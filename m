Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADE520FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbcGAHrO (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:47:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:59993 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcGAHrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:47:12 -0400
Received: from virtualbox ([37.24.143.238]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LrNl6-1bT1080z88-0136C7; Fri, 01 Jul 2016 09:46:00
 +0200
Date:	Fri, 1 Jul 2016 09:45:58 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] consistent setup code for external commands
In-Reply-To: <20160701055532.GA4488@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607010939350.12947@virtualbox>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu> <20160701040715.GB4832@sigill.intra.peff.net> <20160701055532.GA4488@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zEKvTIEY/jxgXYlDgN3NwmLx+i5SLNLgC3CtB1hk15QF6jrjmJx
 /R9IF7w0AIVyruMSINlmDEv1TJFoLkr1brYpVXkDYfNzlZoGaS6Ksho4IVIUNC2QDpuUEjh
 Wj0VObOCMulIOmgIHkJd6Egrc4CTXwoBH1s8v18tpxiK6N6rkT/hrSEkXudZZOyhD4aaVh6
 V2yjP4jzOfOhGlvxw4A+A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:UqkyI7ZW3MU=:aI1EDh2dnvNqsrlrXJESdN
 IY7zCx1yLqgePZ7R7gmtWFu7xM/+uNiXFOn0R9Srkmb1dFC6jf6+3q0A9a0epOvY94Zv9VgY6
 kKflM+gLJs0jdov+/Y0f3U+p9aZCxH/FC2U+m2sagkKNbYChkKAMp+q0PTDQCembakbundASd
 plRw/1u8DDWmu/fCHlRXavIvbtxJ+/T5awJwyd2KMaFNHDlsCA6zdKV27iN0XL8zjFtbMWWns
 FVsAGDOa72QrX0A7QcNZ5FmZSKrtk/znch7Y2TaDMgvKBENG5ccKSaxx6EwwCCMmlwqRVf2pI
 HfwaASLtxXK3UBTZ+Py6tl+WpCCKP3CZEMLVfbJotBUZJw0Ltrr8a62XY0gyUS0aXewi9662i
 4cDKvcAe7K4rHLOvy74nb4TIRonuIU65fF+Mzns3odWOnHY+BYKI0mN9JHuGRXu46tk2y6Mf1
 rz/kxX2VymFIBk/3yvxQhp+uVa5/0MBYdKrG8M3L8ooUm5NHyJLE2QAKKxHsIdo9JKBSNmcZl
 5cR2ZnfJYU62NnLZwZUOXGgdAixDMAb2LnMarC9wgF0yB19ZrZOldCXJf9oP2RIuP5n0Ie37J
 u/YKdR4XNwAM8YDdhdIOMVohHKr8EH6NNVnaCOg0MO4id9zjxiJsvh3VcEOhSh2nmPBgi0tvc
 RpoFeLTVDGIc+xKJ95r4IboOIFOPoozEK23Mp6ycMtQ3FPkJPlR7hHKn898NeVKjy9zfXlezb
 pIqfYd5TsIaoEVzFe2bKVgJjiTtQL79qKkwOkX4WhxUsVLAug1FMsvErYhtC9XG10LRfJ3K7V
 fLcYFYo
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 1 Jul 2016, Jeff King wrote:

>   - for external programs run as "git foo", you get _two_ times.

I considered doing this in my work-around, but decided against it because
I deemed it too inelegant to call it twice.

But your patch series has more benefits than just fixing the assertion in
the credential-store.

For one, it makes test programs such as test-dump-untracked-cache.exe
usable outside Git's test suite without any major envvar jujitsu.

So once the dust settles, I will revert my commit in git-for-windows.git
and merge in your patches.

Thanks,
Dscho
