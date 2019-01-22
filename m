Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7964D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfAVTbU (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:31:20 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44967 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVTbU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:31:20 -0500
Received: by mail-qt1-f175.google.com with SMTP id n32so28927498qte.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Kw880YKxBUhejmQEKTEXnvoJJjvgUJJ5/tSCs5LW8E=;
        b=sxHxu3EnjoFmpjL2rhno9bGKhPILiCvHSvqzOqkjB+4V3dGKahwPKyYovsIleH1UJE
         qdLCoKy+l9G1Bp1ir85stPLF86/SQUJ7NwSbJ5XuOo9C3blujYc2dVStw7yX9AzGPs3n
         m6OrtpqAU+kv7DyEAmzN7Z/eDMOPTYI9AoOtr+ArY+fiqe73SKQFv9RVGXsDYtvRc6VY
         +PklJRZ6Ayj31E5+UFhmw7ZaKgAAehJFHLSKqk2Y2CMw836wlwAZsz4xZPZfYjsLYA+s
         e4GAo0x4JoJS5BZLxce4prxjeC/2cRVFlEr8E5JCxaUznOLN1BElSp9O3Lwa1pLes1nX
         /Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Kw880YKxBUhejmQEKTEXnvoJJjvgUJJ5/tSCs5LW8E=;
        b=lRtnzbq/XGxXZ+Cy/UObhZ1Vb3mSmwXXKhlenMSlgU5XVUVachiLx/2I+7dZFG/ZVP
         qJ/v2u6AIe27W7F+1RUu8oulgQKzs9vsuk+sos0fZ3uVcJo54oqxAbM3vb5kPT81AwJ3
         fYKRtiAb7vBqzVOOjNAHWkkftPbqcj2eR+omagxL6kDrb3wTU8rzvvNV+M+6MTdTidF7
         FDlGoN7I8Yf2oQhKtV+DBCk0ccy5JE6fYxcyurAimhIi7ZvZ+6BMfoNDm4KhqvUgneMU
         nLvGHR73/8jjftUGnkZDSmkBQlgILriwhoFpkNZL+dJXcEvLlHZ5SxXU6URW0/qfXJwk
         p2ng==
X-Gm-Message-State: AJcUukcSaFEe3EfVjlaYIl98sTQD8JBJschGTcf9lgCqqvERe25zrKys
        q5M41nw7JRnd8DZpjG6LczY=
X-Google-Smtp-Source: ALg8bN7+QRB2zBL8iv/YkEanTkAab0HLofbNjYz8P/uJRnk7qpd3/2pvQow5iDVb4irVk/JL/UShow==
X-Received: by 2002:a0c:d124:: with SMTP id a33mr30188691qvh.19.1548185478396;
        Tue, 22 Jan 2019 11:31:18 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id o21sm71750333qto.18.2019.01.22.11.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:31:17 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Fix regression in checkout -b
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        pclouds@gmail.com
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190121195008.8700-1-peartben@gmail.com>
 <xmqq4la0h6am.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2a3ac803-133c-98fb-45e9-43f6e4a018d1@gmail.com>
Date:   Tue, 22 Jan 2019 14:31:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq4la0h6am.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/22/2019 1:54 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index af6b5c8336..9c6e94319e 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -517,12 +517,6 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>>   	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
>>   		return 0;
>>   
>> -	/*
>> -	 * We must do the merge if this is the initial checkout
>> -	 */
>> -	if (is_cache_unborn())
>> -		return 0;
>> -
>>   	/*
>>   	 * We must do the merge if we are actually moving to a new commit.
>>   	 */
>> @@ -598,6 +592,13 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>>   	 * Remaining variables are not checkout options but used to track state
>>   	 */
>>   
>> +	 /*
>> +	  * Do the merge if this is the initial checkout
>> +	  *
>> +	  */
>> +	if (!file_exists(get_index_file()))
>> +		return 0;
>> +
>>   	return 1;
>>   }
> 
> This is curious.  The location the new special case is added is
> different, and the way the new special case is detected is also
> different, between v1 and v2.  Are both of them significant?  IOW,
> if we moved the check down but kept using is_cache_unborn(), would
> it break?  Or if we did not move the check but switched to check the
> index file on the filesystem instead of calling is_cache_unborn(),
> would it break?
> 

I had to change the check to not use is_cache_unborn() because at this 
point, the index has not been loaded so cache_nr and timestamp.sec are 
always zero (thus defeating the entire optimization).  Since part of the 
optimization was to avoid loading the index when it isn't necessary, the 
only replacement I could think of was to check for the existence of the 
index file as if it is missing entirely, it is clearly unborn.  This 
solved the behavior change for the --no-checkout sequence reported.

The only reason I moved it lower in the function was a micro perf 
optimization.  Since file_exists() does file I/O, I thought I'd do all 
the in memory/flag checks first in case they drop out early and we can 
avoid the unnecessary file I/O.  As long as it is tested before the 
'return 1;' call, it is logically correct.

> There are three existing callers of is_{cache,index}_unborn(), all
> of which want to use it to decide if we are in this funny "unborn"
> state.  If this fixes the issue we saw in v1 of these two patches,
> does that mean these three existing callers also are buggy in the
> same way and we are better off rewriting is_index_unborn() to see if
> the index file is on the disk?
> 

It is just the fact that I needed to check for an unborn index _before_ 
it was loaded that makes me unable to use is_{cache,index}_unborn() 
here.  The other callers should still be fine.  I could add a comment in 
the code to clarify this if you think it will cause confusion later.

> I am *not* suggesting to make such a drastic change to the existing
> system.  I am wondering why they are working fine but only this new
> code has to avoid the existing is_index_unborn() logic and go
> directly to the filesystem.  Especially as this new exception added
> to "skip-merge-working-tree" is to allow the special case code in
> merge-working-tree that depends on is_cache_unborn() to trigger.
> 
> Thanks for working on this.
> 
