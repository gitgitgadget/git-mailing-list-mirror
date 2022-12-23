Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511FFC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiLWTrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiLWTq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 14:46:58 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9B630A
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:46:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i7so5372997wrv.8
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBqyluQCnasgA4CMJ71EV3Eb1JFqkoys6Y1qsHAwfwA=;
        b=KBXYhzbapGOYDxPHQF/6ehOHQSSFCBCzMVn1ESyzScHrIZd1CE0s9B2ICKmLknJrjF
         3Pm4FmoxfnanoFkd6arRdoGsZpy1/F7YkpPq9/cmgMMJoZUy932KQq7o+wbXseLXhySh
         q0S/k4GCQOlZAX3WetOee2teodI2A7mWU4lAVcUyRYTtEgn0EDNq2baD6hoHJDarT1b4
         XoPq6/Z4NbwlHHHgI72aDw3m1ORe39KozLBINplMFgxG1jX7R1IBkaWndI9HVt1v7Nkh
         BwFaZZ2QD8+kMT0YepCtgJ3c/EzSJ4i2az0JrNKBtIEaYwyOwuN0VI2jKlcn4eVPpxGI
         FSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBqyluQCnasgA4CMJ71EV3Eb1JFqkoys6Y1qsHAwfwA=;
        b=3xY6Lk/v61yJKl+n6IiYnm+lT1jrViZizjnA9tqiXtYhgmhjOoyV7qj5R/6A2COkp/
         EHrIvCNLIJKsZY2iPMXdImV4VbuvxzbTtVgmcojnralgF5FJLoqfCDn7cQxuuz5YQnwa
         KSghSkEnIOgETecftEZoh68KYPgFFtRXGHO8xwG5IwhvUCSggEQHTTFdIA+SJ3JA6Uyr
         i0qGoHdbct3UtE43X0uiuYUE1AvAHDBHGQ0YAg+E7YssbYF7kpOZdWSKMgMB9gDezMb0
         UqbP61WOgrP11M43LWW6y65vcsaprAIY50JVYrhVuTRYDgZU9qhytS4qY86ok0BAVZ3t
         A+6Q==
X-Gm-Message-State: AFqh2ko+YBJZb+/0cstIMWrJ1ITShLm0PQ7JMZEUiEeYt6Kyd1xXemUD
        5IE0E4t4DeuPvNvSw6T8xE17nf6dNzY=
X-Google-Smtp-Source: AMrXdXuaf7vj7i56kKw44L+v3lbAbEu7qJQxrCiogyqhkAxrClmCVuQdlEHM4VkxHQpkNThmbPtHhw==
X-Received: by 2002:adf:f4c4:0:b0:242:381:c607 with SMTP id h4-20020adff4c4000000b002420381c607mr6617021wrp.15.1671824813587;
        Fri, 23 Dec 2022 11:46:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11-20020adffd8b000000b00236545edc91sm3754251wrr.76.2022.12.23.11.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 11:46:53 -0800 (PST)
Message-Id: <pull.1399.v9.git.git.1671824812030.gitgitgadget@gmail.com>
In-Reply-To: <pull.1399.v8.git.git.1671824586607.gitgitgadget@gmail.com>
References: <pull.1399.v8.git.git.1671824586607.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Dec 2022 19:46:51 +0000
Subject: [PATCH v9] git: edit variable types to match what is assigned to them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

There are many places where "int len = strlen(foo);" is written,
just for len to be passed as a parameter of size_t.

This causes truncation and then expansion
back from int to size_t. This is poor logic.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: edit variable types to match what is assigned to them
    
    There are many places where "int len = strlen(foo);" is written, just
    for len to be passed as a parameter of size_t. This causes truncation
    and then expansion back from int to size_t. Not to mention this is poor
    logic and needless truncations can add extra unneeded instructions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1399%2FAtariDreams%2Ffix-type-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1399/AtariDreams/fix-type-v9
Pull-Request: https://github.com/git/git/pull/1399

