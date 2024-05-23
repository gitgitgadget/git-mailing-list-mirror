Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77688128392
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499613; cv=none; b=fGUdoxFFF0gqRtUR2qTof4GrMb1Oi4jRM3U1/XiLQAwmO2lb6NRpkEqmw3vdGo4MzrKQf1QEwqiCX5Joy75BJHHiKAERKWsie+XJUFdWgRFmZIiU2dW0DVVAEnBXpl38f3BlSGtn+vAll1wyq8lNAX3r0DFWbUk7eHAefR4vnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499613; c=relaxed/simple;
	bh=TBlk/BomLXnbn5zDMonuSH56JPGOqQwnOYIjY1gGtjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjkuwOFHip90JtoPIzUkL7E9IAaRYp0cwiemjHG3VgKMm0uAsAJles6SBrPyI+gFmzc4GZETcllOu1wuF8Vho6imytZTIrthYTTpz42Wb+tDWaO2T+e9CKz3ynz1CTv2nFCgcF9v/DsBJ3a0FjDcF+O87xF4sAvX67YsKMTB7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pZodjeqZ; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pZodjeqZ"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b31f2c6e52so2869824eaf.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499611; x=1717104411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFI1cnPyZs4YhZi/Wyd3za+PF0NEm+j9eUfq7jVj/Z8=;
        b=pZodjeqZ/4JKJPDwp4YwVy5HHKs/rZ9HXl7c3U/tSWE09qMyA9EeHrSRnms7rLmC+J
         YQrWYal4Gr1wumkwd1LYcmc0O8muhtG779SDk7jwa5nzXVAG4e0yCi+1iZePTdz9/pFu
         +w4RMWvzqeoRq4vT9IzyhNorEmH8fnZleaxfnfhRJxjmtm7F/msqj6vu9R+QSL1iPwaz
         1O0S/dzLUxt35vpn7+WJLzKc+NIlIu3+Spk5I7XdKi7wWnyfpHzx1GtuCRhb4+VSjgiD
         HigwlCQ8vC4Uydw1Ffr71SjtxRgUnwWu3mu0W29Bv0YeGsEtal7cKIRiHYv4hWq735Ma
         RR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499611; x=1717104411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFI1cnPyZs4YhZi/Wyd3za+PF0NEm+j9eUfq7jVj/Z8=;
        b=WYEVWEKFXscSRYnMei0jwZuoLyeo+Skq1eVg/lqarKWSvjc58h2lEIpFAVDmBfRd9X
         0o+P8BQHuYNFueh/3qsNB1JgMi7+gQgBIrkD1iD23wIFBU6/HLhddfXM75JrZt7ZDlhl
         yHkpNDXXLM56yH/KqWfXluVXCHv7SYVoU5qZxo8yaDD+POjYTfSk9xovfJJIfqLlEpuI
         tTZh17SGjHt3Uv8qr+uQcQ5e0Hpm0ERdcaF/G9sccm3vIdoY57PyRjWFpP/Up14oRL1s
         kvTiI33xYWA4nUq+6d5OZqD66H6W4SPPxgmCc/ubBnL4cNYTpmXynXdZTtCOg7judMXB
         P5cg==
X-Gm-Message-State: AOJu0YxZ9M0RLkxApB0VDe7Ikrc6dgbIFKdsbZNzifVdi4HCrlDZZh9/
	gAoTpyYU2P+E7JWsKg2a10ylvJXZ7GBNtxXTnExlAbdvTjn7Kx/YvXAWe5Nbqqc+Wlvgny3UMez
	u
X-Google-Smtp-Source: AGHT+IHFdFJJEJBwbC1rFDEh1QWu3QR0Cj1UT/2s+C3JdfEPPFXkk0bEi4tO7BnOOP3t6q/mSw4UoQ==
X-Received: by 2002:a05:6359:28f:b0:17f:6b3f:1b0a with SMTP id e5c5f4694b2df-197e5216b48mr63682555d.15.1716499611045;
        Thu, 23 May 2024 14:26:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dc62dsm630836d6.38.2024.05.23.14.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:50 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/24] pack-bitmap: extract `read_bitmap()` function
Message-ID: <c653a10f8e40ff33c8110c07572c3468791581d9.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

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
2.45.1.175.gcf0316ad0e9

