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
	by dcvr.yhbt.net (Postfix) with ESMTP id C24951F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 11:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfJALxj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 07:53:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 07:53:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so15149879wro.4
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YgqfT88OsSoIeYRdRKZuKA1C1hFGpW8bRWIvRDG0fBc=;
        b=oUWoSZcUnou0+jcyNAiB+WGcJ4d8OXGdW60o2Ta8NUj/8BkmfaDZz7MQvyyE/YDDES
         Rcnaw1c0Ey+OlRA0CRdFxit6OgDNzdXorQ6s5Q+0YjCV/qL9MOH/NogSQ5IGQpC1sHk+
         dos8fkSwEMuAS2ZkvTbTxx+3Lvw2VgFfzdgsEO7Ptqq2LGCU+hi0NY1JK7KEiO9/NET1
         n1BmSjs63crpuXr1WFe9lh0/SLSBgRnT2eAOn0rL2y3Lkx3XZzji3Z+o266YTa5TpCx/
         XWaNJ9rXjBuhgeEcg5mybh6+ZPob6eh0GDEEukN3JeCbspHpvG+2b2m/Hyt3J9+SAIs+
         lRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YgqfT88OsSoIeYRdRKZuKA1C1hFGpW8bRWIvRDG0fBc=;
        b=fBCTtgKD60ppWulc4iztrv9v5TgKVs8VhbzTDV14RmBJO5ew53FxIvd8gP4Q8OAgQ/
         vIWYHp6SAs6+kdD7d9Ehb/9JXayz41NKFhj7InVMQc5PwHRA7X0JzrISm8LtLGTS1cro
         1gomNnvsCwOFd0qSvG49w8NljyIixKeKe6LqHoO8HCUPjpxJbfSzv5NLb0P4JlETeZOg
         GUEk6Sw+C3+OlKfuDX9EwBY2OuxpTQwQjq2vI8eURB2CsBZQshEH4aIw0gUZxRfGLL6a
         9sl31o0Scnrpi0R6lDgOXsl1RYl6ZljvPsZDv36RXcA299P3pudZlS1UKycczlsQVKU+
         5qxQ==
X-Gm-Message-State: APjAAAVvlJE7ibUjR5Nz9sTSLTAHkmKwyQLmX/9k7Mu6x8SRMsckELZd
        x8QB7lsgasC8tRlCCMzRd1Lzm8Ta
X-Google-Smtp-Source: APXvYqy8lPXeD324T5m1Ljww60dhHW/aIB1qUXQUS+Dc7m4zwzcQjsv/UWnotTmBeM1TJTaYBtAo4Q==
X-Received: by 2002:a5d:560a:: with SMTP id l10mr17752628wrv.387.1569930817390;
        Tue, 01 Oct 2019 04:53:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q124sm4579932wma.5.2019.10.01.04.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 04:53:36 -0700 (PDT)
Date:   Tue, 01 Oct 2019 04:53:36 -0700 (PDT)
X-Google-Original-Date: Tue, 01 Oct 2019 11:53:35 GMT
Message-Id: <pull.369.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] fetch --multiple: respect --jobs=
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

I saw with sadness that pd/fetch-jobs went nowhere, and read in the most
recent What's Cooking mail that it was even dropped.

This is my attempt to resurrect the idea (although without the overhead of
trying to support a first-class UI to control submodule and multiple-remote
fetches independently, of which I was a rather outspoken opponent).

To make things a bit safer, this patch uses the --end-of-options marker, and
is therefore based on top of jk/eoo.

Johannes Schindelin (1):
  fetch: let --jobs=<n> parallelize --multiple, too

 Documentation/config/fetch.txt  |  10 +++
 Documentation/fetch-options.txt |  13 ++--
 builtin/fetch.c                 | 124 +++++++++++++++++++++++++++-----
 t/t5514-fetch-multiple.sh       |  11 +++
 4 files changed, 137 insertions(+), 21 deletions(-)


base-commit: 67feca3b1c45a51b204253039139b46cc07e145f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-369%2Fdscho%2Ffetch-jobs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-369/dscho/fetch-jobs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/369
-- 
gitgitgadget
