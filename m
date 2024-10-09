Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6F1E1A30
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505898; cv=none; b=QEd+x3WKhTLaFX3UBIVGG8sHjjNkTrMEHGGhU2OuE7+EAXAFeHmquRV8R6azGzNCYJ9rNtJv6VHEFSL1FO+fr5XnC9F6leIxfWWkgHRfKWVrJKaiFWdzf0QAiT0k//vGw0cZTgFdHKXGgwogpBlq06xQWs+kKYyQ6QslXKxTxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505898; c=relaxed/simple;
	bh=BNl7ZVvmZtGlpb2WVtte+Daz769a56Jp6Pj6rbe1IM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHRng0j/BjHTlPqSfVXcCeP2ueQ8XmnpUAPZ07n0B88LRWMG6Ltl9YXqz8r/4n23BQPoGdOwe6Vt24m+P7zJ4eXIwsiSbD4oKvqWWl3DsTxBT2QvbcHUhnF08+W0lbexx2voTsM+YVvYnWAxnhMNf2WjPcf1f2fQ/2c0EcaR9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=c837JVy9; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="c837JVy9"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso153858276.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505896; x=1729110696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RinAmfBl92v9ExenHxp8lXmwNKwUnMvFVISnlM0937w=;
        b=c837JVy9VbeH+zqftjB9WE6g2d4ZPZzIN0zYVT9ZRvzDA5JlT8QVEmD/gEhWrZ+5zF
         nWfVLBwoIUUnGklMKyxGr38gYqULJlBFa8GCR16quHzchTHNNSWArr3U4OiO4USHagsx
         AQSpMAylchBkEF0ft5Nsbs/kh+4QW7kF2HrdaM+E6rWColwOvirFBy3smrCRMNCiLwIL
         PfZpI3IExleR9xN2pridQxmbOFsPQMkg20ZOXTo/cUELR7dW4tBFM/APUgeKD70bDRQB
         2MJs8fhHzhcP/weK4/QRW26iv/xM7JR3GU33xc8AmgmVUkoyWA1NHtuK2B3h6asgnbEr
         yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505896; x=1729110696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RinAmfBl92v9ExenHxp8lXmwNKwUnMvFVISnlM0937w=;
        b=j1xlYfru1fHvn3oaO8ScRiYqk+ztzT6bfHGSLZJDhhdoTpX+2dPh2vEaxWXtfVbMfM
         +GlA5o4pWd1xTMvcjq9aCLYZUKukHN1OmtSKrJGliPDj/GxZunjJxsyULmIi4EOCfKGp
         z5ymvtRzzAKfAnaOYinVq3Hfwbm+Pb1a+yyxWXR+XL5D6DbqtUniq1ZfAgRK3kopXwzx
         h4vfPEowKhgBnOjP/pF9XUJPvqPSsa/zSPnXkZXvTruDfvO5RctqtX5aMVQCQEH0SBbO
         6+M6Zt5syLh/Q6EXYBeGvNl4bbtlIgPn4NxiZhl7KXxgIQG95LW+SbNzqSdIpUSeYCzA
         4aAg==
X-Gm-Message-State: AOJu0YyJHqONcpulka4ZoPKHmJWJ/rvxbvQdHd0hMJuBa7mYwIP5rhqY
	/QYGL3qVduT3DIy+NLoJC2Rbb3St58bkmr43zwVBqpVRhM61kAHF2LQ8POluK2oIKST+B30C0CW
	mNf8=
X-Google-Smtp-Source: AGHT+IHgSA+l33FOTkc5f3wT8JY5YCAp0e3cgIHhl63radMsGIvatS0hFPm2JbzBZpMRnZXa/XiQGA==
X-Received: by 2002:a05:690c:4703:b0:6e2:43ea:55f with SMTP id 00721157ae682-6e3221f7bcamr31019847b3.38.1728505895860;
        Wed, 09 Oct 2024 13:31:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e31ce7ba14sm5856547b3.42.2024.10.09.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:35 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 11/11] pack-bitmap: enable reusing deltas with base objects
 in 'haves' bitmap
