Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FA2066F3
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983545; cv=none; b=ZZcJltJ4MEpD55L3004afh1N312IoPKqR4DCpTbLRhjg21h2phqDI8Za2xx8RlkI99opn+KGPlKtarNWMer6zF+0hl5UWFmk2y89uDos80f1hPb/a2xnPyA65Mg+KV284VxOZ1Eu8mfksQKW+/yPJyvL/OrsStK7vl9m05MVGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983545; c=relaxed/simple;
	bh=ZYx2gByTblTw+dsIsojZeBW7tU40aII3gaiJu9Xgy3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPTDlXLN58x/nnPaB7R3hwApWVCIye4jt0ah5HGzpbyqfXxkBmnZrQuoA+1SglxPOdIl4RT3QC9CL43f6j4WnIZGmjsmJNeRYpHk7FjoK/lfGH097s7NGaEHFY5KVklC+Kz3mQ5elMTdhXJ5GPIeIMu/Rvq0VyfWsTEsXCyh1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zECCoToT; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zECCoToT"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso22122636d6.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983541; x=1742588341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrdhz+xcjCDmVtdwxSkwlSAeLnoIXiDdRTu+0Lr7nvw=;
        b=zECCoToTIR/aNETSdye7Yuz5cnXPIWWzm0dVhZhnRfNmeTg5eW3lqC8riDt8EXdVe9
         oH3pqW6kMahY1Z9SlTCX34g275gw/DY9iPv16XosUkC9+/CCw4HjfwtRSykRbWs7gys6
         9JoF61oCArpoyMmx2q1SdmehCr5yRm8tDpV+3ZNsJ+ZEorE0CKECOecGRFgQ+SuINq1E
         Mabfxp8OhiHZ3qfLKzW1GiaGXA5PqlfqUh2lNYjuwnr39+llpASUk2yTkVPhmJdLSKgW
         vkw3Nk9mcG8LqS60GiCx2wrZYmpdkeQRtzaQ5XV4SxeL2Zaq9lW2BVpHLGIJl/XFUrqa
         MpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983541; x=1742588341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrdhz+xcjCDmVtdwxSkwlSAeLnoIXiDdRTu+0Lr7nvw=;
        b=HWpUvclrkuVi+9piJ6ThauA1axKALMvO8CIYL4XmklPx9dcbsShGOpvT+ebOwdVcbv
         0yRP+eS2Ct1mxXaJCBEodHFRk7H7/gmqupUpGkMGOUkPdO+f7hTB3qrMJfPetgIz23vp
         pnFkLlJNhafPR/O+TRUkBbVWmV2LjsVCRPMzg67qd2pKgTq2EIFEIe9J5gek7qaKonSg
         ebbgnqB74wiRNj7P6EUcpNFN1fYB+VvX3K/XJkFf8fCT7fkSgMb1UufJc3pekwoQ4oOC
         eybjoKxZFgTTVL1Qxip8V3U/OC8jlsrgxX+xj4MuI4A3Uwmm/EnPPQCxDZ3HiUlnLXei
         3aBA==
X-Gm-Message-State: AOJu0YxMhoT6ZH7SKsS2WGgVXB3A0Go5LLYVJhqR8uBD68ojkwuu0Guc
	6NmymnmN5lWkigFaXFJ3hOhu++keTYaJ1dqdlaIZ+zMdKM0N765TGvSQOelUPTXaqEO02ApAfwf
	1HEg=
X-Gm-Gg: ASbGncv7T1dyV3D7i0/zVQ067Co+eXRzAbDBYxcSKKw5alTSM4pi2xTLbflAmq6svyC
	RVak5vOfGNByo2nJUxFckZO1XIeaTwtzWdrNLysFS3MkeB8dslzaCCSm9sJS/Pbgg93MMOi2kfJ
	JFRufKZsfrKXlwt2tHSx4X/V7JeXUE4YDS1LuITUVIoowkWlFGMuqKoo82hTRMS3O+p+5Ab/55g
	uAzpBmZvRgX2U9/M9xJHC0vybANvk5dWXuhM6p1P76Oarf8HJ1qHCc7f5uMAvOke93LZbeZD4XA
	n3KjhxCUKWOAiWQWza54q2XKWrAp47jKQjAr0I35PVY6L4IpwXweDUVMtCqvFKxGv2tVP0g13m9
	XceXCC7BjIXwkpX6G
