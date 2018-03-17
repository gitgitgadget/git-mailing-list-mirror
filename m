Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D5E1F42D
	for <e@80x24.org>; Sat, 17 Mar 2018 07:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeCQHze (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 03:55:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41816 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCQHzc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 03:55:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id m69-v6so18493725lfe.8
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 00:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkeJ3DTnmY3Jb0v3JkVcJMllv0sryoRt1hc5ViRBkr4=;
        b=XJHIsfKbnWWYMVJCsbik3EWYTh3lUK6Go7x3E5GJvZqsxK5tVqcGqHbWZRxfa/PtQ/
         lYrKMlInKbtv66bXj8JDy3hCDGKmDrFjixuPHkfST+OOQtMVHx/LqMSbp2PCGh6PR330
         qthdLVRFk0bMxBej6D6z/m4+6gx2iMDzUueKEiVlO7/xWhdBWtr7SueXpe1SUtxNRdte
         3jk4dv/fZFTvB8VHd/EW103PsFK7jHRZz/sA+Jg6RYwWCtya7hURg0/iRnyGKODQcrED
         fNdS2ZxKPBUqtaojQEMJ60gzbXQZRggI0irsvbqQvb3MxFl7e8QgUfjNpsiRu0SzgpL4
         Tujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkeJ3DTnmY3Jb0v3JkVcJMllv0sryoRt1hc5ViRBkr4=;
        b=OvCS9j2g2mLG5xXCl0jvpu6FbiAF7PH5UrbDaZVuyvetiSl6LcFzKTwEujclDzKpVh
         tQBq9hOu5giQBBrd3bEFIz3J9zxOq5cHCnW1qpjzSQvV8qLLFxDXgCh7mW00Faq+4iV8
         z+CLxnkngY2/7GrnOFG8dRVWYO0reqXvmcVr/3XaCgmbDKfTdDvPYYBifV6aZJwIL1yT
         1EPJ0vi0HPu20t/2v0QLDfJGBJ5I3FlkB5421RlWkTYPI0swJ9TImMUvflBP2yFV9Qc1
         mwuSiJlIk8TawnsYrl1TVxEGVnklWL+PrTnIkYu0vR5oSDSTCTf6dviWnzwMouvlrV0i
         QZrQ==
X-Gm-Message-State: AElRT7GcmJ0DX0CHW6whSr2enWeNUUC3rkNenq78FbhCjn0zXkPyhQ8/
        89M4Wxhq2B5BTVMxcYkMh8MvVw==
X-Google-Smtp-Source: AG47ELuNkW6i/hfJZDzdafS7j1jvwhHbKJVQpqPRaYJm3wzZhfEzkmChNIXCVw3nH8LXPCzRRwz1+w==
X-Received: by 2002:a19:e303:: with SMTP id a3-v6mr3467712lfh.111.1521273330670;
        Sat, 17 Mar 2018 00:55:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s23sm170224ljd.5.2018.03.17.00.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Mar 2018 00:55:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/36] Combine t/helper binaries into a single one
Date:   Sat, 17 Mar 2018 08:53:45 +0100
Message-Id: <20180317075421.22032-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The number of t/helper binaries is growing, which slows down build
process due to increasing link time and also consumes more disk space.
This series combines most of them into a new binary called test-tool.

Going forward, new test helper programs should be part of this
test-tool (with few exceptions).

Interesting numbers and exceptions are in 01/36. The four most
interesting patches are at the top. The rest is boring mechanical
search and replace.

