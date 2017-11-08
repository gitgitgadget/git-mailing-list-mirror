Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5041F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 22:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbdKHWLi (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 17:11:38 -0500
Received: from siwi.pair.com ([209.68.5.199]:47961 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdKHWLi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 17:11:38 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 971268457C;
        Wed,  8 Nov 2017 17:11:37 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 32E2384570;
        Wed,  8 Nov 2017 17:11:37 -0500 (EST)
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
 <20171102202052.58762-2-git@jeffhostetler.com>
 <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
 <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
 <20171103113919.396807c82dbfdecff7f19c41@google.com>
 <99b7c61b-f8ab-43a0-0707-62ac1db4d080@jeffhostetler.com>
 <20171106111642.696a006e802cf0259098b44f@google.com>
 <515130bd-6fd8-2c53-e935-e811330f8512@jeffhostetler.com>
 <20171108135116.f96c58500caa302583bb2810@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <37378ccd-c369-3bb2-7a88-fd7f632ac01d@jeffhostetler.com>
Date:   Wed, 8 Nov 2017 17:11:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171108135116.f96c58500caa302583bb2810@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/2017 4:51 PM, Jonathan Tan wrote:
> On Wed, 8 Nov 2017 15:32:21 -0500
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> Thanks Jonathan.
>>
>> I moved my version of part 2 on top of yesterday's part 1.
>> There are a few changes between my version and yours. Could
>> you take a quick look at them and see if they make sense?
>> (I'll spare the mailing list another patch series until after
>> I attend to the feed back on part 1.)
>>
>> https://github.com/jeffhostetler/git/commits/core/pc3_p2
> 
> Thanks - the differences are quite minor, and they generally make sense.
> The main one is that finish_object() in builtin/rev-list.c now returns
> int instead of void, but that makes sense.
> 
> Other than that:
> 
>   - I think you accidentally squashed the rev-list commit into
>     "sha1_file: support lazily fetching missing objects".
>   - The documentation for --exclude-promisor-objects in
>     git-pack-objects.txt should be "Omit objects that are known to be in
>     the promisor remote". (This option has the purpose of operating only
>     on locally created objects, so that when we repack, we still maintain
>     a distinction between locally created objects [without .promisor] and
>     objects from the promisor remote [with .promisor].)
>   - The transport options in gitremote-helpers.txt could have the same
>     documentation as in transport.h.
> 

thanks for the quick turn around.  i'll get these into my next
version next week.

Jeff
