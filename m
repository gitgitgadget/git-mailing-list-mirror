Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09536C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 04:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE91D613B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 04:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhEFEfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 00:35:33 -0400
Received: from mout.web.de ([212.227.15.3]:36175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhEFEfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 00:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1620275670;
        bh=hIxbQbALnZp82ydrXePPiadd7ydrokNTDU6HVf8SklU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oWhkBN/NebEaWLSHhP6h0XQ2Sic7VQBqU/s40wgUvqKyy+f1gjpHJIIqn0CmYU32r
         cDSqvmeuvQuQ+YImPDiN3+v0qodaCxRkIlCDHSlNA3hBRu3JtCL2YGQZOdbsO9E2g5
         1A6eEBFxM0PMCmJhP/O/hkexowJWjCYAf8KCmPZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjFu-1lKDuO0hsQ-00yFDH; Thu, 06
 May 2021 06:34:30 +0200
Date:   Thu, 6 May 2021 06:34:29 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <20210506043429.zqgzxjrj643avrns@tb-raspi4>
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
 <20210504151954.aczbvml4rh7t2svc@tb-raspi4>
 <xmqqtuni58ra.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqtuni58ra.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:m57DscGfWiq12Eu+dORj3VJSGUMUuvzegWRmGf0COATCkkTrSNT
 hRQI15pT1POFoTWev9o9VJaLj/zeKkGTXw68E1wgwl02MbK32TozCPsgbA1MlgjEg2TkiCg
 6+RAO2M9uD6zXCvehjSkBP/8vH6bhfnPUGS+kvGv2+mu+XOewCE+gLi8Io4tDPCLFVzc4bk
 JbAFx3XVWU0QLfLMBIlwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mg7Iv+nhqgM=:p5IlG7eyLyjtswLwLZEnAv
 0yzi7rI8AYALO33iT6xaWf+DSu05iAf4mkkbmDiV/vadXif8O10VB/3FohEMNhmq922TGYdAy
 VwMD4OseD/d9tx66U+6XFDDgB4ua3EwfCfEna3+YHL3eyPNPOFxP0caxKVwlotM0w5K/pnBIe
 EEqj1FoAzGFYPHFH5EzTbI8O8SIKlZ1Mq1kklqVi6FOaUslEStij7jY00IqScgtBTwtEuOcYR
 62zmMve7r2qXKxb44Pts9Fu9V7p/diWzczps0enHH4eq+aig/ZJBq+R1QTgIrjzJ1GwVwRsaZ
 HEGBccj25k2ZmiBYYkX2LHXfstafPgqMpIahyRS8fH+3Rhm32bXQmEvSFKGBV/Me4j1mStZ2M
 wCm26kHPEf00uengnkfBO4FzNrlHEBUnyEa/QyUtYEbgo3hwYNXNvLpcbe2Z1vlmpkeQCR7Np
 bepuKgjqUAlrsGjCfTSqswcudzzFRxaREJD+2OK3e0ZCmCvkv/wSjIlQRfk4XTFPH6YxnptZo
 cZgh9R85q1T/F4LTcruUWoIXBYhkkFNJQT0vyQV4talwHgwgnp4AZxjm0Lma/mAp4BwaBn+KB
 wVZWyZ8G3s8BN3Rp9ELbkrmKdXXJUMH9to1UHGlusXb+1r97OyTzei4Kzl5NAQGRZzDVVpHCd
 VpFt03ZLnQRUTGXYmPrpM0iISF3c9VO29ofL35pbHH0f9Pm5+E5ghXDEVNaQ06+yZAZny16Km
 dh2H15cliPmimO0ufB5YWCCQoBl63CEh8Zrg5Rm7aCC3wG08fb/WGoTblmn90PRxruMCNybaI
 2AQYlhryADaJX+aqKn1Sgn0Qc554age+Xht2GJLiBu1Cb+OfQRYPeoID6Ux25zafnSSSa0p4i
 YqgNc5M7WBxcGjGs0eAP4VoNvv4tF1Uytu/bergiBaLPFD6kpGwapLdhyhqYxPIoL3C2sODMM
 vhBgd9la311jRX99TzoIzPLK8y6cI+Axr4+c8S1LMX2LwQBA8kSpPqbYaa1cvcCQvZ94gRZQI
 xWWQ8u9V/rXaZj6n3/HR6Jk8lXoyPDcpZ8o0qLPxJx8B8WxZTESOX4VjjOETrcfxmrtb4CAeM
 6S1DzIEtbnzqOvo5IiP+qdZpmpJ0PQ+vG/pztsrtTQJvPNjZmv6D8Td4QNvVSqW9KG5ruoqj1
 jDxw8WTsdyQMr1aSbCftnoS0Df1MbMvi7qO95xCgrVhCrwMIpIlgveqHuEBUnQV+DzaXs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 09:23:05AM +0900, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > To my undestanding we try to rename
> > foo/ into FOO/.
> > But because FOO/ already "exists" as directory,
> > Git tries to move foo/ into FOO/foo, which fails.
> >
> > And no, the problem is probably not restricted to MacOs,
> > Windows and all case-insenstive file systems should show
> > the same, but I haven't tested yet, so it's more a suspicion.
> >
> > The following diff allows to move foo/ into FOO/
> > If someone wants to make a patch out if, that would be good.
>
> Is strcasecmp() sufficient for macOS whose filesystem has not just
> case insensitivity but UTF-8 normalization issues?
>

Strictly speaking: no.

The Git code doesn't handle UTF-8 uppper/lower case at all:
git mv bar.txt BAR.TXT works because strcasecmp() is catching it.

git mv b=E4r.txt B=C4R.TXT needs the long way:
git mv b=E4r.txt baer.txt && git mv baer.txt B=C4R.TXT

We have been restricting the case-change-is-allowed to ASCII filenames
all the time.
There is no information, which code points map onto each other in Git,
since this is all file system dependent.
NTFS has one way, HFS+, APFS another, VFAT a third one, and if I expose
ext4 via SAMBA we probably have another one.
Not mentioniong that ext4 can be use case-insensitve on later Linux kernel=
s,
which sticks to unicode.
Or Git repos running on machines using ISO-8859-1, those should be rare th=
ese
days.

That said, people are renaming files in ASCII only and are happy,
and in that sense renaming directories in ASCII can be supported
without major hassle.

And the inode approach mentioned as well:
This could go on top of strcasecmp() to cover non-ASCII filenames
or other oddities, if someone implements it.


