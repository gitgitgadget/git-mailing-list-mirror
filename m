Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE701EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjGYXEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGYXEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:04:04 -0400
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F80E63
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:03:59 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1qOR4O-0003bq-2B
        for git@vger.kernel.org;
        Wed, 26 Jul 2023 01:03:57 +0200
Received: from [10.20.10.231] (port=48306 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.96)
        (envelope-from <dev+git@drbeat.li>)
        id 1qOR4N-003AD2-1h;
        Wed, 26 Jul 2023 01:03:55 +0200
Message-ID: <2f39e481-84d1-097c-ec47-5357dbc36798@drbeat.li>
Date:   Wed, 26 Jul 2023 01:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] wrapper: use trace2 counters to collect fsync
 stats
Content-Language: de-CH
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Calvin Wan <calvinwan@google.com>,
        Victoria Dye <vdye@github.com>
References: <20230720164823.625815-1-dev+git@drbeat.li>
 <xmqq5y6e2xl7.fsf@gitster.g> <xmqqo7jzlrdq.fsf@gitster.g>
From:   Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqo7jzlrdq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.07.23 21:31, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I also spotted this change since v1:
>>
>> - Rename trace2 counters to use "-" (not "_") as inter-word separators.
>>
>> Since I do not seem to be able to find any review comments regarding
>> the variable naming in the v1's thread, let's ask stakeholders.
>>
>> Are folks involved in the trace2 subsystem (especially Jeff
>> Hostetler---already CC:ed---who presumably has the most stake in it)
>> OK with the naming convention of the multi-word variable?  This is
>> the first use of multi-word variable name in tr2_ctr, and thus will
>> establish whatever convention you guys want to use.  I do have a
>> slight preference of "writeout-only" over "writeout_only" but that
>> is purely from visual appearance.  If there is a desire to keep the
>> names literally reusable as identifiers in some languages used to
>> postprocess trace output, or something, that might weigh
>> differently.
> 
> I heard absolutely nothing since I asked the above question last
> week, so I'll take the absense of response as absense of interest in
> the way how names are spelled.
> 
> Therefore, let me make a unilateral declaration here ;-)  The trace2
> counters with multi-word names are to be named using "-" as their
> inter-word separators.  Any patch that adds new counters that do not
> follow the convention will silently dropped on the floor from now on.
> 
> Let's move this patch forward by merging to 'next' soonish.

Works for me :-)

Cheers!

