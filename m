Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DA1DDC37
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854204; cv=pass; b=uZSg/ohPZbNpbVXMudwfvJihQJ2HPEmely3D+lpYtzu9M8CtEwKavPFWUvgTiajwZ2oxhsisaebHN3oN0FQRuRoF98fXEB0gTFdmmjYZvJUno2RFdUrQmpx/eLRDX3Kk/HUQeN62lUNOkt34SVqYufpN5eS0TEtVynWcs3f8H4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854204; c=relaxed/simple;
	bh=Pn5s6aYYrC79R+eKAXJ1AGTU7NCVfVnrvzQA9wGGsp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD/d5nnFg3ND4D4q5XIwzLDmB2VD5ZBiD1sFE/3m3oXH8qL9IpQ7hlV6rJfD+CozlzS2P06Roy80TKav42VWtpLeD5Pk4unIkL32x9aF1et9DayfguIL5kD1DhuCc/j2tdJhYK7UxYPFjxIAFpyM2zdfcn4NABmLTExJQcP+RJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=hvhO5dr0; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="hvhO5dr0"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664b3831a20so4314109d50.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 14:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782854202; cv=none;
        d=google.com; s=arc-20260327;
        b=gX3T5OKuGPF6SOzPup4h3GEJp9ctdymx3ySFBmPr9xxD+1CR1n0bbN2LlrMufCmW1M
         vJ0raMeflc1wEWVshysMneHWgFWTxooDNbydbcO/Eas2TV9shOvXRBhE25RzFrH2z8Gl
         5MbwfStMUIo34KLUVUfcDbMIUDUw3Lggwq3l9tFSpgNzCJwwMQNvbmxaoII7LodEcS7r
         WnHFYwzyxjDCjWNOf9yivYnv/Nd/Ps43xdgH3OZd9nz0f6+koxSEhdW0WntT5sjskPZq
         vitrhXHVFT2i7epJrQ4sJLnP7ZC01u26JTe1q7Gg+6Fwwh2kajo9KP5excLnXqquW8wp
         9Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=exdjPxu/uST4QZ+iNm6L+pGsc8OAs57ENfyLEJOytS8=;
        fh=D62dAyrRBUZ8vK4AirI7aw+LpeOixX87ZNeMWkxn8J8=;
        b=C1QS9mNJ+JuZv7aBiirCaaIJmkOdw4Dxjntx0fMH7sqwgN+r0NwuR0ZPRymPqKiNZa
         lcj2k52TLD4NN9Minf8m7gc7eV4xjSBuHUf+Qfom3wRYf7CznojnXhTcYUrPlHX8YvJY
         iVBgDE5DqXBn23yitfW8yazcxX4HgSufmUdPeUu3W8S8gHHqLSBnqR7swic6e0cAS3oU
         oQEB91e068afxNF38wlsLigk8ZEuWO+6g9MSOXqSKESck5f4G8j0nWWiSeTFyDZo+htc
         c/OXr+aJ8xLp2mycMT3AkRMINadZ4c3P9740eEr+UHXeCNk+t4k9Ni0txpXw1goJ8ZaE
         mP4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782854202; x=1783459002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=exdjPxu/uST4QZ+iNm6L+pGsc8OAs57ENfyLEJOytS8=;
        b=hvhO5dr0c+ucKvbY709cYuDPpsZIjAt9k6NN6zEperq4tZ2qE4o8oASQH8GbzjgbuZ
         udmgALw+71rq1Os5TJm+vw+5Z2X9vu5mI0BqMbkSv3YYHZiqk8U1QJNh7fpulQmO5x97
         r6WI7S6qOqs2O94ZRTNANIuc4+SnNbN3IrLEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854202; x=1783459002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exdjPxu/uST4QZ+iNm6L+pGsc8OAs57ENfyLEJOytS8=;
        b=L49W0i6gfiUy7oNXbmDy9heVkRTDpX5gACt5i0I9i/EiMyjFKi1L/fSIYSSKzYxAoS
         xhiCMgavHsk+lNKcIT2Ygszkvnfck7OK3144ib+nCQGpxB5CIOiMR0IIUe0E82ajmZ7+
         zYtAY/BFefV8fOeNl01It2YlbFA/tsGpGi1TmX8Ig4WhOWA4+q9pp4PKZstlSmi6W4GS
         6WC6aYHj3L1F9aQ8Hf53UeXYPP/wso+bNrJuFx/aNj8V1UcTJM4mwaz3IXII1ygsoefq
         3UF21EiWO8gmWyIwepMaYaVvO2UY566xfrk5mLZs+85IQMHOlfl7fu+MbLj0NQp8gPbQ
         0D8w==
X-Forwarded-Encrypted: i=1; AHgh+Rpx40g0Kn1n6f++GpQp6309luczjmNlWqCzp+rk5Dal68s8OzUxUgnYNGAXb4Rbt0SPOYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBDb1Yp+ud4ThNTttzP6AAKqGrV3sUWcRKxwg0ichPEDPKKjE
	2xgUxJHfOBcKpPEYZwvTkn5nNu5E5BC/+7xTMIIuwF2kmt92Z0Tbj2VaT5LmHacx+AV0/1TmZQr
	lA3Hn2YK8Q9OSS0R1ec4SMAjBy6ZEEeCox9drmgWjSg==
X-Gm-Gg: AfdE7clkpq7Lu9X66QXMKPdmaAxhkYBmhH6+et/9GdB+6WNkp58lkBQs3FQUDBXNMAS
	KEqWn88aM/ICLBTL6QGEy54ScC1i2ZWsxssGurJdVUdlu4fmaaKxNx6DfIfAJZnM/gqg1rsC0x/
	tDy3lLUGTS9vMRMDffjN3MR9/T/VkjWMSJkjtpbjsgzk3/75hVXidijRPN6cQseWnfkbE5Z7e7s
	98BXlmhMQYBn2xR16vnnG3kGpOvLO5LpqFl9Mug36BZsuo39D5qE47WdUy0sy0hD1UFNhalxjcD
	a157cfgk
X-Received: by 2002:a05:690c:998b:b0:7dd:3463:6872 with SMTP id
 00721157ae682-810d9e09d67mr62342507b3.41.1782854202269; Tue, 30 Jun 2026
 14:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
 <pull.2140.v4.git.1780945851.gitgitgadget@gmail.com> <xmqqh5mjrbgq.fsf@gitster.g>
In-Reply-To: <xmqqh5mjrbgq.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 30 Jun 2026 23:16:30 +0200
X-Gm-Features: AVVi8Cel-zwB9X3biOwcYdJfzoBCyaane2doWG3xQmzKU8xGaOTtVAkaPnv6IT0
Message-ID: <CAL71e4MMg-AZY0QDtQoCBW063c9VzgtKuNYz+41FC9cmFdOszw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 at 22:59, Junio C Hamano <gitster@pobox.com> wrote:
>
> So, this is the "other" topic that we would want to merge first
> before the kk/prio-queue-cascade-sift topic.  This round looks good
> to me.

I want to acknowledge that I was too vague in my previous message[1],
I should be more explicit when referencing patch series.

If this gets promoted I will revisit the other series [1] to either verify
that it still gives a relevant boost or if it should be dropped -- both would be
good outcomes.

Thanks for looking at it again,
Kristofer

[1] https://lore.kernel.org/git/CAL71e4MYNiScZjTwkApjDAjRh2LM0_SP59h5HCTywV-Pua03tw@mail.gmail.com/
