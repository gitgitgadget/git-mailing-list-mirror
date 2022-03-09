Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFD8C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbiCIStM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiCIStL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:49:11 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26044180D33
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:48:12 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so4058074ooi.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VzX9v+/DU0uta9DAmf+6L6GeDfUxQIKKunR+W9jqEDQ=;
        b=cklusCndFbRtoo0G8wBpGc7cn26hNEa8lB4bQR5HsAxjbNCTtQc2RqQyxuwHQasokJ
         szVvo/diJCDUTS0D/RCAwbo5wLqMSJd7kyPPforyynPE8KXuiAl52NsQN2YGEtc+q4oX
         cO6Rrk6ppm76nUQdbbjg8nvZ7kCWYcMOL3rMgMBCpF4ZxbzGJxD/EWRuyvnwGNjA6G6r
         xtwaV/YvdJDtzqC9bNSkFSuMRK1ryMRsPf4U1DNwfLLoYfy43IHWxQBK1+/dS+ZpAdix
         onyjuEH8nLEEQZxAiIzZWocxyjYeqskmToSGiiPJ6pREkAJ8DhLKgz8FTGJNdbHxb8BT
         KRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VzX9v+/DU0uta9DAmf+6L6GeDfUxQIKKunR+W9jqEDQ=;
        b=F0JcVwEeM0J7CQ5mOjvtIeHWDoz5j3yA1SSxf5Xely6EQU/afCqNjIywa5kYKBRMlE
         f/wmSizGIs81k0ypeXyL1FD6Zk3/hirGJ4iK3YRY8QKfE0NctBMh4iLHMIUTIsj6ivYa
         +rJTGCDuilOocTakrlNli70BHYqL8WZr6SW7rnh6260uMSEZr/cr0Sf46+E5+CfsouDx
         r1+ZR9NcD1I8NQAVmUJUXLkN92IzuuYBFkXhlOO2QZKcfGF5gJpov8VlBZ6zI6Mp8lTq
         zmdbGuLdXJ757UxkCEhfgVIaulxO2GTwe/KqW29S6YuNZG6DO7Ym7tDg+z1SyYjd9waO
         Q4HQ==
X-Gm-Message-State: AOAM533QUCR+uNfrimyvYLONprGNEyCKNObgGh8YcN12t8CROMWBaRfz
        uVDZJOQHn5cdTgmVgEv15ap2
X-Google-Smtp-Source: ABdhPJxxogMfPeoCSapZ21ejLbPHZbkQT7fRIs8l6aNab3AHDXuQtdXnRZ8vq3KRJ+2kl3B5m6yVjA==
X-Received: by 2002:a05:6870:b386:b0:da:b3f:2b82 with SMTP id w6-20020a056870b38600b000da0b3f2b82mr6400638oap.289.1646851690320;
        Wed, 09 Mar 2022 10:48:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f188-20020a4a58c5000000b0031ccb8272f1sm1375223oob.33.2022.03.09.10.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:48:09 -0800 (PST)
Message-ID: <45b381da-af41-9e6b-f3b6-a83678a20319@github.com>
Date:   Wed, 9 Mar 2022 13:48:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 5:15 PM, Jeff Hostetler via GitGitGadget wrote:
> Here is V2 of part 3 of my builtin FSMonitor series.
> 
> I think I have addressed all of the feedback from V1. This includes:

> Range-diff vs v1:

>   -:  ----------- > 22:  524d449ed64 fsmonitor: never set CE_FSMONITOR_VALID on submodules
>   -:  ----------- > 24:  95b9d4210d2 fsmonitor: on macOS also emit NFC spelling for NFD pathname
>   -:  ----------- > 25:  5a0c1b7a287 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
>   -:  ----------- > 26:  a45c1fd3000 t7527: test Unicode NFC/NFD handling on MacOS
>   -:  ----------- > 27:  e3e01677d93 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible

I looked closely through the range-diff for the edits, then looked at
these new patches closely. Outside of one thought about some debug
output, I'm happy with this version.

Thanks,
-Stolee
