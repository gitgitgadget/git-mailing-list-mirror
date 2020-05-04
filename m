Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D56C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53239206A4
	for <git@archiver.kernel.org>; Mon,  4 May 2020 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bl93I0w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgEDVYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 17:24:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:52601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgEDVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 17:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588627484;
        bh=t4RUzKhraldPv3NJ7hZ7veQqROsxNF8ktMS9BVlW6zM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bl93I0w4VrqJQ7gsVey9fFdNW/mQHWCyzKejRBy/W/OmFMUjwGne32l02Qz7QDI0r
         a5lOxLHUXf3qKp66XO2JCcfvQwuI4BfAw213Axso/Tn4ST2JFZaPXYt8wJu93QP4M6
         YP4RkfXDHFW1Vlhy4jlHX9ESUbz5FLXWXVx+f29U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.224.161] ([89.1.215.201]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1jNmUy3TRz-009hKB; Mon, 04
 May 2020 23:24:43 +0200
Date:   Mon, 4 May 2020 16:23:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Doug Glidden <41mortimer@gmail.com>, git@vger.kernel.org
Subject: Re: git fast-export not preserving executable permissions?
In-Reply-To: <20200501223240.GG41612@syl.local>
Message-ID: <nycvar.QRO.7.76.6.2005041620540.56@tvgsbejvaqbjf.bet>
References: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com> <20200429184909.GE83442@syl.local> <CAHTRwmhhQCs4i04atAK66REiFJP_9e910MoYMt9iyu2v6S2jVw@mail.gmail.com> <20200501223240.GG41612@syl.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Mbd/eraisZ2GJga88CLlO7icT+0/YENDxIUu74k9g+0FyaxYfi3
 yFgSkTU+2OM9nEkAfRR8M5IE2QXxUPoNInhuKs+1Q86xI6XxidJ9I0Fd9An+YhSojgbtqp3
 LxCoOltHkYtCt0ohaK82HMtcgUOoSEsDLj9wfiURwwNNn3OEX2Phy1Jp1nSfDXMlEys1mCC
 /A0P9NdfepJWJ2FkQdx3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P4MqM4yJ+i0=:xkiMBnROkfGlrH0zhrpS0x
 /k2itww5Y4STsa9x34X9Mbr2qHox9fRn8x3qt7ATjOXV8U4flmfeFyL0ooTBDVTf3bGR0vWTR
 7RenhU2+V6C/4d5Sh3OVOzS/qhOlhbq8Lf9noB8PTIYZXa/Uys4YipZdsjqzQwT2d1+tvD6HV
 6YZKBE6TbQD4OQtGlNBq0u3Ja88wE2niD/9iM/S7blLRKO6KbikhsGrLhrubM7iJaeFDWuKgr
 eQRQOuXBDRewA+YfYrAyxH7Fw34yWH6FHiJC29Fj0fWw+7kFKFZwGQ7LN3jpH7aICF16uQdTD
 Z+W+r5VjeFEBd1Hb9cMHOHP69jyc0NTAu7gKJNEGz0fAJUQuwWadrcXriozBUwXFP/FCbQ6ML
 yYszC0z3A5cRK3g2I3MFu5i1oxnP7iAVGfBBnadqd9IaQQ+83/sO5/tZ/Ir8aGt8/+BWTWCWE
 2xe0L8sBT47Zwcic57fqFcglnywK+/2DY4Kzh+7z2VYRzO4MFoEYh939/436e0qcmblZ0k/Fe
 t4SBM2UWxFPswB2pNg7LzON7UIbxrsmuapjeLkxZVNissoBuixbaIX2J2xrZmkqogouZjkoMk
 KOiesdzD2fK0dKRrQ6LCZovJYZrSOrJq4+MwFUZCpe2bBH8aBAa8lNnP3y6tmLtTbTdOGWUvM
 EPUKrqGu9OjxyPacMyMz2XLW+VIm9r8ujlepvnIZXydnIBekSEpqKYpvWhL7EsMjzX0UNvIeT
 fJvOt0Zx5pgX5kE3xG9rI4vPBR5j3Qx6VuzOyWIB89WuFSSZpmH5kXnyVYyGIO7ojO2frI6hM
 yAXit2+0GfXH233EBHM4HOTBMEfpGJv8c5Hu3JcEq33MjH8mKCnWggur4XUDYqtO/SLMM6cnx
 XBWuS76PaQcTJ2alEm4g+Yp13IDpjM1MlYXlOVtdN24Lk3VDe94gkmWYi7I5h9uWKHOQcuSgd
 habMKJrGs0ccLygVPx370y2W2aTI/hI2B//qGy0kAFeRhxKd9n/MtSlHk8lxGQ58lPXmc4Oja
 14ZFHf28fV12wVj2TE8SG3RXFH3PJ0Xnz9qrjxBocw1cBOEl+n1fB9ie99UhIMxn9MMD0vc93
 PXf46Ez25QXBRd+cyXbE0xSCqwlv+HnMRLD6svlGbxrwKwVevuFKjLhI+vhxShx45ZLG771rm
 LRh87nkYhTlHMPLVdK1J/H0gPOAzPVXsheXh11vrfdXi+oBafsFX6lg0T8axXD7f5twxjdgVT
 BVr5X/zxW8d71GU8H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 1 May 2020, Taylor Blau wrote:

> If you are using NTFS or FAT32, neither of these filesystems support
> execute permission bits. (I am certainly not an expert here, but I know
> that Dscho (cc'd) would be able to answer authoritatively here.)

On Windows, there are indeed no executable bits. A file is considered
executable if it has a file extension indicating it, e.g. `.exe`.

In Git for Windows' Bash (which comes from MSYS2), `ls -l` will also
consider files whose first line is a hash-bang one (e.g. `#!/bin/sh`) as
executable. This information is however _not_ used by Git.

If you want to mark a file as executable in Git for Windows, you will have
to use `git add --chmod=+x <file>`.

Ciao,
Johannes
