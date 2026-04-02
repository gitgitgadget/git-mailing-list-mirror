Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E13EFD13
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142354; cv=none; b=GtMLwjUJHx5fj8bfsPF4w/ntIJ60xdJ0hE9OIRLL78WfLUTBhfa8GcQF0NCBOtoY8SC8S+HQZ+M+AFC3M9skdgR0Z0wAACGSitowuT6eLiq//mKoPf9G0SfUumvp0z0QQSO5S8APPPL8kwgDhK5WPSaBfg8sdiogtNuTygr2XZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142354; c=relaxed/simple;
	bh=NsxgfpzQ2dSL9ESc+UXXA71mMwKjkuhlvidoov1vjsE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XrrgMIAlq5sMiuMqmsAZq6axEGLIEiIbjku+6FXkRJZChHZntdB1hnGrcVf/P6WaU+IAYFQn9KMtlxh5c5dXoiUybfCFfnkbdTVpnyXrbFSfiy/uqmti14amWQhiImTB14hWAuBW78eLg+gIa0f1YQD39J/LDTF1eNl3Rd32R1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn+NwBpY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn+NwBpY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso621711f8f.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142351; x=1775747151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwsbhQ3zhaYm5gu8ywEulUc/ivyCq+sG47cjvdKvvr0=;
        b=Fn+NwBpY26wxeW66DRFSpcmVmPmpoUQo77+ngv+FCFWhRcCLEHF1NwnT6xn5W5Yz1u
         i7TKSStBEg26U1v1JEnkfNFW4ur502t0cw1S/b8PgwQsSxKSuGE8zHShq9aSGDTTIgZ2
         gxyEneUzKKnj3+FVcN+6Mfs/Ik5b75HaAFZlovXG7Ah11dihsPznrOxb2KjTyeVYpZzK
         Ju+hDJCsWQ9uD/wUX5QwrzmfM7JHYfjuSOd/wQ9aYAfHcGrIhGqpaOIRSLzsdr+i38k1
         IfuOZOESJR4uRcspbMmgG3cBUIIbq29hoMrUprLlveMx9oNsv6MwLHOkZeyMyfynhbTf
         rXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142351; x=1775747151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwsbhQ3zhaYm5gu8ywEulUc/ivyCq+sG47cjvdKvvr0=;
        b=S2KI0wyUxA1ucHAhIcmTUR5NDsdpt/EVzwIGhg+5cwstJThXsvSgqbu320FBB20p20
         mopjfIO3ZsAEy5eB2I1Z/WmTwTZvzJXywm4HheLqvtWz/BzvQEILuFtWESzJIv1tv5c8
         EtiBQ1hmLpHYq541+ezBpnmuNpByT7hwN1dzl9dTQ00bVWAQLKT57h6zT9wEwZWlLTjx
         8Q4w2bqEUGPjK3TbVhJsnbKi4Nd9wPWLvCdO3E/DQJK/lDQiDAgHs4HENpWdjOiRDj9k
         f9X3HRmfgGFsGbOdQydGlkw6T9YSaz4E4yAs8VFUaU2yftDC7GFj/uH1On9aISVFqRHh
         7zdQ==
X-Gm-Message-State: AOJu0Yx1RPAMSNfpDW7eOCRtlJgod9CiCAB1XliNtdEaxeVnbrcgvK+C
	l0Bf1vM2ZWjijpUh11hB5oun62+S83AJX+tUyPk1gWfH7lKXhVyhahxk
X-Gm-Gg: AeBDiesMQvxSJzGDyK6Mm6uG/fWKrBrqOFG8hQvWa4W5NnDKVoOSW/BPzPD7HRCNb3u
	3UvEzBetY63ltRfgKAsVCfZSHIdhljlectZs3ECEsjTkXB9kBPftz0B8v38b+2PFeDrUNhKpdj6
	VClg2gV+Dw7+gIsWcFVZv3v61CZFu9ONw9qAouYkdaXSoCtmDn92DvR50ctJEAd75Dm4TgiwzAK
	0S9NKsUlo7KL2WDAiF++FV+KriFA5GNlrQ6CyMii5AqcWq/id4wIQ1nk7CRtNhj1NTAzHwi0UMj
	Sezy0jCOaxX/XNVoJhuql2Vv2Oz9mHO18B6ArJ+WHH3kodxtSYWY+MOvd3Ma0u2P2x+hKiGtlEZ
	Gyc7kwSxTjG8NgkmTIKCSET4LGQmV0XEYEgOAMmfuqtoxV3f16BzYnFXfPsAVOn+AiW7BDb5L5z
	DifIOSUsNL7i3J1/RrJefET8RPYrlRVb7lsALurie+nWoUGpiAmy3WsvK3HoDzLS+lBlgaujAyL
	NE=
