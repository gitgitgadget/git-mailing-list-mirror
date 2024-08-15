Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424E1552EE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760940; cv=none; b=UBvk/yl4A3EhEnLA6/c7KBdrE0OLmxqEsmSsN9dMb6cXtDK84OY+vDDOa748BMn1iHXpj9eAclI446Br4+sMKDzS7Zm5uvj7ApLJEJZq1L9tbFyXgBNvl8UoeoALcxO9DAFc63cCozWsFO5LfeJUbC96ZGAqkLt7Tros0o4Xzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760940; c=relaxed/simple;
	bh=ilh/z9+rVIxGj/lPNfJG41yrKZe1FjE1tzFQ0hjWiEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtKtnQrDZN5Tr9nxaudG2mhAenvFWFngxEPORqsF3UlpUN4tinctssq8YkQJOxaUQM4wSG8uFwn7TK8su2jWE5jud362xLpF+ecBWo9cze4P1+D3ve85A6nrmb8zfqwbN8NUqm5XXLwQnHpDjmc9mENyKqfirgkw0rdl/Lf5qmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iO2MT6kL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iO2MT6kL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-68518bc1407so15652497b3.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760937; x=1724365737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdO5rpfaE/UAjBShy8CXkYYFcFh8jX1HTqxdCfoZyPI=;
        b=iO2MT6kL4i8z+4ZT9FNqV24T/i5sTAhI5BIGiOwmKcuWHPXZ1D/MQ/3Irx+XtoiX2f
         CZZHGgxDuOIFX8jg00RnIRKQdF1LtId7JQKdZOKSPnRafmfvbQoJZkyru/gySQzkIuwq
         xzVmJYHhh5JCDhA2OcB2DAP2/Cl16wZFgkG5nXpd5UVjrDecWxOM7g+dwcSttOSrKy2j
         OrDYd8uboV+mIw664qShCy1W97A3JUjN+w2K8OKePWcyahjq6Hq1ZqYgm+a1BJpS2p2h
         e3xH9mTyGxaPhHxibylr9OZXu0OIYVOzjl89IwZzCx46Gf6jEQBCBl1b1d1AE50ZzWse
         GO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760937; x=1724365737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdO5rpfaE/UAjBShy8CXkYYFcFh8jX1HTqxdCfoZyPI=;
        b=SCUwZd5adg2VOFw2nUypeDzJhE7TyGAvboxNMV0+nQsTdXkJIT81DmuuIT7dPymY3K
         HfiT1Xa4krlLtMxazQH3Wd87cycbAUZ3QAlTf1tlmfqu9Z7nwl2w85vzs5Hvxs8LhhCZ
         8KiR7S5gVYyBkMbC3xZs35YHmACLL8E56FlA+vMpvEy4cjjwmus+eCfFFR2fz0h/yun1
         /kRcSEpIa3ET1333cQb42KzY1gwiWL+RZ9he7vOppwYoSNc4jjuIWRzapJMHV/xfIcI3
         Bti4xvXkU94Asr/UtONlgej1Ha7K1VtwpluIO/ziSdlQUQ9eEKa7pEcCIAmoATl1z2cV
         fRsQ==
X-Gm-Message-State: AOJu0YxR+r93TbLDr4tJ9Q0pENjR0FwsaTZrSsepkU/HVJE9/MOGmmi3
	ob6eoN7POFKetmr98uklQEU50HTrUD8pI3AsGaZ1GuLIs8VNUh+5oLTcIYFJJBykIgCRyqQQyCq
	L
X-Google-Smtp-Source: AGHT+IFtWA19eS9SzFCGMGOQivlPwbcaTkidplfeftPqOK1E+y7Nh6wpP35Pqd9VZErb0X7VK+Fktg==
X-Received: by 2002:a05:690c:c8c:b0:6ad:f6ae:768b with SMTP id 00721157ae682-6b1bdb2193bmr13097887b3.31.1723760937219;
        Thu, 15 Aug 2024 15:28:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9950713dsm4128847b3.26.2024.08.15.15.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:28:56 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:28:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/13] pack-revindex: prepare for incremental MIDX bitmaps
Message-ID: <f5d0866e5cb3f7f5695062e12b10072fa05ecff3.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

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
index 2e657a2aa4..0a7039d955 100644
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
@@ -2399,7 +2409,7 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	for (i = 0; i < eindex->count; ++i) {
 		if (eindex->objects[i]->type == type &&
 		    bitmap_get(objects,
-			       st_add(bitmap_num_objects(bitmap_git), i)))
+			       st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			count++;
 	}
 
@@ -2798,7 +2808,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 		BUG("rebuild_existing_bitmaps: missing required rev-cache "
 		    "extension");
 
-	num_objects = bitmap_num_objects(bitmap_git);
+	num_objects = bitmap_non_extended_bits(bitmap_git);
 	CALLOC_ARRAY(reposition, num_objects);
 
 	for (i = 0; i < num_objects; ++i) {
@@ -2941,7 +2951,7 @@ static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
 		struct object *obj = eindex->objects[i];
 
 		if (!bitmap_get(result,
-				st_add(bitmap_num_objects(bitmap_git), i)))
+				st_add(bitmap_non_extended_bits(bitmap_git), i)))
 			continue;
 
 		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
diff --git a/pack-revindex.c b/pack-revindex.c
index 22d3c23464..ce3f7ae214 100644
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
2.46.0.86.ge766d390f0.dirty

