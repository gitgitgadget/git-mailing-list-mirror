Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7548AC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E4C20848
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 13:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FvBW63Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFN56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:57:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:35941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFN56 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 08:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583503073;
        bh=TOLwKH2o1E1L0F2IgH5qx+rsQSraEfp1W5vXVDTPu0c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FvBW63Zlj0utATImgq7ErsbgUQ36hB0rCwtUuKZ0l+MM83X/3KkP9XsPXGzIt0xpD
         XVse8w84QXrNwZMJ/SQ+9B2jGaSkkf2NEB7BorE26lRdiQ0jvB2oszRiq+m+Jv/4jI
         FlD40CbQVNcpp5D1tg5hsfeyEuFopEVeP1lgrWE4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.208]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYvY2-1ioAM52y6S-00Uo6R; Fri, 06 Mar 2020 14:57:53 +0100
Date:   Fri, 6 Mar 2020 14:57:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2003061453260.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YvRhb6koyMJ/v8Q4HKdWldOVAZ7hwbCyLqnfREC4FT4A3imCfvx
 XNsOtI1SG+PG6sD33kCKIkK+wC4dTyzteJyRH4XtsLjEPs/LQ334kuvz/87Vah6MPQ3v6sm
 uvzpcJE5PAmvz2fyhuLeytoQAeKwdsh/m50DmgG1mQrZM7VNSnQLNasnLroQ0vBlnXRW+Pc
 tLAWLFeQHHMgW2ieKRqKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wwuhp8g8laM=:xAV67ZyWXB36pWIdFYptui
 tcFNrHRbDyOsuE/nNXL4ZRPpDLKNwYColhaULjq6b629EttMEzfb2dD6hswNUFRw18B9krKup
 vhYEE3foUY6fXDXup/hlTOc3wh69vy+f9SE9Y+Syq/PQj83CuVgZoLWfA0kApv/5Q4Eb93EGN
 95LdWDvnWrsjChIohIwoqEIPqICunGRvCYEMGT2gGnqRSkkpHrjjkdFWg4fn73arQe9jNzmJ2
 uNiqWSRNV8uzlv+gqTaAeJD8Hvvw0jROWhTgdtHZ56555F9xsKOMnp4t/QkzSvFJ685Uo8dX7
 7pIbOed6YpzFXQHmrIUMSUKn6jvvC7IPgm5obg9QBHQprE2d0uuwJsu3gBcxwkuWbrXXLTO09
 eiwh2vfCSJj4l5mUG+udCgbhQUcAZyCn7GpfN2sTSvw8BMMdxEUPkHGUdVZwZDBn9Bcj4QTH9
 2HmJs5p/xRfdkiiJckWxEZ3+U5FMdiPyC5uBHXIxyMf/k+7s52NZpXZpiGLTG/KuTo7snnTNt
 QUY9v4nXzcjm3LapgjrT2+QEP+p6V5ovN9K/BRoxRtyvsDDXj2RjKOp11U70Pz4NGQAOeKr/w
 kVfJxoY4Fs777TQWkghuU1c8PuCm29VKbQEYfPYc/Qx4XNQ/6LHeVYS9CiO0es4R4evgRGbkg
 +/5/3j41YvZY1C1evxc367qB0h3llP5RFQoTxe0QFdIqJqdOKoyD9eO9T+EFlXsvcXKrV/PEk
 cxhG9utSa503dqT7sRm6jGTdhRfp1tMHpHa1/WrqCCKXArq4l4IWdMF7lzJMUSfx2Qm4RNC6+
 vLI8YS+QzxkbOZ8zJspRZSl8q/UcWQqK0yV7xOzNr4fdSicasocmSH6fimV08ilC9/31i0zZC
 5wVOSGRux4cXzpbZGH7i4f2dyBZLxBu8skAXlCnMO+uS219mhthSNERHXRBcQ4OV0YEokOmLN
 0cDNob+H+h9MrClha/lYxK3BY9kxQbhOK8JXmCkD5VXEAlKgz2CV1PmJSKP2TyPLQxblkW+Nt
 l3ykYhJd79OPhj1B3A9prO+vyyT33viyEFlPXVmia8hfZYFOYZJr3b4wmr1m86TvVQXslpFMX
 bc2F2K9XdOpj16ecToqgt5CZKm0hlhK81c6KDvX4DvQZDJaZYal5Qu/EWVelSlJ84mva6Okeu
 7CDeQ2Hu+SI0NyNrZIaGcHw3KwHyFBwCEEXXB4wHX6j7AbKWXith/psU2dba2RUH/FY768nyP
 D9os5JHkhdU51kUHh
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 5 Mar 2020, Jeff Hostetler wrote:

> On 3/4/2020 4:35 PM, Johannes Schindelin wrote:
> >
> > On Mon, 2 Mar 2020, Emily Shaffer wrote:
> >
> > >   .gitignore                      |   1 +
> > >   Documentation/git-bugreport.txt |  46 ++++++++++++++
> > >   Makefile                        |   5 ++
> > >   bugreport.c                     | 105 ++++++++++++++++++++++++++++=
++++
> > >   command-list.txt                |   1 +
> > >   strbuf.c                        |   4 ++
> > >   strbuf.h                        |   1 +
> > >   t/t0091-bugreport.sh            |  61 +++++++++++++++++++
> > >   8 files changed, 224 insertions(+)
> > >   create mode 100644 Documentation/git-bugreport.txt
> > >   create mode 100644 bugreport.c
> > >   create mode 100755 t/t0091-bugreport.sh
> >
> > Hmm. I am still _quite_ convinced that this would be much better as a
> > built-in. Remember, non-built-ins come with a footprint, and I do not
> > necessarily think that you will want to spend 3MB on a `git-bugreport`
> > executable when you could have it for a couple dozen kilobytes inside
> > `git` instead.
> >
> > Ciao,
> > Dscho
>
> Having this command be a stand-alone exe rather than a builtin allows
> it to have a different linkage.  For example, you could include the
> libcurl and other libraries that are only linked into the transports.
> And then report version numbers for them if you wanted.

While that is true, I would argue that this is quite likely using the
_wrong_ information if the user has a different `git-remote-https` in
their `PATH`. In other words, that information could _mislead_ the
recipient of the bug report.

Now, other people might argue that the different linkage lets
`git-bugreport` maybe work where `git` would fail to load a required
dynamic library. But again, I would counter that this is a false
assumption: since `git-bugreport` relies on `libgit.a`, it essentially
_has_ to have the same linkage as `git`, or a superset thereof.

So: No, I really think this is going the wrong direction.

If we want `bugreport` to be a first-class citizen, we should treat it as
such. That entails making it a built-in. That entails teaching
`git-remote-https` (and potentially other non-builtins) to sprout that
option to enquire other information that should be included in the
generated part of the bug report.

Ciao,
Dscho
