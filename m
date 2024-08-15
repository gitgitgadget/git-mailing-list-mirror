Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E2156F3C
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760969; cv=none; b=UTpu8nYkH2pVJ/7etTjZYKj4MoUzO9/kZSpEtJkCzziMn5SL/yIM93jNDgKyZLEehZa1RoTVFthgtcCC6jQ0F/MCY2ZQQrPSqcJLw+i62QTVp4VSv8aDD/g7laAd11nfY/oTlpEowN84PasMztt7Sf5LLdH/SxCPzhE8mCGSsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760969; c=relaxed/simple;
	bh=L/kx2bVz2U8MLc2sJPAacU3PrkSp0Ga/+8N5iUelGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV0Oxg+meo1UxWwB+VvKldjJLy2BZjzPe6d5km7cN56mP71u8GIGXBqXIi03KCwQmEfkZsRzjm6QjnoI6rvhWM9M+ja1cwSXmXFwtpqcSuJAkN2+KBnHvTb7nl1GBxPw+8sQ1Igba2elokkDuYZxGKq3vMo+muEF/zCAn0kAVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=w73kfPOs; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="w73kfPOs"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e115ea1b919so1341169276.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760967; x=1724365767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BP9XtWEMOUHY4a+xwD5V4Twc3Akc76s2qr/cq3q+gvY=;
        b=w73kfPOsL3jix4V50NsYX345YdTtMm+DaJ8QSA1iDbX1KLTUVq3amj8VMZ1hc/vR/9
         4UEN4sfePtQuzkOztQ/sfO4SGDgucYygRRM7b/S7dcXXqNYnzEP6PwIiG0ub8eaiA4qP
         WpKeSfgWEgl9FfsObo9YwLXs3TMkCLpS6mWLm+YsENwn8EqacLyKxUwkKY1Zc/P0ystr
         7zXStNgxmctbnY7MPONIUmdOo+C53HiON7stsz2hsMLkdiHHdGMa5nF5vgKQzRsyZ2A3
         m/ysBaJJyiOV4o26x96MX+q4B4rB/KvcjxYuDGEmGaHj0eamMTxgb5W2qWgMjObhL+CL
         UMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760967; x=1724365767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP9XtWEMOUHY4a+xwD5V4Twc3Akc76s2qr/cq3q+gvY=;
        b=E2H7RzaonDUOMiy2eLbzLBT7IJAb8A1m6wKFv01dwULb7zhvgnX9s8fVVny8r6rfoU
         75OFm0e24/sPQSZOtjbLqLDCriwyFYIuIeM5n1eQ1+2cn1zSA/fICKuChzftnJZ/lWjR
         dNODxsoAl7JkJlEU85MyvXaks6x7Y/yF0Yr1nWf9Wogpv3fCRuY5yhaE0Rh7VURHTC7G
         JFuxxktDGjNHZa326gVcjvdxyfY5Szeybju+T+I7LHrxsCzexm3aiz3q7z3fx6wzeat5
         1++tBNPxecFl1bKURYBGGbuGZ7ClrYvHZHYMYSgSzRkRjqyIh4g2YjTmkCLzcpqnqb41
         K2bw==
X-Gm-Message-State: AOJu0YzNrMmVb9SaUJJMmnv/epV1Cs/+st0tUmS4DOlyqrhtxH2BnP+F
	a4JFww0BOi8Tjy3LacJAhclLAnZ8JIgq4T7FCZnn4Pff/KniQVfZt4DTifRTmxpSfZgYCRLGjSJ
	a
X-Google-Smtp-Source: AGHT+IGQSU70y4KJBwdpOHJdg9EHZhWff4mzinfsTG8EHyyfNbpNgWz6PGiD/F28f+4IgY/9twLsVg==
X-Received: by 2002:a05:6902:18cd:b0:e11:6c6d:8bff with SMTP id 3f1490d57ef6-e1180f152dfmr1466883276.4.1723760966896;
        Thu, 15 Aug 2024 15:29:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e715edsm485476276.35.2024.08.15.15.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:26 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <c6730b4107e8069b3dd60f50368a3975668c09b0.1723760847.git.me@ttaylorr.com>
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

Now that we have initialized arrays for each bitmap layer's type bitmaps
in the previous commit, adjust existing callers to use them in
preparation for multi-layered bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e1badc7887..9fac43749c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1622,25 +1622,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	}
 }
 
-static void init_type_iterator(struct ewah_iterator *it,
+static void init_type_iterator(struct ewah_or_iterator *it,
 			       struct bitmap_index *bitmap_git,
 			       enum object_type type)
 {
 	switch (type) {
 	case OBJ_COMMIT:
-		ewah_iterator_init(it, bitmap_git->commits);
+		ewah_or_iterator_init(it, bitmap_git->commits_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
+		ewah_or_iterator_init(it, bitmap_git->trees_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
+		ewah_or_iterator_init(it, bitmap_git->blobs_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
+		ewah_or_iterator_init(it, bitmap_git->tags_all,
+				      bitmap_git->base_nr);
 		break;
 
 	default:
@@ -1657,7 +1661,7 @@ static void show_objects_for_type(
 	size_t i = 0;
 	uint32_t offset;
 
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	struct bitmap *objects = bitmap_git->result;
@@ -1665,7 +1669,7 @@ static void show_objects_for_type(
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
 		size_t pos = (i * BITS_IN_EWORD);
 
@@ -1707,6 +1711,8 @@ static void show_objects_for_type(
 			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
+
+	ewah_or_iterator_free(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1758,7 +1764,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
@@ -1775,7 +1781,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
 			mask &= ~tips->words[i];
@@ -1795,6 +1801,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -1852,14 +1859,14 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
 	tips = find_tip_objects(bitmap_git, tip_objects, OBJ_BLOB);
 
 	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		eword_t word = to_filter->words[i] & mask;
 		unsigned offset;
@@ -1887,6 +1894,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -2502,12 +2510,12 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	struct eindex *eindex = &bitmap_git->ext_index;
 
 	uint32_t i = 0, count = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	init_type_iterator(&it, bitmap_git, type);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	while (i < objects->word_alloc && ewah_or_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i++] & filter;
 		count += ewah_bit_popcount64(word);
 	}
@@ -2519,6 +2527,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return count;
 }
 
@@ -3046,13 +3056,13 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 {
 	struct bitmap *result = bitmap_git->result;
 	off_t total = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 	size_t i;
 
 	init_type_iterator(&it, bitmap_git, object_type);
 	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = result->words[i] & filter;
 		size_t base = (i * BITS_IN_EWORD);
 		unsigned offset;
@@ -3093,6 +3103,8 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return total;
 }
 
-- 
2.46.0.86.ge766d390f0.dirty

