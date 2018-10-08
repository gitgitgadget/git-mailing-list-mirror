Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5F91F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 15:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJHW3P (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:29:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39072 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeJHW3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:29:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so10220614plp.6
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cnofc5sBR6IiAYcZ9DjO+h178g7Z7LRNuRrsGhGYrB4=;
        b=ReTaNDleztQEGfRFoXkX4PIbacKKYER7s+4O26ykA6attegLhtHmdwCw89SjXdqIDl
         lZki+xeqBTTznSlWBGSy+yjg8aYoTUVmlGz7jhyZJIqdLeEXJSSQWVWzg3yXdsE7KZ1s
         my0+nZoU0IqK/7CAlbP3U66STQDCy6/1dl+b5OF+kGroQZLPHKndbDGBd5/B8lmc2Nj/
         h+8LLBDK5qv8EWpyrC38iyHqRJcmFpd/hMm/fMLa4en15JAQHQrq6hN853eN6U+hV8jL
         ++LTENuIdTax5jt22cmqkONZpLJTtx+gHR99DrUIOuaf1pR5noaBaDEITstkiHG559cY
         yklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cnofc5sBR6IiAYcZ9DjO+h178g7Z7LRNuRrsGhGYrB4=;
        b=g5bU2pJC0kF+k/VJdKBNBfltyDCxTTQDMluUMQVyFfAlIxfXl8+Z/BkJky3v0zuFQX
         G0yL1MHinu7/hUPuGcm6qxaHlnXx15d5CypSGc2dwEWzTLPlZSKZ54tvCPkN5M8djfea
         bv8G0Ek8+R2fVLHSxzrqbvgttb+mo1JG2/m4BdbcrNN9tut244dbie30lnbNI7PtGo00
         1vM5CLocv5818NFX6SCtC+zE5xNI75U7r9wTSsb5lsXQyfyfHa2qmcPYKDr5RzRVKSu6
         Q6OEbeb+7EF29bGMBUgOm3YQH0wtHJ7/Oj43tSrn/R1gYy0t8tY9ViVwPpdeg972z1Qn
         OZQg==
X-Gm-Message-State: ABuFfohIjrUkdxL3xchXnMVnfqqAzYihp3ntqWMMIIwepUGXehLApM3Y
        mQgPCCsJR4VHYb8W0KQVq49DGiY8
X-Google-Smtp-Source: ACcGV61YpXonfJ5FPmIU4eCeAoaCalEQkkcDISEgVx5oQdrzLmWO2fYCopzKHSWiHDKIcfxR5n9csg==
X-Received: by 2002:a17:902:7244:: with SMTP id c4-v6mr24591174pll.339.1539011822886;
        Mon, 08 Oct 2018 08:17:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id z26-v6sm13173761pfh.77.2018.10.08.08.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 08:17:02 -0700 (PDT)
Date:   Mon, 08 Oct 2018 08:17:02 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 15:16:56 GMT
Message-Id: <pull.27.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Add GIT_TEST_MULTI_PACK_INDEX environment variable
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

To increase coverage of the multi-pack-index feature, add a
GIT_TEST_MULTI_PACK_INDEX environment variable similar to other GIT_TEST_*
variables.

After creating the environment variable and running the test suite with it
enabled, I found a few bugs in the multi-pack-index implementation. These
are handled by the first two patches.

I have set up a CI build on Azure Pipelines [1] that runs the test suite
with a few optional features enabled, including GIT_TEST_MULTI_PACK_INDEX
and GIT_TEST_COMMIT_GRAPH. I'll use this to watch the features and ensure
they work well with the rest of the ongoing work. Eventually, we can add
these variables to the Travis CI scripts.

[1] https://git.visualstudio.com/git/_build?definitionId=4

Derrick Stolee (3):
  midx: fix broken free() in close_midx()
  midx: close multi-pack-index on repack
  multi-pack-index: define GIT_TEST_MULTI_PACK_INDEX

 builtin/repack.c            |  8 ++++++++
 midx.c                      | 17 +++++++++++++----
 midx.h                      |  4 ++++
 t/README                    |  4 ++++
 t/t5310-pack-bitmaps.sh     |  1 +
 t/t5319-multi-pack-index.sh |  2 +-
 t/t9300-fast-import.sh      |  2 +-
 7 files changed, 32 insertions(+), 6 deletions(-)


base-commit: f84b9b09d40408cf91bbc500d9f190a7866c3e0f
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-27%2Fderrickstolee%2Fmidx-test%2Fupstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-27/derrickstolee/midx-test/upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/27
-- 
gitgitgadget
