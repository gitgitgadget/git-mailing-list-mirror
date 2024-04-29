Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EC177998
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423433; cv=none; b=TQ+Ewkm+WL6IGgD5chfQlUL9mIFk+NXrvkAWb7hT5MZMMwutXAbOHp0qUdPJRw+F2F7YTDPXo/BazNivNievOZkW0qr4x+lPRjsXJq7aOjc5QqLzOjSg1/C5aMXPYJcWDwRNVXm3MyZBS2cZrT/AKRhZ0fVIFTirclHofezzYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423433; c=relaxed/simple;
	bh=tAWUidDbsNG+hhVhOgjlRV2TO5ANqfyKEyIG7nJYVus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6CQp7a0dbelX/pFklAi18b9sUSGIkAG+0J8I8xC8hYKCXqXZJysxJr7ADqppwvdU5RLJXpqc9igvfFFcwOOGyOOVI6WZK4+8L2f1XuBA884rPmFZnv4VWbKnznhUfqlf7FxG6nqqoTuWC3vks2hGSZ4UwNZhxS9aRbJkYWchtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tu1lskW7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tu1lskW7"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61be4b98766so6958337b3.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423431; x=1715028231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W+VNq/Hg0fenhqmh65c6yemc1Q8sJen2LGJXWgGbso=;
        b=tu1lskW7Y/D7O6rF+Q0dvhVyqXdsnUVLE3jvmR6w7p5mOLwQPKuWYbVmIlxmIN8ZjD
         GCWDvxpwRHTEIv99woKMG+JJAjheCVfUV3VHlXXZ+eDMGPej0iYDbVcxR8NwosKrk9bs
         y1PPD2tisBviVs5qCmZoyVjarEVGja58ZNLvX2Lh6ZxdBtvpk5YVHO47iCGnDn09b6hj
         v3iIaRNVrZdaFP/dnKJKfEuh1pc7GxHZNLh6BvfM4bVq8itwwCrDLGfO4eDDS/WJeRXE
         11hjftq7zK7/8dhpGgLFBFYzUlB1pagLj3hfNwOTmMbwaukGsUAOrglIP8Kdy6OcpQ6o
         GZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423431; x=1715028231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W+VNq/Hg0fenhqmh65c6yemc1Q8sJen2LGJXWgGbso=;
        b=nmLCLywwe5s7e5PS1Pmyue2MJooB6nDgVWUoStUxVHksTkDvBPwNiJ7vXm3Rkj6KJJ
         F412iKy2BwNvSKfjnBYQnauAijz4e4BWjDCviAtjpmT7bNXrl/2h2LHu8/8mm92eLnTL
         K+8xB5RBvnAGCTv9tE3wWB0+R/VSERabGmxA4e4wifj/BmUV514AGy0fdeCS69hTj943
         p8fY2idoHx+SVDnuj4OQiydDspVtWzuRR5CtWdnFFHXyEcCUZm5tby6YxMyZWKNWaBse
         S6mDsZMPPB3dujclnCC95B/viCwzrbRklCwIfFyQt4bMs2ANZi1j7BtCmxjUnsjwHL5U
         YmYw==
X-Gm-Message-State: AOJu0YymZ//6C7JzqAeLDHeujIcMaxJosVsYVYnN4y4PSLrYEeNweW2O
	VjW9wbWjCu7GM/DgMWh7mYHPhmId7O+4HPuZbYYdwNz4bylswDmE89TYCdgzY7RSz3sKhzVTaR2
	63PI=
X-Google-Smtp-Source: AGHT+IGu3bCSwSN9SQKA8XOdB8J6+L1/e2P6MONNIGVqugF328AULuv68oKH6Npp/MsQB7EWsOpQig==
X-Received: by 2002:a05:690c:6d0f:b0:618:95a3:70b9 with SMTP id iv15-20020a05690c6d0f00b0061895a370b9mr11520099ywb.36.1714423430777;
        Mon, 29 Apr 2024 13:43:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bb40-20020a05622a1b2800b0043ad7ddda16sm1538618qtb.97.2024.04.29.13.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:50 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/23] pack-bitmap: extract `read_bitmap()` function
Message-ID: <60f6b310213b86de25ecf23002cee7a3c8460415.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

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
index 55527f61cd9..a5fe4f305ef 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -133,4 +133,6 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
 int verify_bitmap_files(struct repository *r);
 
+struct ewah_bitmap *read_bitmap(const unsigned char *map,
+				size_t map_size, size_t *map_pos);
 #endif
-- 
2.45.0.23.gc6f94b99219

