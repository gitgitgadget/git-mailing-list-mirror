Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059E3201CF
	for <e@80x24.org>; Wed, 17 May 2017 11:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdEQLim (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 07:38:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35466 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdEQLik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 07:38:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id g12so1363432wrg.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Idn+kFUSRuOmuOqleStCTMHXUI65pT7SRSX3jR4Q82s=;
        b=Uqajv1TIPZdJVWSWZXMQevQiQRgw1NUvM2zCD3H1yi6uFRuVP3gl82REcmdR52wU7q
         OPQtfrTbpVImJAdAZurMh9efEFidgaOCMz2Iwty+hY8TWjqsHUVs6XvqNMY2j5XZhxFK
         Ah2VV3x/zpVFFNVx3WZ1fmKj45zV0RNDKoDemhOItM2NatnzOySaUsszhUT8RSB3i2j8
         6XN7T7N/6IGBUhHqrvTeqOHH998+Qxvt4G1piVowq1YhoGsGzBxWXoaruIdL8PqC8T6n
         bB+URQODDQwmSxdRzQDOp90aQjW2Vb5tjHF5rO7klc5S4PJJhb5APMcn673bipZvkIiB
         Lx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Idn+kFUSRuOmuOqleStCTMHXUI65pT7SRSX3jR4Q82s=;
        b=Fo1m0ct7H56CZYUeIzkNnKC7tC69XhbWacwPc5dffMw2TGXiaiHTXfS5wm4FgRZiNg
         x7So/QbMGtqHEPeFoIzKD/bCMXgZCgW0TBkLdniPBmuT1TNlhRsyCc+fPaNMXAgVnRuK
         YOCNQ+VMCCWR5RbkfhnYDwWlsXGnq7uaxyJv1GXxXTwyU4O2TcJ4TNushoaJiFEzFmcy
         6mISP6/SaajdvSt7S0QXMuLPbwmLW/nk6ymgfigtLOpcy5l/Sj4HWtf1m5/W422dXLCg
         7FIozType2d4ayThZkkOT21xuWE+4AvKeRbSpgEnRIEHnUP2NEC86Uq0II8yx6oeZniz
         G5yQ==
X-Gm-Message-State: AODbwcCHgV4J8tJKbTh4nkQO5ImjD4K1dOJPz+S51h+amiLCkhobmb24
        TlNmWO5TRXe3tw==
X-Received: by 10.223.135.84 with SMTP id 20mr2204455wrz.141.1495021119020;
        Wed, 17 May 2017 04:38:39 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm12502473wmd.1.2017.05.17.04.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2017 04:38:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 1/3] sha1dc: update from my fork of upstream
Date:   Wed, 17 May 2017 11:38:22 +0000
Message-Id: <20170517113824.31700-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170517113824.31700-1-avarab@gmail.com>
References: <20170517113824.31700-1-avarab@gmail.com>
In-Reply-To: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
References: <xmqqk25gvu12.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upgrade the sha1dc code from my fork of the project, which has one
patch I'm hoping will be integrated upstream after this series
demonstrates its usefulness:

    https://github.com/cr-marcstevens/sha1collisiondetection/compare/master...avar:easier-inclusion-in-other-programs

That minor change allows us to in the future just use the upstream
code as-is, without any local modifications.

Now all the local modifications we've done in this directory (see the
git history of sha1dc/) are done either with defines, or via the newly
added sha1dc_git.[ch] files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile           |  9 +++++-
 sha1dc/sha1.c      | 79 ++++++++++++++++++++++++++---------------------
 sha1dc/sha1.h      | 90 +++++++++++++++++++++++-------------------------------
 sha1dc/ubc_check.c |  9 ++++--
 sha1dc/ubc_check.h | 10 ++++--
 sha1dc_git.c       | 19 ++++++++++++
 sha1dc_git.h       | 14 +++++++++
 7 files changed, 139 insertions(+), 91 deletions(-)
 create mode 100644 sha1dc_git.c
 create mode 100644 sha1dc_git.h

