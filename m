Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B9C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D45160D07
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhKAVa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKAVa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 17:30:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB67C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 14:27:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d3so30152740wrh.8
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 14:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kvGRaT3gfty74EVXDVOteMqHiU15/qr4LwlFX6+mwJ0=;
        b=J2ZqlNooQ4ArDqoBGeOuhsi86L9im+kz5KFdXMLYKVq1OCeHcUCAH13TuqyKqLyBD5
         qe0/mSw5sGd0yOUi6zeGPbEwAn9pEfxqmZAipEilefVLnqufSmvyyrimnbhU5CV7sJsS
         Giejkg1tK+bTkFrgxNiGp9z+7FLcwQ0FLwKDJcVAzyqMEmbg/IfLeY9V8Do6VWd0pllN
         QGjwSCQhBL3TNETQDEwUVQSuljkFud5IAJktH4OTHyXQ/rvFVpKGklP+yGGV4PjCJXuS
         oiRO0hHYNBcxqBa4IMM6tsH9jZDJcFpFEsLxOxWSDwfu8dYPfGpSrKRISQMRPp9VOXNX
         IAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kvGRaT3gfty74EVXDVOteMqHiU15/qr4LwlFX6+mwJ0=;
        b=BrAOx+N5xwlINBsdj9AXN4/bJrCdBYHRCKHuhrPcvhUi3VeK/9AUTR/JF7+9U6mKqI
         H9YyvRhW/ZlB11/+BpirLcJMh3wSN4MbhFZpp2hEJ4UQkN1CgKEDHLKVcGzRP8p/3PHI
         ce3GQx4bRBhrY6TFHusZaEH6J65x4REN4mnadQEUmOyiwVUYTRW7RlnDKsVB18a/nFDA
         kBfv8PMW1Sb9KZ27w8z6Z+9MJpAR9lO9EUNDMxnw8BxVxDFAugOX4sQVVyaqeATBE8yv
         xq6kF8Yja+TtZKrVhGY1MQcWvkXwTSVrR5+LaibKqwA37TqURhYn5SQDn3wKN1jC3vc3
         +Lew==
X-Gm-Message-State: AOAM531u7Jxc4A8b9ZDa+oMkIQZL8Yw5bH2DS7I97Eyj5N4EPcUvMyTz
        F3FdnoB9+SVntqlhtb/ku8yC94hp3dw=
X-Google-Smtp-Source: ABdhPJyE3fW4DtEB0u+u05Q1msLvVYt8TgmNOTkDN/rm0mpWMnYLUhq+mOef0jDl2MZDGHHqJgT1Kw==
X-Received: by 2002:a1c:2507:: with SMTP id l7mr1666998wml.186.1635802071076;
        Mon, 01 Nov 2021 14:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm13540797wrs.48.2021.11.01.14.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:27:50 -0700 (PDT)
Message-Id: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
References: <pull.1050.v2.git.1634332835.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Nov 2021 21:27:47 +0000
Subject: [PATCH v3 0/2] Sparse Index: diff and blame builtins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on vd/sparse-reset. It integrates the sparse index with
git diff and git blame and includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the commands
 2. repository settings to enable the sparse index

The p2000 tests demonstrate a ~30% execution time reduction for 'git diff'
and a ~75% execution time reduction for 'git diff --staged' using a sparse
index. For 'git blame', the reduction time was ~60% for a file two levels
deep and ~30% for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.30: git diff (full-v3)                  0.37    0.36 -2.7%
2000.31: git diff (full-v4)                  0.36    0.35 -2.8%
2000.32: git diff (sparse-v3)                0.46    0.30 -34.8%
2000.33: git diff (sparse-v4)                0.43    0.31 -27.9%
2000.34: git diff --staged (full-v3)         0.08    0.08 +0.0%
2000.35: git diff --staged (full-v4)         0.08    0.08 +0.0%
2000.36: git diff --staged (sparse-v3)       0.17    0.04 -76.5%
2000.37: git diff --staged (sparse-v4)       0.16    0.04 -75.0%
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%



Changes since V1
================

 * Fix failing diff partially-staged test in
   t1092-sparse-checkout-compatibility.sh, which was breaking in seen.


Changes since V2
================

 * Update diff commit description to include patches that make the checkout
   and status commands work with the sparse index for readers to reference.
 * Add new test case to verify diff behaves as expected when run against
   files outside the sparse checkout cone.
 * Indent error message in blame commit
 * Check error message in blame with pathspec outside sparse definition test
   matches expectations.
 * Loop blame tests (instead of running the same command multiple time
   against different files).

Thanks, Lessley

Lessley Dennington (2):
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |  3 +
 builtin/diff.c                           |  3 +
 t/perf/p2000-sparse-operations.sh        |  4 +
 t/t1092-sparse-checkout-compatibility.sh | 94 +++++++++++++++++++++---
 4 files changed, 93 insertions(+), 11 deletions(-)


base-commit: 7159bf518eed5c997cf4ff0f17d9cb69192a091c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1050

