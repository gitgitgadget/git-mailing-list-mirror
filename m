Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F568156C5F
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760966; cv=none; b=kEVbJ1wBJvSHd3RQco3M8P06IyKXIWGOq3AOrvwXecC5Fbbvfg9an8QqF3AC5HC+X4/twbkvq9DgTIp2fdIlr4LjNEK0g2hs+BLIzyErp2XTAqehUB3ZFOvswc+334Eq9awDjVKVuMYhdsA4cgN3Qry+Uj+XiuklSLOOJFC7kw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760966; c=relaxed/simple;
	bh=Kbhib89U0y8ygjQysH9AhiuC1dwlrxVvPwUU7EhTViE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe0ahTtXwfcokaX7gMIE+L0OlEh2LAzvHBoKgpflgyLJ06P59uV3iiVE7H+ELNh3DFyn+7tKu+uW4rpWB2n5IAI/0b1sHoLKQwKMt/jng+/c5ANkkTa/aBQMiHYJWIhxlMydkBWtfUY4MEbMTW6eKSM6Alwbho15G385SoiS8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tapXi6fw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tapXi6fw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e11693fbebaso1693236276.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760964; x=1724365764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ldVvuZshyODGMuDow6l9/6JrqjZzTJb49kzfy3z6M=;
        b=tapXi6fwxVa5DWejW8dWVommg6NG58Yt2nEPu/dz0HQRYt74F7H5Y8VdMlK3KhAGtQ
         p2+Ux8xWSO1xqGC5eZNOrcKOaLlsSKdkNBGXjUqlOGCZEuxtVcZLWwtOLSk/foRDqPuc
         tFnxxlWI7JSNqNEF6Zqdxm6IuEPwZNrYj9IovJzl9L2fNNzS2Bk1G0dziI8mlW4nHhTB
         4XkPbh4Jpa0GFdI1B38PbIlsXVJ1c4ppK/Jr5FC+mXBzTf0aPSkAjrqAj+V7r3kKm3/0
         XMiWN3oP/Mgt9FndPDYoVuZ62+vdkLtgMI/VaX63PbKo92cAQ+Fkw9LxOsOvMo/XYQNH
         kmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760964; x=1724365764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ldVvuZshyODGMuDow6l9/6JrqjZzTJb49kzfy3z6M=;
        b=NmWNlyJfewhxdWW3rrqtcHIEjznztMZZfGf/wggw491B1tw7HxIlu6gopLa14SRW00
         bO2iFbIoJtclvrxt2OLU0tT7aDgXz19od048JlicGI8KQfXJEBB0ld56uAKUzeOM/+GN
         SGzqT/FXJ8ya/tZwbDoBbJy/TUkqDOpJ9AnL5hctUnAx28739XyTHOgSS5BpmRlIiTWw
         EBtMkjWjQbMMmsj0NykZZ7B8i/bCJKO5O3opQ4dIbK2xkG7/anm4bg3bND8/lwP9S1Gu
         hI9JthKgnyjTdulu+qlcHrnrTd8Lzepdiz1SjJr/nO5c/lS4rY5r1eOWnbSkW7lKFNXe
         UA7g==
X-Gm-Message-State: AOJu0YxuVcZeSJmJD0VjZgPIi6d0+xXKd4J2xKA3azm9psFfj383alW5
	S6Evbyb7LyTfWAQIhqoFoJbNwVkQ5d/nc7HnV2k28Tpprubp8F3tZB/5XXiEXgaiOcnwb80GWoo
	j
X-Google-Smtp-Source: AGHT+IH4sHjRHWvxC4846j0bQ8NSIWU0+rXIl7l2JnBy/5YMcmbIAeNXW+kVRsGFRSQdmRlHew6TKQ==
X-Received: by 2002:a05:690c:4c8e:b0:6b2:6cd4:7fa5 with SMTP id 00721157ae682-6b26cd4802amr381477b3.32.1723760963992;
        Thu, 15 Aug 2024 15:29:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a4a5sm4164317b3.99.2024.08.15.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:23 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <c4d543d43dc25ee0036a429bbe962f95f261f80f.1723760847.git.me@ttaylorr.com>
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

Prepare for reading the type-level bitmaps from previous bitmap layers
by maintaining an array for each type, where each element in that type's
array corresponds to one layer's bitmap for that type.

These fields will be used in a later commit to instantiate the 'struct
ewah_or_iterator' for each type.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1fa101bb33..e1badc7887 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -78,6 +78,24 @@ struct bitmap_index {
 	struct ewah_bitmap *blobs;
 	struct ewah_bitmap *tags;
 
+	/*
+	 * Type index arrays when this bitmap is associated with an
+	 * incremental multi-pack index chain.
+	 *
+	 * If n is the number of unique layers in the MIDX chain, then
+	 * commits_all[n-1] is this structs 'commits' field,
+	 * commits_all[n-2] is the commits field of this bitmap's
+	 * 'base', and so on.
+	 *
+	 * When either associated either with a non-incremental MIDX, or
+	 * a single packfile, these arrays each contain a single
+	 * element.
+	 */
+	struct ewah_bitmap **commits_all;
+	struct ewah_bitmap **trees_all;
+	struct ewah_bitmap **blobs_all;
+	struct ewah_bitmap **tags_all;
+
 	/* Map from object ID -> `stored_bitmap` for all the bitmapped commits */
 	kh_oid_map_t *bitmaps;
 
@@ -586,7 +604,29 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
+static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
+{
+	struct bitmap_index *curr = bitmap_git;
+	size_t i = bitmap_git->base_nr - 1;
+
+	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr);
+	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr);
+
+	while (curr) {
+		bitmap_git->commits_all[i] = curr->commits;
+		bitmap_git->trees_all[i] = curr->trees;
+		bitmap_git->blobs_all[i] = curr->blobs;
+		bitmap_git->tags_all[i] = curr->tags;
+
+		curr = curr->base;
+		i -= 1;
+	}
+}
+
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
+		       int recursing)
 {
 	assert(bitmap_git->map);
 
@@ -608,10 +648,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
-		if (load_bitmap(r, bitmap_git->base) < 0)
+		if (load_bitmap(r, bitmap_git->base, 1) < 0)
 			goto failed;
 	}
 
+	if (!recursing)
+		load_all_type_bitmaps(bitmap_git);
+
 	return 0;
 
 failed:
@@ -687,7 +730,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git, 0))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2042,7 +2085,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(revs->repo, bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git, 0) < 0)
 		goto cleanup;
 
 	if (!use_boundary_traversal)
@@ -2957,6 +3000,10 @@ void free_bitmap_index(struct bitmap_index *b)
 	ewah_pool_free(b->trees);
 	ewah_pool_free(b->blobs);
 	ewah_pool_free(b->tags);
+	free(b->commits_all);
+	free(b->trees_all);
+	free(b->blobs_all);
+	free(b->tags_all);
 	if (b->bitmaps) {
 		struct stored_bitmap *sb;
 		kh_foreach_value(b->bitmaps, sb, {
-- 
2.46.0.86.ge766d390f0.dirty

