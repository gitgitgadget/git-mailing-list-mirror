Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E9C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiAKLCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbiAKLCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:02:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A78C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:01:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so1563385wme.4
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YiDllnMxRN8vN6jps3Jqf5+QqjqRSgs6hBNkredewDQ=;
        b=HpnfGTA9qqW5yH0QG+e9lD3jl1LnLktWjJWiTUjXEKPBzj/ER7x1Nw53atLEt0mUf3
         OoYyi+gCOSfIjAA2M3gqjCbRJx+fXh0pstgmjb/dDPIiFZOB5u44fjb3a4wBQo8MFdVo
         RGnUrmmXJO3PU6ASiS35Vo7qO7WU6gsRFEPjqdeID6Ozbeu9wYUbOD0GCG7VzsDFwD4f
         umMITGPPAx45Cq23LQbylzUPt8hLUdTJx7aqNL3mJ1TGBHYGMmHZQ1mhCPJZSVDEVK5C
         Zv8IPdlOzgwOg83Qd69hJFv4Egw/HWEAFLI5hZTToKUH1t+8DWTvIwMkXQxIjsVQ1yFu
         NxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YiDllnMxRN8vN6jps3Jqf5+QqjqRSgs6hBNkredewDQ=;
        b=dhTDL+WDAw7NYh+uM+EzX4QhlWbN9vZQJP1qqXnsO4BQV/PTT/e6ZsQ8fQl+UUQAMo
         dtuafLCKcFDAVNOcuYCm6YYrCILjRhuozRklcF52NVaLdbNnZQt34VV4rQiJA2LLx8D2
         mxfF+a5hC1BtgZhjcCYlTuuzBGOgk9WGg1h6biz3lvWOb/LzQj0lSFYq7BEgfxGtofmN
         mlucoBsBw4SPTZxT5gGK6MxOMJ+wpN9j4K9NXtWcbyD7jhJXCMqtJsxKAPXW0/ie1tzm
         D60ZvgT+ykReEm/CcrqoK6Bz2WcY9CfMTF/zVN3kEfVrhpOoJvuR8EXh+mend9UkFMDo
         qmUA==
X-Gm-Message-State: AOAM532n2VGPOGGKTPIb1RulY+AFBMX3wvmQlNj+wdclu0ip6Q2FBESB
        rdw4aSWBNOq5+X3z6qVeCXw=
X-Google-Smtp-Source: ABdhPJx0FPZ7FzBVdewvFes1cjowL9igh77sXwXnWoGJBbPeIfPB0Nx9AyMQrHoYS3+2M9WYhkvAgg==
X-Received: by 2002:a1c:c917:: with SMTP id f23mr2027633wmb.10.1641898918315;
        Tue, 11 Jan 2022 03:01:58 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id t7sm1423221wmq.42.2022.01.11.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 03:01:57 -0800 (PST)
Message-ID: <8d07e92e-b63a-6be4-6999-79c36ca07cb5@gmail.com>
Date:   Tue, 11 Jan 2022 11:01:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
 <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
 <153f69ea9b6cfc3fff47c91fa237cf97efd6bfae.1641425372.git.gitgitgadget@gmail.com>
 <56FFAD1E-D081-4D13-A12E-DD6807375B69@gmail.com> <xmqqo84j1oel.fsf@gitster.g>
 <A869C5DC-98D0-4093-90ED-5F7933041968@gmail.com> <xmqqo84jz9qf.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo84jz9qf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01/2022 19:11, Junio C Hamano wrote:
> John Cai <johncai86@gmail.com> writes:
> 
>>> As I said, my mention of hidden vs non-hidden was not my preferrence
>>> of non-hidden over hidden, but was soliciting opinions from others,
>>> so I was a bit surprised to see a reroll to change only that thing
>>> and nothing else so soon.
>>>
>>> But if it is your preference to leave it unhidden for now, that is
>>> fine as well.  I have no strong preference over the matter either
>>> way.
>>
>> I think it makes sense in this first iteration to keep it
>> non-hidden for visibility purposes.  Maybe in the next release we
>> can make it hidden before we move it altogether.
> 
> I think that is a sensible way forward.

I agree

Thanks

Phillip

