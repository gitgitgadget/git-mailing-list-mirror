Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90591F404
	for <e@80x24.org>; Tue, 30 Jan 2018 22:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeA3Wla (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 17:41:30 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41601 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753691AbeA3Wl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 17:41:28 -0500
Received: by mail-qt0-f195.google.com with SMTP id i1so19422375qtj.8
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SyYiLudf5o+8tmtfi2alXJbvJNP/VLSDxDpNrxx1q8A=;
        b=rxZJ1xlA2FLi+Q2a8MyfZTMRgJyhIOtZLW9yDJ6i5vVaNDFNxPMP/FdQYbb9xTo0oB
         f+qqVgtNcCTecX6aidP9CAK0KkjlcUfGzFKyvysI2zIBr8rbrUCL6E6oFlwdpaL20+/Q
         CYT7hNFo7D7mM+05QgVQNvXIkJfMPLbcyvkwrEvEEa99i64cUHdEqKv7EzTzDNrWOEQv
         YjAC0w/IZ/I2YFQYKjQaxoxu3jIGfCtVHOXwTSKjel+gvkWfcHVB0/xiJoqy2lV4eJ7d
         1f0XRHgpbiOol7POuZWdpifPecAOXndfCX7Mxpv6Z1G5jIgGxnuj+bYUBL8Bf1yb5r02
         EkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SyYiLudf5o+8tmtfi2alXJbvJNP/VLSDxDpNrxx1q8A=;
        b=aVcarcty+GlA9zVoAJ5Awr9OFLIbZXjGxGIXlx6r5LJLdYuDNkFZCw6yUQwSjK7YtD
         EdS2vTulxAg4OQVh5YVf7cMH2NSVJxbeag7b6GqCAteh0XxGzXJbhSDRXNA5m1iot4Vj
         OvXsJy3qBK0E26UYAGfxWTac/dSqxskTJVFgW8tOIeuTCPtEf7kv/XT11xBu/XnSU+WC
         5yCkmo1Rs7zFf80ayBoWGvy8tsae24rsanrCRDB9Yx2/QzuEm5Mh11xMQalx59jBZSuJ
         sVqvP5kXbnT3A71kf6PDOCgj3douLXOL8dZS9rc4mR+6/yp7Q1SBjbaCNkFyr2+o4DS8
         Jbig==
X-Gm-Message-State: AKwxytf9kuE2y0wMJ9VZJAWy+gpTYnAUUlYtVcqZO/qMDYs5HkXJ8/Yy
        KIluqodBgLeG9PKZBN8NHjs=
X-Google-Smtp-Source: AH8x224qsmQMkFIkKm1l/fgDm3+E7is4jsgL/Y4cYKGj+LZLawozp3HzD6VYrg3q/HotI1ZFILkhiA==
X-Received: by 10.200.55.55 with SMTP id o52mr50091355qtb.41.1517352087645;
        Tue, 30 Jan 2018 14:41:27 -0800 (PST)
Received: from [192.168.1.105] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 62sm10346377qkz.89.2018.01.30.14.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2018 14:41:26 -0800 (PST)
Subject: Re: Some rough edges of core.fsmonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>
References: <87efmcw3fa.fsf@evledraar.gmail.com>
 <CACsJy8BpO0s6facg+zcKC9icijpefkipM326n6xOArjn=ZW6+w@mail.gmail.com>
 <87bmhfwmqa.fsf@evledraar.gmail.com>
 <CACsJy8CJtW3LZ+4Z_06uM4rJO88FXsNvcw+zzVqdFpsQUKrvrg@mail.gmail.com>
 <20180127130954.GA19922@ash> <878tcjw2gd.fsf@evledraar.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <145f8cf4-8ade-7d86-31b6-5d92fcfea3ac@gmail.com>
Date:   Tue, 30 Jan 2018 17:41:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <878tcjw2gd.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/27/2018 2:01 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Jan 27 2018, Duy Nguyen jotted:
> 
>> On Sat, Jan 27, 2018 at 07:39:27PM +0700, Duy Nguyen wrote:
>>> On Sat, Jan 27, 2018 at 6:43 PM, Ævar Arnfjörð Bjarmason
>>> <avarab@gmail.com> wrote:
>>>> a) no fsmonitor
>>>>
>>>>      $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>>>>      12:32:44.947651 read-cache.c:1890       performance: 0.053153609 s: read cache .git/index
>>>>      12:32:44.967943 preload-index.c:112     performance: 0.020161093 s: preload index
>>>>      12:32:44.974217 read-cache.c:1446       performance: 0.006230611 s: refresh index
>>>>
>>>> ...
>>>>
>>>> b) with fsmonitor
>>>>
>>>>      $ time GIT_TRACE_PERFORMANCE=1 ~/g/git/git-status
>>>>      12:34:23.833625 read-cache.c:1890       performance: 0.049485685 s: read cache .git/index
>>>>      12:34:23.838622 preload-index.c:112     performance: 0.001221197 s: preload index
>>>>      12:34:23.858723 fsmonitor.c:170         performance: 0.020059647 s: fsmonitor process '.git/hooks/fsmonitor-watchman'
>>>>      12:34:23.871532 read-cache.c:1446       performance: 0.032870818 s: refresh index
>>>
>>> Hmm.. why does refresh take longer with fsmonitor/watchman? With the
>>> help from watchman, we know what files are modified. We don't need
>>> manual stat()'ing and this line should be lower than the "no
>>> fsmonitor" case, which is 0.006230611s.
>>
>> Ahh.. my patch probably does not see that fsmonitor could be activated
>> lazily inside refresh_index() call. The patch below should fix it.
> 
> Will have to get those numbers to you later, or alternatively clone
> https://github.com/avar/2015-04-03-1M-git (or some other test repo) and
> test it yourself, sorry. Don't have time to follow-up much this weekend.
> 
>> But between your normal refresh time (0.020 preload + 0.006 actual
>> refresh) and fsmonitor taking 0.020 just to talk to watchman, this
>> repo seems "too small" for fsmonitor/watchman to shine.
> 
> Surely that's an implementation limitation and not something inherent,
> given that watchman itself returns in 5ms?
> 
> I.e. status could work like this, no?:
> 
>   1. At start, record the timestamp & find out canonical state via some
>      expansive method.
>   2. Print out xyz changed, abc added etc.
>   3. Record *just* what status would report about xyz, abc etc.
>   4. On subsequent git status, just amend that information, e.g. if
>      watchman says nothing changed $(cat .git/last-status-output).
> 
> We shouldn't need to be reading the entire index in the common case
> where just a few things change.
> 

