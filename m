Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8C520248
	for <e@80x24.org>; Mon, 18 Mar 2019 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCRSwK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 14:52:10 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:39609 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRSwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 14:52:09 -0400
Received: by mail-ua1-f42.google.com with SMTP id m11so2683848uad.6
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yEjjp85VQJJgh2IbDYmQKnmGkctKHTlaRP/i96H6esA=;
        b=QmaqpqYLjYi4IEOPB4Vt38OXRbyWWHW7+tO0QZTnNS55tuILLmZTNoLNoEvoU9pVZX
         qS0hrzZbIVafKslBGhvy/fwL1qwSlgpG0xcQPdI2ayBOfW2+mUNCVoCuQLu5nZ0swwfn
         KUPyrrB/PWlP9DoeW6J+ks6Gtw8ZZp4LHEV+kcVeSF+V8T2tle/xo22REAGYadwTfNBj
         wg7zMfFx0z2lxBm/TMxXY90piqcmcHQFwt6EORAzq/JMCpLN1cLbivH1tl1e/O6FgWxG
         9PPdAMQt9pwQV/WtD7aYFIr2RU/EZSWjBYIBpahXsb4D8ujQxl46uMK9jRRHggWficCC
         t7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yEjjp85VQJJgh2IbDYmQKnmGkctKHTlaRP/i96H6esA=;
        b=KqhF+A1q84zPFx2Xr7ug2XhrgSosPkh/iG/s6EkakYVeS5Dfe+MeFwrTpyX3RFp62c
         smFrS9xw0/JS3QxDls0I5OOjOfv5DoVQccYPFMvcwgH7D/oiCPwVlUag72xjlnUJcYYF
         L/9+p5DxIqHXGQm/1OQa98CLSeqxG5rs2XMjoLVKbkTzEniRedxx9ERgwuNuYMYHuCUF
         XTAZvcVvLZbFtqlVKe85jLHNK+WdrsvA0UGw3IaiBiLRdSmR3YL4GYbw4af8OBb3w1QR
         790Y2eePG4Got2F9LeieP7b2hYGgeztfc8NHmRD+R9FPgGOyPXgnh2V8Yz/RkpPtfzHB
         6Jsw==
X-Gm-Message-State: APjAAAWGil5vAHObrc8yyyrzMF2sMgVDA8Sd/wsRWYsz+QVli8HZmafe
        fUFFbcaVrcXORlrIdYAK0FzLIm30HMImv2l+dFI=
X-Google-Smtp-Source: APXvYqzenTeByx27RYo5UGRKH2f6Tt8x9DyV32HTnvAM3/LovRZk5wC41EnWD+xCHA8LrR2TOkfPfKzGj/T5COufS+8=
X-Received: by 2002:ab0:6144:: with SMTP id w4mr6315918uan.135.1552935128517;
 Mon, 18 Mar 2019 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190311093751.GA31092@archbookpro.localdomain>
 <xmqqmum0h88n.fsf@gitster-ct.c.googlers.com> <87va0orop4.fsf@igel.home>
 <87wol3bydp.fsf@evledraar.gmail.com> <CABPp-BHMi=RTWAVjuORdTWY3ijp4EKhy2QAH0=WrviCiotJtyw@mail.gmail.com>
 <20190318181144.02dea38f@kitsune.suse.cz>
In-Reply-To: <20190318181144.02dea38f@kitsune.suse.cz>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Mar 2019 11:51:56 -0700
Message-ID: <CABPp-BHcTTXZDbP00e-5O3ESV420HPjYUO0sQMvYmMTd1No1vg@mail.gmail.com>
Subject: Re: Deprecating git diff ..; dealing with other ranges
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 10:11 AM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Mon, 18 Mar 2019 10:07:08 -0700
> Elijah Newren <newren@gmail.com> wrote:
>
> > On Tue, Mar 12, 2019 at 2:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > > On Tue, Mar 12 2019, Andreas Schwab wrote:
> > > > On M=C3=A4r 12 2019, Junio C Hamano <gitster@pobox.com> wrote:
> > > >
> > > >> I however think it may be worth making sure that our docs do not
> > > >> encourage "diff A..B" and teach "diff A B" when comparing two
> > > >> endpoints.  That can be done without changing anything in the code=
.
> > > >
> > > > The nice thing about "diff A..B" is that you can c&p the output fro=
m the
> > > > fetch run without the need to edit it.
> > >
> > > Not to shoot down this effort, just to add another similar thing I do
> > > regularly for ff-branches:
> > >
> > >  1. Copy/paste A..B fetch output
> > >  2. git log A..B
> > >  3. ^log^diff
> > >
> > > I.e. I just need to tell my terminal to re-run the same "log" command
> > > with "diff" instead of "log".
> > >
> > > Of course as covered in the linked thread it doesn't work for some
> > > (non-ff) cases, and I'll sometimes end up cursing it and swapping aro=
und
> > > ".." for "..." with log/diff.
> >
> > Doesn't this somewhat imply that although you use diff A..B here for
> > convenience, that it's actually wrong since what you really want is
> > A...B?  Or said another way, the end goal of deprecating "diff "A..B"
> > then later reinstating "diff A..B" to mean the same thing as "diff
> > A...B" would actually be better even for your usecase?
>
> I usually mean diff A..B in this case.

Thanks for the feedback; somewhat odd that you and =C3=86var have the same
usecase but want the opposite meaning, but good to know nonetheless.
