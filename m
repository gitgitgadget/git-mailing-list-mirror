Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69132500D0
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753485; cv=none; b=BLpA4Si3UbvdNIzpDhBh8l8rrvskOUIuW9Oz3onah2Pv2bCSjp5GHSQXIppt+OOKhxyMBRSKdHv7NWYf+9w2gYfYUhFhrybOH4NaW2vHhyM9YaMRiH7/9DhwBEh0EjMydNX4+f/1kRV5Z1LXLB11OiiIG6645BeH/fXB1N/XknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753485; c=relaxed/simple;
	bh=aiKjQLjwlCkkqdoZMz0LO6sAQWe312WaScpDPiq48NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la4WIqs0A6QGDKIWKWAr/2BUrcVVp1TRW2C4403fysuNeUTkkWrlbhY5fTSa+6WnjrPyeeyD0Onc35RhcSBRpHiQ8RKuu76TZQx9G7BdUVBvfvLoG5prnF1MfoVckR1VPNww7sq8CmPcH8xzX+6JzcYUGdpgs3FCAn9TfF3j9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqNWdq0C; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqNWdq0C"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a363ccac20so3432612f8f.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753481; x=1748358281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3mGZuOqNHB0vHOpPWzjQuDOCn3aqSFWUy8/hjaTGEw=;
        b=EqNWdq0Ct+Wrjp+l8ANIhmblC2LOcwgPadblzEq+0FG97ccQCv3g4zWQL7GC9xX6hE
         uNgUx7HVd0oerYxCX0XUEIGhEAChsR+Aqjr8/AOl+Zb8QkoQv0P9n04OPOME24QHeU9w
         cxN903+IAnhPX7uL87KnecUFKtFEZAlsSGtnSXROW5GoIxkaLnudNY6dITA3TNkBom/W
         tpT6+zlZTrLa3Govw9uQE9WOJ25HXRQUMCsFIcreZYIpeLocTFIzyGvgjavR4ZVkd7j9
         xB8F3ejxJ0ysYMy1qrjhCnAb8+jFIRptEpv8zK9v4KBf4KsA5Coz8oycFD5j+/rH/Djs
         3VOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753481; x=1748358281;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3mGZuOqNHB0vHOpPWzjQuDOCn3aqSFWUy8/hjaTGEw=;
        b=M5N1+rB3tkejoyX7Ka6+p17on6fQzCvVvkwk3a4h8Urmp0P3480WTK6qoKSjkxaYiy
         HXndy7zvz1CAm7Utmy4gLVKC3+nL4qKnuN9SQuubIk8zWfkADfpo/Olbt6h2hyGatRJW
         2BikR0t0xicak5SJwSZ506HhQbh7SCgUPwMmmY2TzxEh31erj6BkdDkRe1y+i6WjrvZ6
         MsKDOeF9CpZ/z51G0CIxko5jcIUp2+h2pVkIEkG7WlXTc0pRjk3+tPfRz6FZIP4lXA4u
         ZKOfbjiQT1Bq7NeyBuiVQiG7rXsKq0ebjQDAKJjFcpBVUJm0wkNcguoepyAK02S7vv2Z
         +7UQ==
X-Gm-Message-State: AOJu0YyphG7to/AEimRdaXN6xq3PBGo7SIhinMX50bCk2pBJibQD5RfE
	5kyGut+vXlFGHNznxGING1m0GGBLAUHX2s8vrW84Uw2nucu0IseooLejtRQPlQ==
X-Gm-Gg: ASbGncv15okFk8PkCSV1MCyukFOlVmIe9vCx+ZsNcdA828KHwgAAcyK3hN/bq+jJLVG
	g6USLHfzv5VjvSfGenuQCZraCYRbA9y5xL6hPSXW6TW6oSbV4cyB9lMAlm9UPP01Jw9eGC3hfQA
	Xry9UGfQfJWbDcHEBGR/9Zuby4v8f0y+KtolC8ANyBKpwdhcbAKsVbn6z49E1ks5eXTSoW6XlHG
	zeZxGyprvt89CIdazwb2LhofQr3Y45Zsj9oVl5z0TOOyUztWNi2Z5zDwc3S5roI6J4m3kBAGEw9
	l+pcwdN+8Y7LWAixr20+rZaHDkw/o2wDkHcoGbmsa8ObUOgIPF7RGhTppO+D65RBoXY=
X-Google-Smtp-Source: AGHT+IFdSeMpgpSrLx8R2RoPADmayDnkaiDttjwZdcJ83v2SGM+bA6CPCLQs9vclXSiOCnyi1O1PqA==
X-Received: by 2002:a05:6000:2486:b0:3a3:6f54:fb0f with SMTP id ffacd0b85a97d-3a36f54fce7mr6456984f8f.42.1747753480735;
        Tue, 20 May 2025 08:04:40 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm17014029f8f.11.2025.05.20.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:40 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
Date: Tue, 20 May 2025 16:04:24 +0100
Message-ID: <cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

On a 32 bit system "git multi-pack-index --repack --batch-size=120M"
failed with

    fatal: size_t overflow: 6038786 * 1289

The calculation to estimated size of the objects in the pack referenced
by the multi-pack-index uses st_mult() to multiply the pack size by the
number of referenced objects before dividing by the total number of
objects in the pack. As size_t is 32 bits on 32 bit systems this
calculation easily overflows. Fix this by using 64bit arithmetic instead.

Also fix a potential overflow when caluculating the total size of the
objects referenced by the multipack index with a batch size larger
than SIZE_MAX / 2. In that case

    total_size += estimated_size

can overflow as both total_size and estimated_size can be greater that
SIZE_MAX / 2. This is addressed by using saturating arithmetic for the
addition.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-compat-util.h | 16 ++++++++++++++++
 midx-write.c      | 12 ++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 36b9577c8d4..4678e21c4cb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -668,6 +668,22 @@ static inline int cast_size_t_to_int(size_t a)
 	return (int)a;
 }
 
+static inline uint64_t u64_mult(uint64_t a, uint64_t b)
+{
+	if (unsigned_mult_overflows(a, b))
+		die("uint64_t overflow: %"PRIuMAX" * %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a * b;
+}
+
+static inline uint64_t u64_add(uint64_t a, uint64_t b)
+{
+	if (unsigned_add_overflows(a, b))
+		die("uint64_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a + b;
+}
+
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
diff --git a/midx-write.c b/midx-write.c
index dd3b3070e55..c7cb2315431 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1699,19 +1699,23 @@ static void fill_included_packs_batch(struct repository *r,
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
 		int pack_int_id = pack_info[i].pack_int_id;
 		struct packed_git *p = m->packs[pack_int_id];
-		size_t expected_size;
+		uint64_t expected_size;
 
 		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;
 
-		expected_size = st_mult(p->pack_size,
-					pack_info[i].referenced_objects);
+		expected_size = uint64_mult(p->pack_size,
+					    pack_info[i].referenced_objects);
 		expected_size /= p->num_objects;
 
 		if (expected_size >= batch_size)
 			continue;
 
-		total_size += expected_size;
+		if (unsigned_add_overflows (total_size, (size_t)expected_size))
+			total_size = SIZE_MAX;
+		else
+			total_size += expected_size;
+
 		include_pack[pack_int_id] = 1;
 	}
 
-- 
2.49.0.897.gfad3eb7d210

