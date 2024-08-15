Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B214E2D8
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755716; cv=none; b=Z4YICtIWOUvD7F0qxXgofop69B5m5h10d7YtX72C5DEIuZEOtTDOWAMEw9GU00OgeD07rhtcm2CHcJZO/psgm5OrqYCQjuBlPDgWVlzSxWhhrehYjIQF7e7LAIax3NbunRA+UiLR0eD7vfS5ZkzMXBzJNJFkZbaMGkOCJeOH3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755716; c=relaxed/simple;
	bh=Kbhib89U0y8ygjQysH9AhiuC1dwlrxVvPwUU7EhTViE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6/JdJwsCAVIn2rvyRp7HMvlUqtxl+GPeFtTp3YKiAJZEXMEQW8FlyDD2AxJJ78EzrYQlS5bFPDwh9P3bkW27RCO3JWtTD72GL+znfmg2qiFb3LUkqsc3JpgdnJGzybf0mSq3r0b5Zg9cqSE9/mVkZF5mp+SYMAAweiqkzhukzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fu80ZfOB; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fu80ZfOB"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70945a007f0so810764a34.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755713; x=1724360513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ldVvuZshyODGMuDow6l9/6JrqjZzTJb49kzfy3z6M=;
        b=Fu80ZfOB/tDXDnKUf4fcGQeHqy+yu2ftgZk3BuNt1NSGVJbljG6bXuHAo+RRXgoPhx
         O0Uao/5U5DeLiycFlrKyq90WcTn5Dkd5gT/CLKLEWXOcdYAaOlb/uV45TPstrNyQ8KIM
         v05excDRR9ryNdqiIgYreC5FocCgWs8eM2fBJKqaIFJagNBnArhvGD5gTjj3xAlHiulf
         xipW7ER8ytvsNcGAAzmA5gm0LFoTXy5o1VfIGpPta/QhqABDdZaZYuLZ+NxRwRiS+9CK
         FzZzo8m9OgvXsSkl9jc0gIHFxeTRVrOSK+p3bkA65KzL2IqpL6ws6PJRpYA4Vru7uJYc
         Tc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755713; x=1724360513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ldVvuZshyODGMuDow6l9/6JrqjZzTJb49kzfy3z6M=;
        b=PDcloYV1J7xEqazt7DHIGVmsaQiwI1ynrkNnc9bf1n4gxo8pspPRywOqGu/p9bCXxT
         dpJHFEh1+naF8uYXR94HKjLbaLTOADaJ9jK+nsHpgc60b2KCXrMd+bSyGH8kCimmLAkI
         GiYvmCpZM7IPNUXJid4fYTacX4hOmL2/8RN2ywEDGEwSXoOt0wYJCQ4bgDCN0FujCpG/
         kUNlUaoDeJbbqLVNyR4rVN/mKX8Z5yRW7T+YxPOw7Y9Zl7Qrhw9+uT4b5iXBj9LyZrhy
         pNM3UVspFwniU0zMVrSV44n7DvuVoV9VjiB/3Uksma6nKteLOFZkuNEmi09OnK4+Hlnf
         w2FA==
X-Gm-Message-State: AOJu0YwL4EQ2zJjLYn5YD2j70uB2u+SAIofjKNWJMIC9xpA8o2+N8OUK
	aUMTsiT3lb2cGjqhq8sA0k5ZDdaIEZmUvWVukK7YZasi1HL6EWVfAK7XG3uAHZVTXru7+Eyp6nw
	s
X-Google-Smtp-Source: AGHT+IEL/bZNlfR8PS7f3d/qcDuSb+DX9CW/TbBMdCy1fqxEDqUXeOs3tzhdAY1xs2srZHbHQ7kaPA==
X-Received: by 2002:a05:6830:3788:b0:708:b344:fed8 with SMTP id 46e09a7af769-70cac8d53b0mr939144a34.33.1723755713413;
        Thu, 15 Aug 2024 14:01:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d82757esm3897807b3.104.2024.08.15.14.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:53 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/13] pack-bitmap.c: keep track of each layer's type bitmaps
Message-ID: <01508e4ff56531a271beca95b5a8e64bf842fa58.1723755667.git.me@ttaylorr.com>
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

