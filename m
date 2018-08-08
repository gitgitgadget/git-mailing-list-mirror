Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D97B208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHHQK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:10:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37736 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeHHQK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:10:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id b10-v6so1306057eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ALNH0nJ/0xctNQVhjQma5Ionm0S9phF6EpU1HRf6M2Y=;
        b=FDQ6Mg/srKl58W2lGUCtHbbm4brIRmJWarRt+lSMHT3Zz1k7sC6B8bavhT+sPf+aU/
         GIVt8lO8HY/y2kdGkZbNNuAzlLQUZnouPIVkaIKYvlr69sFC1w4rls/AqAw8xu+akj24
         rhFjY36mXXmMkVIdX/xQe8QqSS/df1EgAGQjg7EynvLqgR7vjQ/dkKFdctDibBO6wlnV
         bNHuCBy/HKi1NoC91a5X+HIuJfDW1pE4ZG3W6Wr29MkIBtbpESq5T2hiBpZTTBy3Ij+X
         CHYMuIwbHV5CZGoGBSQTbW/v2Mf8q1TQTYbbN441JXlJr0BIuG9QV12TKyMf/23TH3X/
         R3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ALNH0nJ/0xctNQVhjQma5Ionm0S9phF6EpU1HRf6M2Y=;
        b=ILDwlbsMxEHt14jfRNljfXL9njaIJeYmAWvtA1FN20XPNulawtkYV6RYZHzUAZD/fK
         unJttPgNWPcx/ULRa3Jd8uezhlbpBaqiHY1QFg5rjjiv/fUwOYUWOVhC8l5b8juRdkRl
         DFTgaI1ehA427xs60H4gm/igKQDoxUaYCnoURJfCQGokoj4+6GbxHqQETj5Cea5xvQcO
         YMYFb/7r+vKGzDiJoCJTXMJLTqkHAvuy8IYcxu27zPCaXi6F+iq1iI/XpNpNPaGKSPe+
         HMjntb8wDtRvbIo1DTCM8ffyF0MDnW1kDpDLPOJgMkMtgs+HoxOqt7XrajoJlEf1dPDv
         tGYw==
X-Gm-Message-State: AOUpUlHPyjfjayq09ExBoDYlmV6S/Qm1ST7AOX7GGRdGtCw8omWk99Gr
        kgIhxfWxwRmTPOBSB+uqj8hsD/Lx
X-Google-Smtp-Source: AA+uWPwYsfqPbPOMLZKEkOjIQ6l6x3B/s3GjqYd3CnWBqyHAYe4VtyH1hl7bPXBXNGr/feUewv63uQ==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr3506642edb.174.1533736269168;
        Wed, 08 Aug 2018 06:51:09 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:08 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 00/11] A minimal builtin rebase
Date:   Wed,  8 Aug 2018 19:33:19 +0545
Message-Id: <20180808134830.19949-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series provides the bare minimum to run more than the trivial
rebase (i.e. `git rebase <upstream>`).

Here, I have implemented essential options needed to make this a
builtin rebase. Ofcourse, to accomplish the task of builtin rebase, I had to
do essential optimizations and add certain shield which weren't present in
original rebase.

It is based the latest iteration of pk/rebase-in-c, i.e. ac7f467fef8b
(builtin/rebase: support running "git rebase <upstream>", 2018-08-07).

This is the second patch series that brings us more closer to a
builtin "git rebase".
If you like to view the development branch, you can view
(https://github.com/git/git/pull/505), where I have kept my commits up to date
and leveraged Travis(there is sporadic failures in t5520 for macos gcc and
isn't due to my patches) for extra testing other than my system.

I plan on submitting the next patch series today, in this order:

bultin rebase actions: The builtin rebase will add all the rebase actions.
builtin rebase options: The builtin rebase will add all the options supported
by original rebase.
builtin rebase rest: The builtin rebase will convert all the remaining shell
scripts from the original rebase to C.
default to builtin rebase: This will turn on the feature-complete builtin
rebase to on.

These patch series are built on top of each other, i.e. they depend on this order.

The motivation to organize these patch series is to make review easier and
for pleasant read with the help of my GSoC mentors since, this is the final
week of GSoC and other GSoC students most likely have submitted their
respective works which will need lots of review.

Pratik Karki (11):
  builtin rebase: support --onto
  builtin rebase: support `git rebase --onto A...B`
  builtin rebase: handle the pre-rebase hook (and add --no-verify)
  builtin rebase: support --quiet
  builtin rebase: support the `verbose` and `diffstat` options
  builtin rebase: require a clean worktree
  builtin rebase: try to fast forward when possible
  builtin rebase: support --force-rebase
  builtin rebase: start a new rebase only if none is in progress
  builtin rebase: only store fully-qualified refs in `options.head_name`
  builtin rebase: support `git rebase <upstream> <switch-to>`

 builtin/rebase.c | 333 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 320 insertions(+), 13 deletions(-)

-- 
2.18.0

