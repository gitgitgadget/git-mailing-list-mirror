Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F341F404
	for <e@80x24.org>; Tue, 28 Aug 2018 20:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeH2A0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 20:26:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37449 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeH2A0n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 20:26:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so739357pgo.4
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vY5ePZ11A7w+ElDyrsohzlQCgdmJHbhbaEGmKNG8KMI=;
        b=CVE34Szzchojc0gv9oarFwhZdoyHevD5gImW04RFcV5OmBpA0+nMHYqRV6yib2SHlZ
         tp3tTN9b3PDwcMR3zoqlG9h78JqLRY7sOH9fYjg4VCAMBXDHFFmOZU9oN7hDI5C4lWS4
         Xew+gs4ylcOH78dq7N/waIYWDIk4CuGB9+Hk4Vv/ipGZeXZ78OL4hLaxVBLtzqWMg2vl
         NTePtsVS14luJv6oeuJ6CPyHK36m5UVftIu5/PnMx9qjvIkNl71r8MTIflTB82NKB6ja
         qFkxjupb9iWSHdHNC/lNUpWfP1aWr7wQ3nbI/vbyntHvlSDJw3ZXrOgbaqsWqRR72W8y
         HVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vY5ePZ11A7w+ElDyrsohzlQCgdmJHbhbaEGmKNG8KMI=;
        b=cTyci+BVjRvPMPYuMkGOLSqNIlev4s3Njtil0Hb0sJEwaA8UViGk2vzOhELL4tk8r/
         U1JJyq0yURwlj90DOaBUsZn+C1Ykj/pK/MYJs8vQ5fN1SXBZvV9jlrOVP9SQqtc0XBZ9
         BV6jA9E1lnwN4xrbddnwFwKGDMIhJ7vE4LjYk1mnNnlcNKRLme72wkl9+HEa0DEMpaxe
         ThqToqxWpmA5Z3gBcKCHgpKRszSEFTQPF5B72Pwuj+YpnbL21UH5OO+Kca3v0Kr+4Hs1
         4mE04gTuJalcEbJ66P3HBlBiPb/8Nk1VPBulxrImnLkwxThEhQbm205pf6i2vqQ6Gnyi
         ouWA==
X-Gm-Message-State: APzg51ADOgOB4NxDFugL2akcK/PzPtDHjyWAWr8rBvpX/5WzQOqNQ10T
        qYnrAEkVGLpmP0OFa14xYUgnYaQ/
X-Google-Smtp-Source: ANB0VdY13v8ST2Axm98YOHggZY8QIWVdfCIbphRisxX0ty4Zif7Yh506U8X0UfdE6QoXLto+trSlvw==
X-Received: by 2002:a63:b812:: with SMTP id p18-v6mr2930093pge.156.1535488403224;
        Tue, 28 Aug 2018 13:33:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p1-v6sm2650954pfn.53.2018.08.28.13.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:33:22 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:33:22 -0700 (PDT)
X-Google-Original-Date: Tue, 28 Aug 2018 20:33:19 GMT
Message-Id: <pull.26.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph (and multi-pack-index) features are optional data
structures that can make Git operations faster. Since they are optional, we
do not enable them in most Git tests. The commit-graph is tested in
t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
one script cannot cover the data shapes present in the rest of the test
suite.

This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
. Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
with every git commit command. Thanks, Duy, for pointing out this direction
[1].

A few tests needed to be modified. These are the same tests that were
mentioned in my previous example patch [2].

When this merges down, I'll create a CI build in VSTS that runs the test
suite with this option enabled.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/CACsJy8CKnXVJYkKM_W=N=Vq-TVXf+YCqZP_uP7B-dN_6xddB=g@mail.gmail.com/
Re: [PATCH 0/9] multi-pack-index cleanups (Discussing test environment
variables)

[2] 
https://public-inbox.org/git/20180718152244.45513-1-dstolee@microsoft.com/
[PATCH] DO-NOT-MERGE: write and read commit-graph always

Based-On: ds/commit-graph-with-grafts Cc: jnareb@gmail.com

Derrick Stolee (1):
  commit-graph: define GIT_TEST_COMMIT_GRAPH

 builtin/commit.c                    |  4 ++++
 commit-graph.c                      |  5 +++--
 commit-graph.h                      |  2 ++
 t/README                            |  4 ++++
 t/t0410-partial-clone.sh            |  2 +-
 t/t5307-pack-missing-commit.sh      | 10 ++++++++--
 t/t6011-rev-list-with-bad-commit.sh | 10 ++++++----
 t/t6024-recursive-merge.sh          |  9 ++++++---
 8 files changed, 34 insertions(+), 12 deletions(-)


base-commit: 829a321569d8e8f2c582aef9f0c990df976ab842
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-26%2Fderrickstolee%2Fshallow%2Ftest-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-26/derrickstolee/shallow/test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/26
-- 
gitgitgadget
