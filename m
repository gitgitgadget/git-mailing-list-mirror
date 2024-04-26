Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D674428
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091182; cv=none; b=W3HdnBW47l2zwOFiYZ0uu4XSSwIh1sGtpban4LjK1TXrtUwrODY+m2G6oB4f0g03si5NElM6gex5tQKBxDaslRZ8x4sSqTH0S1mGMjHHniZ3ef2p66fx+JVzAsMmAvm+RdaUUWOVvVc9JQiJCuo5zE7bt7Prdr1EnQVxac6f15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091182; c=relaxed/simple;
	bh=4uNz/BNgPU9bXhIVD83KXZWLdRC44l+OQ1r4zFrYzCs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h8c+sITxbnNQy3mk/C7T6p8fyUZ1Fyz6yaZT77gX+EVz9sx+B0KtNqp9OxFrUvdZnVc2BObZLM5KC40wDXNZVs3Itmmj9dxf2oKMMnMnKEY5F3egQyXciq5ZqfQbxjYHsHQUNozTta6JjsTvxHmseQG8sMcRGqF03Kdnuqg7dOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDXVYptL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDXVYptL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b3692b508so11845725e9.1
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091178; x=1714695978; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYH3cOb+6VK9nymkrwkTOMX8VDcmssy9ePiYCbDT9xU=;
        b=nDXVYptLGyvotpeoBQ5O43XGT97+dCivDCJUz5ghz6bEysW3bSbLfun8ZExoos+6lL
         j3s0vAne7luhEQqOmWo7MvUqNGfMY+6qeYHvX4ZXYc/I3jRMP9qZM+042rptwYiAqVeC
         XQuiLgY10Ad0xveE7ILDXMa9Axhqt2bA4j/Pj4gXxhSEi5G5Viqn+DXpRnmGba4hMTkR
         Z9cJIDfvIkT0nxdaza2Ct2+k7I7JYy0eNdLpWSzBlClL5q+wn5ssVVUC6dFse4NxPc4E
         7/2nLWzN7nxSsN33Izn/hFHR8zbrvmFp+d79ncIMGnGx3ZZ6NQQHDm6eBzIdFuJRzv1C
         Rj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091178; x=1714695978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYH3cOb+6VK9nymkrwkTOMX8VDcmssy9ePiYCbDT9xU=;
        b=qvmVs1+fyBMQwwnwWJCCYtvNN7uVi5GdxrnnyObSWBUbwWPPQtuuXJY+W/eie0K0Z+
         MYMcc+0e9oylJ0o6z1zDJtYa6rBScfjHl12LBt259c3ygBd+VHR8dyiy+gkNmTb5w7Cd
         frkvFzD+uC+Fb5jE2Tu9dV9AwS3o1JOBV6bBbJyGZrSlefFYyysKoDrUSR6o5kbYDjJl
         11T4dxPVDrg//jgXgu5uElNSW5K/wXhuaxE9AQztkA+Ew1B4gdFJAy0bCrzcSud4XVPP
         1HyQMRoow1tDJaC/biD4VT83IQy+4OdGLC1n61Zz64sARn1W0FzwCIi3reY52U0TAQhE
         9J2Q==
X-Gm-Message-State: AOJu0Yy7vl6/FfxU/znLmeEVDchFZsaVNo0TWBI1ryc0j3womqcxZVK/
	dBCfx/gQhUEFmeEjps7O4JKFLbCjtETvmq1RZwtkpprLAgo4yHEg8PR+Lg==
X-Google-Smtp-Source: AGHT+IGqJeA2A5HpMi4LbF5bh0Vcs5qB/EDI6pIF4eiKYavfGywlnwVHbbRWFUnzDwYpCTIN/ThAQg==
X-Received: by 2002:a05:600c:a54:b0:41a:aad8:e393 with SMTP id c20-20020a05600c0a5400b0041aaad8e393mr708505wmq.30.1714091178442;
        Thu, 25 Apr 2024 17:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg16-20020a05600c539000b0041aa8ad46d6sm11558306wmb.16.2024.04.25.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:17 -0700 (PDT)
Message-Id: <d217858c637c06836f83d7e6e0c1388326190222.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:06 +0000
Subject: [PATCH v3 06/10] trailer: make parse_trailers() return trailer_info
 pointer
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
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This is the second and final preparatory commit for making the
trailer_info struct private to the trailer implementation.

Make trailer_info_get() do the actual work of allocating a new
trailer_info struct, and return a pointer to it. Because
parse_trailers() wraps around trailer_info_get(), it too can return this
pointer to the caller. From the trailer API user's perspective, the call
to trailer_info_new() can be replaced with parse_trailers(); do so in
interpret-trailers.

Because trailer_info_new() is no longer called by interpret-trailers,
remove this function from the trailer API.

With this change, we no longer allocate trailer_info on the stack ---
all uses of it are via a pointer where the actual data is always
allocated at runtime through trailer_info_new(). Make
trailer_info_release() free this dynamically allocated memory.

