Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6052018F
	for <e@80x24.org>; Sat, 16 Jul 2016 13:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbcGPNGS (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 09:06:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:52731 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbcGPNGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 09:06:17 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MUpI8-1bs8Ra0JPY-00YBcm; Sat, 16 Jul 2016 15:05:54
 +0200
Date:	Sat, 16 Jul 2016 15:05:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Mike Hommey <mh@glandium.org>
cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] t/t8003-blame-corner-cases.sh: Use here
 documents
In-Reply-To: <20160715232346.12176-2-mh@glandium.org>
Message-ID: <alpine.DEB.2.20.1607161505100.28832@virtualbox>
References: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com> <20160715232346.12176-1-mh@glandium.org> <20160715232346.12176-2-mh@glandium.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bxQbALI449OYPODMtmU0isO1cfuT6DBZn/wHV0hoekdzPOVrgP6
 yFz9RXnlIzdJXM78gWGpXTmbQrlszAdPLC1CQP4xXqzB6gxP0kTcoVx3EXNoItdGMWAz3gv
 SDwO10odPsrhnLmCTpH13xMdAI7D6y+1O130RKm87B86rd9i6gccsFG6djIXOZpZ1RKLz6E
 SS2BuNUQWHVHYSGMUumQw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:oNOL15u4EHo=:hR+CLViPw2A6AXDSMTDbEE
 6Dp2z/6IhR8DLGPlovCSn36n9yj4sph8iwy9x56GdZgdJ9OzSqYZwzukbxoAWjsstMlRUbD/h
 VXzkYEPdZJ32NJvQZuOYn2enc2AEuVmHxqD71I4cA2lEbpauP0rTbAbK4j15pyQOH0YJuTfPW
 McIxDnOJJyGoOZRN/6xszSmMVJaT2YMYm0SArlxJYbQSQShucM/CwXbtCvQQYmv84QUOTjsdM
 bNsbKxndDV/meeXFnT+tWAMgY55J+k1+QqKCGf2thrRnOvFTB291cTj9PFuICbsLUuqvdYHQE
 7hpJp1PYxekv6tGy380ofD7WZn1t3pG1WeLDPytQrUmiJeRwb2elC9Qvcxib/NGAaGEoIgEIR
 U/gKfWOgWNWjfNNZQQbPl05DXeChn4FyBZUe8V/Lgaz0/bVeDl7I0PP9Y0MuLUqPOs3m3oVPo
 P2pRda0xRarIt8TD+hmqKmV84JPFtMipxjScPUNTQEGgCLjdTmHKDg2KD+wAafjw7AqaR8hMR
 Ge5sk7FrdzvH2NwWV8hQHZ1cDr/AC69p06mBjujdh6CJbgTgEZOUHr+TXoTUr2XEOsKK7t0NX
 3xClMwS0O8pEEdUuGnRKAzis3sRQuPLv50hRJdU/HcyLLnFc5zcIS9YobHeMr5Y4t5zsqrQMQ
 ow+MLehjnrd+iikCFqdUmm4kZibWJ4D/zZRfh5TYOBo3ZwKuKxrszCx04LxIDx7WESoVEIMcS
 VXlhYEACHgMZQ8N8HvItqtgMJJvdkOtNSKIU5DtzeG2czTFiK57rqflCAOsKfkUikLZA3/ZpR
 lcLvzQ4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Mike,

On Sat, 16 Jul 2016, Mike Hommey wrote:

> Somehow, this test was using:
> 
> {
> 	echo A
> 	echo B
> } > file
> 
> block to feed file contents. This changes those to the form most common
> in git test scripts:
> 
> cat >file <<-\EOF
> A
> B
> EOF
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>

I reviewed both patches and like them.

Thanks,
Dscho
