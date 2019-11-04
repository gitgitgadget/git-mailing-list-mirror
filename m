Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF551F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfKDT0t (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:26:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39236 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDT0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:26:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so13243395wmi.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PtbhiYEY2ovK/G3zijWT2pT8RJEGWBI8Av1rbrK/Anc=;
        b=WAnzeg5sDAUrM/Wwzb/jDm5XLJeEe8Z5Hh+IT6tPwXeNtJG7yiEooaBXjhQQUBEMDQ
         P3e//47xUdqYSVs5lTQS6eRemLGmpTBgEDhw6yv0zUjdHbggG4pYV1vxdTEjZV0hzGqQ
         0PQHg8Td/rnG+1Ejvwp0tyrQ+BwzXuQrl9O4OH25aoZNpEHQ9byB7HC9KfPf0jy980SS
         zARBOO/1rAliThvbMFAjJhBA3H8wGAtZXD2gHUFljpz8sQHWkF6OMQjOio9HYlhXg6tX
         IkB4xQKI5rNiyk3xnl0rsOzQPYYQ+Gp5/yiQgG0VsUhAHj48dJ5yeaktWLfQnWGGusNw
         6XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PtbhiYEY2ovK/G3zijWT2pT8RJEGWBI8Av1rbrK/Anc=;
        b=fhNt407AGRrh2bYOPJX19aWm34hPd+yrrMZgA3/vqDjCDrI/tuNP1Et1quEovsWIeQ
         UnsYACg0VF7xDCMU5OLILU7fp/5OYmJ9WmHtRuP9QnqZOzN4kg42h6j4JC6kMmpB9QZb
         4lJ7Vc0bBnwchx4O8MhNvZQ3Fcqied1BQPHJweDuAWAyn93a6BTuda9O4m+rHoTgcvZM
         HKBMmL+PKpnc8XKq4ChGrA1AMzEJ3//MR4TeFAsF8XRWSmt1+Aku0f8skiNvIC8GqJZe
         W6ENuYs67impxR5BAhO6ZnEcPDSfzwFz6cwTp/tMNOKMD1g5AZRlke7Hefw3oYmu9Hh0
         1JwA==
X-Gm-Message-State: APjAAAWJMllHLqyB2p3D4QiobAiAA8cLg6p/Qxsk54Wju8rc5+lEFodk
        zPxs59eL+dT/e312Fn4gr7370Zfc
X-Google-Smtp-Source: APXvYqwAt1UlUUeTqkFzPIbXzK5FRwek8h6T3BcYJ8zYqtaNIhZaY7YqDXykKkqovN4xQz81EEU75Q==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr644602wmb.138.1572895606421;
        Mon, 04 Nov 2019 11:26:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w81sm19655260wmg.5.2019.11.04.11.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:26:45 -0800 (PST)
Message-Id: <pull.445.git.1572895605.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 19:26:40 +0000
Subject: [PATCH 0/5] Add --pathspec-from-file option for reset, commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds --pathspec-from-file option for porcelain commands to avoid commandline
length limit.

So far I implemented it for git commit and git reset, but my goal is to
support other commands as well after these patches are reviewed.

The patches are based on the following discussions:
https://public-inbox.org/git/c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com/T/#u
There, --stdin-paths was suggested.
https://public-inbox.org/git/a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com/T/#u
There, --stdin-paths was extended to --paths-file.
https://public-inbox.org/git/pull.133.git.gitgitgadget@gmail.com/
https://github.com/gitgitgadget/git/pull/133Patch from Johannes, I used it
as base of my patch. There, --pathspec-from-file is suggested in discussion.

Major changes compared to patch from Johannes:

1) --pathspec-from-file allows to read file, not just stdin 2) 
--literal-pathspecs should be honored. This is a good improvement because it
keeps --pathspec-from-file much closer to passing args on commandline. Since
the goal of the new option is to avoid commandline length limit, both
behaviors should be close to each other. 3) Patches are designed with all
other git commands in mind

Alexandr Miloslavskiy (5):
  pathspec: add new function to parse file
  doc: reset: unify <pathspec> description
  reset: support the --pathspec-from-file option
  doc: commit: unify <pathspec> description
  commit: support the --pathspec-from-file option

 Documentation/git-commit.txt    |  19 ++++-
 Documentation/git-reset.txt     |  40 +++++++---
 builtin/commit.c                |  25 ++++++-
 builtin/reset.c                 |  22 +++++-
 pathspec.c                      |  41 +++++++++++
 pathspec.h                      |  10 +++
 t/t7107-reset-pathspec-file.sh  | 126 ++++++++++++++++++++++++++++++++
 t/t7526-commit-pathspec-file.sh | 107 +++++++++++++++++++++++++++
 8 files changed, 371 insertions(+), 19 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh
 create mode 100755 t/t7526-commit-pathspec-file.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-445%2FSyntevoAlex%2F%230207_pathspec_from_file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-445/SyntevoAlex/#0207_pathspec_from_file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/445
-- 
gitgitgadget
