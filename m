Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99238C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348094AbhLBRgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:36:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:34019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346939AbhLBRgv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638466405;
        bh=Qg1T2g6oh/ZB1IkQhf+g4M3s/055MZCZZ7DwcFOGiEU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aC1zT3xL5pdWWVEFmtMAlHEEd5fKSJYz1euejnFTchig1UZ/z8fo+UQf1UWxNgiNa
         6sYdR2EJotZ1vvCJtygkvfEzO2caXHiEnUbg1wLG9oLCCEQKtZWpZTtDOs+1mbTwrd
         b9hE19HiNvD/JpCJg0uaWsIf4NJOLa/OPk7hSPWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1nGIUs1v1z-00NzBl; Thu, 02
 Dec 2021 18:33:25 +0100
Date:   Thu, 2 Dec 2021 18:33:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
In-Reply-To: <CAPUEsphxCcfOgPQP9ci6sSn87g5=w+8kjh21=QywTX=on5vTdw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112021832060.63@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <CAPUEsphxCcfOgPQP9ci6sSn87g5=w+8kjh21=QywTX=on5vTdw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gcqmg0Vt8tLSIiMvBx68Lx1Hq8XXvanmtCTJ0GhO40s3TtQcg+y
 dsn+5JopnKBMhEC5xFFcR79Ww1UUINQczr2HPQwRgvd+eAEzZSg/68zTIMQS2XzPr+BHoT4
 HhxmmBqPe+TdydjVREPaywTRzV1QrQhBA2X1rqujv6Vvu3EJeN3jrFxwvUo7ejzq+BlC2vF
 c+Nbz1kIF6YcG3oZivulg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/btXbZNCH5Q=:BYVIZPsDFX1cyaf7vF9uyB
 TyoJdsRu699fmwE0d/4HycXZv3B9BMs4s3ued11eF/7iXxMBNQii+gQ/HQ4OmdAg+CRQT+szd
 g1emDHm4qkpgaUEPCEfe76Vv/aEKXvvvUmvxjw9yo4wIRhZdivnUnbdu4i9VxgjJzc3XZb4Qo
 IHKNcbPkTAx+ZNF3Bcm5F8q/J2Emu1auoPrBcFOGiuVdwYJdKs9o/Bk7z2C1FwAtrgDzNg5V8
 bEsHoE9DWEIeweIu8mwRnablNxB9ckaqbsB9Ktt5WCrY45jmRE9Oyj9caEqljZlhuai2NEVQL
 qfJvrQ6iAjvRx+ve5FTzwQcDiXcT3XeBovPrFRtpUJocgaMSg2L0jyCpJGYsCqFkcEZnDEBvB
 GG+Far2b0EsweAQyh8aO/CzT+ta8/+R80gF+UWh9vaULk16ugEJzINMiGUCUSAzTBSp5f+REl
 EZWUPy50YloPhjlLj/vWR0oq1jTxAnq2Y+UZPVq9+rz0o1i+u/ur0d1Q512qqsh41+DGOuwf+
 kMu1FIrGTYXY74GTJbe492wq+BWw566wbqt6bQsCTNPxVXTBqOX+4M8t+AwsYxI0RjAbLKK+t
 jSAziza5h4WtRg/lOJ2KsZyIamoIA7NoE7wAbjjOqOgVCd6xfMzoNdM5h/3GuUgxu8GBDofSG
 XtsuKrXeAzFUhe+6ZpeMe4Rv+CyVzaVSBmRPM+/yGSTmemmOuGpHtTPbAav61RqKzL+JyR3/w
 9j1qXpFxB4gvNbn2OBNoCsJKTqhb3bQVPkjwLJA3RuMgbQKPg8iBHrImP+TF9zwalfPlb285t
 AbFn2pezR0nyf31E9LMkptjSS0rDvysMrisuc0CpXOdw9lfKfxNAwvYkcdk13Ye1mK5BiHfaQ
 VJTUmPFEGzlaRnnpr9FRgkj8VgQIN4Wt4CLxgOdXZqFlc20LniomNCMGjIf3JE4HKd+5N2xJU
 nrtrCglHxscXgTiNsu2jiWsSR0iWJdtPI9wy68KkINyVO0xL1Gx6xxWjkJSVk2Vr9jZ6pGgeS
 cJXsZM9Xyjg4TzjiKZaNEb1GhJnbgEGYV70S9i51bhx5LPN5wFC2ZTSEOFl5IgTfIG8XcI/zM
 K4cR/EKcUE9jgI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Wed, 1 Dec 2021, Carlo Arenas wrote:

> On Wed, Dec 1, 2021 at 12:40 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > It is time to declare this implementation robust, to use it by default=
, and
> > to start deprecating the scripted implementation.
> >
> > Johannes Schindelin (2):
> >   t2016: require the PERL prereq only when necessary
> >   add -i: default to the built-in implementation
>
> Sadly this implementation has a few bugs that still need fixing, with
> at least one IMHO being a showstopper.
>
> The way macOS implements stdin (through a device) it will always
> timeout in poll(), so escape keys that are left in the unread buffer
> and that could match some of the entries will result in the wrong
> entry being selected.
>
> I have a series[1] that reimplements this and that seemed to work fine
> in my tests while making the code simpler, but that I didn't
> prioritize (and wanted to clean up further) since I wanted to
> prioritize the EDITOR fixes in the same area.
>
> Carlo
>
> [1] https://github.com/git/git/pull/1150

Thank you for pointing that out. I agree both with prioritizing your macOS
patches, and with prioritizing the editor patches before that. Please just
let me know when would be a good time to move forward with this here patch
series.

Thank you,
Dscho
