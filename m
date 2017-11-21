Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793B12036D
	for <e@80x24.org>; Tue, 21 Nov 2017 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdKUSTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 13:19:10 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:39409 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUSTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 13:19:09 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id HD8UeN12WmITaHD8VeLd90; Tue, 21 Nov 2017 18:19:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511288348;
        bh=vvhWSNUJK+CVlENK7LlrvmL7XYz7wC9DXl/5NzrpdDM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X958Ukt9jyPpvwYfN76GJ6PeZYf0UHtkbcASM92n5zfz6UZE4f0evQdVC4UbiqI/E
         N3/jGD4wOWfnS+muPxbnO7sp1VtnIcK3qTOFRxnkA2ePpTj8A9sQz1dMzgHxEVQG/3
         zNrS7aJhNnoK1uquK/f2CpKO2irlytj+wDE19Hqg=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=du6JPaR-88BoEE2quAsA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: t3512 & t3513 'unexpected passes'
To:     Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <73f0fb1e-5b55-1049-7706-652f1f9deaed@ramsayjones.plus.com>
 <20171121104404.GN20681@dinwoodie.org>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a3ed15c4-61b7-aae2-d849-4dbea2fd7511@talktalk.net>
Date:   Tue, 21 Nov 2017 18:19:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171121104404.GN20681@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEENjTjlTqOxerTSw6pagVDtkxih8rejldd0r5qiWJBpoJecIyjrC4U10khU1Nyp5/b8XP1CSdACPtoOTrAkkX6nDGzym/yDApTrV7LP2WGB1g9yC6Fx
 CC68truHrpc8WTAVDq1sg2cL4navaRBSfXHKHaZVYAkc/lHgRotnFzF0A15joneryVCxUC5Hi0KusairkhBZAqPzfsks0eMyWVxhWZ8qSyOs9+a4c/Gng319
 6Q5q8tRwKqIYjJNr3BuCCVRp1v3Gizn0BE14ixz9CmrqypWSoVeqB2kvLiF/9UW+KrYPqIEA6cWQ06HQl4u+iY48JeckasNz2c2qniGqXbtjWx3SutMRPAS0
 u2QXlL2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/11/17 10:44, Adam Dinwoodie wrote:
> On Monday 20 November 2017 at 08:16 pm +0000, Ramsay Jones wrote:
>> For several days, I have been staring at some 'unexpected passes' in
>> the t3512-cherry-pick-submodule.sh and t3513-revert-submodule.sh test
>> files (tests #11-13 in both cases).

Thanks for pointing this out.

<snip>

> I've seen the same unexpected passes, and had just completed the same
> bisect run myself, although I fixed the build failure by cherry-picking
> 82921316a ("SQUASH???", 2017-11-18) onto commits that wouldn't build,
> given that commit seems to exist entirely to fix that build breakage.  I
> think that adds more weight to b5a812b29 being the culprit for these
> unexpected passes.
> 
> It's definitely the case that these unexpected passes exist at 8e4ff0ae1
> ("Merge branch 'pw/sequencer-in-process-commit' into pu", 2017-11-21)
> and do not exist at its immediate left-hand parent, e017a4ccc ("Merge
> branch 'jn/ssh-wrappers' into jch", 2017-11-21), which means it's
> clearly _something_ in the branch merged at 8e4ff0ae1.

If I've understood the comments by those tests this has to do with the
new code detecting empty commits where the old code does not or vice
versa. The new code detects an attempt to create an empty commit by
comparing the tree that is about to be committed to HEAD and complains
if they are the same. I've had a quick look through the code for 'git
commit' but I need more time to figure out exactly what it does in this
case (I've a feeling from when I looked a while ago that it does this
test before it writes the tree). If anyone has any insight as to why the
tests fail with the current commit implementation that would be helpful
for understanding what is going on here - unfortunately I've never
really used submodules.

Best Wishes

Phillip


