Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798862066DB
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983538; cv=none; b=lBWuaptWzBTEBZIaiRxffARWdcFlf2BVb+KB7bhw0Pl+lc6LCjlw1PgwCrjxhLn5f5nIPuV2GO5q2g7vofDFX9c4zOqSJzEtC07imh3kINa7PWJMzCByLSdXAL1EJGD7QujeXR0pKQ6IoNFSruczicXrIo6LW1PvUxPGFjqMydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983538; c=relaxed/simple;
	bh=J0/YefXaYWBkw+PcGEkx1pOjFrjKfBDFigogdDtW2Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMm752bqqpLAG54WTiEPhZ+/ww5iFXyJX4JyBH9Ps4VmiNjXIpADOyIkiTg9maGBaBw6q4adMVabXZlxAfn+XgD6zrPqGdJztXKvpSQUvyKVfrpGgEAVt4+fL+FlxtGY7fe3YblUWwrV5+RftXnLQxNS8vQ9Fom9t64pINRPZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TV82YcU/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TV82YcU/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c542ffec37so255012285a.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983535; x=1742588335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmzxNlob+PFgER2n2B7XGmwg5I58P/R5fpgwzx815nc=;
        b=TV82YcU/GiNGu6Czsuft2ztRRchw9ZGNbFCyf+G9Lly5h+trM+BYwE2OS3HlWaJAfK
         H2zDblJnkt2J6ap4yv2WOMZo4BZHhHVllUc6zIqzeesIIgPAXow/afJfrRLQno2xLIns
         /YzXB8iFSvoEDOupAdF0oLOB+wsyCluwQ61reDOIq3J7KUj5nyRcKGA8qbDM7NEgHPWn
         dWmlj4VXXQYkujUPk1txliUpxjch7ABoKEWRMMHIjsQomRQUBFdwcB6jcMcpEFIIerjl
         t7upxaUelvoxByToaHWpgBJRRp04roZHKFADNwVf5C2aRPgQvHVHdDwrb1wIQnZF35Pi
         876w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983535; x=1742588335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmzxNlob+PFgER2n2B7XGmwg5I58P/R5fpgwzx815nc=;
        b=Ub9kfSwW6xS5z1gwblYb5uhSJA0Y+rFzMqM8rWAoWafCzROqn1FJWD+2wAiuneqWbe
         2XOguwm1ztQk7YRiBjOQT1U8RaEhUFOo6G6KUUKSIRo9Hhve2fN96aIJ6vPShEpEcLZJ
         utNoAaeuCJvoFhiaBQTHKBMrtoK0o+oRNa18fH6QKhyPnLHpn9OYO2g8W7eSkgXdVyYA
         Rgk/XYd0nv4x3Cqxbb1QJ08Dv3+y2vW/1UBxnn5UJ04BJn2m97w7UFAfRXWrGT/OU3Jr
         HuMKQp66ZlvPaZs4t5bBHCq0yF2jzM/HvnNWOaKlY92CLqT7aQX80NCcPCFjzzMk8wcJ
         6cEw==
X-Gm-Message-State: AOJu0YyF6FQSEkC6/bHUaI3sQ+Y3tL8QcspkCZQZzNV6MHsVNKKllS9U
	7lZva7IH0jcVVxA8NmAhvdLHBjBiNbgcNzfJJj6jqDreS2Y72cefeq5gA4yTLPIU+Bam5jEVAD2
	qFAs=
X-Gm-Gg: ASbGncsXNTi+HjwkKKuN2wvfV8j2say/5ueNADcSR45Be4LclJDZv67DydaZMJSdNvb
	E0uDoHlgW1sNUgTErWTUBVt3k13Jgmh4YlhEAhLdmApIy1kraVc4eM41oT2xbC2eMQ9UzGzX/eS
	B+UnCdm8cwDmyABBXo7Hm9C39UOz1shlr+sp68zFm5u++dsrmSiypfIbcgQ4MeqoV0uGLSWTpDa
	wnMow+IaA5UvKGzlZBJTwYPKyQN3u51c8UjVkhEcfofcxZu1rjAijh+FyHxUYHfGfM+2YcbyNDe
	QWQWl9UZZifBxNGGD3pPRU1Kh3Q+9vsV2AmP/3qznHw3YQxdg21uzSwa43zn3nprUZcjL5AFaua
	UpokEhD8ZhajEcoh1
X-Google-Smtp-Source: AGHT+IEO1Bslg/4xqUehbqWx+b7xclr4RNYylN+dRjL/aGGAsJZZttK2Sy4WILD5QMXWzivB5bBRwA==
X-Received: by 2002:a05:620a:1a88:b0:7c5:4788:a152 with SMTP id af79cd13be357-7c57c9191d0mr651156285a.49.1741983535129;
        Fri, 14 Mar 2025 13:18:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c7853fsm294471485a.43.2025.03.14.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:54 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <a29f4ee60d519318d36a8d3c812b4bad039b891e.1741983492.git.me@ttaylorr.com>
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

Prepare for reading the type-level bitmaps from previous bitmap layers
by maintaining an array for each type, where each element in that type's
array corresponds to one layer's bitmap for that type.

These fields will be used in a later commit to instantiate the 'struct
ewah_or_iterator' for each type.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 00acf5ec73..3517972892 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -81,6 +81,24 @@ struct bitmap_index {
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
 
@@ -581,7 +599,32 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 	return load_pack_revindex(r, bitmap_git->pack);
 }
 
-static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
+static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
+{
+	struct bitmap_index *curr = bitmap_git;
+	size_t i = bitmap_git->base_nr;
+
+	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr + 1);
+	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr + 1);
+
+	while (curr) {
+		bitmap_git->commits_all[i] = curr->commits;
+		bitmap_git->trees_all[i] = curr->trees;
+		bitmap_git->blobs_all[i] = curr->blobs;
+		bitmap_git->tags_all[i] = curr->tags;
+
+		curr = curr->base;
+		if (curr && !i)
+			BUG("unexpected number of bitmap layers, expected %"PRIu32,
+			    bitmap_git->base_nr + 1);
+		i -= 1;
+	}
+}
+
+static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
+		       int recursing)
 {
 	assert(bitmap_git->map);
 
@@ -603,10 +646,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
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
@@ -682,7 +728,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git))
+	if (!open_bitmap(r, bitmap_git) && !load_bitmap(r, bitmap_git, 0))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2050,7 +2096,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	 * from disk. this is the point of no return; after this the rev_list
 	 * becomes invalidated and we must perform the revwalk through bitmaps
 	 */
-	if (load_bitmap(revs->repo, bitmap_git) < 0)
+	if (load_bitmap(revs->repo, bitmap_git, 0) < 0)
 		goto cleanup;
 
 	if (!use_boundary_traversal)
@@ -2983,6 +3029,10 @@ void free_bitmap_index(struct bitmap_index *b)
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
2.49.0.13.gd0d564685b

