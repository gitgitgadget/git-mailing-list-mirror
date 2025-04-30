Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DCB25A2D5
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009432; cv=none; b=QC3jJ/vAeBcQj57MIiaJlxzNxCaeY6NKL6RHk6DdCojeSyMMgWw1yngXakgc878LZyXZ1i8DVrQvp4wF+pTf7qwRgvHdQoQ8N4JIILqOU42fiaXv32pRZ2xYxXhjsm/OHgw8RxPxAnpN2eqynD0WRKDWBUmi59FlLmyYjyBU5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009432; c=relaxed/simple;
	bh=5l4vQaI3wBzW+iy0HkiRJagIvhcRBWk2pJmNoJP2G4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LN3m7eQ4xDUD1BhqTUwLfauyN7tL0iI4IwEd9HfSyeOQoGDwLPmSLEkxahuBVlqXnL5bGpV1QgG55LLQ0Rnecix1UIapgzz1wJlM46apqsbGrrbDSfOq1dB5XszZMWEzU1sUh/MZg//234JzggAKPFU525qvcjMufxOyMQiv8D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwvR/Mjm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwvR/Mjm"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff37565232so57676977b3.3
        for <git@vger.kernel.org>; Wed, 30 Apr 2025 03:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746009429; x=1746614229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7eo0oHlclqIn8ETvImQeJJQ49m7qvkQb2dKxwbO+Ykc=;
        b=HwvR/MjmjPO4fQTyx+hGLPD7DbcAzKCC5vHk0n9DolWhuEpqh8IO6kIRDkJn6pj5D0
         AbJQqTEg0pIytthdBW2QZUxSqLMFZG3QMJ/r5k77Jt7Ysi/lvyiZRz9fwTkoYzmNUjIP
         zcLyA/veFc/lw/1iFqZQUC33QgGScSeMDqn3lmQ4P7aPtOlyCtxMR1DIYkZ1ahyUjdHk
         6+OPZy2FKRmQrqxwSwCxXFShqAU/jychQmaPyELF5eB3wMm4WT7zwgFQ22s9y1IHQi4M
         pS0YPouPs6sxg0f6M6wsS+DjmsFOPQROLqeZClAnmAElJ/TMJuzAwqO5WufxZayop4MG
         oiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009429; x=1746614229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eo0oHlclqIn8ETvImQeJJQ49m7qvkQb2dKxwbO+Ykc=;
        b=S2RneuJj58R2XaoCYwY4fZsmrpeClNJStE0smF6zRabD4wJhYXyJveWGBG6O5U8/be
         h6lMRLRzoDDbVt+hXTHUxcHeyu8ejIBhWPy71GTtBS3g7uf/FufV945VR8eH+Z14TD8c
         DykyaG+dX7vimjTbeAmu2tKi+mfkj9RyqUJGnlYfxYpBI068EEgCwCZBbUbL/tb1MHPO
         Oqk+JmXpZ92L7HOqG2mmDhG36TIZ5kJBPIR27KCt1FFrYbbjhNQ2usxoOt0sgurfvbOg
         v5mR5dkzo4NIkkWtb7gESusPoUtBE/t0SyXNEFujWANHY5gBjgwBLy4SINCfxyG8DL6z
         QHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJFAe7+nOu7pRj2vVIrI7XKvVXUFFgwsBopWjZTb9Ev9o9re41Yq2ufsODcnmBAJJdqGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPHIEEucF/cHCjK3+k8FMAoHOWJaN94v/zwz+hQBP/WLj8ABV
	FUziFLzsQSWrOLUrqj1DZUHoZax98yy8A9fPVkUItr6tsqqsnTWOeTwfew==
X-Gm-Gg: ASbGncu7j1eIdw8E8Wh9QgeIUb+ojm/zrNh4H7PYz9DkCvQZUMoznfFAjWl+j2BGjuT
	/guFBrt5ieWziw9zbojb+SwRY6wDP90jieuiU6sh62sbdQwrNwA1k9VnU69XQEGwTZyJAlu0rh4
	HxanFSfSMqfDvSKt0UGa4ESBdU96C/7oEvhFFepBDM72444rP6HAmw+ByWQb6CcurfX+jpAMTfd
	wtOhKj+3EeDGG+d19LS76uW/eRHPmxR2kRcW7amyKr4nLZ71S7fsky4MAO97NtNUAMf620QM2YT
	SwM/VAQ8r8KNIPd9V+qwZJuMvjmpQFB7bYNl+kNsAtfEo8fYRWoX5TsqxoaRlvIuzDxtZQgm3/I
	U6S/WOO+LCi02oo7t
X-Google-Smtp-Source: AGHT+IGFbhPq5ylp0rZ7hy+6F1QsMwMpJ5odJKFKOtU/459GfXPs5SuGbhYqG+XcJsmQa/S5HiteMw==
X-Received: by 2002:a05:690c:ece:b0:6fb:b8a1:d3bb with SMTP id 00721157ae682-708abd8d0a1mr39320197b3.17.1746009429071;
        Wed, 30 Apr 2025 03:37:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:ad95:6981:343a:ce99? ([2600:1700:60ba:9810:ad95:6981:343a:ce99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708ae1b370asm3085237b3.82.2025.04.30.03.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 03:37:08 -0700 (PDT)
Message-ID: <732db882-f27c-4619-91cb-2cc291a7c7d5@gmail.com>
Date: Wed, 30 Apr 2025 06:37:08 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250430-pks-maintenance-missing-tasks-v2-0-2580b7b8ca3a@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/2025 6:25 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series implements the last couple of remaining tasks
> that are missing compared to the functionality git-gc(1) provides.
> 
> Right now, git-maintenance(1) still executes git-gc(1). With these last
> gaps plugged though we can in theory fully replace git-gc(1) with finer
> grained tasks without losing any functionality. The benefit is that it
> becomes possible for users to have finer-grained control over what
> exactly the maintenance does.
> 
> This patch series doesn't do that yet, but only implements whatever is
> needed to get there.
> 
> Changes in v2:
>   - Introduce "maintenance.worktree-prune.auto", which controls how many
>     stale worktrees need to exist before executing `git worktree prune`.
>   - Introduce "maintenance.rerere-gc.auto", which controls how many
>     stale rerere entries need to exist before executing `git rerere gc`.
>   - Add tests to verify that "gc.worktreePruneExpire" works.
>   - Remove some fragile test logic by introducing functions that check
>     for a given maintenance subprocess.
>   - Link to v1: https://lore.kernel.org/r/20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im

This version satisfies my comments from v1 and builds further by including
the maintenance.<task>.auto config options.

LGTM. Thanks,
-Stolee


