Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC70C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58F8207D3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ae9im40s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgKJWbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:31:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:44599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731654AbgKJWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605047455;
        bh=ZJDIeXhU3+vKfpwwOiafvIofCf1am7kNBJhmiBm5+7w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ae9im40sAROJXo2jaPpTrxLe2Ww9ztVBjA93G/BsPb9w4z2up/EdY4LjY/uc9iTsP
         35DFBNxSo9p8H3hbuoGvQL6WKhMYLENI8ccJktK9+TzW3ZQ+8ZSs6/qVpYl+dftDt3
         +C2emRc4SIRgFbsWgydx6FoKFCJJm0lqTRxFGADs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1kG18u2Cqx-0151cz; Tue, 10
 Nov 2020 23:30:55 +0100
Date:   Tue, 10 Nov 2020 23:30:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] add-interactive.c: use correct names to load color.diff.*
 config
In-Reply-To: <20201110194823.GA1987088@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011102329120.18437@tvgsbejvaqbjf.bet>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com> <20201106170345.GA174555@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet> <20201110182833.GB1362803@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011102015160.18437@tvgsbejvaqbjf.bet>
 <20201110194823.GA1987088@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s2zbd5uvUUNfWhmWRyjlucih0OuQMK1UeWGNKrhF6XWpgo06gUi
 ZYBMRXNUtkTbJUUp/zvAQ5xV5Qto62d3YAYBB5WxNWPhFCvUug5ANDSxyihWsKLbfRJvtxZ
 vH4y6iUECDarispEJ5QLF9dzdEFQhj0ryAyLtHU4k8gxjBB5Wu1HJb1uOmb4cp7/tk/CWJS
 pWWwZlbp1a58V8cx5WFBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xI39a//PsQ=:CLh48z9t2uMJ0pkrKVPXkm
 CotoQCsjYjBPqLYuczZes0a2/U1VSMCmPGy0KYmvy7DYImxlyO0QTzHvQaL7DKC4VLRdsENYD
 Q8Sw1FHrT1EjUqW/lv22eqfStTnMsztOkDSKntO5sh68t0Puy5MBqoo4V6X/F/zLg8Ue/QFYn
 ZaM9Os4ZHFkpypr+eLCe0nBrhDsDtvsbfaIX20XVQsA0LUueQ7LhjHuC0bGXkjqy5X0dKUXdo
 3uZoHT4jFxA0R+rpueZoW7ysRSRLe+fIsiSvhd8UUNz1CrGDa/hkO4R2hRW1u87/5Jo/KLLI7
 vbCDpgdyWx9cGhw0cq3GuDtj5cbYVsECtp8irATjw7txmmh1zoPfTk5GIPv7CXH/NyuwLO/d5
 6C2fVgszuxz3C9CzXDM+zuXrDbKgxHYkY+RWq6wEPo9vWCD7EbGwCRLssYr2liFQH1bbPF53M
 GRRk9FJoPyvCqDzl5X8oGXGKWYTnvipe7HivKdxFIUufyhX5hnzey6KsmpBeFZFVtxF7ly5rw
 xyi8Ba5Ksqxugp8I0OQQuzJDZgXgIAeZ52TrnxOxb2tSlttReone2vfAME8WAh0Tg9xEtFvkG
 +rk70TmOYZfTOCdkWgWOzzjjebEjPlOhIs9XfqVxczhzy7NZTGeMeDmz9vy598creZlGMLFUq
 nxB6XLfgYL+GdNq3AZvyrHV7sZ6xkznP7yoW26vxT85RZQumZujUl6bzUj2hmSXivDPX06Xhq
 mjJ4vLbPDl8PtvwfgwGe9D3X/vs6myvannvrc8lHzxiqRumjPvkBOcv8CfX9ZdrAvQOM2Ygdh
 SC3gxFD0+URkznQR5PsuzWswz1liM4uc025CGGwPIYdbM1JAPXqZcxVKVjUS9IyNHUwzVpiUO
 VPVZJoWZ88+L1O5vdtsqnoU7ch/aQAQv6BQsHVTW8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 10 Nov 2020, Jeff King wrote:

> On Tue, Nov 10, 2020 at 08:17:04PM +0100, Johannes Schindelin wrote:
>
> > If you don't mind, I'd like to integrate your work into mine and make =
you
> > a co-author. Objections?
>
> Nope, no problem at all (I was worried we might be duplicating, but I
> thought maybe you'd have quit for the day already. Silly timezones).

Right. Normally, you would be right, I would have called it quits for the
day. For this bug, I kind of set aside my movie time today to fix the bug.

As soon as https://github.com/gitgitgadget/git/pull/785 passes the PR
build, I will submit it.

Ciao,
Dscho
