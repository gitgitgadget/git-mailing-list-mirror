Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5E205E17
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983509; cv=none; b=EgwpFyycc9NH6XuHgsezyRGrFcDjdoSXlPIevrEOxp2C9ub3Z0bVmw7b/V5jnxVVwghV3tT8+K/tBXzVluaAUevBa4Lyo/qMoEFld0iOyNnFNql8Cz7TOkXJApgQIeJUxEZ2M9xIq3x9aGgaArsVdPfmIbDE0tuNRCG+axcr1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983509; c=relaxed/simple;
	bh=6N1CTIKrsKC5cvhYIaqm4sSYdzqklDeMxdf3KW46VIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCqsQYAQ7x8HC9Rjpg+BBgyEX7sc6p53eXNyyCO5VdXLt5/dGkdZjDk+2T4m0KkmSUhhWqVycNYGTVu+g3zWuBetbSaUNiaIpu5rV3v1gDX/2qRDMTTpruFcO/p7Q+46kBLKSP3Mdgg1ExNHwisoGTP2tHdnzrSz868kQML1knk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tvDZnZbT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tvDZnZbT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46fcbb96ba9so34271711cf.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983506; x=1742588306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nsJ9+y6/1BFnZefRuXSAAvlsgqb00kumJyoESlQw1s=;
        b=tvDZnZbTER6fqmugabXHGMAwh3453rTyWTdZ8HCKFstP1szxrJV5e8YiCYB25g36LW
         VADtgh4xqkI3QW2zx9l2Hj//XGqIW7xGlaKRY2aZK4EYqRnj02l/Ve25R3PwtAB8ATkW
         Da4av4FQPGaRovqvG2eMEDsfzQ7vQADAmUIVBhpAVMcXQkXOhe3RduvRx1ktaXdtXOUm
         /KjoQt/eDsafBwSQTySmjOLMZB6Y0dbgObgoxZ2WcrMp1u3uAb35DKKvE4gGl4aIFZfX
         sB3jd8x7FSnymR1z1F92+UP2ruBBZbeoGt3XnD8yz99DFoIQx4v5PfpFzmo0NLN/wdpp
         GcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983506; x=1742588306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nsJ9+y6/1BFnZefRuXSAAvlsgqb00kumJyoESlQw1s=;
        b=ixFMF2A6j76OnTWAAYZMQsjZyvJhIT0lAPQhm/fhT+qA7e7dGOj5uCLNICbNWoDjfP
         6+ifCXAr5Q3mKImV+e9YqaGM3QTVlePFT6er0rxlclND0SGs+nqhLdRsLpkj4iBWnofI
         opIFCMmiGWL0bwv4YvmUHesQpgchRTRVesZDf2BI8RAVJ9hQbCWQpZLhckZ9FznqCNc4
         i9mork7G6QhBNPUCCFG5o7MDlLfEn5XV2tIzD1HvG2HCbXjUWdjWkEWZoSDNQ6x3NDFN
         vaO5FnD4/OJPjME+8X4GMHJ+sQQtY6XIVtBlcLQM9thpKfv1bqh1U8jqYEwNWSGHU/8n
         2Nng==
X-Gm-Message-State: AOJu0YxsN6dVY6Rkr6e7gUyaPF3icV0KG8UA5EX0xZHRBknVUWLNAjrw
	UzPmDexBzNZnd/OOi4uxcV7RbRFpua8YRlhuAxps5hRDYoEv4AXzPk/5YmLCePsAz4xXwu3R1se
	hi+k=
X-Gm-Gg: ASbGncvXPSNeGinXASQIg2MEKzp3GjpA/Ei+duEUaN4u4oXv37dWabUW4GabDxJZ5WJ
	aSAoT+89X8r3YV2XF6GnXBIRfD7yFAtp7lnkduOtwEEntWr/cjZqgWaVFF/0rDnNB6NOOoJgI+v
	oMqp5xgU1ypXzvo4vYGboYqDYEDX1igIeMMy944RTehcSG+DpLiOplXh+bwQl/9ZRp/kzK0crM0
	uJxQP6TLSnV1KW4Zkx34AdfhKuMoiB3vuv/ox1Ecp9NyeGoZKSnU7lOuMWZp5LSFcX6MGgeb83A
	1eYemXg4kGhCnPVAwXnhV38XAAN1RSS/2iDfrIW+ef7MyvKmKm/7G4QvWQP21DS7DnB8LRYCsz5
	BSd7h+mmTCeOlQpI2
