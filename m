Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFFC4743D
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 17:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C983613B4
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFERyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 13:54:24 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40611 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhFERyY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 13:54:24 -0400
Received: by mail-wr1-f43.google.com with SMTP id y7so7896867wrh.7
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GKEGmttsvaDxaVV7oXwEtw6M5fXsz9qefv8FmpTsHkE=;
        b=dFqdqwddGHnR5uKGBapgpeSj3szUPhEMl6E0CkcySaDTcedJr+/sbZVNNkDAd55Q3x
         gEfhJNwUr5BZO11gSo4OsK4l1afq3o1akD2GsCGlH//dpq1tkLfETZtJYLyNux8LePqe
         Vnqlmd4T4xI0pS1xhtkuKVF01nfkybjaqp3zfX9cbFnIPxGh1dPTw5DXNa4Z7/2LGTv9
         3W+YiJUAbYSmNluJEZ1/2FhLh6S+vnivoJrc7Mu1YhROW3n3YSNedV8diR/fijkka+NM
         hbu4q8mhXprnTW0rhetRf+pT4Uhs4B69gDBoYiR5Y4YqvlBWsnySKCiNg9E85pq2/Vqi
         loAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GKEGmttsvaDxaVV7oXwEtw6M5fXsz9qefv8FmpTsHkE=;
        b=ndKNzp31Q4w1ZVALdSecGRQez2oack8VzVKRXeGPod79CLOU74mmcukAYkYGHQpYMB
         HA/kX/jshDShQV2vnufqT4resU/D4ohvfNECNxUmCBMtD9WN22W+tBZd3eDamn+lysPQ
         KrqqbSMCoVxVWMcN+R287xNLZyle6jufxcynqSXar55UXKB9eAP+l9PLDoYMMbzZZYY9
         fgn332SCcyRZkfPoiUFhbSEXNkEtIXKLzxu47nv7yO9LxHd+wgNzP8N15Fh0HWg3Sy2f
         OzAGZIV0eXw4vMnjVqBHvnRb60LqnipA90scvgRWPT1Rv785sUyfuvutMtonB2T+zWTz
         KCqg==
X-Gm-Message-State: AOAM531FCXd+t+kepaSzaszsWR4XqdkGYRlrFghxIqUSeyzDCTvtrPSf
        GwFveW+qe0Eq9j74WVSZ65OXcYuhl4zKxPCNm1aamtS7a3p7Zw==
X-Google-Smtp-Source: ABdhPJw5oCLS4Ab5UcCWjyKUUEWn2GUP5v2G7rcaEsp6dSeXqewqSgzKjfSJOjNqWsytted/T2hIlkG7vng05oXb3+c=
X-Received: by 2002:adf:efca:: with SMTP id i10mr9472194wrp.139.1622915495452;
 Sat, 05 Jun 2021 10:51:35 -0700 (PDT)
MIME-Version: 1.0
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Jun 2021 12:51:24 -0500
Message-ID: <CAMP44s3DodJ6giL_CHmUvsv3t6w4aUAS6A1STtL3yNRgBnPutw@mail.gmail.com>
Subject: Blog post: Adventures with man color
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Work to arrive at one patch (e.g. [1]) is many times non-trivial, even
if the patch is.

Part of the work is explained in the commit message, but only a tiny amount.

For a full explanation of the removal of GNU_ROFF I wrote a blog post
with much more detail:

https://felipec.wordpress.com/2021/06/05/adventures-with-man-color/

Cheers.

[1] https://lore.kernel.org/git/20210515115653.922902-2-felipe.contreras@gmail.com/

-- 
Felipe Contreras
