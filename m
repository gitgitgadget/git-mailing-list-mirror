Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32932090B
	for <e@80x24.org>; Sun, 17 Sep 2017 19:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdIQTDi (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 15:03:38 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:46614 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbdIQTDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 15:03:37 -0400
Received: from [192.168.2.240] ([92.22.15.39])
        by smtp.talktalk.net with SMTP
        id tepvdvXtqlmqOtepvdoKiz; Sun, 17 Sep 2017 20:02:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1505674955; bh=IppD1sJrLZ5usteNj3luWqQifCNizKPQYnzHq+fakS8=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=WSM/rfoayEMUXoshFd7bwVRS3Au2/EMWSXIHv+CG6aASn92y8oN+0Poyl6mFXoI1J
         fn4l8qJCWkRrgew73DnWVcTxXNyXqy2LuRNECpT/eyAidtAqTMQSGJm+Y2bDcHQwVm
         Prq2dD40eEraEwYdLDSznbExtvS+ZSRH+Ys+nt10=
X-Originating-IP: [92.22.15.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=H+Sr+6Qi c=1 sm=1 tr=0 a=3EVUng5azuUHeJ78rNzxRg==:117
 a=3EVUng5azuUHeJ78rNzxRg==:17 a=Q9fys5e9bTEA:10 a=NEAV23lmAAAA:8
 a=yDJdJGQx3wNHZ0xWxasA:9 a=PUjeQqilurYA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: update information about windows build
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <0102015e8e4f7e75-dfec22a3-bb1a-4208-a069-450275d52b6d-000000@eu-west-1.amazonses.com>
 <80afe093-aceb-9478-f0d2-d69f7f75eaab@talktalk.net>
 <1505655777.14232.3.camel@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b1add5b2-7ebe-38b9-de85-742e64cd1ee3@talktalk.net>
Date:   Sun, 17 Sep 2017 20:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1505655777.14232.3.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF687RGWlbf8QtHtjo2i4cPpksXYbTgw5NV4Nh3NQ6+C/Xsv/TOPbFO16eaiPTuMhWGEgdBDeLztz82NYDKCBkcp99T3rmSgoeXYO6g37vJAFFU4Cblj
 /dSBKPSFUCdghu/Tq71KQ4HN9nQ4u7hFMiTorG3SScdfVYufPulRQWMSpQfyUQTp0ClS508IQaI0GeSjlX1RC0tV6iEyod6S/dPvCDHBTOUOPP1rIGDyYyHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/09/17 14:42, Kaartic Sivaraam wrote:
> 
> On Sun, 2017-09-17 at 14:24 +0100, Phillip Wood wrote:
>>
>>   From that commit:
>> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
>> new file mode 100755
>> index 000000000..4e3a50b60
>> --- /dev/null
>> +++ b/ci/run-windows-build.sh
>> @@ -0,0 +1,74 @@
>> +#!/usr/bin/env bash
>> +#
>> +# Script to trigger the a Git for Windows build and test run.
>> +# Set the $GFW_CI_TOKEN as environment variable.
>> +# Pass the branch (only branches on https://github.com/git/git are
>> +# supported) and a commit hash.
>> +#
>>
>> so only git/git from github gets built on windows, not other peoples
>> trees. One cannot use travis to test ones changes on windows before
>> submitting them
>>
> 
> Thanks for pointing it out didn't notice it. I have been confused by
> the presence of the build named 'Windows' that I see even on my tree. I
>   always see a green check mark near it which tricked me into believing
> that they were running successfully. I didn't know they were being
> skipped all these days!

Yes I only noticed the other day that the windows job only ran for a 
minute so I looked at the output log and saw it checks the repo and just 
exits if it's not git/git

> May be the Windows build exit with failure on other repos rather than
> saying it passes?

I'm not quite sure what you're asking. If the tests aren't run it needs 
to look like a pass or everyone's branches would be marked as failing on 
github and more importantly it wouldn't be clear when there was a real 
failure on linux/macos. If the tests are run then it will pass/fail 
depending on the test result.

Best Wishes

Phillip
> 
> ---
> Kaartic
> 

