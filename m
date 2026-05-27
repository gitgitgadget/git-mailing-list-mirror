Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5B3B27E1
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911760; cv=none; b=CXhcBXoei9jWobBuoCwiPyLYS/9NbsdPJx6rEwywtGjAg0B+Z3pFXqaxoPHF2B/XkSqSG03kb7/i9bAYqDCes91d0bBjgsETHX4bwLYI/5sUuyn8aRjR6gyLmBoAJqndVayO130t+q1dJ8OLM5y3LwABk428qQnc3CwilU8eA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911760; c=relaxed/simple;
	bh=fbUBpTTfyR3WRb6QusVG+sB30xW+yOIW/pdV9Zc6RHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4IYTjUNApCI/AgRCO12/Qk82THayyjD+mzNMjeTA03VtK7OrOPAgpMjm6l2m4M9lZMNOl2PT3jIIhoIrnGmxvGHePy/MHwBCV01yrWcWEoOeB76plh7dOhFC2scNDMKstJTg5uFbd1Y2v4aiqdcAXBmPb8uTrOYEp+mZEiQEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gayvwSIV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gayvwSIV"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c0dea734b8so116694347b3.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911758; x=1780516558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L782fL89Pw8BgjIOEqiM98XCWQdoDoaUmyOh/NaSWxQ=;
        b=gayvwSIVmvvhBJNLf6GFBJ0UD0WczG27kqawDPLO/vxxoaRiNGoyUHnEqn7fYUfIyh
         8PQ78ZGhcC5qpheoAdzVLIBebrkSWPKIwjihjzrt2A+uAYpzYbMZ8FPu4Y5bocrkLFS3
         9qgk3ba1Kv6RbymKf56T6eMcnkX1LLcTHVqACJIWl65+x7UmjCZIGTzSJBdramBpP9cf
         cQJeyPUHO8L2RLRhyb94/jZ417sc/eY8+jF1R69acXeD449azwDSDzzIF32hJDy6Mjwq
         m+JxlRn+xlO095MmdrhlEIvtb4G1otc/yeb6dtAt2eHzyBLASLlfQ5tKgK1feqcTWg4a
         E7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911758; x=1780516558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L782fL89Pw8BgjIOEqiM98XCWQdoDoaUmyOh/NaSWxQ=;
        b=o8dkemf3VQBeNgsoCmCcUF1YEfT6QTDld/QIwjww73e3VrM8N0tmYApiDrX72hnKhC
         Qo/4YNYxKaFaJQ6peGaNoNZTWeuaF3L6/AjpuTBPu2yug3xgEwP62AH9R0PCYpRD13D4
         KBj4fWRbmq/IgXfACdDxyCU9MaMITJ7mEoyd90Pv16QJhyQpo8nHnXsN8L+u9afN441X
         R/mNAl84znXbdLx78TSHKKMqEQkhh362Strnqw6gJsrYpneP7sioXNX32HPecSbO77Rg
         oG18bF1D1Qq/6q/4pG7OtgfOi3DwJ8o4xkw3ZT8TU7w/Qerye4b6NJ9jYYLdnZcfionO
         dq5A==
X-Gm-Message-State: AOJu0Yx9dJ5TE9KE9/Kkohrv1xlw05GWQZDxRVXDTBIQn9oZOJTDeTON
	PWx2RX6iF117RrFeq9yoSMoYWRMj5yMiMs3O8h7QXXnkvmU9+Gt1Aho0hqWtVYc3/luO28+Gw0+
	t3qpJ
X-Gm-Gg: Acq92OGt/CpdMp/DwkdYEIeo1L+14V7jFTDhrvxmJxc43Epj01PDWuoIE4/q6FEsuDs
	H+in/czOHbTxCcWLb8ZfGdbINoFFdt/0zuki2dEbhmY3eXhIkGsttMHQr4dfPEIX/K5+Zd72ydk
	1i0FhS+U5yW9XqmpmoeX8L9GhTyHZCeLFMLXLixCuWPAkNVMIzPjRxusNu26KrgXYEcE+jRkQHR
	8U0D0X16i2cmz+nyc7KCyRZE/pAJnLVkJMSepjvB1LL/ql4Aw4j+gIlLn6BlPqLLYlrwrwrbnT9
	nxSUcG08Q1gBCfTD/vCcV3JfX410Q9kc+kysI1HO3QO017/z6hiuQXmGSne2q0toX3Q9+s6LPhL
	Ia007kbldu+yLMLPAPRXTYh1Pj0zze7tatp+wf80UXhDwpYCuJDufvsXmW4ZE7fAc5KrRMXQ5GY
	039WssQRdptBacueKOPV/+8L07MCDy5GfG9qHbu08CllUEo+dJzGnHSEiNbP8aRD7zE0OLyEJ+U
	i81TIJdbyS8MGEbO/9aZcLgaxnFN5rIfCaoJvVPaeQu1kHwrW0zKHkUlsL1/THR9HWFq5kouDIa
	FZlOvkWu5YNhL4wxbmIgkx+rNX8=
