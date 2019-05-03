Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67871F453
	for <e@80x24.org>; Fri,  3 May 2019 08:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfECIm4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:42:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:34991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECIm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556872969;
        bh=yjVRVsNREZwgYClV5shG2ucVpSvMt7WIGq7nOpEHuXY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Rui1hRet6UDmOya7VZiQ7ZmRX8C3HKS9B3E0O04MhiT6KYz4Un03aMkhZtQ5quGJe
         H1wvY4dlKSpwGCTNcJbls4S6KImJE1T8oMimQ+qI/muFNdGvKMqclRzo4c9nColthu
         QGAyV5zh2tZ0rjxfOKRgPDxSyLEsuQkGJosXuBxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1gp2ht3ueX-00gF6I; Fri, 03
 May 2019 10:42:49 +0200
Date:   Fri, 3 May 2019 10:42:47 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for
 transport
In-Reply-To: <890578de-6286-1726-37fc-d05bf4b359df@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1905031041590.45@tvgsbejvaqbjf.bet>
References: <pull.137.git.gitgitgadget@gmail.com> <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com> <CAPig+cT1EP+HC5h4e0NGCu=1i6cZXPxERRgnnAdZJn+XeqpbFw@mail.gmail.com> <nycvar.QRO.7.76.6.1904291916510.45@tvgsbejvaqbjf.bet>
 <b8e799e2-356d-2a03-faa4-2792ec1b171d@kdbg.org> <nycvar.QRO.7.76.6.1904301832500.45@tvgsbejvaqbjf.bet> <890578de-6286-1726-37fc-d05bf4b359df@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PWM1e3iuTOVUevgQLkCepLb4qpqIFMVp5Jityp9pN90q16ISbJC
 CWJ3wSq3FoBMwfP8ziZzzRqVSXi8DvhcJt7IfxnkO7XyIhpdfo1+lrdZsEgfr8rbsPSmdi+
 gIoBlsuZ0XpTV6GwYlV4ulnQ3DbIVsN/nSQupCpouhqjH3sc0C50oOf1q5eOg0kaUCw/tOL
 wyOoe76iexqWkqoX7e4PQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RFztcbp8hiU=:C/nyAYLeOKwOcmFROz6WwQ
 qh6+a+eACQbpjQHhzE5clTyZPTlKxx2BGGYPNP0CNVYsfaXZSNyFqAiwUfF+fPVqCc5bt3x9O
 DvswNK0pg8jpdPZ2tUREfJGflmzKxpOHLpHzEs1xAylrYEC6t0oA7QInfMoRBdWyTsZbWOMVy
 YlMZDSNe+ovKwkGjT1pI24SWW0XbMCIdgVP6AlJplAjyJlnyJ6PBIeuL9jySb+sI8Y3JaOLwU
 7Ry1VV3qvUvbKwyLuA8wvPAtTkwbe3AeCKvkhdJGmx94LlF+EhQ865A11pXqWIDNse2UnRo+e
 C26jnRsn3MWYCogCBq8OuOjsjYxF2K3iHGmyYlVKnVo0eLIPDNpghRZvPdaSi7WxEl5FvWPCH
 Tf9HLXLHG7JkVf4G3IZf5aRAq3Jh9QEACm4T2/AmcAAug57iCDhzTxpuB5GF1rcnugb/DBiAg
 qTE8WzKrnDMIpcnyNqbCHty7OAOqJ4wJ7NN6wBWwWtnE/jJBwz1kmILRryn95mGstvUnQL4V5
 4dKkq9BSB1deBdqUbpfBBHMVRNK32NMa1rbppJfyF2hMg0hSPnSYQlix1ubh9n7j4vqWCOXWI
 HRDJhoFzeGViQrU0s09M/yKVA13ggE0ob+V3uqpwJlGS4k98AildhuL0ueO53cCsaOgF4vGZG
 Tm6HgNSIKlIpTS81xFzAu3gUPPRIa7oTVNvNRBCi5NOpJhd8bFQ+TPt7PMNLMH5hkaJ/9WoQ4
 4Lr+4INumORSCrAXlyM0LsoyLI7xBQbPFzSnepYrSto7BMXm3p9gNcriPrPGcn4xFwHbaYZ/C
 C00yHXL6FG/68ln6lzPn2xL1LYORMB0EdUuQ6TZytlbrnjrPpdmJy3LGzraqo3FedcRe+b4uE
 xFdnl9j2bHthXrttm1N2jbwmpoGeAS1R4E/FMg5lTRWN2BBUuoQRuzxqptBiSgPEOl7FMinLW
 nxxZeVxABng==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 1 May 2019, Johannes Sixt wrote:

> Am 01.05.19 um 00:33 schrieb Johannes Schindelin:
> > On Tue, 30 Apr 2019, Johannes Sixt wrote:
> >> Am 30.04.19 um 01:17 schrieb Johannes Schindelin:
> >>> You're right, this is confusing, especially since Git for Windows 2.=
x does
> >>> not have that bug.
> >>
> >> If there is no bug, why do we need the patch?
> >
> > I thought you of all people (building with the ancient MSys/MINGW
> > toolchains) would benefit from it :-)
> >
> > But if even you don't want it, I'll gladly drop it from Git for Window=
s'
> > patches and be done with it.
>
> Ah, this is only for the ancient MinGW! I do indeed not mind if you drop
> it as I have updated my toolchain to the one you provide long ago.

Okay then, let's drop this!

Ciao,
Dscho
