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
	by dcvr.yhbt.net (Postfix) with ESMTP id DD55E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 00:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKLANn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 19:13:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45419 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLANm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 19:13:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so11916193pfn.12
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 16:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6j5inomchsmBkuvtx5KObV/KY55yKzNUbSaWTUlT8+0=;
        b=onCWg6omk37nDzIrO0fqb1MDawOW9hVgfvkHg2vua98YUorgeIcBfPWTrfLRYDjtfi
         zynTBZPOPCMVTHhqagrgei3yTk/Xky6ykt7jSzbVcNud7GWfhKnea1hj91SAsu8Cb7Ba
         fo6dV7EoYuoxbTUToAiwPv/s7lOwdDcVWv1Zc3T9BEu9JB9kFiqUnfp/iCUfLFe8CGQd
         T9ynyFVd8MkXp4mG6lIE9BL4Qqj9b+wMBDQ9fs1GmbQobttNkrNZnWSpCAGm6RfWBwE9
         QvNojt4q1Iarcimc8mBBXOb/uFgAj+IY2NMNf50yolqJlY1JvIT7Meromt0mgMmd15Jj
         T6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6j5inomchsmBkuvtx5KObV/KY55yKzNUbSaWTUlT8+0=;
        b=lqfdeMYb5+LB+H17IekmJK953UPwgNhKndQb/SFK9YLQM4T45uMjY5e44pmhXOs9VD
         eg1tY+NmAy2XiaMuY9Kzdnd+GS8h0x751faWhOdTGmPyBEajLN9O3ajFfEs2uxHUvuFN
         1Rkdl1VC1arSK3e3h0XJlsFRJzk/cqL1XVVLpYOuUCv5dBOxjYhiIBoZCdQkpecT9aRW
         +Sz9c74CHTdALFFWEmaYLoXTTHK/FV8LxdNCtr+4Huw79zWTe+CZCz56mZNiasncLD8O
         rr27n0JJdGw1PsmdqWR53RoksPUB3H5NAU6oFaMB4Uu1qoyUrogsgrylKJfn3b1SWlmU
         c75A==
X-Gm-Message-State: APjAAAUkNoETd5kckBrtPRyWm+lKDFjFbpxMFVmK/XrI4kfyiZngVYC5
        sgBslZt+MJP5FyVJ+9NVMUSxhLpx
X-Google-Smtp-Source: APXvYqy1cs6Tr0ETb8LMybfXfbi7/wy5VtFzh/vdV+UO3dzV3/FzYp8n36q+jYM+PV9hoWfWy0nr9w==
X-Received: by 2002:a63:5205:: with SMTP id g5mr8958588pgb.267.1573517621414;
        Mon, 11 Nov 2019 16:13:41 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j186sm15499860pfg.161.2019.11.11.16.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:13:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 16:13:38 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/14] t5520: various test cleanup
Message-ID: <cover.1573517561.git.liu.denton@gmail.com>
References: <cover.1573152598.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573152598.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like earlier patchsets, I want to implement a feature that involves
modifications to the test suite. Since that feature will probably take a
while to polish up, however, let's clean up the test suite in a separate
patchset first so it's not blocked by the feature work.

1/15 is a general improvement to test_rev_cmp() that will be used later
in the series.

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
  t5520: replace subshell cat comparison with test_cmp
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
 t/test-lib-functions.sh             |  25 +-
 9 files changed, 236 insertions(+), 152 deletions(-)

Range-diff against v4:
 1:  06f89b85f3 !  1:  3c58df27c4 t: teach test_cmp_rev to accept ! for not-equals
    @@ Metadata
      ## Commit message ##
         t: teach test_cmp_rev to accept ! for not-equals
     
    -    Currently, in the case where we are using test_cmp_rev() to report
    -    not-equals, we write `! test_cmp_rev`. However, since test_cmp_rev()
    -    contains
    +    In the case where we are using test_cmp_rev() to report not-equals, we
    +    write `! test_cmp_rev`. However, since test_cmp_rev() contains
     
                 r1=$(git rev-parse --verify "$1") &&
                 r2=$(git rev-parse --verify "$2") &&
     
    -    In the case where `git rev-parse` segfaults and dies unexpectedly, the
    -    failure will be ignored.
    +    `! test_cmp_rev` will succeed if any of the rev-parses fail. This
    +    behavior is not desired. We want the rev-parses to _always_ be
    +    successful.
     
         Rewrite test_cmp_rev() to optionally accept "!" as the first argument to
         do a not-equals comparison. Rewrite `! test_cmp_rev` to `test_cmp_rev !`
         in all tests to take advantage of this new functionality.
     
    +    Also, rewrite the rev-parse logic to end with a `|| return 1` instead of
    +    &&-chaining into the rev-comparison logic. This makes it obvious to
    +    future readers that we explicitly intend on returning early if either of
    +    the rev-parses fail.
    +
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
      ## t/t2400-worktree-add.sh ##
    @@ t/test-lib-functions.sh: test_must_be_empty () {
     +# provided first, that its other two parameters refer to different
     +# revisions.
      test_cmp_rev () {
    -+	local inverted_op
    -+	inverted_op='!='
    ++	local op
    ++	op='='
     +	if test $# -ge 1 && test "x$1" = 'x!'
     +	then
    -+	    inverted_op='='
    ++	    op='!='
     +	    shift
     +	fi
      	if test $# != 2
      	then
      		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
    -@@ t/test-lib-functions.sh: test_cmp_rev () {
    + 	else
      		local r1 r2
      		r1=$(git rev-parse --verify "$1") &&
    - 		r2=$(git rev-parse --verify "$2") &&
    +-		r2=$(git rev-parse --verify "$2") &&
     -		if test "$r1" != "$r2"
    -+		if test "$r1" "$inverted_op" "$r2"
    ++		r2=$(git rev-parse --verify "$2") || return 1
    ++
    ++		if ! test "$r1" "$op" "$r2"
      		then
     +			local comp_out
    -+			if "x$inverted_op" = 'x='
    ++			if "x$op" = 'x='
     +			then
    -+				comp_out='the same'
    -+			else
     +				comp_out='different'
    ++			else
    ++				comp_out='the same'
     +			fi
      			cat >&4 <<-EOF
     -			error: two revisions point to different objects:
 2:  11714ca897 =  2:  023e0ccc11 t5520: improve test style
 3:  2c27c8d60a =  3:  1bb65a59da t5520: use sq for test case names
 4:  5a196cf136 =  4:  d2fbae6ade t5520: let sed open its own input
 5:  0c8baddc7d =  5:  1d73546eb6 t5520: replace test -f with test-lib functions
 6:  2775817d02 =  6:  f1141f244f t5520: remove spaces after redirect operator
 7:  d71fe3d097 =  7:  5106004e95 t5520: use test_line_count where possible
 8:  dd16809b68 =  8:  85b444e8a6 t5520: replace test -{n,z} with test-lib functions
 9:  abfa6539aa =  9:  3d43784391 t5520: use test_cmp_rev where possible
10:  06cb5c1302 = 10:  2f9052fd94 t5520: test single-line files by git with test_cmp
11:  f47f11ccfa = 11:  3fd10a58c6 t5520: don't put git in upstream of pipe
12:  3dfc417670 = 12:  ed78ed75bd t5520: replace subshell cat comparison with test_cmp
13:  575bd0f0cd = 13:  7888757bd0 t5520: remove redundant lines in test cases
14:  bd92e3821e = 14:  1bc7ad364f t5520: replace `! git` with `test_must_fail git`
-- 
2.24.0.300.g722ba42680

