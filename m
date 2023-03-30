Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B26C74A5B
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 05:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjC3F7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjC3F7X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 01:59:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CF4C1A
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 22:59:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so10991908wmq.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680155958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWV7fW27l9pw4sYrDM77CXcsf9OlbVg6PkI3JZZ2p8c=;
        b=EoHvLP2pZrgKwgMjP9Tn53O+leK9dC0KbyjlQrjt+KB9WefjZGyoMV4TLcaQ6eNlwQ
         UNbbBX2VMBRqjcXcbjCiyILF8nA/6doTu+TDQtAYnL3pawbyNwGxP8bLx9qxD4I0ExjD
         3rCg9gROsqfUVRBUCfV/yDog+vU1xzu8RmVUcz02dC0ZJhHrPCt8CgI2mVPCbNV8MZgL
         SmRb0/trumSSlrxgSfKxmEsgfI3N+sU9Mmap99kHmfXd372GRvmfgaMJCXXSX0YHny5s
         f+JSVTzcuQE7SJS/eyz6B8BOc/y+LFgFX8mMbYhIm02Lu7a/hEz0uGi/2fzdVEu++Lm3
         Yu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680155958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWV7fW27l9pw4sYrDM77CXcsf9OlbVg6PkI3JZZ2p8c=;
        b=uibHCvmbvy+17+AlXqejjbhdYs1XASx6yX6RuTerj4q0R4mMZqEVSeEeYQimRG2M/Y
         OwD+ua8Zigh8lNkSX23hA88BiMUfYvpiX0YlpfwqdcYO7a7/wBxRnD9AxtPkdnB90amg
         Zb8nDgPO3WufkhaiNsK6iDm1ri03e++j3n+npbovvnFkQa29P3gjEpDKyhi69bv/3Lrb
         XmonZBTdPndvxs+tQgPjWomglHK6HOZ9r0Ga9wxNGd7mo8ssv8zOwPn5fZeRdzt/uumi
         9YqFoB8VqQa/+JZJJD580GpTGwKgJYsef9+gjrQdHDx6/TCUh8GYOnCa0LIPjq7gJ8nM
         93ww==
X-Gm-Message-State: AO0yUKUYOsE0iRMh2kzjzZlBWN/QO5soLW98U8CYZpguUVo9ERIoAl/w
        R1HSIkYXgkshTut95I0e+Ib815dk4/0=
X-Google-Smtp-Source: AK7set8vWrn9cSvD7ddLmg1jMwB9gBtKCDjdJuwbrKUgVzZL7QjGKrSjipvHz0lHUPOQ8mnDPpyHbg==
X-Received: by 2002:a7b:c398:0:b0:3ee:2bed:222d with SMTP id s24-20020a7bc398000000b003ee2bed222dmr17030366wmj.3.1680155958133;
        Wed, 29 Mar 2023 22:59:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003e91b9a92c9sm4489369wma.24.2023.03.29.22.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 22:59:17 -0700 (PDT)
Message-Id: <pull.1480.v3.git.git.1680155957146.gitgitgadget@gmail.com>
In-Reply-To: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
References: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
From:   "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Mar 2023 05:59:16 +0000
Subject: [PATCH v3] describe: enable sparse index for describe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Raghul Nanth A <nanth.raghul@gmail.com>

Add usage and performance tests for describe

Describe uses the index when it is run with --dirty flag, which uses the
run_diff_index commmand. The command is sparse-index aware and hence we
can just set the requires-full-index to false

Performance metrics

  Test                                                     HEAD~1            HEAD
  -------------------------------------------------------------------------------------------------
  2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
  2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
  2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
  2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
  2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
  2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
  2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
  2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%

Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
---
    describe: enable sparse index for describe
    
     * Removed describe tests not concerned with sparse index
    
     * Added performance metric to commit message
    
     * Moved tests to t1092.sh
    
     * Explained reason for changes in commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1480%2FNanthR%2Fdescribe-sparse-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1480/NanthR/describe-sparse-v3
Pull-Request: https://github.com/git/git/pull/1480

