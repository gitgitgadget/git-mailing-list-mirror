Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714651F404
	for <e@80x24.org>; Mon, 29 Jan 2018 23:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeA2XQ2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 18:16:28 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35054 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeA2XQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 18:16:25 -0500
Received: by mail-qt0-f193.google.com with SMTP id g14so14987739qti.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uwMuCYYz/PCAhNeIsqzpCnJ+B3Ould820oPwHhDW1w=;
        b=SlkmyK8/K9h12J1vELTTiDQBsEsTNHee3XoFXNf3RIFam9BQHWUYZTDuqAnfdJ5s1F
         JD1kE7P91e+2BE1NdHBeNc2GpUulZrwE4o+ji6nlfsgCv+4FWVQwbbCI1sp8Cvwxffz7
         NXrsWEWZglnzdTxlBxDA4kEa90qvkuaqbaFSCdPigR+hKtEpJKKXklRHqp8r3egBldWK
         VkeOX1NppoUXhGMEXEL8CmBfBm42bMK6W6cDSEHIex6+q6nYJBMrNKW296+DPNmZVIQp
         UHaQnjsijwIgftNBqLTGqf/51JD9K+KfDZMA8lobs31BPpyNBWlH3Uk88wZRNj/P4xug
         aRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uwMuCYYz/PCAhNeIsqzpCnJ+B3Ould820oPwHhDW1w=;
        b=AIKVMRo6MS4MrvaV6gMVQiQNwJuElrV/hxV9FiawRMr+gaZxorZdYJgYJBkMXEF7PX
         dhHl0ow5uoaP8VqqoXMk/YraKx4IWwQ3myanH+PdJOkO1lOo3AQzbR/1nCKvGQaZp9fY
         fX49jNh2aJ7H0d5jD5epAxoikVfASoCcPI+dYBLbGZn4CKc0F2J1CR5MaO/imZt67S+I
         Sj6mernZ8fMD5fc/bJriXGOlZ5co1AcJsfT+LI6zjLsAMo0p76aXnkRD+MmiPQHyvW4S
         LyocdwNz8RNPiVKoErPhzLU31Z4WNAZpGXuVRLg3awqojxqwmBBV2NR3rrrsRzj/7NSV
         eSYA==
X-Gm-Message-State: AKwxytc/8QIk08oiFuTrmRAgL8f0cKIzl/vBHWlPBdcoPA3O2iQ9vvfb
        fupfdo1EMTYHdtgeVDLHzDQ=
X-Google-Smtp-Source: AH8x227ZGqqtatGzbxzrq3vGPch50uxcTDtXubpDhXafZi2zzw/UcsN/ArJB1cAWFs3Mf9wMRaeTSg==
X-Received: by 10.200.49.183 with SMTP id h52mr42988293qte.281.1517267784845;
        Mon, 29 Jan 2018 15:16:24 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id m92sm9382284qkh.13.2018.01.29.15.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 15:16:23 -0800 (PST)
Subject: Re: Some rough edges of core.fsmonitor
To:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        jamill@microsoft.com
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com> <20180129094033.GA8670@ash>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <bb8a433f-bd61-1f3c-2034-1acc96539882@gmail.com>
Date:   Mon, 29 Jan 2018 18:16:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180129094033.GA8670@ash>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/29/2018 4:40 AM, Duy Nguyen wrote:
> On Sat, Jan 27, 2018 at 12:43:41PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> b) with fsmonitor
>>
>>      $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>>      12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index
> 
> This is sort of off topic but may be interesting for big repo guys. It
> looks like read cache's time is partially dominated by malloc().
> 

That is correct.  We have tried a few different ways to address this. 
First was my patch series [1] that would parallelize all of the read 
cache code.

We quickly found that malloc() was the biggest culprit and by speeding 
that up, we got most of the wins.  At Peff's recommendation [2], we 
looked into using tcmalloc but found that 1) it has bugs on Windows and 
2) it isn't being actively maintained so it didn't seem those bugs would 
ever get fixed.

We are currently working on a patch that will use a refactored version 
of the mem_pool in fast-import.c to do block allocations of the cache 
entries which is giving us about a 22% improvement in "git status" 
times.  One challenge has been ensuring that cache entries are not 
passed from one index/mem_pool to another which could cause access after 
free bugs.

[1] 
https://public-inbox.org/git/20171109141737.47976-1-benpeart@microsoft.com/
[2] 
https://public-inbox.org/git/20171120153846.v5b7ho42yzrznqoh@sigill.intra.peff.net/


> This is the performance breakdown of do_read_index()
> 
> $ GIT_TRACE_PERFORMANCE=2 ~/w/git/t/helper/test-read-cache
> 0.000078489 s: open/mmap/close
> 0.038915239 s: main entries
> 0.018983150 s: ext TREE
> 0.012667080 s: ext UNTR
> 0.000005372 s: ext FSMN
> 0.001473470 s: munmap
> 0.072386911 s: read cache .git/index
> 
> Reading main index entries takes like half of the time (0.038 vs
> 0.072). With the below patch to take out hundred thousands of malloc()
> we have this, loading main entries now only takes 0.012s:
> 
> $ GIT_TRACE_PERFORMANCE=2 ~/w/git/t/helper/test-read-cache
> 0.000046587 s: open/mmap/close
> 0.012077300 s: main entries
> 0.020477683 s: ext TREE
> 0.010259998 s: ext UNTR
> 0.000010250 s: ext FSMN
> 0.000753854 s: munmap
> 0.043906473 s: read cache .git/index
> 
> We used to do less malloc until debed2a629 (read-cache.c: allocate
> index entries individually - 2011-10-24) but I don't think we can
> simply revert that (not worth the extra complexity of the old way).
> 
> Now "TREE" and "UNTR" extensions become a bigger problem.
> 
> -- 8< --
> diff --git a/read-cache.c b/read-cache.c
> index d60e0a8480..88f4213c99 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1622,7 +1622,12 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
>   						   const char *name,
>   						   size_t len)
>   {
> +#if 0
>   	struct cache_entry *ce = xmalloc(cache_entry_size(len));
> +#else
> +	static char buf[1024];
> +	struct cache_entry *ce = (struct cache_entry *)buf;
> +#endif
>   
>   	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
>   	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 48255eef31..e1d21d17a3 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -8,7 +8,9 @@ int cmd_main(int argc, const char **argv)
>   	setup_git_directory();
>   	for (i = 0; i < cnt; i++) {
>   		read_cache();
> +#if 0
>   		discard_cache();
> +#endif
>   	}
>   	return 0;
>   }
> -- 8< --
> 
