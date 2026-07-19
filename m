Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AC43F08E
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475054; cv=pass; b=MpB7KA98CDw6HHtKIUgRH0SS0Yb/FhVb8y6XkcFTr+aAT1x+4u0OMu+XEVUuQFDeQe8gHtvL/pgJ0nMqVQ0KIRw5jHM4KvnN/bDlG60hzP6IUQsuAxLABdxEUOHEqlhCiyIht4K3fFo+qw8tX9VRsbM/T7sDSoU2ZgUAIBmdD1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475054; c=relaxed/simple;
	bh=YyVgPRcNGMhMSZ3CCJ4ndWHkFtSePZ4Th7KJN/3GrIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNlCoGZMTBVXe3gVazHqIR9ev3KAjIPetJeuevzL/6PgL/Y2ptVnLxXfkcrJmZGzkftwljmnYICftIR7aMSpkB5bygJZj9wo3r4XRRz3dppf0j/50i7etdM2SsKYSEIM1JmmZrGxtAVwjwkrLWGZmcaM69sCIQp1Fh8xmOMLs6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9KSdId5; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9KSdId5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1614804757so995084766b.1
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784475051; cv=none;
        d=google.com; s=arc-20260327;
        b=q0eHSOko4rljqOuNoQu+SvVPke2JqTS1/6gZgPSoNWlSZa7l+IE8KPbt+65rvKGqJG
         4wtb8NThgmAwIzZ4ejIQOW87H54JgBe9ZWYCij2oUoZqYxbH7+PSLFLEwlc0fRQixrxK
         lUEnFLkV92bcAz9MZBgugc5vcm3XPho1rdwdqBFMxf2q3GSE/PnaZXljys+o4HLcIqdR
         ZITHEyn6oSwQ4M7tXdKhAaPMd92qRwAwqPR4Gah+bTAF2+fvlbRUKxKRVlcxDYrB4JO4
         2jRFo7iscX94H1RC8Vp1KCrqUqXBV99m3+pmK5pUWl22d8YUJgX9Qs7raqR8B4DL1q4o
         ZQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=keXgxct1LNBCqlK+I1TPgOMF7a5GeiSCcJ6Q7wucXnY=;
        fh=3mJtmlslTCXE/7snQTkBiGOEvg5aO2AzKJdAHSHX4go=;
        b=GQMidjr77LT1pAYqcaipTDc5CvZNiy+iWIALcauTZVSpSqP/nzYVFSVwHA9CpUEIRb
         OueeuhnMefT7wI5DiaoP7HmjZpwtL4rUQTepNlH0b+J2z3KVzFEKuZVpPv550RqkhWij
         htk5LdF3LxwAkJikSb9PPNocsDmU+zH+JZe6k/vmXeOykkQjS0QcKhf2c0afcyPbwq0g
         8YnfgDKpYhmY4Wo02BcwprUuM1MYqC9cPQOiZodKCmoWxz1mM5lAPtrzA66DYSEB+bmX
         54IBjcyJi952Dm1XDW9AwuqrIxghfVTB0jvP3bmqGeLnASiqfkc974X3Ls4ctZt4xvEy
         Sj6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475051; x=1785079851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=keXgxct1LNBCqlK+I1TPgOMF7a5GeiSCcJ6Q7wucXnY=;
        b=C9KSdId555GzE+edgXGKoFCNH3TPatz264z0J3PNow6MmgkoZ24tp8LyEHpqRJbgHN
         eR+yleawQf+VXxcZML1znnkhFaP9ZHirYGsdjPS8Y2WVE1mIN7ft02AqkWwV9UqeIaJS
         ekkTqo3vv2QUvtpLJ8jjUwQIHjNLunom++qhxPurOuVnbM0LmvUhqmsBUSD8T8I21g07
         violRpbQ0DkYPRvuIZDJzIzfZXKoGFBEVF2FxSvI/GyObt9++piebn7+FMBnwwpee973
         Xlyc8ZcS5oHmlh7PauF6Y4jUO3CJd8FBSI/6L/UdwpV/Rd+dEFPxGJf9vgxBBkB6oaBo
         56Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475051; x=1785079851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=keXgxct1LNBCqlK+I1TPgOMF7a5GeiSCcJ6Q7wucXnY=;
        b=kyMIraHxHv0PjNX3/gxcawaZPj/umhS/+TIMeSlexBtaNo+YGbFPEfMW8j7DurMUgq
         kDdX4ayjNcfJQG0LE7nzzUhl1p/AR1aJw9ec1RFDdRYMzcWudyTSLnm2PqA4CBY24Yzw
         Sb7liRUgu4Hxlb6ldB+JR9ZroCjafTc9k8XPYDFqiAWNer6Z/PhzU+0T5pVepE4kmagb
         nZJ+jENLdOyGdXKXXSi117GigtWLGaQWExrhZobo/FgABDNV2tAJZ/JYnWTXAgSTrIcG
         /ARYqlz3eaIxyy9P9qQ0JA+IizD/dPuWc3kDYyHP4LG07hDNfWcoVxnHWPPH8+0Tn3iQ
         cWsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA92nqrjMQr+27pT+fmcloFHSsxH5RkOD9A/8hDiFbZ5xGDLwg0fw26C55s16a8fI5hl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMWMKCANoNcof21IVj4ax/YgBQobexBGw+kOalxX6lUHxDCWQ
	LdfChff/cZJVLHv1gWSSelcKpG3iaS0F33jsBN1XsQwI1cy51qlBcjttNeztZCrggerPeMud+Jy
	VhYW5BCZ1JsrNh7fnOXmHoMQC4PpBRwo=
X-Gm-Gg: AfdE7ckjM/EKp4H14tpcpX5eszs0OuaeDsmbD9/QGm4Te0vnDamFnZNPybUru1VCtOW
	PBm8LBEUerLOfpgw3bHeBKxqlMwgB09i79kYabzABid1/qnK5q1AdurmMD/sYjx/GdkiHITbXxS
	Uo202T/AQbM6E1Xk6YssTX9sAwNPfOTFOM0SIdJuv+DCCV8fLHiaW9DLd+lhqhoIJPjzJBlFmdq
	C16RqVp/h7l0q9G3wRw7B/JdeU/4CP1c5qcQuUE8cByq6PN0xKQzAOac7DNsQ==
X-Received: by 2002:a17:907:1b1f:b0:c16:afdd:9dad with SMTP id
 a640c23a62f3a-c16b46f16e1mr475180966b.22.1784475050903; Sun, 19 Jul 2026
 08:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com> <a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
 <xmqqtspvptqc.fsf@gitster.g>
In-Reply-To: <xmqqtspvptqc.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 19 Jul 2026 17:30:11 +0200
X-Gm-Features: AUfX_myFqZkZdx-tFwA5x3Fy1sY2SE5PrBkSi2bsWMAlewWuk1POmG_SYbC5-UU
Message-ID: <CAHwyqnXdaPeO12+p=_+_ttrknV0-VqTMnH-suS66yZ4stsBKnQ@mail.gmail.com>
Subject: Re: [PATCH v19 5/7] branch: add --delete-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I think I can fix this with

```
    -+  if (strset_contains(data->deletable, ref->name))
    ++  if (strset_contains(data->deletable, ref->name) ||
    ++      strset_contains(data->spared, ref->name))
```

I used your example to write a test about it as well.


Harald
