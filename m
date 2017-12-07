Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C1C20954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdLGTGx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:06:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35901 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdLGTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:06:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so14812938wmg.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b/zR3Ke1gGThjv9x/omtWK9U5E2NNz6SwupvAspwfvI=;
        b=aGUZo8g5W06s+lUwYSho/8fxOXKUMG3y+X4ZGgmMCtfUt394G4JavlPnpaXY/0Utzo
         Nyu5a8gx4c9Cnhoa8n8SorQ6h6laxTqa5/LTa+gCrrOpjWNz/khwvnKKFdbctGy/+MFL
         9xIjC5bx1jvlh9JFNAVeMPx7dnYkJqgEfOvpuhZq86fMeM585C29S0uZpuGyBgm+h+Kj
         obAoJM/ahwtPUISUNVzU2zaQ6UunJki3X/hkMLo1i5U8GGqv0r1En9hFEKenz51N9ooe
         3uh6v9Lq8++niLjfGpuxwKAqUnDZeMFR5phV/V+nX+hSKOTxQCzrBHeCuBBw8+6YM6Bp
         QVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b/zR3Ke1gGThjv9x/omtWK9U5E2NNz6SwupvAspwfvI=;
        b=UePnhJpWRaS/Vywusl8CUbJQPQnPyL3+FneDdcKnhfMEycM/yriy3bZKIOKjXK+Smr
         VXvS23sM8vATQmxDz28OLlG3hvAtwMU3TdU9YW6OxCOs+ZrkyEORyL2Duszo7bY3f+AK
         kA+szFkz7ao0mEmXFAYRjsSDz1f1+hkcNJuCHK89QRbdPXKNCZH20KmLR46XebrtLReD
         tFNu4kcjDRag1i7b4d2iO9+8A1vnmN29hxclXc7b3yzhNbnjzvSg3db+AW1FQyXoKD4g
         uvzqQ7YAnk9SLdxNMbNUutJTjioRxA6qyNSwd3e27f3aRTM/7B5Wn/Yonlr4JSKmasrI
         y6BA==
X-Gm-Message-State: AJaThX5O+UL+Dg0cFCIDaVZTJUoPRU61zw+OWW7De+g3pdXL0CT5I8o1
        WRit8uoZ9WJPDVocE82hmw+D8aXbdX43tvyQ1mE=
X-Google-Smtp-Source: AGs4zMbClB68z+2AzUoM8PoLMHYWruUebJw/ObQi11r0LkhxKlb5QEISVUZJaqFjzNuLPUWPNoCt8vtvshJZH9bD+lQ=
X-Received: by 10.80.137.147 with SMTP id g19mr46385671edg.293.1512673610616;
 Thu, 07 Dec 2017 11:06:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Thu, 7 Dec 2017 11:06:29 -0800 (PST)
In-Reply-To: <20171207173034.12865-4-gitster@pobox.com>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
 <20171207173034.12865-1-gitster@pobox.com> <20171207173034.12865-4-gitster@pobox.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 7 Dec 2017 11:06:29 -0800
Message-ID: <CA+P7+xoYEQ8sD+hSk+N95xAaRkMo15+kDRNB5rH5dgbGCfPieQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] t4045: test 'diff --relative' for real
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 7, 2017 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The existing tests only checked how well -relative=<dir> work,
> without testing --relative (without any value).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4045-diff-relative.sh | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index fefd2f3f81..815cdd7295 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -25,7 +25,10 @@ check_diff () {
>         +other content
>         EOF
>         test_expect_success "-p $*" "
> -               git diff -p $* HEAD^ >actual &&
> +               (
> +                       test -z "$in_there" || cd "$in_there"
> +                       git diff -p $* HEAD^
> +               ) >actual &&
>                 test_cmp expected actual
>         "
>  }
> @@ -38,7 +41,10 @@ check_numstat () {
>         EOF
>         test_expect_success "--numstat $*" "
>                 echo '1 0       $expect' >expected &&
> -               git diff --numstat $* HEAD^ >actual &&
> +               (
> +                       test -z "$in_there" || cd "$in_there"
> +                       git diff --numstat $* HEAD^
> +               ) >actual &&
>                 test_cmp expected actual
>         "
>  }
> @@ -51,7 +57,10 @@ check_stat () {
>          1 file changed, 1 insertion(+)
>         EOF
>         test_expect_success "--stat $*" "
> -               git diff --stat $* HEAD^ >actual &&
> +               (
> +                       test -z "$in_there" || cd "$in_there"
> +                       git diff --stat $* HEAD^
> +               ) >actual &&
>                 test_i18ncmp expected actual
>         "
>  }
> @@ -63,15 +72,22 @@ check_raw () {
>         :000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A      $expect
>         EOF
>         test_expect_success "--raw $*" "
> -               git diff --no-abbrev --raw $* HEAD^ >actual &&
> +               (
> +                       test -z "$in_there" || cd "$in_there"
> +                       git diff --no-abbrev --raw $* HEAD^ >actual
> +               ) &&

You could avoid the subshell by just passing $in_there to -C on the
git commands. Same for the other tests. If you quote it, -C
'$in_there', then it will work regardless of if in_there is set or
not, (-C with an empty string doesn't cd anywhere). I think this is
generally preferable for tests given it helps avoid unnecessary
subshells when testing on Windows..?

>                 test_cmp expected actual
>         "
>  }
>
>  for type in diff numstat stat raw
>  do
> +       in_there=
>         check_$type file2 --relative=subdir/
>         check_$type file2 --relative=subdir
> +       in_there=subdir
> +       check_$type file2 --relative
> +       in_there=
>         check_$type dir/file2 --relative=sub
>  done
>

This isn't quite what I had in mind for the directory parameter. I
passed it as an extra argument, but I think this is probably more
sensible.

> --
> 2.15.1-480-gbc5668f98a
>
