From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 06/12] Remove final newline from the value of xfrm_msg
 variable.
Date: Fri, 27 May 2005 15:54:06 -0700
Message-ID: <7vfyw846wh.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbngd-00028A-8s
	for gcvg-git@gmane.org; Sat, 28 May 2005 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVE0WyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVE0WyS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 18:54:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30639 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262647AbVE0WyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 18:54:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527225407.YOPW20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 18:54:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 27 May 2005 15:43:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This change makes the implementation of git-external-diff-script
cleaner.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c                   |    6 +++---
git-external-diff-script |    2 +-
2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -141,7 +141,7 @@ static void builtin_diff(const char *nam
 			printf("new mode %s\n", temp[1].mode);
 		}
 		if (xfrm_msg && xfrm_msg[0])
-			fputs(xfrm_msg, stdout);
+			puts(xfrm_msg);
 
 		if (strncmp(temp[0].mode, temp[1].mode, 3))
 			/* we do not run diff between different kind
@@ -622,7 +622,7 @@ static void diff_flush_patch(struct diff
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"copy from %s\n"
-			"copy to %s\n",
+			"copy to %s",
 			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
@@ -631,7 +631,7 @@ static void diff_flush_patch(struct diff
 		sprintf(msg_,
 			"similarity index %d%%\n"
 			"rename old %s\n"
-			"rename new %s\n",
+			"rename new %s",
 			(int)(0.5 + p->score * 100.0/MAX_SCORE),
 			p->one->path, p->two->path);
 		msg = msg_;
diff --git a/git-external-diff-script b/git-external-diff-script
--- a/git-external-diff-script
+++ b/git-external-diff-script
@@ -59,7 +59,7 @@ then
     echo "new mode $mode2"
     if test "$xfrm_msg" != ""
     then
-	echo -n $xfrm_msg
+	echo "$xfrm_msg"
     fi
 fi
 diff ${GIT_DIFF_OPTS-'-pu'} -L "a/$name1" -L "b/$name2" "$tmp1" "$tmp2"
------------------------------------------------

