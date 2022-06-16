<@extends src="base.ftl">

  <@block name="content">

<script type="text/javascript">
<#if docList?has_content>
<#assign firstDocId = docList[0].id!"NA">
$(document).ready(function() {
  jQuery(".preview-iframe").attr("src", "${basePath}/easyshare/${docShare.id}/${firstDocId}/@preview/");
});
</#if>
function updatePreview(e) {
  e.preventDefault();
  let docurl = jQuery(e.target).attr('data-docurl');
  jQuery('.preview-iframe').attr("src", docurl+'/@preview/');
}
</script>
<style>
.preview-container {
    position: relative;
    overflow: hidden;
    padding-top: 56.25%;
}
.preview-iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 400px;
    border: 0;
}
</style>

  <div>

    <#include "includes/header.ftl">

    <content>

      <#if docShare.dublincore.description?length &gt; 0 >
        <div class="comment">
          <i class="icon-user"></i>
          <blockquote>${docShare.dublincore.description}</blockquote>
        </div>
      </#if>

      <#if isFolder>
          <a class="action_bar" title="${docShare.title}" href="${basePath}/easyshare/${docShare.id}"> ${Context.getMessage("easyshare.label.backToTheRoot")}</a>
      </#if>

      <div class="shared-items">
        <#list docList as doc>
          <#assign filename=This.getFileName(doc)>

          <#if doc.isFolder>
          <a class="item" title="${filename}" href="${basePath}/easyshare/${docShare.id}/${doc.id}">
            <span class="document">
            <i class="icon-folder"></i>${doc.title}
            </span>
          <#else>
          <a class="item" title="${filename} (NEW)" target="_blank" href="${basePath}/easyshare/${docShare.id}/${doc.id}/${filename}">
            <span class="document">
            <i class="icon-file"></i>${doc.title}<#if filename != doc.title> - ${filename}</#if>
          </span>
            <i class="icon-download"></i>
            <button data-docurl="${basePath}/easyshare/${docShare.id}/${doc.id}" onclick="updatePreview(event);" >Preview</button>
          </#if>
        </a>
        </#list>

        <#if !docList>
          <div class="empty"><i class="icon-unhappy"></i>${Context.getMessage("easyshare.label.nofiles")}</div>
        </#if>

    </content>

    <#include "includes/pagination.ftl">

  </div>

  <div class="preview-container"><iframe class="preview-iframe"></iframe></div>

  </@block>
</@extends>