X-Google-Smtp-Source: AGHT+IGifYAGE9z++QOmRYHQEg5j/DqSTIH3PdTSiJs1YaDPAHNCNLjFqCtvU5nSJoxYUhpJxDAfvQ==
X-Received: by 2002:ad4:5f4f:0:b0:6e8:9d00:3d71 with SMTP id 6a1803df08f44-6eaeaa2389fmr56486156d6.21.1741983541411;
        Fri, 14 Mar 2025 13:19:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade209369sm27880036d6.2.2025.03.14.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:19:01 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:19:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 13/13] midx: implement writing incremental MIDX bitmaps
Message-ID: <d0d564685bc66df71b4c3ed1093452e58e0f54fd.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

Now that the pack-bitmap machinery has learned how to read and interact
with an incremental MIDX bitmap, teach the pack-bitmap-write.c machinery
(and relevant callers from within the MIDX machinery) to write such
bitmaps.

The details for doing so are mostly straightforward. The main changes
are as follows:

  - find_object_pos() now makes use of an extra MIDX parameter which is
    used to locate the bit positions of objects which are from previous
    layers (and thus do not exist in the current layer's pack_order
    field).

    (Note also that the pack_order field is moved into struct
    write_midx_context to further simplify the callers for
    write_midx_bitmap()).

  - bitmap_writer_build_type_index() first determines how many objects
    precede the current bitmap layer and offsets the bits it sets in
    each respective type-level bitmap by that amount so they can be OR'd
    together.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c                  |  3 +-
 ewah/ewah_bitmap.c                      |  2 +-
 ewah/ewok.h                             |  2 +-
 midx-write.c                            | 57 +++++++++++------
 pack-bitmap-write.c                     | 65 ++++++++++++++-----
 pack-bitmap.c                           | 10 +--
 pack-bitmap.h                           |  4 +-
 t/t5334-incremental-multi-pack-index.sh | 84 +++++++++++++++++++++++++
 8 files changed, 183 insertions(+), 44 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b16126..a7e4bb7904 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1397,7 +1397,8 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_init(&bitmap_writer,
-						   the_repository, &to_pack);
+						   the_repository, &to_pack,
+						   NULL);
 				bitmap_writer_set_checksum(&bitmap_writer, hash);
 				bitmap_writer_build_type_index(&bitmap_writer,
 							       written_list);
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index e92341b8fa..056c410efb 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -399,7 +399,7 @@ int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
 	return ret;
 }
 
-void ewah_or_iterator_free(struct ewah_or_iterator *it)
+void ewah_or_iterator_release(struct ewah_or_iterator *it)
 {
 	free(it->its);
 }
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 4b70641045..c29d354236 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -158,7 +158,7 @@ void ewah_or_iterator_init(struct ewah_or_iterator *it,
 
 int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
 
-void ewah_or_iterator_free(struct ewah_or_iterator *it);
+void ewah_or_iterator_release(struct ewah_or_iterator *it);
 
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
diff --git a/midx-write.c b/midx-write.c
index 48d6558253..0897cbd829 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -647,16 +647,22 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	return pack_order;
 }
 
-static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
-				     struct write_midx_context *ctx)
+static void write_midx_reverse_index(struct write_midx_context *ctx,
+				     const char *object_dir,
+				     unsigned char *midx_hash)
 {
 	struct strbuf buf = STRBUF_INIT;
 	char *tmp_file;
 
 	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
 
-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
-								    ctx->repo->hash_algo));
+	if (ctx->incremental)
+		get_split_midx_filename_ext(ctx->repo->hash_algo, &buf,
+					    object_dir, midx_hash,
+					    MIDX_EXT_REV);
+	else
+		get_midx_filename_ext(ctx->repo->hash_algo, &buf, object_dir,
+				      midx_hash, MIDX_EXT_REV);
 
 	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
 					ctx->entries_nr, midx_hash, WRITE_REV);
