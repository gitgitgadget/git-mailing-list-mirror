Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED031F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfF0J3X (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35587 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0J3X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so754396pgl.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9xqErgJC+/vBrAtDxM4M3OmiWg2OBmcZ2RPH/7RFfg=;
        b=ucShbY6MQe1+aEtWv2ZnuJBq9nZW+UYL8OU1ON4+ShNDW5RVmrrzUNvIikJ7O3TgPM
         5qrpulG+PhDmIGrvtsfan+Ib7s4+TFSJlhWQqjSvW8YBpMm3K4jEHRHVZ26CeTWIAM+0
         6T0M29eK9iG+QM8zqUI33UqdWR7PVgiK6pMCf7QsghIhlWo+yYD2sVw14SM456+peBsm
         BMEEKF3sgKhtrkSX6x9JTgg9UpAob38mDkuPOGCUPPFqraeK0eEiS0EZnBtxFTODSBSU
         TVX7Le6M+YWUH/iunVP+xhg2K1fqIrNAhdfGpqxjtp54a9dmFLtcIYGCK0TBKC8wgXuW
         pN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9xqErgJC+/vBrAtDxM4M3OmiWg2OBmcZ2RPH/7RFfg=;
        b=GZLVvwHzGw9blI0lgGOZIlfLuYnuirplXz90zul/0b6aztyFPt1K227LeZvZ0/WwXO
         yTD1jPm8bDDp22GnTJ4sopoeUykAhXwUR0+IIg5dDv95gYbKchAtRIwmDrzgtRxVXayP
         k7uHMBQDMwainiGlxp8ldYYtGmIJtuPuHWIoowqQk8kI1Yac6BwiM+mIW2tJX24YrVmE
         uTRIy31vdjtdjzpwB/4+F7y8/+WNuuv17frjWYgluBv6tvGB/fA9vzkT2+M5fQy48kFR
         7Rt+k0YrY+RwE4I2qZpAev5ezxbsjagVW+BH4P1Bib0d4vasdh+U0yo8JgJiOfQFqPdx
         IIcQ==
X-Gm-Message-State: APjAAAURh7NrtP9H2EQmBxV1zPrCLYzJG4NJExBZRP8K8qy2jhpHwFRW
        LCaWWnoSVqNVPXBZYw6msFNsE95y
X-Google-Smtp-Source: APXvYqx8i6ltL4ESzuRSZgJLzVmgDNHdLVqbIqmWWUZ3DjzJx1wgbQ4HG/EMEI/D3ggPEPSJ8Py3RA==
X-Received: by 2002:a17:90a:9a83:: with SMTP id e3mr4742865pjp.105.1561627762394;
        Thu, 27 Jun 2019 02:29:22 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id o16sm5076285pgi.36.2019.06.27.02.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 27 Jun 2019 16:29:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/6] Kill the_repository in tree-walk.c
Date:   Thu, 27 Jun 2019 16:28:46 +0700
Message-Id: <20190627092852.11326-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624095533.22162-1-pclouds@gmail.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes t7814 flakiness. The problem is git-grep can operate on
multiple repos and I read objects from the wrong repo (supermodule)
instead of the submodule one.

There are still the_repository hidden in git-grep code paths, and the
hack of asborbing submodule's object db to the_repo's in order to make
it work.  And I can't quite understand how t7814 sometimes passed.

I'll revisit this after this series is done and will try to get rid of
add_to_alternates_memory() in git-grep.

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

Range-diff dựa trên v1:
1:  35d7cdbe6a ! 1:  9e73c39f9a sha1-file.c: remove the_repo from read_object_with_reference()
    @@ -3,7 +3,6 @@
         sha1-file.c: remove the_repo from read_object_with_reference()
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/cat-file.c b/builtin/cat-file.c
      --- a/builtin/cat-file.c
    @@ -27,7 +26,7 @@
      
      		grep_read_lock();
     -		data = read_object_with_reference(&object->oid, tree_type,
    -+		data = read_object_with_reference(opt->repo,
    ++		data = read_object_with_reference(&subrepo,
     +						  &object->oid, tree_type,
      						  &size, NULL);
      		grep_read_unlock();
2:  4ff146fb64 = 2:  b9107f7503 tree-walk.c: remove the_repo from fill_tree_descriptor()
3:  47f956bd0f = 3:  87ed67bde5 tree-walk.c: remove the_repo from get_tree_entry()
4:  e19c4b9ce6 = 4:  557b61f2ba tree-walk.c: remove the_repo from get_tree_entry_follow_symlinks()
5:  3fe87a7fde = 5:  53f09e0437 match-trees.c: remove the_repo from shift_tree*()
6:  6d0449f1a7 = 6:  d5d4d2ba65 Use the right 'struct repository' instead of the_repository
-- 
2.22.0.rc0.322.g2b0371e29a

