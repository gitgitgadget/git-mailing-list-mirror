Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B4C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbiCJRTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbiCJRTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:19:12 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54515107DB1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:18:11 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so7521396oos.9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aOsHAUKTRAJ3qFzfrm1mE3uZ1Oz2UULs5FcKZbmmgEE=;
        b=VgGd0JK5tk3hAyWNWz/KP5pJJIMgl9mSOuCTJpJLcQh4K5nAyr4qCet+MvX250ffpN
         FzQ21hqQfKSJ9NZxe6p1TCUXtknYTA8e1OaiaVM4ZB9QwrxmZR/oYECq6DiD5x1GY+V/
         Jxah3gq0RtTkfroeSqnqb0WHJ17Y2mBbSMjcnoS0Ymad+6Iu4CYLsmQTN3IxTavng/r9
         WrSGiHTEZhZNYc5KjidQZp09op++CRA6+/H3OYZVvPiw1noiIweNV3wcceOF7kG4GX1d
         HppWd8Q1+DpvGSOT4BtuQEQwf4sg3nXj+krCm1aLI2AY4w42Vig1hYfqfJqlfh9jVDJH
         PiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aOsHAUKTRAJ3qFzfrm1mE3uZ1Oz2UULs5FcKZbmmgEE=;
        b=hM6HhLraduB50J+az2Alu8DkPh8IeHa9mtk6lnDDLFUMhrME/HtBofthJ1vmfv94+R
         BAaOKbSahXJq32HSA0CEn6ERWu13T6ONTSveToT1t0ckAUfZpJh+8t1iam7h9ZWPrDz6
         ThD1m+1c1bCPBMvkIQHf+3h2efES+FokhbwHHVIRxQ0/aTBzsESs5HcUClzRdG54o6JT
         ZaMTnxnw0RwCbH7hFKRKFjuPhHsnpkDlySEF9I/PYq0NdRfirklll71K3fvgmYtBDglF
         UpcSlkH7G03WjY/LcuGH2r56RZD7CW4CrBKJgT+l5FgJEEV54MGjM1RLQDBvRVNspyZn
         yOxA==
X-Gm-Message-State: AOAM532yi42feAbP6ydWs/Kea3UVXcoRGS7NywMC4oqL8oOebljP6rDU
        EoqQlgj6QWgTmDGe+TCqCAfR
X-Google-Smtp-Source: ABdhPJxSYzn4VVOdrjim9zGfPtgaiFGh/npTF1brfacbMeQt8KZQnSKrP3dLpEpIVQI3Aa1hFpBf4Q==
X-Received: by 2002:a05:6870:a986:b0:da:b3f:3279 with SMTP id ep6-20020a056870a98600b000da0b3f3279mr3320538oab.297.1646932690381;
        Thu, 10 Mar 2022 09:18:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x14-20020a05680801ce00b002d97bda386fsm2537732oic.52.2022.03.10.09.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 09:18:09 -0800 (PST)
Message-ID: <2318f4e9-2267-0097-4d6f-a1b916cda3ca@github.com>
Date:   Thu, 10 Mar 2022 12:18:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com>
 <Yh4zehdSnHLW1HuK@ncase> <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
 <Yh93vOkt2DkrGPh2@ncase> <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com>
 <YiCkRLFxn8Pok7Kc@ncase> <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
 <06ea3190-32d0-c792-0ae9-c5600305f158@github.com> <YiXfnsbGzPXffdgV@ncase>
 <94ed6a1e-327c-3f94-b98b-db019a6f5ada@github.com> <YioEHVo3GnzBl3rW@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YioEHVo3GnzBl3rW@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2022 8:58 AM, Patrick Steinhardt wrote:
