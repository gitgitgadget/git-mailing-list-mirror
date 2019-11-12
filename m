Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD401F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKLXHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:07:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45816 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfKLXHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:07:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so12834014pga.12
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/j6fVGRHQHmfm177qgPJHW+su9jg4GBKcwL2UfxKE4=;
        b=juHwO7NbqLT9tFmHEQ8vZl3R6DlKFa+k8PGOEan1Yj/0+0SCRnRWQjFoF2zH49flkA
         DvceITS0ybAqLRp0wkmo+IbZNSiZzQjkS6MhMNeLDguEJxznw4v3GVSr8omYncTWKY4F
         4f0A/A/hUiCiM3SKcxnAksmo093CNsF0zD3gcIAi9r0wSXl7SLyK3S3/ON7seryf5U2y
         zARdGpmegdz1r5p8xTQFVnigiz/7BY8lKz5Al2xEGrgnkPVCBraj9uq/RGoZYoILxc8w
         4L+Z3j1o3J4gJaUiTZR1mrZipcMi55Jx5cBtJyJ+BYvWk/K0YE2CN/elO6s0BdHP5+wY
         ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/j6fVGRHQHmfm177qgPJHW+su9jg4GBKcwL2UfxKE4=;
        b=D4OekjoeN+780XbrqnRMutlU9B/6s6jpvyc/h+7Yf1+Mr4hRAALNK6Z3udyK/xGKWT
         yyvsIm2L9iA9CX4ziy+7wH+5wpHuV1Ow00r94NPUgKIPFTWJwg7w3u/8nQXSKx3rIqlQ
         CkG8EvUrlxsmoWe8d+1LyagAcgAQvLpJJq3Q+ZM4PFYAR3nUDVsS7DtMJh/efpntHU/Z
         GRBABgQ82aVjl4goou7LJopZ12lvRk3QHqPBSwcEFwuzKUX3Y09GodHUZiYWzrR/mVnM
         n4hNL6otrJJaqfSfh+eWMnXdptqKxHgdt0QuDHTP0mHVNz6n6q2aVm6K7XlAqyIiThmB
         f0QQ==
X-Gm-Message-State: APjAAAVsAq97FyET0V6Z/qdpikUCLdYfTLiteMyTS0arpUKZAZF+uwnr
        2lot+M/2NOGPoJgwHO6GJWFKQ8d2
X-Google-Smtp-Source: APXvYqxPNilmtey1QjLT6anV6P5lVRgqJNEnrlShuNcBq7Ig8RrL20lB81GWBtRF9QT4LDUBomK+Ng==
X-Received: by 2002:a62:8605:: with SMTP id x5mr529567pfd.112.1573600065382;
        Tue, 12 Nov 2019 15:07:45 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y12sm16608pfp.176.2019.11.12.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:44 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 00/14] t5520: various test cleanup
Message-ID: <cover.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573517561.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments on the last round, Junio.

Please ignore the fixup patch from earlier, it has been bundled into
this reroll.


Like earlier patchsets, I want to implement a feature that involves
modifications to the test suite. Since that feature will probably take a
while to polish up, however, let's clean up the test suite in a separate
patchset first so it's not blocked by the feature work.

1/15 is a general improvement to test_rev_cmp() that will be used later
in the series.

Changes since v5:

* More test_cmp_rev() cleanup

* Changed instances of "subshell" to "command substitution" where appropriate

* Change instances of "Git" to "git" when we are referring to the command

Changes since v4:

* Cleaned up test_cmp_rev() logic with suggestions from Junio

Changes since v3:

* Rebased and tested on top of v2.24.0

Changes since v2:

* Drop 't7408: replace `test_must_fail test_path_is_file`' since it's
  not a rabbit hole we want to go into right now

* Fix the output of `test_cmp_rev !` when revs are actually equal

* Rebase against the latest master since this topic hasn't been picked
  up yet

Changes since v1:

* Incorporate Eric's feedback

Denton Liu (14):
  t: teach test_cmp_rev to accept ! for not-equals
  t5520: improve test style
  t5520: use sq for test case names
  t5520: let sed open its own input
  t5520: replace test -f with test-lib functions
  t5520: remove spaces after redirect operator
  t5520: use test_line_count where possible
  t5520: replace test -{n,z} with test-lib functions
  t5520: use test_cmp_rev where possible
  t5520: test single-line files by git with test_cmp
  t5520: don't put git in upstream of pipe
  t5520: replace $(cat ...) comparison with test_cmp
  t5520: remove redundant lines in test cases
  t5520: replace `! git` with `test_must_fail git`

 t/t2400-worktree-add.sh             |   4 +-
 t/t3400-rebase.sh                   |   2 +-
 t/t3421-rebase-topology-linear.sh   |   6 +-
 t/t3430-rebase-merges.sh            |   2 +-
 t/t3432-rebase-fast-forward.sh      |   2 +-
 t/t3501-revert-cherry-pick.sh       |   2 +-
 t/t3508-cherry-pick-many-commits.sh |   2 +-
 t/t5520-pull.sh                     | 343 +++++++++++++++++-----------
 t/test-lib-functions.sh             |  20 +-
 9 files changed, 231 insertions(+), 152 deletions(-)