I agree that reading the entire index in the common case is rather 
expensive. It is, however, the model we have today and all the code in 
git assumes all cache entries are in memory.

We are interested in pursuing a patch series that would enable higher 
performance especially with large and/or sparse repos by making the 
index sparse, hierarchical, and incrementally readable/writable.  As you 
might expect, that is a lot of work and is far beyond what we can 
address in this patch series.

> There's also a lot of things that use status to just check "are we
> clean?", those would only need to record the last known timestamp when
> the tree was clean, and then ask watchman if there were any changes, if
> not we're done.
> 
>> I'm still a bit curious that refresh index time, after excluding 0.020
>> for fsmonitor, is stil 0.012s. What does it do? It should really be
>> doing nothing. Either way, read index time seems to be the elephant in
>> the room now.
>>
>> -- 8< --
>> diff --git a/read-cache.c b/read-cache.c
>> index eac74bc9f1..d60e0a8480 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1367,12 +1367,21 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>>   	unsigned int options = (CE_MATCH_REFRESH |
>>   				(really ? CE_MATCH_IGNORE_VALID : 0) |
>>   				(not_new ? CE_MATCH_IGNORE_MISSING : 0));
>> +	int ignore_fsmonitor = options & CE_MATCH_IGNORE_FSMONITOR;
>>   	const char *modified_fmt;
>>   	const char *deleted_fmt;
>>   	const char *typechange_fmt;
>>   	const char *added_fmt;
>>   	const char *unmerged_fmt;
>> -	uint64_t start = getnanotime();
>> +	uint64_t start;
>> +
>> +	/*
>> +	 * If fsmonitor is used, force its communication early to
>> +	 * accurately measure how long this function takes without it.
>> +	 */
>> +	if (!ignore_fsmonitor)
>> +		refresh_fsmonitor(istate);
>> +	start = getnanotime();
>>
>>   	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
>>   	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
>> -- 8< --
