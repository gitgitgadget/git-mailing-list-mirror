From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri,  1 May 2009 12:06:36 +0300
Message-ID: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 11:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzohu-0003Oh-8N
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZEAJGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 05:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbZEAJGt
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:06:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:42358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZEAJGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 05:06:46 -0400
Received: by fg-out-1718.google.com with SMTP id d23so32908fga.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cG0bZvSLtV+TrGjr4OE5K0hM0bAxjz0bayen0drL9/8=;
        b=ttsLmvbIHzKK3lRJqvv4nORsCfPp1z8cJ09YKgyfUCQISyGpOGrLdjZoenRKdlmrZ6
         Ls0reIGaTR1PKXzxWKQ2bO275mIK8kshlnz43Zpq9kuoev2jWDj53dVltQx0IJd3u3Ng
         cWUSteh/5s7DDgUA7bcllNe42fTJSbQ+tF3zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kxgsRfYiQ+/14d1G8c2simov6t5Pf8I+YvzanCrZ/eSrkns2tlMc0uG7hgjkwWW2IH
         kNrZW/7jXON+JbtWa0XoXWcHxjuI6fjw/dXyLGVUenrQnOgp+KbNPjJc5slhQDHIDKER
         p9ysPMvlzWlsiM6lrC7ZHfTZzhHbj8JWGiRN8=
Received: by 10.86.79.12 with SMTP id c12mr2704461fgb.64.1241168805001;
        Fri, 01 May 2009 02:06:45 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id e11sm445205fga.21.2009.05.01.02.06.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 02:06:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118065>

Essentially; s/type* /type */ as per the coding guidelines.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 alias.c                                   |    4 +-
 alloc.c                                   |    2 +-
 attr.c                                    |    4 +-
 builtin-blame.c                           |    8 +++---
 builtin-checkout-index.c                  |    4 +-
 builtin-describe.c                        |    4 +-
 builtin-fetch-pack.c                      |    2 +-
 builtin-help.c                            |    6 ++--
 builtin-update-index.c                    |    6 ++--
 cache.h                                   |    2 +-
 combine-diff.c                            |    4 +-
 compat/mingw.c                            |    2 +-
 config.c                                  |   30 ++++++++++++++--------------
 contrib/convert-objects/convert-objects.c |    6 ++--
 diff-no-index.c                           |    2 +-
 diff.c                                    |    6 ++--
 dir.c                                     |    2 +-
 fast-import.c                             |   14 ++++++------
 git.c                                     |    8 +++---
 lockfile.c                                |    2 +-
 reflog-walk.c                             |    2 +-
 run-command.c                             |    2 +-
 server-info.c                             |    4 +-
 sha1_file.c                               |    2 +-
 wt-status.c                               |    2 +-
 25 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/alias.c b/alias.c
index ccb1108..e687fe5 100644
--- a/alias.c
+++ b/alias.c
@@ -27,7 +27,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 	int src, dst, count = 0, size = 16;
 	char quoted = 0;
 
-	*argv = xmalloc(sizeof(char*) * size);
+	*argv = xmalloc(sizeof(char *) * size);
 
 	/* split alias_string */
 	(*argv)[count++] = cmdline;
@@ -40,7 +40,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 				; /* skip */
 			if (count >= size) {
 				size += 16;
-				*argv = xrealloc(*argv, sizeof(char*) * size);
+				*argv = xrealloc(*argv, sizeof(char *) * size);
 			}
 			(*argv)[count++] = cmdline + dst;
 		} else if (!quoted && (c == '\'' || c == '"')) {
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
diff --git a/attr.c b/attr.c
index f1ca4f5..98eb636 100644
--- a/attr.c
+++ b/attr.c
@@ -224,7 +224,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		if (is_macro)
 			res->u.attr = git_attr(name, namelen);
 		else {
-			res->u.pattern = (char*)&(res->state[num_attr]);
+			res->u.pattern = (char *)&(res->state[num_attr]);
 			memcpy(res->u.pattern, name, namelen);
 			res->u.pattern[namelen] = 0;
 		}
@@ -275,7 +275,7 @@ static void free_attr_elem(struct attr_stack *e)
 			    setto == ATTR__UNKNOWN)
 				;
 			else
