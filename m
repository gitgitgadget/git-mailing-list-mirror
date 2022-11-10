Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B04C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiKJB6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKJB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920102D74A
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v1so292487wrt.11
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWwBOWtFcdAxATwikM1Gnx7Jra3kh9xR39YL+wtn8AQ=;
        b=MjYEMc9VvH18sAX23NxxUNULoP+HZZ8ygvltgolTBFBHU8GC3nnnoNe5tRh4tdQW63
         Xi4yhkv56f0J+lT1Ew5LTNHIkWpxQlatnG8FfSZ6x886vLD92qWjF7QuQ0Fr/chYm51B
         n+gEQt4gaU5gKJqmURYh3vZecudjAcv53ocbBoNQmAq9QnjgKyRCO1d3ukpddwpJGWHd
         G6cnOUdUcZU0x1ziDeoYk24q7LmAivFPAf8g+vzLqn3epTibYZBDmxXnA1LusdgqFlmp
         5Dyjsdy+Lp0mEfHBs3b9EooHwqvuDE3z0lrlzUGn/x7RsGzka4fc+Y0D6wyiPSirwIxj
         d6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWwBOWtFcdAxATwikM1Gnx7Jra3kh9xR39YL+wtn8AQ=;
        b=5vU6UyqhO/zd+1BjawzQ9ZC3YNjU1PUn+WLrnVTWBM90eeCA1MD7k/NICW+Ija4o8m
         KO8sBYYcBlkVh9wxpT6Pv4BoRXfK1ab9Utz1Re49qP1k+Gv2dk64dQzrOZ857zpLQSXA
         42Em40SyRe4gl8/L5C9In84rqOvCfu/R0bqlFYNw5QXF6PL29zdgjs82lVrRkkYHISHq
         VoVpQwp4aPiMW0cnEDeyuzYR/Y37wjtvcvzihHQ7ovtLmmre/pxwFSNQefdLzb47Nxcg
         /Nr63JCONe07g7YIhNj+bif1wjl7nRvBmfvR/AOSCF261Fe8W4rLug1Ex6TuCYTqKX9/
         o+FA==
X-Gm-Message-State: ACrzQf19HFRisU2xVIQUySpARpfTHDP5uOksiElfJDGWr5Uw+FCDcbcz
        fsbHZ+dt7lqIidzTe5un/O2OgU8SoUE=
X-Google-Smtp-Source: AMsMyM6uWK3m8YYAZm7kPJqYq8hAFmZZWtpc1D4yE+rhgzxdXEQBVA0K3igdqpz0FJG4b6rF3OUYRg==
X-Received: by 2002:a05:6000:18a4:b0:238:3f91:554f with SMTP id b4-20020a05600018a400b002383f91554fmr23149835wri.682.1668045439824;
        Wed, 09 Nov 2022 17:57:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d4302000000b0022ae0965a8asm14257566wrq.24.2022.11.09.17.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:19 -0800 (PST)
