Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824B2DCC09
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 02:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748744090; cv=none; b=jXM6VauwI09qlWO0zC7Km1nHiUVhEXgmxEeW3ipzxB0LBd0wEp9lIidnPDo4DgI7Ux/uUdxKwp5l++iManLjbdUj6vxJhv2UrNrz1MUY47lUOipEbTLFp+4vR9TZHMk/8xjRqmQmxfUm0nLzK6d6KZ/bBKORNQDSQ32MPdoFZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748744090; c=relaxed/simple;
	bh=ebE5TUc/qjoQXQK1Y01Wrc6sd4vbKFRaixDYN5sr3v4=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Z1UTVejQAZMcYzPQTX0FiqkluSswCs1w5Xvkw1uIEaWR0yS31ES33Im3Q7tTA+osMYU7TXmK/PGXbTP3SM+FRQjr1AmoZOM/2Dxd2XhrJwpqzq3KRAPFY+NgyGlwaviuWLteK66tZYPt8IDMq+f/nEemMZwjkLUqfwtVS/kL7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMJL9o6D; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMJL9o6D"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30f0d8628c8so2977207a91.0
        for <git@vger.kernel.org>; Sat, 31 May 2025 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748744088; x=1749348888; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ypo83Fv8GQZnfA4Mm+ZyFK95YGYYq1WSlz0s2oqrnpg=;
        b=fMJL9o6Drx+e0jgAHzfBPH5Y8WZaRlIqYzA54oP3GXSOtqGeIw1bCvMV2uDSJ8wSPc
         YyGJNUsLDe59MsMjP+Gk2qD2aHpZRYYs8LFh8K3yV8w9kxoYFnULfvQbe4iuKkE+mMhV
         yyPIj7287mICgKCrk/wx2s8CIBX+PW/2meEdmHEy0qfMVipgIawYM3NkvDd1k1O0YUzP
         0oeCb81X9AJJnEel7kDI2nFjSGkNzaPBoFu6/GNvDOQAbe2tH7va1oT9xlULEzicO4K7
         PoZFDlBPRqUEONOz7KWPuU23oxHg0SuK8AuCSliDIqAdppL6sSEHYqtWV8rI2N8X06qJ
         wMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748744088; x=1749348888;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypo83Fv8GQZnfA4Mm+ZyFK95YGYYq1WSlz0s2oqrnpg=;
        b=xHHaDnz23wGHnn3Mbrqb4eDTvDmCWNAr2lnPkeBGEb7S0B1ADnwjwJK3kdbEHCRuUL
         YOIvK84uVdnCpA7YHI8oKLGriP181o1VPMNLMstVCEBaCwxZb11YH0YdVNofEqV+OcWj
         zQ4iy03yabKMntEbvLGkd9OAMOhb9Kz2Ri+8fAmP5gzb2zlXruGDY3K2yE0GHY8EC/aC
         6ycxjyXlTTIpyoOMsmn/lEkBecYxAvvhHd7NVQENrhqAzJGixwCrJaNouhSj5HvPz330
         t0FbJlYbkgbsjb4Ysd6hZWIoMNy9En82yq1USBB4nS4Kiu6PFTwNuBA1SGH2OH0KOz8Q
         /3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXDvfJ7dMw5C8GloO4nRQg83T+F6oNgl5roR4+uHJg53aKZgw0H4OQpHS7U8X+ifxW8QYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOb0B3azQuyeOFNx9fjqFHEj8y+tvZMJz8Jayz8t1f5/aErmyu
	Bez+A88ZA3fGHiPnUjVg3lQsphhsYW+A11RiE47zBYYmZYdw/49RvRDA3ijfzA==
X-Gm-Gg: ASbGncs1AQWbe9koD4i59AnGd1E3CyWg1t2W/QMQHv1/fuMaixD8tSPzZYm9FtkRfdm
	ocLoSLrI7FSk/17sUl+RliwKhkhyHY41MajQSZQmSM8+5pelUuSoRcdIOP6QL1iA0jwhj2FUM1Z
	zytGSkES/ttmLbVHWVeGTmflbrxx4y/AWgJCHiVcNjnFUuXktp5bf/tPNW9R28zWmB4E8BTq1J8
	kI9d1VcwoRv7Ga57Y7iCnAbSqGtPc55JRso1uKRNUULNwZ9LM/pvxZPIMlqTFWPNuAdO5Zjcywu
	QYXXOtO47Ih9bU14u+ka/A04c/oKWIJXSc7GWndifcs=
X-Google-Smtp-Source: AGHT+IFDz26gGSAN0FVeZfEnre04pHURZaTlG66wYdv4Ygl2cu3Ww30ySoVOD0gX6b/8EapULGmGnA==
X-Received: by 2002:a17:90b:1b12:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31214e51de0mr17791275a91.10.1748744087637;
        Sat, 31 May 2025 19:14:47 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::eef5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3c0db6sm3648249a91.34.2025.05.31.19.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 19:14:47 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Subject: Re: [PATCH] thread-utils.c: detect online CPU count on OpenBSD /
 NetBSD
In-Reply-To: <aB2c-W0V83aVDpZr@humpty.home.comstyle.com>
Date: Sat, 31 May 2025 19:14:46 -0700
Message-ID: <87msas5ht5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Brad,

You wrote:

> OpenBSD / NetBSD use HW_NCPUONLINE to detect the online CPU
> count. OpenBSD ships with SMT disabled on X86 systems so
> HW_NCPU would provide double the number of CPUs as opposed
> to the proper online count.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  thread-utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Looks good to me. I tested the patch on OpenBSD 7.7 and NetBSD 10.0.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>

Collin
