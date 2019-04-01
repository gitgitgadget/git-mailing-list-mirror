Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701D220248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDAVGr (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:06:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:31431 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDAVGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:06:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 00BEA3F40C9;
        Mon,  1 Apr 2019 17:06:46 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:74a2:1cda:f42b:77ce] (unknown [IPv6:2001:4898:8010:0:5dd8:1cda:f42b:77ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 799F13F40C7;
        Mon,  1 Apr 2019 17:06:45 -0400 (EDT)
Subject: Re: [PATCH v2 4/7] trace2: use system config for default trace2
 settings
To:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
 <20190401210034.GD60888@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c06fcab0-2aa7-e042-db0f-e2d6c9242212@jeffhostetler.com>
Date:   Mon, 1 Apr 2019 17:06:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401210034.GD60888@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/1/2019 5:00 PM, Josh Steadmon wrote:
> On 2019.03.29 10:04, Jeff Hostetler via GitGitGadget wrote:
> [...]
>> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
>> index baaa1153bb..13ca595c69 100644
>> --- a/Documentation/technical/api-trace2.txt
>> +++ b/Documentation/technical/api-trace2.txt
>> @@ -117,6 +117,37 @@ values are recognized.
>>   Socket type can be either `stream` or `dgram`.  If the socket type is
>>   omitted, Git will try both.
>>   
>> +== Trace2 Settings in System Config
>> +
>> +Trace2 also reads configuration information from the system config.
>> +This is intended to help adminstrators to gather system-wide Git
>> +performance data.
>> +
>> +Trace2 only reads the system configuration, it does not read global,
>> +local, worktree, or `-c` config settings.
>> +
>> +Trace2 will try to load the following system configuration settings
>> +and then read the corresponding environment variables at startup.
>> +
>> +....
>> +---------------------------------------------------
>> +trace2.normalTarget          GIT_TR2
>> +trace2.normalBrief           GIT_TR2_BRIEF
>> +
>> +trace2.perfTarget            GIT_TR2_PERF
>> +trace2.perfBrief             GIT_TR2_PERF_BRIEF
>> +
>> +trace2.eventTarget           GIT_TR2_EVENT
>> +trace2.eventBrief            GIT_TR2_EVENT_BRIEF
>> +trace2.eventNesting          GIT_TR2_EVENT_NESTING
>> +
>> +trace2.configParams          GIT_TR2_CONFIG_PARAMS
>> +
>> +trace2.destinationDebug      GIT_TR2_DST_DEBUG
>> +---------------------------------------------------
>> +....
>> +
>> +
> 
> A question for the list: should these new config vars also be documented
> in the git-config manpage, or is it better to keep these separate since
> they are only read from the system config?
> 

I wasn't sure either, so I just kept them in the trace2 api doc for now.
Jeff
