Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74222DC792
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345509; cv=pass; b=Y0RJeW8le5XHv6MjRYn9foob7PhkMp2GPD9WJOu5CqCoC4I1PwTfu0OT13d1rEkar2usmdtzbWNLS1cVbbgcdtPZbjA2pTmTF9KiocpUcuQuOKtRelIg3GiUGFARDsz9vvlvQLv2aWM/XBuedYnzm/E9R1eZsAJtImbt4CxBEvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345509; c=relaxed/simple;
	bh=2iN2UzRA3qXtqLCt6jMDsERhWopumNh2NvSFf8EwEMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOJhoNn8SFW3lbY795aqdS7DhMpSrm3vi9+s9txg0iqTBAlrLs4xQu3aEacjP9KVM32Wg9a04PWNt5LRMwedRxcj5bkMfawUAYVY0kUYY1mr2Vi4IlWxT+EEaeVjuQKZEcPO2XwgN1hrHHWIGTwYtmJHrAxLJ7xC6na3zL8ynps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=c+X02hmF; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="c+X02hmF"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6611669cd16so4116413d50.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783345507; cv=none;
        d=google.com; s=arc-20260327;
        b=iAJlfl1TzcS0uFXhScSYeRXZ4jcp627kNGybSlm3SfM/SBOhvnPXJR3AqyxHXp1Tms
         B+/7V58xZ8roCVbyH1Ix6Q+qWXebYDv7xuj45m8WWGzC1+xINDmCqrrKUGpbeJt0UHuT
         SGznkjN/J4UPMF04V9QWXqfmH+PlQ8MPVyIXr2Wk/sH/EWh2iXz/kWVk2dbBKNM3QBgf
         nx65j1qTXE/kFotWbVbHEeP2Xz4BEy9111bYW87fzs4S8gRt419RGDNrn0zmBFGFRPVy
         H9VU51bRobCwtmwgRcv4Lx1pkCV75ud2byg3MI9Gm6AwM8fIsqwVxhShBDxrN2znHQ4M
         p8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2iN2UzRA3qXtqLCt6jMDsERhWopumNh2NvSFf8EwEMw=;
        fh=0xe4Jkr0A9N5Wf5NVqBswoIDQmpkhxCxKEPZtNhYjx0=;
        b=lkf70Ey6pOWXIW83iQNbsUnpuMzFtAsC7jYbra2TR0uboojLD9yIiiXJmrWgbcSRWk
         coVeK/TBRWe1lFVvFXXrq0oZES1qhxLN5QWXvfSvQAqvfGxAfkxVUJZSf+ez+hjJewSd
         IDLRws9fh+jvaB2bghzpR+SqYvLSLrTu5E3NrPACAJi5EyPhznZYlijrrhWdtIaAD6Qr
         afEuBqsWPFlcjXxkey9Zt92mp7Om0dzVefb9zEzAl45gFwzEA1LuC1I01bg7Q4TjZpZC
         nfo5vHs20y8F9CYRhsuRhoMQO0FDencrhTcSQHE0ssXNGfzwwHPOJJnOltcC765WphiV
         AdZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783345507; x=1783950307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iN2UzRA3qXtqLCt6jMDsERhWopumNh2NvSFf8EwEMw=;
        b=c+X02hmF+DaNrUbI+gfMEiT8Fs/oII1x8nXe6schzdN/4uaHKGXxIjGh/Sc/qomv9f
         jftBO6ESGnsZFe1sMrGpsL0oMyWYXHox8Bs5pd7WKltX4aoKnfjCdaIGLnTMPKexY2M0
         LD+elnxxbIVD1SL+F/2D4Qk/wuAgDEN1A5tuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345507; x=1783950307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iN2UzRA3qXtqLCt6jMDsERhWopumNh2NvSFf8EwEMw=;
        b=pB0JA7ZR/i6OyrGK0npOrmyZXLh9BXAWtj53kCmAyOC4fAKotDkHNGcRrvNKOmCE1P
         0OQXUnL+bLAhQ8xsvlxXpKVztFeEqJa1H0BquAYQuyDxpHxVS2oQZZZ8ioPC96B7WDLb
         GNnGCfUO0oU1R8WrZmeG3q8zgOCL5GQiDy/yGzM8NAtriCAqtTO565CxRTr0fvza8fkl
         ce+OBNbMemDoyoXBKFDgxN/4jzZr6F8mtY+gjDobcGCeUDR1CEfhNusHDsLAk9OQJERj
         CIxXbNvnEdOYb+yVKSfiy5cKByHk0HOUcGKbAaH5fziPHRDNyR0F9ufwkCdd5YV2xNYk
         hMrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVxOCUpQYgpa5EVM/AyuO5HjQyCjmAuP6y8U3p8fi6ezHn39tRToTE/z3Vug5ANMHb4rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5D5BqlbkF704bE2GtzC92gbxOVFv/kqawFLrIorntTfoT8kor
	hVNzRXQkz90vA7hmAOtuTRwBcaEnulzXzWoIzFY3P+Cj6PafOO1HClAgry7Zf0hm6n1T9AbNZLL
	kviar/Z6h4/bgtgA6MlwmAFwg/dsPzy5iD0gdv7H14A==
