From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH] Style cleanup - When declaring pointers the star sides with the variable
Date: Mon, 02 Feb 2009 20:21:12 -0500
Organization: Norang Consulting Inc
Message-ID: <87pri0co3b.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moriyoshi Koizumi <mozo@mozo.jp>, git <git@vger.kernel.org>
To: "Junio C. Hamano" <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 02:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU9zz-0007Y5-IL
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 02:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZBCBVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 20:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbZBCBVT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 20:21:19 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60326 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZBCBVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 20:21:18 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LU9yW-000CNh-3q; Tue, 03 Feb 2009 01:21:16 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id n131LDhK010453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 Feb 2009 20:21:14 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n131LDYZ013058;
	Mon, 2 Feb 2009 20:21:13 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n131LCU7013057;
	Mon, 2 Feb 2009 20:21:12 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19amVm+mliPj48OhZWT9xPN
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.95 http://www.acme.com/software/spfmilter/ with libspf2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108136>

>From Documentation/CodingGuidelines:

 - When declaring pointers, the star sides with the variable
   name, i.e. "char *string", not "char* string" or
   "char * string".  This makes it easier to understand code
   like "char *string, c;".

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---

Here is a cleanup patch for all of the cases I could find.  I skipped
http.c since Junio already submitted a patch that covers that in
http://permalink.gmane.org/gmane.comp.version-control.git/108054

-Bernt

 alloc.c                  |    2 +-
 builtin-check-attr.c     |    4 ++--
 builtin-checkout-index.c |    2 +-
 builtin-config.c         |    6 +++---
 builtin-fast-export.c    |    2 +-
 builtin-fetch-pack.c     |    2 +-
 builtin-help.c           |    6 +++---
 commit.c                 |    2 +-
 config.c                 |   28 ++++++++++++++--------------
 diff.c                   |    6 +++---
 fast-import.c            |   34 +++++++++++++++++-----------------
 git.c                    |    4 ++--
 quote.c                  |    2 +-
 reflog-walk.c            |    6 +++---
 sha1_file.c              |   14 +++++++-------
 wt-status.c              |    2 +-
 16 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/alloc.c b/alloc.c
index 216c23a..6ef6753 100644
--- a/alloc.c
+++ b/alloc.c
@@ -57,7 +57,7 @@ DEFINE_ALLOCATOR(object, union any_object)
 #define SZ_FMT "%zu"
 #endif
 
-static void report(const char* name, unsigned int count, size_t size)
+static void report(const char *name, unsigned int count, size_t size)
 {
     fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
 }
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 15a04b7..abcf767 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -21,7 +21,7 @@ static const struct option check_attr_options[] = {
 };
 
 static void check_attr(int cnt, struct git_attr_check *check,
-	const char** name, const char *file)
+	const char **name, const char *file)
 {
 	int j;
 	if (git_checkattr(file, cnt, check))
@@ -42,7 +42,7 @@ static void check_attr(int cnt, struct git_attr_check *check,
 }
 
 static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
-	const char** name)
+	const char **name)
 {
 	struct strbuf buf, nbuf;
 	int line_termination = null_term_line ? 0 : '\n';
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 0d534bc..88d3314 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -124,7 +124,7 @@ static int checkout_file(const char *name, int prefix_length)
 static void checkout_all(const char *prefix, int prefix_length)
 {
 	int i, errs = 0;
-	struct cache_entry* last_ce = NULL;
+	struct cache_entry *last_ce = NULL;
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
diff --git a/builtin-config.c b/builtin-config.c
index f710162..1582673 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -27,7 +27,7 @@ static int show_all_config(const char *key_, const char *value_, void *cb)
 	return 0;
 }
 
-static int show_config(const char* key_, const char* value_, void *cb)
+static int show_config(const char *key_, const char *value_, void *cb)
 {
 	char value[256];
 	const char *vptr = value;
@@ -74,7 +74,7 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	return 0;
 }
 
-static int get_value(const char* key_, const char* regex_)
+static int get_value(const char *key_, const char *regex_)
 {
 	int ret = -1;
 	char *tl;
@@ -284,7 +284,7 @@ static int get_colorbool(int argc, const char **argv)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
-	char* value;
+	char *value;
 	const char *file = setup_git_directory_gently(&nongit);
 
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index e9ee2c7..56b3cce 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -62,7 +62,7 @@ static inline uint32_t *mark_to_ptr(uint32_t mark)
 	return ((uint32_t *)NULL) + mark;
 }
 
-static inline uint32_t ptr_to_mark(void * mark)
+static inline uint32_t ptr_to_mark(void *mark)
 {
 	return (uint32_t *)mark - (uint32_t *)NULL;
 }
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 67fb80e..98cbd75 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -111,7 +111,7 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const unsigned char* get_rev(void)
+static const unsigned char *get_rev(void)
 {
 	struct commit *commit = NULL;
 
diff --git a/builtin-help.c b/builtin-help.c
index 9b57a74..d3e7e90 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -114,7 +114,7 @@ static int check_emacsclient_version(void)
 	return 0;
 }
 
-static void exec_woman_emacs(const char* path, const char *page)
+static void exec_woman_emacs(const char *path, const char *page)
 {
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
@@ -128,7 +128,7 @@ static void exec_woman_emacs(const char* path, const char *page)
 	}
 }
 
