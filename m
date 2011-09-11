From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 1/3] make-static: master
Date: Sun, 11 Sep 2011 14:38:20 -0700
Message-ID: <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2rjd-0004QY-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454Ab1IKVi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:38:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760401Ab1IKViX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 17:38:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F18C4333;
	Sun, 11 Sep 2011 17:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=4Zs/UhhB6OzqNX+lJp4a7w07PFM=; b=dfcT89ysU5zfvESnxIXx
	SYa+bMJs6ZAPmBu+8WcX0zXaENveECnYVDtRC17DQLjZhNXZCxXSLBnPGAfZmvh4
	Qm/gpYEb8f9q8XYouSw+guuYh7wbvcEJAktIjLuXSU6k896h7n7mxNdhT85PNGuA
	OqqDTnNomETXNrKZUI1RyiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=JUpAVTzgzVWPK1wiyX2Ev+N71yf9eZro07lkXTCh1wSD4W
	8L/Auxf1uSmnawQgwSOnf+8rWDcml4jADKUtLxIABpmURxH2RKYDiP+ecEuW/X3A
	Y4QBe80rBeHoPoyktrmLnRa0bICJcLQIQIwt34qqW6Vtj9q+FtHP+5YINz20k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26C2A4332;
	Sun, 11 Sep 2011 17:38:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2372A4327; Sun, 11 Sep 2011
 17:38:22 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F47DE66-DCBE-11E0-83CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181197>

Many symbols that are exported to the global scope do not have to be.

Signed-off-by: Junio C Hamano <junio@pobox.com>
---
 * To be applied on top of 3793ac5 (RelNotes/1.7.7: minor fixes, 2011-09-07)

 builtin.h         |    2 --
 builtin/notes.c   |    4 ++--
 cache.h           |    2 --
 convert.c         |    2 +-
 convert.h         |    1 -
 diff.c            |    2 +-
 diff.h            |    1 -
 dir.c             |    4 ++--
 dir.h             |    2 --
 git-compat-util.h |    5 -----
 graph.c           |   28 ++++++++++++++++++++++++++--
 graph.h           |   29 -----------------------------
 notes.c           |   15 +++++++++++++--
 notes.h           |   14 --------------
 parse-options.c   |    2 +-
 parse-options.h   |    1 -
 rerere.c          |    2 +-
 rerere.h          |    1 -
 sha1-array.c      |    2 +-
 sha1-array.h      |    1 -
 trace.c           |    2 +-
 wrapper.c         |   40 ++++++++++++++++++++--------------------
 22 files changed, 69 insertions(+), 93 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..8f50a3a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,7 +16,6 @@ extern const char git_more_info_string[];
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 int merge_title, int shortlog_len);
-extern void commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
 	struct notes_tree **trees;
@@ -28,7 +27,6 @@ struct notes_rewrite_cfg {
 	int mode_from_env;
 };
 
-combine_notes_fn parse_combine_notes_fn(const char *v);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..34b74ee 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -288,7 +288,7 @@ static int parse_reedit_arg(const struct option *opt, const char *arg, int unset
 	return parse_reuse_arg(opt, arg, unset);
 }
 
-void commit_notes(struct notes_tree *t, const char *msg)
+static void commit_notes(struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char commit_sha1[20];
@@ -312,7 +312,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_release(&buf);
 }
 
