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
	by dcvr.yhbt.net (Postfix) with ESMTP id 448FD1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 12:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGaMhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 08:37:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:46473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfGaMhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 08:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564576569;
        bh=9t759fpwdAfcdVMV6cGskgYX/4D5QR/rRaZErwdvsxY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RYa7q7u7hTKIAUi4vO2o29tpUML1TC1nz+m5WzGyOsSMboyg6USQUiCClYAx10v5m
         RRak0cwSNsGNRLdGhHJge/gr++a+bkpjuubd/3rOLnvb6kdVlxMgkpgfaPsS/YSaPg
         Ec6hrVmZzLyndSnaXJ5Zdd8xU+iKhTATnJWTf81Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2Jt-1iW0Kn3wFV-00e62p; Wed, 31
 Jul 2019 14:36:09 +0200
Date:   Wed, 31 Jul 2019 14:36:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org, avarab@gmail.com,
        sandals@crustytoothpaste.net, dev+git@drbeat.li
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in
 PCRE
In-Reply-To: <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907311434080.21907@tvgsbejvaqbjf.bet>
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com> <2f9cc063-96fc-dc99-0e29-230f1e12c1d3@web.de> <xmqqh874vikk.fsf@gitster-ct.c.googlers.com>
 <CAPUEspjo3Uo8KtSYQ=uh+_gPEjb+dBdSPgsEVE1j1bOMPF=0DA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-971224832-1564576570=:21907"
X-Provags-ID: V03:K1:rSyogP1KsBfuPAwFxm3sibpLPGkyECqooUvmXMKEbFF+21w9k7S
 PKyzzidkTGUGMaVDKJ1tawrZmrReoD360HQ5e2583+IIRxwXerBdsVZ7mVoSn17yM8czmlG
 JRtykQYcC5Wp0/EfKE0JYJgLBJ+oXOxr22/Y97ngT+E6yPZQUzkyUa/qKQHoJU9+rCIyl4M
 b80Yen17UrrTF8EHesBnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VRtWlyvF/wI=:b3stZtFSGoEuTm0Y6otRe+
 E5whwBtt6ozhTRGuUerNqJuewbi14V14Fa3u1pBWytjKCkV1vFRDXLJBAQCvBEOPkMV7w6dr9
 3xqZtI3ZFdt3vzyQvs2dXuOkjWzuZeJTJt7Y20bOjxZGdw3sECiGh8EEdUZPVwtoHe/xU9NCf
 4HzBjXniOYk1/TtulVsw7j3pwoSY0kiamyGD066WsMNB9JM2+ZEi3JjBgtNsayqAN84NkcMjb
 fHu0u8JWuwxqDpm3D46NOIQ0bElM2cQRQK7WdjHfj5ufm1MNxkGgNkOQ3Nucx9Lgn5at03EnD
 mOCVuJ+2fLSwZwBJER3Eb/Dpn1BE/AOktt3BqDx0+IxiIjqPOfqt+OdUq3ojgbH0NF8zAmtir
 chdsh0P3u7jCJhQHWGjinJA3+Op4NCVzkJ3yELrhinlzlSrQcBi9waR9Yo+ldzqHRh1kgTCnM
 ywB4RFQGW2sVY5S0/yMsRMp+0bWfT6pUaVvAEKBwTVzK++x4PN+REBUcWknw7ez0sIUqbqaUJ
 Gn1T6wkaZZAMB39X7i80wKxzxJpSyKjhx9fNd4l+KpfIqvsZ1GHarAbseld46O3f7c50Ih7D/
 REfCaPAv+e72eoTBUwuSBkKCMr9gi5xg7yvhjF3Wj+7kt21RB1+gmzrS49vv/dM0a0noGGXQK
 gkjH7ytDEa0UmsV6xibZtoTcVkwogFeBxckl35iIjtbZS+lNcV3QIIhiPd4196r/DeMBUw2Ky
 nVCXSFS4ifIZlIK5fk1cD8lbyE7Vp4kWH7tt3JgzMWBlgY6baZyvyBzMu9nfNsdjcdundkyfu
 1AbihqXESTp5Z1IEP57rDBThdn8K4X235FFhUtcrtPqDQcj/9rEb8VvYVIhARedwUgalbJAOm
 cMHG2dqwpuJ34ZQ3zmKfknodgdOuwkEfBP8CNLbuemJuWzsdk80dgMqxVExwKvX/lnDvCiKyw
 H0tzShgPXMO/BHjcQxqnDFm8bfDWzqaLJFYJetaqaDe19ThupvN2S4+Xn7WnuFHBXqpZWvcRd
 3pP4q5yqZGjhKvk4gbsnC+ihl330MatPNV/qzEb/xHS7Q5HTNzGRFW+XvzcMv9HRmaS3F9MaD
 tAmkuu48IVFrXvyNgNePA2ZtZk7AcIDm1R7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-971224832-1564576570=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Mon, 29 Jul 2019, Carlo Arenas wrote:

> On Mon, Jul 29, 2019 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrot=
e:
> > Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
> > >> +pcre.jit::
> > >> +    If set to false, disable JIT when using PCRE.  Defaults to
> > >> +    true.
> > >> +    if set to -1 will try first to use JIT and fallback to the
> > >> +    interpreter instead of returning an error.
> > >
> > > Why not implement only -1, without adding this config setting?
> >
> > ... nor command line option.  If we have an auto-fallback, I would
> > think that makes the most sense.  IIRC the first iteration with only
> > the configuration was really about working around the (non-working)
> > pcre-jit---if we can self-detect and skip a non-working case, that
> > would allow us to drop end-user facing knobs, which is ideal.
>
> because that was proposed earlier[1] and wasn't accepted ;)
> [...]
> [1] https://public-inbox.org/git/20181209230024.43444-3-carenas@gmail.co=
m/

For the record, I read
https://public-inbox.org/git/xmqqh8flkgs2.fsf@gitster-ct.c.googlers.com/
as encouraging a slightly more powerful argument in favor. Junio seemed
to hope that PCRE2's own `pcre2grep` would behave that way, and that
would give us plenty reason to just imitate it.

I don't know whether `pcre2grep` behaves that way, even if it does not,
I think the benefits of the auto fallback to the end user are
considerable.

Ciao,
Dscho

--8323328-971224832-1564576570=:21907--
