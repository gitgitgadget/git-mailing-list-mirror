Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE051D3656
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054047; cv=none; b=lpb3c+ShUWREN9ey87lNXF5o8LYoPSP2I9HyHdFDhVq5ZiauUderC/IHwzOXuEbn+CKmHGVgYlYzEG2xEHWuWrGlkJ95OP9+yvPAwH43jUtr3A/LItHSaRubKfDhp5Q2VJhn5bin5T5EJON6fs24ZKdJtJC80OwUx/3CbtLyAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054047; c=relaxed/simple;
	bh=ajYfkR4Iq3arnjSMvwRBQqpRxd3UcEaOLOsDswT373I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQvG8nFEv3Xux7GTXT9Z9A6+RLBuEGujk+numW3+baqJqfT8qSmeEVGr+6uPibKKi1wwj081Q74TIOJ5rjgXns3xEe7vhIYt6K818SX9UVL+NlvMIGfEsv37Ctz8nCuneADe/YHDo1F9g+LGdF4AzpEXQdH4OW98+4D2X/vmzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tsXCGQDw; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tsXCGQDw"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ee55cfa88cso13907487b3.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054044; x=1732658844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ydn/gki/FN6aAjjruqHw5OGRDks+E/b15nEzT0kqyQ=;
        b=tsXCGQDw24W9CR9ooZcjYLMcYs2fk5rYplZhos0uZik5sBKVqKVaeOPmI9drn55U7Q
         0foFvjUwrzmowqKlECt3RwYWvscQMUDBdwBZ9H21bELYFVzCJ6FgHk4hRP2a9jbtJR6E
         u1yWxC6rmffgvk2J0D1ngstTpQZnlYpij4MYTtcXCH6UGWxFtITXBc9xRRqsLto3TApv
         Eq/PSoSyO1NXiS2XbmJH6BPBKqL703wa+Ys5ava464IOniWg3wQ6b7JTs346mgVkfRwL
         aVfVxgjNDVXxdmNgRD2v3r3O3VBybhPNvCCFetp5hXs50V/Eav5xFKQ0LuLc3kN6LAUW
         KBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054044; x=1732658844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ydn/gki/FN6aAjjruqHw5OGRDks+E/b15nEzT0kqyQ=;
        b=wImFpb9Fjzi1xMgel5KjbBjzcrq0WT9Jkyb9Nwa+pGGggTzn1cGeFArBCl+Cd+qME6
         ATJSLjg27BgQoCjKUT/5Nm4U6vQ319/IFQHhNx08fAWXMqO2twhjgsVzz4m9fn8WT9iE
         2ZZpTgzbupR+nh/y35t22AAfRVxIK+hqYhya/TVF7F4VwhcBKPOrbAbnBZaskS/KaYOJ
         nKYIcAhf82ZtYeQmTg8m7oV/yYAauPM009SFFHXLFt2tVdIdkue1a20QElm1+OaHWAs1
         Fq3Twd2caAGaif+b3btoPgtKCpvZXsa8lakmMH8CbqbCdTqS4TIoW9eW9AUvNQ4BiwPQ
         u8aA==
X-Gm-Message-State: AOJu0YwTVO7thKRbnYhujs6xetviOyxeWKSIP7h4dkjmOrQk5CArBSjP
	/Yswe+BE12bJXehHPdPcAN6wLTXwVPZF3fGpP2Ejh8r4sqi75uwB7Z9bzhYe3A5lDBz6DR4vvJI
	EOWA=
X-Google-Smtp-Source: AGHT+IGgYSylBRr+eoLSRwEkVkG779LgFwDsngccA7K3GxvlEtwukVyozLuhNjs9VKaRBvfQ94wdwQ==
X-Received: by 2002:a05:690c:6312:b0:6ee:9b1d:912c with SMTP id 00721157ae682-6eebd135e50mr6462977b3.22.1732054044334;
        Tue, 19 Nov 2024 14:07:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee713805c7sm19306617b3.126.2024.11.19.14.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:23 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/13] pack-revindex: prepare for incremental MIDX bitmaps
