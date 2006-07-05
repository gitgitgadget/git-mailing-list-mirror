From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: [PATCH] git-cvsexportcommit dies on merge commits
Date: Wed, 5 Jul 2006 15:25:04 +0200
Message-ID: <20060705132504.GA3470@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 05 15:27:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy7OT-0005Mz-3o
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 15:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWGENZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 09:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWGENZn
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 09:25:43 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:34980 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S964854AbWGENZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 09:25:07 -0400
Received: (qmail 21382 invoked by uid 0); 5 Jul 2006 13:25:04 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 5 Jul 2006 13:25:04 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23348>

Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
---
 git-cvsexportcommit.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index d1051d0..5dcb2f9 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -63,15 +63,15 @@ foreach my $p (@commit) {
 }
 
 if ($parent) {
+    my $found;
     # double check that it's a valid parent
     foreach my $p (@parents) {
-	my $found;
 	if ($p eq $parent) {
 	    $found = 1;
 	    last;
 	}; # found it
-	die "Did not find $parent in the parents for this commit!";
     }
+    die "Did not find $parent in the parents for this commit!" if !$found;
 } else { # we don't have a parent from the cmdline...
     if (@parents == 1) { # it's safe to get it from the commit
 	$parent = $parents[0];
-- 
1.4.0
