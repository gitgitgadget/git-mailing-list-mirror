Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F15C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 15:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiGGPRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGGPRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 11:17:20 -0400
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EFB2CDD4
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 08:17:18 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9TFcooxaoAcBn9TFdohj4m; Thu, 07 Jul 2022 16:17:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657207036; bh=02PvycGvuYE4CY+97RcesBQgDiHRwv7L+/KLISt1/Jw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MRQ6Ea1zi4w1hNza74Q1f+0NGApu471YQpFJKII1AZxTzYRfOReGaS3VRen5Erg2Y
         hy9oeQKdCO7Ap+xJ8rRDVTi0TPBtm9gZH7mhjq+fDPkii3xDvUWgYeF7vokeZAcAc4
         C3Dcf4HTgHz64NBZe6Jc3C7yQnsLraE3PTcmpeRK1wrfwAiufr1pS8ELyGvTD7mCJm
         9fbAnuqKoA9OMfhNG66U8xQ4ap8iYX6HPGinzv4qXsY0dt0CME4hfn4aO3oheLpcq3
         QXzxxRbYUCZgCH2BGzbCwKweduR/9CCTVRJGtXLU09ik0SbOb5nkX8dELyUv99xoQY
         NTuqloGHvK69w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62c6f8fc
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=oa0oqEqVVccOiMJfNoEA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 16:17:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: t0301-credential-cache test failure on cygwin
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqtu7t30uv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPV+YE7LUx/7mNvftn8lZ4gF5cQQeERiSCvcKyAE0MiuPCecsI3g3fMplfgLn2EUM+zcpG6E7sdVOx1JIy2L7lVKvhcvZBj34URTcfSfrgvIsZBrOyjl
 AhAMmN828/eW9odVstCCY3m27obd8srgMaVi1SRmOFd/VEx3LdKfyPPH/yx40xof2zjmhADfYebmKmu6C/1KlRKo86SFuCcDXnc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[
Jeff: sorry for not CC:-ing you on the original email - I had intended
to do just that, but forgot! :(

See: https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/
]

On 07/07/2022 07:15, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> However, I had some time to kill tonight, so I decided to take a _quick_ look
>> to see if there was something that could be done ... (famous last words).
>> ...
>>   diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
>>   index 78c02ad531..84fd513c62 100644
>>   --- a/builtin/credential-cache.c
>>   +++ b/builtin/credential-cache.c
>>   @@ -27,7 +27,7 @@ static int connection_fatally_broken(int error)
>>    
>>    static int connection_closed(int error)
>>    {
>>   -	return (error == ECONNRESET);
>>   +	return (error == ECONNRESET) || (error == ECONNABORTED);
>>    }
> 
> This feels like papering over the problem.

Agreed, ... which is what I really meant by "(Well, it side-steps the
problem, really)."

>> Having noticed that the 'timeout' test was not failing, I decided to try
>> making the 'action=exit' code-path behave more like the timeout code, as
>> far as exiting the server is concerned. Indeed, you might ask why the
>> timeout code doesn't just 'exit(0)' as well ...
>>
>> Anyway, the following patch does that, and it also provides a 'fix' for this
>> issue!
> 
> If this codepath was written like this (i.e. [PATCH 1C]) from the
> beginning, I would have found it very sensible (i.e. instead of
> caling exit() in the middle of the infinite client serving loop,
> exiting the loop cleanly is easier to follow and maintain), even if
> we didn't know the issue on Cygwin you investigated.

Yep, apart from the variable name, I quite like the approach taken by
the 1C patch.

All three of these patches were really just "showing my working" and
allowing anyone to "follow along" without the hassle of trying to
scrape the diffs from the email.

As I said, I don't think we can determine a suitable fix without first
finding the cygwin commit which caused this test failure. But if we
can't determine this, for whatever reason, then I would favour a patch
to git based on the 1C patch. (Writing the commit message to justify the
change, without mentioning this cygwin issue, may be more challenging! :)

Also, I would like to understand why the code is written as it is
currently. I'm sure there must be a good reason - I just don't know
what it is! I suspect (ie I'm guessing), it has something to do with
operating in a high contention context [TOCTOU on socket?] ... dunno. ;-)

ATB,
Ramsay Jones