diff --git a/Makefile b/Makefile
index e35542e631..342466d83a 100644
--- a/Makefile
+++ b/Makefile
@@ -1414,7 +1414,14 @@ else
 	DC_SHA1 := YesPlease
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
-	BASIC_CFLAGS += -DSHA1_DC
+	BASIC_CFLAGS += \
+		-DSHA1_DC \
+		-DSHA1DC_NO_STANDARD_INCLUDES \
+		-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 \
+		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
+		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C="\"../sha1dc_git.c\"" \
+		-DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H="\"../sha1dc_git.h\"" \
+		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
 endif
 endif
diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 35e9dd5bf4..c53f68b844 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -5,12 +5,26 @@
 * https://opensource.org/licenses/MIT
 ***/
 
-#include "cache.h"
-#include "sha1dc/sha1.h"
-#include "sha1dc/ubc_check.h"
+#ifndef SHA1DC_NO_STANDARD_INCLUDES
+#include <string.h>
+#include <memory.h>
+#include <stdio.h>
+#include <stdlib.h>
+#endif
+
+#ifdef SHA1DC_CUSTOM_INCLUDE_SHA1_C
+#include SHA1DC_CUSTOM_INCLUDE_SHA1_C
+#endif
 
+#ifndef SHA1DC_INIT_SAFE_HASH_DEFAULT
+#define SHA1DC_INIT_SAFE_HASH_DEFAULT 1
+#endif
 
-/*
+#include "sha1.h"
+#include "ubc_check.h"
+
+
+/* 
    Because Little-Endian architectures are most common,
    we only set SHA1DC_BIGENDIAN if one of these conditions is met.
    Note that all MSFT platforms are little endian,
@@ -18,14 +32,17 @@
    If you are compiling on a big endian platform and your compiler does not define one of these,
    you will have to add whatever macros your tool chain defines to indicate Big-Endianness.
  */
-#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
+#ifdef SHA1DC_BIGENDIAN
+#undef SHA1DC_BIGENDIAN
+#endif
+#if (!defined SHA1DC_FORCE_LITTLEENDIAN) && \
+    ((defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
     (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
-    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
-    defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)
+    defined(_BIG_ENDIAN) || defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
+    defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__) || defined(SHA1DC_FORCE_BIGENDIAN))
+
+#define SHA1DC_BIGENDIAN
 
-#define SHA1DC_BIGENDIAN	1
-#else
-#undef SHA1DC_BIGENDIAN
 #endif /*ENDIANNESS SELECTION*/
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
@@ -36,11 +53,11 @@
 
 #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1))
 
-#if defined(SHA1DC_BIGENDIAN)
+#ifdef SHA1DC_BIGENDIAN
 	#define sha1_load(m, t, temp)  { temp = m[t]; }
 #else
 	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
-#endif /* !defined(SHA1DC_BIGENDIAN) */
+#endif
 
 #define sha1_store(W, t, x)	*(volatile uint32_t *)&W[t] = x
 
@@ -869,6 +886,11 @@ static void sha1recompress_fast_ ## t (uint32_t ihvin[5], uint32_t ihvout[5], co
 	ihvout[0] = ihvin[0] + a; ihvout[1] = ihvin[1] + b; ihvout[2] = ihvin[2] + c; ihvout[3] = ihvin[3] + d; ihvout[4] = ihvin[4] + e; \
 }
 
+#ifdef _MSC_VER
+#pragma warning(push)
+#pragma warning(disable: 4127)  /* Complier complains about the checks in the above macro being constant. */
+#endif
+
 #ifdef DOSTORESTATE0
 SHA1_RECOMPRESS(0)
 #endif
@@ -1189,6 +1211,10 @@ SHA1_RECOMPRESS(78)
 SHA1_RECOMPRESS(79)
 #endif
 
