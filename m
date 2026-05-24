Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8153090C6
	for <git@vger.kernel.org>; Sun, 24 May 2026 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645933; cv=none; b=IPL0ebSbRpiJrTobrWeQytVmt2UVViH+h7IFJRvcfYR90WvQyELlR2bIAWuuPU4D9nW6v4S+s/8crUlJD7gu6AAn/fmU3YQHaYRQB3eUUaMzVc6yI+mLgDcuieZnDMx00v8EEMdyV7kxT+18zXVKF14+9DmkIfaBUj4zJoMxff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645933; c=relaxed/simple;
	bh=Ae5BUMl/YD3yvufL/YBRms41DwQcnePksYXfEb59ae8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iUp09bI8mnkgkhROZJbIfcfo8NU7Ns6e+JaWzqD1XxrggcT7aHpVlw40FYbfpMxjs2EDRU+siHrnGOhsxBZYeuBTxbSF2bXD6Z20y9aECGN266z0GOziE6zaWXfLP1sAto5eObOrhaKtWgUgdlCDRxYlcIpGHctheiTqDR2yw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPy/lATS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPy/lATS"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e63771eb0so90003071cf.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779645931; x=1780250731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hV/2kLbLTL/EIZquKHIs3h34idTewFCETnnSwQaRUmA=;
        b=oPy/lATS7oVzSerIJ/h/KA7/8EXRfyk+FFPQAQ8eSZu0UbVkotO7LwuAQt1T99fRbP
         hkiFNgM2GW2iyXhayE0PRkPgV8Q3SECbD+XcEaI9fkEM6sYX7OqluTB/8bY0DYFO+01B
         EP1QmfhxxzVjUq4akf5IY56MvU2lBNTkuV9TXBn6Yl6jxa/faJ+NecZpdj2hd7OnkxaC
         bRHW0KTy3Ou3x1Ru99LUsxdpHpEapGnZi7Fs8Mum6X+a8fVmHoNoVk7EFQ0Qm0tShPs2
         30VOpg1VLLOqzreZ/NQ//fhMynGKEg7kWHLMlDN/H8r7AIdojgzUVsLou0hWHuBiKRYZ
         9oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645931; x=1780250731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hV/2kLbLTL/EIZquKHIs3h34idTewFCETnnSwQaRUmA=;
        b=GwyKpaYTIeRLl2NwPwiI/WQjlVoMz0Lmz+gV5ETE+eOSNclVCtKnAFI79sqxhgjaH6
         4Nr9Yh/fMzg0uyBXHj06+npaRIXSUnJgwMn0hMYBT23FwHekbi6MuXeSu+YiSiq0BN+b
         rGdEsoIxFDXkMZgXdULhRbm15IpW0gS+0MRHvG8bikmhoO23kuJvPM01o7Oxe0lLIWRg
         s3g4A2BYTOAFp8PkoYp6nShBtoIxED8bZ09D6tdzkrYCnsKL/wxDoD3WwP8muOVyIctZ
         EXZ3LfsJQiH8HiMFkQ+5LIgBeiBAYIk5zAstXlEcLgoU0KLlhCWIKJFqC4B2kA2fZbBP
         tIXA==
X-Forwarded-Encrypted: i=1; AFNElJ8CBeluXgFXv7Gak372TPr2Upe1ZsO8s435ACvOM/RmoPMSAvmx0J58W9a3Asn+8x1ZKRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwdnmBBLcBwytbyhZ6AC8Ye7N8tFhW6xw5Bg12SdX6nfI40DQ
	iugxmdsPQS1Ce7XcKbfzRVrF47Qk6blbpkGW5NBAGtfVAFFXGrzfSQHv
X-Gm-Gg: Acq92OEBJmuHKBzkoD3hZWROguTnnXUpTP9B2CdahCt53nV5LoalY0gbSh8iO3MrC6P
	7vCAdsrd8ALPweyEErHvkXRO+tkXIIuLGB4PmmMG4LFkPBXKwUfU+uQE6ks/I+shZedwcXodRyG
	ztXLPu5t1XPn5/x7OIfAqLM0atvJQa9KntmX7RoEB+xVAqdi8XRyZCF/8vSxz4YvjpolO9/EDYa
	+t/zh6Q0ohH80bDeHwhvVXF1nBq9uO1F0ycfwbLPUIiPtfAlHgxt6m/b8ol4vmivX7M4TQfK9rs
	Xx7PW6Op5Cus5WKLUrS/+SIWLKahkaO+FYPcgcCX2H/iRVwLwAu+ARfAG47ieVnGadnwVOiq7Xw
	fmggGgOnI1KcZ8WLTDzz1KQiNVtkD5mQDaz/pkLScayegobB4zmdhSeGf2GHH0hXoy6W069j9lY
	sH0p7+ivNehWWaLnzz49mR7AtZqfKbg+Vb4nytNVrzmhaQOeF/KRVVdYV9KUl6aZra7k2FhEZ/G
	7SJ7VXwVWVkeVsI5Ff2WxMegrwEq4WJPpD84e48762pIcTPopo=
X-Received: by 2002:ac8:7e91:0:b0:50d:597e:4b50 with SMTP id d75a77b69052e-516d42e07a9mr180083731cf.13.1779645930871;
        Sun, 24 May 2026 11:05:30 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:4178:7958:947f:ef4f? ([2605:a601:9b88:8300:4178:7958:947f:ef4f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c9208fsm72077371cf.17.2026.05.24.11.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 11:05:28 -0700 (PDT)
Message-ID: <ef5613db-03be-45c7-b3d3-96689a33ba9f@gmail.com>
Date: Sun, 24 May 2026 14:05:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/path-walk-filters (was: What's cooking in git.git (May 2026, #06))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, me@ttaylorr.com
References: <xmqqzf1qsdfa.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzf1qsdfa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/26 5:06 AM, Junio C Hamano wrote:

> * ds/path-walk-filters (2026-05-13) 14 commits
>   - path-walk: support `combine` filter
>   - path-walk: support `object:type` filter
>   - path-walk: support `tree:0` filter
>   - t6601: tag otherwise-unreachable trees
>   - pack-objects: support sparse:oid filter with path-walk
>   - path-walk: add pl_sparse_trees to control tree pruning
>   - path-walk: support blob size limit filter
>   - backfill: die on incompatible filter options
>   - path-walk: support blobless filter
>   - path-walk: always emit directly-requested objects
>   - t/perf: add pack-objects filter and path-walk benchmark
>   - pack-objects: pass --objects with --path-walk
>   - t5620: make test work with path-walk var
>   - Merge branch 'en/backfill-fixes-and-edges' into ds/path-walk-filters
> 
>   The "git pack-objects --path-walk" traversal has been integrated
>   with several object filters, including blobless and sparse filters.
> 
>   Comments?
>   source: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>

Taylor has completed review on a small re-roll v5.

Thanks,
-Stolee

