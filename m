Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE421F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA2O4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:56:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2O4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:56:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so16261459ede.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=y6IM7RY6jn4HlEZE7PVKBCuhY64DsVDdI3KSWEA9U9Q=;
        b=szNrGLBYi8AcUzLGPTUueB353TGOgtESvPJl2H1UI27prFGMirS4MrQ64pT/NvWyU1
         +E7Sfmb303/2ZdFBu0LDM2hCKwp4kt0QpCiYlhwE2LJ75/ghYPBR6NB32XpICCXLwdmU
         t3PRrlY5iWyXG72ksSkyjyKwZNtiecPV3GjS/K1GmJYfU+5w7UlSqxq3fl9UI7y+VRtL
         HNKBeQD/HqGetDfFZ2PJfNFHwfvwMS7mijZkSkEYlNm0yHb3wC8DIdGyeN29ajel55Jq
         puYAd7FkTIZyBjkbJOulemF/0Z5F8Pc6dD/ZqM15G87EIiHWD/+r2zf6OAiREBbx0mTM
         CXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y6IM7RY6jn4HlEZE7PVKBCuhY64DsVDdI3KSWEA9U9Q=;
        b=DkjjVzHf/v/u1KeTNCGI/QwlE6V7pxD3A9MnHMA9twG688zKy/W35JWKoeE9TGWYV3
         aL6qWid6HhYVZ/bP2ydPjFgP87RX+YWV+xd6dEsMgExyM7mUIJn2FRtODclduSodiGXe
         ckc/5/nI+cvm5IrFMKbCk4OxGD81nQrtxjML3xDFNP1zILq7gMXEuzxpyzmxZTe97kAq
         u61RrnuqS56u6wqbFkenoVhFsaYeYpiWR6PS4SXDND1j4gExExhM12ktpQUe6e6RsBJf
         NyQytPQ9OuuaT12ffZmu61E6ZGpMfZ1H4pH4MdRXNgLVh8vOpWZIP3yLJqwgCmG2PK8j
         qC6A==
X-Gm-Message-State: AJcUukeFQv+e/PhkxB9fP75fKJRxSbvLbfFZieL6nwyIQuAGSStSb2MN
        a87zsl6bai/swnu9JC24Nlu+fxF7
X-Google-Smtp-Source: ALg8bN66+q4zpgxw0YiC0WhPcwPgOVxNBYJrC2Jw6H+v/VEs9LVw8E7qoHp36tJLWiwSidubtnYtLA==
X-Received: by 2002:a50:d643:: with SMTP id c3mr24876538edj.178.1548773768162;
        Tue, 29 Jan 2019 06:56:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4sm14387600edb.21.2019.01.29.06.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:56:07 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:56:07 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:56:05 GMT
Message-Id: <pull.114.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Makefile: add prove and coverage-prove targets
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

Sometimes there are test failures in the 'pu' branch. This is somewhat
expected for a branch that takes the very latest topics under development,
and those sometimes have semantic conflicts that only show up during test
runs. This also can happen when running the test suite with different
GIT_TEST_* environment variables that interact in unexpected ways.

This causes a problem for the test coverage reports, as the typical 'make
coverage-test coverage-report' run halts at the first failed test. If that
test is early in the suite, then many valuable tests are not exercising the
code and the coverage report becomes noisy with false positives.

This patch adds two targets to the Makefile: 'prove' and 'coverage-prove'.
The idea is to use the 'prove' tool to run the test suite, as it will track
failed tests but continue running the full suite even with a failure.

If/when this merges down, I will use this new target for the automation
around the test coverage reports.

Thanks, -Stolee

Derrick Stolee (1):
  Makefile: add prove and coverage-prove targets

 Makefile | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 0d0ac3826a3bbb9247e39e12623bbcfdd722f24c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-114%2Fderrickstolee%2Fcoverage-prove-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-114/derrickstolee/coverage-prove-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/114
-- 
gitgitgadget
