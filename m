Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A7C47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF062137B
	for <git@archiver.kernel.org>; Fri,  1 May 2020 19:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XLpT4fni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgEATcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 15:32:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:55433 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgEATcj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 15:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588361546;
        bh=mbFBGjyLH/GdRGnXJ/VOqMAILcLfaWjzlMGXfas6+QM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XLpT4fniJipXWkjkVJ+Rdhi0ULQ13LPKek9SSnEdgmS8n189Cf0uhsPFbePjkGxa1
         rPG17XwgUa8uHDOAtCAcK5PucP9xBqVzluGpPj9hGBgaJVIW2ztybp8ZMhFU2sYl6K
         gzckTU7yv938oTN76ED2iZ4nae1bR4we9o1svkT0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.255]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgNh7-1ixRm237df-00htM3; Fri, 01 May 2020 21:32:25 +0200
Date:   Fri, 1 May 2020 21:32:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net> <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net> <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f8/ZEPmgpjPuVm1mXqcKheC1pppmMj+WKx2JIGJJKEayR1/YLSx
 6AB4tEzfeDaPC76Ywu5F4acCYw86R754Hq2LxOPrDXGrdGxshpI1Je+eDo4GXONfTRBeMwk
 BLOfGwZNuqj8dgZEIFiRc+OAbPXM2NM0iC84KKm9CIV7w0HvdE7xXR/mJZzsEHkmXycHmuc
 HdE1OA66luHhyDvLSuURg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2u5j2V8SW8=:xbo6gtRNlpi20Opg2FmBZR
 8KdlxhKjPqYmptMgjSZ1GKBJQ3wtRK+zX9wTSWA3bBIq68GQgPfaddbwuwdrCmEk3+jqhkc7C
 cv6XtBjnnrnbCv1VHu0xNhjEEcmaaFYd6IMEkiCVaJ5uBImuOyisOxg5hkR5nx/KrWbX2ccwo
 bS9XLElmA8MpWz7ve+B1WtupeQm7tqjtb/oRRZHftGIl+2B+ECTkdzjGhKwPNWTMHI02Xe5qe
 hZ+Z5wg7jAI/E5IJ6Gu06OzP2OSIvnjaLrDf36wtPK+6RrN/b3EKtZsbJ1UNBNCYy20bYpO2+
 hvgPIjPoDH5eG5UIXZXZBzKTuHsdnjIeR8QdXhZ7SvutlNUBftJ2RKk8KbtlghNbfu5u8yywn
 grQ3q5BpdbCKpK+buzYqhbxC6FP4PlvHXiDjoG/in6NMbwLDNLsXQpiN967UIzCCemf8xkclj
 dmUotxFrdtuosfP4F2gcn7J3O+APalG6vsKecse5/DQyybOBe6lVHKDiHMkF+FY5UHL88dJ/N
 YdDF6YMMpMrHRgr+4blqznW84Uk2qaa7dY+SVr+vefDzf4r6wrZK8wAak2BWCf92h48YgFiHF
 zxNvFfM073FVTqCnADcgJWjO6zSAeJ+YGmyLtqY6nFIE75CgoIQPbRwjJprlP1VEz/JPTQpv+
 rFJUMg07zg6VcRbkcllkzq5lPTbZ2xvtMQ7Oai5769lCOjhtJ5i0DCa2XHSrBi0G2f11YTUu9
 O0z4trCDQ0vAMNE+Y61EhN4+irxMq1u2FTN2Bbo0C3R7tA00pO951/+cwQI8BNIl0xWNc0af0
 obyih+1vsDO2CncjuNjHpd2V0ZuFehj4onHIsFG2D+8b0l5hoHMLGfhWxvb5s/GbAe533CNYH
 98hSlNAaVHZlVR45SOQolzw64b4VjmFNZl2PJs7pOH5oHFJmXvkLbCPlstUx184UHJj/BYSIe
 FcYfuKTFqTeL2tWtbyOMKVdFX7rXdTHtBG1mPlA/+Jh+EuCPCd+Guwc9TtK8ukU7paq1qT4fG
 ZgAr6kVIyzeOFdC/Cndwzg83a0i+lbeI/zcNI3/OhYZ3Tir6dDUJHXJFFBFx9pYSgXKUj0J6Y
 SETbad+XFN3PO9U9s2j6e7nVhK8615QMclk1o1bvCm8EZ65ohfbUM1xT3SY6/YC7EjMMV0nbB
 1YR4Td97/r+M+T7XvUI4huIIgH8gJ0kyzywM2EvEEUklGzZuGb9BZEgm/ScI7X0YwthHQLWdJ
 skU15UkFKyPPpghtl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

[please avoid top-posting on this list, but do reply inline instead, that
is much preferred.]

On Wed, 29 Apr 2020, Sibi Siddharthan wrote:

> Adding the CMake script to contrib/buildsystem is a good option.

I'd actually prefer it to live in a different subdirectory: what is in
contrib/buildsystem/ uses the technique of running `make` in a dry-run
mode, parsing the output, and then generating project files. But that is
not what CMakeLists.txt is about.

How about contrib/cmake/?

> Is there any changes (apart from the CMakeLists.txt critique and) that
> I have to do on my part?

No, I think that's it!

Thanks,
Dscho

>
> Thank You,
> Sibi Siddharthan
>
> On Wed, Apr 29, 2020 at 2:37 AM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Apr 28, 2020 at 08:52:37PM +0700, Danh Doan wrote:
> >
> > > On 2020-04-27 16:12:28-0400, Jeff King <peff@peff.net> wrote:
> > > > On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:
> > > >
> > > > > Skimming the patches, I do wish I didn't see so much repetition =
with the
> > > > > existing Makefile. I know that some of the logic will just have =
to be
> > > > > ported manually, but surely we could be pulling things like the =
list of
> > > > > libgit_SOURCES from the Makefile as the single source of truth?
> > > >
> > > > Thinking I surely couldn't be the only one to think of this, I dug
> > > > further into some of the sub-threads. And indeed, it seems like yo=
u are
> > > > on the same page here.
> > > >
> > > > IMHO it is worth making the cmake file depend as much as possible =
on
> > > > what's in the Makefile.
> > >
> > > Please correct me if I were wrong (I recall this from my memory
> > > without checking anything).
> > >
> > > The worst thing about CMake is we can't override (Make's) variable
> > > in Makefile generated by CMake.
> >
> > I really don't know enough about cmake to say one way or the other. I
> > can well believe there are parts of the Makefile that will need to be
> > manually translated, and that it may not ever hit full parity.
> >
> > But as long as it just a tool for people using Visual Studio, and if
> > they are happier being able to use that tool, even with a few
> > deficiencies, then it may still be worth doing.
> >
> > -Peff
>