X-Google-Smtp-Source: AGHT+IGLMNsDlFRQpB/UIX4ZWEL90qRvJicTSza/iV6GP8i2BAYPpETqA2FVVKnwqNJ/XPI/mY9DvA==
X-Received: by 2002:a05:6214:dab:b0:6e2:4859:f062 with SMTP id 6a1803df08f44-6eaeaa4cf43mr61112086d6.21.1741983505658;
        Fri, 14 Mar 2025 13:18:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade34c5d6sm27683056d6.111.2025.03.14.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:25 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX bitmaps
Message-ID: <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
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

Prepare the reverse index machinery to handle object lookups in an
incremental MIDX bitmap. These changes are broken out across a few
functions:

  - load_midx_revindex() learns to use the appropriate MIDX filename
    depending on whether the given 'struct multi_pack_index *' is
    incremental or not.

  - pack_pos_to_midx() and midx_to_pack_pos() now both take in a global
    object position in the MIDX pseudo-pack order, and finds the
    earliest containing MIDX (similar to midx.c::midx_for_object().

  - midx_pack_order_cmp() adjusts its call to pack_pos_to_midx() by the
    number of objects in the base (since 'vb - midx->revindx_data' is
    relative to the containing MIDX, and pack_pos_to_midx() expects a
    global position).

    Likewise, this function adjusts its output by adding
    m->num_objects_in_base to return a global position out through the
    `*pos` pointer.

Together, these changes are sufficient to use the multi-pack index's
reverse index format for incremental multi-pack reachability bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c   | 40 ++++++++++++++++++++++++++++------------
 pack-revindex.c | 34 +++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6406953d32..c26d85b5db 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 	return read_bitmap(index->map, index->map_size, &index->map_pos);
 }
 
+static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
+{
+	if (index->midx) {
+		struct multi_pack_index *m = index->midx;
+		return m->num_objects + m->num_objects_in_base;
+	}
+	return index->pack->num_objects;
+}
+
 static uint32_t bitmap_num_objects(struct bitmap_index *index)
 {
 	if (index->midx)
@@ -924,7 +933,7 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_num_objects(bitmap_git);
+		return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
 	}
 
 	return -1;
@@ -992,7 +1001,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_num_objects(bitmap_git);
+	return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
 }
 
 struct bitmap_show_data {
@@ -1342,11 +1351,17 @@ struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_g
 		if (pos < 0 || pos >= bitmap_num_objects(bitmap_git))
 			goto done;
 
+		/*
+		 * Use bitmap-relative positions instead of offsetting
+		 * by bitmap_git->num_objects_in_base because we use
+		 * this to find a match in pseudo_merge_for_parents(),
+		 * and pseudo-merge groups cannot span multiple bitmap
+		 * layers.
+		 */
 		bitmap_set(parents, pos);
 	}
 
-	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges,
-						parents);
+	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges, parents);
 
 done:
 	bitmap_free(parents);
@@ -1500,7 +1515,8 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
+		if (!bitmap_get(objects,
+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1679,7 +1695,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
+		size_t pos = st_add(i, bitmap_non_extended_bits(bitmap_git));
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -1705,7 +1721,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < bitmap_num_objects(bitmap_git)) {
+	if (pos < bitmap_non_extended_bits(bitmap_git)) {
 		struct packed_git *pack;
 		off_t ofs;
 
@@ -1729,7 +1745,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		}
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
+		struct object *obj = eindex->objects[pos - bitmap_non_extended_bits(bitmap_git)];
 		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
 					     &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
@@ -1882,7 +1898,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 	uint32_t objects_nr;
 	size_t i, pos;
 
-	objects_nr = bitmap_num_objects(bitmap_git);
+	objects_nr = bitmap_non_extended_bits(bitmap_git);
 	pos = objects_nr / BITS_IN_EWORD;
 
 	if (pos > result->word_alloc)
@@ -2419,7 +2435,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(objects,
-			       st_add(bitmap_num_objects(bitmap_git), i)))
+			       st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			count++;
 	}
 
