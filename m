Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15973909B9
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928499; cv=pass; b=o4+9vH/aLL50ftddVuV+uwCMZjDgIjZLTtG1Ma7FewdKRqEfuVRHeIZAuL3GTc12V3tAsjeP7t5iDy2gWsfqyeOk/uRfSM9/eI3O/T+ekGWavx0Ijxo3EzI+ulde3Q0O5pI0K9B88jOgTVcR9dbFaudxEO+s5/0F1Ap8eqIUtd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928499; c=relaxed/simple;
	bh=c7nJAkCev4eDKxIr7J5M3VuxFh70bf2JG5PKf2t2p58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+cxSOA+R1xpISHy8UG8DmcscD3EhWzr4sIuMRWbIucOGm8JJOEhPNDL1vB4JbaSzyCN7yT5+2pnnKLzSbsMxC3Luq/JwdrgPha5HnRtt6brjD45IxFFIpHtYTYDtTfvRGT3tokWC98IPeHl7sPTh6KUgPaNo6CNgXwCLaMhFaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4GW7NaM; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4GW7NaM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so6976593a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 00:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783928494; cv=none;
        d=google.com; s=arc-20260327;
        b=rb0hV2dAPXMZdSeHFJ5n0rHdcrSPlLkOPRm+WyxAuSXiTofUjmQOKCYaIWbWqWSr2l
         BVgxVeE3lrXqI8/+Vnl/dsPg3xfddpbKZFkYPpswpsFEKXytfpP7El8xDvHPjktYKXc2
         G2cn5RmBzcXG9X3aq3F3se9o00l4++MspsQEQ5CbPNEdHU95L241D5LGIxcrVnJnzHjX
         gPa1fY/rgy3uLql+uTMcF0bFZcKXNMM5U+SX5izsJIIavXlzQ7NZGiVteNuPBBFEtiOV
         Eh7mCfxECYtzMyGXOPpCLlbcnTOs8RAWzTnkRHI6eewpcsUnodjm6fSNURoyFLoCAI4H
         jbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=r1q9MRpVRxDxBAMiewCO0TT7j3hvO5WKK+O6wSw2G38=;
        fh=/WzmUuOECWC+k8/gOJadAeucLFtYs2ekZ/V3h5Vf5AE=;
        b=SnXHHCkRyAxJQqa1oAVsJ+g5SoYnswTPJXp1mE0uKbzJfmiO9rg/DsSy8x94LHxWZo
         CAfjklAi9I6fMBM+70L1mlOYb4WO6hF2Svv4268l35HFYssqgzKk9lsROP1Z9DulhwYh
         WScaqpn/xoJ+/mAISnGPYU6WazVrnzE78sZEuwwewWLm533Jr/02w4AHLgyQIvkS+9PW
         BR5VFoQGf6/jP3SQ5CezRQedONdLrWlhh1iK6vhW29O52fneyBNLiJFC6/THEw+Jt/Ez
         b2QbkB9i/OtDtfF3t8gezkNwe+LDziGZb6K6cW19k9kYGes1UGlT2+FfAIHKYNao/BD1
         YYQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783928494; x=1784533294; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r1q9MRpVRxDxBAMiewCO0TT7j3hvO5WKK+O6wSw2G38=;
        b=b4GW7NaMB8Kbfyumt2eVrjySwYmEdmD8CaMur28HlN+r0ZMbaOONPJDBoSiqPwZJer
         F90NRaFid0VhZYNpW/6qT8kBibIhQ1hfrOvWu1Pm9UOSFuCRzZQ8sqDmXRxktcxzzo/6
         +gOdBeN439mqGU3FpuY/MNamO3f8GThMwBvTpKhw2mOxvfikd/S/V9aJrf6GZ6twGnxU
         RVEacIUbPh3MJLw4F41LB7Iji4qi0RlUhGjI82YM4rAxSum0aEhopaYBy9dKBmgJtWyg
         dEvB1lZz0Jc8FtWMUw67PMNjHgk9RrX5uoUXHwTMrEQkGkvIqXinQJgasRT1gzoc1wX+
         BXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928494; x=1784533294;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r1q9MRpVRxDxBAMiewCO0TT7j3hvO5WKK+O6wSw2G38=;
        b=IzDaOQ6bzs83AEq80KuQZKEWAsNU6YUl8BrORRfyKzWkGmJ1gChikwTLHpVrs3JhD4
         Gd7WKZxC0Aa0HVOv9CLsgWsxU59KTV9NvVJHGi5vzi6zO4bV9ZMANCc7MlEGw01PQmdR
         lZpOcyiiAq8WCkfzqNldg+sbuNxChU+D2RxHHJaA/2Hm/49rK+wpbry2FqwsNoxDRbAY
         ZL28cmt7sME/EthgprVqx9AA9qfjY1d5O9Dnp9P7C+WjUCvNAAGKWi5G+NtmyIDeBWlU
         It+4RqkVeQu8pKkQQc/21j5xk0CzAPL+xqG9jsytfDNtQGGEyqu/Oo603Yw8SR4NJQUY
         HZug==
