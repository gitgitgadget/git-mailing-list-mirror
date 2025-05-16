Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B517A2FA
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412853; cv=none; b=VphQJmyhd3JQVlgSyQXmrdkJ9y4Rt8EkENUO0hOS1ftkIoK4VIeZ4mfw5rFMysUrcRj88G9yL6muM7fzALzzI6zQRZDFB/vP0etV3Xpp7AF/Ng7XPQeG5qBDqpKO6UtCgaa1gO6sJhSciAcG6rXMZciDz1CF9FOm78+nzW5CpvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412853; c=relaxed/simple;
	bh=hLHcWqtUOfzOea5q3rglKE7Xg5zUCJWDfzPOMXfbY6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSCW+WzsOhIA/MJnJS4aX15VD7v2T5w6NNmPaKT286l6U+7ASNY8bd9Hi7L1SwBWRj7j5rQ/WwVGKtGXGn9QqDVQJlwS/1xNuVH28iHoqY4lsf6HLyPB2gsgukjq/lhi8wCxaUBacsIy86vidAJBs8fT2uP8x/RgFxssMwXbt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ni1H/QPK; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni1H/QPK"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7b7b4eaca1so678313276.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747412851; x=1748017651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul0DXeOoKn+97g8gddT5XcyWjOHA3YIg90IhHhXf2ZU=;
        b=ni1H/QPKpZVtG/Q030S1ZYeMTvjth2kmZhmF245ekprO7Cx5B642UrVJ/P5S275acY
         E3F1BuxL4MgrnMTETlOlh+1dpMynYLKEi4DAfJneft1JtHrfIrd0pkjG5PlwymTt60Np
         2qg0Crkc4kO/fkyH3Qn/dFOvYJSOVhhDsXH3MovR+s1GmjehAT+pH/yufzKZ+pwoqV1i
         JPxjg3x2CWMVC33+TcLBZc8OwXOswQQjrVeglnkNnLRjtUyQcQ8jDlhmrTHRAcfjmS09
         72xTPFbWv6HooenJOr6D8Ucn6l4m3Sd5rG/XDl8ThHsGv2aMgp7WujfvvwnIl4czOcoA
         jd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747412851; x=1748017651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul0DXeOoKn+97g8gddT5XcyWjOHA3YIg90IhHhXf2ZU=;
        b=e4WlInzPDEcIeHKPk183X3nngzlklI2DZarMGD9ygEgQavyFQle2pM7CdBahATsLNc
         fOQeuM1ObUwKJ6T36xWUQBoCGPwT+hNZ+kInC3s2LXAu1NEC+Na7fuEodQlwoHtvZosI
         wkEHSIZPwmAfMFSLeO0pIIuscHIdF72l17kluQcQr8Z0qH/iNxf4ifJ/uONArmgn9T8h
         Aij0ifi06KaLnHYkCd5JiYgnD9CvQL3zglzFymyMqHPDXWEK6cV+duiQlySL3PAby3U9
         U61vqE8xH73gzbZdH+mzY4DZSSkQ44vyKTlgnM/CM03YYiyVG8ZHE2qUI8gDWEaY62VX
         wdGg==
X-Gm-Message-State: AOJu0YwgdoCqplLpV42D1HHpGyWX4rLjvjkxiLG3OlEhh8FkD6Pu7o1w
	nllor6/I3Dw4BYLZpRCTrPLu8A4os5SbF2DzxTVFcBt+AzeB9VBnvZnn
X-Gm-Gg: ASbGncvT/q9UdzNjn+Pq2zDv+qCu1BuLUF1+hQK/ZTkBjakl27H8ewDIMEdE2/onrYv
	k6wNqxP8RvKvstoL98kM13EzvH6RaYaOWrBAIJVAVlwRuc0TPUCJ6yRISaiRbHQw49T4r6WlFc4
	NwrDXMKj5GJXWqQPPBn32j0gtcE4jNJ3oLCdITyvFw0hFGatuX+v0F9eiaSffeFln7logJXpWXF
	/z2i+8m0H+8lOSGkCWTCRH77KWWvr0n1JGaztbPRgGHAC6fb0+62XT143pDrbk1y1letBKAWiiw
	Ghm5dbDNNdr8jkDB8ZowiG6f+m9+AFnhlyovOOhrttXiXwtJVvEFkdd6keC85iIlcyIOoVJFi9g
	8hYxrlRYAwIz8Qk6FrpUmNFacj0iImBR7/Npf43A=
