Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96E3D1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeKJPdI (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42246 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbeKJPdI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so3366774ljk.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/7AG38zNWiVEX5tKBkszRR9439H7VqFEUDgHsdMQ2c=;
        b=bfZjz5BIsQcEm+gT/l1qUJVD8Ye31c7YxOxv4w9bH4JJNCslOfVj8ELJOGa2WzTxEU
         v3LItSD1f/KsoSoC2sbjVfAokEQJVmHInnj+G1l1iqAae+EgJ1y/boUYCPR4L5+dkWDc
         bl2CeZ2IqRKQ1Dwt7YSnAZbyfDoVKey8FHRtgV7Xh8190PwMfBQ9QQ30QDRf1p5JSScv
         ovTIuLjwnNU35h5M/1guguP3DbNeiY5okKwj4oqnUE41zur5jTCVHnQe0pR6+ktnmbOB
         k9ZWaqh+ljoTk8ZPwt/vo9sbknugHDJB3MRBi/IAGAX02E7xFBdemRQ6yAs0r4MkR05e
         Jpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/7AG38zNWiVEX5tKBkszRR9439H7VqFEUDgHsdMQ2c=;
        b=lDU0r/6QUQqNbxzROeqxZVk+X0Y8lb6J1FvOV5YiPxcLVKoZh9FBF6v1nixuyRlijI
         3ZQi1cETmDLlmc4r6/4lfLsREnTD1nJNl+taAYa+0+YHDxN0DAss2gRebgzj8NSjEyPn
         OBwJNkkfOQzxHc/LEYI6fC/OkrBxky46rgzlw9N8yrDGI5nJ4tWbK5EWKFu2d+QuO6Lk
         8kkULzwOvVCWsVf2IqEGdu7fygfupoU6JdHnGCo1NvQVQX2SE4Uq0REsH5pY8lmbkfN9
         +EiuRpnl8vTwbpqcaszuxCz3rkePsp+lpWFAgBwimxGamqkvNWLYMkXFbg9oUBFiMK2h
         hN/A==
X-Gm-Message-State: AGRZ1gK7sTbbAekhyoT7+0/a6CyqYENckBKan3/CAdQOFtPod8XNe+1o
        18IchV3UBVSwJ86xolR80gZQ9LHH
X-Google-Smtp-Source: AJdET5cpnwbO/g/WGDVC4vfPrIwD2ey/hnbB1w+ax2XvZAkVSppl9FS9YkS3xe+skfQiRrwhsU3jHQ==
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr6978945ljj.82.1541828959953;
        Fri, 09 Nov 2018 21:49:19 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:19 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/22] Kill the_index part 5
Date:   Sat, 10 Nov 2018 06:48:48 +0100
Message-Id: <20181110054910.10568-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Please ignore v1 which contains unrelated patches)

I lied about part 5 being final. This series contains most of my WIP
series [2] except sha1-name.c, read-cache.c and merge-recursive.c
because there will be conflicts on 'pu' so they will be in part 6. At
least this only results in two small conflicts in sequencer.c.

I did start pushing the_repository out of library code [1] in the bottom
half of this series. There aren't big surprises except that cache-tree
API now take _both_ struct repository and struct index_state. The
reason is cache-tree can work on temporary indexes and repo->index is
about $GIT_DIR/index.

[1] Stefan and I make a good team. He keeps adding the_repository. I
keep removing. We both hold hands leading commit counts (with Brian
just a bit behind frantically replacing sha1 with oid to keep up).
Meanwhile Junio is crying in the corner because of too many conflicts.
:-D

[2] https://public-inbox.org/git/20181019145237.16079-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (22):
  wt-status.c: remove implicit dependency on the_index
  wt-status.c: remove implicit dependency the_repository
  list-objects-filter.c: remove implicit dependency on the_index
  list-objects.c: reduce the_repository references
  notes-merge.c: remove implicit dependency on the_index
  notes-merge.c: remove implicit dependency the_repository
  transport.c: remove implicit dependency on the_index
  sequencer.c: remove implicit dependency on the_index
  sequencer.c: remove implicit dependency on the_repository
  blame.c: remove implicit dependency the_repository
  bisect.c: remove the_repository reference
  branch.c: remove the_repository reference
  bundle.c: remove the_repository references
  cache-tree.c: remove the_repository references
  delta-islands.c: remove the_repository references
  diff-lib.c: remove the_repository references
  line-log.c: remove the_repository reference
  notes-cache.c: remove the_repository references
  pack-check.c: remove the_repository references
  pack-*.c: remove the_repository references
  rerere.c: remove the_repository references
  rebase-interactive.c: remove the_repository references

 bisect.c                      |  48 ++--
 bisect.h                      |   5 +-
 blame.c                       |  39 +--
 branch.c                      |  21 +-
 branch.h                      |   8 +-
 builtin/am.c                  |   4 +-
 builtin/bisect--helper.c      |   2 +-
 builtin/branch.c              |   6 +-
 builtin/bundle.c              |   7 +-
 builtin/checkout.c            |   5 +-
 builtin/commit.c              |   8 +-
 builtin/fsck.c                |   3 +-
 builtin/merge-ours.c          |   2 +-
 builtin/merge.c               |   2 +-
 builtin/notes.c               |   2 +-
 builtin/pack-objects.c        |   6 +-
 builtin/pull.c                |   3 +-
 builtin/push.c                |   3 +-
 builtin/read-tree.c           |   4 +-
 builtin/rebase--interactive.c |  19 +-
 builtin/rebase.c              |  13 +-
 builtin/rerere.c              |  10 +-
 builtin/reset.c               |   4 +-
 builtin/revert.c              |   8 +-
 bundle.c                      |  26 +-
 bundle.h                      |   9 +-
 cache-tree.c                  |  26 +-
 cache-tree.h                  |   4 +-
 combine-diff.c                |   2 +-
 delta-islands.c               |  24 +-
 delta-islands.h               |   9 +-
 diff-lib.c                    |   7 +-
 diff.c                        |  12 +-
 diff.h                        |   5 +-
 diffcore-pickaxe.c            |   4 +-
 grep.c                        |   2 +-
 line-log.c                    |   2 +-
 list-objects-filter.c         |  10 +-
 list-objects-filter.h         |   2 +
 list-objects.c                |  13 +-
 notes-cache.c                 |  12 +-
 notes-cache.h                 |   6 +-
 notes-merge.c                 |  16 +-
 notes-merge.h                 |   5 +-
 pack-bitmap-write.c           |   6 +-
 pack-bitmap.c                 |  13 +-
 pack-bitmap.h                 |   3 +-
 pack-check.c                  |   9 +-
 pack-objects.c                |   6 +-
 pack-objects.h                |   5 +-
 pack.h                        |   4 +-
 read-cache.c                  |   2 +-
 rebase-interactive.c          |   6 +-
 rebase-interactive.h          |   5 +-
 ref-filter.c                  |   2 +-
 rerere.c                      |  26 +-
 rerere.h                      |   6 +-
 sequencer.c                   | 453 +++++++++++++++++++---------------
 sequencer.h                   |  27 +-
 transport.c                   |   9 +-
 transport.h                   |   3 +-
 unpack-trees.c                |   2 +-
 userdiff.c                    |   5 +-
 userdiff.h                    |   4 +-
 wt-status.c                   |  94 ++++---
 wt-status.h                   |  21 +-
 66 files changed, 650 insertions(+), 489 deletions(-)

-- 
2.19.1.1231.g84aef82467

