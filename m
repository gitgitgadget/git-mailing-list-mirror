Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428551F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 19:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbdKMTcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 14:32:45 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:51915 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754561AbdKMTcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 14:32:43 -0500
Received: by mail-qk0-f194.google.com with SMTP id f63so6702212qke.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=myKJ7LyY3z0+PKBclGO/QbrQXmsH3C4GUDT30c4tfEs=;
        b=RPhBQMvOdtOm4qGuxhwZq632pCoR/LO9gJJ12tsAzS3o4GMqj6Ux4sypJ+9g14NOaS
         hM7HR2hX4wxr4ZzRNN7fMq5kZXeuuRcnYW7Q68X8nmsimhsyVAAK3tA/GRSd3b35S/TB
         VPUk9yo6NHnTllZaLUAvBduKLha0M6UUOdOR6vRJvkvMWJSCPN0Mf1hG+oKY6cFCPB2l
         35n0q1w19x2B0L88wsWfcao8apZWkMZgpL1PK4pyPqeo23pL43qp+/64ShUfEF5JdYe4
         fxs7l7iPO8zlx7r4sV5nTBBC9il8RMsCp7hhyHWflY5VSTndRSgdNmrAkTpdpbmpaec6
         pIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=myKJ7LyY3z0+PKBclGO/QbrQXmsH3C4GUDT30c4tfEs=;
        b=rSpfJvZ3QSIBJOQ5j+LQY/w1KvvhHfRIdf8gfhK7VbFQEN5vRB2ejbzO1JHZ/S60Gu
         aEY32VqX1X6VaMjKqsj1pvItlRaMF5KkXm4gb8BbUtt8+CWFG3dN8Li7FQDtwwJNyD/y
         cbmeaesY0Dcaj/nIt1ZNtdahKasmGErJWuiH2ZmcAJnRqu5SJCcZJsqFItohmPZ6S67j
         rVJsYB2+FaMBE+z6fjufVWRd5gJIPWF4bwA0aH22f9Wj3bZ5efLUGAHjXTRbuL4j7a3h
         zIBqCP5dRTuVtS9/5Z8IimyfLjfh4pCUlbb/MeA6tBqEk59gH1KGjTfW9hSRMAGnJ6tY
         Gc5w==
X-Gm-Message-State: AJaThX51waKHUP420q8FpejbsqK3WdcTGmK7HygLHgXz7Q+phykAf+F0
        ZF3DG1dn6ZsTaH7jOIe/9KVdVMPQQLBu7XFyRKQ+Dg==
X-Google-Smtp-Source: AGs4zMb0pcdU41y0vyxVwjqnCN5xHTLKH9MQV/CgWbLlygRMpLxzUNdHMbVDIbBMSVa2q+tq32dYqd/YPGpC8Zowra0=
X-Received: by 10.233.239.70 with SMTP id d67mr15452694qkg.308.1510601562821;
 Mon, 13 Nov 2017 11:32:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 11:32:42 -0800 (PST)
In-Reply-To: <20171110190550.27059-2-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-2-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 11:32:42 -0800
Message-ID: <CAGZ79kZtOjB43d9kT8yjnwA9ii60VsyzRxM7XHQBtMs70S2zGQ@mail.gmail.com>
Subject: Re: [PATCH 01/30] Tighten and correct a few testcases for merging and cherry-picking
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> t3501 had a testcase originally added

... goes and looks ...

  "in 05f2dfb965 (cherry-pick: demonstrate a segmentation fault, 2016-11-26)"

would have helped me here in the commit message.


> to ensure cherry-pick wouldn't
> segfault when working with a dirty file involved in a rename.  While
> the segfault was fixed, there was another problem this test demonstrated:
> namely, that git would overwrite a dirty file involved in a rename.
> Further, the test encoded a "successful merge" and overwriting of this
> file as correct behavior.  Modify the test so that it would still catch
> the segfault, but to require the correct behavior.

As the correct behavior is not yet implemented, mark it as
test_expect_failure, too. (probably this reads implicit)


>
> t7607 had a test

... added in 30fd3a5425 (merge overwrites unstaged changes in renamed file,
2012-04-15) ...

> specific to looking for a merge overwriting a dirty file
> involved in a rename, but it too actually encoded what I would term
> incorrect behavior: it expected the merge to succeed.  Fix that, and add
> a few more checks to make sure that the merge really does produce the
> expected results.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t3501-revert-cherry-pick.sh | 7 +++++--
>  t/t7607-merge-overwrite.sh    | 5 ++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index 4f2a263b63..783bdbf59d 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -141,7 +141,7 @@ test_expect_success 'cherry-pick "-" works with arguments' '
>         test_cmp expect actual
>  '
>
> -test_expect_success 'cherry-pick works with dirty renamed file' '
> +test_expect_failure 'cherry-pick works with dirty renamed file' '
>         test_commit to-rename &&
>         git checkout -b unrelated &&
>         test_commit unrelated &&
> @@ -150,7 +150,10 @@ test_expect_success 'cherry-pick works with dirty renamed file' '
>         test_tick &&
>         git commit -m renamed &&
>         echo modified >renamed &&
> -       git cherry-pick refs/heads/unrelated
> +       test_must_fail git cherry-pick refs/heads/unrelated >out &&
> +       test_i18ngrep "Refusing to lose dirty file at renamed" out &&
> +       test $(git rev-parse :0:renamed) = $(git rev-parse HEAD^:to-rename.t) &&
> +       grep -q "^modified$" renamed
>  '
>
>  test_done
> diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
> index 9444d6a9b9..00617dadf8 100755
> --- a/t/t7607-merge-overwrite.sh
> +++ b/t/t7607-merge-overwrite.sh
> @@ -97,7 +97,10 @@ test_expect_failure 'will not overwrite unstaged changes in renamed file' '
>         git mv c1.c other.c &&
>         git commit -m rename &&
>         cp important other.c &&
> -       git merge c1a &&
> +       test_must_fail git merge c1a >out &&
> +       test_i18ngrep "Refusing to lose dirty file at other.c" out &&
> +       test -f other.c~HEAD &&
> +       test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
>         test_cmp important other.c

Code looks good,

Thanks,
Stefan
