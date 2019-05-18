Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E0E1F461
	for <e@80x24.org>; Sat, 18 May 2019 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfERGm4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 02:42:56 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37961 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfERGm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 02:42:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 455bFT67x6z5tlD;
        Sat, 18 May 2019 08:42:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 597FF20BA;
        Sat, 18 May 2019 08:42:52 +0200 (CEST)
Subject: Re: [PATCH] make slash-rules more readable
To:     "Dr. Adam Nielsen" <admin@in-ici.net>
References: <20190507104507.18735-1-admin@in-ici.net>
 <xmqqzhnxh5nm.fsf@gitster-ct.c.googlers.com>
 <094f3746-67c9-0284-0593-eb6b24d5c4a3@in-ici.net>
 <469c37d9-4491-9072-211f-d9d8614413e0@in-ici.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f80eb2e5-3285-40bd-018d-ff0c7e5e9ff5@kdbg.org>
Date:   Sat, 18 May 2019 08:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <469c37d9-4491-9072-211f-d9d8614413e0@in-ici.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.19 um 23:43 schrieb Dr. Adam Nielsen:
>> Another thing that I noticed is that its not mentioned anywhere that
>> the pattern use a slash as a directory separator (instead of a
>> backslash), its only clear from the examples. Maybe its worth to
>> mention it in the "PATTERN FORMAT" section. Also its maybe worth to
>> introduce the term "leading slash" and "trailing slash" because they
>> will be of importance of the following paragraphs. Something like this
>> after the paragraph of "!":
>>
>>      [...] for example, "\!important!.txt".
>>
>>      A slash `/` is used as a directory separator.
>>      A leading slash (that is if the pattern begins with a slash)
>>      or a trailing slash (that is if the pattern ends with a slash)
>>      have special meaning and are explained below.
>>
>>      If the pattern contains a trailing slash, it would only find
>>      a match with a directory. [...]
>>
> 
> 
> I changed my mind about this last addition. I think it is not very
> readable and there is no need to explain leading/trailing slash. Maybe
> one could just note it like this:
> 
>       [...] for example, "\!important!.txt".
> 
>       A slash `/` is used as a directory separator.
>       A leading and trailing slash have special meaning
>       and are explained in the following.
> 
>       If the pattern ends with a slash, it would only find
>       a match with a directory. [...]
> 
> then I would also add:
> 
>      If the pattern does not end with a slash, it would find a match
>      with a file or directory.
> 
> 
> Two notes about two sentences that I proposed a while ago:
> 
>> + - If the pattern contains no slash "`/`" (except an optional
> trailing slash),
>> +   the ...
> 
> I think that this sentence is not very readable. The exceptional case in
> the brackets makes it over complicated.
> 
>> + - A pattern that contains a non-trailing slash is matched
> 
> And I don't like this phrase either. I think its too easy to confuse it
> with "A pattern that contains no trailing slash".
> 
> So I would suggest to replace both with the following:
> 
>     If the pattern contains no slash or only a trailing slash, [...].
>     Otherwise (when it contains a non-trailing slash) the pattern
>     is matched [...].

With all those new "if"s, "but"s, "otherwise"s, "when"s, and "except"s,
I have a feeling that the current way to say

   If .... ends with a slash, then ... only directories... The trailing
   slash is removed for the purpose of the remaining rules.

is still the best way to go forward. I do understand that this is a
rather technical way to explain things than a colloquial one, but it
also does remove a lot of conditionals and, therefore, mental burden.

-- Hannes