X-Forwarded-Encrypted: i=1; AHgh+RrbUeWvlnwt9/wqDZToehBl8M1mGNka005zejxei6a/EUZKI/VbH2HlNSMnMdStZGGsZC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPgn6wC3VSpqVGztSiS2aNUhkc3lm/ztU2MwXJiHuZ7S+zlIL
	BdHkgzmRcTKQIxO9yNcOAeoXisUyNA3F1LW8FYZoG0OQfRqWUVoJLyS1KDdZ6iz5aFzHHj4lM60
	bAB75hIhsW4efTlJSbA52TEbmlZFuW3g=
X-Gm-Gg: AfdE7ckPdvRk7QeHGGItqyacLpJEwJ6jIkI68j/gXr05T9hL6XWPOQ7uXg/vuUnlw0I
	Ct0RGJ2+c6NaGjveNLq+2u2N4BkBPFxvf5qVfZMbPmXe5zFDvf4x/JL8cfZ44YYiRxOpq551pW0
	RpPuKaEYFWj1zLTyOOV8Drm3O0vJ3ucFERZJw61iLJ6toCoG2MwH2sdvZnKCr5XPVihlZQw18Y7
	LEBWve89cxtN1kmrxealXOao+iLjT/h8XjLxzieXNXJtNnk+ggIr3QneTz7Igh91AITXAysIC01
	sUuOtieNwIYdmtu6A2lirPU1hFwcwXnQm7x6Dg0MUtlIiWQ1+v/06U9i+m48hnq2Qh/pouOZErd
	449ENqPSDFFY=
X-Received: by 2002:a05:6402:2790:b0:698:b92b:c785 with SMTP id
 4fb4d7f45d1cf-69c62a636femr3526646a12.3.1783928494295; Mon, 13 Jul 2026
 00:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit> <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
 <alJpjTXfZmYQccwk@exploit> <CA+J6zkQcHu-LVKE-1ypfT=59gEzo4qBzi-pmhSJNC_udCDCJZg@mail.gmail.com>
 <alOOXKGIB8BqACxR@exploit> <DJWR4GEV14P4.3G9N0ZL1R8VDL@gmail.com>
In-Reply-To: <DJWR4GEV14P4.3G9N0ZL1R8VDL@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 13 Jul 2026 13:11:05 +0530
X-Gm-Features: AUfX_mxNvbtz0tZ3TuXkJoKF-x4pC2Ezo3IfskDQBpto4b8LelTD_MyVyppwgzc
Message-ID: <CA+J6zkT+Do2P2O2piaMsprhOMx7rBvm26h4i_3NKGG-5g8O=1g@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, gitster@pobox.com, jltobler@gmail.com, 
	karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> I agree that having an infinite stair is not a good solution. the 3
> column wrap looks reasonable.
>
> I see two cases with this wrap:
>
> 1. No conflict case:
>
>   A
>     B
>       C
>   D
>     E
>       F
>
> No ambiguity, this would be the ideal case.
>
> 2. Ambiguity:
>
> If it happens that the visual number on visual roots meet the condition
> (number_of_visual_roots % 3 == 0) and the next commit is NOT a visual
> root this would happen:
>
>   A
>     B
>       C
>   D
>   E
>   E
>
> Which would be ambiguous. The solution is to check with the lookahead
> buffer that we have since patch 3 if the next is a visual root, if it's
> not we indent D anyway:
>
>   A
>     B
>       C
>     D
>   E
>   E
>
> Which I find the pyramid effect uncomfortable.
> What about capping at 4 columns?
>
> 1.
>
>   A
>     B
>       C
>         D
>   E
>     F
>       G
>         H
>
> 2.
>
>   A
>     B
>       C
>         D
>     E
>   F
>   F
>
> I prefer the 4 column wrap because it looks more abrupt and IMO shows
> better that the commits are unrelated.
>
> What do you think?

I agree with Mirko, the 4-column wrap looks like a reasonable compromise.

> Also, about the no-opt option "--no-graph-indent" is still wanted
> regardless of the final design that we choose?

I feel indifferent about this personally, but there are clearly people who have
a use-case for such a flag.

Let us add an explicit opt-out flag: --no-graph-indent alongside a configuration
variable: graph.indent, log.graphIndent, or something similar.

A heads up: I think it would best to add these changes as two new commits to
the series.

Thanks,
Chandra.
