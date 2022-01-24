Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A8C4332F
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbiAXTdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352723AbiAXTa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:59 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD949C028C1B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:14:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so3316607wra.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z4D1URX+3kK/Uq4IPVaN54ox5HJIb6dQy07r+RyLXLY=;
        b=GT4Q2oSSm3AP1RYQnmIxjZR4C7c66pkcZZ7rO8UvHbkc8VlIO4j5aRzAKyK+g9jqI5
         qmXXwOA4o+hcRBCfIrO3nP5sxLEDBujgpZq+iDru9FGbd/a230BDfVNJqX618WMCX7a3
         Lsgjmc+giXAf/X62hmOPmZkbOT+qnvJBJFlaVgeu5orpzw83F2S/p7tGlgxul4urt/ly
         CS0u9Q6QMH481+KWl4/UDK0FWIHMVjrjAJN2NOlMDL7Jn1EPHCmRo4UrBxLfM/ay5rqP
         rt8+daAb7RUm90q+pUBdvEWdZIApsx5YHLvazW7WWiEyWalM95maEWAmY0rUJV7xOc2t
         1wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z4D1URX+3kK/Uq4IPVaN54ox5HJIb6dQy07r+RyLXLY=;
        b=H1QcuFZHWVBhd7X3JXFR45zWVhnR9nehqDTjj+QYeokCrermdFESzr22rKBaV/pghj
         1fjWd5Ml+BCq+rM/3GH21hLw/wxzlR46CPXixMGir8NqxpAERmUc6tVihTNCS3v1h8HE
         Q2HfSJQkc+fI68IJfavO6cldIt/63+xTLganBEt8nRuQ5//s3hceGsjahtn6O68OsJsg
         7RCGywy+fGPgf1WNUMXVgUknwgTRX9Q27Vg+BRxyuBQFG8rlqS09UjNohHOdKRJ5M3CC
         7huaLGEOmWcZjYPbxVXz7mGCuQCPUZCx83lE30UTonI/UANjF/T4Gd0ZZVHY+o87ytFy
         Z2PQ==
X-Gm-Message-State: AOAM5330Z/3o7zYL7LeIhe1sZ9KtcaRA2EaCOhxzsOetyMMNU7tCRoBY
        Vfk0vtvfc0lV+PBeVNSuyoHB8rfz/sMwlA==
X-Google-Smtp-Source: ABdhPJwrLqKHVzcmRRveq4ia1G8mV/1F98pilIHbY4wjAiZASaFazgzjWWGbMzp3LMNQQrARI92bEQ==
X-Received: by 2002:adf:fb84:: with SMTP id a4mr15579452wrr.315.1643051640032;
        Mon, 24 Jan 2022 11:14:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm155586wmr.25.2022.01.24.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:59 -0800 (PST)
Message-Id: <556fc11080a67ceda81f6c39fcdd4dc1098ac1b5.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:44 +0000
Subject: [PATCH v7 16/16] reftable: rename typ to type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The 'typ' variable name betrays the Go origins of this code (in Go,
'type' is a reserved word). Since we now have parted ways with the Go
code, simply use 'type'.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c  | 10 ++++----
 reftable/merged.c |  6 ++---
 reftable/merged.h |  2 +-
 reftable/reader.c | 58 +++++++++++++++++++++++------------------------
 reftable/record.c |  4 ++--
 reftable/writer.c | 32 +++++++++++++-------------
 6 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 80ad10bb794..6c1f70ba563 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -68,14 +68,14 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	return 0;
 }
 
