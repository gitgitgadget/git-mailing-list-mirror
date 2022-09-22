Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7CAC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 15:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiIVPUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIVPUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 11:20:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9477E302
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:20:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l8so7012994wmi.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=24GmaVJKJkfM2BN1XvNojrh9jh4lqs1qUpd9mF4CJ1c=;
        b=KCDXIvU97x4ZfKrbwlQ69RmrrOQ1wyKB6VCcAc7eMr3YR3saOt0P85Rd0Q+ob2Wmja
         yUK56JAuYGrG/KRoocVui5TDpArcUaLo0xq/CaCtnwxo85vx8CD001xTTV09OWCn0dnx
         0S6OpMAOR8uv+36yG/+hYnwhiTNywHLFVwWljtef0bnNGkcDWIZXxwevyB+qwJnIrA4q
         DqYeEeXVOUIPuGmgFhyld/zGTZ38L/p99QYDP7y8opiR1oO0/JsEsSqFKTodw5pV1L3P
         XXGffFTWixlS2I++E+QSBM1YrRnx0SsAmQBO3a4fF5jHn4hyoaRfNmL1Bngp+GlKxnKm
         z7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=24GmaVJKJkfM2BN1XvNojrh9jh4lqs1qUpd9mF4CJ1c=;
        b=5uBDFUBdax2xT0tuAtrlQzbBlx6kjhUnjoY2y27XbRbY1LSh+D7jHp3GCctSyEv/qx
         hu+MrTxGYfumqwmrBfTErsePYW58bDrWSpK7AvklAHFYVb47aaqBNE4MNexnLcdGGivM
         xxHd2TZPsDi7nPAVFf17dogorzQqqqsNnsVktK/sky8co4esee3L5x8Fg1QXpyW3f7Dd
         Thr2e7tgB97OwOBkNkl/AxjqrtriNZ8my1CaC0wn0LC0EK18i4Z6KpTdueb0qH80OL65
         0Q8EjXQmx41R5jhu3EiAGBI0EhGVsWJbJYqHdfh/vkjLIvcNOnCcw4jRG8Sfey4K9oCu
         DdSw==
X-Gm-Message-State: ACrzQf1xImNugFdLbDUknh7Log3eSfpjrFn5rRCXfG34baWZX8Q7E5vA
        73TE4IcukhTkvvEy4SRLbvFmgTvpGuB+Fw==
X-Google-Smtp-Source: AMsMyM7Tj2myeTeyipTAslGwZzO84YBmJGJvHp8Q36wObHGz9h+JpVoNyr88N9nD+Ce0NynU0GmIlw==
X-Received: by 2002:a05:600c:5128:b0:3b5:d6:eb8f with SMTP id o40-20020a05600c512800b003b500d6eb8fmr2914658wms.65.1663860018715;
        Thu, 22 Sep 2022 08:20:18 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b003a5ca627333sm6969831wmq.8.2022.09.22.08.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:20:18 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9501804c-4b34-0c46-b75c-5b2eb23386b3@dunelm.org.uk>
Date:   Thu, 22 Sep 2022 16:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git diff-index considers touched files as dirty and changes
 behaviour
Content-Language: en-US
To:     "Lindeke, Cord" <Cord.Lindeke@softwareag.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BEZP281MB25194116180654CE60001F6CEC4E9@BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BEZP281MB25194116180654CE60001F6CEC4E9@BEZP281MB2519.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Cord

On 22/09/2022 15:11, Lindeke, Cord wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>> touch README.md
>> git diff-index --exit-code HEAD
> :100644 100644 64c1efecd5716f56155b806caaf9fa6a771fae47 0000000000000000000000000000000000000000 M      README.md
>> echo $?
> 1
>> git status
> On branch master
> Your branch is up to date with 'origin/master'.
> 
> nothing to commit, working tree clean
>> git diff-index --exit-code HEAD
>> echo $?
> 0
> 
> What did you expect to happen? (Expected behavior)
> The first "git diff-index" should not detect any differences, but return 0 instead.
> 
> What happened instead? (Actual behavior)
> The first "git diff-index" considers the touched README.md as dirty and returns 1.
> Somehow, calling "git status" fixes this behaviour so that the second "git diff-index" behaves as expected.
> 
> What's different between what you expected and what actually happened?
> The result of the first "git diff-index" should have been 0.
> And the behaviour should not alter at all with calling any other git commands like "git status" or "git diff" in between.

It is working as expected. diff-files and diff-index are "plumbing" 
commands designed for use in scripts and require the index to be 
refreshed with "git update-index --refresh" before they are called. "git 
diff" and "git status" are "porcelain" commands designed for users and 
refresh the index as the first step.

Best Wishes

Phillip


> Anything else you want to add:
> The same issue holds true for "git diff-files".
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.37.3
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 4.15.0-193-generic #204-Ubuntu SMP Fri Aug 26 19:20:21 UTC 2022 x86_64
> compiler info: gnuc: 7.5
> libc info: glibc: 2.27
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> 
> Best regards
> Cord Lindeke
> Sr. Software Specialist
> cord.lindeke@softwareag.com
> Software AG, Uhlandstrasse 12, 64297 Darmstadt, Germany
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Software AG – Sitz/Registered office: Uhlandstraße 12, 64297 Darmstadt, Germany – Registergericht/Commercial register: Darmstadt HRB 1562 - Vorstand/Management Board: Sanjay Brahmawar (Vorsitzender/Chairman), Dr. Elke Frank, Dr. Matthias Heiden, Dr. Stefan Sigg, Dr. Benno Quade, Joshua Husk - Aufsichtsratsvorsitzender/Chairman of the Supervisory Board: Christian Lucas - https://www.softwareag.com
