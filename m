Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F0148FF4
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318163; cv=none; b=IG4F34PELVs1dvAyttNiG/bX5eU7UTZRpAqWDxwEZ98Yfn18QJZQBsYs1O/LOgnor3bYAdIQKLsJ7rMDZR2d+j+k34aLhIP7UtXaH6/yOr4N01d++aThpnDI6UkNknmF7xE9TDiDr6j7cPhfoj0IrUgk+7O711WnIbhjiPX+3uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318163; c=relaxed/simple;
	bh=v3HyzGw4s4uOasLIiFBfYg1S7Bq3Ia6rouObgPHZSEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pntkj1b2pdZDNBaPGCfyjpfIAZbZkCByLtX50npZkbauOCWGf7gs7IPIo1mHggCd9iJpwud5jkp7LlytsLcYOiWkAsZNPw/VC2zj2Hd1x2Uw82esoDXe2FHLTP9jVbObJB5TjTKsUKfJRJsPTTPUfNlyBrF/ynMlvTxScg2raTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vvEvRJjw; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vvEvRJjw"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792b8bf806fso30820585a.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318160; x=1716922960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mag3WXEGw9TgE7Fy+nYodFXV59VLIcDLrJ4LZS5CV0c=;
        b=vvEvRJjwOBRlRTbwqU4pdpJRx5uCnhXY145ZuynUXVldy2SYy6n95dOX8/Jpe3rGNL
         7Ee/Agvwcu2Wz+DSQ+dIDZWt8M3xSgDADsv+voVDMTDlijbGAq0/KPb2Cnvt9HibfK6F
         2aeU7rTfgUd3ZMd61jXeFty9P3+dLuit22avvXMcaU3SV3evXis+fbqK2uwIGhHsvk+N
         EwrB5EGsqj1UxnyTeYFQmApknnYW/PfZ95bjsPUDGV0rS5eJLe8k6PZiLH1mpQdOs0vd
         gDAtMvmgvQSPpzw/E7/uPOIAcBL/ct9L052Y2vINcWxwCXKL+JDrjCjBJsmoRTpFnQ3c
         aolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318160; x=1716922960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mag3WXEGw9TgE7Fy+nYodFXV59VLIcDLrJ4LZS5CV0c=;
        b=wp8SCW7UFn1ioEEQWbzYwbAJ0Y4CREh+Oo64iDLSeTCZrzP7/YwDRqTGfsw1H3Ukxn
         EGtcKJ9JMfaF4UCgXrWYC00hIK9oaUp5DHQvi9UJ8d8VSpqFI7EL7XN5xDPifMKC0XNs
         GXCUfD9SY0mNIAk33kgaaX38QdW5jeBKeijexC6BmYmt+e14Hla+FAegfU2nz9lYPZ/4
         4eyKponxKNIcwPlYUZ9tu88sJI1TqQQ6h5h/DdQTeeYvka08yE8M2yPaf3rwa2KFigbF
         dfyhJ/8AC9cfFMFUTcKfxha8Z0IALNMVAa08t2zo5LEs+BoNJT7b2ycg8i/c1TUSjdtV
         nnVA==
X-Gm-Message-State: AOJu0YyKfYM3ZeNfBnCOgI7ZJiE5GyeaTi/Prd56FX+Qgw02n44VmL97
	hcGPc6N6QzIL0z+h61x6T6MZQ7BdRHwchAyXuUOjqrqM5OZ91iCjXvJGUbSRTIiUcCumnDVNGnD
	r
X-Google-Smtp-Source: AGHT+IF0LLN9sNC+PoeQ7ElRI5A/0+Rl4kde5PcYvGfwFrahbCo/KqvikDL6e6WJf9q5qbuGRvClGQ==
X-Received: by 2002:a05:620a:46a0:b0:792:a8d2:83d0 with SMTP id af79cd13be357-792c75af2a4mr4005484485a.39.1716318160168;
        Tue, 21 May 2024 12:02:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7948e9baa51sm124659285a.5.2024.05.21.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:39 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/30] pack-bitmap: extract `read_bitmap()` function
Message-ID: <55dd7a8023e78d187c3f71164537f49af07110bf.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

The pack-bitmap machinery uses the `read_bitmap_1()` function to read a
bitmap from within the mmap'd region corresponding to the .bitmap file.
As as side-effect of calling this function, `read_bitmap_1()` increments
the `index->map_pos` variable to reflect the number of bytes read.

Extract the core of this routine to a separate function (that operates
over a `const unsigned char *`, a `size_t` and a `size_t *` pointer)
instead of a `struct bitmap_index *` pointer.

This function (called `read_bitmap()`) is part of the pack-bitmap.h API
so that it can be used within the upcoming portion of the implementation
in pseduo-merge.ch.

Rewrite the existing function, `read_bitmap_1()`, in terms of its more
generic counterpart.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 24 +++++++++++++++---------
 pack-bitmap.h |  2 ++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35c5ef9d3cd..3519edb896b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -129,17 +129,13 @@ static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 	return composed;
 }
 
-/*
- * Read a bitmap from the current read position on the mmaped
- * index, and increase the read position accordingly
- */
-static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
+struct ewah_bitmap *read_bitmap(const unsigned char *map,
+				size_t map_size, size_t *map_pos)
 {
 	struct ewah_bitmap *b = ewah_pool_new();
 
-	ssize_t bitmap_size = ewah_read_mmap(b,
-		index->map + index->map_pos,
-		index->map_size - index->map_pos);
+	ssize_t bitmap_size = ewah_read_mmap(b, map + *map_pos,
+					     map_size - *map_pos);
 
 	if (bitmap_size < 0) {
 		error(_("failed to load bitmap index (corrupted?)"));
@@ -147,10 +143,20 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 		return NULL;
 	}
 
-	index->map_pos += bitmap_size;
+	*map_pos += bitmap_size;
+
 	return b;
 }
 
+/*
+ * Read a bitmap from the current read position on the mmaped
+ * index, and increase the read position accordingly
+ */
+static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
+{
+	return read_bitmap(index->map, index->map_size, &index->map_pos);
+}
+
 static uint32_t bitmap_num_objects(struct bitmap_index *index)
 {
 	if (index->midx)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index db9ae554fa8..21aabf805ea 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -160,4 +160,6 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 int verify_bitmap_files(struct repository *r);
 
+struct ewah_bitmap *read_bitmap(const unsigned char *map,
+				size_t map_size, size_t *map_pos);
 #endif
-- 
2.45.1.175.gbea44add9db

