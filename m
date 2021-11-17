Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460AFC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0D261B96
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbhKQLXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbhKQLX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:23:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EDC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so3894788wru.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oRSFnyhMNaCVd+A1yXll/itpTPChaAlDyuz0SZIrxzg=;
        b=Z1hTuO54PDyBa4qsj7nRfZcB64Kxk1CSEOBR6pMdq1+6PRU/8QnxBcJBuzDl+g6b7b
         1/k3dPkcf+S2AemihTj7kjsjI0YqidZxP1ASuIkf5OqXY1kENbvnTSqrqWTntb2n2Ve5
         ahf/pjWnZmpU/sBBZuGM9dgrFJk21EZdu89/pqu4CVs8y+1u5D1eekPiZNeu+YR+nrc0
         qorYt4fZSyLGr9xJTedvSyjzqueHFIH/TzrtFGJ/aDDfiQIL5BisFqZG7QBT0A4iIoBJ
         DjGCi9WE6czoHAck9jWVmDYmO8LyDGlZqXZ+UWOVDiSJo00jLiRz+YH9tGAvOd4Xqeeh
         3pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oRSFnyhMNaCVd+A1yXll/itpTPChaAlDyuz0SZIrxzg=;
        b=rBDOWarPKZVaQPV2z1HFaGP54yUTj/+vBUtlCzL1PgqID+sU7bRejIneQyMK9sXxAc
         kxdefENxihd6+tEVbXy2aHwkwO0HnONLt7ss8RGyKJhgyhePX09rP94YHLdYcpRQ32eo
         Tv0uT9pR9V58So5WlpelawiQvjExyotw11Ac37KVjCFB73UVEh3BJsb9VezgVxbX/wCf
         pYEhdV9H4gGkX+5MCU6dn6wFdlsV59benYQYQaxyYwNCo2ejJ/4L525tJClI9jcgIGq5
         Z7hHaGuOUJJ/BNO++AxqcWnzwYiqUy9eqQT6e32JzK7KQh9d1yrX3t+jKZy1j3LVOKJ1
         0G0Q==
X-Gm-Message-State: AOAM530Ju9u/J9G3NBxj8WG2AGYojKfUPCmK5Bl+K/rofk3TxRnnc8uH
        5Jn3OpDp+W9qrZm8kVcVKf+3L9+aTCQ=
X-Google-Smtp-Source: ABdhPJw6cGtjxoLjz6ZvosBjwi/b4xS4jfrLtCeibrw2nfrZnwuTrpaRKTA6lbdNiSOJjQPhDvIYXw==
X-Received: by 2002:adf:e848:: with SMTP id d8mr19154914wrn.3.1637148028586;
        Wed, 17 Nov 2021 03:20:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm6756877wmq.46.2021.11.17.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:20:28 -0800 (PST)
Message-Id: <eef46c71840d7f36b503a92b899c95632c023351.1637148025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 11:20:24 +0000
Subject: [PATCH 2/3] xdiff: avoid unnecessary memory allocations
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

rindex and ha are only used by xdl_cleanup_records() which is not
called by the histogram or patience algorithms. The perf test results
show a small reduction in run time but that is probably within the
noise.

Test                                  HEAD^             HEAD
-----------------------------------------------------------------------------
4000.1: log -3000 (baseline)          0.19(0.17+0.02)   0.19(0.12+0.07) +0.0%
4000.2: log --raw -3000 (tree-only)   0.98(0.78+0.20)   0.98(0.81+0.16) +0.0%
4000.3: log -p -3000 (Myers)          4.81(4.15+0.64)   4.81(4.23+0.56) +0.0%
4000.4: log -p -3000 --histogram      5.87(5.19+0.66)   5.83(5.11+0.70) -0.7%
4000.5: log -p -3000 --patience       5.35(4.60+0.73)   5.31(4.61+0.69) -0.7%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xprepare.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 7fae0727a02..4527a4a07c4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -213,10 +213,13 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		goto abort;
 	memset(rchg, 0, (nrec + 2) * sizeof(char));
 
-	if (!(rindex = (long *) xdl_malloc((nrec + 1) * sizeof(long))))
-		goto abort;
-	if (!(ha = (unsigned long *) xdl_malloc((nrec + 1) * sizeof(unsigned long))))
-		goto abort;
+	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
+	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
+		if (!(rindex = xdl_malloc((nrec + 1) * sizeof(*rindex))))
+			goto abort;
+		if (!(ha = xdl_malloc((nrec + 1) * sizeof(*ha))))
+			goto abort;
+	}
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
-- 
gitgitgadget

