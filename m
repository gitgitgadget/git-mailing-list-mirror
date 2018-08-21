Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D041F954
	for <e@80x24.org>; Tue, 21 Aug 2018 18:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHUWBQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 18:01:16 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36930 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeHUWBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 18:01:16 -0400
Received: by mail-qk0-f196.google.com with SMTP id f17-v6so6719251qkh.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XXNuoUG+XIRy5Hb/YYQ+Xm/MMJX6/jOu0QDD3+rGnYA=;
        b=uuqxk7HgGX/8zSA4qCwRjrrRz18MLyJUNTtpnxjLUDS6dgCadxLU5pVBwTkY7/V/mN
         qGwXyU7JWs/J6HXjjLrnZMSnjh5uuvchBOGPoNUMNFoX6ZRk0BdoXEXPDTbgOT2A03zv
         r7ZwflX6uisYGycP1MOqB7zQ/FaZawEAQzoeERcHhPpmczr2zGarHMcW8w0Ddymuroku
         +IEs3qfv9s2LVd+3usq1lj7ksD22VZF9mNiGgSaGwG8y+wjfRTRGBf63lNuIivcK7T4V
         rbRBr2J5U91mCUExviH5oN398Q+1ZszeSfuLBF258peu9MOk29XaK7lxXkPN4OuQ3j4B
         tKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XXNuoUG+XIRy5Hb/YYQ+Xm/MMJX6/jOu0QDD3+rGnYA=;
        b=rpZPYUkbpbdWLnsqaRlPiqplAVdR37VHuNm7ZzFsP2ZdkeWLhEGF2ex/Ima/+R1XC9
         pKksNUbqbmtHOMLUF6EfanLgf9W9IVQqS+U/tKBTA54WRPt8ZIOz3RtO7uA0RDxwNIMj
         /+2XqF5vq+ZbuA0KADf/PDE4G26fgIYN1PMuK2WCu+ar6o07wsUOO8Sv9N1tB0V4aNqt
         EGa296miwBaFonaWzNeeoAYEtnk4hgFqD8zSWYkzxRagwh0V2VaKvWr2jtzQ0aJ6ORJ2
         Qa1sOzi6KauVZTDKrvzLTtdD520/cnJIabqdD1aE1+HKal8eiUhMddgJoFr9yklGLGTd
         /RQQ==
X-Gm-Message-State: AOUpUlGuMLfqV61jF/4EVZi9K+rmY43L8rEvYOOktpMPsFmlTa+5GAZH
        BCp1edSYUlFQKzXh7DA8nzg=
X-Google-Smtp-Source: AA+uWPz2PSSqb1RAl7f0DkyDDSuAbPvTeeEbO8axwwLqQkY1lPJABbCGnDZw9/SUIwoIC28EWaIr3A==
X-Received: by 2002:a37:c207:: with SMTP id i7-v6mr45583877qkm.292.1534876797725;
        Tue, 21 Aug 2018 11:39:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bcc1:4ea1:6a05:dc2a? ([2001:4898:8010:0:a5f7:4ea1:6a05:dc2a])
        by smtp.gmail.com with ESMTPSA id j129-v6sm4583922qke.56.2018.08.21.11.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 11:39:57 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] commit-graph: not compatible with replace objects
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <20180820182359.165929-1-dstolee@microsoft.com>
 <20180820182359.165929-6-dstolee@microsoft.com>
 <xmqqa7pfaa15.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <78b20554-1522-9661-cb29-09ffd438b206@gmail.com>
Date:   Tue, 21 Aug 2018 14:39:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7pfaa15.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 1:45 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Create new method commit_graph_compatible(r) to check if a given
>> repository r is compatible with the commit-graph feature. Fill the
>> method with a check to see if replace-objects exist. Test this
>> interaction succeeds, including ignoring an existing commit-graph and
>> failing to write a new commit-graph. However, we do ensure that
>> we write a new commit-graph by setting read_replace_refs to 0, thereby
>> ignoring the replace refs.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   builtin/commit-graph.c  |  4 ++++
>>   commit-graph.c          | 21 +++++++++++++++++++++
>>   replace-object.c        |  2 +-
>>   replace-object.h        |  2 ++
>>   t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
>>   5 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index 0bf0c48657..da737df321 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -120,6 +120,8 @@ static int graph_read(int argc, const char **argv)
>>   	return 0;
>>   }
>>   
>> +extern int read_replace_refs;
>> +
> Why do you need this (and also in commit-graph.c)?  I thought
> cache.h includes it, which you can just make use of it.


You're right. I don't know how I missed that.


>> +static int commit_graph_compatible(struct repository *r)
>> +{
>> +	if (read_replace_refs) {
>> +		prepare_replace_object(r);
>> +		if (hashmap_get_size(&r->objects->replace_map->map))
>> +			return 0;
>> +	}
>> +
>> +	return 1;
>> +}
>> diff --git a/replace-object.c b/replace-object.c
>> index 3c17864eb7..9821f1477e 100644
>> --- a/replace-object.c
>> +++ b/replace-object.c
>> @@ -32,7 +32,7 @@ static int register_replace_ref(struct repository *r,
>>   	return 0;
>>   }
>>   
>> -static void prepare_replace_object(struct repository *r)
>> +void prepare_replace_object(struct repository *r)
>>   {
>>   	if (r->objects->replace_map)
>>   		return;
> The way the new caller is written, I am wondering if this function
> should return "we are (or, are not) using the replace object
> feature", making it unnecessary for callers on the reading side to
> know about "read-replace-refs" external variable, for example.
>
> 	/*
> 	 * To be called on-demand from codepaths that want to make
> 	 * sure that replacement objects can be found as necessary.
> 	 *
> 	 * Return number of replacement defined for the repository, or
> 	 * -1 when !read_replace_refs tells us not to use replacement
> 	 * mechanism at all.
> 	 */
> 	int prepare_replace_object(struct repository *r)
> 	{
> 		if (!read_replace_refs)
> 			return -1;
>
> 		if (!r->objects->replace_map) {
> 			r->objects->replace_map =
> 				xmalloc(...);
> 			oidmap_init(r->objects->replace_map, 0);
> 			for_each_refplace_ref(r, register_...);
> 		}
> 		return hashmap_get_size(&r->objects->replace_map->map);
> 	}

This is a good idea. I can incorporate it into v3.

> Then, the caller side can simply become something like:
>
> 	#define cgraph_compat(r) (prepare_replace_object(r) <= 0)

With the next two patches that add more conditions to 
commit_graph_compatible(), I'd prefer keeping it a method instead of a 
macro.

> There are various writers to read_replace_refs variable, but I think
> they should first be replaced with calls to something like:
>
> 	void use_replace_refs(struct repository *r, int enable);
>
> which allows us to hide the global variable and later make it per
> repository if we wanted to.

I will incorporate this into v3 as well.

Thanks,

-Stolee

