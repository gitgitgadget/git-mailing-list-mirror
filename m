From: atousa.p@gmail.com
Subject: [PATCH v4 3/3] Move all the SHA1 implementations into one directory
Date: Wed,  4 Nov 2015 22:38:43 -0800
Message-ID: <1446705523-30701-3-git-send-email-apahlevan@ieee.org>
References: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
Cc: Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 08:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEfq-0005wo-A8
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033201AbbKEHGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:06:13 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34755 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032988AbbKEGlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:41:22 -0500
Received: by padhx2 with SMTP id hx2so70024799pad.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 22:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=58M110JDlsjqMIX9TNejUnki9kTgDEYT5cun2cp78mk=;
        b=WwAiVojJDgLPZv8NB3O1F+Ni9V0D91x4+CBxjmjYdXL9/VPbiAH1JWOkrC4vFLKVuB
         qb4jT7HWQKjXPIarwrZyqMB6MNrKED56XgpZS1P8G0JL5b/gCx8C3nPgUvJR7qMNG52X
         sLZp/E2gLjAKsIGE5ZhNvClalitYOH2a9q0gWdanMKSJdADUQOOl2UVBRjca2TsrTw3Z
         aXOrZ0rbKKnfw6KH41OWKAyvoiAvB6JRRQfyXOrI/yJGJWvT8Io+Ti8ht9y+WtJBi5EX
         ZDId404Q+ogtvOfQWXZ1oH831HMWfdxU42SXX2qJgYe6kPs6guOQtl3MQgEXP7U1l3jU
         t9FA==
X-Received: by 10.66.148.67 with SMTP id tq3mr7385515pab.124.1446705682164;
        Wed, 04 Nov 2015 22:41:22 -0800 (PST)
Received: from Atousas-Air.jduprat.net ([50.240.193.13])
        by smtp.gmail.com with ESMTPSA id nu5sm5710601pbb.65.2015.11.04.22.41.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Nov 2015 22:41:21 -0800 (PST)
X-Google-Original-From: apahlevan@ieee.org
X-Mailer: git-send-email 2.4.9 (Apple Git-60)
In-Reply-To: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
In-Reply-To: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
References: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280912>

From: Atousa Pahlevan Duprat <apahlevan@ieee.org>

The various SHA1 implementations were spread around in 3 directories.
This makes it easier to understand what implementations are
available at a glance.

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
---
 Makefile              |  10 +-
 block-sha1/sha1.c     | 251 --------------------------------------------------
 block-sha1/sha1.h     |  22 -----
 cache.h               |   2 +-
 compat/sha1-chunked.c |  19 ----
 compat/sha1-chunked.h |   2 -
 ppc/sha1.c            |  72 ---------------
 ppc/sha1.h            |  25 -----
 ppc/sha1ppc.S         | 224 --------------------------------------------
 sha1/blk-sha1.c       | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1/blk-sha1.h       |  22 +++++
 sha1/chk-sha1.c       |  19 ++++
 sha1/chk-sha1.h       |   2 +
 sha1/ppc-sha1.c       |  72 +++++++++++++++
 sha1/ppc-sha1.h       |  25 +++++
 sha1/ppc-sha1asm.S    | 224 ++++++++++++++++++++++++++++++++++++++++++++
 16 files changed, 621 insertions(+), 621 deletions(-)
 delete mode 100644 block-sha1/sha1.c
 delete mode 100644 block-sha1/sha1.h
 delete mode 100644 compat/sha1-chunked.c
 delete mode 100644 compat/sha1-chunked.h
 delete mode 100644 ppc/sha1.c
 delete mode 100644 ppc/sha1.h
 delete mode 100644 ppc/sha1ppc.S
 create mode 100644 sha1/blk-sha1.c
 create mode 100644 sha1/blk-sha1.h
 create mode 100644 sha1/chk-sha1.c
 create mode 100644 sha1/chk-sha1.h
 create mode 100644 sha1/ppc-sha1.c
 create mode 100644 sha1/ppc-sha1.h
 create mode 100644 sha1/ppc-sha1asm.S

diff --git a/Makefile b/Makefile
index 6a4ca59..94f74d7 100644
--- a/Makefile
+++ b/Makefile
@@ -1345,12 +1345,12 @@ ifdef APPLE_COMMON_CRYPTO
 endif
 
 ifdef BLK_SHA1
-	SHA1_HEADER = "block-sha1/sha1.h"
-	LIB_OBJS += block-sha1/sha1.o
+	SHA1_HEADER = "sha1/blk-sha1.h"
+	LIB_OBJS += sha1/blk-sha1.o
 else
 ifdef PPC_SHA1
-	SHA1_HEADER = "ppc/sha1.h"
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+	SHA1_HEADER = "sha1/ppc-sha1.h"
+	LIB_OBJS += sha1/ppc-sha1.o sha1/ppc-sha1asm.o
 else
 ifdef APPLE_COMMON_CRYPTO
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
@@ -1363,7 +1363,7 @@ endif
 endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
