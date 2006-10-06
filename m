From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Separate (new) and (deleted) in commitdiff by a space
Date: Fri, 06 Oct 2006 18:00:17 +0200
Message-ID: <20061006160017.855.96502.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 18:00:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVs7b-0000Co-IJ
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 18:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWJFQAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 12:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWJFQAT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 12:00:19 -0400
Received: from rover.dkm.cz ([62.24.64.27]:59797 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1751536AbWJFQAS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 12:00:18 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 54A958B363;
	Fri,  6 Oct 2006 18:00:17 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28410>

Currently it's pasted to the sha1 of the blob and looks ugly.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bcb41cc..ea159e9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1987,14 +1987,14 @@ sub git_patchset_body {
 				print "<div class=\"diff_info\">" . file_type($diffinfo->{'to_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
 				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'to_id'}) . "(new)" .
+				              $diffinfo->{'to_id'}) . " (new)" .
 				      "</div>\n"; # class="diff_info"
 
 			} elsif ($diffinfo->{'status'} eq "D") { # deleted
 				print "<div class=\"diff_info\">" . file_type($diffinfo->{'from_mode'}) . ":" .
 				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
 				                             hash=>$diffinfo->{'from_id'}, file_name=>$diffinfo->{'file'})},
-				              $diffinfo->{'from_id'}) . "(deleted)" .
+				              $diffinfo->{'from_id'}) . " (deleted)" .
 				      "</div>\n"; # class="diff_info"
 
 			} elsif ($diffinfo->{'status'} eq "R" || # renamed
