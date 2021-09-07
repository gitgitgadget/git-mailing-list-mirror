Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14CFC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D75610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbhIGTpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:45:00 -0400
Received: from mout.gmx.net ([212.227.17.21]:51255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345525AbhIGTpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631043827;
        bh=MIFBwjYoMOMLdI/sFuhc7OSnjTqKjj5B7mjfEjTT4RY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QyA2hBCdGfxr32kpfxag2kxUoLJweo7np9LVu59TYZaLcbfC4Jj2NGvcayndqkdKc
         CI5xYwqXw285GmcRHtPXbS1iTLgrwX9UVP4zRofmiHWzjamIe4fg0sbCe21/9V+XZR
         lx+5Fo1VXqQHJCptIX2yJ5r+E06GW8cnMBkIWsa0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1mKhGS0KeR-007Skb; Tue, 07
 Sep 2021 21:43:47 +0200
Date:   Tue, 7 Sep 2021 21:44:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
In-Reply-To: <86cbe5b9-1a9e-0616-2d66-3130fcb9afb9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109072135250.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com> <d93a750a-9faf-c91a-c9f7-e968c7ed40f5@gmail.com>
 <nycvar.QRO.7.76.6.2109071430320.55@tvgsbejvaqbjf.bet> <86cbe5b9-1a9e-0616-2d66-3130fcb9afb9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sIdTku/kbTwlW1DNP/oIElez1cn0bKZM3CPGa7G86kKfo4Wk56p
 bp9M7RQlLtLssFBdBYbzgOO/65dCey/dqoTmpiVliHQn1Xr2TmRW8F3iN7X7yJsIfDpNAWx
 Ef8nW8rGnuCKH5OpvaLrPWOZUUCpA+Sr9dmnMSg/LRJ0WujCUn2FL6r5lI8zJrvafSw3JO5
 9rQngKAUS6FD0+3PtXyGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CcjX27+5m7c=:mZEwGH+U4tkQTj14fWsEAg
 EEJ7d9n8OjGG620RAww48IixAL4cfwf+H9/c6jKvz8IdR7qA2lw6Ac8A79jIGFogQdbrFIMp8
 Cgph4uamSTb57OKgM2kAoHho3RG+Dzj+qMnsFtuUw/TUAwdDzowXQUaBttsVa1FPexeJaW/2R
 VDqLPJDRDKX6Y9lJKUFxk9Htkkb9wyA0UfwObl39VOe5JaelLpwWA3g6XphU/MewwoMwPSneg
 n/VTbsZNqlXuHvuIGbI54eOju5wWfm3eVI0BoSVsFbix/A759NqVqUrGeLX6v7cMDRM7+5mjd
 nSoFh9oYanP3wp86dYgSDAzvnwhHpHUxo0rhPKJmNDkGdVsjwNrJKzsL0P9E2XlV2CpollcY0
 KWTxEnksQ/Ez7ocealebZSQpfK0nwQRcunqnoawJdbN0WqyEPx5dGpGbn0zgipKAxPxOGGPHg
 Lkq6zecXPBkCp2ZaTzHCyXx3N5cKXzUCgdidIXXx74JEmhcZkDkk4x4/TciUk+wa7SHhhikCI
 Z56rGSLsdFJJZS8C8zPz66Pg3JwKSnuM4I319DRQ70YuTQOrowxXnyoJwYaHn1xtFaDSxl6Ih
 1pzsSbfAj4M3DF7M8hvQ/NVcT5v5hwleOtAsg8iiADpiPvcQKKeUByT5aIZO+FCPpba5aW1C0
 fYKsOo4OExbBrlg1HbxyYQJdp2EfaavjoHNU99xsbvNnYdmj6dW6XxY6SCevi34b39PqabK16
 qXSRoLbHPXJQnnPbJVWxsLrLX1wbPQjR7ZMvHkBoRSpNiM/dR8VHgDk605fmAHZddevvD1HD+
 6guGqBsoWU5VnmcmmOBJDC/GVVDgirpYuHWrzj+Cg8fyKVc66wepv2X/R6BXgY+OsE9qHR608
 JKeQSmRMph1iaMPEE4ZrqI5dE+y0yhpNWh+GYL5SqrcZizZKWYpW0PRVff+IJjcWiYjfL4sJh
 kWE2xmmYcGsZS7c1p3ucw7hUWkR0cXZ78w29QSLHwkFZfd8TTaAlANYk9YWQbq1JGbNzZVC7G
 aUM/l6HlI4O88NKeiEWqF2iYS9OSpAhjJoljVWNCItLQSlpjhzcmzn7YeZd6tErTJNVL2DtnG
 +ClrHCx/3F8sDVZ6Umm1p1KNJb9BhBUNvDBev86ZlL8UbK7iOMqnsNC7A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, 7 Sep 2021, Phillip Wood wrote:

> On 07/09/2021 13:32, Johannes Schindelin wrote:
> >
> > On Mon, 6 Sep 2021, Phillip Wood wrote:
> >
> > > On 01/09/2021 12:57, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > This option was deprecated in favor of `--rebase-merges` some time=
 ago,
> > > > and now we retire it.
> > >
> > > This all looks good to me. I did see the comment below in builtin/re=
base.c
> > > that could be tweaked if you reroll, but it is a very minor issue.
> > >
> > > /* -i followed by -p is still explicitly interactive, but -p alone i=
s not
> > > */
> > > static int parse_opt_interactive(const struct option *opt, const cha=
r
> > > *arg,
> > >                                   int unset)
> >
> > Right, without `-p` this comment does not make sense anymore. But once=
 I
> > replace the `-p` by `-r`, it _does_ make sense: `git rebase -r` is not
> > interactive, but `git rebase -ir` _is_.
> >
> > > I do wonder if we need these option parsing functions now but that i=
s a
> > > question for another day.
> >
> > As the function parses the `-i`/`--interactive` option, which is not g=
oing
> > anywhere, we still need it.
>
> Sure I was just wondering if we could simplify things by using something=
 like
> OPT_BOOL rather than OPT_CALLBACK_F for "--am", "-i" and "-m". I haven't
> looked too closely though

It's definitely a good question, and I wondered, too, but failed to share
my conclusions with you.

The callback does two things: first, it switches the rebase type to
`merge`, and then it also sets the flag (by setting a bit in the bit
field) that the rebase is explicitly interactive.

The reason for this "explicitly interactive" wording is historical, of
course, because historically some functionality was implemented by
`git-rebase--interactive.sh` even if the rebase itself was intended _not_
to be run interactively. Think `git rebase --exec <command>`, for example.

These days, it is still true that `rebase-interactive.c` implements some
functionality that is not necessarily meant to be executed interactively
(again, `--exec`, but also `--rebase-merges`).

So there _is_ a need for that option to do more than one thing, and as
some options can try to set, say, the rebase type, it is important to
handle those options immediately (as opposed to trying to set a flag based
on `--interactive` and then trying to infer the rebase type from that flag
_after_ `parse_options()` is done).

Ciao,
Dscho
