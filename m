Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA21C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91D820759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nBOZqqY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgKDUFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:05:08 -0500
Received: from avasout01.plus.net ([84.93.230.227]:53737 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbgKDUFI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:05:08 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id aP1lk7LNan8O7aP1mkKVSY; Wed, 04 Nov 2020 20:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604520306; bh=6zJ9MpJmeyFqKSkyiNEj2n9aMot1rEbs9tRuClcWreY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nBOZqqY84Bf+rQeCw1tNcC0c10HDE5mxd40EwVcZoFxRHGQLFlBwNUzYYC+ZrN9F6
         FSgxGGYs6gG3vUQIOv6Q7+pEY6mpwVLkV+JJW7/PG+m6g7VvQyMIyJVsshH3KTrvy1
         iB8G+48g2M8bbettzkp7Cg4Q1BynDxHMILjMvRKhUxeuTyGZC/6NEVaPxIHo4t0J3l
         jw7E6a+uaibboKBFlERQIZeSUK+foKmG1rwwR3FGCX1xBmekCG+iynSZsVShWL8AcS
         I1ggCftllkHiP7XldVCJ9OqF+4hLeJDXJFWwqVsOR8cdFofUkPs9oyaSrLKGVDqtkn
         HGVYbAKTa9SkQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=w0RzvLSWAAAA:20 a=5p_tG3gqAAAA:8
 a=dMj9qbwedp2y1qN_MW8A:9 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
 <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
 <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
 <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
 <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2011041431370.18437@tvgsbejvaqbjf.bet>
 <67b3569c-453f-4e6a-502e-136f8f3d8df7@ramsayjones.plus.com>
 <xmqqk0v1m1ox.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5885924e-ae91-1ed8-7b32-949b9ea377bd@ramsayjones.plus.com>
Date:   Wed, 4 Nov 2020 20:05:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0v1m1ox.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDH50u55AtsvflqobkaGuC8x3EezlqJi9qdtdZ5iM9QXHobt+27tGcK9GxN/ig4Z+C4qUcGu8+4kh9qCMAcyfSvxzSlBz+i6K507JflZOp822DRtdTw+
 OwyrFPWERbNkgzD1X0qoDv/sRPUF2K5LH5Tz6aI2/Pm8FT8sOJD25MCX4YaRh9oY+CREkHg2WYdCvQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/11/2020 18:11, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 04/11/2020 13:43, Johannes Schindelin wrote:
>>> Hi Ramsay,
>>>
>>> On Tue, 3 Nov 2020, Ramsay Jones wrote:
>>>
>>>> On 02/11/2020 18:55, Junio C Hamano wrote:
>>>>
>>>>> CI builds already have enough stuff around invocation of "make test"
>>>>> etc., and it would be trivial to pass SPARSE_FLAGS from the command
>>>>> line when adding "make sparse" invocation to one of the scripts in ci/
>>>>> directory, so from that point of view, this patch is not needed for
>>>>> them, either.
>>>>
>>>> My concern was more about how the CI system obtains/installs/builds a
>>>> sufficiently new version of sparse. Otherwise, 'make sparse' won't do
>>>> very much. ;-)  As I said, I don't know what's involved in getting that
>>>> to work.
>>>
>>> As mentioned in https://github.com/gitgitgadget/git/issues/345, there is a
>>> Pipeline that builds sparse packages for Ubuntu, ready for use in our CI
>>> build: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary.
>>> Currently, it is scheduled to run every weekday at 5:00am (I assume that's
>>> UTC).
>>
>> Oh-my! Has there been a CI 'make sparse' build since september last year? :-D
>> I missed that! (I couldn't view the azure build summary given above - it just
>> keeps asking for a user/password :( ).
> 
> Hmph, is that what Dscho said?
> 
> I thought he was just saying packaged versions of latest sparse
> usable on Ubuntu are regularly available so those who wants to add
> "make sparse" to our jobs have a place to fetch it from.

Ah, yes. Having read that again, I think your interpretation is correct.

Ahem. My mistake. Still, it's good to know that a suitable version of
sparse is available should anyone need it.

Thanks!

ATB,
Ramsay Jones


