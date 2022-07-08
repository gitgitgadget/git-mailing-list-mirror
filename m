Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D5C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 16:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiGHQ0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239242AbiGHQ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 12:26:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D06D562
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 09:25:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so1166005wmr.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dD85s/bxXv2q7lM4F7b9Vqnw0iZFNEaYnrxuhLyqNcM=;
        b=kCqpPmi0cXRhQhwjbfeXGBZ2KS2kcnaLGAFDk6WzDP/GS3KecqTNNCO1MIiGEayz6R
         858HcITcVMsRnXxZUgZSsRumwd5pzZXTJ5s+uxuWj0oKn5FrvJT8PNHIVyCTLCvM1C9E
         PwfVnEkfrRQxxu9E4Cbc/ZzQ2xlOQA4sVl4k0WA6HmapIlBGY+Ai3VL0XGw0oJsX9b1p
         zGsDFo7T3xy3GJ2kfVtToOWdHQRCEvT1sjk9wiKAWhCur7wRDAfrGgzuQK7BsAg7BrDn
         IIcFjp2FJl11Nlo0ZClkvSoUeZbUgr2WYPoIDEVkvh/Y/lOD4EGGAX5Na0o4hOyBGPLV
         sVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dD85s/bxXv2q7lM4F7b9Vqnw0iZFNEaYnrxuhLyqNcM=;
        b=Ti8MaQ42NOzWsIO0O7ug9UcRlm8Q70EVfV4bLNGBVw1DJa0WgbINlYS3aWmYfALJ/P
         BV4UdrUdy0TJatJUfbPblP1tE0JrvB+TpjHus9emFZlbR5erqKbb2zej5RNfzgvT/dfu
         qythj3yuyHukbNeJ0/BEw5d9+HRPgV+PQzUG0vSGVwVpmEaoEGq4LWtsFGkBJFH6xe8+
         DG5YlVv1gCwseauCWwRXB6WYsHlZ+jMEWED1ejPMtZb5rPBKke6yZpb2pO7bRM8iaFqI
         1X3sfDLvOpklIrubA8hz6REz+/0hRLAZqjV2LPtodQ7ngo0UJG0DjW4dBcyivRMl/nfB
         ZjXA==
X-Gm-Message-State: AJIora9U02moiAs7J2FpACrgcUm1QFvts0QPqWqCEIL4yn6/FvZZmlDD
        iH7z+30/iCmKmSWAj4uRxM33Qc0sXEE=
X-Google-Smtp-Source: AGRyM1tJii/o/kJJOxMFbtrUUi0XBMi9yl9QWW7zjq8nDZMb7AS2YUscHYPLxweL99mUM42o3MQhrg==
X-Received: by 2002:a05:600c:a192:b0:3a0:433a:9ca with SMTP id id18-20020a05600ca19200b003a0433a09camr691047wmb.108.1657297523529;
        Fri, 08 Jul 2022 09:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b0021cf31e1f7csm5447581wrb.102.2022.07.08.09.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:25:23 -0700 (PDT)
Message-Id: <ea8993a57efea4af347e00e25eed6487fec28a53.1657297520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
        <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jul 2022 16:25:17 +0000
Subject: [PATCH v2 2/4] xdiff: introduce xdl_calloc
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

