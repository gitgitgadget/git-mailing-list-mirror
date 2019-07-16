Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13FEB1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfGPODP (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:03:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42212 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPODO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:03:14 -0400
Received: by mail-wr1-f49.google.com with SMTP id x1so6095926wrr.9
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=c/4b+2/GCn08V2SLSIE/E6Q9ldRMFISt6PjhbHB9lRs=;
        b=Z9G+caL1n4VfiKVC1Wa0MZh4hLNtAmQuiSY0DpP7HmGpPsA67w7n1rHd0SIoJ0s2Zk
         beqpz4prERwjmrYZpJ9cjeq4uaW5yGvNABz4znD8frWd3d7E9PMkhMLyjbWcPzym/144
         lSC/OIutgY1/ehaoBbXI705HyMrS7BIU4/3ZEdJGnDV81Vhclq6xhO9Ez0HxfzvdxfSk
         zt8VVIxkl9tQ3GP4GarBTUDhKA2NrPWQZvwhsOOKlOPRGg8qu290AjyMoLJICLc+PH0M
         hOn2h68QdHED2CUSsxqGYvi1Uo6UCwQI31K4+gyZAARv6sXO3z8nunbcKD7we6zdNnd8
         1tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c/4b+2/GCn08V2SLSIE/E6Q9ldRMFISt6PjhbHB9lRs=;
        b=E+VTM4Xz3eGcgyvsW606p5vrt/deBZGLwELhpfB0+cRoZNf7scaaGyPaLlu3VDPeqd
         LGOVthdLD7zaOEpCbj9JYNfRpdJg9V74+H1k3/cdH5uLcz0UESQSouG4biWEO0qoXD3j
         wU8n+1qpiSq0tTC3TqoPoBTib6eH+xGmFPnO8Z3zuHiqEK+wxmZ0y2E+Aa4dCUkRDuWM
         pvQApgRFf8FXhVHC6ROqIb4lk11t48VMRqrDas8c+ZTtff9ym/gFSxqD4+lqvzWhgUbg
         TbYUSXDnXd7cw9XfpHZrlKJyD091fq2HHeOrZN6cr/BJDG7DaqmlYbcZLFFRfNlzPXJT
         SJlw==
X-Gm-Message-State: APjAAAWOIii/CmRWPqLc8FNfGBk4wxcLkPv4BcYWK2CQ67dJmEeBC3nn
        5VwgzXDcc8GXIGy/ymfHEx5HFRVx
X-Google-Smtp-Source: APXvYqwOxt5DFhuHxj1RL9XPqJM5HGuNQNcbQ4D5RA5sfNmxx+lYHs7R5wiszzb0TXKD3B1Dmra3EQ==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr7328691wrw.185.1563285792385;
        Tue, 16 Jul 2019 07:03:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm16883051wmc.21.2019.07.16.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:03:11 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:03:11 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:03:10 GMT
Message-Id: <pull.220.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: support spawning programs with paths containing spacesnames
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

This is a patch to support older Windows versions (e.g. Windows 7) better.

I know, I know, Windows 7's End-Of-Life is now less than half a year away,
but... I am unsure just how long Git for Windows will support Windows 7
beyond its officially-supported life; We still support Windows Vista, after
all, which has been "sun-set" over two years ago.

Johannes Schindelin (1):
  mingw: support spawning programs containing spaces in their names

 compat/mingw.c         | 8 +++++---
 t/t0061-run-command.sh | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-220%2Fdscho%2Fspawn-with-spaces-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-220/dscho/spawn-with-spaces-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/220
-- 
gitgitgadget
