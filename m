Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC21AC424
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199156; cv=none; b=A0Nrso7j4cE6c9NJ8oHDvKY0zEBocuDxGCCagaph/tLIMRDfSJ5vXePngY69DApK05D8V4nD5r6L7gQlwEiqedyGjm26qnxzWNJGMrM0Fl/ViO5V4Mfp1mtlJvrmKyh8wjFKYDtkELXPIc6lAkmoeKIzvK1ymlmSSr4I8FnAsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199156; c=relaxed/simple;
	bh=+WM9XWHSEJ3ncDjE3zebOmDr8bXcBSX6wjlrZDms4Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaXv2PtgLwzG9+Oe/LS5oLQpX+/G/YK30SNPsFqJxuK2bedO9lqMBj9MLbBISq1pkfLGdfUki+C9BCEmS/GvDmSG2Eiu+1HhpwBLztoKiAKk6y8s8w94rAIr4K0QVxGqSJzrBUYedpYGdbGnrrp+oNwpZWuMM6tXAdYWegSQhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nUjifs+X; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nUjifs+X"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e22531db3baso3792130276.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727199153; x=1727803953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4Q6POxtDbrGJ5dnpl5kdnB8d0HovRP9OhWdbVm6isk=;
        b=nUjifs+X/1ON43waEDJ3QNaZLsKIQ3R/UVMApnhqnHf4v0YBaTWsuj5GA+18ZP7NQa
         8tevyjOqerwjBvij7MGTxa8nDz847O9NZAULipDpNuWDZZXFnDYGbjWMU9HBa3NHnpJE
         wQoSitw3XxtlfSiMrqdVY96YdSswr50epesTuI1FFxOt7G0CU1MDBCqnL6v5/Z32hbyf
         3zkSzDZZRrcy3lvMpdDpct7jUYmnslbsmCBdjVmZt3UCDu/mam/5+O9uBTIeewWgwEnW
         oXz8SY8zcmssoIae18aTSLYtE286AlqyfiPNzFO1R1Is21D+FPYE63BJhHHs4DKF/zE6
         iW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199153; x=1727803953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4Q6POxtDbrGJ5dnpl5kdnB8d0HovRP9OhWdbVm6isk=;
        b=EXd1HnbSpaJ1reHy+wsKIDhGSM+0Uc8KDnkwffpW9KJ7nPnecRmUzAJOaC8jxJSSQF
         VhxUJYaPnSWmwaY1n8c3Nt+1CaIxc6o+J0xEIC4gLGqDloMkGhibjKEyoBxa+F7WEU4a
         i4UkUuQPqP9FY9Bm6tBOkjwsXrc3jHRYCD6Gx4Hdp6pAqA0DIiljAWcvDcdZRIkqDCmX
         EzeyZAcraHtIydx6ux++pDiSqrfrALHt7hSjY7Om5RUqHkaAANOQOe/aQdKdAtOLDaK3
         ZBxBSEpbagOARs8zGh9x2FRrznJN6oVSNsIfhAfL+7YcRpiRRy6ipbQum+7A2/50XDbw
         6cvw==
X-Gm-Message-State: AOJu0YzYEaz6dYDnnoIIYDVgBi7tOOhsfzXO+lwzzr4D/p4D1vPvfl+A
	jc809aq6Jyh0qoOhprd8AAvXJSI1nG5uxPhhBSlRgetA9n7Ka72VNcE8QwO1xRP15oJIyyGffjn
	sGXg=
X-Google-Smtp-Source: AGHT+IFQb0KgEff82Qd2b13z5Wr3qXshW/NfXn5zDGCBofkazDjKXgjmZsTeRL0JnFqehrDqAvP2zw==
X-Received: by 2002:a05:6902:f82:b0:e20:1165:8da2 with SMTP id 3f1490d57ef6-e2250c47748mr12184023276.29.1727199153593;
        Tue, 24 Sep 2024 10:32:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2499ae6a78sm319402276.6.2024.09.24.10.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 10:32:32 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:32:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 7/8] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <af8fd9aa4ede1fb37d4990dd52c5de0f9b9fa681.1727199118.git.me@ttaylorr.com>
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
index 9cf2be070fa..fb84a87592d 100644
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
index 96458b129f9..f97f858307b 100644
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
2.46.2.636.g4b83dd05e9f

