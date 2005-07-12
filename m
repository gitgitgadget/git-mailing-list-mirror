From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 12 Jul 2005 23:35:32 +0200
Message-ID: <20050712213531.GA10936@pc117b.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:42:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsSWP-0007Os-2q
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 23:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVGLVlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 17:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVGLVj2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 17:39:28 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:26753 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S262422AbVGLVhO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 17:37:14 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j6CLZWTf017174;
	Tue, 12 Jul 2005 23:35:37 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 3DDB04CCA2; Tue, 12 Jul 2005 23:35:32 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: parse multidigit revisions.

Previously, git-cvsimport-script would fail
on revisions with more than one digit.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit 7b5f7bcc470528beb4a0b6ef1c93ce634aaa0158
tree db66d0759f97016bd123e2351aa0e77585e3177b
parent e30e814dbfef7a6e89418863e5d7291a2d53b18f
author Sven Verdoolaege <skimo@kotnet.org> Tue, 12 Jul 2005 22:36:57 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Tue, 12 Jul 2005 22:36:57 +0200

 git-cvsimport-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -675,7 +675,7 @@ while(<CVS>) {
 		$state = 9;
 	} elsif($state == 8) {
 		$logmsg .= "$_\n";
-	} elsif($state == 9 and /^\s+(\S+):(INITIAL|\d(?:\.\d+)+)->(\d(?:\.\d+)+)\s*$/) {
+	} elsif($state == 9 and /^\s+(\S+):(INITIAL|\d+(?:\.\d+)+)->(\d+(?:\.\d+)+)\s*$/) {
 #	VERSION:1.96->1.96.2.1
 		my $init = ($2 eq "INITIAL");
 		my $fn = $1;
