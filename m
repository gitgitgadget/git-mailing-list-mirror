Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9761F461
	for <e@80x24.org>; Fri, 28 Jun 2019 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF1OQv (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 10:16:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38319 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 10:16:50 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so12835404ioa.5
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZMzwJ3IUCH5/w0ZXQbN9g77LNXqTtZAZIpxGBHD94k=;
        b=l+LO3aSX0/JBUBW+sMzIhyd8sMYGC/c4Q3i3PhfmK4byQENBl0TyVkSMRWYsXw26Iy
         XWuQA0DPSpNyXXqGncd4SF2hnUkr3XKoL4IEveIsl+0xCjNKmTJfscJo75vu9B21Hicr
         ToWFYhfTaRivYLUYqcbzHml5iRdpbLpU8gXf6MsfjJ7VBvxMQqMydYaK7giw9+JZFtJw
         OBWMgVEmxOdmEmlss9mIguEQ1YkHolzAcr4oL9xIfZxlTm6MOHgzhektw8ZouqChfQTw
         99dC24PcHwiVfVyoOA2lLibEoKyjogD7FeeGdRoLa3iITAi6SiNVL9Cxd4DlDOSUDYYs
         Ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZMzwJ3IUCH5/w0ZXQbN9g77LNXqTtZAZIpxGBHD94k=;
        b=croDq9bEP7IzHTs/P6IHM0iLwQ5BNC3Y5AhnAz7gGnBBcSpTJjUL4unLGGmzma+9xA
         dOD6J7eRDJ2piPg7QjhzPSIqlcEls0lxQvHurIfIiUpISzJXfxkMNX+pRRpIGh8H7q7Q
         LnbGZ5zRQGL7bUlHVCn8jWZGr9/7P/1KASNf9eQQX7HQGcV+OA6iQ2f+fEsp37s7OTOA
         PIPyIVe1bU894P8lB+UmzVT7l/HdxJ3K6npTifvoYmkHfAO3QdRmG+Dw3bE0VeM0Wmv6
         Q213Ibz33D/zwu7CPpMPSCeUc7uzbg/4UqHA9UVz62yokr7Mxeut2DYw4PZ0ylhRYmJI
         mYTg==
X-Gm-Message-State: APjAAAXD050kr28baiV7ysWqHxI+5N94cLkbAnoxhz+NvvMjdndriu6d
        KsPMoFigV4+pRf9ucWfTk/WYLz5qfXkWVIJj/1mI7w==
X-Google-Smtp-Source: APXvYqy5bHSP6xVXPDLN3H0poHbxLfI9OSYLRGQZ9XPgdnuRWY82vgabftl4b5eMgv1qQAWvTmFSgYxLTN1jfOJs/Jo=
X-Received: by 2002:a5d:9a04:: with SMTP id s4mr11587937iol.19.1561731409153;
 Fri, 28 Jun 2019 07:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560898723.git.matheus.bernardino@usp.br>
 <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
 <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet> <CAHd-oW6c7EoY+t-ymkcBmZM20YcGb1SWhM7XMO35Fofj-UNmYQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906281449250.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906281449250.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 28 Jun 2019 11:16:38 -0300
Message-ID: <CAHd-oW45RAov-5paURQ7j5dg0nZktF2J0bME7Wo1pF8YCd2cww@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to dir_iterator_begin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 9:50 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
>
> > On Thu, Jun 27, 2019 at 3:47 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:
> > >
> > > > On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > > >
> > > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > > >
> > > > > > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> > > > > >
> > > > > >>[...]
> > > > > >> +/*
> > > > > >> + * Look for a recursive symlink at iter->base.path pointing to any directory on
> > > > > >> + * the previous stack levels. If it is found, return 1. If not, return 0.
> > > > > >> + */
> > > > > >> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
> > > > > >> +{
> > > > > >> +    int i;
> > > > > >> +
> > > > > >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> > > > > >> +        !S_ISDIR(iter->base.st.st_mode))
> > > > > >> +            return 0;
> > > > > >>
> > > > > >> +    for (i = 0; i < iter->levels_nr; ++i)
> > > > > >> +            if (iter->base.st.st_ino == iter->levels[i].ino)
> > > > > >
> > > > > > This does not work on Windows. [[ Windows port does not have
> > > > > > usable st_ino field ]]]
> > > > >
> > > > > And if you cross mountpoint, st_ino alone does not guarantee
> > > > > uniqueness; you'd need to combine it with st_dev, I would think,
> > > > > even on POSIX systems.
> > > >
> > > > Ok, thanks for letting me know. I'm trying to think of another
> > > > approach to test for recursive symlinks that does not rely on inode:
> > > > Given any symlink, we could get its real_path() and compare it with
> > > > the path of the directory current being iterated. If the first is a
> > > > prefix of the second, than we mark it as a recursive symlink.
> > > >
> > > > What do you think of this idea?
> > >
> > > I think this would be pretty expensive. Too expensive.
> >
> > Hmm, yes unfortunately :(
> >
> > > A better method might be to rely on st_ino/st_dev when we can, and just
> > > not bother looking for recursive symlinks when we cannot,
> >
> > What if we fallback on the path prefix strategy when st_ino is not
> > available? I mean, if we don't look for recursive symlinks, they would
> > be iterated over and over until we get an ELOOP error. So I think
> > using real_path() should be less expensive in this case. (But just as
> > a fallback to st_ino, off course)
> >
> > > like I did in
> > > https://github.com/git-for-windows/git/commit/979b00ccf44ec31cff4686e24adf27474923c33a
> >
> > Nice! At dir-iterator.h the documentation says that recursive symlinks
> > will be ignored. If we don't implement any fallback, should we add
> > that this is not available on Windows, perhaps?
>
> I do not really care, unless it breaks things on Windows that were not
> broken before.
>
> You might also want to guard this behind `USE_STDEV` as Duy suggested (and
> maybe use the opportunity to correct that constant to `USE_ST_DEV`; I
> looked for it and did not find it because of that naming mistake).

Ok, just to confirm, what I should do is send your fixup patch with
the USE_STDEV guard addition, right? Also, USE_STDEV docs says it is
used "from the update-index perspective", should I make it more
generic as we're using it for other purposes or is it OK like this?

Thanks,
Matheus
