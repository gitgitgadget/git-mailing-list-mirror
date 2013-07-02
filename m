From: Tony Finch <dot@dotat.at>
Subject: [PATCH 3/4] gitweb: omit the repository owner when it is unset
Date: Tue, 2 Jul 2013 17:24:24 +0100
Message-ID: <E1UyevA-0003df-Jo@hermes-2.csi.cam.ac.uk>
References: <20130714234915.GB19057@google.com>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:18:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyevI-0005ld-9i
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab3GOJSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:18:18 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:58885 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754434Ab3GOJSR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:18:17 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:53818)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1UyevA-0000mZ-8Y (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:16 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1UyevA-0003df-Jo (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:16 +0100
In-Reply-To: <20130714234915.GB19057@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230444>

On the repository summary page, leave the whole owner line out if
the repo does not have an owner, rather than displaying a labelled
empty field..

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..c029b98 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6463,7 +6463,7 @@ sub git_summary {
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table class=\"projects_list\">\n" .
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
-        unless ($omit_owner) {
+        if ($owner and not $omit_owner) {
 	        print  "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
         }
 	if (defined $cd{'rfc2822'}) {
-- 
1.8.3.1.605.g85318f5
