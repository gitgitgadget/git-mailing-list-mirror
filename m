Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46D61F454
	for <e@80x24.org>; Sat,  9 Nov 2019 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfKILVt (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 06:21:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:55687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKILVt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 06:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573298494;
        bh=5jX44gs74Yn0kOu/GfU/sLJY5juS/SbrwikUnWqAwMg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aS8CpN2ywuXrd7v0PBVaCL2pEiPVD6NQ8V5M8le9H5U9rTgIlq0XmXu8y94bxJN1m
         kaVJAhh/5J5U84MZrGXtxGCjGVTw2GL3f8GPQNHquUKKV7/iSHFJshlpEOOPRRs55z
         8XRyFeKlG3u+PubkdczHcOrJBC+jfw1nb8STM4zw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([46.183.103.8]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2wGi-1iUVne0kou-003R6e; Sat, 09
 Nov 2019 12:21:34 +0100
Date:   Sat, 9 Nov 2019 12:21:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 5/9] built-in add -i: implement the main loop
In-Reply-To: <xmqq1rujndza.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911091211560.46@tvgsbejvaqbjf.bet>
References: <pull.170.v4.git.gitgitgadget@gmail.com>        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>        <25590fbbbee7efc34477bfea233684e93ee7fe60.1572869730.git.gitgitgadget@gmail.com> <xmqq1rujndza.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6RWnOV4XUtoOpq0uokEgMYODFZGWFY/zf4ySaWYOdJ/ftnzEgNH
 ShX60/cgDQY2nnuatvbOqL6XQ+faeuASxD+eOVu2R/fXpe8BRao9IzBb5aLl67YmOxMSeMs
 O/EtUHllOZEVyzF2uk/WyASWQF32iiyP63jThbNKKs+rLg0aI3X03hS1J0eZudxZm0ZsjZh
 fMYjzkGE2H5KPsn1Nei5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sa2twkchMlc=:TQTeZ8bziOpaFQobo/p5gp
 i+ipN/0GfFiP9WPI0ldlkEM6ppsTty3slcZUDsM99cuySwrS6yrKJd0iRn0JQqa1wOLbuFpyx
 XlSS6otwnW2UyeuizfmuQsgFzBsZp8GtBbxkDKczryJkY/s6A35XW8de0LApngLKGf2kk2vc5
 EttdE6Kyia7dtJX7LYTCAIlJBSyDb2AplvuaB3LeGr4f4AI1gh27l11y8I4T5YPNEuJTiK1g3
 CdvN8GjcexXdIUyaQOrYV8nChYYorUXuthMzHX5GbR5h7Ug93aXi8j0uDUUt/suWAR+tUEVDS
 xh1/p6DHCksbViRumvXAkMXnp8VXGNFfntQtDq5qnquFDMeOnbwN+LFa4g0/BKolD24ssNLZh
 LP8Kz4XIHNsuYFVbqveZcE+GTwm7o98ve2MbfR+io5Csq7Ei/rNzltg2B3qm2WvtZDGgYtG9s
 1xLg9k8myScBU3NC00c1L6i3YQvwV3DtxwOvenkCHNxmld0iun4UheP2Rrhl6j8fqYejz0H+7
 SMWZ2F5dqjkC+qKeORgvy00pkMKbrAiygKUmQxPROWEmx2Irv2JeTOL69D+ORFu9eSk/CF163
 CF7ND0RCMlHhgJvALrpENkQd9C+xEUbP3xc6sbUtLOrVGZoKloB7aWOY1j0gacUJw2CAwmt0y
 2CFMH+GQfA4Wzxa8nJtW0xqSEA8puwraLsC4gdq5bJJ9SEVQ8ZJrRg4O3zP8zQeOj6Bf66pvM
 oSrK2bC2TIvI9cBU5ZVyOUg1x8Jzzw2wSK2zp0rNR05DWuR+nOsAJ1JW5LwR6C0kJfxeEW2MR
 LXONGWYAgpW8oiC4M6jSd+I9bDf673wlozMAaJyXcvLDQdTPaRG/blHIxOmvEDEvxn/OQpuoT
 BUL2fKRLW/8HLsQtA+1uO75zuRCfkBI1YbPHsj+QJX//PZzGsmyPGJ7H2GFCR/mTbUlu7P3Nt
 3/KLsrU6kRzanrvk+wXBveY8w/K/9veRI9HVBJQkU0Ay+QTqco7QkASjRmkQGbntLADlAb4yg
 +Wv8Mg1hi2VA660fnqm0KCh0+1aR4WNm8wVIgRgxwMncj+ZjAPdXP8SeIinnh/fIjYbv89H2z
 UBjooeJR99lD62AfZ9BC2rHFD44eNh+WyGIcyxXBLxxxvxPw4BvB1ZFI/jQBaUPZwbP6eW0jU
 r77obBBPhfsQoDlwJpZu+HlrbwPXtHSNBikt4HKQxfOZbN1sjjS8rKIM4hK79Joj8i8Iu5tJo
 in7DSljNMZLb1bZWYtFDYbcz5RKTxyG3Ry2Fix77u2wPJg3nT7z+G9Z+4OGo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 8 Nov 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The reason why we did not start with the main loop to begin with is th=
at
> > it is the first user of `list_and_choose()`, which uses the `list()`
> > function that we conveniently introduced for use by the `status`
> > command.
> >
> > Apart from the "and choose" part, there are more differences between t=
he
> > way the `status` command calls the `list_and_choose()` function in the
> > Perl version of `git add -i` compared to the other callers of said
> > function. The most important ones:
> >
> > - The list is not only shown, but the user is also asked to make a
> >   choice, possibly selecting multiple entries.
>
> The list_and_choose() we have here shows and lets users choose and
> returns the choice, but the above makes it sound as if it only shows
> and the caller is responsible for asking the end-user input.  Is
> this description outdated or something?
>
> Perl allows us to return multiple choices, where it is a bit hard to
> express it in C (perhaps because we are passing in an array of
> structs to be shown as choices, list_and_choose could set a bit in
> these structs to signal "this one, that one and that other one was
> chosen", returning how many are chosen in total, to extend the
> version here to bring it to feature-parity?).  So at this step, it
> only lets the user one choice (or abort or ask for help).  Isn't the
> lack of multiple choice the only difference this bullet item wants
> to highlight?

I changed the commit message to:

    built-in add -i: implement the main loop

    The reason why we did not start with the main loop to begin with is th=
at
    it is the first user of `list_and_choose()`, which uses the `list()`
    function that we conveniently introduced for use by the `status`
    command.

    In contrast to the Perl version, in the built-in interactive `add`, we
    will keep the `list()` function (which only displays items) and the
    `list_and_choose()` function (which uses `list()` to display the items=
,
    and only takes care of the "and choose" part) separate.

    The `list_and_choose()` function, as implemented in
    `git-add--interactive.perl` knows a few more tricks than the function =
we
    introduce in this patch:

    - There is a flag to let the user select multiple items.

    - In multi-select mode, the list of items is prefixed with a marker
      indicating what items have been selected.

    - Initially, for each item a unique prefix is determined (if there
      exists any within the given parameters), and shown in the list, and
      accepted as a shortcut for the selection.

    These features will be implemented in the C version later.

    This patch does not add any new main loop command, of course, the
    built-in `git add -i` still only supports the `status` command. The
    remaining commands to follow over the course of the next commits.

    To accommodate for listing the commands in columns, preparing for the
    commands that will be implemented over the course of the next
    patches/patch series, we teach the `list()` function to do precisely
    that.

    Note that we only have a prompt ending in a single ">" at this stage;
    later commits will add commands that display a double ">>" to indicate
    that the user is in a different loop than the main one.

> > The Perl script `git-add--interactive.perl` mixed the purposes of the
> > "list" and the "and choose" part into the same function. In the C
> > version, we will keep them separate instead, calling the `list()`
> > function from the `list_and_choose()` function.
>
> That makes sense.
>
> > +static ssize_t list_and_choose(struct add_i_state *s, struct string_l=
ist *items,
> > +			       struct list_and_choose_options *opts)
> > +{
> > +	struct strbuf input =3D STRBUF_INIT;
> > +	ssize_t res =3D LIST_AND_CHOOSE_ERROR;
> > +
> > +	for (;;) {
> > +		char *p, *endp;
>
> The scope of endp looks way too wide in this function, isn't it?
> Even in the final state of the series, it only gets used to parse
> an integer input using strtoul, inside a block of three lines.

True. I moved the declaration of `endp` into that three-line (now
four-line) scope.

> Other than that, the code at this step was a pleasant read overall.

Thank you for your review!
Dscho
