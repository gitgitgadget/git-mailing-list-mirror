Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABF6C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626E120885
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ac9WccMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgHNOSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:18:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:52263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgHNOSs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597414718;
        bh=NBvJ4aNUqztYsHeAmuBYvKBhhwpBiMA4MhNkILG8ZiQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ac9WccMO4i/tpmYq01vA5nYPNuLwOBPOcvOD7vWoxCQ5vUWq/j3TY73xVIhrqWYHX
         sza9yHlMwz9oc6tBsIUlFGPweJ1ttUfzKC9WI/YBocHh5owG9peUozkQkBN9doQb6+
         q3FwO4wM8lO+ZMbcLXNPvs+9NG3cWS9r+7N+t7OI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.215.129]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1kjIwS3uD7-015Y1z; Fri, 14
 Aug 2020 16:18:38 +0200
Date:   Fri, 14 Aug 2020 16:18:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/5] Makefile: drop builtins from MSVC pdb list
In-Reply-To: <20200813150828.GA891963@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008141611490.54@tvgsbejvaqbjf.bet>
References: <20200813145515.GA891139@coredump.intra.peff.net> <20200813145719.GA891370@coredump.intra.peff.net> <20200813150428.GA2244@syl.lan> <20200813150828.GA891963@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7OCojG8h8/RQJEA/HwgxQDyyGbzX7lUA6/iCShW6RRdREitKyAs
 Mosz5w83qABpDiDISaHR1Tym5WKbcLoabQmanqD815K52Q4BU3OHVKvaaVaJSNjHhQ9jkuJ
 Fgqhbt6WIcx0/QCTjONFrRdX73HgVn/6+wd9BFLsX/kSg7m1x/tdSx2ubQS1jeFaLUCjMz6
 IRuMuxyS1SCAUFWeiXpmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:plX5HdA4Crc=:ql5ScgXfvoDZW58RoxD0Uq
 8jHev98u3ynjK46QB6PyZmcjftE+pYl9EE5U7qoatbQ2MZVCyj0hW8up+4sQOAqahMSiRFhLP
 5fygIIwo6zzTaavK3xVZ3PylLPCKV+poyZlTWaAeP7YspgMt1l0cvHzSFgnemauETGOO+vLvc
 Z18Et7M0DkVpUSYnywbLHH0IrRRMx/kYZExg67KC3eMmF0SqNT9Ny1HUwy+0683H6/AUClfNo
 QG78BNYnN/qUKMAqcZ1EJb7egt2cksaxuG+p/BJHrfUTxq27HBlULVrT55VvrTKxyBPokwcm2
 UmPkRTqf/MG1GDOUFBJmy/TUax5r8vFtuhNEWPKtpjmVA2weRCou7hp4F78hf8Vioflw+0caE
 q9W8dmeFyKJZ1u0e3oeVfIsiJO4eJKwxo6Np8D98ux0QV4qBr4lg82rtWmp4dDyJZQyMowecL
 7jdP1WFctD7eVb86gEJo7h0SEv+GJm+VRIlL/QmfGUotP627j+OZOcA3dgEo2QLoFwyy1SFtc
 KG4m4ROAnswuSq1+fjxxcsKnoHJLI3RdXdKk+fjzgnTtJBzdBJ5GmY5gnxeV3rNrvPcNhFlnF
 EzU56HzenDgMKiALPyf5kNU4XPMb6IYCnC6HZYTZUpElwyyJ/emOqNwv9sM4+E5pd5q6pGU4l
 /ZqdfGXXnntzi05XGaNCuqLZFQ7H20x53+RcAl1NPUsVJ42euoV+Z/QHYWHw+wR0teJEEwCYJ
 VFwlgM19RiC1vx/ArqEuHywZLgPaZLg7caLjEXqkaBZT5slXTyD0yGgiIpp8OuAVDa4Ie+yRt
 JAhNv+1Tui86KPE/gyhR3P6GCw/W51kKBMMcUDVqE55DIE5EyOVMSxiuib8cFCiRwam2B8L2c
 oKcv/6FdodGkBbVVpodMzn9eEn1+7Pt1qLKPCrPYsDgrWarDbUPmfDaBKASi39S6SjBEQkIUO
 RhtKDb5IADjxpM2XYciDFPDDlQHrXb1CIFmVrluakdtE84mmMLD/WoKULP5zXbvdYueXbe1rp
 ukH9U/ppPBycjT15pVL80xTJqFO4aGUIog885tU3swf+iOFjnpWJbNygfAPdwbFB8SHXNBmfs
 GpkNLOdulN0pBu6Ispnd9yswxdIQAm05mMA7OU0JLcRoaFvkmh8QuumziknWtnFBvbDIC/Tkp
 wyqyxxEuIJCgNtjsaTq+iIF4EntQsYqh3VjX9V6P/zy1gZjUYBeVMd1gX0H6nU4utR9GpgZYx
 VgRIDAd2xckiJhbqPlKIGW+aqt18a3EnwDHOUnA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 13 Aug 2020, Jeff King wrote:

