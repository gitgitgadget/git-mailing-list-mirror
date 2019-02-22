Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748A81F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfBVJwm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:52:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37222 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfBVJwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:52:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so1346037wmg.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SnpIeZi4pGC8IOMzbUuKGKeZARg1h9mFP2Eua9weirw=;
        b=QFzz2nmhgY9U2Ce3msmDmKUo8aGGlPoSVYlGJcBwC6v4u2z0IcSCP270F55FaENp+1
         oCDGOVjzWU5p32ymxl8bEKvA975eLLTLGakX8kjj3hDWGCQFTBIEOUGqBmC2wz+pT1zA
         N4yeFFdkfXrCK/fX5ee/Kje0PEUhaSHnef0WBgcu7B+FKTWRpQmky3ErOMz+2lLV3pT+
         eLW4yrSseFCtJe1dW4JPyC1UNkzPTwFMcnxSUYqPTRSSJEF9B57AwV27vsar2IVuu0WZ
         Koz0erJQqi8tHZlZPoSzx8YDocRq+dGQCcvYGgMDVpZsZHPGzDZSdUuigISk8JwkVeZ0
         R9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SnpIeZi4pGC8IOMzbUuKGKeZARg1h9mFP2Eua9weirw=;
        b=oCVuNM/1LIB0nxCr7HzboF/4W+Nc3FflWmchZVNcj37sKCScS0YVchKSAn4/rd967v
         JzJfB03G23y1mClrKdwK2V1QyozPxz3Uggr7pF4jy6BBRaN8CtMIzDggQekc4owXkyLJ
         7Ka6EeLWkdQjNHodVBaeKqancuQRn8jB/wiSoGPKv4uX1zf7pbN25CDKFyZF2yytgY2v
         oih6byG/lB4ds+/PoROXVLVHHwmKr1yQ3fu1W4xinlqLnk4zqNxKi6AG4cV9/tuBqBHv
         COPolI9QtvEWdYD82jy8220OYWe7246UAdeoF3CHrtRdF14aTw2glEfADdTVl2JNZY4i
         b0LQ==
X-Gm-Message-State: AHQUAubJTMm1qkCo8QKhjEDfeq73bGJ1pJ0SiA0bbSrBBF6RtNJC3LYj
        mIAA8c67958lSJnozGJpk0s=
X-Google-Smtp-Source: AHgI3IbyIrWXDW0kUiMtNkrFR1jdfW9x1tMVYzgkEtJWDV7ZuTYYufmYAKJVwaVn08F4ApzM48inIA==
X-Received: by 2002:a1c:f901:: with SMTP id x1mr1894308wmh.84.1550829159858;
        Fri, 22 Feb 2019 01:52:39 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u134sm713482wmf.21.2019.02.22.01.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 01:52:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Ideas for even more compact fetch.output=compact output
References: <20190125095122.28719-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190125095122.28719-1-pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 10:52:38 +0100
Message-ID: <875ztc5evt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 25 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> I have a remote named "jch" and it has a branch with the same name. And
> fetch.output is set to "compact". Fetching this remote looks like this
>
>  From https://github.com/gitster/git
>   + eb7fd39f6b...835363af2f jch                -> */jch  (forced update)
>     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
>   * [new branch]            nd/diff-parseopt   -> jch/*
>   * [new branch]            nd/the-index-final -> jch/*
>
> Notice that the local side of branch jch starts with "*" instead of
> ending with it like the rest. It's not exactly wrong. It just looks
> weird.
>
> This patch changes the find-and-replace code a bit to try finding prefix
> first before falling back to strstr() which finds a substring from left
> to right. Now we have something less OCD
>
>  From https://github.com/gitster/git
>   + eb7fd39f6b...835363af2f jch                -> jch/*  (forced update)
>     6f11fd5edb..59b12ae96a  nd/config-move-to  -> jch/*
>   * [new branch]            nd/diff-parseopt   -> jch/*
>   * [new branch]            nd/the-index-final -> jch/*

This patch works great. The existence of fetch.output=3Dcompact had
somehow passed me by until a few weeks ago, now using it and it looks
great. Thanks.

Just using this as a bounce-off point for a related discussion, one case
where I still see duplicates is things like:

    From github.com:git/git
       a7da99ff1b..28d0017056  next                -> origin/*
     + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced upd=
ate)
       a7da99ff1b..28d0017056  refs/pull/412/head  -> origin/pull/412/head
     + 1dbcd06490...6b1f08d3ef refs/pull/412/merge -> origin/pull/412/merge=
  (forced update)
     + e911e946c2...9cc6aca6e9 refs/pull/444/head  -> origin/pull/444/head =
 (forced update)
     + 8131760e3b...ed5bbbbcec refs/pull/444/merge -> origin/pull/444/merge=
  (forced update)

I.e. the duplicate strings for the "pull" namespace I'm fetching.

Now, there's no room with the current syntax to represent that
unambiguously, I started to patch it, but wasn't sure I liked the syntax
I came up with.

This is also one of the rare cases where bikeshedding the idea can
productively done without a patch so I thought I'd start that discussion
first.

If we had this:

    From github.com:git/git
       a7da99ff1b..28d0017056  next                -> origin/*
     + e911e946c2...9cc6aca6e9 pu                  -> origin/*  (forced upd=
ate)
       a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
     + 1dbcd06490...6b1f08d3ef refs/[pull/412/merge] -> origin/*  (forced u=
pdate)
     + e911e946c2...9cc6aca6e9 refs/[pull/444/head]  -> origin/*  (forced u=
pdate)
     + 8131760e3b...ed5bbbbcec refs/[pull/444/merge] -> origin/*  (forced u=
pdate)

We could de-duplicate such output. I.e. used [] as "capture" delimiters
for the subsequent "*" since "[" and "]" aren't valid in ref names (but
"()" and "{}" are!).

Or maybe more generally using it consistently throughout, also for next/pu:

    From github.com:git/git
       a7da99ff1b..28d0017056  [next]                -> origin/*
     + e911e946c2...9cc6aca6e9 [pu]                  -> origin/*  (forced u=
pdate)
       a7da99ff1b..28d0017056  refs/[pull/412/head]  -> origin/*
    [...]

The things that suck the most about this are that you can no longer
copy/paste the ref on the LHS as-is, and that it'll only show up in rare
cases, so it'll probably confuse even experienced users.

What do you think?
