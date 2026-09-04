Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508543E8685
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509818; cv=pass; b=Ofot8pCzbPTFeLemHLO40wGk+Tbx4BbO0F1GtEWpEXKU7qLOiC3cbeoN+OaaISw9LS0Ttv6rYKwTiIx3uhOb4qRlwjIg+4EWHSG5k3CLk4w9rZ0fh/sIYXItmZPpndeGSymeyfH6/KjbCo3NKb7Lkrnzh0Np0RKRvTYnv5hEMGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509818; c=relaxed/simple;
	bh=T/uApe24tZ5/rn4oG8CsaVtKP2tvDOxQAJ8sahOcI9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcuDrgDfw+i/ufjmBhdo7Tk3WPYJjLdMr0kcJ7fVpuBROoV2rAgtybyBXo/3u6y6QfyVPleYMh/uEufVI10P51JuPKPlPM0+giv2gmCbEmEUClHtKFnoXB1VHcO/N36QGWkfoDlVJlw+Z8lSrpfxmcnmCZAUm42pE5lCXlQMLhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaIga2pI; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaIga2pI"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5e392b2b3so1063198a12.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 01:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788509814; cv=none;
        d=google.com; s=arc-20260327;
        b=BZPFcS1nQKT2QLdrlZJbWhJiCVh0vrLroEKAKJ1OWjbeS/YeMYW8H8aUQ3Fl66Fcrw
         iD1N/h0kM6qAYrxxyNNDVKXGYhLZQ2E93iimpUX/45u+6YyivD+YIp88RkcI+DfLGaW6
         PuG2yGqwLtLluk88gOV8bAG0F0mlDpJF5sTplcN6yVRU0Em+P9MptmsCppq3zifhO2qw
         gUys5di7CgdT8JXZqt548ALszbcLt3rbD2zHfNUQhk867+3WMGRZLrBwwzreIx50Nzdd
         TVCl/JDxwINyUJ+2ShklkFuOuXTbxxVZt+0V3LsT7diZkeyKkQMiArOd4jFg1WeMRkr5
         J/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=onzfETtBoiGBw5efF67P3FDUxv95BeLH/th9DxdChqs=;
        fh=Ty+QtqMG7K+xCfoijGc3xiQU76xU++ufBzWJmnp8Oig=;
        b=TmCHvl/va4MMOylKpocf7g/v7QGTEP2F7pd6S00020/isrvZA/keefjkkPtYYzQ45k
         EqgB/kgyiUjh1O61gjMLAPzglCFPlsvqB0T9Tu4x13Im7RNV1n8jRFG/0g8KnFg3IIEo
         E30hXSGMegvT9FCIVRguN8ik93vcq84xP4y+sY16vRGNXKXATFbxQCuqIzzfcmbW3WsQ
         vDtHPt6frQA0BT4c9spcK3+ZPZDuR1Q1UsIbqSZc226Mz5uKapzFeOis0mkETunIlBlA
         tcVrDNteB4iJEPkaBv5kB/tg8eqBrFgWRO+Fqq5vvfgKAik0PCSFdTScgGT77IMhg36u
         VEzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788509814; x=1789114614; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=onzfETtBoiGBw5efF67P3FDUxv95BeLH/th9DxdChqs=;
        b=IaIga2pILYYlKrLkSw/x+TkmY3DUoJ/F2aFIrUE3ZQWHDJvLEVZMPs6CjaKKUZUT0T
         LaejJJMF7B2QKrMYOnfzJnjSIQIVPs1hOJ04jJJm8x8f9c9Pu8MVka7ESDqJ1MiTE9Ms
         Z1ja+TUh5vyQy24PPRXZ0jmYhtjeyXBrZEKguPS29gBBb8uSzgyTKCvxLGMfAY86TURP
         wCMCl2RBiQT776LTRQvySsvVMYd4hrT8m69v4VWzEXYvAxk6j8I+TIzb9DOwPsrXpTUh
         LyqQdxXMGmePrQEguTLli8iQIVO2YLAXiiHXryP6aXwXnIIvB8fPTPSm4uO+WzfWwDZc
         YTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788509814; x=1789114614;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=onzfETtBoiGBw5efF67P3FDUxv95BeLH/th9DxdChqs=;
        b=Vnkb/NVpCbP8rjMjmenwQvtWvIwivMGBWcLFXa5MMT/CnXLHsAqF76IxIbvlFHUcCI
         4vdd6N34NNcZgOJ0LQEUFcwOPdEroiTwu0Cty+b8x6/2PaHw97OoAcqSnk+Jf2iq5ckN
         zB0k4NAGsExc0YdF5GAJECfhdsZffU19WJVwP/jM8AQz4C+7pXayGF+zDL4jhXw3CDCj
         C3/J0gRiPncxrRMFLCUxP9V7Gj7d8iwZut386rUfW9u1WPqNft2vUCwTCkWrOeqeR/eA
         WfQsMEBUkAPlHy5JUSs0TyIePA94Q0JoxDrVs2k49SpUoB6WxpjYpvWYCCne07tUqAgy
         kL0g==
