Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E2CC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443388AbiDVCfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443384AbiDVCf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA884B40C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m14so9063822wrb.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uMMwrMi3Zq1sV2E4egHHhmRIH6diyDyXo7IxLvY/hWU=;
        b=IWoKzKqBxOt4N50V2raWRW4F8iTD/sNXRhyUmROP+xUBUQbQsCCPoUnggHhI90O0gv
         Z2C8i/IoD/2yBuqOXyB4TsG1l4CLTLXZiRYj/iASodlo/g8Gx4xeRwJBqCPTVZrgDX4H
         AASkgIR7sSn0Hp4uNoisatvK230tPFkNrviLR1Ui1KtpZWp3XmmQPfPmMH418gTPyYC+
         t5LaHOz9+W9gDvpH6Ui+enfBkVr4UlrMZvdFdWPGASpbCjue1Wun8zhU9SJD+EmFEfmr
         /18Qa5vPNjLTiZ2ltvTgALRi5i+/MFyTgscS08ZwVetcG16DS34LFj5V78ojt+P55way
         pDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uMMwrMi3Zq1sV2E4egHHhmRIH6diyDyXo7IxLvY/hWU=;
        b=1saCIBJI15Kg3GHH11VrnywGzHI4onbpBQNV4YKhv355wKb07/wbaf2c6JfH4Z6fMb
         0o2A4NJTThfB23sPWOH8e+y+ZAKXJtn7tql3FFzQpSKEGENRvEovJI1xBCLNXhBMdzu9
         uXaEOLhCP8M0h+4+SI3uHHCNXhl9hs29NN9YQE/tQfF0PvjNvH/mtWiGga7lUIUl2feJ
         YwfV1t64DVw4LLTvrRYwCvSWIv7wB85W2lmB07bO2ZDn6MPU/sMtOReIs/CNVPdr/qzO
         jC41wszavowEYQyiaT5fb8+HM+RuM8j49WK1EMLafTIrESBWi7dBpXdwSh9+oLYtXJWh
         bqFQ==
X-Gm-Message-State: AOAM531wYajwDr1dX9fL1ZSXyxEP6pK9Uw5yl2ZzBNH7uoyX4ez3NyGj
        hRaOPvnPnlSsKNfkgUAiA2WnrKnI+fo=
X-Google-Smtp-Source: ABdhPJw1NJaIOLhC35xfoNdJoYZLDGKi3hyPkyHTef82yLgI4cqrDdiFcMe8HN5GhJyDAAJ59BsKMw==
X-Received: by 2002:adf:e908:0:b0:207:a28e:b904 with SMTP id f8-20020adfe908000000b00207a28eb904mr1856311wrm.542.1650594752672;
        Thu, 21 Apr 2022 19:32:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm564968wrf.10.2022.04.21.19.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:32 -0700 (PDT)
Message-Id: <b0b57cd37e7c2044ff64d8432e821a4350a174ad.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:21 +0000
Subject: [PATCH v3 4/9] git-sparse-checkout.txt: update docs for deprecation
 of 'init'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The 'init' subcommand of sparse-checkout was deprecated in ba2f3f58ac
("git-sparse-checkout.txt: update to document init/set/reapply changes",
2021-12-14), but a couple places in the manual still assumed it was the
primary way to use sparse-checkout.  Correct them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index b5db812f09e..8e80d1c7332 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -70,11 +70,11 @@ SET' below for more details).  In the past, this was not the default,
 and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
 to be enabled.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
-the input list is considered a list of patterns.  This mode is harder
-to use and less performant, and is thus not recommended.  See the
-"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
-Set" sections below for more details.
+When `--no-cone` is passed, the input list is considered a list of
+patterns.  This mode is harder to use and less performant, and is thus
+not recommended.  See the "Sparse Checkout" section of
+linkgit:git-read-tree[1] and the "Pattern Set" sections below for more
+details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -196,9 +196,9 @@ In addition to the above two patterns, we also expect that all files in the
 root directory are included. If a recursive pattern is added, then all
 leading directories are added as parent patterns.
 
-By default, when running `git sparse-checkout init`, the root directory is
-added as a parent pattern. At this point, the sparse-checkout file contains
-the following patterns:
+By default, when running `git sparse-checkout set` with no directories
+specified, the root directory is added as a parent pattern. At this
+point, the sparse-checkout file contains the following patterns:
 
 ----------------
 /*
-- 
gitgitgadget

