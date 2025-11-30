Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15212229B12
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764532613; cv=none; b=BYJoaORRMq+HRFE+rgjgsSs0ww+/SKgOrnnJNiTzJAOAfn97kxksQuBZkjUJWOmtuARUjpNtHDxBhz1DDe1x+CHq0fFX7FSG2gkdvpncPEkTtCrNHxgYJLtoMegzaeRMk83eMQtFf1nxRbBJXS3V8+DmpKYJRgaJvulK1Hh67FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764532613; c=relaxed/simple;
	bh=VzfiMXWQGeZlq4USECijgwWtcpqgUd/O13gr+rwRojU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVmvfu0G9cuGqe0q8Yl6uwlPEH2+9vE3EyfiFpRTn4GbY4zoTMrF/HIectxt+W0heKB9ITlhPfZtKE3+NY7abkIl2d/2qmRtxIkZDRajc9CR81cc8Y6BX4ZF+AW/n9hj3KyoO61ya6Asyk13uhuZwPTqbg5B3dJYU35zSvrt/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkB40Yl+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkB40Yl+"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee4c64190cso28076221cf.0
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 11:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764532610; x=1765137410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKVP3OZ5lBZi1FqY+MheawVn0dvcyA4u1uUk6Z/JTos=;
        b=NkB40Yl+SOvqa8Fv0iiEHDXttnDBkUm+Sfm7t1sKnvTMHtMogKUsulshLPqt0uPPhK
         PI9cbsd9VaeGRyOSfVE2/AhigwhFBQoiK94+395v2C8nzRFoiOMC525FQfbxwlD47q8v
         eJc6bMqlL+cg/A2SXE6I9XLmPtBydGQFla64zspS8ScFSl5GZtojE8vB5bAcS6OLq96Q
         p38SSAlmJFEYVPZdN6bryoPCJfGjnrozZaDykCosPaUMTVgZ4111zmaHz0HwTIzuqmT4
         0A6cOniXJwzPsHSqxQfgFtnra3TX2dWitk+K73pTDtcuQ8CNFyOB0wZQX3Zve0iTd1ug
         ztrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764532610; x=1765137410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKVP3OZ5lBZi1FqY+MheawVn0dvcyA4u1uUk6Z/JTos=;
        b=Dp1u9pnVDI/8LQ1uikWsivUjE316KrR1ERdCbpMmjahBAihFQupI8MECI0AKn2YJ/T
         O74e6dKt5q8xdYtmY8YAvy45RbrDwnTOuj0mxvsfBZF1XU7GEGrmWeuAxv8pT6DDt6A1
         GWAeA6pVokqqgtQqWG7gWDQjdniRJFpsLeLioJTa/BM93XZKaEvG1rtZ4cmcDgaDQqPV
         pUjM8zkKqxTdD+9aZPrl6cM36BsFsmJRQvSeeCYZbPKF96hVGU6gBHMZ9EETrnl8T1JN
         jpCHyFEzoPqBCSnZvf3EOKoLZjqzcmSR00eAYKTUPw3f1wPpBa9Jaj8R4yG4uIeUjVKT
         HKNA==
X-Gm-Message-State: AOJu0Yw7T5tVazUHatbdUrLp43TAAT0tKyneHzCJAowSlmiMlMBzyyro
	liPc5WE2Raq/IeDHIQMIoF0JA/Jps/HZZwXVem3d8XMQkDpZcZiX1R1w
X-Gm-Gg: ASbGncs1WDgxRw6sBwQSCPK95saYYLaV1Rqz7n5tmtr+gmhcAT2eIak3HAHFQ/t49xS
	U5kZWY9CQUx0XElvE0Dc76HUn4nxkHcD3gKQbbgPVsY+wl0wytcjzUxzmIl0Z4kH0P2crxlhjk7
	/xCAc/mtxEoPNuq9056/sHjBCt/uyJAFh57L5GZB7/eMb4h70XKlzIwcIt0v0PNXXXyDJNqutXk
	TLDYvgHwqS7IZeCgKnhEMLEoO0gmtZdlktEE4APS2Sfsk921Jk3TVloxmIZRtKestTFpR5eMi8n
	/ZL/EhK4n9XZ+KnQthZYUmhojwOtm/E6pcPnSeme/Acn3EU43xU+VgZqnr5Bz3OuPEGVY99Czrd
	7BpUw9iR0mH0eXajZtq8inagODEEojsd6GDucfySO+N6/tf4nk3RoP3HuiXYDGOnJg56mYnLxZg
	9h4DmCeYiI+ohkJzN0ngIv0gM1rWJv5HROxUKrgEhVnhEmWCp/ooUT7tCxnX9pWzIANFt8
X-Google-Smtp-Source: AGHT+IFeqK6JL9gyc8uTpqkfcv6UVhKkf4Zlh3kFBnCQupj1W5vdorj+8KTUJS7Y4cKKdCo0N1MWag==
X-Received: by 2002:a05:622a:155:b0:4ed:da56:7a96 with SMTP id d75a77b69052e-4ee58af100cmr498023971cf.60.1764532609943;
        Sun, 30 Nov 2025 11:56:49 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b6d301sm69608716d6.38.2025.11.30.11.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 11:56:49 -0800 (PST)
Message-ID: <a4d60418-f48a-4321-b305-d37ae2f752b1@gmail.com>
Date: Sun, 30 Nov 2025 14:56:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] scalar: document config settings
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, atthewhughes934@gmail.com,
 johannes.schindelin@gmx.de
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <18580f020d149eaa8271542d7e629ef10fd8c9a0.1764195516.git.gitgitgadget@gmail.com>
 <xmqqbjkol4je.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjkol4je.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/2025 7:09 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +commitGraph.generationVersion=1::
>> +	While the preferred version is 2 for performance reasons, existing users
>> +	that had version 1 by default will need special care in upgrading to
>> +	version 2. This is likely to change in the future as the upgrade story
>> +	is solidifies.
> 
> "as the upgrade story solidifies"?

That's better than what I was going for which was "is solidified". Will fix.

>> +fetch.writeCommitGraph=false::
>> +	This config setting was created to help users automatically udpate their
>> +	commit-graph files as they perform fetches. However, this takes time
>> +	from foreground fetches and pulls and Scalar uses background maintenance
>> +	for this function instead.
> 
> "update their files".

Yes. thanks.

>> +index.threads=true::
>> +	This tells Git to automatically detect how many threads it should use
>> +	when reading the index in parallel due to the `core.preloadIndex=true`
>> +	setting.
> 
> Is "due to the `core.preloadIndex=true` setting" part of this
> sentence still relevant?

I should still include this, but mention that it is enabled by default and
still recommended.

> Other than that, superbly written.  Thanks, will queue.

Thanks,
-Stolee

