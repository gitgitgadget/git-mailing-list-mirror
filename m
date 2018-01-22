Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D691F424
	for <e@80x24.org>; Mon, 22 Jan 2018 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeAVJcy (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 04:32:54 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:39227 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeAVJcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 04:32:52 -0500
Received: by mail-oi0-f41.google.com with SMTP id t8so5482989oie.6
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 01:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=drBkdwfJCB5wO3SbPMSRXIQV9wBWUTQcn2RBqmh01dQ=;
        b=Uw5/pXbKJcisySSK8Gg/mDt29WbTyyNa4OuA5Tzb0ZaVLbWTO+ULNSq//sBdI76DdG
         cxGG256+W+Rvrn5jiRSKHpUOyYVXnMIKliG4AyKDfKYCEDER5Wt1udOMf4bB5QFT60ep
         ZaPOxBX71r3bA5ZUNKOG1OYC8g1QPvLZbsm2FaJ1S50dje7LnePL/er/socHvyZt7SfS
         UyvgLgG/+pTh0VM2daD/tMgGAzZpx5peeRvNEytI1MSIUxBegAbxUbnB44NKNjaoqXGo
         o5iqpZoeogQ9M0TnWhtStbXet7tIGNTdKxnZ5OHdEj1vrAaISmvVS3BeQWtBrAj2/dl7
         RmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=drBkdwfJCB5wO3SbPMSRXIQV9wBWUTQcn2RBqmh01dQ=;
        b=J3FERTVqALbWU9U/8ocLgNT7FXyUOe7hw3HjaYs5sPUkJJmWeyuYm1TCdiyoUM1KW3
         1DFXysD53LtmQ7sAr0F0w8LDHCA3MGCg1uTvrDMCJ6aP05A2EKorSB2H6q8p6eZKBSPW
         /nsQEVH/lklW6Ihy4t3oJxYoiUqA1rpM1ENbHnIxRyBIVLA126kdEK0bth+l+g2kvTYC
         OFKONKLEtzDChZOUGI+aX8vh1SmTEHqSWxm6zRqu5/MXuBGLrPZ44++0Lh6QVAAySVcc
         ONWxiC7N/UXTK5wPJJDZPVkJ70mSrd1hQc1dWQ+Q8P902vYPqv7v7JpgZIEeplNNZ59N
         tDIg==
X-Gm-Message-State: AKwxytd3ubFzdSfg6SR9cw1xMoq/JJzDZZGgxK/F1egN46AIWRZIh2QC
        hbdKgVgJ91XJZVMAs+tnc1Hs/vsYDCdXneDEtOdU+A==
X-Google-Smtp-Source: AH8x225EdazZAV73SoDEpurE8fv75+BXHef4HRLp1xom2y0Oidu6/wcI+B4ZNU84hjF9HTmpt9TjZdPl6ADEsz8dopY=
X-Received: by 10.202.171.195 with SMTP id u186mr3440993oie.253.1516613571711;
 Mon, 22 Jan 2018 01:32:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Mon, 22 Jan 2018 01:32:21 -0800 (PST)
In-Reply-To: <20180122092114.27640-1-pclouds@gmail.com>
References: <20180122092114.27640-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Jan 2018 16:32:21 +0700
Message-ID: <CACsJy8CSja4Lh1co4PfMmag=REhEpfYrDchWzQrJW1p9uV=1HA@mail.gmail.com>
Subject: Re: [PATCH/RFC] Merge most test helper programs into a new one "test-tool"
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops, this patch is over 100KB and will likely be blocked by
vger.kernel.org. I may need to split it and resend later, but I think
the commit message is enough for discussion (the actual changes are
not that interesting anyway). The commit is only available at
https://github.com/pclouds/git/tree/t-helper-all-in-one

On Mon, Jan 22, 2018 at 4:21 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Plenty small programs in t/helper are now part of a bigger one called
> test-tool. There are two benefits in merging multiple programs into
> one:
>
> - t/helper consumes less disk space (31MB vs 152MB)
> - link time is reduced (with ccache on and -j1, 16s vs 24s)
>
> The following programs remain standalone because...
>
> - test-line-buffer:
> - test-svn-fe: extra dependencies
>
> - test-fake-ssh: some tests require this to be a single argument,
>   splitting it into 'test-tool fake-ssh' creates new problems
>
> - test-dump-fsmonitor:
> - test-dump-untracked-cache:
> - test-run-command:
> - test-wildmatch: some in-flight topics add or remove call sites. It
>   is simpler to leave them out until the dust settles. Then we can
>   move them to test-tool.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  This may bring joy to Johannes and pain to Junio. I've excluded some
>  programs to reduce merge conflicts on 'pu' (only one conflict left in
>  Makefile due to a new test program). But if some new topics show up
>  and use these programs, it's going to be pain pain pain.
>
>  Makefile                                |  77 ++++-----
>  cache.h                                 |   2 +-
>  name-hash.c                             |   2 +-
>  t/helper/test-chmtime.c                 |   3 +-
>  t/helper/test-config.c                  |   3 +-
>  t/helper/test-ctype.c                   |   3 +-
>  t/helper/test-date.c                    |   3 +-
>  t/helper/test-delta.c                   |   3 +-
>  t/helper/test-drop-caches.c             |   3 +-
>  t/helper/test-dump-cache-tree.c         |   3 +-
>  t/helper/test-dump-split-index.c        |   3 +-
>  t/helper/test-example-decorate.c        |   3 +-
>  t/helper/test-genrandom.c               |   3 +-
>  t/helper/test-hashmap.c                 |   3 +-
>  t/helper/test-index-version.c           |   3 +-
>  t/helper/test-lazy-init-name-hash.c     |  13 +-
>  t/helper/test-match-trees.c             |   3 +-
>  t/helper/test-mergesort.c               |   3 +-
>  t/helper/test-mktemp.c                  |   3 +-
>  t/helper/test-online-cpus.c             |   3 +-
>  t/helper/test-parse-options.c           |   3 +-
>  t/helper/test-path-utils.c              |   3 +-
>  t/helper/test-prio-queue.c              |   3 +-
>  t/helper/test-read-cache.c              |   3 +-
>  t/helper/test-ref-store.c               |   3 +-
>  t/helper/test-regex.c                   |   3 +-
>  t/helper/test-revision-walking.c        |   3 +-
>  t/helper/test-scrap-cache-tree.c        |   3 +-
>  t/helper/test-sha1-array.c              |   3 +-
>  t/helper/test-sha1.c                    |   3 +-
>  t/helper/test-sha1.sh                   |   4 +-
>  t/helper/test-sigchain.c                |   3 +-
>  t/helper/test-strcmp-offset.c           |   3 +-
>  t/helper/test-string-list.c             |   3 +-
>  t/helper/test-submodule-config.c        |   3 +-
>  t/helper/test-subprocess.c              |   3 +-
>  t/helper/test-tool.c (new)              |  66 ++++++++
>  t/helper/test-tool.h (new)              |  39 +++++
>  t/helper/test-urlmatch-normalization.c  |   3 +-
>  t/helper/test-write-cache.c             |   3 +-
>  t/lib-git-p4.sh                         |   2 +-
>  t/lib-git-svn.sh                        |   2 +-
>  t/lib-pack.sh                           |   2 +-
>  t/perf/p0002-read-cache.sh              |   2 +-
>  t/perf/p0004-lazy-init-name-hash.sh     |   8 +-
>  t/perf/p0007-write-cache.sh             |   2 +-
>  t/perf/p0071-sort.sh                    |   2 +-
>  t/perf/p7519-fsmonitor.sh               |  12 +-
>  t/t0005-signals.sh                      |   6 +-
>  t/t0006-date.sh                         |   8 +-
>  t/t0009-prio-queue.sh                   |   6 +-
>  t/t0011-hashmap.sh                      |   4 +-
>  t/t0013-sha1dc.sh                       |   4 +-
>  t/t0021-conversion.sh                   |   4 +-
>  t/t0040-parse-options.sh                |  68 ++++----
>  t/t0060-path-utils.sh                   |  60 +++----
>  t/t0062-revision-walking.sh             |   2 +-
>  t/t0063-string-list.sh                  |  48 +++---
>  t/t0064-sha1-array.sh                   |  16 +-
>  t/t0065-strcmp-offset.sh                |   2 +-
>  t/t0070-fundamental.sh                  |   8 +-
>  t/t0090-cache-tree.sh                   |  18 +--
>  t/t0110-urlmatch-normalization.sh       | 266 ++++++++++++++++----------=
------
>  t/t1006-cat-file.sh                     |   2 +-
>  t/t1050-large.sh                        |   6 +-
>  t/t1300-repo-config.sh                  |   2 +-
>  t/t1305-config-include.sh               |   2 +-
>  t/t1308-config-set.sh                   |  22 +--
>  t/t1309-early-config.sh                 |  12 +-
>  t/t1405-main-ref-store.sh               |   2 +-
>  t/t1406-submodule-ref-store.sh          |   2 +-
>  t/t1407-worktree-ref-store.sh           |   4 +-
>  t/t1501-work-tree.sh                    |  10 +-
>  t/t1600-index.sh                        |   2 +-
>  t/t1700-split-index.sh                  |  62 ++++----
>  t/t2022-checkout-paths.sh               |   4 +-
>  t/t2104-update-index-skip-worktree.sh   |   6 +-
>  t/t3008-ls-files-lazy-init-name-hash.sh |   4 +-
>  t/t3306-notes-prune.sh                  |   2 +-
>  t/t3404-rebase-interactive.sh           |   4 +-
>  t/t3418-rebase-continue.sh              |   4 +-
>  t/t3501-revert-cherry-pick.sh           |   2 +-
>  t/t3510-cherry-pick-sequence.sh         |   4 +-
>  t/t3600-rm.sh                           |   2 +-
>  t/t3700-add.sh                          |   2 +-
>  t/t4011-diff-symlink.sh                 |   2 +-
>  t/t4013-diff-various.sh                 |   2 +-
>  t/t4035-diff-quiet.sh                   |   2 +-
>  t/t4151-am-abort.sh                     |   4 +-
>  t/t4200-rerere.sh                       |  22 +--
>  t/t5000-tar-tree.sh                     |   4 +-
>  t/t5300-pack-object.sh                  |   4 +-
>  t/t5301-sliding-window.sh               |   2 +-
>  t/t5302-pack-index.sh                   |  14 +-
>  t/t5303-pack-corruption-resilience.sh   |  10 +-
>  t/t5304-prune.sh                        |  16 +-
>  t/t5310-pack-bitmaps.sh                 |   2 +-
>  t/t5313-pack-bounds-checks.sh           |   4 +-
>  t/t5314-pack-cycle-detection.sh         |   2 +-
>  t/t5316-pack-delta-depth.sh             |   2 +-
>  t/t5400-send-pack.sh                    |   2 +-
>  t/t5516-fetch-push.sh                   |   2 +-
>  t/t5546-receive-limits.sh               |   2 +-
>  t/t5547-push-quarantine.sh              |   2 +-
>  t/t5608-clone-2gb.sh                    |   2 +-
>  t/t6022-merge-rename.sh                 |  30 ++--
>  t/t6500-gc.sh                           |   2 +-
>  t/t6501-freshen-objects.sh              |   4 +-
>  t/t7411-submodule-config.sh             |  18 +--
>  t/t7508-status.sh                       |   6 +-
>  t/t7701-repack-unpack-unreachable.sh    |   6 +-
>  t/t7812-grep-icase-non-ascii.sh         |   2 +-
>  t/t9004-example.sh                      |   2 +-
>  t/t9100-git-svn-basic.sh                |   4 +-
>  t/t9300-fast-import.sh                  |   2 +-
>  t/t9802-git-p4-filetype.sh              |   2 +-
>  t/t9803-git-p4-shell-metachars.sh       |   4 +-
>  t/t9813-git-p4-preserve-users.sh        |   6 +-
>  t/t9820-git-p4-editor-handling.sh       |   2 +-
>  t/test-lib.sh                           |  10 +-
>  120 files changed, 681 insertions(+), 537 deletions(-)
>  create mode 100644 t/helper/test-tool.c
>  create mode 100644 t/helper/test-tool.h
--=20
Duy
