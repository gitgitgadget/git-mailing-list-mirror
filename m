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
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B531F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJVKTz (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:19:55 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:42405 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:19:55 -0400
Received: by mail-pg1-f182.google.com with SMTP id f14so9649339pgi.9
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y1I1ZzNx6RQcNzwweqjhBxufSItFNEYOMJYpV/KHzyk=;
        b=sqIp0p0Z3/dMpeRO9nCTeKxm+gxAnxNDiaZIe0IE/o8U/3NoURh5z/jvVhVr5W4fFs
         L9Y9i0kGYTOmBCQ4EGHpbNMQ9mM76dA0geIlYJ1d/9QMthPx8auEvsKcot+kkv6pcG5G
         xpOfB/q/MD7TmpqmPRdU6+E2MzLnYrctOuUy8XY3jcbLQmBSkT0GP4IM9u0RWpIbz/lx
         Aj2lHrhXTv34liQMuCuRAJ8+h4mufAkNQVjdRsBXKxnsNaWCoaZUrIBWKA/k7qqghzXW
         qCcXrTimmZiKegGbkKwQG5hpV/R+aPcnjmGKeGzMvKY3vmsQ7xNEuFQxXUKEX8sAqxBt
         XytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y1I1ZzNx6RQcNzwweqjhBxufSItFNEYOMJYpV/KHzyk=;
        b=BW72ImrvkPTUFB5Sbe14svJ2nw0+8xrx1LaRY9A8eLu9fCt9vPJ/BY5lgA7ksJIH+N
         V2Zh/BWYrTn99Qh5skxCXxp4FOS1XkTFE7P68aifiolAQjKXTfvRVjKebXLDdpWyWWZX
         b/ESZoMX3WOXSrZG5kFUc2n4X70kflCGayUjT4HFO4tSlKsM7EuXP7XtVkTYIf7fyUtX
         AZYCYa3y18pJ7qPTGGEUDiRGBr8/OcyXn71Ykufki874NQ8jqUUQkxEDXQTUpgoWvd/P
         dhDfgNKCMXiOFqFIUxkx6jHoSIkVXdqu6mwEn9Rhy8iqiU/rGMJhqx6CqtBA8eoXn+Ur
         Ffhw==
X-Gm-Message-State: APjAAAVQgfdsGEy7zTshd6dd2X0zrWB9m3ADPCktbSc0X5aRxY2rBzfW
        E0LWdiSGbYv8pkJHkr//birqpSei
X-Google-Smtp-Source: APXvYqw/ygnkRTwtuDCRZz5XNMZRQljQKiqeq2fdToAM0I4f2xzfXo59VoS0Dfqm/3xFSWd//skFYw==
X-Received: by 2002:a62:5305:: with SMTP id h5mr3432798pfb.121.1571739594319;
        Tue, 22 Oct 2019 03:19:54 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id u7sm18582653pfn.61.2019.10.22.03.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:19:53 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:19:51 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 00/14] t5520: various test cleanup
Message-ID: <cover.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
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
 t/test-lib-functions.sh             |  22 +-
 9 files changed, 234 insertions(+), 151 deletions(-)

Range-diff against v2:
 1:  987fee4652 <  -:  ---------- t7408: replace `test_must_fail test_path_is_file`
 2:  417e808466 !  1:  9a96f113e7 t: teach test_cmp_rev to accept ! for not-equals
    @@ t/test-lib-functions.sh: test_cmp_rev () {
     -		if test "$r1" != "$r2"
     +		if test "$r1" "$inverted_op" "$r2"
      		then
    ++			local comp_out
    ++			if "x$inverted_op" = 'x='
    ++			then
    ++				comp_out='the same'
    ++			else
    ++				comp_out='different'
    ++			fi
      			cat >&4 <<-EOF
    - 			error: two revisions point to different objects:
    +-			error: two revisions point to different objects:
    ++			error: two revisions point to $comp_out objects:
    + 			  '$1': $r1
    + 			  '$2': $r2
    + 			EOF
 3:  0a56980857 =  2:  dfc86a8d9b t5520: improve test style
 4:  dfa89ba1cb =  3:  a1071038f5 t5520: use sq for test case names
 5:  9fac3dff83 =  4:  0af3f5027b t5520: let sed open its own input
 6:  c6ca45eb17 =  5:  b696ff0a67 t5520: replace test -f with test-lib functions
 7:  830a8212ae =  6:  d2e49fd990 t5520: remove spaces after redirect operator
 8:  3d982230be =  7:  fcfc3226f8 t5520: use test_line_count where possible
 9:  2bca4f046d =  8:  86dafc7b54 t5520: replace test -{n,z} with test-lib functions
10:  1a54db1d5c =  9:  bf9b5023a3 t5520: use test_cmp_rev where possible
11:  52cf4f0d0f = 10:  bfabf8ceff t5520: test single-line files by git with test_cmp
12:  0cfabb201c = 11:  56bcbf3047 t5520: don't put git in upstream of pipe
13:  b2d0ce21c8 = 12:  e9d50b8bb0 t5520: replace subshell cat comparison with test_cmp
14:  5aac40a029 = 13:  9db0fc2156 t5520: remove redundant lines in test cases
15:  2c0d3ac416 = 14:  a721d5f119 t5520: replace `! git` with `test_must_fail git`
-- 
2.24.0.rc0.197.g0926ab8072

