Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793018978;
	b=T8fKx4RqzPe6cHhnqTDYBKa8uVb7GmoZ4QYVTPgnfIvxi+Wuavvyo0a/+293ZXdyjaao
	 cbFWcH4hxnZsB053o02FTJw1tbDSFlS5CaMQPkwd7oMso1o0oiUUjYz9e/wi9SgRNscWY
	 wYPZV3Z+JUP9Q8s4nDrAbXCE5K7+rN91klhsbXM0UZInlzunuH+X+f0yq6DjIWemLMUJS
	 CSXhjQ83nFkcCfmtQwVI8SPB2JcC2sXR5Fxhc0KGn2g/n7AGeVIQWPYk3zGl8S3SFaxqc
	 wdC0TP3z6lY0ZjrNHzgbeI165iH+d8FkFQrSsTffkwqhRCfk9LTXew/+tWsDofY7Yyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=azujMy4YXSAKzxi019QKjJHRH/7sqvvoVJNCApkDGfw=;
	b=0uLjphYyvyJmiT0NmbY+jF++FF6k/j9hJeIp48AbKC8QMBRrbKjvuWypIBi1oeNWAYf2
	 Acu7IBk+i501trcLqIo4WhUI1Cszcjo52/YICz1EHhYrzLxROGI+AE3D2YUFUsobT0c0Y
	 Z+7nVW3WHi7Artg7hkIoTgvK6U0fTyuLqxZ8Tk/h7nGJWScAeofZqnMnC7RRUkIcFrgt4
	 jzBVWsn9gZmsddvYwgcWpHeoZGQ6Y6dLEIBjtAnEueDnQHlqL22dWbegBb14Xzq3Oo1Gp
	 co66WhpyZ/CRzTl6QniSxWGnvN3hRu+rMdylzxptEW+g3H2hHqdjeEZxsF8Rzo+beqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O0a1NfJQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3B606A327
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE3B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O0a1NfJQ
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso5729400a12.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018977; cv=none;
        d=google.com; s=arc-20260327;
        b=D3WLukrC3CtziOUPv3DCqpEV+LoCprHYSzXV7ZnV4+4UhvZrA7B8WOJGkNLs1VCUJu
         +dPNgv+KGSEDFOdj1bjCm1CjC9plq5jnl/uTN3tESKwVo2ffIGy47jLNP9KQ9JKbCrhI
         njyMWCSvs63h0TBF0f13ZwfHNVa68JK1EOH/R3HVSBtsJMOzk3lpZpRsJ+HqmueqxiH8
         6l6vha0FPVUGqmBgNJYkPmjIOBa3DsBSlGgX3UbWPYjy4s+A0cPvrA5Adz1Z2bEdOWvR
         hV61jiwDLLpgYITVjfbG3MIQYyjQdMs0RnGpCAhlgf/NATdOOMIPNZpLFLbueZnmffO4
         Sfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=azujMy4YXSAKzxi019QKjJHRH/7sqvvoVJNCApkDGfw=;
        fh=sCrAD80SYHRU9WDu8YXR0+zJy5ittAh7VsOz7YBzNb4=;
        b=NKvgE238iFAxWjXLubrxqrmr5ohEp/Ta8QFllwqxQACU76iqGI7ExwPeD68uGGsFRX
         6DhAovmYc+NI9az0vFsI2L+Yt3EHDU7CTMDICEWae7iLuj+Mh2zTTz2Tgu2SBEbds3K+
         JztTCeON+1ydMXrps5B2JtGXmVMDDlHpxFIN3N6UWHu7MzF7VxGoShDwHQ/y94DjfA/w
         0LB1qRaYvVx6UcuIVeQEL8fCk4y2DA47sr3Aq/m5/JXyshXwuRWw2esv5KflgLDZ6p2H
         3AVhpePbTtTwcV+KjoTyv/ernfciQ6eXCzH2kynF2RWRaZZAAxRr7qZyLNZSOXJm9C0O
         8h4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018977; x=1793623777; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azujMy4YXSAKzxi019QKjJHRH/7sqvvoVJNCApkDGfw=;
        b=O0a1NfJQ/9VBmdHcuJQjlg+aI7hZWhv+0lTfu7X0kJAHIGX3QT6NSBnP+DyKWieX5q
         KfiYysl53/XwQJlkVYxVZtGGEq+WYqT6rwtNHQgNZI007xAfSHHVrXGHmTAdFSDbISYG
         /Qbo97q6KVmd/uPdt9SLxsZ4kDQMstctpn8P2Uu0WEfUho1ywpvUyaIbXvDuotpwpSyF
         p5uyuCmgyo1BvUoqo5wOdEhCGo5PFO97iXmHYL1zrOvgXgwZwf5sThy4jVRjpmxJjHMj
         QmFH+HBMX8bWBGLeqEjiSuXser3PmwfOB1+cNX1TKJ2/gIMlpelpi+5hyk1aq/B8SZHq
         9YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018977; x=1793623777;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=azujMy4YXSAKzxi019QKjJHRH/7sqvvoVJNCApkDGfw=;
        b=1fpnx3+JSdcFGd0MZtmXZCLGMhGsk/HgjnJqc3DYlDbvsbAY7/ycqIHCDUvByjivu4
         wxsvTkTYE5KowgMamw6pnxDYiBqyt3YHgRpQmZy2jnyTVp4E1iXaWI5MdVcW2eQtR8Ls
         UshtXTbQtlB6zniIlLmkcQh3gzPR6gHv9s8T+fvRugqFKtYwNtHpHwBbPxPUW97bZs8D
         m9/sqBz2pf06b8OGbL17aRNmaj16mEQUWtZUTGiyMDXEb3jg99Z5YEa4NIVfag+o9gHF
         oC1waxCys6o3vIvvTz/8AN4o46Y1ql8CF20cNl5tbtJNIQanl6rEOlQVODeZ1vc/JjPO
         QeRA==
