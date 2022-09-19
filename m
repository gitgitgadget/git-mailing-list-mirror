Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E31ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiISRsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiISRr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7A42AFB
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t14so275609wrx.8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=hAouAMmcHwmMcP2yo6RVjvoH3SyC6PIjvqzkXERSW/o=;
        b=RFlVxcLZdEZU7D47fphIZDv8gI5bLAxePKx5cnPbnWFGg1z0gIbVi0aYZo4cq+VFgS
         nOzbdFagQmfag4re+4jzhUXhBIUD7n3e86KSmoqiG0Y6tCQmWSiBTF5rZgldaVe7U28+
         UEmqTRPkUfTZobLssJAQnTlRVSIUCQCYOBmKVk9660MyWUL3naDxBk/AjT1f+a/uRovQ
         XAm0+sA8hVSIi/GVBLM2HKyDt7e/PO59rPfJW+8OJ+DFgefc50QxzTyxXL8hG6YFl+w2
         I98nkmkWxgKHSqxGplV2lK0E4jLyTO7KXxM4pFh4rxei8GR8d25PWCpTdeQUEpqLaFMO
         vjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hAouAMmcHwmMcP2yo6RVjvoH3SyC6PIjvqzkXERSW/o=;
        b=ZWhUoa+mxn3h74G43wCndVWOR7tan9ZM2tsIr1jeXbq0WewG4MMiJTxoFl5lUoAYRj
         RZUK8UmzN6QHKk5CRepP6Y1axM053Lp2ewt7rHgQjeF4IO9qvUGteRA3oKRtoAO+8twT
         hhHaSEPV1jGo30d7pmF/xZA2pfmQR64FLNA2n6LVVEZkdkCwoqIELFQlzj/No4ybcpxE
         TpgqPejYYe6FQe9i0BJhWjUPJJvOQIqNLh4kFZArZyDoQVjAkhpqwGzoI1tdTVQyxprr
         QKpsdWXnVCZx9EZ0pkH4wIMjojyMd/G7X4yo6ZvqhJ9SI40hv6CqoVYiQwdCfsvp1dj4
         UrIA==
X-Gm-Message-State: ACrzQf0r2m7KQgwaAcychOnceYdPd+O5NRh+aIwi/cHpN/o0PjWv/ssa
        3vQBvP2QvTEMnrc5OuOJ1Nj56eqART4=
X-Google-Smtp-Source: AMsMyM6zWkosUpf12ktkzAhHGBn2xahY6mOre9AcCLr4YkjrpIfvTXDU6HnXJpBkwFJ3bp2jMkrCPw==
X-Received: by 2002:adf:9795:0:b0:22a:f421:5d0f with SMTP id s21-20020adf9795000000b0022af4215d0fmr6793897wrb.644.1663609665401;
        Mon, 19 Sep 2022 10:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1-20020a056000004100b00228de58ae2bsm14551816wrx.12.2022.09.19.10.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:47:45 -0700 (PDT)
Message-Id: <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:47:37 +0000
Subject: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Roaring bitmaps are said to be more efficient (most of the time) than
ewah bitmaps. So Git might gain some optimization if it support roaring
bitmaps. As Roaring library has all the changes it needed to implement
roaring bitmaps in Git, Git can learn to write roaring bitmaps. However,
all the changes are backward-compatible.

Teach Git to write roaring bitmaps.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Makefile                |   1 +
 bitmap.c                | 225 +++++++++++++++++++++++++++
 bitmap.h                |  33 ++++
 builtin/diff.c          |  10 +-
 ewah/bitmap.c           |  61 +++++---
 ewah/ewok.h             |  37 ++---
 pack-bitmap-write.c     | 326 ++++++++++++++++++++++++++++++----------
 pack-bitmap.c           | 114 +++++++-------
 pack-bitmap.h           |  22 ++-
 t/t5310-pack-bitmaps.sh |  17 +++
 10 files changed, 664 insertions(+), 182 deletions(-)
 create mode 100644 bitmap.c
 create mode 100644 bitmap.h

