Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9005B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeICWbd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:33 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:41582 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeICWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:33 -0400
Received: by mail-lj1-f180.google.com with SMTP id y17-v6so1076232ljy.8
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9U8RfHDQsvb9IL1+Wq4Nj/zE42ppM2jcJPXR3K50MpM=;
        b=uH/m+XEghblwGAfVH8dxUWCrO186k9hm0HX68Ey9OTaCHTweLqN+pcN56tUYeUxYoQ
         nEhPN3QcV917rhTgfwDzsbanLrkzR0QMf2RMEkovxDdqaNZd9Vr2dASau1rqxL9c4w8+
         llFIvMTTOtpgG4LKvA+C5epfhdKHV0P9MNA5j1yyw30hTxdMIjEpy6NDbKaisOSNcoXf
         MI9wVDiZBYZkxD+oEX9hFOjI7TUYBfgLR8P03qvlCjFlZylCpiarwM3naxPcSR6L0BM6
         V2mJFI5ryvrFv7Y8uQAjK+9v20PHAzLEu8I9hMy4hL6X9MndlaavktsKv/T7ZfaK9jfV
         EAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9U8RfHDQsvb9IL1+Wq4Nj/zE42ppM2jcJPXR3K50MpM=;
        b=j3WF9ZvK15KV2z1bLt7Jf9zukp1PLPOkBheqHZkf+vr8Cg9PKWVeUTRoqkpoMqxKqN
         teI0sXyndPZxlFTwFfP8ZL1zMTtdrzTkJlCSmWGqEH9bK6Y+41xV/ZEBhB7XAu72CKxu
         O1cCUGs3i90v4iZpUVuEkH4+1GqweGdk/l3FN/GZ9hmDCpEqkDrckZkPMERGEdiha62r
         LxP3/sb2RjG718oGm6UhzeDOUCM7f+9P8hOF4K+txOz5TWOhsMlVh2dPNnKfNKL1N31g
         WLm4pTVmEH9FrA/rSS9WzZFCZF8JYVYyPaIggCW9Atm2uitzhKBsP4FRaGfj94BNh14j
         G3pQ==
X-Gm-Message-State: APzg51CZkKXDqTRw2dFJUKYoStIRHMfcNVi7DXKlH4sJw8M3IYZJkAeW
        7yDc5MKG/Be8K+uhPT8mpv8=
X-Google-Smtp-Source: ANB0VdYv/6SePGN/RZT8cc32NqdppVDP0MDzWS6x3P8LQIyTxobYFrazpRfx6OSVsKvovnmhX3wqVA==
X-Received: by 2002:a2e:5201:: with SMTP id g1-v6mr17873596ljb.144.1535998211343;
        Mon, 03 Sep 2018 11:10:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 00/24] Kill the_index part 4
Date:   Mon,  3 Sep 2018 20:09:08 +0200
Message-Id: <20180903180932.32260-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes:

- the 'repo' argument is renamed to 'r' in most places.  I still keep
  'repo' as the name if it's not the first argument (i.e.  it's some
  normal parameter and not the "this" object in C++ sense).

- I accidentally merged the diff.c changes into the 'read-cache.c:
  remove const...' patch last time. It's now split up.

- wt-status.c is swapped out and revision.c takes its place at the end
  of the series. I figure revision.c and diff.c usually play hand in
  hand, might as well keep them in one part.

- The last patch is just to make sure 'pu' still builds after
  resolving conflicts, in case Junio picks it up. If 'stash' and
  'rebase' topics enter 'master' first, I could just drop this one.
  Otherwise I'll revert it some time later.

