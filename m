Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA67200B9
	for <e@80x24.org>; Mon,  7 May 2018 19:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeEGTFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 15:05:43 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:46824 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbeEGTFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 15:05:42 -0400
Received: by mail-yw0-f170.google.com with SMTP id i17-v6so8927410ywg.13
        for <git@vger.kernel.org>; Mon, 07 May 2018 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oSVWIahr0APIbeFhRE7xd7DWevC5/rspdswR5qTv+aU=;
        b=aVk+9JXRk7+WCWfhyNPbiAiQjKMZnX1dF+s3oWMexdGR492hNYYlomR0bc1fMDtoym
         EegylJfwRS2fhLWjIwObmc1PAxfYn4p7MTPZGvH74xLVjLOLktjaUeYT5bCJRGTwVvFc
         ebpB0rWUkO1b0L0PRqMsPe4QT6FV/QLRCh3bLcyLGgEwTdVAoaAl6m6JfS2OkxpWvosn
         8DBSBkPkfp7tBtlfSGhXDZEeL99kqRvzAlXb1Ur229RVdVSwsfsanmHak2eeg86tfsvW
         LWJlG8f7OPsHLBaPdsDOcci1JhN6ujcbNgKelA/NDZJNF7zLD4AOmP2Je1nSwdxXE5Tz
         itVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oSVWIahr0APIbeFhRE7xd7DWevC5/rspdswR5qTv+aU=;
        b=X01BF7oOKyO/iepIIqExymg3cWLa4kR5pMKT2eIT0HxuTubrAmn1qxLe5WoGF80MS6
         r0dXeyLeUc/IuONA64/Dbck7mBxBMsdmp43do9UVL6Zl5/9yF5TrxxiRjXOwi7fFhrrE
         4tdLVpeulTT4FWXAN9wvmrRNAcXngHNiVkifZg7Vg7ya6uG9NRzJc2DEpW1X8JuW5ppP
         M4WLHPXwbeUu55mOsoCTiBTg1WTgpBMJCc2sV5q8SiXcaKm3wzHzUXCBEoy5Tpwws2ue
         2ekuC6PxOEr9mIj3zg1d60GW3Zsf1aJXaHN3NXn/UiuQBz16k1Ru2vWPMvuin7OEndAa
         I4CQ==
X-Gm-Message-State: ALQs6tC27WzC/P7gYHeD2XoCRmyc90w1zCuWTCPbt7/wyhkHsfJAPXCP
        D8o4wo0ea2C8CaGchqoUDigQzEPOkqkt4z82ufe25w==
X-Google-Smtp-Source: AB8JxZpRgor1UmLVgWh0Y3T0bxwKSatmiBQBbBMogICqX6wY7DYBLb4NIK6WgTFLWt8H+O2cDvP98v6B1K2wT7W0GjE=
X-Received: by 2002:a81:4ec9:: with SMTP id c192-v6mr21809248ywb.421.1525719941615;
 Mon, 07 May 2018 12:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 12:05:41 -0700 (PDT)
In-Reply-To: <1525630243.15782.4.camel@gmail.com>
References: <1525630243.15782.4.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 12:05:41 -0700
Message-ID: <CAGZ79kYSanRAchMe+7uJ4spy+GaS7PyU7epPeOSCs_58RsAR8A@mail.gmail.com>
Subject: Re: Weak option parsing in `git submodule`
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 11:10 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> I recently faced the consequence of the weak option parsing done by in
> `git submodule`. Initially tried to add a new submodule using the `git
> submodule add` sub-command in the following way,
>
>     $ git submodule add ./foo/bar
>
> This cloned the submodule into a new directory named 'bar' in the
> present directory. This was initially confusing as I expected `git
> submodule` to use the actual directory itself as it resides inside a
> sub-directory the main project and thus avoiding the creation of a new
> clone. Then I came to know that `git submodule` wasn't smart enough yet
> to identify this, by reading the documentation. Then, after realizing
> that I would have to specify the path in the command to avoid the
> redundant clone, I corrected the command without consulting the
> documentation (thoroughly) to,
>
>     $ git submodule add ./foo/bar --path ./foo/bar
>
> expecting that the path needs to be specified after an argument. This
> is what triggered the weird consequence of weak option parsing. The
> output I got for the above command was:
>
>     The following path is ignored by one of your .gitignore files:
>     --path
>     Use -f if you really want to add it.

Yuck, that is bad UX.

> That really confused me pretty much (being a person who doesn't know
> much about how `git submodule` works). Instead of complaining about an
> inexistent option '--path', it considers '--path' to be the <path>
> argument which seems to be bad. It doesn't even complain about the
> extra argument. I also dug to find the reason behind this totally weird
> message. It seems to be a consequence of the following lousy check
> ($sm_path is the normalized <path> argument):
>
>     if test -z "$force" &&
>             ! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
>     then
>             eval_gettextln "The following path is ignored by one of your .gitignore files:
>     \$sm_path
>     Use -f if you really want to add it." >&2
>             exit 1
>     fi
>
>     The lack of checking for the reason behind why `git add` fails seems to
>     be the reason behind that weird message.

(from the man page)
git submodule [--quiet] add [<options>] [--] <repository> [<path>]

When options are given after <repository> or <path> we can count
the arguments and know something is up. (The number of arguments
must be 1 or 2. If it is 3 or above, something fishy is going on), which
I would suggest as a first step.

>     Ways to fix this:
>
>     1. Fix this particular issue by adding a '--' after the '--no-warn-
>     embedded-repo' option in the above check. But that would also
>     require that we allow other parts of the script to accept weird
>     paths such as '--path'. Not so useful/helpful.
>
>     2. Check for the actual return value of `git add` in the check and
>     act accordingly. Also, check if there are unnecessary arguments for
>     `submodule add`.

The second part of this suggestion seems to me as the way to go.
Do you want to write a patch?

>     3. Tighten option parsing in the `git-submodule` script to ensure
>     this doesn't happen in the long term and helps users to get more
>     relevant error messages.
>
>     I find 3 to be a long term solution but not sure if it's worth trying
>     as there are efforts towards porting `git submodule` to C. So, I guess
>     we should at least do 2 as a short-term solution.

Yeah, bringing it to C, would be nice as a long term solution instead
of piling up more and more shell features. :)

Thanks for such a well written bug report with suggested bug fixes. :)
Stefan