X-Gm-Gg: AfdE7cnhoixVsLx87bPgqpKlgtSJ1oaYkN6bSxVmaYz+Xg4mIXNyvDJ44qT/yXEBzkM
	pNm8CoUgR4RRXrrePMHKRFdaNyFHZLriAvFAHKllFtDkOEspcExYkMGVb06dy352i7BmgZlxB+6
	xzY2GF95GFXULQbJsRERcxIn7S50GSiiEro0jaHWmr9ZQyALpSQPF8x7QZUquP4Pn2oAcgM2U5H
	Yz+JPedDCC69XcKDm/z/dqYzLOds/+7k1tqZJQvp0dHHWeoFtJzzwkqsLxmcc2TOzS2MJnEOw==
X-Received: by 2002:a53:d015:0:b0:664:c429:fbf with SMTP id
 956f58d0204a3-6677faedb9emr551913d50.6.1783345506645; Mon, 06 Jul 2026
 06:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
 <20260704-ps-pre-commit-indent-v7-2-a94706cc8376@gmail.com> <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com>
In-Reply-To: <CA+J6zkQFsTA3QfU5VVjQ=KhJCg_pCrTgW9zinAUC4D9YwsyOkQ@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 6 Jul 2026 15:44:55 +0200
X-Gm-Features: AVVi8CdbuMoUmODgdGb7Xfl0Ge7pipkcR61Ymza2-clkkNuPxBIYPebZqB9w6Qo
Message-ID: <CAL71e4O1tLE_VSDeeZQ_p=8kAXvk9JQ9EqdPaYMZnNs+Xj+RYA@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] graph: add a 2 commit buffer for lookahead
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

The hardcoded size-2 lookahead buffer was my suggestion,
so I am responding inline with my thoughts although Pablo is
the right person for making further changes (if any).

On Mon, 6 Jul 2026, Chandra Pratap <chandrapratap3519@gmail.com> wrote:
> Do we need to NULL out the retrieved buffer entries? If so, it is
> worthwhile asserting that the entire buffer is NULLed out in the
> !graph->lookahead_nr check above.

You're right, it's not technically needed, and there are many places
in the repo where stale data remains in buffers, and it would be possible
to do that here too. I don't think it matters much in practice though,
and NULLing them out would perhaps prevent some accidental reuse on bugs
(NULL would crash instead).

As for asserting: rather than checking that empty slots are NULL
(which just verifies our own cleanup), it might be more useful to
assert that a slot is non-NULL when lookahead_nr says it should be
populated, i.e. assert on read rather than on empty. But even that
may be overkill for a 2-element internal buffer.

> Not the best engineering practice, but I guess it is fine to constrain
> the logic to _only_ a 2-entry buffer since that's what we'll always
> deal with anyway.

I did consider making it a proper ring buffer, but it felt like
overkill (and I could not find any other existing ring buffer to
piggy-back on in the repo), and the lookahead depth is
structurally tied to the algorithm - we only ever need two more
elements.

It also helps that this is entirely internal to graph.c. If the
buffer were part of a broader API, a less hardcoded approach
would be more appropriate indeed.

> We should use ARRAY_SIZE(graph->lookahead) instead of hardcoding
> the value 2.

Agreed, that is a nice improvement. What do you think Pablo?

Thanks,
Kristofer
