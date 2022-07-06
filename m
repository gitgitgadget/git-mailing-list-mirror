Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BACC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 13:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiGFNRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiGFNRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 09:17:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787281EC4A
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 06:17:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so22032909wra.9
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MnwjDPAh+gq6iP80oBXODA4JbIE7jjFKisWtZunrT88=;
        b=Cq27/rYWilUXffzeX+b/NRdMTAGuoEQG4mxkG/pNgIjkO3Ln3IJ5UvMaRwkWY1REe+
         Z0iu69L4uviVut8lO1g6NxPgAM0sKQ37vxZU2y3GFCPrgXtmSpkNUyL/sVLk9grfRNcB
         hG9HsnJYnUwNMgqxBoNzYpyxL2C4OJ6qY88eauUSTgdYyiVW69FSabd8GT3S05WURlMy
         7lJ1lF8k24+0gP+RJY9+XQL5YExoOLUUlAM4GjpXcnpUspNiCJs7itMcnIlavk0ZF3B0
         0xawfaudQV987a06TOu0eHPz9xCAaKURaWzPk4IP64N0eP73CrM0SvEIV9SpE2+TZ7ef
         jM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MnwjDPAh+gq6iP80oBXODA4JbIE7jjFKisWtZunrT88=;
        b=04ZaiunZaX9IxiImHamwl3gT41WtmEg0xcogSU3fUJTACJwPm46jwn22bJbQ8q4Gec
         MVZNEdbdbEuMG4uVhDQ4qI82iWl9oBCbk3v6Vd1o9C+HMsEHC6RaynYEI8avoTpmSfmY
         O/RrZcqQ2LiMXGcB6RGtTQEzX50PAIslAw1TxduL5mfD0EBimINAjDJzhIVMNa7j6zZ5
         aAPfnuYUw/sHY3XvmnKiXAM9nq1R1j0VWdvZCrCIO64k0JYeZSNcuNDO0k77ysbbxnH2
         t6lIVDeQl/Czf0ogDD40vAR0LZiwql7WrS5NXfKAnpUTmCPjqPb0vbyP9z8M5mbj+wad
         ic+g==
X-Gm-Message-State: AJIora9AQVyG/5ZgSEZ1QUZ8Za7DTVpMuDdH7EJIWsQmmkWywadh+19Z
        G9LWB9lwtoAa69AmOiJTXgc=
X-Google-Smtp-Source: AGRyM1vkcLqV0KHcfiUe0HbAyeANjSw9JCKNZDdkFVrDGXLZOqgE01bRmkdPMbNg4Ly+waa724CMDQ==
X-Received: by 2002:a5d:64ae:0:b0:21b:b923:7ad5 with SMTP id m14-20020a5d64ae000000b0021bb9237ad5mr35991011wrp.460.1657113438952;
        Wed, 06 Jul 2022 06:17:18 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05600c1e1d00b003a03be171b1sm23892153wmb.43.2022.07.06.06.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 06:17:18 -0700 (PDT)
Message-ID: <114180f5-8c54-b6e1-14d1-4ad1a9666358@gmail.com>
Date:   Wed, 6 Jul 2022 14:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] xdiff: introduce XDL_CALLOC_ARRAY()
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <8bead9856be7b39d3d03f688f53d678832d60109.1656516334.git.gitgitgadget@gmail.com>
 <xmqqy1xednht.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy1xednht.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 30/06/2022 19:17, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
>> index 9fd3c5da91a..23db8e785d7 100644
>> --- a/xdiff/xmacros.h
>> +++ b/xdiff/xmacros.h
>> @@ -55,4 +55,10 @@ do { \
>>   		? xdl_malloc((nr) * sizeof(*(p)))	\
>>   		: NULL)
>>   
>> +/* Allocate an array of nr zeroed out elements, returns NULL on failure */
>> +#define XDL_CALLOC_ARRAY(p, nr)				\
>> +	(XDL_ALLOC_ARRAY((p), (nr))			\
>> +		? memset((p), 0, (nr) * sizeof(*(p)))	\
>> +		: NULL)
>> +
> 
> This implementation is somewhat dissapointing.  Allocating and then
> clearing is conceptually different from allocating an already
> cleared buffer.
> 
> Wouldn't it make more sense to build on top of xcalloc() or its
> counterpart in xdl world by introducing xdl_calloc()?  For that,
> this step would probably need to become two patches.  The first
> patch introduces xdl_calloc(), which uses xcalloc() in our codebase,
> and turn the existing "alloc and clear" code to use it, and the
> second patch would wrap the use of xdl_calloc() in the size-safe
> macro XDL_CALLOC_ARRAY().

I was hoping to avoid that by following the existing pattern of malloc() 
+ memset() but I'll reroll with a preparatory patch that converts the 
existing code to use xdl_calloc()

Best Wishes

Phillip