-void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+void block_writer_init(struct block_writer *bw, uint8_t type, uint8_t *buf,
 		       uint32_t block_size, uint32_t header_off, int hash_size)
 {
 	bw->buf = buf;
 	bw->hash_size = hash_size;
 	bw->block_size = block_size;
 	bw->header_off = header_off;
-	bw->buf[header_off] = typ;
+	bw->buf[header_off] = type;
 	bw->next = header_off + 4;
 	bw->restart_interval = 16;
 	bw->entries = 0;
@@ -186,7 +186,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		      int hash_size)
 {
 	uint32_t full_block_size = table_block_size;
-	uint8_t typ = block->data[header_off];
+	uint8_t type = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
 
 	int err = 0;
@@ -195,12 +195,12 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint8_t *restart_bytes = NULL;
 	uint8_t *uncompressed = NULL;
 
-	if (!reftable_is_block_type(typ)) {
+	if (!reftable_is_block_type(type)) {
 		err =  REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
 
-	if (typ == BLOCK_TYPE_LOG) {
+	if (type == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + header_off;
 		uLongf dst_len = sz - block_header_skip; /* total size of dest
 							    buffer. */
diff --git a/reftable/merged.c b/reftable/merged.c
index 82511762d2a..b5710d5f7a9 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -22,7 +22,7 @@ static int merged_iter_init(struct merged_iter *mi)
 {
 	int i = 0;
 	for (i = 0; i < mi->stack_len; i++) {
-		struct reftable_record rec = reftable_new_record(mi->typ);
+		struct reftable_record rec = reftable_new_record(mi->type);
 		int err = iterator_next(&mi->stack[i], &rec);
 		if (err < 0) {
 			return err;
@@ -58,7 +58,7 @@ static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
 					       size_t idx)
 {
 	struct pq_entry e = {
-		.rec = reftable_new_record(mi->typ),
+		.rec = reftable_new_record(mi->type),
 		.index = idx,
 	};
 	int err = iterator_next(&mi->stack[idx], &e.rec);
@@ -245,7 +245,7 @@ static int merged_table_seek_record(struct reftable_merged_table *mt,
 		sizeof(struct reftable_iterator) * mt->stack_len);
 	struct merged_iter merged = {
 		.stack = iters,
-		.typ = reftable_record_type(rec),
+		.type = reftable_record_type(rec),
 		.hash_id = mt->hash_id,
 		.suppress_deletions = mt->suppress_deletions,
 	};
diff --git a/reftable/merged.h b/reftable/merged.h
index 7d9f95d27ed..63f288ff8d6 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -28,7 +28,7 @@ struct merged_iter {
 	struct reftable_iterator *stack;
 	uint32_t hash_id;
 	size_t stack_len;
-	uint8_t typ;
+	uint8_t type;
 	int suppress_deletions;
 	struct merged_iter_pqueue pq;
 };
diff --git a/reftable/reader.c b/reftable/reader.c
index 565cda8d5a2..1ecd23bba36 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -43,9 +43,9 @@ void block_source_close(struct reftable_block_source *source)
 }
 
 static struct reftable_reader_offsets *
-reader_offsets_for(struct reftable_reader *r, uint8_t typ)
+reader_offsets_for(struct reftable_reader *r, uint8_t type)
 {
-	switch (typ) {
+	switch (type) {
 	case BLOCK_TYPE_REF:
 		return &r->ref_offsets;
 	case BLOCK_TYPE_LOG:
@@ -84,7 +84,7 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 			uint8_t *header)
 {
 	uint8_t *f = footer;
-	uint8_t first_block_typ;
+	uint8_t first_block_type;
 	int err = 0;
 	uint32_t computed_crc;
 	uint32_t file_crc;
@@ -149,10 +149,10 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 		goto done;
 	}
 
-	first_block_typ = header[header_size(r->version)];
-	r->ref_offsets.is_present = (first_block_typ == BLOCK_TYPE_REF);
+	first_block_type = header[header_size(r->version)];
+	r->ref_offsets.is_present = (first_block_type == BLOCK_TYPE_REF);
 	r->ref_offsets.offset = 0;
-	r->log_offsets.is_present = (first_block_typ == BLOCK_TYPE_LOG ||
+	r->log_offsets.is_present = (first_block_type == BLOCK_TYPE_LOG ||
 				     r->log_offsets.offset > 0);
 	r->obj_offsets.is_present = r->obj_offsets.offset > 0;
 	err = 0;
@@ -214,7 +214,7 @@ done:
 
 struct table_iter {
 	struct reftable_reader *r;
-	uint8_t typ;
+	uint8_t type;
 	uint64_t block_off;
 	struct block_iter bi;
 	int is_finished;
@@ -228,7 +228,7 @@ static void table_iter_copy_from(struct table_iter *dest,
 				 struct table_iter *src)
 {
 	dest->r = src->r;
-	dest->typ = src->typ;
+	dest->type = src->type;
 	dest->block_off = src->block_off;
 	dest->is_finished = src->is_finished;
 	block_iter_copy_from(&dest->bi, &src->bi);
@@ -257,7 +257,7 @@ static void table_iter_block_done(struct table_iter *ti)
 	ti->bi.next_off = 0;
 }
 
-static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
+static int32_t extract_block_size(uint8_t *data, uint8_t *type, uint64_t off,
 				  int version)
 {
 	int32_t result = 0;
@@ -266,20 +266,20 @@ static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
 		data += header_size(version);
 	}
 
-	*typ = data[0];
-	if (reftable_is_block_type(*typ)) {
+	*type = data[0];
+	if (reftable_is_block_type(*type)) {
 		result = get_be24(data + 1);
 	}
 	return result;
 }
 
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
-			     uint64_t next_off, uint8_t want_typ)
+			     uint64_t next_off, uint8_t want_type)
 {
 	int32_t guess_block_size = r->block_size ? r->block_size :
 							 DEFAULT_BLOCK_SIZE;
 	struct reftable_block block = { NULL };
-	uint8_t block_typ = 0;
+	uint8_t block_type = 0;
 	int err = 0;
 	uint32_t header_off = next_off ? 0 : header_size(r->version);
 	int32_t block_size = 0;
@@ -291,13 +291,13 @@ int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
 	if (err < 0)
 		goto done;
 
-	block_size = extract_block_size(block.data, &block_typ, next_off,
+	block_size = extract_block_size(block.data, &block_type, next_off,
 					r->version);
 	if (block_size < 0) {
 		err = block_size;
 		goto done;
 	}
-	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
+	if (want_type != BLOCK_TYPE_ANY && block_type != want_type) {
 		err = 1;
 		goto done;
 	}
@@ -326,10 +326,10 @@ static int table_iter_next_block(struct table_iter *dest,
 	int err = 0;
 
 	dest->r = src->r;
-	dest->typ = src->typ;
+	dest->type = src->type;
 	dest->block_off = next_block_off;
 
-	err = reader_init_block_reader(src->r, &br, next_block_off, src->typ);
+	err = reader_init_block_reader(src->r, &br, next_block_off, src->type);
 	if (err > 0) {
 		dest->is_finished = 1;
 		return 1;
@@ -349,7 +349,7 @@ static int table_iter_next_block(struct table_iter *dest,
 
 static int table_iter_next(struct table_iter *ti, struct reftable_record *rec)
 {
-	if (reftable_record_type(rec) != ti->typ)
+	if (reftable_record_type(rec) != ti->type)
 		return REFTABLE_API_ERROR;
 
 	while (1) {
@@ -404,38 +404,38 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 
 static int reader_table_iter_at(struct reftable_reader *r,
 				struct table_iter *ti, uint64_t off,
-				uint8_t typ)
+				uint8_t type)
 {
 	struct block_reader br = { 0 };
 	struct block_reader *brp = NULL;
 
-	int err = reader_init_block_reader(r, &br, off, typ);
+	int err = reader_init_block_reader(r, &br, off, type);
 	if (err != 0)
 		return err;
 
 	brp = reftable_malloc(sizeof(struct block_reader));
 	*brp = br;
 	ti->r = r;
-	ti->typ = block_reader_type(brp);
+	ti->type = block_reader_type(brp);
 	ti->block_off = off;
 	block_reader_start(brp, &ti->bi);
 	return 0;
 }
 
 static int reader_start(struct reftable_reader *r, struct table_iter *ti,
-			uint8_t typ, int index)
+			uint8_t type, int index)
 {
-	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, type);
 	uint64_t off = offs->offset;
 	if (index) {
 		off = offs->index_offset;
 		if (off == 0) {
 			return 1;
 		}
-		typ = BLOCK_TYPE_INDEX;
+		type = BLOCK_TYPE_INDEX;
 	}
 
-	return reader_table_iter_at(r, ti, off, typ);
+	return reader_table_iter_at(r, ti, off, type);
 }
 
 static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
@@ -522,12 +522,12 @@ static int reader_seek_indexed(struct reftable_reader *r,
 		if (err < 0)
 			goto done;
 
-		if (next.typ == reftable_record_type(rec)) {
+		if (next.type == reftable_record_type(rec)) {
 			err = 0;
 			break;
 		}
 
-		if (next.typ != BLOCK_TYPE_INDEX) {
+		if (next.type != BLOCK_TYPE_INDEX) {
 			err = REFTABLE_FORMAT_ERROR;
 			break;
 		}
@@ -582,9 +582,9 @@ static int reader_seek_internal(struct reftable_reader *r,
 static int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
 		       struct reftable_record *rec)
 {
-	uint8_t typ = reftable_record_type(rec);
+	uint8_t type = reftable_record_type(rec);
 
-	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
+	struct reftable_reader_offsets *offs = reader_offsets_for(r, type);
 	if (!offs->is_present) {
 		iterator_set_empty(it);
 		return 0;
diff --git a/reftable/record.c b/reftable/record.c
index c57bac0e96a..8330b7a2589 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -78,9 +78,9 @@ int put_var_int(struct string_view *dest, uint64_t val)
 	return n;
 }
 
-int reftable_is_block_type(uint8_t typ)
+int reftable_is_block_type(uint8_t type)
 {
-	switch (typ) {
+	switch (type) {
 	case BLOCK_TYPE_REF:
 	case BLOCK_TYPE_LOG:
 	case BLOCK_TYPE_OBJ:
diff --git a/reftable/writer.c b/reftable/writer.c
index 96a5155ea77..5b768438625 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -26,9 +26,9 @@ static void writer_clear_index(struct reftable_writer *w);
 static int writer_finish_public_section(struct reftable_writer *w);
 
 static struct reftable_block_stats *
-writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
+writer_reftable_block_stats(struct reftable_writer *w, uint8_t type)
 {
-	switch (typ) {
+	switch (type) {
 	case 'r':
 		return &w->stats.ref_stats;
 	case 'o':
@@ -102,7 +102,7 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	return header_size(writer_version(w));
 }
 
-static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
+static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t type)
 {
 	int block_start = 0;
 	if (w->next == 0) {
@@ -110,7 +110,7 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	}
 
 	strbuf_release(&w->last_key);
-	block_writer_init(&w->block_writer_data, typ, w->block,
+	block_writer_init(&w->block_writer_data, type, w->block,
 			  w->opts.block_size, block_start,
 			  hash_size(w->opts.hash_id));
 	w->block_writer = &w->block_writer_data;
@@ -375,7 +375,7 @@ int reftable_writer_add_logs(struct reftable_writer *w,
 
 static int writer_finish_section(struct reftable_writer *w)
 {
-	uint8_t typ = block_writer_type(w->block_writer);
+	uint8_t type = block_writer_type(w->block_writer);
 	uint64_t index_start = 0;
 	int max_level = 0;
 	int threshold = w->opts.unpadded ? 1 : 3;
@@ -434,7 +434,7 @@ static int writer_finish_section(struct reftable_writer *w)
 	if (err < 0)
 		return err;
 
-	bstats = writer_reftable_block_stats(w, typ);
+	bstats = writer_reftable_block_stats(w, type);
 	bstats->index_blocks = w->stats.idx_stats.blocks - before_blocks;
 	bstats->index_offset = index_start;
 	bstats->max_index_level = max_level;
@@ -536,17 +536,17 @@ static int writer_dump_object_index(struct reftable_writer *w)
 
 static int writer_finish_public_section(struct reftable_writer *w)
 {
-	uint8_t typ = 0;
+	uint8_t type = 0;
 	int err = 0;
 
 	if (w->block_writer == NULL)
 		return 0;
 
-	typ = block_writer_type(w->block_writer);
+	type = block_writer_type(w->block_writer);
 	err = writer_finish_section(w);
 	if (err < 0)
 		return err;
-	if (typ == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
+	if (type == BLOCK_TYPE_REF && !w->opts.skip_index_objects &&
 	    w->stats.ref_stats.index_blocks > 0) {
 		err = writer_dump_object_index(w);
 		if (err < 0)
@@ -630,10 +630,10 @@ static const int debug = 0;
 
 static int writer_flush_nonempty_block(struct reftable_writer *w)
 {
-	uint8_t typ = block_writer_type(w->block_writer);
+	uint8_t type = block_writer_type(w->block_writer);
 	struct reftable_block_stats *bstats =
-		writer_reftable_block_stats(w, typ);
-	uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
+		writer_reftable_block_stats(w, type);
+	uint64_t block_type_off = (bstats->blocks == 0) ? w->next : 0;
 	int raw_bytes = block_writer_finish(w->block_writer);
 	int padding = 0;
 	int err = 0;
@@ -641,12 +641,12 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 	if (raw_bytes < 0)
 		return raw_bytes;
 
-	if (!w->opts.unpadded && typ != BLOCK_TYPE_LOG) {
+	if (!w->opts.unpadded && type != BLOCK_TYPE_LOG) {
 		padding = w->opts.block_size - raw_bytes;
 	}
 
-	if (block_typ_off > 0) {
-		bstats->offset = block_typ_off;
+	if (block_type_off > 0) {
+		bstats->offset = block_type_off;
 	}
 
 	bstats->entries += w->block_writer->entries;
@@ -655,7 +655,7 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 	w->stats.blocks++;
 
 	if (debug) {
-		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", typ,
+		fprintf(stderr, "block %c off %" PRIu64 " sz %d (%d)\n", type,
 			w->next, raw_bytes,
 			get_be24(w->block + w->block_writer->header_off + 1));
 	}
-- 
gitgitgadget
