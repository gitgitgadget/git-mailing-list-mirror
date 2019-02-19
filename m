Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D321F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfBSODe (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:03:34 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:55294 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfBSODe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:03:34 -0500
Received: by mail-it1-f178.google.com with SMTP id f10so6176405ita.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hlNJHau4ddFANa0nhitoHhWwaI+hXQwosgSzXsdJ8ic=;
        b=PEknoEZYpc27fToM5x4z1R2xN8O3+h1XUyOw4NJBNndZ0EFfyy77cuxLAyayaxN93b
         Ug+M8tKFaV3DcUt7eHN2Hp1xff1CeUBo7+gxC8G2Zow+iozdYoFtgOg9VSVfHUYbgulm
         6fKFxIIzMYOgXjdJk/7zWHhkEQqCvNqohTrbUiGwEIUmdCFRBamOhG4Q5idskREIiKSt
         wLdecGIk1UZOKEidNj4EEWWjc1uCATdQgl9tgStn7SBLhmhgwolApFmsia86gUhN0d0i
         3RVRAxlEJ3q6T+Q09cOyzW+ES/EJiE+7GtkH968NEIUEdw6Uzm2uXWDeqLBI2b0pa7tO
         thIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hlNJHau4ddFANa0nhitoHhWwaI+hXQwosgSzXsdJ8ic=;
        b=Gc4xeaRMPNYvzpejJEZP31tpvBR7eRLcmnnAnbvitIslKQJGSrcJoVo/nz68/THKDB
         BvvybphHDZyycOGvzl0tr68Y2VXHdS2l9/NdY1/8N/5Mx9aaSNSGTJJqYH+j4TWKQwAL
         ZFElo5i0OJJygtVEsq8UWR/0P5zp8VuoHD2Gr6JXYZQmKr6kVW6rrYEt4Izw16VgeDeK
         0X3ngmuYU1lTNzUNAFOKxwJtbfqKo/aUvJyV69YFJ4TbAp4sWktSrYaAA/3yrWdVh9S+
         Z6pgtvfkXmeoTucWvcZee4FfUsZZqGmOou1JQvCDpBEPU75bFeknmgtbPdQg/zgMpopd
         Xnug==
X-Gm-Message-State: AHQUAuaQbOSZVskHiK8K5B5ZhKpYIvR+n/HllCCDjH5Mqtesje1vyPpN
        oxteEWM5my4I0baq5QJzDyK8GenyoPqgrdIH54tLlPUR
X-Google-Smtp-Source: AHgI3IbwryOwl5wGA7ewdSC0UdXDZLQ3dNoEc9YpOPOILVYduUbuXDvZPDlIamPFPOpLpX/dnK1WJA5HwYsA+E543TE=
X-Received: by 2002:a6b:dd16:: with SMTP id f22mr16281279ioc.148.1550585012953;
 Tue, 19 Feb 2019 06:03:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com> <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net>
In-Reply-To: <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net>
From:   =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Date:   Tue, 19 Feb 2019 11:03:22 -0300
Message-ID: <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     phillip.wood@dunelm.org.uk
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My system is macOS Mojave 10.14.2. I normally use Git from Homebrew (curren=
tly
Git 2.20.1).

I investigated this further, and I think I found the problem on my end.

When I actually run "git rebase --interactive <commit>" from the terminal,
everything works fine.

But almost every time I start my rebases from inside "tig" [0], for which I
have this mapping:

        bind main R <git rebase -i %(commit)

tig will exit after running that command, and then I normally continue work=
ing
on the rebase from the shell. And it is when I start the rebase this way th=
at
"git rebase --continue" fails after solving conflicts.

Second, I have tig installed with the Nix package manager [1], which shows

        $ ~/.nix-profile/bin/tig --version
        tig version 2.4.1
        ncursesw version 6.1.20180127
        readline version 6.3

So, I decided to try with tig from Homebrew, and then the problem
doesn't happen.
The Hombrew version of tig shows:

        $ /usr/local/bin/tig --version
        tig version 2.4.1
        ncurses version 5.7.20081102
        readline version 8.0

I will keep using tig from Homebrew to avoid issues for now.


In summary, the problem only happens when I start the rebase from inside ti=
g,
but only when tig is the version from the Nix package manager, which has
different dependencies than the Homebrew version of tig.
And it happens for Git 2.20.x and master. Git <=3D 2.19.x works fine.


I also did bisect Git (I never though I would be bisecting Git itself).
It landed in this commit: 4d010a757c (sequencer: use read_author_script(),
2018-10-31).

And the content of .git/rebase-merge/author-script is always the same:

        GIT_AUTHOR_NAME=3D'Sebasti=C3=A1n Mancilla'
        GIT_AUTHOR_EMAIL=3D'smancill@jlab.org'
        GIT_AUTHOR_DATE=3D'@1550530007 -0300


Regards


[0]: https://github.com/jonas/tig
[1]: https://nixos.org/nix/

El mar., 19 de feb. de 2019 a la(s) 06:59, Phillip Wood
(phillip.wood@talktalk.net) escribi=C3=B3:
>
> Dear Sebasti=C3=A1n
>
> On 19/02/2019 07:22, Eric Sunshine wrote:
> > [cc:+phillip.wood@talktalk.net]
>
> Thanks Eric
>
> > On Tue, Feb 19, 2019 at 1:45 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >> On Tue, Feb 19, 2019 at 5:20 AM Sebasti=C3=A1n Mancilla <smancill.m@gm=
ail.com> wrote:
> >>> But since Git 2.20.x it doesn't work anymore. Now after solving the c=
onflicts
> >>> and running "git rebase --continue" I get this error most of the time=
:
> >>>
> >>>      error: unable to dequote value of 'GIT_AUTHOR_DATE'
> >>
> >> It looks like this can happen only when an "author-script" file (most
> >> likely .git/rebase-merge/author-script)
>
> or it could be .git/rebase-apply/author-script depending on the options
> passed to rebase when it started (the sequencer and am use the same code
> for reading the author script now)
>
> >> is read by the sequencer
> >> mechanism. Could you show us the content of this file on your machine?
> >
> > A very good suggestion considering that there have been changes
> > recently specifically related to the parsing of GIT_AUTHOR_DATE in C
> > code.
>
> That would be very helpful, without seeing that it's hard to know what
> the problem is.
>
> Best Wishes
>
> Phillip
>


--=20
Sebastian Mancilla
