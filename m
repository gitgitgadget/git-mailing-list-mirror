Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61818226D15
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493411; cv=none; b=Obfp+bxGj1FTQBkzekv2JCgmutH78JLGdxx6i8ooYMB1JEAYWiMfV3RySchIaq4Rs4eUhl4ianRxoHqSczYY/XcnFGWCAbDcv/IfJgu6l5fjqquxoUDmA8mmRl0lynaiWdvhYuipeDaZzFWvPTIxjRlczXkYFzhitbly3f2UxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493411; c=relaxed/simple;
	bh=e/swQyaGBSuYBv/vUkxE0VVD96fVnK7K874+NJc1u0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3Jcnx3J3LUoACdJ2PnJvGJoVFKAWhreTCzj33Jx1ma91wGaEBCufIfApSD69cJ29gIgNnIAs1yXAPV+pkrLoEkZVywyXwHpAKcmFL/6eSsENvGOvmIdtlvU0shlUgUXAYInAk81+6P+opL+Vd20kO+s2qACkr3leAJ9NgHe1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=V4t7xFTr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="V4t7xFTr"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd15d03eacso10849926d6.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493408; x=1743098208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO5Yoa/oX4fnHaQ0thRBTiNtX94aLzclbBWwjOYbegM=;
        b=V4t7xFTrxDWckSyMqvEkB/EcMKZRfCCXDy/fYKutN/lGUNN80OnvEAK2QS3wxTyxsF
         5F3WKuKcMFQ7KooHDBMo8FBJZynRcg1DQAKQlQjoBxxhAmnbqmYhbJLEsdyDDskyWSVn
         O79hdCpqIPl3g8YK/91VRhXj3SuvddWLXmu3eLA1HVNHYwlsNxQPx6cQuNYOdHrJ9YsO
         X925aUqzMhkhmG0AMsg62gdmG+DcdNkXQYlm+qN1K37T2lETyWMQV6k9h0//aVSqipRh
         FobkUj6rPYeImCfBr79N+hBdxs3ILsKKS89V6Wh//CUoo5B2jiIEdsTD2MvFCtVzPx1z
         FrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493408; x=1743098208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO5Yoa/oX4fnHaQ0thRBTiNtX94aLzclbBWwjOYbegM=;
        b=dcLbqkppnHiDrWK7T3O1ugrVn548ymKutpP9rq8OIjGFWyXjdELK2WI8fGcaOdJmKD
         FubXHYHcYZQi1E558is7IWm5vDqMNHiImWIBp40CdGX/ZLaRhC+vw2dXLE/gWfCH07Bb
         DjQ1jcVN6mLcbTIdnGQ3Ei5lKUSvf6HqRp2019L04Mc5VEoD62gJMx7obe/LOtvvjWmr
         HV72nn6DQsBokAxHFrA76c6fZ01Iok52pcTwWLp842i+ppnMmS51ljEmkadH50kLej02
         3GKLsmTm2jZeWV55XuukxGUfYN3ZqnYA/pSJK2aQb51Sxi4zfJ6MewJ3rnxmfC7TVG2T
         /cqg==
X-Gm-Message-State: AOJu0Yz++coiY7PDtWhCRwu/AqYB/7lBHg9iQBgpL4SF6mKWYZPXCKxO
	jNqSGXBWKg3ZOcFVIWNXWTLAgRgHBVT1IDYiTs++OCRBTXYocH+tUmLnUS/XuE3gdXtnVvC36xk
	BtK4=
X-Gm-Gg: ASbGncvIlYTSe0xK6eYV3QGdYhYWGpc4o7SM+ifVnoPj0rD3HOREDp2f2WW8FkmCaKP
	txOblXdimBqAvNhPZ+CO2Q+c+b40SgTorxV5ep86xYlOQVK0rAScw38rfpZf1ig8cZhn+1v9y6E
	VtGPC9oShtQn9Uyf8IYvadi6rzMKNG0oDlLcEB9zAs6h4xFEFlGbSdN0jJCQNwvmvaIZLPGdGVk
	7oIaeP7742YJiSEKdD4abg+RM9N0l3nGFMGZqI+Tivya0ihAFpM6DOklvHi7trELaSQqF5dBVnq
	sp0fuipeDrcEISLuzwHdlT+1Ccgj/dVGO0dmB9lrG3nIcdDCndkip7NH/tv8EoeoGPGACKQ+QiX
	0hVlKQNWZ0ykBlDSXW18Z5TfKnsM=