X-Received: by 2002:a05:6000:18a8:b0:43c:f583:126a with SMTP id ffacd0b85a97d-43d15062d30mr15614518f8f.14.1775142350811;
        Thu, 02 Apr 2026 08:05:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm8753341f8f.21.2026.04.02.08.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:05:50 -0700 (PDT)
Message-ID: <49834347-8049-4a79-8bdd-4da1ec1ebac0@gmail.com>
Date: Thu, 2 Apr 2026 16:05:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and out
 params
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>,
 Michael J Gruber <git@grubix.eu>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235017.GH2328529@coredump.intra.peff.net>
 <14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
 <b77be594-83b4-4d9b-9f89-569f1f335d61@gmail.com>
 <20260401192423.GA2905896@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20260401192423.GA2905896@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/04/2026 20:24, Jeff King wrote:
> On Wed, Apr 01, 2026 at 03:04:10PM +0100, Phillip Wood wrote:
> 
>> On 01/04/2026 14:17, Phillip Wood wrote:
>>> On 01/04/2026 00:50, Jeff King wrote:
>>>>
>>>> +/*
>>>> + * Check that an out-parameter that is "at least as const as" a matching
>>>> + * in-parameter. For example, skip_prefix() will return "out" that
>>>> is a subset
>>>> + * of "str". So:
>>>> + *
>>>> + *  const str, const out: ok
>>>> + *  non-const str, const out: ok
>>>> + *  non-const str, non-const out: ok
>>>> + *  const str, non-const out: compile error
>>>> + *
>>>> + *  See the skip_prefix macro below for an example of use.
>>>> + */
>>>> +#define CONST_OUTPARAM(in, out) \
>>>> +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
>>>> +#define skip_prefix(str, prefix, out) \
>>>> +    skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))
>>>
>>> This is clever but it changes the behavior of skip_prefix() which is
>>> documented as not touching out if it returns false.
>>
>> Sorry, I've just realized we always take the other branch so this does not
>> change the behavior and is in fact a nice solution to the problem.
> 
> Yeah, exactly. I was curious if the dead branch would be left in place,
> but gcc seems to prune it even at -O0.
> 
> I also pondered whether:
> 
>    (*out = in,out)
> 
> might be a problem, but I think it is OK. The "," is a sequence point,
> so it is well defined (of course we would never run this code anyway,
> but if we have undefined behavior in the code at all, it may cause
> confusing effects).

I agree it's well defined and because this code is never executed we 
don't need to worry about evaluating "out" multiple times. While the 
message from using _Static_assert below is nicer I think having this 
which is simple and works with all compilers is a better trade off.

Thanks

Phillip

> For reference, this is the more complicated one I came up with:
> 
>    /*
>     * Note that builtin_types_compatible_p() counts "char" and "const
>     * char" as the same type. So we deref and construct our own pointer
>     * with const to find out it "x" is const, and then either compare
>     * x and y exactly (if it is const, they must both be) or dereferenced
>     * (which lets y be either const or not).
>     */
>    #define CONST_COMPATIBLE(x, y) \
>            (__builtin_types_compatible_p(typeof(x), const typeof(*(x)) *) ? \
>             __builtin_types_compatible_p(typeof(x), typeof(y)) : \
>             __builtin_types_compatible_p(typeof(*(x)), typeof(*(y))))
> 
> I also tried using a gcc statement-expression and _Static_assert to get
> a nicer message, like this:
> 
>    #define CONST_OUTPARAM(in, out, in_name, out_name) ({ \
>            _Static_assert(CONST_COMPATIBLE((in),*(out)), \
>                           in_name " is not const-compatible with " out_name); \
>            (const typeof(*(in)) **)(out); \
>    })
>    #define skip_prefix(str, prefix, out) \
>            skip_prefix(str, prefix, CONST_OUTPARAM((str), (out), #str, #out))
> 
> It does produce slightly nicer output:
> 
>    foo.c: In function ‘bad’:
>    foo.c:8:9: error: static assertion failed: "my_in_var is not const-compatible with my_out_var"
>        8 |         _Static_assert(CONST_COMPATIBLE((in),*(out)), \
>          |         ^~~~~~~~~~~~~~
>    foo.c:13:34: note: in expansion of macro ‘CONST_OUTPARAM’
>       13 |         skip_prefix(str, prefix, CONST_OUTPARAM((str), (out), #str, #out))
>          |                                  ^~~~~~~~~~~~~~
>    foo.c:16:9: note: in expansion of macro ‘skip_prefix’
>       16 |         skip_prefix(my_in_var, "foo", my_out_var);
> 
> but I don't think the extra complexity and portability headache is worth
> it.
> 
> -Peff