Range-diff vs v2:

 1:  ac33159d020 ! 1:  991aaad37b4 diff: enable and test the sparse index
     @@ Commit message
          Enable the sparse index within the 'git diff' command. Its implementation
          already safely integrates with the sparse index because it shares code with
          the 'git status' and 'git checkout' commands that were already integrated.
     +    For more details see:
     +
     +    d76723ee53 (status: use sparse-index throughout, 2021-07-14)
     +    1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)
     +
          The most interesting thing to do is to add tests that verify that 'git diff'
          behaves correctly when the sparse index is enabled. These cases are:
      
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout -f -
       test_done
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
     - 	test_all_match git diff --staged
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
     + 	)
       '
       
     -+test_expect_success 'diff partially-staged' '
     ++test_expect_success 'sparse index is not expanded: diff' '
      +	init_repos &&
      +
      +	write_script edit-contents <<-\EOF &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
      +
      +	test_all_match git diff &&
      +	test_all_match git diff --staged &&
     ++	ensure_not_expanded diff &&
     ++	ensure_not_expanded diff --staged &&
      +
      +	# Add file outside cone
      +	test_all_match git reset --hard &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
      +
      +	test_all_match git diff &&
      +	test_all_match git diff --staged &&
     ++	ensure_not_expanded diff &&
     ++	ensure_not_expanded diff --staged &&
      +
      +	# Merge conflict outside cone
      +	# The sparse checkout will report a warning that is not in the
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
      +	test_all_match test_must_fail git merge merge-right &&
      +
      +	test_all_match git diff &&
     -+	test_all_match git diff --staged
     -+'
     -+
     - # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
     - # running this test with 'df-conflict-2' after 'df-conflict-1'.
     - test_expect_success 'diff with renames and conflicts' '
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
     - 	# Wildcard identifies only full sparse directories, no index expansion
     - 	ensure_not_expanded reset deepest -- folder\* &&
     - 
     -+	echo a test change >>sparse-index/README.md &&
     ++	test_all_match git diff --staged &&
      +	ensure_not_expanded diff &&
     -+	git -C sparse-index add README.md &&
     -+	ensure_not_expanded diff --staged &&
     ++	ensure_not_expanded diff --staged
     ++'
      +
     - 	ensure_not_expanded checkout -f update-deep &&
     - 	test_config -C sparse-index pull.twohead ort &&
     - 	(
     + # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
     + # in this scenario, but it shouldn't.
     + test_expect_success 'reset mixed and checkout orphan' '
 2:  a0b6a152c75 ! 2:  cfdd33129ec blame: enable and test the sparse index
     @@ Commit message
          currently does not support blaming files outside of the sparse definition.
          Attempting to do so fails with the following error:
      
     -    fatal: no such path '<path outside sparse definition>' in HEAD
     +      fatal: no such path '<path outside sparse definition>' in HEAD
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git reset --hard
       test_done
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'blame with pathspec inside sparse definition' '
     - 	test_all_match git blame deep/deeper1/deepest/a
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'log with pathspec outside sparse definition' '
     + test_expect_success 'blame with pathspec inside sparse definition' '
     + 	init_repos &&
     + 
     +-	test_all_match git blame a &&
     +-	test_all_match git blame deep/a &&
     +-	test_all_match git blame deep/deeper1/a &&
     +-	test_all_match git blame deep/deeper1/deepest/a
     ++	for file in a \
     ++			deep/a \
     ++			deep/deeper1/a \
     ++			deep/deeper1/deepest/a
     ++	do
     ++		test_all_match git blame $file
     ++	done
       '
       
      -# TODO: blame currently does not support blaming files outside of the
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'blame with pathsp
      +# definition, so we verify this scenario.
      +test_expect_success 'blame with pathspec outside sparse definition' '
       	init_repos &&
     ++	test_sparse_match git sparse-checkout set &&
       
      -	test_all_match git blame folder1/a &&
      -	test_all_match git blame folder2/a &&
      -	test_all_match git blame deep/deeper2/a &&
      -	test_all_match git blame deep/deeper2/deepest/a
     -+	test_sparse_match git sparse-checkout set &&
     -+	test_sparse_match test_must_fail git blame folder1/a &&
     -+	test_sparse_match test_must_fail git blame folder2/a &&
     -+	test_sparse_match test_must_fail git blame deep/deeper2/a &&
     -+	test_sparse_match test_must_fail git blame deep/deeper2/deepest/a
     ++	for file in a \
     ++			deep/a \
     ++			deep/deeper1/a \
     ++			deep/deeper1/deepest/a
     ++	do
     ++		test_sparse_match test_must_fail git blame $file &&
     ++		cat >expect <<-EOF &&
     ++		fatal: Cannot lstat '"'"'$file'"'"': No such file or directory
     ++		EOF
     ++		# We compare sparse-checkout-err and sparse-index-err in
     ++		# `test_sparse_match`. Given we know they are the same, we
     ++		# only check the content of sparse-index-err here.
     ++		test_cmp expect sparse-index-err
     ++	done
       '
       
       test_expect_success 'checkout and reset (mixed)' '
     -@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
     - 	)
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: diff' '
     + 	ensure_not_expanded diff --staged
       '
       
      +test_expect_success 'sparse index is not expanded: blame' '
      +	init_repos &&
      +
     -+	ensure_not_expanded blame a &&
     -+	ensure_not_expanded blame deep/a &&
     -+	ensure_not_expanded blame deep/deeper1/a &&
     -+	ensure_not_expanded blame deep/deeper1/deepest/a
     ++	for file in a \
     ++			deep/a \
     ++			deep/deeper1/a \
     ++			deep/deeper1/deepest/a
     ++	do
     ++		ensure_not_expanded blame $file
     ++	done
      +'
      +
       # NEEDSWORK: a sparse-checkout behaves differently from a full checkout

-- 
gitgitgadget
