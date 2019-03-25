Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C466720248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfCYSOb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:31 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45719 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfCYSOY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:24 -0400
Received: by mail-ed1-f41.google.com with SMTP id m16so8375832edd.12
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iE6cCDC3FJHr9ipm1qLoB/McdwT/thW5o2IT6HMvOlk=;
        b=sN98VVnu56T1db6B3i5Bot6wnI/UVnVrw0pkS2cIdBa79mmf5W6HJuY7CoxDuvTIrP
         9eDa+ydtT3NUpSz2Qyegpj0A8OgCVJRXH3Q6GKdLZG1o0dannIJL9zDZhCyJ0090ZbE1
         O8E9xH50JbIgm5o43ML/8ZdLjfY1ApyTdeS3ayG66vHcDVjbrw/5+v3nEJipal3mSWfV
         0AcIYGp4eXPrmeplEgbcmVieuwOh77sTsa67nDgVtZOGa1K1pA1vb3ItZgX3P313Zp9N
         d3VxiCAoYBiYCrn3ER1ufYazPBjilGTcrcTOv4LUlnQW2M4Mf31R85XujzFD3sNd88P2
         AMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iE6cCDC3FJHr9ipm1qLoB/McdwT/thW5o2IT6HMvOlk=;
        b=cEpdEKsVtSgBy6ldgOTQjCDHchHpWg0J6zvPQM2b5ugpYnWzFNk/iWxUI/LpjRBdZr
         c9ktsC4s2YJcdtuP2MTFtYbREJOh7QgeE5lLtiw2jpRJP3mzlw1UCxxTLX/We92nc8YF
         mdohi61kvEyzXlABB7O3Qefn0rl2ZgcZj747gFtSQ8uL+pV9Ld7a6K6KHGnPsBzxDdnf
         VEd4FPlEhPIdwUCnTlbPEu7pHAGpTLsOhYsZH+l0KQtApXBYfPsms7upOFG8k800BE14
         NZeCKKTSx4RwRyAAbnpKodvRvt9sfPztLsIleqq9xIzer40Wg1Pf7OFGL5m94+0woNqX
         3b/g==
X-Gm-Message-State: APjAAAUa3DXBXMzXN807an92s2Oiuj4NR9pA/cIfle66cEVoorP8WKOR
        yh7TWuibOvL/ZVPMVRS+hmIx2W6F
X-Google-Smtp-Source: APXvYqwkLJreMigFqw1+KL5KqHJv8hKNqr2S8i5Yu7ukDLJqHh7zCtLufgFRK3ubAb86l1pngW3Lvg==
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr17456599edq.153.1553537662726;
        Mon, 25 Mar 2019 11:14:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r48sm5646867edd.87.2019.03.25.11.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:22 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:22 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:14 GMT
Message-Id: <531450c00dfe517748d9ad0bc77b9871c45042aa.1553537656.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/8] tests (status): spell out the `--find-renames` option in
 full
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To avoid future ambiguities, we really want to use full option names in
the test suite. `t7525-status-rename.sh` used an abbreviated form of the
`--find-renames` option, though, so let's change that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7525-status-rename.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index ef8b1b3078..a62736dce0 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -84,7 +84,7 @@ test_expect_success 'status score=100%' '
 	test_i18ngrep "deleted:" actual &&
 	test_i18ngrep "new file:" actual &&
 
-	git status --find-rename=100% >actual &&
+	git status --find-renames=100% >actual &&
 	test_i18ngrep "deleted:" actual &&
 	test_i18ngrep "new file:" actual
 '
@@ -93,11 +93,11 @@ test_expect_success 'status score=01%' '
 	git status -M=01% >actual &&
 	test_i18ngrep "renamed:" actual &&
 
-	git status --find-rename=01% >actual &&
+	git status --find-renames=01% >actual &&
 	test_i18ngrep "renamed:" actual
 '
 
-test_expect_success 'copies not overridden by find-rename' '
+test_expect_success 'copies not overridden by find-renames' '
 	cp renamed copy &&
 	git add copy &&
 
@@ -105,7 +105,7 @@ test_expect_success 'copies not overridden by find-rename' '
 	test_i18ngrep "copied:" actual &&
 	test_i18ngrep "renamed:" actual &&
 
-	git -c status.renames=copies status --find-rename=01% >actual &&
+	git -c status.renames=copies status --find-renames=01% >actual &&
 	test_i18ngrep "copied:" actual &&
 	test_i18ngrep "renamed:" actual
 '
-- 
gitgitgadget

