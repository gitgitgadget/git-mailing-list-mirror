Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8571F462
	for <e@80x24.org>; Wed, 12 Jun 2019 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436775AbfFLIwq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 04:52:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54070 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407156AbfFLIwq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 04:52:46 -0400
Received: by mail-it1-f193.google.com with SMTP id m187so9518810ite.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ta9UaxJA6Ql0vvVvRH45HEyxmz093iojOGpSLZOUZ2k=;
        b=HSt+tPjK5LrZ/qF94CPqICDyQp+j8g8pA4QVE+9aEe+JzyPbalpBg/sQw8vGMQS305
         KtQ0YdgsAh2El14gsS9O+87B7Pe9VybwgzCjpTeFtgrdn7GOWWLlyNP4+VBP+WDOfhIs
         +0nhnrUjP5LMcdXOSg+F1V5bL9Ao2WN6yXyWvnpco9rz/Q6CujWMoTfpnb6ciJeCNvMC
         c9ya0XfbMyQ/K5I4CLAtlUcnLBgQVTCGiwNrEqBVCb8DBbJsDvvWeZw/RbVDB4WOx0gC
         uBxhkGThn7Per/bIu3LigmbkLkmhZY5bKHy6jM8HH0pknuJiYqfqefCXT0PIyWEMaW9M
         1XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ta9UaxJA6Ql0vvVvRH45HEyxmz093iojOGpSLZOUZ2k=;
        b=cKJrywfiFTEYvEcMmAr/wSUN1/z4TCiucOZpja3CLi1lwKduUR6FQAgHm4hLXTcQju
         TwODvVSve0O0Rtg/eCI4XX5/qo+VlXujehESjWMzqypv1xjoNskWMpmxhpHszINhjrsW
         tWe/1Qfiw9LYFBKcWbTG2Cs3CWkZNUzYZKyp+QzNpuGTs8FPT0tsueso6UNaRNKBjGRg
         1JYEHxNdsHJiasCEfhC1aqdipGNnJRYKSBODATZO+y3if7ew0pjQ0tjFia90u5swcum2
         B2gCQN0RQFuMceJHYsdCEnh7h+wDV/9I0PRZ/KxSX2BncKh97+QOXGzjYjrxK7QDn9pS
         BYDg==
X-Gm-Message-State: APjAAAU4ZeyJigg1tV2j9ByfZQ/ImD3xlphrb98ybk4lTIdLLdKbvW2D
        Q3vLbCO/htki+Cs9AWAeReJa4dFZlrJXYW2MxDc=
X-Google-Smtp-Source: APXvYqzV6npY98eiBrLZmGEJH9mYMfP8gjkAi0bCQPIAkytSlW2/NKQVK6umJAI0BfOptsXLvh8L5xMz0cnSLW00pXw=
X-Received: by 2002:a05:6638:63a:: with SMTP id h26mr37602976jar.92.1560329565689;
 Wed, 12 Jun 2019 01:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607022443.5706-1-felipe.contreras@gmail.com>
 <20190607093034.816-1-pclouds@gmail.com> <20190607100252.GA24208@szeder.dev> <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
In-Reply-To: <CAMP44s3EsNzBtt_pG8HVp_RTMTTArk7Twhty4_tzf2iiZ7TKUQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Jun 2019 15:52:19 +0700
Message-ID: <CACsJy8CGtZMn0aa7QRj7Dz-jZS2K2fviUJ_Lii48FRY4E84i5Q@mail.gmail.com>
Subject: Re: [PATCH] completion: do not cache if --git-completion-helper fails
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 8, 2019 at 12:33 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Fri, Jun 7, 2019 at 5:02 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> >
> > On Fri, Jun 07, 2019 at 04:30:34PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
> > > "git <cmd> --git-completion-helper" could fail if the command checks =
for
> > > a repo before parse_options(). If the result is cached, later on when
> > > the user moves to a worktree with repo, tab completion will still fai=
l.
> > >
> > > Avoid this by detecting errors and not cache the completion output. W=
e
> > > can try again and hopefully succeed next time (e.g. when a repo is
> > > found).
> > >
> > > Of course if --git-completion-helper fails permanently because of oth=
er
> > > reasons (*), this will slow down completion. But I don't see any bett=
er
> > > option to handle that case.
> >
> > I think a permanently failing 'git cmd --git-completion-helper'
> > shouldn't really happen, unless there is a bug in the completion
> > script or the git installation or similar exceptional situation.  And
> > then that issue should be fixed, but I don't think we should worry
> > about an extra subshell and git process in those situations.
>
> Indeed. In think there's only sane option to make this work in all
> situation; a reorganization.
>
> Something like this should work:
>
> struct command checkout_command =3D {
> .name =3D "checkout",
> .function =3D cmd_checkout,
> .run_options =3D RUN_SETUP | NEED_WORK_TREE,
> .help =3D N_("Switch branches or restore working tree files"),
> .options =3D {
> OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
> ...
> },
> }
>
> This way we could run parse_options_show_gitcomp() from git.c and not
> worry about whatever cmd_checkout() needs.

This only works for a few commands. Those with subcommands already
have struct option[] array scattered in different places. And some new
ones also have struct option array dynamically created.

It's not impossible to do. But I feel there's a lot of reorganizing
for little gain. Maybe when we pass 'struct repository *' to all
commands, which means we hit all commmands at once anyway, we can
reconsider this (and having config parser in a more declarative form
like cmd option parser).

> This has the added advantage that it gathers information about this
> command that is stray in multiple sources (git.c, command-list.h), and
> it makes builtin.h cleaner too.
>
> Plus, we could rework the way -h works too.
--=20
Duy
