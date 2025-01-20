Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167EE1E9B1B
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388251; cv=none; b=HFs3BCRSSSpvdw4FMteyLb1msafYvPz0aLN6mKTQIqTdJ/t9owo4KJrVIcZi4C167zA3xv2gKDYXCCsdMcXQmuNG2CS+RdqWXuo+pEm7zPD0B4OHyebRaNFAbWr9v4MAOPerm1pOX2vMDrkM+M/wSVbGH4vMXFaraZxkA7VPc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388251; c=relaxed/simple;
	bh=APxKGj/5/AT3//dgBIUnYZbOHI6AhFqfGx+k4eu6ocI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LZOmvcphZKjIXaacHzdg98UAtT8khmcqByB0vClqjM7KGFxtxdlLXUtOBSXye/8RFG3qd22wnwPfK1mqIdbyj3neytFGT441TY/tiPSaiNtRoPu03Pd9IFBnMrt6R18K8mt3EImDUkE/v4xNw4vNSjysVYqX4o07qc/m90wQ9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlP4uuB8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlP4uuB8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so7881092a91.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737388248; x=1737993048; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IPS+7l7Kox7uIki+jM2nwAs84xQnpQP065I2PQMKLo=;
        b=QlP4uuB88iQocRDY2zEfrImULsw69qbUlz6oOF55ySG760q7YuFG21FoWIVDf4hXtN
         Pa30ofWr2Yni4IxYZEOKepjL5gjIBOb3T8fzCBdfnDfzhM8lXo3/d1vg5I5CpXwjqk2K
         OC/X4Ib9Qqw6Vooix1U5l6XxKe1LX/FCD7CRCdumG46zZtM8YLBZ8dP4UwS840+mvE2y
         1zUT3Csk8+n01hP7R0nTNCY0t0Hm1AhILYmbEfRSzsHs5YLMWIFE7Gy3aFTlIDXOv8F1
         lpWC750q35G9jCT5RMbhbeH/TfQ58QVLja1CvVPlRX1PIzORHENYUrdPu7s1bbXoCsXM
         abYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737388248; x=1737993048;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IPS+7l7Kox7uIki+jM2nwAs84xQnpQP065I2PQMKLo=;
        b=qDNL0oA3qZDyQxTEP3Ng+ACpcqW5Kl8Ycs6hNQzA169NiVxy0J+tNPB4AYsLQYroyY
         iyrez3uvw8zSbEdrQSCfWAaFNVJnEIko9GeswKkGPDm5uGUz2oaCvtpv/IirS40cbbeY
         I8frdOUE6bDrot8Pn5QoUEFhGjIzOsRLdoPJjh9wK7OU80E6IHWTGHDVs/0oP7JpsUyT
         qXs6Q5aXcQiDhpJIguJYbQeMJFNLj949guiUl/FcBcSfJS5t8yL8yvwTipfoI1LflUO5
         yoA0ui1hc8f4WZlwPEyFgxlh06zwYvfl25JlA3KrAktZ20YLpSWPg9RhNXRui7fJ3264
         7e8w==
X-Gm-Message-State: AOJu0Ywpp5MwGTl6NA6X5BBSIz+i9a0p6ERa6nhkjS7yEwhbbXRmpdzU
	Ov92oHQ88Y8qMrQ/VwjLZ/jTwbqfHpDMAwa39xTvIlChObxMFmdEtVBsnGuG
X-Gm-Gg: ASbGncuija9O3tbujabFS5WJj07q/dGUJ3XendxnJHyUAudT7stJatgUu6gTRgyHEBP
	elf58GiFl22RC9Px/+6XrwcpeW89zY1JorJGwxS1S46TtvUH1H2DWgFBhvIsDgLz/JoKxI6X4md
	EqqhtRm2v3DSO6iZGxWYCQmeB8Pyc7TLfdxQm4FWt4QtW74tNquLlTe1tw6EOF6AgqQOBBqAyE/
	tYKY5ohU/VYhZrHk2hjAXC6F6gHohARvH5BD/AD2Uu/FJTbOaHsT1TdxOd2EO+NY4JL4d78Z2U3
	D3mvQg==
X-Google-Smtp-Source: AGHT+IELQ565zx2R4tRt3TFDI5PmRnPGKWER2APasovNM416btPnEfP9+CKwWTVyiNuBT6xE4vUTUQ==
X-Received: by 2002:a05:6a00:10d4:b0:72d:8fa2:9999 with SMTP id d2e1a72fcca58-72dafa03124mr19491308b3a.11.1737388248312;
        Mon, 20 Jan 2025 07:50:48 -0800 (PST)
Received: from [192.168.15.3] ([191.181.57.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81737asm7520174b3a.57.2025.01.20.07.50.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 07:50:47 -0800 (PST)
Message-ID: <1be70312-8d4d-4e24-8a67-9f320a3ce593@gmail.com>
Date: Mon, 20 Jan 2025 12:50:44 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC] Introduction and microproject for GSoC 2025
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone!

I'm expecting to apply for GSoC 2025 in Git, so let me present myself!

My name is Lucas Oshiro, I'm a developer from São Paulo, Brazil,
currently a grad student in CS at University of São Paulo. My interest
in Git dates from years ago and I even submitted a patch here in the
past (which wasn't finished due to scheduling conflicts with my
capstone project).

Since then, I haven't been involved directly with Git community,
however, I kept my interest in Git alive by:

- Translating parts of Pro Git to pt-BR:
   https://github.com/progit/progit2-pt-br/pull/81

- Writing some blog posts about Git, for example, this one that
   explains how Git can be used as a debugging tool:
   https://lucasoshiro.github.io/posts-en/2023-02-13-git-debug/

- Writing a subset of Git in Haskell:
   https://github.com/lucasoshiro/oshit

Even though GSoC 2025 didn't start so far, I intend to select as a
microproject replacing a `test -f` by `test_path_is_*` in `t7603`. If
someone else is working on that I can change it by another test.

I hope to get in touch again soon!
Lucas
