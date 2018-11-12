Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1157D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeKMJVS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46564 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMJVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so4733677pgp.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JvXCEGvqKZsB5LsXiTaNfJfOp+C991Odh5ecQlZGLwY=;
        b=KOG9otuqofJ5G7k68/qhw+mUp6XfLWWaR0dOS8NUhxGobqN60sXdMji2AdDrKis7lf
         OGty8QhdYNjIMX4GXolDF5PKMjvE2nKuTRyYkS9irheTOwUzjwLKFSb1GAvJ2EiCA77t
         /Ig0BE70iocy/X6V6F5MWECCJE8C23YMq8NQ2cv7YYXQT46RX90o/OZGx/1xsfmxvK11
         QcaWe8BiNdaUiAyBaJBBx3GGWTJ2ZCvkZeECYYenbDQYDZc3Al8aYXJY+asuEqkM6uTV
         ptRPaep5Yw4K0eYjJv0HJwHD1ptRJK+7K1sq1HoGKvdM8sImf0tvkZIcVqJHiisBCRC1
         VbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JvXCEGvqKZsB5LsXiTaNfJfOp+C991Odh5ecQlZGLwY=;
        b=L5dpAeSf+PWmAgQogDyCVw2bVHZjaW6j5EJ+WZUPxOXwEfiKOoUBbxqDaj7QKN2soy
         vwF/tlU/yEEQZ9hw4Kdv+62/3DPp6Hf4OrC1nXmKdOWR+GclOMfjDVDNU0zFin6MnTYs
         RTDto1LIb5H6qCCgoviyIuPiphFtjoOi5FcuikXOeDXTfXwpuOCQgm2sazcDFLiG6uE5
         tZOlFoXtQQJI3PIcWsOR5l791TuXvPof4MyGL728dlnbJ/9N0F6rsr/ZqMWyx3Pp7Rr4
         SzTZNnzr/0ITBa7k/FcOn8SJgf0LVZoMDKUxZhoiyOotzMfhgYTCUpKoCU4eoNyeRWL9
         bx0w==
X-Gm-Message-State: AGRZ1gLQXSE4YYUW9Nkdtkm/n5yzX9bSQlFrqUKjxKrHZwFN/VstAVzM
        EnlMW49MdlHoocksa2vNhz0/jQtc
X-Google-Smtp-Source: AJdET5eIiA0WoKzFNtmcVeCaOMsewOCyOKHbKYrYBtoI1C4wUY11lm5MQDPmbIDVvXYR66JHYIQgrA==
X-Received: by 2002:a62:5e46:: with SMTP id s67-v6mr2880090pfb.122.1542065156644;
        Mon, 12 Nov 2018 15:25:56 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id c87-v6sm31436591pfe.93.2018.11.12.15.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:25:56 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:25:56 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:48 GMT
Message-Id: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/5] Assorted fixes revolving around rebase and merges
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

I noticed a couple of weeks ago that I had bogus merge commits after my
rebases, where the original commits had been regular commits.

This set me out on the adventure that is reflected in this patch series.

Of course, the thing I wanted to fix is demonstrated by 1/5 and fixed in
2/5. But while at it, I ran into other issues and fixed them since I was at
it anyway.

Johannes Schindelin (5):
  rebase -r: demonstrate bug with conflicting merges
  rebase -r: do not write MERGE_HEAD unless needed
  rebase -i: include MERGE_HEAD into files to clean up
  built-in rebase --skip/--abort: clean up stale .git/<name> files
  status: rebase and merge can be in progress at the same time

 builtin/rebase.c         |  3 +++
 sequencer.c              | 10 ++++++----
 t/t3430-rebase-merges.sh | 16 ++++++++++++++++
 wt-status.c              |  9 +++++++--
 4 files changed, 32 insertions(+), 6 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-75%2Fdscho%2Frebase-r-and-merge-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-75/dscho/rebase-r-and-merge-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/75
-- 
gitgitgadget
