Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793789177;
	b=JyBIc6F+eZwhO0BURHHZWdRAmz0FUG47hKyfOAYTakfUAYlmHbQAePhJlBxMYqUbo0dN
	 ci2MKBIWGHsM7Rfkz2/E50yFnBjX2CJCdPGRa/i60CfxByxYk5I19f4ktXE2QNNKouL1u
	 6Wju8ZWjFAbzPMUNyZECHMPJzGO6Snsw9wrN/nSEfEugSidW3kLz+cHkgk7kwrtpfLroM
	 JdTftsMbBP+F11aEA2YXDJVZAUjeUcIJ9I37bftoCB15vesUT9eEq+Nu1irywkXiSLKR9
	 hePqPSAy50K/wA06UKnrPPGHH9Lcigay67EyrLjlTYh2RTjZW+8QqvbSEx90r14hWJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=xGDfCDliBUTVchMDDZpTfang5ifej43r5z++txgwe+4=;
	b=ZxeZ91DloHACw/EzsowiTE1uXlb+Qhl8asdfNkbdmgFqjJt0fbfm1pHzTd9wYTQqTwMm
	 L988//BmOTeZPJqJa6X22/vOxJ4PNjWSy/BtAyf+SMGuZh/CrXQnIphLpZ2rWrEP/V2jW
	 r4V2zElVfe9LaHZXL43kcgs/HO2knCwGZTKcJLAa8hZrN5zFmkUr8xz/82NvFGqMYocMP
	 G50owhw7L4XLF6U/uvbTFs2L+BY5qjgnuyjVyX2OdbgBokwg3r67etT+6Hw1WLYQQ8qD/
	 J76V/PAyvMOnZ1izxyZ2TWFhMav40c7z3TjyToqLa/iHlK17W9ZzYClJinnpj6zmcLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Emo8YPdy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8150606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8150606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Emo8YPdy
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc2bb73cd9so116174137.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 02:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793789176; cv=none;
        d=google.com; s=arc-20260327;
        b=Cqt9EV/WGzPLyQxIYnFbCZ4zXbetelnwW+BVoIRen7hGc/f/WR0ZHk5LSDMvH3GR/F
         pAnoJwQK2BggKYuUIaB4t7z1+d0sZpR5GzuW0+iuj/BUDHZULNBUvKrVKygv/3GN7t11
         acolhBxDTN6kj2ycAAZPgaYWa1eE8PzqPICVEvpMpN/hh3P+SHi51Z5ykI4n6GnbIxiF
         DR9H5cUGh/lmDjaqRAcnTcaNmBkJl3DgiyhCt16rk/IGMQKnU5pfT0e78QTq7ijQ8QEV
         dQwBG7pD/IQZddVGOhOlmfxVa1LqNPYZ67p/haykLEZ3im2PKMOoK6NFdKSXRZf3UTRD
         lr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xGDfCDliBUTVchMDDZpTfang5ifej43r5z++txgwe+4=;
        fh=PCybN1kHabcpRbmmRDGdlW/gD65FXRe9pjMm7QBleUE=;
        b=nXfgsh7E5uWGT8oLYL1ZVfwtQm6iyOoHhtXIA/AXq6yuwUqHIyguKveak099nmKG+J
         5/M07zpGvYvp91xm3XPY3bPPLjXKxnfhsn5b0EtiLtJEQNq8OE45pCPiuUhiinbgRYGf
         eIMv64jVk9VTJfjPqUJPlWaAPIEbx+XqCuY9y8GJ5m/x2LmoEJ4k0KEkK/r8C2k4519i
         xR0/yzFZ5QWSQWQrsoOhXiR1Mp/q6yA4WnIxcbxQLejEhjl4oDi0FTTTP9xHhxjNed3o
         IKdim2pmNXaR9fnLB8xj0nlffJJ9BP+VFPJ4IUvXNKTK2kZIrNXqkzQ0wfMEiry5nyjx
         hzgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789176; x=1794393976; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGDfCDliBUTVchMDDZpTfang5ifej43r5z++txgwe+4=;
        b=Emo8YPdyX3rIi9gqjHdTxgjdX+2wyjub2EawDF2X13iRhwZTEOL6F/ZAhNNHoFp0hA
         W+oTwbNiTWdoOhSFGyREQ2D+BaZrDf9vF2hi3lGv1NaX+zVXdgchZ8IUI9O4j23bnNS1
         62z1+i76Vf/IeZ1fQevZTGxelJJNjMDo6HeIVwZxHp8Fw5XYtG6Mp83fn44uNsYsWh7y
         6BGdSggqQIscu4l0NR+DROM/SKtVfVpBtgDkRRx+R6/9IFLrrCw0uIzzTra/RexCk+nj
         1wo7WiTMiJqh4zeBzm0ystKb1xaMJ+xOFWKmiBdQ64txDjFoXwAB205l9W35UxpE1Px8
         oagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789176; x=1794393976;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xGDfCDliBUTVchMDDZpTfang5ifej43r5z++txgwe+4=;
        b=MVzFYgh9DAo6u1UQYu7L12habNDaW418SOlZdSGnf/3X7K4fBD4ej4cssXhSI8TErt
         OWQ9+nl9m62I0OCF/y96+bwWi7VIH6PbNDe1WjMXDhx0ZYlZ7b3RKwqLjtmHz5x2ijZU
         MLHE7YYSIRymvYM5ZOISoFVsy92802t1XJDxLOolkS//uz5IvjHMlX2sr/hDUnP/iYLA
         JC81rG3m9Zx17T2VuNN3w38ROmuRRLA2k2KvJ99y0KCWb0LqFHnl++Qya6ECabC1VW9J
         P5zuNvR3CybFhZQWBEXTUzT/IBIVuCh+n8kR8pdu6t8MMwba45TnPctKAIAmwyDL2Fka
         QKWw==
