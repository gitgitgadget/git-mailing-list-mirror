Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7317E764
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196373; cv=none; b=uiAByUxurnHY6K9bY89rsxMXGMGh0R/EF0IRulL2m0ij5UCEup/3N59xtAoll4/n49lMbG8/nhQ9oBVgJngLpg5hnL68w/EaXpZfYISIXcDbPo7rJlJVQMvnUeMK/ETjhI3Dq7By57LiMUyqCdCwRa1+GxBVlQsArU5OTmtM/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196373; c=relaxed/simple;
	bh=6QL/Sn9w4wAaofC5ZJ/XnQWkFTDIITPXeGJ3bFQXdZU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bc8agJY//xsnj1xs2jmWxunzM5xuMxOPNLFW3MOS2J817rf6GlyTiBg7aeC708FgUuCIFWmuTyi7SpP7nO0MBdhvn8qvp/qXEww6RsjMSHnU7Fm8ImivWgk0/6OsIDczGmV0bC2oa4qZWu10WJyrIFOfr7U7eOadaVguBnRAUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXvGb9ZO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXvGb9ZO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392b045e0aso257120f8f.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196369; x=1707801169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/7iEkelNpOUguRvsEE9eynfw8YnY6LsMa0XK+YcgpE=;
        b=LXvGb9ZOP3A8wVY1Jfk+AVxrGvFzNtzhOUCiBnjzARlmT/m6pMdbNsRyN22Bx+wlA/
         CNisVZRN31buE9TVlWxUbc+nQwTJhQDzK4zROnQvU9YK0TnoyaTbyLTe0cjK0rf4W7r4
         BBi/XZ3WNDaQwngkg+izqE6faEb+OqLuQEWhDJzP33avJC4KkGbwcKABMbn0eLqM1Fx8
         +pP7Ehs6aouMGENyRCae3yL2ZwJwYHeLYVM/V6MpJUDMiS7sb20pYEedjA3i55TDz4He
         TRNq4A6GdU3vp1nhJJs/Gqn6HHMt5OQ03TtufpFxYsDryF5PyuZugOYuo+vD5oJcdJad
         IJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196369; x=1707801169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/7iEkelNpOUguRvsEE9eynfw8YnY6LsMa0XK+YcgpE=;
        b=NUrcpau4dfGfJZqzDUQ4sYVaGrxTk+c8wjewsxQZBN73gwBRDm3cJONuUKUh51bWIN
         R/R0VOC3sZwZCaHpCgrZj90+EES8kTIHbKNkZHxz731Xru04JAzVlbMWUZAjnuGCtoZZ
         iWExJHws7gFTu5IbZYchLrt+Ar3++WeRtruY5SeuLSlQElhouPcmAU/07RLqqz+gbiK/
         9iGuHfmwPsonbD1HS+MIlpXgc/FUO9OulYfT6GR1zKfZpmysU4dckR20jcXXaOVGe2Ac
         4jS6PtuuhXr0oj3loFsjNHLHpg8wL9ZM6EF7Y1AmIWTBoxzC7pl5WVgG7yAG0vx3NQqk
         o/dw==
X-Gm-Message-State: AOJu0YwiI+ONceUoY/N7QJYYqwtcdEtsdk4/1VAM+BazoVdLm8A4xyK/
	d9ek2ohbyyQ7R24Yeo1suj2v7+q9HG8Frs0YwcMVokb8Lo88TuBVYX3XrZVv
X-Google-Smtp-Source: AGHT+IH36lg042NmUUxL3wLaoSfgwbz7p3N3nqR0dCT9IpKSTPa56fRznPWLhcqX0IPCfRJen2cLmg==
X-Received: by 2002:a5d:5510:0:b0:33b:2194:d2ec with SMTP id b16-20020a5d5510000000b0033b2194d2ecmr468261wrv.57.1707196369508;
        Mon, 05 Feb 2024 21:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVoQS5C0zjH5g5+2mynMExW+XqgJjMksd+IYuecmfxXnPcH2eVPt/27IcXzeKVLQveqjFF7okZMDKQghFYfq5jlSuaFojd2rHXIrBrHlz6KHHNEuhWtaWBm4Kfd8dulHAIYgsKUhnMVKCvzZSSY7Ys1Uws6KYFig7pJQUz5+HyMJaux5LSR+Tti2x85uwZHLqvu/Ue9jiJhWQ==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b0033b40a3f92asm1069755wro.25.2024.02.05.21.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:49 -0800 (PST)
