Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 978EF1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfGYKLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:11:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33034 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfGYKLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:11:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so50213683wru.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uKQ71AQsygHOwZULp7pxv0uWuvFGVLtZwwPnGtv+Q64=;
        b=jLSZZiYYGl+a6Bl38qFoKNf83z6zcv4n1UIeiLDkenr2BYMne9UM+9sDuTrf6tc3lP
         fK+KFkg27PChEVDpBD9c+vnK5/Ib+EgL+9AX3JCiTEMn9s+JfXpRiec+Aczn2dRnqlo9
         h+t2cdpHavWZ52Tc7bk0lvOALNB9N6hErLQYwOJ3zRgrHy3NTt9bhBPNv0BYHtUHQx+F
         5O/0mxUKK4DAfrVdWSuV/Q4KzJ5eXMNPzb9RAmddTZaIcyy6ow4aKYSpeubZDb7k6hVp
         63wh4ceQB2eEUB+6Hm7dV5pTZX4eBZaTBPKp8m0tasLnpjYRr4ejav6h7IqrDULIaDub
         DJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uKQ71AQsygHOwZULp7pxv0uWuvFGVLtZwwPnGtv+Q64=;
        b=DlT07rSnlhbgF4bF6/5AmM01XhpdCnwUQuhKS3QmMjSc7lAI/CXwr2Dd6dFDVNwQ5d
         M891ke7aNjVfjDrHQG3Mzcic6lg7pe0zhJyvIDcBSgp5iaR204kzGdQWqIjwAqv6IXS0
         VbQqcS6LYtralmQfS6/8nkbZmDZTt5LBuQeT7pDgcEUXFVZ5sKUT0kbl51YlnfW8HKKp
         2ZKOJyWTfPnSLZDzUkJyuoa4Ay7Fk+9ojC9kA+Vq6ZRG5QjTQ8D4SfYs0ZA2r/5Qg38K
         93ff92lUn9K0QDrz0w4MiWMPR+Hgwn1yuAfcYAwURWAyvDzN3uZZGvkKqGTqqN2laTtY
         u9VQ==
X-Gm-Message-State: APjAAAU2iRIu/L6BnxN1mo0dGNYTJeiQqJKDAAWAUfW6Fu4WgdZ8xwPI
        MDw6AUPdDiYWGsAf2Hu3pG9jOT57
X-Google-Smtp-Source: APXvYqx7KlpvSrtPyD4dq0YRweHNxkDbhUjiA4VLeb0Kb615JyJ3dyyJKQPuKq49dkIc0sw8Thi/vg==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr38006287wru.311.1564049475258;
        Thu, 25 Jul 2019 03:11:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i66sm78872274wmi.11.2019.07.25.03.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:11:14 -0700 (PDT)
Date:   Thu, 25 Jul 2019 03:11:14 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Jul 2019 10:11:01 GMT
Message-Id: <pull.294.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 00/12] rebase -r: support merge strategies other than recursive
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

This is the most notable shortcoming that --rebase-merges has, still,
relative to --preserve-merges' capabilities: it does not support passing
custom merge strategies or custom merge strategy options.

Let's fix this.

While working on this patch series, of course I tried to copy-edit the test
cases we have, to cover --preserve-merges' support for merge strategies. Oh
my, did I regret this decision as soon as my eyes set sight on 
t3427-rebase-subtree.sh!

At first I tried my best to make heads or tails of t3427, for way too long.
In the end the only way to understand what the heck it tries to do was to
actually fix it. That's why this patch series looks as if it focuses on
t3427 rather than on adding support for custom merge strategies to the 
--rebase-merges mode.

As a consolation to myself, this work was actually worth it, surprising as
that may look. Not only is t3427 now really easy to understand, adding that
test case for --rebase-merges -Xsubtree tickled the sequencer enough to
reveal a long-standing bug: the --onto option was simply ignored when passed
together with --rebase-merges and --root. For good measure, this patch
series addresses this bug, too.

Johannes Schindelin (12):
  t3427: add a clarifying comment
  t3427: simplify the `setup` test case significantly
  t3427: move the `filter-branch` invocation into the `setup` case
  t3427: condense the unnecessarily repetitive test cases into three
  t3427: fix erroneous assumption
  t3427: accommodate for the `rebase --merge` backend having been
    replaced
  t3427: fix another incorrect assumption
  t3427: mark two test cases as requiring support for `git rebase -p`
  rebase -r: support merge strategies other than `recursive`
  t/lib-rebase: prepare for testing `git rebase --rebase-merges`
  t3418: test `rebase -r` with merge strategies
  rebase -r: do not (re-)generate root commits with `--root` *and*
    `--onto`

 Documentation/git-rebase.txt           |   2 -
 builtin/rebase.c                       |  16 +--
 sequencer.c                            |  18 ++-
 sequencer.h                            |   6 +
 t/lib-rebase.sh                        |   8 +-
 t/t3418-rebase-continue.sh             |  14 +++
 t/t3422-rebase-incompatible-options.sh |  10 --
 t/t3427-rebase-subtree.sh              | 150 ++++++++++++-------------
 t/t3430-rebase-merges.sh               |  21 ++++
 9 files changed, 134 insertions(+), 111 deletions(-)


base-commit: 082ef75b7bfc90ac236afbb857a9552a026832b8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-294%2Fdscho%2Frebase-r-with-strategies-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-294/dscho/rebase-r-with-strategies-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/294
-- 
gitgitgadget
