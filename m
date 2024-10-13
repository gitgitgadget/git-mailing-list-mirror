Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0D2AF1E
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728820728; cv=none; b=N8moP50/XT+dQgx+LFeOH7jlBDQSo2RE+DHPiMiKY3AOWrJMxDe9ZY0bN038UnoaXwVSswwY5ZE+i3buw10co1nUlMXvbwNgtUvE5EqT9UitjynsgiRl4YKn0mU3ZRvY7xtuuaPHMfNnkUXw+VbX6YO/0QoLBk/mVxD2HxtXFic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728820728; c=relaxed/simple;
	bh=6KNZ1sbQVBNQvJ3oC6PpebSrJLB+WLpyDz6Id0W1t6I=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dgHkfsNnk5BxBWX8gHugmk7vuHm6+RwmT/Z51FTkIsCjP0WpNsNlM3wEKyn8Om2fG9mFfjjS9nIpVa0LRkKQvR1hqi6NNzoTQGvGO7g1djIh17Y6VXgHlbO2WzhdbOtzkHUNbCzw2jEzj3ndi6RlhbQ2paR0k/wX936bcJ5W4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWqhg1dR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWqhg1dR"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso560782266b.3
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728820724; x=1729425524; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pOcmYroS6yXcZr3yElWEjr2epUPcYWOr/MXKvyapBdo=;
        b=CWqhg1dRbPKK5nx6mJfMdyGNw7ojfiX5l0jbLrbKv+YKo/miU78mErRPAl/82T4SIb
         QStj1ZpijKBQR/FUufrsEbINwLpyjc9Z0XZrPczXeetA/D3PbpLOy5qDILZG0Hg1YLnS
         b33TvxX1hpYxnT8k6zS7GeVXiwjd7iaUCzG4pVv0SGr9dvwOSAqGZ77p5BUFTL+hrcGh
         ZaFdjRV2VFt6nEtUCePrJcM0B0y08+cvJbBoKTweGqG0lZwOiOP+0I51hQ5/lQ8p5GYX
         HSVMWnOrWeULCCZk8ty921jh971jyrym8tYaj7NH6Owq5Qu/gqmMhWa0zA8pnUW9x6mm
         9aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728820724; x=1729425524;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOcmYroS6yXcZr3yElWEjr2epUPcYWOr/MXKvyapBdo=;
        b=gyAoc9n24VBGo5I7Dd9HxGhdCytlUYJn8Sbm/w+DqF2RKecSO2PQE+nPC9O2oQ5hhD
         437d49DaMyK4HeAI46N0mIV3W5jwwkHjy2Ukh/9OjlnUgPF9ThexYrKUtqZLkn8I3y8B
         QgjaGmbqSVoL2gjg9ZRXlEaMVH9qxGuCx94VWKaTBqZdPi4CnN9iykBUoizfc9ZNoQlo
         PHwGlFQmwgojx2lpO7bzZzqur8vgaunyOKuunyredSoivub/g6/4holTKoi+epUG96SO
         IB4x+ygT/vy4zabocFvHfiJPxhyjYseU33IYdOtbV5kkFoIg9KcUPcIXlb1xqTKoqjy5
         81ow==
X-Gm-Message-State: AOJu0Yybe0NaUp7Ax5UEJslunvhn7PlCTm4z65O2JUGrWrcJ/A7sblLt
	mvdERLbPm2t4qeZW/aDX3o/wBot+TxHzO9tHxmpnWxIzIY/ELcPM4R6O8Q==
X-Google-Smtp-Source: AGHT+IHgd/NZAkr1e23B1tsElbGg7jh4J/vf9Dv44ElmYHpjhn6TEt9q3mujrxkGY2KhXr1t/IfR2w==
X-Received: by 2002:a17:907:e203:b0:a99:5881:c6a0 with SMTP id a640c23a62f3a-a99e3cf8dbemr410099166b.36.1728820723686;
        Sun, 13 Oct 2024 04:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0d50a005sm14586866b.132.2024.10.13.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 04:58:43 -0700 (PDT)
Message-Id: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Oct 2024 11:58:42 +0000
Subject: [PATCH] trailer: spread usage of "trailer_block" language
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Deprecate the "trailer_info" struct name and replace it with
"trailer_block". This is more readable, for two reasons:

  1. "trailer_info" on the surface sounds like it's about a single
     trailer when in reality it is a collection of one or more trailers,
     and

  2. the "*_block" suffix is more informative than "*_info", because it
     describes a block (or region) of contiguous text which has trailers
     in it, which has been parsed into the trailer_block structure.

Rename the

    size_t trailer_block_start, trailer_block_end;

members of trailer_info to just "start" and "end". Rename the "info"
pointer to "trailer_block" because it is more descriptive. Update
comments accordingly.

