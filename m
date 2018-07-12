Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837821F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeGLQko (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:40:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38419 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeGLQkn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:40:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id c5-v6so24596242qth.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IHia6/Gwk/D28Mweu499Ie/MIXWXpBMIA8nt/G8cUMk=;
        b=LNWUgIyhwkwzzHoqh1QeJFjFkm5938r0oVW9be2jqYNnTInOdLv2cb0372G8+yA9m0
         lrSsIxVxdyNGWQTRnZ+vL6mr949HLa+uZ4+nxDKj4cPobMmg1UZj6JgBJvO9RUtyd3z8
         UOCKcFw0ZnXhj9e1UpfqFmxg9LBNmfP1x1Hxz75qKVV4//+I1ANpCoK4+mH/6NHxpJsQ
         8GqiQAL8tz2cn7wVhFwFaYFWB0f6hPlL/HBcMbVQzNqttNKq7GSFTDZ6Qo8iovYhFQ7H
         IGJXlXZj/CQwClRyKhuJ2R27Pwcngt2zKgE0Viu0HMfsGgmNJ7UWsKm8VmnD0HXcvT+n
         pSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IHia6/Gwk/D28Mweu499Ie/MIXWXpBMIA8nt/G8cUMk=;
        b=CtQp8ePQQFcBZ5AXl+XLBQeGxK7ZyJnFG19fzZ9MbxAskc5PoSNKCx4l1ZUtVfFfEd
         Q6grwzm6m4q7NsDVyyuYNJemEIiz0kic8r7jbyLo0LOko5cWpakz+of9MxRR3TZFMtOD
         wzb7YTAqbaRHjeMyOl8pSbt7URprIkmNXkf21Ku6MhRVg0sxGFy82jEK/oWLjDiGrPlL
         PTh5JW5aBcKkTpm8lRjFZntoatRuYUYguzILT4iBBTGr1rr8sxmUV6iQFSFLgE6tKWa5
         0GH66b83Grs67NKAqJ0AQ24SeeePwmmPmDW717Ft1E/WkIiE+VZa7FPzvc4SUNIy72dk
         4eJA==
X-Gm-Message-State: AOUpUlHe3ZbmzXG52d4MQVtR6SfebO0Z1TlUpYn1pEgpEFGGiT0YYH21
        JyrgnTzX7n4woE21FeoggVM=
X-Google-Smtp-Source: AAOMgpe+xV/xcWOcm8AiUo2xuq4/0mZQ11TQKvCRpVzgx5HgUNqmfwL/Y3LwPL8PC1qjbptlfWR/ZA==
X-Received: by 2002:ac8:222a:: with SMTP id o39-v6mr2451364qto.399.1531413026681;
        Thu, 12 Jul 2018 09:30:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7999:2a5f:44db:50fd? ([2001:4898:8010:0:62cf:2a5f:44db:50fd])
        by smtp.gmail.com with ESMTPSA id e81-v6sm8825662qka.3.2018.07.12.09.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:30:26 -0700 (PDT)
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
From:   Derrick Stolee <stolee@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com>
 <CAPig+cTJuvOjyzkmAj5axAkS3q1UyeV03jQk6-oB==KyzbEK_w@mail.gmail.com>
 <2270ec32-f5e3-e23a-5605-f5f0e7a44c46@gmail.com>
Message-ID: <5ff95525-4677-872d-e249-b01b5aaf6c68@gmail.com>
Date:   Thu, 12 Jul 2018 12:30:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2270ec32-f5e3-e23a-5605-f5f0e7a44c46@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2018 9:19 AM, Derrick Stolee wrote:
> On 7/6/2018 1:39 AM, Eric Sunshine wrote:
>> On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>>> The core.multiPackIndex config setting controls the multi-pack-
>>> index (MIDX) feature. If false, the setting will disable all reads
>>> from the multi-pack-index file.
>>>
>>> Add comparison commands in t5319-multi-pack-index.sh to check
>>> typical Git behavior remains the same as the config setting is turned
>>> on and off. This currently includes 'git rev-list' and 'git log'
>>> commands to trigger several object database reads.
>>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>> ---
>>> diff --git a/cache.h b/cache.h
>>> @@ -814,6 +814,7 @@ extern char *git_replace_ref_base;
>>> +extern int core_multi_pack_index;
>>> diff --git a/config.c b/config.c
>>> @@ -1313,6 +1313,11 @@ static int git_default_core_config(const char 
>>> *var, const char *value)
>>> +       if (!strcmp(var, "core.multipackindex")) {
>>> +               core_multi_pack_index = git_config_bool(var, value);
>>> +               return 0;
>>> +       }
>> This is a rather unusual commit. This new configuration is assigned,
>> but it's never actually consulted, which means that it's impossible
>> for it to have any impact on functionality, yet tests are being added
>> to check whether it _did_ have any impact on functionality. Confusing.
>>
>> Patch 17 does consult 'core_multi_pack_index', so it's only at that
>> point that it could have any impact. This situation would be less
>> confusing if you swapped patches 16 and 17 (and, of course, move the
>> declaration of 'core_multi_pack_index' to patch 17 with a reasonable
>> default value).
>
> You're right that this commit is a bit too aware of the future, but I 
> disagree with the recommendation to change it.
>
> Yes, in this commit there is no possible way that these tests could 
> fail. The point is that patches 17-23 all change behavior if this 
> setting is on, and we want to make sure we do not break at any point 
> along that journey (or in future iterations of the multi-pack-index 
> feature).
>
> With this in mind, I don't think there is a better commit to place 
> these tests.

Of course, as I convert this global config variable into an on-demand 
check as promised [1] this commit seems even more trivial. I'm going to 
squash it with PATCH 17.

[1] 
https://public-inbox.org/git/b5733625-29c8-4317-ff44-d27c2fca11ce@gmail.com/

