From: Peter Hagervall <hager@cs.umu.se>
Subject: [PATCH] Make every builtin-*.c file #include "builtin.h"
Date: Sun, 15 Jul 2007 01:14:45 +0200
Message-ID: <20070714231445.GA21180@scanner.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jul 15 01:35:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9r8a-0006jk-J2
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 01:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764912AbXGNXey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764598AbXGNXex
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 19:34:53 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:39697 "EHLO mail.cs.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764342AbXGNXew (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 19:34:52 -0400
X-Greylist: delayed 1202 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2007 19:34:52 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id AE90C74;
	Sun, 15 Jul 2007 01:14:49 +0200 (MEST)
X-Virus-Scanned: amavisd-new at cs.umu.se
Received: from mail.cs.umu.se ([127.0.0.1])
	by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rrMZ75tncYQs; Sun, 15 Jul 2007 01:14:46 +0200 (MEST)
Received: from scanner.cs.umu.se (scanner.cs.umu.se [130.239.40.181])
	by mail.cs.umu.se (Postfix) with ESMTP id C22CF73;
	Sun, 15 Jul 2007 01:14:46 +0200 (MEST)
Received: by scanner.cs.umu.se (Postfix, from userid 12006)
	id 43D9939A0; Sun, 15 Jul 2007 01:14:46 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52518>

Make every builtin-*.c file #include "builtin.h".

Also takes care of some declaration/definition mismatches.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---
 builtin-bundle.c         |    1 +
 builtin-checkout-index.c |    1 +
 builtin-fetch--tool.c    |    1 +
 builtin-for-each-ref.c   |    3 ++-
 builtin-fsck.c           |    3 ++-
 builtin-gc.c             |    1 +
 builtin-merge-base.c     |    1 +
 builtin-merge-file.c     |    7 ++++---
 builtin-pack-refs.c      |    1 +
 builtin-rerere.c         |    1 +
 builtin-runstatus.c      |    1 +
 builtin-show-ref.c       |    1 +
 12 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 306ad29..6ae5ab0 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "object.h"
 #include "commit.h"
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 8460f97..75377b9 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -36,6 +36,7 @@
  * of "-a" causing problems (not possible in the above example,
  * but get used to it in scripting!).
  */
+#include "builtin.h"
 #include "cache.h"
 #include "strbuf.h"
 #include "quote.h"
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index ed4d5de..e2f8ede 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 2b21842..0afa1c5 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "refs.h"
 #include "object.h"
@@ -796,7 +797,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
 
-int cmd_for_each_ref(int ac, const char **av, char *prefix)
+int cmd_for_each_ref(int ac, const char **av, const char *prefix)
 {
 	int i, num_refs;
 	const char *format = NULL;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index a6ef65e..350ec5e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
@@ -659,7 +660,7 @@ static const char fsck_usage[] =
 "git-fsck [--tags] [--root] [[--unreachable] [--cache] [--full] "
 "[--strict] [--verbose] <head-sha1>*]";
 
-int cmd_fsck(int argc, char **argv, const char *prefix)
+int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
 	int i, heads;
 
diff --git a/builtin-gc.c b/builtin-gc.c
index 45025fb..9397482 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -10,6 +10,7 @@
  * Copyright (c) 2006 Shawn O. Pearce
  */
 
+#include "builtin.h"
 #include "cache.h"
 #include "run-command.h"
 
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index e35d362..0108e22 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "commit.h"
 
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 10ec63b..58deb62 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
@@ -5,9 +6,9 @@
 static const char merge_file_usage[] =
 "git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
-int cmd_merge_file(int argc, char **argv, char **envp)
+int cmd_merge_file(int argc, const char **argv, const char *prefix)
 {
-	char *names[3];
+	const char *names[3];
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
 	xpparam_t xpp = {XDF_NEED_MINIMAL};
@@ -51,7 +52,7 @@ int cmd_merge_file(int argc, char **argv, char **envp)
 		free(mmfs[i].ptr);
 
 	if (ret >= 0) {
-		char *filename = argv[1];
+		const char *filename = argv[1];
 		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
 
 		if (!f)
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 7584992..09df4e1 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "refs.h"
 #include "object.h"
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 6ffc43d..29d057c 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "path-list.h"
 #include "xdiff/xdiff.h"
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 4b489b1..2db25c8 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "wt-status.h"
 
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 9463ff0..65051d1 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"
 #include "refs.h"
 #include "object.h"
-- 
1.5.3.GIT
