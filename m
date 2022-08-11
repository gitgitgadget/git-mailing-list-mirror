Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2784C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 15:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiHKPwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiHKPvm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 11:51:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01F698C94
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:43:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r69so10910086pgr.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kfLtFuMb5LvNB6eqMjx18yg0sWLQ7ul32JZ3B408tmU=;
        b=B1bC4hmrrqEvaEEy1mGXKhYecsPF6gh6iDCcBn7b3D49sRPLhlqOX/oNOwrGLsf4e6
         yB3LAgyzmZKQBRZocU/HYiJkbk64yRVgZZkucETrD5b4PxJSugjZvTZu6p/ImqSzA1hI
         nXafl3KhpQXDnGggbzyfnmQNuFxmJxg2bXun7udRH3IMbJpfxeWH9jmH/ApZNQU4LIsK
         67+oCMhDc5XPh0GV9Hv8WLItSE7aArpQf/3rNPdx/DDoXsFMDAqW2r2BlMyeCYHUxGt8
         R+t9fWu1/EOJtD5/NZm5zBPHr65q4yIb/ZHeS0ZVSQw1f1JGE0F9UxI/7CPaDYPidaTK
         sqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kfLtFuMb5LvNB6eqMjx18yg0sWLQ7ul32JZ3B408tmU=;
        b=lkC8mo5UrZ91NVQjA/2wXrUHDa15Wx4kgAAzlF6QYWvEVhMv8QfWoV3A1SpMKpg4UM
         XfKeszc1ejcYtkil/5n9K0xoO4E+4aBSZvmDAphNAsQ6hhlRA9HA273h3DEf5ZrDvGVo
         4M3WfyF6CTtERgVoW9Y2AjfqVQ1/EK7zPQTow2Gi+ZDvyxxD/Pv+PhG53xciCgJ/xs1f
         kvrq7Rf9GxkS74cnPXiqsDKrgyWl6icC0pS4LXrBDfugKQzhA9dgqDl4dqZiIK9UEmEa
         HaeyzKaQ+efE9ViSzCM3p5ETHh6f5ZOEPXL1xFt2DVOaJjnt0T3WfV/1yJ4FJV1NiQcQ
         faDA==
X-Gm-Message-State: ACgBeo0NYOQ4ftnKmWaTBGdBaS6UU67ZS5TRtlzsLToHPJzFWZ9AwGli
        gE+OOp8MIXdEdTEzd/CWi9Wc
X-Google-Smtp-Source: AA6agR5TZgKtAAdmlTH0Hu23DisSB0qa9HN8Bo35hFfksKAsHlUMmlefxWu5+H+x51uwhwp85FbWKg==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr29629424pfl.59.1660232629260;
        Thu, 11 Aug 2022 08:43:49 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a4f0700b001f7613a9d0dsm3846994pjh.52.2022.08.11.08.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:43:48 -0700 (PDT)
Message-ID: <9d1b0cb9-5c21-c101-8597-2fe166cb6abe@github.com>
Date:   Thu, 11 Aug 2022 08:43:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v3 06/11] diagnose.c: add option to configure archive
 contents
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
 <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
 <220811.86ilmzqchn.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220811.86ilmzqchn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Aug 10 2022, Victoria Dye via GitGitGadget wrote:
> 
>> index 06dca69bdac..9bb6049bf0c 100644
>> --- a/diagnose.h
>> +++ b/diagnose.h
>> @@ -2,7 +2,14 @@
>>  #define DIAGNOSE_H
>>  
>>  #include "strbuf.h"
>> +#include "parse-options.h"
> 
> This is a stray include that isn't needed at this point, some mistake,
> or needed by a subsequent patch?

It's needed by patch 8 [1]. If I re-roll again, I'll move this '#include' to
that patch. Thanks!

[1] https://lore.kernel.org/git/3da0cb725c927d08dd9486286e06bdb76896f5b7.1660174473.git.gitgitgadget@gmail.com/
