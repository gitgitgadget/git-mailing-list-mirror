From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Include git-gui credits file in dist.
Date: Wed, 21 Feb 2007 23:49:51 -0500
Message-ID: <20070222044951.GA28013@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 05:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK5uJ-0004Az-6i
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 05:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbXBVEt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 23:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXBVEt6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 23:49:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37017 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbXBVEt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 23:49:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HK5tl-0004n6-E8; Wed, 21 Feb 2007 23:49:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BBDC420FBAE; Wed, 21 Feb 2007 23:49:51 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40334>

The Makefile for the git-gui subproject will fail to execute if run
outside of a git.git directory, such as when building from a .tar.gz
or .tar.bz2.  This is because it is looking for the credits file,
which was created but omitted from the tarball by the toplevel
Makefile.

---

 This has to go on `maint` before you create the release tarball
 for 1.5.0.2, otherwise 1.5.0.2 cannot be compiled outside of a
 git.git repository.

 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 289decd..35be5e2 100644
--- a/Makefile
+++ b/Makefile
@@ -895,7 +895,8 @@ dist: git.spec git-archive
 	$(TAR) rf $(GIT_TARNAME).tar \
 		$(GIT_TARNAME)/git.spec \
 		$(GIT_TARNAME)/version \
-		$(GIT_TARNAME)/git-gui/version
+		$(GIT_TARNAME)/git-gui/version \
+		$(GIT_TARNAME)/git-gui/credits
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
-- 
1.5.0.61.ga0bf
