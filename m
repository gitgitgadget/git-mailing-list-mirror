Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1E226D14
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493395; cv=none; b=rWu9KM3cP7bngrZbHrDRIWZJUQ8VwUnTYsnB+y7tZOUY/uQOmlsliI/83BLMqj+oJHy5Ytzj7P2fITij4ZJYOTBnYGBPzEbCuA6IGT4oF3MDTM+p/OLyJMp7LN0UlKgblqW/KK10SotnWKf49UTJ+6jj5Ask8fEm5vaa2CIWLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493395; c=relaxed/simple;
	bh=/iu2sLQgyJEc7KczN4fg/h+T5UJVmCh3HJ7VrCGQU0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc2ZcQREoa/zT6bDUzZEdAK9tikarOT1XauStvJxe0HNYAuQR5c1mVn9ATPkMgba30UVzUwRe951w+aefQTMXi8nuC/ikeLOLUR2fL6BrMU1JLvZNxd/1qslduN5u3O9ea8ZuVBL8TseCI8uc2/5RsHwYWXqtAjGb/d5TfD5774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vTA2PsSC; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vTA2PsSC"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47692b9d059so15341461cf.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493393; x=1743098193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okeut1hGQOfrMJhKwahTjs3IcdAeJwbz5BeZIM/0gqg=;
        b=vTA2PsSCpA48FmxAErwsIZiMDampg2/1p/7Utwhbg34MPfHHv3sD2I9FyIagUpPOJZ
         cggaZSBeWwHfIsR7el1G6A4QQPyb6uItv6YlfFXqjK9qTGYoocBN9eskiQp5UFEoaYrn
         lyNJN+yHpi+BOZWRDoBJJkzjnz0o6Bw0GgkrPxAbzbJ16wdAYy/+/WU09qn6cb4g656X
         tNOAnWynNYkT9Oj2vhxis+iAWe8Q3Rq+DwNbMNwpVS2BbcqssDmsCoKnd1VAiZGjXy6d
         dqzPnxWrtMObjd/uzYGyuFdYr6J/mqFzQkdkx3nBk8laDCo/l3yhrzUKr3LsoIh5GOD8
         WEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493393; x=1743098193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okeut1hGQOfrMJhKwahTjs3IcdAeJwbz5BeZIM/0gqg=;
        b=pFdpkBVLldkEJ8q3hr607essjfRsXVYsRpoIS75g8eOLNpZwGDgIF5SmXkj3dRTop6
         9cYVOcqd6vM0kmig3qF8tChw3PHv/gJHuWZWw2gcMttV7NpptHCAvpCSGBoVj/J/NAGZ
         4XSj4Fqe38GCbKIJ7Z0XNJPCLSpUmxngAMoG/eircPIvAcOckerwhYx4crpySemDspwO
         B/XCBJJfc+TwZFEfC/UqAt3Y0ciF7482Bkj/m4jIpnA/2+WcvKUiIGk+gj+KgWD9Gfyk
         MlndY/FrGJ1o5ftArJjyHIU023LzgMA39CoHek3JJqLsYoMsafwHQtJybmP+onfIpAGy
         f+Gg==
X-Gm-Message-State: AOJu0YyKkl6BhtkYDC60kC6ti74OEoscPgBR1j/aZUlMyv5eRA7rt8+j
	JsN8lYu2m8I5z5k4Vft3nDScfa6lw+g/wrR3CDBVGlkbGcZhKfLcz17W3240lGfZL2y2vBPHn5t
	bl3Q=
X-Gm-Gg: ASbGncsx+ZrCbHHxmmCMvBGLe57dywMdzocFp07i6sdwYsewa3gcpr4uQ05ZOfJzWoi
	+MpCDMRffFZ1zWB0uy5Ed79LoM4KJqA2b6p7VgMQSV5Qp03Ia9qVx0gKKonYjUiht7GwpHrssjT
	7w1eNw3U32nMs1WOFYOOZBtFMmjXaqzKIZ7SeJiVL59o35NXClTHaBhCkzOLZQn8sjcTxadXReM
	Y7vg7j3bAW0TgHAgl3IWFyWiJvqqOfpMJk5H0d4FvHPdec+BFMPQBc0+PKJO0sxCQtpGHSlRIpU
	Aa3dqyKY7lEw8YqaS0C0eZHPOzD5YgwtikW6Drfq094dYNjNHB5ecJZzetPruFMcuQsCDRhwl26
	Fm8iSls5APEukJOWE
