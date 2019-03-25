Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C35F20248
	for <e@80x24.org>; Mon, 25 Mar 2019 18:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCYSOT (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 14:14:19 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:36480 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfCYSOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 14:14:19 -0400
Received: by mail-ed1-f43.google.com with SMTP id e4so8392616edi.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AY2wyzdOSzYQNJ7NICx4qHWh3kkAM5t5UTOoyTwYhUo=;
        b=ANkzuVYbevMirElhIDkdBG+v4kyzkf8vO9wkJskSEqRM3C95vldOlnw+a36KX7eEqU
         j7GGVp2JIEfGmvlBiaLGZK4Tx1T2CvRIyYugJ3zNkC1I1K54YcwP+r/JN/FUGrCIOxaC
         5lGEFtqEWWuw006s/Drik9c1psDtC/nWpEdTgiwNfGqceDLDEyZMYOEYC5RV70oZW5vR
         qUP8KLEZAnJFFfzoxTLFOGC0UzBM28vixvj/BqWtllOhY278G+BC2+ACokxvDCL6ThdJ
         YSm8ElE3/sVTbICIrla+i6jpTD2OKLQkhMZeJSYxhQZRfHYAmJO2wHqN91yPPCgxCgCa
         6WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AY2wyzdOSzYQNJ7NICx4qHWh3kkAM5t5UTOoyTwYhUo=;
        b=uABTu3gZpoLJWm4Dk6fID6Ez4vEZxRR1gRSm1zYzDI1eFbK8sYIQbpFik3E69Fzn5/
         K4y07A8447ORjGCRPXydu5yTBg2tSdh+uwMXo2CbXnBLZf+6zlxf4qou/fA+ns1U7HI9
         c3leQP8W30BzVtWrkaZ/Lc6wp+twukR5+/GAXkxzox6ifHU4IIpJpI0Bc/84pFc5eMBk
         Wl4y9VL6UVKwUPDV9O+JrRN1YZpmcGdl2ZYVNrDremJnOrNsLfX06osmrK4S3s7exkVe
         BMzeXsJieFcuXqJunvS2d/qTHqVCxIW+vlY3kkoQwoeRIqnTNXtniTvveHZkk3GDp76e
         crIA==
X-Gm-Message-State: APjAAAWdObHjdSsW2khpd2cAoyJHc8xCpBAyz1kFWqIh64APDAmL6itE
        W9Q2S3kKbG1bslfcNclGJHcUoXjY
X-Google-Smtp-Source: APXvYqzF+ls0sgJdMSydbfeD/dYFg27hoCVQVLSa66f8PlPjj2Idc1vYNvqL0YqfD3Pezxqfrb1Uuw==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr17172607edv.274.1553537657851;
        Mon, 25 Mar 2019 11:14:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z35sm4338173edd.81.2019.03.25.11.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:14:17 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:14:17 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 18:14:08 GMT
Message-Id: <pull.167.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/8] Do not use abbreviated options in tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want to have tests that need to be changed by completely unrelated
patch series, just because abbreviations that used to be unique are being
made non-unique by said patch series.

I stumbled over this while investigating the test failures in
dl/rebase-i-keep-base
[https://dev.azure.com/gitgitgadget/git/_build/results?buildId=5482&view=ms.vss-test-web.build-test-results-tab]
: the new --keep-base option makes the --keep abbreviation of --keep-empty 
in t5407 non-unique, which causes the test suite to fail.

Johannes Schindelin (8):
  tests (rebase): spell out the `--keep-empty` option
  tests (rebase): spell out the `--force-rebase` option
  t7810: do not abbreviate `--no-exclude-standard` nor `--invert-match`
  t5531: avoid using an abbreviated option
  tests (push): do not abbreviate the `--follow-tags` option
  tests (status): spell out the `--find-renames` option in full
  tests (pack-objects): use the full, unabbreviated `--revs` option
  tests: disallow the use of abbreviated options (by default)

 parse-options.c                        |  9 ++++++
 t/README                               |  4 +++
 t/t0040-parse-options.sh               |  7 +++-
 t/t3415-rebase-autosquash.sh           |  2 +-
 t/t3430-rebase-merges.sh               |  4 +--
 t/t5317-pack-objects-filter-objects.sh | 44 +++++++++++++-------------
 t/t5407-post-rewrite-hook.sh           |  4 +--
 t/t5516-fetch-push.sh                  |  4 +--
 t/t5531-deep-submodule-push.sh         |  2 +-
 t/t7525-status-rename.sh               |  8 ++---
 t/t7810-grep.sh                        | 16 +++++-----
 t/test-lib.sh                          |  6 ++++
 12 files changed, 67 insertions(+), 43 deletions(-)


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-167%2Fdscho%2Fdisallow-abbreviated-options-in-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-167/dscho/disallow-abbreviated-options-in-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/167
-- 
gitgitgadget
