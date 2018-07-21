Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC75208E9
	for <e@80x24.org>; Sat, 21 Jul 2018 04:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeGUE7H (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 00:59:07 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40597 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeGUE7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 00:59:07 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so17111180ita.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hmPsYUvOZ54KmGDjBggCQL/zwyD5SNaO2ytLJ/HVp/8=;
        b=VPNz/7GFXkPQ1TSCg7Mbwc0vmI5kQyN9HWurEHUbaFLTqWAxiMvusB+O1V+DhOEIfQ
         sidyLVElwZ4gfrdRDiHXIcCAac9qsXR33n08kDldWiiCcbLDWBnZJx4g4u9O6cDw296S
         TeI777Vpc5rbQi2zAQpkHV96MXm8IS7w8+z/v3c1W5TAp1l6e/THigiHSyHhV4W2xzUI
         oWGXB/eeRvi5J4mYK+J4uIwmoGHOUr+bVk6mwDsFi9/tVY3AIjconcR2VmGIJ8aoOC80
         A8QyW9YaXk1K0S62Vl3yvVMGY8uEWSxJRWuxg/3XmzfaR/Xvaolk9x5xysB1B8XEGGx4
         hWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hmPsYUvOZ54KmGDjBggCQL/zwyD5SNaO2ytLJ/HVp/8=;
        b=LexlCdEA29dwL+pxhc3WZHk2W0Aqule25oiwmt9Thg5Py/gI4RzGbLcFLwwaUdoP53
         G07uWzwt+x3fb1g22LymgLe4tk9WFk+OKrq58e33lwKa7Pr5G3fDEJxLZZSTrpyxShou
         n62QwG16iIIA7aZP98uIAKVwPMix4YyYoqBwlzc7SHFW2Hh61svFFryU/iE+j0EzX63X
         d4y+qHrVFSsuYkatpaofjP5zlXVRTXuI+b8tVqBcGx4t+iHc9BYxsU116BxST+Yc+xWS
         zQaMZEZPyOCyzwDUe++u5avhZjWqhgJeCRZirzmTWHslw/h9NJPCpQdx4T0M2fmRGKzi
         T5WA==
X-Gm-Message-State: AOUpUlE+3qcN3W17ScwKBq7RdapeHx+TqPNo3qMM192ocNh3ImyVOAAr
        qoYhdzShvPPtAkIM/lziWLkV1v4/T1J9bxwUJe8=
X-Google-Smtp-Source: AAOMgpcBejW6PIswq8fiCfukPzGaiW9vJMK01Mi7u01hGohxqIFQ3HT3wbUzM4yYdPtl1F893mf8jTK3JiWF0CdSpSM=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr3773867itf.121.1532146074792;
 Fri, 20 Jul 2018 21:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com> <CABPp-BF5O2-DQMSjN67HYsHHYHP_VH-N-C=k796NwPTvtwf7gQ@mail.gmail.com>
In-Reply-To: <CABPp-BF5O2-DQMSjN67HYsHHYHP_VH-N-C=k796NwPTvtwf7gQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 06:07:26 +0200
Message-ID: <CACsJy8Ck7U3m8khFdiKDzYWKk1ZcKyi32RkQ=a=oFQYHd5bruQ@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 1:52 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jul 20, 2018 at 10:43 AM, Elijah Newren <newren@gmail.com> wrote:
> > On Fri, Jul 20, 2018 at 8:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>
> >> This patch provides a better fallback that is
> >>
> >> - cheaper in terms of cpu and io because we won't have to read
> >>   existing pack files as much
> >>
> >> - better in terms of pack size because the pack heuristics is back to
> >>   2.17.0 time, we do not drop large deltas at all
> >>
> >> If we encounter any delta (on-disk or created during try_delta phase)
> >> that is larger than the 2MB limit, we stop using delta_size_ field for
> >> this because it can't contain such size anyway. A new array of delta
> >> size is dynamically allocated and can hold all the deltas that 2.17.0
> >> can [1]. All current delta sizes are migrated over.
> >>
> >> With this, we do not have to drop deltas in try_delta() anymore. Of
> >> course the downside is we use slightly more memory, even compared to
> >> 2.17.0. But since this is considered an uncommon case, a bit more
> >> memory consumption should not be a problem.
>
> Is the increased memory only supposed to affect the uncommon case?  I
> was able to verify that 2.18.0 used less memory than 2.17.0 (for
> either my repo or linux.git), but I don't see nearly the same memory
> reduction relative to 2.17.0 for linux.git with your new patches.
>
> >> ---
> >>  I'm optimistic that the slowness on linux repo is lock contention
> >>  (because if it's not then I have no clue what is). So let's start
> >>  doing proper patches.
> >
> > I'll be testing this shortly...
>
> Using these definitions for versions:
>
>   fix-v5: https://public-inbox.org/git/20180720052829.GA3852@sigill.intra=
.peff.net/
> (plus what it depends on)
>   fix-v6: The patch I'm responding to
>   fix-v2: https://public-inbox.org/git/20180718225110.17639-3-newren@gmai=
l.com/
>
> and inspired by
> https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/, I
> ran
>
>    /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
>
> three times on a beefy box (40 cores, 160GB ram, otherwise quiet
> system).  If I take the lowest MaxRSS, and the lowest time reported
> (regardless of whether from the same run), then the results are as
> follows for linux.git (all cases repacked down to 1279 MB, so removing
> that from the table):
>
> Version  MaxRSS(kB)  Time (s)
> -------  ----------  --------
>  2.17.0   11413236    621.36
>  2.18.0   10987152    621.80
>  fix-v5   11105564    836.29
>  fix-v6   11357304    831.73
>  fix-v2   10873348    619.96
>
> The runtime could swing up to 10 seconds between runs.  The memory use
> also had some variability, but all runs of fix-v2 had lower MaxRSS
> than any runs of 2.18.0 (which surprised me); all runs of 2.18.0 used
> less memory than any run of fix-v6, and all runs of fix-v6 used less
> memory than any run of 2.17.0.  fix-v5 had the most variabiilty in
> MaxRSS, ranging from as low as some 2.18.0 runs up to higher than any
> 2.17.0 runs.

As Peff said, RSS is not a very good way to measure memory usage.
valgrind --tool=3Dmassif would be the best, or just grep "heap" in
/proc/$PID/smaps. fix-v2 should increase struct object_entry's size
and memory usage for all repos, while v6 has the same memory usage as
2.17.0 in heap, and extra once it hits a big delta.

> ...but maybe that'd change with more than 3 runs of each?
>
> Anyway, this is a lot better than the 1193.67 seconds I saw with
> fix-v4 (https://public-inbox.org/git/20180719182442.GA5796@duynguyen.home=
/,
> which Peff fixed up into fix-v5), suggesting it is lock contention,
> but we're still about 33% slower than 2.17.0 and we've lost almost all
> of the memory savings.  Somewhat surprisingly, the highly simplistic
> fix-v2 does a lot better on both measures.

Maybe we should avoid locking when the delta is small enough then and
see how it goes. This is linux.git so there's no big delta and we
would end up not locking at all.

If you do "git repack -adf --threads=3D8", does the time difference
between v6 and 2.17.0 reduce (suggesting we still hit lock contention
hard)?

> However, I'm just concentrating on a beefy machine; it may be that v6
> drastically outperforms v2 on weaker hardware?  Can others measure a
> lower memory usage for v6 than v2?

I'll try it with massif on linux.git, but this is a very weak laptop
(4GB) so  it'll take a while....

> Also, for the original repo with the huge deltas that started it all,
> the numbers are (only run once since it takes so long):
>
> Version  Pack (MB)  MaxRSS(kB)  Time (s)
> -------  ---------  ----------  --------
>  2.17.0     5498     43513628    2494.85
>  2.18.0    10531     40449596    4168.94
>  fix-v5     5500     42805716    2577.50
>  fiv-v6     5509     42814836    2605.36
>  fix-v2     5509     41644104    2468.25
>
>
> >>  If we want a quick fix for 2.18.1. I suggest bumping up
> >>  OE_DELTA_SIZE_BITS like Elijah did in his second option. I don't
> >>  think it's safe to fast track this patch.
> >
> > Okay, I'll submit that with a proper commit message then.  Since you
> > also bump OE_DELTA_SIZE_BITS in your patch (though to a different
> > value), it'll require a conflict resolution when merging maint into
> > master, but at least the change won't silently leak through.
>
> ...except now I'm wondering if the commit message should mention that
> it's just a stopgap fix for 2.18.1, or whether it's actually the fix
> that we just want to use going forward as well.

no fix-v2 is really a stopgap. With 2.17.0 (and fix-v6) we pay 80
bytes per object, or 6.5M * 80 =3D 520 MB heap. fix-v2 increases this
struct to 88 bytes so we pay 52 MB extra.
--=20
Duy
