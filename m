Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF107C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948C4613EE
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEUXW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 19:22:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40003 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhEUXW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 19:22:57 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14LNK7G4301272
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 21 May 2021 16:20:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14LNK7G4301272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621639211;
        bh=cc1+FmPmv2Iyn5EaUlIMjSv4Avpx5El/+kgSMRIXI84=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IHtgm9C+DfHZfChT6F9ja4psvnPc5kY4PUOmhZtFq/pqfev0PIPi4aLd8UPuarb3D
         55YLiSyoNHmb7jblqwadKrX6gwR/O0oyFWUKHS6v9lSKaLCxJnYoIH3/rN3uFd11yi
         V950i6RaQQbNO3PlYC1ILXRTmDKxSHYsZNIm3fIUzTbnCdotsaFkKOzrSKovoBso3k
         nllR8VRr+5iMbRQwjeO8S/TOW4ER2/LPQ0V2l5JOhtgH6qttrK8FM/clpCCielaFLa
         p5Ti/Ew4D3YY9Pb47wOwCgiDSDvGTrM6rqFrndS6d4mUe5rg9mAd9PLT6LPOg1kZhy
         qwIN5bJksu5jQ==
Subject: Re: RFC: error codes on exit
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
 <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com>
Date:   Fri, 21 May 2021 16:20:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/21/21 9:53 AM, Alex Henrie wrote:
> On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> It's good to not include many initial codes, but I would start with at
>> least three:
>>
>>    OK = 0,
>>    UNKNOWN = 1,
>>    NORMAL = 2,
> 
> If you go that route, could you please pick a word other than "normal"
> to describe errors that are not entirely unexpected? I'm worried that
> someone will see "normal" and use it instead of "OK" to indicate
> success.
> 

<sysexits.h>

	-hpa

