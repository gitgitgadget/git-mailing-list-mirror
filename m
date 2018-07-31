Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E6E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeGaRu0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:50:26 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:42457 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaRu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:50:26 -0400
Received: by mail-ua0-f180.google.com with SMTP id w7-v6so10645130uan.9
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oqjp+h5Nr1E1q7+NMFV3mdwNZCOYjsp0r/2hn9ZRl5I=;
        b=ZyXSC61QsY/7wAQtVkcrkNQLpnA4Z42BPQkD/nDRNWh4QvlHTFB6FOnj/4bIQ21Wvu
         wdnTTuP7vpd3xsnYZV4slKtvWSRb6BfUI4sbvRNHsFBTR0Q2tEJw81JIGy6k2cLCVJcG
         VrCX0i2AE4K29FAYxo99hFjUX8rZr9d/GUd0/bhPIeWNSM2IXoQiYqSw1ceHskxI5wPz
         usDJplXTfTkSAW3ZkoNoMFSnH2RKE3NV9nAl2DCJ3YBhO8AUNkeOsaPcHtdPYPXtJNiv
         yjGgwaA12T9/UBGqyhMtW5bff9EKPVSp6KRPEYcPmO6pmtRhn3UOKGdK3oK2OvLLYYt8
         gfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oqjp+h5Nr1E1q7+NMFV3mdwNZCOYjsp0r/2hn9ZRl5I=;
        b=WjBZcSXpLAdYME7pVYgmalu3Eu9GDws7HlBzZbttepojPnv2QnMpPEiIc9W852ZYhI
         KyntH8e1YHGGncSc6sz6K9NY4i94uXN2kdVl+xbJtQaf49NSLvfxlJHqvbHfv5kK+jv2
         qQF4rDvwK8zjDqmVWbHaEsLhqI7WHwmdsx2M6gkvSRl5x69+h/viWLe1AIUM6kRGCBWn
         nQm2Y2RJTw5qFvBDB1tC9UfvOziAd1qxY+CVCx61lEW5db1Ks/yL5fvY3ZwUT2F24R6P
         fRbmVYa9bIgUVHLse/g2P23amYNM0OqBQ5+wehAMCmunThPwj//Q0qK68cTI6u0IGEL2
         tm5A==
X-Gm-Message-State: AOUpUlGBDi8adRy8Z+6m2xWT/chXiTieF9v44O2UegZ5kAuQDKaLjzte
        Y/rQYtKSO7paminKIPfp2Y8/BQHKNszlEneHixrw9g==
X-Google-Smtp-Source: AAOMgpeY51Ea6KIJuKbiJ5S9Cdt9S5nt/YLwHfxN5Gwdb5uc/qoffQ820o+peli+BuZCdm6KCY8i8JQ8qvSljOttNU8=
X-Received: by 2002:ab0:66d4:: with SMTP id d20-v6mr15716943uaq.112.1533053365086;
 Tue, 31 Jul 2018 09:09:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 09:09:24
 -0700 (PDT)
In-Reply-To: <CAGZ79kYnfJXRiLnx8oq9mZYrzfBa-79URn+j4QtsFu3d07Jyog@mail.gmail.com>
References: <20180730155950.17329-1-pclouds@gmail.com> <CAGZ79kYnfJXRiLnx8oq9mZYrzfBa-79URn+j4QtsFu3d07Jyog@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Jul 2018 09:09:24 -0700
Message-ID: <CABPp-BEAmjx0e8AFHdPChR6LcUAyTVGHY7hAMHUiykX90kvnHg@mail.gmail.com>
Subject: Re: [PATCH/RFC] Color merge conflicts
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 10:40 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Jul 30, 2018 at 9:00 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>>
>> One of the things I notice when watching a normal git user face a
>> merge conflicts is the output is very verbose (especially when there
>> are multiple conflicts) and it's hard to spot the important parts to
>> start resolving conflicts unless you know what to look for.
>
> I usually go by git-status, but I am not the watched normal user,
> hopefully. Maybe we want to run git-status after a failed merge
> for the user, too, though?

I'm a little worried the git status output may be long enough that
they miss all the conflict messages and don't even think to scroll
back and look at them.  Since not all conflict types are nicely
representable in git status output, that could be problematic.  (e.g.
renames aren't recorded in the index in any fashion, so git status
can't tell you a conflict was from a rename/delete or
rename/rename(1to2), for example; it's possible that information may
be important in helping the user track down why the working directory
ended up the way it did to help them resolve the conflict.)

If that extra information that is currently only reported in these
conflict messages were recorded somewhere -- either the index or the
working tree -- then it wouldn't be as much of a risk to hide it
behind git status.  In fact, it would seem safer and nicer in general
because users already run the risk of losing those conflict messages.

>> This is the start to hopefully help that a bit. One thing I'm not sure
>> is what to color because that affects the config keys we use for
>> this. If we have to color different things, it's best to go
>> "color.merge.<slot>" but if this is the only place to color, that slot
>> thing looks over-engineered.
>>
>> Perhaps another piece to color is the conflicted path? Maybe. But on
>> the other hand, I don't think we want a chameleon output, just enough
>> visual cues to go from one conflict to the next...
>
> I would think we would want to highlight the type of conflict as well,
> e.g.
>
>   <RED> CONFLICT> <RESET> \
>   <BOLD;RED> (rename/rename): <RESET> \
>   Rename a -> b in branch foo \
>   rename a ->c in bar
>
> but then again, this patch is better than not doing any colors.
>
> I wonder if we want to have certain colors associated with certain
> types of merge conflicts, e.g. anything involving a rename would
> be yellow, any conflict with deletion to be dark red, regular merge
> conflicts blue (and at the same time we could introduce coloring
> of conflict markers to also be blue)

Providing extra hints might be good, but we'd need to flesh out this
idea to avoid edge and corner cases...

What do you do with mixtures, e.g. rename/delete conflicts?  Average
the colors?  Colorize the "rename" differently than the "delete"?

Also, by "regular conflicts" I think you mean the normal content-based
conflict markers we stick in files, rather than path-based conflicts
(like modify/delete or rename/add).  However, something could be both
-- e.g. for an add/add conflict we two-way merge the files so we have
both a path conflict (both sides added a file with that name) and a
content or "regular" conflict (most the files were the same but they
differ on these lines...).  Things could get even crazier with e.g.
rename/add/delete or rename/rename(2to1)/delete.  So, if you want to
colorize regular (or content) conflicts differently than path-based
ones, what do you do when you have both types present?  Does one win?
Do we print multiple conflict messages?  Something else?

> (I am just making up colors, not seriously suggesting them)
>
> I like the idea!
>
> Thanks,
> Stefan
