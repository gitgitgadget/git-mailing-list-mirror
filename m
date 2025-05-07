Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849D288CAC
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625670; cv=none; b=Z+EyI4wRy18xJB7dXZXE/5kLTuREgLQlYyCFWKebuMeq15lShICxA8tF9mxfAFQwi+YMVZT9BD6C7VPQvYU53IJo1zDCDJr/9klRmYcFhD1pjB4Bt0UOKdLKyc4Fr8qfYr0t5vJDMK7Raeby83l5H4WDb+7a/lrJU2QQtyZhGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625670; c=relaxed/simple;
	bh=juSdwUN9O8SoN92ZLdZ76Yc7eCPyPFuReY3unI1rF88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUafvRy0vt/KaYO0zwvyFw8bdp6CqkJERGhGzQtw0QG2CGxEvpmA8Z/kh9nzU9lOjdjvva/ZoMjPcq7zAlcTVTcvjgGxmCXoDmLWOVPeXhg/sAVJ2IzY4OeL+TOUcxF3NXtd3FLRuhrvLjygwpx1KRBIhqXaV+7+m1TGaoIaFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxBpZQMZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxBpZQMZ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70811611315so56383407b3.1
        for <git@vger.kernel.org>; Wed, 07 May 2025 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625667; x=1747230467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYnhrXJCsdfE0IlV8mE+MRGrEeaMjTXZ6SunLSNjuoM=;
        b=WxBpZQMZTvNcDr43l2TMsl3s2ADKdS23AD4STZflCt8zxRkk0rryCam3a26T8Jshmp
         ZHy3F8/aJPfK+i23toe2BIcrxXZb/aOc8Nww1YfWhW0bC88JpIDvfCsKN8FPClqgQwh2
         09JOh13EinqcfbXQyhz6qmit98VuJor4Cria+/GSOgp1v0qkAM1UzAvTQP8ClyXXkU9N
         9eipsiXELsXM7SNlkyAZhICTEyOySUt9vs94kZdtSv0D03jFsneiNhsXmrtDiZNyZ+oL
         VLnF5vMPEYMnsTmyTICHkcaQ+Vn3LJSo3k+VCvu5E9jddoNKvou3MsdQ7hxVOBtO/9s4
         /2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625667; x=1747230467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYnhrXJCsdfE0IlV8mE+MRGrEeaMjTXZ6SunLSNjuoM=;
        b=k3bms8cH/ty5+FJNPcSj8L+0pv9jl3V44GFEETvPtxFgdkV5et0HA2ykn0wV4eBRr/
         LTpuweObkhxryOfOlqCslUx0Oo+OKMVwwQOLNhVG9djNpfb2Fxe9MtduprVSaNQcK4gN
         Ry2qNwmKrA/mN6ASlM5Gb21K8FDzfWMU6YBJ1Dtue0OxrAO0PMmPnSoKXt6VOU8GX0kI
         AfSUXqSmI/89bU04aN/JOz1DVV2Ljzuqo292gTTHfKbg9l410rVVL1/c2A9C0pJbeyKW
         FI9D4DDEcCHimBChNzA3nW605IvctrSn1zYLhJWjJ2hpyxya4XTAOWWxZOFh/T5/nlLq
         V6SQ==
X-Gm-Message-State: AOJu0Yygca3M9To4m1sIW6Gvm1ueCbhwE2qIwYKqrZDct1yreJECd83B
	TFKa+d85wyzB29RR4hjThC4aBFtDJOmzyXgYUBnTjFPSn98I7GZa
X-Gm-Gg: ASbGncvyq3yOboW1GACS8sPD8yAI6xj+imGPyCxmvsSqFutK6W+snauruvWvmb+erCH
	qjUWzMBEIM046/svVOf26pJ7BkatpfCQaP4k5dOrEw/ZDAYKsBy4ksKu5c/gIapyajNvjET7pCo
	qg+I5WdQspUSbHcqTOsLVeH+jYkkP43ebTxFnOA6Ari5fO2cysZvivpaWONW9Qxcbm/L9MfgF+q
	FgofY1BTCTKtyjZvQ6XPdNiZysIN7DfK3WMfSbSMGIeGOjNnMJhl7mcnE9DCa1fALMnxBpMDr8J
	319+GAHedY6LR57JEhODNgYYNZigVSnU00aTzgNRGX0ysAXTSHMv1JXLc9WWTqkiyA+PSvmy9WA
	MJyeHH4Kp4Lj1uQW6
X-Google-Smtp-Source: AGHT+IFehaEvhfXFzmdFyKsp40nZ+64LJMbxpTBawh9MYz1o4Op1dVEu0R5AwYnGEVocLmMtNWo2Ow==
X-Received: by 2002:a05:690c:690d:b0:708:cd31:88a9 with SMTP id 00721157ae682-70a1dadbddbmr46282877b3.37.1746625667373;
        Wed, 07 May 2025 06:47:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b924:34fb:fbd9:4309? ([2600:1700:60ba:9810:b924:34fb:fbd9:4309])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c415c9d1sm32224397b3.66.2025.05.07.06.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:47:46 -0700 (PDT)
