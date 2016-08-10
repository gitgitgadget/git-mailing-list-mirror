Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2041FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 23:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbcHJX0V (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 19:26:21 -0400
Received: from siwi.pair.com ([209.68.5.199]:30459 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224AbcHJXZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 19:25:56 -0400
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id B6EA684598;
	Wed, 10 Aug 2016 19:25:54 -0400 (EDT)
Subject: Re: [PATCH v5 9/9] status: unit tests for --porcelain=v2
To:	Junio C Hamano <gitster@pobox.com>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
 <1470434434-64283-10-git-send-email-git@jeffhostetler.com>
 <xmqq4m6vgpf9.fsf@gitster.mtv.corp.google.com>
 <57AB9C61.5060409@jeffhostetler.com>
 <xmqqvaz82qn6.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:	Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <57ABB788.5020305@jeffhostetler.com>
Date:	Wed, 10 Aug 2016 19:23:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaz82qn6.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 08/10/2016 06:41 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
>>> Having said all that, it is OK to fix their titles after the current
>>> 9-patch series lands on 'next'; incremental refinements are easier
>>> on reviewers than having to review too many rerolls.
>>
>> I'll change the test titles to have all that info.
>
> OK.  As I said, if the retitling is the only change, then doing so
> as a follow-up to the existing 9-patch series would be easier to
> review.  If there are other changes needed, a reroll of the full set
> is probably better.

I've changed the titles and added 5 or 6 more tests to
cover your previous questions/comments, but no code changes.


>>> This is a small point, but doesn't the lowercase 'u' somehow look
>>> ugly, especially because the status letters that immediately follow
>>> it are all uppercase?
>>>
>>
>> Since we are inventing a new format and my column 1 is completely new
>> I didn't think it mattered.
>
> Wrong assumption ;-)  We want the resulting code to be consistent.
>
>> And I used a lowercase 'u' to distinguish
>> it from the "U" in the X and Y columns since they mean different
>> things.
>
> I thought they both mean "Unmerged"; that is why I thought seeing a
> lowercase there was very strange.

For unmerged items, the X & Y columns in the original porcelain
format, can have various combinations of "A", "D", and "U" values.
The implication being that "U" means modified/edited in some way.
Yes, it is labeled "unmerged", but in a "DU" or "UD" conflict, it
means that one side deleted it and one side modified it in some way.
A "UU" conflict means both sides edited it and auto-merge failed.

All I wanted the lowercase 'u' to indicate was that the file was
in an unmerged state (without specifying why).  That is, we would
have (the 7 valid combinations of) "u [ADU][ADU]" and it would be
clear(er?) that the little 'u' was different from the other 2.

I know it is a subtle point and we can change it if you want, but
that was the rationale.


Thanks,
Jeff

