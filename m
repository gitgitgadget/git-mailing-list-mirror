Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DED1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbcHAJTJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:19:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:59692 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcHAJTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:19:06 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MX1hk-1bp8eY0Y7w-00VxM4; Mon, 01 Aug 2016 11:18:54
 +0200
Date:	Mon, 1 Aug 2016 11:18:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 12/16] merge-recursive: flush output buffer before
 printing error messages
In-Reply-To: <xmqqh9bavk2x.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011118480.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <349bdfacfffa11d06241655c9e0b62506e58758b.1469547160.git.johannes.schindelin@gmx.de> <xmqqh9bavk2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:94BUuNuK+hFzNgrReEKpBs9jYOxQNL/UIF8l69OoQBLELa5BDyV
 Y3BT+MHfFFjGA/x/Y0V+hKK5gJbtir2oQilZPknLaJcZGH49wdXsFC14eFd13TvdOTeW8xJ
 WUF92guI33ZpzAvHeJLYNXE5F9sKGJPLdJI2qMOkpdmJ6KTw5CIW/rWgZfFxntuz11fG4IO
 ykcnRpzyhSxOnwidICDHA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:eOG1UjyP904=:ueUCh7W+czX5cvuQ5MgPwc
 MTo7tY1IDH+mo1HLtj8ycUPBkf0UMd09xM5nGgpjkygntn1GWBhTsqf+i8Q1ZtmiBqsHMNAoz
 wKGgQDsrwILIFyxDqBCs+lzQDdybRBsSX4uRTAFu5RUQCBj1/i4MAgK5NPwLBqK9iUKW0wkaH
 z+Y3NUTpD4M9t/Jqcu2f9tDzFje2yormSr3C0hgjuM0Ht83LhbWNWyu1EJq2IHOkY000p/3kr
 nChtdHE9Rm/7Ph1qWEWKu0Xsxw5Nc7NI2NowHxwzdATWb5CBRYsiIBqX0AjU3LEAIEVrAeAQS
 vXMuJ2bh9PAnvdPQpMWTBjd1YLPCeM7VUuToyKKyWcs9x78MYFNKgzp86kJqUePpG+S9eoHua
 67s79+bTdBZ2HBLz8xMUo5URe0eDrRQW76ohTMqzIInUGDInbWxp4B0Xkd39q7RDGsq2Othh6
 j5pjwrg3vHZBPczdRkrq4laf+z4eNHIgEZxXz/XJVHxx9ohlFgqyu65EwO4FUBivs+FUg+Dfh
 BjddYrG1hQ4bRNrJ0KUy1dQ8Y/HH2PLA2iDS2ep69IPdIi6Rd2CBHl/nWkchjRqG35BiwF76R
 fBg6PUiW7QVM9LCHiss9+y3r839z0Ka5rCuHMaHT0TnYyOYVPhFayEldM27ZwzNxE5M8T2LV0
 M9+52VDbSSP0txOaCs3Jequ5C4n1Xudh8M11KVY5gnPpSWG+TyWhs+xRfl6SpduMyiz/Iaozq
 JBqHa5vXwG1Rzv8K3+33SDIqt0uuXwNtCQRk5sswhuC+0Yex88115+9iI5ovZls19WkNnvKOT
 be5+6RH
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The data structure passed to the recursive merge machinery has a feature
> > where the caller can ask for the output to be buffered into a strbuf, by
> > setting the field 'buffer_output'.
> >
> > Previously, we simply swallowed the buffered output when showing error
> > messages. With this patch, we show the output first, and only then print
> > the error message.
> 
> I didn't quite understand this paragraph until I realized that you
> meant "when showing die message".  We died without flushing, losing
> accumulated output.

I rephrased it, using your explanation.

> > +static int err(struct merge_options *o, const char *err, ...)
> > +{
> > +	va_list params;
> > +
> > +	va_start(params, err);
> > +	flush_output(o);
> 
> I would have written the above two swapped; va_start() logically
> is about what happens in the next four lines.

For some reason, I thought that `va_start()` must be the first statement
of the function. Fixed.

> > +	strbuf_vaddf(&o->obuf, err, params);
> > +	error("%s", o->obuf.buf);
> > +	strbuf_reset(&o->obuf);
> 
> Sneaky ;-)

Thanks ;-)
Dscho
