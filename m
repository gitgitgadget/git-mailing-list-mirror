Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8F299942
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929349; cv=none; b=du5m6SYFylc3AEHaoxssN3HVjTcvb8mSVYC18bX/MWfXy7+LuU7b/7xUFgXJ2ubalLeQqjDhJVTFVgZxx9nXHfqsGygOVVBrJusUJN0NSrZMJyyX0eOggnMnvXg7B64G6GoiIXuQoOrPM8Tx3gX4sjkHD95UTH26Tt5DDLoZkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929349; c=relaxed/simple;
	bh=LGGOAqxRZvzDUPmBzHnyrmk9CL46fs7FLD8zIMbrQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+b9Kcm6cRPjVq6fePPQoudF5ezCC1d+3wzjidWcm9X8k763zRzrBIsjPxvwbKKYQy8EsCL+LgJArFBRjUksaFe3JP0CsZw7C6J0Ic1icxNQ5KGPOFLqaqDlNSN3je/NJKbFcKrMTIvcdO+O0DaND0DrSS6WirO2QrmMVx5FVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqp5U2Ad; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqp5U2Ad"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a374f727dbso3431104f8f.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929344; x=1748534144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4xj6394REKKw5Dcu3axQ80o0945ZMGIdlkSGrDoZc0=;
        b=nqp5U2Ad+uQX9iSGxxxKWoyiYuAqNJzCOBr5ID4Jhu5M9q1KjdlO5zm4Y36GywS+Pi
         h6qzEp90eJilnYn4I4BTS9cYOj+2p6/gqKBJGoN8jVZbTWhyCJxozhMChi1ubT/Vumu/
         T1YACxDeLm2ocbPQRXG5Nj8z2exFv+5V2jJwL6Ufmt8XBL5AFeaphHsXJNRF7D3eK+d2
         0CPZZE0gu3svHombK2oQlQmyREgQJzVXFZRMNyTwTD+pD0mpsi5XnuTCVnTLqlmuDEMY
         gWX8ahnctNbezKUaGj64Br9wMYUZGYLHXRzUl07gSxQP0yEzONUJou55WupiGc6YrF2e
         6haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929344; x=1748534144;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4xj6394REKKw5Dcu3axQ80o0945ZMGIdlkSGrDoZc0=;
        b=ElWQYoY3rrSpo3L1iYuBCXBGoR/ACXTRppVPujr9vNOPHEIemDZrE6O2UoLZnCcQaS
         jNDmQ6nWFhM5eyTH1tWVz44OCIUFZ8ddd5K1gEQDAlr4+3ignlpYr9fsnuNqS3odAbyZ
         1JeqzG/3Nboh5m5QQPqxpKnuR7et2ZmpGQKRK7I44o9WXf7EtHCdiWgFD6D0mbbb3D/j
         8tMFEN3wNtHXsdRGGAUCVAZWWd6wmXTSls8PQsN70Pi4nXrAUrspCZXFoUs23nlIx/WH
         elePsuqXzvr7ZbAgEhYRhFzVVSei5fY1t3Q8ZeJVqSxbgJVitZFpLkTZ8rhyOFgZq/Mb
         Haew==
X-Gm-Message-State: AOJu0Yzq+kVC8x4eH609c3VDd00JurOJhXZ8ifEseVCoha+wiV2yxNwO
	6+onICQ89OuJ/hrSW/55esfI9lCnFjSW1YA6dIpbBrcVYbD8Z1pU0wPZXp2Org==
X-Gm-Gg: ASbGncu5wxRCZacTabcOiB0nsWA0DHwP8izzOsv47LH84EoupzKFKa+UeQYVJtMX4CI
	eMXfYmN5wTxBpJkfzJgu8HPRsI4TZ6BhP0RzXqczKbu0Ul9GiU+GBFnSno44ArfSnLenu0+N3JW
	F1EQCjY+uy4vjLiT485XUDIKzLuexNK05bih0VCdlMp3IS8z7Nxu9fh6CtMorOGRiXtZM4d8WQy
	hrDvyoDl5gDTT7r4pRO3wpiRxHegdHiMkgLluOi3dPlalPkFIwdkV/nIH8D9gkHkE/ofa80KMsQ
	toTVvHL4cOXmDGY1JaSKfMxofwEjQkDzNERm56kpcIS6ZlP2ZrytMCrmfEhYOZkZwwUWQjTwLn/
	t7A==
X-Google-Smtp-Source: AGHT+IEf8A+88qA2YF57VzuAjU9ERPdyHpo/389FfssJsZkN9BSIoITTVfQOuhJxgnWWI50uYJLm4w==
X-Received: by 2002:a05:6000:4304:b0:3a3:6b16:85de with SMTP id ffacd0b85a97d-3a36b1687c7mr15486423f8f.29.1747929344399;
        Thu, 22 May 2025 08:55:44 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm19253599f8f.57.2025.05.22.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:55:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/4] midx repack: avoid integer overflow on 32 bit systems
Date: Thu, 22 May 2025 16:55:20 +0100
Message-ID: <9a1e6c8168876d93c0184523cb467d22e391bf07.1747929225.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747929225.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <cover.1747929225.git.phillip.wood@dunelm.org.uk>
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
addition. Although estimated_size is of type uint64_t by the time we
reach this sum it is bounded by the batch size which is of type size_t
and so casting estimated_size to size_t does not truncate the value.

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
index dd3b3070e55..105014a2792 100644
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
+		if (unsigned_add_overflows(total_size, (size_t)expected_size))
+			total_size = SIZE_MAX;
+		else
+			total_size += expected_size;
+
 		include_pack[pack_int_id] = 1;
 	}
 
-- 
2.49.0.897.gfad3eb7d210

