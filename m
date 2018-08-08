Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A347208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbeHHR63 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:58:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeHHR63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:58:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so1482987eds.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QchmznPcz/KjKHV8BlduHwPDmnasqkvZeKrwFEoCCg0=;
        b=HuraqflAPDUjkqpoNgYksjmZEBQnxowufR3hCfqZHpO5+NrgNfXzOU6WKrge/yhH7e
         Z4quv9JjFRCh6nWXmMO8zaAyChdie1dBLOsC143Ot++cLg99LWqPCk0s7W6wz4SuAKal
         0aPgiAUbsyP4/7yeTD9Q9pn0Y6K9vBcwG4vPJWgk1rRiH1qVtayvBNxlSicTxWF5reo0
         0dKdPjt0kvu5eC1rnLhC6IzrYKSLvPJuRO1imdRQwmsDbTlitMxbmZUYSsYoA+ta+rKh
         hcWm5HRjDl+PpWbzZ8+VWr02dsyOsuf1seVnHY1O1l7claMQT70NcAT4hpV6jmhyyKQt
         X1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QchmznPcz/KjKHV8BlduHwPDmnasqkvZeKrwFEoCCg0=;
        b=rGDvc7DgoJlVWzlUEzpclvpKyGVijBtNYumKYf/c+lkeRlSpqaC3zXqaUkxjzly09C
         NyGACzX13F+ByjYr8dSQY1zGH+N1k1/pBxornipW8H4jfE2wGlr5MjI5B7Qbe2t9Z26f
         A3mboHgRLYPtmSn/cw02AXFAse627Pp3Bx5laEt/4wVVK8ewVHVVJL07jsZdkzmjRugq
         ZnPmQlcQCoDNOpK/VJvI7m7Ho76P382jMnzfih3kRPaLgVXHqHnkekbV6xkpw8qdfIN7
         uPU8DRk7tGCSPtoFBWsMEMejW3GtCagAHOdKAXtqjF7QP4lEVh5GfnzydQxuW4visE6G
         VS4A==
X-Gm-Message-State: AOUpUlHtRknxjNOJzkwjFoQDgwQ1rvqJtQX9jiJP6ArZ8DF41ojJ4EvJ
        S+k0EaIf43eUl7L/+BAn9LT4Vn4c
X-Google-Smtp-Source: AA+uWPwjcIY1vpMRmKHTUCJOHkq2Rl/APpXcltJ83xgpJSnd0pY7gI90jeQNbpvLfUpz99//Erfjog==
X-Received: by 2002:a50:9069:: with SMTP id z38-v6mr4019968edz.79.1533742695884;
        Wed, 08 Aug 2018 08:38:15 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id d11-v6sm1904876edo.39.2018.08.08.08.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:38:14 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH 0/6] builtin rebase rest
Date:   Wed,  8 Aug 2018 21:21:29 +0545
Message-Id: <20180808153635.19944-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch pretty much converts all what is remaining from the shell-script
version of `git rebase` to the builtin version. After the conversion of
actions and different options which are important for builtin rebase and have
been organized to make a patch series of their own. There were still some
leftover shell scripts on the original rebase and hence, this patch series
addresses those by converting them and this completes the builtin rebase.

It adds the functionality to the previous patch series,
(https://public-inbox.org/git/20180808152140.14585-1-predatoramigo@gmail.com/).

This is the fifth patch series that brings us more closer to a builtin
"git rebase".

If you like to view the development branch, you can view
(https://github.com/git/git/pull/505), where I have kept my commits up to date
and leveraged Travis(there is sporadic failures in t5520 for macos gcc and
isn't due to my patches) for extra testing other than my system.

The next in line patch series which I'll be sending out today are:

default to builtin rebase: This will turn on the feature-complete builtin
rebase to on.

These patch series are built on top of each other, i.e. they depend on this
order.

Pratik Karki (6):
  builtin rebase: optionally auto-detect the upstream
  builtin rebase: optionally pass custom reflogs to reset_head()
  builtin rebase: fast-forward to onto if it is a proper descendant
  builtin rebase: show progress when connected to a terminal
  builtin rebase: use no-op editor when interactive is "implied"
  builtin rebase: error out on incompatible option/mode combinations

 builtin/rebase.c | 150 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 15 deletions(-)

-- 
2.18.0