-combine_notes_fn parse_combine_notes_fn(const char *v)
+static combine_notes_fn parse_combine_notes_fn(const char *v)
 {
 	if (!strcasecmp(v, "overwrite"))
 		return combine_notes_overwrite;
diff --git a/cache.h b/cache.h
index 607c2ea..e1fc31e 100644
--- a/cache.h
+++ b/cache.h
@@ -709,7 +709,6 @@ int git_mkstemp(char *path, size_t n, const char *template);
 int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
 
 /* set default permissions by passing mode arguments to open(2) */
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
 
 /*
@@ -1147,7 +1146,6 @@ extern void alloc_report(void);
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
-extern void trace_vprintf(const char *key, const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
diff --git a/convert.c b/convert.c
index 3bb5a4d..fc74a6e 100644
--- a/convert.c
+++ b/convert.c
@@ -867,7 +867,7 @@ static struct stream_filter null_filter_singleton = {
 	&null_vtbl,
 };
 
-int is_null_stream_filter(struct stream_filter *filter)
+static int is_null_stream_filter(struct stream_filter *filter)
 {
 	return filter == &null_filter_singleton;
 }
diff --git a/convert.h b/convert.h
index d799a165..3d464eb 100644
--- a/convert.h
+++ b/convert.h
@@ -51,7 +51,6 @@ struct stream_filter; /* opaque */
 
 extern struct stream_filter *get_stream_filter(const char *path, const unsigned char *);
 extern void free_stream_filter(struct stream_filter *);
-extern int is_null_stream_filter(struct stream_filter *);
 
 /*
  * Use as much input up to *isize_p and fill output up to *osize_p;
diff --git a/diff.c b/diff.c
index fcc0078..bd4be32 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
-int diff_use_color_default = -1;
+static int diff_use_color_default = -1;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
diff --git a/diff.h b/diff.h
index 8c66b59..985bed4 100644
--- a/diff.h
+++ b/diff.h
@@ -230,7 +230,6 @@ extern int parse_long_opt(const char *opt, const char **argv,
 
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void *cb);
-extern int diff_use_color_default;
 extern void diff_setup(struct diff_options *);
 extern int diff_opt_parse(struct diff_options *, const char **, int);
 extern int diff_setup_done(struct diff_options *);
diff --git a/dir.c b/dir.c
index 08281d2..ebf1de6 100644
--- a/dir.c
+++ b/dir.c
@@ -19,7 +19,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
 static int get_dtype(struct dirent *de, const char *path, int len);
 
 /* helper string functions with support for the ignore_case flag */
-int strcmp_icase(const char *a, const char *b)
+static int strcmp_icase(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
@@ -29,7 +29,7 @@ int strncmp_icase(const char *a, const char *b, size_t count)
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
 
-int fnmatch_icase(const char *pattern, const char *string, int flags)
+static int fnmatch_icase(const char *pattern, const char *string, int flags)
 {
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
 }
diff --git a/dir.h b/dir.h
index 433b5b4..640b18a 100644
--- a/dir.h
+++ b/dir.h
@@ -106,8 +106,6 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
-extern int strcmp_icase(const char *a, const char *b);
 extern int strncmp_icase(const char *a, const char *b, size_t count);
-extern int fnmatch_icase(const char *pattern, const char *string, int flags);
 
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 5ef8ff7..3b5648d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -330,7 +330,6 @@ extern char *gitmkdtemp(char *);
 
 #ifdef NO_MKSTEMPS
 #define mkstemps gitmkstemps
-extern int gitmkstemps(char *, int);
 #endif
 
 #ifdef NO_UNSETENV
@@ -566,10 +565,6 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  */
 int unlink_or_warn(const char *path);
 /*
- * Likewise for rmdir(2).
- */
-int rmdir_or_warn(const char *path);
-/*
  * Calls the correct function out of {unlink,rmdir}_or_warn based on
  * the supplied file mode.
  */
diff --git a/graph.c b/graph.c
index 7358416..e013289 100644
--- a/graph.c
+++ b/graph.c
@@ -62,7 +62,22 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
-void graph_set_column_colors(const char **colors, unsigned short colors_max)
+/*
+ * Set up a custom scheme for column colors.
+ *
+ * The default column color scheme inserts ANSI color escapes to colorize
+ * the graph. The various color escapes are stored in an array of strings
+ * where each entry corresponds to a color, except for the last entry,
+ * which denotes the escape for resetting the color back to the default.
+ * When generating the graph, strings from this array are inserted before
+ * and after the various column characters.
+ *
+ * This function allows you to enable a custom array of color escapes.
+ * The 'colors_max' argument is the index of the last "reset" entry.
+ *
+ * This functions must be called BEFORE graph_init() is called.
+ */
+static void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
 	column_colors_max = colors_max;
@@ -1113,7 +1128,16 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
-int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+/*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+static int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	switch (graph->state) {
 	case GRAPH_PADDING:
diff --git a/graph.h b/graph.h
index aff960c..5ddbb1a 100644
--- a/graph.h
+++ b/graph.h
@@ -5,23 +5,6 @@
 struct git_graph;
 
 /*
- * Set up a custom scheme for column colors.
- *
- * The default column color scheme inserts ANSI color escapes to colorize
- * the graph. The various color escapes are stored in an array of strings
- * where each entry corresponds to a color, except for the last entry,
- * which denotes the escape for resetting the color back to the default.
- * When generating the graph, strings from this array are inserted before
- * and after the various column characters.
- *
- * This function allows you to enable a custom array of color escapes.
- * The 'colors_max' argument is the index of the last "reset" entry.
- *
- * This functions must be called BEFORE graph_init() is called.
- */
-void graph_set_column_colors(const char **colors, unsigned short colors_max);
-
-/*
  * Create a new struct git_graph.
  */
 struct git_graph *graph_init(struct rev_info *opt);
@@ -50,18 +33,6 @@ void graph_update(struct git_graph *graph, struct commit *commit);
 int graph_is_commit_finished(struct git_graph const *graph);
 
 /*
- * Output the next line for a graph.
- * This formats the next graph line into the specified strbuf.  It is not
- * terminated with a newline.
- *
- * Returns 1 if the line includes the current commit, and 0 otherwise.
- * graph_next_line() will return 1 exactly once for each time
- * graph_update() is called.
- */
-int graph_next_line(struct git_graph *graph, struct strbuf *sb);
-
-
-/*
  * graph_show_*: helper functions for printing to stdout
  */
 
diff --git a/notes.c b/notes.c
index 93e9868..d98243f 100644
--- a/notes.c
+++ b/notes.c
@@ -1196,8 +1196,19 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
-void format_note(struct notes_tree *t, const unsigned char *object_sha1,
-		struct strbuf *sb, const char *output_encoding, int flags)
+
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the given notes_tree structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
+ *
+ * 'flags' is a bitwise combination of the above formatting flags.
+ */
+static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
+			struct strbuf *sb, const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
 	const unsigned char *sha1;
diff --git a/notes.h b/notes.h
index c716694..3592b19 100644
--- a/notes.h
+++ b/notes.h
@@ -241,20 +241,6 @@ void free_notes(struct notes_tree *t);
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
 
-/*
- * Fill the given strbuf with the notes associated with the given object.
- *
- * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
- * If the given notes_tree is NULL, the internal/default notes_tree will be
- * used instead.
- *
- * 'flags' is a bitwise combination of the above formatting flags.
- */
-void format_note(struct notes_tree *t, const unsigned char *object_sha1,
-		struct strbuf *sb, const char *output_encoding, int flags);
-
-
 struct string_list;
 
 struct display_notes_opt {
diff --git a/parse-options.c b/parse-options.c
index 503ab5d..db80155 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,7 +11,7 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-int optbug(const struct option *opt, const char *reason)
+static int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name)
 		return error("BUG: option '%s' %s", opt->long_name, reason);
diff --git a/parse-options.h b/parse-options.h
index 59e0b52..eed93cb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -165,7 +165,6 @@ extern NORETURN void usage_msg_opt(const char *msg,
 				   const char * const *usagestr,
 				   const struct option *options);
 
-extern int optbug(const struct option *opt, const char *reason);
 extern int opterror(const struct option *opt, const char *reason, int flags);
 /*----- incremental advanced APIs -----*/
 
diff --git a/rerere.c b/rerere.c
index dcb525a..a2e36de 100644
--- a/rerere.c
+++ b/rerere.c
@@ -25,7 +25,7 @@ const char *rerere_path(const char *hex, const char *file)
 	return git_path("rr-cache/%s/%s", hex, file);
 }
 
-int has_rerere_resolution(const char *hex)
+static int has_rerere_resolution(const char *hex)
 {
 	struct stat st;
 	return !stat(rerere_path(hex, "postimage"), &st);
diff --git a/rerere.h b/rerere.h
index fcd8bc1..156d2aa 100644
--- a/rerere.h
+++ b/rerere.h
@@ -16,7 +16,6 @@ extern void *RERERE_RESOLVED;
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
-extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
 extern int rerere_remaining(struct string_list *);
 extern void rerere_clear(struct string_list *);
diff --git a/sha1-array.c b/sha1-array.c
index b2f47f9..6f4a224 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -14,7 +14,7 @@ static int void_hashcmp(const void *a, const void *b)
 	return hashcmp(a, b);
 }
 
-void sha1_array_sort(struct sha1_array *array)
+static void sha1_array_sort(struct sha1_array *array)
 {
 	qsort(array->sha1, array->nr, sizeof(*array->sha1), void_hashcmp);
 	array->sorted = 1;
diff --git a/sha1-array.h b/sha1-array.h
index 4499b5d..72bb33b 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -11,7 +11,6 @@ struct sha1_array {
 #define SHA1_ARRAY_INIT { NULL, 0, 0, 0 }
 
 void sha1_array_append(struct sha1_array *array, const unsigned char *sha1);
-void sha1_array_sort(struct sha1_array *array);
 int sha1_array_lookup(struct sha1_array *array, const unsigned char *sha1);
 void sha1_array_clear(struct sha1_array *array);
 
diff --git a/trace.c b/trace.c
index d953416..5ec0e3b 100644
--- a/trace.c
+++ b/trace.c
@@ -62,7 +62,7 @@ static int get_trace_fd(const char *key, int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-void trace_vprintf(const char *key, const char *fmt, va_list ap)
+static void trace_vprintf(const char *key, const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 
diff --git a/wrapper.c b/wrapper.c
index 85f09df..390a7ae 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -236,29 +236,12 @@ int git_mkstemp(char *path, size_t len, const char *template)
 	return mkstemp(path);
 }
 
-/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
-int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
-{
-	const char *tmp;
-	size_t n;
-
-	tmp = getenv("TMPDIR");
-	if (!tmp)
-		tmp = "/tmp";
-	n = snprintf(path, len, "%s/%s", tmp, template);
-	if (len <= n) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
-	return mkstemps(path, suffix_len);
-}
-
 /* Adapted from libiberty's mkstemp.c. */
 
 #undef TMP_MAX
 #define TMP_MAX 16384
 
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
+static int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 {
 	static const char letters[] =
 		"abcdefghijklmnopqrstuvwxyz"
@@ -327,11 +310,28 @@ int git_mkstemp_mode(char *pattern, int mode)
 	return git_mkstemps_mode(pattern, 0, mode);
 }
 
-int gitmkstemps(char *pattern, int suffix_len)
+static int gitmkstemps(char *pattern, int suffix_len)
 {
 	return git_mkstemps_mode(pattern, suffix_len, 0600);
 }
 
+/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
+int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
+{
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return mkstemps(path, suffix_len);
+}
+
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
@@ -372,7 +372,7 @@ int unlink_or_warn(const char *file)
 	return warn_if_unremovable("unlink", file, unlink(file));
 }
 
-int rmdir_or_warn(const char *file)
+static int rmdir_or_warn(const char *file)
 {
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }
-- 
1.7.7.rc0.188.g3793ac
