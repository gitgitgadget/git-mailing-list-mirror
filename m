From: Brilliantov Kirill Vladimirovich <brilliantovkv@byterg.ru>
Subject: [PATCH] Use GIT_SHA1_RAWSZ as array size instead magic number 20
Date: Mon,  8 Feb 2016 15:11:22 +0300
Message-ID: <1454933482-31920-1-git-send-email-brilliantovkv@byterg.ru>
Cc: Brilliantov Kirill Vladimirovich <brilliantovkv@byterg.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 14:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSlmu-0002k1-75
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 14:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbcBHNX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 08:23:28 -0500
Received: from mail.byterg.ru ([62.205.171.178]:51756 "EHLO mail.byterg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbcBHNX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 08:23:26 -0500
X-Greylist: delayed 4466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2016 08:23:25 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=byterg.ru; s=mail;
	h=Message-Id:Date:Subject:Cc:To:From; bh=fAnJt2I5LYEXot7lhNgavbQS4DQnxT4R/T1/O0wsrH4=;
	b=bitdXhvcK5cu9NTzb0+xX4OPJSaDL3wJ/80AXjls7ydirmH62U+FxIgn653aVe/MTMYWmJmjZ7hiHQs1mSqWaT++qxhrvS+Ft3jluGPERX3s/4YzwqC5iEdZmzLdbwmSD/5hd5UXPRfCM3hGzuiMN2diB2EXO7kIlvZGpooripY=;
Received: from [192.168.10.51] (helo=kirill.byterg.ru)
	by mail.byterg.ru with esmtp (Exim 4.84)
	(envelope-from <brilliantovkv@byterg.ru>)
	id 1aSkci-0003sK-Nc; Mon, 08 Feb 2016 15:08:57 +0300
X-Mailer: git-send-email 2.1.4
X-Spam-Score: -2.9 (--)
X-Spam-Report: Spam detection software, running on the system "mail.byterg.ru",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantovkv@byterg.ru>
    --- builtin/apply.c | 4 ++-- builtin/blame.c | 2 +- builtin/cat-file.c |
   8 ++++---- builtin/checkout.c | 18 +++++++++--------- builtin/commit-tree.c
    | 6 +++--- builtin/commit.c | 6 +++--- builtin/describe.c | 4 ++-- builtin/diff-tree.c
    | 8 ++++---- builtin/diff.c | 2 +- builtin/fast-export.c | 6 +++--- builtin/fmt-merge-msg.c
    | 12 ++++++------ builtin/grep.c | 2 +- builtin/hash-object.c | 2 +- builtin/index-pack.c
    | 6 +++--- 14 files changed, 43 insertions(+), 43 deletions(-) [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285762>

Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantovkv@byterg.ru>
---
 builtin/apply.c         |  4 ++--
 builtin/blame.c         |  2 +-
 builtin/cat-file.c      |  8 ++++----
 builtin/checkout.c      | 18 +++++++++---------
 builtin/commit-tree.c   |  6 +++---
 builtin/commit.c        |  6 +++---
 builtin/describe.c      |  4 ++--
 builtin/diff-tree.c     |  8 ++++----
 builtin/diff.c          |  2 +-
 builtin/fast-export.c   |  6 +++---
 builtin/fmt-merge-msg.c | 12 ++++++------
 builtin/grep.c          |  2 +-
 builtin/hash-object.c   |  2 +-
 builtin/index-pack.c    |  6 +++---
 14 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index deb1364..63d14ca 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -202,8 +202,8 @@ struct patch {
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
-	char old_sha1_prefix[41];
-	char new_sha1_prefix[41];
+	char old_sha1_prefix[GIT_SHA1_HEXSZ + 1];
+	char new_sha1_prefix[GIT_SHA1_HEXSZ + 1];
 	struct patch *next;
 
 	/* three-way fallback result */
diff --git a/builtin/blame.c b/builtin/blame.c
index 55bf5fa..e1fd8d5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -120,7 +120,7 @@ struct origin {
 	 */
 	struct blame_entry *suspects;
 	mmfile_t file;
-	unsigned char blob_sha1[20];
+	unsigned char blob_sha1[GIT_SHA1_RAWSZ];
 	unsigned mode;
 	/* guilty gets set when shipping any suspects to the final
 	 * blame list instead of other commits
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 54db118..36fea66 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -23,7 +23,7 @@ struct batch_options {
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	enum object_type type;
 	char *buf;
 	unsigned long size;
@@ -93,7 +93,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
-			unsigned char blob_sha1[20];
+			unsigned char blob_sha1[GIT_SHA1_RAWSZ];
 			if (sha1_object_info(sha1, NULL) == OBJ_TAG) {
 				char *buffer = read_sha1_file(sha1, &type, &size);
 				const char *target;
@@ -128,12 +128,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 }
 
 struct expand_data {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	enum object_type type;
 	unsigned long size;
 	unsigned long disk_size;
 	const char *rest;
-	unsigned char delta_base_sha1[20];
+	unsigned char delta_base_sha1[GIT_SHA1_RAWSZ];
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5af84a3..acec04f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -175,9 +175,9 @@ static int checkout_merged(int pos, struct checkout *state)
 	const char *path = ce->name;
 	mmfile_t ancestor, ours, theirs;
 	int status;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	mmbuffer_t result_buf;
-	unsigned char threeway[3][20];
+	unsigned char threeway[3][GIT_SHA1_RAWSZ];
 	unsigned mode = 0;
 
 	memset(threeway, 0, sizeof(threeway));
@@ -241,7 +241,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	int pos;
 	struct checkout state;
 	static char *ps_matched;
-	unsigned char rev[20];
+	unsigned char rev[GIT_SHA1_RAWSZ];
 	int flag;
 	struct commit *head;
 	int errs = 0;
@@ -806,7 +806,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	int ret = 0;
 	struct branch_info old;
 	void *path_to_free;
-	unsigned char rev[20];
+	unsigned char rev[GIT_SHA1_RAWSZ];
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
 	old.path = path_to_free = resolve_refdup("HEAD", 0, rev, &flag);
@@ -900,12 +900,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
 				struct branch_info *new,
 				struct checkout_opts *opts,
-				unsigned char rev[20])
+				unsigned char rev[GIT_SHA1_RAWSZ])
 {
 	struct tree **source_tree = &opts->source_tree;
 	const char **new_branch = &opts->new_branch;
 	int argcount = 0;
-	unsigned char branch_rev[20];
+	unsigned char branch_rev[GIT_SHA1_RAWSZ];
 	const char *arg;
 	int dash_dash_pos;
 	int has_dash_dash = 0;
@@ -1105,7 +1105,7 @@ static int checkout_branch(struct checkout_opts *opts,
 
 	if (new->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
-		unsigned char sha1[20];
+		unsigned char sha1[GIT_SHA1_RAWSZ];
 		int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, sha1, &flag);
 		if (head_ref &&
@@ -1115,7 +1115,7 @@ static int checkout_branch(struct checkout_opts *opts,
 	}
 
 	if (!new->commit && opts->new_branch) {
-		unsigned char rev[20];
+		unsigned char rev[GIT_SHA1_RAWSZ];
 		int flag;
 
 		if (!read_ref_full("HEAD", 0, rev, &flag) &&
@@ -1229,7 +1229,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 * remote branches, erroring out for invalid or ambiguous cases.
 	 */
 	if (argc) {
-		unsigned char rev[20];
+		unsigned char rev[GIT_SHA1_RAWSZ];
 		int dwim_ok =
 			!opts.patch_mode &&
 			dwim_new_local_branch &&
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 3feeffe..d50a732 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -44,8 +44,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i, got_tree = 0;
 	struct commit_list *parents = NULL;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
+	unsigned char tree_sha1[GIT_SHA1_RAWSZ];
+	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
 	struct strbuf buffer = STRBUF_INIT;
 
 	git_config(commit_tree_config, NULL);
@@ -56,7 +56,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "-p")) {
-			unsigned char sha1[20];
+			unsigned char sha1[GIT_SHA1_RAWSZ];
 			if (argc <= ++i)
 				usage(commit_tree_usage);
 			if (get_sha1_commit(argv[i], sha1))
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..79eca8d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1317,7 +1317,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
 	int fd;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
@@ -1419,7 +1419,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	struct rev_info rev;
 	struct commit *commit;
 	struct strbuf format = STRBUF_INIT;
-	unsigned char junk_sha1[20];
+	unsigned char junk_sha1[GIT_SHA1_RAWSZ];
 	const char *head;
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
@@ -1629,7 +1629,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	struct commit_list *parents = NULL, **pptr = &parents;
 	struct stat statbuf;
 	struct commit *current_head = NULL;
diff --git a/builtin/describe.c b/builtin/describe.c
index 8a25abe..04958ad 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -43,7 +43,7 @@ struct commit_name {
 	struct tag *tag;
 	unsigned prio:2; /* annotated tag = 2, tag = 1, head = 0 */
 	unsigned name_checked:1;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	char *path;
 };
 
@@ -237,7 +237,7 @@ static void show_suffix(int depth, const unsigned char *sha1)
 
 static void describe(const char *arg, int last_one)
 {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	struct commit *cmit, *gave_up_on = NULL;
 	struct commit_list *list;
 	struct commit_name *n;
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 2a12b81..5478785 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -18,7 +18,7 @@ static int diff_tree_commit_sha1(const unsigned char *sha1)
 /* Diff one or more commits. */
 static int stdin_diff_commit(struct commit *commit, char *line, int len)
 {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
 		/* Graft the fake parents locally to the commit */
 		int pos = 41;
@@ -42,7 +42,7 @@ static int stdin_diff_commit(struct commit *commit, char *line, int len)
 /* Diff two trees. */
 static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	struct tree *tree2;
 	if (len != 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1))
 		return error("Need exactly two trees, separated by a space");
@@ -60,7 +60,7 @@ static int stdin_diff_trees(struct tree *tree1, char *line, int len)
 static int diff_tree_stdin(char *line)
 {
 	int len = strlen(line);
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	struct object *obj;
 
 	if (!len || line[len-1] != '\n')
@@ -164,7 +164,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
 					       DIFF_SETUP_USE_CACHE);
 		while (fgets(line, sizeof(line), stdin)) {
-			unsigned char sha1[20];
+			unsigned char sha1[GIT_SHA1_RAWSZ];
 
 			if (get_sha1_hex(line, sha1)) {
 				fputs(line, stdout);
diff --git a/builtin/diff.c b/builtin/diff.c
index 52c98a9..84b8397 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -21,7 +21,7 @@
 #define DIFF_NO_INDEX_IMPLICIT 2
 
 struct blobinfo {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	const char *name;
 	unsigned mode;
 };
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2471297..e5eeb8e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -326,7 +326,7 @@ static void print_path(const char *path)
 static void *generate_fake_sha1(const void *old, size_t *len)
 {
 	static uint32_t counter = 1; /* avoid null sha1 */
-	unsigned char *out = xcalloc(20, 1);
+	unsigned char *out = xcalloc(GIT_SHA1_RAWSZ, 1);
 	put_be32(out + 16, counter++);
 	return out;
 }
@@ -797,7 +797,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 	for (i = 0; i < info->nr; i++) {
 		struct rev_cmdline_entry *e = info->rev + i;
-		unsigned char sha1[20];
+		unsigned char sha1[GIT_SHA1_RAWSZ];
 		struct commit *commit;
 		char *full_name;
 
@@ -912,7 +912,7 @@ static void import_marks(char *input_file)
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
 		char *line_end, *mark_end;
-		unsigned char sha1[20];
+		unsigned char sha1[GIT_SHA1_RAWSZ];
 		struct object *object;
 		struct commit *commit;
 		enum object_type type;
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e5658c3..b3615de 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -41,7 +41,7 @@ struct src_data {
 };
 
 struct origin_data {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	unsigned is_local_branch:1;
 };
 
@@ -59,8 +59,8 @@ static struct string_list origins = STRING_LIST_INIT_DUP;
 struct merge_parents {
 	int alloc, nr;
 	struct merge_parent {
-		unsigned char given[20];
-		unsigned char commit[20];
+		unsigned char given[GIT_SHA1_RAWSZ];
+		unsigned char commit[GIT_SHA1_RAWSZ];
 		unsigned char used;
 	} *item;
 };
@@ -106,7 +106,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head = 0;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 
 	if (len < 43 || line[40] != '\t')
 		return 1;
@@ -546,7 +546,7 @@ static void find_merge_parents(struct merge_parents *result,
 		int len;
 		char *p = in->buf + pos;
 		char *newline = strchr(p, '\n');
-		unsigned char sha1[20];
+		unsigned char sha1[GIT_SHA1_RAWSZ];
 		struct commit *parent;
 		struct object *obj;
 
@@ -596,7 +596,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		  struct fmt_merge_msg_opts *opts)
 {
 	int i = 0, pos = 0;
-	unsigned char head_sha1[20];
+	unsigned char head_sha1[GIT_SHA1_RAWSZ];
 	const char *current_branch;
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
diff --git a/builtin/grep.c b/builtin/grep.c
index 8c516a9..24e825e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -817,7 +817,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	/* Check revs and then paths */
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
-		unsigned char sha1[20];
+		unsigned char sha1[GIT_SHA1_RAWSZ];
 		struct object_context oc;
 		/* Is it a rev? */
 		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index ff20395..4f992e1 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -32,7 +32,7 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		    int literally)
 {
 	struct stat st;
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 
 	if (fstat(fd, &st) < 0 ||
 	    (literally
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6a01509..da2f001 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -56,7 +56,7 @@ struct ofs_delta_entry {
 };
 
 struct ref_delta_entry {
-	unsigned char sha1[20];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
 	int obj_no;
 };
 
@@ -1110,7 +1110,7 @@ static void parse_pack_objects(unsigned char *sha1)
 {
 	int i, nr_delays = 0;
 	struct ofs_delta_entry *ofs_delta = ofs_deltas;
-	unsigned char ref_delta_sha1[20];
+	unsigned char ref_delta_sha1[GIT_SHA1_RAWSZ];
 	struct stat st;
 
 	if (verbose)
@@ -1239,7 +1239,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 
 	if (fix_thin_pack) {
 		struct sha1file *f;
-		unsigned char read_sha1[20], tail_sha1[20];
+		unsigned char read_sha1[GIT_SHA1_RAWSZ], tail_sha1[GIT_SHA1_RAWSZ];
 		struct strbuf msg = STRBUF_INIT;
 		int nr_unresolved = nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas;
 		int nr_objects_initial = nr_objects;
-- 
2.1.4
