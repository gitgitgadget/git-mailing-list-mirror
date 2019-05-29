Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EC11F462
	for <e@80x24.org>; Wed, 29 May 2019 19:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfE2T6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:58:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:46078 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2T6e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:58:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A5E163F40FA;
        Wed, 29 May 2019 15:58:33 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c90f:aaf8:aafe:c1ce] (unknown [IPv6:2001:4898:a800:1010:7a45:aaf8:aafe:c1ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 50E3C3F40F0;
        Wed, 29 May 2019 15:58:33 -0400 (EDT)
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20190510211502.GS14763@szeder.dev>
 <20190519144309.9597-1-szeder.dev@gmail.com>
 <87blzmmbd7.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c93cb249-1618-e2ed-5ba3-31d716fdbe06@jeffhostetler.com>
Date:   Wed, 29 May 2019 15:58:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87blzmmbd7.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 7:02 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, May 19 2019, SZEDER Gábor wrote:
> 
>> For an environment variable that is supposed to be set by users, the
>> GIT_TR2* env vars are just too unclear, inconsistent, and ugly.
>>
>> Most of the established GIT_* environment variables don't use
>> abbreviations, and in case of the few that do (GIT_DIR,
>> GIT_COMMON_DIR, GIT_DIFF_OPTS) it's quite obvious what the
>> abbreviations (DIR and OPTS) stand for.  But what does TR stand for?
>> Track, traditional, trailer, transaction, transfer, transformation,
>> transition, translation, transplant, transport, traversal, tree,
>> trigger, truncate, trust, or ...?!
>>
>> The trace2 facility, as the '2' suffix in its name suggests, is
>> supposed to eventually supercede Git's original trace facility.  It's
>> reasonable to expect that the corresponding environment variables
>> follow suit, and after the original GIT_TRACE variables they are
>> called GIT_TRACE2; there is no such thing is 'GIT_TR'.
>>
>> All trace2-specific config variables are, very sensibly, in the
>> 'trace2' section, not in 'tr2'.
>>
>> OTOH, we don't gain anything at all by omitting the last three
>> characters of "trace" from the names of these environment variables.
>>
>> So let's rename all GIT_TR2* environment variables to GIT_TRACE2*,
>> before they make their way into a stable release.
> 
> Good to see this land in 2.22.0. I wonder if we shouldn't take this
> further and rename trace2.* config to trace.*, and just re-use
> GIT_TRACE=1 instead of having GIT_TRACE2 as well, and have a
> GIT_TRACE_VERSION to switch between them.
> 
> Then we could just switch in a future version. We've never promised what
> the trace format was going to look like, and the existing one isn't
> configurable (and we won't be making the v1 one...), so starting from
> the outset with "2" in config is unfortunate.
> 
> We'd still have special snowflakes like e.g. GIT_TRACE_PACKET.
> 
> OTOH we can just do this after the release if it's deemed a good idea,
> and just support trace2.* as aliases for trace.* for some amount of
> time, same for the env vars.
> 

I'm open to considering such a change while we're at it.

Jeff
