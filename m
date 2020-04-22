Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26252C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000CB20787
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ni+zKpbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDVL1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:27:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:41169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgDVL1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 07:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587554859;
        bh=50u3zuAENxCfzxqMaCNr1Xm/qij5ngaFJHzKrK+UwoA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ni+zKpbAzgtDmnm+O+iLTF9IRkXIuXSqzfw5orsNOZwhHM1rulyg26bClScAy9vRS
         VEtmh2lZ78XhU9SufveKl/UfWYdSfIkRfFZRz4AWtojz3lkMoQMNMqKiu+nk52EUHE
         nRD9/4qkrcqPgOyVu+ETsPW2C8QARuSD16SUrqK0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.165]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTRMs-1jdLZ03SbU-00TkjJ; Wed, 22 Apr 2020 13:27:38 +0200
Date:   Wed, 22 Apr 2020 13:27:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [gitgitgadget/git] Reftable support git-core (#539)
In-Reply-To: <CAOw_e7azo1Wb9RO=7kH8kXp4RxTzD6SW4a9w_2ifiGxUmt2YKw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004221327020.46@tvgsbejvaqbjf.bet>
References: <gitgitgadget/git/pull/539@github.com> <gitgitgadget/git/pull/539/c615547763@github.com> <CAOw_e7azo1Wb9RO=7kH8kXp4RxTzD6SW4a9w_2ifiGxUmt2YKw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AHIqD35fqfHEp2ekUWtVdWGNeTO1xoUcaM8tAA09ILT6qcMDk1B
 N558efZhaNYqrMkXJHde0bWwAJWcBxRMlJsHtHOwC4TZIoWiK3QzqMjmwKWGhhex5X1IG/j
 YoHDoVWx2PwgX15Zs+Y5/rD4wIX2ri/JN18cfCQwnEZxO4Yqe0r0BWMb7pync1h5dKR4gnC
 xnV1R+EI85W5wO0YIumKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Skq6l8EZm48=:J349esif/ty0oibazlUdAa
 3gqTLxoKgteAriM8zPuM62tlEttEojxMlDlxWt58DGGgMwkX8bw+Y/vcnghK3E8U0dChzSGdu
 JWpxENFFwGNf/pAXnIcqMnTSLAN9n6h34dIX/Q2GH76ngH/TLfMjPYnvvf1jkqZ3ZN9D+y5lO
 sDxghUJ3b6ZWgZIj3+A+wFCwMA1c6wRz2xEOn0PR6pCm8TXTlu9AEy1Lvz2HFNCQyZZI+6p4q
 nyHRGnY+OexoGRuP90iSnlY/1H0XGeDTJG8yMYtz+5ewIFMWsY8QJd2Awo91sjc1aQrZsDDHX
 N4ygC+YYtYhSFBVu9Ar58bowsvQwsfViT+RjzE5CEpMBLXkaJqw9OFOt6Vgoq7KnKVcxv8keu
 zbevsEIcUaQla9Lq/GceEo6PMqCDEXaNOTI1VpXdXFI3EAvdS2WwDWYYw/C1CmkZdmDXory17
 qY5wAtHpkpLUYLbtDnj4T3fGv+iFdvVEUVVHKXSqYdQaP3Xc7s2RuypvwZTcWwcwG0JQx06j2
 DJMvhSZCUVD4ZQjWbrzVz6gv1Lvrf4rN8N6c0pbbgPDjBez7broSe5luYyIyH+b0zP+5ouImd
 GscBru3HEyv3BqsvvPndTe61ys8LlaSVXZFv8pD/ZHVCAfs9HgvH1aVD8t/9yWdtEcNP60Tfo
 M7uIeqL/SPXhvWk0Q1YpAfkAmp8/5qIFXZRzZssUtfI5R1OTSSTcPbgly+0vFcKhmHQYe/AI8
 oHoMX1Kc5Jl84Hu8KjiSgcMsp0g+Lt9nJownWQHN6dEYmGJxzBYKz9h0iLSVB9IbO/9/ZIDOA
 zZJNTU/mop9BdczhTFQ0W1d0Yk1eXccPNkswlyse4tly3aOyTpwQkMmKchjEzAcfWU2kmKkSt
 gdE7HLfgClVxCEPdQK5rnyPTgNGwuKKPKzNX9kr2SJxUWl6YgfBIzff8He9SDbVwcfFn7h3uB
 eCb9lhA1HWt0o8tnTU7DSZxQYZK+TvwfwOmkFuBHk43iRU2+TFcZcqkNC3MEe1iZFSoB/aRUJ
 TyM7HPIbN1dZAtPnzJy8TjZCU3kuNqmavMkTUIkP6BmLMpEgZurmaS0u2AXUWyOwJeUGdQElw
 t9jGe8be6zHAILwtIRDoYeYbWFMdGPkUM2OVrLarxcby/9X7Y+ZnhdF2fUQlBDZPaSFkseVgW
 PkH+i4n0JgcD2INukem23FPJMm3/wh8A8tZpBXBfNH9hGqYmPvoOg3FmKjlwdgBimgXFGMo+r
 dWiBUfe8dOdaLM5fy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Mon, 20 Apr 2020, Han-Wen Nienhuys wrote:

> On Sat, Apr 18, 2020 at 5:26 AM gitgitgadget[bot] <notifications@github.=
com>
> wrote:
>
> > On the Git mailing list
> > <https://lore.kernel.org/git/20200418032252.GA9169@danh.dev>, Danh Doa=
n
> > wrote (reply to this
> > <https://github.com/gitgitgadget/gitgitgadget/wiki/ReplyToThis>):
> >
> > On 2020-04-15 16:29:33-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > > "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > >
> > > > This adds the reftable library, and hooks it up as a ref backend.
> > >
> > > Since I queued the topic to 'pu', I needed to apply these fix-up
> > > patches on top.  The change to the Makefile is about "make clean"
> > > which forgot to clean the reftable library.  All the rest are ws
> > > clean-ups.
> > >
> > > There are build breakages reported on Windows, with possible fixes
> > > (which IIRC were reported to segfault X-<), but I do not have URL or
> > > message-IDs handy.
> >
> > FYI, it's also segfault in Linux even if only the test is applied.
> > IOW, the code to fix breakages on Windows doesn't affect the segfault.
> >
> > Here is the message: <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf=
.bet>
> >
> >
> Thanks for the reference. I'll look into it.
>
> Johannes, if you have specific comments about the reftable patch, please
> include me (hanwen@google.com) explicitly on your messages.

Sorry, I forgot. Will try to do better next time.

Ciao,
Dscho
