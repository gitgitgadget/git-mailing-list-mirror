From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-tree does not need -r in git-export.c
Date: Thu, 28 Apr 2005 12:13:16 -0700
Message-ID: <7v3bta90kz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 21:08:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DREMf-0003GI-MW
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVD1TNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVD1TNX
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:13:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16589 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262231AbVD1TNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 15:13:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428191315.DPBC20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 15:13:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

No need to pass -r anymore, since diff-tree -p implies recursive
behaviour these days.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-export.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

# - [PATCH] diff-cache.c compilation warning fix.
# + 04/28 11:20 No need to say diff-tree -p -r in git-export
Index: git-export.c
--- k/git-export.c  (mode:100644)
+++ l/git-export.c  (mode:100644)
@@ -18,7 +18,7 @@ void show_commit(struct commit *commit)
 		char *against = sha1_to_hex(commit->parents->item->object.sha1);
 		printf("\n\n======== diff against %s ========\n", against);
 		fflush(NULL);
-		sprintf(cmdline, "diff-tree -p -r %s %s", against, hex);
+		sprintf(cmdline, "diff-tree -p %s %s", against, hex);
 		system(cmdline);
 	}
 	printf("======== end ========\n\n");

