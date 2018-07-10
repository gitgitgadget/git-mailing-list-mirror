Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B001F1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeGJMRN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41432 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeGJMRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so7852587wrr.8
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQjyQbFhY5o6lYCrkqz7HMiVzZHkrD+a3yN0CGIWteU=;
        b=d49dF8ePXo69E/LGpBb/Cm1xyG3UQf86T5uA3l9PHE7dFRW2+HkUWiaoi2grka2tpr
         3sTDhvuhgAGmAARUduxFW0Zf5H1GwfXXurl+rndZP9Jb952G1tRjPZv7L+iG6ZBZrHdF
         zztMXY6TFCfClRTTtP6TtqFe4GmidgjSqc2/TtgowxHkzjZtX6qADsa9Ye8Dq3HyTm3K
         1YnDKASmBQCsxRRcQ93wI7yD6gXq9BPdEZRp4iNIM+XOXbPMstq8sVLip7KLG/ZHJBtW
         LfAMqU2QGnnMCg2Ju502YimABC4/OJ5fssEM8I79l7qoQ7XGwcuOzChgUKZB8cD7rnpc
         vVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQjyQbFhY5o6lYCrkqz7HMiVzZHkrD+a3yN0CGIWteU=;
        b=BSfdL9vYT15DBmFjyZy4/X9LjJ0xUtIGfg8FaAbACyGSipN/4Jhc/vIZuvkV0zFPMS
         hAZ4f0fB+jFwiFchzKwgSVmME/mh66aG6e++lfBdQHw+GCR2iUxl+Qajm3DgVIWdd4im
         VABHUz25m6G+OYjxJ14T7LlAgbdJoMxUflCUSQ+bc9ol0yZZgem8DnTKzgwUG9ldS5P+
         +TKlmd+NHaO9C8IkPB/Mu+zRwfTIYDUF4TKvzH5LlMcb3kyVsjw0BkYJ9a34AUKnbmXg
         jdcESTXSwqIWqsMc0jDh9quomFrQnqkhy9+ly90GRLCtzn11S62945Oy4aJRW0m54mv7
         BsbA==
X-Gm-Message-State: APt69E2c905g3Ol75M+/oDbMrNxQaut6VlOEPknH3xcWLYs0HOEn7WsT
        GTi3CezINgFE6t6ScDtU4dUNMRjf
X-Google-Smtp-Source: AAOMgpeknVERPCJVxCJRjka5a89ZB5xYLVBsyEHFkbDqZAUm3nfqfbiZ3ZW0EhImnZsM4jSLIf3meA==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr18156549wrf.169.1531225031309;
        Tue, 10 Jul 2018 05:17:11 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 00/13] rebase -i: rewrite some parts in C
Date:   Tue, 10 Jul 2018 14:15:44 +0200
Message-Id: <20180710121557.6698-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series rewrites some parts of interactive rebase from shell
to C:

 - append_todo_help(). The C version covers a bit more than the shell
   version.

 - The edit-todo functionnality.

 - The reflog operations.

 - complete_action().

 - init_revisions_and_shortrevisions().

This patch series is based on master (as of 2018-07-10).

Changes since v2:

 - Lowercasing error messages.

 - Removing a comment from run_command_silent_on_success().

 - Using the `else` keyword to call run_command_silent_on_success() or
   run_command() in run_git_commit() and run_git_checkout().

 - Dropping the `verbose` parameter in run_git_checkout(),
   prepare_branch_to_be_rebased(), and checkout_onto(), as the
   replay_opts structure already has a `verbose` field.

 - Rewriting complete_action() and init_revisions_and_shortrevisions().

Alban Gruin (13):
  sequencer: make two functions and an enum from sequencer.c public
  rebase--interactive: rewrite append_todo_help() in C
  editor: add a function to launch the sequence editor
  rebase-interactive: rewrite the edit-todo functionality in C
  sequencer: add a new function to silence a command, except if it fails
  rebase -i: rewrite setup_reflog_action() in C
  rebase -i: rewrite checkout_onto() in C
  sequencer: refactor append_todo_help() to write its message to a
    buffer
  sequencer: change the way skip_unnecessary_picks() returns its result
  rebase--interactive: rewrite complete_action() in C
  rebase--interactive: remove unused modes and functions
  rebase -i: implement the logic to initialize the variable $revision in
    C
  rebase -i: rewrite the rest of init_revisions_and_shortrevisions in C

 Makefile                   |   1 +
 builtin/rebase--helper.c   | 123 +++++++++++++++++----
 cache.h                    |   1 +
 editor.c                   |  27 ++++-
 git-rebase--interactive.sh | 216 ++-----------------------------------
 git-rebase.sh              |   2 +-
 rebase-interactive.c       |  96 +++++++++++++++++
 rebase-interactive.h       |  11 ++
 sequencer.c                | 215 +++++++++++++++++++++++++++++-------
 sequencer.h                |  15 ++-
 strbuf.h                   |   2 +
 11 files changed, 439 insertions(+), 270 deletions(-)
 create mode 100644 rebase-interactive.c
 create mode 100644 rebase-interactive.h

-- 
2.18.0

