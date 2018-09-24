Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5501F453
	for <e@80x24.org>; Mon, 24 Sep 2018 23:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeIYFYM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 01:24:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38387 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIYFYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 01:24:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so9000443ybb.5
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 16:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWNnHmHpTCkza6fYrzsTlhhJg9HEuVKDneZ466nGx1A=;
        b=IdjaGwJgLTONGIag1yMlLGRKn0wLSWNv13q5hpl1DkIHks5VdY3Pj2yvjiY3KinZ1b
         /4PLVGOl9IM+IDnSJIsTgKKUhqxkGCxBESwkmvX0Mn1GZpZxcV1Ez8dQumCaEfgb+b/7
         kF2yFdEAQETZnPYpAOMjE0nZC8vGrp/yfvhpIHUGLeE3fEGAd0iI8XYYZIIpL7sSPrwm
         ScroJMTz59tbYJGHcLbwkCX14R9q1d2vkPhw2d9sG4eA23BrPBQQAoXMGPOkFmM/yytR
         Yja5gyO4TkGPzNurjkD/oU+Vl8VX4VQYW1Hwrl7Xuko6c7J2JDqi1cgKjERcvLseqfvx
         0J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWNnHmHpTCkza6fYrzsTlhhJg9HEuVKDneZ466nGx1A=;
        b=Y07o7PnIxHLhGw9MCK6NmF8/p3TIzvk8eUfYc03QZy8VLoG8KoLfvXKHluKTghaZh9
         iH0cj3y40i0ezNp3Ft6gKNJJYM4hsX9SenfJvWeqlxXkgC9g/762/nEYbo59+ndFecfe
         4DHBFQ/djbIoSqsdHujg4z8XZa3CYRvwY361QXS991FnKF9GDoQTxGWvP/1GXFD1Js8Y
         RYZ932uH20HL8L/GJPpGx5giYwTUflgL6NWH5bC6FuqgE1guMmlou8vSqoZw6FEeb6V1
         4TL0Od2E2UHk64UUo2Me7PEy+Zk56BofQP546NPwjmtzM8bFGTUXoedrERTWHEuXNlmi
         C/Aw==
X-Gm-Message-State: ABuFfoi0ewZmL+pFVGOxk+aYaTg37WUqJyIjw1GDSwqzVVGNgNejQRPp
        0P2NFDS1jf4fIeQHcWO5tUnXAJ1yOl3mIZkqPfqh1Gk8JJErzg==
X-Google-Smtp-Source: ACcGV63HaHAKJBcomlQH9lYUOi5nFkI7PKgad3ZLQxJ0jZyYNWcuVl5/jNGIg3GOWM02K19SI4FxtZHmDnojauTc5FM=
X-Received: by 2002:a25:908f:: with SMTP id t15-v6mr520222ybl.201.1537831176742;
 Mon, 24 Sep 2018 16:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net> <20180924100604.32208-2-phillip.wood@talktalk.net>
In-Reply-To: <20180924100604.32208-2-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 16:19:25 -0700
Message-ID: <CAGZ79kbFwfFBT9auh-KYwyHVnVX9hyBO3h7=P7-GcmE-4JOA4w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] xdiff-interface: make xdl_blankline() available
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 3:06 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This will be used by the move detection code.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff-interface.c | 5 +++++
>  xdiff-interface.h | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 9315bc0ede..eceabfa72d 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -308,6 +308,11 @@ int xdiff_compare_lines(const char *l1, long s1,
>         return xdl_recmatch(l1, s1, l2, s2, flags);
>  }
>
> +int xdiff_is_blankline(const char *l1, long s1, long flags)
> +{
> +       return xdl_blankline(l1, s1, flags);
> +}
> +
>  int git_xmerge_style = -1;
>
>  int git_xmerge_config(const char *var, const char *value, void *cb)
> diff --git a/xdiff-interface.h b/xdiff-interface.h
> index 135fc05d72..d0008b016f 100644
> --- a/xdiff-interface.h
> +++ b/xdiff-interface.h
> @@ -45,4 +45,9 @@ extern int xdiff_compare_lines(const char *l1, long s1,
>   */
>  extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
>
> +/*
> + * Returns 1 if the line is blank, taking XDF_WHITESPACE_FLAGS into account

presumably in the flags field.

> + */
> +extern int xdiff_is_blankline(const char *s, long len, long flags);

We also have
    int ws_blank_line(const char *, int, int)
that looks very similar, but works slightly differently.
grep.c has
    static int is_empty_line(const char *bol, const char *eol)
    {
       while (bol < eol && isspace(*bol))
       bol++;
       return bol == eol;
    }

pretty.c also has a is_blank_line() (and some stale comment in
that file refers to it as is_empty_line, 77356122443
(pretty: make the skip_blank_lines() function public,
2016-06-22)

Would we be able to unify all these down to one or two
functions? (Maybe all can use the new xdiff function?)
It seems as if we're reinventing the wheel a couple times
in our code base.

Stefan
