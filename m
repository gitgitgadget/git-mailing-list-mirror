Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E6C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 10:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiGKKyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGKKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 06:54:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE373B6DB3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:00:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2703233wmb.3
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUiIFEgcC/Dg1h48iu0cUc81h0EpV9lDgaKwojKigqk=;
        b=dNDYAK66IIpwWSGDF0AUWcB8KgKBVBv+T7Tl9iBEvCf/1BVrVqfRTBBGuujqhwhC2F
         mQbgRD103wud/PZtrr87kB7xfl35c6mdzdJpcYPReQ2tGPBgF4wmJTIlU4g0yxcx2FdR
         b0gqrkHyjrYx+l0oJ87tYTlZ/pcsWv4Z+1sYSrnK8+W5ImV+wzli15dCTM+zdvNBk8Hp
         B7meqszq58Ph+HxK0W4yVByHct1jNh6C79WgH9jsiVzB/mM3na4pTX0s+g0PR5R3l8HN
         QpEZWcazw+iJFKtu19XyiCko6T1S9ZoH+rm0mf8vrZpLDLNvhfZQiv8ZnRdXicNHBNaU
         4JrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUiIFEgcC/Dg1h48iu0cUc81h0EpV9lDgaKwojKigqk=;
        b=DIkuari9JfAahN8QiMDi/dkyduZzvZxeAh0n26E2W2LAq4GxkT7S52TBzI4eJ9GWN6
         ocFxdxMJ84bcszgEW9dPjht7PbsnUEHo8lbcaF3mj4tOTl6VE7oZ5kYCcJzVn0BFrYmp
         eSRNBTJxwSyNpFSDMmyY0OMUnl/JIKOcImmeSeT/CV3ZR1P/mXNdrVPHF3DEffEgRL1Z
         rDiWL/WzQWBQpHfqlxLbaJVJpAu/TzpSWay6H8nz2ci0iWne+lA38IthkvH62AauboBU
         c69QenLbZT3dCxc9+sxo/D82yRCg/uK/9uGJ1Xx/nPYsTPBEj77y/JEir/Y8xof/g8X7
         mlSA==
X-Gm-Message-State: AJIora9gFbvFuSTauQ66km4692VD0WtgW5mgSTy0d0HYQyowopr1t7M5
        CdQaqvr3LYHOEi74pIX4nVc=
X-Google-Smtp-Source: AGRyM1t8i+0IphHyY3fIYU+4aThV8ty0uI0+VTr4+grEjDsFTrvFyi/WEC6m4cWWOAgoVt0bqNn5HA==
X-Received: by 2002:a1c:7407:0:b0:3a2:e260:5b9f with SMTP id p7-20020a1c7407000000b003a2e2605b9fmr11555719wmc.28.1657533608047;
        Mon, 11 Jul 2022 03:00:08 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id p7-20020a05600c1d8700b0039c4d022a44sm6331736wms.1.2022.07.11.03.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:00:07 -0700 (PDT)
Message-ID: <bb1c85e4-50be-04a5-3c9f-f4c4dab6a50e@gmail.com>
Date:   Mon, 11 Jul 2022 11:00:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <pull.1272.v2.git.1657297519.gitgitgadget@gmail.com>
 <8c24cd7737b29d461788b71f6a94eb74c468ad33.1657297520.git.gitgitgadget@gmail.com>
 <220709.86v8s78chj.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220709.86v8s78chj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07/2022 23:17, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jul 08 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>> the rest of the codebase but returns −1 on allocation failure to
>> accommodate other users of libxdiff such as libgit2.
>> [...]
>> +		if (XDL_ALLOC_GROW(cf->rcrecs, cf->count, cf->alloc))
>> +void* xdl_alloc_grow_helper(void *p, long nr, long *alloc, size_t size)
>> +{
>> +	void *tmp = NULL;
>> +	size_t n = ((LONG_MAX - 16) / 2 >= *alloc) ? 2 * *alloc + 16 : LONG_MAX;
>> +	if (nr > n)
>> +		n = nr;
>> +	if (SIZE_MAX / size >= n)
>> +		tmp = xdl_realloc(p, n * size);
>> +	if (tmp) {
>> +		*alloc = n;
>> +	} else {
>> +		xdl_free(p);
>> +		*alloc = 0;
>> +	}
>> +	return tmp;
>> +}
> 
> Whether you agree with the entire approach in my series-on-top[1] or not
> (and it looks like not), this way of doing it seems needlessly complex.
> 
> I.e. the whole "pass the size" business is here because you're wanting
> to use this as an expression, which ALLOC_GROW() isn't able to do.
> 
> But you've also changed every single callsite anyway.
> 
> So why not just change:
> 
>      if (XDL_ALLOC_GROW(recs, ...))
> 
> To:
> 
>      XDL_ALLOC_GROW(recs, ...);
>      if (!recs)

Because I think it's ugly, we'd never define a function as void(int* 
result, args...) and I don't think we should do that for a macro where 
we can avoid it. The existing ALLOC_* macros make sense as statements 
because they die on failure.

Best Wishes

Phillip

> And do away with needing to pass this through a function where we get
> the size, and thus losing the type information before we can call
> sizeof().
> 
> Then, as that series shows the implementation here could be pretty much
> an exact line-for-line copy of what we have in cache.h, including the
> same alloc_nr(), all without casts etc.
 >
> All of which seems much simpler than trying to maintain the constraint
> that this must be usable in an expression.
> 
> Your commit message sort-of addresses this by mentioning that this
> "returns −1 on allocation failure to accommodate other users of libxdiff
> such as libgit2".
> 
> But since libgit2 won't use this, but only a copy of this xdiff code in
> libgit2 I don't see how that makes sense. We're only talking about using
> this in the xdiff code we maintain, and even if libgit2 wanted to use it
> it could deal with not being able to use it in an expression, no?
>      	
> 1. https://lore.kernel.org/git/patch-5.7-3665576576f-20220708T140354Z-avarab@gmail.com/

