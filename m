From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH 1/3] Fix assorted white space damage in *.c files
Date: Sat, 12 May 2007 13:10:58 +0200
Message-ID: <e5bfff550705120410u3290cdaeted4a7eadcaee1545@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 13:11:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmpVJ-00047J-D8
	for gcvg-git@gmane.org; Sat, 12 May 2007 13:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbXELLLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 07:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXELLLE
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 07:11:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:5085 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301AbXELLLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 07:11:00 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1261684wra
        for <git@vger.kernel.org>; Sat, 12 May 2007 04:10:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AzGjE8Nvky32GzAb1Apn3rRU2AEUbxeQ/9p4zfd1FRkRP9YkEp0YspXsrvxzRAnl0ik3nOn2lPmwm1HvBsy02QXuyYr5lgNEgx2rqmwJiXzcbse7rYSmTI4zTDOvuoYk9bjPa0ndGUy/krdj57OBI2jMO1pBBp/X8TFu7NkI5qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EqEpuTrAccmvjodT/ernh7X70UMBbwxRE4Iald6DOjmZS/6m/ONRfMKT1iI7hjM2lAEmtle+CsFStzmRjyllVDx2iNU7ueltUTcJXmRz1ADzdiM+x7ks9RZEeOOgIyNafJ1rWSmg09eVDsO22K3itR6pAN8O/BmghaI8K+XecrM=
Received: by 10.114.12.9 with SMTP id 9mr217314wal.1178968258777;
        Sat, 12 May 2007 04:10:58 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 12 May 2007 04:10:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47037>

Used the new 'cleanfile' script by H. Peter Anvin, just merged
in Linux tree.

This script cleans up various classes of stealth whitespace.  In
    particular, it cleans up:

    - Whitespace (spaces or tabs)before newline;
    - DOS line endings (CR before LF);
    - Space before tab (spaces are deleted or converted to tabs);
    - Empty lines at end of file.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 builtin-annotate.c      |    1 -
 builtin-diff-index.c    |    2 +-
 builtin-fmt-merge-msg.c |    1 -
 builtin-fsck.c          |    4 ++--
 builtin-ls-files.c      |    2 +-
 builtin-name-rev.c      |    1 -
 builtin-pack-objects.c  |    4 ++--
 builtin-rerere.c        |    1 -
 builtin-shortlog.c      |    1 -
 builtin-tar-tree.c      |    2 +-
 commit.c                |   14 +++++++-------
 config.c                |    3 +--
 connect.c               |    2 +-
 convert-objects.c       |    2 +-
 copy.c                  |    1 -
 ctype.c                 |    1 -
 daemon.c                |    4 ++--
 date.c                  |   10 +++++-----
 diff-lib.c              |    2 +-
 diff.c                  |    4 ++--
 diffcore-pickaxe.c      |    2 +-
 entry.c                 |    2 +-
 environment.c           |    2 --
 fetch-pack.c            |    2 +-
 fetch.c                 |    4 ++--
 git.c                   |    2 +-
 help.c                  |    2 --
 http-fetch.c            |    2 +-
 http-push.c             |    2 +-
 http.c                  |    2 +-
 imap-send.c             |    2 +-
 local-fetch.c           |    8 ++++----
 lockfile.c              |    1 -
 mailmap.c               |    1 -
 match-trees.c           |    1 -
 merge-index.c           |    2 +-
 mktag.c                 |    2 +-
 object-refs.c           |    2 --
 pack-redundant.c        |    4 ++--
 patch-id.c              |    2 +-
 path-list.c             |    1 -
 pkt-line.c              |    2 +-
 read-cache.c            |   14 +++++++-------
 setup.c                 |    4 ++--
 sha1_file.c             |    8 ++++----
 shallow.c               |    1 -
 ssh-upload.c            |   10 +++++-----
 strbuf.c                |    1 -
 tree-walk.c             |    1 -
 upload-pack.c           |    2 +-
 var.c                   |    4 ++--
 xdiff-interface.c       |    2 --
 52 files changed, 68 insertions(+), 91 deletions(-)

diff --git a/builtin-annotate.c b/builtin-annotate.c
index 9db7cfe..fc43eed 100644
--- a/builtin-annotate.c
+++ b/builtin-annotate.c
@@ -22,4 +22,3 @@ int cmd_annotate(int argc, const char **argv, const
char *prefix)

 	return cmd_blame(argc + 1, nargv, prefix);
 }
