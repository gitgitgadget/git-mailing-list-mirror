Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56A551F404
	for <e@80x24.org>; Fri, 31 Aug 2018 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeHaU6R (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 16:58:17 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:37179 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeHaU6R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 16:58:17 -0400
Received: by mail-pf1-f173.google.com with SMTP id h69-v6so5783845pfd.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NdQ62Jmhpz7uY9wHmugVkkBRC1fu9vhzv5/PuV0CbnA=;
        b=kZgQ6RNeqa+/DcPSvdXJHqYxkEYwFowpQVj3H+Ug4FLZsA5KM7SHdJrK7OUGKdMmps
         /XwHZGsnFNwBXmfGaZ4MPeN8/mciVTwNRtTuhiGDUg2OEnXVLJbYCiWEi3IaXtmm2B+x
         53XoF/nOi5QkN0eBLvILmOZGa7fpzp/MfXBW6/gLfmltnWLHzuUphGskV7fM4UEhbqQX
         trReigUmS33MU379BCxSjqI9L0LcCvIyeGj8p8AnWO4K2mo7tqeWPH6twdbHe4xRivZb
         m8Uc+F9NaTiX0PjEvHu85bJT1+z303QvmI3HA+xh8Jn5+4XLBpUMViESdKOZWSwjdhKw
         DpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NdQ62Jmhpz7uY9wHmugVkkBRC1fu9vhzv5/PuV0CbnA=;
        b=CbKMnGPwVZKqiegYYZI9jwAZMFP5KCr23UJZw78CoE9a0/ieFAb5Ol1zxg8sciFGL7
         /w2VY0tgwc0JWhF5uE0tJlUpJqz1OqQXseSnBu9psw1tPvAJC0iFIbcutovRwxeJCWgy
         PZ9L91zHGshHvNxu9mCJtOL51JpXmHLlzWJCC7P7BUPdiLsHLz0uy8tHBKUVcahfGEVF
         onSbawkZp1sK3ozPG+InT/PGRF+5LGOaJxntODFx6U6abEeV2EkmPkhLmAosIM7BdXkj
         QGPIM+EHFls881apmfgulGd8stAjRI/UewE9001gAIU0iJo5HXCN3qLj2qP6RRZTN9JI
         oYgw==
X-Gm-Message-State: APzg51CWrg+kdO109JIxPIJmMxC9DktFJsJ1j+MzpCro9qMYkh9Fyz9v
        wMgAZFvMhf8+swDkg0IWHoRiFOrk
X-Google-Smtp-Source: ANB0VdZFIGC3Vv40TLYTK5RTec0//SNRX7sqKVijRftjzcKsvoV/7wbrDVDHt7r2d/8gqQtG7f+1wg==
X-Received: by 2002:a63:5465:: with SMTP id e37-v6mr15332735pgm.316.1535734194709;
        Fri, 31 Aug 2018 09:49:54 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id e14-v6sm14560015pff.128.2018.08.31.09.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 09:49:53 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:49:53 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 16:49:43 GMT
Message-Id: <pull.29.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/8] WIP: trace2: a new trace facility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series contains a new trace2 facility that hopefully addresses
the recent trace- and structured-logging-related discussions. The intent is
to eventually replace the existing trace_ routines (or to route them to the
new trace2_ routines) as time permits.

This draft adds new trace2_ calls and leaves most of the original trace_
calls in place. Subsequent drafts will address this.

This version should be considered a replacement for my earlier structured
logging patch series [1].

It addresses Jonathan Nieder's, Ben Peart's, Peff's, and Junio's comments
[2,3,4,5] about merging the existing tracing routines, ease of use,
progressive logging rather than logging at the end of the program, hiding
all JSON details inside the trace2_ routines, and leaving an opening for
additional formats (protobuf or whatever).

It also adds a nested performance tracing feature similar to Duy's
suggestion in [6]. This version adds per-thread nesting and marks each event
with a thread name.

[1] 
https://public-inbox.org/git/20180713165621.52017-1-git@jeffhostetler.com/
[2] 
https://public-inbox.org/git/20180821044724.GA219616@aiede.svl.corp.google.com/
[3] 
https://public-inbox.org/git/13302a8c-a114-c3a7-65df-55f47f902126@gmail.com/
[4] 
https://public-inbox.org/git/20180814195456.GE28452@sigill.intra.peff.net/
[5] https://public-inbox.org/git/xmqqeff0zn53.fsf@gitster-ct.c.googlers.com/
[6] https://public-inbox.org/git/20180818144128.19361-2-pclouds@gmail.com/

Cc: gitster@pobox.comCc: peff@peff.netCc: peartben@gmail.comCc: 
jrnieder@gmail.comCc: pclouds@gmail.com

Jeff Hostetler (8):
  trace2: create new combined trace facility
  trace2: add trace2 to main
  trace2: demonstrate trace2 regions in wt-status
  trace2: demonstrate trace2 child process classification
  trace2: demonstrate instrumenting do_read_index
  trace2: demonstrate instrumenting threaded preload_index
  trace2: demonstrate setting sub-command parameter in checkout
  trace2: demonstrate use of regions in read_directory_recursive

 Makefile           |    1 +
 builtin/checkout.c |    5 +
 cache.h            |    1 +
 compat/mingw.h     |    3 +-
 dir.c              |    3 +
 editor.c           |    1 +
 git-compat-util.h  |    7 +
 git.c              |    9 +-
 pager.c            |    1 +
 preload-index.c    |   10 +
 read-cache.c       |    6 +
 repository.c       |    2 +
 run-command.c      |    8 +-
 run-command.h      |    5 +
 sub-process.c      |    1 +
 trace2.c           | 1592 ++++++++++++++++++++++++++++++++++++++++++++
 trace2.h           |  214 ++++++
 usage.c            |    5 +
 wt-status.c        |   14 +-
 19 files changed, 1882 insertions(+), 6 deletions(-)
 create mode 100644 trace2.c
 create mode 100644 trace2.h


base-commit: 2f743933341f276111103550fbf383a34dfcfd38
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-29%2Fjeffhostetler%2Fml-trace2-v0-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-29/jeffhostetler/ml-trace2-v0-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/29
-- 
gitgitgadget
