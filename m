Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B9C001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHGSZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHGSZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:25:13 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2C1726
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:25:12 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0246BCA1247;
        Mon,  7 Aug 2023 14:25:11 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:8ddb:2d4a:b436:909c] (unknown [IPv6:2600:1700:840:e768:8ddb:2d4a:b436:909c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7F580CC839C;
        Mon,  7 Aug 2023 14:25:10 -0400 (EDT)
Message-ID: <2a490e5a-2e14-206b-f4ca-73e73e84cf74@jeffhostetler.com>
Date:   Mon, 7 Aug 2023 14:25:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] wrapper: use trace2 counters to collect fsync
 stats
Content-Language: en-US
To:     Beat Bolli <dev+git@drbeat.li>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
References: <20230720164823.625815-1-dev+git@drbeat.li>
 <xmqq5y6e2xl7.fsf@gitster.g> <xmqqo7jzlrdq.fsf@gitster.g>
 <2f39e481-84d1-097c-ec47-5357dbc36798@drbeat.li>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <2f39e481-84d1-097c-ec47-5357dbc36798@drbeat.li>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/25/23 7:03 PM, Beat Bolli wrote:
> On 25.07.23 21:31, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I also spotted this change since v1:
>>>
>>> - Rename trace2 counters to use "-" (not "_") as inter-word separators.
>>>
>>> Since I do not seem to be able to find any review comments regarding
>>> the variable naming in the v1's thread, let's ask stakeholders.
>>>
>>> Are folks involved in the trace2 subsystem (especially Jeff
>>> Hostetler---already CC:ed---who presumably has the most stake in it)
>>> OK with the naming convention of the multi-word variable?  This is
>>> the first use of multi-word variable name in tr2_ctr, and thus will
>>> establish whatever convention you guys want to use.  I do have a
>>> slight preference of "writeout-only" over "writeout_only" but that
>>> is purely from visual appearance.  If there is a desire to keep the
>>> names literally reusable as identifiers in some languages used to
>>> postprocess trace output, or something, that might weigh
>>> differently.
>>
>> I heard absolutely nothing since I asked the above question last
>> week, so I'll take the absense of response as absense of interest in
>> the way how names are spelled.
>>
>> Therefore, let me make a unilateral declaration here ;-)  The trace2
>> counters with multi-word names are to be named using "-" as their
>> inter-word separators.  Any patch that adds new counters that do not
>> follow the convention will silently dropped on the floor from now on.
>>
>> Let's move this patch forward by merging to 'next' soonish.
> 
> Works for me :-)
> 
> Cheers!
> 

Agreed.

Thanks
Jeff
