From: Alp Toker <alp@atoker.com>
Subject: [PATCH] gitweb: Include a site name in page titles
Date: Tue, 11 Jul 2006 21:10:26 +0100
Message-ID: <11526486261142-git-send-email-alp@atoker.com>
Cc: junkio@cox.net, martin.langhoff@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 11 22:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0OZ6-0000pN-NL
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 22:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWGKUKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 16:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWGKUKi
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 16:10:38 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:64772 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1751216AbWGKUKh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 16:10:37 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 90DA016F09E; Tue, 11 Jul 2006 21:10:26 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23733>

Tip Of The Day:
    <title>: the most important element of a quality Web page.

This helps users tell one 'git' bookmark apart from the other in their
browser and improves the indexing of gitweb sites in Web search engines.

Defaults to the HTTP SERVER_NAME.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 gitweb/gitweb.cgi |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2e87de4..be0a01d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -46,6 +46,10 @@ if (! -d $git_temp) {
 # target of the home link on top of all pages
 our $home_link = $my_uri;
 
+# name of your site or organization to appear in page titles
+# replace this with something more descriptive for clearer bookmarks
+our $site_name = $ENV{'SERVER_NAME'} || "Untitled";
+
 # html text to include at home page
 our $home_text = "indextext.html";
 
@@ -280,7 +284,7 @@ sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 
-	my $title = "git";
+	my $title = "$site_name git";
 	if (defined $project) {
 		$title .= " - $project";
 		if (defined $action) {
@@ -1760,7 +1764,7 @@ sub git_opml {
 	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
 	      "<opml version=\"1.0\">\n".
 	      "<head>".
-	      "  <title>Git OPML Export</title>\n".
+	      "  <title>$site_name Git OPML Export</title>\n".
 	      "</head>\n".
 	      "<body>\n".
 	      "<outline text=\"git RSS feeds\">\n";
-- 
1.4.1.g97c7-dirty
