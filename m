Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE2360EF2
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921948; cv=none; b=FLe2/lrZqUXe2woLPupvAJrJZjOvHMh5doydzcKk7e3sRvju9ejjcJBfMU9cVIGB98TUiktlKOgIWR9dUQQHEpUqdanPi+9Ai+bbCns4DC13sissmL6zDCDwPzGwJPAWe4t7NqrtxGf+1+pnC4vXEIQ+uswPtJOdmuws9cY/HzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921948; c=relaxed/simple;
	bh=fw5FPGtQsiPWmHsKgMZiMCk0PdIs3xb7Jhsiv28Rhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rohzgZkvrABk5z/Z/II6fcNKLjj2Rv5RDAfQ74nqtEg3DRsnBwfdKfHPzU6HdqGHbgcwpf80mEcAMSmgFcMETnaoO8JJHjv2X61aU6O6Ke02ikUpGo6p5jDabrtHnrPlMxA1WaEK9EizAfcK+/LUhSJTy+e3ZeUmSfLFey6pu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOpN5W/6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOpN5W/6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493e4cccd8dso11438965e9.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783921946; x=1784526746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qO0yhN7hai+AAjGB7KmBzk3QAiQe4xf4LQ8ydRJZgR0=;
        b=dOpN5W/6YGvS2DZx6BkGeiFinV2v8bJuJg85b8VfOVE8FMFmLRASlivnYLA0ZW/Miu
         eThYfYqzhkkTw3qVwmE/9DePvZv1P67KpegJ85/wWPBFWhcSIZxRt7v/JEhmO7q3aRua
         vyuUaZYOu3IiwC8towDwm4Krpgtbvv/Z5ZXBy1WSzZ/xSkK0F6XMjPLYMQWRWsozaFjs
         x6DPjnoHve22VWJ/lMLYql8zw0AjG53XpjLXM8c3UcWgR3xdpaPsEeYR7cEqyLmPPPQG
         usLX2/3E33vKOMuZOsE74cAPoRjXBLwnDIIKaA4hrzBQ2xilD7/4wVlobOJ9qx09ACTW
         35wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783921946; x=1784526746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qO0yhN7hai+AAjGB7KmBzk3QAiQe4xf4LQ8ydRJZgR0=;
        b=EWsqNCAqRRzlNT/THwLHAzYImKqRpBrZfSjVFEZST65caNl8yKxr7Ip/n7vpOmSgot
         Z3YPe/PeVcHcgIkiEIuXoq19EtPioaeFLe6NtMbXSTjtEYfQV85QwYSyaR0SpAI3zyZu
         yJ9op2VAcZzs8fkYs300imCWrHdP1EQY8MAKLVKt0WfMm+8LGYsrXaIiazXusk9mzwU6
         i6hdIM3N/vo9JG698kALxrrvWa2gDQwSjQf8CycArNDFBUC7QsfZkdvA/LO4MQNvRzE8
         zDqL+lz7oZXITsiFhCjOEcglUXyupgk6XX2bP4WdcS63frHMAZD23xS2SXw4nB8Ttgst
         RvNg==
X-Gm-Message-State: AOJu0YycBSNbclHvUXYVd6lf5oTxHmo3OxGpI+RxQdVjV+UVuTOqu4qk
	3ERlrSvE7bqHG3r0JeS3cunLZ/CzmiK+ELPRSFZvA3tMedjZT9X1rZCu
X-Gm-Gg: AfdE7cn/GfYEO7wcA6PdcTh4kaneuphEY51WHH9XkLYdDPF3V+eeSJNjpY0BiWKffyl
	1edrXGEfX/9q6dD7Sa3+tr42U6rQMspnYUtcckz+89Uihnq47fkWvaHl1Q6AH4T8IR9g0B0JxaX
	WB7HYJ63oUFLPOa/uVhr2EiS7wh/SxbqbFLMEHiA5D1tCEHPzDLLBBF/tL3AA/GSIg4lvpEG6nW
	b0Jpw4QibLXzy/lCfxVsOYPw7m1qej7fvRuiShRB9QN9+4//i2eOeC9Mp9TSkraPH8TZt+dxbR0
	XMECu1oJaq5d+/gaQpx6bDwW5nbj9zdcOaS27nO9GWENLpjq5gs/AEVGGiM/FVJNEAXZy8hm/T1
	oOstI25AEXS2NZZGaziUW5GTo2gb2IYV18sH5IDUrZ+hx1uDFhJi7PPTEysJpXQD7zTT6ZLsIRT
	um8oX0uIzzCjSF9jPqBJsBG27FXxbUpGEoC8lwiAM2dWf0ieyb6Pg5kmxyTDMfrGixJmxN2hYoc
	Q==
X-Received: by 2002:a05:600c:4e09:b0:493:bc92:2a2f with SMTP id 5b1f17b1804b1-493f87d858emr77608935e9.1.1783921945581;
        Sun, 12 Jul 2026 22:52:25 -0700 (PDT)
Received: from localhost (20014C4D24DCF5004C88C1C38E0356F6.dsl.pool.telekom.hu. [2001:4c4d:24dc:f500:4c88:c1c3:8e03:56f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm398142705e9.7.2026.07.12.22.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:52:25 -0700 (PDT)
Date: Mon, 13 Jul 2026 07:52:24 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
Message-ID: <alR9GDNTbdjWB4dq@szeder.dev>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>

On Wed, Jul 01, 2026 at 08:59:27AM +0200, Patrick Steinhardt wrote:
> This move does not come for free though:
> 
>   - The mass rename introduces a cutoff point in the history of every
>     moved file, as tools like git-log(1) do not follow renames by
>     default.
> 
>   - Any in-flight or not-yet-submitted topic that touches the moved
>     files will have to be rebased, and backporting fixes across the
>     boundary becomes more cumbersome as a patch can no longer apply
>     cleanly to both the old and the new layout.
> 
> My own (obviously subjective and biased) take is that the tradeoff is
> worth it, as these issues are a one-time cost while the benefits to
> discoverability will be permanent.

It is not a one-time cost, but will be an ongoing burden.

> Furthermore, especially the first downside is a limitation in Git
> itself. We're not the first or last project to do such a mass rename. So
> if our provided tools are insufficient, then we should improve them to
> make the experience better for other projects, as well. Subjecting
> ourselves to the same pain may even give us more incentive to eventually
> improve rename following for everyone.

I'm uncertain how that should work, and rather sceptical that it would
work at all.

Some have expressed that it is a pain to deal with the fallout of this
patch.  Should we then come up with those envisioned improvements,
whatever they might be?  I'm fairly certain that I won't have the time
for that.  Or should you do those improvements, because, after all,
you thrust upon us this churn?  Then it would certainly be better to
come up with those improvements first...

Overall, I remain unconvinced, and maintain that this just trades one
annoyance for the other, and it's not worth it.

