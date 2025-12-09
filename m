Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC311713
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765320416; cv=none; b=MFJW20gorKukP0Jm3gs137mAG3BMu2rSPb4zspA4qsGmxWn7nYW7TV3R6M4McA15gGaQ/lHX1X8SmBRc8n//kTGtgP5KhhirQRLO9axi3t1/h3kmEbHEz8UkaesYNOiyskCX921TqhrIUSEfJJdX2E3l5LT/whSAVm118mhh8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765320416; c=relaxed/simple;
	bh=RIuNAOM/gQPGv9wGd3S/kqtY+6WsUipUnnhZZx0DzT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naZdx3t35vORfwQghnNTZ4Ss5TZBBC0K4MHvnsfP6xX/cp3dOOp3Fyr9aB1FZBAx0g1T8K1fyUqPXX3TLzFqQO7vGFSnfs7G7yim/EUEwRMSfzb86Klc3eEtXxopuFtbdB9aEW5X3XQL5VFZ9DdptD26qau7dh6lEgsKaSvV3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICiHY7oi; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICiHY7oi"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93c6628c266so1626043241.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765320414; x=1765925214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYd6J1G7+9sUZhOmLElR831Dr1YpET0vYmaLduM6028=;
        b=ICiHY7oil173A66DZeUleq5LKUg9VM5k9EYE4Zm/rE+CPTTM71Wq/yuirI6rI1Z5Zl
         DDx6Aw86LQ2pleGhzB2GrGZkN4Dp792pAviyDISb0yJvoWgHPg84ZrOg07PT0T894yPC
         ayggZmyJj9YlH4bF0c+YziGyGvW2v7T9TCOTo4/pGxPSGvLesrLK2KwXe7VZp8h9zBXN
         xoPdt115fECpAH+xaX0uK1h46Jh2qxQ8RwK42HKgUrkxKKdWFqik8C8sGe7n0uLjHIUi
         lXaoBbvR+dNnCO5I9YPUxHty5Jj7kNMxRxywcG19WZYrIvPWBWlkv+S5jGZQ7vvIqoaQ
         UOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765320414; x=1765925214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYd6J1G7+9sUZhOmLElR831Dr1YpET0vYmaLduM6028=;
        b=fuY0NVdI1FxexRFbBLlT7QVPSP2PjP4V1STQBXcC1ezZpfLaVdK8zAb5U7WVaOLZ4W
         FiQ+Ehw/LqeOrlVhLXOin9UDC2Y04BzvBBlcv2z2Xj4mfXqxdb7XpkIrmLHDqvI2f+cj
         mZT45+ivjD5iy4DIkYhYE95wjItMp2/ohW6ML4SChQREupzj2LGuMijYHqYdOP77K/5V
         qK2ON1BFN4VP0oMjFx6lNcqcn7vPeejbi9XYfKLxXtKfloramwgywwA+dJTCWGDAHIrg
         zMXKhoSE9q62ndOh4X4gLHkA6LElZljk7r3WC5kRkPHh6IxAsIRy/Wkbn/PZniT2vczM
         l1jQ==
X-Gm-Message-State: AOJu0Yy3BCbBboTE0WrAh77lPU59HQzyFn5LJ7vWQjz0mI1wpTwv1c14
	DFqm2GQiZLhSZOGNh0ARlCw4E7kSSV1Ioe7t0CHQYrk2NthF0DBjVWj9lgcdynqk51o9au+CUlX
	/Ga89uZ4rVbk0Ri0nMR99CFCveQMxT7Y=
X-Gm-Gg: ASbGnctFVyMvIK5mQYncIeM49flqk/ySH1+GABCFngdLY8NYs1T4O9JJQuwEObmddLN
	5dh2N16iSpeIokPiSOvs2FStjyzbR5RcF7i9su0xMg5LWUrCSTy8DRCLaw7+DoF0zFueBqaODyC
	+mG5tjYbzbhOk6LxH+fxq7VDT7F/kNtBYoIzQEWGiy2oeZ4OVla9lvW/ZxrFXik1R/mG6MwUvr8
	GqOpP21Y3r0bc3iHi17t3KDYQ98sX4C8bm3FPZoBT4p4AMUaqSc6VBiG39Hk2MtITYhUr5jL2wJ
	5+1r9tfZfChp15Lll19NCxxveyQ7+g==
X-Google-Smtp-Source: AGHT+IE6ErsbOvWpJiIn8/B74S/UD1PuOpOiQeyfA1cEc77vCOhONo4gpokfVNhYY/Rj+pCYd5Syl6ccSGExwkcCuns=
X-Received: by 2002:a05:6102:1526:b0:5db:33f9:adce with SMTP id
 ada2fe7eead31-5e571f1e373mr162123137.41.1765320413745; Tue, 09 Dec 2025
 14:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqfr9jjrci.fsf@gitster.g>
In-Reply-To: <xmqqfr9jjrci.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 9 Dec 2025 23:46:28 +0100
X-Gm-Features: AQt7F2qkcGKZb84vunRvQjTNhl8FujIVhxVV_CN62_7hH-CrBQk_NqFWjtMwLMc
Message-ID: <CAOLa=ZTeEEntiQdCnDd6B8a_ppJrrZqdURhQJV=bNktnp0JqMw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #02)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * kn/ref-location (2025-12-01) 2 commits
>  - refs: add GIT_REF_URI to specify reference backend and directory
>  - refs: support obtaining ref_store for given dir
>
>  A mechanism to specify what reference backend to use and store
>  references in which directory is introduced, which would likely to
>  be useful during ref migration.
>
>  Comments?
>  source: <20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com>

I'm currently on leave. While I do plan to work on this, my next version
which is based on Patricks recent review will be a bit delayed.

> * kn/fix-fetch-backfill-tag-with-batched-ref-updates (2025-11-21) 3 commits
>  - fetch: fix failed batched updates skipping operations
>  - fetch: fix non-conflicting tags not being committed
>  - fetch: extract out reference committing logic
>
>  "git fetch" that involves fetching tags, when a tag being fetched
>  needs to overwrite existing one, failed to fetch other tags, which
>  has been corrected.
>
>  Expecting a (hopefully small and final) reroll.
>  cf. <CAOLa=ZQ-O7V9qHbgeuQ78R1bHGDmGEM6fP5Kr9aC0AfvSF8MZA@mail.gmail.com>
>  source: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>

The only change needed from the last review was a typo. I think we should be
good as is.

Thanks!
