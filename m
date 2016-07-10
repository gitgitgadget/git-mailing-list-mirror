Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDC11F744
	for <e@80x24.org>; Sun, 10 Jul 2016 10:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbcGJKx4 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 06:53:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:59691 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbcGJKxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 06:53:55 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLi1v-1bLvNY0qPb-000qxl; Sun, 10 Jul 2016 12:53:23
 +0200
Date:	Sun, 10 Jul 2016 12:53:20 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: ignore return value of write_file()
In-Reply-To: <alpine.DEB.2.20.1607091624120.6426@virtualbox>
Message-ID: <alpine.DEB.2.20.1607101251230.6426@virtualbox>
References: <577EB546.1090007@web.de> <20160707203157.GA11804@sigill.intra.peff.net> <alpine.DEB.2.20.1607080834340.6426@virtualbox> <20160708065650.GA10664@sigill.intra.peff.net> <alpine.DEB.2.20.1607091624120.6426@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sBJuvq6AFCyGvKcHtLUzdLTiq51Ro7C7mkwhHbgxnRV63FoW3Nw
 ZJp1nuVvhnshHcXI54c2R1ZGpZWGFvVdcdecsvqwO9CdNKSitw48VyUAjHdFnBilOpyOnaI
 N0FsEbLgEO/w2rfjWeC0olRzSGAX8ORabV7zniZFHCRmFxQqiBjYtGqnJuENWhziOfE+CHJ
 ++SX/cuZnx9aTmunBCecA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nWB32ONIT5M=:akAT/BKe5wIBxsyuPaNZa8
 2SHmiLiucsIlKQEGEqvnpubxaGX/E/KRN6oxOGuoCGd2goUJDQydb/1fdTVMibCP0znTIk0io
 kjrZcvd7N/dm8mSAouteZDS9VajkTbb7bha6vdkrFNHtuhocg9BeF0fa0ZwB3NgFgPGLhxMj/
 4uZbqu5z6w6rBbVUFD8I9hBx3QibN5idizvaj9kBvtB81z5AW+oJWENsK94XQEn8sy5FL19KC
 JknITmZIJm5xyGu+xiETKnlgN7XI1yRbfEIpFyxNI0Lm3FqA9CCiaO/v3jPNAi6M91JhjDpuI
 5QRX90vHvvzXbmVr2/se4pwL07fiA626jOU0EE/i6DhpS+Sgdv1Y1Rukb8VHg00P8HjXtGnaN
 Zdk6/h6le5qe9RKvEBGog2Vk3GiFBrbNy27fyIACWo1dmmNH8PXENW9srELADDZiDexvud5nY
 vE/U2OKBEHrQwzu3dC0GOLRtRc0skSCs3WrdQqp4lwhLc5S5v6e4eLSZip7+FlJOnlvEktHRl
 uyBR0bgeRA0gYon6U0CZ9+CPPSRKs0mykVa+wowsIgiwnaDmJgd0aCTmKpmSZIQ2ir1g7/iyj
 aV/nhevYSid/+yFIFEsU3BU2IneOXlvFWCqDsCB6VU83yVWZzX7gOCSFdCEmY5cdcMPxnw06y
 TxgVbuMuPcIT7hVVi3ULKTZm4NnNV+UCtFnOpmaXB50Qsew591dIgGgU+U3GkAbGI7Q509Ygh
 wsfjEgE/QS/kH3l2wjFZVCe5QfCTtxwtfcxE4H88fuzbrJ/zCPKxynHL68g3BQc0XNdhHWW+k
 qY6wFyN
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Sat, 9 Jul 2016, Johannes Schindelin wrote:

> On Fri, 8 Jul 2016, Jeff King wrote:
> 
> > I think we can clean that up, though. I'll hopefully have a series in a
> > few minutes.
> 
> You caught me at busy times... I'll review it tomorrow, promise!

And so I did. Looks good to me, I was surprised that there were no
possible callers is the non-builtin code. But I guess they all use the
lockfile mechanism now.

Ciao,
Dscho