Finally, due to the way the function signatures of parse_trailers() and
trailer_info_get() have changed, update the callsites in
format_trailers_from_commit() and trailer_iterator_init() accordingly.

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  4 ++--
 trailer.c                    | 41 +++++++++++++++++++-----------------
 trailer.h                    | 17 ++++++---------
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f3240682e35..6bf8cec005a 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info = trailer_info_new();
+	struct trailer_info *info;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,7 +151,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	parse_trailers(opts, info, sb.buf, &head);
+	info = parse_trailers(opts, sb.buf, &head);
 
 	/* Print the lines before the trailers */
 	if (!opts->only_trailers)
diff --git a/trailer.c b/trailer.c
index 95b4c9b8f19..9179dd802c6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -952,7 +952,7 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-struct trailer_info *trailer_info_new(void)
+static struct trailer_info *trailer_info_new(void)
 {
 	struct trailer_info *info = xcalloc(1, sizeof(*info));
 	return info;
@@ -962,16 +962,16 @@ struct trailer_info *trailer_info_new(void)
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-void parse_trailers(const struct process_trailer_options *opts,
-		    struct trailer_info *info,
-		    const char *str,
-		    struct list_head *head)
+struct trailer_info *parse_trailers(const struct process_trailer_options *opts,
+				    const char *str,
+				    struct list_head *head)
 {
+	struct trailer_info *info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(opts, str, info);
+	info = trailer_info_get(opts, str);
 
 	for (i = 0; i < info->trailer_nr; i++) {
 		int separator_pos;
@@ -995,6 +995,8 @@ void parse_trailers(const struct process_trailer_options *opts,
 					 strbuf_detach(&val, NULL));
 		}
 	}
+
+	return info;
 }
 
 void free_trailers(struct list_head *trailers)
@@ -1021,10 +1023,10 @@ int blank_line_before_trailer_block(struct trailer_info *info)
 	return info->blank_line_before_trailer;
 }
 
-void trailer_info_get(const struct process_trailer_options *opts,
-		      const char *str,
-		      struct trailer_info *info)
+struct trailer_info *trailer_info_get(const struct process_trailer_options *opts,
+				      const char *str)
 {
+	struct trailer_info *info = trailer_info_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1063,6 +1065,8 @@ void trailer_info_get(const struct process_trailer_options *opts,
 	info->trailer_block_end = end_of_log_message;
 	info->trailers = trailer_strings;
 	info->trailer_nr = nr;
+
+	return info;
 }
 
 void trailer_info_release(struct trailer_info *info)
@@ -1071,6 +1075,7 @@ void trailer_info_release(struct trailer_info *info)
 	for (i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
+	free(info);
 }
 
 void format_trailers(const struct process_trailer_options *opts,
@@ -1138,21 +1143,19 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 struct strbuf *out)
 {
 	LIST_HEAD(trailer_objects);
-	struct trailer_info info;
-
-	parse_trailers(opts, &info, msg, &trailer_objects);
+	struct trailer_info *info = parse_trailers(opts, msg, &trailer_objects);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info.trailer_block_start,
-			   info.trailer_block_end - info.trailer_block_start);
+		strbuf_add(out, msg + info->trailer_block_start,
+			   info->trailer_block_end - info->trailer_block_start);
 	} else
 		format_trailers(opts, &trailer_objects, out);
 
 	free_trailers(&trailer_objects);
-	trailer_info_release(&info);
+	trailer_info_release(info);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
@@ -1161,14 +1164,14 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	opts.no_divider = 1;
-	trailer_info_get(&opts, msg, &iter->internal.info);
+	iter->internal.info = trailer_info_get(&opts, msg);
 	iter->internal.cur = 0;
 }
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	if (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *line = iter->internal.info.trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.info->trailer_nr) {
+		char *line = iter->internal.info->trailers[iter->internal.cur++];
 		int separator_pos = find_separator(line, separators);
 
 		iter->raw = line;
@@ -1185,7 +1188,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(&iter->internal.info);
+	trailer_info_release(iter->internal.info);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 }
diff --git a/trailer.h b/trailer.h
index 9ac4be853c5..b32213a9e23 100644
--- a/trailer.h
+++ b/trailer.h
@@ -89,18 +89,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-void parse_trailers(const struct process_trailer_options *,
-		    struct trailer_info *,
-		    const char *str,
-		    struct list_head *head);
-
-void trailer_info_get(const struct process_trailer_options *,
-		      const char *str,
-		      struct trailer_info *);
+struct trailer_info *parse_trailers(const struct process_trailer_options *,
+				    const char *str,
+				    struct list_head *head);
+struct trailer_info *trailer_info_get(const struct process_trailer_options *,
+				      const char *str);
+
 size_t trailer_block_start(struct trailer_info *);
 size_t trailer_block_end(struct trailer_info *);
 int blank_line_before_trailer_block(struct trailer_info *);
-struct trailer_info *trailer_info_new(void);
 
 void trailer_info_release(struct trailer_info *info);
 
@@ -142,7 +139,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info info;
+		struct trailer_info *info;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

