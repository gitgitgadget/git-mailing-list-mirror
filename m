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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6501F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHEWnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:43:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48979 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHEWnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:43:43 -0400
Received: by mail-pl1-f202.google.com with SMTP id i33so47084972pld.15
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Ec1O6TZ7zFKkgQpO4OIInPesKuCvksKVW/O/kRMdGSA=;
        b=WCcN8TdTAVCeZ4SF7jJoctYIOD+WktvkvBbX2MP/QREMmxAknnT5FuWDrIvjgb6WwF
         +G5qBILrh9iIs2sbJoPYIwWdpIKN6kwj8n2L/FYYP6cYJWsX6lR5aasjluZcQDMTKCSI
         bfFmR8FPlmP3/B9Dfh7RnGIzNhYjh/HPAIDtnNWWcW5K+/MwEDaX/U5Z/XAsJBSEaFAY
         v1nFpcbMAEINe2REj0qeCXH0Xl7noic5+saSu3d/jbCoeWB5Lqw/4aqChnAWlBfyFXdO
         fcYXZ13xQ9TcgFuHYX2iu9RlkzDyjwaRIHT4htsedYZ5HNt6xoY9mAH6ndv2EMVfu/eK
         3vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Ec1O6TZ7zFKkgQpO4OIInPesKuCvksKVW/O/kRMdGSA=;
        b=agBRVY0rp/vRyQ6YwLeXXMo6vEjfEzD6mFkslgSSFmp9IPW83O5jHn0F4WCmPUfcWt
         6h/j2JT4h+lFpj1D9tPfmnpWPgXDszlUVUeV+/XOHa863rbFehNklFkN03gkka7t7OIT
         Fs9QH3mK6UDsWrEAD8JJBsTwjGwUVQvUmOp29ugAnk8pekZDIUe5kZQYkzLn9IUA9kMe
         l2evBsuYRUOtIZhs9y+rXCJBQcLX0V1UzBLlV9jNY8Uy6AhEW4FPC7rjZ5PwDZ1qMI2V
         dGce5sssZln96GVp3Wm8hs5sZDFWkec1oH8PueVaq7vxzTba1lDs/kULg3Yw2TZnKw7Z
         Pv1A==
X-Gm-Message-State: APjAAAX7y00jdY4t/Dl1j18+/2W/28sXGD+mz2XOvngTB4Qx8++Ncasz
        QTZKcmjhQ/OlFosfwJpUqnHZ9nN220WteME3egkqEqu5CBzKPXf/lhO0PoGYooo2QoMJLYx/0qM
        rAIH2UGHYZn170UM+BndtFiNxvvN+6JHTwtWxG8Qbmu9Tl8ZjJmd15E/SULi7yBM=
X-Google-Smtp-Source: APXvYqwpAVoavlCosQN+GnGmlW1Zl3T82wAcFyeMsw3u2O1hmJx0YZ+94B1ujUAVgR94Q5BiPZBVphpMAGHLKA==
X-Received: by 2002:a63:6106:: with SMTP id v6mr212762pgb.36.1565045021816;
 Mon, 05 Aug 2019 15:43:41 -0700 (PDT)
