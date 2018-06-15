Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97F51F403
	for <e@80x24.org>; Fri, 15 Jun 2018 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936277AbeFOPLL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 11:11:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41321 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFOPLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 11:11:10 -0400
Received: by mail-qk0-f195.google.com with SMTP id w23-v6so5775082qkb.8
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7rAtIv4OrBpUVR0YMHwKAthaBCSXyDQNWH2/4NoKfEU=;
        b=cm6xwhLHded7xKaAHCEgCqzL+N1tPCEzthpNGFp28+KmTLQre2mJesVwPH31eoNmkm
         Q5oCIhaYjtUkeTkrIryH/X7/XoC0X5s9FO7KzcAKSDQyyw96l04T8l79K+bhON8v226L
         6tXzr/Y2S45KAsuBdPUqUKgKb9ThFAXEYyw4iE8XyHN3oEeXjGNOGmZUcpt4SPzg+754
         WHiZmaoGjGLykJ2IqoaNo0av3kGI6S0IDvopP5/QXX/r6LWhrTyzFCkxrRSDyViDB/Ep
         JAtDU98oGcoCTFKBwv9cN3EaVIRQw2r4wC9FIKZ/0YpXJZnN1KfXJCKnkLraIfV9h3ZB
         mg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7rAtIv4OrBpUVR0YMHwKAthaBCSXyDQNWH2/4NoKfEU=;
        b=GJSyQ+22IT30hFE7O0vzECReVQ5jV9U7P6h9m9EPaZeckESFiyvkocwG7RPSekqxK8
         weKGNiLH3DTb4GhG58j5rCx9dws8OjrDYd/yAImw1YBF3+8sH+g8gS0DxDvLAnKpbqh7
         zkv6EH4uRJK6oVde/P8k/S82zF64rpHoVrB/v0ucMX/Yq+fwJRn84gSWU9dX5P+IHbKS
         N9CLvA05hBSdJmfZi7MMYKA+86SNs/GyXMcFe8L1Fl1CoumsF684DShzfmSbe1IiA/e3
         FBcRJTmg+elBbo03PwfJxtyMn6G/t66N4UM1tiNwB2W/8pMPSuoLDe+Gj95kGRHIAE6v
         yy9g==
X-Gm-Message-State: APt69E3RcTjiXhNgw36eMfOqAr2uyowNTvB8Z4Y70fCMCm6gIqjU/2PN
        auI5zVXj9qN+WgbGjiK2USI=
X-Google-Smtp-Source: ADUXVKK5FxHsZsoanwoAdR6TkuMrQpaMlQPKhp2l7dMR28i6IXG1ed+GWXc44L/Ogk/vS/mcGDV0PA==
X-Received: by 2002:a37:5842:: with SMTP id m63-v6mr1651552qkb.250.1529075470248;
        Fri, 15 Jun 2018 08:11:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id s15-v6sm6264177qtc.81.2018.06.15.08.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 08:11:09 -0700 (PDT)
Subject: Re: [PATCH 1/8] ewah/bitmap.c: delete unused 'bitmap_clear()'
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615143018.170686-2-dstolee@microsoft.com>
 <f95526b3-0f4f-ccf7-1c31-e7f48a00d1e2@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <93cbfe90-701c-b2c0-b4fc-c3c5036f90f2@gmail.com>
Date:   Fri, 15 Jun 2018 11:11:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f95526b3-0f4f-ccf7-1c31-e7f48a00d1e2@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 10:46 AM, Ramsay Jones wrote:
>
> On 15/06/18 15:30, Derrick Stolee wrote:
>> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   ewah/bitmap.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
>> index 756bdd050e..d61dc6114a 100644
>> --- a/ewah/bitmap.c
>> +++ b/ewah/bitmap.c
>> @@ -45,14 +45,6 @@ void bitmap_set(struct bitmap *self, size_t pos)
>>   	self->words[block] |= EWAH_MASK(pos);
>>   }
>>   
>> -void bitmap_clear(struct bitmap *self, size_t pos)
>> -{
>> -	size_t block = EWAH_BLOCK(pos);
>> -
>> -	if (block < self->word_alloc)
>> -		self->words[block] &= ~EWAH_MASK(pos);
>> -}
>> -
>>   int bitmap_get(struct bitmap *self, size_t pos)
>>   {
>>   	size_t block = EWAH_BLOCK(pos);
>>
> I haven't read all the patches yet, but what about the extern
> declaration in ewah/ewok.h?

Thanks! I'll get that, too.
