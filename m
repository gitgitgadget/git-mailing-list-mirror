Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795223010;
	b=UMrg/C41/GZSfQFMw44qH1cyI0RWUY9sV2etYLFMLALBVKWEP7itRdHno4r4tBDq5Pi0
	 HFk4kcWfrSZpnqWzqkYOXAmn5KqKIZ29NJaHxDpagxW1trS+48TNVPVCOmHPAVHx3Vyy6
	 krsAnyhpeC+ixNzN+yvUNocPx5yINtCK2aJzW7I7AY/+euRxO3oQfcuASBv/p1RpqPOob
	 HxJVgg/JfuLEWmw7RIM964SLrKCmFvzHinpEFxf6BU4LiEcgLnOPxowWGW6vjTEDYyq35
	 e88kCPrdY5Vc9QG+yJf0mfLl8OE1gjKUtWqe1fiooeutv60Wsp/9quBO5LKu7iR1Aag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795223010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=3lJfXHWYYqkONk6dUJ5+twqXwOIWA/H8S1E1ksWF9CA=;
	b=MRAntHnB/wtiPULBeHJ0bj8sok9QH0ITjygkpf1Pj1T3nhBGnxaVi7IQHPgjIAPjrQ9q
	 /4omkMq9M98pVjLG/spwcX0lnrKiHT/lA6fqLI8fT/9NctjcK1ForBf0ao2h9nXuCNqU5
	 Dh8qNeKwukLZV60XujhaFZNjcGX5flYPohxLqiSkyyzf6ylfRnOXDQ1n+NU8kXuYJBiGC
	 lDMFgwl1u9r7RyunquGA6QkNbVtqjU2No/Szs8ELIgZ10sNdoeu88BPY8ts1XftA43zN7
	 fnRmnZ2v7mIOWTC0znF3H/1Pne2cCUeIJkQymOGi3MlWkjRNnRz9XAx5EMkKYpHaFKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=theorem.dev;
	spf=pass smtp.mailfrom=theorem.dev;
	dkim=pass header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ppJs5DeU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93902606A6A2
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 01:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93902606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theorem.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theorem.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=theorem-dev.20260707.gappssmtp.com header.i=@theorem-dev.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ppJs5DeU
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so202918366b.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:03:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795223007; cv=none;
        d=google.com; s=arc-20260327;
        b=YIN+hGZSvgBIk7hK02AoCi9+lZ9go6Di556BAi8/mtjFecQdS/BrF6ixjV85HNpqPh
         8EQq807wjc8QqKEc/KikaH4yrlDuaF1MX4eclmmzUobTb/NU0RmboDFxppIMvgjhSP1i
         N7PMEqyQ7Ao1qrdvlFwxBUSl2X+iXhuM5f0bhG9EErb49Dzhnbzm0uGtsup1u2X6uk3O
         cEL+rxVo+Do3rxJpviHhQDmUBJbdquVznA5Ym4cLl4QD/1PWuTFPDh9aEq5x8mF5cGaZ
         CbqlSyyK1y8Ne/bpPPU/WDv0cZjNHc6LQpMGNAgoSiG/52aOIZyOG9TmmPmIL/SLU/Df
         Bw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3lJfXHWYYqkONk6dUJ5+twqXwOIWA/H8S1E1ksWF9CA=;
        fh=4p7AWUdCb8Bjx1k5s0WSGQWH2VPRMsaoxx46XhGw5g8=;
        b=hZItecUW+aryIFVysAXiN1pGvKKYuhdmwDlOS1CPkh//brP0joOfkfMXG+4EIbYvja
         q9YfmdMAB3L8hrUtR+8UrmVqJYuS7OwA4T9BjO1765NSddEWn1BdVH4xDq2yig/UEf4h
         VVzQbUPv4/zqXt/INZ8+js0issK4SjwSia4Cm5fdYOfrKmLV54M9LliRM8hOSGs5OpqK
         87KejPYSeEleVHrMN4GCcXzT1NpqP9D/6sImp7KHQIIDkD9QeRsNNMFjt+Xmv++OJ+O1
         lzdtQU6F+z3QnWCMLnyrN2zklvnk7QxkPJGkN+eMgU5Mo1nZeDZXBgNXk7zY/8acHbNh
         o1ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theorem-dev.20260707.gappssmtp.com; s=20260707; t=1795223007; x=1795827807; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3lJfXHWYYqkONk6dUJ5+twqXwOIWA/H8S1E1ksWF9CA=;
        b=ppJs5DeUMfwPpU578ri3PToYxrtfM9dMaxyLnf4t7QsEUR5l/h7L9ybanxL2+8UCxq
         s/MreH1+lj7+HFAqlZRd9QJUy+iCBTIRPoZC4MhCOG+DlOre71QdrBP8H7ZR1RCKnWX5
         rA+EdsXD/lOcDlkdg9IaQ2Knm78HZ99skP8mLr/0lL4ivKSWrh04Jr5+4tLCaAGTSHt0
         gOYDjdSDNWfE+WtlV9QIPkMhO1OQI+IG0X1l/Cr8vDPBoiKCLxUiLVJ3LlDLl/BdBxs9
         /IxNli5MtUgxJNPLL/0avR6t78znc/KXOzDP89mbRJEg0orMm3QNqpWNRQNPMCfLN2Ui
         ZZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795223007; x=1795827807;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lJfXHWYYqkONk6dUJ5+twqXwOIWA/H8S1E1ksWF9CA=;
        b=bdiUC1csSm2mHjUvjJUXGKgjWWsEBEfmnjye9/s3H0v29ubW1j7MooPt/Y2GXIwQCu
         jUC6ina1/ngv7cEdnijpgxjP/K+ZqA2wh1LvAyO8AhRDJydFkdkFTpXETWgaBGYc1Siu
         jNC0Yam5MyTkicg3a5/V2ldNH083Fl20UIIMhKu96CFk6Z21m2MSboCrBrQj8knO7fZR
         B/2lKtgITbF1dcSJ/NYkjyj+tqW31TNEoFR/fcNXcUsJpjfTFgE/GQGytjzks42qDUq/
         RfM3XBzoXXPJuvX3oRffqovhypRvUs8MOqamMeuXWQmW2q2BryskmbpJ6v0YVgvgwJQR
         YzkA==
