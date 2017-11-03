Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89B5B2055E
	for <e@80x24.org>; Fri,  3 Nov 2017 13:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756309AbdKCNnY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 09:43:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:21053 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752321AbdKCNnX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 09:43:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C36938457B;
        Fri,  3 Nov 2017 09:43:22 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 18B6D84575;
        Fri,  3 Nov 2017 09:43:22 -0400 (EDT)
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102124445.fbffd43521cd35f6a71e1851@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bd41699f-19c7-02a0-0af1-8f22b3277a1b@jeffhostetler.com>
Date:   Fri, 3 Nov 2017 09:43:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102124445.fbffd43521cd35f6a71e1851@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/2/2017 3:44 PM, Jonathan Tan wrote:
> On Thu,  2 Nov 2017 17:50:07 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Here is V2 of the list-object filtering. It replaces [1]
>> and reflect a refactoring and simplification of the original.
> 
> Thanks, overall this looks quite good. I reviewed patches 2-6 (skipping
> 1 since it's already in next), made my comments on 4, and don't have any
> for the rest (besides what's below).
> 
>> I've added "--filter-ignore-missing" parameter to rev-list and
>> pack-objects to ignore missing objects rather than error out.
>> This allows this patch series to better stand on its own eliminates
>> the need in part 1 for "patch 9" from V1.
>>
>> This is a brute force ignore all missing objects.  Later, in part
>> 2 or part 3 when --exclude-promisor-objects is introduced, we will
>> be able to ignore EXPECTED missing objects.
> 
> (This is regarding patches 5 and 6.) Is the intention to support both
> flags? (That is, --ignore-missing to ignore without checking whether the
> object being missing is not unexpected, and --exclude-promisor-objects
> to check and ignore.)
> 

Yes, I thought we should have both (perhaps renamed or combined
into 1 parameter with value, such as --exclude=missing vs --exclude=promisor)
and let the user decide how strict they want to be.

Jeff

