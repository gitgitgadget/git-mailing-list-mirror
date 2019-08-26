Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56A81F461
	for <e@80x24.org>; Mon, 26 Aug 2019 19:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfHZTRD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 15:17:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35542 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHZTRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 15:17:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so15019260qke.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d3bAHx/YlLkWFZ2lfWKgoNDfzJo9GimcnRoXYmr/5xM=;
        b=cPz5dy1KFpXc+pBdgPCoyPV0u9LJTXBpIBTXAE9UNRiiEmV/OkYS5YebA7+QPxuL4d
         Tm+Or7GiSpbzhzf+srWNkBetC9m+THBwfz10nj7vlXWxqZRhziIWWXt7IT8I9i/fCehb
         qx/QKpjYlVFVT4nz7m83T2WpTs1tY9ZOmDvsOYK8oOMjlGDgJ0DbO6OamgheosX9UEf6
         IGQj5NEonbpBRR3gRL/Y6sCoSiT8kvIbElbOODMGyPbQr+yEszUgpV4YlmXTUYpxvMs/
         mssZ2UTw1XQ3KAB4JBVNJAIw/w24uyM2qecOxNxGtYbxfpxL8YD8rpnnR4Mq5REPek4o
         DYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d3bAHx/YlLkWFZ2lfWKgoNDfzJo9GimcnRoXYmr/5xM=;
        b=EPvZEPKvicyL+PakLE+FgjyPWgPH38On+jgswrsRyhUH1owQJBDmMbHGEXYyEA8aHi
         T0whhlry9BQuYVbGLqGjtfV8oqrHrzn26ccJy4ur6GtYRAC4aEK9zwBp1cAVe4od/rli
         y0Z00sbFSNqdNKNLyhs7ukgk/gFC1/pMtIg8nuDxinciEym4AoYykFK/vZa10eH3f76t
         UgN8rYFr/kHKppQIdkLFNuoFPePdVfwpBoCKDRvAQ+zI5kLKi1ac05FONF533QQ8oQYT
         SwYKw3w73lo/hi9MT75RK/kaMK3Db8BwMMPLA7ahXny+TASW7wgNsbklzZwxA47iId1o
         vgsA==
X-Gm-Message-State: APjAAAUWYqt6wxdHSBPm3qGuF+IzesWbZo+zu6+faWHDO/LUllZb0WLb
        O0RXZV4sdrwYdGHM7+pe2lA=
X-Google-Smtp-Source: APXvYqwkjR+UuQuTgZ9BDABeRHo0oyZYRoC7HkOJkbu32kQJVQVYdai8Zl+HQ16UXcu9vM8m4q39FQ==
X-Received: by 2002:a37:aa06:: with SMTP id t6mr17951857qke.226.1566847021086;
        Mon, 26 Aug 2019 12:17:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1d0f:5c09:ae47:3604? ([2001:4898:a800:1012:ce42:5c09:ae47:3604])
        by smtp.gmail.com with ESMTPSA id a67sm7249820qkb.15.2019.08.26.12.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 12:17:00 -0700 (PDT)
Subject: Re: [PATCH 0/9] [RFC] New sparse-checkout builtin and "cone" mode
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com>
 <08bd295b-ec5a-3128-42cf-acb24971d679@gmail.com>
 <CABPp-BG8GtdaogbCCZqPXYkhMAqseyAXX0ppjUbg_1hVShGG=Q@mail.gmail.com>
 <c919513a-f41f-2ce8-60ed-e0b0733c0c7f@gmail.com>
 <CABPp-BFGcuf6jnLndi_s_LGA9M4FAb1_GGOYo=Bxky5pv5CWug@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3ca3a292-5fb4-4937-1293-979297ef34b7@gmail.com>
Date:   Mon, 26 Aug 2019 15:16:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFGcuf6jnLndi_s_LGA9M4FAb1_GGOYo=Bxky5pv5CWug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2019 2:16 PM, Elijah Newren wrote:
> On Mon, Aug 26, 2019 at 6:29 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 8/24/2019 1:40 AM, Elijah Newren wrote:
>>> On Thu, Aug 22, 2019 at 6:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>>>>
>>>> On 8/21/2019 5:52 PM, Elijah Newren wrote:
>>>>> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
>>>>> <gitgitgadget@gmail.com> wrote:
>>>
> 
>>>> In this series, I turn `core.sparseCheckout` into a tri-state, and only
>>>> try to validate the sparse-checkout when `core.sparseCheckout=cone`.
>>>> This avoids spending time on the validation when someone is content using
>>>> the existing feature.
>>>>
>>>> The _intent_ of using the sparse-checkout file and no extra data structure
>>>> was to let other clients (or an older client) read the sparse-checkout data
>>>> and result in the same working directory. One thing I realized after
>>>> submitting is that the tri-state config variable will cause old clients
>>>> to error on parsing the non-boolean value. Instead, in v2 I will introduce
>>>> a new boolean config variable "core.sparseCheckoutCone" that will do the
>>>> same thing as the current series when `core.sparseCheckout=cone` and will
>>>> fix this compat scenario.
>>>
>>> Once we are forced to use yet another config variable, we may as well
>>> use yet another config file ($GITDIR/info/sparse-checkout-cone or
>>> something; or maybe a less specific name with greater future
>>> compatibility via some version marking in it).
>>
>> I'm hesitant to include a second "source of truth," as that can cause
>> issues when users modify the sparse-checkout file directly. Since the
>> existing way to interact with the sparse-checkout is to directly edit
>> the file, I want to be as careful as possible around users who modify
>> that themselves. The caveat is that if they specify "cone" mode then
>> they will get warnings and worse performance if they modify it outside
>> the limited patterns we allow.
> 
> Wait...does that mean you allow mixing and matching both regular style
> sparse-checkout declarations with cone-mode style declarations within
> the same file?  Are the non-cone mode entries ignored?  Does it
> fallback to non-cone mode for all entries?  Or does that mean you
> allow checking out both old and new styles of filesets, where you
> optimize the cone-mode style declarations with your hashsets, and have
> the remaining ones fall back to the old O(N*M) matching?  (I think it
> does the last of those, right?)
> 
> If you support both, it sounds like you naturally support doing cone
> mode with allowing people to also grab a handful of additional files
> without the rest of their directories or parents.  It's just that
> folks who want to do that will ask for a way to turn off any warnings
> you spew, and if you turn the warnings off, then people who meant to
> get cone behavior but mistyped stuff might complain about no warnings.
> Hmm....
> 
> (Just trying to think things through out loud; I don't necessarily
> know what's good or bad here, just voicing what I think might happen.)

The way I built the current series is that we honor what is in the
sparse-checkout as historically allowed. Always.

If a user modifies the sparse-checkout to have patterns that don't match
those that are added in cone mode, then Git warns the user this is the
case then reverts to the old pattern-by-pattern logic. This is to have
the Git client always match what another Git client would expect. (This
could be JGit or an older version of Git.) A user could always disable
cone mode to remove the warning and keep their sparse-checkout in its
current state.

Note: I have not made the "non-code-mode pattern" checks very robust.
For instance, I don't check the middle characters for wildcards. This
needs to happen at write time, too. The plan is to make these more
robust in future versions of the series.

Thanks,
-Stolee
