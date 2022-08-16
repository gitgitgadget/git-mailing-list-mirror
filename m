Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CC3C28B2B
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiHPLLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiHPLKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 07:10:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71046564CE
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660640749;
        bh=wysYBb29vpnJHnSxnEj7tpOJiItKTuuPsYlRCqnoXoo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EKZmDGfWkqlGG/PeUF3b4T7WuO2OPa6Vo3cVptFS8TmJYI/XFErLxkX5hTGmwWY3Q
         QJ0CYslOZw7PKTafDJ0QbZfJ1JUCmTjghzGb3sZFqp6PcNRvPrrYW349QibDxdJRw0
         c8nijovkTWTGYJ61CMxsaUQ9K0rWnPeFxWS0ae/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1ncSHA0IA1-00nvYn; Tue, 16
 Aug 2022 11:05:49 +0200
Date:   Tue, 16 Aug 2022 11:05:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Coverity, was Re: What's cooking in git.git (Oct 2021, #02; Wed,
 6)
In-Reply-To: <YXBALFsf305U8mJs@coredump.intra.peff.net>
Message-ID: <2n33pn8n-7529-443q-rq7n-q12nrqrn8p27@tzk.qr>
References: <xmqqfstdr8b5.fsf@gitster.g> <YV5aaD418SyZqS/1@coredump.intra.peff.net> <YV5dmkkuCqAY2qqG@coredump.intra.peff.net> <YV5yi+AejPGO9qOi@nand.local> <YV/BMkZrj4xQyvUL@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2110080946060.395@tvgsbejvaqbjf.bet>
 <YWC49+xCh+zum8Ms@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2110201416390.56@tvgsbejvaqbjf.bet> <YXBALFsf305U8mJs@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xBiX+KIcI2NYGDu48CHuLrPR4SltXKk8XE5aSKp9b0Eypo0Icti
 1ytMNiTbsf3nRpybKdddcEClj+06kJQRF/IzE8/46Fo3BBun2pQjQ/A8p5efNKD5xLjiHZv
 FC1RvpGHrTfoakk8D44nPimbrcO1TUWsyLW/wIsRjgx8dmLdtDHp/U/8vA19YQIsHVwaFrh
 Rh87FMNc5UmoPujUGL8cA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SoTcUfsBDHo=:cAGQhqb7fTnHH9lig43Sqb
 +7SXTMzO4nScsD+XIJlBq2HGKS+UVhVQG7mbC8gMz5cnC4zu+MLUnlLYNHJW80xJo/rhQM7r9
 LfJzU7xm1S/rfWh9/I1Z0B6+tOFqwhrB+PIZzRWRXylhZ5aKM3DV/bCPhSdgm4lUs1x/+f3/N
 iRRc2aG+P4Dx8OS4wy47drimcw0gUdSvdkAIQMjQOsyhUpMGk1HFy28bfQyY2gbYm+Df+Da+C
 VKYhbUJuVl/qvhm7vXVw7HdxdnCvDDnu81EQGaoQu8E8crDCw0NCWqADKAoaYyTRdEunrdopk
 0FVlUGynpJtDZENlzQ3Ai9Yz6imiRCa/K8LaWxQL9dZFJ0RRZa3fAafC30dZXsE46xS+2jG5a
 L2knHAYGnwUj2+QLqJTxILNMwAeuCHMA6fsPJ1Y7Z44l0RJu2fIErDgrV2RzDh4gfCq6MzXfF
 ILk3OG3Y7j2AhI1Olx+rT/609Ox+s9WSDd6mQbqanYwSYSpSa1899kHyzwUMC5yj/1oKkvABs
 fJM8jxce3s3kAbsSvRz3KXPbhUGjD/bpkBjUEG77Ja4Vew2R3P8xXuHmigeg8ETLYzCB5pe6x
 FTuwv22zl77ys6+r8t6xiy8DdtxAUh/vFgEs5G551fNPevYm6C03Xnh3pCFtNS1J3xUYQtGnv
 VNcXJp00zgVcvFhfjXAjjByk6K7IULJdh7pDIDbN/3e76QtkS/2f9aUfyz6B9ltaLeeK7Va1u
 0LYUDjUFjdXIgSMdcu0IM1vjqF4uku/GWoYCFAi8/5FaoF2HaMVjK4IwcB7jahdxdtkn98JGJ
 rxl7rkYAtrdDn9Htn5/UNSa9gkNW9Sxwrfkmp4KZMuyD4TLo9yg6VXYUXfFjoeMIP0RGFroWp
 VTgqQ4f9lbkj/pLwqBYr7S/ARDrUVtJ8skUs5ZD23xSeeVFwkjV205w9Q4t21uVLWho7aboR4
 C1vhlYECHx0LDCKtWNSuVm3xa3o6hIdyhuTIX4oyCLZWdCY4M4Aoq5qUrTryPL3KApd4U8sSb
 OmIoJYSG0e3ca6DFKgoesSPhwIodqpctn2ktfEFZxzllOoAVyXSJ6tbzM2pTGbuanvuIOH+dU
 G0lkajfDKGXPLLaCHJ2MP6dS3igj37dkevur+bQF8+G9/9LqSIQKO0Hfg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Taylor,

On Wed, 20 Oct 2021, Jeff King wrote:

> On Wed, Oct 20, 2021 at 02:27:30PM +0200, Johannes Schindelin wrote:
>
> > On Fri, 8 Oct 2021, Jeff King wrote:
> >
> > > On Fri, Oct 08, 2021 at 09:51:33AM +0200, Johannes Schindelin wrote:
> > >
> > > > FWIW I have set up an Azure Pipeline to keep Git for Windows'
> > > > `main` branch covered by Coverity:
> > > >
> > > > https://dev.azure.com/git-for-windows/git/_build?definitionId=3D35
> > > >
> > > > It essentially calls into this scripted code:
> > > > https://github.com/git-for-windows/build-extra/blob/4676f286a1ec83=
0a5038b32400808a353dc6c48d/please.sh#L1820-L1915
> > >
> > > Do you have any objection to adding something like the Action I
> > > showed eariler? It would do nothing in git-for-windows/git unless
> > > you set up the right environment, so there shouldn't be any
> > > downside.
> >
> > No objection. I'd just ask to use `${{github.repository}}` instead of
> > hard-coding `peff/git`, and to really not run the workflow unless
> > configured. So something like this:
>
> Yep, those were directions I was planning to take it.
>
> > I am very much in favor of having this in git/git. Do you want to prov=
ide
> > the commit message, or do you want me to shepher this?
>
> I'd be just as happy if you did (I hadn't even looked at it since my
> earlier email).
>
> It sounds like Taylor is volunteering to set up the Coverity side for
> git.git, and I can help him with getting those COVERITY_* variables into
> the GitHub environment.

Given the challenges with Coverity (false positives, lack of support on
Synopsys' side, severely limited access to the reports), and given the
renewed efforts by OSTIF that focus not on Coverity but on CodeQL, I am
in favor of abandoning the idea to integrate Coverity in our GitHub
workflow.

Regarding CodeQL, I am still uncertain what level of integration we will
end up with, and the contacts I am working with are currently all on
vacation, but I am confident that we will have an easier time going
forward with static analysis using CodeQL instead of Coverity.

Ciao,
Dscho
