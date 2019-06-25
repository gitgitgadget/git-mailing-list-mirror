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
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD641F461
	for <e@80x24.org>; Tue, 25 Jun 2019 10:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfFYKL0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 06:11:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46059 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfFYKL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 06:11:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so26275873edv.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ze68xgU7U4w8NN9Dt5exlQs24wHmEll8BzRsL7ONUAY=;
        b=lY3Ne5vHB8sOZEMb0KmjfTV+sSoIslepuDpuveLF1AYok73k4Bsd04eRmkgf11Tf6A
         Xsyzy9wj4D1fPYyOZB3KCz6FLOShtsUvi65dgHxoDgJTTOkt5w5LiWowFoEp4UhL2gsD
         rwbS4A6ugTuecH5fsRdr17arGouNHnJoGWnVv5fvLCg3yrHWb8TL2MgBsrpXEX0cN928
         PcGg7GwKK7GC0sQQpFu5sUfQz337Q3XgTDbsa/Y8qatXX8oM8rBvqb4H5/RT8ue16rVf
         eumjFRlGvokq7GWxWXAQTLmKJW+ZArEoVTmt2BXaRsW8NzXfqK6x+m7HWD1j+W86VBxE
         vI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ze68xgU7U4w8NN9Dt5exlQs24wHmEll8BzRsL7ONUAY=;
        b=fme9t7wNmkNitRJCH10syHYHTGZg3OCWrcNiuqii0h4+ZePOVK2wK1gTWYUF6o20Wc
         3N+XeSID108yWwCQllrkpDmz8jFmYQbtwupzdWanDHuMSZSG/bdrOzjQ98AmQ1Tc2sEo
         5ZDSJzp+dV+9LJcAgtnbMETLCupzIcM86vMKqLJMw0klNyD4BnuAmFjotPVUgUDuUBI3
         uj6q0GT8yj018EiX61hQ9ofqoQE/A2UGexqSCgxzRvpyrchoncUZ47hBHndJFUoxXCik
         fBs6nv8TvoviskwWqGZdtJo8Oa7S9fDmBnwTWqO7nRL1hWczqup7xbmFbLC7QsENOwdX
         3r/g==
X-Gm-Message-State: APjAAAWH9gx1laUntdAP92aVpkvIe6DgCPoQpM7yJK0mVRV7trypVEl2
        HS+UjqJ0yJl2RELDs2LJfxApo4dy
X-Google-Smtp-Source: APXvYqzlLDC/u7Ytl5pOng9avqGZ8/YoVV/2RXpJ0EZvyMLHCichTWBfWiXC/L3sGn1x2Qq6jHUKfA==
X-Received: by 2002:a17:906:6582:: with SMTP id x2mr13599751ejn.2.1561457484902;
        Tue, 25 Jun 2019 03:11:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l38sm4615287eda.1.2019.06.25.03.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:11:24 -0700 (PDT)
Date:   Tue, 25 Jun 2019 03:11:24 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 10:11:20 GMT
Message-Id: <pull.275.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Wip/quieter sequencer status parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we cannot parse the oid in the sequencer todo file do not show an error
when running git status but instead report that a cherry-pick or revert is
in progress. This addresses a confusing error message reported in 
https://public-inbox.org/git/3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com/

These patches are based on maint

Phillip Wood (3):
  sequencer: always allow tab after command name
  sequencer: factor out todo command name parsing
  status: do not report errors in sequencer/todo

 sequencer.c            | 43 +++++++++++++++++++++---------------------
 t/t7512-status-help.sh | 16 ++++++++++++++++
 2 files changed, 37 insertions(+), 22 deletions(-)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-275%2Fphillipwood%2Fwip%2Fquieter%C2%A0sequencer%C2%A0status%C2%A0parsing-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-275/phillipwood/wip/quieter sequencer status parsing-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/275
-- 
gitgitgadget
