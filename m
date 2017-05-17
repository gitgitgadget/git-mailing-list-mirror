Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75F0201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbdEQOLU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:11:20 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64243 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753103AbdEQOLT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 10:11:19 -0400
X-AuditID: 1207440c-9d9ff70000001412-ee-591c5a069d8c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.13.05138.60A5C195; Wed, 17 May 2017 10:11:18 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HEBFeu007035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 10:11:16 -0400
Subject: Re: [PATCH 04/23] prefix_ref_iterator: don't trim too much
To:     Jeff King <peff@peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
 <20170517125510.qmy2qvyxuup25zw6@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <7cec0285-fe6b-0e7e-83b4-b93c9770b55b@alum.mit.edu>
Date:   Wed, 17 May 2017 16:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170517125510.qmy2qvyxuup25zw6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1GWLkok0WDNZwWLtsztMFl1Xupks
        GnqvMFssefia2aJ7yltGix8tPcwWmze3sziwe+ycdZfdY8GmUo+u9iNsHs969zB6XLyk7PF5
        k1wAWxSXTUpqTmZZapG+XQJXxp6fU9kLHglVXGnfw9TA+Jyvi5GTQ0LARGLz/GbWLkYuDiGB
        HUwSKy/9YINwzjFJbN/1iKWLkYNDWMBZYvJyM5AGEQFZie+HNzJC1BxilFizcCMLSIJZYBOT
        xNaz9iA2m4CuxKKeZiYQm1fAXuL3wn5GEJtFQFViWe89sHpRgQiJh5272CFqBCVOznwCFucU
        cJF48+k+K8RMdYk/8y4xQ9jyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5ya
        rFucnJiXl1qka6iXm1mil5pSuokREuY8Oxi/rZM5xCjAwajEwxsRIBMpxJpYVlyZe4hRkoNJ
        SZR3/wPpSCG+pPyUyozE4oz4otKc1GKg1zmYlUR4xSKAynlTEiurUovyYVLSHCxK4ryqS9T9
        hATSE0tSs1NTC1KLYLIyHBxKErxnQRoFi1LTUyvSMnNKENJMHJwgw3mAhsuBDS8uSMwtzkyH
        yJ9iVJQS530SDpQQAElklObB9cLS0CtGcaBXhHk1IoGqeIApDK77FdBgJqDBzSAf8RaXJCKk
        pBoYtVI1AiM0WTxehX1wEItxyl+ZV3pHdB1T+VG+s2mJbJEWGb+OH1tX/1HZ3/yi5vIan+te
        ZUErf6kl8u63DOcV9dwcrbhgycyvy3qE+n8+PvV+xRRlzxsJFyT7pvJyzRbWbFZSbLs0M29j
        PUveO1lHbVHb/7Ib/860qV/+a4bRW8/vD935jwgosRRnJBpqMRcVJwIAxkJ0eR4DAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17/2017 02:55 PM, Jeff King wrote:
> On Wed, May 17, 2017 at 02:05:27PM +0200, Michael Haggerty wrote:
> 
>> diff --git a/refs/iterator.c b/refs/iterator.c
>> index bce1f192f7..f33d1b3a39 100644
>> --- a/refs/iterator.c
>> +++ b/refs/iterator.c
>> @@ -292,7 +292,19 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
>>  		if (!starts_with(iter->iter0->refname, iter->prefix))
>>  			continue;
>>  
>> -		iter->base.refname = iter->iter0->refname + iter->trim;
>> +		if (iter->trim) {
>> +			/*
>> +			 * If there wouldn't be at least one character
>> +			 * left in the refname after trimming, skip
>> +			 * over it:
>> +			 */
>> +			if (memchr(iter->iter0->refname, '\0', iter->trim + 1))
>> +				continue;
> 
> It took me a minute to figure out the logic here. You're looking for the
> end-of-string within the trim boundary, which would be an indication
> that the string itself is smaller than the boundary.
> 
> But what if it returns true, and the string really is shorter than the
> trim size? That would mean we pass a size to memchr that is longer than
> the buffer we pass. Is that legal?
> 
> I suspect it's undefined behavior according to the standard, though I'd
> guess in practice it would be fine. But if I'm understanding it
> correctly, this is the same check as:
> 
>   if (strlen(iter->iter0->refname) <= iter->trim)
> 
> which seems a lot more obvious to me and doesn't fall afoul of weird
> standard issues. The only downside I see is that it would read to the
> end of string when yours could stop at iter->trim bytes. I have no idea
> if that would be measurable (it might even be faster because strlen()
> only has one condition to loop on).

You are correct that I chose `memchr()` over `strlen()` to avoid
scanning a POTENTIALLY EXTREMELY LARGE NUMBER OF CHARACTERS past the
trim length, but of course in real life refnames aren't that long and
`strlen()` might actually be faster.

I *think* `memchr()` is technically OK:

> Implementations shall behave as if they read the memory byte by byte
from the beginning of the bytes pointed to by s and stop at the first
occurrence of c (if it is found in the initial n bytes).

But I agree that the `strlen()` version is also easier to read (I
actually had that version first). So I'll change it as you have suggested.

Thanks,
Michael

