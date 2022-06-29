Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA61C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiF2Jb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiF2Jb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 05:31:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76439BAB
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:31:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ge10so31347500ejb.7
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IUErsV6J1C9I+PDWeNx1CAGFl/Ri7N8vwXnXZyBPGU=;
        b=T8rP4pguyhW+5HjceWVbaOr+exZGwMlzdt+Nft0yh89ZUBYWYPcsHzBytrNVACPwO6
         aU3RiKnGIbiNrdpRWRhig8CSl1RsW3tRhOfP18SJx8pzFTgGKyNioP8ujvH7/9xMPmtS
         xtc+Q/JhKM3M8ESenxbfIOxdhIMc5caLQDJM+pzU8IAdKwaqrxnDJ+/IUDmhLpKRX4xU
         YCf+/W3vmcbgBPWXUcjvaUg+DBqG2bJH4EV86iABzh4+PV/X3S14ByCb8hbHEI+PWjOR
         A5P+l9UY7QQhpPAr/w3ql/pxXXZkhfuLl8tc7p6lixoezsGp/YbrGBkIrFEi4lkw8H96
         zTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+IUErsV6J1C9I+PDWeNx1CAGFl/Ri7N8vwXnXZyBPGU=;
        b=oiTKsMmGTG0TPHOW4qvK+B7QaBIyOS0P6XlvynrWMPHI86svMme22O/dhgtdhDgFgM
         Qtm1gIC1p99dIc1kevQeu55+n0Vd3asnT4UiYbAG9/xiDjnPgfVRKMW5VI56JkgrHMp5
         d3+kh89cdQ5Pm0ncm3TL71YQPL0DUaBKdJr3uE0lxkliHRy+DXd9KIVeDxVU8O6gWs6G
         UjqQKD/vBSOc9CK4qIPKfYZNQ7Sb1lmaRZwP9ow49npgnuiwRggybOj2qlXyJCumK9tt
         fNrd7QXlQ5FF4Mx9WhDE09PtQiDoIEB0fIwJlXIY4SgSmp5pTD5xMTD5segX6KN7a6SW
         rW9Q==
X-Gm-Message-State: AJIora8AMY/cMCwyApR7yCjlLQBfRwBIYVWklkECy7+u9VEC0Vhf45zz
        QF0sAXPbMwHf9vcWW5MBtF8=
X-Google-Smtp-Source: AGRyM1vdsZJmmhWgVPvrat44TOLvE5HHhCsyI1D8tu1rLkwqg6/nI6D91q2ThL9+RmtcFOiFPM+q6A==
X-Received: by 2002:a17:907:7e86:b0:726:2a6b:1623 with SMTP id qb6-20020a1709077e8600b007262a6b1623mr2316988ejc.706.1656495084250;
        Wed, 29 Jun 2022 02:31:24 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906068500b00703671ebe65sm7409085ejb.198.2022.06.29.02.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:31:23 -0700 (PDT)
Message-ID: <6f229f4d-8ce8-beb5-e27c-2ea244a634a7@gmail.com>
Date:   Wed, 29 Jun 2022 10:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] git-rebase.txt: use back-ticks consistently
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
 <pull.1270.v2.git.1656446577611.gitgitgadget@gmail.com>
 <xmqqwnd0h30t.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqwnd0h30t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 22:49, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -537,7 +539,7 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>>   -x <cmd>::
>>   --exec <cmd>::
>>   	Append "exec <cmd>" after each line creating a commit in the
> 
> I thought `exec <cmd>` was an improvement, just like ...

I'm not so sure, I thought we normally reserved backticks for command 
line options and this is talking about what gets added to the todo-list. 
I could see "exec `<cmd>`" being an improvement though. There are 
several other mentions of todo list commands in the documentation and I 
think they are all double quoted like this one.

Best Wishes

Phillip

>> -If `--autosquash` is used, "exec" lines will not be appended for
>> +If `--autosquash` is used, `exec` lines will not be appended for
> 
> ... this is?
> 
> Other than that, looking good.
> 
> Thanks.
