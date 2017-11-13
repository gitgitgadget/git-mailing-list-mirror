Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5AB31F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdKMWEi (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:04:38 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:51234 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdKMWEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:04:37 -0500
Received: by mail-qk0-f180.google.com with SMTP id f63so7239664qke.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZyA+dytaKkRzwDFPRW03mQBvzEa8kzfXsB3lJwTWnEw=;
        b=bkljIQXJODnlIG8UG4nRmibrhnYv5XeLKm6ZpohYnM5D1614P3lzai9tdHRQ0hmyRG
         tHt3Anc51kQWJyuygAeeAl+uGKguQNjyZRdQiX+H+3Q2PjO9CuyN7b1MurVMVOr0Ywe3
         lnyevtK9d7KnHD8DzYHqk9K7YFtHi62OtjVZsoPcH20OD6s2OA/eD/C3tz5CqHMfqIDC
         ArkZTOFCueQkoCsWpN9Db0tOuuePCSTTxpLqOxMGrnqiIh0bt656IutRJpH8Egi37JtO
         Z73N44nOZknjdWVcH/O9HAsMqV9wUlDDyJAdxjqVhEEypbKI+9H9jvcTedzajgwY4K1O
         IU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZyA+dytaKkRzwDFPRW03mQBvzEa8kzfXsB3lJwTWnEw=;
        b=stQ++j5J0SJb9fuIj4F5z5tjMGI5ZvQa7CwVSnrODrFkre+ZRUyDJzs2wRpD6Gc2bF
         X9rpRNm7geJuGgHMF2KOcVPmfnlwSbffW6CzmjZIJm8hxe8e7DSBJ7QrS85xHy16mVf0
         mk3+Hjie4aZtpaX1wHvxWrg9jFBQeRrZO9Yzs4NC6JPhAN6DYgy1k/YXGXS02h/P7lj1
         bbguGPUjWs6XOnt1wAOAPImc4T1UnSaHsy+3txLqALpvjy8Zt13qPEUPdeB9l9MKuCim
         w8JLJW2mT+lu5wWCXlfDyiCqNhAJvk6+Rtr8lGxZ7TjdpjoiqVmRi9jTyB7XL5PFnIQ3
         QEfQ==
X-Gm-Message-State: AJaThX4UgNxKsc02y4utAYj1vBJt8GeLV9COfieNOIGnhipxoC59BgHF
        hvfHALB+QgrazbjpC3Tg6Y1OPhn1jCNpAYAMwAZ8gA==
X-Google-Smtp-Source: AGs4zMY8VYsIM4iKsfBAS6nfj+ajceEix/XxEh8bZhFSABURwq4veJUTaBhudq6X+p2MPCdJOpj8QpQsAIncZEiVcwg=
X-Received: by 10.55.33.13 with SMTP id h13mr16458013qkh.176.1510610675674;
 Mon, 13 Nov 2017 14:04:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 14:04:35 -0800 (PST)
In-Reply-To: <20171110190550.27059-5-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-5-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 14:04:35 -0800
Message-ID: <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com>
Subject: Re: [PATCH 04/30] directory rename detection: basic testcases
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 391 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 391 insertions(+)
>  create mode 100755 t/t6043-merge-rename-directories.sh
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> new file mode 100755
> index 0000000000..b737b0a105
> --- /dev/null
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -0,0 +1,391 @@
> +#!/bin/sh
> +
> +test_description="recursive merge with directory renames"
> +# includes checking of many corner cases, with a similar methodology to:
> +#   t6042: corner cases with renames but not criss-cross merges
> +#   t6036: corner cases with both renames and criss-cross merges
> +#
> +# The setup for all of them, pictorially, is:
> +#
> +#      B
> +#      o
> +#     / \
> +#  A o   ?
> +#     \ /
> +#      o
> +#      C
> +#
> +# To help make it easier to follow the flow of tests, they have been
> +# divided into sections and each test will start with a quick explanation
> +# of what commits A, B, and C contain.
> +#
> +# Notation:
> +#    z/{b,c}   means  files z/b and z/c both exist
> +#    x/d_1     means  file x/d exists with content d1.  (Purpose of the
> +#                     underscore notation is to differentiate different
> +#                     files that might be renamed into each other's paths.)
> +
> +. ./test-lib.sh
> +
> +
> +###########################################################################
> +# SECTION 1: Basic cases we should be able to handle
> +###########################################################################
> +
> +# Testcase 1a, Basic directory rename.
> +#   Commit A: z/{b,c}
> +#   Commit B: y/{b,c}
> +#   Commit C: z/{b,c,d,e/f}

(minor thought:)
After rereading the docs above this is clear; I wonder if instead of A, B, C
a notation of Base, ours, theirs would be easier to understand?


> +test_expect_success '1a-setup: Simple directory rename detection' '
> +test_expect_failure '1a-check: Simple directory rename detection' '

Thanks for splitting the setup and the check into two different test cases!


> +       git checkout B^0 &&

Any reason for ^0 ? (to make clear it is a branch?)

> +# Testcase 1b, Merge a directory with another
> +#   Commit A: z/{b,c},   y/d
> +#   Commit B: z/{b,c,e}, y/d
> +#   Commit C: y/{b,c,d}
> +#   Expected: y/{b,c,d,e}
> +
> +test_expect_success '1b-setup: Merge a directory with another' '
> +       git rm -rf . &&
> +       git clean -fdqx &&
> +       rm -rf .git &&
> +       git init &&

This is quite a strong statement to start a test with.
Nowadays we rather do

    test_when_finished "some command" &&

than polluting the follow up tests. But as you split up the previous test
into 2 tests, it is not clear if this would bring any good.

Also these are four cleanup commands, I'd have expected fewer.
Maybe just "rm -rf ." ? Or as we make a new repo for each test case,

    test_create_repo 1a &&
    cd 1a

in the first setup, and here we do
    test_create_repo 1b &&
    cd 1b

relying on test_done to cleanup everything afterwards?


> +# Testcase 1c, Transitive renaming
> +#   (Related to testcases 3a and 6d -- when should a transitive rename apply?)
> +#   (Related to testcases 9c and 9d -- can transitivity repeat?)
> +#   Commit A: z/{b,c},   x/d
> +#   Commit B: y/{b,c},   x/d
> +#   Commit C: z/{b,c,d}

So B is "Rename z to y" and C is "Move x/d to z/d"

> +#   Expected: y/{b,c,d}  (because x/d -> z/d -> y/d)

This is an excellent expectation for a clean case like this.
I have not reached 3, 9 yet, so I'll remember these questions.

> +test_expect_success '1c-setup: Transitive renaming' '
> +       git rm -rf . &&
> +       git clean -fdqx &&
> +       rm -rf .git &&
> +       git init &&
> +
> +       mkdir z &&
> +       echo b >z/b &&
> +       echo c >z/c &&
> +       mkdir x &&
> +       echo d >x/d &&
> +       git add z x &&
> +       test_tick &&
> +       git commit -m "A" &&
> +
> +       git branch A &&
> +       git branch B &&
> +       git branch C &&
> +
> +       git checkout B &&
> +       git mv z y &&
> +       test_tick &&
> +       git commit -m "B" &&
> +
> +       git checkout C &&
> +       git mv x/d z/d &&
> +       test_tick &&
> +       git commit -m "C"
> +'
> +
> +test_expect_failure '1c-check: Transitive renaming' '
> +       git checkout B^0 &&
> +
> +       git merge -s recursive C^0 &&
> +
> +       test 3 -eq $(git ls-files -s | wc -l) &&

    git ls-files >out &&
    test_line_count = 3 out &&

maybe? Piping output of git commands somewhere is an
anti-pattern as we cannot examine the return code of ls-files in this case.

> +       test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
> +       test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
> +       test $(git rev-parse HEAD:y/d) = $(git rev-parse A:x/d) &&

Speaking of these, there are quite a lot of invocations of rev-parse,
though it looks clean; recently Junio had some good ideas regarding a
similar test[1].
So maybe

  git rev-parse >actual \
    HEAD:y/b  HEAD:y/c HEAD:y/d &&
  git rev-parse >expect \
    A:z/b    A:z/c    A:x/d &&
  test_cmp expect actual

Not sure if that is any nicer, but has fewer calls.

[1] https://public-inbox.org/git/xmqqa807ztx4.fsf@gitster.mtv.corp.google.com/


> +       test_must_fail git rev-parse HEAD:x/d &&
> +       test_must_fail git rev-parse HEAD:z/d &&
> +       test ! -f z/d
> +'
> +
> +# Testcase 1d, Directory renames (merging two directories into one new one)
> +#              cause a rename/rename(2to1) conflict
> +#   (Related to testcases 1c and 7b)
> +#   Commit A. z/{b,c},        y/{d,e}
> +#   Commit B. x/{b,c},        y/{d,e,m,wham}
> +#   Commit C. z/{b,c,n,wham}, x/{d,e}
> +#   Expected: x/{b,c,d,e,m,n}, CONFLICT:(y/wham & z/wham -> x/wham)
> +#   Note: y/m & z/n should definitely move into x.  By the same token, both
> +#         y/wham & z/wham should to...giving us a conflict.

If wham are equal (in oid), shouldn't this not conflict and only conflict
when z/wham and x/wham differ in oid, but have the same sub-path?

> +
> +# Testcase 1e, Renamed directory, with all filenames being renamed too
> +#   Commit A: z/{oldb,oldc}
> +#   Commit B: y/{newb,newc}
> +#   Commit C: z/{oldb,oldc,d}

What about oldd ?
(expecting a pattern across many files of s/old/new/ isn't unreasonable,
but maybe too much for now?)
By having no "old" prefix there is only one thing to do, which is y/d

> +#   Expected: y/{newb,newc,d}

ok.

> +# Testcase 1f, Split a directory into two other directories
> +#   (Related to testcases 3a, all of section 2, and all of section 4)
> +#   Commit A: z/{b,c,d,e,f}
> +#   Commit B: z/{b,c,d,e,f,g}
> +#   Commit C: y/{b,c}, x/{d,e,f}
> +#   Expected: y/{b,c}, x/{d,e,f,g}

Why not y/g ? Because there are more files in x?
I can come up with a reasonable counter example:

A: src/{main.c, foo.c, bar.c, magic.py}
B: src/{main.c, foo.c, bar.c, magic.py, magic-helper.py}
C: src/{main.c, foo.c, bar.c} py/{magic.py}
Expect: src/{main.c, foo.c, bar.c} py/{magic.py, magic-helper.py}


> +
> +###########################################################################
> +# Rules suggested by testcases in section 1:
> +#
> +#   We should still detect the directory rename even if it wasn't just
> +#   the directory renamed, but the files within it. (see 1b)
> +#
> +#   If renames split a directory into two or more others, the directory
> +#   with the most renames, "wins" (see 1c).  However, see the testcases
> +#   in section 2, plus testcases 3a and 4a.

oh, ok. I presume testcases 2 follows in a later patch.
I'll go looking.

Thanks,
Stefan
