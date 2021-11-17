Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13695C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E916261B42
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhKQLX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbhKQLX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:23:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769DDC061746
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso4463919wms.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I0g3EPYabtyH7qPlMtmdPzqLjmO2A3erl+jKrOYxuH4=;
        b=geJEa5mRBYrp+mxmJwt0WuPTAvziPOXqG1o+PQEvimElZ61P281FwAlOxnUbYOlSTF
         c1DYjK1lUjAHR2AD50GRgqtV1wr84qPrIhqISV+oVhyD/iNedAe7Ujl+lmQGuyix6kmD
         h5oyE3PMIC9fHat8BNaWRKcxAR9UprytYd6kEomVOk1K4r+Rg7saq5ilIrPiq2HGnTB4
         C8vIgSm3LBhAENs6UZyajvIbeQ8DppuG7Ji4TvB2H91FVzqTsHOGzJ48jUuzZu0I5HAE
         hYAKCjjPTDC7nYVSsh5AIKtt87zuo0ZdyNTXOyV8yTrQP1XW6gDwo8d5S+vj/372zoHK
         IV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I0g3EPYabtyH7qPlMtmdPzqLjmO2A3erl+jKrOYxuH4=;
        b=vWEZuPf+7Q2LieFIYlwv2Et/JNz9mOJY4WGp7QDVdR88NpR874yzaLAMLbZ1r9TxHM
         BL64ep+B7AQvIdTi94Iuv73qtNP9Z5qHHcJ2blav5GSv+iLZU9ld0wJDGp7/HjRg0BnH
         8bNz0T1sp/IWyjOnP2TbkTvRKQYgZDvv1UqTY/X/PkX7UB/xhZiaMAoga25IqUDvvTV2
         NitNB2MYOQFw45udm8weIMXBXPMCUlxOpC/+PvzWFJiNTJ/IeXptY/a3c1zIQ1GRf7CH
         dQKr763MVCt7m1hcaK6ipVFyQBL/+57YLlEa3xUUaKGz48iX9SWjT8P8YarRTjDtwvaK
         UwOw==
X-Gm-Message-State: AOAM530t4lNtl5ZC3blpOUFeq5IQLBoyp3Bo77TrxNtAJLYaVs3zFnrN
        1ccdfAIdkotUHosVXgnbV5PZdXSjCdk=
X-Google-Smtp-Source: ABdhPJzv0Kx/UL/r2hIjHniNSKokMlrxQnEIkpGExDAPi8TaUZxKNoXzciQNpRtqwWuHRbaYhWnqlQ==
X-Received: by 2002:a05:600c:1f0e:: with SMTP id bd14mr13096419wmb.3.1637148027855;
        Wed, 17 Nov 2021 03:20:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm5388733wmb.7.2021.11.17.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:20:27 -0800 (PST)
Message-Id: <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 11:20:23 +0000
Subject: [PATCH 1/3] diff histogram: intern strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Histogram is the only diff algorithm not to call
xdl_classify_record(). xdl_classify_record() ensures that the hash
values of two strings that are not equal differ which means that it is
not necessary to use xdl_recmatch() when comparing lines, all that is
necessary is to compare the hash values. This gives a 7% reduction in
the runtime of "git log --patch" when using the histogram diff
algorithm.

Test                                  HEAD^             HEAD
-----------------------------------------------------------------------------
4000.1: log -3000 (baseline)          0.18(0.14+0.04)   0.19(0.17+0.02) +5.6%
4000.2: log --raw -3000 (tree-only)   0.99(0.77+0.21)   0.98(0.78+0.20) -1.0%
4000.3: log -p -3000 (Myers)          4.84(4.31+0.51)   4.81(4.15+0.64) -0.6%
4000.4: log -p -3000 --histogram      6.34(5.86+0.46)   5.87(5.19+0.66) -7.4%
4000.5: log -p -3000 --patience       5.39(4.60+0.76)   5.35(4.60+0.73) -0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xhistogram.c |  5 ++---
 xdiff/xprepare.c   | 24 ++++++++----------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index e694bfd9e31..6c1c88a69a1 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -91,9 +91,8 @@ struct region {
 static int cmp_recs(xpparam_t const *xpp,
 	xrecord_t *r1, xrecord_t *r2)
 {
-	return r1->ha == r2->ha &&
-		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
-			    xpp->flags);
+	return r1->ha == r2->ha;
+
 }
 
 #define CMP_ENV(xpp, env, s1, l1, s2, l2) \
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index abeb8fb84e6..7fae0727a02 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -181,15 +181,11 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!(recs = (xrecord_t **) xdl_malloc(narec * sizeof(xrecord_t *))))
 		goto abort;
 
-	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
-		hbits = hsize = 0;
-	else {
-		hbits = xdl_hashbits((unsigned int) narec);
-		hsize = 1 << hbits;
-		if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
-			goto abort;
-		memset(rhash, 0, hsize * sizeof(xrecord_t *));
-	}
+	hbits = xdl_hashbits((unsigned int) narec);
+	hsize = 1 << hbits;
+	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
+		goto abort;
+	memset(rhash, 0, hsize * sizeof(xrecord_t *));
 
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize)) != NULL) {
@@ -208,9 +204,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
-
-			if ((XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-			    xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
 				goto abort;
 		}
 	}
@@ -279,8 +273,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	enl1 = xdl_guess_lines(mf1, sample) + 1;
 	enl2 = xdl_guess_lines(mf2, sample) + 1;
 
-	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF &&
-	    xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
 		return -1;
 
 	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
@@ -305,8 +298,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 
-	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)
-		xdl_free_classifier(&cf);
+	xdl_free_classifier(&cf);
 
 	return 0;
 }
-- 
gitgitgadget

