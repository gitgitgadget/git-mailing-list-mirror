Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186E1D79A4
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651992; cv=none; b=SrPsCSOajP+3Bt1rc3X2MPULYmbu1Ay5EnnkxVOjD5UGiyGt4pCez0x2V3WET0LWzZIwgQKk0XpwMlemYaLKMabmdtCWQO962ivIVg2H4yVgJcSzSYxq0kBLfhbX5z4L9h1LNIQ0D0QZNIQIysDaI2qsk2Emk1XMTfi8SO3Jxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651992; c=relaxed/simple;
	bh=yU2XLiil/Dgd1SR2dDh984LhHX+sGVOf/Y/qgC+kWAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evGEv3MWtCX6rhBFminYfRB1AQHuVJcw3hr078IGwoXGk80vo555akc38K8Co7O3xkXjy9F1r5s50b8t4rm1/ys5dDTLrOjTZThv07G2hrIHHBRAZLWrsBSuKNBVuhMqxg6cQ3TcOhPgz0OtCymI5gliGB8fPLrXIR67GkME2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NG1wlJnh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NG1wlJnh"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-699ac6dbf24so21783037b3.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725651990; x=1726256790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkgFMJYvEuhrH5mGmGFeZ4T8Q78nXa3QWTMrxfpu9RI=;
        b=NG1wlJnh6H5R8hV7E2zUDrKx0NS1EXxzCcAGkjjZJIvVIxoyFn4YwcPClXZHD7jQ7e
         uJ+UFqyX385UwmySqGdo1wyaec+FjgZRM1q5goVF3BZ6vrHs57mFoT9h1Wm1yvGO7tBf
         qQfBeubZlb5sNhEBJFEkwoYn4nEnEwK285TJDqTl5+IMdIbPMDPtd2tw/oTpei9ZXIJ/
         UZVLKF8blVszLT2LeUNvQQcyYvLaIoiTk0qJ4KN29EX7AFs4rRnQ4cQ3GYmuver8QQ15
         c2vajPF8KHAaaR0LZEyCTydXqmvcOjrulQDTVqNB7o1jmRFum20eOME96XwVBkrDgZ+J
         QApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651990; x=1726256790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkgFMJYvEuhrH5mGmGFeZ4T8Q78nXa3QWTMrxfpu9RI=;
        b=NdZRvWWln69miZzjg298SjnwRqgN57dI4mbUlLkP8N7uyV+tTu/cCXIQHhTgdujHke
         /lyKJ9SWG3tfIH+ZAsXshkYp0/ocRfjMdtP09yi9vOC0HP/gZCVIvOinMgvMu2sxSfqO
         rrVU3cWsFWEWJQsEzeCXshWEuCorYytucmKiMHFlTPaDkh5pFKqh9KHGbu2kiU5Aq+i5
         MPAvl8ANSeldRzIU/e3bETCEiG6a0+KyCa2Qj/0qfsl6PAB25HS81P1sWD0C/L325f0y
         und0K2F6fiQTbnCkrLK9/CbMqVHImvwkvHhHlWisiLwpj7KHRveJEvEVG5djD/WsEZVB
         HorQ==
X-Gm-Message-State: AOJu0Yyd5pf2uIetr3Xb8h1fzdTktq0eSqlryzmUILj7oNiaO94dS8Ux
	RY8I3XLa8P7xXcfunSZtlgHj6wVix0L1L9tZIc666v34z96XxNJc+IW/XF4HA+J3o3Fmb7xTdlT
	ci6g=
X-Google-Smtp-Source: AGHT+IHMZOyWccxzVOMDrURsiHTtWSsovzhAjcli5sJBwzOtxuOW4xlrzcfhIREiixVoF9+QzXwZCg==
X-Received: by 2002:a05:690c:2f0a:b0:6d3:f51b:38a3 with SMTP id 00721157ae682-6db4515475amr29423517b3.33.1725651989793;
        Fri, 06 Sep 2024 12:46:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db5631a7a8sm1142077b3.23.2024.09.06.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:46:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:46:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/9] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <137ec30d68a7cf60e738951a7bf283ef78e44345.1725651952.git.me@ttaylorr.com>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1725651952.git.me@ttaylorr.com>

Introduce _FAST variants of the OPENSSL_SHA1, BLK_SHA1, and
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
index e298c8b55ec..d24f9088802 100644
--- a/Makefile
+++ b/Makefile
@@ -517,6 +517,10 @@ include shared.mak
 # Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
 # SHA-1.
 #
+# Define the same Makefile knobs as above, but suffixed with _FAST to
+# use the corresponding implementations for "fast" SHA-1 hashing for
+# non-cryptographic purposes.
+#
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
 # collision-detecting sha1 This is slower, but may detect attempted
@@ -1982,6 +1986,27 @@ endif
 endif
 endif
 
+ifdef OPENSSL_SHA1_FAST
+ifndef OPENSSL_SHA1
+	EXTLIBS += $(LIB_4_CRYPTO)
+	BASIC_CFLAGS += -DSHA1_OPENSSL_FAST
+endif
+else
+ifdef BLK_SHA1_FAST
+ifndef BLK_SHA1
+	LIB_OBJS += block-sha1/sha1.o
+	BASIC_CFLAGS += -DSHA1_BLK_FAST
+endif
+else
+ifdef APPLE_COMMON_CRYPTO_SHA1_FAST
+ifndef APPLE_COMMON_CRYPTO_SHA1
+	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
+	BASIC_CFLAGS += -DSHA1_APPLE_FAST
+endif
+endif
+endif
+endif
+
 ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
 	BASIC_CFLAGS += -DSHA256_OPENSSL
diff --git a/hash.h b/hash.h
index 5e5b8205b58..6ea0d968017 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,36 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#if defined(SHA1_APPLE_FAST)
+#  include <CommonCrypto/CommonDigest.h>
+#  define platform_SHA_CTX_fast CC_SHA1_CTX
+#  define platform_SHA1_Init_fast CC_SHA1_Init
+#  define platform_SHA1_Update_fast CC_SHA1_Update
+#  define platform_SHA1_Final_fast CC_SHA1_Final
+#elif defined(SHA1_OPENSSL_FAST)
+#  include <openssl/sha.h>
+#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
+#    define SHA1_NEEDS_CLONE_HELPER_FAST
+#    include "sha1/openssl.h"
+#    define platform_SHA_CTX_fast openssl_SHA1_CTX
+#    define platform_SHA1_Init_fast openssl_SHA1_Init
+#    define platform_SHA1_Clone_fast openssl_SHA1_Clone
+#    define platform_SHA1_Update_fast openssl_SHA1_Update
+#    define platform_SHA1_Final_fast openssl_SHA1_Final
+#  else
+#    define platform_SHA_CTX_fast SHA_CTX
+#    define platform_SHA1_Init_fast SHA1_Init
+#    define platform_SHA1_Update_fast SHA1_Update
+#    define platform_SHA1_Final_fast SHA1_Final
+#  endif
+#elif defined(SHA1_BLK_FAST)
+#  include "block-sha1/sha1.h"
+#  define platform_SHA_CTX_fast blk_SHA_CTX
+#  define platform_SHA1_Init_fast blk_SHA1_Init
+#  define platform_SHA1_Update_fast blk_SHA1_Update
+#  define platform_SHA1_Final_fast blk_SHA1_Final
+#endif
+
 #if defined(SHA256_NETTLE)
 #include "sha256/nettle.h"
 #elif defined(SHA256_GCRYPT)
-- 
2.46.0.430.gca674632b70