Signed-off-by: Linus Arver <linus@ucla.edu>
---
    trailer: spread usage of "trailer_block" language

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1811%2Flistx%2Ftrailer-cleanup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1811/listx/trailer-cleanup-v1
Pull-Request: https://github.com/git/git/pull/1811

 builtin/interpret-trailers.c | 25 +++++-----
 trailer.c                    | 95 ++++++++++++++++++------------------
 trailer.h                    | 30 ++++++------
 3 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index c5e56e2cd3d..44d8ccddc9d 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,8 +141,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info;
+	struct strbuf trailer_block_sb = STRBUF_INIT;
+	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -152,13 +152,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	info = parse_trailers(opts, sb.buf, &head);
+	trailer_block = parse_trailers(opts, sb.buf, &head);
 
-	/* Print the lines before the trailers */
+	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
+		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
 
-	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
+	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
 		fprintf(outfile, "\n");
 
 
@@ -172,15 +172,16 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block);
+	format_trailers(opts, &head, &trailer_block_sb);
 	free_trailers(&head);
-	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
-	strbuf_release(&trailer_block);
+	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
+	strbuf_release(&trailer_block_sb);
 
-	/* Print the lines after the trailers as is */
+	/* Print the lines after the trailer block as is. */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
-	trailer_info_release(info);
+		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
+		       sb.len - trailer_block_end(trailer_block), outfile);
+	trailer_block_release(trailer_block);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 682d74505bf..59affa2159b 100644
--- a/trailer.c
+++ b/trailer.c
@@ -13,19 +13,20 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-struct trailer_info {
+struct trailer_block {
 	/*
 	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
+	 * "start".
 	 */
 	int blank_line_before_trailer;
 
 	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
+	 * The locations of the start and end positions of the trailer block
+	 * found, as offsets from the beginning of the source text from which
+	 * this trailer block was parsed. If no trailer block is found, these
+	 * are both set to 0.
 	 */
-	size_t trailer_block_start, trailer_block_end;
+	size_t start, end;
 
 	/*
 	 * Array of trailers found.
@@ -975,16 +976,16 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-static struct trailer_info *trailer_info_new(void)
+static struct trailer_block *trailer_block_new(void)
 {
-	struct trailer_info *info = xcalloc(1, sizeof(*info));
-	return info;
+	struct trailer_block *trailer_block = xcalloc(1, sizeof(*trailer_block));
+	return trailer_block;
 }
 
-static struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
-					     const char *str)
+static struct trailer_block *trailer_block_get(const struct process_trailer_options *opts,
+					       const char *str)
 {
-	struct trailer_info *info = trailer_info_new();
+	struct trailer_block *trailer_block = trailer_block_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1017,34 +1018,34 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
 	}
 	strbuf_list_free(trailer_lines);
 
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
+	trailer_block->blank_line_before_trailer = ends_with_blank_line(str,
+									trailer_block_start);
+	trailer_block->start = trailer_block_start;
+	trailer_block->end = end_of_log_message;
+	trailer_block->trailers = trailer_strings;
+	trailer_block->trailer_nr = nr;
 
-	return info;
+	return trailer_block;
 }
 
 /*
- * Parse trailers in "str", populating the trailer info and "trailer_objects"
+ * Parse trailers in "str", populating the trailer_block and "trailer_objects"
  * linked list structure.
  */
-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
-				    const char *str,
-				    struct list_head *trailer_objects)
+struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
+				     const char *str,
+				     struct list_head *trailer_objects)
 {
-	struct trailer_info *info;
+	struct trailer_block *trailer_block;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	info = trailer_info_get(opts, str);
+	trailer_block = trailer_block_get(opts, str);
 
-	for (i = 0; i < info->trailer_nr; i++) {
+	for (i = 0; i < trailer_block->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = info->trailers[i];
+		char *trailer = trailer_block->trailers[i];
 		if (starts_with(trailer, comment_line_str))
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1065,7 +1066,7 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 		}
 	}
 
-	return info;
+	return trailer_block;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1077,28 +1078,28 @@ void free_trailers(struct list_head *trailers)
 	}
 }
 
-size_t trailer_block_start(struct trailer_info *info)
+size_t trailer_block_start(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_start;
+	return trailer_block->start;
 }
 
-size_t trailer_block_end(struct trailer_info *info)
+size_t trailer_block_end(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_end;
+	return trailer_block->end;
 }
 
-int blank_line_before_trailer_block(struct trailer_info *info)
+int blank_line_before_trailer_block(struct trailer_block *trailer_block)
 {
-	return info->blank_line_before_trailer;
+	return trailer_block->blank_line_before_trailer;
 }
 
