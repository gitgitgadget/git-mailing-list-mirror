Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5CC1F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 20:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfJTUjg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 16:39:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37111 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfJTUjf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 16:39:35 -0400
Received: by mail-wr1-f43.google.com with SMTP id e11so2808373wrv.4
        for <git@vger.kernel.org>; Sun, 20 Oct 2019 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LrApvkCjFWvhGISvjPaB1ghpvPuI5naNWtBbYQ9hscM=;
        b=ajBKdhoL82mN+3VsbzKnTk0Bfmd6n/mALbOFYpHAiUbMwanfxqarHRO4f9Dz2bQhiw
         Tu/nWcYR3OCE+loI9eM38gtByAbzfsAe+puv3dShvxb0ykL2SsGSkddUHNNEjNlRLBqP
         HURW8AWxstbd3Am3/6PHE11mEiXoxxmCru5L12Dh41vYmWhUANDypsJW+5/2MWmns7TN
         yN2tGZIGBlb/yUeDdtbsASRaKy7VmzoePUzNKrBziy5frVQj2w3dDAlZxhuSioD2WEwF
         JXG9vP4Pj5snurudbVdIpjO0Fco14gkoeI8rmAQ2qngxND8yctdLieNyNJJ80hRsasBv
         JP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LrApvkCjFWvhGISvjPaB1ghpvPuI5naNWtBbYQ9hscM=;
        b=PUfsU2vQvpsdiI+CLqwdEHurHEkdBRAc2HGK0Y76yg8+WTVYAMs9+OPhRh9BiZVJwp
         sB5qCo1UdaduyqpZCaDQrkz9ixw3nsvNQLhahEQfUVcH5Ii9A32R5+8OP+eGM0LQHeu0
         iGZLfUa7KDVaHkXuga7YlGKP/p/5/PEP6gK3qhIHsfTV/0OlD/ADAi8524RmnwQ4iozO
         FWUJqlTmwrUWG4Z0/Jfue5YS/G9K0V1hDMiZg1w4io2l6oRbMEd4EdVa/t2noaNIVv8A
         6U7H/jwmBu09M1HKlXtz6bWnRdgThqTh+ZfjoIqefLw14aOR+jTHYBItO0Fy3549ySEu
         6wfA==
X-Gm-Message-State: APjAAAWdgUOl8SQNSZxZlRQw+JUE1sx3AFEizdnYLZpPU0POfBI9+5cY
        HufqeaVPAqpZdS4ZYl9NQUnZT2XE
X-Google-Smtp-Source: APXvYqxkwusQd+QpWzf8hO0ISJc4p3QdeLM9/NVaxXAU83dkhXh2qcAguVwwsHXspJ+KVs+xanWz0Q==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr16007966wrm.351.1571603973317;
        Sun, 20 Oct 2019 13:39:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm10549894wml.26.2019.10.20.13.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 13:39:32 -0700 (PDT)
Message-Id: <e3343d174008a3fe21c159c197913ce749e21589.1571603970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.410.git.1571603970.gitgitgadget@gmail.com>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Oct 2019 20:39:30 +0000
Subject: [PATCH 2/2] ci(visual-studio): actually run the tests in parallel
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Originally, the CI/PR builds that build and test using Visual Studio
were implemented imitating `linux-clang`, i.e. still using the
`Makefile`-based build infrastructure.

Later (but still before the patches made their way into git.git's
`master`), however, this was changed to generate Visual Studio project
files and build the binaries using `MSBuild`, as this reflects more
accurately how Visual Studio users would want to build Git (internally,
Visual Studio uses `MSBuild`, or at least something very similar).

During that transition, we needed to implement a new way to run the test
suite in parallel, as Visual Studio users typically will only have a Git
Bash available (which does not ship with `make` nore with support for
`prove`): we simply implemented a new test helper to run the test suite.

This helper even knows how to run the tests in parallel, but due to a
mistake on this developer's part, it was never turned on in the CI/PR
builds. This results in 2x-3x longer run times of the test phase.

Let's use the `--jobs=10` option to fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 457c6fee31..af2a5ea484 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -255,7 +255,7 @@ jobs:
 
         cd t &&
         PATH=\"`$PWD/helper:`$PATH\" &&
-        test-tool.exe run-command testsuite -V -x --write-junit-xml \
+        test-tool.exe run-command testsuite --jobs=10 -V -x --write-junit-xml \
                 `$(test-tool.exe path-utils slice-tests \
                         `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE t[0-9]*.sh)
       "@
-- 
gitgitgadget