-				free((char*) setto);
+				free((char *) setto);
 		}
 		free(a);
 	}
diff --git a/builtin-blame.c b/builtin-blame.c
index 83141fc..cf74a92 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -873,7 +873,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * Prepare mmfile that contains only the lines in ent.
 	 */
 	cp = nth_line(sb, ent->lno);
-	file_o.ptr = (char*) cp;
+	file_o.ptr = (char *) cp;
 	cnt = ent->num_lines;
 
 	while (cnt && cp < sb->final_buf + sb->final_buf_size) {
@@ -1704,7 +1704,7 @@ static int prepare_lines(struct scoreboard *sb)
 	while (len--) {
 		if (bol) {
 			sb->lineno = xrealloc(sb->lineno,
-					      sizeof(int* ) * (num + 1));
+					      sizeof(int *) * (num + 1));
 			sb->lineno[num] = buf - sb->final_buf;
 			bol = 0;
 		}
@@ -1714,7 +1714,7 @@ static int prepare_lines(struct scoreboard *sb)
 		}
 	}
 	sb->lineno = xrealloc(sb->lineno,
-			      sizeof(int* ) * (num + incomplete + 1));
+			      sizeof(int *) * (num + incomplete + 1));
 	sb->lineno[num + incomplete] = buf - sb->final_buf;
 	sb->num_lines = num + incomplete;
 	return sb->num_lines;
@@ -1889,7 +1889,7 @@ static const char *parse_loc(const char *spec,
 		return spec;
 
 	/* it could be a regexp of form /.../ */
-	for (term = (char*) spec + 1; *term && *term != '/'; term++) {
+	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
 		if (*term == '\\')
 			term++;
 	}
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 0d534bc..afe35e2 100644
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
@@ -278,7 +278,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p, prefix_length);
 		if (p < arg || p > arg + strlen(arg))
-			free((char*)p);
+			free((char *)p);
 	}
 
 	if (read_from_stdin) {
diff --git a/builtin-describe.c b/builtin-describe.c
index 3a007ed..63c6a19 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -334,7 +334,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die("--long is incompatible with --abbrev=0");
 
 	if (contains) {
-		const char **args = xmalloc((7 + argc) * sizeof(char*));
+		const char **args = xmalloc((7 + argc) * sizeof(char *));
 		int i = 0;
 		args[i++] = "name-rev";
 		args[i++] = "--name-only";
@@ -349,7 +349,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 				args[i++] = s;
 			}
 		}
-		memcpy(args + i, argv, argc * sizeof(char*));
+		memcpy(args + i, argv, argc * sizeof(char *));
 		args[i + argc] = NULL;
 		return cmd_name_rev(i + argc, args, prefix);
 	}
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 5d134be..cbe5f20 100644
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
index e7fbe9a..67dda3e 100644
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
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1fde893..92beaaf 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -292,7 +292,7 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 	report("add '%s'", path);
  free_return:
 	if (p < path || p > path + strlen(path))
-		free((char*)p);
+		free((char *)p);
 }
 
 static void read_index_info(int line_termination)
@@ -509,7 +509,7 @@ static int do_unresolve(int ac, const char **av,
 		const char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
 		if (p < arg || p > arg + strlen(arg))
-			free((char*)p);
+			free((char *)p);
 	}
 	return err;
 }
@@ -712,7 +712,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (set_executable_bit)
 			chmod_path(set_executable_bit, p);
 		if (p < path || p > path + strlen(path))
