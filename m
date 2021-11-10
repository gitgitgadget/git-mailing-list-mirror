Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA2C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378F8611ED
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhKJOrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:47:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:36301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231551AbhKJOrp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636555479;
        bh=YgLa83kYk4ZlVqr58PHMutPAufPRProtfmuAlM/Hrt8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ip2fwpiMcXyZ8p9shsHAQ3HPL2kZf2t0gxt3yI8kqkpDEbR9VutMSB7MrFipS/8gI
         J+r8HEkCjxOpsD4Wux0H7S22N/KFIQw9m468ch+M8omPuhOUsQrdSaGp2ZsbEGtlpU
         wM7NfZo8TldGBO9SKNKemFIJZ5gt+ywFT+F7LKQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1mjiNW2vwi-003OCf; Wed, 10
 Nov 2021 15:44:38 +0100
Date:   Wed, 10 Nov 2021 15:44:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Patrick Steinhardt <ps@pks.im>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/3] refs: sync loose refs to disk before committing
 them
In-Reply-To: <cover.1636544377.git.ps@pks.im>
Message-ID: <nycvar.QRO.7.76.6.2111101534370.21127@tvgsbejvaqbjf.bet>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im> <cover.1636544377.git.ps@pks.im>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HiYRfnO4uRpEOGBarO+51uUFgqfv3yYUQWuT4zd88+j8fB1WlVu
 RfaQp3MdSCwjigMBhixX9Xdh9hmD1raKudEB15wcD54c7KhkT78F96csGCaaJDELpiu2Sfr
 45Rpx9xkv+Hq7/cm/pt0Dr5+ET17IiwCm5AUqv1XsM48BBZW/5H/QXFXwRo/ziXmzgHzCEp
 OpXgQ10gtoj5xHvq8zlcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+4XBOGlHSTY=:mFDRUuhCcX/NAbK9EIf6aS
 m5gVF+xND0A1qFvoCQ3dFTi4TFAvanmcSDkStPJMgu6WzDrAp9x+NPY4n1VVGHhFBcZr9CPu5
 lItEadqVlmo/Z75cvFF5RulECbST35cYFIbvO8YLk04+MaPQvipy2MyOlSfzt5GxNV8nTkks4
 LOQZ5DUoyd/x24UiqdGlVZ6FzCdcVDohdmDhv4TC/8CPsoS2ibNghOOMcwp63X8J5YqNR1J3j
 nf0+/ZY4CUAdmFDslZEty5QPrfg4E8RtoXUaQ87xRW04+Gwo2qkXM3haAEAyrAz2AL4Cn9ZwX
 hmXhVmtVLfp8dpUJHRAYSZ6kGqdS+Lt0n0F0iuZfYcNJxk3n1Z7075sUDdOUmnpWYQ/ezfs9D
 gaBrlhtjaEpiqINzDNuznO+vvyXztqi5SjvIP3u5wpL1+FnGp64QiMx39dwbyPkXaYZGdbq+N
 76H2UJynb12VW64SDA+Ged11BsVbLJtY3vhDfRTy1Lf52sEgh8aDi66gJHJ8x4KAZsqK434OH
 yzTDUzXB6qG2mTGkfq8hdtebYQlnP7knSX/vsa7F5HiXOEGyqDtkFBnRR5qfKevxMWC1dzka6
 DgLE9nWfRURHhgQ/7Nr8vdsHUHfHG/eXJwF6zlQRqR+iOLZ9rOaKkJeWyE9IJAt8miA4by08z
 ViePJcShhwivSIR3X2aCQKC+A+LZljJlALbX0rSkfKrWvHpVHh7fkQ0h8lXFZIf80JeMP7TJt
 CYdGyzvgqaoItHv7xiHumcS89ikWdrzlOQqjb4wv5RuTW4C04iSW/G/uQbvHIvmvOHo72Bjir
 tBzMnc4fldrRBAbXPKYkVzvME9i4pvGoqkyoD8zakHSc4l1+pwhzQB2sD5i5+++pscO4lNh9n
 kymgYPcgT7pOV1PMC+W35sqyTGY4St3ka+Ksl2HjldFeHLrL82tBZUPUAXWPrrIaexiO0c8yK
 XdcGD8gSEH9krys61ozesTYrHRn9rpe0OzYwf84Jgut8EFRCceHoq8c2LYquXs0zveygLDooy
 iEAxaLXRO03B9wW0z7KGgiJUDXK8Eb2EVLGjZwROwll7BE2pVA2Y/y6SGYm8ZY9dIR/ojdF5s
 n2YvuIarML01ek=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

On Wed, 10 Nov 2021, Patrick Steinhardt wrote:

> This series is implements the same batching as Neeraj's series [1]. It
> introduces a new config switch "core.fsyncRefFiles" with the same three
> toggles "on", "off" and "batch". Given that it reuses funcitonality
> provided by the batched object flushing this series is based on "next".

Excellent, I am glad that my idea was helpful.

I read through the patches and found them easy to follow. Even 3/3, which
was a bit complex because of the need to support both transacted ref
updates as well as atomic renames/copies, is clear and well-written.

FWIW you could base your patches directly on `ns/batched-fsync`, I would
think.

Thank you,
Dscho
