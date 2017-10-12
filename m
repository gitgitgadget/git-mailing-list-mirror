Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABDF520372
	for <e@80x24.org>; Thu, 12 Oct 2017 22:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdJLWjF (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 18:39:05 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:49157 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753191AbdJLWjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 18:39:04 -0400
Received: by mail-qt0-f176.google.com with SMTP id k31so16453198qta.6
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E0A2YfKy5+/iVWY7hs0ZGy9RBnERSpB4ftp7I1SqRC4=;
        b=CuQNpxe91gdY1MRpvVi+s4bWuoo2jSZocsXH8w3sqh3ql3tXRcm+jHoimH3N+yCC/4
         lvLKscPf5JugTDGk9m3AwM1BS4grGtRlrc5HXI4Jw2TsfZmLXQwm8Mg+z6EiL5dZls7l
         MUMWEfGUvyUO2DzxjGLvvvRn138S/wp+W1Hohh9GMFo7bBTBvs1ODJCvKnWRiZCT4J/U
         CxiDq6EEq8JoxwYWF0rIJ+f01ID9zFQGcJPHeQYbyxa55OYVPqDESXfBpdZKaJBDJ7L8
         eUBYzDOBslJ3uH+4R/Voha0u1d0scWwpeBRWuAgtsgwerrSIkxJUbKy9aTSFc2NkAu4b
         nIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E0A2YfKy5+/iVWY7hs0ZGy9RBnERSpB4ftp7I1SqRC4=;
        b=fbJ2tvBooIPKyylYyka7kD32jMwA6Soq6YYIwzuaR8U+8Ad39A7dTGUPP7Qs9NPOIz
         KrGFrUEZ+aj/NJwoND60fsjtZ7ebECfHSs3ptQLdwHzqvYy3K+/w8daKdruSvAGjWAei
         bYRz9MKR69UXT7ylgmGLRNMVPe23XnvaOW3zsmtgftAy34aqxat4MCM3TxhTAAwedLcl
         wAawXH+JxmRsvDHq9XLYsz6QZkqJghrjEZfJcc43hrUJAVscWxmpdm5KUOyyJ7gqOBIc
         2gxXlaiITAFe4J7WaLRhBNoX9YsysnKBxYcU2jFzaUnkKQUDZPAaqPvVc39FKLFtXGHT
         0yAg==
X-Gm-Message-State: AMCzsaUZxpyZGRvVFtav0w/dEWMALqBhwmihp/Fvp505YGlzykCuw0fO
        ANcQpHxCKMAtdQkUgVAD4kh8ElHKsvKLFGBqAR+8Cg==
X-Google-Smtp-Source: AOwi7QA+L1Dr431LWYig9MlUYi5PA47GPpLd9uiHMJks13q3+fNcjo2pIpEKpWqFlH8iSFA9Mt34RaLKgxOULkdaCGw=
X-Received: by 10.200.36.175 with SMTP id s44mr6130549qts.298.1507847943785;
 Thu, 12 Oct 2017 15:39:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 12 Oct 2017 15:39:03 -0700 (PDT)
In-Reply-To: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
References: <CAGHpTBLQ8vi00e3Tt3KTrCfaAWhZKQX6u6Ca17t2ySVQdoGc5g@mail.gmail.com>
 <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Oct 2017 15:39:03 -0700
Message-ID: <CAGZ79kZ=v0GiBfNPK=iRp7Hi=zG=KUL6+jHuc3N5CRqtECt7fw@mail.gmail.com>
Subject: Re: Out of memory with diff.colormoved enabled
To:     Jeff King <peff@peff.net>
Cc:     Orgad Shaneh <orgads@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 1:05 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 12, 2017 at 10:53:23PM +0300, Orgad Shaneh wrote:
>
>> There is an infinite loop when colormoved is used with --ignore-space-change:
>>
>> git init
>> seq 20 > test
>> git add test
>> sed -i 's/9/42/' test
>> git -c diff.colormoved diff --ignore-space-change -- test
>
> Thanks for an easy reproduction recipe.

Thanks here as well!

> It looks like the problem is that next_byte() doesn't make any forward
> progress in the buffer with --ignore-space-change. We try to convert
> whitespace into a single space

> (I'm not sure why, but I'm not very
> familiar with this part of the code).

(on why you don't feel familiar)
Because it is quite new, and you weren't one of the main reviewers.
2e2d5ac184 (diff.c: color moved lines differently, 2017-06-30) was also very
large, such that it is easy to overlook. Though I remember Junio and me
discussing the next_byte part quite vividly. :/

(On why it is the way it is)
Consider the three strings
    one SP word
    one TAB word
    oneword

The first two are equal, but the third is different with
`--ignore-space-change` given. To achieve that goal,
the easiest thing to do (in my mind) was to replace
any sequence of blank characters by "a standard
space" sequence. That will make all strings with different
white space sequences compare equal, but the one
without blanks will be different.

> But if there's no space, then the
> "cp" pointer never gets advanced.

Right, because of the early return, skipping the increment of *cp

> This fixes it, but I have no idea if it's doing the right thing:
>
> diff --git a/diff.c b/diff.c
> index 69f03570ad..e8dedc7357 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -713,13 +713,17 @@ static int next_byte(const char **cp, const char **endp,
>                 return -1;
>
>         if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
> -               while (*cp < *endp && isspace(**cp))
> +               int saw_whitespace = 0;
> +               while (*cp < *endp && isspace(**cp)) {
>                         (*cp)++;
> +                       saw_whitespace = 1;
> +               }
>                 /*
>                  * After skipping a couple of whitespaces, we still have to
>                  * account for one space.
>                  */
> -               return (int)' ';
> +               if (saw_whitespace)
> +                       return (int)' ';

The "else" is implicit and it falls through to
the standard case at the end of the function,
incrementing *cp, returning the character *cp
pointed at prior to being incremented.

That sounds correct.

>         }
>
>         if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
>
> I guess it would be equally correct to not enter that if-block unless
> isspace(**cp).

This also sounds correct.

>
> -Peff
