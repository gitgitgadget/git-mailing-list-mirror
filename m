Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1F720248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfCHKRG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42477 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so13790390pgl.9
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPOVAjCQ4wfKWqLb/L8/HsczhmWlc8JWwxnjF8bio8E=;
        b=CJwMjDYKFZ7eDVjTpoD9mLC7Zr14jJc7IZtjaZybUv/C/SxCMH7AEODuEPe76YllPP
         i7fNjwRHcx1A3Uoy+CZAu2W1QO1rLBw6Bjsmw9b0zttZYYVlc4F0Uwlo+KG2Y5xNXTQK
         Czw3G5DRKEOqveH3CmvnSarwigYp8CS1hwfMXQS15ek0xLnhdf3wPPDgn7iFLFGJqXG3
         qFjCZC6wHOGNUDd7bIa80XDnE7IUAFoknOazvP6jVNzLOiHRY3hlJEWUxY3be4LcTcQi
         zSSHsMpO+vIVxGNxiUHAkEXo2Zj5sSi33uj03ymOHz0Ul5vLN6JDG0NVR3icG/l0Cj6+
         mk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lPOVAjCQ4wfKWqLb/L8/HsczhmWlc8JWwxnjF8bio8E=;
        b=bBQYxFPzJnD0bDUiGX5HZDXGaz0eNfDtg4XYcVXQiAUqx+A2Fi9yFQTpRVnWaUpuFN
         A27xsw1l/VjS4ADqZDy2rwMraoi1fYe4VLejfTHaov3VbhbxwAqYtuabUgJzeJtALZJF
         2XAMZdjanO4XpHG6sjbef28g4gKE9T86XuMQ911iv7ALxhRk6S706beohOFOYPcXHChL
         Ia+IQ70gLFhJrBAg/qv1Z24jDdH1ZGGHTfHH8HK+OJfypIbksKzz4PnMvxr3HpgXpkMg
         w03Sbdc2CldJKs4Yj0wbuENOCcvwwmyzm/tbEIJALwh+aKbEF2BFMSvLNgJuShaxrEao
         kePA==
X-Gm-Message-State: APjAAAU+YGujv8TAToLwmF6xO/FpDEAMp8LjNiwk4FARQSif2EN2iCw3
        JlT7bOKnDHQCEJeowVKJtoadZNG2
X-Google-Smtp-Source: APXvYqyYJaf5yU590UQJkolf43FueTixlobaCSxeoGL91XCOVDlO/GRZaLlESRO3xhZDi0bk0bCA+g==
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr18153739pll.12.1552040224898;
        Fri, 08 Mar 2019 02:17:04 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f192sm26955034pfc.180.2019.03.08.02.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:16:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 00/11] And new command "restore"
Date:   Fri,  8 Mar 2019 17:16:44 +0700
Message-Id: <20190308101655.9767-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the companion of "git switch" [1] and is based on that topic.
This command peforms the "checkout paths" from git-checkout, git-reset
and also has a third mode to reset only worktree, leaving the index
alone.

For new people not aware of previous discussions, this command is
supposed to be a friendlier replacement for "git checkout" and
hopefully fixes some warts that have grown over the time in git-checkout.
For this reason, the last patch starts to recommend "git restore"
everywhere.

For old people, I'm surprised nobody reacts to the command rename from
restore-files to restore. "restore" vs "reset" is certainly confusing.
My hope was to remove "common porcelain" status from reset, but I
probably will not succeed in doing that.

Some open issues from the last discussion [2]

- intent-to-add support. This will come but maybe later.

- --index has a different meaning in git-apply. I don't have a good
  suggestion except "yeah we have two different worlds now, the old
  and the new one"

The series is also available at [3]

[1] https://public-inbox.org/git/20190308095752.8574-1-pclouds@gmail.com
[2] https://public-inbox.org/git/CACsJy8CQhWeC3b6eGPePuRejfOx7c17X61-wqq5kOiRzYkRESw@mail.gmail.com/
[3] https://gitlab.com/pclouds/git/tree/switch-and-restore

Nguyễn Thái Ngọc Duy (11):
  checkout: split part of it to new command 'restore'
  restore: take tree-ish from --source option instead
  restore: make pathspec mandatory
  restore: disable overlay mode by default
  checkout: factor out worktree checkout code
  restore: add --worktree and --index
  restore: default to --source=HEAD when only --index is specified
  restore: support --patch
  t: add tests for restore
  completion: support restore
  doc: promote "git restore"

 .gitignore                             |   1 +
 Documentation/config/interactive.txt   |   3 +-
 Documentation/git-checkout.txt         |   1 +
 Documentation/git-clean.txt            |   2 +-
 Documentation/git-commit.txt           |   4 +-
 Documentation/git-format-patch.txt     |   2 +-
 Documentation/git-reset.txt            |   6 +-
 Documentation/git-restore.txt (new)    | 172 ++++++++++++++++
 Documentation/git-revert.txt           |   4 +-
 Documentation/gitcli.txt               |   4 +-
 Documentation/giteveryday.txt          |   4 +-
 Documentation/gittutorial-2.txt        |   4 +-
 Documentation/gittutorial.txt          |   2 +-
 Documentation/user-manual.txt          |  14 +-
 Makefile                               |   1 +
 builtin.h                              |   1 +
 builtin/checkout.c                     | 259 +++++++++++++++++++------
 builtin/clone.c                        |   2 +-
 builtin/commit.c                       |   2 +-
 command-list.txt                       |   3 +-
 contrib/completion/git-completion.bash |  15 ++
 git-add--interactive.perl              |  52 +++++
 git.c                                  |   1 +
 t/lib-patch-mode.sh                    |  12 ++
 t/t2070-restore.sh (new +x)            |  77 ++++++++
 t/t2071-restore-patch.sh (new +x)      | 105 ++++++++++
 t/t7508-status.sh                      |  82 ++++----
 t/t7512-status-help.sh                 |  20 +-
 wt-status.c                            |  26 ++-
 29 files changed, 736 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/git-restore.txt
 create mode 100755 t/t2070-restore.sh
 create mode 100755 t/t2071-restore-patch.sh

-- 
2.21.0.rc1.337.gdf7f8d0522

