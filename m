Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17B325483
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393591; cv=none; b=FdLIIpOOR3MxR/lyqSpvicYQCEE9lVe8qpOac3WEOk5wOqWHsaEe11yxVA4w9VdIVxN9gY3OPg4mU79zkhfuoUlNklZrVdJM8owliQ5C1C08MA5aoihuIRtVH6xhJOr4gBjkwWxsczJFLvvQ5ezidktHFYKkbfphz3J0kv+/d6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393591; c=relaxed/simple;
	bh=9aUFyW18foZeuNcUYLObrac7dvLh6kfzid6AMTho53Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nxZr9mxrxLTw2/0j6m2R4bvownrWJqmYVncv4+B0qCHzyVMtnxUFbcfojdI4GH3YAWeKmbnY68wIKWSdbyTrCNMLmAn1RJayg7DKoioZJT1TUq1cv7iNtDwAn6OszV6aetmGn2gVcN4rNuDIc88hDrSTyxkSsecireKsck2vqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3YqIqh/; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3YqIqh/"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463a0e14abfso5807949b6e.2
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393587; x=1777998387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtObJhzuxIAUJsqGQ2ncg6Ho4sg5ijIrnqZIfvSh+Ok=;
        b=I3YqIqh/cPE45F5L6kLC2doceNZPIzVwKq08yqtQdJ1zPr1lFf0kDWH3oe2GISWfza
         fytrtm5gIQq7r5PKO6G6lD37FG95oAF+b4jreRCefsVOELkUqZL/hCQZlai8VGS8gGyK
         EgiaYUPNKUss1DcgdVSRbiaMl6JQGFBYnU4ck4mJ6LBwOsNXD4goVaARnKq6FkFsdFso
         eFrW2r3O0wq1vHgIKskAeWjTx+b0htkdzAUWj44+PO8lyJ3RxBgqGsqXyGk5YM91mZmF
         R/peVXS0xkGZihDe+WqmTS+a73a1BAiNwry5iS9wMtD2V4iEQPEU1jqjT3ooY9pfeJEt
         HLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393587; x=1777998387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XtObJhzuxIAUJsqGQ2ncg6Ho4sg5ijIrnqZIfvSh+Ok=;
        b=PUWmS+1vf0KLle36mATx36OPYRjCi8Tp8mwsf/PC3jQ0MiWXvokwjItAYo8vlLKhwN
         IlphYrB3TXpAHG2ten5rka2PtguBLoMSnbf0gPZ53vUk1a56HUpHx1tZHcLEJk9wJebR
         RJETOQNsyzP17S7xVSp5zEw8hyQ8q9fP8/BPLYSmNtFQPv075UoPG5NQ4OZ0HJyDQ7gg
         Y2rN2dyshf60ULfWNnz3v0Je3SzIN6Xt38vi9trWmORYxYHB+EJFTMNf1fFQp72CIyC4
         /fEcgJOwAwpXmhMxPLGtD7SBVO7UzMtLj8zDZTCJ/+0Z42oeNuhusQ89Jct88w+3NzIx
         1qZw==
X-Gm-Message-State: AOJu0YzwzzVqT9Pi8wmBEmbyCf4+7Ufw3JyMlyUP41Y06B3wRXEpI5zK
	ePzjeUdWdRYJiWpTFxcytGWZyjtxvlS+DLwJrN20uhkx4qXMCBDv60wOD4ojvg==
X-Gm-Gg: AeBDietpC3ZcXzbX20hzeq80pOHZE+GBd/IsrZ5X/fAvcSYkJOPuOGmZjxWR66VZoNT
	BxkWcC4xavB4ugEN0TWqW2sD3U16VeOFiJb7udcY9tpj27Oh9Y2NSgplDYpgOSNdptBAkxK2X01
	gxfS7Dz/swmujQdlE+GVZDpYv1xBZgzy8CkLp45K1bUDEdKq1/Czcmut30ixoSZCsLPLihsBJqX
	5YHbu+UYpXRPamVhi/wIo4Vz9Fmoazb705UrjU2ArbNlqvGcyrJdxWJ0ralHSScWQ8tzh4aR9JK
	uPjj0Ofr7mo/lzfAoqrOgP2Z3s1t0YfClTLffpPpEyYv5a/ucv1WOUOQKaDsNgCv5bSrsWRXUTU
	e6mY9tAeKvekBBrHohGfwLrjwMj32ue+gNrUCX8fSieoAhcESQwV4TnTIgRocf0yFD2DDJmkUbI
	piJ66dcve2t2ShBgf2vuj3pFbA+VDZ/LBZLYE2Rp9G96eIUz2Uzg==
X-Received: by 2002:a05:6808:1509:b0:45e:e07d:85af with SMTP id 5614622812f47-47c28d801aamr2009735b6e.2.1777393586732;
        Tue, 28 Apr 2026 09:26:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c28f50286sm1736196b6e.1.2026.04.28.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:26 -0700 (PDT)
