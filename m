Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F1C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKJTHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiKJTHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB3C5802B
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso4695629wmb.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15eMQwvJF++5aDVXFKdE3MDZ0e8KNUhbdAtxF4VrPZw=;
        b=p27zqv7dqZgbOZVamntDnmq3qty+KhCZjax/PClblQQigEIuiwp0BnvLyPpnvgXxDz
         GS15USXy9Y3Y4qakIkFGhIwKNj4RL5oQRF57YyCcjm194CcZElFuL3uxK1bEaadFI/+M
         bN6qQcMqXAxCtIBQ7G8NeEbqi1chkb31/G7zgT9hfm18/Fj6lJLqXgarz/JPha600KFP
         zjsiJotiscXSn5Dgsi5uW/cx8evfzsVF8rnkp76Me670x2DA6Lss3POT2D+nREh1o1XT
         N9ZmNsXoLgKQJatwUUTvdceOCLSkmdnDwyqoBQ3KvqkBl9TOsfXxoBH3SN0m9KVC6cHk
         F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15eMQwvJF++5aDVXFKdE3MDZ0e8KNUhbdAtxF4VrPZw=;
        b=qVJCV6X8ZN/NiDQeIAHn7p9TRrR8d2DZbYCRnjVUr2pHHz6dQ0ObwBSRL7Pue2qaZB
         fwhK3hPdooYuWbTU3bzXbB9j6Ut8QaPeBoLGZ0TxGT+Ak9dkYsI9u1Ao5Rff/DgVN63/
         AfZWMfVYpcsMo+WtFFcEMUUmQ3buf6/VfuapSf13gVUME7A+meuAcIUm6Pd6hSzZBtyQ
         l2NdKHDpHgqMASacJUQfBmS8zgPSCU4HTa7+iHds3PiKiAihAAvtOgVL2ObQ8EtRFq2I
         +FcFrocPoCJIYYyLKA1beeR6rKm1tq6WkPRJmumhebFdYiLulRJC1dY3t+2/LC4EqLc9
         IVkQ==
X-Gm-Message-State: ACrzQf37eDTobOu/h39Fu3m2JUHu0mmKKufub8b3Cz6cnZeDPQdEk4dp
        UP26wKo2jhFRod1lNErJtD2okq49UGM=
X-Google-Smtp-Source: AMsMyM5q/wwKNnmt8pK0oqekwO8zSAaXPE+CWjPG0ZgmUtAA1lFCTMbm4pXimi0hrFlasBxclMMjNQ==
X-Received: by 2002:a05:600c:1:b0:3c6:c456:f07a with SMTP id g1-20020a05600c000100b003c6c456f07amr45626450wmc.158.1668107167932;
        Thu, 10 Nov 2022 11:06:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003c6c3fb3cf6sm390915wml.18.2022.11.10.11.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:07 -0800 (PST)
