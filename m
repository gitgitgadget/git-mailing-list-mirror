Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A2B1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 14:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfAaOxa (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 09:53:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:39756 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731978AbfAaOxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 09:53:30 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 26FD83F4013;
        Thu, 31 Jan 2019 09:53:29 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DEAAC3F4012;
        Thu, 31 Jan 2019 09:53:28 -0500 (EST)
Subject: Re: [PATCH v3 00/14] Trace2 tracing facility
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
 <pull.108.v3.git.gitgitgadget@gmail.com> <20190131143811.GB10587@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9b603fd7-d8f0-1ce7-7c7c-8b17484d7d0a@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 09:53:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190131143811.GB10587@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 9:38 AM, SZEDER Gábor wrote:
> On Wed, Jan 30, 2019 at 11:51:04AM -0800, Jeff Hostetler via GitGitGadget wrote:
>> V3 addresses:
>> [] incorporate most of the suggestions from clang-format.
> 
>> Range-diff vs v2:
>>
>>    1:  1a90de9dab <  -:  ---------- trace2: Documentation/technical/api-trace2.txt
>>    -:  ---------- >  1:  60b56d6a8f trace2: Documentation/technical/api-trace2.txt
>>    2:  ea39b76d31 !  2:  bfe2fe0bbe trace2: create new combined trace facility
> 
>>       @@ -745,7 +734,8 @@
>>        +	int j;
>>        +	int sum = 0;
>>        +
>>       -+	for_each_builtin(j, tgt_j) {
>>       ++	for_each_builtin(j, tgt_j)
>>       ++	{
>>        +		if (tgt_j->pfn_init())
>>        +			sum++;
>>        +	}
>>       @@ -763,7 +753,8 @@
>>        +	struct tr2_tgt *tgt_j;
>>        +	int j;
>>        +
>>       -+	for_each_builtin(j, tgt_j) {
>>       ++	for_each_builtin(j, tgt_j)
>>       ++	{
>>        +		tgt_j->pfn_term();
>>        +	}
> 
> Our CodingGuidelines prefer the opening brace on the same line after
> the if/for/while/struct/etc. statement, and even omitting the braces
> if the if arm or loop body consists of a single statement.  So
> unfortunately a considerable part of this range diff goes in the wrong
> direction.

I know they do and I had them on the same line originally.

Clang-format was complaining about every use of the for_each_builtin
macro, so I changed them to be on the next line to quiet it.

I hesitate to remove braces around a statement adjacent to a
for_each macro trick for the usual safety reasons.

Jeff


