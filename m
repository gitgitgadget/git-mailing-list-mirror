Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCFC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhKWMgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:36:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:41635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234773AbhKWMgM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637670766;
        bh=MY1Hwn5YtdstJw4P9S5C7w5edaTHOr8nNVUY0E3fAno=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e/JEHIeu8g4NPBRcqxDMVlSlunOzo3JKCmmOwiTytidbZpA+1Iuj5+yaHnMKJVUms
         /F81zOvtojtX7URR+LL1Qdt6kdvtm70azWLji4hxCql4ZIHESU+zdprBkp/KjJxStK
         xKrFWM/UGdBAWEnP2H8E/cM+GFRy57wpWoXRQuP4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1n2bz42Cbw-00M1HU; Tue, 23
 Nov 2021 13:32:46 +0100
Date:   Tue, 23 Nov 2021 13:32:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99
 supporty
In-Reply-To: <xmqqwnkzdepm.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111231331530.63@tvgsbejvaqbjf.bet>
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net> <20211114211622.1465981-2-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet> <xmqqk0h7423v.fsf@gitster.g> <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
 <xmqq1r38hzi9.fsf@gitster.g> <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com> <xmqq8rxgf254.fsf@gitster.g> <xmqqv90jewwa.fsf@gitster.g> <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet> <xmqqwnkzdepm.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PlcEIYm3ev20ziOIIcnKCDRVLnYOJ7U4QlOqb1E5rjRHP1yFiEz
 5zEiTAuFs1Fgg3iHdi96hdQDJje2vyjJhGBUqpPXmoimmSjFDjJhGOKc9T4cnz4MB4diELJ
 aZL6IFvgZ88TIEqbGdNVTNkIXH6oynqYaVDS/FAa7HlxTNH58ntsPFbP2jtH5E7ptozXUKW
 eWdlDiuhyPT+r+a19VgqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HFo8lCBXipo=:dx0+O1MVcR6vlBC1+Fxc8b
 4xfdnGku8mOtRpNr2O3QIfXxU19sshN+2geDOItBUl/lEAV0QyyvHWdfivqhf2F4SnBZS/Ltz
 jp9faNwzLzaI8BzVaQtnt/HHBIwCDtKz2eApyxll2uYbMUMZIsW+JKQaNgPjNwjV0Mer0BFtK
 LwwfSYxxqIJJFUbK46JHbAmoBXhaiU3hvy7XW2rwUEtP7i4WrxpdLIQ+6x9G2iEpB9aEs/NL+
 9nkiZ94xvLk9PFdirbmumswwCxoZ77okejlcdVpMmbIOxbNpyxZzpmcLv2uDRAfw+bw1MWBFl
 /wHGe96I1Xyc8G1Ab/Wfudj8Jtc4cmfD1iBUKXwFWQMFmuUFdf0kKf5u5UYswJKVAxRWInSqd
 X/XeT4xd3KVafaYymbQ+0G1I/cBpsngzcu9PEb3sJb8hYGWLmrT97Jk23XdBn3/5irONjBIGU
 iDC2kr7M7gw4UyFB9ZgKR8gLwIgq+Na1VL4cx293tDHQdAvWcNhuM2uv8uoTdvoj9bU1v9A6o
 Qh+D2xyiY1VfJIpGecMc146eyoSTfMRoz2d+ezu02wAYqs3bSDTkJV5SbUEENchDim5V3jdzR
 g3ACYVtoNJF8XJq8Rv18SK2UQ/PO5Nug/r/GBb2i0NTVJsmB4Sdp6v7C0At2iSjCZBlEKq2Ha
 ZBRUHH3yc6zljyaxOsYCxezdB5wxWOSd/xFhuUkEbVPAw1l75eEdQL8TYb/M6F/epv2/K5OEo
 sqaMCEiIDdH5WMcMCModfXgLrje+7lyvvs55BXTtut91YooCozw73ExGcJoVIS5W5qBijUwQH
 K5zQqV6dLOsoJ2muH67SQjI/EwriR4f4tmBQszq6oEcGCKrUv27c7VSv3M7XAb+NQksZXkJuj
 Bqa9uD4SFOjiGQy7ybmNPgdn2/AbXOAu2/7m6zEc7lGaJWw1vVqom1BnOX6PlPlPiv6bunzNy
 JhheZdvCJExade6uXGR4fC3dMRbM8b8d59NEIl8REyiATonSLiBqtPCWSny0nb/rcvfBDz6eF
 o75X1BLTQacABdiOAwgTTTXOdEKTxH0HX7wCGXQxjSDs+XFa7Ed/m7JQS7tFIqQ4j8kghAXVg
 FzgyS/LmgB8EJs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 22 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> But if we were to do so, perhaps we'd want something like what I
> >> gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
> >> its place to avoid confusing people.
> >
> > That sounds like a good course of action to me.
> >
> > Please note that the MSVC-related adjustment of the `FLEX_ARRAY` block=
 is
> > still needed, I think.
>
> The "something like what I gave ... to avoid confusing people" patch
> is following up on the direction to drop the patch with -std=3Dgnu99
> change.  IIRC, your MSVC adjustment was to tweak that patch we were
> discussing of dropping, so even if it is still needed, it won't be
> part of what I was doing.

I thought we were only dropping the `--std=3Dgnu99` part, not the change t=
o
the `git-compat-util.h` header file, nor the patch to the CMake
configuration for MS Visual C.

Ciao,
Dscho
