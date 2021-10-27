Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8950C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8AB60F90
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhJ0Olw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhJ0Olv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B4AC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p14so4528076wrd.10
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyRQ2s5ZnTBwgr72ilQJ1M3XL2xhyduxrDwGzvyuBog=;
        b=GxgABdBpnLvvrkNirkK5N2TBScrU1Bnodp7Z54cq0oWHGN7MJb+ESEJGVm9rgxjh6i
         HrN7ENQogV1T2uvX9k67Vd72SuNZYwuhongtmL7WLyJNnY58ZC0mayCXycwR0z6SfBlz
         UEvN4R9srYcWhoOV4ELkWb6MW4Rosh6pr+jLul8JeTbcAGeIlq5A/0qlK2OtjWsFsG0T
         PcRoYseidfJBT025nQUKIFgoKwZvpWZu2quXO7WmFi3BwOCQwWwRuKDzsvJq1dkwH/QA
         2TYBvN68SDihoAqfBouwtFA1A2NNGRz84nuZkOnFO6TYyRVB17XNDnPWcrcfy2NqLAra
         LO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyRQ2s5ZnTBwgr72ilQJ1M3XL2xhyduxrDwGzvyuBog=;
        b=JEBMfHg8fHTKf2MgzsMgKUhP/QVdLn4wRaADPzkHyeLBl+flivVxd5Qrhs1ckn7m5o
         J5geTc+cGBnFfxjJf/rq/GgFcNDdieYFv2RObkAzVTkDkqqeV3gzsHhdbcmz7baAAaa+
         ObjB72zKB9x0SBlnULXmE31x4+RH99QaXXWPOLb4G1ztL+Nno5xX5abXh3jFqcmn7S4U
         /A2YJ1knqJTKjLLR/DyZq8i6gwtOmVZITvnu7CHu4WZvMGBJJKJmsbfRzcvnvMMEMzPl
         KNhRIdJbKYirnv+UMUnm6xWTPoxZ/Qv6JJR+ye5SDGl7/qLPP/rqQjaE25k+Sa+Wibta
         addg==
X-Gm-Message-State: AOAM533oJjIvIWlJqTqoswPC7VaK4N8k2Qs6/TykqBxgNeDSTlzaKEhm
        OP22CH/urnZVvG5vp0DSjVI+/NG5THA=
X-Google-Smtp-Source: ABdhPJyFDbjSC4ZY5DwOLxiU8mJs8aBzTzLjP52kphFnowUMMTWOPa+Q1P5S/KJDIsy0wS+mbIZsfw==
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr39912050wrq.411.1635345564358;
        Wed, 27 Oct 2021 07:39:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm3859741wms.41.2021.10.27.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:23 -0700 (PDT)
Message-Id: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:15 +0000
Subject: [PATCH v5 0/8] Sparse Index: integrate with reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series integrates the sparse index with git reset and provides
miscellaneous fixes and improvements to the command in sparse checkouts.
This includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the command
 2. repository settings to enable the sparse index with ensure_full_index
    guarding any code paths that break tests without other compatibility
    updates.
 3. modifications to remove or reduce the scope in which ensure_full_index
    must be called.

The sparse index updates are predicated on a fix originating from the
microsoft/git fork [1], correcting how git reset --mixed handles resetting
entries outside the sparse checkout definition. Additionally, a performance
"bug" in next_cache_entry with sparse index is corrected, preventing
repeatedly looping over already-searched entries.

The p2000 tests demonstrate a ~70% execution time reduction in git reset
using a sparse index, and no change (within expected variability [2]) using
a full index. Results summarized below [3, 4]:

Test                           base              [5/8]                 
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.97(0.50+0.37) -3.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.96(0.50+0.36) -4.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   1.37(0.91+0.35) -18.5%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   1.41(0.94+0.35) -17.1%

Test                           base              [6/8]   
-----------------------------------------------------------------------
git reset --hard (full-v3)     1.00(0.50+0.39)   0.94(0.48+0.34) -6.0% 
git reset --hard (full-v4)     1.00(0.51+0.38)   0.95(0.51+0.34) -5.0% 
git reset --hard (sparse-v3)   1.68(1.17+0.39)   0.46(0.05+0.29) -72.6%
git reset --hard (sparse-v4)   1.70(1.18+0.40)   0.46(0.06+0.29) -72.9%

Test                               base              [7/8]
---------------------------------------------------------------------------
git reset (full-v3)                0.77(0.27+0.37)   0.72(0.26+0.32) -6.5%
git reset (full-v4)                0.75(0.27+0.34)   0.73(0.26+0.32) -2.7%
git reset (sparse-v3)              1.44(0.96+0.36)   0.43(0.04+0.96) -70.1%
git reset (sparse-v4)              1.46(0.97+0.36)   0.43(0.05+0.79) -70.5%
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.69(0.26+0.30) -4.2%
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.71(0.27+0.32) -4.1% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.81(0.42+0.90) -44.1%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.79(0.42+0.76) -44.0%

Test                               base              [8/8]            
---------------------------------------------------------------------------
git reset -- missing (full-v3)     0.72(0.26+0.32)   0.73(0.26+0.33) +1.4% 
git reset -- missing (full-v4)     0.74(0.28+0.33)   0.74(0.27+0.32) +0.0% 
git reset -- missing (sparse-v3)   1.45(0.97+0.35)   0.43(0.05+0.80) -70.3%
git reset -- missing (sparse-v4)   1.41(0.94+0.34)   0.44(0.05+0.76) -68.8%



