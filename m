Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1A120248
	for <e@80x24.org>; Wed, 17 Apr 2019 11:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfDQLwi (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 07:52:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:33849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfDQLwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 07:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555501953;
        bh=BIFbMj0YbZbm+N0h+HWxHp4ytH8rmZkjegsxsR9XyZ4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I/tUKhmWf/KC1JSw+n4GSXEiTuRLXYkr6FxClyuRBDT4IcGAfogqO/FzM/70tley3
         HDAYFab0HETzoURuVJnbPJBesAIibkwlRw4wM+X4qNf/w7+yRPrVElLkudMTyqkWuM
         ALPFJVQqctpu4CRLeB8u5eUVxowvktlXfrCVwEzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5GDv-1gpCHl49SP-011C7r; Wed, 17
 Apr 2019 13:52:33 +0200
Date:   Wed, 17 Apr 2019 13:52:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/4] range-diff: don't remove funcname from inner
 diff
In-Reply-To: <20190415185627.GB1704@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1904171350310.46@tvgsbejvaqbjf.bet>
References: <20190411220532.GG32487@hank.intra.tgummerer.com> <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-3-t.gummerer@gmail.com> <CAPig+cSmh1rCTPj0Y=G4OA3TmoGqVBnj95S+KogOgiDtW_0DiQ@mail.gmail.com> <nycvar.QRO.7.76.6.1904151454010.44@tvgsbejvaqbjf.bet>
 <20190415185627.GB1704@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2+62Fgpit/OwgwM8UErTHyklQmdCecXKMycWb/7ES/+N5X1PFkS
 w5I34+wGiBTnaeiA+jOSkBkZThrk5JlsyEynIt+NSWKnoexbhZiVIU53BLRiSghoDt0ploj
 xGTWlmclqi1bGsmURhfeMuGEN5iSCGcm4tR+EtfpePkWLHSSRa9FtgKkCimMIqJ8NDOvuQ4
 dzk+meafOJZnvXK/oeveg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:78oXUuGvxWc=:YBTA5o9+rsZjcaMTZhwQKv
 jGMp0SmCe3HOJRvYRaLIh4JECMCV5j66o70Uj9Rnom3JKUH441yqA0+vhM33v7fivRO6tJ7b0
 rsIWJB6x8BORDMK/WkWITd+ir485T99xr0wUUTUeyHa3+pxPnMk1el2Gbigmcbtp9K6FRinuZ
 fdq6u6Javc9jaxTzZ/xnYR0YmmWzHwh7Y8YgSnbCynP0j/0oirmFeT6Z0bp5uwcn/wZZamZ0D
 /zGw9IcHlEgsxlqWIPPMQV6HZPcdGra4UwlyiT22UMcclfOxUivzeoeI5JswCVItJYHOeO2CV
 TdvlE0MbKzm6T+nnTlV9IeKLwdsztQG68Sw5314PTeU8uMQ964XK7+kPLeVS1Joh0ehGh2sJ9
 eGcODqk3+PKhr712VrLjl8LHA9wVkEuDa53zcSpUuputLyE4WiDgGEX9vZcAozlNTkTepVLbM
 x80zj2RNYfJYBAuheCjA1p0bz2bkrkU8qdM02WIdiUajQgM1+FnM4LKgQOuWQs7DvcMKA4W3a
 qfXOMyn3B9PqpEcYVUcpsZnENkbvEUmlola0tEmb7NrtUkVlNaC29abs+PvcJ54xgeIn8Iyhd
 02jr0fcaYKa0NymKa1hGJ4/405dgw/L55v8clWN6SWYbR5xpD7rxfr9vqsOrFecoA8k1e2Zh0
 uzLnRuL3u9Te7Y+ys7++DYA7oxFTpFzR4UjHbBErG/cSuZwEaXaRZskAWgazDFFe/zG57VQ0+
 +bCFnvlnR0pdqWyRwxJ3otvyZncF1J4n+1YE1UQCmRSPYrs8gcfiy8gHJuakjEuxs2UlW+/F6
 lvYiTCIjOqO1/Pf+dUXnRK7q8gCNHV/DSMxaLyBZa8ioZ2haVLxp1yW/GYqMdHUuYJVH/qk7W
 iDYmSMAy36+QwI0cWmb6NSZVFQ2D5DP0Ja25mwFDpH5uiR/qWwjSUBSxOOtAgHAqbhqQeRoMm
 ji/isgUiMtQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 15 Apr 2019, Thomas Gummerer wrote:

> On 04/15, Johannes Schindelin wrote:
>
> > On Sun, 14 Apr 2019, Eric Sunshine wrote:
> >
> > > On Sun, Apr 14, 2019 at 5:09 PM Thomas Gummerer <t.gummerer@gmail.co=
m> wrote:
> > > > [...]
> > > > However it can still be useful to have the function name that 'git
> > > > diff' extracts as additional context for the change.
> > > > [...]
> > > > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > > ---
> > > > diff --git a/range-diff.c b/range-diff.c
> > > > @@ -102,9 +102,12 @@ static int read_patches(const char *range, st=
ruct string_list *list)
> > > > +               } else if (starts_with(line.buf, "@@ ")) {
> > > > +                       char *skip_lineno =3D strstr(line.buf + 3,=
 "@@");
> > > > +                       strbuf_remove(&line, 0, skip_lineno - line=
.buf);
> > >
> > > It makes me a bit uncomfortable that this is not checking for NULL
> > > return from strstr() before doing pointer arithmetic (even though th=
e
> > > input is presumably machine-generated).
> > >
> > >     if (!skip_lineno)
> > >         BUG(...);
> >
> > Good point, but maybe we should not go so far as to declare this a bug=
,
> > and fall back to removing everything bug the initial two `at` characte=
rs
> > instead?
>
> I like declaring this a bug.  We are after all parsing
> machine-generated output, that does come from git (which is why I
> neglected the NULL checking in the first place).  If that second "@@"
> is not there it's definitely a bug somewhere in the diff machinery,
> I'd say.

Ah, but you do know about the micro-project I proposed to optionally feed
an mbox to `range-diff`, right?

The idea behind my proposal is that this would make it possible to
generate a range-diff between the patches on public-inbox and the commits
that actually made it into Junio's `pu`...

> Note that the "@@" also couldn't come from anywhere else, the diff
> header has a well defined format and so does the metadata.  The diff
> itself is prefixed with '<', '>' and '#' in this case, and the commit
> message is also prefixed with four spaces.  So if this breaks
> somewhere I'd rather hear about it loudly, than let users potentially
> get wrong output because we missed something somewhere.

Agreed. But I could imagine that `die()`ing here would be the more
appropriate way to holler loudly ;-)

Ciao,
Dscho