-
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index d90eba9..81e7167 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -23,7 +23,7 @@ int cmd_diff_index(int argc, const char **argv,
const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-			
+
 		if (!strcmp(arg, "--cached"))
 			cached = 1;
 		else
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 5c145d2..ae60fcc 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -357,4 +357,3 @@ int cmd_fmt_merge_msg(int argc, const char **argv,
const char *prefix)

 	return 0;
 }
-
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 44ce629..3c7e30d 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -336,7 +336,7 @@ static int fsck_commit(struct commit *commit)
 	if (!commit->parents && show_root)
 		printf("root %s\n", sha1_to_hex(commit->object.sha1));
 	if (!commit->date)
-		printf("bad commit date in %s\n",
+		printf("bad commit date in %s\n",
 		       sha1_to_hex(commit->object.sha1));
 	return 0;
 }
@@ -676,7 +676,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)

 	heads = 0;
 	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+		const char *arg = argv[i];

 		if (*arg == '-')
 			continue;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f7c066b..5398a41 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -117,7 +117,7 @@ static void show_other_files(struct dir_struct *dir)
 		if (0 <= pos)
 			continue;	/* exact match */
 		pos = -pos - 1;
-		if (pos < active_nr) {
+		if (pos < active_nr) {
 			ce = active_cache[pos];
 			if (ce_namelen(ce) == len &&
 			    !memcmp(ce->name, ent->name, len))
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index c022224..c696b35 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -272,4 +272,3 @@ int cmd_name_rev(int argc, const char **argv,
const char *prefix)

 	return 0;
 }
-
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 966f843..dda7d2e 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -28,7 +28,7 @@ struct object_entry {
 	unsigned long size;	/* uncompressed size */
 	unsigned int hash;	/* name hint hash */
 	unsigned int depth;	/* delta depth */
-	struct packed_git *in_pack; 	/* already in pack */
+	struct packed_git *in_pack;	/* already in pack */
 	off_t in_pack_offset;
 	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
@@ -242,7 +242,7 @@ static void *delta_against(void *buf, unsigned
long size, struct object_entry *e
         delta_buf = diff_delta(otherbuf, othersize,
 			       buf, size, &delta_size, 0);
         if (!delta_buf || delta_size != entry->delta_size)
-        	die("delta size changed");
+		die("delta size changed");
         free(buf);
         free(otherbuf);
 	return delta_buf;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 8c2c8bd..f6409b9 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -434,4 +434,3 @@ int cmd_rerere(int argc, const char **argv, const
char *prefix)
 	path_list_clear(&merge_rr, 1);
 	return 0;
 }
-
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 8d3f742..16af619 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -331,4 +331,3 @@ int cmd_shortlog(int argc, const char **argv,
const char *prefix)

 	return 0;
 }
-
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index b04719e..8861a29 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -21,7 +21,7 @@ int cmd_tar_tree(int argc, const char **argv, const
char *prefix)
 	 * $0 tree-ish ==>
 	 *	git-archive --format=tar tree-ish
 	 * $0 tree-ish basedir ==>
-	 * 	git-archive --format-tar --prefix=basedir tree-ish
+	 *	git-archive --format-tar --prefix=basedir tree-ish
 	 */
 	int i;
 	const char **nargv = xcalloc(sizeof(*nargv), argc + 2);
diff --git a/commit.c b/commit.c
index d01833d..06f3c30 100644
--- a/commit.c
+++ b/commit.c
@@ -148,7 +148,7 @@ static int commit_graft_pos(const unsigned char *sha1)
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(graft->sha1);
-	
+
 	if (0 <= pos) {
 		if (ignore_dups)
 			free(graft);
@@ -406,7 +406,7 @@ struct commit_list * insert_by_date(struct commit
*item, struct commit_list **li
 	return commit_list_insert(item, pp);
 }

-	
+
 void sort_by_date(struct commit_list **list)
 {
 	struct commit_list *ret = NULL;
@@ -1155,7 +1155,7 @@ void sort_in_topological_order_fn(struct
commit_list ** list, int lifo,
 		next = next->next;
 		count++;
 	}
-	
+
 	if (!count)
 		return;
 	/* allocate an array to help sort the list */
@@ -1183,11 +1183,11 @@ void sort_in_topological_order_fn(struct
commit_list ** list, int lifo,
 		}
 		next=next->next;
 	}
-	/*
+	/*
          * find the tips
          *
-         * tips are nodes not reachable from any other node in the list
-         *
+         * tips are nodes not reachable from any other node in the list
+         *
          * the tips serve as a starting set for the work queue.
          */
 	next=*list;
@@ -1215,7 +1215,7 @@ void sort_in_topological_order_fn(struct
commit_list ** list, int lifo,

 			if (pn) {
 				/*
-				 * parents are only enqueued for emission
+				 * parents are only enqueued for emission
                                  * when all their children have been
emitted thereby
                                  * guaranteeing topological order.
                                  */
diff --git a/config.c b/config.c
index 70d1055..47e4f42 100644
--- a/config.c
+++ b/config.c
@@ -590,7 +590,7 @@ static ssize_t find_beginning_of_line(const char*
contents, size_t size,
 	size_t equal_offset = size, bracket_offset = size;
 	ssize_t offset;

-	for (offset = offset_-2; offset > 0
+	for (offset = offset_-2; offset > 0
 			&& contents[offset] != '\n'; offset--)
 		switch (contents[offset]) {
 			case '=': equal_offset = offset; break;
@@ -958,4 +958,3 @@ int git_config_rename_section(const char
*old_name, const char *new_name)
 	free(config_filename);
 	return ret;
 }
-
diff --git a/connect.c b/connect.c
index da89c9c..4382d43 100644
--- a/connect.c
+++ b/connect.c
@@ -574,7 +574,7 @@ static int git_proxy_command_options(const char
*var, const char *value)
 		}
 		if (0 <= matchlen) {
 			/* core.gitproxy = none for kernel.org */
-			if (matchlen == 4 &&
+			if (matchlen == 4 &&
 			    !memcmp(value, "none", 4))
 				matchlen = 0;
 			git_proxy_command = xmalloc(matchlen + 1);
diff --git a/convert-objects.c b/convert-objects.c
index cefbceb..90e7900 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -194,7 +194,7 @@ static unsigned long parse_oldstyle_date(const char *buf)
 		fmt++;
 	} while (*buf && *fmt);
 	printf("left: %s\n", buf);
-	return mktime(&tm);				
+	return mktime(&tm);
 }

 static int convert_date_line(char *dst, void **buf, unsigned long *sp)
diff --git a/copy.c b/copy.c
index 08a3d38..d9b0810 100644
--- a/copy.c
+++ b/copy.c
@@ -35,4 +35,3 @@ int copy_fd(int ifd, int ofd)
 	close(ifd);
 	return 0;
 }
-
diff --git a/ctype.c b/ctype.c
index 56bdffa..ee06eb7 100644
--- a/ctype.c
+++ b/ctype.c
@@ -20,4 +20,3 @@ unsigned char sane_ctype[256] = {
 	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
 	/* Nothing in the 128.. range */
 };
-
diff --git a/daemon.c b/daemon.c
index e74ecac..a30324f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -133,7 +133,7 @@ static int avoid_alias(char *p)
 {
 	int sl, ndot;

-	/*
+	/*
 	 * This resurrects the belts and suspenders paranoia check by HPA
 	 * done in <435560F7.4080006@zytor.com> thread, now enter_repo()
 	 * does not do getcwd() based path canonicalizations.
@@ -247,7 +247,7 @@ static char *path_ok(struct interp *itable)
 		int pathlen = strlen(path);

 		/* The validation is done on the paths after enter_repo
-		 * appends optional {.git,.git/.git} and friends, but
+		 * appends optional {.git,.git/.git} and friends, but
 		 * it does not use getcwd().  So if your /pub is
 		 * a symlink to /mnt/pub, you can whitelist /pub and
 		 * do not have to say /mnt/pub.
diff --git a/date.c b/date.c
index a9b59a2..a5407f5 100644
--- a/date.c
+++ b/date.c
@@ -403,7 +403,7 @@ static int match_multi_number(unsigned long num,
char c, const char *date, char
 }

 /*
- * We've seen a digit. Time? Year? Date?
+ * We've seen a digit. Time? Year? Date?
  */
 static int match_digit(const char *date, struct tm *tm, int *offset,
int *tm_gmt)
 {
@@ -493,7 +493,7 @@ static int match_digit(const char *date, struct tm
*tm, int *offset, int *tm_gmt
 	} else if (num > 0 && num < 13) {
 		tm->tm_mon = num-1;
 	}
-		
+
 	return n;
 }

@@ -567,13 +567,13 @@ int parse_date(const char *date, char *result, int maxlen)
 		if (!match) {
 			/* BAD CRAP */
 			match = 1;
-		}	
+		}

 		date += match;
 	}

 	/* mktime uses local timezone */
-	then = my_mktime(&tm);
+	then = my_mktime(&tm);
 	if (offset == -1)
 		offset = (then - mktime(&tm)) / 60;

@@ -689,7 +689,7 @@ static const struct typelen {
 	{ "days", 24*60*60 },
 	{ "weeks", 7*24*60*60 },
 	{ NULL }
-};	
+};

 static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
 {
diff --git a/diff-lib.c b/diff-lib.c
index 07f4e81..7fb19c7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -664,7 +664,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	const char *tree_name;
 	int match_missing = 0;

-	/*
+	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but totally different.
 	 */
diff --git a/diff.c b/diff.c
index 8354e71..faff76a 100644
--- a/diff.c
+++ b/diff.c
@@ -3038,7 +3038,7 @@ void diff_addremove(struct diff_options *options,
 	 * entries to the diff-core.  They will be prefixed
 	 * with something like '=' or '*' (I haven't decided
 	 * which but should not make any difference).
-	 * Feeding the same new and old to diff_change()
+	 * Feeding the same new and old to diff_change()
 	 * also has the same effect.
 	 * Before the final output happens, they are pruned after
 	 * merged into rename/copy pairs as appropriate.
@@ -3065,7 +3065,7 @@ void diff_change(struct diff_options *options,
 		 unsigned old_mode, unsigned new_mode,
 		 const unsigned char *old_sha1,
 		 const unsigned char *new_sha1,
-		 const char *base, const char *path)
+		 const char *base, const char *path)
 {
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index c4a77d7..af9fffe 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -102,7 +102,7 @@ void diffcore_pickaxe(const char *needle, int opts)
 		for (i = 0; i < q->nr; i++)
 			diff_free_filepair(q->queue[i]);
 	}
-	else
+	else
 		/* Showing only the filepairs that has the needle */
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
diff --git a/entry.c b/entry.c
index 82bf725..581de3f 100644
--- a/entry.c
+++ b/entry.c
@@ -31,7 +31,7 @@ static void remove_subtree(const char *path)
 	struct dirent *de;
 	char pathbuf[PATH_MAX];
 	char *name;
-	
+
 	if (!dir)
 		die("cannot opendir %s (%s)", path, strerror(errno));
 	strcpy(pathbuf, path);
diff --git a/environment.c b/environment.c
index 2231659..a8855d3 100644
--- a/environment.c
+++ b/environment.c
@@ -104,5 +104,3 @@ char *get_graft_file(void)
 		setup_git_env();
 	return git_graft_file;
 }
-
-
diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..b6cb655 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -114,7 +114,7 @@ static const unsigned char* get_rev(void)
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
 			non_common_revs--;
-	
+
 		parents = commit->parents;

 		if (commit->object.flags & COMMON) {
diff --git a/fetch.c b/fetch.c
index 8e29d31..dda33e5 100644
--- a/fetch.c
+++ b/fetch.c
@@ -15,7 +15,7 @@ int get_verbosely = 0;
 int get_recover = 0;
 static unsigned char current_commit_sha1[20];

-void pull_say(const char *fmt, const char *hex)
+void pull_say(const char *fmt, const char *hex)
 {
 	if (get_verbosely)
 		fprintf(stderr, fmt, hex);
@@ -153,7 +153,7 @@ static int process(struct object *obj)
 			return 0;
 		prefetch(obj->sha1);
 	}
-		
+
 	object_list_insert(obj, process_queue_end);
 	process_queue_end = &(*process_queue_end)->next;
 	return 0;
diff --git a/git.c b/git.c
index f200907..664a638 100644
--- a/git.c
+++ b/git.c
@@ -214,7 +214,7 @@ const char git_version_string[] = GIT_VERSION;
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NOT_BARE 	(1<<2)
+#define NOT_BARE	(1<<2)

 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
diff --git a/help.c b/help.c
index 6a9af4d..1cd33ec 100644
--- a/help.c
+++ b/help.c
@@ -219,5 +219,3 @@ int cmd_help(int argc, const char **argv, const
char *prefix)

 	return 0;
 }
-
-
diff --git a/http-fetch.c b/http-fetch.c
index 09baedc..202fae0 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -828,7 +828,7 @@ static void abort_object_request(struct
object_request *obj_req)
 	}
 	unlink(obj_req->tmpfile);
 	if (obj_req->slot) {
- 		release_active_slot(obj_req->slot);
+		release_active_slot(obj_req->slot);
 		obj_req->slot = NULL;
 	}
 	release_object_request(obj_req);
diff --git a/http-push.c b/http-push.c
index e3f7675..c54ad9d 100644
--- a/http-push.c
+++ b/http-push.c
@@ -517,7 +517,7 @@ static void start_put(struct transfer_request *request)
 	request->buffer.size = stream.total_out;
 	request->buffer.posn = 0;

-	request->url = xmalloc(strlen(remote->url) +
+	request->url = xmalloc(strlen(remote->url) +
 			       strlen(request->lock->token) + 51);
 	strcpy(request->url, remote->url);
 	posn = request->url + strlen(remote->url);
diff --git a/http.c b/http.c
index ae27e0c..c6fb8ac 100644
--- a/http.c
+++ b/http.c
@@ -137,7 +137,7 @@ static int http_options(const char *var, const char *value)
 		return 0;
 	}

-#ifdef USE_CURL_MULTI	
+#ifdef USE_CURL_MULTI
 	if (!strcmp("http.maxrequests", var)) {
 		if (max_requests == -1)
 			max_requests = git_config_int(var, value);
diff --git a/imap-send.c b/imap-send.c
index 84df2fa..2b7471c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1239,7 +1239,7 @@ split_msg( msg_data_t *all_msgs, msg_data_t
*msg, int *ofs )
 	msg->data[ msg->len ] = 0;

 	*ofs += msg->len;
- 	return 1;
+	return 1;
 }

 static imap_server_conf_t server =
diff --git a/local-fetch.c b/local-fetch.c
index 4b650ef..bf7ec6c 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -114,7 +114,7 @@ static int fetch_pack(const unsigned char *sha1)
 		return -1;
 	target = find_sha1_pack(sha1, packs);
 	if (!target)
-		return error("Couldn't find %s: not separate or in any pack",
+		return error("Couldn't find %s: not separate or in any pack",
 			     sha1_to_hex(sha1));
 	if (get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
@@ -122,11 +122,11 @@ static int fetch_pack(const unsigned char *sha1)
 		fprintf(stderr, " which contains %s\n",
 			sha1_to_hex(sha1));
 	}
-	sprintf(filename, "%s/objects/pack/pack-%s.pack",
+	sprintf(filename, "%s/objects/pack/pack-%s.pack",
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_name(target->sha1),
 		  sha1_to_hex(target->sha1), 1);
-	sprintf(filename, "%s/objects/pack/pack-%s.idx",
+	sprintf(filename, "%s/objects/pack/pack-%s.idx",
 		path, sha1_to_hex(target->sha1));
 	copy_file(filename, sha1_pack_index_name(target->sha1),
 		  sha1_to_hex(target->sha1), 1);
@@ -141,7 +141,7 @@ static int fetch_file(const unsigned char *sha1)
 	char *hex = sha1_to_hex(sha1);
 	char *dest_filename = sha1_file_name(sha1);

- 	if (object_name_start < 0) {
+	if (object_name_start < 0) {
 		strcpy(filename, path); /* e.g. git.git */
 		strcat(filename, "/objects/");
 		object_name_start = strlen(filename);
diff --git a/lockfile.c b/lockfile.c
index 23db35a..5ad2858 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -97,4 +97,3 @@ void rollback_lock_file(struct lock_file *lk)
 		unlink(lk->filename);
 	lk->filename[0] = 0;
 }
-
diff --git a/mailmap.c b/mailmap.c
index cb567a2..8714167 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -89,4 +89,3 @@ int map_email(struct path_list *map, const char
*email, char *name, int maxlen)
 	}
 	return 0;
 }
-
diff --git a/match-trees.c b/match-trees.c
index 23cafe4..d7e29c4 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -301,4 +301,3 @@ void shift_tree(const unsigned char *hash1,

 	splice_tree(hash1, add_prefix, hash2, shifted);
 }
-
diff --git a/merge-index.c b/merge-index.c
index 5599fd3..fa719cb 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -25,7 +25,7 @@ static void run_program(void)
 static int merge_entry(int pos, const char *path)
 {
 	int found;
-	
+
 	if (pos >= active_nr)
 		die("git-merge-index: %s not in the cache", path);
 	arguments[0] = pgm;
diff --git a/mktag.c b/mktag.c
index 9310111..070bc96 100644
--- a/mktag.c
+++ b/mktag.c
@@ -11,7 +11,7 @@
  * The first three lines are guaranteed to be at least 63 bytes:
  * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
  * shortest possible type-line, and "tag .\n" at 6 bytes is the
- * shortest single-character-tag line.
+ * shortest single-character-tag line.
  *
  * We also artificially limit the size of the full object to 8kB.
  * Just because I'm a lazy bastard, and if you can't fit a signature
diff --git a/object-refs.c b/object-refs.c
index 022e8d8..5345671 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -85,5 +85,3 @@ void mark_reachable(struct object *obj, unsigned int mask)
 			mark_reachable(refs->ref[i], mask);
 	}
 }
-
-
diff --git a/pack-redundant.c b/pack-redundant.c
index 87077e1..876071f 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -81,7 +81,7 @@ static struct llist * llist_copy(struct llist *list)
 {
 	struct llist *ret;
 	struct llist_item *new, *old, *prev;
-	
+
 	llist_init(&ret);

 	if ((ret->size = list->size) == 0)
@@ -100,7 +100,7 @@ static struct llist * llist_copy(struct llist *list)
 	}
 	new->next = NULL;
 	ret->back = new;
-	
+
 	return ret;
 }

diff --git a/patch-id.c b/patch-id.c
index 086d2d9..9349bc5 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -81,4 +81,4 @@ int main(int argc, char **argv)

 	generate_id_list();
 	return 0;
-}	
+}
diff --git a/path-list.c b/path-list.c
index caaa5cc..dcb4b3a 100644
--- a/path-list.c
+++ b/path-list.c
@@ -100,4 +100,3 @@ void print_path_list(const char *text, const
struct path_list *p)
 	for (i = 0; i < p->nr; i++)
 		printf("%s:%p\n", p->items[i].path, p->items[i].util);
 }
