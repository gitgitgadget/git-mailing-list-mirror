Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41D11F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeIZAxS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:53:18 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44886 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbeIZAxS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:53:18 -0400
Received: by mail-pg1-f182.google.com with SMTP id g2-v6so4191598pgu.11
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=4tbqOtpjmsZmefTsSWeXH/wAtGZgH64eE5KyW+uirj0=;
        b=iwboisrbPh/Xqw4HmbOkQSJ4QSaSLABTtE1u4I51Hc+WmfYbRSFAZWOAfzNMjYcwl6
         ou7wWmdtizWkmH/GLodSyGdQjVjqatrBiiai0pT+4r5/3qWveYLrjGnd48zdD4zZgXoU
         UBz6ycPA6erVLS856pNWFM9/PlF8uP5ZGxNJ1pWpxbzAefh7qA9Yezr2Z3osc57WHuEU
         HuECdvuxexq9AyAwodpT15uxcPlo8Zwlm3quFa4AcISxxezpiJVLXvuVTwZ/y5wO8JnF
         anB4tS4UxDYkerIkKJ6S062SAebsHzYx/SpV82iRDxqgXAWg3g6qf08AaeemABS8qGBf
         ZYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=4tbqOtpjmsZmefTsSWeXH/wAtGZgH64eE5KyW+uirj0=;
        b=iVeifw9dvs9kuEr5xMBnAcPpQNUUjLwGA6goDgdjhBjDhvhNq/nzW5VPdiceTCM0ml
         3yqdoLYUd5BC4hK5CIhWueeYmOI/GQh0ie/lICI71bMDCUp02n7BDZL4ca7aR5bN+YD7
         oy8yM0b/MGTo4yt6nBfWucsycHYkwTZLbzEM1UnXcwxR5Zi+b84xpH1rCgXe2RUoEh+/
         NWRWsP63RM0XVI7hDvoAVOHOoFIrFgWvNtZm0ikhFNIG+8nsZGQY5jv+FidyOTTHnG+r
         /DO5da/ljCQFq6FtgIFYsNnpcY4jsuIAt1ruIwhMzh9W6vHHNMatbEGJr0oW2oeXwn7D
         4tKg==
X-Gm-Message-State: ABuFfojJTZ8Iq+tuRWbvN7PsqxlN8bLAONtdg87ViupulwiVS/v5q1fD
        oQnHBQnYNdBCLn/ZUgm0IjI=
X-Google-Smtp-Source: ACcGV60knXNLayQlxjxC707N3VpEU9umpVuQwKvXSf2KVniy/MqsqeYFICr5G7btdEqEW4FcDFCq2Q==
X-Received: by 2002:a62:9894:: with SMTP id d20-v6mr2415313pfk.186.1537901065661;
        Tue, 25 Sep 2018 11:44:25 -0700 (PDT)
Received: from unique-pc ([223.228.178.228])
        by smtp.googlemail.com with ESMTPSA id e26-v6sm3881370pfi.70.2018.09.25.11.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:44:24 -0700 (PDT)
Message-ID: <fa6d37b850177f7f2ba31c596d5986962eaf7382.camel@gmail.com>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a
 worktree
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CACsJy8D_37U+4sb7tb8KqGM=_3CRrTaZX1ZE9VqDVrYJT-AhnA@mail.gmail.com>
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
         <CACsJy8D_37U+4sb7tb8KqGM=_3CRrTaZX1ZE9VqDVrYJT-AhnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 26 Sep 2018 00:14:19 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2018-09-24 at 17:17 +0200, Duy Nguyen wrote:
> On Sun, Sep 23, 2018 at 10:19 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
> 
> Yes, some bugs. It behaves correctly for me. There must be something
> strange that triggers this. What's your "git worktree list" (iow
> anything strange there, duplicate worktrees perhaps)?

Nothing seems strange in the list.

$ git worktree list
$COMMON_ROOT/git                      01d371f741 (detached HEAD)
$COMMON_ROOT/git-next                 cfa73bbfcb (detached HEAD)
$COMMON_ROOT/git-next-build-automate  01d371f741 (detached HEAD)
$COMMON_ROOT/git-pu                   363c5c06bb (detached HEAD)

Note: I sanitized the path in which the git worktrees (including the
main worktree) is present as $COMMON_ROOT.


>  Also please try
> "git fetch" again with GIT_TRACE=1 and GIT_TRACE_SETUP=1. Hopefully we
> could catch something with that.

$ GIT_TRACE_SETUP=1 GIT_TRACE=1 git fetch origin next
23:10:26.049785 trace.c:377             setup: git_dir: $COMMON_ROOT/git/.git/worktrees/git-next-build-automate
23:10:26.049868 trace.c:378             setup: git_common_dir: $COMMON_ROOT/git/.git
23:10:26.049901 trace.c:379             setup: worktree: $COMMON_ROOT/git-next-build-automate
23:10:26.049922 trace.c:380             setup: cwd: $COMMON_ROOT/git-next-build-automate
23:10:26.049941 trace.c:381             setup: prefix: (null)
23:10:26.049955 git.c:415               trace: built-in: git fetch origin next
23:10:26.051033 run-command.c:637       trace: run_command: git-remote-https origin https://github.com/git/git.git
23:10:28.366526 run-command.c:637       trace: run_command: git rev-list --objects --stdin --not --all --quiet
23:10:28.400979 run-command.c:637       trace: run_command: git rev-list --objects --stdin --not --all --quiet
23:10:28.402745 trace.c:377             setup: git_dir: $COMMON_ROOT/git/.git/worktrees/git-next-build-automate
23:10:28.402787 trace.c:378             setup: git_common_dir: $COMMON_ROOT/git/.git
23:10:28.402793 trace.c:379             setup: worktree: $COMMON_ROOT/git-next-build-automate
23:10:28.402798 trace.c:380             setup: cwd: $COMMON_ROOT/git-next-build-automate
23:10:28.402802 trace.c:381             setup: prefix: (null)
23:10:28.402815 git.c:415               trace: built-in: git rev-list --objects --stdin --not --all --quiet
From https://github.com/git/git
 * branch                  next       -> FETCH_HEAD
23:10:28.437350 run-command.c:1553      run_processes_parallel: preparing to run up to 1 tasks
23:10:28.437481 run-command.c:1585      run_processes_parallel: done
23:10:28.437763 run-command.c:637       trace: run_command: git gc --auto
23:10:28.439608 trace.c:377             setup: git_dir: $COMMON_ROOT/git/.git/worktrees/git-next-build-automate
23:10:28.439655 trace.c:378             setup: git_common_dir: $COMMON_ROOT/git/.git
23:10:28.439667 trace.c:379             setup: worktree: $COMMON_ROOT/git-next-build-automate
23:10:28.439677 trace.c:380             setup: cwd: $COMMON_ROOT/git-next-build-automate
23:10:28.439687 trace.c:381             setup: prefix: (null)
23:10:28.439699 git.c:415               trace: built-in: git gc --auto

HTH,
Sivaraam