diff --git a/Makefile b/Makefile
index e9537951105..9ca19b3ca8d 100644
--- a/Makefile
+++ b/Makefile
@@ -900,6 +900,7 @@ LIB_OBJS += archive.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += bitmap.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
diff --git a/bitmap.c b/bitmap.c
new file mode 100644
index 00000000000..7d547eb9f53
--- /dev/null
+++ b/bitmap.c
@@ -0,0 +1,225 @@
+#include "bitmap.h"
+#include "cache.h"
+
+static enum bitmap_type bitmap_type = INIT_BITMAP_TYPE;
+
+void set_bitmap_type(enum bitmap_type type)
+{
+	bitmap_type = type;
+}
+
+enum bitmap_type get_bitmap_type(void)
+{
+	return bitmap_type;
+}
+
+void *roaring_or_ewah_bitmap_init(void)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return ewah_new();
+	case ROARING:
+		return roaring_bitmap_create();
+	default:
+		error(_("bitmap type not initialized\n"));
+		return NULL;
+	}
+}
+
+void *roaring_or_raw_bitmap_new(void)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return raw_bitmap_new();
+	case ROARING:
+		return roaring_bitmap_create();
+	default:
+		error(_("bitmap type not initialized\n"));
+			return NULL;
+	}
+}
+
+void *roaring_or_raw_bitmap_copy(void *bitmap)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return raw_bitmap_dup(bitmap);
+	case ROARING:
+		return roaring_bitmap_copy(bitmap);
+	default:
+		error(_("bitmap type not initialized\n"));
+			return NULL;
+	}
+}
+
+int roaring_or_ewah_bitmap_set(void *bitmap, uint32_t i)
+{
+	switch (bitmap_type) {
+	case EWAH:
+		ewah_set(bitmap, i);
+		break;
+	case ROARING:
+		roaring_bitmap_add(bitmap, i);
+		break;
+	default:
+		return error(_("bitmap type not initialized\n"));
+	}
+
+	return 0;
+}
+
+void roaring_or_raw_bitmap_set(void *bitmap, uint32_t i)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_set(bitmap, i);
+		break;
+	case ROARING:
+		roaring_bitmap_add(bitmap, i);
+		break;
+	default:
+		error(_("bitmap type not initialized\n"));
+	}
+}
+
+void roaring_or_raw_bitmap_unset(void *bitmap, uint32_t i)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_unset(bitmap, i);
+		break;
+	case ROARING:
+		roaring_bitmap_remove(bitmap, i);
+	default:
+		break;
+	}
+}
+
+int roaring_or_raw_bitmap_get(void *bitmap, uint32_t pos)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return raw_bitmap_get(bitmap, pos);
+	case ROARING:
+		return roaring_bitmap_contains(bitmap, pos);
+	default:
+		return error(_("bitmap type not initialized\n"));
+	}
+}
+
+int roaring_or_raw_bitmap_equals(void *a, void *b)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return raw_bitmap_equals(a, b);
+		break;
+	case ROARING:
+		return roaring_bitmap_equals(a, b);
+	default:
+		return error(_("bitmap type not initialized\n"));
+	}
+}
+
+size_t roaring_or_raw_bitmap_cardinality(void *bitmap)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		return raw_bitmap_popcount(bitmap);
+	case ROARING:
+		return roaring_bitmap_get_cardinality(bitmap);
+	default:
+		return error(_("bitmap type not initialized\n"));
+	}
+}
+
+int roaring_or_raw_bitmap_is_subset(void *a, void *b)
+{
+	switch (bitmap_type) {
+	case EWAH:
+		return raw_bitmap_is_subset(a, b);
+	case ROARING:
+		return roaring_bitmap_andnot_cardinality(a, b) ? 1: 0;
+	default:
+		return error(_("bitmap type not initialized\n"));
+	}
+}
+
+void roaring_or_raw_bitmap_printf(void *a)
+{
+	switch (bitmap_type) {
+	case EWAH:
+		ewah_bitmap_print(a);
+		return;
+	case ROARING:
+		roaring_bitmap_printf(a);
+		return;
+	}
+}
+
+void roaring_or_raw_bitmap_or(void *self, void *other)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_or(self, other);
+		break;
+	case ROARING:
+		roaring_bitmap_or_inplace(self, other);
+		break;
+	default:
+		error(_("bitmap type not initialized\n"));
+	}
+}
+
+void roaring_or_raw_bitmap_and_not(void *self, void *other)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_and_not(self, other);
+		break;
+	case ROARING:
+		roaring_bitmap_andnot_inplace(self, other);
+		break;
+	default:
+		error(_("bitmap type not initialized\n"));
+	}
+}
+
+void roaring_or_raw_bitmap_free(void *bitmap)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_free(bitmap);
+		break;
+	case ROARING:
+		roaring_bitmap_free(bitmap);
+		break;
+	default:
+		error(_("bitmap type not initialized\n"));
+	}
+}
+
+void roaring_or_raw_bitmap_free_safe(void **bitmap)
+{
+	switch (bitmap_type)
+	{
+	case EWAH:
+		raw_bitmap_free(*bitmap);
+		break;
+	case ROARING:
+		roaring_bitmap_free_safe((roaring_bitmap_t **)bitmap);
+		break;
+	default:
+		error(_("bitmap type not initialized\n"));
+	}
+}
\ No newline at end of file
diff --git a/bitmap.h b/bitmap.h
new file mode 100644
index 00000000000..d75400922cc
--- /dev/null
+++ b/bitmap.h
@@ -0,0 +1,33 @@
+#ifndef __BITMAP_H__
+#define __BITMAP_H__
+
+
+#include "git-compat-util.h"
+#include "ewah/ewok.h"
+#include "roaring/roaring.h"
+
+enum bitmap_type {
+	INIT_BITMAP_TYPE = 0,
+	EWAH,
+	ROARING
+};
+
+enum bitmap_type get_bitmap_type(void);
+void set_bitmap_type(enum bitmap_type type);
+void *roaring_or_ewah_bitmap_init(void);
+void *roaring_or_raw_bitmap_new(void);
+void *roaring_or_raw_bitmap_copy(void *bitmap);
+int roaring_or_ewah_bitmap_set(void *bitmap, uint32_t i);
+void roaring_or_raw_bitmap_set(void *bitmap, uint32_t i);
+int roaring_or_raw_bitmap_get(void *bitmap, uint32_t pos);
+int roaring_or_raw_bitmap_is_subset(void *a, void *b);
+void roaring_or_raw_bitmap_or(void *self, void *other);
+void roaring_or_raw_bitmap_free(void *bitmap);
+void roaring_or_raw_bitmap_free_safe(void **bitmap);
+void roaring_or_raw_bitmap_unset(void *bitmap, uint32_t i);
+void roaring_or_raw_bitmap_printf(void *a);
+int roaring_or_raw_bitmap_equals(void *a, void *b);
+void roaring_or_raw_bitmap_and_not(void *self, void *other);
+size_t roaring_or_raw_bitmap_cardinality(void *bitmap);
+
+#endif
diff --git a/builtin/diff.c b/builtin/diff.c
index 54bb3de964c..8cf7481d325 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -353,8 +353,8 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 			continue;
 		}
 		if (!map)
-			map = bitmap_new();
-		bitmap_set(map, i);
+			map = raw_bitmap_new();
+		raw_bitmap_set(map, i);
 	}
 
 	/*
@@ -364,7 +364,7 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 		usage(builtin_diff_usage);
 
 	if (!is_symdiff) {
-		bitmap_free(map);
+		raw_bitmap_free(map);
 		sym->warn = 0;
 		sym->skip = NULL;
 		return;
@@ -375,7 +375,7 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 	if (basecount == 0)
 		die(_("%s...%s: no merge base"), sym->left, sym->right);
 	sym->base = rev->pending.objects[basepos].name;
-	bitmap_unset(map, basepos);	/* unmark the base we want */
+	raw_bitmap_unset(map, basepos);	/* unmark the base we want */
 	sym->warn = basecount > 1;
 	sym->skip = map;
 }
@@ -539,7 +539,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			obj = &get_commit_tree(((struct commit *)obj))->object;
 
 		if (obj->type == OBJ_TREE) {
-			if (sdiff.skip && bitmap_get(sdiff.skip, i))
+			if (sdiff.skip && raw_bitmap_get(sdiff.skip, i))
 				continue;
 			obj->flags |= flags;
 			add_object_array(obj, name, &ent);
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index ac618641632..499bf2e03d0 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -22,7 +22,7 @@
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
 #define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
-struct bitmap *bitmap_word_alloc(size_t word_alloc)
+struct bitmap *raw_bitmap_word_alloc(size_t word_alloc)
 {
 	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
 	CALLOC_ARRAY(bitmap->words, word_alloc);
@@ -30,14 +30,14 @@ struct bitmap *bitmap_word_alloc(size_t word_alloc)
 	return bitmap;
 }
 
-struct bitmap *bitmap_new(void)
+struct bitmap *raw_bitmap_new(void)
 {
-	return bitmap_word_alloc(32);
+	return raw_bitmap_word_alloc(32);
 }
 
-struct bitmap *bitmap_dup(const struct bitmap *src)
+struct bitmap *raw_bitmap_dup(const struct bitmap *src)
 {
-	struct bitmap *dst = bitmap_word_alloc(src->word_alloc);
+	struct bitmap *dst = raw_bitmap_word_alloc(src->word_alloc);
 	COPY_ARRAY(dst->words, src->words, src->word_alloc);
 	return dst;
 }
@@ -50,7 +50,7 @@ static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 	       (self->word_alloc - old_size) * sizeof(eword_t));
 }
 
-void bitmap_set(struct bitmap *self, size_t pos)
+void raw_bitmap_set(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 
@@ -58,7 +58,7 @@ void bitmap_set(struct bitmap *self, size_t pos)
 	self->words[block] |= EWAH_MASK(pos);
 }
 
