Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7B820281
	for <e@80x24.org>; Tue,  3 Oct 2017 01:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbdJCBIT (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 21:08:19 -0400
Received: from avasout07.plus.net ([84.93.230.235]:59952 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdJCBIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 21:08:16 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Gp8D1w0070M91Ur01p8FEg; Tue, 03 Oct 2017 02:08:15 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=VVlED5B4AAAA:8 a=ybZZDoGAAAAA:8 a=b1iREBDN41TqYnP0x0kA:9
 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3] clang-format: add a comment about the meaning/status
 of the
To:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
 <20171001154425.5568-1-s-beyer@gmx.net>
 <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
 <20171002172135.GB5189@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <57ab6f76-e150-26ab-3671-b14e0247a553@ramsayjones.plus.com>
Date:   Tue, 3 Oct 2017 02:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171002172135.GB5189@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/10/17 18:21, Brandon Williams wrote:
> On 10/02, Junio C Hamano wrote:
>> From: Stephan Beyer <s-beyer@gmx.net>
>>
>> Having a .clang-format file in a project can be understood in a way that
>> code has to be in the style defined by the .clang-format file, i.e., you
>> just have to run clang-format over all code and you are set.
>>
>> This unfortunately is not yet the case in the Git project, as the
>> format file is still work in progress.  Explain it with a comment in
>> the beginning of the file.
>>
>> Additionally, the working clang-format version is mentioned because the
>> config directives change from time to time (in a compatibility-breaking way).
>>
>> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * So here is a counter-proposal in a patch form.  I agree that my
>>    earlier suggestion was unnecessarily verbose; this one spends
>>    just as many lines and not more than the v2 round of Stephan's
>>    patch.
>>
>>  .clang-format | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/.clang-format b/.clang-format
>> index 56822c116b..7670eec8df 100644
>> --- a/.clang-format
>> +++ b/.clang-format
>> @@ -1,4 +1,8 @@
>> -# Defaults
>> +# This file is an example configuration for clang-format 5.0.
>> +#
>> +# Note that this style definition should only be understood as a hint
>> +# for writing new code. The rules are still work-in-progress and does
>> +# not yet exactly match the style we have in the existing code.
> 
> Thanks for writing up this header comment to the .clang-format file,
> it's something I definitely should have included when I introduced it.
> 
> And I like the wording that you've both settled on, as it reflects our
> intentions (of having the code eventually conform to the format rules)
> and making note that this set of rules still needs to be tuned.

Just for the record, I have 'clang-format version 3.8.0-2ubuntu4
 (tags/RELEASE_380/final)' on Linux Mint 18.2, which requires me
to comment out:

    AlignEscapedNewlines: Left
    BreakStringLiterals: false
    PenaltyBreakAssignment: 100

And on cygwin, I have 'clang-format version 4.0.1
 (tags/RELEASE_401/final)', which requires me to
comment out:

    AlignEscapedNewlines: Left
    PenaltyBreakAssignment: 100

So, I don't think I can play along! :(

[When playing with 3.8 on Linux, I noted that clang-format
seemed to ignore *all* settings in .clang-format, if it found
*any* config that it didn't know about! Not very friendly. :-P ]

ATB,
Ramsay Jones

