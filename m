Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90E51FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 10:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbdBJKYK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 05:24:10 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49161 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752052AbdBJKYH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 05:24:07 -0500
X-AuditID: 1207440c-07dff70000000a44-53-589d94be7e79
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id DB.02.02628.EB49D985; Fri, 10 Feb 2017 05:23:59 -0500 (EST)
Received: from [192.168.69.190] (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1AANt9j023082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 05:23:56 -0500
Subject: Re: [PATCH 1/5] refs: store submodule ref stores in a hashmap
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
 <a944446c4c374125082f5ad8b79e731704b66196.1486629195.git.mhagger@alum.mit.edu>
 <xmqqh943p0hv.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c631a5eb-936b-bd88-cc3b-732786f75065@alum.mit.edu>
Date:   Fri, 10 Feb 2017 11:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqh943p0hv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLt/ytwIg++nNCy6rnQzWTT0XmG2
        6F/exWax5OFrZovuKW8ZLX609DBbbN7czuLA7rFz1l12jw8f4zwWbCr16Go/wubxrHcPo8fF
        S8oenzfJBbBHcdmkpOZklqUW6dslcGWcWb+MpeCSSMWFpz9YGxj3C3QxcnJICJhIPHh4j62L
        kYtDSOAyo8SqQ1OYIJwLTBJLpz1gA6kSFnCTuHl2AzOILSKgJjGx7RALRNFORonOB7fZQRxm
        gWlMEsv+P2QHqWIT0JVY1NMMNIqDg1fAXuLoYROQMIuAqkTzwb8sILaoQIjEnIUPGEFsXgFB
        iZMzn4DFOQWsJZpv3ABbxiygJ7Hj+i9WCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNK
        c3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCAp5nB+O3dTKHGAU4GJV4eCdUzYkQYk0s
        K67MPcQoycGkJMpr2zA3QogvKT+lMiOxOCO+qDQntfgQowQHs5IIr00HUI43JbGyKrUoHyYl
        zcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMFbOBmoUbAoNT21Ii0zpwQhzcTBCTKcB2h4
        CEgNb3FBYm5xZjpE/hSjopQ4bxpIQgAkkVGaB9cLS0ivGMWBXhHmnQxSxQNMZnDdr4AGMwEN
        vn56FsjgkkSElFQDY5ZC91lFKz229yvd212mdfzZkOwoybrw16R+M5Mte15d+ihx8pNMedar
        N3EtNb/qPqw1FQ1feEZxUVa7wNdHOTwe76YrL5SNNVP+pvDja03Po7++GzJ3+sgvNVbI+PPk
        y6wKPl63ar5KFuYw9zW3srdMy/vu+v/Jjvv1C7M1z/ffqSnU4U0VVmIpzkg01GIuKk4EAB0/
        SwEjAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2017 09:34 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]
>> +static int submodule_hash_cmp(const void *entry, const void *entry_or_key,
>> +			      const void *keydata)
>> +{
>> +	const struct submodule_hash_entry *e1 = entry, *e2 = entry_or_key;
>> +	const char *submodule = keydata;
>> +
>> +	return strcmp(e1->submodule, submodule ? submodule : e2->submodule);
> 
> I would have found it more readable if it were like so:
> 
> 	const char *submodule = keydata ? keydata : e2->submodule;
> 
> 	return strcmp(e1->submodule, submodule);
> 
> but I suspect the difference is not that huge.

Yes, that's better. I'll change it.

On 02/10/2017 05:04 AM, Jeff King wrote:
> On Thu, Feb 09, 2017 at 12:34:04PM -0800, Junio C Hamano wrote:
>
>>> +static struct submodule_hash_entry *alloc_submodule_hash_entry(
>>> +		const char *submodule, struct ref_store *refs)
>>> +{
>>> +	size_t len = strlen(submodule);
>>> +	struct submodule_hash_entry *entry = malloc(sizeof(*entry) + len + 1);
>>
>> I think this (and the later memcpy) is what FLEX_ALLOC_MEM() was
>> invented for.
>
> Yes, it was. Though since the length comes from a strlen() call, it can
> actually use the _STR variant, like:
>
>   FLEX_ALLOC_STR(entry, submodule, submodule);
>
> Besides being shorter, this does integer-overflow checks on the final
> length.

Nice. TIL. Will fix.

>>> @@ -1373,16 +1405,17 @@ void base_ref_store_init(struct ref_store *refs,
>>>  			die("BUG: main_ref_store initialized twice");
>>>
>>>  		refs->submodule = "";
>>> -		refs->next = NULL;
>>>  		main_ref_store = refs;
>>>  	} else {
>>> -		if (lookup_ref_store(submodule))
>>> +		refs->submodule = xstrdup(submodule);
>>> +
>>> +		if (!submodule_ref_stores.tablesize)
>>> +			hashmap_init(&submodule_ref_stores, submodule_hash_cmp, 20);
>>
>> Makes me wonder what "20" stands for.  Perhaps the caller should be
>> allowed to say "I do not quite care what initial size is" by passing
>> 0 or some equally but more clealy meaningless value (which of course
>> would be outside the scope of this series).
>
> I think this is what "0" already does (grep for HASHMAP_INITIAL_SIZE).
> In fact, that constant is 64. The 20 we pass in goes through some magic
> load-factor computation and ends up as 25. That being smaller than the
> INITIAL_SIZE constant, I believe that we end up allocating 64 entries
> either way (that's just from reading the code, though; I didn't run it
> to double check).

I guess I might as well change it to zero, then.

Thanks for the feedback!

Michael

