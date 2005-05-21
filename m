From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Constness fix for pickaxe option.
Date: Sat, 21 May 2005 15:02:51 -0700
Message-ID: <7v1x80gruc.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7voeb4kjda.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 00:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZc2b-0005Zn-Kc
	for gcvg-git@gmane.org; Sun, 22 May 2005 00:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVEUWC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVEUWC6
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 18:02:58 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37574 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261641AbVEUWCx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 18:02:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521220253.NGKJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 18:02:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voeb4kjda.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 02:40:01 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Constness fix for pickaxe option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c  |    2 +-
diff-files.c  |    2 +-
diff-helper.c |    2 +-
diff-tree.c   |    2 +-
diff.c        |    2 +-
diff.h        |    2 +-
6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff-cache.c b/diff-cache.c
--- a/diff-cache.c
+++ b/diff-cache.c
@@ -8,7 +8,7 @@ static int line_termination = '\n';
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
-static char *pickaxe = 0;
+static const char *pickaxe = 0;
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -14,7 +14,7 @@ static int line_termination = '\n';
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
-static char *pickaxe = 0;
+static const char *pickaxe = 0;
 static int silent = 0;
 
 static int matches_pathspec(struct cache_entry *ce, char **spec, int cnt)
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -9,7 +9,7 @@
 static int detect_rename = 0;
 static int diff_score_opt = 0;
 static int generate_patch = 1;
-static char *pickaxe = 0;
+static const char *pickaxe = 0;
 
 static int parse_oneside_change(const char *cp, int *mode,
 				unsigned char *sha1, char *path)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -13,7 +13,7 @@ static int generate_patch = 0;
 static int detect_rename = 0;
 static int reverse_diff = 0;
 static int diff_score_opt = 0;
-static char *pickaxe = 0;
+static const char *pickaxe = 0;
 static const char *header = NULL;
 static const char *header_prefix = "";
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -513,7 +513,7 @@ int diff_scoreopt_parse(const char *opt)
 }
 
 void diff_setup(int detect_rename_, int minimum_score_,
-		char *pickaxe_,
+		const char *pickaxe_,
 		int reverse_diff_, int diff_raw_output_,
 		const char **pathspec_, int speccnt_)
 {
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -20,7 +20,7 @@ extern void diff_unmerge(const char *pat
 extern int diff_scoreopt_parse(const char *opt);
 
 extern void diff_setup(int detect_rename, int minimum_score,
-		       char *pickaxe,
+		       const char *pickaxe,
 		       int reverse, int raw_output,
 		       const char **spec, int cnt);
 
------------------------------------------------

