Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908FA20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 19:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbeLJTE7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 14:04:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37333 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLJTE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 14:04:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5845506pfb.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 11:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6URI1MFigUqmGqdgD/p2t23mqFsVIsy43LMvFA7WSJo=;
        b=fWDs64aG4H1WwSlzO3H9dFX5kb/nGiDgaB3fLZ9pSxjSB55tOr09wfPPq/M+dX9JKs
         T84wxLzWrGmsQBzj4Z0XE5tpm3wtn2DFKBzrK/vpdX+gDjZhxfjvPueTco31vIVuBT2z
         Ut0BbcG84AzhbxK4CkkLCqBEA/k2HLt8qXK/lF0e9O0WJWwFyY1labQbDqaqWODPWzbr
         dAX0pBqzTVG30EDFSBAspVMgYcu1csmadfy2cHSicje2S+6Dw0Pu1LJboXpdLtXNL/tC
         J+80MX0w+YLzZBohy2Ict33rS1N4nzhCs3NFeTkmTgaVefR7GhU1cehsy53xFsMfIJoF
         XSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6URI1MFigUqmGqdgD/p2t23mqFsVIsy43LMvFA7WSJo=;
        b=lb9gJqBXwzw8XIyajNhx3t6QhJuhmbqrk0vBqhj53rg06xN1xGrhbaGkjYEMMoU7YP
         RBGhRhSELvApQiXX1iP5+qFhu6pYyAyhtSnRq8CsVnGTlzbbuZubQrnN5EtC3ltm23t1
         WmlYl7Xle/PJutknLZ7s+pSpNBzJG7afVci51j112mY7TsT8Lzuxgl250gN7X3eUDUeO
         ek+t5YYqbZB2O5krhFVRmSTTRJg2VuI9ypyC8UweUZTNhtB0nNXndegu0G78rIZRS3eD
         gwd2Au97dyeDRj1D7NZr8bB7MkZVbGnu4Dg9us7cS2zBReyAq7vXYadYTaJVrtEwEMe/
         gYYA==
X-Gm-Message-State: AA+aEWYLQY2pCAf7TCiht4vVDB4XH4AekYcqR7gSgLjvYzBAvvU+PAmj
        4J5seBuW4ELVt+zlLw91aB+BXsxY
X-Google-Smtp-Source: AFSGD/Uj3GzTaX4biS87K+qOw0MdDfACHvDoXSLFwuWOCxNrKo2HlL3Nx/TfXpmwgDU+MUOvMsBEHA==
X-Received: by 2002:a63:ec13:: with SMTP id j19mr11733806pgh.6.1544468698056;
        Mon, 10 Dec 2018 11:04:58 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d25sm17943619pfe.40.2018.12.10.11.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 11:04:57 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:04:57 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 19:04:52 GMT
Message-Id: <pull.90.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
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

The idea was brought up by Paul Morelle.

To be honest, this idea of rescheduling a failed exec makes so much sense
that I wish we had done this from the get-go.

So let's do the next best thing: implement a command-line option and a
config setting to make it so.

The obvious intent behind that config setting is to not only give users a
way to opt into that behavior already, but also to make it possible to flip
the default at a later date, after the feature has been battle-tested and
after deprecating the non-rescheduling behavior for a couple of Git
versions.

If the team agrees with my reasoning, then the 3rd patch (introducing -y
<cmd> as a shortcut for --reschedule-failed-exec -x <cmd>) might not make
much sense, as it would introduce a short option that would become obsolete
soon.

Johannes Schindelin (3):
  rebase: introduce --reschedule-failed-exec
  rebase: add a config option to default to --reschedule-failed-exec
  rebase: introduce a shortcut for --reschedule-failed-exec

 Documentation/config/rebase.txt |  5 ++++
 Documentation/git-rebase.txt    | 11 +++++++++
 builtin/rebase--interactive.c   |  2 ++
 builtin/rebase.c                | 42 ++++++++++++++++++++++++++++++++-
 git-legacy-rebase.sh            | 24 ++++++++++++++++++-
 git-rebase--common.sh           |  1 +
 sequencer.c                     | 13 +++++++---
 sequencer.h                     |  1 +
 t/t3418-rebase-continue.sh      | 14 +++++++++++
 9 files changed, 108 insertions(+), 5 deletions(-)


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-90%2Fdscho%2Freschedule-failed-exec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-90/dscho/reschedule-failed-exec-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/90
-- 
gitgitgadget
