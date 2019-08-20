Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F5E1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfHTTfD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:35:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfHTTfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:35:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so13593833wrn.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=URucZdV9fXqudAD2SVaf0lngrACmoeWRV8243SZ23Nk=;
        b=QTLdKw9sFsxo5cPkK5kr+3L/ZXPQqiTwRRc6AClIeMKnCmIi0UT9nXepdWnlshqMAj
         VI4g2ULIkOk7B3DGbXqTiYRYVB8ZrXrjRrpO2zeDiLGqo0xPGwB2ngjz4hYUPOY3ZXqR
         DR51TNAUYwQdnt+gQTun6RRg3ghRwYdcFTmNISqrzUnsjXGho/ZDK0IjZ+oo48KYILEg
         PSMir2szLiwTahVK5LKyKO4RxWNnoUYiBFgiJ4fvlSGCnHyW3JiAMj7nD4eI+63fTiw0
         FoJmNealFUYEosVYhLDW5rWCm/aAdtqDEtsGKfMs7TZ4mhx+wr+705c4Qo3lhIwPZ7QB
         6b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=URucZdV9fXqudAD2SVaf0lngrACmoeWRV8243SZ23Nk=;
        b=ACnkE87Qypd2gB7WB7opCH54uDQmkbeSY1wKXVQx8AYtTDHQ7KhQW2+g9MBI31BELp
         tOCBMKuMVwdHaSne7r+H2BjXCFyLqwlDhxZEaOpUFHo6zdgbDytDTcQ7KrkFDpp7Rycu
         Xw8+Jz2Fs1sH6Ux7+3St+nwtUWuBFwwAdWzxp3PXgYRSR4HIC/wDYzk3E4kXiqVi4c18
         J6Glt0AIlxZ8adGkUSl2mRAqAWK0Of2a9Hu8wChrngJCNyghJLshAV5CH8r8QvFeMLuk
         0Pr5TjtfNy5NGRdQTimwQC8WiDxYqMrqo7NaWwec+Z3iMaYbBLql8fe+ZL+W3pR3Y8WH
         0PXA==
X-Gm-Message-State: APjAAAV/CSdJiYxkhJRju5UiWa5cowBo0qIswlYrsihMZpQ3oR4lu/vv
        kaEVIwnCiZrORHf4NAMOr5vQhYWU
X-Google-Smtp-Source: APXvYqyaQiHApoQcH44xii4zU8BXE/xo2ZthmWKnlz5C/Qbgo2WfLdFJzysX0fJm+YM9z86TOsEmzA==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr1600510wrn.173.1566329701415;
        Tue, 20 Aug 2019 12:35:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e15sm11398429wrj.74.2019.08.20.12.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:35:00 -0700 (PDT)
Date:   Tue, 20 Aug 2019 12:35:00 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 19:34:59 GMT
Message-Id: <pull.314.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] quote: handle null and empty strings in sq_quote_buf_pretty()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     garimasigit@gmail.com, jeffhost@microsoft.com, stolee@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

In [1], Junio described a potential bug in sq_quote_buf_pretty() when the
arg is a zero length string and how he believes the method should behave.
This commit teaches sq_quote_buf_pretty to emit '' for null and empty
strings.

Looking forward to your review. Cheers! Garima Singh

[1] 
https://public-inbox.org/git/pull.298.git.gitgitgadget@gmail.com/T/#m9e33936067ec2066f675aa63133a2486efd415fd

Garima Singh (1):
  quote: handle null and empty strings in sq_quote_buf_pretty()

 Makefile              |  1 +
 quote.c               |  9 +++++++
 t/helper/test-quote.c | 28 +++++++++++++++++++++
 t/helper/test-tool.c  |  1 +
 t/helper/test-tool.h  |  1 +
 t/t0091-quote.sh      | 58 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+)
 create mode 100644 t/helper/test-quote.c
 create mode 100755 t/t0091-quote.sh


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-314%2Fgarimasi514%2FcoreGit-fixQuote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-314/garimasi514/coreGit-fixQuote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/314
-- 
gitgitgadget
