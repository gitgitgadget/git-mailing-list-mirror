From: Henrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] gitweb: git_summary - show $project in title
Date: Sun, 11 Nov 2012 06:20:58 +0100
Message-ID: <1352611258-11450-1-git-send-email-xypron.glpk@gmx.de>
Cc: xypron.glpk@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 06:28:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXQ5b-0008V3-59
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 06:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab2KKF16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 00:27:58 -0500
Received: from mailout-eu.gmx.com ([213.165.64.43]:49802 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750721Ab2KKF15 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 00:27:57 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2012 00:27:57 EST
Received: (qmail invoked by alias); 11 Nov 2012 05:21:06 -0000
Received: from xdsl-78-35-178-184.netcologne.de (EHLO family2.heinrich-schuchardt.de) [78.35.178.184]
  by mail.gmx.com (mp-eu005) with SMTP; 11 Nov 2012 06:21:06 +0100
X-Authenticated: #41704822
X-Provags-ID: V01U2FsdGVkX1/JDnFDCaLJ0oduEtVARjiBwnIMAut5zVz8Uem2g/
	7FRDF+jeoNHlMY
X-Mailer: git-send-email 1.7.10.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209323>

Gitweb pages are structured by divs of class title with grey background.
The shortlog, and the log page show the project name as the first title.
Page summary only shows an empty grey box above the project details.
This provides an inconstent user experience.

This patch adds the missing project title.

Signed-off-by: Henrich Schuchardt <xypron.glpk@gmx.de>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..3e1c452 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6451,7 +6451,7 @@ sub git_summary {
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
-	print "<div class=\"title\">&nbsp;</div>\n";
+	print "<div class=\"title\">$project</div>\n";
 	print "<table class=\"projects_list\">\n" .
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
         unless ($omit_owner) {
-- 
1.7.10.4