Message-Id: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:00 +0000
Subject: [PATCH v3 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()' is called immediate
 after
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on a discussion [1] around cache tree refreshes in 'git reset',
this series updates callers of 'unpack_trees()' to skip its internal
invocation of 'cache_tree_update()' when 'prime_cache_tree()' is called
immediately after 'unpack_trees()'. 'cache_tree_update()' can be an
expensive operation, and it is redundant when 'prime_cache_tree()' clears
and rebuilds the cache tree from scratch immediately after.

The first patch adds a test directly comparing the execution time of
'prime_cache_tree()' with that of 'cache_tree_update()'. The results show
that on a fully-valid cache tree, they perform the same, but on a partially-
or fully-invalid cache tree (the more likely case in commands with the
aforementioned redundancy), 'prime_cache_tree()' is faster.

The second patch introduces the 'skip_cache_tree_update' option for
'unpack_trees()', but does not use it yet.

The remaining three patches update callers that make the aforementioned
redundant cache tree updates. The performance impact on these callers ranges
from "negligible" (in 'rebase') to "substantial" (in 'read-tree') - more
details can be found in the commit messages of the patch associated with the
affected code path.


Changes since V2
================

 * Cleaned up option handling & provided more informative error messages in
   'test-tool cache-tree'. The changes don't affect any behavior in the
   added tests & 'test-tool cache-tree' won't be used outside of
   development, but the improvements here will help future readers avoid
   propagating error-prone implementations.
   * Note that the suggestion to change the "unknown subcommand" error to a
     'usage()' error was not taken, as it would be somewhat cumbersome to
     use a formatted string with it. This is in line with other custom
     subcommand parsing in Git, such as in 'fsmonitor--daemon.c'.


Changes since V1
================

 * Rewrote 'p0090' to more accurately and reliably test 'prime_cache_tree()'
   vs. 'cache_tree_update()'.
   * Moved iterative cache tree update out of C and into the shell tests (to
     avoid potential runtime optimizations)
   * Added a "control" test to document how much of the execution time is
     startup overhead
   * Added tests demonstrating performance in partially-invalid cache trees.
 * Fixed the use of 'prime_cache_tree()' in 'test-tool cache-tree', changing
   it from using the tree at HEAD to the current cache tree.

Thanks!

 * Victoria

[1] https://lore.kernel.org/git/xmqqlf30edvf.fsf@gitster.g/ [2]
https://lore.kernel.org/git/f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com/

Victoria Dye (5):
  cache-tree: add perf test comparing update and prime
  unpack-trees: add 'skip_cache_tree_update' option
  reset: use 'skip_cache_tree_update' option
  read-tree: use 'skip_cache_tree_update' option
  rebase: use 'skip_cache_tree_update' option

 Makefile                           |  1 +
 builtin/read-tree.c                |  4 ++
 builtin/reset.c                    |  2 +
 reset.c                            |  1 +
 sequencer.c                        |  1 +
 t/helper/test-cache-tree.c         | 64 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p0006-read-tree-checkout.sh |  8 ++++
 t/perf/p0090-cache-tree.sh         | 36 +++++++++++++++++
 t/perf/p7102-reset.sh              | 21 ++++++++++
 t/t1022-read-tree-partial-clone.sh |  2 +-
 unpack-trees.c                     |  3 +-
 unpack-trees.h                     |  3 +-
 14 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 t/helper/test-cache-tree.c
 create mode 100755 t/perf/p0090-cache-tree.sh
 create mode 100755 t/perf/p7102-reset.sh


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1411%2Fvdye%2Ffeature%2Fcache-tree-optimization-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1411/vdye/feature/cache-tree-optimization-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1411

Range-diff vs v2:

 1:  833519d87c8 ! 1:  2b48a684156 cache-tree: add perf test comparing update and prime
     @@ Commit message
          partially invalid (e.g., 'git reset --hard'), 'prime_cache_tree()' will
          likely perform better than 'cache_tree_update()' in typical cases.
      
     +    Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
      
       ## Makefile ##
     @@ t/helper/test-cache-tree.c (new)
      +
      +	setup_git_directory();
      +
     -+	parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
     ++	argc = parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
      +
      +	if (read_cache() < 0)
     -+		die("unable to read index file");
     ++		die(_("unable to read index file"));
      +
      +	oidcpy(&oid, &the_index.cache_tree->oid);
      +	tree = parse_tree_indirect(&oid);
     @@ t/helper/test-cache-tree.c (new)
      +			cache_tree_invalidate_path(&the_index, the_index.cache[i * interval]->name);
      +	}
      +
     -+	if (!argc)
     -+		die("Must specify subcommand");
     ++	if (argc != 1)
     ++		usage_with_options(test_cache_tree_usage, options);
      +	else if (!strcmp(argv[0], "prime"))
      +		prime_cache_tree(the_repository, &the_index, tree);
      +	else if (!strcmp(argv[0], "update"))
      +		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
      +	/* use "control" subcommand to specify no-op */
      +	else if (!!strcmp(argv[0], "control"))
     -+		die("Unknown command %s", argv[0]);
     ++		die(_("Unhandled subcommand '%s'"), argv[0]);
      +
      +	return 0;
      +}
 2:  b015a4f531c = 2:  0e03614f0fd unpack-trees: add 'skip_cache_tree_update' option
 3:  4f6039971b8 = 3:  386f18ca36a reset: use 'skip_cache_tree_update' option
 4:  5a646bc47c9 = 4:  ea5c82ce992 read-tree: use 'skip_cache_tree_update' option
 5:  fffe2fc17ed = 5:  100c01e936c rebase: use 'skip_cache_tree_update' option

-- 
gitgitgadget