Date:   Mon,  5 Aug 2019 15:43:35 -0700
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
Message-Id: <cover.1565044345.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1564695892.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v4 0/4] pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Range-diff against v3:
1:  f0476b2b1e ! 1:  5085729095 t7503: verify proper hook execution
    @@ Commit message
         write_script() and doing setup inside a test_expect_success block.
    =20
    +    Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
    +    Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
    =20
      ## t/t7503-pre-commit-hook.sh ##
     @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
     +	echo $0 >>actual_hooks
     +	exit 1
     +	EOF
    ++	write_script "$HOOKDIR/non-exec.sample" <<-\EOF &&
    ++	echo $0 >>actual_hooks
    ++	exit 1
    ++	EOF
    ++	chmod -x "$HOOKDIR/non-exec.sample" &&
     +	write_script "$HOOKDIR/require-prefix.sample" <<-\EOF &&
     +	echo $0 >>actual_hooks
     +	test $GIT_PREFIX =3D "success/"
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
     =20
     -	echo "foo" > file &&
     +test_expect_success 'with no hook' '
    -+	test_when_finished "rm -f expected_hooks actual_hooks" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f actual_hooks" &&
     +	echo "foo" >file &&
      	git add file &&
     -	git commit -m "first"
     -
     +	git commit -m "first" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     =20
      test_expect_success '--no-verify with no hook' '
     -
     -	echo "bar" > file &&
    -+	test_when_finished "rm -f expected_hooks actual_hooks" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f actual_hooks" &&
     +	echo "bar" >file &&
      	git add file &&
     -	git commit --no-verify -m "bar"
     -
     +	git commit --no-verify -m "bar" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     =20
     -# now install hook that always succeeds
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
     -	echo "more" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
     +	ln -s "success.sample" "$PRECOMMIT" &&
    -+	touch actual_hooks &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "more" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
      test_expect_success '--no-verify with succeeding hook' '
     -
     -	echo "even more" >> file &&
    -+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
    ++	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
     +	ln -s "success.sample" "$PRECOMMIT" &&
    -+	touch expected_hooks actual_hooks &&
     +	echo "even more" >>file &&
      	git add file &&
     -	git commit --no-verify -m "even more"
     -
     +	git commit --no-verify -m "even more" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     =20
     -# now a hook that fails
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
     -	echo "another" >> file &&
     +	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
     +	ln -s "fail.sample" "$PRECOMMIT" &&
    -+	touch actual_hooks &&
     +	echo "$PRECOMMIT" >expected_hooks &&
     +	echo "another" >>file &&
      	git add file &&
    @@ t/t7503-pre-commit-hook.sh: test_description=3D'pre-commit hook'
      test_expect_success '--no-verify with failing hook' '
     -
     -	echo "stuff" >> file &&
    -+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
    ++	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
     +	ln -s "fail.sample" "$PRECOMMIT" &&
    -+	touch expected_hooks actual_hooks &&
     +	echo "stuff" >>file &&
      	git add file &&
     -	git commit --no-verify -m "stuff"
     -
     +	git commit --no-verify -m "stuff" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     =20
     -chmod -x "$HOOK"
      test_expect_success POSIXPERM 'with non-executable hook' '
     -
     -	echo "content" >> file &&
    -+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
; chmod +x \"$HOOKDIR/fail.sample\"" &&
    -+	ln -s "fail.sample" "$PRECOMMIT" &&
    -+	chmod -x "$HOOKDIR/fail.sample" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    ++	ln -s "non-exec.sample" "$PRECOMMIT" &&
     +	echo "content" >>file &&
      	git add file &&
     -	git commit -m "content"
     -
     +	git commit -m "content" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     =20
      test_expect_success POSIXPERM '--no-verify with non-executable hook' =
'
     -
     -	echo "more content" >> file &&
    -+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
; chmod +x \"$HOOKDIR/fail.sample\"" &&
    -+	ln -s "fail.sample" "$PRECOMMIT" &&
    -+	chmod -x "$HOOKDIR/fail.sample" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    ++	ln -s "non-exec.sample" "$PRECOMMIT" &&
     +	echo "more content" >>file &&
      	git add file &&
     -	git commit --no-verify -m "more content"
     -
     +	git commit --no-verify -m "more content" &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
      '
     -chmod +x "$HOOK"
     -
