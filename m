Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA82E62A4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704542; cv=pass; b=qJg2QLJg0emFWmrBJWE0azVsZ2zhvf0AdldlybjWXOl4cSLIy7TmjKA2fQ9ypIdf3ZrdggAgTcGpG5VrBzX27ppGzCFotPEiR3k/qjfAZDPr4NKqa/mO3EdylN6LwaAKEhJC+ITm5vNf4LGvBkXL2ZKoYGN3B/T5WnZypgTu0js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704542; c=relaxed/simple;
	bh=ojUkl16c2is91oyNpyD2c027U+4Bn+aQK54RUKL7pGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akMDcUBqY0kXi2urVmoLw+ntmwAigmLtIXL1TdYVTTzLlujym1VEHl5LKFF4jIflP3xJ6k9auRNe1c+upJwkOLyfnhmlvbKtd8XbPncrQdvfL/d3equA4xDaoOM+vpORPfRpcoQS/nGjQ7dc6Tp+Ui4JrLNjCVoR/FJ2MSqDnsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=PQSqD6DK; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="PQSqD6DK"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66666bad8beso1720986d50.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783704539; cv=none;
        d=google.com; s=arc-20260327;
        b=bMB5tpWuNanxU/xHPQNpMcmaVxGbMWeGVjhFNhEPK22k3n9pBo+nQiVQLJDuhW/J3r
         U94mf2po5ejGVsxGH8qiRVF/T25YfVZBoXVbHFBNhFRxcKifSGDLnp2upZL8h7s2jp8e
         7M9W4IbQvrZTnu9MHel5H3UsUIn+GSjnKwmnXglkWf4jmhp2VktbREltf3SEpESnfUMD
         DKbpXJKFFLeYPDhLcFJi5HYEuO9t+Txk4PbCgVePMo7VDYzRZa/F1KSOovaIGHxcE4yU
         bYyCEKZkCAQqCjcwF+7RY/bfs1oLr2H8EViWrmjt7mm5fbLgCKmFQaKp0SYqRv8ynL/v
         RYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7H7YfxRrLUElzl0CelaJeIr//rPzfcZjsOQizMO2scY=;
        fh=yEyTaOb2vUi+TzGQShBBQJQwI20iaqnZmF0Qsosfbb0=;
        b=VzyXIImHgSaCYSlQ9jHeKcdvN8H3zEGRIUOAbbfQF4kPOzd+7tALZxuS0BgRDExEH/
         4axkASVsHGzr22hLhsH3sxsdyX1a7AvYxowodYapcuJ6gsLDmCTOncpzOqtyL31edzlI
         bdjRctUyvzZpDSJ0CzAle1Bqy4O/WCsu4JbsEDLFgFnFNt+QmrcZTCH8YC912CGTgiva
         FQMtdUEWRr75TaFikGUWLD4RhVILv1yTMM+kGpB83n4aOmmuYYunXqpwBC3Kls4sQR8Y
         1snZRW70p9HohFR2nUSDayzpH4oCtWa0ZKLR8z6iNcsCcl8/1fCey3rvXoQr4awsoneH
         6Yhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783704539; x=1784309339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7H7YfxRrLUElzl0CelaJeIr//rPzfcZjsOQizMO2scY=;
        b=PQSqD6DKPnT8Y7gz+i3P4NlVC59ga0fC7l9JOuwkFhrNbqX7BtT9pzbcGilcTGl1JV
         ceAoobw2jbKj4o3gB93H6npXdbvED6YSYoDDKtkciy0owjAttci4BV56hERLAroQqc/h
         1U8cDQ6Yt7j9u8wg/q+xTNlILrqRarknwfz5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704539; x=1784309339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7H7YfxRrLUElzl0CelaJeIr//rPzfcZjsOQizMO2scY=;
        b=Si5nSa8pqD7qK5c5T23/LgL3neR2IaQ41EomYzmZqm0314gSp96vHScJ5Ac5SnOloI
         CftQtd8ch+WbfW316KGDsNyvM8hUyBga2/WtakmdCrNN2bUB1S2J1dQYMrTzwXaO5qB7
         2HpgFbtG7KN8MkQn53IcB7brZIhn77wgnWawX+WdppS7pl/01g3iZ4biqoG7JjND6zV8
         wOUqN3tWUJmWKh9WUvrAvLtLtwt1IPSkX/RbHq5cKxIvYCXoAMsXeL1ZyVeH173CkVz+
         jlwWHLUMzSqE5HBfM8+TElkitCCLPIK0zncPmCP/Os0h057IadruMtRe7eoBUpVDx5Bp
         GMBw==