Range-diff vs v2:

 1:  03176f64607 ! 1:  01838ca3ab0 describe: enable sparse index for describe
     @@ Commit message
      
          Add usage and performance tests for describe
      
     +    Describe uses the index when it is run with --dirty flag, which uses the
     +    run_diff_index commmand. The command is sparse-index aware and hence we
     +    can just set the requires-full-index to false
     +
          Performance metrics
      
            Test                                                     HEAD~1            HEAD
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +test_expect_success 'sparse-index is not expanded: describe' '
      +	init_repos &&
      +	# Add tag to be read by describe
     -+	ensure_not_expanded tag -a v1.0 -m "Version 1" &&
     ++	git -C sparse-index tag -a v1.0 -m "Version 1" &&
      +	ensure_not_expanded describe --dirty &&
     ++	cp sparse-index-out sparse-index-dirty &&
      +	ensure_not_expanded describe &&
     -+	echo "test" >>sparse-index/extra.txt &&
     ++	cp sparse-index-out sparse-index-normal &&
     ++	# Check describe has same output on clean tree
     ++	test_cmp sparse-index-dirty sparse-index-normal &&
     ++	echo "test" >>sparse-index/g &&
      +	ensure_not_expanded describe --dirty &&
     ++	echo "v1.0-dirty" > actual &&
     ++	# Check describe on dirty work tree
     ++	test_cmp sparse-index-out actual &&
      +	ensure_not_expanded describe
      +'
      +
       test_expect_success 'sparse index is not expanded: diff' '
       	init_repos &&
       
     -
     - ## t/t6121-describe-sparse.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='git describe in sparse checked out trees'
     -+
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
     -+. ./test-lib.sh
     -+
     -+check_describe () {
     -+	indir= &&
     -+	while test $# != 0
     -+	do
     -+		case "$1" in
     -+		-C)
     -+			indir="$2"
     -+			shift
     -+			;;
     -+		*)
     -+			break
     -+			;;
     -+		esac
     -+		shift
     -+	done &&
     -+	indir=${indir:+"$indir"/} &&
     -+	expect="$1"
     -+	shift
     -+	describe_opts="$@"
     -+	test_expect_success "describe $describe_opts" '
     -+		git ${indir:+ -C "$indir"} describe $describe_opts >actual &&
     -+		echo "$expect" >expect &&
     -+		test_cmp expect actual
     -+	'
     -+}
     -+
     -+test_expect_success setup '
     -+	test_commit initial file one &&
     -+	test_commit --annotate A file A &&
     -+
     -+	test_tick &&
     -+
     -+	git sparse-checkout init --cone
     -+'
     -+
     -+check_describe A HEAD
     -+
     -+test_expect_success 'describe --dirty with --work-tree' '
     -+	(
     -+		cd "$TEST_DIRECTORY" &&
     -+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
     -+	) &&
     -+	grep "A" out
     -+'
     -+
     -+test_expect_success 'set-up dirty work tree' '
     -+	echo >>file
     -+'
     -+
     -+test_expect_success 'describe --dirty with --work-tree (dirty)' '
     -+	git describe --dirty >expected &&
     -+	(
     -+		cd "$TEST_DIRECTORY" &&
     -+		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
     -+	) &&
     -+	test_cmp expected out
     -+'
     -+test_done


 builtin/describe.c                       |  2 ++
 t/perf/p2000-sparse-operations.sh        |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index 5b5930f5c8c..7ff9b5e4b20 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			int fd, result;
 
 			setup_work_tree();
+			prepare_repo_settings(the_repository);
+			the_repository->settings.command_requires_full_index = 0;
 			repo_read_index(the_repository);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 3242cfe91a0..db7887470f9 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
 	done &&
 
 	git sparse-checkout init --cone &&
+	git tag -a v1.0 -m "Final" &&
 	git sparse-checkout set $SPARSE_CONE &&
 	git checkout -b wide $OLD_COMMIT &&
 
@@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
+test_perf_on_all git describe --dirty
+test_perf_on_all 'echo >>new && git describe --dirty'
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e1..8bc35c51426 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1514,6 +1514,24 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash pop
 '
 
+test_expect_success 'sparse-index is not expanded: describe' '
+	init_repos &&
+	# Add tag to be read by describe
+	git -C sparse-index tag -a v1.0 -m "Version 1" &&
+	ensure_not_expanded describe --dirty &&
+	cp sparse-index-out sparse-index-dirty &&
+	ensure_not_expanded describe &&
+	cp sparse-index-out sparse-index-normal &&
+	# Check describe has same output on clean tree
+	test_cmp sparse-index-dirty sparse-index-normal &&
+	echo "test" >>sparse-index/g &&
+	ensure_not_expanded describe --dirty &&
+	echo "v1.0-dirty" > actual &&
+	# Check describe on dirty work tree
+	test_cmp sparse-index-out actual &&
+	ensure_not_expanded describe
+'
+
 test_expect_success 'sparse index is not expanded: diff' '
 	init_repos &&
 

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