Range-diff against v5:
 1:  85fac754e2 !  1:  0532847787 t: teach test_cmp_rev to accept ! for not-equals
    @@ t/test-lib-functions.sh: test_must_be_empty () {
     +# provided first, that its other two parameters refer to different
     +# revisions.
      test_cmp_rev () {
    -+	local op
    ++	local op wrong_result
     +	op='='
    ++	wrong_result='different'
     +	if test $# -ge 1 && test "x$1" = 'x!'
     +	then
     +	    op='!='
    ++	    wrong_result='the same'
     +	    shift
     +	fi
      	if test $# != 2
    @@ t/test-lib-functions.sh: test_must_be_empty () {
     +
     +		if ! test "$r1" "$op" "$r2"
      		then
    -+			local comp_out
    -+			if "x$op" = 'x='
    -+			then
    -+				comp_out='different'
    -+			else
    -+				comp_out='the same'
    -+			fi
      			cat >&4 <<-EOF
     -			error: two revisions point to different objects:
    -+			error: two revisions point to $comp_out objects:
    ++			error: two revisions point to $wrong_result objects:
      			  '$1': $r1
      			  '$2': $r2
      			EOF
 2:  2b1caec3d7 =  2:  aa3f2e3395 t5520: improve test style
 3:  1aa0cdad1c =  3:  99b0fb0e1c t5520: use sq for test case names
 4:  edd4446554 =  4:  0660aa3fff t5520: let sed open its own input
 5:  c5d5966405 =  5:  00b7143b30 t5520: replace test -f with test-lib functions
 6:  6a99400ba4 =  6:  c451940c5b t5520: remove spaces after redirect operator
 7:  b7b66b13f6 =  7:  8e1c90eb70 t5520: use test_line_count where possible
 8:  07517c868c !  8:  8043b230a7 t5520: replace test -{n,z} with test-lib functions
    @@ Metadata
      ## Commit message ##
         t5520: replace test -{n,z} with test-lib functions
     
    -    When wrapping a Git command in a subshell within another command, we
    -    throw away the Git command's exit code. In case the Git command fails,
    -    we would like to know about it rather than the failure being silent.
    -    Extract Git commands so that their exit codes are not lost.
    +    When wrapping a git command in a command substitution within another
    +    command, we throw away the git command's exit code. In case the git
    +    command fails, we would like to know about it rather than the failure
    +    being silent. Extract git commands so that their exit codes are not
    +    lost.
     
         Instead of using `test -n` or `test -z`, replace them respectively with
         invocations of test_file_not_empty() and test_must_be_empty() so that we
 9:  29d9ff3b21 !  9:  7f5347bb40 t5520: use test_cmp_rev where possible
    @@ Metadata
      ## Commit message ##
         t5520: use test_cmp_rev where possible
     
    -    In case an invocation of `git rev-list` fails within the subshell, the
    -    failure will be masked. Remove the subshell and use test_cmp_rev() so
    -    that failures can be discovered.
    +    In case an invocation of `git rev-list` fails within the command
    +    substitution, the failure will be masked. Remove the command
    +    substitution and use test_cmp_rev() so that failures can be discovered.
     
         This change was done with the following sed expressions:
     
10:  aeaa3374a7 ! 10:  73004d6cc3 t5520: test single-line files by git with test_cmp
    @@ Metadata
      ## Commit message ##
         t5520: test single-line files by git with test_cmp
     
    -    In case an invocation of a Git command fails within the subshell, the
    -    failure will be masked. Replace the subshell with a file-redirection and
    -    a call to test_cmp.
    +    In case an invocation of a git command fails within the command
    +    substitution, the failure will be masked. Replace the command
    +    substitution with a file-redirection and a call to test_cmp.
     
         This change was done with the following GNU sed expressions:
     
11:  131609fc5c ! 11:  463f5c11b9 t5520: don't put git in upstream of pipe
    @@ Commit message
     
         Before, if the invocation of git failed, it would be masked by the pipe
         since only the return code of the last element of a pipe is used.
    -    Rewrite the test to put the Git command on its own line so its return
    +    Rewrite the test to put the git command on its own line so its return
         code is not masked.
     
      ## t/t5520-pull.sh ##
12:  c67be3d18c ! 12:  67ea3f0238 t5520: replace subshell cat comparison with test_cmp
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t5520: replace subshell cat comparison with test_cmp
    +    t5520: replace $(cat ...) comparison with test_cmp
     
         We currently have many instances of `test <line> = $(cat <file>)` and
         `test $(cat <file>) = <line>`.  In the case where this fails, it will be
13:  04ef898857 = 13:  b45c088d20 t5520: remove redundant lines in test cases
14:  153ff07dc0 ! 14:  c605afa537 t5520: replace `! git` with `test_must_fail git`
    @@ Metadata
      ## Commit message ##
         t5520: replace `! git` with `test_must_fail git`
     
    -    Currently, if a Git command fails in an unexpected way, such as a
    +    Currently, if a git command fails in an unexpected way, such as a
         segfault, it will be masked and ignored. Replace the ! with
         test_must_fail so that only expected failures pass.
     
-- 
2.24.0.346.gee0de6d492

