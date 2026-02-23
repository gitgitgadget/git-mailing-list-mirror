Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACA1799F
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771808043; cv=none; b=kMyp2SHzo8P+Kdt5ke9gUn9l2brq+HK8xVjMATbA1at8soSBeuazCS6tOULhG8k6MlYdwMWemtWzaNaLr115iKCB7Tho/SdSrLuvqegZhrTU/PTJrqTFkBBg5wbt0TigfNK177JBjVV1J3JXce9k72frCpXGzldPKSeUMOg9fyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771808043; c=relaxed/simple;
	bh=O6CmYA6Gsb7BV9Lk7UQOAIeooBD6CK0+Rs7HwE7IIQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec6QmdwAbb9Xd5IYUKC8EOspguvEdElLxsBbaYUX1BMXoZk4119mDQx3rEQs43di/dVX3refcI5RRAVEoZSDn8vT1NHYaK5nsbP14sbAXfWwwHX+vyi5ZG4gwvVaqKxSQi4aGUgSHzVxixFSZFHcz+Y+xtvY8iJbojjBb5B6B8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQ7gfu2v; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQ7gfu2v"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069ad750b7so33710121cf.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771808041; x=1772412841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxxFN1gNnZPKxGb6tBjPayOG61J/kQuLT0AOK8A8Cj0=;
        b=SQ7gfu2vYWFXmjQGy3FcSlO8Igt+uzaChLMcQnM5XPxJL4//AmY1AsGcPQ818lcjbd
         GbZcj+jCqHKU/i4y9EyJ0DvJ6/Z7LpTmYojOpgDTUtTtGFqU9XiFCqU8deAFgA2RoPdU
         UdBFlznpXmK1OK11Jo0ReeRrJ+bJ8xkPLmbaITV2N0JQoKKRQ6UJb5m8XC+P4iQ5Xz89
         RPRKmKi3WU4Dx7L1s4AG4F4JY4gxUsjnn8u4ZFoG1UP7W9RVJsXKPDC2HK//buAcBdrG
         fvWn3w+qDASUAWcnfv+SPOuiOOsk/YLFvMy0SfpuQryVkixJvMU47XnT32nEuWandeLT
         7Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771808041; x=1772412841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxxFN1gNnZPKxGb6tBjPayOG61J/kQuLT0AOK8A8Cj0=;
        b=blqT9P/Za0BQ5zd/qWpCBxGbMo4G7gf0qKGR545yjZ/ly8TmVG5ae+KgFOGS+x4g8T
         by5V/e8uR3NJShYQKWHm0ScWApOhB1HgIB5MDqJGH0qEvkhCuhXWs+pxBllN+2g+BNd4
         jd4muNvWSgayGMy21GgIfVgiFFGC3+xS8PZuJ8W6dMeYuwgCguhSBnTyYFfuI7CE+WBE
         XlvKvI/oQVk4Rlclawju3Q+/4QozJf4ELyAPWJIBVjHFbj3k4HujYaWGAIGFNLtLw48u
         IIqdMKkPHiypilj082nFEMZbcgZpYT/ZPemtXvZy6yGqo46cAiOtTGpoDrAgtZI9LxMU
         wGaA==
X-Forwarded-Encrypted: i=1; AJvYcCVXwuWdvq5EEOBiFKhMT56Trp/PFqXeC/PDiWit/WGIeRTZIcYQjyiPz06p5iaGZEyiq+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVykdEmmRiTMXMP197pez29qrL1m+fSS3mVYeKj1SG76rWNzhk
	2Ge4bBYfcgv1MxV+Qb6HqVpK7iE1sKSVnoRxfiKfs/PpIunNNdVLPumpEoDl1Q==
X-Gm-Gg: AZuq6aJedhE1PklXxRgYhvmPr1+nl0HRUPagaKPsEOxhHNj5ViXNYGn9a5lfFPtQosI
	E/69RaswazI1yvf8RxMee/IRBCjaCxJIS81WziAmL9RRpMxnImZN4z8YT4lO29Eu4fi9xe498bE
	uYupLvP/8mr1Ym6I7XsEEE9Ra2oRk1OQiwInXM3IXukUeTBdwUxcEE05RVXTYBTz+7snAkfNAOj
	CeIKJe1haDgw+VnoexWFozGQsx93Rmf0vQb/D4yRSLz1mI2E8wMEDkcXM1yuCm1PuMVoajnduu3
	UQPUXQ3aR7YrBPAsw5ChMPIKBOLr5Qm630fEYKrVy3K8Y+LiSbN8+iPNwWgOR41LXUTrRg/4hjw
	3p+yRJouCeF+nSYwGPt2TY+STkERSFO6oU4zUkGcTBsgG1pgR7QWPxLw3KvoWQwTChgfQRKEyDu
	sMJ25k/1cdbi36xVed+R3QVRG+YwrXLMdzHvy6JPJQWMBq45Y7ADkiIBpmwqguV28gwIY+ubYLs
	wNjW/UnjMAuvVUOqMZvLPbI1rQ/j0m85CSXiVO0dXdejFCm
X-Received: by 2002:a05:622a:146:b0:506:a15c:507e with SMTP id d75a77b69052e-5070bcd0a93mr115869301cf.64.1771808041335;
        Sun, 22 Feb 2026 16:54:01 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6dffadsm56221971cf.31.2026.02.22.16.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:54:00 -0800 (PST)
Message-ID: <968fc3da-a2f4-4277-af61-a06dc94afe7e@gmail.com>
Date: Sun, 22 Feb 2026 19:53:59 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] builtin/maintenance: use "geometric" strategy by
 default
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/26 5:15 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this series converts our default strategy used by git-maintenance(1)
> from "gc" to "geometric". The aim of this is twofold:
> 
>    - It completes the conversion to a more flexible infrastructure for
>      repository maintenance. git-maintenance(1) is structured around
>      tasks that can be toggled on/off as needed, and this is a lot easier
>      to extend going forward.
> 
>    - We start to use a more efficient repacking strategy by default,
>      which should especially help large repositories out there.
> 
> Out of these two, I think that the first point is actually the more
> important one.

I fully support this change as implemented, though I had a nit about
the final commit message and think there should be a documentation update
for this.

> Unfortunately, a lot of our tests are racy or will fail with the new
> strategy. This is mostly because the new strategy may decide to optimize
> data structures in cases where the old strategy didn't, and because the
> tasks we perform might be different. The majority of this patch series
> thus adapts our tests accordingly. The actual change is a one-line
> change in the final commit.

The patches that update these tests all look sensible. Thanks for the
extra care in explaining some tricky bits.

Thanks,
-Stolee