Message-Id: <3a539061c5f62c65d46bd0eb774bb1b1239463ff.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:17 +0000
Subject: [PATCH 3/6] odb, packfile: use size_t for streaming object sizes
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The odb_read_stream structure uses unsigned long for the size field,
which is 32-bit on Windows even in 64-bit builds. When streaming
objects larger than 4GB, the size would be truncated to zero or an
incorrect value, resulting in empty files being written to disk.

Change the size field in odb_read_stream to size_t and introduce
unpack_object_header_sz() to return sizes via size_t pointer. Since
object_info.sizep remains unsigned long for API compatibility, use
temporary variables where the types differ, with comments noting the
truncation limitation for code paths that still use unsigned long.

This was originally authored by LordKiRon <https://github.com/LordKiRon>,
who preferred not to reveal their real name and therefore agreed that I
take over authorship.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c       | 23 ++++++++++++++++-------
 object-file.c                | 10 +++++++++-
 odb/streaming.c              | 13 ++++++++++++-
 odb/streaming.h              |  2 +-
 oss-fuzz/fuzz-pack-headers.c |  2 +-
 pack-bitmap.c                |  2 +-
 pack-check.c                 |  6 ++++--
 packfile.c                   | 24 +++++++++++++++---------
 packfile.h                   |  4 ++--
 9 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..aa4b1cb9b8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -629,14 +629,21 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
 	struct packed_git *p = IN_PACK(entry);
 	struct pack_window *w_curs = NULL;
 	uint32_t pos;
-	off_t offset;
+	off_t offset, cur;
 	enum object_type type = oe_type(entry);
+	enum object_type in_pack_type;
 	off_t datalen;
 	unsigned char header[MAX_PACK_OBJECT_HEADER],
 		      dheader[MAX_PACK_OBJECT_HEADER];
 	unsigned hdrlen;
 	const unsigned hashsz = the_hash_algo->rawsz;
-	unsigned long entry_size = SIZE(entry);
+	size_t entry_size;
+
+	cur = entry->in_pack_offset;
+	in_pack_type = unpack_object_header(p, &w_curs, &cur, &entry_size);
+	if (in_pack_type < 0)
+		die(_("write_reuse_object: unable to parse object header of %s"),
+		    oid_to_hex(&entry->idx.oid));
 
 	if (DELTA(entry))
 		type = (allow_ofs_delta && DELTA(entry)->idx.offset) ?
@@ -1087,7 +1094,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 {
 	off_t offset, next, cur;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	offset = pack_pos_to_offset(reuse_packfile, pos);
 	next = pack_pos_to_offset(reuse_packfile, pos + 1);
@@ -2243,7 +2250,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
-		unsigned long in_pack_size;
+		size_t in_pack_size;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -2734,16 +2741,18 @@ unsigned long oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail, size;
+	unsigned long used, avail;
+	size_t size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
+		unsigned long sz;
 		packing_data_lock(&to_pack);
 		if (odb_read_object_info(the_repository->objects,
-					 &e->idx.oid, &size) < 0)
+					 &e->idx.oid, &sz) < 0)
 			die(_("unable to get size of %s"),
 			    oid_to_hex(&e->idx.oid));
 		packing_data_unlock(&to_pack);
-		return size;
+		return sz;
 	}
 
 	p = oe_in_pack(pack, e);
diff --git a/object-file.c b/object-file.c
index 086b2b65ff..0be2981c7a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2326,6 +2326,7 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 	struct object_info oi = OBJECT_INFO_INIT;
 	struct odb_loose_read_stream *st;
 	unsigned long mapsize;
+	unsigned long size_ul;
 	void *mapped;
 
 	mapped = odb_source_loose_map_object(source, oid, &mapsize);
@@ -2349,11 +2350,18 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 		goto error;
 	}
 
-	oi.sizep = &st->base.size;
+	/*
+	 * object_info.sizep is unsigned long* (32-bit on Windows), but
+	 * st->base.size is size_t (64-bit). Use temporary variable.
+	 * Note: loose objects >4GB would still truncate here, but such
+	 * large loose objects are uncommon (they'd normally be packed).
+	 */
+	oi.sizep = &size_ul;
 	oi.typep = &st->base.type;
 
 	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
 		goto error;
+	st->base.size = size_ul;
 
 	st->mapped = mapped;
 	st->mapsize = mapsize;
diff --git a/odb/streaming.c b/odb/streaming.c
index 5927a12954..af2adf5ce7 100644
--- a/odb/streaming.c
+++ b/odb/streaming.c
@@ -157,15 +157,26 @@ static int open_istream_incore(struct odb_read_stream **out,
 		.base.read = read_istream_incore,
 	};
 	struct odb_incore_read_stream *st;
+	unsigned long size_ul;
 	int ret;
 
 	oi.typep = &stream.base.type;
