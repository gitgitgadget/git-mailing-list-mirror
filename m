Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223082054F3
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983526; cv=none; b=EhifaAnjr22h52MBROo1FKmbMDSvPDPK7SNQbNcNWGm2qnZ+JYMMbxP+Oj8ESr5irGdd3Gmy04sGaBMTDKzQJ7LTGJlHDCY+OMYp9QylU9R4kCUOMAe9pnmlXHojRxghlHjC7Tf3zhi+sFkTnW8hnnH73RKz5sOGF24gvTkAcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983526; c=relaxed/simple;
	bh=wwH0XQaRbqNlb+WxfwmWe7VSWT+4MMMeQm70uzZAzoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWuWT/+fnTF9/vSPIw6q/gL6cBrQB8mBhwWrtBLszgsgjfMqRFpV29bDXMk+UW6uE44M90yYcvWAGsqtWTVBnzEVE8dUyTEyINNt0W8Ggrq/2lE/gPAYKtilTGOnxOIeskN2lhLeIfrk+HjqSYWXeN0gx+pz1fefM0UT8iNiV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MoaDpiR6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MoaDpiR6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500cf80so196115885a.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983523; x=1742588323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUi1fV5CbQ0P51wBkNONPREMhlgs8lPVXE/LfhfBuNg=;
        b=MoaDpiR6C3E9fI5/L582jrufoS1vKGZOSZK1+mHuay+v+ZR6bPWss6APQkjGufFDNY
         z9Pwia4jqgDuuRZOYR0gZo18/17YcTRUlvaugjlaR9IBe9O3yeohzWp9DO/gnRcgcARl
         Q54kFJYHiv3o7u+AQ7jnox11I/MdfvTXQmsv6Inc3Uget0EzCltIMqHdJ/R24Bp4eYU1
         tRCGtOH3Lo9Sdmoh9e2HqEBz5JtF4cX56tEwGgzUBRw8K3UKtJy4tlpQUG55sN9z3nvy
         4DGwF7DBKfrHZGLiCSxGqvVQnyn1v0QJz0xB71+BE3HDZuZFRo/cgW2etZ0t7TMnpkqW
         7cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983523; x=1742588323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUi1fV5CbQ0P51wBkNONPREMhlgs8lPVXE/LfhfBuNg=;
        b=qZObTlWlbeBSO9iBog3qYpWIcePyqbov6qWINQ1vRRzOguIYtf7PymMNoawEuMkQRq
         h+8NEH5nHkobRaCjVT2dDqqpqWkg17gLTOx8oJf/5GFBOf9sXOX5w8TvpFWEZk1lsWJH
         hXVnOumDmVLqh62IcIFwYxSA4UqQEKvc3orhVaGV/8Gxd6TaGk9SnHkcykDBJpXadlNO
         DfpxHXXjsPSkDLEv/aLjdAK69+6W7OC7ASAZ8V/bYWrLoKjAJAb3Tn888BQPBpRn6ZJi
         2dZJvhtRTbbzMmJZPiOpazCYVUTzNAFm6Q+MrSsrJVE+xpQ6ONE47SqcxfxQJ062/N5G
         nThw==
X-Gm-Message-State: AOJu0YyEmhRfo7YKxLFQ9GKG85Wv8QqGijogyPpcaEeulYW/9yq/ng+I
	aUIlfVPSckv/PpInLm/e6bcVILz0rNplkt6OrHrZDlxLO0vV7beLomWPBb6mhVavwDiT4yrBZaF
	W1ds=
X-Gm-Gg: ASbGnctZUI3QWfIjWSYQMabjhxWwIM570u81b3h7HVmErnp2FjOtajJTW5GsmcfyIig
	BDOivkBOzkq2fMJlm+FX+jYLqVe8h7ZcP8p52Eb6LaQx9vopVgp3I+kp1t0kpK5BC7GPv2uebS8
	kusWaBLRgWlPOxe78vu8Q0oldEoOEiAS1WgQPJsEnRjsse8PnqSt9aKeAVU+Vzsvqwela2jG+dE
	DSxbHpdp9xcgzpGsweWo6luL0sifBtBdq3m/W9wFuoQh9kWw7kbnFZWYNYooZqzcQIjyyvhcWsY
	YTkq8ggj1r5UVzjje0LqGxi2GCCztBMZ6bvt9LNLcYIq0AUav9iGWdUPIvVEgWRqwNhCnCA5dfw
	UennGwiAFdYaNC2TC
X-Google-Smtp-Source: AGHT+IECe4CHLsc6BKmFACyDXxT8B7939TGaNHbwaUVfZLC9PGag3dFgY6ryRoDfPWR0jQL3hH/CgQ==
X-Received: by 2002:a05:620a:4550:b0:7c5:49b7:237a with SMTP id af79cd13be357-7c57c7e22d5mr415952185a.19.1741983522739;
        Fri, 14 Mar 2025 13:18:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c4db57sm297931485a.8.2025.03.14.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:42 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 07/13] pack-bitmap.c: teach `rev-list --test-bitmap` about
 incremental MIDXs
Message-ID: <b45a9ccbc20180e3358e314b4fd5e46bfa566241.1741983492.git.me@ttaylorr.com>
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
index 7a41535425..bb09ce3cf5 100644
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
@@ -2511,6 +2524,8 @@ struct bitmap_test_data {
 	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
+
+	struct bitmap_test_data *base_tdata;
 };
 
 static void test_bitmap_type(struct bitmap_test_data *tdata,
@@ -2519,6 +2534,11 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
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
@@ -2582,13 +2602,57 @@ static void test_show_commit(struct commit *commit, void *data)
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
+		CALLOC_ARRAY(tdata->base_tdata, 1);
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
@@ -2597,17 +2661,28 @@ void test_bitmap_walk(struct rev_info *revs)
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
@@ -2624,16 +2699,10 @@ void test_bitmap_walk(struct rev_info *revs)
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
 
@@ -2645,11 +2714,7 @@ void test_bitmap_walk(struct rev_info *revs)
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
2.49.0.13.gd0d564685b