Nguyễn Thái Ngọc Duy (36):
  t/helper: add an empty test-tool program
  t/helper: merge test-chmtime into test-tool
  t/helper: merge test-sha1 into test-tool
  t/helper: merge test-lazy-init-name-hash into test-tool
  t/helper: merge test-config into test-tool
  t/helper: merge test-ctype into test-tool
  t/helper: merge test-date into test-tool
  t/helper: merge (unused) test-delta into test-tool
  t/helper: merge test-drop-caches into test-tool
  t/helper: merge test-dump-cache-tree into test-tool
  t/helper: merge test-dump-split-index into test-tool
  t/helper: merge test-example-decorate into test-tool
  t/helper: merge test-genrandom into test-tool
  t/helper: merge test-hashmap into test-tool
  t/helper: merge test-index-version into test-tool
  t/helper: merge (unused) test-match-trees into test-tool
  t/helper: merge (unused) test-mergesort into test-tool
  t/helper: merge test-mktemp into test-tool
  t/helper: merge test-online-cpus into test-tool
  t/helper: merge test-path-utils into test-tool
  t/helper: merge test-prio-queue into test-tool
  t/helepr: merge test-read-cache into test-tool
  t/helper: merge test-ref-store into test-tool
  t/helper: merge test-regex into test-tool
  t/helper: merge test-revision-walking into test-tool
  t/helper: merge test-run-command into test-tool
  t/helper: merge test-scrap-cache-tree into test-tool
  t/helper: merge test-sha1-array into test-tool
  t/helper: merge test-sigchain into test-tool
  t/helper: merge test-strcmp-offset into test-tool
  t/helper: merge test-string-list into test-tool
  t/helper: merge test-submodule-config into test-tool
  t/helper: merge test-subprocess into test-tool
  t/helper: merge test-urlmatch-.. into test-tool
  t/helper: merge test-wildmatch into test-tool
  t/helper: merge test-write-cache into test-tool

 .../howto/recover-corrupted-object-harder.txt |   2 +-
 Makefile                                      |  79 +++---
 cache.h                                       |   2 +-
 name-hash.c                                   |   2 +-
 t/helper/test-chmtime.c                       |  15 +-
 t/helper/test-config.c                        |   5 +-
 t/helper/test-ctype.c                         |   3 +-
 t/helper/test-date.c                          |  17 +-
 t/helper/test-delta.c                         |   5 +-
 t/helper/test-drop-caches.c                   |   3 +-
 t/helper/test-dump-cache-tree.c               |   3 +-
 t/helper/test-dump-split-index.c              |   3 +-
 t/helper/test-example-decorate.c              |   3 +-
 t/helper/test-genrandom.c                     |   3 +-
 t/helper/test-hashmap.c                       |   5 +-
 t/helper/test-index-version.c                 |   3 +-
 t/helper/test-lazy-init-name-hash.c           |  26 +-
 t/helper/test-match-trees.c                   |   3 +-
 t/helper/test-mergesort.c                     |   3 +-
 t/helper/test-mktemp.c                        |   3 +-
 t/helper/test-online-cpus.c                   |   3 +-
 t/helper/test-path-utils.c                    |   3 +-
 t/helper/test-prio-queue.c                    |   3 +-
 t/helper/test-read-cache.c                    |   3 +-
 t/helper/test-ref-store.c                     |   3 +-
 t/helper/test-regex.c                         |   7 +-
 t/helper/test-revision-walking.c              |   3 +-
 t/helper/test-run-command.c                   |   3 +-
 t/helper/test-scrap-cache-tree.c              |   3 +-
 t/helper/test-sha1-array.c                    |   3 +-
 t/helper/test-sha1.c                          |   3 +-
 t/helper/test-sha1.sh                         |   4 +-
 t/helper/test-sigchain.c                      |   3 +-
 t/helper/test-strcmp-offset.c                 |   3 +-
 t/helper/test-string-list.c                   |   3 +-
 t/helper/test-submodule-config.c              |   3 +-
 t/helper/test-subprocess.c                    |   3 +-
 t/helper/test-tool.c                          |  62 ++++
 t/helper/test-tool.h                          |  40 +++
 t/helper/test-urlmatch-normalization.c        |   5 +-
 t/helper/test-wildmatch.c                     |   3 +-
 t/helper/test-write-cache.c                   |   3 +-
 t/lib-git-p4.sh                               |   2 +-
 t/lib-git-svn.sh                              |   2 +-
 t/lib-pack.sh                                 |   2 +-
 t/perf/p0002-read-cache.sh                    |   2 +-
 t/perf/p0004-lazy-init-name-hash.sh           |   8 +-
 t/perf/p0007-write-cache.sh                   |   2 +-
 t/perf/p0071-sort.sh                          |   2 +-
 t/perf/p7519-fsmonitor.sh                     |  12 +-
 t/t0005-signals.sh                            |   6 +-
 t/t0006-date.sh                               |   8 +-
 t/t0009-prio-queue.sh                         |   6 +-
 t/t0011-hashmap.sh                            |   4 +-
 t/t0013-sha1dc.sh                             |   2 +-
 t/t0021-conversion.sh                         |   4 +-
 t/t0060-path-utils.sh                         |  60 ++--
 t/t0061-run-command.sh                        |  24 +-
 t/t0062-revision-walking.sh                   |   2 +-
 t/t0063-string-list.sh                        |  48 ++--
 t/t0064-sha1-array.sh                         |  16 +-
 t/t0065-strcmp-offset.sh                      |   2 +-
 t/t0070-fundamental.sh                        |   8 +-
 t/t0090-cache-tree.sh                         |  18 +-
 t/t0110-urlmatch-normalization.sh             | 266 +++++++++---------
 t/t1006-cat-file.sh                           |   2 +-
 t/t1050-large.sh                              |   6 +-
 t/t1300-repo-config.sh                        |   2 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1308-config-set.sh                         |  22 +-
 t/t1309-early-config.sh                       |  12 +-
 t/t1405-main-ref-store.sh                     |   2 +-
 t/t1406-submodule-ref-store.sh                |   2 +-
 t/t1407-worktree-ref-store.sh                 |   4 +-
 t/t1501-work-tree.sh                          |  10 +-
 t/t1600-index.sh                              |   2 +-
 t/t1700-split-index.sh                        |  64 ++---
 t/t2022-checkout-paths.sh                     |   4 +-
 t/t2104-update-index-skip-worktree.sh         |   6 +-
 t/t3008-ls-files-lazy-init-name-hash.sh       |   4 +-
 t/t3070-wildmatch.sh                          |  14 +-
 t/t3306-notes-prune.sh                        |   2 +-
 t/t3404-rebase-interactive.sh                 |   4 +-
 t/t3418-rebase-continue.sh                    |   4 +-
 t/t3501-revert-cherry-pick.sh                 |   2 +-
 t/t3510-cherry-pick-sequence.sh               |   4 +-
 t/t3600-rm.sh                                 |   2 +-
 t/t3700-add.sh                                |   2 +-
 t/t4011-diff-symlink.sh                       |   2 +-
 t/t4013-diff-various.sh                       |   2 +-
 t/t4035-diff-quiet.sh                         |   2 +-
 t/t4151-am-abort.sh                           |   4 +-
 t/t4200-rerere.sh                             |  22 +-
 t/t5000-tar-tree.sh                           |   4 +-
 t/t5300-pack-object.sh                        |   4 +-
 t/t5301-sliding-window.sh                     |   2 +-
 t/t5302-pack-index.sh                         |  14 +-
 t/t5303-pack-corruption-resilience.sh         |  10 +-
 t/t5304-prune.sh                              |  16 +-
 t/t5310-pack-bitmaps.sh                       |   2 +-
 t/t5313-pack-bounds-checks.sh                 |   4 +-
 t/t5314-pack-cycle-detection.sh               |   2 +-
 t/t5316-pack-delta-depth.sh                   |   2 +-
 t/t5400-send-pack.sh                          |   2 +-
 t/t5516-fetch-push.sh                         |   2 +-
 t/t5546-receive-limits.sh                     |   2 +-
 t/t5547-push-quarantine.sh                    |   2 +-
 t/t5608-clone-2gb.sh                          |   2 +-
 t/t6022-merge-rename.sh                       |  30 +-
 t/t6500-gc.sh                                 |   2 +-
 t/t6501-freshen-objects.sh                    |   4 +-
 t/t7411-submodule-config.sh                   |  18 +-
 t/t7508-status.sh                             |   6 +-
 t/t7701-repack-unpack-unreachable.sh          |   6 +-
 t/t7812-grep-icase-non-ascii.sh               |   2 +-
 t/t9004-example.sh                            |   2 +-
 t/t9100-git-svn-basic.sh                      |   4 +-
 t/t9300-fast-import.sh                        |   2 +-
 t/t9802-git-p4-filetype.sh                    |   2 +-
 t/t9803-git-p4-shell-metachars.sh             |   4 +-
 t/t9813-git-p4-preserve-users.sh              |   6 +-
 t/t9820-git-p4-editor-handling.sh             |   2 +-
 t/test-lib.sh                                 |  10 +-
 123 files changed, 694 insertions(+), 549 deletions(-)
 create mode 100644 t/helper/test-tool.c
 create mode 100644 t/helper/test-tool.h

-- 
2.16.2.903.gd04caf5039

