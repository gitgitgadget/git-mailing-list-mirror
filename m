Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792658155;
	b=COsz05HaQtXuwlm/g+VeDp9PkOAheeujX3t+4Qt8tnm7ODPKTI40eS51kM5m1hC03z8D
	 coCFFHmikTa23YMox1nGdppViNUvOZiDb9nl5KsnmMnxkpePmcR72IqRtluy8iEaN4dJw
	 KlAYq5r0gAdMc6cCnRgWfdq897OK4n4tARo8KTSA0Io2zo9yEGlXonK5blkBVWZf1OVNp
	 wQYOcNql0MnJCZWJBkOdWqBN/7wdpED9AnBLvLWdV4xxODTZ6w46iFrWDeiR1WJlG6r0h
	 i3ffiD9DMfETGcWp2EFcm+sRtTKhJ2Ly+Uhp0J6nbnyaYeKvY7uv99lE6CKBCOncnFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YDZNG+xuNo5zSDo0iQzTi/eZgqBPUxb1qTSZpp5iouY=;
	b=NA5gdic8T76xucEfx0ErwS6ZPeJOmgbyjEZd4SoMNG6z0EuG/EIAcKFoh81+/+wJoMlr
	 cqsVN+TQbI1WgdVkca++WOe6qXjqgYTDg53t6Z8DB30ea9BrrPt0hnN1obJGabIYuETtj
	 aHAnOY15+3DvmM3DwVt3KplEX1h6C8fp+qpkEp83XxYrCsjdwaVRUAHKQK2DfBQnzGDRq
	 AYnLwjX0vVoHHIkW6KjHm9Df52W0cnJcWkeKAEeUrg9KFFSzSFPRByMkdDmMQvDBjLT8a
	 z+eICTE1kfQmZzMh+3FtwF7eZGRIFKkRzyX09epxE1hKXIGev+SahFKloPysAGyKKGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=CMXa047z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD7606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 08:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFAD7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=CMXa047z
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ab3d3c5761so14338597b3.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792658154; cv=none;
        d=google.com; s=arc-20260327;
        b=CPWceDxx6FDNBY1x0XJuPrbSpkUqygE+HByNDpI4rOEP16NZCIE0uCuioOlryLPEfl
         jS0rs3P6LleLm8B9OBlc8Wp8c83Nq5RWm25kqcp7M+VtUlCIwhp7a3grS/ZF5eFHfJDB
         E6wU6/ib6QHwjKYpHbcIVogomih189gRugYiaRoaYDQkjMkghHh9D6JYuW07WGhcKBo7
         1HGJQu/9d+aEJj5bztsNjV6mav1To8QkEGGD0gHFEmL+qWu1/AFiIlmBPERHftXE+M71
         exNXmP0/erGvNTZ9LmAGxTPcU2G+K+4qsgf6Mlh5qpupBj2uUbCmaZNX1MuCM2Fbjck4
         t6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YDZNG+xuNo5zSDo0iQzTi/eZgqBPUxb1qTSZpp5iouY=;
        fh=uyXpz0agA+jdQeicW+9yumIW/U55+LrgKZV9dYVkLvI=;
        b=BAGhWphzSFozg4CYd+PHeVilPoVeR3Wxu/tswm4l24xlij8ByUlJHVSWFL1WgiRu/l
         u1hXg3+hucp/+AZYzY4cliG1BltAVnaLkbwrMF30q4BmmHmd+dXGfDpPpL2cISd4LxpC
         dCtkslmMKLQQbJdGdYcK1VbS1GRfljHoYhIgYNNzMU5lwy78tsRPevcTLsXyagxPJda5
         YuT4wJLP5TI9QGWQCrBMihF7RB8pGUbtXNK/R9VgPco5C79lW0cmbqsWijrGdMo6/AFi
         0HECSD7ccgclGLc3ltKlRRcY7FrUjcS//4zhP0TMud+CLzUqZwD17U8+e+JkbAKD8XWR
         Rauw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792658154; x=1793262954; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDZNG+xuNo5zSDo0iQzTi/eZgqBPUxb1qTSZpp5iouY=;
        b=CMXa047zbdW6yN2ZqklOf/oLlgqV1ttFKNKmIaqt9v4XVRWYq0mwu+2PRc3HpeneWM
         MVOfC/JO0Jvc6OTMnUdxP8oXMLamsA8ECSe54obSyFhEpSOJ86FQPZfOGILT1LCsi+YQ
         TmWbhUmCzxfMfdGruNXztrZSc008q89Wsnlbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658154; x=1793262954;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YDZNG+xuNo5zSDo0iQzTi/eZgqBPUxb1qTSZpp5iouY=;
        b=bCkgD+2Lymg0Fp7SeBKZv9j6NF86afHxX66Zak5ggiOklLhi7WA4Qe2Rnv+oaKrCkz
         tZ+NCIALFKkdci26ntM0iGBrFB5hcDTmxtj8n+at4BkwjIkABUhkQBW3rq+B36erjKub
         vu74tNVhWUClYAJs11bS0LvgPBzhtxbqgxuUXaYsIFwwinGKFd1wTNSf/g9ilQstcbmr
         iJiTFPn8I1cp5wrib0z9nrc4MUK9irCWrofWagO5STSidUhei3CtMF4sqWVHhw8VSMsF
         pZNJK0kmCsJn3I5YwE7d6j42wBTNwMZX2dFs5rna2wSMmV0pNBq8p5RUfhv2EIrjgEUI
         XcQg==
