Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6625A63B
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738719764; cv=none; b=iHFXx7R9eeX/4k6QtZwD7mg6eCBS7hyG+4f+wHfKHUp90mj4cGEClrTLHM4bU4gLcPX6Y31sRrXte+OapL+qImdyqUyYu9SKvctHAFuunzJMeWaDCY/Ni9HLpbefiP43xiD1RlEZiI2ZRR09XmD1+QQmLxR9568sJ9t37dBoJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738719764; c=relaxed/simple;
	bh=l+VkGlht0IgXtZfZDZTFOT6rNqQ9L8Le0hP0ZhezGgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XlZrU+Xd3noNpZols1/LAM7YZ6c0Ayt0HjZuDlsEjDvQM+IpWefu17VRHn6xmwP1FSpFKbEA7YeDseXKDYufpisGqca8px34iO8P6lmj2kaBczNIB5SiEAzYmGNUHLoX8jqTsB7FKekovWfgFiaJygjCqei1Hg/wmDuCIovLAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0L4Phi8; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0L4Phi8"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2f9c3ec68c7so1976958a91.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 17:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738719762; x=1739324562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Joiqr8Yr1jmRz9YnpmVttAYse6TfVAa3czkos+O1+8=;
        b=b0L4Phi8Vnz2yNTrQS0uT37XYh8FqA1vYYoS0QHzBtudEUQv7JJvAy4NYEMHNvd/9b
         uNN1yIo3OF/3oKFx3foc3vm9Qh7GtTRI0zYK4kWqNxSjfHolW1up8cBr2Z9urhNHNwrB
         2OXLnhKOw9CLYqWjd6FD2TD/SUr1SI6EtwnvoNhX5rwftbX0Q5y5pHupcaHoFxokYs+a
         7W8mI9Wz21aucQOyQCrYl0nf7P+FlyXbXY1JY8mh10KVXILrp37M3XoVHjGL+quwBnxl
         Z7a0gRNbri4V/Lyn0D7jemq3SZ0im3wYjde4+AGkJ+0TzloJh6CjNqAO+6pMGBldTnY9
         IXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738719762; x=1739324562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Joiqr8Yr1jmRz9YnpmVttAYse6TfVAa3czkos+O1+8=;
        b=nDn3VcK5seEZ0BfE2OqV82CYm9ynw6BC0QSgM9eaYrETPZ8Zb+HiW0MtqLyL6+yTxE
         z7k519HP2QKfkB3Db9Cl/Nsl/9ZgaJYNwqp82cVzrF6c/Q1Z4Vcy5bF2Rx3oi7K5buDx
         ONcFCAyfDU4EMNvC6L/X7XrWAcVPk2n8ci5ykJdsnMd+Zd97Hj4YVl9zch9EcO+v9oCH
         y9Jr/msoH+uzzrx9HMQo7wdPdYNJeKFG9P4oyWltPl1R1SIeZTQ+hPHoVbnESHO3YZ99
         idlj0rayYFt9lIIlV/xjrJhIyNIP2+VvVNb3mtuNDglFRkk9HzpyfEWykFm+hUennC6H
         v4bw==
X-Gm-Message-State: AOJu0Yzx9cxsE6Dv+J9gS5yDK5xnhnP2EzXmPm0yznryprDbHgkrhl2/
	O8qVn5GctvGhn45gG8Diu3VqL+jrNYY3nd76VXdqz99SAGQ3Mfz5JdhFqGoccho9oA4o
X-Gm-Gg: ASbGncuhxVhZUCrVdlUaABuJYNiL/ums7Tn32PuF9PssjttiKr5a0qmzHdb5Hq978wh
	FcBxgR5CGnyMmx3cBjRsX2mpLU7HpMZ/WR1xAgZ9cSx7x5PkJ0rXMvAXSBzpmAQ2P/GXnwhm/Py
	uuT3kCK74bm+InihTi8WD1SAjJx8zAx92hrQuvpPT17yLaYc+EefzHk9zDITne8RJico7jzdpFq
	8NA8O3E1HBBJ0a7t7Un64lA6u0tnRaD8kxFkPRPS1ng8lW2BNghXNpK+TZOaBBQ7F9Tqbt5RT5E
	/J7OY3csAkpyHmetAmSZfkXr4rNXDX4SheZt0jKEYF5V8e/ysgDR/HXdn9EYiq0YkOzB7NOjHo3
	oC4TyOn6Pu1rmrFj2X2svW9sS8XUVN5djtBpx
