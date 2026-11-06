Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987134;
	b=tgj6uy9sXSyFekRXwXPHDoDlKO35EuP/+Es5DBrvo+fFeyVpunX5mEOmi37ntq9N3xJy
	 b95VydkZ7uR5rar93O5X61JLuDSEbQnhMKhqc8oktYE7P0aIV5m/ypyPOMlDGXA96dWwl
	 Qgizim0XDaTBxxgsj3viTxW3SjsDyZoaXkwoNhd2tuHQ952t7M32jHDUsWi9P5Dp2W4zt
	 deepREQlQQvtFrEcpMtStEFFZYgXbNLm7kYVpLRW16Ntzk13bLgVEzkFGokq8d8DPV++O
	 TfZ/IksASgmHmOQsONOzUSzbgm9mbywgPvsloyNkqDgSFXD4HcfM5X8riGH3m6xagTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type;
	bh=R1kgA9kfm2YUO03b4lCH7IpifLG2BGN+YGvGPOjwBtE=;
	b=N6nxuF3ZJTBHudwf2v1e/a0SW4LQG6f632mS1XSgPf3e9juD5351YVGqfPYal3gEzFC4
	 UIMspcAtBtSyro9VNwDGW5232anG1ZE9T5cPF2uqzSCdOSCP6iiZJJmWQkVw7DVX4r16D
	 jZhT9x4zuITSZDdONZVvZGgFGceaaFm24jZNnVITdq7V+J8CkBiwEDZlot445kFb1ZoUT
	 bX/Q20rD+mmJcBXKdWWgmXBNm6aE4tDXB7nsk2TLpip9vZEAEEojfhY1RwltN4Gjwd628
	 KNAqzgcXzGUvxGsCDs7QOdmcNZ3KldSw6jaHXR1H4vwPYXvai+qPUYIOYaRivfm6DYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRx+7Wcb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64D2606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C64D2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GRx+7Wcb
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-823e4047037so617304a34.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 09:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987133; cv=none;
        d=google.com; s=arc-20260327;
        b=K7aNqUPVpfPquw7a97sEUOTX3LA3V0+s8Z+hWtJt3748L8HIBP0ZcISbGLpvKCsr2r
         Hqkw2WNiP8OpplDVypMGp83l7/q5ph4gTFnAgCcOsmG0V8IPUzXwS/5StMCNNeQ+jPHH
         X/dC3z0swvq59psGYY1tzMjeXn3gsAAQ0xVvwN0xKVZiuvTdmqj/9yB8qMm56DWbIJcT
         WKH17begKXRgqNh8B8HfZf1K9Qx0oZnSvoK1A+sDpeHRIwdASz2oNu1npZ885juKYkHw
         t9KCNRPEFZGxnuuHwnSQOtEPmXEjhl3z5nFkRmXtsV/9nwmMP2pznxTIOvr6nDG5H7k7
         y8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=R1kgA9kfm2YUO03b4lCH7IpifLG2BGN+YGvGPOjwBtE=;
        fh=MPfLd9lJuqfwYG83TuxBt3lV3RoOABPZZDYTD4SQec0=;
        b=NjrxJlX/PPXlLrATyWilduMIPDWWhZeL63Bc9e4/jsX72QHrfF0Nph4XsfG8LQwq6x
         QCshqy71Y94wSUzRW8e14NNxRcAZqcFFut8rLnxK/N6N1Tpoxit9B/N2eVIjOu5fXg0D
         OXfmhe+bYBc1HwffLFqFztc8x/t6aFZGJUIXJxt20j5BIfDa1P5seFwsv27V5+6y3MAt
         WDb0EQhZdQ7hKTYe6y6+mkbTmXzkYPeZBHiAsMZ3IjLyrAmRqRYqRY32ytUNbhcYxUOy
         fTbVzeSD/u7+2br8PglL4uJz//Sr/ovVhAbs3BtO8mDqVNuEnZvQ12/UKskd5TjPIJWi
         DPTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987132; x=1794591932; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=R1kgA9kfm2YUO03b4lCH7IpifLG2BGN+YGvGPOjwBtE=;
        b=GRx+7WcbGglPtlhVqHMa/93SPXoRzMqT0l+03v6L3dpKzXNnxgLLPclS8I4pym7VaK
         JoB55SdXQWzsA2VnKeUyuTTSD5QvGf0Uqr+TDNCc9K5OC5FRLOzhTO+nUOvZ4qbz6nLP
         7xZ7AZmFnopESIpudcZ7igXKSG8ZmUmvB1EnYTMGFNkYQ+hXC+xrID3c5trBcjDyfcIh
         ZdYl39E0ChLSzCS8E9IVcpuGd+2YOb5AmOI/oV0cw5K7+wJb3B2//lqmyphg0Rx9ip9u
         Tkd/SGE8ZK0aAAxje/Ypf3GAQ0g+yBUdLVHlSdmRRPb2oq+Mpcv5Sb7nDnNb0DhILrI0
         /E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987132; x=1794591932;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R1kgA9kfm2YUO03b4lCH7IpifLG2BGN+YGvGPOjwBtE=;
        b=aVvE/D4g7os0CioNnbZPiwPHxhxvdNPXUDdNJkKpYtmHOSTYQFmEE0nFqe3UjoiwTr
         UdKXI4sxtk3Z8udRmSYzAOtpQh7nKpdB9WezcTZ5H07630s2SuE5SOcGcmlTBuImvcvZ
         4wOgChnHo7cmxBRdEWdeXfCsT00lI5guvfGqSfYywNi6Fkj/YNQO1ieGCBniWzAd7XbZ
         u/8RWzZkAd/iLgLYaIIbuZ+ghn3A4JdJyo+Qv/Iqu5G9uFHsyRNm7BQDJXrfheEB/7ut
         2Gd+dgTK2PccoVGjvsM4eqKr+X5kb1+73GEcVKH2NGA+kJRDarwnbKdp6vtM/KwM2/lw
         K+AQ==
