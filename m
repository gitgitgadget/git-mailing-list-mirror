Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F53E1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeHZNp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:26 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44577 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHZNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:25 -0400
Received: by mail-lf1-f47.google.com with SMTP id g6-v6so9702703lfb.11
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zu8vC2pcL+S0JOhDAZcrPGJ1r67ueOZBO1QIzt2xHXM=;
        b=etSm7TUgmfUdGIseoyGD1LeNVGaDNOF8ew2d2Y9ngNofA6s5dZYl1wsc44u6MSESvu
         7MUNbRwxiplyYV9zVHK8i7U6ApwfKoMprTcRKx1oXYG5bgl0+am059LqLFVyqTTULZSy
         OgGxXO6GDqYF7uAlHIZiT9liRk5pSaqGTdS54JXD/U+aa7JMjmPOnJcFwvhVBnweXwMK
         FoPqw+1veN8UGhOjHLcD0JZVJssr24H3P/bKzaMLDpQN34dX1lu6zwdy2q/dOQub+nuE
         k9OvXeOoSXiZIxqJGq4xkLM28u9+WBQrYwi3dw21mYuq1qz67KTCbsab/1GDWyz/tPo1
         K1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zu8vC2pcL+S0JOhDAZcrPGJ1r67ueOZBO1QIzt2xHXM=;
        b=O2T0J7TRt2ezHmdyckB5lmzGznN6jsQ0/5sC1PDPBxnZokO8ejzExwfXIfVtovSQHi
         WDEAj6oufmbW22QTSfBw0PfXDV15uISz/W3ZfFrEtFZiQI/k54Ni/XZ7ZcvC3mtUb8MZ
         pcej2yi6CnBvaammOmYmLZBUYGklnBTFRk0CVfjSNhTs7V5nutXl2GTgHyerQVamkNFX
         6a5eM354VhlRcyOPNE5+Uis2ON2jPEjIrE2iPaJtZqB8OVeYJEmp+nDZkZGboPtDLpXv
         UnKP1pDfg4//yHcR+92O87Tl0ynhSqVWOwo+0qPQ4DPj5DZg9s/x6wTCKcYflKvdxQcL
         biiQ==
X-Gm-Message-State: APzg51Bqkbn7u931c+RuluTQ1Hgy1tCLRxVjROB38O7e4CmUYqDB7sz4
        oNk1iAlZNKgg6ZA3WkD16J+iVX7q
X-Google-Smtp-Source: ANB0VdZmPXxwFjUofIFY18Xy6j4S53FDZ1tO4/A30IzxFoxmS7DN9DqafjP4RsU7G5DUBb0lMX5K3A==
X-Received: by 2002:a19:eb83:: with SMTP id f3-v6mr5446916lfk.89.1535277797721;
        Sun, 26 Aug 2018 03:03:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:16 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/21] Kill the_index part 4
Date:   Sun, 26 Aug 2018 12:02:53 +0200
Message-Id: <20180826100314.5137-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This continues the journey of getting rid of the_index at least in
library code. The focus of part 4 is diff code. Since 'struct
repository *' is passed around more (and even more in part 5), I take
this opportunity to remove some the_repository references too.

Besides some small conflicts on 'pu', like the previous part, it also
breaks 'pu' because of API changes. The fix is trivial though, just
prepend the_repository as the first argument for the broken function
calls.

After this and ~20 more patches in part5, the_index is gone from
library code.

Nguyễn Thái Ngọc Duy (21):
  archive.c: remove implicit dependency the_repository
  read-cache.c: remove 'const' from index_has_changes()
  combine-diff.c: remove implicit dependency on the_index
  diff.c: remove the_index dependency in textconv() functions
  grep.c: remove implicit dependency on the_index
  diff.c: remove implicit dependency on the_index
  read-cache.c: remove implicit dependency on the_index
  diff-lib.c: remove implicit dependency on the_index
  ll-merge.c: remove implicit dependency on the_index
  merge-blobs.c: remove implicit dependency on the_index
  merge.c: remove implicit dependency on the_index
  patch-ids.c: remove implicit dependency on the_index
  sha1-file.c: remove implicit dependency on the_index
  rerere.c: remove implicit dependency on the_index
  userdiff.c: remove implicit dependency on the_index
  line-range.c: remove implicit dependency on the_index
  submodule.c: remove implicit dependency on the_index
  tree-diff.c: remove implicit dependency on the_index
  ws.c: remove implicit dependency on the_index
  wt-status.c: remove implicit dependency on the_index
  wt-status.c: remove implicit dependency the_repository

 apply.c                |  19 +--
 archive-zip.c          |  14 ++-
 archive.c              |   2 +-
 blame.c                |  27 +++--
 builtin/am.c           |   4 +-
 builtin/blame.c        |   2 +-
 builtin/cat-file.c     |   6 +-
 builtin/checkout.c     |   3 +-
 builtin/commit.c       |   4 +-
 builtin/diff.c         |   2 +-
 builtin/difftool.c     |   2 +-
 builtin/grep.c         |   7 +-
 builtin/hash-object.c  |   2 +-
 builtin/log.c          |   9 +-
 builtin/merge-tree.c   |   2 +-
 builtin/merge.c        |  12 +-
 builtin/pull.c         |  12 +-
 builtin/range-diff.c   |   2 +-
 builtin/replace.c      |   2 +-
 builtin/rerere.c       |   6 +-
 builtin/reset.c        |   1 +
 builtin/update-index.c |   2 +-
 cache.h                |  14 ++-
 combine-diff.c         |  32 ++---
 diff-lib.c             |  17 +--
 diff-no-index.c        |   9 +-
 diff.c                 | 259 +++++++++++++++++++++++------------------
 diff.h                 |  19 ++-
 diffcore-break.c       |  12 +-
 diffcore-delta.c       |  12 +-
 diffcore-pickaxe.c     |   8 +-
 diffcore-rename.c      |  35 +++---
 diffcore.h             |  13 ++-
 grep.c                 |  34 +++---
 grep.h                 |  10 +-
 line-log.c             |  25 ++--
 line-range.c           |  22 ++--
 line-range.h           |   6 +-
 ll-merge.c             |  17 +--
 ll-merge.h             |   5 +-
 merge-blobs.c          |  16 ++-
 merge-blobs.h          |   7 +-
 merge-recursive.c      |   5 +-
 merge.c                |  20 ++--
 notes-merge.c          |   9 +-
 patch-ids.c            |   4 +-
 patch-ids.h            |   3 +-
 read-cache.c           |  33 +++---
 ref-filter.c           |   2 +-
 rerere.c               | 121 ++++++++++---------
 rerere.h               |   9 +-
 revision.c             |   8 +-
 sequencer.c            |  16 +--
 sha1-file.c            |  50 ++++----
 submodule.c            |  28 +++--
 submodule.h            |   9 +-
 transport.c            |   9 +-
 tree-diff.c            |   2 +-
 userdiff.c             |   5 +-
 userdiff.h             |   3 +-
 ws.c                   |   5 +-
 wt-status.c            |  88 ++++++++------
 wt-status.h            |  21 +++-
 63 files changed, 682 insertions(+), 482 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

