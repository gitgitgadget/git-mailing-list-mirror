From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Run GIT-VERSION-GEN with $(SHELL), not sh.
Date: Wed, 25 Jan 2006 12:37:51 -0800
Message-ID: <10802.1138221471@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Wed Jan 25 21:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1rOs-0001Pa-S8
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 21:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWAYUhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 15:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWAYUhw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 15:37:52 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:65164 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750802AbWAYUhw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 15:37:52 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k0PKbpxV010808
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:37:51 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k0PKbpXu010807
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:37:51 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15136>

Alas, not all shells named sh are capable enough to run
GIT-VERSION-GEN.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ba55c17e4888568cf17da569f95f11e27a26072d
diff --git a/Makefile b/Makefile
index 3046056..245f658 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ all:
 # change being considered an inode change from the update-cache perspective.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-	@sh ./GIT-VERSION-GEN
+	@$(SHELL) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
-- 
1.0.GIT
