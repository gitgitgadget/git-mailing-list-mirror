Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6186930C629
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245678; cv=none; b=kqaJvDXpc/ytRiaqBlU0twsmrJFwIU9s45H3YoDoMM8vWK+iurk0rQ+hQQJG5zGRGnT8nAY7ca6PFH0++OupgQLQUg/oqEEW6g3+NnuaIfyvuNiqxH+r8qtPlGRJwhMhYhAs5AFyN4itR/JDD/E6XqeAZJz84dGx1HoTfSzzlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245678; c=relaxed/simple;
	bh=TRdhYlHlC0xJohJE+9qSjFfLXf/W14/yw/42wCjK3s4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TJk3L+VFyoa8t1F+rnfrrml6nifiz0jNWBjOhvorExpFhoo6+uJSpsYGqT6/tyU1w0yvvoyqu2DQUHpHIhiPyC/fYjXo0kU/5DjSVTuONHEQ3T1+5PFyLeQU3lDsbkIe7nJkwz+pIP1CyVStoSXwGuGoBfO66o+cS/AQUGIl6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSmpEN3L; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSmpEN3L"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d03db7f87so4076606f8f.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776245676; x=1776850476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AdsMUXX2bveG1YvnYdYjVMCzOmufPFyVPR69BGfVEk=;
        b=oSmpEN3LLC3Ab0dd9nw2mhijsKxjkqxejktaOEAyYsnqE4GDxSkzJlY73xdPy2trHq
         0eJeZ7spoOWd8/xazNQuw2Ov64cguceIag782VMse+rb/FAUeLoJCzvJWeD1ce5s6Aq+
         yyTJh335xcRowoMnzNHwvGAq7lDet6eH7Z6Gu3oThxE47jbX4d06IaQEE3hMloPvFNEH
         cx3LzfF6qo6YbmMpMooSb3Nadzq2I12nD6mGLnSn30eTP/SBoCdGlG1mR3GAPGHFRQEJ
         yfl41YgvQ+6vrRSbmjzh3B0yK/GZywJqghijoTSx/DqVvDi1io+B3CjJtFOYVfCJiwhq
         N8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776245676; x=1776850476;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AdsMUXX2bveG1YvnYdYjVMCzOmufPFyVPR69BGfVEk=;
        b=juW5oGdKW/73iVTVAYeOOvIr2mfLHSrkiXzpMDfiUQkhXO47pus78PVOnQKXcxahet
         KtFxj/cZf3tUzTaPgAnVarBueS9eH/rx4WWahkQQ63k0Xm6GLHbXClBbgZX8YOrVVnvt
         3NRIRq+oZBLeOMhZXDqhPeWXoPsJlzEOYjd/SHbZnwXTM6vxjUHEWoyyTw0ADsosFqJF
         lXnFYuv6zhMJtQAU1byDLx6cX6uGYSl4FP/E+sa82eGWjzAQ3ey8WU2kGWhsCQ66NMRl
         aPVcMe8JJ2crXgYMkdKEdjh+zM/gWwtm4/SezlPlBDqhxPKUvIwklld9IkHMOZ1g0p0z
         GKjg==
X-Forwarded-Encrypted: i=1; AFNElJ9EwHeimAj87iWGTtbC68tNwzc3oi8jTvKAEvZd+AHTLPH9tbu1EwIeWVPfNeksVtPKuJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHt9ZdQfC0br2PyA97vFCVVwt00e6s4k7sTDtVyZOfBK6axdww
	SQ2/ITTdpJMqyJX5etP/89sR8at7kcmX3DlahHQW7IZK7ucARpYlp17i
X-Gm-Gg: AeBDiesjpZFrQ52RXwR1MGoI1qK7NFgXY3weM47ma0L/Lvb9d+SZHQZ15PbvvFoKV3q
	c6vtdLSOsBDBrgy2aRzYFic6RHlIWBSn9zqSKQWBJwEccFc8VEAyOdCfVaV4qMTl5Y77OmsmyY9
	Nfsa3B0IX3vN63+/NWCN1rcQNgAFEzH5ebrMx9O62ebJ8df9XJ4v+gWDWYd8M/X3yt7a8IsLAgq
	tpNrnrvJugjEkiXPZ1vEpB2tPsf/ET9cBTkDheMUDP1qr/iuepNyRzL1yBijTpetUjBG8pFn9IS
	i+2JJ9Mxx1ZTJwEDLGf3AIqV9lPPwkLVmmX9wyovtUc7VSIjvT9e6MQCTcjFjAD3dBKMs8HGy1s
	y1TRFwcSH61Sr3gNVimKB7u9ECM3sOzwdlYnZ3Am209UcXxi197jB9T7S6dpjganNkUkPrT63wd
	WFUcYjOhTvGJy1UVm8UDI8hvfCjGeQ2uX5bBmYkG4TgTuheNaisUn51yzlCfxLX6GReFhAz6y+/
	XTH946ZMrF/Mg==
X-Received: by 2002:a05:6000:2288:b0:43d:7508:c9b9 with SMTP id ffacd0b85a97d-43d7508cbaemr20168308f8f.49.1776245675547;
        Wed, 15 Apr 2026 02:34:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f11sm4035285f8f.18.2026.04.15.02.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:34:34 -0700 (PDT)
Message-ID: <516b88c8-ebc2-4d28-9a00-4149426ad43c@gmail.com>
Date: Wed, 15 Apr 2026 10:34:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
 peff@peff.net, phillip.wood@dunelm.org.uk
References: <20260414201327.51745-1-haraldnordgren@gmail.com>
 <20260415081900.86956-1-haraldnordgren@gmail.com>
Content-Language: en-US
In-Reply-To: <20260415081900.86956-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2026 09:19, Harald Nordgren wrote:
>>>> +                     strbuf_addf(&autostash_msg,
>>>> +                                 "autostash while switching to '%s'",
>>>> +                                 new_branch_info->name);
>>>> +                     create_autostash_ref_with_msg_silent(the_repository,
>>>> +                                                "CHECKOUT_AUTOSTASH_HEAD",
>>>
>>> It's a shame we have to create a ref here. MERGE_AUTOSTASH exists so
>>> that "git merge --continue" can apply the stash once the user has
>>> resolved any merge conflicts. We don't have that problem here because
>>> there is no user interaction and we could just hold onto the stash oid
>>> in a variable.
>>
>> I don't know how to actually do that. Maybe better to do later?
> 
> A gave this a try, but it becomes a very big change. Or maybe I'm missing
> some key knowledge here.

Maybe leave that for now then

>>>> +                                                autostash_msg.buf);
>>>> +                     created_autostash = 1;
>>>> +                     ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
>>>> +             }
>>>>                if (ret) {
>>>
>>> I'm confused by this - if we stash then don't we expect the call to
>>> unpack_trees() in merge_working_tree() to succeed and therefore return
>>> 0? 

In that case we apply the stash lower down so that's fine.

>>> If opts->merge is false then we should not be trying to apply the
>>> stash when merge_working_tree() fails.
>>
>> Same here, I'm not sure how to get this to work. Maybe better to do later?
> 
> I think I succeeded with this one.

This one definitely needs fixing but it should be simple to do as I 
think it is just a logic error. We should not be trying to re-apply the 
stash unless we created it and we can check "created_autostash" to do that.

Thanks

Phillip

> 
> 
> Harald