-
diff --git a/pkt-line.c b/pkt-line.c
index b4cb7e2..cb831af 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -5,7 +5,7 @@
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
  * A length of 'zero' means end of stream (and a length of 1-3
- * would be an error).
+ * would be an error).
  *
  * This is all pretty stupid, but we use this packetized line
  * format to make a streaming format possible without ever
diff --git a/read-cache.c b/read-cache.c
index d9f46da..922046f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -166,7 +166,7 @@ static int ce_match_stat_basic(struct cache_entry
*ce, struct stat *st)
 		changed |= MTIME_CHANGED;
 	if (ce->ce_ctime.nsec != htonl(st->st_ctim.tv_nsec))
 		changed |= CTIME_CHANGED;
-#endif	
+#endif

 	if (ce->ce_uid != htonl(st->st_uid) ||
 	    ce->ce_gid != htonl(st->st_gid))
@@ -208,9 +208,9 @@ int ie_match_stat(struct index_state *istate,

 	/*
 	 * Within 1 second of this sequence:
-	 * 	echo xyzzy >file && git-update-index --add file
+	 *	echo xyzzy >file && git-update-index --add file
 	 * running this command:
-	 * 	echo frotz >file
+	 *	echo frotz >file
 	 * would give a falsely clean cache entry.  The mtime and
 	 * length match the cache, and other stat fields do not change.
 	 *
@@ -597,7 +597,7 @@ static int has_dir_name(struct index_state *istate,
  * is being added, or we already have path and path/file is being
  * added.  Either one would result in a nonsense tree that has path
  * twice when git-write-tree tries to write it out.  Prevent it.
- *
+ *
  * If ok-to-replace is specified, we remove the conflicting entries
  * from the cache so the caller should recompute the insert position.
  * When this happens, we return non-zero.
@@ -970,8 +970,8 @@ static int ce_write(SHA_CTX *context, int fd, void
*data, unsigned int len)
 		write_buffer_len = buffered;
 		len -= partial;
 		data = (char *) data + partial;
- 	}
- 	return 0;
+	}
+	return 0;
 }

 static int write_index_ext_header(SHA_CTX *context, int fd,
@@ -1037,7 +1037,7 @@ static void ce_smudge_racily_clean_entry(struct
cache_entry *ce)
 		 * size to zero here, then the object name recorded
 		 * in index is the 6-byte file but the cached stat information
 		 * becomes zero --- which would then match what we would
-		 * obtain from the filesystem next time we stat("frotz").
+		 * obtain from the filesystem next time we stat("frotz").
 		 *
 		 * However, the second update-index, before calling
 		 * this function, notices that the cached size is 6
diff --git a/setup.c b/setup.c
index a45ea83..14f62c4 100644
--- a/setup.c
+++ b/setup.c
@@ -39,7 +39,7 @@ const char *prefix_path(const char *prefix, int len,
const char *path)
 	if (len) {
 		int speclen = strlen(path);
 		char *n = xmalloc(speclen + len + 1);
-	
+
 		memcpy(n, prefix, len);
 		memcpy(n + len, path, speclen+1);
 		path = n;
@@ -47,7 +47,7 @@ const char *prefix_path(const char *prefix, int len,
const char *path)
 	return path;
 }

-/*
+/*
  * Unlike prefix_path, this should be used if the named file does
  * not have to interact with index entry; i.e. name of a random file
  * on the filesystem.
diff --git a/sha1_file.c b/sha1_file.c
index 32244d7..911eaec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -193,7 +193,7 @@ char *sha1_pack_name(const unsigned char *sha1)
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
 	}
-	
+
 	return base;
 }

@@ -218,7 +218,7 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
 	}
-	
+
 	return base;
 }

@@ -1109,7 +1109,7 @@ static int parse_sha1_header(const char *hdr,
unsigned long *sizep)
 	unsigned long size;

 	/*
-	 * The type can be at most ten bytes (including the
+	 * The type can be at most ten bytes (including the
 	 * terminating '\0' that we add), and is followed by
 	 * a space.
 	 */
@@ -1683,7 +1683,7 @@ static int find_pack_entry(const unsigned char
*sha1, struct pack_entry *e, cons
 	return 0;
 }

-struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs)
 {
 	struct packed_git *p;
diff --git a/shallow.c b/shallow.c
index d178689..dbd9f5a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -101,4 +101,3 @@ struct commit_list *get_shallow_commits(struct
object_array *heads, int depth,

 	return result;
 }
-
diff --git a/ssh-upload.c b/ssh-upload.c
index 2f04572..ca0003f 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -29,24 +29,24 @@ static int serve_object(int fd_in, int fd_out) {
 	}
 	if (!size)
 		return -1;
-	
+
 	if (verbose)
 		fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1));

 	remote = 0;
