Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1070C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D530207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eSN5F6IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHLNfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:35:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:48959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHLNfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597239308;
        bh=GPh9OoGNb3uby8ywRToZfL3IOPVygsFDeHDo7LOWB3s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eSN5F6ISLCXU8v4fTXmvSKMw4nOArPAzGY6W+Uiy8AWgAYLJP6XrTgz75R8lIGU4K
         m2qwEXgV9GIyTyxf45gDSagIs6VI4ltuJ/Pgc4cFoQDRqMnr3dRfH1Z2EwLPKV19G1
         bnlDWffM6fnbfGqSpcByG+W6uJ6k595fMO/A37dc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.213.182]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1k8cKI0MVq-003uHR; Wed, 12
 Aug 2020 15:35:08 +0200
Date:   Wed, 12 Aug 2020 15:35:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
In-Reply-To: <20200804192053.GA1400936@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com> <20200804185057.GA1400256@coredump.intra.peff.net> <xmqqr1sms0f0.fsf@gitster.c.googlers.com> <20200804192053.GA1400936@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nKT6eFxQ7gPJ5X3Qm1R4nIz+KBcWSCtfuli98EulJuLdkt4kTaY
 FDuEOd0ywqbHEQb3L7QrFMAsWrzIwVy8H+UTLLUvtbGw3r3vXCXZsLHzP2IKVONOcxW106L
 fXvZqlasrAXJY50yoLk79UUGPcn0SdZ/rYb1Okzr8K569ZwXaIcQGWMKyvZa9xvwCvaYZBl
 SMbLxD5HRxv6Rjl0hJSeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zkr9/Z+SrnA=:eu4YHqmk7+1yZbOpPFpbZc
 sn7l0A0wADiStp9vU6zYZ3ou3/2myhS9TGFwuqqKa2JStVxal+Z8e9UOhzq9UAHCeIgORhGkI
 osfHL9hHxog7Ja9BRJv++Jn6dTleGwjPp7gugsQyqLfiqzOkL5uFevcwpH7VTXv3VNN+MSjMt
 l3eOIKE+PgRcx7CPGU45gBDCvD8gzIDi3rcS7f9NieXTl+gGO9ylQdABcrjSv9GoiOFzYcg2p
 x2UZF1v5tMWvaXmPRjbcG4NylIIm8VR1LMHhAAJqi4t9Ise8XDJHFcupsL5UlalgAn7fuy7FB
 CXG+hKPy+76h3lwfdfJosqSj1Gq+75LIpB2DrJTGpmgjpWooPNDH+ZGZUuH/bmvhQ6OF10ik+
 +iXlsPGnZdrxS1oymmXafIP+JUEOvAEXEYDJ87Gsc3T6Km+Ja4Fegine7Fo5GBX0dbz3BZtaj
 0yuDk/zn2TyAuiM6OPLw2Id5wETuIhGn7Oe9Y3vKPM7XQ7kdj93LvgeRsjLuqm1JB93513hm8
 0FKyODlPE1zi2bksAyPcp3Ncvhej+k4omvv8wapLQWZf/etOMIFsJNt+g+R1bYgnEvvnO/TO5
 ZGS78vJ+/x6fi4p7qZkfhKr/IrpqUr9xTCjiV9Z7FpbbwzRsLVfz92wcQb0zNUC2b8qkXrDgB
 +CXHZ5Gq256IDpDCDHE+GgMFD9OtC1eFhs8+u4telzi+yVC3SvpR2r1ZEG7joiqWd4+vrbDBT
 EoaWuKsIwFWl7rDK3wqtge5AB5YVlahRTKunJvSyH+GqzqVkT0VGydTR9bjPuE00z1mNwuCMq
 eP5Gc+2Y02cLiSpEZu01aJiNBmZso1YstOdTiPK5W7/T1U+OHuwCZd94GOMSL3YZpGcqyprfA
 8NPI+ZbM9xmtUfJWF3uqrYQXqAYhlxBU7rDJhbAq7baBsvzIOdfEvwBT3/rsF4ON/DgNxlAfr
 wvsyg8L2xtPddCTMZ+hB8ca6Roo8MT/dZYX4MlFi5GAPo1+Te93BHdWtPHDgQrbXtKSOn/OA2
 QYXbVewoGepzYlkqnMQwB6lw4/xyjiuSQFJeev1krHuQhkswoI5iAzzP1ePRcKBqKz75nLoOH
 gXTJO1qC/9Ap0Aw8HWPg4wMGxCEomQfmbhn4qllSalZ3ChNhqC69WSfwtOVfydFyXVOhvSAfb
 K44PQ4/geBwtUXLsSqT+c+NlxoIO8JiuU5+Nqjew1502zWibnOy2yNAQGmIZzkRny1P8ESVyF
 ru8d5Og9G6AOXTVi6cTbMH+rjEpHVQN6aYJYYjw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 4 Aug 2020, Jeff King wrote:

> On Tue, Aug 04, 2020 at 11:58:43AM -0700, Junio C Hamano wrote:
>
> > > I ran into issues with this, as I have several in-progress topics (n=
ot
> > > yet sent to the list) that touch our Makefile, and they needed updat=
es
> > > to the cmake file (because it reproduces a lot of the lists and logi=
c
> > > from the Makefile).
> > >
> > > The original philosophy behind putting it in contrib is that most pe=
ople
> > > wouldn't have to care, and folks interested in cmake would be
> > > responsible for keeping it up to date. But the top patch makes it ha=
rd
> > > to ignore, because the vs-build CI job will fail.
> > >
> > > I'm not sure of the right path forward. I was definitely unenthused =
to
> > > be dealing with cmake, and the problem came up as soon as the series=
 hit
> > > next.
> >
> > My hope is that if we let vs-build broken long enough, those who
> > want to see cmake to graduate would fix it.  We can always threaten
> > the topic to be discarded out of 'next' after the next release if it
> > hasn't been fixed ;-)
>
> That was my philosophy, too, but it's annoying in the meantime as I get
> a notification for "your build is broken" every time I run CI. So it
> becomes a game of chicken over who gets annoyed first. ;)

I am a bit sad to read all this, as I thought that we had reached
consensus that the `Makefile` _is_ the source of truth.

But then, most of the source files that need to be compiled _are_ parsed
from the Makefile.

So I wonder what problems you ran into; Maybe we can come up with a
strategy how to preempt future instances of the same nature?

Ciao,
Dscho
