Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83936F903
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489480; cv=none; b=hVpXilX1wqWGvJmvIotRLb20mp1k8ZZ46+7Dowk2yAkluACqhkUcqs8yocz36L1D8KHSFmei2GEEtUeiQ3RNX/XdTEJ7F76sD5Dt/tbYAE0kYnEzV/8rC5h31ISfdVhJqEWtu+XlQ87jgBZGvXEK2AByXs/11+Ovl/Iwj2oPeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489480; c=relaxed/simple;
	bh=YNYmL3fwErK1wmOcLRH51MRie6YMZf1MDzKtcdchMj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E98BENhfOcolCdK2jw64qn7zh/slyJKmYv6e8b3JYXlgvyUT697OiikUb/sVgk/36dMEG2pK3Vp3QVZaN92wDTmxPuvhg8E2SCgUWfVtc2JRRqaX7Kbw8lMWep4wSPrgWaQUCowCHD80j2HuETEL6QjVhfAIrVC85qCKqzv1QQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZADbb9h; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZADbb9h"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dc67a5e102so65805637b3.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489478; x=1781094278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCMlmb8npyt39Pe+yqqZ3o2Ka+e1TXL0zpU8vOd/3MI=;
        b=cZADbb9h0+ZZlyKhMw7XCidubPxBUnsN8iAWCqGHWKnLXDuQa9ra4Bv5Z3n7JZzLRU
         1eUu7l/Gg0Lsg+vL+gNzbWzxNIw6ZbmwmUcBhtWefqQaglXe1u2k00OMVnp2sA+h4KuH
         bOTL/5wD1ouzPczzYfeV5zPKYrqJLs3OvK5HSVRKLnarfygmXXoKfDdYRdU/C1qCIL6f
         aFMRP2JKbK5s7b74u4gufDTNeE1ob3/iIIMBAIqJrF4YiR/fzex42KePjLu7J0J+tQU9
         PgisiBPvzGUdK7liPHELuuMqxLXHr11yMKlAKnucCEepYGCkbqGEcGCRM0Utzo5vWzEH
         K43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489478; x=1781094278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCMlmb8npyt39Pe+yqqZ3o2Ka+e1TXL0zpU8vOd/3MI=;
        b=Ivg7K9uEBs7TFNeeyVKE2Rtdcj9d3W0vbuk0R8HrrRrrGsN3nN/V4GK9RUxGzCM57k
         izRyt7yTNszfPn0/qe8l/yeH6EnHV2XFpaQefyvW0bvLQOIfAczUgQDvLQH9jtkR+/7Q
         xhEmK196DEvSQAowmISln5xhZioZ2LzzdSDD/G6sROdX+Md1jNwNDTLZS8WhscFse88a
         5gvqLF9EuARbBY0YNxmOKlcZFV+eobu/+uDirCI2+sohMzPVLTmBn7QpLDt4Xv+Bx+x6
         YOcANVSgKO2QIBdsXrGdMbqH+ioVjjK+dMTw7tOIrTyA1muE7aiKNjQjv9G2DLJfh7c3
         WqUA==
X-Forwarded-Encrypted: i=1; AFNElJ/2UfnytmmjX4tAyoOoLeT8PtU/0G04uLrI6kJ2kRHTeeFtHNox2xmQ8e/QFZU1LUhBzMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZpdgFy4dntiODmGINZUm5CGVas3gNUCdNA9nHw6l45z+088I
	rI5+z5OWGrASuYrJ63Sx7h4trQRf3+pw4wiwUMFqsQ/DHptQeMDmpk8sU4Slfg==
X-Gm-Gg: Acq92OEc5zwj01iVy/4Chbb80EU652I2TJNBWmNXoLWnrGbRjGnJXCypJwbIhmlFfPr
	KeedKRStI3E3mUditg8a8bAvB4pqiJnqdnIPQxhoPS4fSfeObHBSmLKPRGsEr5QAYW3Q/KEx03y
	JYYIorabaXpG3cV7v55mtkZO9o0LzIsv3snNCfqYUREo92d6EaSONzmWa+YAOzVm3Ok+PyD7by5
	salyEbt6/MZUS/xyYYRxul0ob/aPvAgJDHaRZzhw1lvHp1lNlUbrU4ttARu3H71Z/ulmZo9Uhdc
	HOmzwsvUIHTOeXhTAyjwMqgMPq+eq6N+sNFrwS3pHJFs8bCgvefq62mTgRYwPEkOkvN6fitAvnU
	y4gBZd3Lly+4g8ugUEqXTw/1XYpbANkPBkb4XfUVMPygv0mL7i9z8AH0hCqEYrWvZLEa94zeIuE
	rE1ITL9/GfIz/hmUcSidE/SkP2l329gLTdJ5R9NbY90zoi7zYDG/JpGMhlL95izMf5v3gfV+idy
	gaAEq1CKY52IapX
X-Received: by 2002:a05:690c:6f05:b0:7b9:edca:bac6 with SMTP id 00721157ae682-7ea478f292dmr26824067b3.15.1780489478079;
        Wed, 03 Jun 2026 05:24:38 -0700 (PDT)
Received: from [172.16.8.28] ([76.182.66.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8d0dsm14913637b3.6.2026.06.03.05.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 05:24:37 -0700 (PDT)
Message-ID: <c4a32a6f-70bf-4ff4-abbf-d6e301246b5b@gmail.com>
Date: Wed, 3 Jun 2026 08:24:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
To: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Arijit Banerjee <arijit91@gmail.com>,
 Arijit Banerjee <arijit@effectiveailabs.com>
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
 <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/26 8:05 PM, Arijit Banerjee via GitGitGadget wrote:

>      Changes since v2:
>      
>       * Addressed Jeff King's review question by releasing cached base data
>         after all direct children have been dispatched, while keeping the
>         existing subtree bookkeeping intact.
>       * Re-ran t/t5302-pack-index.sh, p5302-pack-index.sh, and end-to-end
>         full clone spot checks with the precise-release version.
...
> +static int base_data_has_remaining_direct_children(struct base_data *c)
> +{
> +	return c->ref_first <= c->ref_last ||
> +	       c->ofs_first <= c->ofs_last;
> +}
> +

I'm glad you were able to find some bookkeeping that already exists to
help with this decision.



>   static void prune_base_data(struct base_data *retain)
>   {
>   	struct list_head *pos;
> @@ -1201,8 +1207,12 @@ static void *threaded_second_pass(void *data)
>   		}
>   
>   		work_lock();
> -		if (parent)
> +		if (parent) {
>   			parent->retain_data--;
> +			if (!parent->retain_data &&
> +			    !base_data_has_remaining_direct_children(parent))
> +				free_base_data(parent);
> +		}

This appears like the correct place to do this.

>   		if (child && child->data) {
>   			/*
> @@ -1212,7 +1222,6 @@ static void *threaded_second_pass(void *data)
>   			list_add(&child->list, &work_head);
>   			base_cache_used += child->size;
>   			prune_base_data(NULL);
> -			free_base_data(child);

And still we don't want this universal free.

Thanks for re-running your performance numbers after this change. I didn't
see any significant difference in the relative changes.

I don't think we have a way of measuring "memory pressure" during the
performance test suite. Did you see any evidence that this change has the
intended effect of reducing process memory proactively instead of relying
on the cache evictions?

Thanks,
-Stolee
