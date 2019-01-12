Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07ADA211B5
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfALCOG (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44397 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so7553050plt.11
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCSPxmr3ELvvXnEsbwa5WBz1fsMb3sVFX+39qbOyJFY=;
        b=osgQu4Zb5NQvW69ss9Hws81ogyj1NckaqdpemDpCoYZ2FUNuz8AuiYjM+Jl4Inodrp
         6thoZy/tW/olILjUePtXg6tBXGR8MyhqDKEsE4SIewIdn/AEgeNsNCNsZKUOM6g2xxou
         LwxeFcC29UO5eyVElWKGVzJ4Zj4YdTUruCCS7+2vv+EECsZ2EY6r6dU3Rn5i/1TbrHrr
         Cd1ljJhg5AZ/Gqmy6Kxl/EkeiYnkabGifHzMTlFYkMnY6xriuZbKcvgy4AzFYpS9Cidl
         ioFEq0so45n0VASAjgiDTYd/Nxn62sWUAq4AKJ7nPpfkUV4+eGythQZlXYqSiUpEVlV+
         13Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCSPxmr3ELvvXnEsbwa5WBz1fsMb3sVFX+39qbOyJFY=;
        b=Lfahw9/r+J76XcLWTm6xDpZcyvBydSqdjAR2cAbDM4BIiEF7KfGbRfwwMTmsA1FLoM
         FBZRtnjdFPFT2UgJF7jpbb3/ayRAltyTuuGX3tYuoNqSvsKnRsS11EiZwJp+ZkWXx3V9
         OuI0sYefQw4DOLn8rlOjxXO2HAT0bkyPRyaPbOIqo1WdJc7wOkpeudYZbDgP0a1Xr4B3
         V0Rq7FuhF2Bu//NRnCY/0F1BUFfk5wlzn+L8GtDU/bTjlpObmzA0iP3euGvejyIgWOM7
         UCJSC6TZkadtlqaLpIYw3EXxjVzDgJmNILYHC6GBg6CwGZUvkv+mfRPwdP2uvZY/wede
         k7Mw==
X-Gm-Message-State: AJcUukfm8J2LqlUFgjN2J/PcagY9djbn/b57fqaJPPAjDSlIulk8LjtX
        vgM8zCmJybdBdtOSITPTGmJurjhy
X-Google-Smtp-Source: ALg8bN4EOj4KloY/+9mM+CNOapTw35FzsnKQu/KzZn4toIPRxz5BPThcWsfTxSLeGTNlxD1IGDW4Xw==
X-Received: by 2002:a17:902:5982:: with SMTP id p2mr16836988pli.39.1547259245339;
        Fri, 11 Jan 2019 18:14:05 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i62sm93390542pge.44.2019.01.11.18.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:13:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/11] Remove the_index, the final part
Date:   Sat, 12 Jan 2019 09:13:21 +0700
Message-Id: <20190112021332.11066-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190105055153.3256-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes Martin's comment in 2/10 and also includes a new patch about
grep_opt->repo that was sent and reviewed during rc time [1]. It's kind
of the same topic so I include it here instead of resending it
separately.

[1] https://public-inbox.org/git/20181118163851.32178-1-pclouds@gmail.com/

Range-diff:

 -:  ---------- >  1:  2e43d9479e grep: use grep_opt->repo instead of explict repo argument
 1:  5e2b073fcc =  2:  f6eeeba0e7 notes-utils.c: remove the_repository references
 2:  7055e1e351 !  3:  1fca26dc83 repository.c: replace hold_locked_index() with repo_hold_locked_index()
    @@ -23,18 +23,6 @@
      
      	if (state->check_index && read_apply_cache(state) < 0) {
     
    - diff --git a/builtin/clone.c b/builtin/clone.c
    - --- a/builtin/clone.c
    - +++ b/builtin/clone.c
    -@@
    -  * Clone a repository into a different directory that does not yet exist.
    -  */
    - 
    -+#define USE_THE_INDEX_COMPATIBILITY_MACROS
    - #include "builtin.h"
    - #include "config.h"
    - #include "lockfile.h"
    -
      diff --git a/cache.h b/cache.h
      --- a/cache.h
      +++ b/cache.h
    @@ -117,6 +105,8 @@
     +			   struct lock_file *lf,
     +			   int flags)
     +{
    ++	if (!repo->index_file)
    ++		BUG("the repo hasn't been setup");
     +	return hold_lock_file_for_update(lf, repo->index_file, flags);
     +}
     
 3:  86d6231d9e =  4:  4f63b505d7 checkout: avoid the_index when possible
 4:  50b7828c17 =  5:  be722abc06 read-cache.c: kill read_index()
 5:  6cf6d66b97 =  6:  a86921c6b6 read-cache.c: replace update_index_if_able with repo_&
 6:  a5b19aac6d =  7:  637289c4ff sha1-name.c: remove implicit dependency on the_index
 7:  f9660a561e =  8:  f7fc854a43 merge-recursive.c: remove implicit dependency on the_index
 8:  be609ede73 =  9:  c1b37119a7 merge-recursive.c: remove implicit dependency on the_repository
 9:  639062ad41 = 10:  315f3f37d6 read-cache.c: remove the_* from index_has_changes()
10:  b41cebabad ! 11:  c271d734aa cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
    @@ -119,6 +119,18 @@
      #include "cache.h"
      #include "config.h"
     
    + diff --git a/builtin/clone.c b/builtin/clone.c
    + --- a/builtin/clone.c
    + +++ b/builtin/clone.c
    +@@
    +  * Clone a repository into a different directory that does not yet exist.
    +  */
    + 
    ++#define USE_THE_INDEX_COMPATIBILITY_MACROS
    + #include "builtin.h"
    + #include "config.h"
    + #include "lockfile.h"
    +
      diff --git a/builtin/commit.c b/builtin/commit.c
      --- a/builtin/commit.c
      +++ b/builtin/commit.c

Nguyễn Thái Ngọc Duy (11):
  grep: use grep_opt->repo instead of explict repo argument
  notes-utils.c: remove the_repository references
  repository.c: replace hold_locked_index() with
    repo_hold_locked_index()
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
 builtin/grep.c                       |  45 ++++---
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
 repository.c                         |  11 ++
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
 74 files changed, 385 insertions(+), 290 deletions(-)

-- 
2.20.0.482.g66447595a7

