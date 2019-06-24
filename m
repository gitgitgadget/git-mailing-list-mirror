Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3F2D1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfFXJe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:34:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:54705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFXJe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561368889;
        bh=JNXJYyzG/ALQw1C/H4m2+eaEqs21iz67SbCXn2WEsLE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HyxYHUsUdMwiv1pd13P9RS9DIa/Pz9e7QfrTCUg0uuBtMlcItlB7l47aMWQK/EbkO
         8zMmgJZU3jfngSLoHolPyZ/edEjz3Jy7PhLEePflhe27XUXod2gJj1XPaSlZx2Ln0D
         sF6SDXgSZ9OnUB73KaogMNKSltvc70fySsM5BXXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoVvG-1iCjNT1WLC-00gVwi; Mon, 24
 Jun 2019 11:34:49 +0200
Date:   Mon, 24 Jun 2019 11:35:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
In-Reply-To: <20190621205238.GD25874@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1906241133080.44@tvgsbejvaqbjf.bet>
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet> <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com> <xmqqd0j7km7x.fsf@gitster-ct.c.googlers.com>
 <20190621205238.GD25874@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mnc3RaFvdf9H4VmP3dGmzbZhmiqailOvwWeTKUzMl8aOKOhjVXi
 3wCZoFMJox3ZlCWrRiFXbzs0W1ug+s0D2gs5keAe4al2pTkhbuaMVUBAKetDGIgRJlkg+XO
 wdl7g5g8VzkqOmbvhjjKGlq0MpQF/xrdqMWtRlscTX7zpGdANH8oqgLQjOveLLcqALLpVVj
 QsjcjqHDeI1UpmQS5Nb3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qlHuDFmelN0=:KjeKqxdzGY1Q5qMJraxjTa
 bjs+SO998QdljpcvU9McCvTKY7+BoMjWEhF5V8v0DLp44VVicoF1kbZoX3TUY/3/cxwvdkkuc
 Iey4o/lqltUIsuSQN18oKco1WY+QkCnhIuUWOkltja/7mDCFHJ1W+1kdL278fHJC7RVE3sl8G
 p6mYI+wQzMB7IE5GwzjRg6MpbdRghClMDsotid6sBSgOZ4Y87o0uz3f4VRXph6aOhQrTxB/Wo
 53z6x965q9paMZi6R9tjUTBloOmJ5ho/pAgsWadWOG1m45wUZwzIjjD0HXEub3m4RA2pstwYk
 inchZBQuGG7VZ7OQvxxuJaFlgZmkuytP35XpHN6rVhPX122U0bBehayVlT/peGnikoBtGsv0/
 xy04hiykuUhxgPkmoyIbMipC0SraRQhwEUDHHB3Yhnp6YCCWLhdf6YUvXdbzICzQHC+aDAeAM
 HWXl6zF5ENPPttFlIa0UEv2lyBlEjxTcSCDr26eYJdOAv1b6Uhs5Y4rJPjxJ54VGKls/cv0QD
 ZXrx/8cmy2kt0v6PaRrWAI3x8oWIojAkvULc+DmfNX1xT6xB3EHq40AnOmaKc9doQzUIaEUSK
 K/2Ed8G1Texf1AD7ibayfrRBE1BaEI2WB0QhmztLX5RnBkZTYBuzu2zSX7m1K4YB036YWW3HS
 t0QSkmWWw17Rthtycv+BJRO09Z18noCknsE3NPBGoILD5M+KijjhfmdcvPN+toCIjphQUwJa7
 AoXzmV2lpYiqMw1FcZv0+gZTZZ65k1DlLO8uXXdUfM/gVvVG2l7Tp9gF/2ZF1zzAiZOQmTnvT
 FVlQTJcKj/2F7MxYz3qeMxLHzvytlSzp3YSqp1AHwNBnRsMP6S1KkTUADCvMtETcEs7QvKp/4
 XY6CHxkng63UzgbLfplIR6nYAUJ3hxAndfu80LrofKHVMbA0QQLDXk7Ltyh9HQB4cFoktWbxo
 VpyeXzf6cBg1UKjZnLek4NAZLD4zKKasA7pYuID8we2zFuN8bPBPJ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Junio,

On Fri, 21 Jun 2019, Jeff King wrote:

> On Fri, Jun 21, 2019 at 08:10:58AM -0700, Junio C Hamano wrote:
>
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > Considering the amount of code to output these, supporting multiple
> > > formats would be a nightmare. I may be ok with versioning the output
> > > so the tool know what format they need to deal with, but I'd rather
> > > support just one version. For third parties wanting to dig deep, I
> > > think libgit2 would be a much better fit.
> >
> > Yeah, I think starting with --debug=3Djson (or --debug-json) until we
> > see some stability in the output and got comfortable to the idea of
> > "version X" to mean what we output at that point, and then renaming
> > it to "--json" with "version: 1" in the output stream so that third
> > party can use it (and interpret it according to version 1 rules) is
> > the way to go.  Third-party tools are welcome to read --debug-json
> > output as an early-adoption practice waiting for the real thing, but
> > we do not want to be locked into a schema too eary before we are
> > ready.
>
> I should have read the whole thread before responding. I made a similar
> comment to Dscho, so I guess that is now two of us. :)

It is a bit of a chicken-and-egg problem. You want the format to
stabilize. But you also don't want to commit to one final format. And you
choose as option name a deliberately discouraging one, deterring the
(third-party application) developers who could most help you evolve the
format to a sensible and useful stable version.

Ciao,
Dscho