-	
+
 	if (!has_sha1_file(sha1)) {
 		fprintf(stderr, "git-ssh-upload: could not find %s\n",
 			sha1_to_hex(sha1));
 		remote = -1;
 	}
-	
+
 	if (write_in_full(fd_out, &remote, 1) != 1)
 		return 0;
-	
+
 	if (remote < 0)
 		return 0;
-	
+
 	return write_sha1_to_fd(fd_out, sha1);
 }

diff --git a/strbuf.c b/strbuf.c
index 7f14b0f..e33d06b 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -39,4 +39,3 @@ void read_line(struct strbuf *sb, FILE *fp, int term) {
 		sb->eof = 1;
 	strbuf_end(sb);
 }
-
diff --git a/tree-walk.c b/tree-walk.c
index cbb24eb..8d4b673 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -206,4 +206,3 @@ int get_tree_entry(const unsigned char *tree_sha1,
const char *name, unsigned ch
 	free(tree);
 	return retval;
 }
-
diff --git a/upload-pack.c b/upload-pack.c
index d3a09e7..0e881c8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -678,7 +678,7 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-	
+
 	if (i != argc-1)
 		usage(upload_pack_usage);
 	dir = argv[i];
diff --git a/var.c b/var.c
index e585e59..4127031 100644
--- a/var.c
+++ b/var.c
@@ -67,8 +67,8 @@ int main(int argc, char **argv)
 	val = read_var(argv[1]);
 	if (!val)
 		usage(var_usage);
-	
+
 	printf("%s\n", val);
-	
+
 	return 0;
 }
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 10816e9..3421efd 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -121,5 +121,3 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	ptr->size = sz;
 	return 0;
 }
-
-
-- 
1.5.2.rc3