Message-ID: <b902513f43697e94976c1baf5598222fe2e3b847.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

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
 pack-bitmap.c   | 30 ++++++++++++++++++++----------
 pack-revindex.c | 32 +++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4fa9dfc771a..bba9c6a905a 100644
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
@@ -925,7 +934,7 @@ static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 
 	if (pos < kh_end(positions)) {
 		int bitmap_pos = kh_value(positions, pos);
-		return bitmap_pos + bitmap_num_objects(bitmap_git);
+		return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
 	}
 
 	return -1;
@@ -993,7 +1002,7 @@ static int ext_index_add_object(struct bitmap_index *bitmap_git,
 		bitmap_pos = kh_value(eindex->positions, hash_pos);
 	}
 
-	return bitmap_pos + bitmap_num_objects(bitmap_git);
+	return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
 }
 
 struct bitmap_show_data {
@@ -1498,7 +1507,8 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		struct object *obj;
 
-		if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap_git), i)))
+		if (!bitmap_get(objects,
+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			continue;
 
 		obj = eindex->objects[i];
@@ -1677,7 +1687,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * them individually.
 	 */
 	for (i = 0; i < eindex->count; i++) {
-		size_t pos = st_add(i, bitmap_num_objects(bitmap_git));
+		size_t pos = st_add(i, bitmap_non_extended_bits(bitmap_git));
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(to_filter, pos) &&
 		    !bitmap_get(tips, pos))
@@ -1703,7 +1713,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 
 	oi.sizep = &size;
 
-	if (pos < bitmap_num_objects(bitmap_git)) {
+	if (pos < bitmap_non_extended_bits(bitmap_git)) {
 		struct packed_git *pack;
 		off_t ofs;
 
@@ -1726,7 +1736,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 		}
 	} else {
 		struct eindex *eindex = &bitmap_git->ext_index;
-		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
+		struct object *obj = eindex->objects[pos - bitmap_non_extended_bits(bitmap_git)];
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
 	}
@@ -1878,7 +1888,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 	uint32_t objects_nr;
 	size_t i, pos;
 
-	objects_nr = bitmap_num_objects(bitmap_git);
+	objects_nr = bitmap_non_extended_bits(bitmap_git);
 	pos = objects_nr / BITS_IN_EWORD;
 
 	if (pos > result->word_alloc)
@@ -2403,7 +2413,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(objects,
-			       st_add(bitmap_num_objects(bitmap_git), i)))
+			       st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			count++;
 	}
 
@@ -2802,7 +2812,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
 
-	num_objects = bitmap_num_objects(bitmap_git);
+	num_objects = bitmap_non_extended_bits(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -2945,7 +2955,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 		struct object *obj = eindex->objects[i];
 
 		if (!bitmap_get(result,
-				st_add(bitmap_num_objects(bitmap_git), i)))
+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
diff --git a/pack-revindex.c b/pack-revindex.c
index 22d3c234648..ce3f7ae2149 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -383,8 +383,12 @@ int load_midx_revindex(struct multi_pack_index *m)
 	trace2_data_string("load_midx_revindex", the_repository,
 			   "source", "rev");
 
-	get_midx_filename_ext(&revindex_name, m->object_dir,
-			      get_midx_checksum(m), MIDX_EXT_REV);
+	if (m->has_chain)
+		get_split_midx_filename_ext(&revindex_name, m->object_dir,
+					    get_midx_checksum(m), MIDX_EXT_REV);
+	else
+		get_midx_filename_ext(&revindex_name, m->object_dir,
+				      get_midx_checksum(m), MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(revindex_name.buf,
 				      m->num_objects,
@@ -471,11 +475,15 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 
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
@@ -491,7 +499,8 @@ static int midx_pack_order_cmp(const void *va, const void *vb)
 	const struct midx_pack_key *key = va;
 	struct multi_pack_index *midx = key->midx;
 
-	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
+	size_t pos = (uint32_t*)vb - (const uint32_t *)midx->revindex_data;
+	uint32_t versus = pack_pos_to_midx(midx, pos + midx->num_objects_in_base);
 	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
 	off_t versus_offset;
 
@@ -529,9 +538,9 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
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
@@ -551,7 +560,8 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 	if (!found)
 		return -1;
 
-	*pos = found - m->revindex_data;
+	*pos = (found - m->revindex_data) + m->num_objects_in_base;
+
 	return 0;
 }
 
@@ -559,9 +569,13 @@ int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
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
2.47.0.301.g77ddd1170f9

