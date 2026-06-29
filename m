Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36125403156
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737971; cv=pass; b=bcG4ieuQp3nPTSCLV6Ia0x53SxiLkiaWWDfNXC/6zQbQbzZhzLwpC+W3LQ/DaTAqT3wpByGk2FxnBRv83uiV5ji1BdwnfDzOoCWo/TpeZgro8D51zs2I+gYKAaF3zzGNv1nyiHPGcXSj4NRlDRhOok02n1MA4VlQdgQmzlJJHcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737971; c=relaxed/simple;
	bh=x7UJuT24mRHfeVUuhIZleTSFqbOL+kC7emQ7aokjtBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBqXYwkDmtd4KwyKVlpfof3o6vevULKIdqapT8Sf2ptC8u1EgeHITV56IlUOOlj4zUGx2UB1HPAeQ9lh1KwEP00ZPBg2DQBl1oAx+vLuH8KdkLt1iqaRdD8MvnArp9aGKnvPU9oPaLw/ZQtohAKZT5iM0EOsJ9V/pHcW8649pd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Omg5pfa2; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Omg5pfa2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664c535f1a0so1739433d50.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 05:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782737969; cv=none;
        d=google.com; s=arc-20260327;
        b=jDr/El0RCuZrI+OIcyBf5eUm2slnhvdLZNArwAbFFDtyXv/yGGVeSAA046P2NW5RIz
         ZUlpA73T26HxDE6JPMtxQKnywNcbHfztP92hzijgD7SyoprwkFeIbAvK0bl3iJ91s77f
         6wuhdbZ13+ApMgUcEkygNlnkKydJ69geI+lRnrwJR+N0pp9keE9v1qxzpLfM8r2vcFYv
         xXDAx7IuqYUoIC0CJCAIpgM7CmCIJHIY6QwNz8msHGsxvYJ2q5A6kJHHfIYswTosJ1MV
         DwigVVblrUnR7CB0T7i91Cvmn+c8RXkC8g+c6M/B5UafPu2SHMvEsw9fSfA467+bf1zg
         i/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gMn4YBLE6/NjdDTJFKZGfZ4Tu0KicUscBPmV0jC769Q=;
        fh=GajSeXigLaptIM001w6r7hlOrTezlYgOx19lhsjh6ho=;
        b=BoQSEWegSMYoUPj5Y//UI4JtgzQAC3SA70dNdrBo+NFrjNUdgDm9UpdvwrLqIDZp8J
         L3bfUx3Ci5xiTxBQuEtfrLIhz67sizBMGWShqM/dYe2jRR69IbKPOCVsrpHNr6zSnWf/
         JweH4brpQLgsO1d2km5/+2vKoh5Sjpy3/WxKlvPhA1Vjvyp+GiST2CZkyGDyotVgwiyB
         OEVJNQ2QHepJGPPIn5HSQzgpmFAO8CR7pvBf1OmVZVTv2/CE4ghCue5MNiBDoHjBlAHh
         E/y6Lh1vJ0ioMoeQF2yxhUycG8R4Kh3acHcZNMnyertjHAlggzi+PT3XBXTs4oLTYjAu
         bRqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782737969; x=1783342769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gMn4YBLE6/NjdDTJFKZGfZ4Tu0KicUscBPmV0jC769Q=;
        b=Omg5pfa2/qUn0BVPEeIzpqhXP5zazi8vW2ocilKM8I8JwFJchPbmHPrb5lQAoInQol
         ykCSTWtE+DZypRjmWmuMzfccHThp7kTIlHrFQ7292Eq6f58CDvak99sP3SPxJ92fIfPD
         zZdzXKva0odFfar+AZJhpENelVBxMJ1j/zUQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737969; x=1783342769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMn4YBLE6/NjdDTJFKZGfZ4Tu0KicUscBPmV0jC769Q=;
        b=LaBKscLhGWgF+D8EFTinSDwmsj3vA375zUJELdIqzcuuswF42ZjXQ5n/HxAda2hCxg
         +G/US4t1xXzmyEJIz3Yyeu1j/H/YH6FQty+/zCaQ25dPtCEEdGFIZCcUpf1DtHXDOvRO
         BSZ/kOO3Zt4iT/1sKNn6QeT5I05nD8/g/7lvQ+HxN7WiCIXswAQ7WgKD1nED+hEhDmx6
         /lv6clZ/a9EO1EKxqrvz7ypWFsl4epnPfGEBuAfRQk7N32aUEz3STsaxmr0ImqT/PPvS
         ZfKlsrCqwJ5as+dTOvIBjHHqn5H6KL23x+e6ncyUfskznIhy/Q6BuSeghN63zJaNVpmM
         W9RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+u5BfLIzgrGDB53oO/zfGJXHSjSDt1KcbDWZC2gBcItBIXzrNYWF5gjmYX/LPFlpu3mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+r+GwjS0cfJzr9YCmPLfn050e5QYqxCg0a+6YTsKwfwIYxsz
	wKZpF6Ji0l+EdPzzr7rfEnhYAkgCiZ8CtWGbjMzNDBCTQG2kQRPAt18VOG+fIxpm/oERkzEiuMC
	bfqUPiaNcKN8BqozeGl7xeEyyyOpWpad4oz5ucLIezv5GvD52Tvfp7bE=
