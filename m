Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF957C433FE
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 13:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiAJNEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 08:04:55 -0500
Received: from mout.gmx.net ([212.227.17.22]:42053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236163AbiAJNDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 08:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641819783;
        bh=weWjyMuNnjlcol4nOhreusTcxn09c2kgk49/fdfsb4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hpMa3NsYLPorBf0qqn1KVxOOri5/rkwna77xSJOdbJKIjCMVugjNg3yI4mMbcItnH
         iTsTaA/Ecfr++Ao7witmr3hKhAOB03ne3csEMdjz3KhPZT3gRAgvGuszkFlkN291Na
         sL2QzGt3lEmiJmmGGLKP+3extiKN7ELoy5AIbBGk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1mRnsz1OHa-00gWWw; Mon, 10
 Jan 2022 14:03:03 +0100
Date:   Mon, 10 Jan 2022 14:03:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Why GitGitGadget does not use Sender:, was Re: Review process
 improvements
In-Reply-To: <xmqqh7b0juk5.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2201101401530.339@tvgsbejvaqbjf.bet>
References: <YbvBvch8JcHED+A9@google.com>        <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>        <211222.86ee65pb60.gmgdl@evledraar.gmail.com>        <20211222154534.b2gb22ghn2mpyeur@meerkat.local> <xmqqh7b0juk5.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q9KIisLV+G9Un9qgdRXJuCaWX+Wk3eDRObqbNCB124PfdJXESit
 m1PpNYh76qsR7VY2lE/MjskREHXVGIT5ORRQLrUqBxIszvBNSSUAL+aj7oq/5/97jofJoUV
 aXuaUKl8pxHv1blhLMnuTYaGmcyr/lrXEChQaFcM1paq5doARM4ZlIBWPa1rI/XeeIQ+TL4
 lQwwXLe8OiV4F50hh4WmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQln+ulfdKk=:FSTtw4wM9+ao4fovW2hdey
 B+M4Z01S+wcYx2C9G7fJ1Ew3vievAaALaBU7SuI6jkrj2fssQ+2WyYR/50qLbtHnH3FJf25Lc
 93lxyrFa+hprP4iecqM8HlCEmmCdOgRwPjkyzGZtj2AuXjRTNVgBaKoLmIXbxBYTIxcGCNo8A
 yljKCp3OFrxJwD11NT6fEeblK46/QqW8Jlz3654Y434Y5ihgEegFTntXN9FPQb04hWEso5m7k
 DhmXpmo74pNbfMzVVaQkwEJH/rmmah2xz1gy9ZOuQdAl1wqeYrS9rYFwSFHC+G65hNM+5+mSr
 yRdZKU/NIVCbNFBoS7q3hAPkahQk/E+Ix7ztkUVLKdzMM8aCybaIkUTTJAShsLRsLKRbo8idg
 XKoCmwW3w50Tn1GZ4Cecyc3yqQu0a9hWTxRIRZ8cv4o1kZHaL7ex8w/37WSLre/JOgVNxj1Im
 SEkpSAC6PolK2q7lZYB+NTKfBm875NGCdxKcrZCjh3csDUi+PCT/x+u2GZSoR4g+MHti5uB0P
 YIb/i8krcT8pcESM/nkMLAx0khMWWoF6yvU0+VDx0ZzZpR59rW8zF4hd9EaMN6VnvidHVP/39
 WycdB4DLQkfpfy9nBpc8wdpbEiCnkkJcC3km5KLwwjptr9+mDHBA2Adm+33VTMaekv1mXBQMt
 B7CxBGIX+uVqbXzq9U9HulGRnWx9XekHnpNeTcN7QVzLK74HjlaB0VpevLaniqOgeNPb9uF25
 X17detCSIjQoSMWcuF3tMUlR92mrKlOQVN0+O82ZQaFuKxcW9kE1PAEwvBlj82LisKEI+X8v6
 MNZ1hmE18WWzMwRCRt7DVtXsqEBYwr+tobm4+pfr5KrBKjpNCyKxgO5A9acT3swuGm0CisfYo
 DiyGPKNLuN6zaOSY9r/juT8apNBerVzgVFqpBtgz0BgR9ZiVq9qgyHH+p4o1zAvMQH3Z/yLSR
 DQV+oKnBoS8HTwuDp4tMcxQGOGMEvDgW5duSa8i6B5Vm04LUZ3GzZGTOL/Bbm1F28rvFZy2wF
 SlsZkpTekLEVb41pS24KH1NKCAXBQKtK28+MNARIDbWSkA0+sM4EYgQxXDH3H4Xh7Pxvuk6AZ
 IVaYdKCCu5d+Xo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 22 Dec 2021, Junio C Hamano wrote:

> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
>
> > This would require pretending that we're authorized to send mail from =
the
> > domain name of the commit author, so this unfortunately won't work (an=
d hence
> > the reason why GGG does it this way). E.g. say you have:
> >
> > From: foo@redhat.com
> > Subject: [PATCH] Fix foo
>
> Would it help to use "Sender:"?

You had suggested that before, and I explained why it does not work in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2008241445200.56@tvgsbejvaqb=
jf.bet/.
The gist is: GMail interferes with your cunning plan.

> When GGG or any other automation are trying to send e-mail on behalf of
> the person shown on "From:", I thought that it is the mechanism for them
> to use to identify themselves.

Ciao,
Dscho
