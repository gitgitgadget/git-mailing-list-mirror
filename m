Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DE1AC89B
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199149; cv=none; b=e7EtjCOsIwFLRtzsBescQO1zF4KHG9hHs0dElEP1RdqD3Ob6ZyOWawUHCVY7oSNLHKTVyS0Bc8bAiJHo1yL1CAmKtsd2NH57ncTxcWMpk9jhsozPh/n/69T7YPRYoO0HAeGRB5INTm1dhnLtxQcM6gXCuqb0E1W+UAaYGb8jAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199149; c=relaxed/simple;
	bh=PPR0KUGWoQXvQ9N5oCgYRCD4y+oNPgM+laGsMSi7wHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlp2GGqmNgvOG5dgG6D689fDXUexwGUK7e0KvW2y2akDcY++Ltq4FuAMjPbXtpCKOQR88tbY8hc4qtmMWUvZlnsTh04Lwg5Thd8Cj3LG0W1fgSK3z00O6lEkAgl6AvbY8j5syHR2QDwHrKk5JZyJjwZmNc4aKD0eT157SW7BOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=szwEM6bj; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="szwEM6bj"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so5800706276.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199146; x=1727803946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJjrakAcqMqCV9bvTcFxUPZIYP5wM6235OvJkaiITCQ=;
        b=szwEM6bjOQH7sLTNnZboplVZzXTgbQ7MzH4SiCS43FYjkC+Qbaj6HN3hu8uHEuL9Tq
         py9opeA1N9ZMoO9MnhmxSDvAO7isU848YiIrQCUNREnt4G0UZ3expIF/krBDhwOueAKe
         lZoC2x1LNae3krXI2MIaLwXEs1eS04jdB1mzL+5zE4e00Kfp45rOBGH3NZhoTEKZRrV4
         1nsnFCQ37/QsbTY/30frW401YthNUGGduBbsPjcOnsnvuqqqXyn6j4VDW4MbtiV4xQ/b
         tBCeqOprp/r1r++TlvhJgrwuDCIh4HVFzRJ2OO+JwMUE2b/S3P/8BngLxq53NjpJ1QMO
         MN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199146; x=1727803946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJjrakAcqMqCV9bvTcFxUPZIYP5wM6235OvJkaiITCQ=;
        b=eEYonFzBF1Q+em45iIWz6ysE9kN4+o8brNmmPufaoV8dIZ8+GpQTC6A+DrgoBQgTkv
         q3k2fbfbTK0hqmqkFCqMy2vsSVSUzQGnLq1BuEIQsa9liYT57mJNNJLJX19IGW5pSZ5u
         NyoOjpyXLKJsxtLU7ssrh4YaZ9uF4quFa+efNypa4AYSorrnx/dq0XY8Xo2K+ek9X+Y4
         yZTXpKNYyEyEXTjNZJ1L12ExFLjgOxC0C1IbJuqll89747YzxyyDCM9BhVCE2t8oJXMN
         tRkSmY7pCakfXGyZ4ZYqUJitYDql37F8Dfn/MMyAf7UiI1iBL/EDTFe8vNYFDiikbR+U
         wK8A==
X-Gm-Message-State: AOJu0YyL+oB5ocSTLtZpKxD67kwSonVxzXEIJR8MSDyR5B1DEjib9j9b
	N9Qyx/t8VoxGX5L1a0OPF2qvNy0HCR4hYDLw0FIsJr4IBJiUts15H/v7/UClIB5p/zCwvbxqQaf
	LtgE=
X-Google-Smtp-Source: AGHT+IFp+hEFl10gUG9His5SMUdhGmNdKva2fU7PZsSoeICPVCU6+lSdH13KJKRdtKl+W2t+okGWcA==
X-Received: by 2002:a05:690c:d83:b0:6e2:11e4:2f58 with SMTP id 00721157ae682-6e21d6ec5e2mr2138627b3.7.1727199146487;
        Tue, 24 Sep 2024 10:32:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e20cffe0f6sm3142427b3.25.2024.09.24.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:26 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/8] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <8f8ac0f5b0e6ddc774b9108049d7f9c3310735f3.1727199118.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727199118.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>

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
2.46.2.636.g4b83dd05e9f

