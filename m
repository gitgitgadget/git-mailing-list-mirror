Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD952047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdI0R0U (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:26:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:59880 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdI0R0S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:26:18 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9950184617;
        Wed, 27 Sep 2017 13:26:17 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 49938844D7;
        Wed, 27 Sep 2017 13:26:17 -0400 (EDT)
Subject: Re: [PATCH 09/13] rev-list: add object filtering support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
 <20170922203017.53986-10-git@jeffhostetler.com>
 <20170926154457.51f4da732122f00381d646e1@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0373bf21-af3c-0ab6-9fba-8559ba05ebb7@jeffhostetler.com>
Date:   Wed, 27 Sep 2017 13:26:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170926154457.51f4da732122f00381d646e1@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/26/2017 6:44 PM, Jonathan Tan wrote:
> On Fri, 22 Sep 2017 20:30:13 +0000
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> +		if (filter_options.relax) {
> 
> Add some documentation about how this differs from ignore_missing_links
> in struct rev_info.
> 

It's unclear what that field means.  (It's not documented that I saw.)
And it is explicitly turned on and off in pack-bitmap.c, so again I'm
not sure how that agrees with what I'm doing.

My relax field is probably an interim thing (to allow rev-list, index-pack,
and friends not complain about missing objects during my development).

I suspect that you and I will need to merge our efforts here.  You have
a similar variable "revs->exclude_promisor_objects".  But I need to study
how our usages differ.

Thanks,
Jeff