-	LIB_OBJS += compat/sha1-chunked.o
+	LIB_OBJS += sha1/chk-sha1.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
 ifdef NO_PERL_MAKEMAKER
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
deleted file mode 100644
index 22b125c..0000000
--- a/block-sha1/sha1.c
+++ /dev/null
@@ -1,251 +0,0 @@
-/*
- * SHA1 routine optimized to do word accesses rather than byte accesses,
- * and to avoid unnecessary copies into the context array.
- *
- * This was initially based on the Mozilla SHA1 implementation, although
- * none of the original Mozilla code remains.
- */
-
-/* this is only to get definitions for memcpy(), ntohl() and htonl() */
-#include "../git-compat-util.h"
-
-#include "sha1.h"
-
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
-
-/*
- * Force usage of rol or ror by selecting the one with the smaller constant.
- * It _can_ generate slightly smaller code (a constant of 1 is special), but
- * perhaps more importantly it's possibly faster on any uarch that does a
- * rotate with a loop.
- */
-
-#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
-#define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
-#define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
-
-#else
-
-#define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
-#define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
-#define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
-
-#endif
-
-/*
- * If you have 32 registers or more, the compiler can (and should)
- * try to change the array[] accesses into registers. However, on
- * machines with less than ~25 registers, that won't really work,
- * and at least gcc will make an unholy mess of it.
- *
- * So to avoid that mess which just slows things down, we force
- * the stores to memory to actually happen (we might be better off
- * with a 'W(t)=(val);asm("":"+m" (W(t))' there instead, as
- * suggested by Artur Skawina - that will also make gcc unable to
- * try to do the silly "optimize away loads" part because it won't
- * see what the value will be).
- *
- * Ben Herrenschmidt reports that on PPC, the C version comes close
- * to the optimized asm with this (ie on PPC you don't want that
- * 'volatile', since there are lots of registers).
- *
- * On ARM we get the best code generation by forcing a full memory barrier
- * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
- * the stack frame size simply explode and performance goes down the drain.
- */
-
-#if defined(__i386__) || defined(__x86_64__)
-  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
-#elif defined(__GNUC__) && defined(__arm__)
-  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
-#else
-  #define setW(x, val) (W(x) = (val))
-#endif
-
-/* This "rolls" over the 512-bit array */
-#define W(x) (array[(x)&15])
-
-/*
- * Where do we get the source from? The first 16 iterations get it from
- * the input data, the next mix it from the 512-bit array.
- */
-#define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
-#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
-
-#define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
-	unsigned int TEMP = input(t); setW(t, TEMP); \
-	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
-	B = SHA_ROR(B, 2); } while (0)
-
-#define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
-#define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
-#define T_20_39(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1, A, B, C, D, E )
-#define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
-#define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
-
-static void blk_SHA1_Block(blk_SHA_CTX *ctx, const void *block)
-{
-	unsigned int A,B,C,D,E;
-	unsigned int array[16];
-
-	A = ctx->H[0];
-	B = ctx->H[1];
-	C = ctx->H[2];
-	D = ctx->H[3];
-	E = ctx->H[4];
-
-	/* Round 1 - iterations 0-16 take their input from 'block' */
-	T_0_15( 0, A, B, C, D, E);
-	T_0_15( 1, E, A, B, C, D);
-	T_0_15( 2, D, E, A, B, C);
-	T_0_15( 3, C, D, E, A, B);
-	T_0_15( 4, B, C, D, E, A);
-	T_0_15( 5, A, B, C, D, E);
-	T_0_15( 6, E, A, B, C, D);
-	T_0_15( 7, D, E, A, B, C);
-	T_0_15( 8, C, D, E, A, B);
-	T_0_15( 9, B, C, D, E, A);
-	T_0_15(10, A, B, C, D, E);
-	T_0_15(11, E, A, B, C, D);
-	T_0_15(12, D, E, A, B, C);
-	T_0_15(13, C, D, E, A, B);
-	T_0_15(14, B, C, D, E, A);
-	T_0_15(15, A, B, C, D, E);
-
-	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16, E, A, B, C, D);
-	T_16_19(17, D, E, A, B, C);
-	T_16_19(18, C, D, E, A, B);
-	T_16_19(19, B, C, D, E, A);
-
-	/* Round 2 */
-	T_20_39(20, A, B, C, D, E);
-	T_20_39(21, E, A, B, C, D);
-	T_20_39(22, D, E, A, B, C);
-	T_20_39(23, C, D, E, A, B);
-	T_20_39(24, B, C, D, E, A);
-	T_20_39(25, A, B, C, D, E);
-	T_20_39(26, E, A, B, C, D);
-	T_20_39(27, D, E, A, B, C);
-	T_20_39(28, C, D, E, A, B);
-	T_20_39(29, B, C, D, E, A);
-	T_20_39(30, A, B, C, D, E);
-	T_20_39(31, E, A, B, C, D);
-	T_20_39(32, D, E, A, B, C);
-	T_20_39(33, C, D, E, A, B);
-	T_20_39(34, B, C, D, E, A);
-	T_20_39(35, A, B, C, D, E);
-	T_20_39(36, E, A, B, C, D);
-	T_20_39(37, D, E, A, B, C);
-	T_20_39(38, C, D, E, A, B);
-	T_20_39(39, B, C, D, E, A);
-
-	/* Round 3 */
-	T_40_59(40, A, B, C, D, E);
-	T_40_59(41, E, A, B, C, D);
-	T_40_59(42, D, E, A, B, C);
-	T_40_59(43, C, D, E, A, B);
-	T_40_59(44, B, C, D, E, A);
-	T_40_59(45, A, B, C, D, E);
-	T_40_59(46, E, A, B, C, D);
-	T_40_59(47, D, E, A, B, C);
-	T_40_59(48, C, D, E, A, B);
-	T_40_59(49, B, C, D, E, A);
-	T_40_59(50, A, B, C, D, E);
-	T_40_59(51, E, A, B, C, D);
-	T_40_59(52, D, E, A, B, C);
-	T_40_59(53, C, D, E, A, B);
-	T_40_59(54, B, C, D, E, A);
-	T_40_59(55, A, B, C, D, E);
-	T_40_59(56, E, A, B, C, D);
-	T_40_59(57, D, E, A, B, C);
-	T_40_59(58, C, D, E, A, B);
-	T_40_59(59, B, C, D, E, A);
-
-	/* Round 4 */
-	T_60_79(60, A, B, C, D, E);
-	T_60_79(61, E, A, B, C, D);
-	T_60_79(62, D, E, A, B, C);
-	T_60_79(63, C, D, E, A, B);
-	T_60_79(64, B, C, D, E, A);
-	T_60_79(65, A, B, C, D, E);
-	T_60_79(66, E, A, B, C, D);
-	T_60_79(67, D, E, A, B, C);
-	T_60_79(68, C, D, E, A, B);
-	T_60_79(69, B, C, D, E, A);
-	T_60_79(70, A, B, C, D, E);
-	T_60_79(71, E, A, B, C, D);
-	T_60_79(72, D, E, A, B, C);
-	T_60_79(73, C, D, E, A, B);
-	T_60_79(74, B, C, D, E, A);
-	T_60_79(75, A, B, C, D, E);
-	T_60_79(76, E, A, B, C, D);
-	T_60_79(77, D, E, A, B, C);
-	T_60_79(78, C, D, E, A, B);
-	T_60_79(79, B, C, D, E, A);
-
-	ctx->H[0] += A;
-	ctx->H[1] += B;
-	ctx->H[2] += C;
-	ctx->H[3] += D;
-	ctx->H[4] += E;
-}
-
-void blk_SHA1_Init(blk_SHA_CTX *ctx)
-{
-	ctx->size = 0;
-
-	/* Initialize H with the magic constants (see FIPS180 for constants) */
-	ctx->H[0] = 0x67452301;
-	ctx->H[1] = 0xefcdab89;
-	ctx->H[2] = 0x98badcfe;
-	ctx->H[3] = 0x10325476;
-	ctx->H[4] = 0xc3d2e1f0;
-}
-
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
-{
-	unsigned int lenW = ctx->size & 63;
-
-	ctx->size += len;
-
-	/* Read the data into W and process blocks as they get full */
-	if (lenW) {
-		unsigned int left = 64 - lenW;
-		if (len < left)
-			left = len;
-		memcpy(lenW + (char *)ctx->W, data, left);
-		lenW = (lenW + left) & 63;
-		len -= left;
-		data = ((const char *)data + left);
-		if (lenW)
-			return;
-		blk_SHA1_Block(ctx, ctx->W);
-	}
-	while (len >= 64) {
-		blk_SHA1_Block(ctx, data);
-		data = ((const char *)data + 64);
-		len -= 64;
-	}
-	if (len)
-		memcpy(ctx->W, data, len);
-}
-
-void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
-{
-	static const unsigned char pad[64] = { 0x80 };
-	unsigned int padlen[2];
-	int i;
-
-	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
-	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
-	padlen[1] = htonl((uint32_t)(ctx->size << 3));
-
-	i = ctx->size & 63;
-	blk_SHA1_Update(ctx, pad, 1 + (63 & (55 - i)));
-	blk_SHA1_Update(ctx, padlen, 8);
-
-	/* Output hash */
-	for (i = 0; i < 5; i++)
-		put_be32(hashout + i * 4, ctx->H[i]);
-}
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
deleted file mode 100644
index b864df6..0000000
--- a/block-sha1/sha1.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * SHA1 routine optimized to do word accesses rather than byte accesses,
- * and to avoid unnecessary copies into the context array.
- *
- * This was initially based on the Mozilla SHA1 implementation, although
- * none of the original Mozilla code remains.
- */
-
-typedef struct {
-	unsigned long long size;
-	unsigned int H[5];
-	unsigned int W[16];
-} blk_SHA_CTX;
-
-void blk_SHA1_Init(blk_SHA_CTX *ctx);
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
-void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
-
-#define git_SHA_CTX	blk_SHA_CTX
-#define git_SHA1_Init	blk_SHA1_Init
-#define git_SHA1_Update	blk_SHA1_Update
-#define git_SHA1_Final	blk_SHA1_Final
diff --git a/cache.h b/cache.h
index 182ac62..961da4e 100644
--- a/cache.h
+++ b/cache.h
@@ -28,7 +28,7 @@
 #ifndef git_SHA_CTX
 
 #ifdef SHA1_MAX_BLOCK_SIZE
