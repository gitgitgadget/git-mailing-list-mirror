Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7621F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfGANQV (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:16:21 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40209 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGANQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:16:21 -0400
Received: by mail-ed1-f44.google.com with SMTP id k8so23464383eds.7
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EtZjpasjN9L0gYt9jFv2duYRI8X4c1EkfhEtKwQQMGk=;
        b=kX50aWt7dg6H3ORJE7jfnOUN6Qypf8evpWGWP/Ce1MlAw5zT16lslkK4E7vkFNChUN
         WNvlEymQqcL4E1+941DpBLfoG30rvMI1JfmJpBB/EiwprVee42/52+RaFRHHtxWYGUPI
         4XOjFPwPNG8R6amqQAq5z9cidP2fy5IQL20GChIft+d1/wwQxepV/XeTOR15kSmEjA4o
         +MYQoD9PlVt9JSkWqYccLqQv+4WPUDFip/3Pcc4INN/ByuzQ9Ze5+BwoQU0Bz+vKQIsD
         o82jfV0KySj3bTjqeSDl4FCg5TPoApdicznbRoMbPYv24AYMhV8vAQBoPXR0KFu8lrqM
         wlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EtZjpasjN9L0gYt9jFv2duYRI8X4c1EkfhEtKwQQMGk=;
        b=EaxnQUZYk89v2oe3Fxq68BLEacH6UlRdwe72m3Q0jf1AEeGpwOB6qSBxDn66ENVx1M
         kxysls3j7UzY8WcOIw2dVMiVAvbX7vuwaVxwsiJWZZgf25GHhNrKrDsD9NxIv3Gb43tc
         WN+vn1NKgSmmJ99vhWfP504FX+jSEeJebBYU6i8SXWMFd4u4fodaT7vAKrOXw95GwgqT
         qWriBmZNa9hPLW6S8aVfAfmz+Wo9+h1zVtd3buEkFBn09mOn1UN+14ID7u/Cq4ymXqo2
         9vgMfhNv0En881RtB7wkz3+dnFz0Gc93WMn2cWlT6MFkh5OGFw6P/tmM/1yGlLgmjrPx
         HtHg==
X-Gm-Message-State: APjAAAWlH1TaIWD6fm3eXWnt3ZVQNohQxK1GmCflgN3xM45SzQEzDLmI
        KLcpabGTT5ucmBk9/fZp6Gi4qiT7
X-Google-Smtp-Source: APXvYqykAmJPObmiy9J4gZe0qmMRfWc9wrfZ3xkhelr512NJwfRZsPsfKY+LQxsrIZSETlk43otI5A==
X-Received: by 2002:a50:95d3:: with SMTP id x19mr28941377eda.98.1561986979498;
        Mon, 01 Jul 2019 06:16:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm2139156ejc.72.2019.07.01.06.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:16:19 -0700 (PDT)
Date:   Mon, 01 Jul 2019 06:16:19 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 13:16:17 GMT
Message-Id: <pull.280.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix test bug with spaces in file owner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Johannes.Schindelin@gmx.de, j6t@kdbg.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Johannes Sixt for reporting this bug and Dscho for presenting the
correct test-tool to use.

This applies on ds/midx-expire-repack. If we instead want to squash this
into that branch, the two hunks will need to be squashed into these commits:

THIRD_SMALLEST_SIZE applies to ce1e4a105b4 (midx: implement midx_repack(),
2019-06-10).

MINSIZE applies to 2af890bb280 (multi-pack-index: prepare 'repack'
subcommand, 2019-06-10).

Thanks, -Stolee

Derrick Stolee (1):
  t5319: use 'test-tool path-utils' instead of 'ls -l'

 t/t5319-multi-pack-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: b526d8cbbb8740faa10411caa757c6586395fcab
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-280%2Fderrickstolee%2Fmidx-test-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-280/derrickstolee/midx-test-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/280
-- 
gitgitgadget
