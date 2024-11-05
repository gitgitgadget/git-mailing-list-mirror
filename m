Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEF3C30
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771509; cv=none; b=EEkrHnFqNr9/YfP6UOXpfdJ7cdJXboAK4VLIEELfuvK7hrJ/2NWY2YOloynOfWQrLmjglzuDOQQ1lSzwVW1cmjluO++zSgLfoaP1qsLb70qOVoI/Vx/TWM4cZiXvuUPL6vaqkVmDGUuqsB8ci5Zb3xjiaC7k+vHX4Vy9QctLCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771509; c=relaxed/simple;
	bh=pTLMYn5RUjKGhjI+4KdvKknzn2iQK+IZzd0UH6MnH5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9Vh+YabYBf2H3OIjj/rujx+LAB5eeJpOja4xizybCqfIS5D1ikpu8GGDjbP4vRhAdt+httcgv4EFPUbFAIEZL4SxkE2UnY0zlpnrlF/Rrp8NQ7ztECQZWd0i9Ql4raX1EL9q5Bu99QflrQHyJpJD8EppFVCHXDoB5rAtY60I18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGMert1d; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGMert1d"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ea85f7f445so21250277b3.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 17:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730771505; x=1731376305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mf+2uKXt562o2VXMbtBsZYcHuvelTsUcSM83p5LOQ0=;
        b=jGMert1dkdSrowXybKUiPEmi+YUv7/N+tb40UVLumStrxzDHI0TQn7q8yWLt9+uPL1
         OqhjJeD2JUkyFvQcOIGzYkrlGz5BInFPqo5UdTMzDWFMaReeTqwzTnbjBFLqrdN/wvQ5
         S3TFKyugRc/1CSdZxH9x8V2tZu/Cw3gd0qViIDOt5ZtHaRljjupjpLl6EsuzDtISIYzY
         nwCgI0c1humplTantaSOO3oNu7YTEdueY9QkI6O7K9weIQdOdngRuFQn4Le6Ry94DHgr
         Q9yzNYm3MaG0KSvp4vROGzy32nPoSw5DGfOH5U2AbtOgdj9MEQz+efEtT3mAA9fgwxCB
         M7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730771505; x=1731376305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mf+2uKXt562o2VXMbtBsZYcHuvelTsUcSM83p5LOQ0=;
        b=VGmveHGjVcNriQUsreUdUHLXIgoPn5tfTrAiQUXy+0za+jUgvkCP7ym+JVvtxAEZgI
         RBsqfVJXzoOPs6n2EZ+EiN8GooIT7NhkdcnaWWWRwtCRyBB6EaL+VePm9TLxraB5k3dO
         3Vj9npRb0BHkdCwwc7fAVTr/+Q/fT/a5KSWKICeOoHlD9sxbx+9szDskD7Y/LUAB2qP8
         RZxzhZJzHXKljzt1ky+B7Qpep6IH8lJot0Ih2lSWGWpnBAuJ2PeviImfTzXBYZC7Xgup
         VE3Ea2SGk1awjF6qXgkqcfVFWK49NPoQrnRxxIQEBtDcwYf7t4n9Wvp32Cpb2KDI3iKF
         CFaw==
X-Gm-Message-State: AOJu0YzkZTxiSP3izahbVUXf0sN+0IDn3dOczeblASk4BbHbi4oQ6NAE
	du90PAkwswZrj8NQYlRXHjojDL8AwShyY6rZDZxrfGisZFI9shlg
X-Google-Smtp-Source: AGHT+IHAMhY8OaGiHHadL3Nq01NsJBTQBmReMOPP2AxU6LK4xlR1tI4VfSY3gpvN6Ti/2Wmz8jw8jg==
X-Received: by 2002:a05:690c:25c8:b0:6e5:e571:108b with SMTP id 00721157ae682-6ea523216f0mr178337317b3.8.1730771505409;
        Mon, 04 Nov 2024 17:51:45 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:2db7:73fd:372e:bf53? ([2600:1700:60ba:9810:2db7:73fd:372e:bf53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea96bf32e1sm6934087b3.61.2024.11.04.17.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 17:51:44 -0800 (PST)
Message-ID: <7be6cc82-e566-4425-b663-71e53117af3d@gmail.com>
Date: Mon, 4 Nov 2024 20:51:43 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
To: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
References: <xmqqr07rwsmd.fsf@gitster.g> <ZyjoTVhP0xn/Qcvx@nand.local>
 <xmqqikt2wrn1.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqikt2wrn1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 5:39 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>>> [Graduated to 'master']
>>>
>>> * ds/path-walk-1 (2024-10-31) 6 commits
  - path-walk: mark trees and blobs as UNINTERESTING
  - path-walk: visit tags and cached objects
  - path-walk: allow consumer to specify object types
  - t6601: add helper for testing path-walk API
  - test-lib-functions: add test_cmp_sorted
  - path-walk: introduce an object walk by path

>> This is marked as "Graduated to 'master'", although I suspect it isn't.
>> I thought that it would have been because the topic went away, although
>> I still see this in 'jch' via your 3503a15e17 (Merge branch
>> 'kh/bundle-docs' into jch, 2024-11-03).
>>
>> Perhaps this WC report was generated before moving the topic back into
>> 'jch'? In either event, as noted by <ZyUqr/wb5K4Og9j9@nand.local>, this
>> topic is still under discussion and is not ready to be merged (yet).
> 
> I am not sure how exactly it happened, but IIRC, the topic branch for
> this one was missing for some time after I grabbed the broken-out
> topics from you.  As I didn't rebuild 'seen' I managed to pull it
> out of master..seen chain locally, but that was before I generated
> the "What's cooking" report and I think that is how this entry was
> mistakenly moved.
It is possible that things got confusing when this replaced
ds/path-walk, which was a longer series that started with these same
patches.

Thanks,
-Stolee