-void bitmap_unset(struct bitmap *self, size_t pos)
+void raw_bitmap_unset(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 
@@ -66,14 +66,14 @@ void bitmap_unset(struct bitmap *self, size_t pos)
 		self->words[block] &= ~EWAH_MASK(pos);
 }
 
-int bitmap_get(struct bitmap *self, size_t pos)
+int raw_bitmap_get(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 	return block < self->word_alloc &&
 		(self->words[block] & EWAH_MASK(pos)) != 0;
 }
 
-struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
+struct ewah_bitmap *raw_bitmap_to_ewah(struct bitmap *bitmap)
 {
 	struct ewah_bitmap *ewah = ewah_new();
 	size_t i, running_empty_words = 0;
@@ -100,9 +100,9 @@ struct ewah_bitmap *bitmap_to_ewah(struct bitmap *bitmap)
 	return ewah;
 }
 
-struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
+struct bitmap *ewah_to_raw_bitmap(struct ewah_bitmap *ewah)
 {
-	struct bitmap *bitmap = bitmap_new();
+	struct bitmap *bitmap = raw_bitmap_new();
 	struct ewah_iterator it;
 	eword_t blowup;
 	size_t i = 0;
@@ -118,7 +118,7 @@ struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah)
 	return bitmap;
 }
 
-void bitmap_and_not(struct bitmap *self, struct bitmap *other)
+void raw_bitmap_and_not(struct bitmap *self, struct bitmap *other)
 {
 	const size_t count = (self->word_alloc < other->word_alloc) ?
 		self->word_alloc : other->word_alloc;
@@ -129,7 +129,7 @@ void bitmap_and_not(struct bitmap *self, struct bitmap *other)
 		self->words[i] &= ~other->words[i];
 }
 
-void bitmap_or(struct bitmap *self, const struct bitmap *other)
+void raw_bitmap_or(struct bitmap *self, const struct bitmap *other)
 {
 	size_t i;
 
@@ -138,7 +138,7 @@ void bitmap_or(struct bitmap *self, const struct bitmap *other)
 		self->words[i] |= other->words[i];
 }
 
-void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
+void raw_bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
 	size_t other_final = (other->bit_size / BITS_IN_EWORD) + 1;
@@ -159,7 +159,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 		self->words[i++] |= word;
 }
 
