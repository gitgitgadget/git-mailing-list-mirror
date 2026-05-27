Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323936EA98
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911766; cv=none; b=EU2TDbMBfzBAWRlCsHHQpabmvUPL64zplPwx8jyhPqquDBWrrglYlYkkAX4u9Nqj4dGirZghZLMg0CzAUpW3Md8wKO1HBA+JZURjWIwVH3N+Hr7aRwqt3pr+hhtZpJGBzDB3ARBCsTIo8wsgWACgGzrNLZAt4EBisgmr8PLdgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911766; c=relaxed/simple;
	bh=VUf6Hd50ntkCC+UZOneR/JsyyEx9s46+XWC6FbecuVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9YxyG/S5Nkz4iJI7Tge1jXkBAJ8kP1+iVzPhUvSehLev4CBukjxK6ig2rlNbPsmgu7N2MK50HYVqhqVeiulcfgJGcFdhAWFFNBBsi8x3NwQB+APBd4nILcF1HIht0uwVZgknb8+ZlAEZXeaq4rdU80FAOMg2MGLLGpMqkF2NX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OC/OUUPC; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OC/OUUPC"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7c0dea734b8so116695507b3.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911763; x=1780516563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgN7WEAjgl6S2xyZmCtwBiA+nBOhONB4Z1KmIj/pgE0=;
        b=OC/OUUPCSG8Z6U4AOTGW+Qc+J1tnQsLJ+6hOFvQfCdXfX8Mnw5JyIYggpiB/3eeG2J
         ftPa7HEgUIW/91mKDbAGxZEZxYKjxXrDPkygoldMO9Is10VoHCJXGamqYA2evYahymK+
         Hy8kf6lE0D5GuxedlZwTiz9RdjHf0NeRSnZAeFOSb5qXsWNFycY6/zzcUIoBrftdiiMP
         pu8sdiqLtgGLWPjPAVLlV712w7ZK7P3p43VPRVoyEmtHfPpcvuJUzPCgEP7qPMo9SVQH
         occD2jfnsFBGxwBdLsDSJhb37k+PHTd6gyKRTAZ1Fek70lHK/kfgKp6rtYKQtSOc0cRs
         NBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911763; x=1780516563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgN7WEAjgl6S2xyZmCtwBiA+nBOhONB4Z1KmIj/pgE0=;
        b=kb+lXCPiqTdO5utXNhT7lAQXj9RdSlleV2Qp+9A57tc2rJRdYu/htHk0s6yA8GRVce
         8hGCCZ2jQv7rytZN/xX4hBx9BcJ7q3C048E9FUDMIJK6XnyuxYuWd7GLKPzCtAEJ5XJI
         CxZABbravD9oU1wed6qJx7aKu3dl9q/WT9DMzXUXZ8nKnvLvyD4kOPA4czmd+/CsnHcB
         KnITjf3sI4TFweZXsu7JSYbSvc8O30/DJMB/jElyeJWfvobyOvgkk1JNPglx1H/rav/a
         Vzuxk5Pr/4JZARU+SLWHUBzWi2FKSBbpF7cYIl9hwZYT9e3URrQXojS03Cqzh7Cr+ak8
         P42A==
X-Gm-Message-State: AOJu0Yx5/pITZoAALphULi8pdbUPYhBRgPfpEoRl+n4QUyWEIkImTATo
	guuoKzV+PH67vr+7uLwh5S9k0wAUszeQqvFSg6SMVsyRErnge3o/JGJDgO2ogUtFl92rERoOaJ9
	MpJ1/97Y=
X-Gm-Gg: Acq92OF3JYspV7n3cAXRm7YI4suM0t6BpUWqVUNMVP1EDRDmJDwPGlWbdxy6wW7ENbR
	+mTvZkrOBxFx+rETUR7SwiAyhplYftut1Lw9cRs1yYpfv3xe2RR+gJRF9Ecr9BpTF0e+j6ue+df
	1YC40rHxhmYxWgJ43yP0TAbZnbYgIGOHakP+PRlBzDpEBWaeo4A4J5g7B5TR3Cj7G4UxRiw/VVk
	thyRQgc3p9LKaCrc+6ZEvURHH9SQiP/2Ar3OB6BMA0gDu/fqCNWcYyt1mQTKnYjqDV3CU7BtpGX
	agopPzFJmJenjpvFF+MR2GE6hy+s/gv6wUnEPrADTEgGhzFlG9SnTHcjzs6rODWOGmwXvtkT5+t
	pITWXggAglgGRUUhv/bvR4zGrDnqXAByjOaaNBbD5WxrLH0f9Si/crcE8uDrhk8KH4DDZmrhJsu
	G8lSiBrTaFwXqB/oQbWL0b1xGdpW+CnlVULn7d9COS/mTpzP+0Ps0G/rst4HG5O8KsWPxTNSt5w
	jMh1qheo2fDfeSElElj1Sl1UD09NHwhrontEhzdYUW4St+yzDS1KtgfcHqpLGhbh36z3MorCU1V
	cz3sG3EoISXc+lbGNfmnPIT2gi0=
