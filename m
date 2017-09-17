Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3209E20281
	for <e@80x24.org>; Sun, 17 Sep 2017 10:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdIQKYi (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 06:24:38 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59078 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdIQKYh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 06:24:37 -0400
X-AuditID: 12074413-38bff70000007929-d2-59be4d6426e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.94.31017.46D4EB95; Sun, 17 Sep 2017 06:24:36 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC30B.dip0.t-ipconnect.de [87.188.195.11])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8HAOYWc000888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 17 Sep 2017 06:24:35 -0400
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
Date:   Sun, 17 Sep 2017 12:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1E3x3RdpcHCHtEXXlW4mi4beK8wW
        /9vesVn0Nv5hdWDx2DnrLrvHxUvKHp83yQUwR3HZpKTmZJalFunbJXBlXLm9nangHl/F/1vb
        2RoYe7i7GDk5JARMJKa828nexcjFISSwg0ni+IdlzBDOeSaJm5vWsoNUCQsES5z/dYQFxBYR
        UJOY2HYIzGYWqJB4f7iJEcQWEuhmlHj9xxXEZhPQlVjU08wEYvMK2Eusej6LFcRmEVCVuLny
        L1i9qECERN/by+wQNYISJ2c+AZvJKWAt8fDAKXaI+eoSf+ZdYoawxSVuPZnPBGHLSzRvnc08
        gVFgFpL2WUhaZiFpmYWkZQEjyypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2M
        kOAW3sG466TcIUYBDkYlHt4NJXsjhVgTy4orcw8xSnIwKYnyWvntiRTiS8pPqcxILM6ILyrN
        SS0+xCjBwawkwsthvy9SiDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEk
        wXvSB6hRsCg1PbUiLTOnBCHNxMEJMpwHaPhkkBre4oLE3OLMdIj8KUZFKXFea5CEAEgiozQP
        rheWfF4xigO9IszLD0xFQjzAxAXX/QpoMBPQ4JYde0AGlyQipKQaGPknHbrpzTaPO9yJz27P
        47iLG72sbZq2bok9GHYgJyxuPt9cN0mGfMWT2T1FN6V63Lgtte5leS1jZDm1bu9ee9uvzl7t
        Dz2PNHRK/tfKNudLVlh2Z5JGy7POkufnpc47TuB/vDtg85nfon7/L007fNg4MSpSuqp0i7ld
        nz/rsq0LauY2qeooKrEUZyQaajEXFScCABZjVmMZAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/17/2017 02:59 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If you pass a newly-initialized or newly-cleared `string_list` to
>> `for_each_string_list_item()`, then the latter does
>>
>>     for (
>>             item = (list)->items; /* note, this is NULL */
>>             item < (list)->items + (list)->nr; /* note: NULL + 0 */
>>             ++item)
>>
>> Even though this probably works almost everywhere, it is undefined
>> behavior, and it could plausibly cause highly-optimizing compilers to
>> misbehave.
>> ...
>> It would be a pain to have to change the signature of this macro, and
>> we'd prefer not to add overhead to each iteration of the loop. So
>> instead, whenever `list->items` is NULL, initialize `item` to point at
>> a dummy `string_list_item` created for the purpose.
>> ...
>> -#define for_each_string_list_item(item,list) \
>> -	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
>> +extern struct string_list_item dummy_string_list_item;
>> +#define for_each_string_list_item(item,list)                                 \
>> +	for (item = (list)->items ? (list)->items : &dummy_string_list_item; \
>> +	     item < (list)->items + (list)->nr;                              \
>> +	     ++item)
> 
> Sorry, but I am confused.
> 
> So when (list)->items is NULL, the loop termination condition that
> used to be
> 
> 	NULL < NULL + 0
> 
> that was problematic because NULL + 0 is problematic now becomes
> 
> 	&dummy < NULL + 0
> 
> in the new code?  What made NULL + 0 not problematic now?

*sigh* of course you're right. I should know better than to "fire off a
quick fix to the mailing list".

I guess the two proposals that are still in the running for rescuing
this macro are Jonathan's and Gábor's. I have no strong preference
either way.

Michael
