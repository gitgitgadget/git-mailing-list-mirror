From: Tony Finch <dot@dotat.at>
Subject: [PATCH v4 4/4] gitweb: make search help link less ugly
Date: Tue, 20 Aug 2013 17:59:54 +0100
Message-ID: <3a61bd631c264ac398271af34400809dc2fa0429.1377019362.git.dot@dotat.at>
References: <cover.1377019362.git.dot@dotat.at>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 19:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpjX-0004nv-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab3HTR2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:28:40 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53625 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab3HTR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:28:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:47875)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VBpjQ-0005kb-Ei (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VBpjQ-0002mk-Dq (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
In-Reply-To: <cover.1377019362.git.dot@dotat.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232617>

The search help link was a superscript question mark right next to
a drop-down menu, which looks misaligned and is a cramped and
awkward click target. Remove the superscript tags and add some
spacing to fix these nits. Add a title attribute to provide an
explanatory mouseover.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..59af7de 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4030,8 +4030,8 @@ sub print_search_form {
 	      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
 	      $cgi->popup_menu(-name => 'st', -default => 'commit',
 	                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
-	      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
-	      " search:\n",
+	      " " . $cgi->a({-href => href(action=>"search_help"),
+			     -title => "search help" }, "?") . " search:\n",
 	      $cgi->textfield(-name => "s", -value => $searchtext, -override => 1) . "\n" .
 	      "<span title=\"Extended regular expression\">" .
 	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
-- 
1.8.3.1.605.g85318f5
