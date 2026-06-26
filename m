Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D258184524
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492092; cv=pass; b=oKvy3Nxi0cBwKO1xnQKnUW7+kMA+MGAuvw7KcIRYOXQdlPETWnahUs48cEI1jwj9y2msJ/fIo/a4/VrEq30kkjPo4sONBhFiSxo+wZ9sbfJX7YQWlFkkevijmOZWO7JZ/N3KA7ba2MJhpIBehEjoOu4H3Xm8cfwc2djX5p0Xkxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492092; c=relaxed/simple;
	bh=5WlE1iv5olvbeGqZJsTYhssH3DcwL8v3gjmvrYka4BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inSHNfKW/xyUkgrx7nI7rihauUEtIlsXrKvX4LIrM6Z1zbIMLMgTPoB3Cfv15pvO8awATjSIvMAZtGq69stiLEs3oZyHKIrX0Zd/3Rl3Q1z7526fA0nLewse30AtQUmIWRo5PQyUA89VnpPrMF4HM7Nm+PX3mx0FP/Yo/HpEaow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=EFxcYO3O; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="EFxcYO3O"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664346e66daso1179155d50.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492089; cv=none;
        d=google.com; s=arc-20260327;
        b=HoG6b3HhElHmzksHrOtwFiDUvCik1+A+Y7cxtdvoiSTuGkmuMIKL6XZoUewuZpnTEL
         LFzHQ8Q5kxmgN0JIVC+WDkDL9avPAqSjwff6lI8AiEr2WPWRYmcVHtN831SHa8qCIY1j
         SsEZDWScis2TUOxzC7Wl9XP6bxIsXT+5flSlOB/NSLWhcSYU4Oipo9KpTawv/Xe8gihJ
         07fse5mJXcqesuujjKHeNjIrGQJXgmhx4Nbz4v9KC2v9wK3OvogOPVLHVWzd4mwsGQRr
         ngLU24fU0lhjypRvRqRFqWaTsV52WDTdoJ/NIjyJoWENawNlnkRpqisdtv5E3jAazJmP
         SnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5WlE1iv5olvbeGqZJsTYhssH3DcwL8v3gjmvrYka4BE=;
        fh=AKvpj17K3Yzy3VyIu2QN7G+s189htP3MloRB/sAsluo=;
        b=QFXptf26TZapLfyYCjwo60i2JxTWHUyZ+L+WSKnnrZDZmtT7N9LunPgAEBCMlTDuC6
         0mP6tVNcJ+2RCQQU+mCHJF3/BiFO3AAyRw04Fb2g9BvdY4EU0ARCB7mxBB50TlRKXvAG
         4Bqh37gElRmFBkB1uJR5/on9TpcsyhX2k3dcQl1ahmqP3zgQ0ZF0xtfvqHtd5HnwTRWK
         4D/6TAQ/L0ZSDAR2EqQqIOtx0i0aEqOnrOLvH1x/n9glZhv1RkOy7g6tXy2qFC7B7fdr
         SZ1IykcEzPP5Rmv5bHOiWewWRa+S1BokqHzJ2m4+7LYXCIbWrWA58GESRuQa+RsfBlHG
         GB9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782492089; x=1783096889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5WlE1iv5olvbeGqZJsTYhssH3DcwL8v3gjmvrYka4BE=;
        b=EFxcYO3OATGtXadCKjHMQA2MN5sq0uwS43fg7jWSvmME1OWl++WJrr4ICBlS/kmBlu
         3M4paOL7EGv0uJjjFD2eCCHofoKbdc/IPM4PiP+l5UONj6z5K5MXSyL+gS9jA1qdiyIj
         wgtBeJN11D1HSyLnnsIYO1uQUhCrlG60BjmUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492089; x=1783096889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WlE1iv5olvbeGqZJsTYhssH3DcwL8v3gjmvrYka4BE=;
        b=N2j9NWBa2fEpg5KR8KqJuBkicvQyefJ0mf8ut8GnwAsRb01vHIBiVoo5+FnheUryLR
         RJcIBHDibiJj2kyIHi8Aai4MizV0ZbKREwiVCLkKFiufczKBrCZP7KKznWqnsG0782wM
         a3WOfi5gBFaAKsNDgqNP+xGCK9wwZ0vfo/jlb3PEVoQ6sZe5ZhsF8EeOlnuRAM5pPbJX
         GYHOuCGVMJNzSbfsYm1VN1uwQTshf7PVjw7+mMsIr/WgNYdpdVO+Nw3h56xAf6/Gc2Pp
         uzlbVA9aTA3jZZ8R17tWQvX2d7QaLaioqDaNZ306lDIK6NVphXLotL6fjGE8COcSo4Y4
         coXw==
X-Forwarded-Encrypted: i=1; AHgh+Ro30zvVarxtefSptJS2HCorPCllvoJdbZiI8xF50qYtOO0Q6UxOz0OaRstgiXoNDvnRtjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsoQIxrS7aGZPHstKbIWYc0HjtZO1fsuW2MmctFItPqPfzDKf
	l+mLOTBJfusCs/N63kTh7msU9YKP01HTgLXsZZMnSEYFveM19hHnr5q8ppKe2DGzXM9ezw8H8ya
	6gmmTY0fVFueRrq3UzWyGKoNQiv9l5W7klJVFxLTWfQ==
X-Gm-Gg: AfdE7cmwV97O72TBEceLkYelI2LpQvJrKsaxWB1xEReJwtJCPvD6PB+B4EV4WuP5OBs
	Co7QH6024jmOffFSzG83aSGa8ZO16mouP1pUSkT6Gp9RMBimWkVMCwc6/AHYA8aMm1HSQT3Ll3c
	W6Y0HpfFhx/k6xU5bcsFnaF3U+fCMQDn5cbfywyaMJU8BHKUMItPWiNVWkfGz50mVZ/V71N+PiX
	LFEgX6koMT1jEdQLmw0bE9qjkvePViYoV1W/cuIry85MohTWvf/ewktJWXzNJ1Z/hjWrF89kQ==
X-Received: by 2002:a05:690e:43cb:b0:664:346e:61db with SMTP id
 956f58d0204a3-66487e24110mr4352998d50.33.1782492089275; Fri, 26 Jun 2026
 09:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
 <CAL71e4N3RPHSrXscwYJUiLWc8-a172h+nE13yuUBRV7Uu3zGzw@mail.gmail.com> <cb82cb80-291b-4a36-ae83-f308560c844b@gmail.com>
In-Reply-To: <cb82cb80-291b-4a36-ae83-f308560c844b@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 18:41:18 +0200
X-Gm-Features: AVVi8Cdk_6YQS9IBphQmKoGPcIg7VuvA60kTYYda4posuC1uc5KBwWorkQJYwgY
Message-ID: <CAL71e4PcCGbth+CcU0ievjQeK_VnDVwHX=FEvR5jpSkzkr_6GA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 16:32, Derrick Stolee <stolee@gmail.com> wrote:
>
> > I have to note that I accidentally pushed this version before noticing
> > that it now fails for a subset of commit-graph modes.
> > Apologies for that - I will rework the logic here later
> > to preserve the behavior better.
>
> And do we catch this with a test case? I'm hoping that you discovered
> this error through the test suite, even if you submitted the series a
> little early.

(I missed replying to this message initially, sorry)

Yes exactly - it was caught by t6600 but somehow I missed running it before
submitting it (so I noticed it in the GGG CI instead)

So the existing tests are good, I only wish I could be equally reliable as them.

Thanks,
Kristofer
