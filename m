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
	by dcvr.yhbt.net (Postfix) with ESMTP id 885941F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 11:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfJALQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 07:16:28 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40925 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 07:16:28 -0400
Received: by mail-wm1-f44.google.com with SMTP id b24so2758309wmj.5
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QxKMhUlikYPdZGMehn2UzMSDc+F5gYDdw5YgbbymyNs=;
        b=j1abuazJgvKW9lVtJYrc+fXEtY7CzXQfX0567ls++azhk9zi7BZ4zhn6JDo269V4yU
         V0zKYeQDQ8cF+iMpWJ5aOocSrv5+k0IDQ10U3GrfQcEWXiWNVQwGuI0pTHJtERLrrrgF
         sBO5AJ/fEUEy2+AXddsWEKMe7BHNhL5hKN8EwIyUtt0xGpvQr+b5CFVfMaCc1qvM0MD7
         8vTI64oA2qytUp5r9cjUCljIOVjR1dakGwX6Ki4TvxTnR2eTaARrC2BcpqpDovUrvx25
         FFK4Vl89cxvHZMfYtZ3n/pY9dilLdCBeRBAqHxpikg6Y8tf13thLkLgEbL+0AIo/7uZl
         j2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QxKMhUlikYPdZGMehn2UzMSDc+F5gYDdw5YgbbymyNs=;
        b=QGzaS5+m9yDTfHsXWu9YnBczDw5R6TkRobYbFZMfOXZr14h2XC7Zjn1Kno6KgJjSYw
         /A43NozdxKYVRT0jRiXeu3SgyeeclfImW1iooHgqGNLn6tlMylYccgjus0V4MJj83kpu
         45AH4nHxJLMyuf72mebbZkz6e698wSO4WoIDmHJq9uILj7X8mcgCiRX4GgWDLsTLnbkf
         4MrcrZYg9Q0O8FBpYydpCLIUj3r362eH2XH7hkn5UVu6dZEkN0DdAJRPqH0kjX6jOpx9
         MoJeDSm3AEV5zlCqVWewCrZTfmkacWxXoOgx2Q2MtpA4YUOLyQvgg2ybV030sOin67xo
         ppEA==
X-Gm-Message-State: APjAAAWBLfRadasI+VgMsNe851kEJddJCpzV/e0OIX4Dt6nXCfU/FI5L
        e9o0K5BekGx9TAt0OBySBqBd2Z2n
X-Google-Smtp-Source: APXvYqyh/lmINMiqzq2X3IfkIfNnavUVKerf6EnjtPQUwJgdH7CzrARMzkYgTtf0QKW2D+3HmtjI+A==
X-Received: by 2002:a1c:c14a:: with SMTP id r71mr3364209wmf.46.1569928586053;
        Tue, 01 Oct 2019 04:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm3380038wmi.13.2019.10.01.04.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:16:25 -0700 (PDT)
Date:   Tue, 01 Oct 2019 04:16:25 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:16:23 GMT
Message-Id: <pull.368.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Include hdr-check in the CI builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our hdr-check target is now functional in more ways than before. Let's run
it as part of the CI builds.

I offered this idea in a review of dl/honor-cflags-in-hdr-check
[https://public-inbox.org/git/nycvar.QRO.7.76.6.1909261452340.15067@tvgsbejvaqbjf.bet/] 
but it was not picked up. So I offer it as a stand-alone patch on top of
that series.

Johannes Schindelin (1):
  ci: run `hdr-check` as part of the `Static Analysis` job

 azure-pipelines.yml        | 2 +-
 ci/install-dependencies.sh | 3 ++-
 ci/run-static-analysis.sh  | 3 +++
 3 files changed, 6 insertions(+), 2 deletions(-)


base-commit: b503a2d515e6ac3d2cced7881791c12663c45d01
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-368%2Fdscho%2Fhdr-check-in-ci-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-368/dscho/hdr-check-in-ci-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/368
-- 
gitgitgadget
