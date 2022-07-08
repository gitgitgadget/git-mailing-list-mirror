Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32002C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiGHQ0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239286AbiGHQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B5DEE
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:25:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s1so31233019wra.9
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ab6DNjlfCGaxlfSosFC6Vg+UX4p6nTgmto90YH041oY=;
        b=kaCPikQj2m4vMduRyNBjNLs/WeaVHIIEwHRcwMddDS9ER5c2ok7VEt4Eqd2I3gLZq7
         lWYbyNIBRgxFAYOv6kAO+G6pruQOsM2ISsjwqd1QDoGHWGYT9hDCBA69J9r0bezFqBNR
         J0+ka/mqK2M6eUbcjPIpn2IbvVHvJpjcJ0BC1Zt45juHVv9gPZ9Omvt+A9Q6w+9C81CZ
         MJj/ImolBtCqLqVtpC1Ygcot7MFlQDZHBm9PDctEfTz96R+pd1yoQWJbZdd3kQlazm7/
         9SCBoZjx3VOKCGWLEnelu8SmwjXwI6XUIU/dAbSJG46PRET3KN9EvY1wX64VaLI35q2M
         v3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ab6DNjlfCGaxlfSosFC6Vg+UX4p6nTgmto90YH041oY=;
        b=3+M3Rva+dWEIlZGVagAy3hOTp4yBOEB9oLzFzMaoG3knAZukKx7wYJIemDlKkGX/8O
         Z6rSAiOhzQ8KkJAI4qyYbj44FYDJcUUdH/Vg3JBBDKRr39iI0TNJ2mPaoUri/Y86k8/g
         qAT2x4gGP3Q/iAIBEzLtGQbdjg+STg7syyGAlXWk5TSiboORZ7GDs65n6MgGTKxPXYmL
         qYJ4VIespCLoRqLkEvuzT4bYOSyHQG83IyaKN7PGR5hKrqwn3elkHNDYSl1LNw7Q+F2I
         ZQjS8d5+ycMxnnS4cLSeDtBmkDFxcTvTxwkAorXKNWb0Vbb21+vN4uIvtG4lr80xrJrO
         5N3w==
X-Gm-Message-State: AJIora94u2SQoBrcOLAQwd0VprRb0GBZHFyTzeBSFaL1zaKajWbXD6Rs
        BNYPcoAqHNDUlX456dBVmmbZVqa/4Ss=
X-Google-Smtp-Source: AGRyM1vgG6Ali/rvCe4KVIqTEXc+W0HfDnQBORT8U1KMnxxRHxwYZ62yw2Xi2oRGCqGrCgWwpMCHCA==
X-Received: by 2002:a5d:6d84:0:b0:21b:9acb:c478 with SMTP id l4-20020a5d6d84000000b0021b9acbc478mr4209372wrs.491.1657297524608;
        Fri, 08 Jul 2022 09:25:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c41c300b0039c362311d2sm2890331wmh.9.2022.07.08.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:25:24 -0700 (PDT)
Message-Id: <5490fd22579c8a65e097d79d0da4beea8549a02b.1657297520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 16:25:18 +0000
Subject: [PATCH v2 3/4] xdiff: introduce XDL_CALLOC_ARRAY()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add a helper for allocating an array and initialize the elements to
zero. This is analogous to CALLOC_ARRAY() in the rest of the codebase
but it returns NULL on allocation failures rather than dying to
accommodate other users of libxdiff such as libgit2.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xhistogram.c |  9 +++------
 xdiff/xmacros.h    |  3 +++
 xdiff/xpatience.c  |  3 +--
 xdiff/xprepare.c   | 10 ++++------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index c97edc1e29e..df909004c10 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -266,17 +266,14 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 
 	index.table_bits = xdl_hashbits(count1);
 	index.records_size = 1 << index.table_bits;
-	if (!(index.records = xdl_calloc(index.records_size,
-					 sizeof(*index.records))))
+	if (!XDL_CALLOC_ARRAY(index.records, index.records_size))
 		goto cleanup;
 
 	index.line_map_size = count1;
-	if (!(index.line_map = xdl_calloc(index.line_map_size,
-					  sizeof(*index.line_map))))
+	if (!XDL_CALLOC_ARRAY(index.line_map, index.line_map_size))
 		goto cleanup;
 
-	if (!(index.next_ptrs = xdl_calloc(index.line_map_size,
-					   sizeof(*index.next_ptrs))))
+	if (!XDL_CALLOC_ARRAY(index.next_ptrs, index.line_map_size))
 		goto cleanup;
 
 	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 9fd3c5da91a..0977d1615ac 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -55,4 +55,7 @@ do { \
 		? xdl_malloc((nr) * sizeof(*(p)))	\
 		: NULL)
 
+/* Allocate an array of nr zeroed out elements, returns NULL on failure */
+#define XDL_CALLOC_ARRAY(p, nr)	((p) = xdl_calloc(nr, sizeof(*(p))))
+
 #endif /* #if !defined(XMACROS_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 94f8886dd14..fe39c2978cb 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -151,8 +151,7 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
 
 	/* We know exactly how large we want the hash map */
 	result->alloc = count1 * 2;
-	result->entries = xdl_calloc(result->alloc, sizeof(*result->entries));
-	if (!result->entries)
+	if (!XDL_CALLOC_ARRAY(result->entries, result->alloc))
 		return -1;
 
 	/* First, fill with entries from the first file */
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 45190e59fc8..b016570c488 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -78,7 +78,7 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 		return -1;
 	}
-	if (!(cf->rchash = xdl_calloc(cf->hsize, sizeof(*cf->rchash)))) {
+	if (!XDL_CALLOC_ARRAY(cf->rchash, cf->hsize)) {
 
 		xdl_cha_free(&cf->ncha);
 		return -1;
@@ -182,7 +182,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!(rhash = xdl_calloc(hsize, sizeof(*rhash))))
+	if (!XDL_CALLOC_ARRAY(rhash, hsize))
 		goto abort;
 
 	nrec = 0;
@@ -207,7 +207,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!(rchg = xdl_calloc((nrec + 2), sizeof(*rchg))))
+	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
@@ -380,10 +380,8 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 
-	if (!(dis = xdl_calloc(xdf1->nrec + xdf2->nrec + 2, sizeof(*dis)))) {
-
+	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
 		return -1;
-	}
 	dis1 = dis;
 	dis2 = dis1 + xdf1->nrec + 1;
 
-- 
gitgitgadget