Message-ID: <487258bca343078bcb59f22ac0a9a69d69f3c284.1728505840.git.me@ttaylorr.com>
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

Ever since the current verbatim pack-reuse strategy was devised in
bb514de356 (pack-objects: improve partial packfile reuse, 2019-12-18),
we have skipped sending delta objects whenever we're not sending that
object's base.

But it's fine to send such an object as a REF_DELTA against the base
object, provided the following are true:

  - We know that the client has the object already, i.e. it appears
    in the 'haves' bitmap.

  - The client supports thin packs, i.e. 'pack-objects' was invoked
    with the '--thin' option.

  - The client did not request object filtering, in which case we
    cannot trust that they actually do have all of the objects in the
    'haves' bitmap, since we only filter the 'result' bitmap.

When all of those criteria are met, we can send the delta object
verbatim, meaning that we can reuse more objects from existing packs
via the verbatim reuse mechanism, which should be faster than kicking
those objects back to the slow path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c      |  3 +-
 pack-bitmap.c               | 52 ++++++++++++++++++++---------
 pack-bitmap.h               |  3 +-
 t/t5332-multi-pack-reuse.sh | 66 +++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dbcd632483e..027c64f931f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4099,7 +4099,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 						   &reuse_packfiles_nr,
 						   &reuse_packfile_bitmap,
 						   &reuse_as_ref_delta_packfile_bitmap,
-						   allow_pack_reuse == MULTI_PACK_REUSE);
+						   allow_pack_reuse == MULTI_PACK_REUSE,
+						   thin);
 
 	if (reuse_packfiles) {
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 67ea267ed2a..e8094453ca3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2131,6 +2131,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			     off_t offset,
 			     struct bitmap *reuse,
 			     struct bitmap *reuse_as_ref_delta,
+			     int thin_deltas,
 			     struct pack_window **w_curs)
 {
 	off_t delta_obj_offset;
@@ -2145,7 +2146,7 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
 		uint32_t base_bitmap_pos;
-		int cross_pack;
+		int wants_base, cross_pack;
 
 		/*
 		 * Find the position of the base object so we can look it up
@@ -2164,19 +2165,25 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			return 0;
 
 		/*
-		 * And finally, if we're not sending the base as part of our
-		 * reuse chunk, then don't send this object either. The base
-		 * would come after us, along with other objects not
-		 * necessarily in the pack, which means we'd need to convert
-		 * to REF_DELTA on the fly. Better to just let the normal
-		 * object_entry code path handle it.
+		 * And finally, if we're not sending the base as part of
+		 * our reuse chunk, then either convert the delta to a
+		 * REF_DELTA if the client supports thin deltas, or
+		 * don't send this object either.
 		 */
-		if (!bitmap_get(reuse, base_bitmap_pos))
-			return 0;
-
+		wants_base = bitmap_get(reuse, base_bitmap_pos);
 		cross_pack = base_bitmap_pos < pack->bitmap_pos;
-		if (cross_pack)
+
+		if (!wants_base) {
+			if (!thin_deltas)
+				return 0;
+			if (!bitmap_git->haves ||
+			    !bitmap_get(bitmap_git->haves, base_bitmap_pos))
+				return 0;
+
 			bitmap_set(reuse_as_ref_delta, bitmap_pos);
+		} else if (cross_pack) {
+			bitmap_set(reuse_as_ref_delta, bitmap_pos);
+		}
 	}
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
@@ -2188,7 +2195,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git,
 						 struct bitmapped_pack *pack,
 						 struct bitmap *reuse,