-#include "compat/sha1-chunked.h"
+#include "sha1/chk-sha1.h"
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		git_SHA1_Update_Chunked
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
deleted file mode 100644
index 6adfcfd..0000000
--- a/compat/sha1-chunked.c
+++ /dev/null
@@ -1,19 +0,0 @@
-#include "cache.h"
-
-int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
-{
-	size_t nr;
-	size_t total = 0;
-	const char *cdata = (const char*)data;
-
-	while (len) {
-		nr = len;
-		if (nr > SHA1_MAX_BLOCK_SIZE)
-			nr = SHA1_MAX_BLOCK_SIZE;
-		platform_SHA1_Update(c, cdata, nr);
-		total += nr;
-		cdata += nr;
-		len -= nr;
-	}
-	return total;
-}
diff --git a/compat/sha1-chunked.h b/compat/sha1-chunked.h
deleted file mode 100644
index 7b2df28..0000000
--- a/compat/sha1-chunked.h
+++ /dev/null
@@ -1,2 +0,0 @@
-
-int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len);
diff --git a/ppc/sha1.c b/ppc/sha1.c
deleted file mode 100644
index ec6a192..0000000
--- a/ppc/sha1.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- *
- * This version assumes we are running on a big-endian machine.
- * It calls an external sha1_core() to process blocks of 64 bytes.
- */
-#include <stdio.h>
-#include <string.h>
-#include "sha1.h"
-
-extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
-			  unsigned int nblocks);
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c)
-{
-	c->hash[0] = 0x67452301;
-	c->hash[1] = 0xEFCDAB89;
-	c->hash[2] = 0x98BADCFE;
-	c->hash[3] = 0x10325476;
-	c->hash[4] = 0xC3D2E1F0;
-	c->len = 0;
-	c->cnt = 0;
-	return 0;
-}
-
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
-{
-	unsigned long nb;
-	const unsigned char *p = ptr;
-
-	c->len += (uint64_t) n << 3;
-	while (n != 0) {
-		if (c->cnt || n < 64) {
-			nb = 64 - c->cnt;
-			if (nb > n)
-				nb = n;
-			memcpy(&c->buf.b[c->cnt], p, nb);
-			if ((c->cnt += nb) == 64) {
-				ppc_sha1_core(c->hash, c->buf.b, 1);
-				c->cnt = 0;
-			}
-		} else {
-			nb = n >> 6;
-			ppc_sha1_core(c->hash, p, nb);
-			nb <<= 6;
-		}
-		n -= nb;
-		p += nb;
-	}
-	return 0;
-}
-
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
-{
-	unsigned int cnt = c->cnt;
-
-	c->buf.b[cnt++] = 0x80;
-	if (cnt > 56) {
-		if (cnt < 64)
-			memset(&c->buf.b[cnt], 0, 64 - cnt);
-		ppc_sha1_core(c->hash, c->buf.b, 1);
-		cnt = 0;
-	}
-	if (cnt < 56)
-		memset(&c->buf.b[cnt], 0, 56 - cnt);
-	c->buf.l[7] = c->len;
-	ppc_sha1_core(c->hash, c->buf.b, 1);
-	memcpy(hash, c->hash, 20);
-	return 0;
-}
diff --git a/ppc/sha1.h b/ppc/sha1.h
deleted file mode 100644
index c405f73..0000000
--- a/ppc/sha1.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-#include <stdint.h>
-
-typedef struct {
-	uint32_t hash[5];
-	uint32_t cnt;
-	uint64_t len;
-	union {
-		unsigned char b[64];
-		uint64_t l[8];
-	} buf;
-} ppc_SHA_CTX;
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c);
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
-
-#define git_SHA_CTX	ppc_SHA_CTX
-#define git_SHA1_Init	ppc_SHA1_Init
-#define git_SHA1_Update	ppc_SHA1_Update
-#define git_SHA1_Final	ppc_SHA1_Final
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
deleted file mode 100644
index 1711eef..0000000
--- a/ppc/sha1ppc.S
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- * SHA-1 implementation for PowerPC.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-
-/*
- * PowerPC calling convention:
- * %r0 - volatile temp
- * %r1 - stack pointer.
- * %r2 - reserved
- * %r3-%r12 - Incoming arguments & return values; volatile.
- * %r13-%r31 - Callee-save registers
- * %lr - Return address, volatile
- * %ctr - volatile
- *
- * Register usage in this routine:
- * %r0 - temp
- * %r3 - argument (pointer to 5 words of SHA state)
- * %r4 - argument (pointer to data to hash)
- * %r5 - Constant K in SHA round (initially number of blocks to hash)
- * %r6-%r10 - Working copies of SHA variables A..E (actually E..A order)
- * %r11-%r26 - Data being hashed W[].
- * %r27-%r31 - Previous copies of A..E, for final add back.
- * %ctr - loop count
- */
-
-
-/*
- * We roll the registers for A, B, C, D, E around on each
- * iteration; E on iteration t is D on iteration t+1, and so on.
- * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
- * the previous values.)
- */
-#define RA(t)	(((t)+4)%5+6)
-#define RB(t)	(((t)+3)%5+6)
-#define RC(t)	(((t)+2)%5+6)
-#define RD(t)	(((t)+1)%5+6)
-#define RE(t)	(((t)+0)%5+6)
-
-/* We use registers 11 - 26 for the W values */
-#define W(t)	((t)%16+11)
-
-/* Register 5 is used for the constant k */
-
-/*
- * The basic SHA-1 round function is:
- * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
- * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
- *
- * Every 20 rounds, the function F() and the constant K changes:
- * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
- * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
- * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
- * - 20 more rounds of f1(b,c,d)
- *
- * These are all scheduled for near-optimal performance on a G4.
- * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
- * *consider* starting the oldest 3 instructions per cycle.  So to get
- * maximum performance out of it, you have to treat it as an in-order
- * machine.  Which means interleaving the computation round t with the
- * computation of W[t+4].
- *
- * The first 16 rounds use W values loaded directly from memory, while the
- * remaining 64 use values computed from those first 16.  We preload
- * 4 values before starting, so there are three kinds of rounds:
- * - The first 12 (all f0) also load the W values from memory.
- * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
- * - The last 4 (all f1) do not do anything with W.
- *
- * Therefore, we have 6 different round functions:
- * STEPD0_LOAD(t,s) - Perform round t and load W(s).  s < 16
- * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
- * STEPD1_UPDATE(t,s)
- * STEPD2_UPDATE(t,s)
- * STEPD1(t) - Perform round t with no load or update.
- *
- * The G5 is more fully out-of-order, and can find the parallelism
- * by itself.  The big limit is that it has a 2-cycle ALU latency, so
- * even though it's 2-way, the code has to be scheduled as if it's
- * 4-way, which can be a limit.  To help it, we try to schedule the
- * read of RA(t) as late as possible so it doesn't stall waiting for
- * the previous round's RE(t-1), and we try to rotate RB(t) as early
- * as possible while reading RC(t) (= RB(t-1)) as late as possible.
- */
-
-/* the initial loads. */
-#define LOADW(s) \
-	lwz	W(s),(s)*4(%r4)
-
-/*
- * Perform a step with F0, and load W(s).  Uses W(s) as a temporary
- * before loading it.
- * This is actually 10 instructions, which is an awkward fit.
- * It can execute grouped as listed, or delayed one instruction.
- * (If delayed two instructions, there is a stall before the start of the
- * second line.)  Thus, two iterations take 7 cycles, 3.5 cycles per round.
- */
-#define STEPD0_LOAD(t,s) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  and    W(s),RC(t),RB(t); \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;      rotlwi RB(t),RB(t),30;   \
-add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      lwz    W(s),(s)*4(%r4);  \
-add RE(t),RE(t),%r0
-
-/*
- * This is likewise awkward, 13 instructions.  However, it can also
- * execute starting with 2 out of 3 possible moduli, so it does 2 rounds
- * in 9 cycles, 4.5 cycles/round.
- */
-#define STEPD0_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r5;  loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
-add RE(t),RE(t),%r0
-
-/* Nicely optimal.  Conveniently, also the most common. */
-#define STEPD1_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r5;  loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1
-
-/*
- * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
- * We could use W(s) as a temp register, but we don't need it.
- */
-#define STEPD1(t) \
-                        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
-rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
-add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* spare slot */        \
-add    RE(t),RE(t),%r0
-
-/*
- * 14 instructions, 5 cycles per.  The majority function is a bit
- * awkward to compute.  This can execute with a 1-instruction delay,
- * but it causes a 2-instruction delay, which triggers a stall.
- */
-#define STEPD2_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r5;  loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
-
-#define STEP0_LOAD4(t,s)		\
-	STEPD0_LOAD(t,s);		\
-	STEPD0_LOAD((t+1),(s)+1);	\
-	STEPD0_LOAD((t)+2,(s)+2);	\
-	STEPD0_LOAD((t)+3,(s)+3)
-
-#define STEPUP4(fn, t, s, loadk...)		\
-	STEP##fn##_UPDATE(t,s,);		\
-	STEP##fn##_UPDATE((t)+1,(s)+1,);	\
-	STEP##fn##_UPDATE((t)+2,(s)+2,);	\
-	STEP##fn##_UPDATE((t)+3,(s)+3,loadk)
-
-#define STEPUP20(fn, t, s, loadk...)	\
-	STEPUP4(fn, t, s,);		\
-	STEPUP4(fn, (t)+4, (s)+4,);	\
-	STEPUP4(fn, (t)+8, (s)+8,);	\
-	STEPUP4(fn, (t)+12, (s)+12,);	\
-	STEPUP4(fn, (t)+16, (s)+16, loadk)
-
-	.globl	ppc_sha1_core
-ppc_sha1_core:
-	stwu	%r1,-80(%r1)
-	stmw	%r13,4(%r1)
-
-	/* Load up A - E */
-	lmw	%r27,0(%r3)
-
-	mtctr	%r5
-
-1:
-	LOADW(0)
-	lis	%r5,0x5a82
-	mr	RE(0),%r31
-	LOADW(1)
-	mr	RD(0),%r30
-	mr	RC(0),%r29
-	LOADW(2)
-	ori	%r5,%r5,0x7999	/* K0-19 */
-	mr	RB(0),%r28
-	LOADW(3)
-	mr	RA(0),%r27
-
-	STEP0_LOAD4(0, 4)
-	STEP0_LOAD4(4, 8)
-	STEP0_LOAD4(8, 12)
-	STEPUP4(D0, 12, 16,)
-	STEPUP4(D0, 16, 20, lis %r5,0x6ed9)
-
-	ori	%r5,%r5,0xeba1	/* K20-39 */
-	STEPUP20(D1, 20, 24, lis %r5,0x8f1b)
-
-	ori	%r5,%r5,0xbcdc	/* K40-59 */
-	STEPUP20(D2, 40, 44, lis %r5,0xca62)
-
-	ori	%r5,%r5,0xc1d6	/* K60-79 */
-	STEPUP4(D1, 60, 64,)
-	STEPUP4(D1, 64, 68,)
-	STEPUP4(D1, 68, 72,)
-	STEPUP4(D1, 72, 76,)
-	addi	%r4,%r4,64
-	STEPD1(76)
-	STEPD1(77)
-	STEPD1(78)
-	STEPD1(79)
-
-	/* Add results to original values */
-	add	%r31,%r31,RE(0)
-	add	%r30,%r30,RD(0)
-	add	%r29,%r29,RC(0)
-	add	%r28,%r28,RB(0)
-	add	%r27,%r27,RA(0)
-
-	bdnz	1b
-
-	/* Save final hash, restore registers, and return */
-	stmw	%r27,0(%r3)
-	lmw	%r13,4(%r1)
-	addi	%r1,%r1,80
-	blr
diff --git a/sha1/blk-sha1.c b/sha1/blk-sha1.c
new file mode 100644
index 0000000..abacf05
--- /dev/null
+++ b/sha1/blk-sha1.c
@@ -0,0 +1,251 @@
+/*
+ * SHA1 routine optimized to do word accesses rather than byte accesses,
+ * and to avoid unnecessary copies into the context array.
+ *
+ * This was initially based on the Mozilla SHA1 implementation, although
+ * none of the original Mozilla code remains.
+ */
+
+/* this is only to get definitions for memcpy(), ntohl() and htonl() */
+#include "../git-compat-util.h"
+
+#include "blk-sha1.h"
+
+#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
+
+/*
+ * Force usage of rol or ror by selecting the one with the smaller constant.
+ * It _can_ generate slightly smaller code (a constant of 1 is special), but
+ * perhaps more importantly it's possibly faster on any uarch that does a
+ * rotate with a loop.
+ */
+
+#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
+#define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
+#define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
+
+#else
+
+#define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
+#define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
+#define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
+
+#endif
+
+/*
+ * If you have 32 registers or more, the compiler can (and should)
+ * try to change the array[] accesses into registers. However, on
+ * machines with less than ~25 registers, that won't really work,
+ * and at least gcc will make an unholy mess of it.
+ *
+ * So to avoid that mess which just slows things down, we force
+ * the stores to memory to actually happen (we might be better off
+ * with a 'W(t)=(val);asm("":"+m" (W(t))' there instead, as
+ * suggested by Artur Skawina - that will also make gcc unable to
+ * try to do the silly "optimize away loads" part because it won't
+ * see what the value will be).
+ *
+ * Ben Herrenschmidt reports that on PPC, the C version comes close
+ * to the optimized asm with this (ie on PPC you don't want that
+ * 'volatile', since there are lots of registers).
+ *
+ * On ARM we get the best code generation by forcing a full memory barrier
+ * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
+ * the stack frame size simply explode and performance goes down the drain.
+ */
+
+#if defined(__i386__) || defined(__x86_64__)
+  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
+#elif defined(__GNUC__) && defined(__arm__)
+  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
+#else
+  #define setW(x, val) (W(x) = (val))
+#endif
+
+/* This "rolls" over the 512-bit array */
+#define W(x) (array[(x)&15])
+
+/*
+ * Where do we get the source from? The first 16 iterations get it from
+ * the input data, the next mix it from the 512-bit array.
+ */
+#define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
+#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
+
+#define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
+	unsigned int TEMP = input(t); setW(t, TEMP); \
+	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
+	B = SHA_ROR(B, 2); } while (0)
+
+#define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
+#define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
+#define T_20_39(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1, A, B, C, D, E )
+#define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
+#define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
+
+static void blk_SHA1_Block(blk_SHA_CTX *ctx, const void *block)
+{
+	unsigned int A,B,C,D,E;
+	unsigned int array[16];
+
+	A = ctx->H[0];
+	B = ctx->H[1];
+	C = ctx->H[2];
+	D = ctx->H[3];
+	E = ctx->H[4];
+
+	/* Round 1 - iterations 0-16 take their input from 'block' */
+	T_0_15( 0, A, B, C, D, E);
+	T_0_15( 1, E, A, B, C, D);
+	T_0_15( 2, D, E, A, B, C);
+	T_0_15( 3, C, D, E, A, B);
+	T_0_15( 4, B, C, D, E, A);
+	T_0_15( 5, A, B, C, D, E);
+	T_0_15( 6, E, A, B, C, D);
+	T_0_15( 7, D, E, A, B, C);
+	T_0_15( 8, C, D, E, A, B);
+	T_0_15( 9, B, C, D, E, A);
+	T_0_15(10, A, B, C, D, E);
+	T_0_15(11, E, A, B, C, D);
+	T_0_15(12, D, E, A, B, C);
+	T_0_15(13, C, D, E, A, B);
+	T_0_15(14, B, C, D, E, A);
+	T_0_15(15, A, B, C, D, E);
+
+	/* Round 1 - tail. Input from 512-bit mixing array */
+	T_16_19(16, E, A, B, C, D);
+	T_16_19(17, D, E, A, B, C);
+	T_16_19(18, C, D, E, A, B);
+	T_16_19(19, B, C, D, E, A);
+
+	/* Round 2 */
+	T_20_39(20, A, B, C, D, E);
+	T_20_39(21, E, A, B, C, D);
+	T_20_39(22, D, E, A, B, C);
+	T_20_39(23, C, D, E, A, B);
+	T_20_39(24, B, C, D, E, A);
+	T_20_39(25, A, B, C, D, E);
+	T_20_39(26, E, A, B, C, D);
+	T_20_39(27, D, E, A, B, C);
+	T_20_39(28, C, D, E, A, B);
+	T_20_39(29, B, C, D, E, A);
+	T_20_39(30, A, B, C, D, E);
+	T_20_39(31, E, A, B, C, D);
+	T_20_39(32, D, E, A, B, C);
+	T_20_39(33, C, D, E, A, B);
+	T_20_39(34, B, C, D, E, A);
+	T_20_39(35, A, B, C, D, E);
+	T_20_39(36, E, A, B, C, D);
+	T_20_39(37, D, E, A, B, C);
+	T_20_39(38, C, D, E, A, B);
+	T_20_39(39, B, C, D, E, A);
+
+	/* Round 3 */
+	T_40_59(40, A, B, C, D, E);
+	T_40_59(41, E, A, B, C, D);
+	T_40_59(42, D, E, A, B, C);
+	T_40_59(43, C, D, E, A, B);
+	T_40_59(44, B, C, D, E, A);
+	T_40_59(45, A, B, C, D, E);
+	T_40_59(46, E, A, B, C, D);
+	T_40_59(47, D, E, A, B, C);
+	T_40_59(48, C, D, E, A, B);
+	T_40_59(49, B, C, D, E, A);
+	T_40_59(50, A, B, C, D, E);
+	T_40_59(51, E, A, B, C, D);
+	T_40_59(52, D, E, A, B, C);
+	T_40_59(53, C, D, E, A, B);
+	T_40_59(54, B, C, D, E, A);
+	T_40_59(55, A, B, C, D, E);
+	T_40_59(56, E, A, B, C, D);
+	T_40_59(57, D, E, A, B, C);
+	T_40_59(58, C, D, E, A, B);
+	T_40_59(59, B, C, D, E, A);
+
+	/* Round 4 */
+	T_60_79(60, A, B, C, D, E);
+	T_60_79(61, E, A, B, C, D);
+	T_60_79(62, D, E, A, B, C);
+	T_60_79(63, C, D, E, A, B);
+	T_60_79(64, B, C, D, E, A);
+	T_60_79(65, A, B, C, D, E);
+	T_60_79(66, E, A, B, C, D);
+	T_60_79(67, D, E, A, B, C);
+	T_60_79(68, C, D, E, A, B);
+	T_60_79(69, B, C, D, E, A);
+	T_60_79(70, A, B, C, D, E);
+	T_60_79(71, E, A, B, C, D);
+	T_60_79(72, D, E, A, B, C);
+	T_60_79(73, C, D, E, A, B);
+	T_60_79(74, B, C, D, E, A);
+	T_60_79(75, A, B, C, D, E);
+	T_60_79(76, E, A, B, C, D);
+	T_60_79(77, D, E, A, B, C);
+	T_60_79(78, C, D, E, A, B);
+	T_60_79(79, B, C, D, E, A);
+
+	ctx->H[0] += A;
+	ctx->H[1] += B;
+	ctx->H[2] += C;
+	ctx->H[3] += D;
+	ctx->H[4] += E;
+}
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx)
+{
+	ctx->size = 0;
+
+	/* Initialize H with the magic constants (see FIPS180 for constants) */
+	ctx->H[0] = 0x67452301;
+	ctx->H[1] = 0xefcdab89;
+	ctx->H[2] = 0x98badcfe;
+	ctx->H[3] = 0x10325476;
+	ctx->H[4] = 0xc3d2e1f0;
+}
+
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
+{
+	unsigned int lenW = ctx->size & 63;
+
+	ctx->size += len;
+
+	/* Read the data into W and process blocks as they get full */
+	if (lenW) {
+		unsigned int left = 64 - lenW;
+		if (len < left)
+			left = len;
+		memcpy(lenW + (char *)ctx->W, data, left);
+		lenW = (lenW + left) & 63;
+		len -= left;
+		data = ((const char *)data + left);
+		if (lenW)
+			return;
+		blk_SHA1_Block(ctx, ctx->W);
+	}
+	while (len >= 64) {
+		blk_SHA1_Block(ctx, data);
+		data = ((const char *)data + 64);
+		len -= 64;
+	}
+	if (len)
+		memcpy(ctx->W, data, len);
+}
+
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
+{
+	static const unsigned char pad[64] = { 0x80 };
+	unsigned int padlen[2];
+	int i;
+
+	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
+	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
+	padlen[1] = htonl((uint32_t)(ctx->size << 3));
+
+	i = ctx->size & 63;
+	blk_SHA1_Update(ctx, pad, 1 + (63 & (55 - i)));
+	blk_SHA1_Update(ctx, padlen, 8);
+
+	/* Output hash */
+	for (i = 0; i < 5; i++)
+		put_be32(hashout + i * 4, ctx->H[i]);
+}
diff --git a/sha1/blk-sha1.h b/sha1/blk-sha1.h
new file mode 100644
index 0000000..b864df6
--- /dev/null
+++ b/sha1/blk-sha1.h
@@ -0,0 +1,22 @@
+/*
+ * SHA1 routine optimized to do word accesses rather than byte accesses,
+ * and to avoid unnecessary copies into the context array.
+ *
+ * This was initially based on the Mozilla SHA1 implementation, although
+ * none of the original Mozilla code remains.
+ */
+
+typedef struct {
+	unsigned long long size;
+	unsigned int H[5];
+	unsigned int W[16];
+} blk_SHA_CTX;
+
+void blk_SHA1_Init(blk_SHA_CTX *ctx);
+void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
+void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
+
+#define git_SHA_CTX	blk_SHA_CTX
+#define git_SHA1_Init	blk_SHA1_Init
+#define git_SHA1_Update	blk_SHA1_Update
+#define git_SHA1_Final	blk_SHA1_Final
diff --git a/sha1/chk-sha1.c b/sha1/chk-sha1.c
new file mode 100644
index 0000000..6adfcfd
--- /dev/null
+++ b/sha1/chk-sha1.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
+{
+	size_t nr;
+	size_t total = 0;
+	const char *cdata = (const char*)data;
+
+	while (len) {
+		nr = len;
+		if (nr > SHA1_MAX_BLOCK_SIZE)
+			nr = SHA1_MAX_BLOCK_SIZE;
+		platform_SHA1_Update(c, cdata, nr);
+		total += nr;
+		cdata += nr;
+		len -= nr;
+	}
+	return total;
+}
diff --git a/sha1/chk-sha1.h b/sha1/chk-sha1.h
new file mode 100644
index 0000000..7b2df28
--- /dev/null
+++ b/sha1/chk-sha1.h
@@ -0,0 +1,2 @@
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len);
diff --git a/sha1/ppc-sha1.c b/sha1/ppc-sha1.c
new file mode 100644
index 0000000..2ca9a5a
--- /dev/null
+++ b/sha1/ppc-sha1.c
@@ -0,0 +1,72 @@
+/*
+ * SHA-1 implementation.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ *
+ * This version assumes we are running on a big-endian machine.
+ * It calls an external sha1_core() to process blocks of 64 bytes.
+ */
+#include <stdio.h>
+#include <string.h>
+#include "ppc-sha1.h"
+
+extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
+			  unsigned int nblocks);
+
+int ppc_SHA1_Init(ppc_SHA_CTX *c)
+{
+	c->hash[0] = 0x67452301;
+	c->hash[1] = 0xEFCDAB89;
+	c->hash[2] = 0x98BADCFE;
+	c->hash[3] = 0x10325476;
+	c->hash[4] = 0xC3D2E1F0;
+	c->len = 0;
+	c->cnt = 0;
+	return 0;
+}
+
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
+{
+	unsigned long nb;
+	const unsigned char *p = ptr;
+
+	c->len += (uint64_t) n << 3;
+	while (n != 0) {
+		if (c->cnt || n < 64) {
+			nb = 64 - c->cnt;
+			if (nb > n)
+				nb = n;
+			memcpy(&c->buf.b[c->cnt], p, nb);
+			if ((c->cnt += nb) == 64) {
+				ppc_sha1_core(c->hash, c->buf.b, 1);
+				c->cnt = 0;
+			}
+		} else {
+			nb = n >> 6;
+			ppc_sha1_core(c->hash, p, nb);
+			nb <<= 6;
+		}
+		n -= nb;
+		p += nb;
+	}
+	return 0;
+}
+
+int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
+{
+	unsigned int cnt = c->cnt;
+
+	c->buf.b[cnt++] = 0x80;
+	if (cnt > 56) {
+		if (cnt < 64)
+			memset(&c->buf.b[cnt], 0, 64 - cnt);
+		ppc_sha1_core(c->hash, c->buf.b, 1);
+		cnt = 0;
+	}
+	if (cnt < 56)
+		memset(&c->buf.b[cnt], 0, 56 - cnt);
+	c->buf.l[7] = c->len;
+	ppc_sha1_core(c->hash, c->buf.b, 1);
+	memcpy(hash, c->hash, 20);
+	return 0;
+}
diff --git a/sha1/ppc-sha1.h b/sha1/ppc-sha1.h
new file mode 100644
index 0000000..c405f73
--- /dev/null
+++ b/sha1/ppc-sha1.h
@@ -0,0 +1,25 @@
+/*
+ * SHA-1 implementation.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ */
+#include <stdint.h>
+
+typedef struct {
+	uint32_t hash[5];
+	uint32_t cnt;
+	uint64_t len;
+	union {
+		unsigned char b[64];
+		uint64_t l[8];
+	} buf;
+} ppc_SHA_CTX;
+
+int ppc_SHA1_Init(ppc_SHA_CTX *c);
+int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
+int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
+
+#define git_SHA_CTX	ppc_SHA_CTX
+#define git_SHA1_Init	ppc_SHA1_Init
+#define git_SHA1_Update	ppc_SHA1_Update
+#define git_SHA1_Final	ppc_SHA1_Final
diff --git a/sha1/ppc-sha1asm.S b/sha1/ppc-sha1asm.S
new file mode 100644
index 0000000..1711eef
--- /dev/null
+++ b/sha1/ppc-sha1asm.S
@@ -0,0 +1,224 @@
+/*
+ * SHA-1 implementation for PowerPC.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ */
+
+/*
+ * PowerPC calling convention:
+ * %r0 - volatile temp
+ * %r1 - stack pointer.
+ * %r2 - reserved
+ * %r3-%r12 - Incoming arguments & return values; volatile.
+ * %r13-%r31 - Callee-save registers
+ * %lr - Return address, volatile
+ * %ctr - volatile
+ *
+ * Register usage in this routine:
+ * %r0 - temp
+ * %r3 - argument (pointer to 5 words of SHA state)
+ * %r4 - argument (pointer to data to hash)
+ * %r5 - Constant K in SHA round (initially number of blocks to hash)
+ * %r6-%r10 - Working copies of SHA variables A..E (actually E..A order)
+ * %r11-%r26 - Data being hashed W[].
+ * %r27-%r31 - Previous copies of A..E, for final add back.
+ * %ctr - loop count
+ */
+
+
+/*
+ * We roll the registers for A, B, C, D, E around on each
+ * iteration; E on iteration t is D on iteration t+1, and so on.
+ * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
+ * the previous values.)
+ */
+#define RA(t)	(((t)+4)%5+6)
+#define RB(t)	(((t)+3)%5+6)
+#define RC(t)	(((t)+2)%5+6)
+#define RD(t)	(((t)+1)%5+6)
+#define RE(t)	(((t)+0)%5+6)
+
+/* We use registers 11 - 26 for the W values */
+#define W(t)	((t)%16+11)
+
+/* Register 5 is used for the constant k */
+
+/*
+ * The basic SHA-1 round function is:
+ * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
+ * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
+ *
+ * Every 20 rounds, the function F() and the constant K changes:
+ * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
+ * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
+ * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
+ * - 20 more rounds of f1(b,c,d)
+ *
+ * These are all scheduled for near-optimal performance on a G4.
+ * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
+ * *consider* starting the oldest 3 instructions per cycle.  So to get
+ * maximum performance out of it, you have to treat it as an in-order
+ * machine.  Which means interleaving the computation round t with the
+ * computation of W[t+4].
+ *
+ * The first 16 rounds use W values loaded directly from memory, while the
+ * remaining 64 use values computed from those first 16.  We preload
+ * 4 values before starting, so there are three kinds of rounds:
+ * - The first 12 (all f0) also load the W values from memory.
+ * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
+ * - The last 4 (all f1) do not do anything with W.
+ *
+ * Therefore, we have 6 different round functions:
+ * STEPD0_LOAD(t,s) - Perform round t and load W(s).  s < 16
+ * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
+ * STEPD1_UPDATE(t,s)
+ * STEPD2_UPDATE(t,s)
+ * STEPD1(t) - Perform round t with no load or update.
+ *
+ * The G5 is more fully out-of-order, and can find the parallelism
+ * by itself.  The big limit is that it has a 2-cycle ALU latency, so
+ * even though it's 2-way, the code has to be scheduled as if it's
+ * 4-way, which can be a limit.  To help it, we try to schedule the
+ * read of RA(t) as late as possible so it doesn't stall waiting for
+ * the previous round's RE(t-1), and we try to rotate RB(t) as early
+ * as possible while reading RC(t) (= RB(t-1)) as late as possible.
+ */
+
+/* the initial loads. */
+#define LOADW(s) \
+	lwz	W(s),(s)*4(%r4)
+
+/*
+ * Perform a step with F0, and load W(s).  Uses W(s) as a temporary
+ * before loading it.
+ * This is actually 10 instructions, which is an awkward fit.
+ * It can execute grouped as listed, or delayed one instruction.
+ * (If delayed two instructions, there is a stall before the start of the
+ * second line.)  Thus, two iterations take 7 cycles, 3.5 cycles per round.
+ */
+#define STEPD0_LOAD(t,s) \
+add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  and    W(s),RC(t),RB(t); \
+add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;      rotlwi RB(t),RB(t),30;   \
+add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      lwz    W(s),(s)*4(%r4);  \
+add RE(t),RE(t),%r0
+
+/*
+ * This is likewise awkward, 13 instructions.  However, it can also
+ * execute starting with 2 out of 3 possible moduli, so it does 2 rounds
+ * in 9 cycles, 4.5 cycles/round.
+ */
+#define STEPD0_UPDATE(t,s,loadk...) \
+add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
+add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
+add RE(t),RE(t),%r5;  loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
+add RE(t),RE(t),%r0
+
+/* Nicely optimal.  Conveniently, also the most common. */
+#define STEPD1_UPDATE(t,s,loadk...) \
+add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),%r5;  loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
+add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
+add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1
+
+/*
+ * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
+ * We could use W(s) as a temp register, but we don't need it.
+ */
+#define STEPD1(t) \
+                        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
+rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
+add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* spare slot */        \
+add    RE(t),RE(t),%r0
+
+/*
+ * 14 instructions, 5 cycles per.  The majority function is a bit
+ * awkward to compute.  This can execute with a 1-instruction delay,
+ * but it causes a 2-instruction delay, which triggers a stall.
+ */
+#define STEPD2_UPDATE(t,s,loadk...) \
+add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
+add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
+add RE(t),RE(t),%r5;  loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
+add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
+add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
+
+#define STEP0_LOAD4(t,s)		\
+	STEPD0_LOAD(t,s);		\
+	STEPD0_LOAD((t+1),(s)+1);	\
+	STEPD0_LOAD((t)+2,(s)+2);	\
+	STEPD0_LOAD((t)+3,(s)+3)
+
+#define STEPUP4(fn, t, s, loadk...)		\
+	STEP##fn##_UPDATE(t,s,);		\
+	STEP##fn##_UPDATE((t)+1,(s)+1,);	\
+	STEP##fn##_UPDATE((t)+2,(s)+2,);	\
+	STEP##fn##_UPDATE((t)+3,(s)+3,loadk)
+
+#define STEPUP20(fn, t, s, loadk...)	\
+	STEPUP4(fn, t, s,);		\
+	STEPUP4(fn, (t)+4, (s)+4,);	\
+	STEPUP4(fn, (t)+8, (s)+8,);	\
+	STEPUP4(fn, (t)+12, (s)+12,);	\
+	STEPUP4(fn, (t)+16, (s)+16, loadk)
+
+	.globl	ppc_sha1_core
+ppc_sha1_core:
+	stwu	%r1,-80(%r1)
+	stmw	%r13,4(%r1)
+
+	/* Load up A - E */
+	lmw	%r27,0(%r3)
+
+	mtctr	%r5
+
+1:
+	LOADW(0)
+	lis	%r5,0x5a82
+	mr	RE(0),%r31
+	LOADW(1)
+	mr	RD(0),%r30
+	mr	RC(0),%r29
+	LOADW(2)
+	ori	%r5,%r5,0x7999	/* K0-19 */
+	mr	RB(0),%r28
+	LOADW(3)
+	mr	RA(0),%r27
+
+	STEP0_LOAD4(0, 4)
+	STEP0_LOAD4(4, 8)
+	STEP0_LOAD4(8, 12)
+	STEPUP4(D0, 12, 16,)
+	STEPUP4(D0, 16, 20, lis %r5,0x6ed9)
+
+	ori	%r5,%r5,0xeba1	/* K20-39 */
+	STEPUP20(D1, 20, 24, lis %r5,0x8f1b)
+
+	ori	%r5,%r5,0xbcdc	/* K40-59 */
+	STEPUP20(D2, 40, 44, lis %r5,0xca62)
+
+	ori	%r5,%r5,0xc1d6	/* K60-79 */
+	STEPUP4(D1, 60, 64,)
+	STEPUP4(D1, 64, 68,)
+	STEPUP4(D1, 68, 72,)
+	STEPUP4(D1, 72, 76,)
+	addi	%r4,%r4,64
+	STEPD1(76)
+	STEPD1(77)
+	STEPD1(78)
+	STEPD1(79)
+
+	/* Add results to original values */
+	add	%r31,%r31,RE(0)
+	add	%r30,%r30,RD(0)
+	add	%r29,%r29,RC(0)
+	add	%r28,%r28,RB(0)
+	add	%r27,%r27,RA(0)
+
+	bdnz	1b
+
+	/* Save final hash, restore registers, and return */
+	stmw	%r27,0(%r3)
+	lmw	%r13,4(%r1)
+	addi	%r1,%r1,80
+	blr
-- 
2.4.9 (Apple Git-60)
