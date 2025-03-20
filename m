Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E482226520
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493430; cv=none; b=kyGjVWEBA3DnL6sk5gnFK4vFngqOOmXaXIa0wHyCj4mEFnYy9LPDaVWQjfi3l9rFVx8xr2axcv8Exa47kncWnnIimLJ3LUdedMTjpt4jSp1ns4f8/5nTCoGg984vzz+9xZ3t+cz8KwULb0SGVsZTL3MuojSNxv9wuboFctwnDJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493430; c=relaxed/simple;
	bh=/eYVYhOP5/zVzPfFH3gx2cn4AGkw7a1jcIUMvZVu6TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNwohfLKE7Qmo7amH5Frrw/PHXVvI3NG31Nc2BDASVgVYaaLvVdWkckg1GTxX1e7+mjhV7HGyzioKNeomM7Frf7T9nt/Jw21G5ih9jaOTtv0duOS/H2T5t8CCbgByur1BYwPwqtlWaeCDD1sl7YMIIpe/Eg1PqRfkTm/+lZ9glw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=P415jyBJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="P415jyBJ"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4769b16d4fbso5905171cf.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493427; x=1743098227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHMLeW8dR6WFJWNufB4KeIXEno4jvN0jJc04K5IivGI=;
        b=P415jyBJOErdmSjA1xGA96a9spENH4bFMqlrgNBitGQMHWEyPtlboN9t32ZUZCEgZ4
         gD2E9Pvl/VXWUKyHZ5VDAN/ZXWEKOqzYNK1jhWegZzHth5yypGTTJZZhcmGucbpso2dP
         i2ZFsznpvfv2oy8vA7QGyQbgeWKc2dQiMXN2fUz2uy7AZV83/jb9h6FTWQkZ1iqNiSED
         myrvKXe4u0cqqeBg67v8iC36KSWhaYBxJH8gM5JIBs1wiuoic8z1kjpsWun7HQFcNaGy
         Ln3/VIMWalNXQj0TDHHcCoQ4svVSFGQk/EHaScnsygKp114UMqYTrH4j4teIBixXo8K2
         xk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493427; x=1743098227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHMLeW8dR6WFJWNufB4KeIXEno4jvN0jJc04K5IivGI=;
        b=WyhrUE+H55siT9hco3XdOr3I3woB4HsLm/Uc0/B7Sac061SBTRQVc8wtVeg2ikkHV5
         Ci9R9g5bvOyH1w87kUPqipYRTHYvZbb9c4qz2SDAPynivKFzNvU73bNdR6fAQGJ2RAbW
         /YgiqWOm3/3Dyd/4dwaifC2QtinIKcxjjBYzaBrX2g5aqqnII5UTGrWhg7WgF8hNjt5G
         vwoJXz+Z9xVa8WFzpYFpJvyj0YMUkX9WhiYh8iVB1Jzm5dqo4SLAlMEq7/HrgbEYGkTv
         DEo2JrMbwtSG/LVTKjdcPc9YfimE8gPejIguFnOaeoN/NwFaqgEmkwmphkSbNkl9L2zb
         dVpw==
X-Gm-Message-State: AOJu0Yx/oZinZRcype0nP2hzQ9Zx86CLa5RWth4TxCx3KkexwhJQVZKI
	+cypEts3Y0jGQc2p8CzzXhLdyVSyHCWxu7si9JmLbZWdFtN4o712MuxKPO3Nqd/eiYgELul1dMk
	CLEs=
X-Gm-Gg: ASbGncvxDUl/nWNAbRkUil81AXrqAShrzbhopc7axvaoW0Qo1yuQ3EcuYnxUQIEIXlt
	tcG6MuaPZOguv+31aRKWMDs2pITeWa8AGGIdc/Tik+7qs51iLKj86JY6WfMz9XdGjACxO64ZksH
	xxsJPGJlsfl5Ef2z0hLEqV8O2kEwjGpfB3k0KGrTj2C+c/4FqldRP5KEUEwn2z4uPFukcBz+gab
	XGSy+leL5InOzKmk1Oh861/W6esx/3guG2XjZnh96wZJYpLiuGs6KfIbaD9i0Q4XFsbehlbzLQw
	V0EpTMVhm/a+bykWw/5zZPxZLxhtRxogTqNUgo3A+aM77HWaPk2lbAUV4rE6oHj9JY+x8G/0d7D
	Y2Js00j3spOzQbRb+
X-Google-Smtp-Source: AGHT+IEb1VBw0y+XOrLOfbCCYW405H6znJkxWQZSBERbTE5I8zS4tULVeP3+LHTC88YVshuEE4Bh6Q==
X-Received: by 2002:a05:622a:5912:b0:476:889b:ac08 with SMTP id d75a77b69052e-4771dd6234amr4290511cf.3.1742493427331;
        Thu, 20 Mar 2025 10:57:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4771d0ad87esm1647871cf.0.2025.03.20.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:57:07 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:57:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 13/14] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <dcb45e349e16c12ab4a1be39fcdf8ba214b713fa.1742493373.git.me@ttaylorr.com>
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

Now that we have initialized arrays for each bitmap layer's type bitmaps
in the previous commit, adjust existing callers to use them in
preparation for multi-layered bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5721fa7a0f..6f7fd94c36 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1629,25 +1629,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
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
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
+		ewah_or_iterator_init(it, bitmap_git->trees_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
+		ewah_or_iterator_init(it, bitmap_git->blobs_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
+		ewah_or_iterator_init(it, bitmap_git->tags_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	default:
@@ -1664,7 +1668,7 @@ static void show_objects_for_type(
 	size_t i = 0;
 	uint32_t offset;
 
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	struct bitmap *objects = bitmap_git->result;
@@ -1672,7 +1676,7 @@ static void show_objects_for_type(
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
 		size_t pos = (i * BITS_IN_EWORD);
 
@@ -1714,6 +1718,8 @@ static void show_objects_for_type(
 			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
+
+	ewah_or_iterator_release(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1765,7 +1771,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
@@ -1782,7 +1788,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
 			mask &= ~tips->words[i];
@@ -1802,6 +1808,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_release(&it);
 	bitmap_free(tips);
 }
 
@@ -1862,14 +1869,14 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
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
@@ -1897,6 +1904,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_release(&it);
 	bitmap_free(tips);
 }
 
@@ -2528,12 +2536,12 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
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
@@ -2545,6 +2553,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
+	ewah_or_iterator_release(&it);
+
 	return count;
 }
 
@@ -3077,13 +3087,13 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
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
@@ -3124,6 +3134,8 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
+	ewah_or_iterator_release(&it);
+
 	return total;
 }
 
-- 
2.49.0.14.g88b49c1b34

