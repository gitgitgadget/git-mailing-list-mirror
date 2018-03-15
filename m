Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0DD1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeCOSoJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 14:44:09 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43746 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbeCOSoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 14:44:08 -0400
Received: by mail-qk0-f171.google.com with SMTP id g184so8401364qkd.10
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3jQyqU+SfQaJAyq3lYgDGzfxAV8qOACdeveTlvalJoM=;
        b=fGlMxrrTGcP54eKJxOdGsUGwiE84iweKuBdgrgvJ/sr+fbzEUOHK3O8RnS+Z/9HcRe
         W7/k79pEEDIFMX4r6QpCT0+S3yIoyyuFtgt76R4k7LKqdgRmrs0RnrQdHmK/67SRaZpE
         S9fo7WLyf0A3lrcv1tpNp2y9wF/YUkDkXlLbiZKUUqCVUTgRW4F/uvZ7SwsPTT7JjKxX
         1pJIiJaxOHB2hve3JeZCGqGziAb7l1XBNxPeqqVNddVu3FuoOjgt4INXWlxsYwm4A3n1
         xNQV7Pw5zaq7DbbjIqosMof+gt6y+NvIRZzvLS9m81yJczS0+H8Kz+KM5bAv2h+Xy1p/
         thOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3jQyqU+SfQaJAyq3lYgDGzfxAV8qOACdeveTlvalJoM=;
        b=BSZtflGYMbLQojAbOPCFTCHxMlIUrPu8IBtcg1otRxe+o2o8FOzumBZrKfxbhfpbpA
         0DeCKuPDE4jiijn8PHy1u6cr6sUxt6nfM4yZ5p0LXM9a0pytIkZRLZZArPsxZlv1npeE
         Fs4AII5EbbrvLKQW4JpEPUtC5qrMg00xSY3vb3p5E1eOfPHkve+Jo1M0Xb2fuS99PGYz
         wD+uO+I4WAGBmguYpivkjE7MYkIydNH6Ez6EOEWTilTfAnHHkAQ/1Uzk+31dwwM3FxbU
         2DaxuAW8TKqzR5qTBY02QoxYB6Olwt4FHgXQ+uPewsXoSqKJyEAaFsDh9adj9GbqcLvq
         qGqg==
X-Gm-Message-State: AElRT7HpKwrZxR8rLJsPpNX9bwqWsM3o8uS7XT3r/IXSYbMlOnkLWTt0
        uGJ2JJAkk0y4cOydiiUZm3g=
X-Google-Smtp-Source: AG47ELscmVU/34QRrfcQX6XdoVgo6goi90BKRPHs3vaPUsTzNPMOIoh7tvhMPL8RVlUTWgZtEgKv3Q==
X-Received: by 10.55.42.15 with SMTP id q15mr14472938qkh.9.1521139447161;
        Thu, 15 Mar 2018 11:44:07 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z26sm4323135qtz.38.2018.03.15.11.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 11:44:06 -0700 (PDT)
Subject: Re: [PATCH v1] Fix bugs preventing adding updated cache entries to
 the name hash
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, blees@dcon.de
References: <20180315152520.23264-1-benpeart@microsoft.com>
 <xmqqfu515ihj.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <339cd7f7-9ca0-62cf-ea46-588be119eedd@gmail.com>
Date:   Thu, 15 Mar 2018 14:44:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqfu515ihj.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/15/2018 1:58 PM, Junio C Hamano wrote:
> Ben Peart <benpeart@microsoft.com> writes:
> 
>> Update replace_index_entry() to clear the CE_HASHED flag from the new cache
>> entry so that it can add it to the name hash in set_index_entry()
> 
> OK.
> 
>> diff --git a/read-cache.c b/read-cache.c
>> index 977921d90c..bdfa552861 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -62,6 +62,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>>   	replace_index_entry_in_base(istate, old, ce);
>>   	remove_name_hash(istate, old);
>>   	free(old);
>> +	ce->ce_flags &= ~CE_HASHED;
>>   	set_index_entry(istate, nr, ce);
>>   	ce->ce_flags |= CE_UPDATE_IN_BASE;
>>   	mark_fsmonitor_invalid(istate, ce);
> 
> As we are removing "old" that is not "ce", an earlier call to
> remove_name_hash() that clears the CE_HASHED bit from the cache
> entry does not help us at all.  We need to clear the bit from "ce"
> ourselves before calling set_index_entry() on it, otherwise the call
> would become a no-op wrt the name hash.  Makes sense.
> 

Correct.  As you note below, this one line is sufficient to fix the 
actual bug.

> Makes me wonder why "ce" which is a replacement for what is in the
> index already has the hashed bit, though.  Is that the failure to
> use copy_cache_entry() in the caller the other part of this patch
> fixes?  To me it looks like copy_cache_entry() is designed for
> copying an entry's data to another one that has a different name,
> but in the refresh codepath, we _know_ we are replacing an old entry
> with an entry with the same name, so it somehow feels a bit strange
> to use copy_cache_entry(), instead of doing memcpy() (and possibly
> dropping the HASHED bit from the new copy--but wouldn't that become
> unnecessary with the fix to replace_index_entry() we saw above?)
> 

This 2nd part of the patch was more for code cleanliness.  When I was 
investigating why the hashed bit was set, it was caused by this 
memcpy().  When I examined the rest of the code base, I only found 1 
other instance (in dup_entry()) that did a straight memcpy(), the rest 
used the copy_cache_entry() macro.  I updated this code to match that 
pattern as it would have prevented the bug as well though as you 
correctly point out, it is not necessary with the other fix.

> Is this fix something we can demonstrate in a new test, by the way?
> 

Unfortunately I was unable to find a way to reliably demonstrate this 
bug and fix with a new test.  I only ran across it while working on 
another patch series that ends up triggering it more reliably.

The symptom was that occasionally in very specific circumstances a git 
status call would incorrectly show some directories as having untracked 
files when there were actually no untracked files in that directory.  A 
subsequent call to status would correctly show no untracked files as 
would git status -uall.

I do have a test for this fix as part of the other patch series but 
thought I'd submit this bug fix separately as it may be a while before 
the other patch series is ready.

> Thanks.
> 
