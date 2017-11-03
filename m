Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F273320450
	for <e@80x24.org>; Fri,  3 Nov 2017 13:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbdKCNhs (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 09:37:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:48641 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932201AbdKCNhs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 09:37:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6804B84559;
        Fri,  3 Nov 2017 09:37:45 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1B6BA84515;
        Fri,  3 Nov 2017 09:37:44 -0400 (EDT)
Subject: Re: [PATCH v2 4/6] list-objects: filter objects in
 traverse_commit_list
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
 <20171102175013.3371-5-git@jeffhostetler.com>
 <20171102123245.0f768968703ec4e35d3d1f81@google.com>
 <alpine.DEB.2.21.1.1711031254280.6482@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0dd48f07-6174-1a4e-c1f0-bae5b18cebd1@jeffhostetler.com>
Date:   Fri, 3 Nov 2017 09:37:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711031254280.6482@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/2017 7:54 AM, Johannes Schindelin wrote:
> Hi Jonathan,
> 
> On Thu, 2 Nov 2017, Jonathan Tan wrote:
> 
>> On Thu,  2 Nov 2017 17:50:11 +0000
>> Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>> +int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
>>> +			      const char *arg)
>>
>> Returning void is fine, I think. It seems that all your code paths
>> either return 0 or die.
> 
> Can we please start to encourage libified code, rather than discourage it?


I did that so that I could call it from the opt_parse_... version below
it that is used by the OPT_ macros.

And Johannes is right, it bothers me that there doesn't seem to be a hard
line where one should or should not call die() vs returning an error code.

Jeff