X-Gm-Message-State: APuU4Z/wYtE8vvs+MQEks0ZLiS/tQjG1zfv2cYMZMv2OjNkPpld2eoWP
	oKyyvyRBPzVF85et11L4i7Ev5RaGWA5BXKFHqPsHRIaVsFXxqyzbFgEFlye5MeU82cTQsm/B8rg
	06Brt1zSUvO52YXpWuBL3B7EJAP50Lb90Ir+Z
X-Gm-Gg: AYBFou0Yu32mX9X9Up1iiqX7FfQVZCQxjHlBSuSpFF7A0Hpiz0OU8YRcPKXuZC5WjT9
	Lfxpx5yNGYr2O5KLwz9/YgUPgL2N53NAqPAhigpN5FOT1JPiOt4FrrJhC73ZG1tGbCaPn/jPM+V
	7AWRchaO/xuRydckne1/Od1wn471PgkrV0lmD3uQDtjbUwMjx5gAwKQBCaoHkEeDrsQdbilYquL
	nJYow7mekBwj8+RA6BdKj/zY85GSEcWuQ6c/yMbjQDOkj3PBe0UpGveazg2lX8s7zTxCgGEQzoa
	CB1UhiBzw6FoSBYj6XiY3gQRhv+HXI8LBN7nlSi2LAJXynJ6NsfyUaeaEwW8EhlwVy10eONe26r
	I1wY8/706stEuduQ9NLcTI5nuDNkYKCuai8Qme8miqHpDifrDyJOrezDVfm5KE0hUUk8ixIaCpM
	LWWwdVdAQfJlYbE3U/dWdgvig9
X-Received: by 2002:a05:6102:578c:b0:7cc:1f46:65bd with SMTP id
 ada2fe7eead31-7d072c22993mr5832135137.19.1793789175815; Wed, 04 Nov 2026
 02:46:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
In-Reply-To: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Wed, 4 Nov 2026 16:16:03 +0530
X-Gm-Features: AclHuK-pQzQWuSYTRUB2Cie_XINcoTJpqMoF-wuSZSqKzC-MdCV_efIMNPw1S_w
Message-ID: <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com>
Subject: Re: [Outreachy] Project Proposal : Implement promisor remote fetch ordering
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Nov 2026 at 15:56, Shashank S <shashu8660@gmail.com> wrote:

I am sending a quick follow-up to correct a typo in the CC line for
Kaartic, and to fix the links to my microprojects from my proposal
(the URLs were accidentally joined with the text in my previous
email).

> Microprojects:
>
> 1.  t0081: modernize the code testing whether a file exists
>      Link: https://lore.kernel.org/git/pull.2254.git.1791962806807.gitgitgadget@gmail.com/
>      This patch series was integrated into master via
> githttps://github.com/git/git/commit/e1bb515788e48d500c9d4e36f13c66c4daddd3d4

https://github.com/git/git/commit/e1bb515788e48d500c9d4e36f13c66c4daddd3d4

>
> 2.  t2403: modernize test for directory existence
>       Link: https://lore.kernel.org/git/pull.2259.git.1792125111461.gitgitgadget@gmail.com/
>       This patch series was integrated into seen via
> https://github.com/git/git/commit/c645a5db002ded161115dc8f6c15a40acfdde2b2
