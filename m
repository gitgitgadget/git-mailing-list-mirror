From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 2/4] bugfix for cg-init -N: pass -N to cg-commit
Date: Sun, 10 Jul 2005 23:53:36 -0400
Message-ID: <20050711035327.22229.20563.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpMW-0008FJ-9T
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVGKDxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVGKDxi
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:53:38 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:49497 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262214AbVGKDxg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:53:36 -0400
Received: (qmail 25235 invoked from network); 11 Jul 2005 03:53:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=5Cwg5egTy9eZukKHoR2yp8OkfEwxlIHGiYvce/wgOasICi8tP/B90Z0apJubRiYsN2xMjiHWVImUov3F5c0/E2r5CkTVwLkk7ixEDFE2t2aIZT08cFKsCVnU/sfnCDNpC/K8coU21nn9Y69gjMO8fEsgaMhuXK194KI3jm0CQ1k=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 03:53:32 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bugfix for cg-init -N:  the -N option needs to be passed down into cg-commit as well.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -56,7 +56,7 @@ if [ "$uri" ]; then
 else
 	git-read-tree # Seed the dircache
 	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add ${infoonly}
-	cg-commit -C -m"Initial commit" -E
+	cg-commit -C -m"Initial commit" -E ${infoonly}
 fi
 
 trap "" SIGTERM EXIT
