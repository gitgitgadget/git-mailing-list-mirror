Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD252C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiBXQUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBXQUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:20:18 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A663BCF
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:19:41 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j24so3113462oii.11
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=hZyfo1Fmk9NGNG5PDICpaOInxfvn5vwSzWZcBzN8lRo=;
        b=YYknZ8HMSEd8ytWK1UezthNJhLo8zyb+rVmwnJXLExM9zmdVT7huvLoF3GHeTVHxz8
         YLS9Oqb28qiJkQL2GV19bZ95dWDL30wQo63qsl9wM+l2wYKkU/PupNAertkS3nhkMhO2
         cyXsqyrugYT0zuYk9pJD60Ni50ix3AyTPPBSpBAv+69mpVlt/erw2aoURImyC5ADqgNp
         WShtuI3qvsuNoQEktxm5uffQabr8Vn3rrZuIfNgMGtltv51YxZjesNvOufODSbIOAhPb
         tu8kh3QhGULdptnsTWAM5Ssea9uJaR3fKkyeOVZTfetohtGm80SvMalW1D9RYiWZ4KCB
         5cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=hZyfo1Fmk9NGNG5PDICpaOInxfvn5vwSzWZcBzN8lRo=;
        b=B7hVhUbDIUqR+jHAEgbkXv9xkxC+nAIfHkHx+U2eKJTvP9x9Ywzm9Tmri6euPXJh/w
         SCnCdDd3iOOO2bfOQbleM71MkUlth4urDiHLL+SGccyYZsIUFs+1brxAeH5/CZatZJ0o
         iB5bXkOrONZBSssV/qZuiGC8u76IfV8z/8YvRNK4qgspFcyGm7d9ZV/14d1LWGSLwIBT
         FlMU+45Q+oWWAfDNZoxZHi28/XlAGv34NSGdYMBALfhdMwlgwb0kI6xjo3MQKRXKQKKX
         wVDQzc6CP1MCOGlbl4NGBisPar1lgZkHmWv3LJlYtSLvFHf9Y0vZyQCKibvAxk2ov6jN
         Ww7w==
X-Gm-Message-State: AOAM533TLtyCu5K12HZqxx4KblgfhYbO1BaN7XO7DzRP3uzo0vzXNwyw
        nvuSGPj6njrAROytayT0ofZee4IOhziD
X-Google-Smtp-Source: ABdhPJywBb6Zt7arULe8pgZ03voZPcN8GrU52bzDYfPCYjKXGthegMwpAI2YNwgZJdrPpqcSYi0Ttg==
X-Received: by 2002:a05:6870:5802:b0:d3:7479:f48a with SMTP id r2-20020a056870580200b000d37479f48amr1612899oap.166.1645719320872;
        Thu, 24 Feb 2022 08:15:20 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y28sm1231658ooj.23.2022.02.24.08.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 08:15:20 -0800 (PST)
Message-ID: <f9249541-bb92-1c61-825f-44a034a17bb8@github.com>
Date:   Thu, 24 Feb 2022 11:15:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 17/23] fsmonitor--daemon: stub in health thread
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
 <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
In-Reply-To: <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 11:04 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create another thread to watch over the daemon process and
>> automatically shut it down if necessary.
>>
>> This commit creates the basic framework for a "health" thread
>> to monitor the daemon and/or the file system.  Later commits
>> will add platform-specific code to do the actual work.
> 
> ...
> 
>> diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
>> new file mode 100644
>> index 00000000000..b9f709e8548
>> --- /dev/null
>> +++ b/compat/fsmonitor/fsm-health-darwin.c
>> @@ -0,0 +1,24 @@
>> +#include "cache.h"
>> +#include "config.h"
>> +#include "fsmonitor.h"
>> +#include "fsm-health.h"
>> +#include "fsmonitor--daemon.h"
>> +
>> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
>> +{
>> +	return 0;
>> +}
>> +
>> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
>> +{
>> +	return;
>> +}
>> +
>> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
>> +{
>> +	return;
>> +}
>> +
>> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
>> +{
>> +}
> 
> The macOS implementation is stubbed, as advertised.

After looking at the rest of the patch series, it seems that these
are never filled in. Are some of the win32 health monitors also
appropriate for macOS? (They would need platform-specific checks,
probably.)

Thanks,
-Stolee
