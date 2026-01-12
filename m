Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE02E7BDC
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247258; cv=none; b=E89Zu+4GU5oZn6P4SjJc4wqaz3rTP88ILWkgPZUlB/JW2XN2NHzN40An8qogMuWQ8YhYEplVCd9juE3eZAVftDMYxMHsU3Qz2MqikyXQgY4g94SfTt3GHAL5gUZxWFk2xLiQHI8GPTNz6avI36jPVRuGeNOUcdGgxoD49xTmKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247258; c=relaxed/simple;
	bh=hvA+q5lpfuetswZcsipsYU04KGlZTBn8K5wNzdydcIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7EE8rvJq+pFiNnpEJ7GQtXxo+1CtGco0UtojH5p7aR/mjPZWVk1pXv79mxCNV55CW2fxz92iZ9aPR/5T4K6ht/uSc88AV5fEKFKIVVaszsjLPiEaGmyyGylkIucu+Ph62XXUgMcyf70IAcKhBG/y+ye1oZHWWVnC4cQ2mf6sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyVOpUa7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyVOpUa7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-382fea4a160so52733061fa.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768247255; x=1768852055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvA+q5lpfuetswZcsipsYU04KGlZTBn8K5wNzdydcIo=;
        b=GyVOpUa7vpNM2bVel/PT23Pp1haNePSuyv4c3zYf3KIJ+rqXEE8jWKIN8a/8jd1bpd
         UrVeHU5IEntJzFNpQJ9u6z+jmgEH7HFyTedApVzocarduYd4scFt+JlHjSfjw555wzbs
         if6z6qYTDdWtQb9J6eaKgsAJfzI2cMl0s2XzCvc63w6I3yyx2qb95Ns4EO4qqGSyOX73
         BaMtVYpErjGXmgWniRZo6y0uE/XD3kxEEoSA8qEyfDtIVBx+okIjrlNcIy6D4NUDYGa4
         nCUJWI6+d0FIy4nqVREVxqZnnbxIOyK+EhoTzXPECBPSvK7LWFrzW5TlyuzVd4OWjWvt
         P/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247255; x=1768852055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvA+q5lpfuetswZcsipsYU04KGlZTBn8K5wNzdydcIo=;
        b=aUm/OXA6bVJQ0VfUOpoxiQs29uQ9qSztbXsvOR1qdU+VqxX7D8NqMjk8rZqlxUCUkA
         tHSSacPHtSLWR6k/5kD+lhJaGaSjsybsDGHGoP7B4hIY6DSyMQfQjAOF3z2yevkOpJgr
         V1xD8INmQs/ATWhj34UJFC366e0re/avohbv41IY6eC2a4ng11FunaGzI/b38p+mZe6S
         Vi9EvMrv89eHPOTkjHLxcge3RBX8a7tG87qBeEn4YoIUSAszjvhFCfSHhH9nddzwNMRY
         uleiENutV48DI0hB28nkoJmHXmyVRK8ZTsep+JgJe3DDavvc4DxErmRrUthE5DVsZasP
         2BZw==
X-Gm-Message-State: AOJu0Yws9DssP1Ktiq9+BVntp7oNFnvXKqleF/Sbc+YDHN57wNlL73wE
	/nYVDM+HhfiPo4leiE2DaSHaJi9ZlIxs/FHE1yMi7718rjqVqM7UHp20
X-Gm-Gg: AY/fxX7aUqV6gZCBEnZmFH/vOyPx27pAcg+9vmRmNsk7jF0iOG3rRwaq/zfa5grnvQ1
	FZG/KDHFU2pq43zSDYvfGf9m3OIOu6HUNy8xR/p9cajEjf/mXkSHkyt5TVm1wV7qfQ8d1fXUJoG
	ohHhRgSLQevmBwnVoY2YZqthVGK8yYgVE6ErUyUheYjC2MM5NgPncXH1HkV6gdLy0Kbd4ZofYL1
	ZaGWqirQSNU0GjA6dWLKTLYS9zWChtG5AR6mqBtzhQHAwcDLy7wJ3C1ps2OK2oCcilSx2/bbkxH
	am4lLsrSgaGKYq1r0N7MfuCuHaNUiWDr40W2XRfM/JzCqwpDxLCvHPHdo6jAp8RDlnJsSZ7RV4E
	4ueFvzlAGJmyxjng3f1ssK2lT55lAF3fu30Cxb+kbbiJNiuawxyRdxNy6H8c8hnduQz0K6evWo5
	GCOxz0ISZd1v/2L7j85DK+MLOP6UWz6gieVKo0TBfjdMMk6zkf/NZ40QcWkgY9POD7Ws4xOHU=
X-Google-Smtp-Source: AGHT+IFlTtjaBHM3pX4HJaY/JuetMob22nOu2Odf1Tuxx5QGJwqbJPERioNCz2eOFozSkbakE4USvw==
X-Received: by 2002:a05:651c:887:b0:37b:99ec:9bfa with SMTP id 38308e7fff4ca-382ff85488cmr50956511fa.45.1768247254943;
        Mon, 12 Jan 2026 11:47:34 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb3bf079sm40128771fa.13.2026.01.12.11.47.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Jan 2026 11:47:34 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Mon, 12 Jan 2026 20:47:33 +0100
Message-ID: <20260112194733.23192-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d2ea8560-1473-43c0-96c1-e1869e22c721@gmail.com>
References: <d2ea8560-1473-43c0-96c1-e1869e22c721@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> It is hard to discuss this without knowing what actually breaks. Are you
> talking about the tests added in this series? If so that means we're
> expecting a different behavior to what "git push" actually does. As Ben
> has pointed out elsewhere in this thread, if you're pushing back to a
> different branch on the same remote as the upstream branch you need to
> set `push.default=current`.

Yes, it's my new tests that are breaking. Maybe it's easiest if you check
out the `seen` branch which now has this logic, play with the code and run
the tests to see when it breaks.

I designed the feature around 'push.default=current' which I use.

If we would design the feature around 'push.default=upstream' then what is
the point? 🤗 Why do we need to show status for both an upstream and a push
branch if we are already pushing to our upstream branch?

> The benefit is that you get a sane interface rather that returning two
> different versions of the same string in two different ways (one from
> the function's return value and the other from a function parameter). It
> also matches what we do for the upstream branch.

That's a good point about matching what we do for upstream branch, I'll
take a look.

> I can't seem to see that test. If we're printing the advice once for the
> upstream branch and once for the default push remote I think that would
> be ok.

This test is also part of my patch 🤗

I disagree about showing the same advice twice.

> But we set show_divergance_advice to false for the push branch so there
> is no need to check the flag.

Good point! I'll update it!


Harald
