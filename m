Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C9412BF1
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231398; cv=none; b=j0gA7bL4aJLgjoRLstbnCK4Y/0NDwLi+ckkbk8vlkzN1rkDmXeQmP++neNZ2hfLhOWJygO2BIIIkoHsNIo3u5VLO0M3Otos9ogprK34O4u0tys+mrV2vUppNtl2EX27n+0TtpWxZRS21PM7mXriz6Q/NlTiH3iXj+QhXo2dbUVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231398; c=relaxed/simple;
	bh=t2gxvPnk8Cc9en8TzCZi46VkBWCvGhP+ExDJhzYvV3Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fzRmXoeK3+5KswjZeIwlR86L/TO9zzXeVtwvmA8WJUHNiYw6GBCl0HUiOHXNYT/g4T3+HyGGv81qoEiwAi8k7DQ044w9vzvXE49AktoxKtz8yfqAAmwjos2SnRjRucDWqkfYSpcwxEPmRiLAQZEbvU7pN1bb6jCTesLsGTpzuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgiP63n2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgiP63n2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-471eeac43bfso3168211f8f.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231395; x=1785836195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYQqst6ebpVvxnWm6S1WmUCGx2LGNKSfNVQ9lBLfmHA=;
        b=IgiP63n2hGaptSmPZWCmCoJaS9Jgoq2UJKj95mnbd6ehH/U2xjxhfrdKGiMt1Bdm2x
         Tq1/vuQM5VPJgtbO8ooIJ7DkLueup571tbdz5OikLuNEYKyCxeIy74q5RCFhbYNpkkco
         DX+jXAbhp+gnzctb9y5dqM+KN1rhpV3aLAaa7Rwt0m2FY4WweimVdYaPTeEAZPi7yRFp
         m8jMxfWzMOero/sj0E8wT7k1O6S7YPtXzxvRFOTmwVpVWK8NBLIBD9ncauCZUbeyZiU5
         tWm3bWLhSUdhMA1k0L9/kM3O3Stso+ryK/+cM7lYN7JC7RxgNXvuhdP/Ec8VDkUHs0Jk
         Dsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231395; x=1785836195;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYQqst6ebpVvxnWm6S1WmUCGx2LGNKSfNVQ9lBLfmHA=;
        b=E8Qplph4pK14yx73u2gZ8kWwZb74lZJFnzdWidhP9Pp9yO4uFSk50tsP2ygpwYRx8m
         5eb2biGowm0lAlEdPp6YGfOm08SdbzfUv80BVSnrm205SJcA+Xo/l/5OGpaqRMURK8do
         I9dv2Aplc77JkFxNUAJF+gOMzEk3xzl2H/6yQWFJoygFKUxulWtv5ZXsTzCpgfoK1FKy
         HA7wz3GqBxv41dX22bUpghK5Bims/lHDIQw2G/NDU2fMh4pkqCLzHLwM6PUfIdO5xMil
         rN85HBM7GK3Hzl14/O045rGdKw2dS/cxDxTRq/51/FdqO61bzmkcSm3GsP19fq356D3N
         G/Hg==
X-Forwarded-Encrypted: i=1; AHgh+Rry7upkB6BXKlqTw5g5KQwwIcZiVRgnhCoipABaeyf1EapGQDi9vHCZLZRasphEXIgAL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYe/wTBleo1S/xVpmPrZaYNQUiycmCGjtu3dV63vFlUNH8fM2J
	umPXH4fvpgjhuI6x3dWw16V9WW7woSYkzlc4cFbI0jEdqRSPoOv+qD8dUMjqmQ==
X-Gm-Gg: AR+sD13nUIbzNte1/wRi6KjiIjO8Ox7/g76wJlA3BUQi9/33EsA9Tws9p2e43NaRJPY
	3LnpRqvyAKJKtTu2StoPCL/1/2dSm+1nY6oP5NCMUKovZOWCZ90etGlHkWc09heS8wXk1e+nlDl
	R3QHThIuKN6xKs6I4+JqRgX6TBeKs30iSAiPofLY1PCXJqrEVI2XiZHgMlxvIsTV+DVj4xdv4Bd
	GGbeamGK+ih9jQX1uw+zF4xAOVaTgxT8Gj629VxpKv/tyJi42eqYMc0cmwVzoc8h/DxrkSMbMUr
	37DB0R0WVAZ4PpZZ/Az8WV4PkgmwOq+kuMLbroSr2TqVbZLiweVRBkUnN0pr1Hu1/Rlzr4ME7tQ
	Ve0fhX5t96DA3hVcajTBY/3dHTwsC4PHiW1PbWdz0KAgg5te4mGgjMG/82/QBGo4WF5L7OJmrCH
	ANFsCp3hgZRYnYkLHgVoOKrBE79+jeiqifRqnmZYuIJXz5XsS0b4Xq3oN1fDpRMgqvT0Y=
X-Received: by 2002:a05:6000:22c4:b0:472:fe1a:1ee9 with SMTP id ffacd0b85a97d-47fb1ed8039mr1805613f8f.20.1785231394735;
        Tue, 28 Jul 2026 02:36:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f9c4fe4c5sm37034670f8f.12.2026.07.28.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 02:36:34 -0700 (PDT)
Message-ID: <8631114b-aa6f-446e-9710-92c400320eac@gmail.com>
Date: Tue, 28 Jul 2026 10:36:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
To: Junio C Hamano <gitster@pobox.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
 <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com> <xmqq7bmhycxq.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq7bmhycxq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/07/2026 16:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> Thanks for re-rolling I'm pretty sure the logic is sound now but I'm a
>>> bit confused by a couple of things - see my comments below.
>>> ...
>>> It would be nice to have a comment here explaining what we're doing.
>>> Also I don't think we need to copy the refname so it would be more
>>> efficient to use refs_resolve_ref_unsafe().
>>
>> Looking at this again we cannot use refs_resolve_ref_unsafe() because
>> the result would be overwritten by the call to refs_resolve_refdup() in
>> branch_checked_out().
> 
> Makes sense.  Thanks for raising a possible alternative and then
> clarifying that it is not quite workable.
> 
>>>> +        /*
>>>> +         * If the branch is the current HEAD, then it will be
>>>> +         * updated by the default rebase behavior.
>>>> +         */
>>>> +        if (head_ref && !strcmp(head_ref, decoration->name)) {
>>>> +            free(resolved_ref);
>>>>                decoration = decoration->next;
>>>>                continue;
>>>>            }
>>>
>>> Then we check to see if the decoration matches HEAD which we used to do
>>> above - I'm not clear why we have moved this check.
>>
>> Should we be using "resolved_ref" instead of "decoration->name"? That
>> would explain why this was moved and would makes sense as we resolve
>> symrefs when reading HEAD. When HEAD points outside "refs/heads/" we'd
>> then skip updating any symrefs under "refs/heads/" that pointed to the
>> same ref as HEAD.
> 
> Yeah, decoration is very much end-user facing and if we can make
> behavioural decision based on a more stable resolved_ref that would
> make it easier to reason about.
> 
> But stepping back a bit, is having a HEAD that is a symref and
> points outside "refs/heads/" an invalid state?  Why are we catering
> to such a configuration to begin with?

We allow HEAD to point to anything below "refs/" - see e9cc02f0e4 
(symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13). I've not 
tested it but looking at the code I think rebase handles a non-branch 
HEAD correctly.

It would be nice if we didn't have to worry about non-branch HEADs, 
recently Caleb reported on discord being surprised that git allows HEAD 
to point to a tag.

Thanks

Phillip


