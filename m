Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F541F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDCda (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:33:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35794 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDCd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:33:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so2036237pgb.2
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tuGoOpewTmz1Aa2tv1DyxpF1NDYGfRq2QnI+NXLROYw=;
        b=VJ+bF+6k5DWLhKr1xPvcflg083TKVaVM4GQsg6C1k2XHwOWHwOj2LV7qs2TL/SG5wQ
         TscZkED3gRL3hBcv0D16rUE/J0ohuoAPiT2bLTvr8plJGyiu5g8tMoqvCj8uE9gSrqFK
         RcoeJA8hgmDbwSi37/f4tPIBUV5Trdf6gsUphBenHCaQSL5cQcUnMS1bE0h/g5flsfyT
         1SR5+BLu7UeemN9vTkhhXzI+ewPNNX6OM34RKfRTneTbB95oU5GYunXBCLV0YjsM+YtW
         7tOn0IImiTbnD6+WtR6RfcpUc639UWwwk4Df/7jumV/eKnUv4L2K+9N9sTtq202yZ8LO
         lmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tuGoOpewTmz1Aa2tv1DyxpF1NDYGfRq2QnI+NXLROYw=;
        b=DvU/ZCuxiibI0QNxVJMteZ1181c6X2gRDceYO/D9I6D76CgpdDrqR4DURtryiTlIHl
         gsFOEVphwklYonedIFb1aE31F4FJqBFtevpVni0mfbhAPacacQ2u1y65/OTYuwmuPD9e
         6l+wI58o0GePdOnq+rnTt+q2u1e+bcASEy5dgtCdrU5UruzDCsiOU48FQNkgZtXQIajn
         4+N098bZ3wvhui83TpmTun8IsL/Jbn9qi3WGYUbKuCeLIC6f0fXcrWgZYDCogIq0YG6q
         kcXCrtnj5wlcFTwNjKQy19aMM6+3Kb2UIDVan8NIiWQy2RVKIdb6eV0zTVBQMqcCNztn
         o2XQ==
X-Gm-Message-State: ABuFfojtoA4v/3K/COJBTkcJAnUDC9W1UU9iVrMJdGqw7ErLs3Fx6pea
        E6LzO3whOtZgB6A8zaLVPWZh9rm3
X-Google-Smtp-Source: ACcGV60FA4Jk61pBTVvFiKQEjYu6ol9mkjHyTmuPtgMiGErfLWRByvILRELdubZkPNiVFLSCSvYYsQ==
X-Received: by 2002:a62:ccd4:: with SMTP id j81-v6mr3285553pfk.76.1538595820797;
        Wed, 03 Oct 2018 12:43:40 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id d7-v6sm7330997pfm.23.2018.10.03.12.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:43:39 -0700 (PDT)
Date:   Wed, 03 Oct 2018 12:43:39 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 19:43:34 GMT
Message-Id: <pull.44.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] mingw: require Windows Vista or later (and fix the Windows CI builds)
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

I noticed that a recent GitGitGadget build failed in the Windows phase, with
compat/poll/poll.h problems all over the place.

Turns out that this is caused by the recent upgrade of the mingw-w64 headers
and crt files (7.0.0.5233.e0c09544 -> 7.0.0.5245.edf66197, which I assume
now enforces Vista as minimal Windows version also for all mingw-w64
projects).

Luckily, in Git for Windows' master, we already had changes to require Vista
(for unrelated reasons: to restrict the std handle inheritance when spawning
new processes).

Technically, Windows Vista is already no longer supported
[https://support.microsoft.com/en-us/help/22882/windows-vista-end-of-support]
, but we do try to keep Git building on older Windows version, up until the
point when it becomes too big of a maintenance burden.

Johannes Schindelin (3):
  compat/poll: prepare for targeting Windows Vista
  mingw: set _WIN32_WINNT explicitly for Git for Windows
  mingw: bump the minimum Windows version to Vista

 compat/poll/poll.c |  6 +++---
 compat/poll/poll.h | 15 +++++++++++++++
 config.mak.uname   |  4 ----
 git-compat-util.h  |  4 ++--
 4 files changed, 20 insertions(+), 9 deletions(-)


base-commit: fe8321ec057f9231c26c29b364721568e58040f7
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-44%2Fdscho%2Frequire-windows-vista-or-later-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-44/dscho/require-windows-vista-or-later-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/44
-- 
gitgitgadget
