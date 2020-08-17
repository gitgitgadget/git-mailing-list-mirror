Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E35C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D952063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 09:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YfvLmT7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHQJGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:06:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:36989 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgHQJGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597655153;
        bh=6EeLIqKPZrZ6Shn8xf68uwTNBH0vwWi4D/ri5gVA8jE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YfvLmT7E0lq6Gmdjto3c2dkygnkBsVMvffDw91YG7GDrNEeCNsDCUsKySd9AGlYy4
         Pu6d7a1RwG4oph0lTK0eALocn5PYrZ+Ev1sUDlVySwfKTfltwG1B4OjPmPzawuv1/t
         cthxPMT5WN2ota0fQm9iNF5+U3P0lPW9fIIV3Drs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.215.233]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDEm-1kYASm417A-00iA5v; Mon, 17
 Aug 2020 11:05:53 +0200
Date:   Mon, 17 Aug 2020 06:42:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
In-Reply-To: <20200814143231.GA4167031@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008170641450.56@tvgsbejvaqbjf.bet>
References: <20200813145515.GA891139@coredump.intra.peff.net> <20200813145719.GA891370@coredump.intra.peff.net> <20200813150428.GA2244@syl.lan> <20200813150828.GA891963@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
 <20200814143231.GA4167031@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LNOWgoThPd2VxFIL9BQMYOVn46Co6Z5XvZQPnpG+AffueJuOz4p
 VM/VahiadKoCoFZlVZ3tSdk+QRjf8Tdwi3sPZJJYwWRFC2q0hg9iYyqBZ4NCPT4X/PJcDem
 tLstA+eby3es4+EWUKB9KjkYxat+RU78egNAF2OJ5C5mPLEocd4KwHMb8AYymAEAO3OoVMg
 C+GCSMyz++gA7wSIzgHiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7FbmLaJVUO8=:/TyOWjxw6zwHd/3kVgUfn4
 UU9uIi0xQsuzt48WnLxqP8Re1XI6SNu4VBEchDJhBU1zq8SWUVjEn08gMdw+ZVErSJRULFtsA
 UkQYkpRY+MKpgWbYlM3+WqVC5u6ZagXcRZXzqhAGWdwpVPvlXYBIHaIkXXJup9GMpbeNHI9m4
 Gw1d1Z0PNFXtMlm7tVguuYbaK4MYBhWFvvt23+QBks1zsCyosIMitaL3Jf+ZQb+WrhyioJSQx
 tTcQIduY6T5lu/qRVECEM/tXxaYvxqS8YrhRIZLE8YBu6wmaDNlAWZpfiQzRxMTY79ec4ezGh
 B0lUhzjyskqxSTzETouGC9Pt25T0x3V2p/xS/3ll9hX+aW1c2iTjba6tmREmwjDB6XBuSOjDm
 mxfT+WIlRaaoxmYx/wzbeYr1NvKL5hDTJp2NUbBPGwfXY7zr0vBbBKFAJ0YBPARnC0D0egWqd
 +T/JTBb0GqH8mPM5k8uDRRt5nIWFyVmYGg65OQ2b2Gt6KDwx5rWqgGWJgJJsPiB0OlQBDaTXk
 DotlvM6fNEWC79nEgYmtD34XA8umzlGmcRh9eZbEM/wD1wBKCe6t6IURJYUTPKq4KewzvGFmU
 tos0tdqqSG47sg/axfFIy/lyWi3fAlVGZw0CJ3LVHc2QLNt7sMptMs3j9KWQmLbp9CBLQXNFx
 usW4Yl0CJ+8uaF+6C4jgfz+DS5G4zYty+mWx3bD+KUnKbR4FFSTt2Pq5ECze12bocFsSMrGrM
 +yybw926mA5eC0aLIW1xdooVt8xMtUmlucn/xUoyJugrhXfRlg2OUIXN6iG6j5HHplg2Hxn6M
 Z+mrd97aphcYqNj/uFdWdD95i7CTA80EajCRLQ2O5ZsBtdRRBnud31eMn8Ya8nhFDsGpHLiBe
 nVygGBNM49E5dXFE/JIC78BG8SosIRqUhmEXe9KEeCY+Ld8+qntrMO2PySEb2YtXF61x8Delc
 GUQWagqgo2ABqtgvyja5fzjTMO0CdsltFpFBK8IeJbd13XjriBk6EO8qhI9otSLrCZSmCFRp1
 54BR38bENCTEa0AZx+WM8x53g/VVjHcjTfwtgkdDnHewdtXjJYShrh917G8tN17fe6fXuP58q
 BhWL7HM5v54nBvarEcSo61YvvWnUBItSZJZtRL83bnli6Rqm1E9fdhZIA92tP2tNyqWXJLD74
 B7kxKZSNHrLUdlrOxyvLXD903AKuXvNXJlX62RpHrdH+kvi0LGtYOI2QAt1b0EMw6YMwcqfnP
 3amfTZH/cEsG9ZVsIcr4CsaF7KB2X0uq41zyRrg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 14 Aug 2020, Jeff King wrote:

> On Fri, Aug 14, 2020 at 04:18:37PM +0200, Johannes Schindelin wrote:
>
> > While all four methods work, the only one that is regularly used with =
the
> > `make install` command is the first one.
> >
> > The location you modified is in the `MSVC` part of `compat.mak.uname`,
> > i.e. in the Visual C part.
> >
> > We originally had a tentative plan to eventually, maybe, build Git for
> > Windows using Visual C by default. However, it turned out that the
> > standard malloc in Visual C's runtime was tuned for other workloads th=
an
> > Gits, and that nedmalloc performed better, and we originally could not=
 get
> > nedmalloc to compile with a modern Visual C, so we stopped that effort=
.
> >
> > That's why you still have support for `make MSVC=3D1 install`.
> >
> > Since it seems not to be too much trouble, I would prefer to keep it
> > working for now, even if it is rarely exercised and regressions might
> > creep in (like the ones you fixed).
>
> Ah, thanks. That perfectly explains what is going on and why it might
> not have been noticed. I agree it is not too much trouble to keep it
> around for now.

Incidentally, I stumbled across the patch I carry in Git for Windows'
branch thicket that _actually_ fixes this. Will send it out in a couple
minutes.

Ciao,
Dscho
