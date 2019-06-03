Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559FE1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFCVnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:43:51 -0400
Received: from siwi.pair.com ([209.68.5.199]:49044 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCVnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:43:51 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 884A63F4019;
        Mon,  3 Jun 2019 17:04:28 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:59ab:b3d9:a0d9:493a] (unknown [IPv6:2001:4898:a800:1012:adf:b3d9:a0d9:493a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E3A3E3F401C;
        Mon,  3 Jun 2019 17:04:27 -0400 (EDT)
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <2b47d4b1-ea62-d59e-77e0-d95dfad084e0@jeffhostetler.com>
 <xmqqh89e31fg.fsf@gitster-ct.c.googlers.com>
 <20190529150228.GC4700@comcast.net>
 <9f1025ec-a3d7-c5f4-4a7a-15e4131f2b87@jeffhostetler.com>
 <20190529232746.GE4700@comcast.net>
 <0d8973e7-5b29-fb09-a435-3bf2ec23269f@jeffhostetler.com>
 <20190531205305.GD4641@comcast.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <91f8f9aa-e427-1b24-db9d-fad53e9e19c5@jeffhostetler.com>
Date:   Mon, 3 Jun 2019 17:04:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531205305.GD4641@comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/31/2019 4:53 PM, Matthew DeVore wrote:
> On Thu, May 30, 2019 at 10:01:47AM -0400, Jeff Hostetler wrote:
>> BTW, I don't think I've seen this mentioned anywhere and I don't
>> remember if this got into the code or not.  But we discussed having
>> a repo-local config setting to remember the filter-spec used by the
>> partial clone that would be inherited by a subsequent (partial) fetch.
>> Or would be set by the first partial fetch following a normal clone.
>> Having a single composite filter spec would help with this.
> 
> Isn't that what the partial_clone_get_default_filter_spec function is for? I
> forgot about that. Perhaps with Emily's suggestion to use parsing functions in
> the C library and the other cleanups I've applied since the first roll-up, using
> the URL encoding will seem nicer. Let me try that...
> 

Yes, thanks.  That's what I was thinking about.

Jeff
