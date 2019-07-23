Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C600C1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbfGWMrg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 08:47:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:60577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbfGWMrf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 08:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563886048;
        bh=+Gw1kfhEWH9S6a6gsAFG2TegjWLFjB7Whj6+8HLTFd4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KAZ8oOglTkpk6AK7VeAjqnfib20LoT3GSuD6RJNeDh5sMx71ZOvkD1UZKmfxmwvKP
         a30ZVJy8RTOHRlTvWroWaaU/7OJy2KAOjg6r0br3almU01aqtXtgDZo/IRWpuAAO1X
         MODtvkWRIzxc/l0whn1PnoFijSq/apkktGJuKnKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.16.31] ([194.69.102.31]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1i3Bqu1o2K-00M11s; Tue, 23
 Jul 2019 14:47:28 +0200
Date:   Tue, 23 Jul 2019 14:46:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitally
In-Reply-To: <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907231444250.47@tvgsbejvaqbjf.bet>
References: <20190721183115.14985-1-carenas@gmail.com> <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <87muh57t5r.fsf@evledraar.gmail.com> <CAPUEspg1nUoPApTk5J2r_-9psxTTSC7nRAPw_X9no+2sFVSxAA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1350122143-1563886042=:47"
X-Provags-ID: V03:K1:rDoOAYJTr3wW4UWcm3sggC2jQ6WMUSf04KrpuSwlSpVrbFF+j8S
 D/oh5w6lK9vMx8d/griYeEcfZDGFyTvgxDlei8wbLev85K4YT4z3sf+uyu/MMlJmD0hX6GF
 A+oyc8m5wefIFN+z6f07NMezjmQCp7Nt8UZM8jCucEqNfSAEgrldm+Ms5QNqlYsnhLlXs89
 X7HEMUhPAf1MXeRo9Sr4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TLHOtZUrpdw=:FCnzyDifXPAL6Vf7fm9Af/
 3n1+qr5AE4M3rLPrE8xwH507+PYTOlxghMRK4h/9JSo1WuR9NDL8E50KtWvRm5Qgk75Nb7Lpw
 vrV4UoGXrgJNOomu5qOFj990+FQG1e1pODFPp4oiKps/I6N+avNyrImAKwLOd5qHdxpHB+ijN
 Kek9v3YeSIDtMeMimM4gIcnARIcygOdBQGJDurGYDfhFhCVIJZXDs2T/Xot35Db7sqfV3J+5I
 A8l/wfYscrmKD+4OoSSbXNKJGN7KvFU4A3Ci3GVFBcbW3LC2TUSK1I+uUODsOrniQpBugnuR3
 mKE2L4EvcJqUMteNCvZoUolgx1hJ19+kcZCaC4MqkGadreJiF5lkJSmQvj+8FW3smC4pigKf2
 K6mhy+q/7DaEgYJRIKS0O2GiTodScShRFMVjrmU3swyYaXOWwIzlpNbNFcPjTOTlEzUZHfA/4
 DTPhvH/dhV+493zvii52pEk+wMOy1yr3GGfjA/7mDT8FS6HZwmn6Su/RKCxsMWoq1LE6CcmgU
 xbipxxdz8pgGlwsU0G6a67KO/9+fKKM62/xALqEI6AQxc6Z76F3p/9eMbuP2Ri0al2lbYHFcH
 DT0AONAdssYVKifx3LucWKpHkmCIO3qGNf105kERj1M6NYZtWcOT794CTTlo0Dyt6OqmzYoo+
 vLdUy0rAujs/ocdj3uWLYD7G6Vizlw6gq1pkHjVaL7JOhl3/wkGf1QdWhtNm7BA1WzN3wiKd5
 sbkNpx7HmbKIG1btmZKelTECKEfF7HhCvsK5TdJTisX44iBMXe0q6VyItQBC306jN5VatS0Fz
 G+BWRI3Lm7iUSRJtYE2G/zMgccKxiOtn8yk3g3HCCqs8dWp5WsMSeJnp+AD+G06rMH10+waHX
 +HFnpM2+d+P21Cei7peUsvUoiZCNgU+xBV2XzWGcoMlOPTfndMfWDEHEbGsl1QYS5+a2ndL81
 3iqoH4fD2juC+HAxeSea3VJ2/ZVWPAjfiSxcTP2BXeackp6SLO1JlEgSW/dW3satKp269olex
 XEp+ADKg4Zgtoy2pFqcdFgu2AHJ6KTsAb7t4e4yMYF89tjKTyE55r/Kl5DI2AkCDcFpoIeSkq
 yCrPTfKHzZ4yCU2s2mq2ffGUf78+vSuXaaY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1350122143-1563886042=:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 22 Jul 2019, Carlo Arenas wrote:

> On Mon, Jul 22, 2019 at 12:42 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Mon, Jul 22 2019, Johannes Schindelin wrote:
> >
> > > So I am fine with this patch.
> >
> > I'm not, not because I dislike the approach. I haven't made up my mind
> > yet.
>
> my bad, I should had explained better the regression I was trying to
> fix with this patch :
>
> $ git version
> git version 2.22.0.709.g102302147b.dirty
> $ git grep "Nguy=E1=BB=85n Th=C3=A1i"
> .mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> fatal: pcre2_match failed with error code -22: UTF-8 error: isolated
> byte with 0x80 bit set
> $ git grep -I "Nguy=E1=BB=85n Th=C3=A1i"
> .mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> po/TEAMS:Members:       Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds AT gmail.com>
> po/vi.po:# Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
, 2012.
> t/t1302-repo-version.sh:# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy
> t/t2104-update-index-skip-worktree.sh:# Copyright (c) 2008 Nguy=E1=BB=85=
n Th=C3=A1i Ng=E1=BB=8Dc Duy
> fatal: pcre2_match failed with error code -8: UTF-8 error: byte 2 top
> bits not 0x80

This is worrisome.

The entire reason why we switch on Unicode mode is because it matters
for regular expressions. Take for example this one:

	Nguy=E1=BB=85*n

See how the =E1=BB=85 is supposed to be present an arbitrary number of tim=
es
(including 0 times)? If PCRE2 was to interpret this as UTF-8, it would
understand that the bytes 0xe1 0xbb 0x85 had to be repeated (or be
missing), but if it interprets it _not_ as UTF-8, then it would handle
_only the last_ byte, 0x85, that way, which will not work correctly.

So when PCRE2 complains about the top two bits not being 0x80, it fails
to parse the bytes correctly (byte 2 is 0xbb, whose two top bits are
indeed 0x80).

Maybe this is a bug in your PCRE2 version? Mine is 10.33... and this
does not happen here... But then, I don't need the `-I` option, and my
output looks like this:

=2D- snip --
$ git grep --perl-regexp "Nguy=E1=BB=85n Th=C3=A1i"
.mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
po/TEAMS:Members:       Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds=
 AT gmail.com>
po/vi.po:# Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>, =
2012.
t/t1302-repo-version.sh:# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy
t/t2104-update-index-skip-worktree.sh:# Copyright (c) 2008 Nguy=E1=BB=85n =
Th=C3=A1i Ng=E1=BB=8Dc Duy
t/t7011-skip-worktree-reading.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy
t/t7012-skip-worktree-writing.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=
=A1i Ng=E1=BB=8Dc Duy
=2D- snap --

No error, you see?

Or maybe it is a problem with the locale? Is your locale using an
encoding different than UTF-8?

> > I stopped paying attention to this error-with-not-JIT discussion when =
I
> > heard that some other series going into next for Windows fixed that
> > issue[1]
> >
> > But now we have it again in some form? My ab/no-kwset has a lot of tes=
ts
> > for encodings & locales combined with grep, don't some of those trigge=
r
> > this? If so we should make any such failure a test & part of this patc=
h.
>
> I don't have a windows environment to test, and I admit I wasn't
> following clearly the whole conversation but at least in my case, I
> never got any test to fail, and I haven't seen any test with broken
> UTF-8.

The problem was not Windows-specific. It was specific to PCRE2 versions
compiled without JIT support (which was the case in Git for Windows'
SDK, but I fixed this on July 5th).

Your patch adequately addresses this problem: instead of erroring out in
the non-JIT version and passing in the JIT version, it will let also the
non-JIT version pass.

But still, I think the issue you found merits some deeper investigation,
methinks.

> > As noted in [2] I'd be inclined to go the other way, if we indeed have
> > some cases where PCRE skips its own checks does not dying actually giv=
e
> > us anything useful? I'd think not, so just ignoring the issue seems li=
ke
> > the wrong thing to do.
>
> we could reenable the checks by moving out of the JIT fast path in pcre =
so
> that pcre2_match is used for all matches (with JIT compiled as an optimi=
zation)
> and that might have the added benefit of solving the PCRE errors when JI=
T is
> broken[1]
>
> $ git version
> git version 2.22.0
> $ git grep "Nguy=E1=BB=85n Th=C3=A1i"
> .mailmap:Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> po/TEAMS:Members:       Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclou=
ds AT gmail.com>
> po/vi.po:# Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
, 2012.
> t/t1302-repo-version.sh:# Copyright (c) 2007 Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy
> t/t2104-update-index-skip-worktree.sh:# Copyright (c) 2008 Nguy=E1=BB=85=
n Th=C3=A1i Ng=E1=BB=8Dc Duy
> t/t7011-skip-worktree-reading.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=
=C3=A1i Ng=E1=BB=8Dc Duy
> t/t7012-skip-worktree-writing.sh:# Copyright (c) 2008 Nguy=E1=BB=85n Th=
=C3=A1i Ng=E1=BB=8Dc Duy
>
> important to note that at least on my system (macOS 10.14.6) the output =
of all
> engines for grep is the same for a UTF-8 pattern match, even if using in=
valid
> UTF-8 in the corpus, and I would expect that to be a better indicative
> of correctness

Right. It is _inconsistent_ at the moment, and with your patch it would
at least be consistent again.

So I still would prefer your patch over "going the other way".

> FWIW GNU grep (with -P) also ignores UTF-8 errors using the same flag an=
d
> even PCRE seems to be going in the other direction with the recent addit=
ion
> of PCRE2_MATCH_INVALID_UTF[1]

Good point!

Ciao,
Dscho

>
> $ od -b int.p
> 0000000   102 145 154 303 263 156 012 303
> $ pcre2grep -U 'Bel=C3=B3' int.p
> Bel=C3=B3n
>
> Carlo
>
> [1] https://public-inbox.org/git/20181209230024.43444-1-carenas@gmail.co=
m/
> [2] https://lists.exim.org/lurker/message/20190528.141422.2af1e386.gl.ht=
ml
>

--8323328-1350122143-1563886042=:47--