X-Google-Smtp-Source: AGHT+IEp8tkTOlot+a5uiFNBKG2u6vWaVTDggJs2Nu5MN3AfwTjhhne1BmtjLZNs2taR0Mk054pezw==
X-Received: by 2002:a05:6214:29e7:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6eb349305d5mr57095796d6.7.1742493408122;
        Thu, 20 Mar 2025 10:56:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3efc5aa4sm1055756d6.71.2025.03.20.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:47 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 08/14] pack-bitmap.c: teach `rev-list --test-bitmap` about
 incremental MIDXs
Message-ID: <d9dfcb5a1b479013e94d636ceb11a33398323e18.1742493373.git.me@ttaylorr.com>
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

Implement support for the special `--test-bitmap` mode of `git rev-list`
when using incremental MIDXs.

The bitmap_test_data structure is extended to contain a "base" pointer
that mirrors the structure of the bitmap chain that it is being used to
test.

When we find a commit to test, we first chase down the ->base pointer to
find the appropriate bitmap_test_data for the bitmap layer that the
given commit is contained within, and then perform the test on that
bitmap.

In order to implement this, light modifications are made to
bitmap_for_commit() to reimplement it in terms of a new function,
find_bitmap_for_commit(), which fills out a pointer which indicates the
bitmap layer which contains the given commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 107 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 21 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5ff1bbfd54..65ad631ce1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -938,8 +938,9 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 	return NULL;
 }
 
-struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
-				      struct commit *commit)
+static struct ewah_bitmap *find_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						  struct commit *commit,
+						  struct bitmap_index **found)
 {
 	khiter_t hash_pos;
 	if (!bitmap_git)
@@ -949,18 +950,30 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return bitmap_for_commit(bitmap_git->base, commit);
+			return find_bitmap_for_commit(bitmap_git->base, commit,
+						      found);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return bitmap_for_commit(bitmap_git->base, commit);
+			return find_bitmap_for_commit(bitmap_git->base, commit,
+						      found);
+		if (found)
+			*found = bitmap_git;
 		return lookup_stored_bitmap(bitmap);
 	}
+	if (found)
+		*found = bitmap_git;
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
 }
 
+struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
+				      struct commit *commit)
+{
+	return find_bitmap_for_commit(bitmap_git, commit, NULL);
+}
+
 static inline int bitmap_position_extended(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
@@ -2513,6 +2526,8 @@ struct bitmap_test_data {
 	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
+
+	struct bitmap_test_data *base_tdata;
 };
 
 static void test_bitmap_type(struct bitmap_test_data *tdata,
@@ -2521,6 +2536,11 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
 	enum object_type bitmap_type = OBJ_NONE;
 	int bitmaps_nr = 0;
 
+	if (bitmap_is_midx(tdata->bitmap_git)) {
+		while (pos < tdata->bitmap_git->midx->num_objects_in_base)
+			tdata = tdata->base_tdata;
+	}
+
 	if (bitmap_get(tdata->commits, pos)) {
 		bitmap_type = OBJ_COMMIT;
 		bitmaps_nr++;
@@ -2584,13 +2604,57 @@ static void test_show_commit(struct commit *commit, void *data)
 	display_progress(tdata->prg, ++tdata->seen);
 }
 
+static uint32_t bitmap_total_entry_count(struct bitmap_index *bitmap_git)
+{
+	uint32_t total = 0;
+	do {
+		total = st_add(total, bitmap_git->entry_count);
+		bitmap_git = bitmap_git->base;
+	} while (bitmap_git);
+
+	return total;
+}
+
+static void bitmap_test_data_prepare(struct bitmap_test_data *tdata,
+				     struct bitmap_index *bitmap_git)
+{
+	memset(tdata, 0, sizeof(struct bitmap_test_data));
+
+	tdata->bitmap_git = bitmap_git;
+	tdata->base = bitmap_new();
+	tdata->commits = ewah_to_bitmap(bitmap_git->commits);
+	tdata->trees = ewah_to_bitmap(bitmap_git->trees);
+	tdata->blobs = ewah_to_bitmap(bitmap_git->blobs);
+	tdata->tags = ewah_to_bitmap(bitmap_git->tags);
+
+	if (bitmap_git->base) {
+		tdata->base_tdata = xmalloc(sizeof(struct bitmap_test_data));
+		bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->base);
+	}
+}
+
+static void bitmap_test_data_release(struct bitmap_test_data *tdata)
+{
+	if (!tdata)
+		return;
+
+	bitmap_test_data_release(tdata->base_tdata);
+	free(tdata->base_tdata);
+
+	bitmap_free(tdata->base);
+	bitmap_free(tdata->commits);
+	bitmap_free(tdata->trees);
+	bitmap_free(tdata->blobs);
+	bitmap_free(tdata->tags);
+}
+
 void test_bitmap_walk(struct rev_info *revs)
 {
 	struct object *root;
 	struct bitmap *result = NULL;
 	size_t result_popcnt;
 	struct bitmap_test_data tdata;
-	struct bitmap_index *bitmap_git;
+	struct bitmap_index *bitmap_git, *found;
 	struct ewah_bitmap *bm;
 
 	if (!(bitmap_git = prepare_bitmap_git(revs->repo)))
@@ -2599,17 +2663,28 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (revs->pending.nr != 1)
 		die(_("you must specify exactly one commit to test"));
 
-	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s)",
+	fprintf_ln(stderr, "Bitmap v%d test (%d entries%s, %d total)",
 		bitmap_git->version,
 		bitmap_git->entry_count,
-		bitmap_git->table_lookup ? "" : " loaded");
+		bitmap_git->table_lookup ? "" : " loaded",
+		bitmap_total_entry_count(bitmap_git));
 
 	root = revs->pending.objects[0].item;
-	bm = bitmap_for_commit(bitmap_git, (struct commit *)root);
+	bm = find_bitmap_for_commit(bitmap_git, (struct commit *)root, &found);
 
 	if (bm) {
 		fprintf_ln(stderr, "Found bitmap for '%s'. %d bits / %08x checksum",
-			oid_to_hex(&root->oid), (int)bm->bit_size, ewah_checksum(bm));
+			oid_to_hex(&root->oid),
+			(int)bm->bit_size, ewah_checksum(bm));
+
+		if (bitmap_is_midx(found))
+			fprintf_ln(stderr, "Located via MIDX '%s'.",
+				   hash_to_hex_algop(get_midx_checksum(found->midx),
+						     revs->repo->hash_algo));
+		else
+			fprintf_ln(stderr, "Located via pack '%s'.",
+				   hash_to_hex_algop(found->pack->hash,
+						     revs->repo->hash_algo));
 
 		result = ewah_to_bitmap(bm);
 	}
@@ -2626,16 +2701,10 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
 
-	tdata.bitmap_git = bitmap_git;
-	tdata.base = bitmap_new();
-	tdata.commits = ewah_to_bitmap(bitmap_git->commits);
-	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
-	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
-	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
+	bitmap_test_data_prepare(&tdata, bitmap_git);
 	tdata.prg = start_progress(revs->repo,
 				   "Verifying bitmap entries",
 				   result_popcnt);
-	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
 
@@ -2647,11 +2716,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		die(_("mismatch in bitmap results"));
 
 	bitmap_free(result);
-	bitmap_free(tdata.base);
-	bitmap_free(tdata.commits);
-	bitmap_free(tdata.trees);
-	bitmap_free(tdata.blobs);
-	bitmap_free(tdata.tags);
+	bitmap_test_data_release(&tdata);
 	free_bitmap_index(bitmap_git);
 }
 
-- 
2.49.0.14.g88b49c1b34