X-Forwarded-Encrypted: i=1; AKwUvBxu3qRqeskYzIW7Wtm7ukmffF1LTsUmSpZn+HfzXPU33LftQuhX2tjJLnbEa12wJ7YQoQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+soGUn09plXZ3HcA8DaeczPZfUcIciXL2/PgWE8ZM6+aydU5Um
	R3mXoQTJZ+LuUDFLcL2GCMEkFG0LZgjQO+mK3dlViRaMYRrRRGr0Rs2hW9gOz3yruv3wb/ICgra
	Gq2f+x6GBxqKuAGRa8KQpmzteJ6t2gZY=
X-Gm-Gg: AYBFou3WuaLd1sbVCvQ7jYPwV0Dnf0BfE69Djy7OxzUXvdhmgjB0kfSJi5RiDPJdIjk
	K1neHPprRiJAPy+by2D1mgIcGV/vWHG/JuWfU23SHmbrqNP9ydH3Gx53a8+k0MoSZkERjMbRvAW
	jF+3h8gXq9jYe46vL+W5PXMOhvOfpVeUfDY5RolgZXANo4dPrgKQWxTaqvGEEiDp13AeL1/0NYh
	lTgPC/de8Ai6ZtUkn4VFdAfz9+dyEWS1od9GxM8wfQDiZl9R44tlfUwHM5fjVkheBoeaw36QcNE
	MbUYXTPNHpRm8B+B1r6Ldj4VwbhTMHTXkFq629zSFv3QEhtHmyyqYJC7I1NrZjXH7pv8bD7wtsC
	dZf1AVmDLSRuZgDrTaJXjRhER0B8Ezbi33KpnJ794M22R7AfitDJzRd+ykizpYS7mlkOLXG9vCl
	OOKwlv
X-Received: by 2002:a05:6830:2e11:b0:821:c75e:5309 with SMTP id
 46e09a7af769-85f1cf7c2e9mr3351598a34.7.1793987132487; Fri, 06 Nov 2026
 09:45:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Joie Joie <soniqjjj@gmail.com>
Date: Fri, 6 Nov 2026 18:44:49 +0100
X-Gm-Features: AclHuK-ZO6fBiIES2gDDl4q4KNLMF1dFpfMj05QxppfSlydV14RL9keLces_64s
Message-ID: <CAH=d44co_ZFA8EJwAoFL4=88ZqWzO65_+GbHDZfjG8amR4cHBw@mail.gmail.com>
Subject: [Outreachy] fast-import: Use repo_for_each_pack() for duplicate checks
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

I was looking through `fast-import.c` and noticed that both
`store_object()` and `stream_blob()` still loop through `files->dirs`
to check whether an object is already in a pack.

I saw that Git already has `repo_for_each_pack()`, which is used in
places like `count-objects.c` and `pack-objects.c`.

Would it be worth using that iterator in these two places instead? The
idea would be to avoid accessing the files backend directly while
keeping the current packed-object lookup and duplicate-handling
behavior unchanged.

I haven't made any changes yet. I wanted to get your thoughts first
and check whether this would be a useful follow-up in the current
refactoring work.

Thanks!
Joy
