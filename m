Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130743;
	b=bDmIaSeYnkgeZcq/n2rn/uy3wkGShTFkdAji0idB6G93syDt8GGq0Ef3mjc+ABL6mAHh
	 CWocsQw3YGHLxqpN0SH/ptEagwRg0EEVTiYcMd7Kd2N8YFIR0BL+yVNv+uXcS3+3pCUtl
	 0tQprz1qNKQB5TSYIgxCrwUoezJVQ+nI5kZDLM3OagFofwiOVzrwNC2K+XiOOtacApest
	 +f0uVZs1V0bMR9mTb8SGyiwuivSlc/YZv1HaQDE85EZywKRBvJe7T45Tha8CVL5uW6lW1
	 gZQWaQFy7zrHXnN13eML5Q1bAt+U7cvilM3b8QqgJR4LlFE2j0KQNBOQdaQBUk31h+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130743;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=d4yrme8y/jCEMBqLl3LqAdggQUanwKcx+nBlD92z4DM=;
	b=jIsY3nuq+CIuV5nvE21M+4RKJeBFoo/lcqrf70qkC1ntQdDRWT/CARLT19LfCyAlbkUX
	 ZPGwYN/ri6ZCvcVGLKIwYxk+7Gl05nNhJ1Y1M5KBiaad/LVEgK5kM8PffLxK+qD3O/NDF
	 ywme/FiuoZ1uQ5nh3970Fc9zRihetinpf0fLaB/m/zI76AQF12x+bRHacZSpH9ixUM3hy
	 /8WRNRu/do7ZJ+62tyUdsfbgpHKP58V1x2d/G4tH1Ga9B/f+wIfPqc0P7PPls7UapO+3k
	 D/HVC6zX0kxr9dDGwFGF7/2w2eDqcWJ0fszG8ErDq3U4o0c46O1csDLzmf0Yr3WHugg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IEC3sqNu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SVVbF42q;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC83606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IEC3sqNu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=SVVbF42q
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C8D581D000B8
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:52:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793130742; x=1793217142; bh=d4yrme8y/j
	CEMBqLl3LqAdggQUanwKcx+nBlD92z4DM=; b=IEC3sqNuvz/rkMoAKc9YhbK9GK
	6xygObr4zhospye+QXoNHEUBhHwvlVdKQk5tjqKh+tgIQWE3fyIp89D3jrWGWjor
	BcaICgEm0VzyL3OOkaEpEHoDMhzI3hIFRqxpXUsUXcjPkytjxB6AeXsgCy8e2Sp9
	QZWob77EJVGVjkgOyb4KA4TNceR+Ipl31DIrO8PvJ3Oj5CYxFGPFXx90W6OT12DG
	BBzdzZcwnkp9eOsJ2KeS3EnSIP86B/qjNIgY9OaqW9PW9/7vyGAZ4VSgFbogCR7e
	t8BplZGoTjK3R3exfPJx1JsLVqKVLUlnypZVV8XEOBbwe82FjbGTnY7yRiWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793130742; x=1793217142; bh=d4yrme8y/jCEMBqLl3LqAdggQUanwKcx+nB
	lD92z4DM=; b=SVVbF42qay8OyIJxJdGAPHxjGw8Ci+bIqsObETtTNjPSwuutv3y
	Dbb99lcrNYN3s8nTJoRx0Bh792f6f7nJgmNfd3PaHKS5Fby4+x84YxSUMCP870Xx
	ineZDTOnmYhrNodFPfq2a4WjRQKqOTNcgMOzl3M95GfY5mMSjm8xpXL0Bfkswyg8
	dDffRW7N3Zw/Qu/TLuwHZ2c/qMQ0Y0nAEJZc+IkE3Ykk9EuT8QtuP/Vr9r7ltX08
	0U+52dtdaDH4XdEAiCp+wCY+5TpOF/Vpb0JGrL+l8hH3NHmtSXtMaHrDf2437oNq
	IBznp1IZ6CKWAPUdHSktwDidsfqLjfdvcZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793130742; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ATUI/3e9itnEEkjY7cAW2eXmjQZx9slBjfU5kNsSqlAdBfv
	JYCN4CtGo60cPJ30uQTGkyPLOPixMFGKH+pmmhA0ivTsMSlgzDMkym66mM87T09m
	Ib+f6Zn2XwygV40C4b7wS9pHATRBK90O9Paso1RIrg/OkH3clDgJA5fJvAiHtBSW
	DPFf3Ntld09va7i4UCbKhwM1sZYl59KzYS69SHfV766ZMPQ5B1TLT4F3vn+XqONJ
	7uNURSv0WD6tth5psEnBD297anxR5Rt+Y7NyDe7HMu03oTOxwU+gUIKBRx1+cam9
	0f8KgjSGGhXWHhhAzk5vwCRvNbJm/2LU8E7JeMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NeZAcCCAAaoovhpQr+gqJXLN4QTEn2Z7nraDJVmdXPg=:cwv+yZUkp7BJ8hkpPZC9keIw4L1E8HymIoidSNT0+xo=;
