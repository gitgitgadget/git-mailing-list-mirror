Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368E12022D
	for <e@80x24.org>; Tue, 28 Feb 2017 11:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbdB1LgL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 06:36:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:59699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdB1Lf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 06:35:59 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3x6-1c48hF3cGq-00etLF; Tue, 28
 Feb 2017 12:34:06 +0100
Date:   Tue, 28 Feb 2017 12:32:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] Use time_t
In-Reply-To: <xmqqlgsrmesc.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702281211270.3767@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <xmqqlgsrmesc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3TuchMKtRCMZO8SFxYUsMVFY/Vy9QUECe3zC3pXs79Zi0KvmYSp
 TVraUnI+1HhG1eDXGLPsWw0FbTGRr5j13gdcXyPdB9eB0j03CpEyuIK+qGUWWRjmeTawrD8
 0UDQDNjw/l3G2U2YhKYQee7h/KtPtOajvNfuPirVGIh9aEb9LIq/HtiGK2VEKQocjDPvV30
 DJC2VSSwXxAscaabQX96Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T85abI2S/PI=:XJcj7Scci94qt1ujyUB9ac
 BDFHVbFcrEb+G0DpmK3DiLX1NusbwGwYTqnLGcOGqjs7RSN+yLe0/JCmhRu7dcNdcfBy7Ewxy
 d7AKC0+xk73PUVyTPfI5YIq9rpd1r0cLZfInXBcE1TQ8qeyW/T9nlK5zQusTfioont6LuUQbY
 cGZgsG9JlZVhpGZZB/AUdM+MtJV0E8Bg0XNHS1tqERtgc+zKYG7UojnkkF1eAYXRgeecLcPqQ
 zMyC5EqBY04VPi18V8jCc1pqtdOPj32w/5JG+sWPr1jRvVtVvkz/Oj4DZMz5ljwoZlwiehxip
 zdnq/rUe5ipXCiiPXzfc7ldD55ZvkDOad2BIDmJMMXAy6hmKxYmIwSzkI/ETRwNsnXhXxTALC
 VRKHjjhNNBcNujb8eT8sYtVIFwGvPaH4QyvhgHhdaEJPIKe5r+xXOYXoxfi+Orcji+oNFv6ce
 VoGCrTSJoVgSBRVqbHieTmkaONd8Qt1bmrmc7cR79sXj8PhGNz8xRpKXZLMcjdp/8ZONDh8f8
 8xf5C5N5aNT36/5HR+GYwME+PGHfJqSqgWLCbJVBCehTXzNSuJhMWd6J2vWpJdftBWaUpD41x
 5Bt5HxsYtoA7XAykLTMTL1fyLnmtlY1qNLfH4IOD1dRXarrb6n0XAp3tbm2yi6P7LCcHqzjXH
 DQuISfEBYMwZOBiiXYwLdDz/fkElZYbpVlxGKxwZNmwty8n5kfGeoiR/0v/I3x2XWeBmKt2Va
 Ym5G5cSLuQrltYmU4jtxJBfqzNl9y5VvFE42Qn+0hzqRAn1JK12eseUtxlRk6G7Ake6Z7HfTd
 Dny4U7LyhM+Hj8ab+jSESLaar+VwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Feb 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > One notable fallout of this patch series is that on 64-bit Linux (and
> > other platforms where `unsigned long` is 64-bit), we now limit the
> > range of dates to LONG_MAX (i.e. the *signed* maximum value). This
> > needs to be done as `time_t` can be signed (and indeed is at least on
> > my Ubuntu setup).
> >
> > Obviously, I think that we can live with that, and I hope that all
> > interested parties agree.
> 
> s/ulong/time_t/ is definintely a good change, and it will take us to a
> place we would want to be in in some future.  

Actually. I have to take back the part where I hoped that all interested
parties would agree. The problem is 32-bit Linux:

	$ cat >a1.c <<-\EOF
	#include <stdio.h>
	#include <limits.h>
	#include <time.h>

	int main(int argc, char **argv)
	{
		printf("sizeof(long): %d, sizeof(time_t): %d, ulong_max: %lu\n",
		       (int)sizeof(long), (int)sizeof(time_t), ULONG_MAX);
		return 0;
	}
	EOF

	$ gcc -m32 -Wall -o a1 a1.c

	$ ./a1
	sizeof(long): 4, sizeof(time_t): 4, ulong_max: 4294967295

So. Not only is `long` a 32-bit on 32-bit Linux, but so is `time_t`. And
with that, switching from `ULONG_MAX` as the maximal time we can represent
in Git to `LONG_MAX` is kind of a serious problem.

> As long as there remains no platform we care about whose time_t and long
> are still 32-bit signed integer, there will be a fallout to them with
> this change.

Sorry, I do not understand the verb "remains" in conjunction with "no
platform"...

Do you mean to say that currently no platform we care about has 32-bit
signed time_t/long?

If so, I just demonstrated this to be unfortunately incorrect.

> It appears that we use uint64_t in many places in our code.  So
> while philosophically time_t is the right type, uint64_t might be
> practically a safer alternative type to use at the endgame patch in
> this series.

Yes, I think you are right. We should use uint64_t instead of time_t, but
*semantically* we should not even use uint64_t. We should introduce our
own data type instead of repeating the mistake to use a data type that
does not convey its role to the reader.

Currently, I am favoring timestamp_t.

> I haven't seen it yet, but presumably the last one 6/6 is the endgame?

Maybe it took a while to get sent out, but it made it into public inbox:
http://public-inbox.org/git/75efe76cbb0636741a7c3aec9e21459bc1dc3cbe.1488231002.git.johannes.schindelin@gmx.de/

Ciao,
Johannes
