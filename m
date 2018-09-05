Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DD51F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIFAAF (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 20:00:05 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37629 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeIFAAF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 20:00:05 -0400
Received: by mail-qt0-f179.google.com with SMTP id n6-v6so9499772qtl.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CBLRM92ETcd7B+Pp+ubuH5iUZFNwudEN2TdvKAoKTAY=;
        b=cHaBEJVYsqjzPXIK/2xl/ncQgeHAAUQ1Ze1CCRhELH25kMkqA5kVzsybXlarEQERX2
         kbVO5CSo5eEAnabCcjxNe20vbiIETT3Qcf/HhnLza5gr9fAW29ZBQs7j2K7PoS9X1INg
         346tMmP8H0giBh09M4wQO+eoEZ/Av4CJWFfQpFNLIURL242ookJe8UR1wblUCTwYYWMo
         dBKtm4nmvX5SAs7I1WU6j0bRczpnTTFHvvlnDoKU/S49qEkjRLMABrJ0TpwhGIDflyYa
         yD93tYXV2K0w669qHG8KxAFGSGUIKR0lO0SBc0AgaiWqYPoG5eYCDFbmf87RNc1ssnbt
         O4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CBLRM92ETcd7B+Pp+ubuH5iUZFNwudEN2TdvKAoKTAY=;
        b=t9efjrPVYo21cTovJ8jJgZ9o8m/5JgiHx+2zWp8Qo+evDqv/OTrzLPp8sCVFkph4ds
         UaRVTCVY1CfOm2RnKqj8sKToWqGogE+wV/HiCFI0qCwmWAX9wtlIARbjM0QpDqxlAj13
         DgImqdnnsbfHNP3dSlX6BWsVxUqwIC1yZMVSX5UyF7GuagRZXS+yJkzuNjSMQoNT/hA6
         9tt2cwHnbVsSKxu+SHiSMqM1ZXvG7c7eJ1h2eP02CMwtODrWcPyAZWpt6gQ2F1wACLAU
         Nk/QV4ySYURW8/baRIJjWJueKcuFsaYjJGdH1ZlT+BD19RuHPd7Umt8L5C0OOJnOGVXZ
         aVwA==
X-Gm-Message-State: APzg51BDtjLoDuoam44UqxsDYe6oTo3Fm1FfSUzVDmcVElpsN/jBCM8U
        SUZJwsjtmE+vdFIBOgibSjk=
X-Google-Smtp-Source: ANB0Vda1REGKVyvTxnbLGVneLhdAXwo3FB+i91m27uURWCCLTgbPW7BsrbjRukC8eiJAW+gpG1P2jQ==
X-Received: by 2002:a0c:aed9:: with SMTP id n25-v6mr34395215qvd.10.1536175708712;
        Wed, 05 Sep 2018 12:28:28 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r20-v6sm1663125qtc.81.2018.09.05.12.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:28:27 -0700 (PDT)
Subject: Re: [PATCH 04/11] multi-pack-index: verify packname order
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.34.git.gitgitgadget@gmail.com>
 <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
 <CAGZ79kY7_RJfJomkpob85A4ubvXJt3BR8njkaozLgi-6ytxB9w@mail.gmail.com>
 <da7eaf92-57f6-8129-149d-4260d84b4eb0@gmail.com>
 <CAGZ79kZHmCyRLur=DgLx2sHhD1hCXn3pU+0CggwFQgWRzTkp5A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e09aa8e6-26fa-68b5-b4d1-1322b09e7974@gmail.com>
Date:   Wed, 5 Sep 2018 15:28:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZHmCyRLur=DgLx2sHhD1hCXn3pU+0CggwFQgWRzTkp5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2018 3:14 PM, Stefan Beller wrote:
> On Wed, Sep 5, 2018 at 12:11 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 9/5/2018 2:15 PM, Stefan Beller wrote:
>>> On Wed, Sep 5, 2018 at 7:46 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>>
>>>> The final check we make while loading a multi-pack-index is that
>>>> the packfile names are in lexicographical order. Make this error
>>>> be a die() instead.
>>> What is the advantage of having a die() here?
>>> Would the midx work under normal operation when
>>> not sorted correctly?
>>>
>>> This sounds like a hack for easy testability in this context,
>>> so could you clarify why this helps the regular user?
>> The multi-pack-index will not work as expected, since
>> midx_contains_pack() may provide incorrect results, and thus we will add
>> the "missing" packfiles to the packed_git linked list.
>>
>> This _should_ be a die(), as something unexpected occurred (the file
>> doesn't match the format specification).
> Thanks for the clarification.
>
> So this patch actually hits 2 birds with one stone, as it fixes
> a bug as well as adds the check for such corruption to the
> verify step?
This is a common occurrence in this series (replacing error() with 
die()) as we are now exercising those conditions and clarifying what 
should happen.