X-Forwarded-Encrypted: i=1; AKwUvBz3pF7pJWqPTyh3oA/k/a1qlDbXJ11BPrlanfSM1xPmqYKzyLayvGcjKBjrObSZmtkLoRM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtjIOnvZFRGdpL5SkrPxLJ4pLHYyN4iMDgEddHR3rwyWJJzdJ0
	ynW0HFH1sbZSSv5J8hAQMZJd4snkNnstnt+6gCLF8n1Kovz/9RwRpPMWkUDbryBDPpHtJ4C8xC5
	4B+wcTU+OPVIjsA4M1g4KQW/hZj/bCiZve7X3QPqGrQ==
X-Gm-Gg: AYBFou2v40caa3vTVJX7ieecLQYtZZPWXzr6BFc2XdWgNwCSs+qnZ5B8ICQwMw3veZF
	ERUSpCTRnwyJrWgF6NKMkqTogHDZmAlJG/XDJ+Ta5j8oOcHDCE9PBAl1mQ7i6hF9yr7Gk3WSkQG
	qEv9RaRMr8F1K33snVO1EzC4Qn+WxVzxZJjfF8YV4DYie67+mWV1x31qp6TnF2UqLL5p453WU3a
	I0T5IpClcv7nz+O0MNiHO94WEcYPTlU96ehsKQC3Xd5LiWmD4mgYE+lmb6YpExK0lxtGC5P8OKU
	chmTz6G68SRgvStnvfWGYveKGZLl/5GgcrOj6v+WqTZ8mtYLpTeMAmJUnD0jRtOiuCoUQs7BUzC
	KxNVq6uN2STp7t3stHSlkux8/wOKY9aDGrAbZYQ==
X-Received: by 2002:a05:690e:4184:b0:677:c92e:eee4 with SMTP id
 956f58d0204a3-67a0e53103cmr2964638d50.86.1792658153760; Thu, 22 Oct 2026
 01:35:53 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com> <d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
 <xmqqecdin6xr.fsf@gitster.g> <CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
In-Reply-To: <CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 22 Oct 2026 10:35:41 +0200
X-Gm-Features: AclHuK8-hbjRaByufSM7xPmsV0p5uGwSIkkBiE0-raw0SVMfanZXX9Wc3-h54Qg
Message-ID: <CAL71e4MepqPJOqUQxoNc_8Q6PaWZwQX45tGZ2z4+iqGnNCDAEw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check via rev-list
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Oct 2026 at 09:00, Kristofer Karlsson <krka@spotify.com> wrote:
>
> On Wed, 21 Oct 2026 at 22:18, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > I wonder if this needs to be _extended() kind that passes a flag bit
> > to avoid fetching from promisors.  repo->fetch_if_missing that is
> > set does prevent lazy fetching, but I wonder if it is better to be
> > more explicit.
>
> Yes, and an earlier internal prototype (that I never sent) did
> this. Blob and tree reads are easy to switch to
> odb_read_object_info_extended() with OBJECT_INFO_SKIP_FETCH_OBJECT,
> but parsing the parent commits goes through
> repo_parse_commit_gently(), which has no such flag.  That would
> need a no-fetch flag passed down through commit parsing, which I
> think is not too bad on its own.

Sorry, I think I was wrong about this part -- commit parsing
never fetches.  I think this means my initial problems were
partly to die().  I will re-explore this and see if eliminating
fetch_if_missing = 0 is less work than I first thought.