X-Received: by 2002:a05:690c:6b05:b0:79a:b49a:cb22 with SMTP id 00721157ae682-7d3368b8065mr248918397b3.49.1779911763574;
        Wed, 27 May 2026 12:56:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7dc642d9aa6sm497887b3.39.2026.05.27.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:56:03 -0700 (PDT)
Date: Wed, 27 May 2026 15:56:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 5/8] pack-bitmap: cache object positions during fill
Message-ID: <70dfa80d5436007aed0f9c27e7bab8c6c1d6742c.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

The previous commits removed some redundant work from bitmap generation
by avoiding unnecessary tree recursion and by reusing selected bitmaps
that have already been computed.

Even with those changes in place, there is still an extremely hot path
from `fill_bitmap_commit()` and `fill_bitmap_tree()` to translate object
IDs into their corresponding bit positions in order to generate their
bitmaps.

In a small repository, this overhead is not significant. However, in a
very large repository (e.g., the one that we have been using as a
benchmark over the past several commits with ~57M total objects), the
overhead of locating object bit positions (often repeatedly) adds up
significantly.

Combat this by adding a small, direct-mapped cache to the bitmap writer
which maps object IDs to their corresponding bit positions. Size the
cache according to the number of objects being written, with fixed lower
and upper bounds so small repositories do not pay for a large table and
large repositories can avoid most repeated packlist and MIDX lookups.

On my machine with (a somewhat outdated) GCC 15.2.0, each entry in the
cache is 40 bytes wide:

    $ pahole -C bitmap_pos_cache_entry pack-bitmap-write.o
    struct bitmap_pos_cache_entry {
            struct object_id           oid;                  /*     0    36 */
            uint32_t                   pos;                  /*    36     4 */

            /* size: 40, cachelines: 1, members: 2 */
            /* last cacheline: 40 bytes */
    };

, and we will allocate up to 2^21 entries for a maximum total of 80 MiB
of cache overhead.

In our example repository from above and in earlier commits, this
results in a ~9.4% reduction in runtime relative to the previous commit:

    +------------------+-------------+-------------+---------------------+
    |                  | HEAD^       | HEAD        | Delta               |
    +------------------+-------------+-------------+---------------------+
    | elapsed          |   324.8 s   |   294.1 s   |    -30.7 s  (-9.4%) |
    | cycles           | 1,508.6 B   | 1,365.5 B   |   -143.0 B  (-9.5%) |
    | instructions     | 1,436.6 B   | 1,389.8 B   |    -46.9 B  (-3.3%) |
    | CPI              |     1.050   |     0.983   |   -0.068    (-6.4%) |
    +------------------+-------------+-------------+---------------------+

When generating bitmaps on this repository (to produce the above
timings), the cache grew to its maximum size of 80 MiB, and resulted in
1.024B cache hits and 59.957M cache misses.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 88 ++++++++++++++++++++++++++++++++++++++++++++-
 pack-bitmap.h       |  7 ++++
 2 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 42ed22feacc..4b6fb07edd7 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -89,6 +89,7 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 	ewah_free(writer->tags);
 
 	kh_destroy_oid_map(writer->bitmaps);
+	free(writer->pos_cache);
 
 	kh_foreach_value(writer->pseudo_merge_commits, idx,
 			 free_pseudo_merge_commit_idx(idx));
@@ -213,15 +214,92 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 	writer->selected_nr++;
 }
 