X-Forwarded-Encrypted: i=1; AHgh+RqnAR45q3e1hEXhGtdC2KevPP5uYQKppaQRO6q9DvQJukNtvIM1dHxWTuStPeUOka9UX1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQI11v644KgXWjvJ+CSAwa8OnXSnEHyzURn2nvzxTt82j9dTW
	sguoJ4eYNqXQD0z0II2LIzeRy80Vp5XyxgamUGKdZ2bPeq8H/a7FzbS6lCXPTrCpsMGeG+FWD1E
	qiWOjoezIy7jRb1wYiJ4qv87Qie2BXAIyNKLCfkGSgw==
X-Gm-Gg: AfdE7cnaohxgaVH/Jigy8u1ewm7ktXayhm69IGGUuj6c19b9SxNc7hymSctBRrCuXh5
	vKwBG4Vn5jwq4yNmGTzPigAwmX4VaGr6sxGwnEVQiLK4T+Q4lu+AdQKeKQPOwKNmFCXlht0BI1N
	LEz3xN0jr9YU32KYQdg61iligiT3hdow9Bf30Xz4z2+RJmDgy0m4/ka2Nj+AWDON5SA1kZMJN9d
	1MW7nJ21UBiV9274SCNVsnKnpA8j5pQ4hsAa8YSLKyzulvdOZgvBfjIgVCBDegz2bdLpR/zpw==
X-Received: by 2002:a05:690e:441b:b0:660:8393:4900 with SMTP id
 956f58d0204a3-667d7b8d6eamr153730d50.54.1783704534538; Fri, 10 Jul 2026
 10:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com> <89a22c6a7532afa530f1c04ee27177e141dd360c.1783532989.git.gitgitgadget@gmail.com>
 <10fad562-90b8-4feb-b7ab-d61015872127@web.de>
In-Reply-To: <10fad562-90b8-4feb-b7ab-d61015872127@web.de>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 10 Jul 2026 19:28:43 +0200
X-Gm-Features: AVVi8CcnWE9VSeWIK2qHw57QjMx4aljxhkrA7OaCXq7SNLZwd9X7ssc7sL3ZyFM
Message-ID: <CAL71e4PRVYfUWc-c+6XHTwtADqrbub9ykbo+rPyramDhJw=Rfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] prio-queue: use cascade for unfused gets
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jul 2026 at 18:37, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> I see a 1% slowdown on an Apple M5 as well in both cases.  I can't
> reproduce it on a Ryzen laptop, but that's too noisy to measure 1%
> changes anyway.
>
> Checked the total number of prio_queue comparisons with the crude patch
> below, and as expected they go down, from 70386235 to 60682175 for Git
> and from 473983445 to 439809087 for Linux.  So there's less work to do,
> still user time goes up -- no idea why.
[snip]
> The patch looks fine, though.  It introduces struct assignments, but
> they should be OK.  Tried replacing them with swap() instead (which
> does a useless extra write), but that didn't change the performance
> (still 1% slowdown).  Odd.

First of all, thanks again for the very comprehensive
investigation on your own hardware!

I don't have any Apple machine to test on but I reran your
exact operation on my machine
(Lenovo Thinkpad Intel(R) Core(TM) Ultra 7 155U)
and just saw noise.

As you say, this feels _logically_ better since it's fewer
compares but perhaps this boils down to the cost difference
between executing CPU operations versus memory
access and the CPU cache?

My random guess:
cascade_down() has fewer operations and compares
but needs to visit all levels of the heap,
while sift_down_root perhaps stops slightly earlier,
so the memory region right before the end
gets fewer visits and reduces pressure on
the cache.

I have no idea if my guess is correct,
it's maybe more subtle than that, but
I think ultimately this points to the fact
that while the change is a theoretical
improvement, the real world hardware
tradeoffs make it a non-obvious change.

I think this means we should simply drop the change
and move on -- it produced bigger gains
before making the lazy prio_queue the default,
but now it seems like it is pure noise, unless
the comparator function grows more expensive
in the future.

Thanks,
Kristofer