-size_t bitmap_popcount(struct bitmap *self)
+size_t raw_bitmap_popcount(struct bitmap *self)
 {
 	size_t i, count = 0;
 
@@ -169,7 +169,7 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
-int bitmap_equals(struct bitmap *self, struct bitmap *other)
+int raw_bitmap_equals(struct bitmap *self, struct bitmap *other)
 {
 	struct bitmap *big, *small;
 	size_t i;
@@ -195,7 +195,32 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
-int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
+void ewah_bitmap_print(struct ewah_bitmap *bm)
+{
+	uint32_t i;
+	struct bitmap *raw_bm = ewah_to_raw_bitmap(bm);
+
+	fprintf(stderr, "\n[ ");
+	for (i = 0; i < raw_bm->word_alloc; i++) {
+		eword_t word = raw_bm->words[i];
+		unsigned offset;
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			uint32_t pos;
+
+			if ((word >> offset) == 0)
+				break;
+			offset += ewah_bit_ctz64(word >> offset);
+			pos = i * BITS_IN_EWORD + offset;
+
+			fprintf(stderr, "%d, ", pos);
+		}
+	}
+	fprintf(stderr, "]\n");
+
+}
+
+int raw_bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 {
 	size_t common_size, i;
 
@@ -216,7 +241,7 @@ int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 	return 0;
 }
 
-void bitmap_free(struct bitmap *bitmap)
+void raw_bitmap_free(struct bitmap *bitmap)
 {
 	if (!bitmap)
 		return;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7eb8b9b6301..4fc96fd73d0 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -171,23 +171,24 @@ struct bitmap {
 	size_t word_alloc;
 };
 
-struct bitmap *bitmap_new(void);
-struct bitmap *bitmap_word_alloc(size_t word_alloc);
-struct bitmap *bitmap_dup(const struct bitmap *src);
-void bitmap_set(struct bitmap *self, size_t pos);
-void bitmap_unset(struct bitmap *self, size_t pos);
-int bitmap_get(struct bitmap *self, size_t pos);
-void bitmap_free(struct bitmap *self);
-int bitmap_equals(struct bitmap *self, struct bitmap *other);
-int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
-
-struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
-struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-
-void bitmap_and_not(struct bitmap *self, struct bitmap *other);
-void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
-void bitmap_or(struct bitmap *self, const struct bitmap *other);
-
-size_t bitmap_popcount(struct bitmap *self);
+struct bitmap *raw_bitmap_new(void);
+struct bitmap *raw_bitmap_word_alloc(size_t word_alloc);
+struct bitmap *raw_bitmap_dup(const struct bitmap *src);
+void raw_bitmap_set(struct bitmap *self, size_t pos);
+void raw_bitmap_unset(struct bitmap *self, size_t pos);
+int raw_bitmap_get(struct bitmap *self, size_t pos);
+void raw_bitmap_free(struct bitmap *self);
+int raw_bitmap_equals(struct bitmap *self, struct bitmap *other);
+int raw_bitmap_is_subset(struct bitmap *self, struct bitmap *other);
+
+struct ewah_bitmap * raw_bitmap_to_ewah(struct bitmap *bitmap);
+struct bitmap *ewah_to_raw_bitmap(struct ewah_bitmap *ewah);
+
+void raw_bitmap_and_not(struct bitmap *self, struct bitmap *other);
+void raw_bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
+void raw_bitmap_or(struct bitmap *self, const struct bitmap *other);
+void ewah_bitmap_print(struct ewah_bitmap *bm);
+
+size_t raw_bitmap_popcount(struct bitmap *self);
 
 #endif
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index a213f5eddc5..7ea2f8e0065 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -12,22 +12,27 @@
 #include "hash-lookup.h"
 #include "pack-objects.h"
 #include "commit-reach.h"
+#include "chunk-format.h"
 #include "prio-queue.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
-	struct ewah_bitmap *bitmap;
-	struct ewah_bitmap *write_as;
+	void *bitmap;
+	void *write_as;
+
+	uint32_t bitmap_type;
 	int flags;
 	int xor_offset;
 	uint32_t commit_pos;
 };
 
-struct bitmap_writer {
-	struct ewah_bitmap *commits;
-	struct ewah_bitmap *trees;
-	struct ewah_bitmap *blobs;
-	struct ewah_bitmap *tags;
+struct write_bitmap_context {
+	void *commits;
+	void *trees;
+	void *blobs;
+	void *tags;
+
+	uint32_t bitmap_type;
 
 	kh_oid_map_t *bitmaps;
 	struct packing_data *to_pack;
@@ -35,18 +40,37 @@ struct bitmap_writer {
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
+	struct pack_idx_entry **index;
+	uint32_t index_nr;
+	off_t *offsets;
+	uint32_t *commit_positions;
+
+	void *lookup_table;
+	void *hash_cache;
+
 	struct progress *progress;
 	int show_progress;
 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
 };
 
-static struct bitmap_writer writer;
+static struct write_bitmap_context writer;
 
 void bitmap_writer_show_progress(int show)
 {
 	writer.show_progress = show;
 }
 
+void bitmap_writer_init_bm_type(unsigned version_type)
+{
+	if (version_type & BITMAP_SET_ROARING_BITMAP) {
+		writer.bitmap_type = ROARING;
+		set_bitmap_type(ROARING);
+	}
+	else if (version_type & BITMAP_SET_EWAH_BITMAP) {
+		writer.bitmap_type = EWAH;
+		set_bitmap_type(EWAH);
+	}
+}
 /**
  * Build the initial type index for the packfile or multi-pack-index
  */
@@ -56,11 +80,13 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 {
 	uint32_t i;
 
-	writer.commits = ewah_new();
-	writer.trees = ewah_new();
-	writer.blobs = ewah_new();
-	writer.tags = ewah_new();
+	writer.commits = roaring_or_ewah_bitmap_init();
+	writer.trees = roaring_or_ewah_bitmap_init();
+	writer.blobs = roaring_or_ewah_bitmap_init();
+	writer.tags = roaring_or_ewah_bitmap_init();
 	ALLOC_ARRAY(to_pack->in_pack_pos, to_pack->nr_objects);
+	writer.index = index;
+	writer.index_nr = index_nr;
 
 	for (i = 0; i < index_nr; ++i) {
 		struct object_entry *entry = (struct object_entry *)index[i];
@@ -84,25 +110,25 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 
 		switch (real_type) {
 		case OBJ_COMMIT:
-			ewah_set(writer.commits, i);
+			roaring_or_ewah_bitmap_set(writer.commits, i);
 			break;
 
 		case OBJ_TREE:
-			ewah_set(writer.trees, i);
+			roaring_or_ewah_bitmap_set(writer.trees, i);
 			break;
 
 		case OBJ_BLOB:
-			ewah_set(writer.blobs, i);
+			roaring_or_ewah_bitmap_set(writer.blobs, i);
 			break;
 
 		case OBJ_TAG:
-			ewah_set(writer.tags, i);
+			roaring_or_ewah_bitmap_set(writer.tags, i);
 			break;
 
 		default:
 			die("Missing type information for %s (%d/%d)",
-			    oid_to_hex(&entry->idx.oid), real_type,
-			    oe_type(entry));
+				oid_to_hex(&entry->idx.oid), real_type,
+				oe_type(entry));
 		}
 	}
 }
@@ -184,8 +210,8 @@ static void compute_xor_offsets(void)
 
 struct bb_commit {
 	struct commit_list *reverse_edges;
-	struct bitmap *commit_mask;
-	struct bitmap *bitmap;
+	void *commit_mask;
+	void *bitmap;
 	unsigned selected:1,
 		 maximal:1;
 	unsigned idx; /* within selected array */
@@ -200,7 +226,7 @@ struct bitmap_builder {
 };
 
 static void bitmap_builder_init(struct bitmap_builder *bb,
-				struct bitmap_writer *writer,
+				struct write_bitmap_context *writer,
 				struct bitmap_index *old_bitmap)
 {
 	struct rev_info revs;
@@ -225,8 +251,8 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 		ent->maximal = 1;
 		ent->idx = i;
 
-		ent->commit_mask = bitmap_new();
-		bitmap_set(ent->commit_mask, i);
+		ent->commit_mask = roaring_or_raw_bitmap_new();
+		roaring_or_raw_bitmap_set(ent->commit_mask, i);
 
 		add_pending_object(&revs, &c->object, "");
 	}
@@ -278,18 +304,18 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 			int c_not_p, p_not_c;
 
 			if (!p_ent->commit_mask) {
-				p_ent->commit_mask = bitmap_new();
+				p_ent->commit_mask = roaring_or_raw_bitmap_new();
 				c_not_p = 1;
 				p_not_c = 0;
 			} else {
-				c_not_p = bitmap_is_subset(c_ent->commit_mask, p_ent->commit_mask);
-				p_not_c = bitmap_is_subset(p_ent->commit_mask, c_ent->commit_mask);
+				c_not_p = roaring_or_raw_bitmap_is_subset(c_ent->commit_mask, p_ent->commit_mask);
+				p_not_c = roaring_or_raw_bitmap_is_subset(p_ent->commit_mask, c_ent->commit_mask);
 			}
 
 			if (!c_not_p)
 				continue;
 
-			bitmap_or(p_ent->commit_mask, c_ent->commit_mask);
+			roaring_or_raw_bitmap_or(p_ent->commit_mask, c_ent->commit_mask);
 
 			if (p_not_c)
 				p_ent->maximal = 1;
@@ -312,7 +338,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 		}
 
 next:
-		bitmap_free(c_ent->commit_mask);
+		roaring_or_raw_bitmap_free(c_ent->commit_mask);
 		c_ent->commit_mask = NULL;
 	}
 
@@ -337,7 +363,7 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 	bb->commits_nr = bb->commits_alloc = 0;
 }
 
