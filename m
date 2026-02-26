Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F33A0E97
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145543; cv=none; b=A+63bhYW/8qPgZEZiuHIGm4qQkHsiSUaJVhy3dRuuDXdDUqBM/Ccdak8uKPxqZt3c225HFVP09CvKidHYxlJAeN82xBAiYqhHj1oAGAVHg37tyedFCGJYDz3Q6kDahWnteyqL50kvq2Incl7Qthb/K6GA9vZ6yVYVvvcZAj0WEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145543; c=relaxed/simple;
	bh=7JmuGnkKyKL93kM0ollccuHX07Nj268Hpyvzy/8IdS0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ECrw0lbsDMK35plpBTnL5KP47DIT2TjLmTmqrmW38W5HjHD7BkcclHLHIm5kSK/J75VlauqSnkEMLhDX19unzXxbYpexLJLyJ5U14eWIhAIcYMOFMldW6RAygGMglH+fF73T1UbDMlQsR0nJVWsTaZd1bBGBaqXihOlCWSEDG7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjRKYFg; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjRKYFg"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a91a5e64eso550881e0c.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772145541; x=1772750341; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNk+RN787duxkT6/seE80qUblE/gg4N55TkaIlDGAzs=;
        b=iAjRKYFgfUq++qT7KhkBmsdXw/YSeF9dLZD+pZ3lWBHUq8cNglWuh0RSTrCESHsuXU
         fA38XgRnW0u6zTAVKeu7RMdavc47zmiY7Ha0eMMXcAN0hPpuVL5eXXKPmpBzAMmjA7UE
         lCG72AyeQRgNoGYYycWU1X8tndsx1Q0sFDoFbVzp5B3Vwc7hY931zc6Yj+rANUqU3Bng
         OBgr2zTELa9frALNcwxlbHhhFK9X73ntVGUATTQSGZv2Bb5YLI35QDMzBtL3++FW0pi2
         wKjgoGBS+XR9W/smcnPXjoNQOx0GphrsA3FVGmblqoLrdrPGIrjdXq7HGDsrgPXCUzDS
         WcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145541; x=1772750341;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNk+RN787duxkT6/seE80qUblE/gg4N55TkaIlDGAzs=;
        b=TKAyPaRsVB/n5QiM7Y70SNKE+SRGiPEUo8caYpOMejPXdR6m2kRO0lsGN6oznV1SS5
         Ln5Bf/r25IVHH8O6PaxmVf6wrngtPdFTUjeNEVZohIkpqsU9qTmxO7l8kxf0mQ9/AOVg
         /s3QrRJzSvLTljH9X/OCgvDczRJDlPPtKiiXLlhxCNtY4S8NOsM+3So4eRR0JWy465uy
         gJW+sL8kjPEDoqu3BrIZQD39CCsr6mjkb/0ntXt1na9iSnTTiaTREp5/IT9Lt/wkFhop
         +69lQBgVMh8W183zGe8cQ+ddlREKofrg9UCl1sOYnIHSk4Lgg+iWgkxsBjgUeEVdcyEV
         2LyA==
X-Forwarded-Encrypted: i=1; AJvYcCVlXEdyApzQDuc3rzeWcupL27EnG+bj+9PMBgQPBI5uiiKjhHvF1C4Yt9o21ZPV9P9toIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+BP+ajkF6cCYAABL1PQrDjVCRSR5yBRYz4Vt+QUCYKBZSFvD
	L6U1UybZLN2xfduy3OPmXqbKgleOiaHZi9KSytRCN53VKdZak9cbxez7
X-Gm-Gg: ATEYQzyvkRrz+V2wdDIyN/ZDC1MN6c2ozb3ybGQCj7SB9/On7rDFyHga2a8VCKYoTEv
	jc7PToKQPaAM2E+B8Iw4u07f7DbAyE8yPC65KLtuxmf+csAaxLWB5zqTKFb6rub1PknuufFUtI8
	KQk11Td4zoJk9KwYUmpg+HiyZ5zEbnZFb56VQIvaPM+wDiTb0RrqFb0dZCFeAcPibxoChyYo7Qa
	nyJQsvG4XTWFGOJJRuX8zNC/PWcDmYNpUD22PzeZTI+VTf5pxXhxxmckz3EZGUsEVdtD8DU68oc
	W4zfDCNjQ+ZiepqS1c3HV4PULqNofkjth1Jax09qG3zvqfK7GRuL35s5EDYJ9b7yNtpT7TRRb0x
	mOK956OCppoBeLsqpJZyUJWEWamzqeROgzrNyf/qbNSJ+JD/iWi6/A8xZ8oJIYgky6P9PvP7vG0
	+/YSsmTtfIF8Ld/m1ksrPRlE0A7jc4/sC8o6fliMSgbOJ8+3ahT4e7wPCJdQj7dXMs
X-Received: by 2002:a05:6122:3a02:b0:566:2711:d8ab with SMTP id 71dfb90a1353d-56aa0a12cd5mr441104e0c.6.1772145541516;
        Thu, 26 Feb 2026 14:39:01 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a920493f9sm4213694e0c.13.2026.02.26.14.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 14:39:01 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [GSOC RFC PATCH] builtin/repo: add path.in-worktree field
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqtsv3uoc4.fsf@gitster.g>
Date: Thu, 26 Feb 2026 19:38:46 -0300
Cc: SoutrikDas <valusoutrik@gmail.com>,
 ayu.chandekar@gmail.com,
 christian.couder@gmail.com,
 git@vger.kernel.org,
 jltobler@gmail.com,
 karthik.188@gmail.com,
 siddharthasthana31@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <AC839D5A-0221-4935-9E9B-92C2BB612C60@gmail.com>
References: <05C28DD8-251A-4990-BBB2-26C144CAD982@gmail.com>
 <20260226201643.5152-1-valusoutrik@gmail.com>
 <BEE3B56B-F8E0-43B5-95EA-8506A84CB2EA@gmail.com> <xmqqtsv3uoc4.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Microproject is to serve as a practice session for a new contributor
> to go through the patch submission + getting reviewed + sending
> polished version cycle.  It does not have to result in a merge to
> the project, but it is essential to get reviewed and respond to
> reviews.  How well you work with reviewers is the focus of the
> observation, and how complex the problem you tackle is is of much
> lessor importance.
> 
>> I think that this seems to be easy to do, but the reviewing process
>> may take some time, so it would be better if you stick to a
>> one of the selected microprojects [1].
>> 
>> [1] https://git.github.io/SoC-2024-Microprojects/
> 
> Is https://git.github.io/SoC-2026-Microprojects/ the latest?  The
> above URL points at one a few years old.

Oops. I've trusted by browser history and pasted the link that I
during my application.

Thanks for correcting me.
