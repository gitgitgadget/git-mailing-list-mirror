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
	by dcvr.yhbt.net (Postfix) with ESMTP id 287AC1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 15:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfJ1PBD (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 11:01:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46500 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJ1PBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 11:01:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so10205437wrw.13
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Vi/A4DG1+KrCvEWXNjKueA042NMXsZjwiRU8gnigqTY=;
        b=U8/agZg2aRu3d6yhSC2mwvF/HZmsEXwFMOm+1rCx6P1Gw08VhV5nw1Zy1+k1dik+du
         U6dMCghTMb+neEMw1AAO1pXAsyQZ72YwvPPBJt/tHD1BnxLIokCi3+UTvcrT67izGYmF
         KmSFrHjGQt9xTiWD3K6iZIr9ymW3gQDO0y5ASvRU1aZt1hujgkRKrxB95Gu/noN/zs9p
         9A0jTre02VqOOopDiXkIf79wgGOuyI9d3WdPy4Bc5MWzRld9hUKlmfvHK3IXVpEkScZG
         t6WWk8Dp05nfnv+rVqULml0dfn1+HkqLBUe9OWl3uc5Pi6iX4DuUQTe1980jpL9DXkR6
         onrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vi/A4DG1+KrCvEWXNjKueA042NMXsZjwiRU8gnigqTY=;
        b=YM587dBDIYT1w8b7y/2ON+VckLovgP09qB0EHIKa1jxiyGb54P0XggPdTVZPuQfw5A
         YFiJswWIgUBSABctpvsqaB9o1lsXYMyn8vZs0s57Z/Qti7GjspA6OwmZsTIUXDxsw6oK
         pKujvSB+5LLiTgIIqQPDJAMszyKjEuVziq8VgT4v9hAi7AuuE9SklkAWcb0gyxWTbKHX
         V5q+eJjvw2Yuwg8WDMQbn+LzzsrWVWouRUKZx6XpJQnPhc2IIu4MPfA+j4A+MlhWs5o+
         rFUTnpAbSPHXdwKeMmX3G1+LIoegOxTBMXOPrBfv2ui+P6XZgZ75St3CKsPxfmeXInZe
         4FIQ==
X-Gm-Message-State: APjAAAWk6bfxmjfIXLYz+3JbIjPma/wONG+94X6uQ5z4pZYSEHK6ugCB
        aTowqaudjLciNQvMDI0b1qt9xDHd
X-Google-Smtp-Source: APXvYqwy9ADMbDgcF24CMqqVr/hVvCvnAmOytz4L+gJsbVBfTyvxEREs7mtD5feXy0TjhtwAV7z9fQ==
X-Received: by 2002:adf:f04e:: with SMTP id t14mr15886998wro.106.1572274860844;
        Mon, 28 Oct 2019 08:01:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm17152468wro.36.2019.10.28.08.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:01:00 -0700 (PDT)
Message-Id: <pull.428.git.1572274859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 15:00:58 +0000
Subject: [PATCH 0/1]  Fix t5516 flakiness in Visual Studio builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Among the flaky tests, it seems that the Azure Pipeline suffers relatively
frequently from t5516 failing with the Visual Studio builds. Essentially, we
grep for an error message, but that error message is produced twice, once by
a fetch and once by the upload-pack spawned from it, and those error
messages are usually interleaved because of MSVC runtime fprintf() 
idiosyncracies. 

The commit message of this patch is based, in part, on 
https://github.com/gitgitgadget/git/pull/407. The patch itself is a much
more minimal alternative (using xwrite() instead of fprintf()) to the code
of https://github.com/gitgitgadget/git/pull/407, avoiding the complexity of
the part of the code that allows for unlimited messages.

While it would seem theoretically more elegant to allow for unlimited
messages, in practice too-long messages cause more problems than they solve,
and therefore we already clip them, and this patch does not change that
behavior.

This fixes https://github.com/gitgitgadget/git/issues/240.

Johannes Schindelin (1):
  vreportf(): avoid buffered write in favor of unbuffered one

 usage.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-428%2Fdscho%2Ffix-t5516-flakiness-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-428/dscho/fix-t5516-flakiness-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/428
-- 
gitgitgadget
