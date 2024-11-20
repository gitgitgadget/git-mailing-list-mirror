Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778121BC9E5
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 19:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130032; cv=none; b=Q0yEune0uqmPCmXVglUqFOwxmhgDEwC/in4QUfpvHGNtim6haU6hdgkGf/nUYYYrIHWcneKXr0+dtNZKxuno4JyI3g2AqAspPUoLEQ21hwbisqSFv4fmqlFy5ekodS3o5KRdwHSv3z7OsMlr76Xc/GfcpRwLUj5edMKaHetxIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130032; c=relaxed/simple;
	bh=tPCGQE4k2UPI86oP3GzEMCE04ykUmCaCcAoft7Iw8d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFt+n6DiZjL1p7q9MdOsazlkz4UVqrLepEdHwrtfAJ+DgKyzqGaOtf3qsrDWtpxLEygw0j2gcmkTso9lYkjLEITHP9x65VcQ+ZXz6lykEyLNgXL7DZOllYa9gr3a9pyKEKXX1PG28SVHAf7DwCpSvO2aRHJZedJ/E/E6f8qaHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SebVMORn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SebVMORn"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso62990276.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732130029; x=1732734829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9C27EFNZlisMrjROfjLk6TYwY56H7cLzp5qM/gRcWao=;
        b=SebVMORnoQ4tsXJnXyfqew+sbvYyMlPzyTM6cKj8WvfLYr7L/ftBQXlX/jR9VDvcHm
         H/Uv7wYSJeannHbO2j5qVhXiqm+M2B9C3t8qrSldwgvRDEetjN0k525skk0LfRBYEcDK
         zb/w0o91AXO2ryCdiK5NEiNRWEXceQ5csSra6tLmp0E1OrxhcMUKwPTy6anOOqetRsdu
         WDBhPTQrqK9JWme1fBGKOi5KaqUyjE/oCkg52DBRKvrD5KyWDB0kPfzvQxqapavI55F0
         EWhYhfpyDlFn42g0qTMcYdknKnq4rsNMhLhYK2DV8lO3KY/dt1jW6gEB7NJWVO6zpbsJ
         6VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130029; x=1732734829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C27EFNZlisMrjROfjLk6TYwY56H7cLzp5qM/gRcWao=;
        b=RtZ4VyhsiiezkQ1xe0JwUCe7fRjfCzJS81cjMwleFh/tkp/HslJktt+A919xaR4zAr
         Bqml5wSdQ+qpB3p8G8+YECMuU1EGYi0GsgbxTUXM1feAQoE6b3c6nbu2Hg1OsYWGC6QE
         +mlfsRjPP4TU0KwTaPlYRvOsNJVONBHHUn/jbZc9+ntT3nD2dn4SjMGN6iLfztAge4Gu
         NJchtTxHg3CgEkIkasxiAH/w7FdjomFrCYXlhXKOH1uWbARQutqPqruW62MRj1SG31ZZ
         UbWd5OMM1ko6tyNA1cKuIWOrc8XFutTb0T+WDBgMlYqd3AERTD0IfJQC6wLPe/kJ7XoG
         dltQ==
X-Gm-Message-State: AOJu0YzNgDe516p7YVSyt4kF5upq6NsnKX243GonzlaN39wn3rfeuZ/Z
	J3GgH1+HWg1DBcwypOb+xRCjNRr+TxTn7uuR8bSZQz7YiuObW7L7FJxmWbwbzGtDlzyP5U8ak7F
	p
X-Google-Smtp-Source: AGHT+IE/WoAbE2hEVKxLQ74oHANCe0RvgSsTUeJbkxkr2VKveSRqZgCPlDdNQKlLlue1TV6vtSQxdg==
X-Received: by 2002:a05:6902:1b10:b0:e2b:b45a:149 with SMTP id 3f1490d57ef6-e38cb5ec160mr4257079276.39.1732130029208;
        Wed, 20 Nov 2024 11:13:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e71fd7fsm3215980276.9.2024.11.20.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:13:48 -0800 (PST)
Date: Wed, 20 Nov 2024 14:13:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/6] csum-file.c: extract algop from hashfile_checksum_valid()
Message-ID: <e5076f003bf5a53fc63bb673213988328c50c98e.1732130001.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732130001.git.me@ttaylorr.com>

Perform a similar transformation as in the previous commit, but focused
instead on hashfile_checksum_valid(). This function does not work with a
hashfile structure itself, and instead validates the raw contents of a
file written using the hashfile API.

We'll want to be prepared for a similar change to this function in the
future, so prepare ourselves for that by extracting 'the_hash_algo' into
its own field for use within this function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 62f4965f094..107bc4c96f9 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -242,14 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	size_t data_len = total_len - the_hash_algo->rawsz;
+	const struct git_hash_algo *algop = the_hash_algo;
+	size_t data_len = total_len - algop->rawsz;
 
-	if (total_len < the_hash_algo->rawsz)
+	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->unsafe_init_fn(&ctx);
-	the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
-	the_hash_algo->unsafe_final_fn(got, &ctx);
+	algop->unsafe_init_fn(&ctx);
+	algop->unsafe_update_fn(&ctx, data, data_len);
+	algop->unsafe_final_fn(got, &ctx);
 
-	return hasheq(got, data + data_len, the_repository->hash_algo);
+	return hasheq(got, data + data_len, algop);
 }
-- 
2.47.0.237.gc601277f4c4

