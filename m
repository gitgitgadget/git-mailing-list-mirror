Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C35981F42D
	for <e@80x24.org>; Mon, 21 May 2018 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEUJwn (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 05:52:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:41703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeEUJwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 05:52:42 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFR2O-1fZ0pV1oA8-00EQdc; Mon, 21
 May 2018 11:52:37 +0200
Date:   Mon, 21 May 2018 11:52:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 01/18] Add a function to solve least-cost assignment
 problems
In-Reply-To: <CACsJy8ApDb_KTjoJgMuV_AJ+dQdGC0kgCnMcJXj5pMGdqMQCyA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211152140.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525361419.git.johannes.schindelin@gmx.de> <CACsJy8ApDb_KTjoJgMuV_AJ+dQdGC0kgCnMcJXj5pMGdqMQCyA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-302835195-1526896361=:77"
X-Provags-ID: V03:K1:h/IkALU+thCbFnyYLmIUaH1GSf76wp7wLXVsGDLix3+D4gsWVSa
 6VTEEzjpHPA6NIKbhzXl8H2O2qsankcUhnkgxTKgDblS2YB/9IpCvTGngTEzngRSE6qWj+v
 8hjEJ6tPqhGpNs2YpTqj63ZN0q2UAMvzGcoORMtQxvsqT8MVEhqExjFfnjFfzDeRU1OcFFO
 whelzlzoS1dLV8Tdmexvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VjU08vMtZVU=:5CwSsmj3oL4pnpb6MmTmVM
 4srOwisOJh4+jWX6CGVQrrVmDLX0URbb3kxGDNTuVQNjUwkX9kXx6homy+gafCdj2UkLBto/H
 Gji+nQT5Hf7K3Gg2xox3Hp07KRUWHnYDOAMkTgzpMDGeWIGHUmaYynVcA0tJxxSfTrjLT1yeL
 hKqOcbfj4MGCZbZVZpsRSLhuDR3MNFPB5ziAiHna7CEj9WVkC/Kph3VXDygh3M8QyKJNjrJOF
 KYpS/f7Si1joQlp6nsY3q9guQ2F6osnv2T3HmWrxYEilf2FTBg3MaNK3p1AY8hdJM9XEvnizN
 oI082eMx+L/hzyyKcI3ik6bk3Y4ty44tNzcsOMRZoC0XC1VNGoMiRz+fp8clW0pnQirbhX1BA
 3sq0tEQ7i6r1l+WnlBpzlfH7/VabhmWyTUiz4KBKkpOb9A0jxWvnawk7wGmuVFWhE4sEOiBc5
 lWnLnq3r7DKAtlCssXDwfwvsKsUWpQ9hWJAhHIts5KfoCVDacrOoIKn7dawlqmdR7CkL6Uo28
 xjAwxEgSHXt8aXMsdOli5PXRQXLjNzrQDK7B2bjSHwF+dw3COROM5Ak3Ka++03ph8L05cIjmh
 Zhur0hsFP2XDna617JEese1mdMsHRgrQGddXBJ2mk+hBv7SUO5R7MrlPvvwXr5NOJ5sZ5IoyH
 J+eUy2A2KU0FypHIVQ2BbkPhGSVMhL7DAaWYyh9be4j4DRh5NVJp2WZaue0px9BXusjryP8aK
 Qyv981VWZO7IVw5zkbunW0LzEtp9mqguONKIvwYbenS3jbPKJvA3uv+KFCnRbGOwlaPVR8Bg/
 s9sNwmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-302835195-1526896361=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Sun, 13 May 2018, Duy Nguyen wrote:

> On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > +       /* reduction transfer */
> > +       free_row =3D xmalloc(sizeof(int) * row_count);
> > +       for (int i =3D 0; i < row_count; i++) {
>=20
> travis complains about this
>=20
>=20
> hungarian.c: In function =E2=80=98compute_assignment=E2=80=99:
> hungarian.c:47:11: error: redeclaration of =E2=80=98i=E2=80=99 with no li=
nkage
>   for (int i =3D 0; i < row_count; i++) {
>            ^
> hungarian.c:21:6: note: previous declaration of =E2=80=98i=E2=80=99 was h=
ere
>   int i, j, phase;
>       ^
> hungarian.c:47:2: error: =E2=80=98for=E2=80=99 loop initial declarations =
are only
> allowed in C99 mode
>   for (int i =3D 0; i < row_count; i++) {
>   ^
> hungarian.c:47:2: note: use option -std=3Dc99 or -std=3Dgnu99 to compile =
your code

Yep, I fixed it locally already before seeing your mail. It is good to
know that some people pay attention, though!

Ciao,
Dscho
--8323328-302835195-1526896361=:77--
