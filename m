Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792653713;
	b=K1py67qY8y0ciECJHtjko1ztkmWCJ3eZuHhpRNtIuXdvPrwsqKI8vmZh5eElJulmOn/j
	 BxtcEpQ1jEIo6brrXgqcEMuE/4IItSjEwkgsOzEB0wQX2lpzDe/pNxLNSp1i5b8nsZjYS
	 DEQz0XGlPNGIPA85Jc3PHPbsfD0bYu1p7P1I9t/P9H2meqVcg9SIWhiLLT+sLMFCpuFt0
	 K6TWu1TTSg7VkmTDl7ZvASg7QmcpBxjjNV2d01Qo1n1hOaekGgXwmfTPNrPCHS6k/U+eK
	 vDsJu9n3bPEP1Tq231NemmHl3RXEZUzQIhumXIRyX6ohHPDhqQWO+sDF8OJEnYmOb9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=TYbtsns3IOAp8DPT7MkNxR3XTQZR+SoyoWCkkTG4ZHM=;
	b=wWaHcucieRz09OB+gs3VSwkdiQ+0JLeUsIlbftTs6smB2c9hu2y1L4LLsBahZGJBC/xx
	 QQYlh90InlTnrXyUJQ7cypR8gPMnlkAHx8qfLzmI+IHhpxXQ3bwRJdkq5bZtVEzWqTdPX
	 OgbF6PgAnsr3mja/tP1ZWrRY6AslFC9IDwKC50AALAxaPeYE5EWvPVGK1EWVr9XDZdHMz
	 7TwOgYyH2ROgl+PFQ/cpieZTbAwQy6sY/3syC44kMns4RAGPEtID57gtpR7ZkKyfnHVk6
	 QfSzhYEKTS/Uty535Nl746vmK3jdp29la9o8fOihgMZdxwPSVgLiD+r3dVWsgexZwrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BQi/I038";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B2606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 07:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 200B2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BQi/I038
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso121902a12.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 00:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792653711; cv=none;
        d=google.com; s=arc-20260327;
        b=mZOqcsfPtTVeojtUbvA+yIZE2h+yB3+EC8hV8N5Xd2kJqmucum2NEn3Z7ZJvzr+DyP
         HIuulwt9NOsY+5CuEaoU+DSzzJFONPyD5hnqUHe7S/uFcFjFawFjn3wA48K0F9UtExAx
         DQr14wCz5dRChfIgDr81ymtz8pMUGA+y0pYE+HYmnQIeh2RdxWoTijE2FQDHkYbkZkQq
         G7FsU+zeBI9iZOGC1VGndxcWLutrp/qOOpMxo7VPwaUZo3chMelapMZ2UnZ/iGoLWSBQ
         g6N2wvdwZRnZ2u7l3kbbXGzdrfyW230bKebVGYOdr2a8wY7LSVUkt9DPKPNGsGHP8kMX
         zjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TYbtsns3IOAp8DPT7MkNxR3XTQZR+SoyoWCkkTG4ZHM=;
        fh=n6dF6yzbATysREPT3yUHjYN22O7cecw478xVrUDaJO4=;
        b=jl3tWC2YYqFkZrxMvW3M5rI0WQoF6ZkpNOii3nlS+0JGh7GIjLk1etaHWdUx1KonzC
         E/C8QUei/AaxvkrB19E3vgEf2i10eaEFNnf8ksRbOAt0D+IsL/KYARvZMVi28J150nQW
         9bihXsJH5FzN/wMNfs9hwqkKGkhvKbPSVC4ixCHBBOM6KGK4p40shtXwm354s+SczfZr
         Nli26xNnjUynbKJDoky+JSJcP9bwvR/F85BjinTMAYb86T70zfaV/qbpxdZ7bMWd2ffo
         4K4WxMxTFHB0eHllP4NkHzh3bNCuWbRtzrzswe/Ofdo9SKkMRHHfRVEFkyrHZy3bWGkz
         h51g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653711; x=1793258511; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYbtsns3IOAp8DPT7MkNxR3XTQZR+SoyoWCkkTG4ZHM=;
        b=BQi/I0385XUE0LR1QiiHqMyYH6MnzrNavi7DzUfLgD2j80L1+BXv16uFRHTxHwNW3l
         zo37onaelN+BPiIDHmWh6yZqPQA5667IGq90lKyYtxWGgzFVnJpKDm4cbNWWZEjwRqOP
         K6r6apHDr97SIZBQfMbTeOOvbWo5uakWjl2D6aIingwj4ikWOW0o7jBzYkcHHzz9rCLH
         PlzU3Fq/q398Y2G8kilHY3dieiBEUAnObS3qEkDf023l2EZD9rzmOnRiXGpZsDtKS7vS
         VvSr95ukyx7zuGdZf20Zyh+tpPhBJ9a3+zYh3AYXd9M2VfLCdGf31nhUwjmde1oRel6f
         VCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653711; x=1793258511;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TYbtsns3IOAp8DPT7MkNxR3XTQZR+SoyoWCkkTG4ZHM=;
        b=nAjdkxEWHNg4WXk4kKdz+ZR9LwHtn7Rr6HJr0fbtUcnVhMBGIXNFaa3poLvKMs1A+b
         xksrOfyMH9yAK709dmRrpcR2lA+4a6AW/EjN+JBbo3MqZLgmTl7u9jEozODu2tNujBuC
         zV2qYi6Im5frIi8wEHb3ssmKnf50wYUVIblNFEcDfxRaj4Xh9OyL68tf2C7oDRiN3CI+
         Bk48h8ATeS3agqpc0FqRV7kFPcqBNFRfXjW6M7qgnSdGKrDpS65kZQwmtPBOF+eKsOR6
         LpSFE4Kud9kUzlyWIdrgpGN4EGrA9Ob7Ye3xTISHvM7cBL749sKVRsHd2tyCtPPlUNIf
         GS0A==
