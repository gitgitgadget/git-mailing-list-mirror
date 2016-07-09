Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF382018E
	for <e@80x24.org>; Sat,  9 Jul 2016 14:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730AbcGIOZH (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 10:25:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:64607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbcGIOZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 10:25:06 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M20Jj-1b6xrb3i95-00u1Lr; Sat, 09 Jul 2016 16:24:45
 +0200
Date:	Sat, 9 Jul 2016 16:24:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
In-Reply-To: <20160708065650.GA10664@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607091624120.6426@virtualbox>
References: <577EB546.1090007@web.de> <20160707203157.GA11804@sigill.intra.peff.net> <alpine.DEB.2.20.1607080834340.6426@virtualbox> <20160708065650.GA10664@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Bs7v5NErUdUx//WOVAJ0pKPbrfG8uUW+ZhafC7Y7uHs/0uUupq0
 RpioxhVQ5ceI1I1+6zWBILFe0bhCiQxq41FXHX+Huj1tBlB+6cMWTf//p22oS8Ltuc+/OPz
 Oty3EROKk8OAizFxb3RfVPbS4XRpNWxEnVi1wmlbY9JWWKGCzAdnyXzTSwPRaCd8NA4A5L1
 LgRv0q+bNx9ku9PJ6HQZg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:8lR04dUQcFE=:3AkkltNPsa653PJqML/NlA
 EW70983IB0iRjyWkNvVl7vr2GvH0oE2bpLKJJYxnt4L2gbxj26IHiWJhwUJuodB9jWaCsqsBH
 6RsqnmF5xpIkM60/tTcgj7k1n4Z9OSz5lPTDm0qYNHo++FDsnEujNZ2NfP3brhL0d/lZ5T+PO
 p8MHPtS7Dc7F70Ry6FhvrpklOt0m/pKTLESI3Dpi8dapMy7CxA3AXPhjY1AEcG6d91+Ya/BEd
 71xCgGxsxwvWQ7MB4ZBG5NAorP7XeUk+HcEuhxbJltOaD2tMjzkPmUKnj7y8bkg4dh3GYT+Eo
 R+oAwq1dnNf7qZ8tA0+ZkxUimeiSCkR70YM53/Ih7h++Ch2LEbkCdRprpSAGatLZfiiSnAFRi
 +N1SssFmgSea0Dl9gT3sTbn6x7WpYDe8zT7NdCVMHXYBmFJQWNzW4R3Ivd/5ETp390zFcNQiY
 5r0PbDcmvaypA1zZkdANIz1TNJPObFvb5rPF1c37HVH7592orCZu1u1/zKhFRxT4ZX3IhXtbT
 TwxJAIIBkAbQIB1arksXz3IML94z4bjjMPGsRkHVnY6lwZnlZIeZjF44R4cqwZJ5HrxWzuTll
 QYFCjeZ9P9lVqfSu7BSDtq09dX6rhY7sKSWYolPYuTE4+TqA+QEjt7Fw4NDNBTSNmOHrLms4N
 QX87bAwPJAkiyLWXZEyW9NR4Ej+VuzBs+XRb+AgTyG4fBV+MMRTWJqMdj4TB3xwhglSc7F+nr
 15zIyz8/uGbNl4fPIfqdsSj3geikVRrHXQeXZPyo5KqXg7HvXMVmVSzpoL5LJ1HkkLIb9Am9W
 redBvG9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 8 Jul 2016, Jeff King wrote:

> I think we can clean that up, though. I'll hopefully have a series in a
> few minutes.

You caught me at busy times... I'll review it tomorrow, promise!

Ciao,
Dscho
