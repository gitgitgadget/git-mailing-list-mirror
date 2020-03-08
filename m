Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB6C10F28
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39220848
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DQr9lBfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHWYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 18:24:53 -0400
Received: from mout.gmx.net ([212.227.15.15]:46989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCHWYx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 18:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583706280;
        bh=aS4jyPh3Vs7ghU82dosIdZQeT4+9lHprfgCDexOxtB0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DQr9lBfmGTJ99YPY7am/x8XkNfJ3+HhU9bWeOC0dOcoitrW/7fB7hHFlvlS5wnTDs
         +bG/a2FKVLQ37X4NM8yl/k2jCZltIkNISXfc2jKwwjtP2LFzIaLgz+lK/EUrhBxPA5
         SsUwROUvlVB3CMcuOiOzefXSdT2T+hR9BS4C7N9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.250]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Md6Mj-1jkgLj36hP-00aCqv; Sun, 08 Mar 2020 23:24:40 +0100
Date:   Sun, 8 Mar 2020 23:24:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com>
 <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jdA0wJ3CHgYtGhRG/u66p3HVdZ64jJ5xXzmTvQAnLS+FyL1etYh
 5kLcRSvNtUChcVlrfAXptQfTzDJ+UY//HkjfQTqwjll+WWniyDPiGWiTd1+2ScwkbCao8r0
 hgjQQP1w3/evgzKfCRLAEvD+tSizHlXGV29raHAQ/sIV9X8PEewkrz7wuoro/chjprA4kt0
 13JK8eCo/IzmMx9LAI9Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OKLZtfWF/Yk=:aZTHmjYwle+LW8NnYt7Iil
 W15K6gVqsa/D9ntaQxc6zlHLIw6cHTuRQxuRuVyfpMqpBwPy5XluKx9NBmze69gZybPxGtEvM
 JsS7ayUj64kUN8knBrRhg+B4vOxESgAw/GvtFOzATuoxerXtPW/TKQ5FYkzzna5ymH4GbCbuh
 GF3dLIw2p3ur/sf3zszQ5MmyvFQnvkqQxc4+jt7uMF9QrYNX+KC2krOIrXnAuafgSX0ejqnvs
 oV4VAPzJgRuSZ0OOD0Jp7wcxsINE5i4S/KPyFHfiJkrPg+3zRGuarTModObTyq/U/4HRcSm73
 CY3foF61W5T0cC3P3ykWYGq1NFEXD70Q7hC4t0JQqDRdD6ESbTsTZb1rwoi70NiUleL06txuE
 HSqjcxf9yW3d1z4NYR+YCtHGoA/zBk+QOZ/S5u/5/i0mMI9p7HM1C7rhAEBUe/nz1r9b1UwAV
 WtLerzUY9qxqRgZX56DJR/t8yf+IXMglY2iZfW1MwY7ui3f3n7lHINPs3idtkv0vhqfhhWlLP
 6rWsSPq+BbGQwesi1PSs3uDbJMsiV74cLGdf+WgWqYr3c+cESSFA8mjoUGbTzRKyLbi6f5tqU
 Fwh9nUmOvcSgFFtkn7fLja5G22AjPOteMM2K3BrBfR/fDzZXCNigjmzCBWjdrW3vfrUrcJZax
 9+lmO4g5ak4DqQtOZnDix2wl2NkcP7uHCB9wDuwzp/g+dAJebvaUZI7wcPobDn/61oOfwGjC3
 b3JdRYdc3QVgZNbDD7l7GLNI/RENMfwsR2UBSmFQQToWFxpAZtaRH9SFu2vimbGT646dM5Su9
 8W1Qbnm+vs2aYpC9eDieloFGAzYw+qUyIVQaSysZHFbFMRVaLHObZ3fQrO2kmvJ33gfNWvL9S
 lUoZy9nxRP8NmkDfROXGsN83fEcUmQA/Fgq5Pzr4f4nJC4m/ExeQ0ryqFP5qoCLlh6K9a8Xu7
 xh3Ew9nVdG3+uopkFEGScfjxepYaAXwH3vF1wzEQ12lq17Y98uDuOf9QoWGBaZ8/ZRv0qbM95
 2RO5EDR1yOgUL92boaNgQE7tlyhdtheoYH+fhi8IYM324x2C72kdV0P3ILSjXorRQmdAghEM3
 vueiUaQJAmdugDWWiV2NXs4JcKLGPdH1CZ7B2WqI1NleQCv1jcEnw5TSgt83WvoGkoobWuLXN
 wiphvYBuvfrgpTBbJHSHBlIpC+EUG2JRMw7CDNjZiRSwZISAz6Y1XvuiHqJn8wk82mlpMEj4Q
 5tOYnNz4r/zWY8Lhd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Mar 2020, Junio C Hamano wrote:

> What makes it possible by making "git bugreport" stand-alone is for
> it to link with libraries that the remainder of Git, including the
> transports that link with libcurl, has no business linking with (a
> library to obtain system details for diagnostic purposes, for
> example).

That would, however, make `git-bugreport` more fragile than `git`, i.e.
the former might fail to launch under more circumstances than the latter.

Not a good idea for a tool meant to help reporting bugs, to be more
fragile to even _start_ than `git`.

A tool that is intended to help users come up with bug reports, despite
the fact that users are totally unfamiliar with the implementation details
of Git and hence unable to judge competently what information to include
or to omit, needs to be _robust_.

You do not want to end up, for example, calling a stale `git-bugreport`
from an earlier `make install` (or from a different installation
altogether). That would give the recipient not only bogus information, it
would be outright misleading.

And that's what I meant by "a stand-alone `git-bugreport` would not be a
1st-class citizen".

I would see it as a serious design issue if this command is anything but a
built-in.

Ciao,
Dscho
