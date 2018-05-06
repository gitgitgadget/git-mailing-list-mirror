Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210A2200B9
	for <e@80x24.org>; Sun,  6 May 2018 04:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbeEFExi (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 00:53:38 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:40161 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeEFExh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 00:53:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id j5-v6so10778596wme.5
        for <git@vger.kernel.org>; Sat, 05 May 2018 21:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xNw6ZCP9vZglbuNI+5xLpYL3eRdOSVCJIbNdpc/JFLs=;
        b=bmg8NIRDTvtdJkQ4sTzvPJGskKoKfbqxVyrILQaglYrssd1edZyZ659HLbt4b+Oq70
         BEMXTTRtD1rm4mec4ixyqY94oSVk4yS8ic/EhkdASqYepDjtk1B39ZdQR4nVH6QG42h3
         mZ2f6K1g7zTOpZ4deHrNQv7kEKt4YMF9ITqfLXa7b1OlVbntQg07SCND+plb+TKAPEFh
         T5EJvWPcLrXbUisocCqN6jowRowLTAg97chi86H0WliU3kJGMtA+iYR3KGabnw+UGemD
         4HDUKhjlxRO0voTWntRoYM0NqehMci5mmSnQTA/cnW7Hi+Wmfr9HmJbJgTJblqhYOOm2
         E5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xNw6ZCP9vZglbuNI+5xLpYL3eRdOSVCJIbNdpc/JFLs=;
        b=UlgTQelSFxql77bxvW2/JiO5QpWOUyf1rywNrpGhp2dLpgyEwYV6dWsGMQCjzCwrzM
         rRaKJ4nSDa9uM+mBEIsXS1FhSKFfGN7c1/ndWPdubOD7nx9N9UP+ISRBAwwyCXHCA3w4
         d1e70kvc2t4aoHSqslpw7SVhji77Rcb7siBaXQCI6gCzDQWpXysDszxb35Y2sqhjGa+N
         2rpvubqHGx1jHJMuJpB9WW+3P/8WA6xmBHuPcX0tACfdnFEDuBO/wWSkoDNZiJ1u9XJM
         LQ31Wc9X6x/G7IuudgzCVAxmZ+IBIDI5vVYAXrwN+3QNHi2CznPBH6wmdBYcu8DYA96w
         ncrg==
X-Gm-Message-State: ALQs6tDj7VQKos1MOB3zwzVT/dRaIxRJuxYR8eeH8MrpC5N0/nMdQvte
        YZraK9eAz8ukkqdSjq9c+STc+rcdHvL+z74ZTSc=
X-Google-Smtp-Source: AB8JxZrLF27Dj8bAs490Pttww4xt5SMGat6GAqLm1mTFpaMrtjbeEbb98/Y+qiTUIVvrV0A0LDTCEKX4VAdCJci92rU=
X-Received: by 2002:a50:ab42:: with SMTP id t2-v6mr34911358edc.133.1525582416409;
 Sat, 05 May 2018 21:53:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Sat, 5 May 2018 21:53:15 -0700 (PDT)
In-Reply-To: <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 5 May 2018 21:53:15 -0700
Message-ID: <CA+P7+xphRqZhwQAutph9RHAYxq=v0Zv9omdaPD3m8oV3KPdRhQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 5, 2018 at 6:05 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> Hi Dscho,
>
> On 05/05/2018 23:57, Johannes Schindelin wrote:
>>
>> > > This builtin does not do a whole lot so far, apart from showing a
>> > > usage that is oddly similar to that of `git tbdiff`. And for a
>> > > good reason: the next commits will turn `branch-diff` into a
>> > > full-blown replacement for `tbdiff`.
>> >
>> > One minor point about the name: will it become annoying as a tab
>> > completion conflict with git-branch?
>>
>> I did mention this in the commit message of 18/18:
>>
>>     Without this patch, we would only complete the `branch-diff` part but
>>     not the options and other arguments.
>>
>>     This of itself may already be slightly disruptive for well-trained
>>     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
>>     `git branch origin/master`, as we now no longer automatically append a
>>     space after completing `git branch`: this is now ambiguous.
>>
>> > It feels really petty complaining about the name, but I just want
>> > to raise the point, since it will never be easier to change than
>> > right now.
>>
>> I do hear you. Especially since I hate `git cherry` every single
>> time that I try to tab-complete `git cherry-pick`.
>>
>> > (And no, I don't really have another name in mind; I'm just
>> > wondering if "subset" names like this might be a mild annoyance in
>> > the long run).
>>
>> They totally are, and if you can come up with a better name, I am
>> really interested in changing it before this hits `next`, even.
>
> I gave this just a quick glance so might be I`m missing something
> obvious or otherwise well-known here, bur why not `diff-branch` instead?
>
> From user interface perspective, I would (personally) rather expect a
> command that does "diff of branches" to belong to "diff family" of
> commands (just operating on branches, instead of "branch" command
> knowing to "diff itself"), and I see we already have `diff-files`,
> `diff-index` and `diff-tree`, for what that`s worth.
>
> Heck, I might even expect something like `git diff --branch ...` to work,
> but I guess that is yet a different matter :)
>
> Thanks, Buga

I like diff-branch, though I suppose that also conflicts with diff too.

Thanks,
Jake