X-ME-Sender: <xms:9gDhaqX1pMYfLpjegHYZmPvH8I6Jhooej4nMGSVRcQv44sBuKXzkZA>
    <xme:9gDhauDM3ATVw8DQMsEa4eaZ9z2N9E90Zvlmd8fqfIi8vZjQgCAhRn-GXBVRS6o6o
    AUYvSuXquyQw92mmNyn2uiEUA_89nGV1sSxJBuHdEEwiG2aQZqDh9o>
X-ME-Received: <xmr:9gDharyDEsUsEbBqun7RAXPD5oWSVSkYHaHmrHXBVN72__UYR8x8Ug9m40Q64eb2rF8lt75L2kjAaHwAIfW8oY7VirY-tXsplGH->
X-ME-Proxy-Cause: dmFkZTEym1zCHzhX6rDFqMa8wg8C4l0XROg27HuHhCk4n/3uWFoOv961VHNIMWU1tcsraC
    mVM7ER6jES2wpXucKxT5ulqPzfhllpjjIqsA5jNZXXhqPZTYGc7Ly9FiGO22QzkD431ha9
    z4ygr6uU+8EGam1aFGw19RN+LhikpAwVt3lg8PHu54G7N3wNMK/t707JFGZRctyRkqYylV
    Um8YRPX0sI1AlLYqyfcpalPh0qkNss9hUe0wDShXvDZlX366gMcg2zbxuidgckoWP3Mzq8
    7zeo/O5gghyeNLPrYAv27nYmqaUhSm6PTwr5GVb9dgogI1qIhpl/ADIaz7W5lZvWaNl2oI
    IHNNcAiQR9rimDlV8C5fTSkNTgk3O5Rl+mWgGHQD5Yor7hk0WtfyuAG+8n67TrYtntH0OO
    Yg5Vb++Y4ST+sqD+CO8bQaEOUz81Qz79bnBHPjnR3saaGQulpq4PUUD5yrnFj/Ou//t9VW
    0SbZZFo692s/GU16f8BHvq/9MTWBLxPs7V3fmjon48NUHkQNVYpX5TRbdrfhMSww1D0sOs
    mhdzfZW5XrUcHwj+HTbdoNTg2P7UApzEyWdmQfBvU1ykIZ1HY+UTVz+gLoeXASGIglz8Yu
    aowjwVUc0dRgAsaYX1z2hB2TT0oOWbZkwC/1JxQwfzaADOBbj/RYLBkJHz2w
X-ME-Proxy: <xmx:9gDharCCV-0VBxEwwcWqtyg3C15klcRBCqBnvBCWKLfq3y11iuOmzg>
    <xmx:9gDhaoZATjKAgjeM0GCbLcgXAzPXSlltU5krTVFnUFjViWGc3wLZvQ>
    <xmx:9gDhajheY3PFe-rpoJSANpd26exbnYzJniCWhhyMTJWl0ZvUNfbgCA>
    <xmx:9gDhaq53aEGnLA6XEvC3qY_ePrhxfceAXIlu1AfqU0GGILAQr9pxxw>
    <xmx:9gDhauIq4MINwViyVGuf1IAbGLAuk_0dftnQ_G79wOlgPJuXON0gWGZK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:52:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/12] builtin/rerere: convert to use subcommands
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	(Patrick Steinhardt's message of "Tue, 27 Oct 2026 11:46:43 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
Date: Tue, 27 Oct 2026 12:52:20 -0700
Message-ID: <xmqqqzhaj4zv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> while reviewing some patch series around git-rerere(1) recently I was a
> bit appalled by our custom subcommand parsing that we do here. This
> patch series here thus cleans up and modernizes that part a bit so that
> git-rerere(1) behaves like every other Git command that happens to have
> subcommands.
>
> This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
> ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
> rerere cache state, 2026-10-23) merged into it.

As the inventor of the mechanism, I took special interest in the
topic, and overall found them well done.  I wasn't even aware that
we were so close to get rid of USE_THE_REPOSITORY_VARIABLE in
builtin/rerere.c with such a small change (even though as I've said
I do not think it is high priority to make cmd_foo() not rely on
the_repository).  Very nicely done.

Thanks.  
