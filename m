From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Built-in diff driver shows Index: line.
Date: Thu, 28 Apr 2005 12:14:32 -0700
Message-ID: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 21:11:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DREOr-0003ad-9F
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 21:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVD1TO4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 15:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVD1TO4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 15:14:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18130 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262235AbVD1TOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 15:14:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428191433.JLGE26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 15:14:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As suggested by Linus as a workaround to unconfuse diffstat,
this patch adds Index: line before the diff output the built-in
driver produces.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |    2 ++
1 files changed, 2 insertions(+)

# - 04/28 11:20 No need to say diff-tree -p -r in git-export
# + 04/28 11:25 Show Index: line from built-in diff driver.
Index: diff.c
--- k/diff.c  (mode:100644)
+++ l/diff.c  (mode:100644)
@@ -125,6 +125,8 @@ static void builtin_diff(const char *nam
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
+	printf("Index: %s\n", name);
+	fflush(NULL);
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 