Message-ID: <38f4b4c4135dfebc06c2b1d5c56854af4b07fedc.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:21 +0000
Subject: [PATCH v4 21/28] trailer: spread usage of "trailer_block" language
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
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Deprecate the "trailer_info" struct name and replace it with
"trailer_block". The main reason is to help readability, because
"trailer_info" on the surface sounds like it's about a single trailer
when in reality it is a collection of contiguous lines, at least 25% of
which are trailers.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 25 +++++-----
 trailer.c                    | 97 ++++++++++++++++++------------------
 trailer.h                    | 18 +++----
 3 files changed, 71 insertions(+), 69 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 6bf8cec005a..f76841c5280 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,8 +140,8 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info;
+	struct strbuf tb = STRBUF_INIT;
+	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const struct process_trailer_options *opts,
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
 
 
@@ -171,15 +171,16 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	}
 
 	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block);
+	format_trailers(opts, &head, &tb);
 	free_trailers(&head);
-	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
-	strbuf_release(&trailer_block);
+	fwrite(tb.buf, 1, tb.len, outfile);
+	strbuf_release(&tb);
 
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
index 36e49ab7cf5..49bf26e3211 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,19 +11,20 @@
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
@@ -974,16 +975,16 @@ static void unfold_value(struct strbuf *val)
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
@@ -1016,34 +1017,34 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
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
- * Parse trailers in "str", populating the trailer info and "head"
- * linked list structure.
+ * Parse trailers in "str", populating the trailer_block info and "head" linked
+ * list structure.
  */
-struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
-				    const char *str,
-				    struct list_head *head)
+struct trailer_block *parse_trailers(const struct process_trailer_options *opts,
+				     const char *str,
+				     struct list_head *head)
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
 		if (trailer[0] == comment_line_char)
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1064,7 +1065,7 @@ struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
 		}
 	}
 
-	return info;
+	return trailer_block;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1076,28 +1077,28 @@ void free_trailers(struct list_head *trailers)
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
@@ -1165,19 +1166,19 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(trailers);
-	struct trailer_info *info = parse_trailers(opts, msg, &trailers);
+	struct trailer_block *trailer_block = parse_trailers(opts, msg, &trailers);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
+		strbuf_add(out, msg + trailer_block->start,
+			   trailer_block->end - trailer_block->start);
 	} else
 		format_trailers(opts, &trailers, out);
 
 	free_trailers(&trailers);
-	trailer_info_release(info);
+	trailer_block_release(trailer_block);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
@@ -1186,14 +1187,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
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
@@ -1210,7 +1211,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(iter->internal.info);
+	trailer_block_release(iter->internal.trailer_block);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 1b7422fa2b0..76e6d941a07 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,7 +4,7 @@
 #include "list.h"
 #include "strbuf.h"
 
-struct trailer_info;
+struct trailer_block;
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -70,15 +70,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-struct trailer_info *parse_trailers(const struct process_trailer_options *,
-				    const char *str,
-				    struct list_head *head);
+struct trailer_block *parse_trailers(const struct process_trailer_options *,
+				     const char *str,
+				     struct list_head *head);
 
-size_t trailer_block_start(struct trailer_info *);
-size_t trailer_block_end(struct trailer_info *);
-int blank_line_before_trailer_block(struct trailer_info *);
+size_t trailer_block_start(struct trailer_block *);
+size_t trailer_block_end(struct trailer_block *);
+int blank_line_before_trailer_block(struct trailer_block *);
 
-void trailer_info_release(struct trailer_info *info);
+void trailer_block_release(struct trailer_block *);
 
 void trailer_config_init(void);
 void format_trailers(const struct process_trailer_options *,
@@ -118,7 +118,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info *info;
+		struct trailer_block *trailer_block;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