-static void exec_man_konqueror(const char* path, const char *page)
+static void exec_man_konqueror(const char *path, const char *page)
 {
 	const char *display = getenv("DISPLAY");
 	if (display && *display) {
@@ -156,7 +156,7 @@ static void exec_man_konqueror(const char* path, const char *page)
 	}
 }
 
-static void exec_man_man(const char* path, const char *page)
+static void exec_man_man(const char *path, const char *page)
 {
 	if (!path)
 		path = "man";
diff --git a/commit.c b/commit.c
index aa3b35b..bce9c1b 100644
--- a/commit.c
+++ b/commit.c
@@ -423,7 +423,7 @@ struct commit *pop_commit(struct commit_list **stack)
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list ** list, int lifo)
+void sort_in_topological_order(struct commit_list **list, int lifo)
 {
 	struct commit_list *next, *orig = *list;
 	struct commit_list *work, **insert;
diff --git a/config.c b/config.c
index 790405a..35c611d 100644
--- a/config.c
+++ b/config.c
@@ -665,16 +665,16 @@ int git_config(config_fn_t fn, void *data)
 
 static struct {
 	int baselen;
-	char* key;
+	char *key;
 	int do_not_match;
-	regex_t* value_regex;
+	regex_t *value_regex;
 	int multi_replace;
 	size_t offset[MAX_MATCHES];
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	int seen;
 } store;
 
-static int matches(const char* key, const char* value)
+static int matches(const char *key, const char *value)
 {
 	return !strcmp(key, store.key) &&
 		(store.value_regex == NULL ||
@@ -682,7 +682,7 @@ static int matches(const char* key, const char* value)
 		  !regexec(store.value_regex, value, 0, NULL, 0)));
 }
 
-static int store_aux(const char* key, const char* value, void *cb)
+static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
@@ -751,7 +751,7 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char* key)
+static int store_write_section(int fd, const char *key)
 {
 	const char *dot;
 	int i, success;
@@ -776,7 +776,7 @@ static int store_write_section(int fd, const char* key)
 	return success;
 }
 
-static int store_write_pair(int fd, const char* key, const char* value)
+static int store_write_pair(int fd, const char *key, const char *value)
 {
 	int i, success;
 	int length = strlen(key + store.baselen + 1);
@@ -824,7 +824,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	return success;
 }
 
-static ssize_t find_beginning_of_line(const char* contents, size_t size,
+static ssize_t find_beginning_of_line(const char *contents, size_t size,
 	size_t offset_, int* found_bracket)
 {
 	size_t equal_offset = size, bracket_offset = size;
@@ -850,7 +850,7 @@ contline:
 	return offset;
 }
 
-int git_config_set(const char* key, const char* value)
+int git_config_set(const char *key, const char *value)
 {
 	return git_config_set_multivar(key, value, NULL, 0);
 }
@@ -878,15 +878,15 @@ int git_config_set(const char* key, const char* value)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char* key, const char* value,
-	const char* value_regex, int multi_replace)
+int git_config_set_multivar(const char *key, const char *value,
+			    const char *value_regex, int multi_replace)
 {
 	int i, dot;
 	int fd = -1, in_fd;
 	int ret;
-	char* config_filename;
+	char *config_filename;
 	struct lock_file *lock = NULL;
-	const char* last_dot = strrchr(key, '.');
+	const char *last_dot = strrchr(key, '.');
 
 	if (config_exclusive_filename)
 		config_filename = xstrdup(config_exclusive_filename);
@@ -967,13 +967,13 @@ int git_config_set_multivar(const char* key, const char* value,
 			goto out_free;
 		}
 
-		store.key = (char*)key;
+		store.key = (char *)key;
 		if (!store_write_section(fd, key) ||
 		    !store_write_pair(fd, key, value))
 			goto write_err_out;
 	} else {
 		struct stat st;
-		char* contents;
+		char *contents;
 		size_t contents_sz, copy_begin, copy_end;
 		int i, new_line = 0;
 
diff --git a/diff.c b/diff.c
index a5a540f..34d0543 100644
--- a/diff.c
+++ b/diff.c
@@ -873,7 +873,7 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-static void show_stats(struct diffstat_t* data, struct diff_options *options)
+static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, total, adds = 0, dels = 0;
 	int max_change = 0, max_len = 0;
@@ -999,7 +999,7 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 	       set, total_files, adds, dels, reset);
 }
 