@@ -2820,7 +2836,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
 
-	num_objects = bitmap_num_objects(bitmap_git);
+	num_objects = bitmap_non_extended_bits(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -2963,7 +2979,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 		struct object *obj = eindex->objects[i];
 
 		if (!bitmap_get(result,
-				st_add(bitmap_num_objects(bitmap_git), i)))
+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			continue;
 
 		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
diff --git a/pack-revindex.c b/pack-revindex.c
index d3832478d9..d3faab6a37 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -383,8 +383,14 @@ int load_midx_revindex(struct multi_pack_index *m)
 	trace2_data_string("load_midx_revindex", the_repository,
 			   "source", "rev");
 
-	get_midx_filename_ext(m->repo->hash_algo, &revindex_name, m->object_dir,
-			      get_midx_checksum(m), MIDX_EXT_REV);
+	if (m->has_chain)
+		get_split_midx_filename_ext(m->repo->hash_algo, &revindex_name,
+					    m->object_dir, get_midx_checksum(m),
+					    MIDX_EXT_REV);
+	else
+		get_midx_filename_ext(m->repo->hash_algo, &revindex_name,
+				      m->object_dir, get_midx_checksum(m),
+				      MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(revindex_name.buf,
 				      m->num_objects,
@@ -471,11 +477,15 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 
 uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
 {
+	while (m && pos < m->num_objects_in_base)
+		m = m->base_midx;
+	if (!m)
+		BUG("NULL multi-pack-index for object position: %"PRIu32, pos);
 	if (!m->revindex_data)
 		BUG("pack_pos_to_midx: reverse index not yet loaded");
-	if (m->num_objects <= pos)
+	if (m->num_objects + m->num_objects_in_base <= pos)
 		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
-	return get_be32(m->revindex_data + pos);
+	return get_be32(m->revindex_data + pos - m->num_objects_in_base);
 }
 
 struct midx_pack_key {
@@ -491,7 +501,8 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 	const struct midx_pack_key *key = va;
 	struct multi_pack_index *midx = key->midx;
 
-	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
+	size_t pos = (uint32_t *)vb - (const uint32_t *)midx->revindex_data;
+	uint32_t versus = pack_pos_to_midx(midx, pos + midx->num_objects_in_base);
 	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
 	off_t versus_offset;
 
@@ -529,9 +540,9 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 {
 	uint32_t *found;
 
-	if (key->pack >= m->num_packs)
+	if (key->pack >= m->num_packs + m->num_packs_in_base)
 		BUG("MIDX pack lookup out of bounds (%"PRIu32" >= %"PRIu32")",
-		    key->pack, m->num_packs);
+		    key->pack, m->num_packs + m->num_packs_in_base);
 	/*
 	 * The preferred pack sorts first, so determine its identifier by
 	 * looking at the first object in pseudo-pack order.
@@ -551,7 +562,8 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 	if (!found)
 		return -1;
 
-	*pos = found - m->revindex_data;
+	*pos = (found - m->revindex_data) + m->num_objects_in_base;
+
 	return 0;
 }
 
@@ -559,9 +571,13 @@ int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
 {
 	struct midx_pack_key key;
 
+	while (m && at < m->num_objects_in_base)
+		m = m->base_midx;
+	if (!m)
+		BUG("NULL multi-pack-index for object position: %"PRIu32, at);
 	if (!m->revindex_data)
 		BUG("midx_to_pack_pos: reverse index not yet loaded");
-	if (m->num_objects <= at)
+	if (m->num_objects + m->num_objects_in_base <= at)
 		BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, at);
 
 	key.pack = nth_midxed_pack_int_id(m, at);
-- 
2.49.0.13.gd0d564685b

