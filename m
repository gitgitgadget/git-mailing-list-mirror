Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiCGQbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244207AbiCGQa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:30:59 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC06E4F6
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:30:04 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so18412471ooi.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cuEBINC5ix5EMknTR+e2lnMGvdhiKCG8j3JiXyGjUxo=;
        b=Za/NrgoZFMwnW+lCsERNOklQ+aWsfGwVV11NOE9zM722ggLp0MQca5n0ZlZsD7Ytg5
         jLemftLXydaH4sMa4WyBDmu+UYT3NB7c63h7uwLJSF01JWsHGfx209HgXomCOS6m5LUp
         114Kzmy9vxeWHFBnOIHe+k8jktpgX5Hx3jVr37lm0K9iyB9dmo4rq1TkP9JW6VfVuMOB
         mbuzKJ/H/CWKpnqStFo/lh0zXYA8yG/QJYwW2rIffq51PerYp9iIUCRwkKlGMLRL+rTS
         2/EgmI1lbsVcKS2FoG0vq63M0l51kzFpIC5rk09TC5AML6N8grA+aKhsVqxVqb2Ef9iW
         HDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cuEBINC5ix5EMknTR+e2lnMGvdhiKCG8j3JiXyGjUxo=;
        b=fvBbQpRuMNqze6LHOhU8ss3Sc+VJ4gK6grdVoXHMBgt9FAP6/Jl+EKNZf/5S8XhbQK
         akI8lD6F7ALTOQq7Jg3ezn06xWjflYMFImB6a1vtHHY/ZfFvMV+i8XYHP460D0GZ6Gtj
         H9i7of26nhDIT5Wzbmxf0DFrJGS4VATgz/PRXc4elMI6ja/VjSJ3B19c75xFJG6ShiG5
         HEJyhV0GvtU7EDPWZ9Yz+Zj+RiizfljlTl+yL3yQKMf4WCAR52ilmDzc6Al7FVWIJySm
         9zvBQ5AlpIa4WMXQ0XhAKGhjtg1WQTBhS9Pg3/ahpncpaADlLIfiiCrl0r5vx3II/zKU
         +4vA==
X-Gm-Message-State: AOAM533+7tyHq/LRMZCRWl7McFj3hKFQmmiFpEiD8WB9n22f8v6DgBJr
        jGp45uBMpkogep91PN1y64RL
X-Google-Smtp-Source: ABdhPJx9vFXCl1Mlen5n/TQOxUAX3ftBEIJB6RoqGYmKyahCsZJN1rzi+m4HdUKHU7MS1gXwFDlG9Q==
X-Received: by 2002:a05:6870:4341:b0:d3:1412:8ecb with SMTP id x1-20020a056870434100b000d314128ecbmr6156249oah.36.1646670603881;
        Mon, 07 Mar 2022 08:30:03 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f21-20020a4ada55000000b0031c16df28f9sm5860875oou.42.2022.03.07.08.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:29:47 -0800 (PST)
Message-ID: <e1b91bb3-4f42-5829-269a-a4a4ec6eb4bf@github.com>
Date:   Mon, 7 Mar 2022 11:29:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 08/11] bundle: parse filter capability
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
 <220307.86bkyhzs3r.gmgdl@evledraar.gmail.com>
 <142219bd-5047-a27d-d53f-2ec2f6cb9c08@github.com>
 <220307.86pmmxybmz.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220307.86pmmxybmz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 11:22 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Mar 07 2022, Derrick Stolee wrote:
> 
>> On 3/7/2022 10:38 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
>>>
>>>> From: Derrick Stolee <derrickstolee@github.com>
>> ...
>>>> diff --git a/bundle.h b/bundle.h
>>>> index 06009fe6b1f..eb026153d56 100644
>>>> --- a/bundle.h
>>>> +++ b/bundle.h
>>>> @@ -5,11 +5,14 @@
>>>>  #include "cache.h"
>>>>  #include "string-list.h"
>>>>  
>>>> +struct list_objects_filter_options;
>>>> +
>>>
>>> For the other ones we include the relevant header, do the same here (or
>>> if there's a need to not do it, do we need it for the rest too?)
>>
>> The others are .c files that require looking into the struct. This
>> declaration is all that's required for this header file.
>>
>>>>  struct bundle_header {
>>>>  	unsigned version;
>>>>  	struct string_list prerequisites;
>>>>  	struct string_list references;
>>>>  	const struct git_hash_algo *hash_algo;
>>>> +	struct list_objects_filter_options *filter;
>>>>  };
>>>
>>> I haven't tried, but any reason this needs to be a *filter
>>> v.s. embedding it in the struct?
>>>
>>> Then we'd just need list_objects_filter_release() and not the free() as
>>> well.
>>>
>>> Is it because you're piggy-backing on "if (header->filter)" as "do we
>>> have it" state, better to check .nr?
>>
>> Yes. I replied to Junio before that there is some assumption in
>> the filtering code that the .nr == 0 case is listed as a BUG()
>> so we would possibly be breaking expectations in a different
>> way doing the embedded version.
> 
> Having an "unsigned int using_filter:1" or whatever IMO makes that much
> clearer than needing to carefully eyeball code that's already using
> embedded structs & see why the one exception that's malloc'd is because
> of that or some other reason...

I think your recommended "using_filter" is messy. Having this
struct be a pointer instead of embedded self-documents that it
is optional (and can be NULL) but that if it is non-NULL, then
it should be considered and valid.

Here, I'm focusing on not allowing a non-sensical state, such
as using_filter = 0 but filter is actually populated with a
valid filter. The possibility of this state means there is a
higher chance of introducing a bug over time by not keeping
these values coupled.

Thanks,
-Stolee