+#ifdef _MSC_VER
+#pragma warning(pop)
+#endif
+
 static void sha1_recompression_step(uint32_t step, uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5])
 {
 	switch (step)
@@ -1606,7 +1632,7 @@ static void sha1_process(SHA1_CTX* ctx, const uint32_t block[16])
 	unsigned i, j;
 	uint32_t ubc_dv_mask[DVMASKSIZE] = { 0xFFFFFFFF };
 	uint32_t ihvtmp[5];
-
+	
 	ctx->ihv1[0] = ctx->ihv[0];
 	ctx->ihv1[1] = ctx->ihv[1];
 	ctx->ihv1[2] = ctx->ihv[2];
@@ -1662,7 +1688,7 @@ void SHA1DCInit(SHA1_CTX* ctx)
 	ctx->ihv[3] = 0x10325476;
 	ctx->ihv[4] = 0xC3D2E1F0;
 	ctx->found_collision = 0;
-	ctx->safe_hash = 0;
+	ctx->safe_hash = SHA1DC_INIT_SAFE_HASH_DEFAULT;
 	ctx->ubc_check = 1;
 	ctx->detect_coll = 1;
 	ctx->reduced_round_coll = 0;
@@ -1728,7 +1754,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
 	while (len >= 64)
 	{
 		ctx->total += 64;
-		sha1_process(ctx, (uint32_t*)(buf));
+		memcpy(ctx->buffer, buf, 64);
+		sha1_process(ctx, (uint32_t*)(ctx->buffer));
 		buf += 64;
 		len -= 64;
 	}
@@ -1788,22 +1815,6 @@ int SHA1DCFinal(unsigned char output[20], SHA1_CTX *ctx)
 	return ctx->found_collision;
 }
 
-void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
-{
-	if (!SHA1DCFinal(hash, ctx))
-		return;
-	die("SHA-1 appears to be part of a collision attack: %s",
-	    sha1_to_hex(hash));
-}
-
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
-{
-	const char *data = vdata;
-	/* We expect an unsigned long, but sha1dc only takes an int */
-	while (len > INT_MAX) {
-		SHA1DCUpdate(ctx, data, INT_MAX);
-		data += INT_MAX;
-		len -= INT_MAX;
-	}
-	SHA1DCUpdate(ctx, data, len);
-}
+#ifdef SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C
+#include SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C
+#endif
diff --git a/sha1dc/sha1.h b/sha1dc/sha1.h
index bd8bd928fb..285161ee35 100644
--- a/sha1dc/sha1.h
+++ b/sha1dc/sha1.h
@@ -4,6 +4,7 @@
 * See accompanying file LICENSE.txt or copy at
 * https://opensource.org/licenses/MIT
 ***/
+
 #ifndef SHA1DC_SHA1_H
 #define SHA1DC_SHA1_H
 
