Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE77C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877212072C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GMW9I2Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKDQ6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:58:03 -0500
Received: from avasout01.plus.net ([84.93.230.227]:41664 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbgKDQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 11:58:01 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id aM6Vk76G5n8O7aM6WkKNc2; Wed, 04 Nov 2020 16:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604509079; bh=tczuhKc30UrVwc1iYdjTinhWBYxmruz/z1Klxr4URuM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GMW9I2Fp4Aaa7h4okkrR9N6BDq7grqYAdurwEowM3ZpZMhK2T5TDk3pacBQXXkskT
         DH9y3dxVq/97hOgUeiQM2A2IyvmW77te+d6Bug0XD725qP+A7jd98Ldi5Po6JJcLPz
         fEnzmyrQ9/Whw4NRLBD976aaK9hmatJkfvVxs5dnJausR9q1QO/88RCI394L/kbIv6
         YmS8TWOdYi4BahS9WyyxAkZJRBnIfCXWxRwhUovcOQU1pbk/D9l9XXUJhPY1csdl61
         vj+VzVT7STYkz4C0+h//+17zBIlS7qT8kDp/v7XZ4YpAUUNWrXNAiuaJQacJcLEFqx
         zJq4/Lkp1Uhlw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=w0RzvLSWAAAA:20 a=5p_tG3gqAAAA:8 a=HmkP6QBsIiYic8n2SgcA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
 <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
 <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
 <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
 <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2011041431370.18437@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <67b3569c-453f-4e6a-502e-136f8f3d8df7@ramsayjones.plus.com>
Date:   Wed, 4 Nov 2020 16:57:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011041431370.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHy3pK9xi/giPSFnqpZehc1W8qekPYbiEUe+VM6R4bEz5s/gFpgcNC+8S3jBU+o1wHfbt4VcxxgGIK/DJ/xTVZmaIxgQ4Lb2oswVeB81BjsnaCHOv93I
 7HYaKE0eN33R2cj84Fqc+IdIzA4ah0STYL8lv6fZ3VxkGiGWgpd/nhBojxou1oeE/Xi1qQIxKB6GjQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/11/2020 13:43, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Tue, 3 Nov 2020, Ramsay Jones wrote:
> 
>> On 02/11/2020 18:55, Junio C Hamano wrote:
>>
>>> CI builds already have enough stuff around invocation of "make test"
>>> etc., and it would be trivial to pass SPARSE_FLAGS from the command
>>> line when adding "make sparse" invocation to one of the scripts in ci/
>>> directory, so from that point of view, this patch is not needed for
>>> them, either.
>>
>> My concern was more about how the CI system obtains/installs/builds a
>> sufficiently new version of sparse. Otherwise, 'make sparse' won't do
>> very much. ;-)  As I said, I don't know what's involved in getting that
>> to work.
> 
> As mentioned in https://github.com/gitgitgadget/git/issues/345, there is a
> Pipeline that builds sparse packages for Ubuntu, ready for use in our CI
> build: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary.
> Currently, it is scheduled to run every weekday at 5:00am (I assume that's
> UTC).

Oh-my! Has there been a CI 'make sparse' build since september last year? :-D
I missed that! (I couldn't view the azure build summary given above - it just
keeps asking for a user/password :( ).

ATB,
Ramsay Jones

