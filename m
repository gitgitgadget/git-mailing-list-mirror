Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8001211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeL0P4X (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33844 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0P4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so12980160lfc.1
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXErmh3fRQ6627aiWtmJZMc3L0aOxQnGlCVhb+SGZGs=;
        b=n6cT6Va63iDSKyXvoHHcvxkODul6aZwlZcpgV9KoMzKN9sMBRJEtKB7ijBjpMHv6VP
         XqIhba2Y6jLTgz5VNCvLonkCw/5cuAyKcFzYk2bqh9t5a/KR+ZTLgPTNAVV6UX6sFVLe
         AoCHoDYsvaOGDXc5pG3pztbezHnI8OvyAI+4QLGhwfMvVsjUVgG56jOQb8yeGXAwpjtJ
         v8gWkWmRtIYESJ1f+HfEVbC82vE+xnafB7rXUhN8W+JH5JFk0IlMM569+N3sS6Ucc4T/
         MG7OSGLhjV+PtP6O76J4YUqA60uRjfOCaWaDkHdKucsNw45CRK19St75+QqBchRt5LIj
         jqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RXErmh3fRQ6627aiWtmJZMc3L0aOxQnGlCVhb+SGZGs=;
        b=hbv5HReLoQrzoTBj+7JBlgTmlvCCvNSwrrOlLJ2umPigBbuO7JYsEoloQj8XHDgFrl
         +l90ieE9DmGRcujw5zvGpuLdI2qoZODfP3grU3EC2XN0mmA0WPkUirZpENMLmWQ0ZAnF
         2K/mTH95PXLk9tZx9HazS1RBQIseeaerSfzgNArE/M1DoobmRKOXY/LJyUgMDWMGDSy1
         OXIrQLi+57BAZiAmP2xwPZMHfTgoy2PRgiznGJm9rr9LOf4a6nVC3PO2ZPnN0RKq1HDx
         aTZDhs9exq0+PD7Cg4Ijc/BdTJtkPXoNgiY+IOELENfJMOLhO5d1gkSezizyBjrpkmYE
         or+A==
X-Gm-Message-State: AA+aEWYRlvUEU8whvq2KuNoqbDChu3fVWoLTouWqAP0SkfRw7Rt/PTuS
        x1efcn4f9oeZ+rYcs6XaakPstnnu
X-Google-Smtp-Source: AFSGD/XM6zwQseVLD5IIISmdQeWLjZZf7hZ6uLoWLrEs+SW1ATwa2+zDZkX4QcjtL8rGt5oENWnMOA==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr11818236lfk.78.1545926181033;
        Thu, 27 Dec 2018 07:56:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:19 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] Add "git config --move-to"
Date:   Thu, 27 Dec 2018 16:56:05 +0100
Message-Id: <20181227155611.10585-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of nd/per-worktree-config, fixing is small
things from that series and prepares to make submodules work in
multiple worktrees.

The first thing is adding API for updating per-worktree config in
03/06. When submodule code wants to write to a per-worktree config,
calling this function takes care of both single and multi worktree
setups, similar to "git config --worktree <name> <value>"

The second thing is "git config --move-to" and friends. This helps
the config transition right after enabling extensions.worktreeConfig,
when the user has to make sure per-worktree config stays in
per-worktree file.

Manual moving config from one file to another is possible with a
couple keys like core.worktree, but once you have to move multiple
groups (i.e.  "submodule.*.*" keys) then it becomes a lot less fun and
more pain. This simplifies that work (and also migration
documentation)

Note that I added --move-glob-to because I think glob fits much better
than regex for matching keys because of the dots in config keys. I
added --move-regex-to anyway because we have --get-regexp. Maybe I
should add --get-glob too (but probably not now).

There is also a NEEDSWORK in 03/06. But I hope it could be addressed
after this series is merged (so that I could continue pushing
submodule changes out)

Nguyễn Thái Ngọc Duy (6):
  config.c: avoid git_path() in do_git_config_sequence()
  worktree.c: add get_worktree_config()
  config.c: add repo_config_set_worktree_gently()
  config: use OPT_FILENAME()
  config: factor out set_config_source_file()
  config: add --move-to

 Documentation/git-config.txt   |  12 ++
 Documentation/git-worktree.txt |  16 ++-
 builtin/config.c               | 244 ++++++++++++++++++++++++---------
 config.c                       |  55 +++++++-
 config.h                       |   3 +
 t/t1300-config.sh              |  54 ++++++++
 worktree.c                     |  16 +++
 worktree.h                     |   7 +
 8 files changed, 330 insertions(+), 77 deletions(-)

-- 
2.20.0.482.g66447595a7