Message-Id: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:12 +0000
Subject: [PATCH v2 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()' is called immediate
 after
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1411%2Fvdye%2Ffeature%2Fcache-tree-optimization-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1411/vdye/feature/cache-tree-optimization-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1411

Range-diff vs v1:

 1:  45c198c629d ! 1:  833519d87c8 cache-tree: add perf test comparing update and prime
     @@ Commit message
          rebuilding an invalid cache tree, ultimately to remove one when both are
          (reundantly) called in immediate succession.
      
     -    Both methods are incredibly fast, so the new tests in 'p0090-cache-tree.sh'
     -    must call the tested method many times in succession to get non-negligible
     -    timing results. Results show a substantial difference in execution time
     -    between the two, with 'prime_cache_tree()' appearing to be the overall
     -    faster method:
     +    Both methods are fast, so the new tests in 'p0090-cache-tree.sh' must call
     +    each tested function multiple times to ensure the reported times (to 0.01s
     +    resolution) convey the differences between them.
      
     -    Test                                 this tree
     -    ----------------------------------------------------
     -    0090.1: prime_cache_tree, clean      0.07(0.05+0.01)
     -    0090.2: cache_tree_update, clean     0.11(0.05+0.06)
     -    0090.3: prime_cache_tree, invalid    0.06(0.05+0.01)
     -    0090.4: cache_tree_update, invalid   0.50(0.41+0.07)
     +    The tests compare the timing of a 'test-tool cache-tree' run as a no-op (to
     +    capture a baseline for the overhead associated with running the tool),
     +    'cache_tree_update()', and 'prime_cache_tree()' on four scenarios:
     +
     +    - A completely valid cache tree
     +    - A cache tree with 2 invalid paths
     +    - A cache tree with 50 invalid paths
     +    - A completely empty cache tree
     +
     +    Example results:
     +
     +    Test                                        this tree
     +    -----------------------------------------------------------
     +    0090.2: no-op, clean                        1.27(0.48+0.52)
     +    0090.3: prime_cache_tree, clean             2.02(0.83+0.85)
     +    0090.4: cache_tree_update, clean            1.30(0.49+0.54)
     +    0090.5: no-op, invalidate 2                 1.29(0.48+0.54)
     +    0090.6: prime_cache_tree, invalidate 2      1.98(0.81+0.83)
     +    0090.7: cache_tree_update, invalidate 2     2.12(0.94+0.86)
     +    0090.8: no-op, invalidate 50                1.32(0.50+0.55)
     +    0090.9: prime_cache_tree, invalidate 50     2.10(0.86+0.89)
     +    0090.10: cache_tree_update, invalidate 50   2.35(1.14+0.90)
     +    0090.11: no-op, empty                       1.33(0.50+0.54)
     +    0090.12: prime_cache_tree, empty            2.04(0.84+0.87)
     +    0090.13: cache_tree_update, empty           2.51(1.27+0.92)
     +
     +    These timings show that, while 'cache_tree_update()' is faster when the
     +    cache tree is completely valid, it is equal to or slower than
     +    'prime_cache_tree()' when there are any invalid paths. Since the redundant
     +    calls are mostly in scenarios where the cache tree will be at least
     +    partially invalid (e.g., 'git reset --hard'), 'prime_cache_tree()' will
     +    likely perform better than 'cache_tree_update()' in typical cases.
      
          Signed-off-by: Victoria Dye <vdye@github.com>
      
     @@ t/helper/test-cache-tree.c (new)
      +#include "parse-options.h"
      +
      +static char const * const test_cache_tree_usage[] = {
     -+	N_("test-tool cache-tree <options> (prime|repair)"),
     ++	N_("test-tool cache-tree <options> (control|prime|update)"),
      +	NULL
      +};
      +
     @@ t/helper/test-cache-tree.c (new)
      +{
      +	struct object_id oid;
      +	struct tree *tree;
     -+	int fresh = 0;
     -+	int count = 1;
     ++	int empty = 0;
     ++	int invalidate_qty = 0;
      +	int i;
      +
      +	struct option options[] = {
     -+		OPT_BOOL(0, "fresh", &fresh,
     -+			 N_("clear the cache tree before each repetition")),
     -+		OPT_INTEGER_F(0, "count", &count, N_("number of times to repeat the operation"),
     ++		OPT_BOOL(0, "empty", &empty,
     ++			 N_("clear the cache tree before each iteration")),
     ++		OPT_INTEGER_F(0, "invalidate", &invalidate_qty,
     ++			      N_("number of entries in the cache tree to invalidate (default 0)"),
      +			      PARSE_OPT_NONEG),
      +		OPT_END()
      +	};
     @@ t/helper/test-cache-tree.c (new)
      +	if (read_cache() < 0)
      +		die("unable to read index file");
      +
     -+	get_oid("HEAD", &oid);
     ++	oidcpy(&oid, &the_index.cache_tree->oid);
      +	tree = parse_tree_indirect(&oid);
     -+	for (i = 0; i < count; i++) {
     -+		if (fresh)
     -+			cache_tree_free(&the_index.cache_tree);
     -+
     -+		if (!argc)
     -+			die("Must specify subcommand");
     -+		else if (!strcmp(argv[0], "prime"))
     -+			prime_cache_tree(the_repository, &the_index, tree);
     -+		else if (!strcmp(argv[0], "update"))
     -+			cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
     -+		else
     -+			die("Unknown command %s", argv[0]);
     ++	if (!tree)
     ++		die(_("not a tree object: %s"), oid_to_hex(&oid));
     ++
     ++	if (empty) {
     ++		/* clear the cache tree & allocate a new one */
     ++		cache_tree_free(&the_index.cache_tree);
     ++		the_index.cache_tree = cache_tree();
     ++	} else if (invalidate_qty) {
     ++		/* invalidate the specified number of unique paths */
     ++		float f_interval = (float)the_index.cache_nr / invalidate_qty;
     ++		int interval = f_interval < 1.0 ? 1 : (int)f_interval;
     ++		for (i = 0; i < invalidate_qty && i * interval < the_index.cache_nr; i++)
     ++			cache_tree_invalidate_path(&the_index, the_index.cache[i * interval]->name);
      +	}
      +
     ++	if (!argc)
     ++		die("Must specify subcommand");
     ++	else if (!strcmp(argv[0], "prime"))
     ++		prime_cache_tree(the_repository, &the_index, tree);
     ++	else if (!strcmp(argv[0], "update"))
     ++		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
     ++	/* use "control" subcommand to specify no-op */
     ++	else if (!!strcmp(argv[0], "control"))
     ++		die("Unknown command %s", argv[0]);
     ++
      +	return 0;
      +}
      
     @@ t/perf/p0090-cache-tree.sh (new)
      @@
      +#!/bin/sh
      +
     -+test_description="Tests performance of cache tree operations"
     ++test_description="Tests performance of cache tree update operations"
      +
      +. ./perf-lib.sh
      +
      +test_perf_large_repo
      +test_checkout_worktree
      +
     -+count=200
     -+test_perf "prime_cache_tree, clean" "
     -+	test-tool cache-tree --count $count prime
     -+"
     ++count=100
     ++
     ++test_expect_success 'setup cache tree' '
     ++	git write-tree
     ++'
      +
     -+test_perf "cache_tree_update, clean" "
     -+	test-tool cache-tree --count $count update
     -+"
     ++test_cache_tree () {
     ++	test_perf "$1, $3" "
     ++		for i in \$(test_seq $count)
     ++		do
     ++			test-tool cache-tree $4 $2
     ++		done
     ++	"
     ++}
      +
     -+test_perf "prime_cache_tree, invalid" "
     -+	test-tool cache-tree --count $count --fresh prime
     -+"
     ++test_cache_tree_update_functions () {
     ++	test_cache_tree 'no-op' 'control' "$1" "$2"
     ++	test_cache_tree 'prime_cache_tree' 'prime' "$1" "$2"
     ++	test_cache_tree 'cache_tree_update' 'update' "$1" "$2"
     ++}
      +
     -+test_perf "cache_tree_update, invalid" "
     -+	test-tool cache-tree --count $count --fresh update
     -+"
     ++test_cache_tree_update_functions "clean" ""
     ++test_cache_tree_update_functions "invalidate 2" "--invalidate 2"
     ++test_cache_tree_update_functions "invalidate 50" "--invalidate 50"
     ++test_cache_tree_update_functions "empty" "--empty"
      +
      +test_done
 2:  d0a20cafd39 = 2:  b015a4f531c unpack-trees: add 'skip_cache_tree_update' option
 3:  908fe764670 = 3:  4f6039971b8 reset: use 'skip_cache_tree_update' option
 4:  319f1d71b2e = 4:  5a646bc47c9 read-tree: use 'skip_cache_tree_update' option
 5:  dd4edd7cad8 = 5:  fffe2fc17ed rebase: use 'skip_cache_tree_update' option

-- 
gitgitgadget
