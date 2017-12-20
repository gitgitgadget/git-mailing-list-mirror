Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971691F428
	for <e@80x24.org>; Wed, 20 Dec 2017 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756588AbdLTToY (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:44:24 -0500
Received: from siwi.pair.com ([209.68.5.199]:15355 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756545AbdLTToO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:44:14 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6601084532;
        Wed, 20 Dec 2017 14:44:13 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 31E7F8452A;
        Wed, 20 Dec 2017 14:44:13 -0500 (EST)
Subject: Re: [PATCH 1/4] status: add --no-ahead-behind to porcelain V2
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-2-git@jeffhostetler.com>
 <20171220163358.GE31149@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7e2a4626-5b59-d70b-a172-4a190216b2cc@jeffhostetler.com>
Date:   Wed, 20 Dec 2017 14:44:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171220163358.GE31149@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/20/2017 11:33 AM, Jeff King wrote:
> On Wed, Dec 20, 2017 at 02:42:42PM +0000, Jeff Hostetler wrote:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 9593bfa..9ccdf2b 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -3082,6 +3082,11 @@ status.submoduleSummary::
>>   	submodule summary' command, which shows a similar output but does
>>   	not honor these settings.
>>   
>> +status.noaheadbehind::
>> +	Do not compute ahead/behind counts for a branch relative to its
>> +	upstream branch.  This can be used to avoid a possibly very
>> +	expensive computation on extremely large repositories.
> 
> I got tripped up by double-negatives here while testing something out
> with your series. Could this be "status.aheadbehind", and default to
> true?
> 
> -Peff
> 

Yeah, we debated internally how to name it and that was the least bad.
I'll change it to the positive and (based on later comments) move it
to "core." so that we can pick up "branch -vv" in this round.

Thanks
Jeff