X-Google-Smtp-Source: AGHT+IGFv6jFq9ZO8fZnmw8nbd5XBPQ/j6MKbWE2i/FuN8YlEMAz7fYyWzfxQWil1aOoxVpYt/xv0g==
X-Received: by 2002:a17:90b:52c7:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2f9e082de10mr1470125a91.31.1738719761937;
        Tue, 04 Feb 2025 17:42:41 -0800 (PST)
Received: from Ubuntu-ROG-Strix-G512LV.. (ec2-43-198-182-209.ap-east-1.compute.amazonaws.com. [43.198.182.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21effe5dd8esm23873465ad.241.2025.02.04.17.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:42:41 -0800 (PST)
From: Zejun Zhao <jelly.zhao.42@gmail.com>
To: git@vger.kernel.org
Cc: Zejun Zhao <jelly.zhao.42@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSOC][PATCH] apply: address -Wsign-comparison warnings
Date: Wed,  5 Feb 2025 01:40:55 +0000
Message-ID: <20250205014055.737190-1-jelly.zhao.42@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several -Wsign-comparison warnings in "apply.c", which can be
classified into the following three types:

  1. comparing a `length` of `size_t` type with a result of pointer
  arithmetic of `int` type

  2. comparing a `length` of `size_t` type with a `length` of `int` type

  3. comparing a loop count `i` of `int` type with an unsigned loop
  bound

Fix these warnings following one basic principle: do not touch the
relevant logics and keep the behaviors of the code. Adopt three
different strategies for each of the above three types:

  1. cast the result of pointer arithmetic to `size_t` type

  2. try to change the type of the `length` to `size_t` (may fall back
  to Strategy 1 if the variable is not guaranteed to be unsigned)

  3. use a loop count `i` of `size_t` type

Signed-off-by: Zejun Zhao <jelly.zhao.42@gmail.com>
---
 apply.c | 73 +++++++++++++++++++++++++++------------------------------
 apply.h |  6 ++---
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/apply.c b/apply.c
index 4a7b6120ac..0c7b89dc3a 100644
--- a/apply.c
+++ b/apply.c
@@ -8,7 +8,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -540,7 +539,7 @@ static size_t date_len(const char *line, size_t len)
 	    !isdigit(*p++) || !isdigit(*p++))	/* Not a date. */
 		return 0;
 