In preparation for introducing XDL_CALLOC_ARRAY() use calloc() to
obtain zeroed out memory rather than malloc() followed by memset(). To
try and keep the lines a reasonable length this commit also stops
casting the pointer returned by calloc() as this is unnecessary.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xdiff.h      |  1 +
 xdiff/xhistogram.c | 22 +++++++++-------------
 xdiff/xpatience.c  |  4 +---
 xdiff/xprepare.c   | 12 ++++--------
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 72e25a9ffa5..bb56b23f34c 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -120,6 +120,7 @@ typedef struct s_bdiffparam {
 
 
 #define xdl_malloc(x) xmalloc(x)
+#define xdl_calloc(n, sz) xcalloc(n, sz)
 #define xdl_free(ptr) free(ptr)
 #define xdl_realloc(ptr,x) xrealloc(ptr,x)
 
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 01decffc332..c97edc1e29e 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -251,7 +251,7 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 		    int line1, int count1, int line2, int count2)
 {
 	int b_ptr;
-	int sz, ret = -1;
+	int ret = -1;
 	struct histindex index;
 
 	memset(&index, 0, sizeof(index));
@@ -265,23 +265,19 @@ static int find_lcs(xpparam_t const *xpp, xdfenv_t *env,
 	index.rcha.head = NULL;
 
 	index.table_bits = xdl_hashbits(count1);
-	sz = index.records_size = 1 << index.table_bits;
-	sz *= sizeof(struct record *);
-	if (!(index.records = (struct record **) xdl_malloc(sz)))
+	index.records_size = 1 << index.table_bits;
+	if (!(index.records = xdl_calloc(index.records_size,
+					 sizeof(*index.records))))
 		goto cleanup;
-	memset(index.records, 0, sz);
 
-	sz = index.line_map_size = count1;
-	sz *= sizeof(struct record *);
-	if (!(index.line_map = (struct record **) xdl_malloc(sz)))
+	index.line_map_size = count1;
+	if (!(index.line_map = xdl_calloc(index.line_map_size,
+					  sizeof(*index.line_map))))
 		goto cleanup;
-	memset(index.line_map, 0, sz);
 
-	sz = index.line_map_size;
-	sz *= sizeof(unsigned int);
-	if (!(index.next_ptrs = (unsigned int *) xdl_malloc(sz)))
+	if (!(index.next_ptrs = xdl_calloc(index.line_map_size,
+					   sizeof(*index.next_ptrs))))
 		goto cleanup;
-	memset(index.next_ptrs, 0, sz);
 
 	/* lines / 4 + 1 comes from xprepare.c:xdl_prepare_ctx() */
 	if (xdl_cha_init(&index.rcha, sizeof(struct record), count1 / 4 + 1) < 0)
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index ce87b9084ca..94f8886dd14 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -151,11 +151,9 @@ static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
 
 	/* We know exactly how large we want the hash map */
 	result->alloc = count1 * 2;
-	result->entries = (struct entry *)
-		xdl_malloc(result->alloc * sizeof(struct entry));
+	result->entries = xdl_calloc(result->alloc, sizeof(*result->entries));
 	if (!result->entries)
 		return -1;
-	memset(result->entries, 0, result->alloc * sizeof(struct entry));
 
 	/* First, fill with entries from the first file */
 	while (count1--)
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 25866a1667a..45190e59fc8 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -78,12 +78,11 @@ static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 
 		return -1;
 	}
-	if (!(cf->rchash = (xdlclass_t **) xdl_malloc(cf->hsize * sizeof(xdlclass_t *)))) {
+	if (!(cf->rchash = xdl_calloc(cf->hsize, sizeof(*cf->rchash)))) {
 
 		xdl_cha_free(&cf->ncha);
 		return -1;
 	}
-	memset(cf->rchash, 0, cf->hsize * sizeof(xdlclass_t *));
 
 	cf->alloc = size;
 	if (!XDL_ALLOC_ARRAY(cf->rcrecs, cf->alloc)) {
@@ -183,9 +182,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	hbits = xdl_hashbits((unsigned int) narec);
 	hsize = 1 << hbits;
-	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+	if (!(rhash = xdl_calloc(hsize, sizeof(*rhash))))
 		goto abort;
-	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
@@ -209,9 +207,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!(rchg = (char *) xdl_malloc((nrec + 2) * sizeof(char))))
+	if (!(rchg = xdl_calloc((nrec + 2), sizeof(*rchg))))
 		goto abort;
-	memset(rchg, 0, (nrec + 2) * sizeof(char));
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
@@ -383,11 +380,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 
-	if (!(dis = (char *) xdl_malloc(xdf1->nrec + xdf2->nrec + 2))) {
+	if (!(dis = xdl_calloc(xdf1->nrec + xdf2->nrec + 2, sizeof(*dis)))) {
 
 		return -1;
 	}
-	memset(dis, 0, xdf1->nrec + xdf2->nrec + 2);
 	dis1 = dis;
 	dis2 = dis1 + xdf1->nrec + 1;
 
-- 
gitgitgadget

