Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9DA1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756395AbeFOS4q (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:56:46 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35566 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756347AbeFOS4q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:56:46 -0400
Received: by mail-qk0-f195.google.com with SMTP id d130-v6so6201764qkc.2
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZTh3KPxIQXL+B9hwDrR+jzyoGZSI/Hp6aq/OhnL6f8U=;
        b=VkshI5zX573cADJ1rrrcQ6pPHx5LgoKfNRNVS4OIE+VicnfKx6+G88qt03XAxKQFeD
         hQd0Cayf6xHR9Z9PhyepU+NhBV2DqTLXEbgZ7+4jx7mwP4lGACXs1onHLot1cr0XmfWP
         wp5KP7tAElbr1LFQcIW3p+J/Sct9TA7tCStDaJOmjX/6g6icm3HWcY4OH2fxupsMstbb
         lDuPK5IgWxdZpRXPCiMi60SbF+VSWgj/pTLKCer5KtWFTPXhwLuUDAY7iutjaOkADybf
         0ZrWjyO4d1nLewAfhNTxFVPxtG+hRXNta9UU5kIvZysPzKZL+f1xN3VG3PGTon0BLFBZ
         hRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZTh3KPxIQXL+B9hwDrR+jzyoGZSI/Hp6aq/OhnL6f8U=;
        b=VOpfaS8cS7lG6xLWPNUvhGgD0MoU3zoGden3NoCWiYMJr5FPh0fQUNxeWhMdsWssBc
         IDO0nVq7o6WXSYzTuAXYU2it+b7M6SmCI26qZ5SGxdahn/G6zIiM/ioiifV2Ujlc6oM8
         dR+b7FJifC+hRb3s7IMjlAvS/lddwW2KOB/nc9msi4mKjw2Pt8T6jt1HNdAZotozP3j2
         Kd6krm2aFcRtbccsVGuhTABbszFgnCVInKWFZI9mU1PsRbRVYiuC0PxhOspZUXjqRPkp
         J+GuHqcRQfdUwg9cT2+RIIkWhnzShAD7VCoF3Ral4ddWhTbBLMWWjh6jZN28st8pzHMD
         tSXg==
X-Gm-Message-State: APt69E0B0N6y68W0W0clV9RBzn6yGbqbSDyeKgjuT+IR+QrCMY242epD
        xhnd5TkOJpZJDuX3BzM+0W8+tMCj
X-Google-Smtp-Source: ADUXVKJkVip8NwRtTBXBi3MjGOGOQiCgtCvXmcsQPQpNKFyf0JPaWfZzrYYv5QeRNyGou/cNlmhQ8A==
X-Received: by 2002:a37:350a:: with SMTP id c10-v6mr2383011qka.388.1529089005173;
        Fri, 15 Jun 2018 11:56:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id m16-v6sm4983035qtn.92.2018.06.15.11.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 11:56:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Delete unused methods in EWAH bitmap
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "ramsay@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>
References: <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615182727.172075-1-dstolee@microsoft.com>
 <xmqq1sd7288z.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee8a1b8f-d14e-218c-3bdf-82908fefbec0@gmail.com>
Date:   Fri, 15 Jun 2018 14:56:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sd7288z.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2018 2:51 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The EWAH bitmap code includes several logical operations that are
>> important for a general-purpose bitmap library. However, Git only
>> uses the XOR operation for storing deltas between reachability
>> bitmaps. This means that we can delete the following unused methods:
>>
>> * ewah_and()
>> * ewah_and_not()
>> * ewah_not()
>> * ewah_or()
>> * ewah_serialize()
>>
>> We can also delete the unused methods bitmap_clear() and
>> bitmap_each_bit().
>>
>> Derrick Stolee (7):
>>    ewah/bitmap.c: delete unused 'bitmap_clear()'
>>    ewah/bitmap.c: delete unused 'bitmap_each_bit()'
>>    ewah_bitmap: delete unused 'ewah_and()'
>>    ewah_bitmap: delete unused 'ewah_and_not()'
>>    ewah_bitmap: delete unused 'ewah_not()'
>>    ewah_bitmap: delete unused 'ewah_or()'
>>    ewah_io: delete unused 'ewah_serialize()'
>>
>>   ewah/bitmap.c      |  32 -------
>>   ewah/ewah_bitmap.c | 229 ---------------------------------------------
>>   ewah/ewah_io.c     |  10 --
>>   ewah/ewok.h        |  25 -----
>>   4 files changed, 296 deletions(-)
>>
>>
>> base-commit: fc54c1af3ec09bab8b8ea09768c2da4069b7f53e
> Thanks.
>
> ewah_clear() can become file-scope static, and
> rlwit_discharge_empty() can be eliminated.  I do not know if either
> is worth doing, though.

With Peff's patches, this is true. When I applied your diff to my patch 
alone we could not do that.

If you want to create a commit with the below, I'm happy to add my 
"Reviewed-by: Derrick Stolee <dstolee@microsoft.com>"

Good team effort today!

>
>   ewah/ewah_bitmap.c | 20 ++++++++++++--------
>   ewah/ewah_rlw.c    |  8 --------
>   ewah/ewok.h        |  6 ------
>   ewah/ewok_rlw.h    |  1 -
>   4 files changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 017c677f98..d59b1afe3d 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -276,6 +276,18 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
>   	}
>   }
>   
> +/**
> + * Clear all the bits in the bitmap. Does not free or resize
> + * memory.
> + */
> +static void ewah_clear(struct ewah_bitmap *self)
> +{
> +	self->buffer_size = 1;
> +	self->buffer[0] = 0;
> +	self->bit_size = 0;
> +	self->rlw = self->buffer;
> +}
> +
>   struct ewah_bitmap *ewah_new(void)
>   {
>   	struct ewah_bitmap *self;
> @@ -288,14 +300,6 @@ struct ewah_bitmap *ewah_new(void)
>   	return self;
>   }
>   
> -void ewah_clear(struct ewah_bitmap *self)
> -{
> -	self->buffer_size = 1;
> -	self->buffer[0] = 0;
> -	self->bit_size = 0;
> -	self->rlw = self->buffer;
> -}
> -
>   void ewah_free(struct ewah_bitmap *self)
>   {
>   	if (!self)
> diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
> index b9643b7d0f..5093d43e2f 100644
> --- a/ewah/ewah_rlw.c
> +++ b/ewah/ewah_rlw.c
> @@ -104,11 +104,3 @@ size_t rlwit_discharge(
>   
>   	return index;
>   }
> -
> -void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out)
> -{
> -	while (rlwit_word_size(it) > 0) {
> -		ewah_add_empty_words(out, 0, rlwit_word_size(it));
> -		rlwit_discard_first_words(it, rlwit_word_size(it));
> -	}
> -}
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 0c504f28e2..84b2a29faa 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -72,12 +72,6 @@ void ewah_pool_free(struct ewah_bitmap *self);
>    */
>   struct ewah_bitmap *ewah_new(void);
>   
> -/**
> - * Clear all the bits in the bitmap. Does not free or resize
> - * memory.
> - */
> -void ewah_clear(struct ewah_bitmap *self);
> -
>   /**
>    * Free all the memory of the bitmap
>    */
> diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
> index bb3c6ff7e0..7cdfdd0c02 100644
> --- a/ewah/ewok_rlw.h
> +++ b/ewah/ewok_rlw.h
> @@ -98,7 +98,6 @@ void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *bitmap);
>   void rlwit_discard_first_words(struct rlw_iterator *it, size_t x);
>   size_t rlwit_discharge(
>   	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate);
> -void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out);
>   
>   static inline size_t rlwit_word_size(struct rlw_iterator *it)
>   {
>
>

