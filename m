Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D9EC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 02:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLPC3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 21:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLPC3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 21:29:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66B3FB81
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 18:29:28 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso804476wmp.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 18:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y0xxIbki4fUSYWLgFioYUZtKL6C/DFoz1YfjMNxDbOg=;
        b=RtRBc8HifF/b1wHIP2fexQBggdTDpr3hANOLWP6+q7XA6Dxoq6rI++eVZ6hLtrShiE
         g2rM8+x7lQxyoIKEvpH6I2d13RJ2qOs80/r6kQodWy7MRLfOYVaRRQpKYUJdvC8bnfa0
         xLG4Cvf6kORzBKWnqyDeqAd6YbMvUZ9MXbdyU+0tx3eDjI6UfPMhKo7OQKERaUq/7rOV
         Mlp9gTmZxVLJH0jJutp0HBXRT21rt1wlT+arx4bdCjQt/vlnroh3XYll3GJRLwPc67Iz
         ZhrhovnzXVZEeTHGJ8ss1/C/a3Ml0++JFCIbBwXEK/UlxqjFpBI2mM9uR731sP3ktprR
         ClhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0xxIbki4fUSYWLgFioYUZtKL6C/DFoz1YfjMNxDbOg=;
        b=FBzV8LQa1LCGv+Myu7Rh9oPVJWDBt/2zUAdYTaldzly6+BAI1mvnOw39LONNqcJ2Sm
         MhWip53JUO7CKkhpx2bRO+GEKrMT+sqiYCsaWWULmjLBOzYHOsp4z9h6m0Hjemt/Gf0q
         J5d4EP2arYD/d7c4/ejiRGJmCnpl9fBoK6XuS3pHOSrWbZJrHQFXr/rdldQziTinEgL3
         X7/SAQkN5HQdvchXlxevTbo7AowIwZcdx6xEBJWLM1nRKyTQodEV+HTaA3aVPNiXmdxQ
         izsRVCsMzxvxKCMSZ6zO5p8vaq9CWQq1lZZB38tl+SkC8rVm97v0B/dDb/UXbF23ZkhN
         hzag==
X-Gm-Message-State: ANoB5pn3cx2ksTGIECvqlWhSEAlG62rGH0OnakkeLwtl4Z+dMNztm3Y1
        7ftKGCOjljONGQewxObN87T0DGtBkZg=
X-Google-Smtp-Source: AA0mqf63/on/QiZdCu2bf78+bEgPviYTIJIb3N4DV0rtShhUJd+8FVhCt2SSmGfHhlfR3p8NTnp4SA==
X-Received: by 2002:a05:600c:a52:b0:3d1:c8c8:fb5 with SMTP id c18-20020a05600c0a5200b003d1c8c80fb5mr24853357wmq.18.1671157767094;
        Thu, 15 Dec 2022 18:29:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b003cf71b1f66csm1037909wms.0.2022.12.15.18.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 18:29:26 -0800 (PST)
Message-Id: <pull.1399.git.git.1671157765711.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 02:29:25 +0000
Subject: [PATCH] git: edit variable types to match what is assigned to them
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
back from int to size_t.

Not to mention, this is poor logic,
and needless truncations can add
extra unneeded instructions.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: edit variable types to match what is assigned to them
    
    There are many places where "int len = strlen(foo);" is written, just
    for len to be passed as a parameter of size_t. This causes truncation
    and then expansion back from int to size_t. Not to mention this is poor
    logic and needless truncations can add extra unneeded instructions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1399%2FAtariDreams%2Ffix-type-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1399/AtariDreams/fix-type-v1
Pull-Request: https://github.com/git/git/pull/1399

 add-interactive.c |  2 +-
 apply.c           | 16 ++++++++--------
 base85.c          | 11 ++++++-----
 cache.h           | 13 ++++++++-----
 color.c           | 30 +++++++++++++++--------------
 color.h           |  2 +-
 column.c          |  7 ++++---
 diff.c            |  4 ++--
 read-cache.c      | 49 +++++++++++++++++++++++++----------------------
 9 files changed, 72 insertions(+), 62 deletions(-)

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
diff --git a/diff.c b/diff.c
index 1054a4b7329..5bcfce125e2 100644
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

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
