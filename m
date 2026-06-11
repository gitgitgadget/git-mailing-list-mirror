Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7179EEBB
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182642; cv=none; b=o1Zd+6vnHVpWs4ubpU53U5lRWR9ZC3IxTOPJMJBBZw6/q7DqyEObP4YzX2zm0VTm1zIVp7LC1pKFKsMduGbCLJ9uem2jSth0CI6ZuxUjsUEWMjJBTaP5km2ZnHHt34MPpZkdjC724tOiS72d6JTLmlQ5BHkUxALEu6K0ml2NR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182642; c=relaxed/simple;
	bh=rMQ0biAt9AIcNPZcEHZVg7iH512IfJPWlvMUXOS/VVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsHOHiRUrjzzsP/gWg0JVO5Zhl4+qvIa6CDLoVSjM4yguC1WQhoq4Gl6mbA02uuYKjIJAwUTl/PaRtxktU+d3E5aamliGlUoUzyi8gbRvaaOkzTT3htzSnitVT0LReEAmm3eNyjLXJHMUporuDX2u3Jz79xK5n4ffS01nODssek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYwMcy3E; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYwMcy3E"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51775f2473aso59859361cf.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781182641; x=1781787441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBt6CSkluAbEQaTHoHi0WzWhILZxh0BS7l7MY6+mAqE=;
        b=dYwMcy3EGG4nvQqbXRuBGJXQAohZGr8NsOAVf4iLez6mbrzVEOkTy4TcMju73DP2ET
         7EyMVvtJ/RAXC0W+UbROqj4FnM7e9plS8MRd3YmymBpu/OD/bT9Edv0FzC2sU55jBXF9
         XM43GbaE1fPBGJ10bufID2LcJUXPt2Btq+WqTomo4THWgMBJFYUZSQgQSsGqcNo+ctVK
         TgYYA8Nd6TmQGXILXqFltqPQ+FGJIn9AlAG00OhYIFvfEHV0mfLiGzB/YIxHQSpd9/K2
         4RTVIrhi3hzx3Nn9oM8PBKjSCaQJtBTpY4EK7hwFRcmdgipPWh/zhxbtaySbj1Mf9XpF
         d88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182641; x=1781787441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBt6CSkluAbEQaTHoHi0WzWhILZxh0BS7l7MY6+mAqE=;
        b=p5GXqrfxAh/sMnpuxEBpnWbvmA6XF/jUenziOj6b2hvxMZVKctLYYfgBCtDMhZNHDa
         8zoglIbT6UsQgqVGy7uFIJbS1lJfJ01GZKb3oL4UayTx6qITGpm6S4Ms0eM7NxhyfG5W
         IWuaDlCiaej3JySnECxEOY7l26a5XYkDIy3xKtAQtkRCNf1Vopd7hDuMRZUlvx1lat36
         5T3fKiKR2sZGRCbSEX19QJDxy985Pk3zXJzSaBFkmfFy/WusoF5/bUu/wBNnTS/o9TDV
         XPqbdB+rF6Gb8BnECg+IolZovv51Ur+PXkm3y+bj/ST1JqOg9FTRG8YhJLIFTEyrHli+
         qj3g==
X-Forwarded-Encrypted: i=1; AFNElJ8Zn1NR14yJkSbhU3ddh4RvJyL6z/aOi7+iOgOcSLsYwxLVGHBROl9YRkkp+2A0seM7YaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qONh8hUoiC9e7n5p4Cc61NDCSnJXALoIduM0gtxDkhIV2agn
	gH3U8oal61a8Z29C9+v/3bgTOIC+5NteECIJLl6GKR9y6bi4pHbbYUFt
X-Gm-Gg: Acq92OGaKTQvk7G/5NwWlN6lxskEvh+fq4FZsGYuHGasw8bHxAg9yNk+St3DjjaSn88
	Ks5n9CFGM8OLb23yY4Cilt3QOZI8xrsL2aAoU8VEcrhVQkZtePXWEa126Ku4xMUZNyK0PvSpnMs
	XDO6D7GfLV65hsOjaUVpxIM3asUp4gQU8B5+wrdjlcBk7GUkB6c2pKJeCBD8EDxiTbuY3L0LAu3
	aNdl0mSf8v+bf3g58K8kjaoOaX8RcnoO7ZW9hLwxrox3qtU9LrzrjRfzbykKYqcRgkWMRKwKiTD
	3yxAy09tlPGZdcdipRAL9/SS9EMJ6tw+NhE0hlB8dnQ9GNX2hmo+u/1768tesYFLzaqkvu8ZulB
	5DYBMwUfT9FHvGCmBsA4nPtlMcKXxIeEsYPXMTsc7KpYJ04TsrsckD9IXa8V6bTFK02X7n//ZII
	v9HZZEb/s4taf2gFsdPeJrI80cOfg94WHQSga/GIySwIbV8oH0HmDmNLLhL3Iu8hN7L5syQl8Kv
	ZTjw5I=
X-Received: by 2002:a05:622a:2447:b0:516:d699:a99b with SMTP id d75a77b69052e-517ee218b18mr41597521cf.40.1781182640573;
        Thu, 11 Jun 2026 05:57:20 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e7bc34dbsm17325726d6.3.2026.06.11.05.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:57:20 -0700 (PDT)
Message-ID: <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
Date: Thu, 11 Jun 2026 08:57:19 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/2026 7:49 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>

>      * Added PQ mode to the existing test-reach tests so both DFS and PQ
>        paths are exercised by the test suite.

This is a substantial change that I don't think is merited. I
think that this makes the point of your change moot: we essentially
have two implementations in one complicated method instead of two
implementations that have different performance characteristics.

I'd rather leave the code as-is than take this complication. I don't
think your commit message justifies the merging of these
implementations, either.

Moreover, I thought the previous patch was fine, it just needed better
awareness of the performance implications of the change. Specifically,
it could be a regression for large repos without a commit-graph file
while simultaneously potentially being a performance boost for large
repos _with_ a commit-graph file.

_If_ we were to go this direction, then it should be two patches, with
the first introducing the new mode and testing it. The second patch
could change the callers of get_reachable_subset() and delete that
code.

Finally, a commentary: You seem to have a habit of responding to
review feedback only through new patch versions, but I'd rather see
some thoughts in the discussion thread as direct replies to the review,
especially if you think you will change direction like this. Saying
something like "Maybe I should update the method to have two walk modes"
in a reply would have given me an opportunity to respond and perhaps
avoided a new version that went in this direction.

Thanks,
-Stolee