-	oi.sizep = &stream.base.size;
+	/*
+	 * object_info.sizep is unsigned long* (32-bit on Windows), but
+	 * stream.base.size is size_t (64-bit). We use a temporary variable
+	 * because the types are incompatible. Note: this path still truncates
+	 * for >4GB objects, but large objects should use pack streaming
+	 * (packfile_store_read_object_stream) which handles size_t properly.
+	 * This incore fallback is only used for small objects or when pack
+	 * streaming is unavailable.
+	 */
+	oi.sizep = &size_ul;
 	oi.contentp = (void **)&stream.buf;
 	ret = odb_read_object_info_extended(odb, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
+	stream.base.size = size_ul;
 
 	CALLOC_ARRAY(st, 1);
 	*st = stream;
diff --git a/odb/streaming.h b/odb/streaming.h
index c7861f7e13..517e2ea2d3 100644
--- a/odb/streaming.h
+++ b/odb/streaming.h
@@ -21,7 +21,7 @@ struct odb_read_stream {
 	odb_read_stream_close_fn close;
 	odb_read_stream_read_fn read;
 	enum object_type type;
-	unsigned long size; /* inflated size of full object */
+	size_t size; /* inflated size of full object */
 };
 
 /*
diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
index 150c0f5fa2..ef61ab577c 100644
--- a/oss-fuzz/fuzz-pack-headers.c
+++ b/oss-fuzz/fuzz-pack-headers.c
@@ -6,7 +6,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 {
 	enum object_type type;
-	unsigned long len;
+	size_t len;
 
 	unpack_object_header_buffer((const unsigned char *)data,
 				    (unsigned long)size, &type, &len);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index f6ec18d83a..f9af8a96bd 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2270,7 +2270,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 {
 	off_t delta_obj_offset;
 	enum object_type type;
-	unsigned long size;
+	size_t size;
 
 	if (pack_pos >= pack->p->num_objects)
 		return -1; /* not actually in the pack */
diff --git a/pack-check.c b/pack-check.c
index 79992bb509..2792f34d25 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -110,7 +110,7 @@ static int verify_packfile(struct repository *r,
 		void *data;
 		struct object_id oid;
 		enum object_type type;
-		unsigned long size;
+		size_t size;
 		off_t curpos;
 		int data_valid;
 
@@ -143,7 +143,9 @@ static int verify_packfile(struct repository *r,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			data = unpack_entry(r, p, entries[i].offset, &type, &size);
+			unsigned long sz;
+			data = unpack_entry(r, p, entries[i].offset, &type, &sz);
+			size = sz;
 			data_valid = 1;
 		}
 
diff --git a/packfile.c b/packfile.c
index b012d648ad..fdae91dd11 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1133,7 +1133,7 @@ out:
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
-		unsigned long len, enum object_type *type, unsigned long *sizep)
+		unsigned long len, enum object_type *type, size_t *sizep)
 {
 	unsigned shift;
 	size_t size, c;
@@ -1144,7 +1144,11 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || (bitsizeof(long) - 7) < shift) {
+		/*
+		 * Each continuation byte adds 7 bits. Ensure shift won't
+		 * overflow size_t (use size_t not long for 64-bit on Windows).
+		 */
+		if (len <= used || (bitsizeof(size_t) - 7) < shift) {
 			error("bad object header");
 			size = used = 0;
 			break;
@@ -1153,7 +1157,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		size = st_add(size, st_left_shift(c & 0x7f, shift));
 		shift += 7;
 	}
-	*sizep = cast_size_t_to_ulong(size);
+	*sizep = size;
 	return used;
 }
 
@@ -1215,7 +1219,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
-			 unsigned long *sizep)
+			 size_t *sizep)
 {
 	unsigned char *base;
 	unsigned long left;
@@ -1367,7 +1371,7 @@ static enum object_type packed_to_object_type(struct repository *r,
 
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
-		unsigned long size;
+		size_t size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1586,7 +1590,7 @@ static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_off
 					     uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
-	unsigned long size;
+	size_t size;
 	off_t curpos = obj_offset;
 	enum object_type type = OBJ_NONE;
 	uint32_t pack_pos;
@@ -1778,7 +1782,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
 	void *data = NULL;
-	unsigned long size;
+	size_t size;
 	enum object_type type;
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
@@ -1943,8 +1947,10 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			      (uintmax_t)curpos, p->pack_name);
 			data = NULL;
 		} else {
+			unsigned long sz;
 			data = patch_delta(base, base_size, delta_data,
-					   delta_size, &size);
+					   delta_size, &sz);
+			size = sz;
 
 			/*
 			 * We could not apply the delta; warn the user, but
@@ -2929,7 +2935,7 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 	struct odb_packed_read_stream *stream;
 	struct pack_window *window = NULL;
 	enum object_type in_pack_type;
-	unsigned long size;
+	size_t size;
 
 	in_pack_type = unpack_object_header(pack, &window, &offset, &size);
 	unuse_pack(&window);
diff --git a/packfile.h b/packfile.h
index 9b647da7dd..49d6bdecf6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -456,9 +456,9 @@ off_t find_pack_entry_one(const struct object_id *oid, struct packed_git *);
 
 int is_pack_valid(struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, size_t *sizep);
 unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, size_t *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
 		     off_t delta_obj_offset);
-- 
gitgitgadget