X-Forwarded-Encrypted: i=1; AKwUvByphnBe98nC5z6LMFfByclfuG1d9i7+amSyuwl3IYVGzC2eU6ayX53bYJzXRtgKDDOacpQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l2rkX4A3l8zA75hbGdGADZM2GrTM2VahUqBmShFIKH9zLm3pgC
	Q8DtGZDnVisnC8X84OL8A/6gZp3uLlZJQOgMLFP96AFMBo8Hcg5XLvfmTyJaE4NaTHAUTyrnFq8
	mSRyERhhJ2K96y1ao/i4xvttTnSIg6Q4=
X-Gm-Gg: AYBFou0PeSYt7N0GFyVEHbXiZl1q7SSR80F5DvG8zQlwXw/XdQ0eJy3sAkk47zIDq6e
	wZcbErrrAf7roquGfRX6SPNMuw6tvmOg6S5cgLn//mWZtn+HMj1GktHRl165tcp7bzmAqBffR5w
	ueUoZiCdcsDHYeIZgfOYaYljBleNCwMHLyhapWZo2Z0gOqHc1ehiz5KmacP3h5vOGj0nHpcRCIx
	cGoCkUVsWqvDkx9GldcgTKEjjY9UW3HvBep3UTR71Rd03wRxSzoH6PvHCOqjX3UjisXmsLKd8rM
	DiZYMI0YFLWFmOuP7/G2/kvyu2JZd7UsFqeTVqrt
X-Received: by 2002:a05:6402:24d8:b0:6a7:ea54:36f with SMTP id
 4fb4d7f45d1cf-6a7ea541dabmr654353a12.23.1788509814221; Fri, 04 Sep 2026
 01:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com> <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g> <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
 <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
 <xmqqqzjab2ho.fsf@gitster.g> <CAHwyqnW8sdnDcncpZpaMD8fmWaj+WJQxhA4G-Y+L5PTW=h3k6Q@mail.gmail.com>
 <xmqqwlt29l01.fsf@gitster.g>
In-Reply-To: <xmqqwlt29l01.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 4 Sep 2026 10:16:17 +0200
X-Gm-Features: AcwNN1UInXZNYmEVafT6xp6AFhdtOUSp8VdWCMz8GDxjZ3CjgViqJGa-A-j-SbU
Message-ID: <CAHwyqnU2c3T_i0gvkqiPPM7UYr8t5bzynr66iG4Z6YUKqZk1Cg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> A local "make style" while you develop runs
>
>         git clang-format --style file --diff --extensions c,h
>
> which tells the command to check only the parts of the system that
> you touched.
>
> I do not think it is used in CI.

It seems to run as part of CI and doesn't catch it then:
'.github/workflows/check-style.yml'


Harald
