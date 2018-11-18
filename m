Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 184C71F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeKSDIx (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 22:08:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42518 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSDIx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 22:08:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so15947879lja.9
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AWD6DYhphdyozhbkujiyoOAbsDmZtEACypr6aYQZ1SA=;
        b=kHQMOvGgaZtIOgVxEy04N53GjaFni9JRudZJOfA2D6lORAwmZYtc9SLnvo1OpQTuBB
         1NcfPBgBOqSxNFQUygLq5SugNc5O98pzzVMyjN4YFWFg3Kq+Ra6lnR39RAiYO8yxYoav
         +KKDIYN0le/Zl345Ai21mZV52NhXfHgAn/75pAwIqbJJz5JGFzU9rfeMEXB3ErwgZasX
         y0EOw2YbawiCGK3PETepkGd95O1wjpSD41S2gLtNK5zgIClLuuW9FiXLgFKReM2H9H1A
         lM1/GvC4bQZpjtTTl73vxEYADVQ3lp0l4IY69krmrqIEOdz+QljZ7xmVvft8ertUmy0n
         JlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AWD6DYhphdyozhbkujiyoOAbsDmZtEACypr6aYQZ1SA=;
        b=rTW95kn9wk3A3aqRMmr9Jm0Z3tdFFDPlHUZVe2sSH+oJlRTHAnfiogbl+kHt5acTCH
         i2WX+IjSCC1Khtpc7/RFqLvx+YBsCRWaN/+1ZJiZSAXonxRUnEv824HOf70CutTgPqtD
         Hg8fqcnhh4013RiuxdCU84+TopiwajLSuOfCkMRCvcOCN1dZncwnisVgQ3SyAynO++hB
         k7DZuKrlPOLZOQhFckDjtEJugXVb2LRmPM54KbHawsz+YbLcEqz32BboQYUVoV1XaqA4
         vtltqpJLaZWzJ9SxBgG0AlOtGgeEWwCpmxYU6X6d85GAlKulXwsh8JdMMRi+Y9VCR8dj
         X0+A==
X-Gm-Message-State: AGRZ1gKS63aaLbvTiEGvkAgfyC69oEK5ibwPVtz0fxLqXA51qwXR5RIu
        2vp+Qj5erPiSd+YsD32uNHyIU/T+
X-Google-Smtp-Source: AJdET5eYO/6Ce40p2LjwKVueeYU3QmAyrkWaGX/3YqvD1cF4n6SaTDwWqPK+MtJKuUXwWgoSW5xbeg==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr9667245ljf.96.1542559686729;
        Sun, 18 Nov 2018 08:48:06 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f29sm4461603lfa.46.2018.11.18.08.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 08:48:06 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/5] Make :(attr) pathspec work with "git log"
Date:   Sun, 18 Nov 2018 17:47:55 +0100
Message-Id: <20181118164800.32759-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When :(attr) was added, it supported one of the two main pathspec
matching functions, the one that works on a list of paths. The other
one works on a tree, tree_entry_interesting(), which gets :(attr)
support in this series.

With this, "git grep <pattern> <tree> -- :(attr)" or "git log :(attr)"
will not abort with BUG() anymore.

But this also reveals an interesting thing: even though we walk on a
tree, we check attributes from _worktree_ (and optionally fall back to
the index). This is how attributes are implemented since forever. I
think this is not a big deal if we communicate clearly with the user.
But otherwise, this series can be scraped, as reading attributes from
a specific tree could be a lot of work.

The main patch is the last one. The others are just to open a path to
pass "struct index_state *" down to tree_entry_interesting(). This may
become standard procedure because we don't want to stick the_index (or
the_repository) here and there.

Nguyễn Thái Ngọc Duy (5):
  tree.c: make read_tree*() take 'struct repository *'
  tree-walk.c: make tree_entry_interesting() take an index
  pathspec.h: clean up "extern" in function declarations
  dir.c: move, rename and export match_attrs()
  tree-walk: support :(attr) matching

 Documentation/glossary-content.txt |  2 +
 archive.c                          |  6 +-
 builtin/checkout.c                 |  3 +-
 builtin/grep.c                     |  3 +-
 builtin/log.c                      |  5 +-
 builtin/ls-files.c                 |  2 +-
 builtin/ls-tree.c                  |  3 +-
 builtin/merge-tree.c               |  2 +-
 dir.c                              | 41 +-------------
 list-objects.c                     |  3 +-
 merge-recursive.c                  |  3 +-
 pathspec.c                         | 38 +++++++++++++
 pathspec.h                         | 27 +++++----
 revision.c                         |  1 +
 t/t6135-pathspec-with-attrs.sh     | 58 ++++++++++++++++++-
 tree-diff.c                        |  3 +-
 tree-walk.c                        | 89 ++++++++++++++++++++++--------
 tree-walk.h                        | 10 ++--
 tree.c                             | 21 ++++---
 tree.h                             | 18 +++---
 unpack-trees.c                     |  6 +-
 21 files changed, 235 insertions(+), 109 deletions(-)

-- 
2.19.1.1327.g328c130451.dirty

