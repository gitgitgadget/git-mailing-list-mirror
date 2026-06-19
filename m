Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99E3A8757
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879822; cv=none; b=Rujm3L3O2tZ5Fix+rEeSx7Z6bQimryhdkfaQdnQNLZCOYZNGQUGNMDVm4wAGzowfJQLYQjBTxKgK0Xmr3hkkKlpIEUhQt96ANDlJhwbs/9CRz0iM+yM7cSkYfS4uFenBEFBkg5cvpH7Uep+Dw6MZ0oSxysRE29M815az48j/4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879822; c=relaxed/simple;
	bh=QU5bZsC5MTny2/vP8wIF34beeFBdgN/Nv7yIlokRH9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=US46ce0FXkxTZfhYsk7f4FWXvDydfzcAtOV4zbfi9aBUl4FvqYLdJf2W1mg3TbumXrYMly3VrLgWsEeaGirWch22kRSQp0+Ku+Kdsh9x2OPcTQ4CXJ+nLVx9vijnjh2uynfvSQIfxyNQqnahYJQ4QfNIjALTbPZWnuPSZ+XlC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZowwJfjr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZowwJfjr"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7fe4808741eso24430537b3.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781879815; x=1782484615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k14S39ValYoRp6nvwAx4ZQOsZvngIUPDaESzBXZSO44=;
        b=ZowwJfjr6R6qb2HO4yTriw9O6CFjnE3Cdz4wtiYkXyC2wZSfWfChXckcb6/BVkgK0w
         xsj6gH3AEr/VVpanvxI1AQ9jHUIssNj0nhKJ5me4PcI8sHfIBK2n47s7qW4SJWoTjvh+
         O283U5dHeNn2RYkPUENrlIAWVSutYfdjYAUkszbINXMGKBg1yl0AuA31WQRjVnZHantS
         CB5jJYEQX2GstsPVwZihoZfZmStUgUi/Vgi/uZX7sOuEGkn8Xr30GHHsI23qCopvgtO/
         ZZTHg8ntOrm7elO6yjFQwOjK6sTS83rjfuxV9BTG9Y8p5AKjN2ipcgJ4tBQXWKqlD9pj
         euDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879815; x=1782484615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k14S39ValYoRp6nvwAx4ZQOsZvngIUPDaESzBXZSO44=;
        b=QVhI8nBOmffppgffPjPW6glBXhEPD9khFm8Ld+bh3tFCgkuNgv/6RTBWOnA5cQM9/C
         0dAJj30Tcm4MGxKCbznBaAXlulX4hAXwAZSbR+0f3SmJQ+cjNZ6Q3vDPRJQgd6WVoKTq
         dHn2E//JsmEeNe/lILCCRBeMD2UfxDZtYD4DbSClFNJkJaT9RPWe3IvhO6D8CcgbnvQ9
         HuZuMWNTffM1fH811ynXcYOkP8FsvzLmlQXbxsvfanofj9ekauGmFz1PnLkBJgmMOdAu
         evoKIU3doVGn36rK2URz3qddiE4TEsKIsxsBnqh79WE2Jc++F2fLzgZS4R8n++L224Fu
         YduA==
X-Gm-Message-State: AOJu0Yzog5eBu2VEPA5WEuwIGGP12zeU6w4XQhHvJpS2M8bsot2VVyB8
	v0OWpuInNUiyLRQdTyP2M6SCxWmsHZ6AYixuuqoTcAs6K/A1WI5avJkq
X-Gm-Gg: AfdE7cn1asQJV7Q9YvoGSrnHwUHMt3dMbzgq3lDTCXr2JWflEK4F/0cnMFWGC4vR2Rp
	CVlG/SvGw7P//KSUylCgvsuJLTrilV4vSPCMaK7FcIty7OB0VVZNJ+AoQrlRcyY3JMgUeoSdetr
	yD1l5vPhbe4Sk+AEy/9QvSf7NX/SnGsFShcW54Nqtq9eu1CKf5Ggc79DkXJHxRunRPkrSFZa/sA
	JPaVFxK08wJhjJNvbxqIvZMgqIwzhwF2LDLWS8L6IkHq5ZirgL1GXjjs4jsHyH6iaQXFP8BcpqF
	aW9eVqUulbd/bMcshkpKSxMZkHatEfSXJWju6EOX3927zzAaBidHYBW07D2+zS2H240T7gtsjL+
	J5r/S8Mdzhb1NewGO9C1Pzf0KTqRD//oUPMW43ftUWMO4KUNHfkW1mKCax4Lpku3B/smu+xC32t
	uXFyvFqgiAoquQYFp3jyD25Q6lcGKV4k5+aua+vvPdnbZSfMx2klGhNgz8Ng==
X-Received: by 2002:a05:690c:c1b:b0:7ef:758c:e7b0 with SMTP id 00721157ae682-8013012f557mr39236417b3.1.1781879815423;
        Fri, 19 Jun 2026 07:36:55 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f01855bsm451256d6.9.2026.06.19.07.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:36:54 -0700 (PDT)
Message-ID: <ec45260a-1d4e-49d1-9aa8-9ec94ecd9b23@gmail.com>
Date: Fri, 19 Jun 2026 10:36:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <6e4a8764-3c56-42c8-a87e-40a94c6c34e9@gmail.com>
 <ajVPJGXuhugDcT+A@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ajVPJGXuhugDcT+A@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 10:16 AM, Taylor Blau wrote:
> On Fri, Jun 12, 2026 at 09:03:41AM -0400, Derrick Stolee wrote:
>> On 6/2/2026 6:21 PM, Taylor Blau wrote:
>>
>>> As a result, we can see significantly reduced pack sizes from p5311
>>> before this commit:
>>
>> I mentioned this before, but the pack _sizes_ aren't changing in this
>> example. We are computing them more quickly, though.
> 
> Thanks for pointing this out. The paragraph following the perf output
> below correctly explains the results ("We get the same size of output
> pack, but [...]"), but this one is obviously wrong.
> 
>> Since we are testing --path-walk on both sides, the change across this
>> commit is that we are using the bitmaps for the "counting objects" phase
>> and then potentially using the --path-walk algorithm to construct the
>> packfile.
> 
> I'm not sure I agree here. Because we are using bitmaps, we're relying
> on pack-reuse to construct the output pack, not --path-walk. I mentioned
> in git-pack-objects(1), but the combination of seeing "--path-walk" and
> "--use-bitmap-index" together only means that we will use a path-walk
> traversal as fallback if we can't get an answer by relying on bitmaps.
I guess my thought was that we'd construct bitmaps when they are
available, but how do we walk objects to get the objects for commits
that are not represented by bitmaps?

But you make a good point: we don't need to do that for functional
use: the bitmap code does an object walk to produce a bitmap, and it's
all in a layer "below" the pack-objects code.

So essentially, this _isn't_ a combined approach: it's "use bitmaps if
we can, and fall back to --path-walk if we can't" which is changing
from our previous behavior of "--path-walk means we don't try to use
bitmaps".

Thanks,
-Stolee