X-Google-Smtp-Source: AGHT+IHeyuvcFH8ehIdInz+pv8H5KSD3XXqYVmAcDhEGFJvE0vaz/3q1PFfqfD7ojjX4x2NpjlK/1A==
X-Received: by 2002:a05:6902:1a45:b0:e75:5d56:c6de with SMTP id 3f1490d57ef6-e7b6d6db0cemr4542562276.39.1747412851104;
        Fri, 16 May 2025 09:27:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ac88bf2sm643284276.20.2025.05.16.09.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:27:30 -0700 (PDT)
Message-ID: <7ee3884e-b629-4b59-8e9a-a9a56abce786@gmail.com>
Date: Fri, 16 May 2025 12:27:29 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] pack-objects: refactor path-walk delta phase
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <622439d78557d94da899d21444920c27768d3c67.1742829770.git.gitgitgadget@gmail.com>
 <aBqz+VfSvecJdWHw@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBqz+VfSvecJdWHw@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 9:14 PM, Taylor Blau wrote:
> On Mon, Mar 24, 2025 at 03:22:46PM +0000, Derrick Stolee via GitGitGadget wrote:
>> The current implementation is not integrated with threads, but could be
>> done in a future update.
> 
> I think that "in a future update" may be worth replacing with "the
> following commit", as the former suggests (to me) that it may be perused
> outside of this series.

Noted and fixed.


>> +static void find_deltas_for_region(struct object_entry *list,
>> +				   struct packing_region *region,
>> +				   unsigned int *processed)
>> +{
>> +	struct object_entry **delta_list;
>> +	uint32_t delta_list_nr = 0;
>> +
>> +	ALLOC_ARRAY(delta_list, region->nr);
>> +	for (uint32_t i = 0; i < region->nr; i++) {
> 
> I know that these values are all unsigned, and very unlikely to get near
> the 32-bit maximum, but I do think we should use size_t here (and
> likewise when dealing with values that deal with how many entries in a
> list we've allocated and indexes into that list).

I've updated things to size_t where I could across this patch. Thanks.

>> +static void find_deltas_by_region(struct object_entry *list,
>> +				  struct packing_region *regions,
>> +				  uint32_t start, uint32_t nr)
> 
> I imagine that "start" here is setup for the following commit which will
> parallelize this task across multiple threads, with each thread starting
> at a different position.
> 
> I wonder if (as an alternative) we could get away with passing in a
> (struct packing_region *, size_t) pair and drop "start". I think this
> can work if you pass in the result of adding whatever the value of
> "start" would be to to_pack.regions here.
> 
> That somewhat hides the fact that this code is meant to be run across
> multiple threads, but in a way that I think is worth doing. It lets the
> function avoid having to do things like:
> 
>    for (size_t i = start; i < start + nr; i++)
> 
> and instead do the simpler:
> 
>    for (size_t i = 0; i < nr; i++)
> 
> since the caller already adjusted the regions pointer for us. As a
> side-effect, it also means that the call below in prepare_pack() can
> avoid passing a literal zero.

I generally avoid this kind of pattern, because it makes it more
difficult to understand what is going on when debugging. The cost
of adding 'start' to the index seems low relative to having a
consistent indexing scheme when accessing from the "global" list
of items.

This only gets more complicated when the threaded version iterates
on a "consecutive sublist of regions".

>> +/**
> 
> This is an extreme nitpick, but I think that "/**" (as opposed to "/*")
> is preferred, as the former is used for Doxygen-style comments. I feel
> like I have seen Junio comment on this before, but searching 'f:Junio
> "/**"' yields a measly 83,000+ results, so I am unlikely to find it ;-).
> 
> (Not worth rerolling on its own, but if you are rerolling anyway, which
> is what I gathered from some of your earlier replies, it may be worth
> picking up along the way.)

I'm confused. Are you saying I should change from "/**" to "/*" (which
is the opposite of your preferred statement) or did you misread that I
had used "/**"? I can't determine which statement is the intended one.
  Thanks,
-Stolee

