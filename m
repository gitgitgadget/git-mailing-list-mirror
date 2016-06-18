Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90781FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 00:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbcFRA6P (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 20:58:15 -0400
Received: from avasout04.plus.net ([212.159.14.19]:41051 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbcFRA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 20:58:15 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 80yB1t0015VX2mk010yCLK; Sat, 18 Jun 2016 01:58:13 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=9FqDv352sWjqah6v6PIA:9 a=QEXdDO2ut3YA:10
X-AUTH:	ramsayjones@:2500
Subject: Re: [PATCH] run-command: mark file-local symbols static
To:	Jeff King <peff@peff.net>
References: <57646524.7040708@ramsayjones.plus.com>
 <20160617233309.GB26564@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <57649CA1.8010109@ramsayjones.plus.com>
Date:	Sat, 18 Jun 2016 01:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160617233309.GB26564@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 18/06/16 00:33, Jeff King wrote:
> On Fri, Jun 17, 2016 at 10:01:24PM +0100, Ramsay Jones wrote:
> 
>> If you need to re-roll your 'jk/gpg-interface-cleanup' branch, could
>> you please squash this into the relevant patch (commit 74287e34,
>> "run-command: add pipe_command helper", 16-06-2016).
> 
> Thanks, yes.
> 
>> BTW, also on that branch, commit 6fec0a89 ("verify_signed_buffer: use
>> tempfile object", 16-06-2016) removes the last use of the git_mkstemp()
>> function. Should it be removed?
> 
> I think so. We still have git_mkstemp_mode and friends, so in that sense
> this is part of a family of commands that somebody might use again. But:
> 
>   1. Unlike the others in the family, where we implement mkstemp
>      ourselves, this one uses the system mkstemp. Which probably behaves
>      in totally the same way, but it's kind of weird and oddball.
> 
>   2. I think we should be steering people towards tempfile.c anyway, for
>      its auto-cleanup properties.
> 
> Want to do a patch on top?

OK, will do. (tomorrow, it is 2am here ...)

ATB,
Ramsay Jones