-			free((char*)p);
+			free((char *)p);
 	}
 	if (read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index d0d48b4..b8503ad 100644
--- a/cache.h
+++ b/cache.h
@@ -846,7 +846,7 @@ extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 extern void pack_report(void);
 extern int open_pack_index(struct packed_git *);
-extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned int *);
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
diff --git a/combine-diff.c b/combine-diff.c
index d210656..60d0367 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -24,7 +24,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			path = q->queue[i]->two->path;
 			len = strlen(path);
 			p = xmalloc(combine_diff_path_size(num_parent, len));
-			p->path = (char*) &(p->parent[num_parent]);
+			p->path = (char *) &(p->parent[num_parent]);
 			memcpy(p->path, path, len);
 			p->path[len] = 0;
 			p->len = len;
@@ -1063,7 +1063,7 @@ void diff_tree_combined_merge(const unsigned char *sha1,
 	for (parents = commit->parents, num_parent = 0;
 	     parents;
 	     parents = parents->next, num_parent++)
-		hashcpy((unsigned char*)(parent + num_parent),
+		hashcpy((unsigned char *)(parent + num_parent),
 			parents->item->object.sha1);
 	diff_tree_combined(sha1, parent, num_parent, dense, rev);
 }
diff --git a/compat/mingw.c b/compat/mingw.c
index 2a04701..cdeda1d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -562,7 +562,7 @@ static char **get_path_split(void)
 	if (!n)
 		return NULL;
 
-	path = xmalloc((n+1)*sizeof(char*));
+	path = xmalloc((n+1)*sizeof(char *));
 	p = envpath;
 	i = 0;
 	do {
diff --git a/config.c b/config.c
index f76a783..1682273 100644
--- a/config.c
+++ b/config.c
@@ -724,16 +724,16 @@ int git_config(config_fn_t fn, void *data)
 
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
@@ -741,7 +741,7 @@ static int matches(const char* key, const char* value)
 		  !regexec(store.value_regex, value, 0, NULL, 0)));
 }
 
-static int store_aux(const char* key, const char* value, void *cb)
+static int store_aux(const char *key, const char *value, void *cb)
 {
 	const char *ep;
 	size_t section_len;
@@ -810,7 +810,7 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char* key)
+static int store_write_section(int fd, const char *key)
 {
 	const char *dot;
 	int i, success;
@@ -835,7 +835,7 @@ static int store_write_section(int fd, const char* key)
 	return success;
 }
 
-static int store_write_pair(int fd, const char* key, const char* value)
+static int store_write_pair(int fd, const char *key, const char *value)
 {
 	int i, success;
 	int length = strlen(key + store.baselen + 1);
@@ -883,8 +883,8 @@ static int store_write_pair(int fd, const char* key, const char* value)
 	return success;
 }
 
-static ssize_t find_beginning_of_line(const char* contents, size_t size,
-	size_t offset_, int* found_bracket)
+static ssize_t find_beginning_of_line(const char *contents, size_t size,
+	size_t offset_, int *found_bracket)
 {
 	size_t equal_offset = size, bracket_offset = size;
 	ssize_t offset;
@@ -909,7 +909,7 @@ contline:
 	return offset;
 }
 
-int git_config_set(const char* key, const char* value)
+int git_config_set(const char *key, const char *value)
 {
 	return git_config_set_multivar(key, value, NULL, 0);
 }
@@ -937,15 +937,15 @@ int git_config_set(const char* key, const char* value)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar(const char* key, const char* value,
-	const char* value_regex, int multi_replace)
+int git_config_set_multivar(const char *key, const char *value,
+	const char *value_regex, int multi_replace)
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
@@ -1026,13 +1026,13 @@ int git_config_set_multivar(const char* key, const char* value,
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
 
diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index 90e7900..f3b57bf 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -59,7 +59,7 @@ static void convert_ascii_sha1(void *buffer)
 	struct entry *entry;
 
 	if (get_sha1_hex(buffer, sha1))
-		die("expected sha1, got '%s'", (char*) buffer);
+		die("expected sha1, got '%s'", (char *) buffer);
 	entry = convert_entry(sha1);
 	memcpy(buffer, sha1_to_hex(entry->new_sha1), 40);
 }
