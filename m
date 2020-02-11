Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AAAC352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A03820714
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeAdF0BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBKCfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:35:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35160 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgBKCfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 21:35:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so2894860edv.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 18:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qb1pkDwgGRVUFfNBCHS/qwscoALakfS2vGYQu42Ei2I=;
        b=CeAdF0BDDfVt7SoK+/IJdugBXNKAT5LvbUoRzMSTOqjldjCNmp44taGqfsKA8f1tkl
         61Yat5vEg+LIRV63Q1R00KK9fCwwczXa/VfvFIyarvUovHFHChkU6UEkBaj+c7gdgWTU
         vR+w/8P9WRm6+nIoLU7uGprNjtXgo8xU00XAaRQwCDt5kC0qQZ2O6MkQMbXCvLxqM8De
         +FQnvxIieNID+ylKjFzIFcmV46jmt22txdA9f4GLLQlbPsuhZws3AG4Bd1ZskXi8ovVL
         UV8NVtUKtdT6vUI3w6Escx+c4BuPUuE5nbPabJO+xMCHNpLliqdGeWbw3RdsRwhhKMqH
         hsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qb1pkDwgGRVUFfNBCHS/qwscoALakfS2vGYQu42Ei2I=;
        b=T8uq5bPZTWzmAHG948xhVmGIgKPigtyAxf5U3BlYHViRlkPKr40zCRkHkt2qofEVP9
         kBVCH/0Bkzb2WBdam8hvTsXkX2zJ6xRdjztRzFvI8ndU+pX8+kYorjS1n4b63YaNz4b6
         6zEGv0OUWFAxsl5gJaB+2dlHZoYZYSTRkuD/j69xwit4MFmtO4R8+bPIfeRcQ1GM6wUv
         847FZj8XOhm+HN8w9QHEpc33nYCG37AUBXrsL9ZfUNiMTWCudTTeaDtc1XcZxHf0GIzx
         yKAVc2ihDuj58bAfxPorab1jFI+r/s42XxyKoPqAqDhmY9wNR1ODxLnjegAx27phBA/8
         pUUQ==
X-Gm-Message-State: APjAAAUwBXCTN9NfSMf51pUIqeKIcPIM83rvQnaPfy+PzpuEob1WweGN
        VAieDolEBqruMhFVeZ2opNrJdnVFR3KNteT/gi4=
X-Google-Smtp-Source: APXvYqzW/reVKRqWw1I5C41gQxWYSO12uw+bEliVimbEWxVBL8ir+AVRSvcMFX4cdBu+12lzUvoLZyZnjw+mvegX1uY=
X-Received: by 2002:a17:906:22cf:: with SMTP id q15mr3815941eja.77.1581388513505;
 Mon, 10 Feb 2020 18:35:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <20200210203725.GA620581@coredump.intra.peff.net> <20200210225528.GD190927@google.com>
In-Reply-To: <20200210225528.GD190927@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 11 Feb 2020 15:35:02 +1300
Message-ID: <CACg5j262pndH=-WdnxtRs63evL8DKvx5w2T0G2-R4LdjZBRf_g@mail.gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 11:55 AM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Mon, Feb 10, 2020 at 03:37:25PM -0500, Jeff King wrote:
> >
> >      instead. Using string literals is more accident-prone than
> >      variables (because the compiler doesn't notice if we misspell them)
> >      but I think is OK for cases where we just refer to the key once.
> >      For others (e.g., advice_commit_before_merge has 13 mentions),
> >      either keep the variable. Or alternatively make a wrapper like:
> >
> >        int want_advice_commit_before_merge(void)
> >        {
> >                return want_advice("commitbeforemerge");
> >        }
> >
> >      if we want to drop the existing mechanism to load all of the
> >      variables at the beginning.
>
> I tend to disagree on both counts. I'd personally rather see something
> like 'void advise_key(enum advice, char *format, ...)'.
>
> As I understand it, Heba wanted to avoid that pattern so that people
> adding a new advice didn't need to modify the advice library. However, I
> think there's value to having a centralized list of all possible advices
> (besides the documentation). The per-advice wrapper is harder to iterate
> than an enum, and will also result in a lot of samey code if we decide
> we want to use that pattern for more advices.
>

I think Peff is suggesting the wrapper for only those rare cases where
a single advice config variable is being checked several times around
the code base, but this doesn't mean we'll have many of them. In my
own opinion, I don't see the need for the list of advices, I think
it'll add unneeded complexity to the advice library and the
introduction of new advice messages. Mainly because I don't see a
scenario where we'd need to iterate through them, so I don't know ...

> (In fact, with git-bugreport I'm running into a lot of regret that hooks
> are invoked in the way Peff describes - 'find_hook("pre-commit")' -
> rather than with an enum naming the hook; it's very hard to check all
> possible hooks, and hard to examine the codebase and determine which
> hooks do and don't exist.)
>
> When Heba began to describe this project I had hoped for a final product
> like 'void show_advice(enum advice_config)' which looked up the
> appropriate string from the advice library instead of asking the caller
> to provide it, although seeing the need for varargs has demonstrated to
> me that that's not feasible :) But I think taking the advice config key
> as an argument is possibly too far the other direction. At that point,
> it starts to beg the question, "why isn't this function in config.h and
> called print_if_configured(cfgname, message, ...)?"
>
> Although, take this all with a grain of salt. I think I lean towards
> this much encapsulation after a sordid history with C++ and an
> enlightened C developer may not choose it ;)
>
>  - Emily