@@ -11,36 +12,30 @@
 extern "C" {
 #endif
 
-/* uses SHA-1 message expansion to expand the first 16 words of W[] to 80 words */
-/* void sha1_message_expansion(uint32_t W[80]); */
-
-/* sha-1 compression function; first version takes a message block pre-parsed as 16 32-bit integers, second version takes an already expanded message) */
-/* void sha1_compression(uint32_t ihv[5], const uint32_t m[16]);
-void sha1_compression_W(uint32_t ihv[5], const uint32_t W[80]); */
+#ifndef SHA1DC_NO_STANDARD_INCLUDES
+#include <stdint.h>
+#endif
 
-/* same as sha1_compression_W, but additionally store intermediate states */
+/* sha-1 compression function that takes an already expanded message, and additionally store intermediate states */
 /* only stores states ii (the state between step ii-1 and step ii) when DOSTORESTATEii is defined in ubc_check.h */
 void sha1_compression_states(uint32_t[5], const uint32_t[16], uint32_t[80], uint32_t[80][5]);
 
 /*
-// function type for sha1_recompression_step_T (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5])
-// where 0 <= T < 80
-//       me2 is an expanded message (the expansion of an original message block XOR'ed with a disturbance vector's message block difference)
-//       state is the internal state (a,b,c,d,e) before step T of the SHA-1 compression function while processing the original message block
-// the function will return:
-//       ihvin: the reconstructed input chaining value
-//       ihvout: the reconstructed output chaining value
+// Function type for sha1_recompression_step_T (uint32_t ihvin[5], uint32_t ihvout[5], const uint32_t me2[80], const uint32_t state[5]).
+// Where 0 <= T < 80
+//       me2 is an expanded message (the expansion of an original message block XOR'ed with a disturbance vector's message block difference.)
+//       state is the internal state (a,b,c,d,e) before step T of the SHA-1 compression function while processing the original message block.
+// The function will return:
+//       ihvin: The reconstructed input chaining value.
+//       ihvout: The reconstructed output chaining value.
 */
 typedef void(*sha1_recompression_type)(uint32_t*, uint32_t*, const uint32_t*, const uint32_t*);
 
-/* table of sha1_recompression_step_0, ... , sha1_recompression_step_79 */
-/* extern sha1_recompression_type sha1_recompression_step[80];*/
-
-/* a callback function type that can be set to be called when a collision block has been found: */
+/* A callback function type that can be set to be called when a collision block has been found: */
 /* void collision_block_callback(uint64_t byteoffset, const uint32_t ihvin1[5], const uint32_t ihvin2[5], const uint32_t m1[80], const uint32_t m2[80]) */
 typedef void(*collision_block_callback)(uint64_t, const uint32_t*, const uint32_t*, const uint32_t*, const uint32_t*);
 
-/* the SHA-1 context */
+/* The SHA-1 context. */
 typedef struct {
 	uint64_t total;
 	uint32_t ihv[5];
@@ -59,30 +54,34 @@ typedef struct {
 	uint32_t states[80][5];
 } SHA1_CTX;
 
-/* initialize SHA-1 context */
+/* Initialize SHA-1 context. */
 void SHA1DCInit(SHA1_CTX*);
 
 /*
-// function to enable safe SHA-1 hashing:
-// collision attacks are thwarted by hashing a detected near-collision block 3 times
-// think of it as extending SHA-1 from 80-steps to 240-steps for such blocks:
-//   the best collision attacks against SHA-1 have complexity about 2^60,
-//   thus for 240-steps an immediate lower-bound for the best cryptanalytic attacks would 2^180
-//   an attacker would be better off using a generic birthday search of complexity 2^80
-//
-// enabling safe SHA-1 hashing will result in the correct SHA-1 hash for messages where no collision attack was detected
-// but it will result in a different SHA-1 hash for messages where a collision attack was detected
-// this will automatically invalidate SHA-1 based digital signature forgeries
-// enabled by default
+    Function to enable safe SHA-1 hashing:
+    Collision attacks are thwarted by hashing a detected near-collision block 3 times.
+    Think of it as extending SHA-1 from 80-steps to 240-steps for such blocks:
+        The best collision attacks against SHA-1 have complexity about 2^60,
+        thus for 240-steps an immediate lower-bound for the best cryptanalytic attacks would be 2^180.
+        An attacker would be better off using a generic birthday search of complexity 2^80.
+  
+   Enabling safe SHA-1 hashing will result in the correct SHA-1 hash for messages where no collision attack was detected,
+   but it will result in a different SHA-1 hash for messages where a collision attack was detected.
+   This will automatically invalidate SHA-1 based digital signature forgeries.
+   Enabled by default.
 */
 void SHA1DCSetSafeHash(SHA1_CTX*, int);
 
-/* function to disable or enable the use of Unavoidable Bitconditions (provides a significant speed up) */
-/* enabled by default */
+/*
+    Function to disable or enable the use of Unavoidable Bitconditions (provides a significant speed up).
+    Enabled by default
+ */
 void SHA1DCSetUseUBC(SHA1_CTX*, int);
 
-/* function to disable or enable the use of Collision Detection */
-/* enabled by default */
+/*
+    Function to disable or enable the use of Collision Detection.
+    Enabled by default.
+ */
 void SHA1DCSetUseDetectColl(SHA1_CTX*, int);
 
 /* function to disable or enable the detection of reduced-round SHA-1 collisions */
@@ -98,25 +97,14 @@ void SHA1DCUpdate(SHA1_CTX*, const char*, size_t);
 
 /* obtain SHA-1 hash from SHA-1 context */
 /* returns: 0 = no collision detected, otherwise = collision found => warn user for active attack */
-int  SHA1DCFinal(unsigned char[20], SHA1_CTX*);
+int  SHA1DCFinal(unsigned char[20], SHA1_CTX*); 
 
-/*
- * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
- */
-void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
-
-/*
- * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
- */
-void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
-
-#define platform_SHA_CTX SHA1_CTX
-#define platform_SHA1_Init SHA1DCInit
-#define platform_SHA1_Update git_SHA1DCUpdate
-#define platform_SHA1_Final git_SHA1DCFinal
+#ifdef SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H
+#include SHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H
+#endif
 
 #if defined(__cplusplus)
 }
 #endif
 
-#endif /* SHA1DC_SHA1_H */
+#endif
diff --git a/sha1dc/ubc_check.c b/sha1dc/ubc_check.c
index 089dd4743d..0614926648 100644
--- a/sha1dc/ubc_check.c
+++ b/sha1dc/ubc_check.c
@@ -24,8 +24,13 @@
 // ubc_check has been verified against ubc_check_verify using the 'ubc_check_test' program in the tools section
 */
 
-#include "git-compat-util.h"
-#include "sha1dc/ubc_check.h"
+#ifndef SHA1DC_NO_STANDARD_INCLUDES
+#include <stdint.h>
+#endif
+#ifdef SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C
+#include SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C
+#endif
+#include "ubc_check.h"
 
 static const uint32_t DV_I_43_0_bit 	= (uint32_t)(1) << 0;
 static const uint32_t DV_I_44_0_bit 	= (uint32_t)(1) << 1;
diff --git a/sha1dc/ubc_check.h b/sha1dc/ubc_check.h
index b64c306d77..f6bb62547a 100644
--- a/sha1dc/ubc_check.h
+++ b/sha1dc/ubc_check.h
@@ -20,13 +20,17 @@
 // thus one needs to do the recompression check for each DV that has its bit set
 */
 
-#ifndef UBC_CHECK_H
-#define UBC_CHECK_H
+#ifndef SHA1DC_UBC_CHECK_H
+#define SHA1DC_UBC_CHECK_H
 
 #if defined(__cplusplus)
 extern "C" {
 #endif
 
+#ifndef SHA1DC_NO_STANDARD_INCLUDES
+#include <stdint.h>
+#endif
+
 #define DVMASKSIZE 1
 typedef struct { int dvType; int dvK; int dvB; int testt; int maski; int maskb; uint32_t dm[80]; } dv_info_t;
 extern dv_info_t sha1_dvs[];
@@ -41,4 +45,4 @@ void ubc_check(const uint32_t W[80], uint32_t dvmask[DVMASKSIZE]);
 }
 #endif
 
-#endif /* UBC_CHECK_H */
+#endif
diff --git a/sha1dc_git.c b/sha1dc_git.c
new file mode 100644
index 0000000000..e59c1d8103
--- /dev/null
+++ b/sha1dc_git.c
@@ -0,0 +1,19 @@
+void git_SHA1DCFinal(unsigned char hash[20], SHA1_CTX *ctx)
+{
+	if (!SHA1DCFinal(hash, ctx))
+		return;
+	die("SHA-1 appears to be part of a collision attack: %s",
+	    sha1_to_hex(hash));
+}
+
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
+{
+	const char *data = vdata;
+	/* We expect an unsigned long, but sha1dc only takes an int */
+	while (len > INT_MAX) {
+		SHA1DCUpdate(ctx, data, INT_MAX);
+		data += INT_MAX;
+		len -= INT_MAX;
+	}
+	SHA1DCUpdate(ctx, data, len);
+}
diff --git a/sha1dc_git.h b/sha1dc_git.h
new file mode 100644
index 0000000000..801b5a1fcb
--- /dev/null
+++ b/sha1dc_git.h
@@ -0,0 +1,14 @@
+/*
+ * Same as SHA1DCFinal, but convert collision attack case into a verbose die().
+ */
+void git_SHA1DCFinal(unsigned char [20], SHA1_CTX *);
+
+/*
+ * Same as SHA1DCUpdate, but adjust types to match git's usual interface.
+ */
+void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *data, unsigned long len);
+
+#define platform_SHA_CTX SHA1_CTX
+#define platform_SHA1_Init SHA1DCInit
+#define platform_SHA1_Update git_SHA1DCUpdate
+#define platform_SHA1_Final git_SHA1DCFinal
-- 
2.13.0.303.g4ebf302169

