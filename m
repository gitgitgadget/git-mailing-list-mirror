Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA65B1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 14:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeKGXbT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:31:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45577 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKGXbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:31:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so6918697pgc.12
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 06:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Us5IqtpabCFWcT2pGyppEl7zRp7ueWY6C60AFiuq1kQ=;
        b=WfwhN37Ak1NfKJ5zb5PB5U88HmxyPJ8IiPz3h/48ChPOz4Lr1SdoK6F5a2WC36rTrR
         ghVREOjXUxt8mSvhTLufgTzKEOmfhakdibmaLe4PggrMRwZiJ+8Tf97L4IgWnCyyUJxl
         sgUhEcy+Z8EbnSae6sh7U6MIFAg99nmemwdsvk1kSEclEUasvDBwYuHH/PGKUt+JHqhO
         oiNTVul85Z34wi8uUD/bEy1HSlCbont8FCsWLIQc49EVws02a5GGXwiYK17sFdtFlGBz
         qwTgMdZBmKpC4Fz28tE1EowlJfotJp66KViMJo1DNWruqR0lde3wCoyk7r2Nwzp8UMqI
         lC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Us5IqtpabCFWcT2pGyppEl7zRp7ueWY6C60AFiuq1kQ=;
        b=CKhzOLuWDt1s1NUX/woU4BUP7+bbQVDsKImIggySgcW4Z7+mqncnO2oSeNUXtYnd/a
         Zye3zPDpfFARVq4RDtVmt/VFFA4+PsO7JDAStCHPpyWAAqNKVJJ79/OIzfFl3DKm61/u
         203j1gCVJYQJlKphgMWfDjR42JsLd+KPUSGH4Je11ZPuDIkEVQfngxmv1SvMRp7s/O/P
         ZeM3pViOhPHEKUkTVuo8jVI1IfrfEhn4o2l75YCwAyD6n1iT5FumA/vzAIZnVyNn2D5S
         sR4d4nxzEI1cW1nKY77GSQe9WzxaWCSgI4tzQLzixuQ33OiWJFhKEoVckoo62IhXPGEb
         voKQ==
X-Gm-Message-State: AGRZ1gIBRCPgzf6pQx1S1ckkoyNWPkskMz1Ou/e3XHaVU1SbCy1SlqT8
        qe2xxgAxvHh5cd91GWiaiy2KeWUomoI=
X-Google-Smtp-Source: AJdET5fmHmt6rzZYR+XxPLChhrWUScHBb55iIR6yC52KuqRhIsQStx2g9u0ZrhmQHrSx/nGvF2dt0A==
X-Received: by 2002:a62:8a91:: with SMTP id o17-v6mr323763pfk.210.1541599248227;
        Wed, 07 Nov 2018 06:00:48 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id z2sm826901pgu.4.2018.11.07.06.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:00:47 -0800 (PST)
Date:   Wed, 07 Nov 2018 06:00:47 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 14:00:43 GMT
Message-Id: <pull.70.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] built-in rebase --autostash: fix regression
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AEvar <avarab@gmail.com>, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported that the new, shiny built-in git rebase has a bug where it
would detach the HEAD when it was not even necessary to detach it.

Keeping with my fine tradition to first demonstrate what is the actual
problem (and making it easy to verify my claim), this patch series first
introduces the regression test, and then the (quite simple) fix.

AEvar, sorry for the ASCII-fication of your name, I still did not find the
time to look at the GitGitGadget bug closely where it does the wrong thing
when Cc:ing with non-ASCII names.

Johannes Schindelin (2):
  built-in rebase: demonstrate regression with --autostash
  built-in rebase --autostash: leave the current branch alone if
    possible

 builtin/rebase.c            | 3 ++-
 t/t3420-rebase-autostash.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-70%2Fdscho%2Ffix-built-in-rebase-autostash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-70/dscho/fix-built-in-rebase-autostash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/70
-- 
gitgitgadget