-	if (date - line >= strlen("19") &&
+	if ((size_t) (date - line) >= strlen("19") &&
 	    isdigit(date[-1]) && isdigit(date[-2]))	/* 4-digit year */
 		date -= strlen("19");
 
@@ -1087,11 +1086,11 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
-	const unsigned hexsz = the_hash_algo->hexsz;
+	size_t len;
+	const size_t hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
-	if (!ptr || ptr[1] != '.' || hexsz < ptr - line)
+	if (!ptr || ptr[1] != '.' || hexsz < (size_t) (ptr - line))
 		return 0;
 	len = ptr - line;
 	memcpy(patch->old_oid_prefix, line, len);
@@ -1158,7 +1157,7 @@ static const char *skip_tree_prefix(int p_value,
  */
 static char *git_header_name(int p_value,
 			     const char *line,
-			     int llen)
+			     size_t llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1207,7 +1206,7 @@ static char *git_header_name(int p_value,
 		cp = skip_tree_prefix(p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
-		if (line + llen - cp != first.len ||
+		if ((size_t) (line + llen - cp) != first.len ||
 		    memcmp(first.buf, cp, first.len))
 			goto free_and_fail1;
 		return strbuf_detach(&first, NULL);
@@ -1240,7 +1239,7 @@ static char *git_header_name(int p_value,
 				goto free_and_fail2;
 
 			len = sp.buf + sp.len - np;
-			if (len < second - name &&
+			if (len < (size_t) (second - name) &&
 			    !strncmp(np, name, len) &&
 			    isspace(name[len])) {
 				/* Good */
@@ -1317,7 +1316,7 @@ int parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
-			  int len,
+			  size_t len,
 			  unsigned int size,
 			  struct patch *patch)
 {
@@ -1371,14 +1370,13 @@ int parse_git_diff_header(struct strbuf *root,
 			{ "index ", gitdiff_index },
 			{ "", gitdiff_unrecognized },
 		};
-		int i;
 
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			break;
-		for (i = 0; i < ARRAY_SIZE(optable); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
-			int oplen = strlen(p->str);
+			size_t oplen = strlen(p->str);
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
@@ -1592,7 +1590,7 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
+			if ((size_t) git_hdr_len <= len)
 				continue;
 			*hdrsize = git_hdr_len;
 			return offset;
@@ -2097,7 +2095,6 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2107,7 +2104,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	}
 
 	/* See if it matches any of exclude/include rule */
-	for (i = 0; i < state->limit_by_name.nr; i++) {
+	for (size_t i = 0; i < state->limit_by_name.nr; i++) {
 		struct string_list_item *it = &state->limit_by_name.items[i];
 		if (!wildmatch(it->string, pathname, 0))
 			return (it->util != NULL);
@@ -2185,7 +2182,7 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 			};
 			int i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
@@ -2238,7 +2235,8 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 {
 	struct strbuf qname = STRBUF_INIT;
 	char *cp = patch->new_name ? patch->new_name : patch->old_name;
-	int max, add, del;
+	size_t max;
+	int add, del;
 
 	quote_c_style(cp, &qname, NULL, 0);
 
@@ -2257,12 +2255,12 @@ static void show_stats(struct apply_state *state, struct patch *patch)
 	}
 
 	if (patch->is_binary) {
-		printf(" %-*s |  Bin\n", max, qname.buf);
+		printf(" %-*s |  Bin\n", (int) max, qname.buf);
 		strbuf_release(&qname);
 		return;
 	}
 
-	printf(" %-*s |", max, qname.buf);
+	printf(" %-*s |", (int) max, qname.buf);
 	strbuf_release(&qname);
 
 	/*
@@ -2319,7 +2317,7 @@ static void update_pre_post_images(struct image *preimage,
 {
 	struct image fixed_preimage = IMAGE_INIT;
 	size_t insert_pos = 0;
-	int i, ctx, reduced;
+	size_t ctx, reduced;
 	const char *fixed;
 
 	/*
@@ -2328,7 +2326,7 @@ static void update_pre_post_images(struct image *preimage,
 	 * free "oldlines".
 	 */
 	image_prepare(&fixed_preimage, buf, len, 1);
-	for (i = 0; i < fixed_preimage.line_nr; i++)
+	for (size_t i = 0; i < fixed_preimage.line_nr; i++)
 		fixed_preimage.line[i].flag = preimage->line[i].flag;
 	image_clear(preimage);
 	*preimage = fixed_preimage;
@@ -2337,7 +2335,7 @@ static void update_pre_post_images(struct image *preimage,
 	/*
 	 * Adjust the common context lines in postimage.
 	 */
-	for (i = reduced = ctx = 0; i < postimage->line_nr; i++) {
+	for (size_t i = reduced = ctx = 0; i < postimage->line_nr; i++) {
 		size_t l_len = postimage->line[i].len;
 
 		if (!(postimage->line[i].flag & LINE_COMMON)) {
@@ -2417,9 +2415,9 @@ static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *postimage,
 				    unsigned long current,
 				    int current_lno,
-				    int preimage_limit)
+				    size_t preimage_limit)
 {
-	int i;
+	size_t i;
 	size_t imgoff = 0;
 	size_t preoff = 0;
 	size_t extra_chars;
@@ -2486,12 +2484,12 @@ static int match_fragment(struct apply_state *state,
 			  unsigned ws_rule,
 			  int match_beginning, int match_end)
 {
-	int i;
+	size_t i;
 	const char *orig, *target;
 	struct strbuf fixed = STRBUF_INIT;
 	char *fixed_buf;
 	size_t fixed_len;
-	int preimage_limit;
+	size_t preimage_limit;
 	int ret;
 
 	if (preimage->line_nr + current_lno <= img->line_nr) {
@@ -2663,12 +2661,11 @@ static int match_fragment(struct apply_state *state,
 	for ( ; i < preimage->line_nr; i++) {
 		size_t fixstart = fixed.len; /* start of the fixed preimage */
 		size_t oldlen = preimage->line[i].len;
-		int j;
 
 		/* Try fixing the line in the preimage */
 		ws_fix_copy(&fixed, orig, oldlen, ws_rule, NULL);
 
-		for (j = fixstart; j < fixed.len; j++) {
+		for (size_t j = fixstart; j < fixed.len; j++) {
 			if (!isspace(fixed.buf[j])) {
 				ret = 0;
 				goto out;
@@ -2705,7 +2702,7 @@ static int find_pos(struct apply_state *state,
 {
 	int i;
 	unsigned long backwards, forwards, current;
-	int backwards_lno, forwards_lno, current_lno;
+	size_t backwards_lno, forwards_lno, current_lno;
 
 	/*
 	 * When running with --allow-overlap, it is possible that a hunk is
@@ -2790,7 +2787,7 @@ static int find_pos(struct apply_state *state,
  */
 static void update_image(struct apply_state *state,
 			 struct image *img,
-			 int applied_pos,
+			 size_t applied_pos,
 			 struct image *preimage,
 			 struct image *postimage)
 {
@@ -2798,11 +2795,11 @@ static void update_image(struct apply_state *state,
 	 * remove the copy of preimage at offset in img
 	 * and replace it with postimage
 	 */
-	int i, nr;
+	int nr;
 	size_t remove_count, insert_count, applied_at = 0;
 	size_t result_alloc;
 	char *result;
-	int preimage_limit;
+	size_t preimage_limit;
 
 	/*
 	 * If we are removing blank lines at the end of img,
@@ -2817,11 +2814,11 @@ static void update_image(struct apply_state *state,
 	if (preimage_limit > img->line_nr - applied_pos)
 		preimage_limit = img->line_nr - applied_pos;
 
-	for (i = 0; i < applied_pos; i++)
+	for (size_t i = 0; i < applied_pos; i++)
 		applied_at += img->line[i].len;
 
 	remove_count = 0;
-	for (i = 0; i < preimage_limit; i++)
+	for (size_t i = 0; i < preimage_limit; i++)
 		remove_count += img->line[applied_pos + i].len;
 	insert_count = postimage->buf.len;
 
@@ -2850,7 +2847,7 @@ static void update_image(struct apply_state *state,
 			   img->line_nr - (applied_pos + preimage_limit));
 	COPY_ARRAY(img->line + applied_pos, postimage->line, postimage->line_nr);
 	if (!state->allow_overlap)
-		for (i = 0; i < postimage->line_nr; i++)
+		for (size_t i = 0; i < postimage->line_nr; i++)
 			img->line[applied_pos + i].flag |= LINE_PATCHED;
 	img->line_nr = nr;
 }
@@ -4287,19 +4284,19 @@ static void summary_patch_list(struct patch *patch)
 
 static void patch_stats(struct apply_state *state, struct patch *patch)
 {
-	int lines = patch->lines_added + patch->lines_deleted;
+	unsigned lines = patch->lines_added + patch->lines_deleted;
 
 	if (lines > state->max_change)
 		state->max_change = lines;
 	if (patch->old_name) {
-		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->old_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->old_name);
 		if (len > state->max_len)
 			state->max_len = len;
 	}
 	if (patch->new_name) {
-		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
+		size_t len = quote_c_style(patch->new_name, NULL, NULL, 0);
 		if (!len)
 			len = strlen(patch->new_name);
 		if (len > state->max_len)
diff --git a/apply.h b/apply.h
index 90e887ec0e..f53fbb1777 100644
--- a/apply.h
+++ b/apply.h
@@ -90,8 +90,8 @@ struct apply_state {
 	 * we've seen, and the longest filename. That allows us to do simple
 	 * scaling.
 	 */
-	int max_change;
-	int max_len;
+	unsigned max_change;
+	size_t max_len;
 
 	/*
 	 * Records filenames that have been touched, in order to handle
@@ -170,7 +170,7 @@ int parse_git_diff_header(struct strbuf *root,
 			  int *linenr,
 			  int p_value,
 			  const char *line,
-			  int len,
+			  size_t len,
 			  unsigned int size,
 			  struct patch *patch);
 

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
-- 
2.43.0

