Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029AC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 18:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiHRSMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiHRSMG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 14:12:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FFC7425
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:12:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 20so2152426plo.10
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SEwNQJS+8SVIH72lE+8Pe1Vl9zmrQIUI/h8VFURcXm8=;
        b=VF2M+UuXwmU4SuUvsbDpWdrH6aFyTPEZN5iuNcXIm4KrafhflrsxCi9UqiE9U2Jgd6
         36+Be51JFK4O7/l8Uq7L94GRiLOrlna+6P/ZjXTkC8xA9ytR09uCTysaPYnccOtdes0I
         f0cLcV8DnStki7PtjnOisHfcBvCWwMFjLCGe6m2j+bui7Df8QJLftaf58Va05rVIJ+78
         CXMh0zSdQIOJbr86FdrMWrelQbmXwJyi+D4Pla8V9tDUyJsJAdphUaETpH4vB7sINl8Z
         7rxCBL+N/n9LothZajiMLFjsjigCB4StxNdovxOf1K0X5XS4bmIyVG6CyaM48B1WcrAX
         hD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SEwNQJS+8SVIH72lE+8Pe1Vl9zmrQIUI/h8VFURcXm8=;
        b=XQ4owH67pouCrnjtRGaIoucz2N2LWtiTumawovG7sUh2fDfQE22lj7IA0MwQBzDDrq
         +l4mFHyDHTf+ZdsloiQcLVcuG297aibk8Ip3N+LGxzNkKOZkzfZxNM3gYwZ5OdHa9Cvu
         z4WfeYWBSC/xBbbWHECB4no3/LCq8Sn03mns2P71512HVFktGtPr9MmOYZnthjKLTuVh
         ryRK6ek7L2cTfV5KZb4DeGvwvtDwpJ86p6vQU9YlJeJIBWmeDnt21x3WISZ+r4HEJLsL
         fCn2cjMHxqAbERasOSI4lRDryWMpcetTirQ2B5/I1CfNZEhmH/pXd+lrdVQMTQq4CqIy
         U+8g==
X-Gm-Message-State: ACgBeo1KJ68P4akiYe5qSdwK0nyFkhfjcoOP1ApF6i8wA3bZ536XjhFa
        wNqqfxZ5EMpWyAyX29TDiVYF
X-Google-Smtp-Source: AA6agR7JQ/C4DK7GoqMUpX0tjdl34by3Pas3Y8mfJaSvKTQAFQ8gjIyNyYt9JXCgWgyfZ9xCd2qNrQ==
X-Received: by 2002:a17:90a:d585:b0:1f4:f9a5:22a9 with SMTP id v5-20020a17090ad58500b001f4f9a522a9mr10010914pju.49.1660846321834;
        Thu, 18 Aug 2022 11:12:01 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b001708e1a10a3sm1700281pla.94.2022.08.18.11.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 11:12:01 -0700 (PDT)
Message-ID: <491d822c-56f0-71df-8815-91ab863ebc9d@github.com>
Date:   Thu, 18 Aug 2022 11:12:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: vd/* (was: Re: What's cooking in git.git (Aug 2022, #06; Wed, 17))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7d36s31e.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7d36s31e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * vd/scalar-enables-fsmonitor (2022-08-16) 5 commits
>  - scalar: update technical doc roadmap with FSMonitor support
>  - scalar unregister: stop FSMonitor daemon
>  - scalar: enable built-in FSMonitor on `register`
>  - scalar-[un]register: clearly indicate source of error
>  - scalar-unregister: handle error codes greater than 0
> 
>  "scalar" now enables built-in fsmonitor on enlisted repositories,
>  when able.
> 
>  Will merge to 'next'?
>  source: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>

This should probably be "Expecting a reroll."; I have a couple of changes to
make in response to [1] and [2] and will send the new version later today.

[1] https://lore.kernel.org/git/f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com/
[2] https://lore.kernel.org/git/82716e5b-3522-68f5-7479-1b39811e0cb2@github.com/

> * vd/scalar-generalize-diagnose (2022-08-12) 11 commits
>  - scalar: update technical doc roadmap
>  - scalar-diagnose: use 'git diagnose --mode=all'
>  - builtin/bugreport.c: create '--diagnose' option
>  - builtin/diagnose.c: add '--mode' option
>  - builtin/diagnose.c: create 'git diagnose' builtin
>  - diagnose.c: add option to configure archive contents
>  - scalar-diagnose: move functionality to common location
>  - scalar-diagnose: move 'get_disk_info()' to 'compat/'
>  - scalar-diagnose: add directory to archiver more gently
>  - scalar-diagnose: avoid 32-bit overflow of size_t
>  - scalar-diagnose: use "$GIT_UNZIP" in test
> 
>  The "diagnose" feature to create a zip archive for diagnostic
>  material has been lifted from "scalar" and made into a feature of
>  "git bugreport".
> 
>  Will merge to 'next'?
>  source: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>

I think the review on this has stabilized (and, personally, I'm happy with
the current version). Assuming no late-stage reviews come in, I think this
is ready for 'next'.
