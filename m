Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CEF61F597
	for <e@80x24.org>; Sat,  4 Aug 2018 19:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHDVYt (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 17:24:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38678 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 17:24:49 -0400
Received: by mail-pl0-f65.google.com with SMTP id u11-v6so3964260plq.5
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3wXr+8OjwzxIzXtgdxHpAEdKpVKWfxnuHtpEnjtE9pg=;
        b=Jq+SbYCUTRbDqeOVqwRyVsWiFk45h6PKk5udFqZWr1OejN3sDV8bMY+DMIUtGF+GBw
         9IRTYSYMosJ5XnznECdEXmq/AKRiBJtl+ndHUst6eDoBrobzy187UtvhHCoqGACTJUcS
         sjjoGgunjXsAXWbR9ixgBKjWmQ/rSUnUoqMUD78VR1tTIgeQxbYkl0pvbnJhtCP36ap4
         576fKSK/jlAOZeM9foa6rx9HrjqvsXDA0i+LpdmNlc27KYzpj6fvQZhrah7fEqZRxRsW
         bTr9JkD7QwnZVIS3zb8EhoDKWOfQpjaIrLVbt+/J5KsTVMs2TOXME+xFhwCnKvalyRpH
         2C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3wXr+8OjwzxIzXtgdxHpAEdKpVKWfxnuHtpEnjtE9pg=;
        b=beS0xqhp1f/idQSx5B9LZbLqa8lEjhd79tZ9Vaz6nYWEOjR69HsvctObFr48tMTur+
         QY3uGv7+yQio0wGIHTHosTqs5BbDKRjOSfWxvXMqzjaLt9Ey91Pfq2wN6zlVR9pixe5p
         AXy9Fv4/Cb0fasnoweCfGLB72f0Ey3S47fFDy8TFI8jY5TNdz9IdeOFEfzYE5ZUl5UE/
         JhMhj872VYqs3x7WS/vS531GXiLhLzf9WjFecT5FqB7lnK/S8Adnsxkqcw3x4wOSbI5d
         aNSXAn2aIrS4BBp01XdYKO84YbayKaPAtTFghIcrGAPybBvTZL2EJfzc2cPSOMMKMq2v
         vfFQ==
X-Gm-Message-State: AOUpUlG2olVyQREJEuvlEDIgdRH48LmOsqO5796QXgKVEEayNpXQ1Fwd
        cRKrC1qCKALPK3eFyt37Fsy0qzFC
X-Google-Smtp-Source: AAOMgpcOT4VSS7LyC2kCBv1Rz8mBaSIeg+u57C4+ux2qt/2pFwjkl3AjYDdpnHluzjEtdBA85n+NMw==
X-Received: by 2002:a17:902:290a:: with SMTP id g10-v6mr8199746plb.110.1533410588969;
        Sat, 04 Aug 2018 12:23:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id s195-v6sm19185427pgs.76.2018.08.04.12.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 12:23:08 -0700 (PDT)
Date:   Sat, 04 Aug 2018 12:23:08 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 19:23:04 GMT
Message-Id: <pull.14.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Support git pull --rebase=i <remote> <branch>
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

The patch [https://github.com/git-for-windows/git/commit/4aa8b8c82] that
introduced support for pull --rebase=<type> into the Git for Windows project
still allowed the very convenient abbreviation

git pull --rebase=i

which was later lost when it was ported to the builtin git pull, and it was
not introduced before the patch eventually made it into Git as f5eb87b98dd
(pull: allow interactive rebase with --rebase=interactive, 2016-01-13).

However, it is really a useful short hand for the occasional rebasing pull
on branches that do not usually want to be rebased.

So let's reintroduce this convenience, at long last.

Johannes Schindelin (1):
  pull --rebase=<type>: allow single-letter abbreviations for the type

 builtin/pull.c  |  6 +++---
 t/t5520-pull.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-14%2Fdscho%2Fpull-rebase-i-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-14/dscho/pull-rebase-i-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/14
-- 
gitgitgadget
