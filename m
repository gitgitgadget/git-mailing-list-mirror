From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-diff style fix.
Date: Sat, 16 Apr 2005 19:15:10 -0700
Message-ID: <7voece2lox.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 04:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMzGN-0005ud-LS
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 04:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVDQCPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 22:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDQCPV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 22:15:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52639 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261238AbVDQCPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 22:15:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417021510.BMMK7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 22:15:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This fixes some stylistic problems introduced by my previous set
of patches.  I'll be sending my last patch to show-diff next,
which depends on this cleanup.

To be applied on top of my previous patches:

    [PATCH] Optionally tell show-diff to show only named files.
    [PATCH] show-diff -z option for machine readable output.
    [PATCH] show-diff shell safety.
    [PATCH] (take 2) Rename confusing variable in show-diff.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- ./show-diff.c	2005-04-16 18:59:09.000000000 -0700
+++ ./show-diff.c	2005-04-16 19:01:28.000000000 -0700
@@ -111,7 +111,7 @@
 	}
 }
 
-static const char *show_diff_usage = "show-diff [-s] [-q] [-z] [paths...]";
+static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
 {
@@ -141,9 +141,8 @@
 			silent_on_nonexisting_files = silent = 1;
 		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
-		else if (!strcmp(argv[1], "-z")) {
+		else if (!strcmp(argv[1], "-z"))
 			machine_readable = 1;
-		}
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -164,7 +163,7 @@
 		char type[20];
 		void *old;
 
-		if (1 <argc &&
+		if (1 < argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
 			continue;
 

