Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1931F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeI1A5v (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:57:51 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:40669 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1A5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:57:51 -0400
Received: by mail-yw1-f54.google.com with SMTP id z143-v6so1513721ywa.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjfLZ2tAtQ+8Y10s5K1TS7+H2f1rkJkBr//TLumwdio=;
        b=INgT4GL6+EZLxtrYHyHkgTUb8xGCbJfJZmOPOQRW4MSJEIcHbFZgVXJ5Ly4XnaATUd
         1P1nLZhsrUVpcncFVCKwUvtlcBy7FoELZdw1d9OUxvL6B+Ptduz/2eiovzLTvZtdDBVn
         GKLJ5NFq4mRKWPWqrgQyz9wCDFuk6o8ToPEyHx5z6xWvJYG8kbkAS/uh+evF674MGdJz
         xL9Xs67820cEn5ehpg3rdFWkhlbeMzjVbvm4IMNKSTxdSkxOSRJwDfsHimqf45PpLAh1
         ll4WnXryjRPpEQ4dCAsKsAj1ahel/sD/phRm6md9jMirnuUWRG0qqcWi7Nr58XK20xVJ
         blBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjfLZ2tAtQ+8Y10s5K1TS7+H2f1rkJkBr//TLumwdio=;
        b=iWUr8xtWhNFchKfcLkFskkeOMecDTUDdqtd2jvwKbl7A/J2L0b+HmDJyUmUt7B55rv
         5foxKegpqOWFiKJHT7Dk25K868s3NocCGK8O7wRiSHEm62cI1vWFInTjT7b5HfeTdcEZ
         oUIeARnrHkHgIM5BeTw8D1fh5ZlH821asUGGMzMLA7S0pmgiZTJ1iNl0wQ/3Suf7yHQf
         uO6wJDh5PtlEGeVXHjv+CAtmHeGiy0yvTDdYj8u6e8dJEQDejCVi68Rmyi5SjZRCYOSp
         HZ8M2+ZYqU/Koi4z5josC6+yGyzXXkEVZTdYZqXHxa4nhEwMuNbvNh3qTzbBbaN/8e5i
         PuxA==
X-Gm-Message-State: ABuFfojtRBnvGV2bFUkwDXdY3syoBY5txokteYTwAywbrkt8e9Zsn5IO
        rbM4UFhOxU2SxzTjKzoml7RqFrNQQ1Hvn+RTLj9z0Q==
X-Google-Smtp-Source: ACcGV610Wve2l/0i6gfb4Dfwzmijc3xCuSbXOFogtdlOKW4VmLkbcsFjNRs5XT59rUOc9nFjCxz6AUwkAXG5lGZQgT0=
X-Received: by 2002:a81:a11:: with SMTP id 17-v6mr6418908ywk.238.1538073495318;
 Thu, 27 Sep 2018 11:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
 <20180927012455.234876-2-steadmon@google.com>
In-Reply-To: <20180927012455.234876-2-steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Sep 2018 11:38:04 -0700
Message-ID: <CAGZ79kZ2aqW7X57KHPtjQiyWtwfk4SGZYRqwccgy9ji0s+sYYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] archive: follow test standards around assertions
To:     Josh Steadmon <steadmon@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 6:25 PM Josh Steadmon <steadmon@google.com> wrote:
>
> Move assertions outside of the check_tar function so that all top-level
> code is wrapped in a test_expect_* assertion.

Cool, I'll file this under modernizing the test infrastructure ;-)

> diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> index 2a97b27b0a..c408e3a23d 100755
> --- a/t/t5000-tar-tree.sh
> +++ b/t/t5000-tar-tree.sh
> @@ -62,11 +62,9 @@ check_tar() {
>         dir=$1
>         dir_with_prefix=$dir/$2
>
> -       test_expect_success ' extract tar archive' '
> -               (mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
> -       '
> +       (mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile &&
>
> -       test_expect_success TAR_NEEDS_PAX_FALLBACK ' interpret pax headers' '
> +       if test_have_prereq TAR_NEEDS_PAX_FALLBACK ; then
>                 (
>                         cd $dir &&
>                         for header in *.paxheader
> @@ -82,16 +80,11 @@ check_tar() {
>                                 fi
>                         done
>                 )
> -       '
> +       fi &&
>
> -       test_expect_success ' validate filenames' '
> -               (cd ${dir_with_prefix}a && find .) | sort >$listfile &&
> -               test_cmp a.lst $listfile
> -       '
> -
> -       test_expect_success ' validate file contents' '
> -               diff -r a ${dir_with_prefix}a
> -       '
> +       (cd ${dir_with_prefix}a && find .) | sort >$listfile &&
> +       test_cmp a.lst $listfile &&
> +       diff -r a ${dir_with_prefix}a

Up to here we unwrapped code and removed test_expect_success
and just executed the code as is, so later callers would need to encapsulate
the call to check_tar with test_expect_success.

However as we are touching the code here, we can go further than just
unwrapping it, usually we'd format one command a line,

    (
        cd ${dir_with_prefix}a &&
        find .
    ) | sort >$listfile &&
    test_cmp ...

I am not sure if that standard style is more legible in this case though.

>  }
>
>  test_expect_success \
> @@ -143,19 +136,20 @@ test_expect_success \
>      'git archive' \
>      'git archive HEAD >b.tar'
>
> -check_tar b
> +test_expect_success 'extract archive' 'check_tar b'

Heh. Just looked into the file and the surrounding code is
a wild mixture of the old style

test_expect_success \
    'git archive' \
    'git archive HEAD >b.tar'

check_tar b

and the new style

test_expect_success 'test name' '
 <TAB> command &&
 <TAB> command2
'

Maybe we could cleanup that file to look more like
one of the newer tests (e.g. t3206, t0410) ?

But I guess for the purpose of getting the check_tar
function usable inside a test, this would do enough.

>
>  test_expect_success 'git archive --prefix=prefix/' '
>         git archive --prefix=prefix/ HEAD >with_prefix.tar
>  '
>
> -check_tar with_prefix prefix/
> +test_expect_success 'extract with prefix' 'check_tar with_prefix prefix/'
>
>  test_expect_success 'git-archive --prefix=olde-' '
>         git archive --prefix=olde- HEAD >with_olde-prefix.tar
>  '
>
> -check_tar with_olde-prefix olde-
> +test_expect_success 'extract with olde- prefix' \
> +       'check_tar with_olde-prefix olde-'

In new style this would look like

    test_expect_success 'extract with olde- prefix' '
        check_tar with_olde-prefix olde-
    '
