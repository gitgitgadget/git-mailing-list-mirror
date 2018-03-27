Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19ABA1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 18:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbeC0SFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 14:05:39 -0400
Received: from avasout04.plus.net ([212.159.14.19]:46775 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeC0SFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 14:05:37 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 0syTfsGlMsD7b0syVfEJpu; Tue, 27 Mar 2018 19:05:35 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=FFy51TlrWJey8IgzQAUA:9
 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
 <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
 <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c9c2ebba-9cde-9eed-bd08-34ce8b543787@ramsayjones.plus.com>
Date:   Tue, 27 Mar 2018 19:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGmo97QTavW+sHuL2MpTDN7hYFqBtvIozTtgxzONP9ZEURY3/gAuyTYPJxJWz4jtf93fmV5Z5SSSVzLocUYIuszlg5t9rZpXa0sczGxm0AUpseZrc5bZ
 TGAgckabP8t40KpAPEPS1GvTXOP9p/GgoyEC6CZMoJuPHjZgV0GbFUb/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/03/18 18:14, Jeff Hostetler wrote:
> 
> 
> On 3/27/2018 11:45 AM, Ramsay Jones wrote:
>>
>>
>> On 27/03/18 04:18, Ramsay Jones wrote:
>>> On 26/03/18 15:31, git@jeffhostetler.com wrote:
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>
>>> [snip]
>>>
>>> Thanks, this version fixes all issues I had (with the compilation
>>> and sparse warnings).
>>>
>>> [Was using UINT64_C(0xffffffffffffffff) a problem on windows?]
>>
>> BTW, I forgot to mention that you had some whitespace problems
>> with this patch, viz:
> 
> I ran "make sparse" on this and it did not complain about any of this.

No, sparse doesn't check for whitespace issues.

> What command do you run to get these messages?

'git am' told me when I applied the patch from the ML, and ...

> I know they appear as red in diffs (and I usually double check that),
> but I had not seen a command to complain about them like this.

... since I applied the patch yesterday, it was easier to
demonstrate the issue today using this command:

>>    $ git log --oneline -1 --check master-json
>>    ab643d838 (master-json) json_writer: new routines to create data in JSON format
>>    t/helper/test-json-writer.c:280: trailing whitespace.
>>    + */
>>    t/t0019-json-writer.sh:179: indent with spaces.
>>    +        "g": 0,
>>    t/t0019-json-writer.sh:180: indent with spaces.
>>    +        "h": 1
>>    $
> 
> the leading spaces are required in this case.
> the pretty json output contains 8 spaces for that sub-structure not a tab.
> is there a preferred way to denote this in the test script?

OK, I should have looked at the output more closely! :(

Only the trailing whitespace in test-json-writer.c needs
to be addressed then.

ATB,
Ramsay Jones