@@ -100,7 +100,7 @@ static int write_subdirectory(void *buffer, unsigned long size, const char *base
 		if (!slash) {
 			newlen += sprintf(new + newlen, "%o %s", mode, path);
 			new[newlen++] = '\0';
-			hashcpy((unsigned char*)new + newlen, (unsigned char *) buffer + len - 20);
+			hashcpy((unsigned char *)new + newlen, (unsigned char *) buffer + len - 20);
 			newlen += 20;
 
 			used += len;
@@ -271,7 +271,7 @@ static void convert_commit(void *buffer, unsigned long size, unsigned char *resu
 	unsigned long orig_size = size;
 
 	if (memcmp(buffer, "tree ", 5))
-		die("Bad commit '%s'", (char*) buffer);
+		die("Bad commit '%s'", (char *) buffer);
 	convert_ascii_sha1((char *) buffer + 5);
 	buffer = (char *) buffer + 46;    /* "tree " + "hex sha1" + "\n" */
 	while (!memcmp(buffer, "parent ", 7)) {
diff --git a/diff-no-index.c b/diff-no-index.c
index 42c1dd8..4ebc1db 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -233,7 +233,7 @@ void diff_no_index(struct rev_info *revs,
 	if (prefix) {
 		int len = strlen(prefix);
 
-		revs->diffopt.paths = xcalloc(2, sizeof(char*));
+		revs->diffopt.paths = xcalloc(2, sizeof(char *));
 		for (i = 0; i < 2; i++) {
 			const char *p = argv[argc - 2 + i];
 			/*
diff --git a/diff.c b/diff.c
index 3ac7168..78140e7 100644
--- a/diff.c
+++ b/diff.c
@@ -876,7 +876,7 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-static void show_stats(struct diffstat_t* data, struct diff_options *options)
+static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
 	int max_change = 0, max_len = 0;
@@ -1025,7 +1025,7 @@ static void show_shortstats(struct diffstat_t* data, struct diff_options *option
 	       total_files, adds, dels);
 }
 
-static void show_numstat(struct diffstat_t* data, struct diff_options *options)
+static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 {
 	int i;
 
diff --git a/dir.c b/dir.c
index c91ebfb..15677da 100644
--- a/dir.c
+++ b/dir.c
@@ -156,7 +156,7 @@ void add_exclude(const char *string, const char *base,
 	if (len && string[len - 1] == '/') {
 		char *s;
 		x = xmalloc(sizeof(*x) + len);
-		s = (char*)(x+1);
+		s = (char *)(x+1);
 		memcpy(s, string, len - 1);
 		s[len - 1] = '\0';
 		string = s;
diff --git a/fast-import.c b/fast-import.c
index 8d959af..e9d23ff 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -212,7 +212,7 @@ struct tree_content;
 struct tree_entry
 {
 	struct tree_content *tree;
-	struct atom_str* name;
+	struct atom_str *name;
 	struct tree_entry_ms
 	{
 		uint16_t mode;
@@ -313,7 +313,7 @@ static unsigned int object_entry_alloc = 5000;
 static struct object_entry_pool *blocks;
 static struct object_entry *object_table[1 << 16];
 static struct mark_set *marks;
-static const char* mark_file;
+static const char *mark_file;
 
 /* Our last blob */
 static struct last_object last_blob = { STRBUF_INIT, 0, 0, 0 };
@@ -672,7 +672,7 @@ static struct branch *lookup_branch(const char *name)
 static struct branch *new_branch(const char *name)
 {
 	unsigned int hc = hc_str(name, strlen(name)) % branch_table_sz;
-	struct branch* b = lookup_branch(name);
+	struct branch *b = lookup_branch(name);
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
@@ -1035,7 +1035,7 @@ static int store_object(
 	git_SHA_CTX c;
 	z_stream s;
 
-	hdrlen = sprintf((char*)hdr,"%s %lu", typename(type),
+	hdrlen = sprintf((char *)hdr,"%s %lu", typename(type),
 		(unsigned long)dat->len) + 1;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, hdrlen);
@@ -1217,7 +1217,7 @@ static const char *get_mode(const char *str, uint16_t *modep)
 
 static void load_tree(struct tree_entry *root)
 {
-	unsigned char* sha1 = root->versions[1].sha1;
+	unsigned char *sha1 = root->versions[1].sha1;
 	struct object_entry *myoe;
 	struct tree_content *t;
 	unsigned long size;
@@ -1258,8 +1258,8 @@ static void load_tree(struct tree_entry *root)
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
diff --git a/git.c b/git.c
index cc5aaa7..5a00726 100644
--- a/git.c
+++ b/git.c
@@ -47,7 +47,7 @@ static void commit_pager_choice(void) {
 	}
 }
 
-static int handle_options(const char*** argv, int* argc, int* envchanged)
+static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	int handled = 0;
 
@@ -136,7 +136,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
 	int count, option_count;
-	const char** new_argv;
+	const char **new_argv;
 	const char *alias_command;
 	char *alias_string;
 	int unused_nongit;
@@ -187,10 +187,10 @@ static int handle_alias(int *argcp, const char ***argv)
 				  "trace: alias expansion: %s =>",
 				  alias_command);
 
-		new_argv = xrealloc(new_argv, sizeof(char*) *
+		new_argv = xrealloc(new_argv, sizeof(char *) *
 				    (count + *argcp + 1));
 		/* insert after command name */
-		memcpy(new_argv + count, *argv + 1, sizeof(char*) * *argcp);
+		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
 		new_argv[count+*argcp] = NULL;
 
 		*argv = new_argv;
diff --git a/lockfile.c b/lockfile.c
index 3dbb2d1..828d19f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -109,7 +109,7 @@ static char *resolve_symlink(char *p, size_t s)
 			 * link is a relative path, so I must replace the
 			 * last element of p with it.
 			 */
-			char *r = (char*)last_path_elm(p);
+			char *r = (char *)last_path_elm(p);
 			if (r - p + link_len < s)
 				strcpy(r, link);
 			else {
diff --git a/reflog-walk.c b/reflog-walk.c
index fd065f4..5623ea6 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -241,7 +241,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	commit->object.flags &= ~(ADDED | SEEN | SHOWN);
 }
 
-void show_reflog_message(struct reflog_walk_info* info, int oneline,
+void show_reflog_message(struct reflog_walk_info *info, int oneline,
 	enum date_mode dmode)
 {
 	if (info && info->last_commit_reflog) {
diff --git a/run-command.c b/run-command.c
index b05c734..eb2efc3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -106,7 +106,7 @@ int start_command(struct child_process *cmd)
 		if (cmd->env) {
 			for (; *cmd->env; cmd->env++) {
 				if (strchr(*cmd->env, '='))
-					putenv((char*)*cmd->env);
+					putenv((char *)*cmd->env);
 				else
 					unsetenv(*cmd->env);
 			}
diff --git a/server-info.c b/server-info.c
index 66b0d9d..906ce5b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -132,8 +132,8 @@ static int read_pack_info_file(const char *infofile)
 
 static int compare_info(const void *a_, const void *b_)
 {
-	struct pack_info * const* a = a_;
-	struct pack_info * const* b = b_;
+	struct pack_info *const *a = a_;
+	struct pack_info *const *b = b_;
 
 	if (0 <= (*a)->old_num && 0 <= (*b)->old_num)
 		/* Keep the order in the original */
diff --git a/sha1_file.c b/sha1_file.c
index f708cf4..28bd908 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -791,7 +791,7 @@ static int in_window(struct pack_window *win, off_t offset)
 		&& (offset + 20) <= (win_off + win->len);
 }
 
-unsigned char* use_pack(struct packed_git *p,
+unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
 		unsigned int *left)
diff --git a/wt-status.c b/wt-status.c
index 929b00f..1b6df45 100644
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
1.6.3.rc3.13.g195b.dirty