-static int fill_bitmap_tree(struct bitmap *bitmap,
+static int fill_bitmap_tree(void *bitmap,
 			    struct tree *tree)
 {
 	int found;
@@ -352,9 +378,9 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 	pos = find_object_pos(&tree->object.oid, &found);
 	if (!found)
 		return -1;
-	if (bitmap_get(bitmap, pos))
+	if (roaring_or_raw_bitmap_get(bitmap, pos))
 		return 0;
-	bitmap_set(bitmap, pos);
+	roaring_or_raw_bitmap_set(bitmap, pos);
 
 	if (parse_tree(tree) < 0)
 		die("unable to load tree object %s",
@@ -372,7 +398,7 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 			pos = find_object_pos(&entry.oid, &found);
 			if (!found)
 				return -1;
-			bitmap_set(bitmap, pos);
+			roaring_or_raw_bitmap_set(bitmap, pos);
 			break;
 		default:
 			/* Gitlink, etc; not reachable */
@@ -394,7 +420,7 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 	int found;
 	uint32_t pos;
 	if (!ent->bitmap)
-		ent->bitmap = bitmap_new();
+		ent->bitmap = roaring_or_raw_bitmap_new();
 
 	prio_queue_put(queue, commit);
 
@@ -403,13 +429,13 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		struct commit *c = prio_queue_get(queue);
 
 		if (old_bitmap && mapping) {
-			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
+			void *old = bitmap_for_commit(old_bitmap, c);
 			/*
 			 * If this commit has an old bitmap, then translate that
 			 * bitmap and add its bits to this one. No need to walk
 			 * parents or the tree for this commit.
 			 */
-			if (old && !rebuild_bitmap(mapping, old, ent->bitmap))
+			if (old && !rebuild_bitmap(old_bitmap, mapping, old, ent->bitmap))
 				continue;
 		}
 
@@ -420,15 +446,15 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		pos = find_object_pos(&c->object.oid, &found);
 		if (!found)
 			return -1;
-		bitmap_set(ent->bitmap, pos);
+		roaring_or_raw_bitmap_set(ent->bitmap, pos);
 		prio_queue_put(tree_queue, get_commit_tree(c));
 
 		for (p = c->parents; p; p = p->next) {
 			pos = find_object_pos(&p->item->object.oid, &found);
 			if (!found)
 				return -1;
-			if (!bitmap_get(ent->bitmap, pos)) {
-				bitmap_set(ent->bitmap, pos);
+			if (!roaring_or_raw_bitmap_get(ent->bitmap, pos)) {
+				roaring_or_raw_bitmap_set(ent->bitmap, pos);
 				prio_queue_put(queue, p->item);
 			}
 		}
@@ -447,8 +473,15 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 	struct bitmapped_commit *stored = &writer.selected[ent->idx];
 	khiter_t hash_pos;
 	int hash_ret;
-
-	stored->bitmap = bitmap_to_ewah(ent->bitmap);
+	enum bitmap_type bm_type = get_bitmap_type();
+
+	if (bm_type == EWAH)
+		stored->bitmap = raw_bitmap_to_ewah(ent->bitmap);
+	else if (bm_type == ROARING) {
+		stored->bitmap = roaring_bitmap_copy(ent->bitmap);
+		stored->write_as = stored->bitmap;
+		stored->xor_offset = 0;
+	}
 
 	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
 	if (hash_ret == 0)
@@ -506,16 +539,16 @@ int bitmap_writer_build(struct packing_data *to_pack)
 				bb_data_at(&bb.data, child);
 
 			if (child_ent->bitmap)
-				bitmap_or(child_ent->bitmap, ent->bitmap);
+				roaring_or_raw_bitmap_or(child_ent->bitmap, ent->bitmap);
 			else if (reused)
-				child_ent->bitmap = bitmap_dup(ent->bitmap);
+				child_ent->bitmap = roaring_or_raw_bitmap_copy(ent->bitmap);
 			else {
 				child_ent->bitmap = ent->bitmap;
 				reused = 1;
 			}
 		}
 		if (!reused)
-			bitmap_free(ent->bitmap);
+			roaring_or_raw_bitmap_free(ent->bitmap);
 		ent->bitmap = NULL;
 	}
 	clear_prio_queue(&queue);
@@ -529,7 +562,7 @@ int bitmap_writer_build(struct packing_data *to_pack)
 
 	stop_progress(&writer.progress);
 
-	if (closed)
+	if (closed && writer.bitmap_type == EWAH)
 		compute_xor_offsets();
 	return closed ? 0 : -1;
 }
@@ -626,7 +659,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 }
 
 
-static int hashwrite_ewah_helper(void *f, const void *buf, size_t len)
+static int hashwrite_bitmap_helper(void *f, const void *buf, size_t len)
 {
 	/* hashwrite will die on error */
 	hashwrite(f, buf, len);
@@ -638,7 +671,7 @@ static int hashwrite_ewah_helper(void *f, const void *buf, size_t len)
  */
 static inline void dump_bitmap(struct hashfile *f, struct ewah_bitmap *bitmap)
 {
-	if (ewah_serialize_to(bitmap, hashwrite_ewah_helper, f) < 0)
+	if (ewah_serialize_to(bitmap, hashwrite_bitmap_helper, f) < 0)
 		die("Failed to write bitmap index");
 }
 
@@ -649,10 +682,15 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 }
 
 static void write_selected_commits_v1(struct hashfile *f,
-				      uint32_t *commit_positions,
-				      off_t *offsets)
+				      struct pack_idx_entry **index,
+				      uint32_t index_nr)
 {
 	int i;
+	uint32_t *commit_positions = writer.commit_positions;
+	off_t *offsets = writer.offsets;
+
+	if (!commit_positions)
+		die(_("commit positions are not initialized properly\n"));
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
@@ -683,11 +721,13 @@ static int table_cmp(const void *_va, const void *_vb, void *_data)
 }
 
 static void write_lookup_table(struct hashfile *f,
-			       uint32_t *commit_positions,
-			       off_t *offsets)
+			       struct pack_idx_entry **index,
+			       uint32_t index_nr)
 {
 	uint32_t i;
 	uint32_t *table, *table_inv;
+	uint32_t *commit_positions = writer.commit_positions;
+	off_t *offsets = writer.offsets;
 
 	ALLOC_ARRAY(table, writer.selected_nr);
 	ALLOC_ARRAY(table_inv, writer.selected_nr);
@@ -758,59 +798,188 @@ void bitmap_writer_set_checksum(const unsigned char *sha1)
 	hashcpy(writer.pack_checksum, sha1);
 }
 
-void bitmap_writer_finish(struct pack_idx_entry **index,
-			  uint32_t index_nr,
-			  const char *filename,
-			  uint16_t options)
+static size_t compute_pt_serialize_type_indexes_size(void)
 {
-	static uint16_t default_version = 1;
-	static uint16_t flags = BITMAP_OPT_FULL_DAG;
-	struct strbuf tmp_file = STRBUF_INIT;
-	struct hashfile *f;
-	uint32_t *commit_positions = NULL;
-	off_t *offsets = NULL;
-	uint32_t i;
+	size_t type_index_size = 0;
+	type_index_size += roaring_bitmap_network_portable_size_in_bytes(writer.commits);
+	type_index_size += roaring_bitmap_network_portable_size_in_bytes(writer.trees);
+	type_index_size += roaring_bitmap_network_portable_size_in_bytes(writer.blobs);
+	type_index_size += roaring_bitmap_network_portable_size_in_bytes(writer.tags);
+	return type_index_size;
+}
 
-	struct bitmap_disk_header header;
+static size_t compute_pt_serialize_commit_bitmap_sec_size(void)
+{
+	size_t  size = 0;
+	int i;
 
-	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
+	for (i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
 
-	f = hashfd(fd, tmp_file.buf);
+		size += sizeof(uint32_t) + sizeof(uint8_t) * 2;
+		size += roaring_bitmap_network_portable_size_in_bytes(stored->write_as);
+	}
+	return size;
+}
 
-	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
-	header.version = htons(default_version);
-	header.options = htons(flags | options);
-	header.entry_count = htonl(writer.selected_nr);
-	hashcpy(header.checksum, writer.pack_checksum);
+static size_t compute_hash_cache_size(void)
+{
+	return st_mult(writer.index_nr, sizeof(uint32_t));
+}
 
