Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F553E6DC3
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462639; cv=pass; b=hY1iYtntA3FykhbBlPCm1nePgYqjJyBysgM1NOHTZcI1XhgiKMF4EcC6sQLikLZlYSYKwjqe43Dyum0daQvikmRL+No5PzMV0l2DlAGv4ywH8QDpkVL4WjMkpSB9VKXEoE2lAsQ3AW3TN6aCH3jKSE02lz27J36PZxGKw38RC0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462639; c=relaxed/simple;
	bh=3duGuveU/iejU6b0/h7BcWqCl9CbIyZenSUBWIrrUaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjPaIXYFOIELc8Rav2wlYZp7rNRMxZf/7zREOIKa9U99Ehvn+5Nc2Hdv/nDPXNBovorG5b4dg2x2KUKMJiT0UbTaAljiQTHXiLyLsFxYrB/NIlUQrcFT2ENJQiA/kXeoW9X+vMKQtsAWde4ZfiAVywYNO42b1Q19xr7+Rimo9b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rA0+ftta; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA0+ftta"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c255acff671so27846466b.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 12:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788462630; cv=none;
        d=google.com; s=arc-20260327;
        b=MID+ip059JYgXU+5OdY8MqbvwVrIZ3nTTuSq36S1VL41/oqyXUSfeLPVILm+TJHWe1
         H2w8TiHEK/ZThHT+l0srVJVmFX+bwGWrVF5+UvvLB4ITgXt2UW2y87lodduA8q5D8eyf
         Cn9u+XoENt2P36VSIVcRHTc/tGLbuJoGiZeSHmIzOPa4jRywOSu/qYZ/01h6QT/LK6bl
         ac9Hr/rpG0f4CESirlSuo9PP6uY++pDUbmEZB+eSlchcd6GYz6JswkHScyEp4oHUcUoI
         kk5PzhsxgdbmeXal3WsSOc++mRBRTpD0zjth0EPmdhezVGQmgnjlO7ARr1ManBCC5HmP
         3kiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=661Zwovv09htlpwQV3fiid3YAqvjQWGS+wDop+qt/2A=;
        fh=01Jaklsm8ft7dP0CwV+fYM5UqeQvhogUVRu760rMyIU=;
        b=koWLT2o2j3MmUXKuQPd9zFrjCfTq4MbZBSUkv7p88GDC98G+tSwHf8JTg7rIS1drH0
         RGzh/UcxVtFm/kuKNXM/IzbSNhuprlgy8Q3lgkwM2c7hhK6aGVArqqRy2lN5pCskMWc2
         sbemF5TA/ImTC8jb2M1xpuW3nOJy0rXBXBlOHccbQWBGoA5zH9iU4bSTN2TgTpohsQaq
         H66l2DyBm+TClzDQbzO2FaHu9J1Rl4fc0f4iBRtLZgedw2T0+pfARDPzA0ziMqES74Ev
         yvD2OuCzWIBXz33sNNmUX4PvKLJ0m2zDR0slG8CEfN8HnO9xOTJm6ZR+SkGa3yv2JUL0
         qAdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788462630; x=1789067430; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=661Zwovv09htlpwQV3fiid3YAqvjQWGS+wDop+qt/2A=;
        b=rA0+fttai3qWVFDLICjuNPk+pw6tOh7rRiTM2p3fqr0xOf0Mba7lYcPI6kIK79+hA8
         T5wgIWHzs6j90Ocbi9Q2R52VHnG11BmYEC/R2WIPS9RiMBPPvqGAqiqpmL/hnwt913kn
         WvgMdk/NIuZixxZuCzkh9GAdpAwoxsWExru3gRQhv3jx0TamB+9bK4EkVXH3hKO8+Wyy
         UZp3VoKY24tOj3CkaGAj98rPF3E+bEOmAaYi5g/1fu4xE4Ncwkp6qsuhGaAeCfre3WO2
         I5Em+WGbr1uNs38o1eNf/379Tp6m/+CQRTPoDkHJCdIlhzOdweoGg5rl5Qe+iX+P6IO9
         OC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462630; x=1789067430;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=661Zwovv09htlpwQV3fiid3YAqvjQWGS+wDop+qt/2A=;
        b=JZGxwjZHziuui41H3ghYS4IJaKyCE/N09lZK3Lk15uk6CIhee56r39GF+cM+JazkDE
         LLQq635BWusdTQDyP16dF2/TGnCpTefPGGjDenSISkYMSnjIsG1zVlW7NtY9PvyWK78U
         qxnde4WHg4GgOtIf36RMLz/dACum6prsd1oAZHN3pSz0TvQH1vmic4QAjxH/ebSF/aAe
         nqZXb7JpiKjIroYszvixynJHzNvhDCcV0kna97BZs1ip9i5x6maaIoFLJJAzYPUQo5PB
         FyCh2oRB970NV5cFvCyEO3WK7HOb6tliK4SHm1jal259t5QU6qPzKGh+lP5iOzOevjDt
         FTVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzP2lDnxl8LyhTLOkXBD/gd4yTEHXKyGGJg4jruYbNCjwQXAXT8NO2g6pS6f/ovBV+qnTg=@vger.kernel.org
X-Gm-Message-State: AFuF++l2Ua/eVK1VfOaPfAQV4rifoZcfXFGESH9l6Pv3gTn09XcEljkg
	u8mm8dg0MJaeKeOkmke2uBm7RDHQCDsm+8ZbaEVR3H5Ql9H5xI8HPcCUAr58F1kMt1aXFT9i8vV
	V8JfYYgRTYjziT0IZBzniq5UyIzs9cGA9VjtZ+VI=
X-Gm-Gg: AYBFou124y4J2D0N5oLZa+qt5XBkEezY24j/grmA9bdZixdDtv+bTTypbj4u4RU9Jkq
	GvQqHw6NFzG5I8pIBdUCvxkAak/DOfvfgr8ZpG/RFcXR9dJjUJsVeYAk26LlXIWGrPxfaoEIAUZ
	xdQpkwtBHl0coe5i6wLz/t7k3AIyc+sgJBFqhvMaB5vf8Ervf1WrQdwLZOmrkVLPVr0pWGKxfTe
	sgwSOnVVBEGXSMc9V9L3ryrDzCvtpBlpjIVEUnOhNy8V8Daf2ZqTLmnfMC9tyQgRWPZsA4rG/+d
	GOIQ3Khg8ZFzwTroj3fWtCwxxdwYkXjXaOAtFxu+oo2vUHPNsOZfwO0tVQ==
X-Received: by 2002:a17:907:1c13:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c260ca22522mr50278066b.17.1788462629905; Thu, 03 Sep 2026
 12:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com> <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g> <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
 <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com> <xmqqqzjab2ho.fsf@gitster.g>
In-Reply-To: <xmqqqzjab2ho.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 3 Sep 2026 21:09:52 +0200
X-Gm-Features: AcwNN1WVfWl-EMBqVo1uTT3MQT5UHwGHHIdliUggLm1ux6vmh7J9oN1D7H4WajM
Message-ID: <CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >> > Style.  Once one of "if", "else if" and "else" cascade gains
> >> > {braches}, others should do so as well.
> >
> > I would love to have a linter rule for this, since I keep forgetting
> > and it's a waste of time for others to remind me.
>
> Does our .clang-format file already cover this?

I don't think so. When GitHub CI runs, it doesn't complain about
mismatched braces.


Harald
