Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCA13B5B4
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364175; cv=none; b=i0L9TFhfTU0qgAH3YPqWPtMFZU/6jmJkyX63C3kQrMzgLgoTJrXgf5hHbPTJypAFC8br5swSnJlYB5edrUI4vg6gb77CZaPCc+1tdMK9EXqbzLBakkERXtXMP027hC1QCS3ARkysMtlpVOS59rAKNl5c7vbydPg0XtzFDnyj79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364175; c=relaxed/simple;
	bh=7vDKM4SUo2apFyTxPXWavVpiCUh4l4mtFKXnDw8lZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkAqnKvDDKK23Bd2BeO3h8K6fh/mxNSepyUc4giAmC/D52ImSFFhKMa3O7a4jX7QOF9jCexN4SQI3JsS7lIbc6xlYS9SrjpCgCHKOn8/CdVg4jT5QjCozowt8PUSRT5gC6CZ9C16ZjRq539PLOfQkt32zgSsWnF/yHw+Yiymxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=N3SzpLrY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="N3SzpLrY"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e21ac45b70so10221187b3.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727364172; x=1727968972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYehiyHbxf/iCSm1oMf9XWK5Z0q8gEvRMTROIU/d8ik=;
        b=N3SzpLrYni3C8EWBo1kIkVeahT7zq3s+XKR9YslnOgYhUziOQdkzfUt5fRIvghRZBj
         sj/QJ/VWoQQ+2Hxecbc3QmgUoDD5yppsfXkFQ+jfJTyFEHr4I7M1oz3KPBl9hoaCJui5
         YRbuxaHStOCulMfUSGYwMP4vOSGSnDjbmGG3D6ADm3B/MB1vocOHZa+/0QXvL7PnjhnU
         x6amBzqgA21apitrzMSjBybIUQSfcEewoSth1T1Uuzu4Lasl8mhnE/btVWbxLX5mCfh8
         QAWmCWn6SOxebpgGDY/TK+fWJ6U6v0z8RHRPdub2PshGqvgE4wdG9PaDuU+ojSDu0RqN
         Ak8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727364172; x=1727968972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYehiyHbxf/iCSm1oMf9XWK5Z0q8gEvRMTROIU/d8ik=;
        b=bJo1CNJDjwZgIjYTcuPT/61B8KBTGqL74Upuq7ha8Gc3nqVyFnk1Wxu7feNjN8k4+u
         MJJ/wHXlvOsp/+tsGfBVicbtqL47agL9vmYiG5h4gLa1oP1d/MCZ2RT8/Y/7v4vdpaJr
         OhQC02+acykNTcH1c3t6+diyHh32vj/ahMiIlDuARyxOvrKorrrvGsYVvNsa7OSeNR1K
         T0rveHYPLfoYTZKBM4u83zxJmK/v+J2w15irmzh/vZPL98Eueh/YWLHYwrgQbbgtTr2u
         TVHxyBZYHmmg222LxYeyLVFo4k/J5vnBAqWaOeqhXXy01jWRc5JweoCYMSWbw+LKLx7C
         AVOg==
X-Gm-Message-State: AOJu0Yz913pSbgvc0UqOUb4HLlV+2qIAVIOFSj9c8x0KYrMxKDEbBhX0
	mxvoyDeBzcDwM1dQV3ZlZoqT5OF2alf2o71qJJD3Ak5q2ce9YmzQPr473VqLdbGenXO1BcJE991
	G13E=
X-Google-Smtp-Source: AGHT+IHD0Bumji0CX7bjEaoAXUpHLBI5sZqJrkH22wyfoUncV0o7mWX60fn0Bm2ujixgaaz7YBwBfA==
X-Received: by 2002:a05:690c:397:b0:6dd:bd27:8b07 with SMTP id 00721157ae682-6e21d9d61d1mr49001427b3.36.1727364172063;
        Thu, 26 Sep 2024 08:22:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2452f9b39sm190967b3.25.2024.09.26.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:22:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:22:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 7/8] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <3884cd0e3add1b8dd2de01101dd11addc163d88e.1727364141.git.me@ttaylorr.com>
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