@@ -829,22 +835,29 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	return cb.commits;
 }
 
-static int write_midx_bitmap(struct repository *r, const char *midx_name,
+static int write_midx_bitmap(struct write_midx_context *ctx,
+			     const char *object_dir,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
 			     uint32_t commits_nr,
-			     uint32_t *pack_order,
 			     unsigned flags)
 {
 	int ret, i;
 	uint16_t options = 0;
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
-	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
-				    hash_to_hex_algop(midx_hash, r->hash_algo));
+	struct strbuf bitmap_name = STRBUF_INIT;
 
-	trace2_region_enter("midx", "write_midx_bitmap", r);
+	trace2_region_enter("midx", "write_midx_bitmap", ctx->repo);
+
+	if (ctx->incremental)
+		get_split_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
+					    object_dir, midx_hash,
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(ctx->repo->hash_algo, &bitmap_name,
+				      object_dir, midx_hash, MIDX_EXT_BITMAP);
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
@@ -861,7 +874,8 @@ static int write_midx_bitmap(struct repository *r, const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, r, pdata);
+	bitmap_writer_init(&writer, ctx->repo, pdata,
+			   ctx->incremental ? ctx->base_midx : NULL);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, index);
 
@@ -879,7 +893,7 @@ static int write_midx_bitmap(struct repository *r, const char *midx_name,
 	 * bitmap_writer_finish().
 	 */
 	for (i = 0; i < pdata->nr_objects; i++)
-		index[pack_order[i]] = &pdata->objects[i].idx;
+		index[ctx->pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(&writer, commits, commits_nr);
 	ret = bitmap_writer_build(&writer);
@@ -887,14 +901,14 @@ static int write_midx_bitmap(struct repository *r, const char *midx_name,
 		goto cleanup;
 
 	bitmap_writer_set_checksum(&writer, midx_hash);
-	bitmap_writer_finish(&writer, index, bitmap_name, options);
+	bitmap_writer_finish(&writer, index, bitmap_name.buf, options);
 
 cleanup:
 	free(index);
-	free(bitmap_name);
+	strbuf_release(&bitmap_name);
 	bitmap_writer_free(&writer);
 
-	trace2_region_leave("midx", "write_midx_bitmap", r);
+	trace2_region_leave("midx", "write_midx_bitmap", ctx->repo);
 
 	return ret;
 }
@@ -1077,8 +1091,6 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	ctx.repo = r;
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
-	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
-		die(_("cannot write incremental MIDX with bitmap"));
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
@@ -1119,6 +1131,13 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	if (ctx.incremental) {
 		struct multi_pack_index *m = ctx.base_midx;
 		while (m) {
+			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
+				error(_("could not load reverse index for MIDX %s"),
+				      hash_to_hex_algop(get_midx_checksum(m),
+							m->repo->hash_algo));
+				result = 1;
+				goto cleanup;
+			}
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
@@ -1387,7 +1406,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	if (flags & MIDX_WRITE_REV_INDEX &&
 	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
-		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
+		write_midx_reverse_index(&ctx, object_dir, midx_hash);
 
 	if (flags & MIDX_WRITE_BITMAP) {
 		struct packing_data pdata;
@@ -1410,8 +1429,8 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(r, midx_name.buf, midx_hash, &pdata,
-				      commits, commits_nr, ctx.pack_order,
+		if (write_midx_bitmap(&ctx, object_dir,
+				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 34e86d4994..8a30853d2e 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -26,6 +26,8 @@
 #include "alloc.h"
 #include "refs.h"
 #include "strmap.h"
+#include "midx.h"
+#include "pack-revindex.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -43,7 +45,8 @@ static inline int bitmap_writer_nr_selected_commits(struct bitmap_writer *writer
 }
 
 void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
-			struct packing_data *pdata)
+			struct packing_data *pdata,
+			struct multi_pack_index *midx)
 {
 	memset(writer, 0, sizeof(struct bitmap_writer));
 	if (writer->bitmaps)
@@ -51,6 +54,7 @@ void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
 	writer->bitmaps = kh_init_oid_map();
 	writer->pseudo_merge_commits = kh_init_oid_map();
 	writer->to_pack = pdata;
+	writer->midx = midx;
 
 	string_list_init_dup(&writer->pseudo_merge_groups);
 
@@ -113,6 +117,11 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 				    struct pack_idx_entry **index)
 {
 	uint32_t i;
+	uint32_t base_objects = 0;
+
+	if (writer->midx)
+		base_objects = writer->midx->num_objects +
+			writer->midx->num_objects_in_base;
 
 	writer->commits = ewah_new();
 	writer->trees = ewah_new();
@@ -142,19 +151,19 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 
 		switch (real_type) {
 		case OBJ_COMMIT:
-			ewah_set(writer->commits, i);
+			ewah_set(writer->commits, i + base_objects);
 			break;
 
 		case OBJ_TREE:
-			ewah_set(writer->trees, i);
+			ewah_set(writer->trees, i + base_objects);
 			break;
 
 		case OBJ_BLOB:
-			ewah_set(writer->blobs, i);
+			ewah_set(writer->blobs, i + base_objects);
 			break;
 
 		case OBJ_TAG:
-			ewah_set(writer->tags, i);
+			ewah_set(writer->tags, i + base_objects);
 			break;
 
 		default:
@@ -207,19 +216,37 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
-	struct object_entry *entry = packlist_find(writer->to_pack, oid);
+	struct object_entry *entry;
+
+	entry = packlist_find(writer->to_pack, oid);
+	if (entry) {
+		uint32_t base_objects = 0;
+		if (writer->midx)
+			base_objects = writer->midx->num_objects +
+				writer->midx->num_objects_in_base;
+
+		if (found)
+			*found = 1;
+		return oe_in_pack_pos(writer->to_pack, entry) + base_objects;
+	} else if (writer->midx) {
+		uint32_t at, pos;
+
+		if (!bsearch_midx(oid, writer->midx, &at))
+			goto missing;
+		if (midx_to_pack_pos(writer->midx, at, &pos) < 0)
+			goto missing;
 
-	if (!entry) {
 		if (found)
-			*found = 0;
-		warning("Failed to write bitmap index. Packfile doesn't have full closure "
-			"(object %s is missing)", oid_to_hex(oid));
-		return 0;
+			*found = 1;
+		return pos;
 	}
 
+missing:
 	if (found)
-		*found = 1;
-	return oe_in_pack_pos(writer->to_pack, entry);
+		*found = 0;
+	warning("Failed to write bitmap index. Packfile doesn't have full closure "
+		"(object %s is missing)", oid_to_hex(oid));
+	return 0;
 }
 
 static void compute_xor_offsets(struct bitmap_writer *writer)
@@ -586,7 +613,7 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue tree_queue = { NULL };
 	struct bitmap_index *old_bitmap;
-	uint32_t *mapping;
+	uint32_t *mapping = NULL;
 	int closed = 1; /* until proven otherwise */
 
 	if (writer->show_progress)
@@ -1021,7 +1048,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 	off_t *offsets = NULL;
-	uint32_t i;
+	uint32_t i, base_objects;
 
 	struct bitmap_disk_header header;
 
@@ -1047,6 +1074,12 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, writer->to_pack->nr_objects);
 
+	if (writer->midx)
+		base_objects = writer->midx->num_objects +
+			writer->midx->num_objects_in_base;
+	else
+		base_objects = 0;
+
 	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *stored = &writer->selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
@@ -1055,7 +1088,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 		if (commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
-		stored->commit_pos = commit_pos;
+		stored->commit_pos = commit_pos + base_objects;
 	}
 
 	write_selected_commits_v1(writer, f, offsets);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5e6d4ace58..94d1e8474a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1719,7 +1719,7 @@ static void show_objects_for_type(
 		}
 	}
 
-	ewah_or_iterator_free(&it);
+	ewah_or_iterator_release(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1808,7 +1808,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
-	ewah_or_iterator_free(&it);
+	ewah_or_iterator_release(&it);
 	bitmap_free(tips);
 }
 
@@ -1903,7 +1903,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
-	ewah_or_iterator_free(&it);
+	ewah_or_iterator_release(&it);
 	bitmap_free(tips);
 }
 
@@ -2552,7 +2552,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
-	ewah_or_iterator_free(&it);
+	ewah_or_iterator_release(&it);
 
 	return count;
 }
@@ -3133,7 +3133,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
-	ewah_or_iterator_free(&it);
+	ewah_or_iterator_release(&it);
 
 	return total;
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d7f4b8b8e9..dd0951088f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -111,6 +111,7 @@ struct bitmap_writer {
 
 	kh_oid_map_t *bitmaps;
 	struct packing_data *to_pack;
+	struct multi_pack_index *midx; /* if appending to a MIDX chain */
 
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
@@ -125,7 +126,8 @@ struct bitmap_writer {
 };
 
 void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
-			struct packing_data *pdata);
+			struct packing_data *pdata,
+			struct multi_pack_index *midx);
 void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1);
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 26257e5660..46d1f0b864 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -44,4 +44,88 @@ test_expect_success 'convert incremental to non-incremental' '
 
 compare_results_with_midx 'non-incremental MIDX conversion'
 
+write_midx_layer () {
+	n=1
+	if test -f $midx_chain
+	then
+		n="$(($(wc -l <$midx_chain) + 1))"
+	fi
+
+	for i in 1 2
+	do
+		test_commit $n.$i &&
+		git repack -d || return 1
+	done &&
+	git multi-pack-index write --bitmap --incremental
+}
+
+test_expect_success 'write initial MIDX layer' '
+	git repack -ad &&
+	write_midx_layer
+'
+
+test_expect_success 'read bitmap from first MIDX layer' '
+	git rev-list --test-bitmap 1.2
+'
+
+test_expect_success 'write another MIDX layer' '
+	write_midx_layer
+'
+
+test_expect_success 'midx verify with multiple layers' '
+	git multi-pack-index verify
+'
+
+test_expect_success 'read bitmap from second MIDX layer' '
+	git rev-list --test-bitmap 2.2
+'
+
+test_expect_success 'read earlier bitmap from second MIDX layer' '
+	git rev-list --test-bitmap 1.2
+'
+
+test_expect_success 'show object from first pack' '
+	git cat-file -p 1.1
+'
+
+test_expect_success 'show object from second pack' '
+	git cat-file -p 2.2
+'
+
+for reuse in false single multi
+do
+	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
+		rm -fr clone.git &&
+
+		git config pack.allowPackReuse $reuse &&
+		git clone --no-local --bare . clone.git
+	'
+done
+
+test_expect_success 'relink existing MIDX layer' '
+	rm -fr "$midxdir" &&
+
+	GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap &&
+
+	midx_hash="$(test-tool read-midx --checksum $objdir)" &&
+
+	test_path_is_file "$packdir/multi-pack-index" &&
+	test_path_is_file "$packdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_file "$packdir/multi-pack-index-$midx_hash.rev" &&
+
+	test_commit another &&
+	git repack -d &&
+	git multi-pack-index write --bitmap --incremental &&
+
+	test_path_is_missing "$packdir/multi-pack-index" &&
+	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_missing "$packdir/multi-pack-index-$midx_hash.rev" &&
+
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.midx" &&
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.bitmap" &&
+	test_path_is_file "$midxdir/multi-pack-index-$midx_hash.rev" &&
+	test_line_count = 2 "$midx_chain"
+
+'
+
 test_done
-- 
2.49.0.13.gd0d564685b