X-Gm-Message-State: APuU4Z8TX6jYZqAuoxh8co1IEBRbdNFWkBHWFXiE3ui7RK+PzAPnUPhH
	RYFQRiyALYiYtzOPX+sPrZca1vok1s5QpFn2/sIm7+1RnDKPBYg1bwJmFHFmsrWYp3if+PdhPrV
	4WDuWFIve8rl6JW7HcEdCRIwQTHrNCgh2VZRSEPqQOi8F7eMArwg1
X-Gm-Gg: AZFdTZfEQ6gXMV7E/ZPbhybMhnBGEY0mPjnfDxENK68qS1sDbTfcm0riYdzx70CsxKv
	4SgPxESg5QktU/qSQqSXzx1iMGbKBdymV/8cnkcPPwE89KkrFoXFacgF5T3DNhShxHuiLG/zpSk
	bdtkE8OtHp+VhHY8cw4sEI/lRmMgtMUDwk61pZU8ElrLMnUOYzEE/vhQQ1gZ3GlNZhZYJpOsNQ/
	XOG9A8Mhe96bP2EHltpgbkPMwkisdnlH/efCFKiYz9o1GI3q4o/7VOTwyKAjrrzI6zHBjFJvcXg
	NYE9/YBkhHZDy8WbdBxpy40R9cqwos42OVADghGyttarXc5+/LLqA853ZmHVWkyto0UZTPSwQDH
	wuI4wl7/7bh+iQ8B9z9/TNkNSo2pSMn8wi10OKwZEEjGdYSKk7hCX4JYhHg==
X-Received: by 2002:a17:906:e081:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c513a5ea748mr383697866b.12.1795223006985; Fri, 20 Nov 2026
 17:03:26 -0800 (PST)
Received: from 410317164191 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Nov 2026 17:03:26 -0800
From: Sami Jawhar <sami@theorem.dev>
In-Reply-To: <20261120165041.91627-1-aniketgupta3001@gmail.com>
References: <CAOJ8FdczW9KxFknceHodV0jmhyEB24OMtqQUmhkP3E2vfsmgag@mail.gmail.com>
 <20261120165041.91627-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 17:03:26 -0800
X-Gm-Features: Aa3M54pZPxEzzVIcJad0KYzsGy9NvSaoM7GBcnd6q5ieFjo_fyylFviynhMXAtU
Message-ID: <CAOJ8FdcOSxprQvi36waQdhhRgDNNx=B2N+J5mR=S26o2mkgSEw@mail.gmail.com>
Subject: Re: [BUG] combine-diff: wrong deletion columns at 33 parents, no
 hunks at 64
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Can I send a patch to fix the shift and to handle merges with too many parents?

Yes, please do.
