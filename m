Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958D149DE3
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755704; cv=none; b=sL89NbcB/+IxgTL2uDSPKV6pqZE7IgiKJr+4eFLteGtMoVr6x/5CxHvJ2m54Rehc6ur9pI/4LOUnWgZpdbDX8JaYEwBzDcKkI1kj9mYP2amjIUUJZ6g3SyDHIzJ+XlU5ooiagParGD6qrvlltg08H6AtkAXNJYJubMM4L2Y4HUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755704; c=relaxed/simple;
	bh=a3kgtv/MMf4WCWdp4KzOSOjY0Cd6rX/09v6y4OiCmzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQWVAQuRIWw2mhAcZmEhj7ME477AQX6eIXMj3kkQL/+gZYfvc2CwB7kEqkH9e9izkBRWtK5z6rPLw7hNfzCrbHikKCs4o5I4xczIaHEIp4mVLtaiAN6yZHLnQJawUjo8vHxOd7J8zt0BF2GfE8yqjxS3dDB36GkLe0eeFdlzvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ee6e5q8l; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ee6e5q8l"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1432284276.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755701; x=1724360501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aPkBe+rAAR0WgzphauuzcOxRQIV1mAnmFFkXYP6HoY=;
        b=Ee6e5q8lFnHH9G3tIaQv8oNXw91hBbJ24SQVyelMuaMu6fx7LmEF7ViemJlpcwDn5l
         gWJ/x//lXNehRVPcv3Dq5Cb4ijbVPq0yAyA2Q+usEx4KPGwR9afY5xdb1NKcegLbF/5l
         PY37MT/2y7LqgcpwfBf/nC2Bco3QGSO5w1t4RvuOYK4dzOc/TMkTWojFhxlsZ4QKCl6n
         YdNmfiKamYf+3almRdkT4L7dLuqFQrqNQiGS7TDVt2jJKSccsvSxeiYNUK6CmwBPCAA9
         GQPzSAU7U00vqHo8N60EKu+O03hivhpxfbTyzrtvm0fTNvQ11EygduxIc6LPoJ8lTnEG
         Evdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755701; x=1724360501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aPkBe+rAAR0WgzphauuzcOxRQIV1mAnmFFkXYP6HoY=;
        b=Xy+k4xBFb9PkntOhvKk0I1SGe1FH6lTX1kYMK1X79AI3eqTM7K7HP66sYcgaLa7bMZ
         MB6Cpc1WImGUeqp2vVvqnbWVveMWg8NCBDCd4yWkUC7e5Gc42/eKtgRi6UyQN5QClUuY
         QTLuYjnnXspckyJo7pQtzHnSVjvVh72UUTTkrYPqj7Pt74yYby/kyZIiDX5Q+tvJt0C5
         1VR1VhgVF8QoMA2xrdGtwrAVwTEC6uK/PHzJV5mcSp15HPmlP5Z/L8QRgRPS1Ky0Kbj3
         /dVwzLSA8z6MN6FBWtqvu6culLxjc2wwSLSDKvCyKsuc8PYKrbWImPXPa2uu9du73GZP
         VydA==
X-Gm-Message-State: AOJu0YwT/kg0wOFSajvUtGJABSsn9YGrmv+4Jw8qLEORlzW1x26pCE0o
	PdFMo9CJ1neQBLXL+fGG45ybvR4+fNQzkURjlpY7E0NE9S3qjLNR6I0JWh/btdh4MWCFymCZQrJ
	Y
X-Google-Smtp-Source: AGHT+IEs3Iq96E4vYsBMkxOhB/E7EHZBB/G0g2AbZzpOtUSjC2SguWZz3rWk02CGB/Li4nJF2LYbIw==
X-Received: by 2002:a05:6902:2589:b0:e11:7744:e55b with SMTP id 3f1490d57ef6-e1180fa4b36mr1131013276.37.1723755701354;
        Thu, 15 Aug 2024 14:01:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1172008d19sm451540276.44.2024.08.15.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:40 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/13] pack-bitmap.c: teach `rev-list --test-bitmap` about
 incremental MIDXs
Message-ID: <928a4eabc8b305f7608c082dcb61cd25f2387d3d.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 105 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 21 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2b3c53d882..5fea2714c1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -943,8 +943,9 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
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
@@ -954,18 +955,30 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
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
@@ -2489,6 +2502,8 @@ struct bitmap_test_data {
 	struct bitmap *tags;
 	struct progress *prg;
 	size_t seen;
+
+	struct bitmap_test_data *base_tdata;
 };
 
 static void test_bitmap_type(struct bitmap_test_data *tdata,
@@ -2497,6 +2512,11 @@ static void test_bitmap_type(struct bitmap_test_data *tdata,
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
@@ -2560,13 +2580,57 @@ static void test_show_commit(struct commit *commit, void *data)
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
+static void prepare_bitmap_test_data(struct bitmap_test_data *tdata,
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
+		prepare_bitmap_test_data(tdata->base_tdata, bitmap_git->base);
+	}
+}
+
+static void free_bitmap_test_data(struct bitmap_test_data *tdata)
+{
+	if (!tdata)
+		return;
+
+	free_bitmap_test_data(tdata->base_tdata);
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
@@ -2575,17 +2639,26 @@ void test_bitmap_walk(struct rev_info *revs)
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
+				   hash_to_hex(get_midx_checksum(found->midx)));
+		else
+			fprintf_ln(stderr, "Located via pack '%s'.",
+				   hash_to_hex(found->pack->hash));
 
 		result = ewah_to_bitmap(bm);
 	}
@@ -2602,14 +2675,8 @@ void test_bitmap_walk(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die(_("revision walk setup failed"));
 
-	tdata.bitmap_git = bitmap_git;
-	tdata.base = bitmap_new();
-	tdata.commits = ewah_to_bitmap(bitmap_git->commits);
-	tdata.trees = ewah_to_bitmap(bitmap_git->trees);
-	tdata.blobs = ewah_to_bitmap(bitmap_git->blobs);
-	tdata.tags = ewah_to_bitmap(bitmap_git->tags);
+	prepare_bitmap_test_data(&tdata, bitmap_git);
 	tdata.prg = start_progress("Verifying bitmap entries", result_popcnt);
-	tdata.seen = 0;
 
 	traverse_commit_list(revs, &test_show_commit, &test_show_object, &tdata);
 
@@ -2621,11 +2688,7 @@ void test_bitmap_walk(struct rev_info *revs)
 		die(_("mismatch in bitmap results"));
 
 	bitmap_free(result);
-	bitmap_free(tdata.base);
-	bitmap_free(tdata.commits);
-	bitmap_free(tdata.trees);
-	bitmap_free(tdata.blobs);
-	bitmap_free(tdata.tags);
+	free_bitmap_test_data(&tdata);
 	free_bitmap_index(bitmap_git);
 }
 
-- 
2.46.0.86.ge766d390f0.dirty