-void trailer_info_release(struct trailer_info *info)
+void trailer_block_release(struct trailer_block *trailer_block)
 {
 	size_t i;
-	for (i = 0; i < info->trailer_nr; i++)
-		free(info->trailers[i]);
-	free(info->trailers);
-	free(info);
+	for (i = 0; i < trailer_block->trailer_nr; i++)
+		free(trailer_block->trailers[i]);
+	free(trailer_block->trailers);
+	free(trailer_block);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
@@ -1166,19 +1167,19 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(trailer_objects);
-	struct trailer_info *info = parse_trailers(opts, msg, &trailer_objects);
+	struct trailer_block *trailer_block = parse_trailers(opts, msg, &trailer_objects);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
+		strbuf_add(out, msg + trailer_block->start,
+			   trailer_block->end - trailer_block->start);
 	} else
 		format_trailers(opts, &trailer_objects, out);
 
 	free_trailers(&trailer_objects);
-	trailer_info_release(info);
+	trailer_block_release(trailer_block);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
@@ -1187,14 +1188,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	iter->internal.info = trailer_info_get(&opts, msg);
+	iter->internal.trailer_block = trailer_block_get(&opts, msg);
 	iter->internal.cur = 0;
 }
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	if (iter->internal.cur < iter->internal.info->trailer_nr) {
-		char *line = iter->internal.info->trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.trailer_block->trailer_nr) {
+		char *line = iter->internal.trailer_block->trailers[iter->internal.cur++];
 		int separator_pos = find_separator(line, separators);
 
 		iter->raw = line;
@@ -1211,7 +1212,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(iter->internal.info);
+	trailer_block_release(iter->internal.trailer_block);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 6eb53df155e..4740549586a 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,7 +4,7 @@
 #include "list.h"
 #include "strbuf.h"
 
-struct trailer_info;
+struct trailer_block;
 struct strvec;
 
 enum trailer_where {
@@ -72,12 +72,12 @@ void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
 /*
- * Given some input string "str", return a pointer to an opaque trailer_info
+ * Given some input string "str", return a pointer to an opaque trailer_block
  * structure. Also populate the trailer_objects list with parsed trailer
  * objects. Internally this calls trailer_info_get() to get the opaque pointer,
  * but does some extra work to populate the trailer_objects linked list.
  *
- * The opaque trailer_info pointer can be used to check the position of the
+ * The opaque trailer_block pointer can be used to check the position of the
  * trailer block as offsets relative to the beginning of "str" in
  * trailer_block_start() and trailer_block_end().
  * blank_line_before_trailer_block() returns 1 if there is a blank line just
@@ -89,21 +89,21 @@ void process_trailers_lists(struct list_head *head,
  * For iterating through the parsed trailer block (if you don't care about the
  * position of the trailer block itself in the context of the larger string text
  * from which it was parsed), please see trailer_iterator_init() which uses the
- * trailer_info struct internally.
+ * trailer_block struct internally.
  *
  * Lastly, callers should call trailer_info_release() when they are done using
  * the opaque pointer.
  *
- * NOTE: Callers should treat both trailer_info and trailer_objects as
- * read-only items, because there is some overlap between the two (trailer_info
+ * NOTE: Callers should treat both trailer_block and trailer_objects as
+ * read-only items, because there is some overlap between the two (trailer_block
  * has "char **trailers" string array, and trailer_objects will have the same
  * data but as a linked list of trailer_item objects). This API does not perform
  * any synchronization between the two. In the future we should be able to
  * reduce the duplication and use just the linked list.
  */
-struct trailer_info *parse_trailers(const struct process_trailer_options *,
-				    const char *str,
-				    struct list_head *trailer_objects);
+struct trailer_block *parse_trailers(const struct process_trailer_options *,
+				     const char *str,
+				     struct list_head *trailer_objects);
 
 /*
  * Return the offset of the start of the trailer block. That is, 0 is the start
@@ -111,24 +111,24 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *,
  * indicates how many bytes we have to skip over before we get to the beginning
  * of the trailer block.
  */
-size_t trailer_block_start(struct trailer_info *);
+size_t trailer_block_start(struct trailer_block *);
 
 /*
  * Return the end of the trailer block, again relative to the start of the
  * input.
  */
-size_t trailer_block_end(struct trailer_info *);
+size_t trailer_block_end(struct trailer_block *);
 
 /*
  * Return 1 if the trailer block had an extra newline (blank line) just before
  * it.
  */
-int blank_line_before_trailer_block(struct trailer_info *);
+int blank_line_before_trailer_block(struct trailer_block *);
 
 /*
- * Free trailer_info struct.
+ * Free trailer_block struct.
  */
-void trailer_info_release(struct trailer_info *info);
+void trailer_block_release(struct trailer_block *);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *,
@@ -167,7 +167,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info *info;
+		struct trailer_block *trailer_block;
 		size_t cur;
 	} internal;
 };

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
gitgitgadget