X-Google-Smtp-Source: AGHT+IFMehXMs8yRuNtaY5HdvqW4NHAqrl2n/Rqby0TY8Rk+KtdiG+thEbuzOMUGSpsdq5PGtk6lJQ==
X-Received: by 2002:a05:622a:5509:b0:476:6e2e:58b with SMTP id d75a77b69052e-4771de8e1a0mr3592181cf.49.1742493392715;
        Thu, 20 Mar 2025 10:56:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d15a081sm1541211cf.9.2025.03.20.10.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:32 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 03/14] pack-revindex: prepare for incremental MIDX bitmaps
Message-ID: <5eac0d1485019179cde4f8b010ac64ee7eb3cd3f.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Prepare the reverse index machinery to handle object lookups in an
incremental MIDX bitmap. These changes are broken out across a few
functions:

  - load_midx_revindex() learns to use the appropriate MIDX filename
    depending on whether the given 'struct multi_pack_index *' is
    incremental or not.

  - pack_pos_to_midx() and midx_to_pack_pos() now both take in a global
    object position in the MIDX pseudo-pack order, and find the
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
 pack-bitmap.c   | 43 +++++++++++++++++++++++++++++++------------
 pack-revindex.c | 34 +++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6406953d32..87f3b5cf4d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 	return read_bitmap(index->map, index->map_size, &index->map_pos);
 }
 
+static uint32_t bitmap_num_objects_total(struct bitmap_index *index)
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
+		return bitmap_pos + bitmap_num_objects_total(bitmap_git);
 	}
 
 	return -1;
@@ -992,7 +1001,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_num_objects(bitmap_git);
+	return bitmap_pos + bitmap_num_objects_total(bitmap_git);
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
@@ -1500,7 +1515,9 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
+		if (!bitmap_get(objects,
+				st_add(bitmap_num_objects_total(bitmap_git),
+				       i)))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1679,7 +1696,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
+		size_t pos = st_add(i, bitmap_num_objects_total(bitmap_git));
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -1705,7 +1722,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < bitmap_num_objects(bitmap_git)) {
+	if (pos < bitmap_num_objects_total(bitmap_git)) {
 		struct packed_git *pack;
 		off_t ofs;
 
@@ -1728,8 +1745,9 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			die(_("unable to get size of %s"), oid_to_hex(&oid));
 		}
 	} else {
+		size_t eindex_pos = pos - bitmap_num_objects_total(bitmap_git);
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
+		struct object *obj = eindex->objects[eindex_pos];
 		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
 					     &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
@@ -1882,7 +1900,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 	uint32_t objects_nr;
 	size_t i, pos;
 
-	objects_nr = bitmap_num_objects(bitmap_git);
+	objects_nr = bitmap_num_objects_total(bitmap_git);
 	pos = objects_nr / BITS_IN_EWORD;
 
 	if (pos > result->word_alloc)
@@ -2419,7 +2437,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(objects,
-			       st_add(bitmap_num_objects(bitmap_git), i)))
+			       st_add(bitmap_num_objects_total(bitmap_git), i)))
 			count++;
 	}
 
@@ -2820,7 +2838,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
 
-	num_objects = bitmap_num_objects(bitmap_git);
+	num_objects = bitmap_num_objects_total(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -2963,7 +2981,8 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 		struct object *obj = eindex->objects[i];
 
 		if (!bitmap_get(result,
-				st_add(bitmap_num_objects(bitmap_git), i)))
+				st_add(bitmap_num_objects_total(bitmap_git),
+				       i)))
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
2.49.0.14.g88b49c1b34

