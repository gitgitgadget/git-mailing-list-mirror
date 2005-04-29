From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] The big git command renaming fallout fix.
Date: Fri, 29 Apr 2005 14:41:31 -0700
Message-ID: <7vacnh45x0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:38:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdBX-0006xo-Fx
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVD2VnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVD2VmB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:42:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:20445 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263023AbVD2Vlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:41:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429214132.EYF20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 17:41:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Fri, 29 Apr 2005 14:24:43 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Ok, I hate to do this, ...

Well, it was time.  This fixes the git-export which calls diff-tree.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.linus/
show-diff -p export.c
--- k/export.c  (mode:100644)
+++ l/export.c  (mode:100644)
@@ -18,7 +18,7 @@ void show_commit(struct commit *commit)
 		char *against = sha1_to_hex(commit->parents->item->object.sha1);
 		printf("\n\n======== diff against %s ========\n", against);
 		fflush(NULL);
-		sprintf(cmdline, "diff-tree -p %s %s", against, hex);
+		sprintf(cmdline, "git-diff-tree -p %s %s", against, hex);
 		system(cmdline);
 	}
 	printf("======== end ========\n\n");




