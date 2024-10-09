Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB11DFE2B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505892; cv=none; b=apbJfovsvEywHz/mQ0YvNQhAj6Bkry3qyt0qNCm4mdoKphsks+q9srZO4qUpB28JxJyt6yCt0WARvDa9KMekiAC7gN4Sx8yW2h3aYFfY2RH1AFNED9Xitkv1M0Fm+Cvc1XeThdbeyLN/UUjOHZqC7lVL7LSrApxuDqnyY7cJmb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505892; c=relaxed/simple;
	bh=qsTt1okpCH0XjdUNRLiLnPjQP/8j00Bp1b8A6dK5Nbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVGoqS+9OwopTdbOZOoI4cJzLqp7Avq/tSRpHN05jFVUvwrGyOLlmjx46A23TWUmp8keOn1pVt7uEWQ+V54uCziMNHhGRcmT25aLkgGdmHZMuu6XCQEqtQ0Hd3d3AF5IK3vU/Zf+fAp8koTjNDx567RF9dLS+8OwWcN3sctafv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YO6q8CfY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YO6q8CfY"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e2904ce7e14so196624276.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505890; x=1729110690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZpQe7A0bytBUiilfEqxsKxr7BVGKQcnyeeyz9Mf1Lc=;
        b=YO6q8CfYD2jGyHGbK09Yzrh/kVFnv591kaKUUSDNcm+klF+ll5JKzI+aUU5S7gBaeu
         cKMQioN3aUw4qzmqJ2KLnGDiFUlNm3f/ahKay+ajXhyMmr8QrVeQRCQv/K6KN/jqMW2W
         nzjS9ok9UrgLi59DrgtoRIZPG6MimLOEqn30sZo7d2H/PiyvHR3hK0bxzlHUsvCxJcK6
         Z85Du/98gfoTDpoUuV50ncYAMJgswJfzurpgYG7WwmUoGM3TT1rt14NEDZpMj0O9nl8Q
         QBChfQFlXnB8qtuS9t50tvThL8WFM0+PQ7ZQOOY1bhmKvZdECNPvvu+LrcFcq7e/CV+A
         WTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505890; x=1729110690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZpQe7A0bytBUiilfEqxsKxr7BVGKQcnyeeyz9Mf1Lc=;
        b=LQbgb3xVZFBUkYQkzrwMkhK+kthTyCmX93SF5g0BoprqT2x3cZpj9ahzZvErvyo0gA
         +/uJh33RPsztmi7A+X4x9gzWhJt0ON9dVYnMZndgAL8nV8CQh0DHPKd+3n533S2G5weG
         K3DSuct+104q8TLkJqUnDhvcm37whXh4hJTrVL+kwUvEOhNfFVTMOTwafGf6WaC27Zzo
         QtzsBcM6e39YScjktEuSLNogwAiKKD1Bfn5Mj4x/WU4Vdmdm4/Nvzinvp5t+lFdj9AV5
         bT0KPvUk54KlkoesEY6/s9Dr8TcT8z5QItRk2L0cMp++0ivGHJfZEjrVso6LkWhmUdjJ
         CzgA==
X-Gm-Message-State: AOJu0YxIdSovITs5QbK0vyPdZ3r4W5QoLpuHn9flXMSGn+VwgnMY5S6A
	4OtPt2X6HQi2kn8qjJj/wov3EAA9KErE8Do4mWcBW8KapDqJe6S3Pm6HndEwpimqBrmVSRb3nY+
	r8Ho=
X-Google-Smtp-Source: AGHT+IE1mNAS9dsrg5j5wAOgghTLlatiKagERB24LzKHFwSFqLehWUhw+UVQqTlJEmY378NAPmFDqw==
X-Received: by 2002:a05:6902:f82:b0:e26:8e8:b29d with SMTP id 3f1490d57ef6-e28fe50e8f0mr3949031276.53.1728505889621;
        Wed, 09 Oct 2024 13:31:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28ee8c438csm789516276.47.2024.10.09.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:29 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/11] pack-bitmap: enable cross-pack delta reuse
