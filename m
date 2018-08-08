Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F33A1208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeHHR2j (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36729 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHR2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id k15-v6so1433102edr.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uxSnwUMcD+XOSD8hR9hF5RqPdrNI9GUIzxFMLIYQItc=;
        b=Z8kmm8jZUAcRfaN05+GPwlJFRybj5JY1vDrd3Ck7cO6M99kKuCEGVcH3NFIYvSdemZ
         TiuJaWXhExAO4QInUry10RFDLI5DAZjZkG7djD4Cdm086hMthlrGC1TcoJYsD6p70of1
         U2abuId6HzHRXCfbiPvz26b+u5mlVwLW1FyULDyC72e3R7deNrtLpyDU51nNCJJeB0VQ
         Z/uR4FbeWjtDUPoefWiLtdxepYkGpIMMW+yq7RNspZZa9fyvtDsdzCIUJnkCWAtKiGr2
         pM0BmvNBXlvL15AcdoNb8xGfhaeyParQsLj3qrBvkIUw4tUXUUhzSR0TsVY5DDEb8JxX
         xh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uxSnwUMcD+XOSD8hR9hF5RqPdrNI9GUIzxFMLIYQItc=;
        b=rHIx5/QBi9EAooF1OqRSOR6PvD1bqnOCSJeKnqg2HDAUqDDhDtB7S2elagd2ie/oGx
         q7tkjGmvMLmwkWMmzfChYNwyBMlBeqSQvgg3N5qqz4uWZpB3mPT60+Jd+uoI8tyzrKEY
         I/CQlID0vbcCU4aNvPYTvzrXYomB8U8c3HLpCq21kGS2kcWTEGpqXlmBeSQOatSI8A3n
         AdVP+XR6cysFBHmV3CbsSx6A2LEBfYLRlzoNuCYXQEAj3UYAJwy5+vUlU6wmgk9u1DnU
         G1MTSjnmE9T3cYEVhAGt+iA0YUbRckVgIAGQJ/JJhqEPavtihzGGPmNC0xZaBUf4T+xo
         lIwA==
X-Gm-Message-State: AOUpUlECETDH3bEUcc4t6BZEfEzeoU7k7KnJNPy6Av0S0X3RSZOaTk5d
        UoZlVMG4apfsjSCjhd992pqyX8Ak
X-Google-Smtp-Source: AA+uWPxWT2MaPwV/fctFlov3WYBIxvQODDcHGINe7KJQQpOLuw8QpB8uJJgx7RjV//4/SoVvJTM2vQ==
X-Received: by 2002:aa7:c1c5:: with SMTP id d5-v6mr3780023edp.270.1533740913869;
        Wed, 08 Aug 2018 08:08:33 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:33 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 0/7] builtin rebase actions
Date:   Wed,  8 Aug 2018 20:51:15 +0545
Message-Id: <20180808150622.9614-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch series implemented essential options and neccessary
configurations. This patch series teaches all the rebase actions like
`--continue`, `--skip`, `--abort`, et al. to builtin rebase.

These actions are important to operation of `git rebase` hence, are kept
in a patch series of their own.

It adds the rebase actions to the previous patch series,
(https://public-inbox.org/git/20180808134830.19949-1-predatoramigo@gmail.com/).

This is the third patch series that brings us more closer to a builtin
"git rebase".

If you like to view the development branch, you can view
(https://github.com/git/git/pull/505), where I have kept my commits up to date
and leveraged Travis(there is sporadic failures in t5520 for macos gcc and
isn't due to my patches) for extra testing other than my system.

The next in line patch series which I'll be sending out today are:

builtin rebase options: The builtin rebase will add all the options supported
by original rebase.
builtin rebase rest: The builtin rebase will convert all the remaining shell
scripts from the original rebase to C.
default to builtin rebase: This will turn on the feature-complete builtin
rebase to on.

These patch series are built on top of each other, i.e. they depend on this
order.

Pratik Karki (7):
  builtin rebase: support --continue
  builtin rebase: support --skip
  builtin rebase: support --abort
  builtin rebase: support --quit
  builtin rebase: support --edit-todo and --show-current-patch
  builtin rebase: actions require a rebase in progress
  builtin rebase: stop if `git am` is in progress

 builtin/rebase.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++-
 strbuf.c         |   9 +++
 strbuf.h         |   3 +
 3 files changed, 201 insertions(+), 4 deletions(-)

-- 
2.18.0

