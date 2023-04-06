Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE9C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDFMJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDFMJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 08:09:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FEE18D
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 05:09:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q19so36219069wrc.5
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680782953;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EMIfPAcSvOvq+0mu5Nab+5XCIJvgwnSPVcNMB4xr6E8=;
        b=NTyGVZMT86LmL01OA9vsDyNxM1BaGMsrX9cJS/Hw5PnkX8L7Gky6As2dfVOVsAaNi3
         97XhMfJcdmebGxehFZcrPUbw3AMw6IErnTohFUSGf6orFeI514Tk/2fcsEE/QWadNfaT
         ehN+pDqFgiS+aI7aIRmtfOUA9k61DzBYlupggxGq/bdP+vV6euSasjoZ/4v3WvFAl3ZV
         iCv+rvaUXbUgYExolzzsv1FENMAnh75r5+RJCs9R50kmFmjeURsJnH7KpNYiVgmcxT1j
         0EApZ0gigFhjKQ2BzUUDL2TsbAiJhUGkomtnMmSGV+WiFWU4g/y0kjRUvreqxYLUhgbU
         JcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782953;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMIfPAcSvOvq+0mu5Nab+5XCIJvgwnSPVcNMB4xr6E8=;
        b=3qTWHNo5GCyqZD5T0UwHQm6C1TS/x2U8cGAosfYkvd5TG0kZKgzeAloHbPM5wpZuJF
         I/bkpRfuyUK/ISDmXK4kqsMq5TV3iVwWsZROdXf6VxdDsJsjf2d8TWNSL2RNm+nLbWoz
         QqrtbEaHOVjkZiO+wkAH1KjVYauPETpvbghCjMHEX2w/xjxBOmX7uNjaMtzp9rM6Bi5I
         1yTT0FJQ5UXzmBLkZob/W/rt+Io7AFBvajQhHIY7N/h/LS5dreuybUKzcEZnt0ziiwsf
         hEJwBQ2xsGk5+QNAlLxb3K4A/+YIakVtRfe40P3xZaNk76nQI72+3UlaJNSYQu4ZxaAK
         AfCA==
X-Gm-Message-State: AAQBX9evEj7XIjV9znXfSC24b/slieULUoaFNoZvt8fjKPCl7NQwWKo5
        aNO174lH4XK/30eW/1thVI8Tk+bY1vk=
X-Google-Smtp-Source: AKy350Zjs9b9elCUhtwHT1Npozlupf+9vXobiPNVsjVenhc7rUylUSA1D5ml8G4+KLMWn2DlcG93JA==
X-Received: by 2002:adf:f7cc:0:b0:2cf:f061:4927 with SMTP id a12-20020adff7cc000000b002cff0614927mr6637220wrq.42.1680782953265;
        Thu, 06 Apr 2023 05:09:13 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d634a000000b002e116cbe24esm1624543wrw.32.2023.04.06.05.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:09:12 -0700 (PDT)
Message-ID: <7663c59d-2bdd-56b2-dab9-3011f9398c09@gmail.com>
Date:   Thu, 6 Apr 2023 13:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/8] sequencer refactoring
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <f72b3820-124c-3e2c-30e2-ca3f46b74dc0@dunelm.org.uk>
In-Reply-To: <f72b3820-124c-3e2c-30e2-ca3f46b74dc0@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/2023 11:08, Phillip Wood wrote:
> Hi Oswald
> 
> On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>> This is a preparatory series for the separately posted 'rebase 
>> --rewind' patch,
>> but I think it has value in itself.
> 
> I had a hard time applying these patches. In the end I had success with 
> checking out next, applying 
> https://lore.kernel.org/git/20230323162234.995514-1-oswald.buddenhagen@gmx.de and then applying this series. It is very helpful to detail the base commit in the cover letter. A series like this should normally be based on master see Documentation/SubmittingPatches.
> 
> Having applied the patches I'm unable to compile them with DEVELOPER=1 
> (see Documentation/CodingGuidelines)
> 
> In file included from log-tree.c:20:
> sequencer.h:7:6: error: ISO C forbids forward references to ‘enum’ types 
> [-Werror=pedantic]
>      7 | enum rebase_action;
>        |      ^~~~~~~~~~~~~
> sequencer.h:140:34: error: ISO C forbids forward references to ‘enum’ 
> types [-Werror=pedantic]
>    140 |                             enum rebase_action action);
>        |                                  ^~~~~~~~~~~~~
> sequencer.h:196:26: error: ISO C forbids forward references to ‘enum’ 
> types [-Werror=pedantic]
>    196 |                     enum rebase_action action);
>        |                          ^~~~~~~~~~~~~
> 
> In file included from ./cache.h:12,
>                   from ./builtin.h:6,
>                   from builtin/rebase.c:8:
> builtin/rebase.c: In function ‘cmd_rebase’:
> builtin/rebase.c:1246:95: error: left-hand operand of comma expression 
> has no effect [-Werror=unused-value]
>   1246 | (BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(action_names) == ACTION_LAST),
>        |                               ^
> ./trace2.h:158:69: note: in definition of macro ‘trace2_cmd_mode’
>    158 | #define trace2_cmd_mode(sv) trace2_cmd_mode_fl(__FILE__, 
> __LINE__, (sv))
>        |     ^~

I think the errors above are best addressed by dropping patch 3 as I 
don't think the benefit is worth the churn. You say that the existing 
code is fragile but it is not that hard to follow and is battle tested 
and known to work. If you need to change things to support --rewind then 
it would be better to do so in a series that adds that option.

> sequencer.c: In function ‘todo_list_rearrange_squash’:
> sequencer.c:6346:23: error: operation on ‘items’ may be undefined 
> [-Werror=sequence-point]
>   6346 |                 items = ALLOC_ARRAY(items, todo_list->nr);

This is easily fixed by deleting "items =" as ALLOC_ARRAY() does the 
assignment for us.

After dropping patches 3 and 7 and fixing the ARROC_ARRAY() above all 
the rebase tests pass for each commit and the CI passes - 
https://github.com/phillipwood/git/actions/runs/4627831184

Best Wishes

Phillip

> 
> Best Wishes
> 
> Phillip
> 
>>
>> Oswald Buddenhagen (8):
>>    rebase: simplify code related to imply_merge()
>>    rebase: move parse_opt_keep_empty() down
>>    sequencer: pass around rebase action explicitly
>>    sequencer: create enum for edit_todo_list() return value
>>    rebase: preserve interactive todo file on checkout failure
>>    sequencer: simplify allocation of result array in
>>      todo_list_rearrange_squash()
>>    sequencer: pass `onto` to complete_action() as object-id
>>    rebase: improve resumption from incorrect initial todo list
>>
>>   builtin/rebase.c              |  63 +++++++--------
>>   builtin/revert.c              |   3 +-
>>   rebase-interactive.c          |  36 ++++-----
>>   rebase-interactive.h          |  27 ++++++-
>>   sequencer.c                   | 139 +++++++++++++++++++---------------
>>   sequencer.h                   |  15 ++--
>>   t/t3404-rebase-interactive.sh |  34 ++++++++-
>>   7 files changed, 196 insertions(+), 121 deletions(-)
>>

