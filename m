Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDDC1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 16:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbcLAQK2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:10:28 -0500
Received: from avasout06.plus.net ([212.159.14.18]:54857 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932873AbcLAQK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:10:26 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Dec 2016 11:10:06 EST
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id Eg2d1u00H0srQBz01g2fEq; Thu, 01 Dec 2016 16:02:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=ti3Vri4vOqBFeaNiaQsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
Cc:     Jann Horn <jannh@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
Date:   Thu, 1 Dec 2016 16:02:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/12/16 09:04, Jeff King wrote:
> If a malicious server redirects the initial ref
> advertisement, it may be able to leak sha1s from other,
> unrelated servers that the client has access to. For
> example, imagine that Alice is a git user, she has access to
> a private repository on a server hosted by Bob, and Mallory
> runs a malicious server and wants to find out about Bob's
> private repository.
> 
> Mallory asks Alice to clone an unrelated repository from her
-----------------------------------------------------------^^^
... from _him_ ? (ie Mallory)

> over HTTP. When Alice's client contacts Mallory's server for
> the initial ref advertisement, the server issues an HTTP
> redirect for Bob's server. Alice contacts Bob's server and
> gets the ref advertisement for the private repository. If
> there is anything to fetch, she then follows up by asking
> the server for one or more sha1 objects. But who is the
> server?
> 
> If it is still Mallory's server, then Alice will leak the
> existence of those sha1s to her.
------------------------------^^^
... to _him_ ? (again Mallory)

ATB,
Ramsay Jones
