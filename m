Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FF11F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeAIOTa (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:19:30 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:41552 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeAIOT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:19:27 -0500
Received: by mail-ot0-f180.google.com with SMTP id 5so3458497oth.8
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 06:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3H4EROF7+dpzBmW8tobFRdMkY2BB2R8AlTltvjuZ/M8=;
        b=PTQMiUclcAM2KyxsN6O7KvDwYcWshhT+bZoRuK7BkkGRsCZAYwoYqnowFgLcXtQBBT
         RGH+ZireYdIucc19+riq8LbiRcyKleLJ4ngaKb4WxSGTyhE0UrZQBEbWb5ULGjh5ecTA
         jaqvt2IaMBw3JqeSY+faaWWOGboXNwr/vFWcY84aEAVnGx3FR9i/PtRTO/NSoq3yYpmC
         8uy9CtXYeNSzKynFM+GHijiK8aeekS1SLKIHylGMHd+Vsgw5Fn7e2uZ2xtKsqMOqnlgK
         iGTZBSjCDLaGbpkqrcmpbLofyH8kclkkQccNDc+xqRRMr+iTT8xX9c4+Wu7hjTC1zHQM
         c6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3H4EROF7+dpzBmW8tobFRdMkY2BB2R8AlTltvjuZ/M8=;
        b=mUNTbEEQwoO9C1fI4jOsyc3txH5JH3oD8CWLREC0iEJGLAi+PFxoAgW0yUKjYSw9v7
         En24jyQ9vKs03kRae59Tjuf3bPiWuzxeQDPW5ndaBLvh2vLBKTVbcsX+uYqRc6pjQaJD
         vog2MwZfMpm8DdX8IwtyvNyUEyYRPzqT0IgApDqRgT0MuGgnB9GWzgLQJ5kFVI+32dtv
         dJeDjyhsSfaIuPo0qp7Rm49l07Zr2uOq30MlRHEAb2NvSE4mMS4NiK+FNNUCIQwXtbCG
         XukgsFvJf+t2Dk3OWz13dKfdY8NulFwWLaIzKiTEWeUtGoIBw1mv9EC5TSDbXxgyofiA
         Sh5w==
X-Gm-Message-State: AKwxytesiffd0tMero5Ch77XpZ982VYeg7kO5HbXiRPqxC64Xube/7IW
        xZOHQH6KLpo/g7/PvWo8Mtu2mYzXLlk7HXnt1QY=
X-Google-Smtp-Source: ACJfBosLp0iCBef5Uz9F0IjY835MeUPS4d+cjxJAwWHHqUXfJz7kES8iqHZpqeIVAKmTn8B/EQHAAH5ASgxzpMNadpA=
X-Received: by 10.157.6.136 with SMTP id 8mr1333173otx.174.1515507566319; Tue,
 09 Jan 2018 06:19:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.73.21 with HTTP; Tue, 9 Jan 2018 06:19:05 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801091424170.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
 <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAJs94EYrBgNW-bzoEgy9=fStJW2esoULxfOHX45V63HavqOCpw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801082034470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAJs94Eb0Yf=4Obk6BpifSZaPiw3ArY-01LbTb1nUaM+o2hSayw@mail.gmail.com> <nycvar.QRO.7.76.6.1801091424170.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Tue, 9 Jan 2018 17:19:05 +0300
Message-ID: <CAJs94EaKObUhvNedMmOGWA9SDMH7y-2V7DLkxO=MabddpbjYFQ@mail.gmail.com>
Subject: Re: rebase preserve-merges: incorrect merge commits
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-09 16:25 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Matwey,
>
> On Tue, 9 Jan 2018, Matwey V. Kornilov wrote:
>
>> 2018-01-08 22:36 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >
>> > On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>> >
>> >> 2018-01-08 19:32 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >> >
>> >> > On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>> >> >
>> >> >> 2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
>> >> >> > 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> >> >> >> Hi Matwey,
>> >> >> >>
>> >> >> >> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
>> >> >> >>
>> >> >> >>> I think that rebase preserve-merges algorithm needs further
>> >> >> >>> improvements. Probably, you already know it.
>> >> >> >>
>> >> >> >> Yes. preserve-merges is a fundamentally flawed design.
>> >> >> >>
>> >> >> >> Please have a look here:
>> >> >> >>
>> >> >> >>         https://github.com/git/git/pull/447
>> >> >> >>
>> >> >> >> Since we are in a feature freeze in preparation for v2.16.0, I will
>> >> >> >> submit these patch series shortly after v2.16.0 is released.
>> >> >> >>
>> >> >> >>> As far as I understand the root cause of this that when new merge
>> >> >> >>> commit is created by rebase it is done simply by git merge
>> >> >> >>> $new_parents without taking into account any actual state of the
>> >> >> >>> initial merge commit.
>> >> >> >>
>> >> >> >> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
>> >> >> >> it *does* allow it, but then fails to handle it correctly.) We even have
>> >> >> >> test cases that mark this as "known breakage".
>> >> >> >>
>> >> >> >> But really, I do not think it is worth trying to fix the broken design.
>> >> >> >> Better to go with the new recreate-merges. (I am biased, of course,
>> >> >> >> because I invented recreate-merges. But then, I also invented
>> >> >> >> preserve-merges, so ...)
>> >> >> >
>> >> >> > Well. I just checked --recreate-merges=no-rebase-cousins from the PR
>> >> >> > and found that it produces the same wrong result in my test example.
>> >> >> > The topology is reproduced correctly, but merge-commit content is
>> >> >> > broken.
>> >> >> > I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2
>> >> >>
>> >> >> Indeed, exactly as you still say in the documentation: "Merge conflict
>> >> >> resolutions or manual amendments to merge commits are not preserved."
>> >> >> My initial point is that they have to be preserved. Probably in
>> >> >> recreate-merges, if preserve-merges is discontinued.
>> >> >
>> >> > Ah, but that is consistent with how non-merge-preserving rebase works: the
>> >> > `pick` commands *also* do not record merge conflict resolution...
>> >> >
>> >>
>> >> I am sorry, didn't get it. When I do non-merge-preserving rebase
>> >> --interactive there is no way to `pick' merge-commit at all.
>> >
>> > Right, but you can `pick` commits and you can get merge conflicts. And you
>> > need to resolve those merge conflicts and those merge conflict resolutions
>> > are not preserved for future interactive rebases, unless you use `rerere`
>> > (in which case it also extends to `pick`ing merge commits in
>> > merge-preserving mode).
>>
>> Are you talking about merge conflicts arising due to commits reordering?
>
> Merge conflicts can arise from commit reordering, and they can also arise
> from commits introduced in "upstream" in the meantime.

Then I am totally agree with you.
But initially I said about conflict resolutions and amendments already
contained in existing merge-commits. While rerere can at least learn
conflict resolutions from existing merge-commits, rerere cannot learn
and recover manual amendments.

>
> Ciao,
> Johannes



-- 
With best regards,
Matwey V. Kornilov
