Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBC1DED68
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158037; cv=none; b=Pg/cSaj/JQ3UHNAG/xu8I19uJRL3YkpyvuZxAYvgv9ZYHr8jJbxzskIVv3Jk9Z1vT6OA8PIh7/jBrUkluGAVbDlS3HaXS+xr985s0Lx5MUPZboHhGi5DRMFUSh8SY3qkOe+6Lr77DoUTwwpdFG/JGvE8NZiFsx8SvJKFe9LNOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158037; c=relaxed/simple;
	bh=oi1MV9MPxcPO4PW8m9cG6HtlCQRcYAoFCKoOrxE1Uxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=awvIOQWQ1RccaKm7CuUpXTPpy+5mdRkxYTr70NWhXtSKo57eO9ioruuKa/0xLZ2J8C+AekrYiQlhzN7SQhSx2piHB42LKEEl4iVkkAydzazoOTKyDUrYCrE6HZC0+wZP8x+EBbQt74vJRauSLW0mseZet4U9c8qSuCjhqxKknEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5bOKZSY; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5bOKZSY"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e479e529ebcso8962108276.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738158035; x=1738762835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZI5+s/FJIK+1PMcl6MYj5vYCmDixGl+9nXlO0OHKJ68=;
        b=N5bOKZSYspLXVRmzS7mbu/486OFKVfqR5roVEXXKlrfiTf8X/wtWmN8LwIp700lyPA
         Jv145Oqwy8QsIfzTOroyXr06+7tXppSPddfe2WUfNk+LlJN1y/xoqvaQD3FxfZE6eLYk
         ofpOWxoaKKqJu7M5+8dqe7MC1abGQ5vW807CzXQBkqnzvevCxp7LYQUqkclU+/pGqSKM
         osrd0LWVvtm82yeiydKki9aX2ydjqybRVfLMREpB9C0hJTGVDJ/kq54P9MOPUchYzhMY
         WEaccTbu24COU3rfXFqKAzLu11O6rkuu3ZC9OR+dMUCdGbfBpUAkqWZQ2FWMQ/inIg8X
         a8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158035; x=1738762835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI5+s/FJIK+1PMcl6MYj5vYCmDixGl+9nXlO0OHKJ68=;
        b=xMO4YVzuOx7A0LzqARxsIb2oveFOPMOglNQXJ9Ckfdzv2Qy24AmoQb5SDREregagVp
         K1zlEwoN/n71NOqWHiH29TztBWvyqa92B5sLzfdRkrgdvANW+PNW5Tqlkt+YMdp7p9EY
         LX9y0B6VgNJ0jiVA3S5+zRUUdDYNIWZUAvuWxY9hhtJ76waM+MMF9NqZ/GDjQWRJcLcO
         KjHCPLOuHGb2tGBlBW3OZind317yUt7oGYuWsFZ82iBVEMy/ZOViErZwWfQU2bLS1Mrm
         un98lZB+gQG/25jbHKbQGV7rDPBaN8MZdKuGGtAcdfjP6d8ky5frjDDfzWY82UAiBNNI
         w/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUyLAr8bIQT1iPx4/7I31UuaSKtTtaW7OjZ6N6IRLaSRBOGzVxmv0x0E7kyX67tvhtuSvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHAM1MvGnnELvods/8Azq/fdTbQ3Qr5mWR8ivEOnk3WU0d/Cw
	9cNGYscx+bvkXSf3C1Y1z/48FQS9ojcirugaaenAgfJyk7dT7sWNgkBnd0+h
X-Gm-Gg: ASbGncvETwirrebhmAzvCcx3fa4mfNueXQobIfFVN4Gnyv8/cbSqrzSpl7JyGFG2H++
	ecaD7PYzRch0KEU0PIQAlOjExLKkEiO5EnRgUbFfZXwQDwIHjzCz4srBXjghk0hBEXemzX6eCZJ
	eCw+8OB+0ii0HabgfZq9ghNJON2NUxnRpQz76C8OraeKPhwrgl1DvQ8nlaIBEbgATSN2gWdInxN
	JKm+qB9hNaijKZ5lJa9TB9rT9RUnU9/bHIYc60+34LXlMqs12D+EuMhN7JEFBIRh7ITg87p5d/u
	h/0oF2CiLGPtbwI75EvwZH/WvN/s+IEIUOJp8L2lRlptW1wd8vuZexL1YRyDW6XzKpuIIQuKby+
	c
X-Google-Smtp-Source: AGHT+IEYD99oRjPErhl7Ge4gMl2oIeWyaCIBMQu0DPb29r2i5pVn0qBKjKivucQziQ46O2LeTevDWQ==
X-Received: by 2002:a05:690c:7445:b0:6f6:c937:2cf4 with SMTP id 00721157ae682-6f7a840057amr20644737b3.23.1738158035159;
        Wed, 29 Jan 2025 05:40:35 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:89cc:5f2b:c6ab:6d1? ([2600:1700:60ba:9810:89cc:5f2b:c6ab:6d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f7578778dbsm23078727b3.20.2025.01.29.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:40:34 -0800 (PST)
Message-ID: <8ddc3313-9d66-433e-847f-0330fd1d5e17@gmail.com>
Date: Wed, 29 Jan 2025 08:40:34 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Jan 2025, #07; Fri, 24)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwmekvubv.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqwmekvubv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/24/25 3:19 PM, Junio C Hamano wrote:


 > * ds/name-hash-tweaks (2024-12-20) 8 commits
 >   - pack-objects: add third name hash version
 >   - pack-objects: prevent name hash version change
 >   - test-tool: add helper for name-hash values
 >   - p5313: add size comparison test
 >   - pack-objects: add GIT_TEST_NAME_HASH_VERSION
 >   - repack: add --name-hash-version option
 >   - pack-objects: add --name-hash-version option
 >   - pack-objects: create new name-hash function version
 >
 >   "git pack-objects" and its wrapper "git repack" learned an option
 >   to use an alternative path-hash function to improve delta-base
 >   selection to produce a packfile with deeper history than window
 >   size.
 >
 >   Will merge to 'next'?
 >   cf. <Z5E5KdbwHE7fmiJx@nand.local>
 >   source: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>

After Taylor's review, I believe the latest version is ready
for 'next'.


> * ds/backfill (2025-01-23) 6 commits
>   - backfill: assume --sparse when sparse-checkout is enabled
>   - backfill: add --sparse option
>   - backfill: add --min-batch-size=<n> option
>   - backfill: basic functionality and tests
>   - backfill: add builtin boilerplate
>   - Merge branch 'ds/path-walk-1' into ds/backfill
>   (this branch uses ds/path-walk-1.)
> 
>   Lazy-loading missing files in a blobless clone on demand is costly
>   as it tends to be one-blob-at-a-time.  "git backfill" is introduced
>   to help bulk-download necessary files beforehand.
> 
>   Expecting a reroll.
>   cf. <Z4jeQSLmARruE5l3@pks.im>
>   source: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>

I plan to reroll this in a week or so. I wanted to focus on the
other series for a bit and will bring this back up (and may submit
the 'git-survey' series as well).

Thanks,
-Stolee

