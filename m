Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFF86249
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972342; cv=none; b=hmbVS2BpCydUp7mdDTsvr5KcOc00Ep14ezGmDsjAbgY11QEbl4AZuRo68vxHtzR/72OmEtTdeqfxKnSRx/dmkD3k/fBVHoOznIDVye9/Q8jp23oA50cSdywlvEyr8kW431jvfNDhgBcfc4U2eYDxYoVWUS9D5Po+Rf0W69pRqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972342; c=relaxed/simple;
	bh=KnyHOkkiJt1d3dEbTi+1Sj9Vzy3UVaAP8gKEs25Ngbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzE2shXvWH7fIKgzRQYBS+AxjW15ucqjHcyL0Z+oFWioAjZKYMuPqDEmdjUejfiDAV/r2u5dwGzcM6WsmfG9RlFNfT0JNOsUZMMk09Ai+5busSTf3YL+W4J5U0WAxeZmc2f1eb82nH6oq4WI4T/p3UWob47aUJvqxe3hHWGnZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mH9DbfRa; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mH9DbfRa"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789dbd9a6f1so26228985a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972339; x=1711577139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WegdbeZ7HXG0eTn2YXN/LVlTtrUOWKYviHbav9sBHsM=;
        b=mH9DbfRams2pjnxIlop0lnFUzQv+9DwWI6czU8VWcAnh747VegAI/ILrOVtq+hUOMC
         gNQrdhb6fI4YpqrgURDQGKyuEcTNqYO9ZsdvtV26zTqjxjLaqGpYWzntVCY62MN0u8o6
         UWPvsreq3r0rkOw1qQ79fRfAHjLWra1aUfmuT4LeD+Tn1FEKrK8hcGw6UfziV+JJdcCv
         yOWoS1PP8CUsiNgbpkJc/d5uFJ/JNHpy81F/pzqpryp8czp4VcjVdC0eGOkWYp7FSu6e
         Vj7Grlsue8Pst+4zaSpabaD92N+gGizRTN/ZY8lokRqYqA+H3JiCis5qqQrKNMoAqvgn
         wQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972339; x=1711577139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WegdbeZ7HXG0eTn2YXN/LVlTtrUOWKYviHbav9sBHsM=;
        b=Ywr8yqY/t2pHJNrhewRHc6HkRzx+ECRU74kb6E/IXmFRzck8Yd8e/axki1iXC1EyeO
         kCmvvdBmqB5PRkoGhCrD7En9VXEfDqcNIbiAKcILTizYTbppATet9sYva+LQxasct+lX
         W00Sbx67KDd3zIg0q9pvD50oyxO4Zeh2TO53l2XJXxgwF3Z2RMgNn0npGdjImktZF7GW
         JXdZmgDKejaeHAv2NCJfuM3UNnMsjPv2VhMUuRMoEKkiLn/xKTxFLGmYvn9JOE5rw6+k
         rozZmTdXJqGK0tljwnQBDrdL87Aohqqycyq97VpeS0j1ftL6vJLmK6IgIvdx6fh6d/5K
         CnXw==
X-Gm-Message-State: AOJu0YxzCbXlCxoU4qwJVE6q3mp7ho3EwtZ82aMgtOMLJIfvHCiUJ+5I
	ey60K8rs8AHXQNXQ1Vx+SjGAy9PYlJMJoRwilZuiQARliVUjHNjvprGvk9o0CzkxLJdJ/C4Pr2f
	mvGc=
X-Google-Smtp-Source: AGHT+IH7lN94Yx1uBMQoxf3ZfmRz7dkJfzc8zlG9OGUZ/nEIFh7uHcb6aAO5fEhdSEm81zu1bBv9Ew==
X-Received: by 2002:a05:6214:20e9:b0:691:826f:5060 with SMTP id 9-20020a05621420e900b00691826f5060mr154702qvk.10.1710972339341;
        Wed, 20 Mar 2024 15:05:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r3-20020a0562140c8300b0069612ee6742sm4664732qvr.14.2024.03.20.15.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:39 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/24] pack-bitmap: extract `read_bitmap()` function
Message-ID: <7a31a932ab327681e7d91454e5dee3f903f279d9.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

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
index 2baeabacee1..b3b6f9aad21 100644
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
index 55527f61cd9..a5fe4f305ef 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -133,4 +133,6 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 int verify_bitmap_files(struct repository *r);
 
+struct ewah_bitmap *read_bitmap(const unsigned char *map,
+				size_t map_size, size_t *map_pos);
 #endif
-- 
2.44.0.303.g1dc5e5b124c

