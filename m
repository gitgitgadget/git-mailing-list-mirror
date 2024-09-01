Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC33FC7
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206605; cv=none; b=i0eFLA3/DT5lwH9rgjWoL368g/SRZBP2pIp26eClolhXRikm0zpw5bMphjMaMjMpyWMwp6gqPkLCOU9SbL9HZN/9YFpgzTipXLZx9qqt3+7lhY1kk05DP4MtGuXldimrvOsTDlfDOtIxJSSeTL22NwTWE8WJ+vhdrJuREn7NdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206605; c=relaxed/simple;
	bh=JWL1QB+C9Bz8PGAWNSpqnc78THbHgpk6npVdnjiapYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUpVd9YoOlqZW8G4/BtPz2JLJv/ghmIRgFit6PkUa+NdMLOi5OAXQEYeUA7J8fDMwVrVmkrYPvhbR84720mq7hvcAKZEKvGx/unnWHFz8Vj0xJznlriKsFVC/BmUJ2KdLnc35GvX8PlnN7KM5sl0yoW50Ea8SB5MrFqFgmP6Huw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TPiQSTjm; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TPiQSTjm"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2703967b10cso1604677fac.0
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725206603; x=1725811403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZJUDImOQAnmS9B4qfB6vHVZUFMx5xAPAatcEzZLZcA=;
        b=TPiQSTjm6yJdklc2M56lR75N1Esnmh9RhlfbVDuMdJIt5DovRW0QI6crC+jjwZxF23
         g9xONsA37YqKJeiej7MUi26FqNnNDjVId/1XrqU7kCJrMS0gCuB/CmjoYZiKt18xvIcr
         GzXjO/kkHRzDH1815BJQHw+I8Q5NbjEm66zOIpN22f/acAvs6+WAk/7oPH1ITgzhQTaj
         li3S990Cq9uT/agurBmuIQMEUkHsJ90LXyidxk2/gmWJcgEdAEqpWrMS4P8Bn5m38B+9
         pocQ8MHnBy9L/MI2knRfKoYan+nwSa2kZ3ZF8MJT/XVJOjGI3OcXU3UIw4AbBQHOXvw6
         Y9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206603; x=1725811403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZJUDImOQAnmS9B4qfB6vHVZUFMx5xAPAatcEzZLZcA=;
        b=cBID4xzpPVVniuauBrpzPYsCCDgvWfIMsnEo3dha25vk0D+4XYq/uMQ33U1DG88bhL
         20kHVp+c9J9+iLPAMQPZya7ID2XNlcfJEpAZAQl1U/FEBMGd0dCxHWMkCbOGBSkJDg1f
         KNrqNgsd/Kx4HYlX7pmS1MTa9PmwRv64fbbN/VylZO0knMN27QIZWW9326ZrtJ2uzo9W
         +uMLFtzw1UPRMRR7C8ZX+9QYFog2/Hj3zIYM3JrvnMRHUKyioGMtBnNeUlePLOq9rkFK
         lZ5WX1Wv2ZaXmEQrtOHmaPT4ENS4C2ITKTIjnftKvB8f6YAIqvQOmV6IpmZY/EE8zFBs
         3Yng==
X-Gm-Message-State: AOJu0Yz2xu32MDx5hSB911TaCrakP44+1I4o8x6F9c2yVTx0KW2cAVDL
	+omiaVrc0ntnf9UZ+QU+8nJE8pCKZdYXUWyitAjzNeVMCLnSAZqV/sa+2eBRQwNpHyWAZvVEqsZ
	Yc+U=
X-Google-Smtp-Source: AGHT+IF3eNA00a7Q9+VVNbmTYiXI7NP7J4MwX8XAV5SbaoEzmuOs/ENlO2O3DkaMyuHbTygcmud1/w==
X-Received: by 2002:a05:6870:bb10:b0:25e:29e7:14c8 with SMTP id 586e51a60fabf-27790319b11mr12953890fac.42.1725206603243;
        Sun, 01 Sep 2024 09:03:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d4988bdbbcsm7957707b3.12.2024.09.01.09.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:03:22 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:03:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <e7cd23bf4cd232fa2ce610284199996383fb3323.1725206584.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com>

Our in-tree SHA-1 wrappers all define platform_SHA_CTX and related
macros to point at the opaque "context" type, init, update, and similar
functions for each specific implementation.

In hash.h, we use these platform_ variables to set up the function
pointers for, e.g., the_hash_algo->init_fn(), etc.

But while these header files have a header-specific macro that prevents
them declaring their structs / functions multiple times, they
unconditionally define the platform variables, making it impossible to
load multiple SHA-1 implementations at once.

As a prerequisite for loading a separate SHA-1 implementation for
non-cryptographic uses, only define the platform_ variables if they have
not already been defined.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 block-sha1/sha1.h | 2 ++
 sha1/openssl.h    | 2 ++
 sha1dc_git.h      | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index 9fb0441b988..47bb9166368 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -16,7 +16,9 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx);
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, size_t len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX	blk_SHA_CTX
 #define platform_SHA1_Init	blk_SHA1_Init
 #define platform_SHA1_Update	blk_SHA1_Update
 #define platform_SHA1_Final	blk_SHA1_Final
+#endif
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 006c1f4ba54..1038af47daf 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -40,10 +40,12 @@ static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
 	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
 }
 
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX openssl_SHA1_CTX
 #define platform_SHA1_Init openssl_SHA1_Init
 #define platform_SHA1_Clone openssl_SHA1_Clone
 #define platform_SHA1_Update openssl_SHA1_Update
 #define platform_SHA1_Final openssl_SHA1_Final
+#endif
 
 #endif /* SHA1_OPENSSL_H */
diff --git a/sha1dc_git.h b/sha1dc_git.h
index 60e3ce84395..f6f880cabea 100644
--- a/sha1dc_git.h
+++ b/sha1dc_git.h
@@ -18,7 +18,10 @@ void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
 void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
 
 #define platform_SHA_IS_SHA1DC /* used by "test-tool sha1-is-sha1dc" */
+
+#ifndef platform_SHA_CTX
 #define platform_SHA_CTX SHA1_CTX
 #define platform_SHA1_Init git_SHA1DCInit
 #define platform_SHA1_Update git_SHA1DCUpdate
 #define platform_SHA1_Final git_SHA1DCFinal
+#endif
-- 
2.46.0.425.ge8f5cbd280c

