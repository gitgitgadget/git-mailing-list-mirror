Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4C227E81
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493417; cv=none; b=EXuR7DN5ZxrvygxXeQ8IDdkfav3OFLp73iDeVqFMUhIm6g2l7bDInVAlPRi/9ZI3D3+ctsoDLjMaBW3WK9C/bzf3UGKoHwK6+UW+33VVmZyAtKxzUwDKpaFUiiNPPFsoj7K/iFMcnlHHgjBoxgkrvRnoae1vvAEjb8DwW8nLKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493417; c=relaxed/simple;
	bh=e/swQyaGBSuYBv/vUkxE0VVD96fVnK7K874+NJc1u0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDecHDdP0xVbqTGmFs2mvgpVI/oLoRKssEG5vmXcmMmHsH15VIVy6QtINhGGzeEmu4IxfSeooA04Accy9x4OTdyMnmqgYQ/YwiNOwk+MUdXWUvkfwt3mElVDDiqSkfe/w+yQFtwxQqppBcY/MCwIx17hgrFetvDXoUgrwAiWCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cN7jk5d1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cN7jk5d1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476775df2f0so20737041cf.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493414; x=1743098214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO5Yoa/oX4fnHaQ0thRBTiNtX94aLzclbBWwjOYbegM=;
        b=cN7jk5d11JRjSqgdXolHfrbW5QZxeQYezZkxMsznisCwW3HO/d1/Gneuj+6Zd8iyIC
         R/v7jfKz8uG22Rm6IeHdpanFI6ptusJ0HBBFDrQ4mwFRzofMMu8cx1gjyuSEWYl9rpOd
         fEGBlvhAaVLEESJneFnRUIlit42S2hmBdI44gl4pobygjzgCJIUuqvOoUjbyC87UXap7
         fUyCPmFbfW7JBZ6yB4qOddnktt2hGjKvfmU3uUPh61vyYKI+hH37k0a7LwUnec499jzZ
         K8JVymm1lk3naq30whVg8ecXatYH3k65CnmfzGptvZCKAnganTCQmvdBjVWCfz2dREgu
         b2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493414; x=1743098214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO5Yoa/oX4fnHaQ0thRBTiNtX94aLzclbBWwjOYbegM=;
        b=tmKciTwo2/75njubdhMY+PT4FUlHJc1pHPtDKIhZNrY1Mnc8fCpKYyAnLlCjv3UpMp
         fDeR/upQLz3tIrid3Cqmkqo3TqPpjkeJTwdKvucHphYsC1mqAE+3+iS6Hm2/HGYKpMQU
         GheZFlH+RHIPfrgckHtP+yJraxjOVDPVeocJwxs2sQnHZRntMvdNCjptEuSrdtyW+AiS
         YQvn3wlVMWhouJTFSEibuKMTCiZ/LDWVx7kjjp8JzdFqtlY7S3HY2Md5az1Fnbj8RZQ9
         +6/68mdPYtAQqmtmbtzB9NNR+Dxrocsnm8HwrwwLXBbZUmpdfUSxNdcyrYZS3pgKQPKq
         +uBA==
X-Gm-Message-State: AOJu0Yy+PX0lWiC/MEFj6YAOQpFMiYnCnjhaxBq/+yYxXe/NMUnfkuS9
	GCUiXxTbmOwJK8ZR3UVNT6M7c5GubquoXxnZlcNZKH85H9/ifyp2kFsqln5ohHVtuC3FB2WUYTg
	Scx8=
X-Gm-Gg: ASbGncsT00b6ftOE6FiKfmHDMQyObeCqX1/XaRnpUV6ng2iVsdlfZCfcrUm00MRTWjK
	BKLeHA4ueFbxJcbr0xBDW6I9VK1xLpGRdDAgctJhgr3ezvYZLCtmYtPKCLfT5NiAnl0kmZUPTaY
	3BlP1I9zK9igaSv8/6zKlyKTslpS9ck7Q59skA4uHC2+BtJmM21+3DzqL4oTAxFkg4ELGrJlyIU
	zX5vMi4vtM/+x5q0lmBSXXqSOxxeSpGzihaeB8nXptdSNl7Mrjkx+xDLPVYq7choDeV0czsB8JL
	Dd0E0HSgW5AUHdi2aMe+SKNTL/nuHbbVFHn54w8JxWY7OUlm4HwIM2+cQ2akkqapvu/dHDaS6k8
	rWakTkBw+T8i+1eIw
X-Google-Smtp-Source: AGHT+IFGBM0smCASxlAjkrwd20QdlRnInfhsfqoemI9nDOOzdp2Q1PJdaadFlQWb43u5z1XXVJfqMQ==
X-Received: by 2002:ad4:5ecf:0:b0:6e4:4adb:8c29 with SMTP id 6a1803df08f44-6eb34996fbcmr60760916d6.12.1742493414058;
        Thu, 20 Mar 2025 10:56:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef0f405sm1163406d6.20.2025.03.20.10.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:53 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:52 -0400
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
Message-ID: <20250320175652.huJnykbhBJ9dLM6drZm3omfLTisaJX-eq1TQ5FN52h4@z>

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

