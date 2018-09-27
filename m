Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B221F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeI1EUx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:20:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38439 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeI1EUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:20:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id j8-v6so4236489wrw.5
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YVGQQK7lwOm9Qr04fPiQi2dwuGNIhjTZVUlb6wlnbo=;
        b=akuNg2UBYdf4Q67UTwvLep+c2Q5e8Y8kyIQErtUmWWyq2O6CIphMjSRyw3Or230fMZ
         F8LgYjVeHKeNJ5LICneF2+4TgKmjT3/yvVG5YPkdcMC/KCkx2A0ZL3WzuE+BYO/2zPyN
         V+8YMFZEpbCNtQN83vzZne1eP38ycMYg+IT1wEI3uXffjisWWZfujFa3p+oEhzPAf63h
         K4efb9h6ZFFdfXEYjIV9CBMSJppuGX05lBsWrbm/NrO5FDwZBfVZ9mmHVmINuKP1kcWW
         cux1nmqecPQF4kN+GxgHkXIznR3UArJMQaZzhfNBWiPLasxSRkLUHxBSklZQkcd7D4b3
         UJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YVGQQK7lwOm9Qr04fPiQi2dwuGNIhjTZVUlb6wlnbo=;
        b=oUSGfRUNGqvyJnELsNtMtf450GqOZQ3WwIBfYM5BIOor0d4m1LIaJuXoNzR71KrNZ6
         WDnr1oV/oVNesDABBSilry5nw4P6LwBZfG8x7adxmDIReewiL/XTxrMbqmL2hDB4O+Fa
         XvPIBJfG5koraTUs73Fg9dk3XoYkBZxTs6fdMLh0FMZftggPo2UQz3AlpqY9jWZ7c0Uz
         tVlBjcatoUG6Z5g2gzFAjrZ9r1qgU5sxl3Lye0c+oeGv/+o/wM0sx5rFGn4VqX0acmIq
         aco7iGLkLyY6hUvz8WH9AuLvOx6kpWYyHWM/mDGQQJFd94Toc1iX1NWHYbE/nXtXIzF/
         tQfw==
X-Gm-Message-State: ABuFfohwLIzyvuSFssUI0SeRvVimH+9mWQNbp/Hh4kIIw7EyMHRHk+nh
        CyGgpn8pJ2cgdbu3MLr5/U0/Js28
X-Google-Smtp-Source: ACcGV62hpNAokXzj0DYLnuKMKn4YTsHZaJ0SKf2GkXFVaICa+zcACR5l/ZY/nygcgarsUEYhCu/e7w==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr10575907wrh.223.1538085627380;
        Thu, 27 Sep 2018 15:00:27 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 00/20] rebase -i: rewrite in C
Date:   Thu, 27 Sep 2018 23:55:50 +0200
Message-Id: <20180927215610.32210-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrite the interactive rebase from shell to C.

The v7 was based on ffc6fa0e39 ("Fourth batch for 2.19 cycle",
2018-07-24), but this series is based on fe8321ec05 ("Second batch post
2.19", 2017-09-24) due to some conflicts.

Changes since v7:

 - [17/20] The optionnal parameter of `-S' was mandatory in
   rebase--builtin2, making it abort when a signing key is provided to
   `user.signingkey' and `commit.gpgsign' is set to true.  First
   reported on github[0], fixed by Johannes Schindelin.

 - [2, 5, 19, 20/20] Changes due to the rebase.

 - [9, 11/20] Conflict solving.

Alban Gruin (20):
  sequencer: make three functions and an enum from sequencer.c public
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
 builtin.h                      |   2 +-
 builtin/rebase--helper.c       |  88 ---------
 builtin/rebase--interactive.c  | 271 ++++++++++++++++++++++++++++
 cache.h                        |   1 +
 editor.c                       |  27 ++-
 git-rebase--interactive.sh     | 283 -----------------------------
 git-rebase--preserve-merges.sh |  10 +-
 git-rebase.sh                  |  47 ++++-
 git.c                          |   2 +-
 rebase-interactive.c           |  90 ++++++++++
 rebase-interactive.h           |   8 +
 sequencer.c                    | 320 +++++++++++++++++++++++++++------
 sequencer.h                    |  22 ++-
 strbuf.h                       |   2 +
 t/t3404-rebase-interactive.sh  |  10 ++
 17 files changed, 740 insertions(+), 449 deletions(-)
 delete mode 100644 builtin/rebase--helper.c
 create mode 100644 builtin/rebase--interactive.c
 delete mode 100644 git-rebase--interactive.sh
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.19.0

