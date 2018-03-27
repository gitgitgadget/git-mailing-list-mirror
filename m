Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A251F404
	for <e@80x24.org>; Tue, 27 Mar 2018 06:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeC0GBZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 02:01:25 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:42862 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeC0GBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 02:01:23 -0400
Received: by mail-io0-f177.google.com with SMTP id d5so26082482iob.9
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rfjpoJF09y2C9ipN4A4YQ6R8TR4l+xLOdt1ZQnJCl0g=;
        b=QiyRpAx7eQ0JT6fKBVCSGwKPiEa5Hl529/x8/zui7HeHtYVIxfXDOwIz+rLduW6Myo
         Jdh6xAtc1js9LnMTPRwUxULyaOjtyM63yWXU88UUshrKf4KsA4OueR5nzIrrs8oPMh3X
         Cr+F3mYpYMWKt+ulKPhxIPJtyy3o0DMCLk7WlUl+X/+5J+UOsXtN29ijCUhusMmSTAYp
         /neeOqOV7gu9DWWz1O5nsmv+dR72RlXW50X2aiqsTX8+gGvoeQb7vieASdnjPwFyjIWG
         iBTqs3yQcmGPPBh6Ogd8Dk9MSUL4dSIW3GWk69H/UlMFrqxvI/jjB9DYBgIxOtV7LY+z
         umVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rfjpoJF09y2C9ipN4A4YQ6R8TR4l+xLOdt1ZQnJCl0g=;
        b=fkpYRRqrp6dMriiErDoDmNowNGTgbRSKE3WlAliWWMxCubVXtkEA4SJBiErV7vxHGJ
         cskYsnrD5YsVE2E6jz+kaZcs1gB9B03VtvraYXdVBFO3O5WQRD0q0mSjsiXPcIJMtUqB
         /uh9Z0KGNR3/m2wJre4d0Lr7B42QgorGYrgVe6lYpfWUlBPTk9ddxxmt1mkEbJkY05XU
         f+KRSVy1hi9GxozLgzwEUQjIVkxWD2EHe5d6AArhgDN9unnnTLCOV3BZ12dlcmaXZmGk
         cqAr1MF+5MwFax4UuWMlh2lfn5fLZHwZrBriSUyfZd4/JhMDqIlDdiXlSn9si0mqDBKx
         0f6w==
X-Gm-Message-State: AElRT7FcQ9g7HiLyo95+wYPJHKSxzKgaVHjWsDrCYHAIKV250/SvlXQc
        ORuBsy1ljyqLLZmr9Mxx0B0HpS+GRzsezwOSHEY6lkSQ
X-Google-Smtp-Source: AG47ELtbZaDd2nSOJo9Cu2j5kawKKWdJkpC7zA+hvj/2u+GP+IBtxyE5H3Q/ug9fWfROjQz4sQF0ZvQRaoxX2IkQ7oc=
X-Received: by 10.107.150.19 with SMTP id y19mr32019794iod.272.1522130482707;
 Mon, 26 Mar 2018 23:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Mon, 26 Mar 2018 23:01:22 -0700 (PDT)
In-Reply-To: <CAA6PgK7L04VoHT7A8M_mwq5kA+9BiQxrd6iPjPHOpa4=Z3futw@mail.gmail.com>
References: <CAA6PgK7L04VoHT7A8M_mwq5kA+9BiQxrd6iPjPHOpa4=Z3futw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Mar 2018 08:01:22 +0200
Message-ID: <CAP8UFD3TPfWtpT8RLGBL2V+M+nkpGEYVa8Y_c68u4Lw4zPyW5g@mail.gmail.com>
Subject: Re: How to `git blame` individual characters?
To:     Jan Keromnes <janx@linux.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 27, 2018 at 2:18 AM, Jan Keromnes <janx@linux.com> wrote:
> Dear Git developers,
>
> I'd like to understand what would be required to run `git blame` on
> individual characters instead of full lines. Could you please point me
> in the right direction?

You might want to take a look at cregit
(https://github.com/cregit/cregit) and maybe at other work from the
people who developed it.

There are links related to this tool in:
https://git.github.io/rev_news/2017/05/17/edition-27/

> Someone asked a similar question about "Word-by-word blame/annotate"
> on StackOverflow a few years ago, and one of the replies said:
>
>> Git tracks changes snapshot by snapshot. The line-based format is calculated on-the-fly, and it would also be possible to have a word-based format.
>
> Source: https://stackoverflow.com/q/17758008/3461173
>
> This leaves me hopeful that a character-based format can somehow be
> achieved. Here is a fake example to illustrate what I'm looking for:
>
>         $ cat myscript.js
>         for (int foo = 0; foo <= 11; foo++) { console.log(foo); }
>         $ git blame --character-based --pseudo-json myscript.js
>         [
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": "for (int " },
>             { "commit": "bcd1234a", "summary": "Rename iterator",
> "characters": "foo" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": " = 0; " },
>             { "commit": "bcd1234a", "summary": "Rename iterator",
> "characters": "foo" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": " <= " },
>             { "commit": "cd1234ab", "summary": "Go up to 11",
> "characters": "11" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": "; " },
>             { "commit": "bcd1234a", "summary": "Rename iterator",
> "characters": "foo" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": "++) { console.log(" },
>             { "commit": "bcd1234a", "summary": "Rename iterator",
> "characters": "foo" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": ")" },
>             { "commit": "d1234abc", "summary": "Add missing
> semicolon", "characters": ";" },
>             { "commit": "abcd1234", "summary": "Implement loop",
> "characters": " }" }
>         ]
>
> What would be the most direct way to achieve such a character-based
> blame/annotate? Should I write some sort of Git extension, or hack
> into Git's source code?

I think the "Token-based authorship information from Git" article
(https://lwn.net/Articles/698425/) is about that.

> E.g. I looked for an option in `git-blame` or `git-annotate` to change
> the "next line boundary" from "carret return" (line-based blame) to
> "any whitespace" (word-based blame) or "character-by-character"
> (character-based blame), but I didn't find it. Could this be
> implemented in `blame.c`? If so, which methods would need tweaking?

I don't think this is implemented in Git. Do you really need that in git itself?