Message-ID: <ca3a916cd6e93aaa09ccff9f77fc127254222068.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

Back when multi-pack bitmaps were first introduced, we performed
verbatim pack reuse over the MIDX's preferred pack only. Since all
duplicate objects were resolved in favor of that pack, any object from
the preferred pack that was stored as an OFS_DELTA is directly
reusable.

That's not the case when we are reusing objects from multiple packs,
like was introduced via af626ac0e0 (pack-bitmap: enable reuse from
all bitmapped packs, 2023-12-14). When reusing an object stored as a
delta from some pack other than the preferred one, it's possible that
the base was selected from a different pack.

When that's the case, we could have converted those OFS_DELTAs to
REF_DELTAs on the fly (like we do when running 'pack-objects' without
the `--delta-base-offset` option). But af626ac0e0 decided instead to
kick those objects back into the non-verbatim reuse path, meaning that
reusing them was slightly slower.

This patch removes that limitation, and teaches pack-objects to
convert deltas (whose base was selected from a different pack in the
MIDX) from OFS_DELTAs to REF_DELTAs.

In order to do this, the pack-reuse code within pack-bitmap.c marks
bits in a separate bitmap called 'reuse_as_ref_delta'. Objects whose
bits are marked in that bitmap must be converted from OFS_DELTAs to
REF_DELTAs.

To mark bits in that bitmap, we adjust find_base_bitmap_pos() to
return the bitmap position of any delta object's base regardless of
whether or not it came from the same pack. This is done by:

  1. First converting the base object's into a pack position (via
     `offset_to_pack_pos()`).

  2. Then converting from pack position into into lexical order (via
     `pack_pos_to_index()`).

  3. Then into an object ID (via `nth_packed_object_id()`).

  4. Then into a position in the MIDX's lexical order of object IDs
     (via `bsearch_midx()`).

  5. And finally into a position in the MIDX's pseudo-pack order (via
     `midx_pair_to_pack_pos()`).

If we can find that base object in the MIDX, then we use its position
in the MIDX's pseudo-pack order to determine whether or not it was
selected from the same pack. If it is, no adjustment is necessary.
Otherwise, we mark the delta object's position in the new
`reuse_as_ref_delta` bitmap, and convert accordingly from within
`write_reused_pack_one()`.

The only tweak we need to make outside of the above is to teach
`write_reused_pack_verbatim()` to only consider words of the
`reuse_packfile_bitmap` as reusable verbatim if the word does not have
any bits which are marked in the reuse_as_ref_delta bitmap, in which
case they must be converted and cannot be reused verbatim.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c      | 29 ++++++++++++++---
 pack-bitmap.c               | 63 +++++++++++++++++++++++++++----------
 pack-bitmap.h               |  1 +
 t/t5332-multi-pack-reuse.sh |  4 +--
 4 files changed, 75 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7f50d58a235..dbcd632483e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -223,6 +223,7 @@ static size_t reuse_packfiles_nr;
 static size_t reuse_packfiles_used_nr;
 static uint32_t reuse_packfile_objects;
 static struct bitmap *reuse_packfile_bitmap;
+static struct bitmap *reuse_as_ref_delta_packfile_bitmap;
 
 static int use_bitmap_index_default = 1;
 static int use_bitmap_index = -1;
@@ -1084,7 +1085,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 		assert(base_offset != 0);
 
 		/* Convert to REF_DELTA if we must... */
