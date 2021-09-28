Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47869C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F31D6120A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 01:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhI1BqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:46:22 -0400
Received: from avasout06.plus.net ([212.159.14.18]:40409 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238481AbhI1BqV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 21:46:21 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id V2Ahmw86RzwAFV2AimK7ZD; Tue, 28 Sep 2021 02:44:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632793481; bh=OYjvEl0DEZkCW4Xy9Gzw1InvK9V5BU+ZjJfOiFXnESQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NgXDA6H3pRGXfca4Uz+qvdYSzDCqttHLtR/EdI30NltbmnU62wACYcOSkqGi5EUnm
         5ByHl5tzMG2BAyR47+RHsey46pJ7/Nq35TbTWiJJ2Qu87RrM5FIkAAj0jQF8hJ0amh
         beOH+N3qBvA5jKrJ8aE7b/obE3bqIrkxOai9G0uT/4361yFeFQ9iFyURxLnG3ellrW
         zvs8n8ylJwWovsfsZXGk2brdckqtcLiR+pxVLTtYC/X7pkyPUKcFmASuKWUYIMJmOY
         xvsdh+eocHDYrQAenu+0fAdCscSxAU3jqSS4f/HvzHF+Bp9JyXTOYGWEri9ooiQGfj
         o0JQmxg97drjg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=FKGAO9gs c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8
 a=zreE_j2jaizrHBlNcCIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/5] *.[ch] *_INIT macros: use { 0 } for a "zero out"
 idiom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
 <patch-v2-2.5-afcd2729c95-20210927T124407Z-avarab@gmail.com>
 <YVJSwuqjolz28+mG@coredump.intra.peff.net>
 <87h7e5zgjw.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4516b271-c9ed-2413-67c9-a783119fc0dd@ramsayjones.plus.com>
Date:   Tue, 28 Sep 2021 02:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87h7e5zgjw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfInXMF2MXGdhA/O+jEYmdU7GF3lAq1o+DoVc92OD8YMkQU4Ej4e02H5vIp1NDqIY4TxckOxEAjCBQjLA62QMCDaRd3X5DoC78QLIB1gk3qoDhpIiRpEk
 wfoZQD/EJalii9UOvy46N43ZSd96XkGMEVuI7ec4fOvokzUeVaCnJPfG1n+TomBpnInEdY8tS6pLTw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/09/2021 01:25, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 27 2021, Jeff King wrote:
> 
>> On Mon, Sep 27, 2021 at 02:54:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> In C it isn't required to specify that all members of a struct are
>>> zero'd out to 0, NULL or '\0', just providing a "{ 0 }" will
>>> accomplish that.
>>>
>>> Let's also change code that provided N zero'd fields to just
>>> provide one, and change e.g. "{ NULL }" to "{ 0 }" for
>>> consistency. I.e. even if the first member is a pointer let's use "0"
>>> instead of "NULL". The point of using "0" consistently is to pick one,
>>> and to not have the reader wonder why we're not using the same pattern
>>> everywhere.
>>
>> I seem to recall we've had some linter complaints about using "0" to
>> initialize a pointer, but I think these days it's OK, per:
>>
>>  - 1c96642326 (sparse: allow '{ 0 }' to be used without warnings,
>>    2020-05-22)
>>
>> and
>>
>>  - https://lore.kernel.org/git/18bd6127-be72-b7b7-8e2a-17bbe7214a2e@ramsayjones.plus.com/
>>
>> I think this is a good step, as the long lists are unwieldy and difficult to
>> keep up to date without actually providing any readability or functional
>> value.
> 
> [+CC Luc Van Oostenryck <luc.vanoostenryck@gmail.com>]
> 
> It seems like we should just revert 1c96642326, looking at the history
> of sparse.git there's:
> 
>  - 537e3e2d (univ-init: conditionally accept { 0 } without warnings, 2020-05-18)
> 
> Followed by git.git's 1c96642326 a few days later, but then in sparse.git:
> 
>  - 41f651b4 (univ-init: set default to -Wno-universal-initializer, 2020-05-29)
> 
> I.e. a few days after the workaround in git.git the upstream repo
> changed the default. The 537e3e2d isn't in any release of sparse that
> 41f651b4 isn't in, they both first appeared in v0.6.2.
> 
> So us having -Wno-universal-initializer only seems useful if you're
> using some old commit in sparse.git.
> 
> Having written the above I found
> https://lore.kernel.org/git/20200530162432.a7fitzjc53hsn2ej@ltop.local/;
> i.e. sparse's maintainer pretty much saying the same thing.

Yes, this has been on my TODO list pretty much since commit 41f651b4, but
it wasn't a priority. ;-)

ATB,
Ramsay Jones

