Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFB6C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354832AbiD2TWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 15:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiD2TWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 15:22:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537CB0D04
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:19:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o11so6471857qtp.13
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QJ6ilOVHWHxUhqbtHmR3eILtk69rC9HR3jGelNLP4/c=;
        b=dQmn9ZiwGRr+F14GYddbtpF6wCgGOLb2pFaGZ3FjwHcsORP1iXYGoNwmF90aEqRf9m
         XlGkE+gKrQ+dUGQsCjpkM0C98ijdY1onEEFzM/Y9Tfr3jkQljip0chl3C6HGJBspUiIt
         J5Nzc9vUDBfHdUPDlSiPYqHvgfBrwitaeYqr5S9/3Y/M87840y7h97FCWJZjN0XIfrSE
         wh3uX+LaPESFYUVAxQdxlIiqGMpuwSVrLvrMyewzB1VA0V5eH1FVbeEYQczyrc0T/18F
         4n6MPWb35GFhmdQGu2ptZK6sEdNOMU2vR7G/ZkyggnglXlV9/Sop1eTM05sp8Y2bJvat
         nNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QJ6ilOVHWHxUhqbtHmR3eILtk69rC9HR3jGelNLP4/c=;
        b=WC9UeDUzNGbIPcyzu8hFNHTxx6JQncuwJVG+/UYwfJMppHwj3yssb8un6oP/p5+WMg
         GTB7/+UXV8l6BV8pOmbG8eKkrMridLoWncNMY5zqOzq12ynU1qj0MqR1EVcMzIuIrsh4
         5ikKAEFKq8hVkWrJSklXhB8A/vD3O5RqbJQFeoklOxx0OCFvqEOtVZ/oLY/UoXRTBgex
         VRE0GVrSdl++KR/lW0ViLJ39B8h8Oi6L/mxCBRsApPh70jFLVCYuUwkBtRiJMuTey8i3
         K2C2L8lOMbPA4jNJ0V13AiMS5lg1xrrJ983UmMM+UIh0lM+vC3quW4WzthrLAYgyoOVz
         UHhg==
X-Gm-Message-State: AOAM531mNtu2p3yHEJ5WxZ3/3baK6Vf9RuE3xztYrYc0KCXLCdz3/pWS
        UOVMQQiKnmdaj8qzYntW5Yg8
X-Google-Smtp-Source: ABdhPJyxHvvTN0eFT9zdBUj5FW6uqV+ByCSTMaQy7sWTwRYXOXQeywDo6HUc6wx0xTej3PrQvOac+A==
X-Received: by 2002:a05:622a:30a:b0:2f2:4a5:59b1 with SMTP id q10-20020a05622a030a00b002f204a559b1mr853643qtw.546.1651259943245;
        Fri, 29 Apr 2022 12:19:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b433:ef9d:298c:a2c2? ([2600:1700:e72:80a0:b433:ef9d:298c:a2c2])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a140b00b0069fc13ce1dfsm24850qkj.16.2022.04.29.12.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 12:19:03 -0700 (PDT)
Message-ID: <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
Date:   Fri, 29 Apr 2022 15:19:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com> <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g> <20220429190625.GA1626@szeder.dev>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220429190625.GA1626@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/29/2022 3:06 PM, SZEDER Gábor wrote:
> On Fri, Apr 29, 2022 at 10:57:58AM -0700, Junio C Hamano wrote:
>> Derrick Stolee <derrickstolee@github.com> writes:
>>> test_config would do the same, right? I think it automatically
>>> does the test_when_finished for us.
>>
>> I thought it (specifically, anything depends on test_when_finished)
>> has trouble working well from inside a subprocess?
> 
> Yeah, test_config doesn't work in a subshell, because modifying
> the variable holding the cleanup commands won't be visible after
> leaving the subshell, and the protection added in 0968f12a99
> (test-lib-functions: detect test_when_finished in subshell,
> 2015-09-05) will kick in.  And we do need a subshell to set the
> config, because without unsetting GIT_TEST_ASSUME_DIFFERENT_OWNER 'git
> config' would refuse to touch the config file.

Ah yes, of course.
 
> I think something like
> 
>   test_when_finished "(
>         unset GIT_TEST_ASSUME_DIFFERENT_USER &&
>         git config --unset safe.directory
>         )"
> 
> would work, though.

Would it be simpler to use this?

	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory

Thanks,
-Stolee
