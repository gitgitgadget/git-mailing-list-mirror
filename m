Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61DC2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DED521741
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DJKDf1jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBFLpU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:45:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:33793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFLpU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 06:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580989515;
        bh=yCTsx0/U6kF2ITk9cXLoRPXYQasUhxBjNCfC6vowN3o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DJKDf1jD0YZKMld+3CVcUDG5VlA9Qtaeqgc1RH2tiZ6yJEQehFA111ud8KbNXGpg2
         Bcwe3L0X2R0Xxkbi8e0vAAuPBJzE+u6CqzV+OdomGe0ETCbxlbwYOwGM2LumBRD2yd
         TIH+DzHGXfsdbDyn8vdI1kIuPkM0SL2NuRTx+Sng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MulqN-1jpRGc3CuR-00rpvP; Thu, 06
 Feb 2020 12:45:14 +0100
Date:   Thu, 6 Feb 2020 12:45:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200206090632.GA17842@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2002061243500.3718@tvgsbejvaqbjf.bet>
References: <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev> <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet> <20200124120240.GG6837@szeder.dev>
 <nycvar.QRO.7.76.6.2001250133510.46@tvgsbejvaqbjf.bet> <xmqqeev8694x.fsf@gitster-ct.c.googlers.com> <20200206002754.GM10482@szeder.dev> <nycvar.QRO.7.76.6.2002060930210.3718@tvgsbejvaqbjf.bet> <20200206090632.GA17842@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1997163078-1580989513=:3718"
X-Provags-ID: V03:K1:aBcFP0/yP6hNOHnDnW++EeO58amNcGCJft6Xah1cuVc+ud8lLaG
 6XpW+RKKdwT76VoLaZ1zEpAt/jOmFz+g1T0LKqhttO5rg+P9AKZ2MCt1fQgap7CGbtUqWQU
 joWIuNNOXZ7rnC2JPbb1HxcN6gYTBHrnkYmoYtzCN5J0ZAhM1nZoYCL/pp/0R8f2hyc9sWi
 R7zWBbHZTPDbF511lpKPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FNYiuCscV8Q=:C2EKYFS/I3JxzDQuDizG2Z
 hVqd7jTbBFrzehVS9gmOmm3uTO5+4JdTp38Z9Vuw5IzTwfq4zadT7jEACbRUZZP0twK8kMWnf
 Y49PiN+L/zte2PlO5a7meTsBzvKRHAnsSqb5rfFfCyOtdheKAUqv4T/SMy/sMzCNUq0RtkkSL
 Asb98RfGNzWu79YZbVyP3ladgKCxYqDaqJfzk10ZsS5syOb4xCT+ftogQRtQIt5c8BbQ78BaA
 omwtpRXDoy+EP4kP8UqXsKbipwyvAc2DMNF+pkSWV7rAI3+arggYkzkGH1O5bETfWDVs+UoY2
 4aMNQial5+Dz6TsWEBwy5gBwhsulXZpq4wVlQv+44kwGt8no4sh2SQnZ1ZBovCoOsgHTeUNE2
 JoZXawUg8mfsmzZkg/mllSY9A+FPDBGAA+tNiE7rYo2beakMfv6z0QNdjTcJuf1UR8c6IUCxI
 E9RB+KNquGeic+O3s0xw0Jw9usVhccVjzvq6bPQTnuS5wJRB2X80bhd4Av7/+kSNfxqNtfEIB
 IFSbXorsO2NAN5FNMoSWFh/eXR1QRq20XnFvWl4z6uDdUyMc6/UQN9cGL8NX7rD1WwiOZfLab
 Ivt2VDFSSCWHeVMosr0d4KZardbnwdItzFxFfdH/DnNPSU+o5vd6EompNliod5JoQ566wTagT
 J+l80RtsP93l0ZgdvA2o9x72fnA8n0GCIeJwzuhB78lVzEEMQzvsvN4aJnf0BBBqsv2g6Us+G
 pRDC/UGlMK8+bbdntevn18x7rbpCGcOctZx5B1YOhIrjBuCZgqk6ZQnIr5CIWuL5xlKqqfq+z
 y+wGWzU+Dw6xFVV7gbTCqIfYEqiVsJ/RXx8gz+8KWlSxYgW8+6462IBNRQyeDjiJUXO0pko0S
 Tf5ujzDXZvn+Ntn7MUZ34LXcRaWp1kf/p/55h8Zca+5d66zbn8hHV5jB+Ub9UAualzgAYN0Ua
 B83NZwn5BI67/aJA0NKGvfjPlQeOXYgcjO9lPDL1qEIhoG5opd5QwrQy0//q2o5IY3O2ZzuOh
 C1xi6YIzxkZEt7ZvjVQXRPRnkboJTaFz8uBYwbXn86HXHagjNy0/oA1g5AYPhmynq3zBGp7fH
 g4OS8RDZrP5j1+mR+k2Vn7gKVDhspqhxiIB2lg6uS9ldagYp/AxSP798YvpL2DqVFTuL5qOYe
 G3STGqcz57D/Zqnan4Q/783uCBmvYqQdntHRLxJq1hTofeXfZm4ZKACO6iJPjVpyqM5SiEXxh
 wg6ubje8VEmnRjYT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1997163078-1580989513=:3718
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 6 Feb 2020, SZEDER G=C3=A1bor wrote:

