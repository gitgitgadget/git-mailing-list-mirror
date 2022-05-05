Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1964BC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 15:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381170AbiEEPRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381181AbiEEPRH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 11:17:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D95BE66
        for <git@vger.kernel.org>; Thu,  5 May 2022 08:13:20 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e656032735so4511175fac.0
        for <git@vger.kernel.org>; Thu, 05 May 2022 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=31qvx5flzKOg1DpAHR0SfrjwvFaFGEpx7CR51Ssp/z0=;
        b=R0khGPK5er2Y2E0BLd24XD/5q5Kjo0JtagjOvBV1CubNHa/+VGF7dkx4IvxuhkbtTl
         fpE+gpXZGl1aCBuHRs2HOgBfwFLD0vF4xbs8erfroxdK/bzyO4XAClWEYfnZMzZeP0pL
         B5Y16ppRu1FCVtCvD8Rv3wvKmOBDpodoe4baIhS1MuZnqMgtNzao34hcrFNl7kP/vviq
         rRGyUB7HOyzwr5iCJbKZfw0+/55VdrLHi5SMjVi2Zx57umoLBYgRU1UYspnYJezeGZLG
         v4xi+aM8vU2A/i6AbOjm7U8vIi+v1HkOITvB304yFNjnPizNaFihCZYDZPpS+Yko3Dt/
         gs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=31qvx5flzKOg1DpAHR0SfrjwvFaFGEpx7CR51Ssp/z0=;
        b=BzXHdkfvRwfCNM58cUQaaDNCTxXMxlPB0YzxoC67Q36pA5hcbJfowjSWnKzThIIpAq
         Uu/d4ILF7yri/gZoXDR5+tmLFNvRjPxptWVtV1OszZdvc4t7pMgUqtxTU68AvfctsXhS
         rl8zYSvfgLjsANJbEj9tWmPsONawJEK2rrggykSCtn8OlNKfLyFIT1PSWj2YAz/j5ljN
         dSY7wJAPAXABoUBIvSFnwdQMrZJIZTGQweBBRKIzZNfxazogeKIx9hDW0DPuSxGt5MCN
         LutmsLUI+PWrA5Mc285WcOZKyy6XBIOb1IwP5V5YU6zfvxKKpW//G22ZAKAswJgrfTfc
         oTHg==
X-Gm-Message-State: AOAM531FyDxGczXWtjvsVKEWVxxTaIm4LPNq6V48VOERkiqzR2+hb+Jr
        VPsPThceExpfHxeUsT9K658YP7Q0lmtQ
X-Google-Smtp-Source: ABdhPJzrs5MI0xEoDgtDQj2M4Yz7Lb5FxAJ37Cp0+kCH7Bn/MDYTXeNbozpJLV6ol+rm9uZ39/52cA==
X-Received: by 2002:a05:6870:7909:b0:ee:91b:bb48 with SMTP id hg9-20020a056870790900b000ee091bbb48mr1675518oab.157.1651763599770;
        Thu, 05 May 2022 08:13:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a0d9:dd04:b268:f889? ([2600:1700:e72:80a0:a0d9:dd04:b268:f889])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870f20600b000e686d1388dsm620314oao.39.2022.05.05.08.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 08:13:19 -0700 (PDT)
Message-ID: <720e86b3-367d-ab83-d3ba-a05cdf9bf0c2@github.com>
Date:   Thu, 5 May 2022 11:13:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
References: <xmqqilqnvacd.fsf@gitster.g>
 <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
 <xmqqy1zhmftk.fsf@gitster.g>
 <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BHDKRX4sW_Jjqw5j7Voas0X_xkFZgg5Jqk0TkNZOd7k1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/5/2022 11:04 AM, Elijah Newren wrote:
> On Wed, May 4, 2022 at 9:18 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> * en/sparse-cone-becomes-default (2022-04-21) 9 commits
>>>>  - Documentation: some sparsity wording clarifications
>>>>  - git-sparse-checkout.txt: mark non-cone mode as deprecated
>>>>  - git-sparse-checkout.txt: flesh out pattern set sections a bit
>>>>  - git-sparse-checkout.txt: add a new EXAMPLES section
>>>>  - git-sparse-checkout.txt: shuffle some sections and mark as internal
>>>>  - git-sparse-checkout.txt: update docs for deprecation of 'init'
>>>>  - git-sparse-checkout.txt: wording updates for the cone mode default
>>>>  - sparse-checkout: make --cone the default
>>>>  - tests: stop assuming --no-cone is the default mode for sparse-checkout
>>>>
>>>>  Deprecate non-cone mode of the sparse-checkout feature.
>>>>
>>>>  Will merge to 'next'?
>>>>  source: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
>>>
>>> This has been quite stable and I'd like to see it merge early in the
>>> release cycle in case that catches anything during local testing.
>>
>> This one I am not worried about stability all that much; I am more
>> worried about breaking those who do not believe in "cone is the
>> future" and managing their expectations.
> 
> What path forward would you like to see?
> 
> On v2 you said, "There are a few things that I found questionable, but
> they were mostly documentation issues".  You brought up several points
> in v2 where my wording in the Documentation was admittedly suboptimal,
> though I think I addressed all of those in v3.
> 
> I also brought up an alternative change for consideration in the cover
> letter, though you didn't comment on it and other reviewers, while
> okay with the alternative, seemed to agree with my proposed changes in
> the series over the alternative.
> 
> Also, it might be worth noting:
>   - sparse-checkout, the capability in Git since ~2010, remains
> unmodified by these changes
>   - sparse-checkout, the subcommand added a couple years ago, still
> supports all non-cone mode behaviors it did before
>   - the change here is that the sparse-checkout subcommand's default
> becomes cone mode, along with documentation updates

I think Junio's concerns are the same ones we have had that delayed
this switch from the start: we don't know who might be surprised by
this change.

We've given this enough time to collect opinions from interested
parties that watch the list, but we need the next level of feedback
at this point. That's why I'm advocating to merge this now and have
a long time before the release to gather feedback.

Thanks,
-Stolee
