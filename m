Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453E61F597
	for <e@80x24.org>; Thu,  2 Aug 2018 09:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeHBLtF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 07:49:05 -0400
Received: from mout.web.de ([212.227.15.4]:50783 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeHBLtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 07:49:05 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MarZy-1fV9vQ3WzS-00KLxE; Thu, 02
 Aug 2018 11:58:38 +0200
Subject: Re: [PATCH] remote: clear string_list after use in mv()
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <553f84f2-7d9d-9a92-d5ca-39bd862ff748@web.de>
 <20180802025641.GF189024@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6b88257e-d698-a160-952a-738104021025@web.de>
Date:   Thu, 2 Aug 2018 11:58:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802025641.GF189024@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aD/VDDzCtKKEvDvtTTvna4fe7vApc5VSBqIPkwIRzPeRG2VQD2k
 Yn7sEONTJpZfoON6X+n8Oa+w2aGWzcdSioWFeIdX1g/SHY230h3m7qTbgpdw9EfOhpYrwMk
 ykZT7f//bJ2xvrLQ70BmHBTbpMUU4sSXYxxDQnpfX5EERKsZoCU1/0FKR1gw1IdCcbvLH5q
 i93TBpBIfong3agry/oYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CYTFDs0v1aw=:U00oi8fGId24TBTavg8UGi
 mFjYIe/d7luQMff6JExeIgsWZfb2GKBBSAVEN8T8YPkBfsoYrHZGXd5/IRRbwxPIRWJx8PJOT
 LiWNnnMIRX2hcuVFYGioQ+s9aZQEtAWx/l45sNt9Q9OlR9aTxcNxt0wO9/qluDAqZW/LuNIOp
 8+sIDpIa5TdH59fGqslDqsDGk9fF8Ov/UfFoc7xOgJZqtcM6hg5Y5DY2zWh3AyZQ99XyLMCKr
 JWIwJkXtAbI0rMHfkhsfSReZwhNMSfEbQt5++x4u73sSFKKVg9MOh4GisRM8aeti2DDYb8IqV
 XJ8kxJTrvu7ICLFATM40dKFKLX1mSnAVTeS6Ctwss3/oEl5JjC2MAOe37htZZlXrfH/uItTmO
 NFDyIb4nlq7NpyUB9dGhhjbFRyxFoyAAc9yilDAcz/A2LsvNvK0SSwXm3rNMMpID+uueapbWK
 NxjErUEWhjVcqsX+e3oTo6Vs2AZwPWwTX0ij22hRT59EhZyFWxGjFbJtIsUKPv3eRokCDvGXc
 HG4kirRofQS70TaOpkP7RTlSmbBNRQrc+nG/EvpgjN6nMXoPgUS7bL52o0/v4dSu3SOATWGHt
 YVF4zACFbb36Sp0o5BoZSSmL0nLDFDxKMvDl0ZoYSVEeEIjLzdegRATYl7yyAPUIsYVzfJk8x
 FFjCPHi7bj6sfypZ5bI+nQ7dXbHKOERvZ4sQT5Jvb0KsvYmrkpLxQP9UhhjxBC9Gmzq55fMSB
 DYBv01MODyXA71dWv8c8po8IJX8dzvZZkvltkgNogI6KNupeMlYEj4iMJx6rce+4RetUcotOg
 wX6dVfl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the review!

Am 02.08.2018 um 04:56 schrieb Jonathan Nieder:
> René Scharfe wrote:
> 
>> Subject: remote: clear string_list after use in mv()
> 
> This subject line doesn't fully reflect the goodness of this change.
> How about something like:
> 
> 	remote mv: avoid leaking ref names in string_list
> 
> ?

Hmm, "clearing" a string_list is how we release its memory, and since we
didn't do it before (otherwise we wouldn't need the patch) it leaked
before.  So I think the title implies plugging a leak already.

The ref names don't take up much space -- they are probably in the range
of hundreds to thousands and probably take up less than 100 bytes each.
The command exits after calling mv(), so this is a minor leak which
won't be noticed by users.

The benefit of this patch is to bring this function in line with its
siblings, which all release their string_lists when done.

>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -558,23 +558,23 @@ struct rename_info {
> 
> optional: Would it be worth a comment in the struct definition to say
> this string_list owns its items (or in other words that it's a _DUP
> string_list)?

Such a comment could easily get out of sync with the assignment later in
the code.  And the struct could easily be used with both types of
string_lists, even if that's not the case here, so I don't think that's
the right place.

We could add an assert(rename->remote_branches->strdup_strings) before
the string_list_append() call instead, which would document that
requirement in the right place in a way that shouldn't get out of sync
silently, but I'm not sure it's worth it here.

>>   	if (!refspec_updated)
>>   		return 0;
>>   
>>   	/*
>>   	 * First remove symrefs, then rename the rest, finally create
>>   	 * the new symrefs.
>>   	 */
>>   	for_each_ref(read_remote_branches, &rename);
> 
> As you noted, this is the first caller that writes to the string_list,
> so we don't have to worry about the 'return 0' above.  That said, I
> wonder if it might be simpler and more futureproof to use
> destructor-style cleanup handling anyway:
> 
> 	if (!refspec_updated)
> 		goto done;
>   [...]
>    done:
> 	string_list_clear(&remote_branches, 1);
> 	return 0;

There are some more early returns higher up, which would have to be
adjusted as well.  Such a restructuring would be helpful if we decide
to release the various strbufs in that function as well..

But perhaps the main problem is that the function is too long. Could
it be split up into sensible parts with a lower number of allocations
each that can be kept track of more easily?

(Sounds like a bigger bite than I can chew at the moment, though.)

>> +	string_list_clear(&remote_branches, 1);
> 
> not about this patch: I wonder if we should make the free_util
> parameter a flag word so the behavior is more obvious in the caller:
> 
> 	string_list_clear(&remote_branches, STRING_LIST_FREE_UTIL);
> 
> Or maybe even having a separate function:
> 
> 	string_list_clear_free_util(&remote_branches);

I agree that naming variants instead of using binary options is a good
idea in general, as it makes the code self-documenting.

I'd like to suggest another option: remove the second parameter of
string_list_clear() and add string_list_free_util(), which only free(3)s
->util pointers.  Users that attached heap objects to string_list items
would have to call both functions; no need to glue them together.

René
