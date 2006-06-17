From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Move gitweb style to gitweb.css
Date: Sat, 17 Jun 2006 11:23:56 +0200
Message-ID: <200606171123.56643.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 11:24:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrX2C-0004El-9l
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 11:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWFQJXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 05:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWFQJXy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 05:23:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43671 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751086AbWFQJXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 05:23:52 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1185887ugf
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 02:23:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=WD6YJ7HvHDuBbaJ7hihIDDT0oH19AZEx5i/r79wi3hNZB7+UkmdoqmwAoJthizyr4q455jnv+osLaRwHY8fSqJdyGrBHpNyxrJojXoVohEA2Xy5aTanwtbRlFM4+6rgeNwDcGtezjWxjPe4CYrQlpHAXy1EI40Ajc2EQZBWYWUU=
Received: by 10.67.89.5 with SMTP id r5mr3551342ugl;
        Sat, 17 Jun 2006 02:23:51 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id o1sm3906652uge.2006.06.17.02.23.50;
        Sat, 17 Jun 2006 02:23:50 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22010>

Move gitweb style from embedded <style> element in gitweb/gitweb.cgi
to external CSS file gitweb/gitweb.css.

---
External CSS file can be downloaded only once and cached.


 gitweb/gitweb.cgi |   64 +++--------------------------------------------------
 gitweb/gitweb.css |   54 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 60 deletions(-)
 create mode 100644 gitweb/gitweb.css

a056a67d019c513754ae33e2b2c6b75da7323b38
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index ea21fbe..9d902b7 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -38,6 +38,9 @@ my $home_link =		$my_uri;
 # html text to include at home page
 my $home_text =		"indextext.html";
 
+# URI of default stylesheet
+my $stylesheet = 	"gitweb.css";
+
 # source of projects list
 #my $projects_list =	$projectroot;
 my $projects_list =	"index/index.aux";
