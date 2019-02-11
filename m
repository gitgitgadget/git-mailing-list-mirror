Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658CE1F453
	for <e@80x24.org>; Mon, 11 Feb 2019 08:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfBKIfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 03:35:42 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45736 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfBKIfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 03:35:41 -0500
Received: by mail-ed1-f52.google.com with SMTP id d9so3213000edh.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 00:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r16fH6RoG/NuCBR1Zk+1jK6AmTwEY655anayVo9pzY=;
        b=Hk9HciPX5xJnJ2dxa34YlCXXG+j3y+NVZM8h2i/T1N0Seq5DA9hVGeaRAaC8zNxHX2
         ioR6LcC0SW3ecl13TyXI//zWyJ02bK8xIvguyRx8yWLzNBMPv7bXI25xNkMGTdeQKWET
         EQNsR8r9YsqO6utEz3ANb6AabpHJjT+kSZZDNDFa96SsKHhCjb4fX4yQS4AbxQW9kOVM
         TBVS181zGxzwAwySsm9UXF6wKcWeVoVyYQXZcjW88KZSi9bRv5Gi1D7Go+hak6mxWYy3
         4C9M9PSAVDr8XWH6MLetYVfvPC+hAofkZVdrDdiK2VjcVwFE3smlqtD7IfTWwYf2y+ry
         uzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r16fH6RoG/NuCBR1Zk+1jK6AmTwEY655anayVo9pzY=;
        b=HuERw/6072C9evD0UgGnSHbv3PstLfqxsfs78Lc8MkEmlmIil0HdEenEASns//ZSMD
         s0/axBcWcE4z9Ku5+rbl3wc91bqB64yHYiqXf24/3V8HvdczfjGv/pcqbAq4e/9sFeiv
         X4qh84jS3mBu2GToGicgNZk9zBQo2u6LttJhtzwMApuv52oM8JWkQGSGpEvRepJxHUQ+
         BHjbDFPbKQUo2Xm+DBQTWlJiW41rMz57V/MXoq9pJ+oadpVlwzLQhHjOc+Mw0aBPU6ZT
         g8k7O4YrPu6qQbnlhnU2ZSLVWrcB1z2uQI1cf/3NL24oVJnNUHebCLHLvyDzv5/ZEb34
         3m+Q==
X-Gm-Message-State: AHQUAuYSRg3SJQEB2gu6TsKUKTIfFj9rZesgwgZgaIWuWS7LR3H+FnQq
        hbzmIOU1zv4EqbKrN21SvaZNPI9caChj/6jSmlK43LQwyaM=
X-Google-Smtp-Source: AHgI3IbKI9pxlu8i8lPhQUmHT82B2PcfcKP2wJ6RhwOcMMe8sSdD11rP2ZuAKl1OM4dh3AbUZ3BxTM+4Fly9vmzjA6o=
X-Received: by 2002:aa7:dacd:: with SMTP id x13mr13703002eds.24.1549874139792;
 Mon, 11 Feb 2019 00:35:39 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com>
In-Reply-To: <20190207213326.GF6085@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Feb 2019 09:35:27 +0100
Message-ID: <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 10:33 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/07, Johannes Schindelin wrote:
> > On Wed, 6 Feb 2019, Thomas Gummerer wrote:
> > >  - implement pushing/poping conflicted state
> > >
> > >    This would obviously be the end goal.
> >
> > On second thought, this might actually be super trivial. Right now, we
> > support two modes (not counting the `--untracked` stuff): --keep-index and
> > --no-keep-index. In both cases, we seem to create a merge commit whose
> > tree reflects the working directory and whose first parent is HEAD and
> > whose second parent is a single commit on top of HEAD (which contains
> > either no changes in the case of --no-keep-index, or whose tree reflects
> > the index in case of --keep-index).
> >
> > To extend that to the conflict case, we could introduce a new flag
> > --with-conflicts, and have the commit structure
> >
> >       Worktree
> >        |    \
> >        |    index stage 0
> >        |      /     |     \
> >        | stage 1  stage 2  stage 3
> >        |    /     /       /
> >       HEAD ---------------
> >
> > The only tricky thing I can see is to maintain backwards compatibility if
> > possible, so that old `git stash` will do something at least semi-sensible
> > with those commit structures.
> >
> > It might be too small a project, after all.
>
> Yeah, looking at this I think you're right.  Thanks for helping work
> through this.

I am not sure it will be too small a project, especially because it is
a new feature. On top of the coding part, the student will also have
to come up with good documentation and test cases, and there will
probably be naming and workflow discussions and possibly refactoring
opportunities and bug fixes along the way.

Yeah, the naming and workflow discussions should actually happen when
discussing the student's proposal, in which case an important part of
the work will (hopefully) be done before the GSoC actually starts.

Historically though we have always been very optimistic in what we
thought a student could accomplish in a GSoC. And we are very likely
to find more ideas for improvements during the GSoC, in case
everything is "finished" before the end. I actually think that it has
never happened that a student both "finished" the project before the
end, and that no idea for improvement on top of the work was found.

I have added a "Note about refactoring projects versus projects that
implement new features" at the end of the idea list:

https://github.com/git/git.github.io/blob/master/SoC-2019-Ideas.md#note-about-refactoring-projects-versus-projects-that-implement-new-features

and I think that with that note students working on such projects will
be warned enough, and therefore hopefully have a better chance of
success.

So after all if you are willing to co-mentor such a project, I would
be ok to co-mentor it with you, and we should add it to the list.

Thanks,
Christian.

And yeah it would help improve our idea list as requested by Google.