-						 struct bitmap *reuse_as_ref_delta)
+						 struct bitmap *reuse_as_ref_delta,
+						 int thin_deltas)
 {
 	struct bitmap *result = bitmap_git->result;
 	struct pack_window *w_curs = NULL;
@@ -2256,7 +2264,7 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 
 			if (try_partial_reuse(bitmap_git, pack, bit_pos,
 					      ofs, reuse, reuse_as_ref_delta,
-					      &w_curs) < 0) {
+					      thin_deltas, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
@@ -2292,7 +2300,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
 					struct bitmap **reuse_as_ref_delta_out,
-					int multi_pack_reuse)
+					int multi_pack_reuse,
+					int thin_deltas)
 {
 	struct repository *r = the_repository;
 	struct bitmapped_pack *packs = NULL;
@@ -2375,9 +2384,22 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	reuse = bitmap_word_alloc(word_alloc);
 	reuse_as_ref_delta = bitmap_word_alloc(word_alloc);
 
+	if (bitmap_git->filtered) {
+		/*
+		 * If the bitmap traversal filtered objects, then we
+		 * can't trust the client actually has all of the
+		 * objects that appear in the 'haves' bitmap. In that
+		 * case, pretend like we don't support thin-deltas,
+		 * since we can't guarantee that the client has all of
+		 * the objects we think it has.
+		 */
+		thin_deltas = 0;
+	}
+
 	for (i = 0; i < packs_nr; i++)
 		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i],
-						     reuse, reuse_as_ref_delta);
+						     reuse, reuse_as_ref_delta,
+						     thin_deltas);
 
 	if (bitmap_is_empty(reuse)) {
 		free(packs);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index e7962ac90e8..1a204fec31e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -87,7 +87,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					size_t *packs_nr_out,
 					struct bitmap **reuse_out,
 					struct bitmap **reuse_as_ref_delta_out,
-					int multi_pack_reuse);
+					int multi_pack_reuse,
+					int thin_deltas);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 6edff02d124..6237c680ae9 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -51,6 +51,33 @@ test_pack_objects_reused () {
 	git index-pack --strict -o got.idx got.pack
 }
 
+# test_pack_objects_reused_thin <pack-reused> <packs-reused>
+test_pack_objects_reused_thin () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --thin --delta-base-offset --stdout --revs \
+		>got.pack &&
+
+	test_pack_reused "$1" <trace2.txt &&
+	test_packs_reused "$2" <trace2.txt &&
+
+	git index-pack --strict --stdin --fix-thin -o got.idx <got.pack
+}
+
+# test_pack_objects_reused_filter <filter> <pack-reused> <packs-reused>
+test_pack_objects_reused_filter () {
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --thin --delta-base-offset --stdout --revs \
+			--thin --filter="$1" \
+		>got.pack &&
+
+	test_pack_reused "$2" <trace2.txt &&
+	test_packs_reused "$3" <trace2.txt &&
+
+	git index-pack --strict --stdin --fix-thin -o got.idx <got.pack
+}
+
 test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_config pack.allowPackReuse single &&
 
@@ -210,6 +237,45 @@ test_expect_success 'can retain delta from uninteresting base (cross pack)' '
 	test_pack_objects_reused_all $objects_nr $packs_nr
 '
 
+test_expect_success 'converts OFS_DELTA to REF_DELTA when possible' '
+	git init ofs-to-ref-delta &&
+	(
+		cd ofs-to-ref-delta &&
+
+		git config pack.allowPackReuse multi &&
+
+		test_seq 64 >f &&
+		git add f &&
+		test_tick &&
+		git commit -m "base" &&
+		base="$(git rev-parse HEAD)" &&
+
+		test_seq 32 >f &&
+		test_tick &&
+		git commit -a -m "delta" &&
+		delta="$(git rev-parse HEAD)" &&
+
+		git repack -ad &&
+
+		test_commit other &&
+
+		pack=$(git pack-objects --all --unpacked $packdir/pack) &&
+		git multi-pack-index write --bitmap \
+				--preferred-pack=pack-$pack.pack &&
+
+		have_delta "$(git rev-parse $delta:f)" "$(git rev-parse $base:f)" &&
+
+		cat >in <<-EOF &&
+		$delta
+		^$base
+		EOF
+
+		test_pack_objects_reused_thin 3 1 <in &&
+		test_pack_objects_reused 2 1 <in &&
+		test_pack_objects_reused_filter "blob:none" 2 1 <in
+	)
+'
+
 test_expect_success 'non-omitted delta in MIDX preferred pack' '
 	test_config pack.allowPackReuse single &&
 
-- 
2.47.0.11.g487258bca34