> On Thu, Aug 13, 2020 at 11:04:28AM -0400, Taylor Blau wrote:
>
> > On Thu, Aug 13, 2020 at 10:57:19AM -0400, Jeff King wrote:
> > > Over the years some more programs have become builtins, but nobody
> > > updated this MSVC-specific section of the file (which specifically s=
ays
> > > that it should not include builtins). Let's bring it up to date.
> > >
> > > Signed-off-by: Jeff King <peff@peff.net>
> > > ---
> > > Given that nobody has mentioned this, it makes me wonder if anybody =
is
> > > even using this part of the Makefile at all these days. Or maybe hav=
ing
> > > extra lines here isn't a problem (though it's also missing some entr=
ies,
> > > like one for git-bugreport).
> >
> > If having extra entries didn't cause a problem, I would suspect that i=
t
> > was just that. But that missing entries *also* doesn't cause a problem=
,
> > I'd suspect that this section of the Makefile just isn't being used.
> >
> > Of course, I'm not using it since I'm not on Windows, but maybe dscho =
or
> > Stolee would know if there are legitimate uses. Of course, if there
> > aren't, I'm favor of getting rid of this section entirely.
>
> I cc'd Jeff Hostetler, who added it. :)
>
> I'm also pretty not-knowledgeable about Windows, but I think that
> anybody using MSVC would do so through Visual Studio these days. And
> that's being covered with recent cmake stuff. Or maybe I'm just
> clueless. We'll see.

We have a couple ways to build Git on Windows:

- the standard way, in a Git for Windows SDK (which is a slightly modified
  subset of MSYS2). This uses GCC and GNU make and all the things that you
  might suspect given Git's origins on Linux.

- the Visual Studio way, after running `make vcxproj` in Git for Windows'
  SDK. As part of the `vcxproj` target, the non-C parts of Git are
  generated and committed.

- the "new" Visual Studio way, after running CMake. The non-C parts are
  generated through CMake, which is nice because no Git for Windows SDK is
  required to build this from start to finish.

- the Visual C way, as championed by Jeff (and which was a prerequisite to
  working on the `vcxproj` target): in a Git for Windows SDK, use GNU make
  but replace GCC by MSVC (via the command-line): `make MSVC=3D1`.

While all four methods work, the only one that is regularly used with the
`make install` command is the first one.

The location you modified is in the `MSVC` part of `compat.mak.uname`,
i.e. in the Visual C part.

We originally had a tentative plan to eventually, maybe, build Git for
Windows using Visual C by default. However, it turned out that the
standard malloc in Visual C's runtime was tuned for other workloads than
Gits, and that nedmalloc performed better, and we originally could not get
nedmalloc to compile with a modern Visual C, so we stopped that effort.

That's why you still have support for `make MSVC=3D1 install`.

Since it seems not to be too much trouble, I would prefer to keep it
working for now, even if it is rarely exercised and regressions might
creep in (like the ones you fixed).

Thanks,
Dscho