X-Forwarded-Encrypted: i=1; AKwUvBzgQg5smoJuAondOmYQM6WaQVJnY5fbxxaIzmnNxfAbDswW+tIzgJjYcOdD9vhca02ffqY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTx/G3rxaXW5lCtt4/pNOl1abNlURlcN9A2/D58u/I4rwsKdk+
	LCs4Tq51TF0Z9apsglIzjvEeSbQvQf6lHMsjLtnoqDJM/ILvZbu3ft08O2oBhlpQH30Ga2+Vrpj
	bMWEvR1xNp0cCWXHThZRli/1PjGCdy40=
X-Gm-Gg: AYBFou2kwy5J6N9RwBdFAXY8ZNxNIKGTD02m8BMdNF3Sl7GfGtnz4fqkqTFlvSq0JVF
	hiMXHcwI5v+44Pli86mlR1lM4OueetSq4Lc5TV/jvaJ0F4CIIDQ7I1NiwEB2J+1FG22UCgqn/mf
	/bXH6Nh2xc2+74ZWmliNsm77n7iIqcFJ0WkMF1SiVwbod/nDxamrFJgY2kGlJv/vV1HnlunpaHs
	47/gZfOMI9QIP2OkY5x+UMl7uKcgNdFORcwe9BdvczbcExnV+Qe6N+vobW/orUvzBjfheCh5h4q
	a+rF+fpAxul/pdO0gXAlS9oJjUKqmUz8yWgwC7k1KcjQ08IHpjqJy9ZR4xHR22ZRsnkgBWSa5er
	lenpUMfVg95as1cPQyKbZOgra0MTOrswHYsp6
X-Received: by 2002:a05:6402:909:b0:6b1:e2f5:4ef7 with SMTP id
 4fb4d7f45d1cf-6b41d592ad5mr1503688a12.11.1792653711430; Thu, 22 Oct 2026
 00:21:51 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021173350.67854-1-me@jaspermayone.com> <CAHwyqnXC6--wTx0Mkj9r-9oj4R6ndubjzcucym8y3Hs9CKYfVw@mail.gmail.com>
 <xmqqbj8mln3c.fsf@gitster.g>
In-Reply-To: <xmqqbj8mln3c.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 09:21:14 +0200
X-Gm-Features: AclHuK9hV9LvVQKioACHb61lwxFniSQ8o3G3yKelk2b1Yg3yWCi4NcHM3b86dQ0
Message-ID: <CAHwyqnXRHBTt6AoZH=OBhd9Q4UgCk6vuHqrJbog3ZYguq694HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] worktree list: add --merged and --no-merged
To: Junio C Hamano <gitster@pobox.com>
Cc: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org, sunshine@sunshineco.com, 
	ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

> > I noticed that I can't check out a branch that is checked out in
> > another worktree. Which seems a bit ridiculous because two regular
> > repos of the same upstream would never enforce that.
>
> Because your repository updating what commit your 'main' points at
> would not affect my repository if they track the same upstream.
>
> Worktrees are different.  If you allow your two worktrees to check
> out the same 'main', and one of them makes a commit on top, you know
> what happens, right?

I didn't. I read up on it now, and yes it's hairy. I withdraw my point here.

> > AI loves worktress, so I suspect we'll see more of these discussions
> > in the future.
>
> I think that was asked and answered already.  "worktree add -d" is
> your friend.

Ok.



Harald
