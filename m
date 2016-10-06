Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A5820986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965308AbcJFJdR (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:33:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:57046 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbcJFJdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:33:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2WgT-1b0fe00Blt-00sR0b; Thu, 06 Oct 2016 11:32:49
 +0200
Date:   Thu, 6 Oct 2016 11:32:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        ramsay@ramsayjones.plus.com, jnareb@gmail.com, j6t@kdbg.org,
        tboegi@web.de, peff@peff.net, mlbright@gmail.com
Subject: Re: [PATCH v9 04/14] run-command: add wait_on_exit
In-Reply-To: <xmqqeg3uo5yt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610061129430.35196@virtualbox>
References: <20161004125947.67104-1-larsxschneider@gmail.com>        <20161004125947.67104-5-larsxschneider@gmail.com>        <xmqqh98rud20.fsf@gitster.mtv.corp.google.com>        <1FD7FB64-0F40-47F0-A047-25B91B170E66@gmail.com>
 <xmqqeg3uo5yt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9SvVecqp4r06LiOVUp+22mrg+kSPDF2oJdsvLPBqJ0F2TZ1a87i
 G84eFso/XXKitqp6EXtQ8qJ9yzG6/imQj38ELkj6DESyFad6iLpsbYEk5LbBBYWSbxtN+bY
 zdnAYvCY9fodiM5BLkDGpeQTOIV9Q3LRgltAku6CWCZfNVNprtjeyT1I/C4LEjuthKuOfUK
 9f/q6TQ/7OErv5SaspdEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bv+SX2PgaCI=:i19O03Hfw3LkwpAcQUZPnv
 lJ52dgE7B2PycyKzbyk0KRKRQJlG9fgBLyPmojDXpRDA/G9jW9D+DvHCW0o9cGinzouSKxJ5C
 pb43Y0HNWA/6t6DDylj/pU2d4fviLFY61gtgh23Zvx2iwPyudk18nQ+heJ6ooBul9hu41tWFg
 E4poThtL3x6U4zIjKfdBRCOMBK3Ypj676dWfpu2QdWFBUaXcPFIBdaCXJPrY5Fpm+uHQYLMjJ
 Roe/7X2CpoqQZIILbPjv62cNRhg4x33yoEHv7S3OIqkKcVpqnalxRrUx1FdPTmWck41u96cRV
 woSyuSik+gtMUwiHNFm/DTdWXvl7phuAS05IQgnBToGhhItzNSXxNqqxBK4hbozLeZD10Kvts
 XkOIfNcTpNxOBbHOfXLpojCB6bR9bWjks7OnLD1/Se7iy536y87188EPbsO7oCu9rRdbqNIRK
 WWFQPgl7P+vnxDrW9uTgftLA6GO1E5hPQKYuvLNEEcVlG7q/vYu7Tsp+RTVhQRrZil10jzJiA
 fQFkK/RaHcNmwLTpOwE6zHvuNODAxyWCy4jwETa6CLAxG1PIJU8ZWj+STVgoIk/H07BvPeK+U
 7XhFzwrKK6QriTtKoR08WCBBao0TQL/qhbLxpqpCmeL9AvsraMtGrkYOe+BANFKmV6LtXj/ZQ
 4FNgE0AkGg5VqvqSYaYu5Q2gb+Sea3WNm2C1d6LJpkXGDvYovxFBFUdIm2al2kkueG9oVkrs/
 aKD52+3A06/RhxWScsj/Ms/GMn2YoUbbegYR8Okd3WYpLwVe/cjH/5W8mfx247XdYLOpzmxRz
 Akmz/Cx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Lars,

On Wed, 5 Oct 2016, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > OK. Something like the patch below would work nicely.
> 
> Yeah, something along that line; it would eliminate the need to
> worry about a field named "stdin" ;-)

Not only a need to worry. Git for Windows' SDK's headers define

	#define stdin (&__iob_func()[0])

leading to the compile error

	In file included from git-compat-util.h:159:0,
                 from cache.h:4,
                 from run-command.c:1:
	run-command.c:25:6: error: expected identifier or '(' before '&' token
	  int stdin;
	      ^

I meant to investigate this build failure of `pu` earlier but only got
around to do it today.

Ciao,
Dscho
