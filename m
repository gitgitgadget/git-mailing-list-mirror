From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/6] merge-recur: Remove dead code
Date: Thu, 27 Jul 2006 19:13:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271912580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:13:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69Q9-0002LX-VA
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWG0RNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWG0RNK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:13:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:65235 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750972AbWG0RNJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:13:09 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:13:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 27 Jul 2006 19:13:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24312>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8d9451f..9a86cdb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -197,11 +197,6 @@ static int index_only = 0;
  */
 static int git_read_tree(const struct tree *tree)
 {
-#if 0
-	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s\n",
-		getenv("GIT_INDEX_FILE"),
-		sha1_to_hex(tree->object.sha1));
-#endif
 	int rc;
 	const char *argv[] = { "git-read-tree", NULL, NULL, };
 	if (cache_dirty)
@@ -219,14 +214,6 @@ static int git_merge_trees(const char *u
 			   struct tree *head,
 			   struct tree *merge)
 {
-#if 0
-	fprintf(stderr, "GIT_INDEX_FILE='%s' git-read-tree %s -m %s %s %s\n",
-		getenv("GIT_INDEX_FILE"),
-		update_arg,
-		sha1_to_hex(common->object.sha1),
-		sha1_to_hex(head->object.sha1),
-		sha1_to_hex(merge->object.sha1));
-#endif
 	int rc;
 	const char *argv[] = {
 		"git-read-tree", NULL, "-m", NULL, NULL, NULL,
@@ -247,10 +234,6 @@ #endif
  */
 static struct tree *git_write_tree(void)
 {
-#if 0
-	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
-		getenv("GIT_INDEX_FILE"));
-#endif
 	FILE *fp;
 	int rc;
 	char buf[41];
@@ -672,11 +655,6 @@ static struct merge_file_info merge_file
 			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, b->path));
 			argv[4] = lo = strdup(mkpath("orig/%s", o->path));
 
-#if 0
-			printf("%s %s %s %s %s %s %s %s %s %s\n",
-			       argv[0], argv[1], argv[2], argv[3], argv[4],
-			       argv[5], argv[6], argv[7], argv[8], argv[9]);
-#endif
 			code = run_command_v(10, argv);
 
 			free(la);
-- 
1.4.2.rc2.g6a4e
