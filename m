Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8676A20705
	for <e@80x24.org>; Wed,  6 Jul 2016 07:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbcGFHcQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 03:32:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:49542 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcGFHcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 03:32:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9ra4-1b9fkK1WuW-00B75v; Wed, 06 Jul 2016 09:31:56
 +0200
Date:	Wed, 6 Jul 2016 09:28:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
In-Reply-To: <20160705204447.GB14496@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607060906550.6426@virtualbox>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de> <20160705202820.GA14496@sigill.intra.peff.net> <20160705204447.GB14496@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZBRcsXyghrHQBVaL0T7TR0JzWz3HFjr/fl5KS655tQK2vmLprcd
 pAb7QbiYOABl2NXA6EGSvRgDv53xxvLwrixwsixbIpz56/GKWlpR77wQ3MFQBBnjLYAFJM0
 Ac3Wef0WifRuAiq9oD4cYLPHLZX+l2lj5acb3zF2FXS7Z6LzcyXeCS4h3U4iwwM0UwhrNcp
 xUYvRsK5+dHganLm+wRYg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:3n2KjVjGbkg=:8SHoXzC5kohG/G2rI+QEfe
 zGAn0Pjr7vGcUBdpgGJw14Yd/l5LQCxmbMFW1i7fFFlurwhjUnZPVUd1AujpGWLx1kN1Axhkf
 4iQDk0fgzRNkbkeIRKLadeKFNCEBpnXf7Ui0L00x2uNvVTnPmSZQwMwjIXe6w/wro7VONU1/I
 Qsnuc1uzDDERaQJ8tnO8BH02pPF2JpdIHK2UO4q06BuhI0I3PmCW207e649MgYLJ9JoRYLS2x
 R0776bSoc3Cbn93U27TTgsQgTD8/3qNTU30k4crmiQrDWC08j+k1kwmTgrP1JeJfO4FACXhVb
 Smy0PSoddiDof+X5pDwOZjYKSBbndFxAuISGPCuKWH8S9g90ij6uCOvTHUdanqnCa+GO69vAZ
 HZCIT7f48H1QGq4tlmGXPir1v7EnRSgS1Jztzfo+CwW5R8eTefQ8c8rwJHrLQCU1kKdUpHAnD
 4Vl3mAod52gib12h1fINd1iHLRhKJpZhYjk4fTkXgFpjWUKv7+TRU/MBL+T7OE7nXlxui5CKG
 Q0I9ad7rzoHLmczT53Q5DyUX3m18y5/nlnjsTik3oAO6kJijby7eHZYz9UDb/mV82xyyAWBFI
 MbUmbDVTCiIiaGhrTcO8oojVYqxG03KpaRPvUrw4y/X121zbWYGEelQPPRg/gXrQnbfplw6Dl
 fVwyjzrmfkDcmZe3irgGUWKPE6mSARRcvQ/EATblN1t4Wxvsc/j0dG6lEi4kEXpXrdveFqtOo
 mjQFlC6iUAs5l9WZY4KLURgfrw/+tOT8OyJXvdgKnTgstsmaXc5Yy9+AbiITWaMjmtWnnTz3T
 FiXlj1B
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 5 Jul 2016, Jeff King wrote:

> +	ALLOC_ARRAY(ret, st_add3(a_len, b_len, 1));
> +	for (i = 0; i < a_len; i++)
> +		ret[i] = a[i];
> +	for (i = 0; i < b_len; i++)
> +		ret[a_len + i] = b[i];
> +	ret[a_len + b_len] = b[b_len]; /* final OPTION_END */

Not really a big deal, but I'd have written "i <= b_len" in the for loop
and avoided the final line. However, your version is clearer.

Ciao,
Dscho
