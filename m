Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9539A1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeC0ROf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 13:14:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:25822 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754311AbeC0ROe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 13:14:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 660913F40B3;
        Tue, 27 Mar 2018 13:14:33 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0FCA23F401D;
        Tue, 27 Mar 2018 13:14:33 -0400 (EDT)
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
 <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
Date:   Tue, 27 Mar 2018 13:14:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/2018 11:45 AM, Ramsay Jones wrote:
> 
> 
> On 27/03/18 04:18, Ramsay Jones wrote:
>> On 26/03/18 15:31, git@jeffhostetler.com wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>> [snip]
>>
>> Thanks, this version fixes all issues I had (with the compilation
>> and sparse warnings).
>>
>> [Was using UINT64_C(0xffffffffffffffff) a problem on windows?]
> 
> BTW, I forgot to mention that you had some whitespace problems
> with this patch, viz:

I ran "make sparse" on this and it did not complain about any of this.

What command do you run to get these messages?
I know they appear as red in diffs (and I usually double check that),
but I had not seen a command to complain about them like this.

> 
>    $ git log --oneline -1 --check master-json
>    ab643d838 (master-json) json_writer: new routines to create data in JSON format
>    t/helper/test-json-writer.c:280: trailing whitespace.
>    + */
>    t/t0019-json-writer.sh:179: indent with spaces.
>    +        "g": 0,
>    t/t0019-json-writer.sh:180: indent with spaces.
>    +        "h": 1
>    $

the leading spaces are required in this case.
the pretty json output contains 8 spaces for that sub-structure not a tab.
is there a preferred way to denote this in the test script?

Jeff


