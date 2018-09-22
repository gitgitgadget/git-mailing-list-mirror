Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4837D1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIVX7d (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 19:59:33 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35599 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeIVX7d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 19:59:33 -0400
Received: by mail-lf1-f44.google.com with SMTP id r191-v6so1082763lff.2
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCLJ96XqaBVamaczLohwEQVWteGJy9skjMZYp0V/nJ0=;
        b=UqnLM3qmVY+GBfCiEJv0VoxoQpF6Z/70gIc3+5oVV+xzgZHDhOsGCibd4P2/YcPJIY
         H0usbUfgyuFvBDQZYHMNqwlBYAzvTLRiNAPP1F4vVmzVfiMVYpyFp8BZLBQMSWWFaUoA
         1iZxqFYuQsTZWEAvexDQV397sKXI9ASeOz/ZUF/KMU44IUWxpRuXny/7TH7PokHG3EhP
         D581BzrPXZCGTLhWaBXs2P7+FM+IASZ169n5BEAjppf6fFeTRezR/TWk3APmOH+mstJ4
         WBFTpz2o3okTVBB6SyKPls+LEDfQPx8elPKGg5NwkMi/tInrXGGJTLsN/6sdJWrk3/ZB
         5zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nCLJ96XqaBVamaczLohwEQVWteGJy9skjMZYp0V/nJ0=;
        b=PKwmdApdTPCnjEMsWudbKoE82DAtQfwTAd1QQjZdNkkMLEqI4Lk/ePSmwgreEzIeU4
         /Yd1Y9DZp9RFH58x8KM1w22HnzoGhLrT/WsvMEaf1g7vGxLuBMthWEnK6nC0lSaBzpsT
         EMXnU7HOA6w96MvMNqNUlH7xP4XUqpCzqBAM3yhkk57mLxvQ8Aur3dJmPvLFQWs+4Ym2
         LMXoLEEgarKBj2Joh247l1Zmg54yEKLcWs0Edc6yIK/QTDfmzt1LoYBKMoC2M1uuLNGn
         vE9NtzyMfWYrOYbHm1eyqnS3UxiACPXl4k9QF6J9sl2Mca38oNfkelxGs2ki7JuIXmNf
         1qng==
X-Gm-Message-State: APzg51BNgPUoD8rjC/V4PHup3QK5PE3zsZu8OOU/vnHOmp9obd6nRUm8
        3TQk4LsSRx2HiJslWz3OmGeJG7xo
X-Google-Smtp-Source: ANB0VdaKpd6JTUV5JFiPSVD90fKHp1dBoLGhmYZkGwZvK9IJGnVDHf57biYN6I15OsK1QzcInKVqIA==
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr1807571lfe.89.1537639506299;
        Sat, 22 Sep 2018 11:05:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f4-v6sm2877942lfa.9.2018.09.22.11.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 11:05:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/8] fix per-worktree ref iteration in fsck/reflog expire
Date:   Sat, 22 Sep 2018 20:04:52 +0200
Message-Id: <20180922180500.4689-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.647.gb9a6049235
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry it took me so long to revisit these bugs, even though the first
one was reported nearly a year ago. I guess I slept on it way longer
than I should have.

This series opens up the currrent worktree's ref space, allowing one
worktree to see refs from other worktrees. With this, it's possible to
have less confusing error reports (e.g. "heh.. what HEAD are you
talking about?"). And it's possible to peek one worktree from another,
e.g. now I could do

    git checkout main/HEAD
    make test -j8

in one terminal and go back to the original terminal and continue
hacking while tests are being run in the background.

With this issue out of the way, I could now continue to fix the
"forget to look at all HEADs/reflogs" problem in fsck and "reflog
expire". The fsck patches are mostly from Elijah with some code/test
adaptation from me.

I also take this opportunity to try to standardize a common/private
space in $GIT_DIR or ref hierarchy so we don't have to add more rules
in the future.

One heads up. One remaining problem with "refs and worktrees" is the
ability to completely separate ref space between worktrees (i.e.
refs/heads/master on worktree A is completely different than one in
worktree B). This is needed to make use worktrees in submodules. But
the way I see it, per-worktree refs may have to be moved back to
$GIT_COMMON_DIR/refs to be efficient.

This may be backward incompatible change. Haven't thought it through
yet (and didn't see it coming because I largely ignored refs/bisect,
which should have made me think about this much earlier)

Elijah Newren (2):
  fsck: Move fsck_head_link() to get_default_heads() to avoid some globals
  fsck: check HEAD and reflog from other worktrees

Nguyễn Thái Ngọc Duy (6):
  refs.c: indent with tabs, not spaces
  Add a place for (not) sharing stuff between worktrees
  refs: new ref types to make per-worktree refs visible to all worktrees
  revision.c: correct a parameter name
  revision.c: better error reporting on ref from different worktrees
  reflog expire: cover reflog from all worktrees

 Documentation/git-reflog.txt           |  7 ++-
 Documentation/gitrepository-layout.txt | 11 ++++-
 builtin/fsck.c                         | 68 ++++++++++++++++++--------
 builtin/reflog.c                       | 22 +++++++--
 path.c                                 |  1 +
 refs.c                                 | 23 ++++++++-
 refs.h                                 |  8 +--
 refs/files-backend.c                   | 42 ++++++++++++++--
 revision.c                             | 22 ++++++---
 t/t0060-path-utils.sh                  |  2 +
 t/t1415-worktree-refs.sh               | 66 +++++++++++++++++++++++++
 t/t1450-fsck.sh                        | 39 +++++++++++++++
 worktree.c                             | 32 ++++++++++--
 worktree.h                             | 14 ++++++
 14 files changed, 312 insertions(+), 45 deletions(-)
 create mode 100755 t/t1415-worktree-refs.sh

-- 
2.19.0.647.gb9a6049235

