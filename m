Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE1820951
	for <e@80x24.org>; Wed, 15 Mar 2017 00:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdCOAPn (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 20:15:43 -0400
Received: from avasout04.plus.net ([212.159.14.19]:52086 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdCOAPm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 20:15:42 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id w0Ff1u00222aPyA010Fg6a; Wed, 15 Mar 2017 00:15:40 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=N659UExz7-8A:10 a=iKrn8l-KAAAA:8 a=ReYs8vE-k4mOGKPJbSwA:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=pILNOxqGKmIA:10 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
 <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
 <xmqq1stzio5b.fsf@gitster.mtv.corp.google.com>
 <1fce97df-7eb8-79d5-b96b-2086746bf19d@ramsayjones.plus.com>
 <20170314234659.wamzgpqu2aikghci@genre.crustytoothpaste.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <dd285cb9-c7c7-e945-1fa2-7eb58d83ea06@ramsayjones.plus.com>
Date:   Wed, 15 Mar 2017 00:15:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170314234659.wamzgpqu2aikghci@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/03/17 23:46, brian m. carlson wrote:
> On Tue, Mar 14, 2017 at 11:42:20PM +0000, Ramsay Jones wrote:
>>
>>
>> On 14/03/17 20:44, Junio C Hamano wrote:
>>> OK, then I'll queue this.  The selection still goes to BASIC_CFLAGS
>>> so the dependencies for re-compilation should be right, I'd think.
>>>
>>> -- >8 --
>>> From: "brian m. carlson" <sandals@crustytoothpaste.net>
>>> Date: Sat, 11 Mar 2017 22:28:18 +0000
>>> Subject: [PATCH] hash.h: move SHA-1 implementation selection into a header file
>>>
>>> Many developers use functionality in their editors that allows for quick
>>> syntax checks, including warning about questionable constructs.  This
>>> functionality allows rapid development with fewer errors.  However, such
>>> functionality generally does not allow the specification of
>>> project-specific defines or command-line options.
>>>
>>> Since the SHA1_HEADER include is not defined in such a case, developers
>>> see spurious errors when using these tools.  Furthermore, while using a
>>> macro as the argument to #include is permitted by C11, it isn't
>>> permitted by C89 and C99, and there are known implementations which
>>> reject it.
>>
>> C99 certainly allows a macro argument to #include (see, 6.10.2-4; there
>> is also an example in 6.10.2-8).
>>
>> I can't remember if it's allowed in C89/C90 (I think it is). I only
>> have immediate access to the C99 and C11 standards (and I can't be
>> bothered to search), so I can't say for sure.
> 
> You're right.  I only have access to N1124 (the C99 final draft), but it
> does allow that.  I could have sworn it was new in C11.  I'm pretty
> certain it isn't allowed in C89, but I don't have access to that
> standard.

My copies of Harbison and Steele (Third and Fifth editions) claim that
Standard C supports it also (by which they mean C89/C90).

> I know there have been reasonably standards-conforming compilers that
> have rejected it in the past, but I can't remember which ones (I think
> they were for proprietary Unices).

Yes, I think that happened to me on Irix, if I recall correctly.

> Junio, do you want to amend the commit message before you merge it?

Yes, please! ;-)

ATB,
Ramsay Jones