@@ -257,68 +260,9 @@ sub git_header_html {
 <head>
 <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
 <meta name="robots" content="index, nofollow"/>
+<link rel="stylesheet" href="$stylesheet"/> 
 <title>$title</title>
 $rss_link
-<style type="text/css">
-body {
-	font-family: sans-serif; font-size: 12px; border:solid #d9d8d1; border-width:1px;
-	margin:10px; background-color:#ffffff; color:#000000;
-}
-a { color:#0000cc; }
-a:hover, a:visited, a:active { color:#880000; }
-div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
-div.page_header a:visited, a.header { color:#0000cc; }
-div.page_header a:hover { color:#880000; }
-div.page_nav { padding:8px; }
-div.page_nav a:visited { color:#0000cc; }
-div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
-div.page_footer { height:17px; padding:4px 8px; background-color: #d9d8d1; }
-div.page_footer_text { float:left; color:#555555; font-style:italic; }
-div.page_body { padding:8px; }
-div.title, a.title {
-	display:block; padding:6px 8px;
-	font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;
-}
-a.title:hover { background-color: #d9d8d1; }
-div.title_text { padding:6px 0px; border: solid #d9d8d1; border-width:0px 0px 1px; }
-div.log_body { padding:8px 8px 8px 150px; }
-span.age { position:relative; float:left; width:142px; font-style:italic; }
-div.log_link {
-	padding:0px 8px;
-	font-size:10px; font-family:sans-serif; font-style:normal;
-	position:relative; float:left; width:136px;
-}
-div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
-a.list { text-decoration:none; color:#000000; }
-a.list:hover { text-decoration:underline; color:#880000; }
-a.text { text-decoration:none; color:#0000cc; }
-a.text:visited { text-decoration:none; color:#880000; }
-a.text:hover { text-decoration:underline; color:#880000; }
-table { padding:8px 4px; }
-th { padding:2px 5px; font-size:12px; text-align:left; }
-tr.light:hover { background-color:#edece6; }
-tr.dark { background-color:#f6f6f0; }
-tr.dark:hover { background-color:#edece6; }
-td { padding:2px 5px; font-size:12px; vertical-align:top; }
-td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }
-div.pre { font-family:monospace; font-size:12px; white-space:pre; }
-div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
-div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
-div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
-a.linenr { color:#999999; text-decoration:none }
-a.rss_logo {
-	float:right; padding:3px 0px; width:35px; line-height:10px;
-	border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
-	color:#ffffff; background-color:#ff6600;
-	font-weight:bold; font-family:sans-serif; font-size:10px;
-	text-align:center; text-decoration:none;
-}
-a.rss_logo:hover { background-color:#ee5500; }
-span.tag {
-	padding:0px 4px; font-size:10px; font-weight:normal;
-	background-color:#ffffaa; border:1px solid; border-color:#ffffcc #ffee00 #ffee00 #ffffcc;
-}
-</style>
 </head>
 <body>
 EOF
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
new file mode 100644
index 0000000..6b1fd23
--- /dev/null
+++ b/gitweb/gitweb.css
@@ -0,0 +1,54 @@
+a { color:#0000cc; }
+a:hover, a:visited, a:active { color:#880000; }
+div.page_header { height:25px; padding:8px; font-size:18px; font-weight:bold; background-color:#d9d8d1; }
+div.page_header a:visited, a.header { color:#0000cc; }
+div.page_header a:hover { color:#880000; }
+div.page_nav { padding:8px; }
+div.page_nav a:visited { color:#0000cc; }
+div.page_path { padding:8px; border:solid #d9d8d1; border-width:0px 0px 1px}
+div.page_footer { height:17px; padding:4px 8px; background-color: #d9d8d1; }
+div.page_footer_text { float:left; color:#555555; font-style:italic; }
+div.page_body { padding:8px; }
+div.title, a.title {
+	display:block; padding:6px 8px;
+	font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;
+}
+a.title:hover { background-color: #d9d8d1; }
+div.title_text { padding:6px 0px; border: solid #d9d8d1; border-width:0px 0px 1px; }
+div.log_body { padding:8px 8px 8px 150px; }
+span.age { position:relative; float:left; width:142px; font-style:italic; }
+div.log_link {
+	padding:0px 8px;
+	font-size:10px; font-family:sans-serif; font-style:normal;
+	position:relative; float:left; width:136px;
+}
+div.list_head { padding:6px 8px 4px; border:solid #d9d8d1; border-width:1px 0px 0px; font-style:italic; }
+a.list { text-decoration:none; color:#000000; }
+a.list:hover { text-decoration:underline; color:#880000; }
+a.text { text-decoration:none; color:#0000cc; }
+a.text:visited { text-decoration:none; color:#880000; }
+a.text:hover { text-decoration:underline; color:#880000; }
+table { padding:8px 4px; }
+th { padding:2px 5px; font-size:12px; text-align:left; }
+tr.light:hover { background-color:#edece6; }
+tr.dark { background-color:#f6f6f0; }
+tr.dark:hover { background-color:#edece6; }
+td { padding:2px 5px; font-size:12px; vertical-align:top; }
+td.link { padding:2px 5px; font-family:sans-serif; font-size:10px; }
+div.pre { font-family:monospace; font-size:12px; white-space:pre; }
+div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
+div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
+div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
+a.linenr { color:#999999; text-decoration:none }
+a.rss_logo {
+	float:right; padding:3px 0px; width:35px; line-height:10px;
+	border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
+	color:#ffffff; background-color:#ff6600;
+	font-weight:bold; font-family:sans-serif; font-size:10px;
+	text-align:center; text-decoration:none;
+}
+a.rss_logo:hover { background-color:#ee5500; }
+span.tag {
+	padding:0px 4px; font-size:10px; font-weight:normal;
+	background-color:#ffffaa; border:1px solid; border-color:#ffffcc #ffee00 #ffee00 #ffffcc;
+}
-- 
1.3.0