X-Gm-Gg: AfdE7ck+gQeRbMpP7jj1n16CAeuaHPIPGYptRk2ImV5YrRU/2lCl8EeJi9lenZ+LypM
	NctSkkSgyEe8B5engq8x4c1YDdrQZ8xD2zu9js839FWiH3okn8LjNXHBJMXCmu6AxfC4OopdcUL
	aGdSAP/RuOryhb5t4utSHZyi0hKI0RBoG9VVDiBrCQWZIpc7V/1uOxKvnnuiAFY71M1Fq8aLtQg
	4HT0LQD6sCQrGui7CQKeEqYexzfz8YDc8DpghoBSzWLmUJgoEJwY1RYh5++qskfnbH8vp5bfQ==
X-Received: by 2002:a05:690e:150a:b0:664:b2d2:ff8a with SMTP id
 956f58d0204a3-664f61dffeemr263370d50.46.1782737969167; Mon, 29 Jun 2026
 05:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com> <48bfdb11-2624-4aa6-8fbd-d3f894c33bcc@gmail.com>
 <CAL71e4O8gTLm4WUcPF-ZbOYTuEzuNSVh0Qjf8ys1w4LVF9Hi8Q@mail.gmail.com> <5ef694a3-9164-4ab4-8835-136439f6d267@gmail.com>
In-Reply-To: <5ef694a3-9164-4ab4-8835-136439f6d267@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 29 Jun 2026 14:59:18 +0200
X-Gm-Features: AVVi8Cf8JXeDlj6Np4HZgXLJy6cevSKL1qUBod8JrNqYSV_bJL31JlKPYWKyx9o
Message-ID: <CAL71e4PpxGMsZLQPasECy5Z89EQPoOtC4LrLb8VyAo-2oabXyg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jun 2026 at 14:40, Derrick Stolee <stolee@gmail.com> wrote:
>
> I agree with your reasoning, data-backed discovery, and the course of
> action to fix this. I'm happy that you're able to close the loop on
> this long-standing performance issue even with v1 generation numbers.

Sounds good, then I can continue with the approach of removing some code
(even though it will likely be a net addition in the end).

> > Do you see any cases I might be missing where removing the fallback
> > could cause problems?
> I don't see any other concerns here. You're right that if we were to
> have a different mode that changes the priority-queue ordering, then
> the side-exhaustion optimization cannot be trusted, but you will
> remove this possibility.
>
> It _may_ be worth mentioning this with a comment when initializing
> the queue order for the paint_queue, because the use of the queue
> requires topological ordering.

Yes my plan is to rewrite v5 in a few ways:
- update original documentation to note that infinite -> finite
   generation does not always hold
- add a test (or more than one) for this problem
- don't introduce the bug at any point
- add a commit to replace the disabled optimization with
   removal of the commit-date based ordering (+ doc update)

Thanks for helping with this,
Kristofer