-		if (!allow_ofs_delta) {
+		if (!allow_ofs_delta ||
+		    bitmap_get(reuse_as_ref_delta_packfile_bitmap, pos)) {
 			uint32_t base_pos;
 			struct object_id base_oid;
 
@@ -1160,6 +1162,10 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 			if (!bitmap_get(reuse_packfile_bitmap,
 					word_pos * BITS_IN_EWORD + offset))
 				return word_pos;
+			if (reuse_as_ref_delta_packfile_bitmap &&
+			    bitmap_get(reuse_as_ref_delta_packfile_bitmap,
+				       word_pos * BITS_IN_EWORD + offset))
+				return word_pos;
 		}
 
 		pos += BITS_IN_EWORD - (pos % BITS_IN_EWORD);
@@ -1182,10 +1188,24 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 	if (pos >= end)
 		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
 
-	while (pos < end &&
-	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
+	while (pos < end) {
+		size_t wpos = pos / BITS_IN_EWORD;
+		eword_t reuse;
+
+		reuse = reuse_packfile_bitmap->words[wpos];
+		if (reuse_as_ref_delta_packfile_bitmap) {
+			/*
+			 * Can't reuse verbatim any objects which need
+			 * to be first rewritten as REF_DELTAs.
+			 */
+			reuse &= ~reuse_as_ref_delta_packfile_bitmap->words[wpos];
+		}
+
+		if (reuse != (eword_t)~0)
+			break;
+
 		pos += BITS_IN_EWORD;
-
+	}
 	if (pos > end)
 		pos = end;
 
@@ -4078,6 +4098,7 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 						   &reuse_packfiles,
 						   &reuse_packfiles_nr,
 						   &reuse_packfile_bitmap,
+						   &reuse_as_ref_delta_packfile_bitmap,
 						   allow_pack_reuse == MULTI_PACK_REUSE);
 
 	if (reuse_packfiles) {
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9ea1fab397..8326a20979e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2054,18 +2054,34 @@ static int find_base_bitmap_pos(struct bitmap_index *bitmap_git,
 				uint32_t *base_bitmap_pos)
 {
 	if (bitmap_is_midx(bitmap_git)) {
+		struct object_id base_oid;
+		uint32_t base_pack_pos;
+		uint32_t base_idx_pos;
+		uint32_t base_midx_pos;
+
 		/*
-		 * Cross-pack deltas are rejected for now, but could
-		 * theoretically be supported in the future.
-		 *
-		 * We would need to ensure that we're sending both
-		 * halves of the delta/base pair, regardless of whether
-		 * or not the two cross a pack boundary. If they do,
-		 * then we must convert the delta to an REF_DELTA to
-		 * refer back to the base in the other pack.
-		 * */
-		if (midx_pair_to_pack_pos(bitmap_git->midx, pack->pack_int_id,
-					  base_offset, base_bitmap_pos) < 0)
+		 * First convert from the base object's offset
+		 * to its pack position in pack order relative
+		 * to its source pack. Use that information to
+		 * find the base object's OID.
+		 */
+		if (offset_to_pack_pos(pack->p, base_offset,
+				       &base_pack_pos) < 0)
+			return -1;
+		base_idx_pos = pack_pos_to_index(pack->p, base_pack_pos);
+		if (nth_packed_object_id(&base_oid, pack->p, base_idx_pos) < 0)
+			return -1;
+
+		/*
+		 * Now find the base object's lexical position
+		 * in the MIDX, and convert that to a bitmap
+		 * position in the MIDX's pseudo-pack order.
+		 */
+		if (!bsearch_midx(&base_oid, bitmap_git->midx,
+				  &base_midx_pos))
+			return -1;
+		if (midx_to_pack_pos(bitmap_git->midx, base_midx_pos,
+				     base_bitmap_pos) < 0)
 			return -1;
 	} else {
 		/*
@@ -2102,6 +2118,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     size_t bitmap_pos,
 			     off_t offset,
 			     struct bitmap *reuse,
+			     struct bitmap *reuse_as_ref_delta,
 			     struct pack_window **w_curs)
 {
 	off_t delta_obj_offset;
@@ -2116,6 +2133,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
 		uint32_t base_bitmap_pos;
+		int cross_pack;
 
 		/*
 		 * Find the position of the base object so we can look it up
@@ -2129,7 +2147,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 					     delta_obj_offset);
 		if (!base_offset ||
 		    find_base_bitmap_pos(bitmap_git, pack, base_offset,
-					 delta_obj_offset, &base_bitmap_pos) < 0)
+					 delta_obj_offset,
+					 &base_bitmap_pos) < 0)
 			return 0;
 
 		/*
@@ -2142,8 +2161,11 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		 */
 		if (!bitmap_get(reuse, base_bitmap_pos))
 			return 0;
-	}
 
+		cross_pack = base_bitmap_pos < pack->bitmap_pos;
+		if (cross_pack)
+			bitmap_set(reuse_as_ref_delta, bitmap_pos);
+	}
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
@@ -2153,7 +2175,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 
 static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git,
 						 struct bitmapped_pack *pack,
-						 struct bitmap *reuse)
+						 struct bitmap *reuse,
+						 struct bitmap *reuse_as_ref_delta)
 {
 	struct bitmap *result = bitmap_git->result;
 	struct pack_window *w_curs = NULL;
@@ -2220,7 +2243,8 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 			}
 
 			if (try_partial_reuse(bitmap_git, pack, bit_pos,
-					      ofs, reuse, &w_curs) < 0) {
+					      ofs, reuse, reuse_as_ref_delta,
+					      &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
@@ -2255,12 +2279,14 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
+					struct bitmap **reuse_as_ref_delta_out,
 					int multi_pack_reuse)
 {
 	struct repository *r = the_repository;
 	struct bitmapped_pack *packs = NULL;
 	struct bitmap *result = bitmap_git->result;
 	struct bitmap *reuse;
+	struct bitmap *reuse_as_ref_delta = NULL;
 	size_t i;
 	size_t packs_nr = 0, packs_alloc = 0;
 	size_t word_alloc;
@@ -2333,14 +2359,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	word_alloc = objects_nr / BITS_IN_EWORD;
 	if (objects_nr % BITS_IN_EWORD)
 		word_alloc++;
+
 	reuse = bitmap_word_alloc(word_alloc);
+	reuse_as_ref_delta = bitmap_word_alloc(word_alloc);
 
 	for (i = 0; i < packs_nr; i++)
-		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse);
+		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i],
+						     reuse, reuse_as_ref_delta);
 
 	if (bitmap_is_empty(reuse)) {
 		free(packs);
 		bitmap_free(reuse);
+		bitmap_free(reuse_as_ref_delta);
 		return;
 	}
 