> On Thu, Feb 06, 2020 at 09:57:51AM +0100, Johannes Schindelin wrote:
> >
> > On Thu, 6 Feb 2020, SZEDER G=C3=A1bor wrote:
> >
> > > On Wed, Feb 05, 2020 at 01:01:50PM -0800, Junio C Hamano wrote:
> > > >
> > > > If linux-gcc and linux-clang labels are not visible, linux-clang-p=
y2
> > > > and osx-py3 would not be, either, so...
> > >
> > > The 'linux-gcc' and 'linux-clang' labels are not visible on Travis C=
I,
> > > because those jobs as part of the build matrix, and, consequently, w=
e
> > > can't set the a 'jobname' environment variable for them in
> > > '.travis.yml'.  If we were to include additional jobs for the Python
> > > scripts, then for those we can (and should!) set
> > > 'jobname=3Dlinux-python' or something, and that would be visible on =
the
> > > Travis CI web interface, just like e.g. 'jobname=3DStaticAnalysis'.
> >
> > I think we can see that jobname very well, though. If you direct your =
web
> > browser to
> > https://travis-ci.org/git/git/builds/646646192?utm_source=3Dgithub_sta=
tus&utm_medium=3Dnotification
> > you will see something like this:
> >
> >     Build jobs		View config
> >
> > ! 5281.1 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment vari=
ables set	8 min 20 sec
> > ! 5281.2 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variab=
les set	8 min 23 sec
> > X 5281.3 AMD64		Compiler: clang Xcode: xcode10.1 C	no environment vari=
ables set	1 min 57 sec
> > X 5281.4 AMD64		Compiler: gcc Xcode: xcode10.1 C	no environment variab=
les set	2 min 41 sec
> > ! 5281.5 AMD64		Xcode: xcode10.1 C			jobname=3DGIT_TEST_GETTEXT_POISON=
	5 min 14 sec
> > X 5281.6 AMD64		Xcode: xcode10.1 C			jobname=3Dlinux-gcc-4.8		1 min 13=
 sec
> > ! 5281.7 AMD64		Xcode: xcode10.1 C			jobname=3DLinux32			6 min 50 sec
> > =E2=9C=93 5281.8 AMD64		Xcode: xcode10.1 C			jobname=3DStaticAnalysis	=
	10 min 56 sec
> > =E2=9C=93 5281.9 AMD64		Xcode: xcode10.1 C			jobname=3DDocumentation		=
6 min 15 sec
>
> I don't see any 'linux-gcc' and 'linux-clang' jobnames.

Ah, that's what you meant. Indeed, those are not displayed because we set
them at the wrong layer, they would need to be defined in `.travis.yml`.
You probably _can_ use variables in the `jobname`.

Ciao,
Dscho

--8323328-1997163078-1580989513=:3718--
