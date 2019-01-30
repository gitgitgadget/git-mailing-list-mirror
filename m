Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEF5A1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfA3Jsi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:48:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:48:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so11178545pfb.4
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPu4nEBvzBjYyIifKHqOmScHr9Ekt8QGzXV95h1ni3k=;
        b=dadmuQX1Z1p7/tDLqFQ3FtamYrRQv66QAyb2OguvV5Gq/wc38StMAu7LDChT4eXuYY
         UvV4KEDqjRvZ9VEXiyMcATUgoPiqByEgsynAfsLqn26JIFIkAY/+6YquhatT1d8SETbm
         rvt8lsLi1DDMYdHHJ/5JrdQdvMc65bYT/LeEym6f9RXNqXtJt4gU2CemrSk3GwH1HOwh
         IX0d898Z6u1NwmDmgzr3BIf31nYml1xk3zvBEgqUfq9cF/Mp6d/+5HutxZm3FqtZsbVs
         28EVG8+BqgDHEVbAo1CbYkUCA+dITiJc8XZ5w9ufM4rbWMEULY/eb5eLTBxHu6tH7phA
         BY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPu4nEBvzBjYyIifKHqOmScHr9Ekt8QGzXV95h1ni3k=;
        b=VO2ITacYwQ4IQTpLXHiVlatA9xA0e2HlLzoYITKC3Mr5BJwafrLkZY5vSwCYR7e1nP
         lH+PNQKOlgjwq23Q0CWb60O4jHWuHATOu7i6rQO4ub8yuzt9cN6YhX6JOiD8TNqd3UKx
         0M4DRVXewHx9i7fEzqVRktdSGx4poTep1GwmiMum4FvXpm239nKtmclaydLsWu5yM3xu
         p0QWBjbVTwuSriOfCfuKBnAQhD+LLTBivclZ+970cdcISRNlwt7EsqH+HP8NmgPjHzHB
         wgXB4wjKNVC+Uw+PAjkpbtRNTikRfG3TCmR1bB3Kv0VNpyMprw8/T2qiVMqzEEilReRh
         8SeQ==
X-Gm-Message-State: AJcUukcHNStg/Ujx5iiY0H9cISA007P1EMgcCwWwCzEG7cQdgfBmbZyT
        Kcmkj9l6ByEizfXjur2c7WrnGV8i
X-Google-Smtp-Source: ALg8bN4jEZFnC2lEM99To+5hs4Mfmq+514EWMb0y0GiSkARXM4xoJnvnyP33ZDM55xMuYv7LVvrj6Q==
X-Received: by 2002:a63:de46:: with SMTP id y6mr26864663pgi.198.1548841717034;
        Wed, 30 Jan 2019 01:48:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h74sm4519144pfd.35.2019.01.30.01.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:48:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/19] Add new command "switch"
Date:   Wed, 30 Jan 2019 16:48:12 +0700
Message-Id: <20190130094831.10420-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first half of the previous "switch-branch and
restore-files" RFC series [1]. I only focus on switch-branch for now
because it's already getting long and I still have some work to do on
restore-files.

The command is, as the name implies, for switching branches. And it's
supposed to be a (hopefully better) alternative for "git checkout". Head
to 08/19 for the man page, which describes the command (with
examples!) better than I do here.

I think I've addressed most of the issues from the last round. The
only one left is adding options similar to "git reset" (but with
better names this time than --soft and --hard, hopefully). I think
that could be done in a follow-up series.

For a complete picture, you would need to consider "git restore" too
(the new name of "git restore-files"). Full series is available [2]
though I still need to work on the "restore from a tree" part of
that command and thinking whether "restore -p" vs "reset -p" could be
confusing...

This series is built on top of master + tg/checkout-no-overlay.

PS. One of the things I like about this, after using it for some time,
is the "no ambiguation" UI design gives better completion support
(much less useless completion candidates), which makes life much
better.

[1] https://public-inbox.org/git/20181129215850.7278-1-pclouds@gmail.com/
[2] https://gitlab.com/pclouds/git/commits/switch-and-restore

Nguyễn Thái Ngọc Duy (19):
  git-checkout.txt: fix one syntax line
  doc: document --overwrite-ignore
  t: rename t2014-switch.sh to t2014-checkout-switch.sh
  checkout: factor out some code in parse_branchname_arg()
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' and 'dwim_..' to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split part of it to new command switch
  switch: better names for -b and -B
  switch: remove -l
  switch: stop accepting pathspec
  switch: reject "do nothing" case
  switch: only allow explicit detached HEAD
  switch: add short option for --detach
  switch: no implicit dwim, use --guess to dwim
  switch: no worktree status unless real branch switch happens
  t: add tests for switch
  completion: support switch
  doc: promote "git switch"

 .gitignore                                    |   1 +
 Documentation/config/advice.txt               |  13 +-
 Documentation/config/branch.txt               |   4 +-
 Documentation/config/checkout.txt             |  17 +-
 Documentation/config/diff.txt                 |   3 +-
 Documentation/git-branch.txt                  |   8 +-
 Documentation/git-check-ref-format.txt        |   3 +-
 Documentation/git-checkout.txt                |  48 +-
 Documentation/git-format-patch.txt            |   2 +-
 Documentation/git-merge-base.txt              |   2 +-
 Documentation/git-merge.txt                   |   4 +
 Documentation/git-rebase.txt                  |   2 +-
 Documentation/git-remote.txt                  |   2 +-
 Documentation/git-rerere.txt                  |  10 +-
 Documentation/git-reset.txt                   |  20 +-
 Documentation/git-stash.txt                   |   9 +-
 Documentation/git-switch.txt                  | 236 +++++++++
 Documentation/gitattributes.txt               |   3 +-
 Documentation/gitcore-tutorial.txt            |  18 +-
 Documentation/giteveryday.txt                 |  24 +-
 Documentation/githooks.txt                    |   8 +-
 Documentation/gittutorial.txt                 |   4 +-
 Documentation/revisions.txt                   |   2 +-
 Documentation/user-manual.txt                 |  52 +-
 Makefile                                      |   1 +
 advice.c                                      |  11 +-
 builtin.h                                     |   1 +
 builtin/checkout.c                            | 464 +++++++++---------
 builtin/clone.c                               |   2 +-
 command-list.txt                              |   1 +
 contrib/completion/git-completion.bash        |  26 +
 git.c                                         |   1 +
 parse-options-cb.c                            |  17 +
 parse-options.h                               |   3 +-
 sha1-name.c                                   |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  14 -
 ...014-switch.sh => t2014-checkout-switch.sh} |   0
 t/t2020-checkout-detach.sh                    |   4 +-
 t/t2060-switch.sh                             |  91 ++++
 39 files changed, 770 insertions(+), 363 deletions(-)
 create mode 100644 Documentation/git-switch.txt
 rename t/{t2014-switch.sh => t2014-checkout-switch.sh} (100%)
 create mode 100755 t/t2060-switch.sh

-- 
2.20.1.682.gd5861c6d90