> On Mon, Mar 07, 2022 at 08:45:07AM -0500, Derrick Stolee wrote:
>> On 3/7/2022 5:34 AM, Patrick Steinhardt wrote:
>>> On Fri, Mar 04, 2022 at 09:03:15AM -0500, Derrick Stolee wrote:
>>>> On 3/3/2022 11:00 AM, Derrick Stolee wrote:
>> ...
>>>>> I will continue investigating and try to reproduce with this
>>>>> additional constraint of working across an alternate.
>>>>
>>>> My attempts to reproduce this across an alternate have failed. I
>>>> tried running the following test against Git without these patches,
>>>> then verify with the newer version of Git. (I also have generated
>>>> a few new layers on top with these patches, and they correctly drop
>>>> the GDA2 and GDO2 chunks when the lower layers "don't have gen v2".)
>>>>
>>>>
>>>> test_description='commit-graph with offsets across alternates'
>>>> . ./test-lib.sh
>>>>
>>>> if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
>>>> then
>>>> 	skip_all='skipping 64-bit timestamp tests'
>>>> 	test_done
>>>> fi
>>>>
>>>>
>>>> UNIX_EPOCH_ZERO="@0 +0000"
>>>> FUTURE_DATE="@4147483646 +0000"
>>>>
>>>> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>>>>
>>>> test_expect_success 'generate alternate split commit-graph' '
>>>> 	git init alternate &&
>>>> 	(
>>>> 		cd alternate &&
>>>> 		test_commit --date "$UNIX_EPOCH_ZERO" 1 &&
>>>> 		test_commit --date "$FUTURE_DATE" 2 &&
>>>> 		git commit-graph write --reachable &&
>>>> 		test_commit --date "$UNIX_EPOCH_ZERO" 3 &&
>>>> 		test_commit --date "$FUTURE_DATE" 4 &&
>>>> 		git commit-graph write --reachable --split=no-merge
>>>> 	) &&
>>>> 	git clone --shared alternate fork &&
>>>> 	(
>>>> 		cd fork &&
>>>> 		test_commit --date "$UNIX_EPOCH_ZERO" 5 &&
>>>> 		test_commit --date "$FUTURE_DATE" 6 &&
>>>> 		git commit-graph write --reachable --split=no-merge &&
>>>> 		test_commit --date "$UNIX_EPOCH_ZERO" 7 &&
>>>> 		test_commit --date "$FUTURE_DATE" 8 &&
>>>> 		git commit-graph write --reachable --split=no-merge
>>>> 	)
>>>> '
>>>>
>>>> test_done
>>>>
>>>>
>>>> My testing after running this with -d allows me to reliably see these
>>>> layers being created with GDAT and GDOV chunks. Running the 'git
>>>> commit-graph verify' command with the new code does not show those
>>>> errors, even after adding commits and another layer to the split
>>>> commit-graph.
>>>>
>>>> I look forward to any additional insights you might have here.
>>>
>>> I don't really know why, but now I've become unable to reproduce it
>>> again. I think we should just go with your patch 5/4 on top -- it does
>>> fix the most important issue, which is the `die()` I saw on almost all
>>> commands. The second part about the warnings I'm just not sure about,
>>> but I don't think it should stop this patch series given my own
>>> uncertainty.
>>
>> Thanks for following up. I agree that with 5/4 we should be safe.
>>
>> I'll remain available to quickly respond if anything else surprising
>> comes up in this area.
>>
>> Thanks!
>> -Stolee
> 
> There is another surprise I hit today in the context of generation
> numbers. In production, I found the following bug:

"In production" makes me think this is on a version of Git without
these patches. Am I right?

>     signal: aborted (core dumped): BUG: chunk-format.c:88: expected to write 8 bytes to chunk 47444f56, but wrote 168304 instead
> 
> 47444f56 is the GENERATION_DATA_OVERFLOW chunk ID, and seemingly the
> precomputed size we intended to write was mismatching the data we have
> actually been writing to disk. And I think this stems from a mismatch in
> how we precompute the number of generation data overflows compared to
> how we're actually writing the data to disk:

Yes, and this count was supposed to be fixed in patch v3 3/5.

The issue is that we skip the increment if the commit was already
parsed, so we would undercount. The fix was to do a loop at the
end focused on counting these overflows.

If you have v3 applied and you still get this error, then we need
to look closely at this issue.

For your production's sake, you might want to set
"commitGraph.generationVersion=1" in your config until you have the
fixes from this series.

Thanks,
-Stolee
