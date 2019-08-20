Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34211F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHTSh6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:37:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38445 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfHTSh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:37:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so13455197wrr.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WCIVe/8f8tbRtydseahqVtBwcSsn+0kkp4iDJdSqLC0=;
        b=aKdEdu7wmhj8HWH2hNlkMc2a3qikXhFRNu9NTjttjrglUk8EmxRA96dp42ZTPXKhE8
         lGt+u5Rt0NBjAb6jSKhutGBGaVZdv5TtwOKZeceiBwp8RmbnvAowZZ7cdZpy+qxSW+pD
         YSJz+WCbginQIswOYkOrki2kWVnseT8Oj21dFrxRBgkCYoqh6hV4cakb98HYxyxvAS69
         +Hu7V4BKejPOXGKmEm2QrpQE/cAAq+eUiOJbWKEnfL0eqcXg3Yr+niFTvXhI1zyFEqmw
         wTFkkvVq7sfbjNWuaXiGiBU1CHFhfd+arcrwcRa4lkOFzoaCSEP4Uh/jbLkvrANfhe9Q
         yTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WCIVe/8f8tbRtydseahqVtBwcSsn+0kkp4iDJdSqLC0=;
        b=V/tmhf0iBqbpmEyMzJt00Gl0J1dFKWJWbnks4UCLBlnpGKVEvhtNo+imUme3mKe8Gu
         bdCuA2QsKCTzahkdhQsbk6cUX37cSFo4G5dCRIh2ZOr+AWKHxJ527PGB/iiErB7tm1j+
         GP6GgMzAArBI1bsLos0ojpzVCJ/YIx5kdEH1b3TexcCrjGLmWgFtxrjPef9KFjpSl18i
         ch7FzpJyLlGR1v8q2cTBWxKKFgE/fuBjRbhuw+08yJc9v6pSEuWc/wMwAjpKPPBFuScG
         Ad0Xvvvy/IEJiYX0+l/iYFZINqElOYB9FXpSG44dJjI31sjoprRGgvOqDiBMcaHj0O5t
         ZXJw==
X-Gm-Message-State: APjAAAWAY6yt49QiFDlf9+WDvGmesWia+m0irY9pZ0/V/bod5Gb208SL
        DWqnCuZoe/iFSY+DJ72B1LDfA+OJ
X-Google-Smtp-Source: APXvYqyOOoaqSPNLPkGRj032VInWCV/+Wvi6NprkNRy1hM3C3EFeHuFP5pJrAVDKTg+rv0Q9c6yI4g==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr34800536wru.116.1566326276240;
        Tue, 20 Aug 2019 11:37:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm18200727wrp.32.2019.08.20.11.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:37:55 -0700 (PDT)
Date:   Tue, 20 Aug 2019 11:37:55 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Aug 2019 18:37:54 GMT
Message-Id: <pull.315.git.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] commit-graph: add --[no-]progress to write and verify
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

Hey Git contributors! 

My name is Garima Singh and I work at Microsoft. I recently started working
closely with the Microsoft team contributing to the git client ecosystem. I
am very glad to have the opportunity to work with this community. I am new
to the world of git client development but I did work on the Git service
offering of Azure Developer Services for a few years. I am sure I will get
to learn a lot from all of you. 

Dr. Derrick Stolee helped me pick out my first task (Thanks Stolee!) He
mentioned an issue in the commit-graph builtin where git did not support
opting in and out of the progress output. This was bloating up the stderr
logs in VFS for Git. The progress feature was introduced in 7b0f229222
("commit-graph write: add progress output", 2018-09-17) but the ability to
opt-out was overlooked. This patch adds the --no-progress option so that
callers can control the amount of logging they receive. 

Looking forward to your review. Cheers! Garima Singh

CC: stolee@gmail.com, avarab@gmail.com, garimasigit@gmail.com

Garima Singh (1):
  commit-graph: add --[no-]progress to write and verify.

 Documentation/git-commit-graph.txt |  4 +++-
 builtin/commit-graph.c             | 29 +++++++++++++++++-------
 commit-graph.c                     |  7 ++++--
 t/t5318-commit-graph.sh            | 36 ++++++++++++++++++++++++++++++
 t/t5324-split-commit-graph.sh      |  2 +-
 5 files changed, 66 insertions(+), 12 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-315%2Fgarimasi514%2FcoreGit-commit-graph-progress-toggle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-315/garimasi514/coreGit-commit-graph-progress-toggle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/315
-- 
gitgitgadget
