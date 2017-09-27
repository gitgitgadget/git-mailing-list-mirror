Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0BF2047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdI0RJo (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:09:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:46737 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbdI0RJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:09:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F40588460E;
        Wed, 27 Sep 2017 13:09:42 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A89708460D;
        Wed, 27 Sep 2017 13:09:42 -0400 (EDT)
Subject: Re: [PATCH 07/13] object-filter: common declarations for object
 filtering
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
 <20170922203017.53986-8-git@jeffhostetler.com>
 <20170926153950.a147c48ce62f73702eff7ebb@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7774ff8d-3a53-860d-9343-292938d59d12@jeffhostetler.com>
Date:   Wed, 27 Sep 2017 13:09:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170926153950.a147c48ce62f73702eff7ebb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2017 6:39 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 20:30:11 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>>   Makefile        |   1 +
>>   object-filter.c | 269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   object-filter.h | 173 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 443 insertions(+)
>>   create mode 100644 object-filter.c
>>   create mode 100644 object-filter.h
> 
> I think these and list-objects-filter-* are multiple levels of
> indirection too many. Would a single file with a few implementations of
> filter_object_fn be sufficient?

I did that in my first draft and I found it confusing.

Each filter has 3 parts (some filter-specific data structures,
a filter callback routine, a driver to call the traverse code).
I found it easier to reason about each filter in isolation.
And it makes it easier to work on each independently and keep
their inclusion in separate commits.


  
