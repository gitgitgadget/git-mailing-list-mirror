Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D23C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiCORPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiCORPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:15:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62626AEA
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:14:31 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so14408681otk.8
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QesH/X3DWEBs134E2z00e4VNmo/hYWPBfYfLQM1b3y0=;
        b=WN+0zgv5pncBwPh1bWMy7Qm+6rEu8WIrQeW85w/k4tVU5aA0b8K81J2YVfvWi3vVMy
         N7aUN2KbQbTkmAUYdfSp/UlWWz4V8bXIlHqKW9UA0ZphsnVzYbotDImkP9n6GbMmrkzj
         asTzy7NU5QGM0O1pIa5G5SmBA24lO+NPoaX+8q+BjcaeXTij40n99j7o+AptqGQD9b4o
         GuhXbR26HrMC1DYxXQW/YvlMhiVZIBy8PQhXYgKJ99N6T4GaK363uN7rCgKJYJD2WMQ3
         R4rPTsCc3gZSdbplYdY17R7n6ELxi//8/zkhTZ7oz+KP/VJDBi2S2d26OrXDKDY1Xtv3
         O2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QesH/X3DWEBs134E2z00e4VNmo/hYWPBfYfLQM1b3y0=;
        b=On3mV6go7a9rBeLIyJMypTHySObBPbu2WWJotkr/iGMkwgk6sTaPu5H4ya4SxbQ6yJ
         NHcvB0vL2+E0MyAnL6tQG70G3Qy+Ap5eH3rnu3ctVj+GWi/9SZW1kQROzrIEHk74sxLl
         eEyttTvqpvihMw24gLJ+moQYVs4U7B0xfctzIC8aFRkV3kbIKs2XXOGAQ8GONbkv2DgM
         5FF5ZLAeEzHnoDERu5PLva7UfkwBsXAqQM8S4eMppzAXEwAf2HCcpne+16nDvaawe5Gw
         0Mh0pKHlnx2WJF9AsdX9O2//MjnQY8hqPjswRhVHNjgwpdteNsqxJo3rU1CfgFti9vuU
         BWAQ==
X-Gm-Message-State: AOAM533hcBX1SC5qL7Bke1yxKMkSZcW2xhvpeTaNZh7077BGLIldrcuq
        aZfqSOtTMTrN/kJzO0D+b24BfCiwoVPP
X-Google-Smtp-Source: ABdhPJxNZ9TXuCCmTdVdPxuedQRYRo9q5ZmXnsjVrp5qSOFQfi+ADAEbeYiICtTU8o6p+vK7Cal0iQ==
X-Received: by 2002:a9d:6c8e:0:b0:5af:5113:1bd9 with SMTP id c14-20020a9d6c8e000000b005af51131bd9mr13217203otr.86.1647364471158;
        Tue, 15 Mar 2022 10:14:31 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s62-20020aca4541000000b002d7823c8328sm9697207oia.4.2022.03.15.10.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:14:30 -0700 (PDT)
Message-ID: <20ffd93d-e3dd-4df6-5ec7-d3577cac910d@github.com>
Date:   Tue, 15 Mar 2022 13:14:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2022 12:07 PM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>  builtin/mv.c                             |  3 +++
>>  t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
> 
> Hi Shaoxuan! 

Hello!
 
> I'll answer your question "are the tests on the right track?" [1] inline
> with the tests here. 
> In 't1092', I've tried to write test cases around some of the
> characteristics relevant to sparse checkout/sparse index. For example:
> 
> - files inside vs. outside of sparse cone (e.g., 'deep/a' vs 'folder1/a')
> - "normal" directories vs. sparse directories (e.g., 'deep/' vs. 'folder1/')
> - directories inside a sparse directory vs. "toplevel" sparse directories
>   (e.g., 'folder1/0/' vs. 'folder1/')
> - options that follow different code paths, especially if those code paths
>   interact with the index differently (e.g., 'git reset --hard' vs 'git
>   reset --mixed')
> - (probably not relevant for 'git mv') files with vs. without staged changes
>   in the index
> 
> I've found that exercising these characteristics provides good baseline
> coverage for a sparse index integration, not leaving any major gaps. I'll
> also typically add cases specific to any workarounds I need to add to a
> command (like for 'git read-tree --prefix' [2]).

This, and other advice that Victoria mentions, are really
good points to keep in mind.

> My recommendations:
> 
> - add tests covering outside-of-sparse-cone 'mv' arguments
> - add tests covering 'mv' attempting to move directories (in-cone and
>   sparse)
> - add some "test_must_fail" tests to see what happens when you do something
>   "wrong", e.g. to try to overwrite a file without '-f' (I've found some
>   really interesting issues in the past where you expect something to fail
>   and it doesn't)
> - add 'git status --porcelain=v2' checks to confirm that the 'mv' worked the
>   same across the different checkouts
> - remove multiples of test cases that test the same general behavior (e.g.,
>   'git mv <in-cone file> <in-cone file>' only needs to be done once)
> - double-check whether '-v' and '-k' have the ability to affect
>   full-checkout/sparse-checkout/sparse-index differently - if not, you
>   probably don't need to test them
> 
> Thanks for working on this, and I hope this helps!

You mention in your cover letter that the ensure_not_expanded tests
are not added yet (same with performance tests). Now that you've
gotten feedback on this version of the patch, I might recommend the
organization you might want for a full series:

1. Add these 'mv' tests to t1092 _without_ the code change. These
   tests should work when the index is expanded, and making the
   code change to not expand the index shouldn't change the
   behavior.

2. Add the performance test so we have a baseline to measure how
   well 'mv' does in the normal case (and how it is slower when
   expanding the index).

3. Make the code change and add the ensure_not_expanded test,
   since the functionality from the tests added in (1) will not
   change and we can report the results from the perf tests
   added in (2). The only thing to test is the new, internal
   behavior that the index is not expanded when doing these
   actions. (Keep in mind that we expect the index to be
   expanded for out-of-cone moves, but it's the in-cone moves
   that we expect to not expand.)

Thanks!
-Stolee