Introduce _UNSAFE variants of the OPENSSL_SHA1, BLK_SHA1, and
APPLE_COMMON_CRYPTO_SHA1 compile-time knobs which indicate which SHA-1
implementation is to be used for non-cryptographic uses.

There are a couple of small implementation notes worth mentioning:

  - There is no way to select the collision detecting SHA-1 as the
    "fast" fallback, since the fast fallback is only for
    non-cryptographic uses, and is meant to be faster than our
    collision-detecting implementation.

  - There are no similar knobs for SHA-256, since no collision attacks
    are presently known and thus no collision-detecting implementations
    actually exist.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile | 25 +++++++++++++++++++++++++
 hash.h   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Makefile b/Makefile
index 9cf2be070f..fb84a87592 100644
--- a/Makefile
+++ b/Makefile
@@ -521,6 +521,10 @@ include shared.mak
 # Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
 # SHA-1.
 #
+# Define the same Makefile knobs as above, but suffixed with _UNSAFE to
+# use the corresponding implementations for unsafe SHA-1 hashing for
+# non-cryptographic purposes.
+#
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
 # collision-detecting sha1 This is slower, but may detect attempted
@@ -1996,6 +2000,27 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA1_UNSAFE
+ifndef OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL_UNSAFE
+endif
+else
+ifdef BLK_SHA1_UNSAFE
+ifndef BLK_SHA1
+	LIB_OBJS += block-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_BLK_UNSAFE
+endif
+else
+ifdef APPLE_COMMON_CRYPTO_SHA1_UNSAFE
+ifndef APPLE_COMMON_CRYPTO_SHA1
+	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	BASIC_CFLAGS += -DSHA1_APPLE_UNSAFE
+endif
+endif
+endif
+endif
+
 ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA256_OPENSSL
diff --git a/hash.h b/hash.h
index 96458b129f..f97f858307 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,36 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#if defined(SHA1_APPLE_UNSAFE)
+#  include <CommonCrypto/CommonDigest.h>
+#  define platform_SHA_CTX_unsafe CC_SHA1_CTX
+#  define platform_SHA1_Init_unsafe CC_SHA1_Init
+#  define platform_SHA1_Update_unsafe CC_SHA1_Update
+#  define platform_SHA1_Final_unsafe CC_SHA1_Final
+#elif defined(SHA1_OPENSSL_UNSAFE)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
+#    include "sha1/openssl.h"
+#    define platform_SHA_CTX_unsafe openssl_SHA1_CTX
+#    define platform_SHA1_Init_unsafe openssl_SHA1_Init
+#    define platform_SHA1_Clone_unsafe openssl_SHA1_Clone
+#    define platform_SHA1_Update_unsafe openssl_SHA1_Update
+#    define platform_SHA1_Final_unsafe openssl_SHA1_Final
+#  else
+#    define platform_SHA_CTX_unsafe SHA_CTX
+#    define platform_SHA1_Init_unsafe SHA1_Init
+#    define platform_SHA1_Update_unsafe SHA1_Update
+#    define platform_SHA1_Final_unsafe SHA1_Final
+#  endif
+#elif defined(SHA1_BLK_UNSAFE)
+#  include "block-sha1/sha1.h"
+#  define platform_SHA_CTX_unsafe blk_SHA_CTX
+#  define platform_SHA1_Init_unsafe blk_SHA1_Init
+#  define platform_SHA1_Update_unsafe blk_SHA1_Update
+#  define platform_SHA1_Final_unsafe blk_SHA1_Final
+#endif
+
 #if defined(SHA256_NETTLE)
 #include "sha256/nettle.h"
 #elif defined(SHA256_GCRYPT)
-- 
2.46.1.507.gffd0c9a15b2.dirty

