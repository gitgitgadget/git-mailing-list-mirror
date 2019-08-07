Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 256C21F731
	for <e@80x24.org>; Wed,  7 Aug 2019 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfHGS5V (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 14:57:21 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:36082 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbfHGS5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 14:57:21 -0400
Received: by mail-vs1-f73.google.com with SMTP id j77so23344947vsd.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nbh33m5/zoc0EeoC7UxTt0kqtOw2joO47F/tA83bERI=;
        b=D6LbC+bv7HS7HwjtBlt6F/+ZDReVdxLLcUuHt90OcOts0nlY0CvYx2715FD8jyXqm+
         S3Wunfu+Vhzom36bHG+KT9D9kK4mRUw0ZoSeVDcS8e9N8BtWm57mLG9LL0kJzYkj1UfL
         HYEDxEkaKQxgGL2glTaSn828gWfvWHyHFv1fNR7ge2UB/5mq0QkeLSQrPbfrOCNs/gXj
         Q31fNmitbgLgz+7H5kY0rdfkM1TVzYHgFU3EFWELpPELYVM3LVE9VXoH9Lc8ig7U8isu
         4cMaar11mM99+f4Mrt4Ox6IeYMlPsEhZklBtKNy1CeQGt4zKZobApcGk0KilOk9CHCEM
         9Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nbh33m5/zoc0EeoC7UxTt0kqtOw2joO47F/tA83bERI=;
        b=fBfukC5pNCBHyvmizXebE3+vDGsvI/35ZGG12CcyBq/v+m5H8A5NsbmmMb2Of0HhgO
         vS35eFlfaIxQhZKd9fmcyDMrT3uKFfS+pzEF/1o2o2VTVao66slZq8doAEibnJOZTXu6
         U6pTd9OWNng90NQHfuxPS/lpAsxqJLLtKyuzJbxpFbdCMTpuY9kFEYdPSuSqfBq8dui+
         C+SNTeJoRPNnC5FSPt7yx8PtdYd9LJp0fS8fIwImQ2fj95MTFF4UgnS40zR/SMjh/o8x
         IlHvSO6315p+oqtgLXKzUXAha3qvvlM3cVwOKR13PVKPwrZb6HXKgy4x6vpuPkrP93t7
         dVbA==
X-Gm-Message-State: APjAAAUs/O7CPAMDN4w+5iB5dYGHF+FjmyYq8oyHOcOiCvfOkxZdjC3O
        2m1b6aLmhRKGSq4IiPwRepbDanRB9g/c3dvcGBDrp9X/y+xaSMf3pg/jMxP43bbOQYcD1QY6zWI
        wLM1bIAvYJM3MxnIr2I/3eNGXU83CNdV2pU9VLzloHUSUvVlFD7f+u7gPqx7J7tk=
X-Google-Smtp-Source: APXvYqxIwb4nNtqr+J5LVKznD7BjUYhuSUkmuC88XCpOOFjiPwNRWjxjhk/jMhfA9n85pzA5ddzeR08TjonB6A==
X-Received: by 2002:a1f:b6c5:: with SMTP id g188mr4064220vkf.2.1565204239825;
 Wed, 07 Aug 2019 11:57:19 -0700 (PDT)
Date:   Wed,  7 Aug 2019 11:57:04 -0700
In-Reply-To: <cover.1565044345.git.steadmon@google.com>
Message-Id: <cover.1565203880.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1565044345.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v5 0/4] pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new pre-merge-commit hook, similar in usage to
pre-commit. It also improves hook testing in t7503, by verifying that
the correct hooks are run or bypassed as expected.

The original series was done by Michael J Gruber <git@grubix.eu>. I have
addressed the outstanding review comments, and noted my changes in the
commit messages in "[js: ...]" blocks.

Changes since V4:
* Used "cp" instead of "ln -s" in test hook setup to make tests more
  portable.

Changes since V3:
* Applied several test style fixes suggested by Martin (thanks!).
* Clarified the documentation for pre-merge-commit hook.
* Fixed a few cases where testing that the merge hook did not run might
  erroneously succeed if we don't have any merge to actually perform.
* Simplified test cleanup by adding a new non-executable sample hook
  script.
* Added test cases for non-executable pre-merge-commit hooks.

Changes since V2:
* Renamed the hook from "pre-merge" to "pre-merge-commit".
* Added a new patch (1/4) to improve t7503 by verifying that the
  expected hooks are (or are not) run.