2:  89ddbf410f =3D 2:  3b701a5c41 merge: do no-verify like commit
3:  61b989ff16 ! 3:  9210421fbb git-merge: honor pre-merge-commit hook
    @@ Commit message
    =20
         [js: * renamed hook from "pre-merge" to "pre-merge-commit"
              * only discard the index if the hook is actually present
    +         * expanded githooks documentation entry
              * clarified that hook should write messages to stderr
              * squashed test changes from the original series' patch 4/4
              * modified tests to follow new pattern from this series' patc=
h 1/4
    +         * added a test case for non-executable merge hooks
    +         * added a test case for failed merges
    +         * when testing that the merge hook did not run, make sure we
    +           actually have a merge to perform (by resetting the "side" b=
ranch
    +           to its original state).
              * reworded commit message
         ]
    =20
    +    Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
         Signed-off-by: Michael J Gruber <git@grubix.eu>
    +    Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
    =20
      ## Documentation/githooks.txt ##
    @@ Documentation/githooks.txt: The default 'pre-commit' hook, when enab=
led--and wit
     +pre-merge-commit
     +~~~~~~~~~~~~~~~~
     +
    -+This hook is invoked by 'git merge' when doing an automatic merge
    -+commit; it is equivalent to 'pre-commit' for a non-automatic commit
    -+for a merge.
    ++This hook is invoked by linkgit:git-merge[1]. It takes no parameters,=
 and is
    ++invoked after the merge has been carried out successfully and before
    ++obtaining the proposed commit log message to
    ++make a commit.  Exiting with a non-zero status from this script
    ++causes the `git merge` command to abort before creating a commit.
    ++
    ++The default 'pre-merge-commit' hook, when enabled, runs the
    ++'pre-commit' hook, if the latter is enabled.
    ++
    ++This hook is invoked with the environment variable
    ++`GIT_EDITOR=3D:` if the command will not bring up an editor
    ++to modify the commit message.
    ++
    ++If the merge cannot be carried out automatically, the conflicts
    ++need to be resolved and the result committed separately (see
    ++linkgit:git-merge[1]). At that point, this hook will not be executed,
    ++but the 'pre-commit' hook will, if it is enabled.
     +
      prepare-commit-msg
      ~~~~~~~~~~~~~~~~~~
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succes=
s 'sample sc
      '
     =20
     +test_expect_success 'root commit' '
    -+	echo "root" > file &&
    ++	echo "root" >file &&
     +	git add file &&
     +	git commit -m "zeroth" &&
     +	git checkout -b side &&
    -+	echo "foo" > foo &&
    ++	echo "foo" >foo &&
     +	git add foo &&
     +	git commit -m "make it non-ff" &&
    ++	git branch side-orig side &&
     +	git checkout master
     +'
    ++
    ++test_expect_success 'setup conflicting branches' '
    ++	test_when_finished "git checkout master" &&
    ++	git checkout -b conflicting-a master &&
    ++	echo a >conflicting &&
    ++	git add conflicting &&
    ++	git commit -m conflicting-a &&
    ++	git checkout -b conflicting-b master &&
    ++	echo b >conflicting &&
    ++	git add conflicting &&
    ++	git commit -m conflicting-b
    ++'
     +
      test_expect_success 'with no hook' '
    - 	test_when_finished "rm -f expected_hooks actual_hooks" &&
    - 	touch expected_hooks actual_hooks &&
    + 	test_when_finished "rm -f actual_hooks" &&
    + 	echo "foo" >file &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss 'with no hook' '
    - 	test_cmp expected_hooks actual_hooks
    + 	test_path_is_missing actual_hooks
      '
     =20
     +test_expect_success 'with no hook (merge)' '
    -+	test_when_finished "rm -f expected_hooks actual_hooks" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f actual_hooks" &&
    ++	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge -m "merge master" master &&
     +	git checkout master &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
     +'
     +
      test_expect_success '--no-verify with no hook' '
    - 	test_when_finished "rm -f expected_hooks actual_hooks" &&
    - 	touch expected_hooks actual_hooks &&
    + 	test_when_finished "rm -f actual_hooks" &&
    + 	echo "bar" >file &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss 'with succeeding hook' '
      	test_cmp expected_hooks actual_hooks
      '
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succes=
s 'with succ
     +test_expect_success 'with succeeding hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks"=
 &&
     +	ln -s "success.sample" "$PREMERGE" &&
    -+	touch actual_hooks &&
     +	echo "$PREMERGE" >expected_hooks &&
     +	git checkout side &&
     +	git merge -m "merge master" master &&
     +	git checkout master &&
     +	test_cmp expected_hooks actual_hooks
     +'
    ++
    ++test_expect_success 'automatic merge fails; both hooks are available'=
 '
    ++	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
    ++	test_when_finished "rm -f expected_hooks actual_hooks" &&
    ++	test_when_finished "git checkout master" &&
    ++	ln -s "success.sample" "$PREMERGE" &&
    ++	ln -s "success.sample" "$PRECOMMIT" &&
    ++
    ++	git checkout conflicting-a &&
    ++	test_must_fail git merge -m "merge conflicting-b" conflicting-b &&
    ++	test_path_is_missing actual_hooks &&
    ++
    ++	echo "$PRECOMMIT" >expected_hooks &&
    ++	echo a+b >conflicting &&
    ++	git add conflicting &&
    ++	git commit -m "resolve conflict" &&
    ++	test_cmp expected_hooks actual_hooks
    ++'
     +
      test_expect_success '--no-verify with succeeding hook' '
    - 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
    + 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
      	ln -s "success.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss '--no-verify with failing hook' '
    - 	test_cmp expected_hooks actual_hooks
    + 	test_path_is_missing actual_hooks
      '
     =20
     +test_expect_success 'with failing hook (merge)' '
     +	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks"=
 &&
     +	ln -s "fail.sample" "$PREMERGE" &&
    -+	touch actual_hooks &&
     +	echo "$PREMERGE" >expected_hooks &&
     +	git checkout side &&
     +	test_must_fail git merge -m "merge master" master &&
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succes=
s '--no-veri
     +'
     +
      test_expect_success POSIXPERM 'with non-executable hook' '
    - 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