X-Received: by 2002:a05:690c:4d01:b0:7be:fedd:726b with SMTP id 00721157ae682-7d3362b1d56mr258938087b3.42.1779911757683;
        Wed, 27 May 2026 12:55:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c8basm80777137b3.37.2026.05.27.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:55:56 -0700 (PDT)
Date: Wed, 27 May 2026 15:55:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 3/8] pack-bitmap: reuse stored selected bitmaps
Message-ID: <f13d65c0ad9d57bea2eb81a58d7e9f25c25b9e68.1779911733.git.me@ttaylorr.com>
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

When `fill_bitmap_commit()` reaches an ancestor that was selected for
its own bitmap and processed earlier, its object closure is already
stored in `writer->bitmaps` as an EWAH bitmap. As a result, walking
through that commit's tree and parents again is redundant.

Teach `fill_bitmap_commit()` to notice that case. For non-root commits in
the walk, look for a stored selected bitmap and OR it into the bitmap
being built. If one exists, skip the commit, its tree, and its parents.

Building bitmaps from scratch on the same test repository from the
previous commits yields a significant speed-up:

    +------------------+-------------+-------------+---------------------+
    |                  | HEAD^       | HEAD        | Delta               |
    +------------------+-------------+-------------+---------------------+
    | elapsed          |   562.8 s   |   324.8 s   |   -237.9 s (-42.3%) |
    | cycles           | 2,621.3 B   | 1,508.6 B   | -1,112.7 B (-42.4%) |
    | instructions     | 2,348.9 B   | 1,436.6 B   |   -912.3 B (-38.8%) |
    | CPI              |     1.116   |     1.050   |   -0.066    (-5.9%) |
    +------------------+-------------+-------------+---------------------+

In our testing repository, there are 1,261 commits selected for bitmap
coverage, and 1,382 maximal commits induced as a result of that. Of the
1,382 calls made to `fill_bitmap_commit()` (one per maximal commit), 131
of them can be short-circuited at some point during their traversal as a
consequence of this change.

In large repositories where the cost of filling the bitmap for any
individual commit is large, being able to short-circuit even ~9.5% of
the calls to `fill_bitmap_commit()` results in a significant savings.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 72610397020..651ad467469 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -509,6 +509,9 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 static int reused_bitmaps_nr;
 static int reused_pseudo_merge_bitmaps_nr;
 
+static int fill_bitmap_commit_calls_nr;
+static int fill_bitmap_commit_found_ancestor_nr;
+
 static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bb_commit *ent,
 			      struct commit *commit,
@@ -519,6 +522,9 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 {
 	int found;
 	uint32_t pos;
+
+	fill_bitmap_commit_calls_nr++;
+
 	if (!ent->bitmap)
 		ent->bitmap = bitmap_new();
 
@@ -553,6 +559,28 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			bitmap_free(remapped);
 		}
 
+		/*
+		 * If we encounter an ancestor for which we have already
+		 * computed a bitmap during this build (i.e. a regular
+		 * selected commit processed earlier in topo order), we can
+		 * short-circuit the walk: its stored bitmap already covers
+		 * the commit itself, its tree, and all of its ancestors.
+		 */
+		if (c != commit) {
+			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
+							   c->object.oid);
+			if (hash_pos != kh_end(writer->bitmaps)) {
+				struct bitmapped_commit *stored =
+					kh_value(writer->bitmaps, hash_pos);
+				if (stored && stored->bitmap) {
+					fill_bitmap_commit_found_ancestor_nr++;
+					bitmap_or_ewah(ent->bitmap,
+						       stored->bitmap);
+					continue;
+				}
+			}
+		}
+
 		/*
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
@@ -692,6 +720,12 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "building_bitmaps_pseudo_merge_reused",
 			   reused_pseudo_merge_bitmaps_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "fill_bitmap_commit_calls_nr",
+			   fill_bitmap_commit_calls_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "fill_bitmap_commit_found_ancestor_nr",
+			   fill_bitmap_commit_found_ancestor_nr);
 
 	stop_progress(&writer->progress);
 
-- 
2.54.0.rc1.84.g1cf18622df7