Message-ID: <43b5bf20-89b8-4eca-a952-0bcc28a23d19@gmail.com>
Date: Wed, 7 May 2025 09:47:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] index-pack: allow revisiting REF_DELTA chains
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
 Patrick Steinhardt <ps@pks.im>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
 <1358039b2f3bf893fffc63c1065f1d6862b74957.1745871885.git.gitgitgadget@gmail.com>
 <aBrAlc8k8uxzrIV9@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBrAlc8k8uxzrIV9@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/2025 10:08 PM, Taylor Blau wrote:
> On Mon, Apr 28, 2025 at 08:24:45PM +0000, Derrick Stolee via GitGitGadget wrote:
>> The crux of the matter is how the algorithm works when the REF_DELTAs
>> point to base objects that exist in the local repository.
> 
> Hmm. I'm having trouble squaring this with these next two paragraphs:
> 
>> Consider the case where the packfile has two REF_DELTA objects, A and B,
>> and the delta chain looks like "A depends on B" and "B depends on C" for
>> some third object C, where C is already in the current repository. The
>> algorithm _should_ start with all objects that depend on C, finding B,
>> and then moving on to all objects depending on B, finding A.
>>
>> However, if the repository also already has object B, then the delta
>> chain can be analyzed in a different order. The deltas with base B can
>> be analyzed first, finding A, and then the deltas with base C are
>> analyzed, finding B. The algorithm currently continues to look for
>> objects that depend on B, finding A again. This fails due to A's
>> 'real_type' member already being overwritten from OBJ_REF_DELTA to the
>> correct object type.
> 
> ISTM that this A->B->C chain is a problem because (in the above example)
> the server sent B as a REF_DELTA base for A but also had its own
> pre-existing copy of B.
> 
> But the first quoted sentence suggests that the issue is with REF_DELTAs
> that point to base objects that exist in the local repository. Does
> "point to" mean that the REF_DELTA's base is the local object, or that
> the local object itself was sent as a REF_DELTA against some other base?

The issue is that based on the negotiation, the server knows the client
wants A and has C but doesn't think the client has B despite the client
having B.

If the server sends these two objects as a delta chain A->B->C using
REF_DELTAs (and not the typical OFS_DELTA from A to B) then the client
may inflate A first and B second (and then try to inflate A again).

> I haven't fully wrapped my head around the implications of this all yet,
> but I think that it's the former, though admittedly even typing this I
> am not quite sure of myself. I *think* that doing this is OK if the only
> path from base objects to their corresponding deltas is unique, and/or
> there were no such paths at all.
> 
> I'm trying to think through the implications of this against my
> series[1] from a while ago that converts OFS_DELTAs that weren't usable
> as part of verbatim pack-reuse into REF_DELTAs. There are two cases
> there that I was considering:
> 
>   - For some (delta, base) pair in a pack, there was an additional copy
>     of 'base' in some other pack, and the MIDX chose the copy from that
>     pack. That forms what I'm calling a "cross-pack" delta. This isn't
>     currently reusable as an OFS_DELTA for a variety of reasons, but is
>     OK as a REF_DELTA provided we know that the client either already
>     has the base object or we are sending it as part of the pack anyway.

These are the kinds of deltas that could hit this problem.

>   - The other case is that we the client wants the delta-half of a
>     delta/base-pair, but not the base object. In this case, we can't
>     currently reuse the OFS_DELTA verbatim, but could if we converted it
>     to a REF_DELTA based on the knowledge that the client already has
>     the base object.

If we know the client has the base object, then not including the base in
the pack and referencing it as a REF_DELTA will always be OK.

> The latter is doable based on the information in the wants/haves bitmap.
> The process there looks like: determine that the client doesn't want the
> base object, realize that its bit is set in the 'haves' bitmap, and then
> convert the delta object from a OFS_DELTA to a REF_DELTA.
> 
> But I think that all breaks for older clients that don't meet the unique
> paths condition above. Does that sound right to you?
> 
> I think the cross-pack case is fine, provided we know ahead of time that
> the client doesn't have the (converted-to-REF_DELTA) delta object in its
> local copy.
> 
> Unfortunately, I think this means that [1] is a bit of a dead-end for
> serves that have older clients (running a version that does not include
> this patch). At least, I think that's true if we can construct a
> situation where the server sends a REF_DELTA that it thinks the client
> doesn't have but actually does. I'm not immediately sure what such a
> situation would look like beyond cases like: "the client verbatim asked
> for an object it already has, but isn't reachable from the set of
> provided 'haves'".

I agree that [1] is going to present more opportunities for this bug to
be hit by older clients, though I will admit that the frequency of the
problem seems to have odd frequencies. It relies upon the fact that the
fetch negotiation fails to identify "B" as a common object. This sort of
thing can happen more frequently when using the commit boundary between
the haves and wants (instead of walking from all haves like a bitmap walk
would do). If the client fails to advertise all of its haves, then that
could also lead to this problem even if the server is walking all objects
reachable from the haves.

The other thing that you'll have going for you is that cross-pack deltas
should be rare. The case that helped me discover this issue was where the
server did not send any OFS_DELTAs at all but used REF_DELTAs for all
delta relationships. (This is required if the client doesn't advertise
the "ofs-delta" capability, but we'd need to go _way_ back for a client
to not include that capability.)

Thanks,
-Stolee

