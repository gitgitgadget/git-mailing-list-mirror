Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4391F597
	for <e@80x24.org>; Tue, 24 Jul 2018 16:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbeGXRl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 13:41:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42324 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGXRl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 13:41:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so4771737wrs.9
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axNUVeOqHMSHCXbJAA8Ghu1F9/4sbj8AsUc4xQYqw2Y=;
        b=IQp0LB37C5r7tRUxdnXlrjgUjMuugSq98LeIeEWUqALAJm1wkEj9HFFJ97SiQeai7+
         JVc8LCk/PbvIFdIovIArRpvayQntpT0NOQMXr5ituRQ9Xmv5reGFmHCMdfd7P/cZI23Q
         Rvkpq7oyDQ25FiwOHXkRPgCOqd04dTNYa/YJzKVNbC3Fl56t9BpuEG8DFZRh55MlXGr6
         bY+quCrGZDIc5j9FdMKVPDn+D5GizMZXehght7XrYS149woXgAEeIm5/DoigYTeXVH3x
         ynhREjUNvkCG7lv25P0nT01y61dyodC4DAzDXmORHpdwvjB7ecaC8BSOauaAHhHY9WDT
         7O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axNUVeOqHMSHCXbJAA8Ghu1F9/4sbj8AsUc4xQYqw2Y=;
        b=NRaIAQa9McYzXwLlq+sZRf3K2B9QXhpINvmFE5MKOyYWKnkClbCeWtxj6LdtPxHWHT
         zu4pFqUvTjqnqZ8jEA/O2LiU+mMY1cir3FW/Tr0UOpYy1kJhfWvOFhKvHo7IHnLv4YtI
         qjtmvgQY31pgeBfMoWWDQ0pscH6LYSGgbcLDixZnZUYbD0l2CWZfY/1oov0sfTP0vJ0n
         2mGNEe3aN1YfMaH7/NQFE1QqgIyiuYtgwkuN81icCStbLEJhpG3edb2VNLc8uM8tq8RO
         VOCuvmVsF4fZ5hCN775t2qgD4bVSpBVxLHdcDh+Rt7PBuB5x3WhU2Sk92qSX2AEbr9jr
         djXw==
X-Gm-Message-State: AOUpUlHAY9UKKc8ZCeydk0rXNoeoSTXbJrSXbks6FWadLzFedv0E9fJk
        Zffb0Xlujag8/5oaMMgpxwiblqvQ
X-Google-Smtp-Source: AAOMgpfof2H7ScU+opjE9XEHHNRehmsd3QUEVmfxhrSUwX2NYD6YmvO3nd2zNrll0soxdUXiiVH2Kg==
X-Received: by 2002:adf:f8c7:: with SMTP id f7-v6mr3381095wrq.237.1532450049531;
        Tue, 24 Jul 2018 09:34:09 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-75-221.w92-156.abo.wanadoo.fr. [92.156.127.221])
        by smtp.googlemail.com with ESMTPSA id x124-v6sm1899091wmg.38.2018.07.24.09.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 09:34:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 00/20] rebase -i: rewrite in C
Date:   Tue, 24 Jul 2018 18:32:01 +0200
Message-Id: <20180724163221.15201-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180710121557.6698-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrite the interactive rebase from shell to C.

It is based on master (as of 2018-07-24).

Changes since v3:

 - The `--verbose` option is stored directly into opts.verbose

 - Drop includes in rebase-interactive.h

 - skip_unnecessary_picks() now returns an object_id instead of a string

 - Add a test case to ensure interactive rebase aborts when the todo
   list only has commented-out commands

 - complete_action() aborts when the todo list only has commented-out
   commands

 - Drop the `keep_empty` parameter of complete_action()

 - Don’t remove the modes `--shorten-oids` and `--expand-oids` from
   git-rebase--helper

 - Replace `ret = !!x(); return ret` by `ret = x(); return !!ret`

 - Fail if `--make-script` is provided with two arguments instead of
   one

 - Rewrite write_basic_state() and init_basic_state() in C

 - Rewrite git-rebase--interactive.sh as a builtin

Alban Gruin (20):
  sequencer: make two functions and an enum from sequencer.c public
  rebase -i: rewrite append_todo_help() in C
  editor: add a function to launch the sequence editor
  rebase -i: rewrite the edit-todo functionality in C
  sequencer: add a new function to silence a command, except if it fails
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C
  sequencer: refactor append_todo_help() to write its message to a
    buffer
  sequencer: change the way skip_unnecessary_picks() returns its result
  t3404: todo list with commented-out commands only aborts
  rebase -i: rewrite complete_action() in C
  rebase -i: remove unused modes and functions
  rebase -i: implement the logic to initialize $revisions in C
  rebase -i: rewrite the rest of init_revisions_and_shortrevisions() in
    C
  rebase -i: rewrite write_basic_state() in C
  rebase -i: rewrite init_basic_state() in C
  rebase -i: implement the main part of interactive rebase as a builtin
  rebase--interactive2: rewrite the submodes of interactive rebase in C
  rebase -i: remove git-rebase--interactive.sh
  rebase -i: move rebase--helper modes to rebase--interactive

 .gitignore                     |   1 -
 Makefile                       |   5 +-
 builtin.h                      |   1 +
 builtin/rebase--helper.c       |  88 ----------
 builtin/rebase--interactive.c  | 264 ++++++++++++++++++++++++++++
 cache.h                        |   1 +
 editor.c                       |  27 ++-
 git-rebase--interactive.sh     | 283 ------------------------------
 git-rebase--preserve-merges.sh |  10 +-
 git-rebase.sh                  |  47 ++++-
 git.c                          |   2 +-
 rebase-interactive.c           |  96 ++++++++++
 rebase-interactive.h           |   8 +
 sequencer.c                    | 311 +++++++++++++++++++++++++++------
 sequencer.h                    |  19 +-
 strbuf.h                       |   2 +
 t/t3404-rebase-interactive.sh  |  10 ++
 17 files changed, 729 insertions(+), 446 deletions(-)
 delete mode 100644 builtin/rebase--helper.c
 create mode 100644 builtin/rebase--interactive.c
 delete mode 100644 git-rebase--interactive.sh
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

