Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FF21F4F8
	for <e@80x24.org>; Sun, 16 Oct 2016 08:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbcJPIJ0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 04:09:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:55465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbcJPIJV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 04:09:21 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mb8HX-1cEjkv0A4h-00Kcg8; Sun, 16 Oct 2016 10:09:14
 +0200
Date:   Sun, 16 Oct 2016 10:09:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <20161015174656.fmgk3le2b34nnjpx@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610161006080.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de> <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
 <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net> <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de> <20161015174656.fmgk3le2b34nnjpx@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-574187668-1476605353=:197091"
X-Provags-ID: V03:K0:D4h/6Lm2DdWExSBNHPXh/cPv5hGJ5Y0argfYr5HCftGAjyChXaF
 Q2MUexLg417pYVhAtmnaPc4Jln9qh5ViikMXbEcPMVAz2S1fhdaSWOPfRRmUk6JV0QpKA68
 N98URvgWAFg/Ct/nbPUFCSUzl4oMZTJ/OsdiTuSdk1RVg8zpafDruta/pPsPs2t6ll0dPGU
 9VjfA7zUvSEZk0Zt7x+8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4mB8No3PJVs=:YhaSEDOXf445GVZejS3E45
 H8PAZQiej4BOi49jbqZo+PdoV3VnBcSNm9s/XEWI8aIhk7H8xRcoKV+XEive7DU2xWLyM6FCR
 RnEI4HYTN7ZQ6c1z+1ORuq/+jWZzsH1+vkTpMNTDUO0IT9TlumZjys2ESMn6VlKLSQKj71T3q
 sitGxRjAK1qPtcQQpf+GwuNclPX+TR6hqcAmb+ch/OGiADHED4ycH6BWK6Mp2wstfCRtdBgag
 zJdYu3m5Vf6Z6WbJ73jmpaoj+kDQBLb9i3dv2Ig6YFLBM6BsO7CYGwShQFytTJZ1/To7z0hHE
 VPSmM2UQLyawLv9kbmwZYYhBFrWdZaywRXjMKY7Ya4PwaHpPcoJd/AwdrOugwxqLSt3PAAssM
 Vr8Ra148LV43pZ83S4eufBB6n8+33WJ5MiFcLdcwuoWGAcBdUxZWEgP3fxhKbuBVdhbkjH4MB
 X7Gb4Dn1sQMetLFm2/28Rg143EOmMiYrXl8lkywNEAG5zdqQBn+XAlmm2xl1NOgU2c2YrG9q9
 XQw6JeSAl6fzrRbKKfHaByboHQK3xeSrXWuZtMdrQdRqnQxHc/CRb4/Jm2L00OR3nuK5JlNlO
 35umh+SlWgxrlhu4qo7iWyNjo8llK5kcIXOMDl9FW2ue5a3RbetxzESer6AIxypXczwjZYKhh
 mZC6YpuAIxNoBxo6JonwsJyJRnPXGkax3MtDtKgo0XLfYacD16ubyp/q111jxwbrDeDavGi5z
 KVdygIlK+RZLCMLT4rWOJOAIFVFdaJhi5ESfPlD2a9iHrntsa1r0DbmEUHy7Xmao9+pZKOgjp
 NPBd+ZD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-574187668-1476605353=:197091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Sat, 15 Oct 2016, Jeff King wrote:

> On Sat, Oct 15, 2016 at 07:40:15PM +0200, Torsten B=C3=B6gershausen wrote=
:
>=20
> > > I wonder if:
> > >=20
> > >   if ((int)command < ARRAY_SIZE(todo_command_strings))
> > >=20
> > > silences the warning (I suppose size_t is probably an even better typ=
e,
> > > though obviously it does not matter in practice).
> > >=20
> > Both do (silence the warning)
> >=20
> > enum may be signed or unsigned, right ?
> > So the size_t variant seams to be a better choice
>=20
> Good catch. It technically needs to check the lower bound, too. In
> theory, if somebody wanted to add an enum value that is negative, you'd
> use a signed cast and check against both 0 and ARRAY_SIZE(). In
> practice, that is nonsense for this case, and using an unsigned type
> means that any negative values become large, and the check catches them.

I am pretty certain that I disagree with that warning: enums have been
used as equivalents of ints for a long time, and will be, for a long time
to come.

Given that this test is modified to `if (command < TODO_NOOP)` later, I
hope that you agree that it is not worth the trouble to appease that
compiler overreaction?

Ciao,
Dscho
--8323329-574187668-1476605353=:197091--