Range-diff vs v8:

 1:  6d7410b6878 ! 1:  86aa007e7f2 git: edit variable types to match what is assigned to them
     @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
       				close(pp->children[i].process.err);
       				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
      
     + ## strbuf.c ##
     +@@ strbuf.c: struct strbuf **strbuf_split_buf(const char *str, size_t slen,
     + 	struct strbuf *t;
     + 
     + 	while (slen) {
     +-		int len = slen;
     ++		size_t len = slen;
     + 		if (max <= 0 || nr + 1 < max) {
     + 			const char *end = memchr(str, terminator, slen);
     + 			if (end)
     +
       ## xdiff-interface.c ##
      @@ xdiff-interface.c: static long ff_regexp(const char *line, long len,
       {


 add-interactive.c             |  2 +-
 apply.c                       | 16 ++++++------
 archive-tar.c                 |  8 +++---
 base85.c                      | 11 ++++----
 builtin/add.c                 |  3 ++-
 builtin/merge-file.c          |  3 ++-
 builtin/submodule--helper.c   |  3 ++-
 cache.h                       | 13 ++++++----
 color.c                       | 30 +++++++++++----------
 color.h                       |  2 +-
 column.c                      |  7 ++---
 compat/compiler.h             |  9 ++++---
 diff.c                        |  4 +--
 fsck.c                        |  4 +--
 list-objects-filter-options.c |  2 +-
 merge-recursive.c             |  4 +--
 merge-recursive.h             |  2 +-
 notes.c                       |  2 +-
 range-diff.c                  | 13 +++++-----
 read-cache.c                  | 49 +++++++++++++++++++----------------
 run-command.c                 | 11 ++++----
 strbuf.c                      |  2 +-
 xdiff-interface.c             |  6 ++---
 23 files changed, 111 insertions(+), 95 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index ae1839c04a7..59ac88f8b5a 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -469,7 +469,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < stat.nr; i++) {
 		const char *name = stat.files[i]->name;
-		int hash = strhash(name);
+		unsigned int hash = strhash(name);
 		struct pathname_entry *entry;
 		struct file_item *file_item;
 		struct adddel *adddel, *other_adddel;
diff --git a/apply.c b/apply.c
index bc338143134..ee5dcdb9133 100644
--- a/apply.c
+++ b/apply.c
@@ -443,7 +443,7 @@ static int name_terminate(int c, int terminate)
 /* remove double slashes to make --index work with such filenames */
 static char *squash_slash(char *name)
 {
-	int i = 0, j = 0;
+	size_t i = 0, j = 0;
 
 	if (!name)
 		return NULL;
@@ -654,7 +654,7 @@ static char *find_name_common(struct strbuf *root,
 			      const char *end,
 			      int terminate)
 {
-	int len;
+	size_t len;
 	const char *start = NULL;
 
 	if (p_value == 0)
@@ -685,13 +685,13 @@ static char *find_name_common(struct strbuf *root,
 	 * or "file~").
 	 */
 	if (def) {
-		int deflen = strlen(def);
+		size_t deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
 			return squash_slash(xstrdup(def));
 	}
 
 	if (root->len) {
-		char *ret = xstrfmt("%s%.*s", root->buf, len, start);
+		char *ret = xstrfmt("%s%.*s", root->buf, (int)len, start);
 		return squash_slash(ret);
 	}
 
@@ -790,7 +790,7 @@ static int has_epoch_timestamp(const char *nameline)
 	const char *timestamp = NULL, *cp, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
-	int zoneoffset, epoch_hour, hour, minute;
+	long zoneoffset, epoch_hour, hour, minute;
 	int status;
 
 	for (cp = nameline; *cp != '\n'; cp++) {
@@ -1083,7 +1083,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
+	size_t len;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
@@ -2172,9 +2172,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
+			size_t i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
diff --git a/archive-tar.c b/archive-tar.c
index f8fad2946ef..6d91eb01157 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -352,12 +352,12 @@ static void write_global_extended_header(struct archiver_args *args)
 }
 
 static struct archiver **tar_filters;
-static int nr_tar_filters;
-static int alloc_tar_filters;
+static size_t nr_tar_filters;
+static size_t alloc_tar_filters;
 
 static struct archiver *find_tar_filter(const char *name, size_t len)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < nr_tar_filters; i++) {
 		struct archiver *ar = tar_filters[i];
 		if (!strncmp(ar->name, name, len) && !ar->name[len])
@@ -525,7 +525,7 @@ static struct archiver tar_archiver = {
 
 void init_tar_archiver(void)
 {
-	int i;
+	size_t i;
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
diff --git a/base85.c b/base85.c
index 5ca601ee14f..ad32ba1411a 100644
--- a/base85.c
+++ b/base85.c
@@ -37,14 +37,15 @@ static void prep_base85(void)
 	}
 }
 
-int decode_85(char *dst, const char *buffer, int len)
+int decode_85(char *dst, const char *buffer, size_t len)
 {
 	prep_base85();
 
-	say2("decode 85 <%.*s>", len / 4 * 5, buffer);
+	say2("decode 85 <%.*s>", (int)(len / 4 * 5), buffer);
 	while (len) {
 		unsigned acc = 0;
-		int de, cnt = 4;
+		int de;
+		size_t cnt = 4;
 		unsigned char ch;
 		do {
 			ch = *buffer++;
@@ -76,7 +77,7 @@ int decode_85(char *dst, const char *buffer, int len)
 	return 0;
 }
 
-void encode_85(char *buf, const unsigned char *data, int bytes)
+void encode_85(char *buf, const unsigned char *data, size_t bytes)
 {
 	say("encode 85");
 	while (bytes) {
@@ -90,7 +91,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
 		}
 		say1(" %08x", acc);
 		for (cnt = 4; cnt >= 0; cnt--) {
-			int val = acc % 85;
+			unsigned val = acc % 85;
 			acc /= 85;
 			buf[cnt] = en85[val];
 		}
diff --git a/builtin/add.c b/builtin/add.c
index 2c154cc3479..9981d8b271b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -40,7 +40,8 @@ struct update_callback_data {
 
 static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 
 	for (i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..28b032dadb6 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -29,7 +29,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmfile_t mmfs[3] = { 0 };
 	mmbuffer_t result = { 0 };
 	xmparam_t xmp = { 0 };
-	int ret = 0, i = 0, to_stdout = 0;
+	int ret = 0, to_stdout = 0;
+	unsigned int i = 0;
 	int quiet = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 05f2c9bc985..2fb44987b90 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -186,7 +186,8 @@ static int module_list_compute(const char **argv,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
 {
-	int i, result = 0;
+	unsigned int i;
+	int result = 0;
 	char *ps_matched = NULL;
 
 	parse_pathspec(pathspec, 0,
diff --git a/cache.h b/cache.h
index 07d40b0964b..ccbe88fcca4 100644
--- a/cache.h
+++ b/cache.h
@@ -1609,10 +1609,13 @@ int repo_interpret_branch_name(struct repository *r,
 
 int validate_headref(const char *ref);
 
-int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2);
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2);
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
@@ -1822,8 +1825,8 @@ extern const char *askpass_program;
 extern const char *excludes_file;
 
 /* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
+int decode_85(char *dst, const char *line, size_t linelen);
+void encode_85(char *buf, const unsigned char *data, size_t bytes);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/color.c b/color.c
index f05d8a81d72..81de82b323d 100644
--- a/color.c
+++ b/color.c
@@ -54,7 +54,7 @@ struct color {
  * "word" is a buffer of length "len"; does it match the NUL-terminated
  * "match" exactly?
  */
-static int match_word(const char *word, int len, const char *match)
+static int match_word(const char *word, size_t len, const char *match)
 {
 	return !strncasecmp(word, match, len) && !match[len];
 }
@@ -73,14 +73,14 @@ static int get_hex_color(const char *in, unsigned char *out)
  * If an ANSI color is recognized in "name", fill "out" and return 0.
  * Otherwise, leave out unchanged and return -1.
  */
-static int parse_ansi_color(struct color *out, const char *name, int len)
+static int parse_ansi_color(struct color *out, const char *name, size_t len)
 {
 	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] = {
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
-	int i;
+	unsigned int i;
 	int color_offset = COLOR_FOREGROUND_ANSI;
 
 	if (match_word(name, len, "default")) {
@@ -119,7 +119,7 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 	return -1;
 }
 
-static int parse_color(struct color *out, const char *name, int len)
+static int parse_color(struct color *out, const char *name, size_t len)
 {
 	char *end;
 	long val;
@@ -219,7 +219,8 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, int background)
+static char *color_output(char *out, size_t len, const struct color *c,
+			  int background)
 {
 	int offset = 0;
 
@@ -250,17 +251,17 @@ static int color_empty(const struct color *c)
 	return c->type <= COLOR_NORMAL;
 }
 
-int color_parse_mem(const char *value, int value_len, char *dst)
+int color_parse_mem(const char *value, size_t value_len, char *dst)
 {
 	const char *ptr = value;
-	int len = value_len;
+	size_t len = value_len;
 	char *end = dst + COLOR_MAXLEN;
-	unsigned int has_reset = 0;
+	int has_reset = 0;
 	unsigned int attr = 0;
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
-	while (len > 0 && isspace(*ptr)) {
+	while (len && isspace(*ptr)) {
 		ptr++;
 		len--;
 	}
@@ -271,10 +272,11 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	}
 
 	/* [reset] [fg [bg]] [attr]... */
-	while (len > 0) {
+	while (len) {
 		const char *word = ptr;
 		struct color c = { COLOR_UNSPECIFIED };
-		int val, wordlen = 0;
+		int val;
+		size_t wordlen = 0;
 
 		while (len > 0 && !isspace(word[wordlen])) {
 			wordlen++;
@@ -319,7 +321,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 
 	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
-		int i;
+		unsigned int i;
 
 		OUT('\033');
 		OUT('[');
@@ -334,7 +336,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			attr &= ~bit;
 			if (sep++)
 				OUT(';');
-			dst += xsnprintf(dst, end - dst, "%d", i);
+			dst += xsnprintf(dst, end - dst, "%u", i);
 		}
 		if (!color_empty(&fg)) {
 			if (sep++)
@@ -351,7 +353,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	OUT(0);
 	return 0;
 bad:
-	return error(_("invalid color value: %.*s"), value_len, value);
+	return error(_("invalid color value: %.*s"), (int)value_len, value);
 #undef OUT
 }
 
diff --git a/color.h b/color.h
index cfc8f841b23..35c0cf09d08 100644
--- a/color.h
+++ b/color.h
@@ -119,7 +119,7 @@ int want_color_fd(int fd, int var);
  * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
  */
 int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+int color_parse_mem(const char *value, size_t len, char *dst);
 
 /*
  * Output the formatted string in the specified color (and then reset to normal
diff --git a/column.c b/column.c
index 1261e18a72e..98c32485cc7 100644
--- a/column.c
+++ b/column.c
@@ -32,7 +32,7 @@ static int item_length(const char *s)
  */
 static void layout(struct column_data *data, int *width)
 {
-	int i;
+	size_t i;
 
 	*width = 0;
 	for (i = 0; i < data->list->nr; i++)
@@ -101,7 +101,7 @@ static void shrink_columns(struct column_data *data)
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < list->nr; i++)
 		printf("%s%s%s", indent, list->items[i].string, nl);
@@ -146,7 +146,8 @@ static void display_table(const struct string_list *list,
 			  const struct column_options *opts)
 {
 	struct column_data data;
-	int x, y, i, initial_width;
+	int x, y, initial_width;
+	size_t i;
 	char *empty_cell;
 
 	memset(&data, 0, sizeof(data));
diff --git a/compat/compiler.h b/compat/compiler.h
index 10dbb65937d..33d51f461c9 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -10,7 +10,8 @@
 
 static inline void get_compiler_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
+
 #ifdef __clang__
 	strbuf_addf(info, "clang: %s\n", __clang_version__);
 #elif defined(__GNUC__)
@@ -18,8 +19,8 @@ static inline void get_compiler_info(struct strbuf *info)
 #endif
 
 #ifdef _MSC_VER
-	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
-		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n", _MSC_VER / 100,
+		    _MSC_VER % 100, _MSC_FULL_VER % 100000);
 #endif
 
 	if (len == info->len)
@@ -28,7 +29,7 @@ static inline void get_compiler_info(struct strbuf *info)
 
 static inline void get_libc_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 
 #ifdef __GLIBC__
 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
diff --git a/diff.c b/diff.c
index 4dfe824c858..b2f57b168d9 100644
--- a/diff.c
+++ b/diff.c
@@ -3305,8 +3305,8 @@ static void emit_binary_diff_body(struct diff_options *o,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
-		int len;
-		int bytes = (52 < data_size) ? 52 : data_size;
+		size_t len;
+		size_t bytes = (52 < data_size) ? 52 : data_size;
 		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
diff --git a/fsck.c b/fsck.c
index b3da1d68c0b..c51a4aa3d06 100644
--- a/fsck.c
+++ b/fsck.c
@@ -35,7 +35,7 @@ static struct {
 
 static void prepare_msg_ids(void)
 {
-	int i;
+	size_t i;
 
 	if (msg_id_info[0].downcased)
 		return;
@@ -43,7 +43,7 @@ static void prepare_msg_ids(void)
 	/* convert id_string to lower case, without underscores. */
 	for (i = 0; i < FSCK_MSG_MAX; i++) {
 		const char *p = msg_id_info[i].id_string;
-		int len = strlen(p);
+		size_t len = strlen(p);
 		char *q = xmalloc(len);
 
 		msg_id_info[i].downcased = q;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ee01bcd2cc3..dcb84ee81e9 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -397,7 +397,7 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src)
 {
-	int i;
+	size_t i;
 
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
diff --git a/merge-recursive.c b/merge-recursive.c
index 2fd0aa96875..8ba57b64db2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3805,7 +3805,7 @@ static struct commit *get_ref(struct repository *repo,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result)
 {
@@ -3816,7 +3816,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	struct commit_list *ca = NULL;
 
 	if (merge_bases) {
-		int i;
+		unsigned int i;
 		for (i = 0; i < num_merge_bases; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(opt->repo, merge_bases[i],
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c25..f8d7517dc50 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -118,7 +118,7 @@ int merge_recursive(struct merge_options *opt,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
diff --git a/notes.c b/notes.c
index f2805d51bb1..e800007434f 100644
--- a/notes.c
+++ b/notes.c
@@ -956,7 +956,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 {
 	struct string_list split = STRING_LIST_INIT_NODUP;
 	char *globs_copy = xstrdup(globs);
-	int i;
+	size_t i;
 
 	string_list_split_in_place(&split, globs_copy, ':', -1);
 	string_list_remove_empty_items(&split, 0);
diff --git a/range-diff.c b/range-diff.c
index 8b7d81adc1b..616285181dd 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -18,7 +18,8 @@ struct patch_util {
 	struct hashmap_entry e;
 	const char *diff, *patch;
 
-	int i, shown;
+	size_t i;
+	int shown;
 	int diffsize;
 	size_t diff_offset;
 	/* the index of the matching item in the other branch, or -1 */
@@ -235,7 +236,7 @@ static int patch_util_cmp(const void *cmp_data UNUSED,
 static void find_exact_matches(struct string_list *a, struct string_list *b)
 {
 	struct hashmap map = HASHMAP_INIT((hashmap_cmp_fn)patch_util_cmp, NULL);
-	int i;
+	size_t i;
 
 	/* First, add the patches of a to a hash map */
 	for (i = 0; i < a->nr; i++) {
@@ -404,7 +405,7 @@ static void output_pair_header(struct diff_options *diffopt,
 	if (!a_util)
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
-		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
+		strbuf_addf(buf, "%*zu:  %s ", patch_no_width, a_util->i + 1,
 			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
 
 	if (status == '!')
@@ -416,7 +417,7 @@ static void output_pair_header(struct diff_options *diffopt,
 	if (!b_util)
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
-		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
+		strbuf_addf(buf, " %*zu:  %s", patch_no_width, b_util->i + 1,
 			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
 
 	commit = lookup_commit_reference(the_repository, oid);
@@ -578,7 +579,7 @@ int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
 	const char *argv[] = { "", copy, "--", NULL };
-	int i, positive = 0, negative = 0;
+	unsigned int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
 	init_revisions(&revs, NULL);
@@ -599,5 +600,5 @@ int is_range_diff_range(const char *arg)
 
 	free(copy);
 	release_revisions(&revs);
-	return negative > 0 && positive > 0;
+	return negative != 0 && positive != 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 1ff518b2a7f..8717dc3b56b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -109,7 +109,8 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 
 static const char *alternate_index_output;
 
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void set_index_entry(struct index_state *istate, unsigned int nr,
+			    struct cache_entry *ce)
 {
 	if (S_ISSPARSEDIR(ce->ce_mode))
 		istate->sparse_index = INDEX_COLLAPSED;
@@ -118,7 +119,8 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	add_name_hash(istate, ce);
 }
 
-static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void replace_index_entry(struct index_state *istate, unsigned int nr,
+				struct cache_entry *ce)
 {
 	struct cache_entry *old = istate->cache[nr];
 
@@ -488,11 +490,11 @@ int ie_modified(struct index_state *istate,
 	return 0;
 }
 
-int base_name_compare(const char *name1, int len1, int mode1,
-		      const char *name2, int len2, int mode2)
+int base_name_compare(const char *name1, size_t len1, int mode1,
+		      const char *name2, size_t len2, int mode2)
 {
 	unsigned char c1, c2;
-	int len = len1 < len2 ? len1 : len2;
+	size_t len = len1 < len2 ? len1 : len2;
 	int cmp;
 
 	cmp = memcmp(name1, name2, len);
@@ -517,10 +519,10 @@ int base_name_compare(const char *name1, int len1, int mode1,
  * This is used by routines that want to traverse the git namespace
  * but then handle conflicting entries together when possible.
  */
-int df_name_compare(const char *name1, int len1, int mode1,
-		    const char *name2, int len2, int mode2)
+int df_name_compare(const char *name1, size_t len1, int mode1,
+		    const char *name2, size_t len2, int mode2)
 {
-	int len = len1 < len2 ? len1 : len2, cmp;
+	size_t len = len1 < len2 ? len1 : len2, cmp;
 	unsigned char c1, c2;
 
 	cmp = memcmp(name1, name2, len);
@@ -555,7 +557,8 @@ int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 	return 0;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2)
 {
 	int cmp;
 
@@ -703,7 +706,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 		return pos;
 
 	/* maybe unmerged? */
-	pos = -1 - pos;
+	pos = -pos - 1;
 	if (pos >= istate->cache_nr ||
 			compare_name((ce = istate->cache[pos]), path, namelen))
 		return -1;
@@ -718,7 +721,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 static int different_name(struct cache_entry *ce, struct cache_entry *alias)
 {
-	int len = ce_namelen(ce);
+	unsigned int len = ce_namelen(ce);
 	return ce_namelen(alias) != len || memcmp(ce->name, alias->name, len);
 }
 
@@ -735,7 +738,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 					   struct cache_entry *ce,
 					   struct cache_entry *alias)
 {
-	int len;
+	unsigned int len;
 	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
@@ -902,7 +905,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 				     unsigned int refresh_options)
 {
 	struct cache_entry *ce, *ret;
-	int len;
+	size_t len;
 
 	if (verify_path_internal(path, mode) == PATH_INVALID) {
 		error(_("invalid path '%s'"), path);
@@ -931,7 +934,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce;
-	int len;
+	size_t len;
 
 	if (!verify_path(path, mode)) {
 		error(_("invalid path '%s'"), path);
@@ -982,7 +985,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
 {
-	int len = ce_namelen(a);
+	unsigned int len = ce_namelen(a);
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
@@ -1109,8 +1112,8 @@ static int has_file_name(struct index_state *istate,
 			 const struct cache_entry *ce, int pos, int ok_to_replace)
 {
 	int retval = 0;
-	int len = ce_namelen(ce);
-	int stage = ce_stage(ce);
+	unsigned int len = ce_namelen(ce);
+	unsigned int stage = ce_stage(ce);
 	const char *name = ce->name;
 
 	while (pos < istate->cache_nr) {
@@ -1151,7 +1154,7 @@ int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
 			break;
 
 	*first_change = k;
-	return (unsigned char)s1[k] - (unsigned char)s2[k];
+	return (const unsigned char)s1[k] - (const unsigned char)s2[k];
 }
 
 /*
@@ -1598,7 +1601,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
-	int i;
+	unsigned int i;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
@@ -2762,7 +2765,7 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 	size = offsetof(struct ondisk_cache_entry,data) + ondisk_data_size(ce->ce_flags, 0);
 
 	if (!previous_name) {
-		int len = ce_namelen(ce);
+		unsigned int len = ce_namelen(ce);
 		copy_cache_entry_to_ondisk(ondisk, ce);
 		hashwrite(f, ondisk, size);
 		hashwrite(f, ce->name, len);
@@ -2842,8 +2845,8 @@ static int repo_verify_index(struct repository *repo)
 
 int has_racy_timestamp(struct index_state *istate)
 {
-	int entries = istate->cache_nr;
-	int i;
+	unsigned int entries = istate->cache_nr;
+	unsigned int i;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -3471,7 +3474,7 @@ int repo_read_index_unmerged(struct repository *repo)
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
-		int len;
+		unsigned int len;
 
 		if (!ce_stage(ce))
 			continue;
diff --git a/run-command.c b/run-command.c
index 756f1839aab..511bed961c3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1632,9 +1632,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 			     const struct run_process_parallel_opts *opts,
 			     int output_timeout)
 {
-	int i;
+	size_t i;
 
-	while ((i = poll(pp->pfd, opts->processes, output_timeout) < 0)) {
+	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp, opts);
@@ -1642,11 +1642,12 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	}
 
 	/* Buffer output from all pipes. */
-	for (size_t i = 0; i < opts->processes; i++) {
+	for (i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			ssize_t n = strbuf_read_once(
+				&pp->children[i].err,
+				pp->children[i].process.err, 0);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
diff --git a/strbuf.c b/strbuf.c
index 0890b1405c5..3b500636eb1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -172,7 +172,7 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 	struct strbuf *t;
 
 	while (slen) {
-		int len = slen;
+		size_t len = slen;
 		if (max <= 0 || nr + 1 < max) {
 			const char *end = memchr(str, terminator, slen);
 			if (end)
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e87950de32e..d4bec9905ff 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -210,8 +210,8 @@ static long ff_regexp(const char *line, long len,
 {
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
-	int i;
-	int result;
+	size_t i;
+	long result;
 
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
@@ -244,7 +244,7 @@ static long ff_regexp(const char *line, long len,
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 {
-	int i;
+	size_t i;
 	struct ff_regs *regs;
 
 	xecfg->find_func = ff_regexp;

base-commit: 7c2ef319c52c4997256f5807564523dfd4acdfc7
-- 
gitgitgadget