; chmod +x \"$HOOKDIR/fail.sample\"" &&
    - 	ln -s "fail.sample" "$PRECOMMIT" &&
    + 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    + 	ln -s "non-exec.sample" "$PRECOMMIT" &&
    +@@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss POSIXPERM '--no-verify with non-executable hook' '
    + 	test_path_is_missing actual_hooks
    + '
    +=20
    ++test_expect_success POSIXPERM 'with non-executable hook (merge)' '
    ++	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    ++	ln -s "non-exec.sample" "$PREMERGE" &&
    ++	git branch -f side side-orig &&
    ++	git checkout side &&
    ++	git merge -m "merge master" master &&
    ++	git checkout master &&
    ++	test_path_is_missing actual_hooks
    ++'
    ++
    + test_expect_success 'with hook requiring GIT_PREFIX' '
    + 	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hook=
s success" &&
    + 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
    =20
      ## templates/hooks--pre-merge-commit.sample (new) ##
     @@
4:  45828c56fc ! 4:  96c54883d3 merge: --no-verify to bypass pre-merge-comm=
it hook
    @@ Commit message
              * cleaned up trailing whitespace
              * squashed test changes from the original series' patch 4/4
              * modified tests to follow pattern from this series' patch 1/=
4
    +         * added a test case for --no-verify with non-executable hook
    +         * when testing that the merge hook did not run, make sure we
    +           actually have a merge to perform (by resetting the "side" b=
ranch
    +           to its original state).
    +
         ]
    =20
    +    Improved-by: Martin =C3=85gren <martin.agren@gmail.com>
         Signed-off-by: Michael J Gruber <git@grubix.eu>
    +    Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
    =20
      ## Documentation/githooks.txt ##
    -@@ Documentation/githooks.txt: pre-merge-commit
    -=20
    - This hook is invoked by 'git merge' when doing an automatic merge
    - commit; it is equivalent to 'pre-commit' for a non-automatic commit
    --for a merge.
    -+for a merge, and can be bypassed with the `--no-verify` option.
    +@@ Documentation/githooks.txt: the use of non-ASCII filenames.
    + pre-merge-commit
    + ~~~~~~~~~~~~~~~~
     =20
    - prepare-commit-msg
    - ~~~~~~~~~~~~~~~~~~
    +-This hook is invoked by linkgit:git-merge[1]. It takes no parameters,=
 and is
    ++This hook is invoked by linkgit:git-merge[1], and can be bypassed
    ++with the `--no-verify` option.  It takes no parameters, and is
    + invoked after the merge has been carried out successfully and before
    + obtaining the proposed commit log message to
    + make a commit.  Exiting with a non-zero status from this script
    =20
      ## builtin/merge.c ##
     @@ builtin/merge.c: static struct option builtin_merge_options[] =3D {
    @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *r=
emoteheads)
    =20
      ## t/t7503-pre-commit-and-pre-merge-commit-hooks.sh ##
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss '--no-verify with no hook' '
    - 	test_cmp expected_hooks actual_hooks
    + 	test_path_is_missing actual_hooks
      '
     =20
     +test_expect_success '--no-verify with no hook (merge)' '
    -+	test_when_finished "rm -f expected_hooks actual_hooks" &&
    -+	touch expected_hooks actual_hooks &&
    ++	test_when_finished "rm -f actual_hooks" &&
    ++	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
     +	git checkout master &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
     +'
     +
      test_expect_success 'with succeeding hook' '
      	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