* Squashed test changes (from V2's patch 4/4) into patch 3/4.
  Modified the tests to follow the example set in patch 1/4.
* Reworded commit messages to match with the current state of certain
  flags, which changed in between V1 and V2 of this series.

Josh Steadmon (1):
  t7503: verify proper hook execution

Michael J Gruber (3):
  merge: do no-verify like commit
  git-merge: honor pre-merge-commit hook
  merge: --no-verify to bypass pre-merge-commit hook

 Documentation/git-merge.txt                   |   2 +-
 Documentation/githooks.txt                    |  22 ++
 Documentation/merge-options.txt               |   4 +
 builtin/merge.c                               |  18 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 281 ++++++++++++++++++
 t/t7503-pre-commit-hook.sh                    | 139 ---------
 templates/hooks--pre-merge-commit.sample      |  13 +
 7 files changed, 336 insertions(+), 143 deletions(-)
 create mode 100755 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
 delete mode 100755 t/t7503-pre-commit-hook.sh
 create mode 100755 templates/hooks--pre-merge-commit.sample

Range-diff against v4:
1:  5085729095 ! 1:  60bbbbf9e0 t7503: verify proper hook execution
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "more" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
    -+	ln -s "success.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "more" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "even more" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    -+	ln -s "success.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
     +	echo "even more" >>file &&
      	git add file &&
     -	git commit --no-verify -m "even more"
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "another" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
    -+	ln -s "fail.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "another" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "stuff" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    -+	ln -s "fail.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
     +	echo "stuff" >>file &&
      	git add file &&
     -	git commit --no-verify -m "stuff"
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "content" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    -+	ln -s "non-exec.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
     +	echo "content" >>file &&
      	git add file &&
     -	git commit -m "content"
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "more content" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    -+	ln -s "non-exec.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
     +	echo "more content" >>file &&
      	git add file &&
     -	git commit --no-verify -m "more content"
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "more content" >> file &&
     +	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks success" &&
    -+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "more content" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -
     -	echo "more content" >> file &&
     +	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks fail" &&
    -+	ln -s "require-prefix.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "more content" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description='pre-commit hook'
     -	test "$GIT_AUTHOR_NAME" = "New Author" &&
     -	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
     +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
    -+	ln -s "check-author.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/check-author.sample" "$PRECOMMIT" &&
     +	cat >expected_hooks <<-EOF &&
     +	$PRECOMMIT
     +	$PRECOMMIT
2:  3b701a5c41 = 2:  02a97eb369 merge: do no-verify like commit
3:  9210421fbb ! 3:  2d41e0ff79 git-merge: honor pre-merge-commit hook
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with succ
      
     +test_expect_success 'with succeeding hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
    -+	ln -s "success.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
     +	echo "$PREMERGE" >expected_hooks &&
     +	git checkout side &&
     +	git merge -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with succ
     +	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
     +	test_when_finished "rm -f expected_hooks actual_hooks" &&
     +	test_when_finished "git checkout master" &&
    -+	ln -s "success.sample" "$PREMERGE" &&
    -+	ln -s "success.sample" "$PRECOMMIT" &&
    ++	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
     +
     +	git checkout conflicting-a &&
     +	test_must_fail git merge -m "merge conflicting-b" conflicting-b &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with succ
     +
      test_expect_success '--no-verify with succeeding hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    - 	ln -s "success.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success '--no-verify with failing hook' '
      	test_path_is_missing actual_hooks
      '
      
     +test_expect_success 'with failing hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
    -+	ln -s "fail.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
     +	echo "$PREMERGE" >expected_hooks &&
     +	git checkout side &&
     +	test_must_fail git merge -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success '--no-veri
     +
      test_expect_success POSIXPERM 'with non-executable hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    - 	ln -s "non-exec.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success POSIXPERM '--no-verify with non-executable hook' '
      	test_path_is_missing actual_hooks
      '
      
     +test_expect_success POSIXPERM 'with non-executable hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    -+	ln -s "non-exec.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
     +	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success POSIXPERM
     +
      test_expect_success 'with hook requiring GIT_PREFIX' '
      	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks success" &&
    - 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
     
      ## templates/hooks--pre-merge-commit.sample (new) ##
     @@
4:  96c54883d3 ! 4:  7b81e2717f merge: --no-verify to bypass pre-merge-commit hook
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success '--no-veri
     +
      test_expect_success 'with succeeding hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
    - 	ln -s "success.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success '--no-verify with succeeding hook' '
      	test_path_is_missing actual_hooks
      '
      
     +test_expect_success '--no-verify with succeeding hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    -+	ln -s "success.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
     +	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success '--no-veri
     +
      test_expect_success 'with failing hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
    - 	ln -s "fail.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/fail.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with failing hook (merge)' '
      	test_cmp expected_hooks actual_hooks
      '
      
     +test_expect_success '--no-verify with failing hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    -+	ln -s "fail.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
     +	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'with fail
     +
      test_expect_success POSIXPERM 'with non-executable hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    - 	ln -s "non-exec.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/non-exec.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success POSIXPERM 'with non-executable hook (merge)' '
      	test_path_is_missing actual_hooks
      '
      
     +test_expect_success POSIXPERM '--no-verify with non-executable hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    -+	ln -s "non-exec.sample" "$PREMERGE" &&
    ++	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
     +	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success POSIXPERM
     +
      test_expect_success 'with hook requiring GIT_PREFIX' '
      	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hooks success" &&
    - 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
    + 	cp "$HOOKDIR/require-prefix.sample" "$PRECOMMIT" &&
-- 
2.22.0.770.g0f2c4a37fd-goog

