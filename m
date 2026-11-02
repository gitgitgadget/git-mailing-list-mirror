Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644697;
	b=alqYOEFrfZVxtXPGO+t+Kg2VgJi81fnksYKrgqx2h7sXY1PaPlVLBEqFEaBtKpDWR9Ez
	 E4HWlpx29ULpa/1TlfvkBO4nCKt2d9W7iO45KERMVuaEugqMG/Bt1J/BSHIX/pz5ZZ2jC
	 keDauXA4jtl1y47NAZntXlAzWeBj32SYSHvkpN9DWBQVYeLKENSjoq9cfH2GQeWXGaVbd
	 CYVLFm2pvndxsWn+hDly7ALJbNii1X0drUwN+44nNxELoQi8S9HE55gZp+5xIpb+1N/wZ
	 fIokalgxCFJ3WrgP+2O/cN9PUFnZ9YmBBkoe55UqpTdDZTQeyrUfJiQYF2xX15qiHAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644697;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=TN9Pgrf2fjsl0xMxH0vQvuKpNr00BjA6YNOojW28X0Y=;
	b=NVNiQ1J78Rvt5unGdfL31zaFQtGBCPndY35nY9VaqMmpc1w83KHs1Nm09A4Lu5l5tlop
	 pYKRRrlFZQzmLxFbGov4hASMD2rRvk83OZ7qTDIKLsWlOtzMnbGnlkIOFrcfxE0XTYhpG
	 h1QGM1ZuwED7Hmv71izfFa+FqLN86/uilo3Djdkpj9IKqA1VAAitmAQNX6PoIeiTsb6aN
	 JU7oVShsW5DBqW3idSfh7HBXIqueFT6v5jWKpTRisGp3RpmAaq8vQd6Xe76lCAi6bHKUB
	 gEhmOwUGIPs/6JyS/calsyxl084lCSsQ0+ZuNPlz52SchgkIcWZsNEG5zRLjUh1Ia3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=UBUrJPcY;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE80606A32C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE80606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=UBUrJPcY
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c445c95d553so455143666b.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793644694; x=1794249494; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TN9Pgrf2fjsl0xMxH0vQvuKpNr00BjA6YNOojW28X0Y=;
        b=UBUrJPcYrySBbC28iFtmX7rc2Y9u/3Fzx4uk7/OgkT+vaAQVDK61ky662xnsTfFwyd
         jP0q/Z6k6ADR+RkubYBkksOFCNxF9gPKcSqOdMSxBeX9pN3ZzZKcFafZqAqmcwf18AJn
         bSSch4EMfsx6vYezUR90/Lhtp0nbxtko6bYOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644694; x=1794249494;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TN9Pgrf2fjsl0xMxH0vQvuKpNr00BjA6YNOojW28X0Y=;
        b=mHron8xrDAfek69blrpjWrqX+1uyeAhAYBoeCrQF49mTh0P029msfEEk9TN1ukAaU8
         QYLglg5FwKr+A7XZktXU+CdEZZfwlcIWSrR/sDUha495zgtlziBgWfgDeaVFLn2cayi1
         O/zrrklFpMuFjSoKCCsoxZV2+5E/MpJXlmrVbU5UgoBOqcdWmRZLX8OR7D20uRuE4WLL
         3IHLLtjiEAhiEEZ+pt0yQN/suAXJWG+bfad+kUGBkm/t64NxNm3vOl/WbWLbFOXU3Tuk
         P/e8f1RfpseUT++z2nUJHSAfZIOUYMmHDHbrWsvUoePXhyoeMdA0bClYp2lOscoe/N3x
         XHJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxd0QNRlIa4rSni1vaU0RK+KYn6/Sl4fUtIN7LyS9fDy8MkOCy/wE/548mbsnc5GCX0JyU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXNuec5Rh7oU3qNwXiruAlKBcZSq08U/pP+NhW86bxmyJmzvNy
	ru4LG77NendiCplCM54NNbnIR3JKsiVMF61SxZ2CQahQo7La5x0IAm3eFAqsGUlGm6QNZadKA6L
	UEf1flSkqZQ==
