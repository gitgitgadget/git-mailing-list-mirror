Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB84C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86DF32070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 19:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gy1OKlhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbgFJTU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:20:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:60073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgFJTU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 15:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591816852;
        bh=HmKjq9CpwzLHZySK2q2EElBV0HmyQPQHtCeY+qWnrSY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gy1OKlhgilXuFVFrvO3ocUxLrv7bTxCBzniYSFG2TgMEI1eZ4KYUdXaxtjp8CdLzc
         QhEmmtipeDN1UspRKuzMwBMO2XDjq7n65fHDiIq/R0hYNmxD+dkkGqoCHJ6PWqiYL2
         kgZlRxzm9QeO529aN9QrBLwPJAcwYkT6zJ/AvY04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([213.196.213.108]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfNf-1iw61r0T9j-00v7Xq; Wed, 10
 Jun 2020 21:20:52 +0200
Date:   Wed, 10 Jun 2020 21:20:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
In-Reply-To: <CAFQ2z_M5ffb1O4R1wMxMH7qxDog+pZwDJX1Nd_ujBr+_nChupg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006102111420.56@tvgsbejvaqbjf.bet>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com> <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <xmqq7dwfhlwt.fsf@gitster.c.googlers.com> <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com> <xmqqimfyg84j.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006102056530.56@tvgsbejvaqbjf.bet> <CAFQ2z_M5ffb1O4R1wMxMH7qxDog+pZwDJX1Nd_ujBr+_nChupg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <nycvar.QRO.7.76.6.2006102111511.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:eX5ngQxrqAy0iYKTg7q4/Ymm3mrFHXmkA7ixJvo2YdhaExhfoOT
 Ja++UJWJY9hKMRU3smoq3phH/dKXGhETvqVv6wDjFL6qQeDu2p81wAnUh0CCoCNyryv5I31
 chzwa0nDeP5QW11GHv2uM536CRrdWVORJ6LLn2889W1lKkccrug74Stg3zimrBXgopX0q3t
 B+AOXSKWN5wGEU3T+BCsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AobfyheZ+eM=:kwT+B6TcwGtPwSeOnSuIzK
 6HXAckG3DBEhTb1I2T9y4xDUCTixn/MaiVgLpK1Hl6bHxMGQ10Qoa4t6eyqjQHSI4A7CUxDdi
 F9vqq20LGYEK8yr8SOVt3LMBDiIbV2nwFodPc7qgGd9IaiyI3oNo4hppmGzhsXjwdYUuWr51F
 J5sITR4cLVlSvE9zweiH5xewFlPveY/BD+aa9zbwqFFYO8XhAGPZs/ppEKg3TmgpYrGsPr1pz
 Qw13n3PmP3tCApUJFTxxEdfoxJVsDpJXmHAmTAmQKTD/6WghZO0TbVh16Q9PKCWdEyY8POd2T
 woAwkKDGUI8nngRkKJ2iwz2zVCMnMkPdEJ7gmTSHPkyx5dVUXNJo0pXvptltADOIq54EjM+EP
 kAEycEXlz26ATfDme7HIB6VyGmas1Kak569kcu2zXKFZ0ZmZNzDtYtykKCOZMxKFYq5n4f25X
 AqUmwhMyP1hEpiFKAl9YKXXk8OjeLZL46RaJf2XdT+R9rIHlOTIwP9pw9LsthuPTcOFMHaFBE
 xhOzvzzXegwSrLI4qwAj+JLjfnTegKVwWkDkqFm1gscOlt71FTfCQZDlYFgQZwakaNrxHMBPP
 skEYX6fahOWrKpHJWZR9GwxX10AA2t7BGjeqPPMmbzGRVD6hY4NlpoN2SN7sj5ALirV4TVObj
 TYQ9nMMwrtKBHsQLdKvH1U7mwLEGhtYockeUAj5gN0zv8l+2+ZTSxDENgWtJ8xoTws4l+vEYP
 54hJDuS+EcxylCV/Pw6DkALEW6+fFbBR8waxBUbdOke302h4v/9hJQqdkda6yVPXXwCi7DljM
 6QctFX5aLnh2ihMhCTm/bDjDEY9Hyg5bmOdBJK4IA5GjSzC4wzzMe+x4caTFYsSzqYiPregBG
 KeQbVmQvhDFaqc/wexD1O0SgUERVMBErDeiOpQo00f+N0QldXR8FKN0k+4MX10s4fMdIYSchR
 w8eq1kTu9G/3eU1FuO8C2VS9iMMo4+bUczxL4/hxFwC5nhaXuYu2yu/WYJ9rOaOxaUKEOl2VU
 Ihtsq+STSqAZh1GuiXJepAuPHV4pk32eaC+v5RKfYgizRpCzRAvIJ6MeOn3pNgTQ/OCyyLLUP
 T3tJ6oEVeiMOuGVNaI7H1ltid1Bm55lQtZL5eXxcpqsCjSgC7pUrX5qnYGTs0uKu8gDVRMjS4
 f/6GMMtEvNtKL+IQKrVbJrPhuh6iMtwnlN8Ij+P2ez5WIoY92UNid7prSBXXB2WiD9weguM7N
 OWWZRQWyp7Zs1r5a6
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Wed, 10 Jun 2020, Han-Wen Nienhuys wrote:

> On Wed, Jun 10, 2020 at 8:59 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > > I am reasonably sure we use opendir() to iterate over existing files
> > > and subdirectories in a directory (e.g. in the codepaths to
> > > enumerate loose object files in .git/objects/??/ directories).
> > >
> > > I do not offhand know we also use fdopendir() elsewhere.  I strongly
> > > suspect we do not.  Perhaps some platforms do POSIX.1-2001 but not
> > > ready for POSIX.1-2008 or something silly like that?
> >
> > We don't. We also do not use `unlinkat()`. And we generally use
> > `remove_dir_recursively()` instead of implementing a separate version =
of
> > it that only handles one directory level ;-)
> >
> > This is what I needed in Git for Windows' `shears/pu` branch to make i=
t
> > compile again:
>
> Thanks Dscho. Last time I folded a fix into
> github.com/google/reftable, you seemed quite upset.

I was not upset. I just pointed out how unnecessarily difficult and
cumbersome it is to have this ever-growing patch, with the _actual_ commit
history completely elsewhere.

My assessment has not changed, and the situation has not changed, and does
not look like it will change, so I'll just keep quiet from now on.

:-)

> How should I proceed with this fixup?

That's for you to decide, not for me. My suggestions in the past seem not
to have pleased you, so in the interest of keeping our relationship
friendly, I will refrain from adding more suggestions.

Ciao,
Johannes
