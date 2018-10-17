Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6011F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJQU4K (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:56:10 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:44266 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJQU4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:56:09 -0400
Received: by mail-pl1-f174.google.com with SMTP id p25-v6so12656538pli.11
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NnFyGlyr0LvYjXJWiRgezwBoznpYtESshQcllYM9nmw=;
        b=KcZuZV8euz3SsaA8382H038K1RyiZEJWaXkP6R6rog4YD/8RIyEjlUiK2dN+xWMF9p
         zn01Am+7KX1JmRsqMhU6N4RFQbWagcYhZ1PwIF5cKmU8/bwwCM0IHLdDAm/C7lm1adq+
         GyNyr3Oze0KhTQZpyQ03ZzbsuKTSYzr+Hz1owyOJKmHIlq5BwgaicuevD4BEzMl42+OT
         LWVSKBIMVNAMSs2odkuSelEi2DsMiz/Yuk1oNBuQOHNwlAFTX40NUz1li7JvC9cEu1P/
         emiX/oJx1qESNTnsB7kUljnyTH4BSriNzQf24XbbCYZ+gkeS0ThfpM19VkX/+2ZQcAT8
         sRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NnFyGlyr0LvYjXJWiRgezwBoznpYtESshQcllYM9nmw=;
        b=NWB9LxUllLGl9qoDEXOCWNIpFpwar/KMr4Dm0iAcBjqh/XUZ40hO9/M5BZbT8z39eR
         f3WBaXMsdJy/op4XoX7ZzbxFo45llFkwqeyAxIzvOuyyoEO5k/mv+H0qZflq2XkgxLwC
         03mDj/23MysbNEvdvaXRHm8hIJ0hvDOhbpK9vxwVTCeKS4lzE7ziDd4VYGQiA2k+XneN
         hvSbITJGz2HejW5JHf3dsxkV2o7TfJ3uUkxgn460vQdsR4TFIJzwOEweVuR1HMtPLhfV
         kGYuEzPVEpCvxu2VxCDDW6rMoYSsgbR/nJM+rE77QISCYMVT+d7SShGJdMKm6RJasjHc
         94tQ==
X-Gm-Message-State: ABuFfogz4iEq3+8cRLz3Kxt136dZbz4DG2+w0/6d+oTMpLA7QgBV05OU
        Wwl/hMJi46I3Y1Mbpx0ZcbRc6l/C
X-Google-Smtp-Source: ACcGV61bLbzJ1hND1h22y+3AcePqM+jtxc2uA/dxmJyZSqms6weViOQaUvmfVbCxF7DLRdyFWFK46g==
X-Received: by 2002:a17:902:d704:: with SMTP id w4-v6mr26176736ply.230.1539781233317;
        Wed, 17 Oct 2018 06:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w127-v6sm24687837pfd.112.2018.10.17.06.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:00:32 -0700 (PDT)
Date:   Wed, 17 Oct 2018 06:00:32 -0700 (PDT)
X-Google-Original-Date: Wed, 17 Oct 2018 13:00:29 GMT
Message-Id: <pull.49.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Run GIT_TEST_COMMIT_GRAPH and GIT_TEST_MULTI_PACK_INDEX during CI
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our CI scripts include a step to run the test suite with certain optional
variables enabled. Now that all branches should build and have tests succeed
with GIT_TEST_COMMIT_GRAPH and GIT_TEST_MULTI_PACK_INDEX enabled, add those
variables to that stage.

Note: the GIT_TEST_MULTI_PACK_INDEX variable has not merged all the way
down, so will be ignored if this series is merged faster than that one.
However, it is safe to make these changes orthogonally as all (known) test
breaks with GIT_TEST_MULTI_PACK_INDEX=1 are fixed in the topic that
introduces the variable.

I also created a build definition on Azure Pipelines that runs the test
suite with different subsets of the test variables, split by the following
types:

1) Index options 2) Commit-graph 3) Multi-pack-index

These builds are found at [1]. There are benefits to testing the variables
all together but also separately. I didn't want to create new stages in the
CI scripts to avoid consuming extra resources.

This series is based on js/vsts-ci to avoid conflicts with that series, but
is not necessarily a hard dependence.

Thanks, -Stolee

[1] https://git.visualstudio.com/git/_build?definitionId=4Build definition
that tests Git with different arrangements of GIT_TEST_* variables.

Derrick Stolee (1):
  ci: add optional test variables

 ci/run-build-and-tests.sh | 2 ++
 1 file changed, 2 insertions(+)


base-commit: d82963f34cf6921ed29d1fc2d96b16acf9005159
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-49%2Fderrickstolee%2Fci-vars-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-49/derrickstolee/ci-vars-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/49
-- 
gitgitgadget
