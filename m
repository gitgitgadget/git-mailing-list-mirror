Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6041F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF0N5S (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:57:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:18959 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0N5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:57:18 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E65153F401C;
        Thu, 27 Jun 2019 09:57:16 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c5bd:5c5b:177e:8a3e] (unknown [IPv6:2001:4898:a800:1010:76f3:5c5b:177e:8a3e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 966C33F4012;
        Thu, 27 Jun 2019 09:57:16 -0400 (EDT)
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
To:     Jakub Narebski <jnareb@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <cover.1560295286.git.steadmon@google.com>
 <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
 <87v9xb7x0q.fsf@evledraar.gmail.com> <20190612162341.GA42943@google.com>
 <86y31vxihj.fsf@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2add419b-80e9-2b21-b4ae-eeb7a1f25776@jeffhostetler.com>
Date:   Thu, 27 Jun 2019 09:57:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <86y31vxihj.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/21/2019 7:53 AM, Jakub Narebski wrote:
> Josh Steadmon <steadmon@google.com> writes:
>> On 2019.06.12 15:28, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Jun 12 2019, Josh Steadmon wrote:
>>>
>>>> trace_schema_validator can be used to verify that trace2 event output
>>>> conforms to the expectations set by the API documentation and codified
>>>> in event_schema.json (or strict_schema.json). This allows us to build a
>>>> regression test to verify that trace2 output does not change
>>>> unexpectedly.
>>>
>>> Does this actually work for you? As seen in my code at
>>> https://public-inbox.org/git/87zhnuwdkp.fsf@evledraar.gmail.com/ our
>>> test suite emits various lines of JSON that aren't even validly encoded,
>>> so I can't imagine we're passing any sort of proper parser validatior,
>>> let alone a schema validator.
> [...]
>> The problem with the existing validators is that they expect each file to be a
>> complete JSON entity, whereas the trace output is one object per line. You can
>> of course loop over the lines in a shell script, but in my testing this approach
>> took multiple hours on the full test suite trace output, vs. 15 minutes for the
>> implementation in this patch.
> 
> Isn't this JSON-Lines (http://jsonlines.org/), also known as
> Line-delimited JSON (LDJSON), newline-delimited JSON (NDJSON) format?

Yes. My Trace2 event format is a series of JSON objects, one per line.
I didn't know there was an official name for it.

Thanks
Jeff


> 
> Best,
> --
> Jakub Narębski
> 