Changes since V1
================

 * Add --force-full-index option to update-index. The option is used
   circumvent changing command_requires_full_index from its default value -
   right now this is effectively a no-op, but will change once update-index
   is integrated with sparse index. By using this option in the t1092
   expand/collapse test, the command used to test will not need to be
   updated with subsequent sparse index integrations.
 * Update implementation of mixed reset for entries outside sparse checkout
   definition. The condition in which a file should be checked out before
   index reset is simplified to "if it has skip-worktree enabled and a reset
   would change the file, check it out".
   * After checking the behavior of update_index_from_diff with renames,
     found that the diff used by reset does not produce diff queue entries
     with different pathnames for one and two. Because of this, and that
     nothing in the implementation seems to rely on identical path names, no
     BUG check is added.
 * Correct a bug in the sparse index is not expanded tests in t1092 where
   failure of a git reset --mixed test was not being reported. Test now
   verifies an appropriate scenario with corrected failure-checking.


Changes since V2
================

 * Replace patch adding checkouts for git reset --mixed with sparse checkout
   with preserving the skip-worktree flag (including a new test for git
   reset --mixed and update to t1092 - checkout and reset (mixed))
 * Move rename of is_missing into its own patch
 * Further extend t1092 tests and remove unnecessary commands/tests where
   possible
 * Refine logic determining which pathspecs require ensure_full_index in git
   reset --mixed, add related ensure_not_expanded tests
 * Add index_search_mode enum to index_name_stage_pos
 * Clean up variable usage & remove unnecessary subtree_path in
   prime_cache_tree_rec
 * Update cover letter performance data
 * More thoroughly explain changes in each commit message


Changes since V3
================

 * Replace git update-index --force-full-index with git reset update-folder1
   -- folder1/a, remove introduction of new --force-full-index option
   entirely, and add comment clarifying the intent of sparse-index is
   expanded and converted back test
 * Fix authorship on reset: preserve skip-worktree bit in mixed reset
   (current patch fully replaces original patch, but metadata of the
   original wasn't properly replaced)


Changes since V4
================

 * Update t1092 test 'checkout and reset (mixed)' to explicitly verify
   differences between sparse and full checkouts

Thanks! -Victoria

[1] microsoft@6b8a074 [2]
https://lore.kernel.org/git/8b9fe3f8-f0e3-4567-b20b-17c92bd1a5c5@github.com/
[3] If a test and/or commit is not mentioned, there is no significant change
to performance [4] Pathspec "does-not-exist" is changed to "missing" to save
space in performance report

Victoria Dye (8):
  reset: rename is_missing to !is_in_reset_tree
  reset: preserve skip-worktree bit in mixed reset
  sparse-index: update command for expand/collapse test
  reset: expand test coverage for sparse checkouts
  reset: integrate with sparse index
  reset: make sparse-aware (except --mixed)
  reset: make --mixed sparse-aware
  unpack-trees: improve performance of next_cache_entry

 builtin/reset.c                          | 104 ++++++++++++++++-
 cache-tree.c                             |  46 +++++++-
 cache.h                                  |  10 ++
 read-cache.c                             |  27 +++--
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 140 ++++++++++++++++++++---
 t/t7102-reset.sh                         |  17 +++
 unpack-trees.c                           |  23 +++-
 8 files changed, 333 insertions(+), 37 deletions(-)


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1048%2Fvdye%2Fvdye%2Fsparse-index-part1-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1048/vdye/vdye/sparse-index-part1-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1048

Range-diff vs v4:

 1:  ad7013a31aa = 1:  ad7013a31aa reset: rename is_missing to !is_in_reset_tree
 2:  bd72bd175da ! 2:  b221b00b7e0 reset: preserve skip-worktree bit in mixed reset
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_failure 'blame with pathsp
      -	test_sparse_match git checkout -b reset-test update-deep &&
      -	test_sparse_match git reset deepest &&
      +	# Because skip-worktree is preserved, resetting to update-folder1
     -+	# will show worktree changes for full-checkout that are not present
     ++	# will show worktree changes for folder1/a in full-checkout, but not
      +	# in sparse-checkout or sparse-index.
     ++	git -C full-checkout reset update-folder1 >full-checkout-out &&
       	test_sparse_match git reset update-folder1 &&
      -	test_sparse_match git reset update-folder2
     ++	grep "M	folder1/a" full-checkout-out &&
     ++	! grep "M	folder1/a" sparse-checkout-out &&
      +	run_on_sparse test_path_is_missing folder1
       '
       
 3:  c4df0d6b136 = 3:  1bb2ca92c60 sparse-index: update command for expand/collapse test
 4:  cfbb23e9fe2 = 4:  cc76c694647 reset: expand test coverage for sparse checkouts
 5:  62fdbf2ad26 = 5:  217ae445418 reset: integrate with sparse index
 6:  b0d437207e7 = 6:  a3e2fd59867 reset: make sparse-aware (except --mixed)
 7:  00d14fb60bd = 7:  a9135a5ed64 reset: make --mixed sparse-aware
 8:  e523dadb8bf = 8:  f91d1dcf024 unpack-trees: improve performance of next_cache_entry

-- 
gitgitgadget
