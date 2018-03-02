Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828BB1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425161AbeCBRGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 12:06:30 -0500
Received: from avasout04.plus.net ([212.159.14.19]:52010 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426856AbeCBRGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 12:06:30 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id ro8Ze23SoTRZxro8aeKiqy; Fri, 02 Mar 2018 17:06:28 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=R6ot5+ZX c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=IOncgDmTvlEYFr0ZtAMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] ref-filter: mark a file-local symbol as static
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
 <20180302035904.GA238112@aiede.svl.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <733494ed-56b1-9072-3c9d-cedc35acd215@ramsayjones.plus.com>
Date:   Fri, 2 Mar 2018 17:06:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302035904.GA238112@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDohTmyQbIpZpuMZQ0bseAxo9JNE50a3o9gTMwjYeUiosVgqrNHqfzw+R5vxCteCBuwhYGA1FmVU65kN6d2DiNHFZM1b+HbW1SX1asZ+cDDWTMLL1qjW
 gl3EQyUoAVI96g7ZYg5Ywx5oKeB+sDJnnLWrT4KJuemlxQpzmn4Rr7dVZm7XxoHBMCklSIP2tJqSYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/03/18 03:59, Jonathan Nieder wrote:
> Hi,
> 
> Ramsay Jones wrote:
> 
>> Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
>> <id> is invalid', 2018-02-23) added the add_str_to_commit_list()
>> function, which causes sparse to issue a "... not declared. Should it
>> be static?" warning for that symbol.
> 
> Thanks for catching it!
> 
>> In order to suppress the warning, mark that function as static.
> 
> Isn't this closer to
> 
> 	Indeed, the function is only used in this one compilation
> 	unit. Mark it static.
> 
> ?  In other words, sparse's warning is accurate, and this is not about
> trying to quiet a false positive but about addressing a true positive.

I thought that was implied by the commit subject line. :-D

However, it certainly doesn't hurt to be more explicit.

Junio, do you want me to re-roll, or would you mind tweaking the
commit message while queueing?

Thanks!

ATB,
Ramsay Jones


