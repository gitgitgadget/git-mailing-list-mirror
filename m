Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403FFC433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C4061B97
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 11:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhKQLXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhKQLX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 06:23:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D61C061764
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:30 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so3957224wrh.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GMd397+C9a5P8a/jMKGZjk/mdHW+mO8bDCfqTyyzcac=;
        b=OHpB15P1pQs23ZetJFlg+g7zowFQ6BdMbw66d49eqBLvrzBP7jFxapZIb+IuZrgchm
         RNSbe5Lbssv8chEovtU/jQ//m+VV4GasEUOuZshjC0a2+AJdJV1cIy4NzLpECHY9b4Cx
         puiR7LhZ28BGzr5HssCwRmWR5QEs9vsSxt/3rilyR3uKBY4Kf8XKCnazkkS4Ehi8v6ZI
         ikM//kHfSjGcsBx45mfCQJBolDO04BNDDurV0bsJlLssOGkV4JMQcNH/bLb9pEZYRsF4
         WaHo7luyOHVDRz1U1MnYa9UctiBrVAor4naSh1ZJEDtXN2k3k6PXzaTJx5Y2KVxXLohU
         75ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GMd397+C9a5P8a/jMKGZjk/mdHW+mO8bDCfqTyyzcac=;
        b=6bmMvXSBHMEdrEpWudNbn91/7ROBd1bn/m8RLudgKidtXrSe1f4Usov8cxO6Ej7KA0
         OIggGVKL/12zMAK+DZxys//5WxoXW45ZYP5aItAxtRJWXNxrUOTAr9SY22mCfsgtdBlT
         L8x5+1sEjJH0okj3gCf/Ftv7Hilf8tZM2mVaEERwzDl96YxKXzllKLTRNo1AfP6iHbtG
         ru1y0nSR0o2/5NlcYwqW84wAddDOEEvZ0yOALG4toUfjRLDZKTB1a/bqzAnMm4fUNUYq
         z9AavLSiB/42HdZzRtaSUfVCElBq0BS4W8puDqAnF3PiZGRJWd0H0LsW0M7EdW/1VSQk
         32+A==
X-Gm-Message-State: AOAM532SCZf4g/rUv5ogfw+i+R4yyuRziC7USKV79uoIgFcv/j50Z/i5
        l9KJMzEV+xQ06MrOTUT4NUHrOgb11rc=
X-Google-Smtp-Source: ABdhPJwsbp33L4wlsAOMFqNOyX7AkLTNb15WK8EZTkaRC4f6spWFO4clab/XgaVI9NASDTDLhilU+A==
X-Received: by 2002:adf:9bcd:: with SMTP id e13mr18901247wrc.165.1637148029231;
        Wed, 17 Nov 2021 03:20:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az4sm5380892wmb.20.2021.11.17.03.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:20:28 -0800 (PST)
Message-Id: <b0bc773f51e114d96ad6efd1ebd03fb6e7646288.1637148025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 11:20:25 +0000
Subject: [PATCH 3/3] xdiff: simplify comparison
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

Now that the histogram algorithm calls xdl_classify_record() it is no
longer necessary to use xdl_recmatch() to compare lines, it is
sufficient just to compare the hash values. This has a negligible
effect on performance.

Test                                  HEAD~1            HEAD
-----------------------------------------------------------------------------
4000.1: log -3000 (baseline)          0.19(0.12+0.07)   0.18(0.14+0.04) -5.3%
4000.2: log --raw -3000 (tree-only)   0.98(0.81+0.16)   0.98(0.79+0.18) +0.0%
4000.3: log -p -3000 (Myers)          4.81(4.23+0.56)   4.80(4.26+0.53) -0.2%
4000.4: log -p -3000 --histogram      5.83(5.11+0.70)   5.82(5.15+0.65) -0.2%
4000.5: log -p -3000 --patience       5.31(4.61+0.69)   5.30(4.54+0.75) -0.2%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 xdiff/xdiffi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a4542c05b61..6a3b9280beb 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -392,10 +392,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2, long flags)
 {
-	return (rec1->ha == rec2->ha &&
-		xdl_recmatch(rec1->ptr, rec1->size,
-			     rec2->ptr, rec2->size,
-			     flags));
+	return (rec1->ha == rec2->ha);
 }
 
 /*
-- 
gitgitgadget
