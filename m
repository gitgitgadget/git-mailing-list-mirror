From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Start conforming code to "git subcmd" style part 3
Date: Sat, 13 Sep 2008 19:30:59 +0300
Message-ID: <20080913163058.GA5108@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 18:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeY2f-00060t-Lo
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 18:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYIMQbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYIMQbD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 12:31:03 -0400
Received: from zakalwe.fi ([80.83.5.154]:47322 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764AbYIMQbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 12:31:00 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 0C76B2BC73; Sat, 13 Sep 2008 19:30:59 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95807>

User notifications are presented as 'git cmd', and code comments
are presented as '"cmd"' or 'git's cmd', rather than 'git-cmd'.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 builtin-init-db.c        |    2 +-
 builtin-pack-objects.c   |    4 ++--
 builtin-read-tree.c      |    2 +-
 builtin-rev-list.c       |    2 +-
 builtin-rm.c             |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-tar-tree.c       |   14 +++++++-------
 builtin-unpack-objects.c |    2 +-
 builtin-update-index.c   |    8 ++++----
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index baf0d09..8140c12 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -37,7 +37,7 @@ static void copy_templates_1(char *path, int baselen,
 
 	/* Note: if ".git/hooks" file exists in the repository being
 	 * re-initialized, /etc/core-git/templates/hooks/update would
-	 * cause git-init to fail here.  I think this is sane but
+	 * cause "git init" to fail here.  I think this is sane but
 	 * it means that the set of templates we ship by default, along
 	 * with the way the namespace under .git/ is organized, should
 	 * be really carefully chosen.
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ba2cf00..217fd49 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -23,7 +23,7 @@
 #endif
 
 static const char pack_usage[] = "\
-git-pack-objects [{ -q | --progress | --all-progress }] \n\
+git pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--max-pack-size=N] [--local] [--incremental] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
@@ -1872,7 +1872,7 @@ static void mark_in_pack_object(struct object *object, struct packed_git *p, str
 
 /*
  * Compare the objects in the offset order, in order to emulate the
- * "git-rev-list --objects" output that produced the pack originally.
+ * "git rev-list --objects" output that produced the pack originally.
  */
 static int ofscmp(const void *a_, const void *b_)
 {
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index dddc304..ac219ac 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -64,7 +64,7 @@ static void prime_cache_tree(void)
 
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index c023003..facaff2 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -178,7 +178,7 @@ static void finish_object(struct object_array_entry *p)
 static void show_object(struct object_array_entry *p)
 {
 	/* An object with name "foo\n0000000..." can be used to
-	 * confuse downstream git-pack-objects very badly.
+	 * confuse downstream "git pack-objects" very badly.
 	 */
 	const char *ep = strchr(p->name, '\n');
 
diff --git a/builtin-rm.c b/builtin-rm.c
index 6bd8211..fdac34f 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -104,7 +104,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 				     "from both the file and the HEAD\n"
 				     "(use -f to force removal)", name);
 		else if (!index_only) {
-			/* It's not dangerous to git-rm --cached a
+			/* It's not dangerous to "git rm --cached" a
 			 * file if the index matches the file or the
 			 * HEAD, since it means the deleted content is
 			 * still available somewhere.
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 7588d22..2af9f29 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -43,7 +43,7 @@ static int pack_objects(int fd, struct ref *refs)
 	po.out = fd;
 	po.git_cmd = 1;
 	if (start_command(&po))
-		die("git-pack-objects failed (%s)", strerror(errno));
+		die("git pack-objects failed (%s)", strerror(errno));
 
 	/*
 	 * We feed the pack-objects we just spawned with revision
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index cb7007e..edcf72a 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -9,19 +9,19 @@
 
 static const char tar_tree_usage[] =
 "git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
-"*** Note that this command is now deprecated; use git-archive instead.";
+"*** Note that this command is now deprecated; use \"git archive\" instead.";
 
 int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 {
 	/*
-	 * git-tar-tree is now a wrapper around git-archive --format=tar
+	 * "git tar-tree" is now a wrapper around "git archive" --format=tar
 	 *
 	 * $0 --remote=<repo> arg... ==>
-	 *	git-archive --format=tar --remote=<repo> arg...
+	 *	git archive --format=tar --remote=<repo> arg...
 	 * $0 tree-ish ==>
-	 *	git-archive --format=tar tree-ish
+	 *	git archive --format=tar tree-ish
 	 * $0 tree-ish basedir ==>
-	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 * 	git archive --format-tar --prefix=basedir tree-ish
 	 */
 	int i;
 	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
@@ -53,8 +53,8 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 	nargv[nargc] = NULL;
 
 	fprintf(stderr,
-		"*** git-tar-tree is now deprecated.\n"
-		"*** Running git-archive instead.\n***");
+		"*** \"git tar-tree\" is now deprecated.\n"
+		"*** Running \"git archive\" instead.\n***");
 	for (i = 0; i < nargc; i++) {
 		fputc(' ', stderr);
 		sq_quote_print(stderr, nargv[i]);
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a891866..40b20f2 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,7 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
diff --git a/builtin-update-index.c b/builtin-update-index.c
index ce83224..417f972 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -14,7 +14,7 @@
  * Default to not allowing changes to the list of files. The
  * tool doesn't actually care, but this makes it harder to add
  * files to the revision control by mistake by doing something
- * like "git-update-index *" and suddenly having all the object
+ * like "git update-index *" and suddenly having all the object
  * files be revision controlled.
  */
 static int allow_add;
@@ -313,18 +313,18 @@ static void read_index_info(int line_termination)
 		/* This reads lines formatted in one of three formats:
 		 *
 		 * (1) mode         SP sha1          TAB path
-		 * The first format is what "git-apply --index-info"
+		 * The first format is what "git apply --index-info"
 		 * reports, and used to reconstruct a partial tree
 		 * that is used for phony merge base tree when falling
 		 * back on 3-way merge.
 		 *
 		 * (2) mode SP type SP sha1          TAB path
-		 * The second format is to stuff git-ls-tree output
+		 * The second format is to stuff "git ls-tree" output
 		 * into the index file.
 		 *
 		 * (3) mode         SP sha1 SP stage TAB path
 		 * This format is to put higher order stages into the
-		 * index file and matches git-ls-files --stage output.
+		 * index file and matches "git ls-files --stage" output.
 		 */
 		errno = 0;
 		ul = strtoul(buf.buf, &ptr, 8);
-- 
1.6.0.1