-	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
+static size_t compute_bitmap_lookup_table_size(void)
+{
+	return st_mult(writer.selected_nr, BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH);
+}
+
+static int write_bitmap_type_indexes(struct hashfile *f, void *data)
+{
+	struct write_bitmap_context *writer = data;
+	roaring_bitmap_portable_network_serialize(writer->commits, hashwrite_bitmap_helper, f);
+	roaring_bitmap_portable_network_serialize(writer->trees, hashwrite_bitmap_helper, f);
+	roaring_bitmap_portable_network_serialize(writer->blobs, hashwrite_bitmap_helper, f);
+	roaring_bitmap_portable_network_serialize(writer->tags, hashwrite_bitmap_helper, f);
+	return 0;
+}
+
+static int write_reachability_roaring_bitmaps(struct hashfile *f, void *data)
+{
+	struct write_bitmap_context *writer = data;
+	uint32_t *commit_positions = writer->commit_positions;
+	int i;
+
+	if (!commit_positions)
+		die(_("commit positions are not initialized properly\n"));
+
+	for (i = 0; i < writer->selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer->selected[i];
+
+		if (writer->offsets)
+			writer->offsets[i] = hashfile_total(f);
+
+		hashwrite_be32(f, commit_positions[i]);
+		hashwrite_u8(f, stored->xor_offset);
+		hashwrite_u8(f, stored->flags);
+
+		roaring_bitmap_portable_network_serialize(stored->write_as, hashwrite_bitmap_helper, f);
+	}
+	return 0;
+}
+
+static int write_chunk_hash_cache(struct hashfile *f, void *data)
+{
+	struct write_bitmap_context *writer = data;
+	write_hash_cache(f, writer->index, writer->index_nr);
+	return 0;
+}
+
+static int write_chunk_lookup_table(struct hashfile *f, void *data)
+{
+	struct write_bitmap_context *writer = data;
+	write_lookup_table(f, writer->index, writer->index_nr);
+	return 0;
+}
+
+static void write_roaring_bitmap_file(struct hashfile *f,
+			       const char *filename,
+			       uint16_t options)
+{
+	struct chunkfile *cf = init_chunkfile(f);
+
+	add_chunk(cf, BITMAP_TYPE_INDEXES,
+		  compute_pt_serialize_type_indexes_size(),
+		  write_bitmap_type_indexes);
+
+	trace2_region_enter("pack-bitmap-write", "write-roaring-bitmap", the_repository);
+	add_chunk(cf, BITMAP_REACHABILITY_BITMAPS,
+		  compute_pt_serialize_commit_bitmap_sec_size(),
+		  write_reachability_roaring_bitmaps);
+
+	if (options & BITMAP_OPT_HASH_CACHE)
+		add_chunk(cf, BITMAP_HASH_CACHE,
+			compute_hash_cache_size(),
+			write_chunk_hash_cache);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		add_chunk(cf, BITMAP_LOOKUP_TABLE,
+			compute_bitmap_lookup_table_size(),
+			write_chunk_lookup_table);
+
+	hashwrite_u8(f, get_num_chunks(cf));
+	write_chunkfile(cf, &writer);
+	trace2_region_leave("pack-bitmap-write", "write-roaring-bitmap", the_repository);
+}
+
+static void write_ewah_bitmap_file(struct hashfile *f,
+			    struct pack_idx_entry **index,
+			    uint32_t index_nr,
+			    const char *filename,
+			    uint16_t options)
+{
 	dump_bitmap(f, writer.commits);
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
 
+	write_selected_commits_v1(f, index, index_nr);
+
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		CALLOC_ARRAY(offsets, index_nr);
+		write_lookup_table(f, index, index_nr);
 
+	if (options & BITMAP_OPT_HASH_CACHE)
+		write_hash_cache(f, index, index_nr);
+}
+
+static void fill_writer_commit_positions(void)
+{
+	uint32_t *commit_positions = NULL;
+	int i;
 	ALLOC_ARRAY(commit_positions, writer.selected_nr);
 
 	for (i = 0; i < writer.selected_nr; i++) {
 		struct bitmapped_commit *stored = &writer.selected[i];
-		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+		int commit_pos = oid_pos(&stored->commit->object.oid, writer.index, writer.index_nr, oid_access);
 
 		if (commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
 
 		commit_positions[i] = commit_pos;
 	}
+	writer.commit_positions = commit_positions;
+}
+
+void bitmap_writer_finish(struct pack_idx_entry **index,
+			  uint32_t index_nr,
+			  const char *filename,
+			  uint16_t options)
+{
+	struct strbuf tmp_file = STRBUF_INIT;
+	struct hashfile *f = NULL;
+	static uint16_t version = 1;
+	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	struct bitmap_disk_header header;
 
-	write_selected_commits_v1(f, commit_positions, offsets);
+	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
+	f = hashfd(fd, tmp_file.buf);
+	if (writer.bitmap_type & ROARING)
+		version = 2;
+
+	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
+	header.version = htons(version);
+	header.options = htons(flags | options);
+	header.entry_count = htonl(writer.selected_nr);
+	hashcpy(header.checksum, writer.pack_checksum);
+
+	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		write_lookup_table(f, commit_positions, offsets);
+		CALLOC_ARRAY(writer.offsets, index_nr);
 
-	if (options & BITMAP_OPT_HASH_CACHE)
-		write_hash_cache(f, index, index_nr);
+	fill_writer_commit_positions();
+	if (writer.bitmap_type == ROARING)
+		write_roaring_bitmap_file(f, filename, options);
+	else if (writer.bitmap_type == EWAH)
+		write_ewah_bitmap_file(f, index, index_nr, filename, options);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
@@ -820,8 +989,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	if (rename(tmp_file.buf, filename))
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
-
 	strbuf_release(&tmp_file);
-	free(commit_positions);
-	free(offsets);
+	free(writer.offsets);
+	free(writer.commit_positions);
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9a208abc1fd..c1a0bc26d02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -936,7 +936,7 @@ static void show_object(struct object *object, const char *name, void *data_)
 		bitmap_pos = ext_index_add_object(data->bitmap_git, object,
 						  name);
 
-	bitmap_set(data->base, bitmap_pos);
+	raw_bitmap_set(data->base, bitmap_pos);
 }
 
 static void show_commit(struct commit *commit, void *data)
@@ -950,19 +950,19 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 {
 	struct ewah_bitmap *partial;
 
-	if (data->seen && bitmap_get(data->seen, bitmap_pos))
+	if (data->seen && raw_bitmap_get(data->seen, bitmap_pos))
 		return 0;
 
-	if (bitmap_get(data->base, bitmap_pos))
+	if (raw_bitmap_get(data->base, bitmap_pos))
 		return 0;
 
 	partial = bitmap_for_commit(bitmap_git, commit);
 	if (partial) {
-		bitmap_or_ewah(data->base, partial);
+		raw_bitmap_or_ewah(data->base, partial);
 		return 0;
 	}
 
-	bitmap_set(data->base, bitmap_pos);
+	raw_bitmap_set(data->base, bitmap_pos);
 	return 1;
 }
 
@@ -999,8 +999,8 @@ static int should_include_obj(struct object *obj, void *_data)
 	bitmap_pos = bitmap_position(data->bitmap_git, &obj->oid);
 	if (bitmap_pos < 0)
 		return 1;
-	if ((data->seen && bitmap_get(data->seen, bitmap_pos)) ||
-	     bitmap_get(data->base, bitmap_pos)) {
+	if ((data->seen && raw_bitmap_get(data->seen, bitmap_pos)) ||
+	     raw_bitmap_get(data->base, bitmap_pos)) {
 		obj->flags |= SEEN;
 		return 0;
 	}
@@ -1017,9 +1017,9 @@ static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
 		return 0;
 
 	if (!*base)
-		*base = ewah_to_bitmap(or_with);
+		*base = ewah_to_raw_bitmap(or_with);
 	else
-		bitmap_or_ewah(*base, or_with);
+		raw_bitmap_or_ewah(*base, or_with);
 
 	return 1;
 }
@@ -1080,7 +1080,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		roots = roots->next;
 		pos = bitmap_position(bitmap_git, &object->oid);
 
-		if (pos < 0 || base == NULL || !bitmap_get(base, pos)) {
+		if (pos < 0 || base == NULL || !raw_bitmap_get(base, pos)) {
 			object->flags &= ~UNINTERESTING;
 			add_pending_object(revs, object, "");
 			needs_walk = 1;
@@ -1094,7 +1094,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct bitmap_show_data show_data;
 
 		if (!base)
-			base = bitmap_new();
+			base = raw_bitmap_new();
 
 		incdata.bitmap_git = bitmap_git;
 		incdata.base = base;
@@ -1133,7 +1133,7 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+		if (!raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1256,7 +1256,7 @@ static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 				       struct object_list *tip_objects,
 				       enum object_type type)
 {
-	struct bitmap *result = bitmap_new();
+	struct bitmap *result = raw_bitmap_new();
 	struct object_list *p;
 
 	for (p = tip_objects; p; p = p->next) {
@@ -1269,7 +1269,7 @@ static struct bitmap *find_tip_objects(struct bitmap_index *bitmap_git,
 		if (pos < 0)
 			continue;
 
-		bitmap_set(result, pos);
+		raw_bitmap_set(result, pos);
 	}
 
 	return result;
@@ -1314,12 +1314,12 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == type &&
-		    bitmap_get(to_filter, pos) &&
-		    !bitmap_get(tips, pos))
-			bitmap_unset(to_filter, pos);
+		    raw_bitmap_get(to_filter, pos) &&
+		    !raw_bitmap_get(tips, pos))
+			raw_bitmap_unset(to_filter, pos);
 	}
 
-	bitmap_free(tips);
+	raw_bitmap_free(tips);
 }
 
 static void filter_bitmap_blob_none(struct bitmap_index *bitmap_git,
@@ -1396,22 +1396,22 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			offset += ewah_bit_ctz64(word >> offset);
 			pos = i * BITS_IN_EWORD + offset;
 
-			if (!bitmap_get(tips, pos) &&
+			if (!raw_bitmap_get(tips, pos) &&
 			    get_size_by_pos(bitmap_git, pos) >= limit)
-				bitmap_unset(to_filter, pos);
+				raw_bitmap_unset(to_filter, pos);
 		}
 	}
 
 	for (i = 0; i < eindex->count; i++) {
 		uint32_t pos = i + bitmap_num_objects(bitmap_git);
 		if (eindex->objects[i]->type == OBJ_BLOB &&
-		    bitmap_get(to_filter, pos) &&
-		    !bitmap_get(tips, pos) &&
+		    raw_bitmap_get(to_filter, pos) &&
+		    !raw_bitmap_get(tips, pos) &&
 		    get_size_by_pos(bitmap_git, pos) >= limit)
-			bitmap_unset(to_filter, pos);
+			raw_bitmap_unset(to_filter, pos);
 	}
 
-	bitmap_free(tips);
+	raw_bitmap_free(tips);
 }
 
 static void filter_bitmap_tree_depth(struct bitmap_index *bitmap_git,
@@ -1597,7 +1597,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 		BUG("failed to perform bitmap walk");
 
 	if (haves_bitmap)
-		bitmap_and_not(wants_bitmap, haves_bitmap);
+		raw_bitmap_and_not(wants_bitmap, haves_bitmap);
 
 	filter_bitmap(bitmap_git,
 		      (revs->filter.choice && filter_provided_objects) ? NULL : wants,
@@ -1702,14 +1702,14 @@ static int try_partial_reuse(struct packed_git *pack,
 		 * to REF_DELTA on the fly. Better to just let the normal
 		 * object_entry code path handle it.
 		 */
-		if (!bitmap_get(reuse, base_pos))
+		if (!raw_bitmap_get(reuse, base_pos))
 			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
-	bitmap_set(reuse, pos);
+	raw_bitmap_set(reuse, pos);
 	return 0;
 }
 
@@ -1758,7 +1758,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	if (i > objects_nr / BITS_IN_EWORD)
 		i = objects_nr / BITS_IN_EWORD;
 
-	reuse = bitmap_word_alloc(i);
+	reuse = raw_bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
 
 	for (; i < result->word_alloc; ++i) {
@@ -1789,9 +1789,9 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 done:
 	unuse_pack(&w_curs);
 
-	*entries = bitmap_popcount(reuse);
+	*entries = raw_bitmap_popcount(reuse);
 	if (!*entries) {
-		bitmap_free(reuse);
+		raw_bitmap_free(reuse);
 		return -1;
 	}
 
@@ -1799,7 +1799,7 @@ done:
 	 * Drop any reused objects from the result, since they will not
 	 * need to be handled separately.
 	 */
-	bitmap_and_not(result, reuse);
+	raw_bitmap_and_not(result, reuse);
 	*packfile_out = pack;
 	*reuse_out = reuse;
 	return 0;
@@ -1814,7 +1814,7 @@ int bitmap_walk_contains(struct bitmap_index *bitmap_git,
 		return 0;
 
 	idx = bitmap_position(bitmap_git, oid);
-	return idx >= 0 && bitmap_get(bitmap, idx);
+	return idx >= 0 && raw_bitmap_get(bitmap, idx);
 }
 
 void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
@@ -1853,7 +1853,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
-			bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
+			raw_bitmap_get(objects, bitmap_num_objects(bitmap_git) + i))
 			count++;
 	}
 
@@ -1896,19 +1896,19 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	enum object_type bitmap_type = OBJ_NONE;
 	int bitmaps_nr = 0;
 
-	if (bitmap_get(tdata->commits, pos)) {
+	if (raw_bitmap_get(tdata->commits, pos)) {
 		bitmap_type = OBJ_COMMIT;
 		bitmaps_nr++;
 	}
-	if (bitmap_get(tdata->trees, pos)) {
+	if (raw_bitmap_get(tdata->trees, pos)) {
 		bitmap_type = OBJ_TREE;
 		bitmaps_nr++;
 	}
-	if (bitmap_get(tdata->blobs, pos)) {
+	if (raw_bitmap_get(tdata->blobs, pos)) {
 		bitmap_type = OBJ_BLOB;
 		bitmaps_nr++;
 	}
-	if (bitmap_get(tdata->tags, pos)) {
+	if (raw_bitmap_get(tdata->tags, pos)) {
 		bitmap_type = OBJ_TAG;
 		bitmaps_nr++;
 	}
@@ -1939,7 +1939,7 @@ static void test_show_object(struct object *object, const char *name,
 		die(_("object not in bitmap: '%s'"), oid_to_hex(&object->oid));
 	test_bitmap_type(tdata, object, bitmap_pos);
 
-	bitmap_set(tdata->base, bitmap_pos);
+	raw_bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
@@ -1954,7 +1954,7 @@ static void test_show_commit(struct commit *commit, void *data)
 		die(_("object not in bitmap: '%s'"), oid_to_hex(&commit->object.oid));
 	test_bitmap_type(tdata, &commit->object, bitmap_pos);
 
-	bitmap_set(tdata->base, bitmap_pos);
+	raw_bitmap_set(tdata->base, bitmap_pos);
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
@@ -1985,7 +1985,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
 			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
 
-		result = ewah_to_bitmap(bm);
+		result = ewah_to_raw_bitmap(bm);
 	}
 
 	if (!result)
@@ -1995,17 +1995,17 @@ void test_bitmap_walk(struct rev_info *revs)
 	revs->tree_objects = 1;
 	revs->blob_objects = 1;
 
-	result_popcnt = bitmap_popcount(result);
+	result_popcnt = raw_bitmap_popcount(result);
 
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
 
 	tdata.bitmap_git = bitmap_git;
-	tdata.base = bitmap_new();
-	tdata.commits = ewah_to_bitmap(bitmap_git->commits);
-	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
-	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
-	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
+	tdata.base = raw_bitmap_new();
+	tdata.commits = ewah_to_raw_bitmap(bitmap_git->commits);
+	tdata.trees = ewah_to_raw_bitmap(bitmap_git->trees);
+	tdata.blobs = ewah_to_raw_bitmap(bitmap_git->blobs);
+	tdata.tags = ewah_to_raw_bitmap(bitmap_git->tags);
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
 	tdata.seen = 0;
 
@@ -2013,17 +2013,17 @@ void test_bitmap_walk(struct rev_info *revs)
 
 	stop_progress(&tdata.prg);
 
-	if (bitmap_equals(result, tdata.base))
+	if (raw_bitmap_equals(result, tdata.base))
 		fprintf_ln(stderr, "OK!");
 	else
 		die(_("mismatch in bitmap results"));
 
-	bitmap_free(result);
-	bitmap_free(tdata.base);
-	bitmap_free(tdata.commits);
-	bitmap_free(tdata.trees);
-	bitmap_free(tdata.blobs);
-	bitmap_free(tdata.tags);
+	raw_bitmap_free(result);
+	raw_bitmap_free(tdata.base);
+	raw_bitmap_free(tdata.commits);
+	raw_bitmap_free(tdata.trees);
+	raw_bitmap_free(tdata.blobs);
+	raw_bitmap_free(tdata.tags);
 	free_bitmap_index(bitmap_git);
 }
 
@@ -2102,7 +2102,7 @@ int rebuild_bitmap(const uint32_t *reposition,
 
 			bit_pos = reposition[pos + offset];
 			if (bit_pos > 0)
-				bitmap_set(dest, bit_pos - 1);
+				raw_bitmap_set(dest, bit_pos - 1);
 			else /* can't reuse, we don't have the object */
 				return -1;
 		}
@@ -2171,8 +2171,8 @@ void free_bitmap_index(struct bitmap_index *b)
 	free(b->ext_index.objects);
 	free(b->ext_index.hashes);
 	kh_destroy_oid_pos(b->ext_index.positions);
-	bitmap_free(b->result);
-	bitmap_free(b->haves);
+	raw_bitmap_free(b->result);
+	raw_bitmap_free(b->haves);
 	if (bitmap_is_midx(b)) {
 		/*
 		 * Multi-pack bitmaps need to have resources associated with
@@ -2265,7 +2265,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 	for (i = 0; i < eindex->count; i++) {
 		struct object *obj = eindex->objects[i];
 
-		if (!bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
+		if (!raw_bitmap_get(result, bitmap_num_objects(bitmap_git) + i))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index f0180b5276b..7d71deca023 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -2,11 +2,18 @@
 #define PACK_BITMAP_H
 
 #include "ewah/ewok.h"
+#include "roaring/roaring.h"
+#include "bitmap.h"
 #include "khash.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "string-list.h"
 
+#define BITMAP_TYPE_INDEXES 0x54494458 /* "TIDX" */
+#define BITMAP_REACHABILITY_BITMAPS 0x5242544D /* "RBTM" */
+#define BITMAP_HASH_CACHE 0x424D4843 /* "BMHC" */
+#define BITMAP_LOOKUP_TABLE 0x424D4C54 /* "BMLT" */
+
 struct commit;
 struct repository;
 struct rev_info;
@@ -23,6 +30,9 @@ struct bitmap_disk_header {
 
 #define NEEDS_BITMAP (1u<<22)
 
+#define BITMAP_SET_EWAH_BITMAP 0x1
+#define BITMAP_SET_ROARING_BITMAP (1 << 1)
+
 /*
  * The width in bytes of a single triplet in the lookup table
  * extension:
@@ -86,16 +96,18 @@ off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(const unsigned char *sha1);
+void bitmap_writer_init_bm_type(unsigned version_type);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping);
-int rebuild_bitmap(const uint32_t *reposition,
-		   struct ewah_bitmap *source,
-		   struct bitmap *dest);
-struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
-				      struct commit *commit);
+int rebuild_bitmap(struct bitmap_index *bitmap_git,
+		   const uint32_t *reposition,
+		   void *source,
+		   void *dest);
+void *bitmap_for_commit(struct bitmap_index *bitmap_git,
+			struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
 int bitmap_writer_build(struct packing_data *to_pack);
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7e50f8e7653..d953de6b7fe 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -475,4 +475,21 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 	test_i18ngrep corrupted.bitmap.index stderr
 '
 
+test_expect_success 'setup test repository (roaring)' '
+	rm -fr * .git &&
+	git init
+'
+setup_bitmap_history
+
+test_expect_success 'setup writing roaring bitmaps during repack' '
+	git config repack.writeBitmaps true &&
+	git config pack.useRoaringBitmap true
+'
+
+test_expect_success 'full repack creates roaring bitmaps' '
+	GIT_TRACE2_EVENT="$(pwd)/trace6" \
+		git repack -ad &&
+	grep "\"label\":\"write-roaring-bitmap\"" trace6
+'
+
 test_done
-- 
gitgitgadget

