Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34906C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FB52087E
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="b/BNVBnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgBCQx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:53:28 -0500
Received: from mout.web.de ([212.227.17.12]:35885 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbgBCQx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 11:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580748799;
        bh=hkOYbbGdFZVKPV0Z5lJHVS0pM+AisLTdLpqy+OJ9cDg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=b/BNVBnSgMXOO2id56VT3wtgHEJOV21zBJiVPa4Gno7QMGxcW6hIKnWC5/GteGNmH
         nN70DN1spnC4YOIqTvHBtJtF/Lsn8kYuNHnhapg+kc/Fyfp+pr+FLsj3yV5A92mbx/
         Uf1X3Oa6owXpKvIRI8+N6kc3s70l/BrIOWmQ9i60=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLxs8-1itAFm48TM-007mBM; Mon, 03
 Feb 2020 17:53:19 +0100
Date:   Mon, 3 Feb 2020 17:53:18 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: Git 2.25 and failed self tests on OS X
Message-ID: <20200203165318.eq3tjo5ja4pdjf7d@tb-raspi4>
References: <CAH8yC8kXPi0teqdZ8NRJ677Z6btbmdafR=y4MFFaKZgZrB=d4A@mail.gmail.com>
 <20200203084356.GB2164@coredump.intra.peff.net>
 <CAH8yC8=-ht7D3CyM-YoJSfW3hueaWVp5WQz2+BJOFMjmt8aDsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8=-ht7D3CyM-YoJSfW3hueaWVp5WQz2+BJOFMjmt8aDsg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:188Jd7AD/Upr9Je5GxGfacieeMYtjD9wMV2q2cmnnddX/qFtjro
 gAj0Qme20GBefooMQoVn/LjVAZvQxnWJcJfgLqFhmnlNT3a6ZJjDwb4JQkDPMnUnRu3nsxj
 iOfm516ZJVgavsmTK/lupkU2AmwAXOe/nT5KCjnVODQROH7Qs7flVNEzqCMAVDaAItzg3wN
 NXbKTSyOR4hhS0dFY9J4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EYop1gmbB6M=:JAy2j2f/CWxX79bZthARZa
 loswbSnWcawcxNr7ttidh7ohccVCfCNthEYl/eTd+/TRdAEijUztX2WsgrT/jfOIxwii6lgHY
 3bTo1k7TWbChCQA4yzW3G8hUAbAtrfHAK89g2rvzMciDXgrPIYBAkqGTkccwF4NiIKWV4utXJ
 W5WNMwCMGbWSeByY62K+cn87SYDCU7cab+qYN0GrfwVg/lfc5/fP2vwisBbqmzgmmKCeckGf7
 TxznX9F2nfYFDC1bcCHwqk9uPvtE8UVnlylte8hC+kcMuOtrH74dzoCLfXiIKFhpv/ox6LNSR
 lCV5UUKqBfKa5Z/5M0qqKai3NetH4nKJkcWwC163mMc5x4QIkcMKc3bXJ2R3ELkspIPYqBV06
 HV5pA16rOR8gg8u4Dp4QkmLbFbR1F7vmPrqanEu+Q5D6YBPkIPHQtsRZE1+4bCI/k5Y47+5QO
 uSZ/kftiaagsEGdQ58GWAtQ6/Mdkby/uioitOPfrfkqfOL8H1CqBjJutKb9pGDuThb6odphXv
 +VSXYDEIAIKQlaNqmORHbKiHsUI/zyTVKRW7Sr6FaYqWR7i+w5Jc5fcGVBmP5rygzL1o+DWpH
 c3OVjiRgY7M8HksA/37E/jzzGC5bFBJTvYwelvOC053TvBfHhoaqWv0+vlvUVzVJuwjSgMJeq
 hGE+eKpv1s6zYtoRtJPqJ6JGG/rLxBHvIHJpXVdDNu7wdAok1OhfPvEUXcM34vhonSx7QmMxw
 yC26hkQ9Wysf7pxnxsIiYs/W9SL3ye/T3MIVO1iwov/Il2Fp77GdbbMjp9LZWW/Ed0HHvTgWv
 hVXoosRDD70retKd8DqoidQ2PYLGXOuuto3G0uisrk6+ay84UTlPzrwigYs50fUCkL0jlkQv5
 Wydo+wHaI5fru6AaAeaGP40Gh0sZ7dkh5Rc5KKbZ0MJcbLPyHoEx+ReOcuhVef7pfWjX8OKdX
 JCAIGL0gxlhXARoI8o15Qsu4NAovHGJe0SS4Nc4YiqrllvECDTYeNcY2vNgKU8ybEkOhI0/ht
 ZZEb7AlDDLV6rOMDMTUfBKvipUp7Hnl+3wphnzu9cFWC1sJ2ExBkuAdrT7+01a85ixZGyo6vY
 w5AkhfNlDoNWJpr2HtJznpOH1+H8HHBaFXsfOiK5SIiKtfO0VxDL2bVTgHy+EBJzhp3jxbWW3
 qJ+gs0zqEvJ5MtIDppoW8SOwSF232vJlCN7dkrZrJ95m53Rk2nRQ2+Bx7eaihJWmv/CAdRmH5
 10sU26OxDYdcDeza5
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 06:00:18AM -0500, Jeffrey Walton wrote:
> On Mon, Feb 3, 2020 at 3:43 AM Jeff King <peff@peff.net> wrote:
> >
> > On Sun, Feb 02, 2020 at 11:08:17PM -0500, Jeffrey Walton wrote:
> >
> > > I'm seeing some self-tests failures building the 2.25 release tarbal=
l
> > > on OS X. I'm seeing it on the old PowerMac with OS X 10.5, and a
> > > modern Intel Mac with OS X 10.9. PowerMac failures are not too
> > > surprising, but the modern Mac should probably pass its self tests.
> > >
> > > *** t3902-quoted.sh ***
> > > not ok 1 - setup
> > > #
> > > #
> > > #               mkdir "$FN" &&
> > > #               for_each_name "echo initial >\"\$name\"" &&
> > > #               git add . &&
> > > #               git commit -q -m Initial &&
> > > #
> > > #               for_each_name "echo second >\"\$name\"" &&
> > > #               git commit -a -m Second &&
> > > #
> > > #               for_each_name "echo modified >\"\$name\""
> >
> > It's hard to see what's going on with this output. Try running:
> >
> >   ./t3902-quoted.sh -v -x -i
> >
> > to get more verbose output.
> >
> > Looking at this test, it tries to create files with funny characters i=
n
> > the names. Presumably your filesystem isn't happy with one or more of
> > them. The verbose output will probably make it clear which.
> >
> > Version 10.9 isn't incredibly new, but these tests have been around a
> > long time. If OS X has a problem with these filenames, it seems odd fo=
r
> > it to be surfacing now.
> >
> > Do you know what filesystem you're using? You aren't running the tests
> > by any chance on a network mount from a Windows machine?
>
> According to `diskutil info /`, the filesystem is Journaled HFS+. The
> tests are running locally on the Mac after logging in over SSH.
>
> I'm wondering if Perl is the problem. I had to cut-over to OpenSSL 1.1
> due to deprecation of 1.0.2. OpenSSL 1.1 increased Perl requirements,
> so now I have to build Perl, too. Previously I was not building Perl.
>
> I'm installing Perl 5.30.1, but it is a minimal install. I only
> install Text::Template Test::More (plus whatever else Perl installs on
> its own from cspan). However I could not install HTTP::Daemon
> HTTP::Request. There's some bug in the cspan installer. It gets stuck
> on one package and tries to download/install it over and over again.
>
> Do you know if Git is using one of Perl's Text:: packages for the test?
>
> Jeff

Shooting out into the blue:
Which shell are you using when logging in via ssh ?



