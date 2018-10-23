Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FC41F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeJXDhv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:37:51 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35645 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeJXDhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:37:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id b207so632790vke.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7vIgCze6iqWZ4AaN4apKA1L1NWw6Dz5b+E8cq1bbdZw=;
        b=p+uE2oO0jylghfC25TsecQw78bcAGcEvPxmltiAjVn3mgaxIW+mMuqUYpaqq+X2blz
         tte9SM+icnQXVb3iHItP+rSKTv01Qvlp2Sv6/V1Dbqyxp0mOSpTABXnMM9xFcHo0g7QS
         1Z/3AkCGiwNhFw7Z75aQ5x1QDSZ/cotgoL5phfIMeJE3KleP5Nas7K3WuwUE8De4X4P6
         0r+Smg2o3DIhI5/+w+fiOrV4rvLQEMh2+vAvmQx4AmszQumn06QPkoOzIjIfzDTxDf26
         kxed6pnzoi14eKBZNZWAHj9D1E3q2z7cg+VguP01YpLV1tdCObhO2Ltoqeg0KS/S8Xf+
         xbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7vIgCze6iqWZ4AaN4apKA1L1NWw6Dz5b+E8cq1bbdZw=;
        b=jj7Pa+i7WCWyNLX02iXGTtlNdUSHH6vafR0TR4GD2MlXmnL2cEoOg+GsQYyuxZK5Mj
         BZohHgK7tcd3jP3KIkDUyMxYb1kRnIgrELtP2aaHGbau5hyuSNVVHAQaf4059/VfcGCk
         ieAsK1QJ/7tHavwaFjCCAiiQCDqK8acllfCToEm0//9pEVU+2W0dfswEmBhEPfQzsx4m
         +/c8neT6UwRwExKcz+ScKw8mxVa3Vb2xjy574lSshr1/fo7bxF/Zg3NUeTs99sJudvHK
         FYUiVx564+xAd0fkyHq28QdDhfLITxMYcav44MLBjka+eWrDJckoh8yW5pg/j4Z+6hak
         +vlw==
X-Gm-Message-State: AGRZ1gKXD2SmjiXaqQuj+v9KDxW2SzXFcStlyt4tj0UJA/HmbOP9vIgU
        Xa965/X5TpbMS3OGi0t9QwA=
X-Google-Smtp-Source: AJdET5esgxQJ7+JmPY4dH2lmf14weUjpqWtoplx18ETE0d0THKa09/YV9BMc5k3+k2MzQrAdrOFu4Q==
X-Received: by 2002:a1f:2802:: with SMTP id o2-v6mr1090802vko.29.1540321988147;
        Tue, 23 Oct 2018 12:13:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a92sm190602uaa.15.2018.10.23.12.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:13:07 -0700 (PDT)
Subject: Re: [PATCH v1] load_cache_entries_threaded: remove unused src_offset
 parameter
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
References: <20181022150513.18028-1-peartben@gmail.com>
 <20181022201721.GD9917@sigill.intra.peff.net>
 <xmqqo9bltwdy.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7a359876-7d36-5d01-5f47-76ef316b6386@gmail.com>
Date:   Tue, 23 Oct 2018 15:13:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9bltwdy.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/2018 7:05 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> If nobody uses it, should we drop the return value, too? Like:
> 
> Yup.
> 

I'm good with that.

At one point I also had the additional #ifndef NO_PTHREADS lines but it 
was starting to get messy with the threaded vs non-threaded code paths 
so I removed them.  I'm fine with which ever people find more readable.

It does make me wonder if there are still platforms taking new build of 
git that don't support threads.  Do we still need to 
write/test/debug/read through the single threaded code paths?

Is the diff Peff sent enough or do you want me to send another iteration 
on the patch?

Thanks,

Ben

>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 78c9516eb7..4b44a2eae5 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2052,12 +2052,11 @@ static void *load_cache_entries_thread(void *_data)
>>   	return NULL;
>>   }
>>   
>> -static unsigned long load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
>> -						 int nr_threads, struct index_entry_offset_table *ieot)
>> +static void load_cache_entries_threaded(struct index_state *istate, const char *mmap, size_t mmap_size,
>> +					int nr_threads, struct index_entry_offset_table *ieot)
>>   {
>>   	int i, offset, ieot_blocks, ieot_start, err;
>>   	struct load_cache_entries_thread_data *data;
>> -	unsigned long consumed = 0;
>>   
>>   	/* a little sanity checking */
>>   	if (istate->name_hash_initialized)
>> @@ -2115,12 +2114,9 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
>>   		if (err)
>>   			die(_("unable to join load_cache_entries thread: %s"), strerror(err));
>>   		mem_pool_combine(istate->ce_mem_pool, p->ce_mem_pool);
>> -		consumed += p->consumed;
>>   	}
>>   
>>   	free(data);
>> -
>> -	return consumed;
>>   }
>>   #endif
>>   
>>
>> -Peff
