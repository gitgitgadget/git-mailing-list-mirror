Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ABAC4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49FB02222F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 14:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GvLmrHLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKMOAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 09:00:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:42541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgKMN77 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605275995;
        bh=1pyjJm78Q2VkKusSGodVe+jHDEWu75KDOQ6J0jFUmtg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GvLmrHLW6ReLwyuUi9sVXIKVrp6Yfq6/UOvqiLyePRLAC1aRkEETLTw9EzLPuhZTl
         pMku7DumHx0vQad53lCiLNsmI7MhXMXResM+jDtBrDG9X7lgbNFkusLCzpUZAPbhaO
         0RrsvQnCthRN0lIffGRaaJjTQZJGuC0V0UievgNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1kapn70xXW-002pEs; Fri, 13
 Nov 2020 14:59:55 +0100
Date:   Fri, 13 Nov 2020 14:58:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/11] add -i (Perl version): include indentation in
 the colored header
In-Reply-To: <70fae5a9-354d-978b-c560-d7fcabb25c76@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131457420.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com> <70fae5a9-354d-978b-c560-d7fcabb25c76@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/ciYXk2xHNojW7pstrB9r2TIsTNfypZJz37WBGwVKwMAer3X3FU
 IcIEgJ/IKXEPmdA255nKaNfyE9+peVhEY+UUd/QEaLLXch3XNGMo7ndy1lhNVIcXfpCEGrm
 AqTHMSP+upURYWOWbOqiOz3NRx1D3am0ggss5hfMptXQiS+qwNGPqOSsqOs2c9meXt//etS
 892cvk5/678zj4kuHiisA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:moZthvJ0Nqc=:ElCgp91aG+JMYvuZVSCGnF
 in6KsJzYZWiEF4XAG+SpRmZOlq7q6HwxTF72pHZZHzWZMue3S1rukyXKW34Zr1xioo7NfKwYe
 uR3BViFgSwUqya2mKQFmjZMST8X+Y6D+tXpu4JV7odAJuaxdvYHmOk6IeLmKONfljJF/GvrlX
 Sn2Hwrgk66jR+Cba2mUAapc4d2c8Bqqd2/PEdBTxs1bcQZoXMIypgs5o5I3Zbfme5IxwbZbFR
 3ePXCB0c3eV/VMIRP8nEAtHMJEAo2aLiuOz1xXWjuC2zRGLLX65j+ANpbzNrJ2z1QuuHxdw7i
 rkQKrk13eHSaAE1K3gdlF5EYLSpJHeLdvGk5LIDt6os5OMK3c2k/8YwMr0VFaXiP4xzMUddQj
 Z0gdkAtQrWAv5bnsAbKS+rZysHPsGhqyTiLA8ZEGqtMnZ6z4+bpMLZUwn5ArS5y02FAXVkZk4
 iHbsRwlUqqR5FGqKzfLfMXrjJvkx3MiGRoYvOIwX1N92CBAAgUViKnhxD6qOi3fw5y4s413t3
 y58K8bCy8Nne0YEKMD2AlzqfaQvYLbB8KjMHLXFx/vzkGTJTlJJYX6ugSDJcCgXbwbjqYjkG4
 lZ+DSqEZov4bYDxUnROvpTKjsrrXGGqPJKBP2YZT6US88Li8BahuVOPDvpT3LDnApKe6E4xFD
 dBokXk/uqg44LyYQAlNDw5cjFFUHStts2ODHz4puz/kDvXN7MNktfb5Y+A8BMluN3ZP7sEyBG
 xObmChxsaKXV8lxOy9VezVNP3xGlCDtkYd0c/ubaixvXwn1mLdYrmJKFw6sPMfuatbcHnvnuR
 Ou2hXnne/OgWpPLGShQoowWOpl/bvZy3NMuV8SaGoOOYNFbPazLl+ejIxWFhagVffBewmLLB7
 7Lxm2XPcYUh9w1sTVtj7Oc/1NaWa375mGlG1kg++4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The header is formatted by padding each column heading with spaces up =
to
> > the length of 12 characters. These padding spaces are naturally includ=
ed
> > when coloring the entire header.
> >
> > However, the preceding five spaces indentation for non-flat lists were
> > _not_ included in the Perl version, but _were_ included in the built-i=
n
> > version. Let's adjust the former to align with the latter's behavior.
>
> I had trouble understanding this. I think my confusion is that the paddi=
ng was
> printed when the header was colored, but it was not inside the colored p=
art
> whereas the subject lead be to think there was no indentation printed wh=
en the
> header was colored.

Right, this is ambiguous, but I thought it was clear from the first
paragraph that "included" means "when coloring".

I'm not a native speaker, though, so I welcome suggestions to improve
this.

> I assume this change is so that we can use the same test for both
> versions?

Correct.

Thanks,
Dscho