X-Gm-Gg: AYBFou3AHIMxZSFUdJJhB8Y5IZbAHqN1CNhgMmbChN/Vl5wJECwKZedKPTlnC8zCVXp
	OFO3AbTtH4tDvtSEeS7Mp+NZpKgKXbjRhgRarw09UC8oKruv+xuy2hMTA8J0cvr1cZLU4x+P/6x
	07L2Nft7r0TLQnDZBCH4hTws+ir4kYn8pycmM9eujjVO9/qQvrXSUTIppCQZVAn2RJFkcAjVo+e
	ZICZvBMDtWS0e5t/NhBUMYx6lD1zQx+aZw4v8l85bzBg5BG+X+gF1lsl6ZK4pZEqn0ZS2c5Vza9
	JRK56YqWb90T/m9GwUrGI4hAM5517qwYHej8h0j12BmyhFxAW+tDdhfc3H/M9VIi0ELEAvPxt4F
	GRMOoAxvfeTXhcgEtGK9yHnFNXeOjRHwIKFaXwpHfWCrkOfBoHHRebekYziVrOT28kx9oxcvuUl
	eELryuUPjXzAY9PPpfrxu99clv+RPvpdDkFJPiqfDqDN9aGKAnk5xys1t1Lm4Dqydb5MmT08nQg
	dxQq77jVaow7VA4l8MPi6azSxGoO6Mw2f5YtjTETFZ6jtnOI0d5vPhOAzv0dKpjehynPkp5914V
	8vEM+9rX4G/LbtudE6TT/fhTqR81SVtgzK8xoR0UDOYDvoQGxG5/rPk/6pRJZbEnjg+aRcS1gEX
	hVw==
X-Received: by 2002:a17:907:96a1:b0:c33:ca5e:8ddb with SMTP id a640c23a62f3a-c4ca7ab1161mr914603166b.28.1793644694355;
        Mon, 02 Nov 2026 10:38:14 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebf3dcc9sm14696766b.53.2026.11.02.10.38.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:38:13 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c445c95d553so455142066b.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:38:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzF2m0Iz3m4MCfD5ttRy+ppl/9+dXKaqEojVkYF0RVjQJn7MJeiQ06M5BiLAEqUFH6lF70=@vger.kernel.org
X-Received: by 2002:a17:906:7315:b0:c2e:2944:d6cb with SMTP id
 a640c23a62f3a-c4ca7a54a6cmr925264166b.13.1793644693623; Mon, 02 Nov 2026
 10:38:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031065525.19883-2-torvalds@kernel.org> <auiGP4XhObUzC9vD@pks.im>
In-Reply-To: <auiGP4XhObUzC9vD@pks.im>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 10:37:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
X-Gm-Features: AclHuK-3SJ9YAYxoJUxB5AOyqNcAlRZmpYk3qmAX6i-rrwoCaXgBD085VAQOWFA
Message-ID: <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 04:47, Patrick Steinhardt <ps@pks.im> wrote:
>
> Out of curiosity, how do you calculate the localversion...? *goes
> checking* Ah, you seem to use `git rev-list --count --left-right $tag`,
> so you basically reimplement parts of git-describe(1).
>
> Is there a reason why you use your own script, e.g. because of a missing
> feature? Besides the fact of course that git-describe(1) is buggy in
> this particular case.

I think it's partly historical, and partly because the kernel version
has actually always had the full "three number" version without the
'v' (ie the kernel localversion uses "7.3.0" instead of "v7.3")

The kernel localversion is also configurable and wasn't tied to git
specifically, so it was never just "git describe". *I* want the git
version (and that's what "CONFIG_LOCALVERSION_AUTO" does for the
kernel automatically if you are using a git tree), but I think all
distros do their own versioning manually).

So there's a whole 'setlocalversion' script in the kernel that does
many different cases, and it's all hacky and historical and I actually
suspect some of it predates "git describe" even existing.

> Hmm. The big downside of this particular change is that you may now get
> different results depending on whether or not you have a recent commit
> graph. So you may get different results based on when git-maintenance(1)
> last decided to update it, and that would in turn result in highly
> puzzling behaviour for the end user.

Well, honestly, no more puzzling than the odd existing behavior. But:

> ... I wonder whether we should also call `ensure_generations_valid()`
> here.

I suspect that is just *way* too expensive in the bad case, but I
would hope/assume that any big repo already has generation numbers in
it, so maybe it doesn't matter.

Maybe add a "--exact" flag ot something to force it, and just document
that without it, you can get slightly odd numbers.

Becasue rigth now, the numbers may be consistent, but when they can be
consistently *wrong*, I don't think that's a good thing either. It
took me a week of annoyance to even start looking at *why* they were
wrong.

            Linus