X-Forwarded-Encrypted: i=1; AKwUvBy4Z8yniKWUKkF83JlcvhINCCW6+PV6/wtGPZx5EZYfOaWL6ub7skfOi/P6hN2HvCCRmkI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTpJjNSsaRuoJfkSTdVdPc9Z4XpqEUyi47aXJVxYIcEIdHJ4GO
	ZXDe9SpFhsH8ryfCbgGxHnVGzLl0o5vMYX3HO1oveLhpWh9aEA6P0Qn72Lnf6r6w65PDPdNUf82
	7ErkRp/HK7I5NpmTrKafH4K6M0tJyW/L68zcB
X-Gm-Gg: AYBFou3oas30QyJ4nRnN6GN+ImdRA0iFRoxCCf/cctriheHna1ltM3VIST9kYZKnPhu
	GDToYTc2gg602y8kjhiaNpSboDFML8b9u4zXGxnxrCf27MMPusHiNzhiGQgM+jBtTnMy1PIHUT7
	1A6nXnyY5EjghWLu/coiFGvb/J2O8LJ8y8fFv4V+YUevRgGST8Q4I28N6qeTVlHGnahwS09ttFA
	bw8yqtl9oq4V41cFrsGBcPzXjcVc/VV67Rr6P1t/ER37Rqy/z+KTk8S7DR8mYi/Vv4rr5HNgtPD
	BHd6z7gAQsDhYg07epAZCo5NT64cOB8MjOa0YMJl3btRqNm56L0bmYQr+mMM6OUB8Mhloonf2Ok
	xDXOODml8UJgdOKvZqrgzemfwj9dvNpJxNXI=
X-Received: by 2002:aa7:ca50:0:b0:6b3:886f:1f0c with SMTP id
 4fb4d7f45d1cf-6b442ff3957mr6036002a12.20.1793018976737; Mon, 26 Oct 2026
 05:49:36 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com> <e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>
 <at80qOfTn5_YUY_f@pks.im>
In-Reply-To: <at80qOfTn5_YUY_f@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 14:49:00 +0200
X-Gm-Features: AclHuK813sNGCO1DsRbIz3nEjuVmpnKNX5lHg_hPmHbHbWX1h2U1fmFzhCpoGYo
Message-ID: <CAHwyqnX2MdcKBLL5Z9Xb9XznKCkOLfztk5bM-OdkJuaOBF0LMQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ci: drop quarantine removal for macos perforce binaries
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > A file downloaded with wget never gets com.apple.quarantine set,
> > only Safari, Finder, and AirDrop apply that attribute through the
> > LaunchServices quarantine API.
>
> This is the explanation why we can remove the flag, but we haven't even
> talked about the observation or what we want to do.

I'll take a look at that.

> > 5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
> > 2020-02-27) added this to stop p4d -V from hanging on a GUI
>
> Nit: you start talking about "this" without even saying what "this" is.

Ok.


Harald
