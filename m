Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F232C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 14:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380715AbiEEOiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbiEEOiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 10:38:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911A5AA57
        for <git@vger.kernel.org>; Thu,  5 May 2022 07:34:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so6377567wrb.6
        for <git@vger.kernel.org>; Thu, 05 May 2022 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxXeNUNPT2iJXtlrUCNWdYGywA9T3pW+S9QocYt/qzY=;
        b=jEsVhpwStntOe2d475kKCsy34rPyDozLHSGp/47mb2hUVBdA2nRKPb0njyK32EGgFd
         8AiZNFsoopYzy9zz+djtwHTnvziV+ZghhVzdvk4bSHUA+vOFnzxFhIxlpo1ey9hi6x29
         4smtJN/MpMg2gbYBKrHVP5B2YrYjW5OUdQFoUp3CRrd5G9yrA2qaAlO3mk/joKJscbLR
         TOSimo9KnNcXlmmFZNfj4M1ynjuhxoukyTmGyijAE5EaIgsde8Wuhv6RYip98wzg1gWA
         gwWwlG1lEdJreElQfTCKdYRIfaMbud2wOjkKH4Q8Zgu4K5OvOxYdbalIfrNKU5/0G9MI
         Ejqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxXeNUNPT2iJXtlrUCNWdYGywA9T3pW+S9QocYt/qzY=;
        b=m5J48qHzNNqJfvdCG/HBINDZoOclAd+HX7fkHCR9sOHS6dnf3xi2IODpfsd/rgQ8ZW
         R9jUDEfMbSBRyg880oigqNKOXaoqVrg4vzxUs7V4rBqdS6YEu06BICo3uapi0j3wXC7b
         tgTYA1U34Uodnu2vJlAH06aB1GIWNjUWpmuTU9zqUF/RTT1wYFFswiScPUdsI7uV5066
         b5PX69pvNItdqGHNHkeRqU9IbFyEXaDq3fWEBAU5etu8EUGN3XEgrU4INkZXn/wmQ4wN
         4K1DN+SQoukyn667BiImf1I2Q4q3LTwdAWBn90eB9ANMEnXqShgL6c5GLdO6CKZMi9dK
         FA+w==
X-Gm-Message-State: AOAM533GE5/hWuPP835XiDI3nRdAOgxAc24eff5yAfUJLUM0njnEa2H6
        eEzfJORevizNm4kAw5SCUz6cHvRVw8w=
X-Google-Smtp-Source: ABdhPJyeUjyLdlnPxhKYhevNicjWZUqI32BA01v1Iu64+hT4kjn41mnj69QyxoGTyjD+VsUDFc5vgQ==
X-Received: by 2002:a5d:56c8:0:b0:20a:d4a1:94de with SMTP id m8-20020a5d56c8000000b0020ad4a194demr20703181wrw.268.1651761281095;
        Thu, 05 May 2022 07:34:41 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id x18-20020adfdd92000000b0020c5253d915sm1324511wrl.97.2022.05.05.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 07:34:40 -0700 (PDT)
Message-ID: <06d8719c-1732-c40f-61ec-e010f208cb5d@gmail.com>
Date:   Thu, 5 May 2022 15:34:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 05/05/2022 14:44, Johannes Schindelin wrote:
>> A new SUDO prerequisite is provided that does some sanity checking
>> to make sure the sudo command that will be used allows for passwordless
>> execution as root and doesn't mess with git execution paths, but
>> otherwise additional work will be required to ensure additional
>> commands behave as expected and that will be addressed in a later patch.
>>
>> Most of those characteristics make this test mostly suitable only for
>> CI, but it could be executed locally if special care is taken to provide
>> for some of them in the local configuration and maybe making use of the
>> sudo credential cache by first invoking sudo, entering your password if
>> needed, and then invoking the test by doing:
>>
>>    $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh
> 
> Hmm. I would like to suggest that we can side-step all of these issues
> (and the ones I outline below) by considering a similar approach to the
> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
> variables to pretend the exact scenario we want to test for.

That's an excellent suggestion. Trying to use sudo in the tests leads to 
all sorts of issues, if we can use a GIT_TEST_* approach instead that 
would be much better.

Best Wishes

Phillip
