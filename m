Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF74C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 887C76113A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhHXNQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:16:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:41117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhHXNQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629810948;
        bh=U+DcjVApuTALg2qo8xwa1ElIIEFo8Wrc7jKMoGmw9WA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BYMKlZo+Eew8dB5rRmMZTE45ofzXUo0tp9/rd7FTHjL2okL1bkPa2DVKLkWizbQAU
         Of2YvxkDIGAtLZHsCNYeP2aMDEGPd1+H5GxF+BrihsyJGu7nDqFJ8bF2w+3sh5RmhE
         kfc7At+QB6l1qBOuYMdtUx5iYT1aTkvvfsSZIHHU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1mPNuP1oxF-006ux1; Tue, 24
 Aug 2021 15:15:48 +0200
Date:   Tue, 24 Aug 2021 15:15:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
In-Reply-To: <xmqqwnohyzuo.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108241513280.55@tvgsbejvaqbjf.bet>
References: <20210817110728.55842-1-bagasdotme@gmail.com> <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet> <CAPig+cT5nPJ7NKFKXRQJwTzL13oEwzMBBpAa+P+XoZxO9SEKKQ@mail.gmail.com> <nycvar.QRO.7.76.6.2108181222120.55@tvgsbejvaqbjf.bet>
 <xmqqwnohyzuo.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2ZUeDQEgbxLnZebQ9+L7X5Dba0Xbf2mHKYGsh0V1WEGOCoxiYVv
 C9HdRr5cNhP25cip9iuVBiex9+Ht/6M7eQSEOLMd3laHYxjvD1rbN5ODr727/BnjC4uZ4TD
 +5j4BWM+Jy6AjAqDjUiS2U48AS3U4V0ty9FzecZutJXfBHpBZjwwstMmiBgPo6MyK6nmlar
 FyDatqqWpzKUCb8HoyHCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+cZHn5jExxA=:cNqufUJ8BCiMv6pe7PhwrU
 EVUVcoKOCEdrQ5AuYUijEVkkPRBSiCiIcmHud13a6hPBl+Zi2VUQMb8Jcjf1z5FKFRkhTSkZV
 9owOzFbdUiuHPg08nsTc+wISADOCD3w4xykBINlca0iCs7ENSwrNprfpZwBSaSjlbWtkP8GHm
 rdr1YSQM99TKMEpJLKH83QJuWDHn23icqVhaOTuRdZlOeUF5JOQsXlL+s62Gzj/mOkFix0U99
 D/7E3748WQ9B1DOvq4g/jbGviKuK26FDo+N6Tq/r7pGUsIBn7CZTLhO03Pn9k/8NJ6pvtNkdq
 lgFC05SGQPb1m0vDLmH9RnkZOWbL1si8zllMJ9eV2J2Y8/FTte94wPFV+AKdf6zMurilgXGTX
 //zpvHVOwYdOncGVacGZRBdDHA+KN/7n42jWmL3fYSsLYfd4VGdUCQhEzZ9q3Jzqf/+xWE3KU
 dKlHwtyay4JarJQDtyxxi/hSLD5sLeo4Gdv/VWFKDqg9fGBtguHmeS4mAczwDMM7g/TQf8dnQ
 Evi40Av/HN2pmaAwJTfbEwNlxbVGS2ot7Ztm3BlrdGGRZ8SrsXifClKLQYvLQf3UrYWwP8M1C
 Zob1CrXrjPA9zHa33lQBQy//Nxv7WE6jxLdKFEJ1CAajBdGe4N5/ZrfBx0NbhBYIfj1KQbD/t
 Fw9c3T4y9XixIGLTG/TLC4wCkezuFOLcvJqy8ZgpvjDgEdUWZ/vbQDILPaZy4v2EY2QnLeFhw
 ilHl5PWkHGRD4MUAB7zjToQIL4y92EzwCE3qgrqnd/bYQemFDYY2KPb3HTjOkVa0y8tZm1fIR
 D9gv7QJ1Y692f+QRSnOh8+d5IUv8D4vlTvh+Eejh6gqgceSqT6ctdXLThJ2xqQV9ihZj1T5ws
 +2pi0MmaFzzq9MAjykRljn2AByOxNr4JDz41D1MqpQtC38UznUV0sEwQfj1mg3DoWJVzTmNqs
 JWchHlblI2no6kXvFtJkmWH7DOYxdukH8bUSMu+kQfwO2wguts+OEIxc2ROMhSyVIVjH7OgyV
 ESX+1et0gwPZrQyrfd7ei5fHNkIayQ1ShpN1zNbH9G2Wf6q4fxFhAAK2mSR8rMjDTfZpodX3A
 0Jb9UUVHetFS85Q+Mgn1wcUcy3wvy30dy3oxge68HMncHBGT5HjMmXu0Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Aug 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > -install: all
> > +install: all | strip
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> >  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > -- snap --
> >
> > I am not quite certain that this is compatible with other `make`
> > implementations we still might support (if there are any, I remember t=
hat
> > we often have to rely on `gmake` because the native `make` does not
> > understand our `Makefile`?), so that might need to be conditional on G=
NU
> > Make.
>
> I think we are pretty-much dependent on GNU make already (it is
> possible to raise a weather balloon to confirm by renaming Makefile
> to GNUmakefile and observing if anybody complains, I think).
>
> But I am not sure what such a rule does for a .PHONY target like
> 'strip'.  Does it do the right thing, i.e. "install recipe is run
> after 'strip' recipe has run, iff 'strip' is also asked for"?

My reading of the documentation is that just as with regular dependencies,
it does not matter whether order-only dependencies are .PHONY or not.

The only difference between order-only vs regular dependencies seems to be
that order-only dependencies are not necessarily built. But if they are,
they are guaranteed to be built before the order-only dependencee.

Granted, I did not have time to test it, but from an implementation point
of view, I would be surprised if there was any more to it.

Ciao,
Dscho