-static void show_shortstats(struct diffstat_t* data, struct diff_options *options)
+static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, adds = 0, dels = 0, total_files = data->nr;
 
@@ -1024,7 +1024,7 @@ static void show_shortstats(struct diffstat_t* data, struct diff_options *option
 	       total_files, adds, dels);
 }
 
-static void show_numstat(struct diffstat_t* data, struct diff_options *options)
+static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 {
 	int i;
 
diff --git a/fast-import.c b/fast-import.c
index 1935206..50b17b8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -211,7 +211,7 @@ struct tree_content;
 struct tree_entry
 {
 	struct tree_content *tree;
-	struct atom_str* name;
+	struct atom_str *name;
 	struct tree_entry_ms
 	{
 		uint16_t mode;
@@ -312,7 +312,7 @@ static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
-static const char* mark_file;
+static const char *mark_file;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -671,7 +671,7 @@ static struct branch *lookup_branch(const char *name)
 static struct branch *new_branch(const char *name)
 {
 	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
-	struct branch* b = lookup_branch(name);
+	struct branch *b = lookup_branch(name);
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
@@ -839,8 +839,8 @@ static void start_packfile(void)
 
 static int oecmp (const void *a_, const void *b_)
 {
-	struct object_entry *a = *((struct object_entry**)a_);
-	struct object_entry *b = *((struct object_entry**)b_);
+	struct object_entry *a = *((struct object_entry **)a_);
+	struct object_entry *b = *((struct object_entry **)b_);
 	return hashcmp(a->sha1, b->sha1);
 }
 
@@ -855,7 +855,7 @@ static char *create_index(void)
 	int i, idx_fd;
 
 	/* Build the sorted table of object IDs. */
-	idx = xmalloc(object_count * sizeof(struct object_entry*));
+	idx = xmalloc(object_count * sizeof(struct object_entry *));
 	c = idx;
 	for (o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
@@ -864,7 +864,7 @@ static char *create_index(void)
 	last = idx + object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
-	qsort(idx, object_count, sizeof(struct object_entry*), oecmp);
+	qsort(idx, object_count, sizeof(struct object_entry *), oecmp);
 
 	/* Generate the fan-out array. */
 	c = idx;
@@ -1040,7 +1040,7 @@ static int store_object(
 	git_SHA_CTX c;
 	z_stream s;
 
-	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
+	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
@@ -1222,7 +1222,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
 
 static void load_tree(struct tree_entry *root)
 {
-	unsigned char* sha1 = root->versions[1].sha1;
+	unsigned char *sha1 = root->versions[1].sha1;
 	struct object_entry *myoe;
 	struct tree_content *t;
 	unsigned long size;
@@ -1263,8 +1263,8 @@ static void load_tree(struct tree_entry *root)
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
-		hashcpy(e->versions[0].sha1, (unsigned char*)c);
-		hashcpy(e->versions[1].sha1, (unsigned char*)c);
+		hashcpy(e->versions[0].sha1, (unsigned char *)c);
+		hashcpy(e->versions[1].sha1, (unsigned char *)c);
 		c += 20;
 	}
 	free(buf);
@@ -1272,8 +1272,8 @@ static void load_tree(struct tree_entry *root)
 
 static int tecmp0 (const void *_a, const void *_b)
 {
-	struct tree_entry *a = *((struct tree_entry**)_a);
-	struct tree_entry *b = *((struct tree_entry**)_b);
+	struct tree_entry *a = *((struct tree_entry **)_a);
+	struct tree_entry *b = *((struct tree_entry **)_b);
 	return base_name_compare(
 		a->name->str_dat, a->name->str_len, a->versions[0].mode,
 		b->name->str_dat, b->name->str_len, b->versions[0].mode);
@@ -1281,8 +1281,8 @@ static int tecmp0 (const void *_a, const void *_b)
 
 static int tecmp1 (const void *_a, const void *_b)
 {
-	struct tree_entry *a = *((struct tree_entry**)_a);
-	struct tree_entry *b = *((struct tree_entry**)_b);
+	struct tree_entry *a = *((struct tree_entry **)_a);
+	struct tree_entry *b = *((struct tree_entry **)_b);
 	return base_name_compare(
 		a->name->str_dat, a->name->str_len, a->versions[1].mode,
 		b->name->str_dat, b->name->str_len, b->versions[1].mode);
@@ -2416,8 +2416,8 @@ int main(int argc, const char **argv)
 
 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
-	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str*));
-	branch_table = xcalloc(branch_table_sz, sizeof(struct branch*));
+	atom_table = xcalloc(atom_table_sz, sizeof(struct atom_str *));
+	branch_table = xcalloc(branch_table_sz, sizeof(struct branch *));
 	avail_tree_table = xcalloc(avail_tree_table_sz, sizeof(struct avail_tree_content*));
 	marks = pool_calloc(1, sizeof(struct mark_set));
 
diff --git a/git.c b/git.c
index 320cb43..2c3f894 100644
--- a/git.c
+++ b/git.c
@@ -46,7 +46,7 @@ static void commit_pager_choice(void) {
 	}
 }
 
-static int handle_options(const char*** argv, int* argc, int* envchanged)
+static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	int handled = 0;
 
@@ -132,7 +132,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
 	int count, option_count;
-	const char** new_argv;
+	const char **new_argv;
 	const char *alias_command;
 	char *alias_string;
 	int unused_nongit;
diff --git a/quote.c b/quote.c
index 6a52085..c5c2fa7 100644
--- a/quote.c
+++ b/quote.c
@@ -58,7 +58,7 @@ void sq_quote_print(FILE *stream, const char *src)
 	fputc('\'', stream);
 }
 
-void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
+void sq_quote_argv(struct strbuf *dst, const char **argv, size_t maxlen)
 {
 	int i;
 
diff --git a/reflog-walk.c b/reflog-walk.c
index f751fdc..05a7696 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -131,7 +131,7 @@ struct reflog_walk_info {
 	struct commit_reflog *last_commit_reflog;
 };
 
-void init_reflog_walk(struct reflog_walk_info** info)
+void init_reflog_walk(struct reflog_walk_info **info)
 {
 	*info = xcalloc(sizeof(struct reflog_walk_info), 1);
 }
@@ -241,8 +241,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info, int oneline,
-	int relative_date)
+void show_reflog_message(struct reflog_walk_info *info, int oneline,
+			 int relative_date)
 {
 	if (info && info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog = info->last_commit_reflog;
diff --git a/sha1_file.c b/sha1_file.c
index 8868b80..09fc4a8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -235,7 +235,7 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 struct alternate_object_database *alt_odb_list;
 static struct alternate_object_database **alt_odb_tail;
 
-static void read_info_alternates(const char * alternates, int depth);
+static void read_info_alternates(const char *alternates, int depth);
 
 /*
  * Prepare alternate object database registry.
@@ -252,7 +252,7 @@ static void read_info_alternates(const char * alternates, int depth);
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
+static int link_alt_odb_entry(const char *entry, int len, const char *relative_base, int depth)
 {
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
@@ -356,7 +356,7 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 	}
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates(const char *relative_base, int depth)
 {
 	char *map;
 	size_t mapsz;
@@ -790,10 +790,10 @@ static int in_window(struct pack_window *win, off_t offset)
 		&& (offset + 20) <= (win_off + win->len);
 }
 
-unsigned char* use_pack(struct packed_git *p,
-		struct pack_window **w_cursor,
-		off_t offset,
-		unsigned int *left)
+unsigned char *use_pack(struct packed_git *p,
+			struct pack_window **w_cursor,
+			off_t offset,
+			unsigned int *left)
 {
 	struct pack_window *win = *w_cursor;
 
diff --git a/wt-status.c b/wt-status.c
index 96ff2f8..ac6246e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -40,7 +40,7 @@ static int parse_status_slot(const char *var, int offset)
 	die("bad config variable '%s'", var);
 }
 
-static const char* color(int slot)
+static const char *color(int slot)
 {
 	return wt_status_use_color > 0 ? wt_status_colors[slot] : "";
 }
-- 
1.6.1.2.310.gdba4a
