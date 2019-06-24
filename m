Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7983C1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFXJzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:55:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfFXJzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:55:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so6556524plb.9
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ACNSqjBQz162LKFM3NoboBFSlduAGplLg/K0ujeEk=;
        b=C30TGHTG9Z8XNkMc0/3hk4lUbPKOE6C/x8OlzioY9uzY0JPDSxTdFvwR/gp6BWDVse
         n2+53CyWK/9+ke0M7NtXXCHsJWsdSf14mQoa7wN0B98dukr7g/QUXnMTHWjxcMZJTbT0
         ajAT1nDoY/E2wfwCrpFD1+S9xiLxeWkdIMCfH+rU8jU7pZQLcf+ZHs3YLTRlhCYRcyJd
         d6Kh9X1oWn6Z2KH4goZCFYc2y1sP3+K/05eZugzrqYla2++qVp7O2/xTSN/tJW4TGG4O
         PCh/q7ajej24aLhs0Uqcc2znw/3XGHdWz3K3HMEup7ErBSQvM9LdCPvgX2s/lJl8vE3Z
         cbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ACNSqjBQz162LKFM3NoboBFSlduAGplLg/K0ujeEk=;
        b=dNkp5/Yw+jbSNlxhZSXelh9vR1i7B3fp4pkrV7uA4uxne/4ArcKs7ncXS0yS60aomP
         FKSWZfh3cpIQ20tEQP9+ElZM0/wbl4rlVq3dJHJ+iya+t5B4EMKPKDq4bHpkDe/QSkDq
         SxCvbfieuCnL/9mJT1wbHGnS3JVWVB1tI04ZNZ6e9jrVxeBc/SV4w859IvKhMGyuSwjN
         lGPYP1H2p10MB74a+SDzsIy5LApKFM+Tmfy9YR2iLs3jRj6nKqiE5JkIFPPrYf3NLiiv
         nXS+CyV3qg7gRHMUD8bXQ1Czs+XiTNtDA9MKX8+zxRF2u51APuzZpXwVI5bSUR4mpSC2
         uZjQ==
X-Gm-Message-State: APjAAAWr59xNC9UWoV1wW0/UFp9sNKLyG6/Zj4i6ilyTQ/4Lv9TXITT9
        684f6S5FGRNRfDvnw929zd4HB02/
X-Google-Smtp-Source: APXvYqwLJQXLvMbsIMMi0kDzITxS3c6hLG+vkDVzRYg3mOa00petodVJKOCJghkQavZTmLjkrU4AiA==
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr16741143plw.268.1561370143080;
        Mon, 24 Jun 2019 02:55:43 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id j1sm3241019pfa.73.2019.06.24.02.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:55:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 16:55:38 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/6] Kill the_repository in tree-walk.c
Date:   Mon, 24 Jun 2019 16:55:27 +0700
Message-Id: <20190624095533.22162-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the continuation of nd/sha1-name-c-wo-the-repository. In that
series I sealed off one place in sha1-name.c that cannot walk trees
from arbitrary repositories. With tree-walk.c taking 'struct
repository *' directly, that check in there can now be removed.

Nguyễn Thái Ngọc Duy (6):
  sha1-file.c: remove the_repo from read_object_with_reference()
  tree-walk.c: remove the_repo from fill_tree_descriptor()
  tree-walk.c: remove the_repo from get_tree_entry()
  tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
  match-trees.c: remove the_repo from shift_tree*()
  Use the right 'struct repository' instead of the_repository

 archive.c                   |  4 +++-
 blame.c                     |  4 ++--
 builtin/cat-file.c          |  3 ++-
 builtin/grep.c              |  6 ++++--
 builtin/merge-tree.c        | 22 +++++++++++--------
 builtin/pack-objects.c      |  3 ++-
 builtin/rebase.c            |  4 ++--
 builtin/reset.c             |  4 ++--
 builtin/rm.c                |  2 +-
 builtin/update-index.c      |  2 +-
 cache.h                     |  7 +++---
 fast-import.c               |  9 +++++---
 line-log.c                  |  7 +++---
 match-trees.c               | 12 ++++++-----
 merge-recursive.c           | 43 +++++++++++++++++++++----------------
 notes.c                     |  4 ++--
 sequencer.c                 |  6 +++---
 sha1-file.c                 |  5 +++--
 sha1-name.c                 | 25 +++++++--------------
 shallow.c                   |  3 ++-
 t/helper/test-match-trees.c |  2 +-
 tree-diff.c                 |  4 ++--
 tree-walk.c                 | 35 ++++++++++++++++++++----------
 tree-walk.h                 |  8 ++++---
 unpack-trees.c              |  2 +-
 25 files changed, 129 insertions(+), 97 deletions(-)

-- 
2.22.0.rc0.322.g2b0371e29a