Nguyễn Thái Ngọc Duy (24):
  archive.c: remove implicit dependency the_repository
  read-cache.c: remove 'const' from index_has_changes()
  diff.c: reduce implicit dependency on the_index
  combine-diff.c: remove implicit dependency on the_index
  blame.c: rename "repo" argument to "r"
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
  revision.c: remove implicit dependency on the_index
  revision.c: reduce implicit dependency the_repository
  Rename functions to avoid breaking in-flight topics

 apply.c                          |  19 ++-
 archive-zip.c                    |  14 +-
 archive.c                        |   2 +-
 bisect.c                         |   4 +-
 blame.c                          |  63 ++++----
 builtin/add.c                    |   4 +-
 builtin/am.c                     |  10 +-
 builtin/blame.c                  |   4 +-
 builtin/cat-file.c               |   6 +-
 builtin/checkout.c               |   7 +-
 builtin/commit.c                 |   4 +-
 builtin/describe.c               |   4 +-
 builtin/diff-files.c             |   2 +-
 builtin/diff-index.c             |   2 +-
 builtin/diff-tree.c              |   2 +-
 builtin/diff.c                   |   4 +-
 builtin/difftool.c               |   2 +-
 builtin/fast-export.c            |   2 +-
 builtin/fmt-merge-msg.c          |   2 +-
 builtin/grep.c                   |   7 +-
 builtin/hash-object.c            |   2 +-
 builtin/log.c                    |  25 +--
 builtin/merge-tree.c             |   2 +-
 builtin/merge.c                  |  16 +-
 builtin/pack-objects.c           |   2 +-
 builtin/prune.c                  |   2 +-
 builtin/pull.c                   |   9 +-
 builtin/range-diff.c             |   2 +-
 builtin/reflog.c                 |   2 +-
 builtin/replace.c                |   2 +-
 builtin/rerere.c                 |   6 +-
 builtin/reset.c                  |   1 +
 builtin/rev-list.c               |   2 +-
 builtin/revert.c                 |   2 +-
 builtin/shortlog.c               |   2 +-
 builtin/submodule--helper.c      |   2 +-
 builtin/update-index.c           |   2 +-
 bundle.c                         |   4 +-
 cache.h                          |  14 +-
 combine-diff.c                   |  32 ++--
 diff-lib.c                       |  21 +--
 diff-no-index.c                  |   9 +-
 diff.c                           | 261 ++++++++++++++++++-------------
 diff.h                           |  20 ++-
 diffcore-break.c                 |  12 +-
 diffcore-delta.c                 |  12 +-
 diffcore-pickaxe.c               |   8 +-
 diffcore-rename.c                |  35 +++--
 diffcore.h                       |  13 +-
 grep.c                           |  34 ++--
 grep.h                           |  10 +-
 http-push.c                      |   2 +-
 line-log.c                       |  25 +--
 line-range.c                     |  22 ++-
 line-range.h                     |   6 +-
 list-objects.c                   |   8 +-
 ll-merge.c                       |  17 +-
 ll-merge.h                       |   5 +-
 merge-blobs.c                    |  16 +-
 merge-blobs.h                    |   7 +-
 merge-recursive.c                |   7 +-
 merge.c                          |  20 +--
 notes-merge.c                    |   9 +-
 pack-bitmap-write.c              |   2 +-
 patch-ids.c                      |   4 +-
 patch-ids.h                      |   3 +-
 read-cache.c                     |  33 ++--
 ref-filter.c                     |   2 +-
 remote.c                         |   2 +-
 rerere.c                         | 121 +++++++-------
 rerere.h                         |  10 +-
 revision.c                       |  76 ++++-----
 revision.h                       |  13 +-
 sequencer.c                      |  18 +--
 sha1-file.c                      |  50 +++---
 shallow.c                        |   2 +-
 submodule.c                      |  34 ++--
 submodule.h                      |   9 +-
 t/helper/test-revision-walking.c |   2 +-
 transport.c                      |   9 +-
 tree-diff.c                      |   2 +-
 userdiff.c                       |   5 +-
 userdiff.h                       |   3 +-
 ws.c                             |   5 +-
 wt-status.c                      |  10 +-
 85 files changed, 740 insertions(+), 549 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

