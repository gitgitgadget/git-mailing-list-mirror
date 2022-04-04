Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FDC433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbiDDJV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiDDJV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 05:21:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC12E091
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 02:20:00 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so5825480wms.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wdegqf9p7Wtzb+cULSh+IGNdzJXpRLaGSNzMnAL1rFg=;
        b=SHIl+e1BPaBN0gZ9aILfKZhBwQ+695AiwohB9s1T7m/rgsekMVKFw79TXIW2z4CXg/
         83V+oCY2eVhRn8qC2Tmu30tMptf7vmMCn1qRkxbaKkuyrCkK4H87d9MKNLUm4r8qcq+3
         +rUrIdlnQrURfGVQDe+C/wUgeXkMS23gtGhMh1ltsJj4/Xi9nn3NgrYixEhKPpW5lx/+
         zvP3ppRHd8j5h8TORQSEzjZVcLIXMHrDaxbxHnLOWmAkKVUsVInl2wAIKjOaVprRV32h
         z1Q0AcvqGPPjVBc5uYOn5WUHihuq3OMDdd/erWvO5m3vGOUL7UxZkPBbl/rwhZiB5Ea7
         YkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wdegqf9p7Wtzb+cULSh+IGNdzJXpRLaGSNzMnAL1rFg=;
        b=oB09XHIL4P/TFK4Hj+oEMdu6siBFRLpmxaMe0W0lERmG7Ir2RjX6yVJ7ZRXhYBTlP/
         BRCpEEj2ltKAtepZRJQYu6yx5iaypor6m+Fvq3DrKPd6OgkkKvVrMaiI2vKhQpnkcNLq
         6FNrAs/bdW/qvrWgxDEnZ+2NLki6tO8fZsWg3nj41DVbUsoe1vHyt2MJ7j5Yyrd3TCsd
         uNop9BxdvMl8pC3VPWF7AojJYdI6SUssjB9pzivsUcQU2kt5wDTFK+kLEVY9C9DSAZux
         UWf+B4hqwRqOvjW/pTza9vObRXpInMJRUwW8qRfLmxN0KlACtNhKyljMMKcnwz8oYRfW
         7Mag==
X-Gm-Message-State: AOAM533XEnE4XOD/ev1roGpgXyKB/XcL+S7IKJNwy99wn5BSQTvO0K4I
        GXZ5Q2X7/O6W/hDeJd8ku9c=
X-Google-Smtp-Source: ABdhPJwEevylvdtsn9m2NF2ODqhkl7sHavrVOzdG4NxaOVSbrVmL8yDBMmvx7DiCqfDaqh3ax72igg==
X-Received: by 2002:a05:600c:354d:b0:38c:e71a:c230 with SMTP id i13-20020a05600c354d00b0038ce71ac230mr18339300wmq.86.1649063999361;
        Mon, 04 Apr 2022 02:19:59 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5009000000b002060f7faa02sm3147944wrt.116.2022.04.04.02.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 02:19:58 -0700 (PDT)
Message-ID: <ce2c72e5-f172-b017-e62d-2eebc5ba1631@gmail.com>
Date:   Mon, 4 Apr 2022 10:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 17/27] revisions API: have release_revisions() release
 "mailmap"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-17.27-ca659940ee5-20220402T102002Z-avarab@gmail.com>
 <5044b964-0605-356c-3e03-1aad8cbbe619@gmail.com>
 <220403.86ilrqmflb.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220403.86ilrqmflb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 03/04/2022 14:57, Ævar Arnfjörð Bjarmason wrote:
> [...]
>>>    	av[++ac] = buf.buf;
>>>    	av[++ac] = NULL;
>>>    	setup_revisions(ac, av, &revs, NULL);
>>> -	revs.mailmap = &mailmap;
>>> +	revs.mailmap = xmalloc(sizeof(struct string_list));
>>> +	string_list_init_nodup(revs.mailmap);
>>
>> This is a common pattern in one of the previous patches, is it worth
>> adding helpers to allocate and initialize a struct string_list? Maybe
>> string_list_new_nodup() and string_list_new_dup().
> 
> Maybe, but generally in the git codebase things malloc and then init(),
> if we're going to add something like this *_new() that would be a change
> for a lot more APIs than just mailmap.
> 
> And if it's just for mailmap I don't see how the inconsistency with
> other code would be worth it.

It's for struct string_list not for mailmap and could be used for all 
the conversions in patch 3. In general the split between allocation and 
initialization is useful because it allows us to allocate structures on 
the stack where possible or embed them in other structures. However if 
there is a structure that is often allocated on the heap then I don't 
think there is anything wrong with having a combined 
allocate-and-initialize helper function which makes the code shorter and 
eliminates the possibility of passing the wrong size to malloc().

>>> diff --git a/revision.c b/revision.c
>>> index 553f7de8250..622f0faecc4 100644
>>> --- a/revision.c
>>> +++ b/revision.c
>>> @@ -2926,10 +2926,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>>    	return left;
>>>    }
>>>    +static void release_revisions_mailmap(struct string_list
>>> *mailmap)
>>> +{
>>> +	if (!mailmap)
>>> +		return;
>>> +	clear_mailmap(mailmap);
>>> +	free(mailmap);
>>> +}
>>
>> It's not a big issue but if there are no other users of this then it
>> could just go inside release_revisions, my impression is that this
>> series builds a collection of very small functions whose only caller
>> is release_revisions()
> 
> Yes, these are just trivial static helpers so that each line in
> release_revisions() corresponds to a member of the struct, without
> loops, indentation for "don't free this" etc.

Fair enough

> To the machine code it makes no difference at higher optimization
> levels.

Indeed, not that these functions are particularly performance sensitive 
in the first place.

Best Wishes

Phillip