@@ -2352,6 +2382,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	*packs_out = packs;
 	*packs_nr_out = packs_nr;
 	*reuse_out = reuse;
+	*reuse_as_ref_delta_out = reuse_as_ref_delta;
 }
 
 int bitmap_walk_contains(struct bitmap_index *bitmap_git,
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a1e8c8936c9..e7962ac90e8 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -86,6 +86,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
+					struct bitmap **reuse_as_ref_delta_out,
 					int multi_pack_reuse);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 8bcb736c75a..6edff02d124 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -194,7 +194,7 @@ test_expect_success 'omit delta with uninteresting base (same pack)' '
 	test_pack_objects_reused 3 1 <in
 '
 
-test_expect_success 'omit delta from uninteresting base (cross pack)' '
+test_expect_success 'can retain delta from uninteresting base (cross pack)' '
 	cat >in <<-EOF &&
 	$(git rev-parse $base)
 	^$(git rev-parse $delta)
@@ -207,7 +207,7 @@ test_expect_success 'omit delta from uninteresting base (cross pack)' '
 	packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
 	objects_nr="$(git rev-list --count --all --objects)" &&
 
-	test_pack_objects_reused_all $(($objects_nr - 1)) $packs_nr
+	test_pack_objects_reused_all $objects_nr $packs_nr
 '
 
 test_expect_success 'non-omitted delta in MIDX preferred pack' '
-- 
2.47.0.11.g487258bca34