" &&
      	ln -s "success.sample" "$PRECOMMIT" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss '--no-verify with succeeding hook' '
    - 	test_cmp expected_hooks actual_hooks
    + 	test_path_is_missing actual_hooks
      '
     =20
     +test_expect_success '--no-verify with succeeding hook (merge)' '
    -+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks"=
 &&
    ++	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
     +	ln -s "success.sample" "$PREMERGE" &&
    -+	touch expected_hooks actual_hooks &&
    ++	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
     +	git checkout master &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
     +'
     +
      test_expect_success 'with failing hook' '
    @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succes=
s 'with fail
      '
     =20
     +test_expect_success '--no-verify with failing hook (merge)' '
    -+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks"=
 &&
    ++	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
     +	ln -s "fail.sample" "$PREMERGE" &&
    -+	touch expected_hooks actual_hooks &&
    ++	git branch -f side side-orig &&
     +	git checkout side &&
     +	git merge --no-verify -m "merge master" master &&
     +	git checkout master &&
    -+	test_cmp expected_hooks actual_hooks
    ++	test_path_is_missing actual_hooks
     +'
     +
      test_expect_success POSIXPERM 'with non-executable hook' '
    - 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks=
; chmod +x \"$HOOKDIR/fail.sample\"" &&
    - 	ln -s "fail.sample" "$PRECOMMIT" &&
    + 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
    + 	ln -s "non-exec.sample" "$PRECOMMIT" &&
    +@@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_succe=
ss POSIXPERM 'with non-executable hook (merge)' '
    + 	test_path_is_missing actual_hooks
    + '
    +=20
    ++test_expect_success POSIXPERM '--no-verify with non-executable hook (=
merge)' '
    ++	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
    ++	ln -s "non-exec.sample" "$PREMERGE" &&
    ++	git branch -f side side-orig &&
    ++	git checkout side &&
    ++	git merge --no-verify -m "merge master" master &&
    ++	git checkout master &&
    ++	test_path_is_missing actual_hooks
    ++'
    ++
    + test_expect_success 'with hook requiring GIT_PREFIX' '
    + 	test_when_finished "rm -rf \"$PRECOMMIT\" expected_hooks actual_hook=
s success" &&
    + 	ln -s "require-prefix.sample" "$PRECOMMIT" &&
--=20
2.22.0.770.g0f2c4a37fd-goog

