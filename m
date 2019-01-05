Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714241F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 05:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfAEFwT (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 00:52:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42446 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfAEFwS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 00:52:18 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so18345971pga.9
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 21:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C1ITgAr2Az3Jbu14/3OmzwrKdRhfVJd3KN9dI0xwiA=;
        b=mmMaYnUYZeJBp7BnfnOVNSmm2pheKClwva6u96Z1K3zIpV06jIYXNOjLyN0Xyp4WiA
         NYMYKaiiJfxPx3E9N2MN6e7D+qpyIGs3lgE5d4ReXEbgdl0Rak7hzTfY2WFgq7JpKrGI
         hXL7SQJF1k2TV5R6C/HdNUKQhEJDZCI3HXWfHebqvxifJ+y3s9pEw96Ol8rQ6P2nlvTT
         kRXqxoDTepiHrB0RbJc5at4tD1IKsxZvGmnoNmYFtZHkGZ/d3VCboF8rQWSTHUgLiZl+
         hlzieuYAVhm9cYLSolPXjk9VRzVCsR4MVmD1Anw1dI5nCSnlvG0RESglaVg4QPtytLcq
         mcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C1ITgAr2Az3Jbu14/3OmzwrKdRhfVJd3KN9dI0xwiA=;
        b=lauzlAMKkd/wZ+Er3DLI63zrKxfKfez6GkhuMLfQmyZlLGCBDsZtbitmdqrxTxa0ZW
         fJ+T4ai9CmR+GMMTpjgS083D1qd0L/RzCSfr8gv7SF5ahduQChnA9yqNIVHatjfWBjC+
         4PKmjSKL5TSmzQBfM6gc4T26gy7BqPbZ9m28lueuOZKkH4qp8Y4nyxMxLIlRs+78Di9Y
         lPPkbqF4vz/vy7vRQbl5Giakyr0bGF3aAzy1gu1E0tsYS5fEDdXIHv1Ps/f33evNmgFh
         HYptexwu4wRqxmDWvb4UQ9+H/yT/A+p8fNAlR52EXKf2Kxnc0SnOJZAiQ9DhWhmEJlPR
         9Hjw==
X-Gm-Message-State: AJcUukc+roHp8iKSiTq+00nBm/HYjb5VRndFc3tzCt3cBuHg8QQIyrBJ
        cihKNeX4bLYqJT+P9TRXmvImBcARox8=
X-Google-Smtp-Source: ALg8bN5abrAU94jhYXdj0B552DRubM5tGXpsee+7oO/g+982nkXuivBFdBRrCW5dRKn/a4KUDh3F6w==
X-Received: by 2002:a63:200e:: with SMTP id g14mr3989441pgg.235.1546667537615;
        Fri, 04 Jan 2019 21:52:17 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id d13sm92125165pfd.58.2019.01.04.21.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 21:52:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 05 Jan 2019 12:52:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/10] Remove the_index, the final part
Date:   Sat,  5 Jan 2019 12:51:43 +0700
Message-Id: <20190105055153.3256-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This completely removes the_index outside builtin/. The macro
NO_THE_INDEX_COMPATIBILITY_MACROS is replaced with
USE_THE_INDEX_COMPATIBILITY_MACROS, which means by default you don't
have access to the_index any more. And USE_THE_... should only be
defined in builtin/

There's one easy conflict in builtin/rebase.c when merging this to 'pu'.
builtin/stash.c also needs to define USE_THE_... to build, but I think
that could be part of the builtin stash topic when it's rerolled.

Nguyễn Thái Ngọc Duy (10):
  notes-utils.c: remove the_repository references
  repository.c: replace hold_locked_index() with repo_hold_locked_index()
  checkout: avoid the_index when possible
  read-cache.c: kill read_index()
  read-cache.c: replace update_index_if_able with repo_&
  sha1-name.c: remove implicit dependency on the_index
  merge-recursive.c: remove implicit dependency on the_index
  merge-recursive.c: remove implicit dependency on the_repository
  read-cache.c: remove the_* from index_has_changes()
  cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch

 apply.c                              |   5 +-
 attr.c                               |   1 -
 blame.c                              |   4 +-
 builtin/add.c                        |   1 +
 builtin/am.c                         |  13 +-
 builtin/blame.c                      |   3 +-
 builtin/cat-file.c                   |   7 +-
 builtin/check-attr.c                 |   1 +
 builtin/check-ignore.c               |   1 +
 builtin/checkout-index.c             |   1 +
 builtin/checkout.c                   |   5 +-
 builtin/clean.c                      |   1 +
 builtin/clone.c                      |   1 +
 builtin/commit.c                     |   7 +-
 builtin/describe.c                   |   3 +-
 builtin/diff-files.c                 |   1 +
 builtin/diff-index.c                 |   1 +
 builtin/diff-tree.c                  |   3 +-
 builtin/diff.c                       |   3 +-
 builtin/difftool.c                   |   1 +
 builtin/fsck.c                       |   1 +
 builtin/grep.c                       |   4 +-
 builtin/hash-object.c                |   3 +-
 builtin/log.c                        |   4 +-
 builtin/ls-files.c                   |   1 -
 builtin/merge-index.c                |   1 +
 builtin/merge-ours.c                 |   1 +
 builtin/merge-recursive.c            |   2 +-
 builtin/merge-tree.c                 |   4 +-
 builtin/merge.c                      |   3 +-
 builtin/mv.c                         |   1 +
 builtin/notes.c                      |  21 +--
 builtin/pack-objects.c               |   2 +-
 builtin/pull.c                       |   1 +
 builtin/read-tree.c                  |   1 +
 builtin/rebase--interactive.c        |   1 +
 builtin/rebase.c                     |  14 +-
 builtin/replace.c                    |   2 +-
 builtin/reset.c                      |   1 +
 builtin/rev-parse.c                  |   4 +-
 builtin/rm.c                         |   1 +
 builtin/submodule--helper.c          |   1 +
 builtin/update-index.c               |   1 +
 builtin/write-tree.c                 |   1 +
 cache-tree.h                         |   2 +-
 cache.h                              |  35 ++---
 convert.c                            |   1 -
 dir.c                                |   1 -
 git.c                                |   4 +-
 list-objects-filter-options.c        |   2 +-
 merge-recursive.c                    | 191 +++++++++++++++------------
 merge-recursive.h                    |   6 +-
 merge.c                              |   4 +-
 name-hash.c                          |   1 -
 notes-merge.c                        |   4 +-
 notes-utils.c                        |  17 ++-
 notes-utils.h                        |  11 +-
 pathspec.c                           |   1 -
 preload-index.c                      |  11 +-
 read-cache.c                         |  44 +++---
 repository.c                         |   9 ++
 repository.h                         |  16 +++
 rerere.c                             |   8 +-
 revision.c                           |  12 +-
 sequencer.c                          |  41 +++---
 sequencer.h                          |   3 +-
 sha1-name.c                          |  56 ++++----
 submodule.c                          |   1 -
 t/helper/test-dump-fsmonitor.c       |   4 +-
 t/helper/test-dump-untracked-cache.c |   1 +
 t/helper/test-tool.h                 |   1 +
 tree.c                               |   1 -
 unpack-trees.c                       |   1 -
 wt-status.c                          |   4 +-
 74 files changed, 359 insertions(+), 273 deletions(-)

-- 
2.20.0.482.g66447595a7

