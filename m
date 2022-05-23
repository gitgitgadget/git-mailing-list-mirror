Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E024BC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiEWSuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiEWSui (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:50:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B107A5A82
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:35:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l82so8751687qke.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TpdgH2vI94/jzWMlDAwAzWBfqJYIEmQ5LUm7y2PGhAI=;
        b=KjkCfR6usFK7YaeM2Svkhv9Ov0G1YJZRJ7MD7iAEmAZ2yRWh1fEr5XW6gfiFyhXi4P
         tF8TKmxMaFx8aqkyQeA8fgrfyy4C2grjFEg4iCkVtg94fLs7PAin4rcAnVH22oQhYXFK
         Jw5L/xPvfwhzSdCn3NI8c+HS374gafGCVNOawv7N6Rkoy9k2PmQifc/TYsDBmYexJu07
         h8DpWzOnSRobS1Vstqpe4ri6wkxXJn54aotXJWlDfo7BfhPH7DzZaebotzAcrXkf9gzz
         HOVbJCzkifoFqfG+HnFACaUmrs1fFZ40jf0wb9hW8HjUNmlG5SP8hYIDzugvPwd6NXpB
         7KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TpdgH2vI94/jzWMlDAwAzWBfqJYIEmQ5LUm7y2PGhAI=;
        b=HWUhkcEeasjlGA2JWKvzBkS0XllZbcGVhDDjTUDHRgoJBqVtMknGdhZdGnbUBX/j8b
         R9fniBDWOEUBjfaXM6rB+KNbhTmgUBb4FW7alH8XlLrmM9pUFY4BV+Y2e97yRfjxT+10
         gQZaJv3sVY5XGet79tUUB2uEHIVbBCvRRvNBlqZZUoSJ9HdafJ0dCdJsWU6Csta9uOLM
         jBNrcXA1lX6psHBj7W5Nr8kVKgPwcoOAN2BldeLroO8Qef30wgVNQV8ccazpIZ7a+huy
         xO2gbmPOgV58WJl7Ad5Dp0MoYs8gUtNhy8QOhGBirYZqFJnf16LXkHANh7gzexADTg9E
         tXbA==
X-Gm-Message-State: AOAM530/ChVq/oPg6Nt8ZExbQ+N46bc9bOPeceuD33MTjOhvPG7Gn4FU
        Phbsdg34t6YS/lK673r/YRvw
X-Google-Smtp-Source: ABdhPJylU14mEmFB2Css6ZlGzgPJnsEpFrCPlQMkDO9MMeZzUcn0OV5qVSaAVvFzvCN7T9AVP0tpeQ==
X-Received: by 2002:ae9:c20a:0:b0:6a3:25c7:e6d5 with SMTP id j10-20020ae9c20a000000b006a325c7e6d5mr14400253qkg.760.1653330921848;
        Mon, 23 May 2022 11:35:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:71ba:8ad9:40cd:d364? ([2600:1700:e72:80a0:71ba:8ad9:40cd:d364])
        by smtp.gmail.com with ESMTPSA id y11-20020ac8708b000000b002f3d0e07693sm4704150qto.88.2022.05.23.11.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:35:21 -0700 (PDT)
Message-ID: <555356a1-147c-71d1-ebab-f3151e37a960@github.com>
Date:   Mon, 23 May 2022 14:35:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] Add pcre2 support for cmake build system.
Content-Language: en-US
To:     Yuyi Wang <Strawberry_Str@hotmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
References: <xmqq1qwqts6w.fsf@gitster.g>
 <OSYP286MB02627C53ECF2C03B397556E3F8D09@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <OSYP286MB02627C53ECF2C03B397556E3F8D09@OSYP286MB0262.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/22 12:18 PM, Yuyi Wang wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Is this "small fix to ensure it builds successfully"?  To those who
>> do not need/want to use pcre2, is this hunk still needed to "build
>> successfully", or is this something that becomes necessary only
>> because we have other hunks in this patch to add support to pcre2?
>>
>> If the former, then perhaps the change deserves to be its own patch
>> with own explanation why it is necessary, what breaks without it,
>> etc.
> 
> There are 2 fixes. They are all needed no matter pcre2 is wanted. I'm
> rather surprised that no one has noticed the CMakeLists.txt is broken.
> 
>> @@ -54,7 +54,7 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>>  
>>  option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
>>  if(NOT WIN32)
>> -	set(USE_VCPKG OFF CACHE BOOL FORCE)
>> +	set(USE_VCPKG OFF CACHE BOOL "" FORCE)
>>  endif()
>>  
>>  if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
> 
> This is the first fix. The original line didn't follow the grammar
> of `set`, and would simply fail.
> 
>> @@ -277,7 +287,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>>  
>>  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
>>  	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
>> -	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c)
>> +	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
>>  endif()
>>  
>>  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
> 
> This is the second fix, to solve the linkage error on Linux.
> 
> You're right, Junio. These fixes should be their own patch.
> Should I remove them? They are still small fixes, I think,
> and could I submit the two together in a new patch?

You can rewrite your branch history to have two commits, force
push your branch, and the GGG pull request will then have two
commits. This will translate to two patches (along with a
cover letter) when you "/submit" again.

Here are some links that might help you in this process:

[1] https://www.youtube.com/watch?v=4qLtKx9S9a8
[2] https://render.com/blog/git-organized-a-better-git-flow

Thanks,
-Stolee