+struct bitmap_pos_cache_entry {
+	struct object_id oid;
+	uint32_t pos;
+};
+
+#define BITMAP_POS_MIN_CACHE_SIZE (1U << 10)
+#define BITMAP_POS_MAX_CACHE_SIZE (1U << 21)
+#define BITMAP_POS_CACHE_VALID    (1U << 31)
+
+static void bitmap_writer_init_pos_cache(struct bitmap_writer *writer)
+{
+	if (writer->pos_cache)
+		return;
+
+	writer->pos_cache_nr = BITMAP_POS_MIN_CACHE_SIZE;
+
+	while (writer->pos_cache_nr < writer->to_pack->nr_objects &&
+	       writer->pos_cache_nr < BITMAP_POS_MAX_CACHE_SIZE)
+		writer->pos_cache_nr <<= 1;
+
+	CALLOC_ARRAY(writer->pos_cache, writer->pos_cache_nr);
+}
+
+static size_t bitmap_writer_pos_cache_slot(struct bitmap_writer *writer,
+					   const struct object_id *oid)
+{
+	return oidhash(oid) & (writer->pos_cache_nr - 1);
+}
+
+static bool bitmap_writer_pos_cache_valid(struct bitmap_writer *writer,
+					  size_t slot)
+{
+	return !!(writer->pos_cache[slot].pos & BITMAP_POS_CACHE_VALID);
+}
+
+static int find_cached_object_pos(struct bitmap_writer *writer,
+				  const struct object_id *oid, uint32_t *pos)
+{
+	size_t slot = bitmap_writer_pos_cache_slot(writer, oid);
+
+	if (bitmap_writer_pos_cache_valid(writer, slot) &&
+	    oideq(&writer->pos_cache[slot].oid, oid)) {
+		writer->pos_cache_hits++;
+		*pos = writer->pos_cache[slot].pos & ~BITMAP_POS_CACHE_VALID;
+		return 1;
+	}
+
+	writer->pos_cache_misses++;
+	return 0;
+}
+
+static uint32_t store_cached_object_pos(struct bitmap_writer *writer,
+					const struct object_id *oid,
+					uint32_t pos)
+{
+	size_t slot;
+
+	if (pos & BITMAP_POS_CACHE_VALID)
+		return pos; /* too large to cache */
+
+	slot = bitmap_writer_pos_cache_slot(writer, oid);
+
+	oidcpy(&writer->pos_cache[slot].oid, oid);
+	writer->pos_cache[slot].pos = pos | BITMAP_POS_CACHE_VALID;
+
+	return pos;
+}
+
 static uint32_t find_object_pos(struct bitmap_writer *writer,
 				const struct object_id *oid, int *found)
 {
 	struct object_entry *entry;
 	uint32_t pos;
 
+	bitmap_writer_init_pos_cache(writer);
+
+	if (find_cached_object_pos(writer, oid, &pos)) {
+		if (found)
+			*found = 1;
+		return pos;
+	}
+
 	entry = packlist_find(writer->to_pack, oid);
 	if (entry) {
 		uint32_t base_objects = 0;
+
 		if (writer->midx)
 			base_objects = writer->midx->num_objects +
 				writer->midx->num_objects_in_base;
@@ -239,7 +317,7 @@ static uint32_t find_object_pos(struct bitmap_writer *writer,
 
 	if (found)
 		*found = 1;
-	return pos;
+	return store_cached_object_pos(writer, oid, pos);
 
 missing:
 	if (found)
@@ -662,6 +740,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 		writer->progress = start_progress(writer->repo,
 						  "Building bitmaps",
 						  writer->selected_nr);
+
+	writer->pos_cache_hits = 0;
+	writer->pos_cache_misses = 0;
+
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    writer->repo);
 
@@ -726,6 +808,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "fill_bitmap_commit_found_ancestor_nr",
 			   fill_bitmap_commit_found_ancestor_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "bitmap_pos_cache_hits", writer->pos_cache_hits);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "bitmap_pos_cache_misses", writer->pos_cache_misses);
 
 	stop_progress(&writer->progress);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a95e1c2d115..19a86554579 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -132,6 +132,8 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
+struct bitmap_pos_cache_entry;
+
 struct bitmap_writer {
 	struct repository *repo;
 	struct ewah_bitmap *commits;
@@ -143,6 +145,11 @@ struct bitmap_writer {
 	struct packing_data *to_pack;
 	struct multi_pack_index *midx; /* if appending to a MIDX chain */
 
+	struct bitmap_pos_cache_entry *pos_cache;
+	size_t pos_cache_nr;
+	uint64_t pos_cache_hits;
+	uint64_t pos_cache_misses;
+
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
-- 
2.54.0.rc1.84.g1cf18622df7

