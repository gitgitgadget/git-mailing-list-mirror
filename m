Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502CB30D3F2
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021450; cv=none; b=G3a+viox3hVumGxwXVt++U58kLVtJB36BqHHvYzpZ9JihVk3odLpsJWIkF0H8ghCTZaYFzSRTGhpY3icNIEVAmdQ1WlUH9YjrZD0w+EjAJkfgdaCbupveEDPZQGTAlJT4KjI4PwjT4Suv0oJtQSse+4uInjI+wdVnaodHq1ocRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021450; c=relaxed/simple;
	bh=RGw586pnjGVq+p7Eig+aMEfiGAuMHbKHAG0tedDt1D0=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=ZM75xrAWrU6+lBXKVYg7Ny6o3qRaB7XKqzeLnLOnr/k5ZWRDI6Z4ATyTew3rz+LSZ66oiG95JQCHy09naDGyCOKzFDikMiGfiedHfnlgo/2OKghPWsi0qq0oOThMoiIrnLfgwqb2+GTQf67laeNuLknEpOYIsHFVLhg8Qx3sTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=williamstechcopy.com; spf=pass smtp.mailfrom=williamstechcopy.com; dkim=pass (2048-bit key) header.d=williamstechcopy.com header.i=@williamstechcopy.com header.b=f0ClR3xS; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=williamstechcopy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=williamstechcopy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=williamstechcopy.com header.i=@williamstechcopy.com header.b="f0ClR3xS"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664b1bab782so320624d50.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=williamstechcopy.com; s=google; t=1786021445; x=1786626245; darn=vger.kernel.org;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGw586pnjGVq+p7Eig+aMEfiGAuMHbKHAG0tedDt1D0=;
        b=f0ClR3xS0OOEm9IHpO+z0kzhRpvh0qy87RouPGJSAqz2xbMkMmrVg7/Xi8Ul0Poaqa
         PkueR8226abZWgdG2UEzf6Ct3vVP0Li3Xo0ZcncjEe7Kyri1tB1dIQa9UlCdkjgzqa+d
         rpZZ4L5GEYn/c2tVk8wQEIKThptkoTvgIlOPWuEMNyxURYL5FsgYzibWdcaYiST8QaSx
         XgFdPzMebO9E+lu3Pj6atTHye1++V6Ps2fqQAO/FVI5pBL1lQj20MDcoeRxo4pKhzOiX
         0Ued7xOXDrYdL3YO4t/4x2DnFKdH+FiBaAEahx+QimhWtHP/yWvtjp8gGHG0WS4jdtNk
         GTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021445; x=1786626245;
        h=content-type:mime-version:date:content-transfer-encoding:subject:to
         :from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGw586pnjGVq+p7Eig+aMEfiGAuMHbKHAG0tedDt1D0=;
        b=sK1k2NP5+bTzeeAl8WTRVVliL8M/ZIlFqeV2NT+Do8NfFxFBa3b4sxyAL/OOkDfn3y
         ZHkMJHXJ3rm9MnlwMxJ/89DzSUSe31I6yiZ3cV7b0Aa46n4c92TTitIK0w6Sc1Izvk5T
         KY3nDnt7jjsVyFkjzDd/rbAcxHWxH0qpfyOYpK6JtoEH6C7B/P7jPoMhwCEuJCHcec4W
         rgaXfjpEsWnkcrSw3k84g5C0AeqNRwaEiymvoNo7/SyIhQcQb2zLxbDEJouMb6GRI56n
         OeQn2vHOTDzKoOsoER+NtCtVVEAblohukFyZrXvQZsrIUNHh7Yz3xraR8bRSzqoIV/k0
         71DQ==
X-Gm-Message-State: AOJu0Ywtb3JdbKeihTMZs544f0nT4M3oGrpYpu8B0DGwdmZQluoPLU3h
	u8cCRpuF8cIJEuQo0ESa4LLkZ1IGqKGgL4vr4+mt5plrAkyKHnnyX5Wto/O6fSCIcZtws9KsGbH
	pE5SOmA==
X-Gm-Gg: AR+sD103ZYnqM4aGKQIgTTex6ZutoVL5N6FHN3XU6OorUaMB9wxldJ8YAVO/KFdxXG0
	DNEsmaC6hDIVsr1KrekyibOrHkYtSY5SpYn2Tk6lbCOt2J6DOPgUkx5aINnJJLycOIPl9uNIpzH
	DQx3XUTvV1siB6Evu87CmZ641uSKenB6hYTEUkgToQOb1lewoxoToXUHpvlavOjRKlsWwyvh65N
	HhGMWO+HTDUrJhnSTgvmYovGAgy/Y/ZXP/5VZzd+Sg84c5jkvKkMo7LxCuKZyNCzsiLWlXtxGj/
	buwUJ6vXwiW2l0GHfp9un8Pi6zY4NBG4E8Yu6VuKvn25zp9XElOq2S3HUfF0ySRVxjO72zuBZIO
	gtm4y4tfZ+C+saGyO6NLX8nu9m3Obb3k0QM+C/9/eAnsdwhRvk0QDBuIMSq3nJMNiaxNS79NvMA
	GXL1MT8HLvOU8uC+QYeuzlz2D6Zrixs2qGnmj8Lp3vBrQzrA9SYKClxgFaGTu2fqzFKY+El++8l
	Ud33CNC0Ud+EAyuWQ8jPpTw9J/e8Gv0JhsfnvXcyWJKUqjWyBLSPy2mXIpdOfriUDH2ExNyrE+z
	j1QGzNsS1EnQ
X-Received: by 2002:a05:690c:e3c9:b0:820:1196:55a2 with SMTP id 00721157ae682-82022457ce3mr73143797b3.2.1786021445149;
        Thu, 06 Aug 2026 06:04:05 -0700 (PDT)
Received: from 019fd72c-60b0-74b8-8db0-22a9a2148b6a.local (ec2-34-229-63-93.compute-1.amazonaws.com. [34.229.63.93])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131d9135sm38120267b3.6.2026.08.06.06.04.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:04:04 -0700 (PDT)
Message-ID: <019fd72c-60b0-74b8-8db0-22a9a2148b6a@williamstechcopy.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019fd72c-60b0-74b8-8db0-22a9a2148b6a
From: Alex Williams <alex@williamstechcopy.com>
To: git@vger.kernel.org
Subject: Content idea for Git
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:04:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hello Team,

I noticed Git's blog hasn't covered AI coding agents in =
developer workflows yet: Teams are wiring AI agents into commits, reviews, =
and CI, but most coverage stays theoretical instead of walking through the =
setup.. It's a topic your readers are actively looking for.

I'm Alex Williams, a full-stack developer turned technical writer (MSc =
Computer Science, University of London), cited by TechTarget, PhoenixNAP, =
RavenDB, and ProgrammableWeb. Recent work includes pieces like "Goodhart's =
Law Comes for Every Benchmark You Trust" and "Why the Frontend Should =
Embrace Platform Engineering."

I'd like to write Git a grounded, =
source-backed post on How AI coding agents fit into the modern dev workflow=
 at Git.

Can I send over two or three headline concepts this week?

Best,=C2=A0
Alex Williams=C2=A0
williamstechcopy.com | linkedin.=
com/in/alexwilliams1337 //linkedin.com/in/alexwilliams1337

P.S. Kindly reply with "no thanks" if you would prefer not to hear from me =
again
