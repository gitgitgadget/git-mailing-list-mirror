Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746D15383A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364168; cv=none; b=X9QHEaK7nDs/RlHAmouxeh+Tp/pvj0ALed4e8hIH7BGKWHjbvWXyr01fvnQ3Qo6Qm8rXsJyjbH8n5tuQVfSdzQMdgLtCTxnEjywkCkmTXFWwoLrCCTF3fPzlcWPm5oNTInPIQ/KH+5B2QR8SmaCwgE+d2GQN0wvz1Sk0yiBw0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364168; c=relaxed/simple;
	bh=5Ekba7RMtLZKry+MkFEbD8tTQwNJQyfPwsnOJ+IRVI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3+g6Ntvfifjk4IPBoUCG4nqg5SCCI62AXqsrPp9hz5BN3sKiLAyY8qc1gYlvMIN1NCw8+sG3A13KcRTH9bjJR1V5UQjHLImGc8vqZtutkP8GYwOIdfaxjOBTJaYt4EEYBxiFBOTLreeyA/MnUs0aItFSUCM5LkoGOxDiF7z9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=F9TI+taw; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="F9TI+taw"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25cbc50d7fso955802276.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364166; x=1727968966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMv3K2AHM700CA19tjbjvf8DVwj5IC/uRDnyMgTY88s=;
        b=F9TI+tawCQBbTypcRgtb71vwyiwYM+tCAAvbjrX5n+SaQpntwB26Nd98/sLXWAxuZ6
         eNg2aPYRKgZddw0AyadZop2p1wP1rjuUQ7BJTuzXfEG5RSeqs7ua0la06Xw56PmyW6Hs
         yFi7uTE5KF4+33VkMBgQ7V8aSvnIjFsLwEn10osA+2kt9Znu6aiKLu5yaOQIK+jR+96k
         mucJysdZ3kmmPtjkdJczbT06WYvtmzz1SCL4sqWwMsOqKyE+Ftxby4ZQr5lyu+CYeDRU
         h+TOVd6kjjohdC1YSccn46StKJMFloSVaOeDoYkIiRpGXJjkgHrYqHIFmfpaDjDM+QZe
         qP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364166; x=1727968966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMv3K2AHM700CA19tjbjvf8DVwj5IC/uRDnyMgTY88s=;
        b=fCyvp6HQG5zL0/MZS2wKI69XQ6efVob4yf2fPjO5jscCEpEI9v4HoZXdAaQ4FKLcK5
         lAwhAv799tE5kSzQZZEDQwagTrMW5/I/6CDunDYXygCoW4ATuSUtKRfNe4rWKB1pNoEt
         zvE5nTUT2cClDwQQdiWh8WCym00shIRuez/alRqTkaPtrj39+8y5gLUPJUm+LzPoDyWC
         GBUrJ1MgJBYCjUfcI5PXmDwxEem9Fy+6u6otRlEg2iUoLKSvBxL97XiT+xxNT1+Yq3HZ
         6RDpWHTYCz7SfTwhtZuKI5ip9GYm0tGMEFt3EtU6Ts/lKJSO45UgDarETOsq7NbdYWm/
         E1dA==
X-Gm-Message-State: AOJu0YyUyaUEMXOEPf3Iqo+R7ScF5gK5qc8Nrl5cad4ZIm30mDjkuCfR
	2E5aWIjfe2BhTmh2FRIGd606OYXG5HTbihPibqe3uDb16aX/a3IDO7ljbOBpjgvJLYfOWkAxuTR
	tskg=
X-Google-Smtp-Source: AGHT+IGX/W+UsU7PWn6/Dte43NHjW16lvw/3hzlpDXCia50jajF990snbArflMd86MC+nZ8D1uecfQ==
X-Received: by 2002:a05:6902:d41:b0:e25:c5ec:5797 with SMTP id 3f1490d57ef6-e25c5ec58bemr2904178276.18.1727364165951;
        Thu, 26 Sep 2024 08:22:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3efab1dsm23678276.6.2024.09.26.08.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:45 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/8] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <9913a5d971389e7e657ea151eaedc94bf025f3fc.1727364141.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1727364141.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>

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
index 9fb0441b98..47bb916636 100644
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
index 006c1f4ba5..1038af47da 100644
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
index 60e3ce8439..f6f880cabe 100644
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
2.46.1.507.gffd0c9a15b2.dirty

