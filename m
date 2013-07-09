From: Tony Finch <dot@dotat.at>
Subject: [PATCH 4/4] gitweb: make search help link less ugly
Date: Tue, 9 Jul 2013 18:15:45 +0100
Message-ID: <E1UyevC-0003du-K4@hermes-2.csi.cam.ac.uk>
References: <20130714234915.GB19057@google.com>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 11:18:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyevI-0005ld-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab3GOJSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:18:22 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:36005 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab3GOJST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:18:19 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:52210)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1UyevC-0008MX-i8 (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:18 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1UyevC-0003du-K4 (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 15 Jul 2013 10:18:18 +0100
In-Reply-To: <20130714234915.GB19057@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230445>

The search help link was a superscript question mark right next to
a drop-down menu, which looks misaligned and is a cramped and
awkward click target. Remove the superscript tags and add some
spacing to fix these nits. Add a title attribute to provide an
explanatory mouseover.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c029b98..874c948 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4029,9 +4029,9 @@ sub print_search_form {
 	      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
 	      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
 	      $cgi->popup_menu(-name => 'st', -default => 'commit',
-	                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
-	      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
-	      " search:\n",
+			       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
+	      " " . $cgi->a({-href => href(action=>"search_help"),
+			     -title => "search help" }, "?") . " search:\n",
 	      $cgi->textfield(-name => "s", -value => $searchtext, -override => 1) . "\n" .
 	      "<span title=\"Extended regular expression\">" .
 	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
-- 
1.8.3.1.605.g85318f5
