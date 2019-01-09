Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F23A1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 06:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfAIGkR (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 01:40:17 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:36980 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfAIGkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 01:40:17 -0500
Received: by mail-pg1-f174.google.com with SMTP id c25so2879567pgb.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vewd-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T3Ns65z89vMSNHIE3OIfAEjCTqbEdOfMB0JDImKlS2g=;
        b=fyxib8PFu7FKtKkiN4QEzi9Aviv6/AsgLddGqH8Y6UVyaICWAYniJdhXnrNcU4vv9R
         jwMxTRBuIYomcK2KU+A4fcEEZAnFWdqdqf7qv7ooGCXQdb587H3SzpzVcVoL1x0twZL5
         +rEpx6PH90com4pceeVu68xXce5cFWwSaAjqSiqVuHXqHGqKNh8bn1kJLteum1PQZvWE
         zvZZJvq0eQsQWzvysZYzJbP/qlbFP2936Fark1zRiGX2MsBEi41qH5afV/jud4WOma27
         e3juLEdsjAQEtpR8WqKpgkNf6Rnr2q+gZ0072ISnakXTm5H4GGzRVl78Uda3OsQ9ByPA
         Hwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T3Ns65z89vMSNHIE3OIfAEjCTqbEdOfMB0JDImKlS2g=;
        b=S7iukGVziV/0WLg+L/PC0Fdqmgx9Jv2CqiLngXDOjQbQ5uX+IbVSoXq42oYP/wVbmF
         G2/z4LjpMApDA1L8z+XbsgUg0dpokvowRP+krZXz5agDyx+pcQ6a7JddCF14EDUJnSut
         5MK9KSyB6uBCuqPFlrVEfxuiniviQ79n43TUshdjW5r50OliizuLAhuS0PcezmJaSFUp
         Se7xXNAdqgPyf3iXK20GIgFULXDvGaDxavsJVF8lfW7zahwrebPxhgVq1H28lB22f53g
         Aj6e/NXbYWNua0mEN4lzJMv9q0KwyBwMkSDJ5nIMR/rA/wru+YTb2A/gWlpb4HZrhV77
         WLzA==
X-Gm-Message-State: AJcUukclrJV0VjYDr7aEbZOY8Xi+uJWoUCt7ZOo/IsWO3V9BrZAJJVHS
        E3HXRr0eW8SGoK4xy7/kuMuoYhjQ1YTw/x/m2GPTQg==
X-Google-Smtp-Source: ALg8bN4tzyx9Z76mEn0e1jzHQcoFxEmb8pYnAMSiWXBNXitFFiLZJV6xfENYL+qJRjMStYJfBp9DKiNyZ9pidpkgDuw=
X-Received: by 2002:a62:53c5:: with SMTP id h188mr4725754pfb.190.1547016015661;
 Tue, 08 Jan 2019 22:40:15 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
 <CACsJy8Cvc8v_4OEmpgKPWSO5csV6jRya7mnSQjEs4mMhHRq4AQ@mail.gmail.com>
In-Reply-To: <CACsJy8Cvc8v_4OEmpgKPWSO5csV6jRya7mnSQjEs4mMhHRq4AQ@mail.gmail.com>
From:   =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Date:   Wed, 9 Jan 2019 07:40:04 +0100
Message-ID: <CAG0vfyTdAyEeAuNUpjTrMjUpmT0XNx1ffdbQwYS3fs13UFnP6w@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Jan 2019 at 00:23, Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Jan 9, 2019 at 5:56 AM Tomasz =C5=9Aniatowski <tsniatowski@vewd.c=
om> wrote:
> >
> > After upgrading to 2.20.1 I noticed in some submodule+worktree scenario=
s git
> > will break the submodule configuration. Reproducible with:
> >     git init a && (cd a; touch a; git add a; git commit -ma)
> >     git init b && (cd b; git submodule add ../a; git commit -mb)
> >     git -C b worktree add ../b2
> >     git -C b/a worktree add ../../b2/a
> >     git -C b status
> >     git -C b2 submodule update
> >     git -C b status
> >
> > The submodule update in the _worktree_ puts an invalid core.worktree va=
lue in
> > the _original_ repository submodule config (b/.git/modules/a/config), c=
ausing
> > the last git status to error out with:
> >     fatal: cannot chdir to '../../../../../../b2/a': No such file or di=
rectory
> >     fatal: 'git status --porcelain=3D2' failed in submodule a
> >
> > Looking at the config file itself, the submodule update operation appli=
es the
> > following change (the new path is invalid):
> >     -       worktree =3D ../../../a
> >     +       worktree =3D ../../../../../../b2/a
> >
> > This worked fine on 2.19.2 (no config change, no error), and was useful=
 to have
> > a worktree with (large) submodules that are also worktrees.
>
> This scenario is not supported (or at least known to be broken in
> theory) so I wouldn't call this a regression even if it happens to
> work on 2.19.2 for some reason.

This scenario worked fine for quite a while now, at least since around 2.15
(as I started using this early 2018). It "just worked", to be honest, just
needed the worktree submodules to be manually set up as worktrees too.

> The good news is, I have something that should make it work reliably.
> But I don't know if it will make it to 2.21 or not.

That's good to hear, is there something I can try out or track?

--
Tomasz =C5=9Aniatowski
