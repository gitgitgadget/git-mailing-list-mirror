Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832739;
	b=qU0bucKxS4xgVMgW3SlVlKlPXFp0PZaB6PLXv2C6BBtEP6SzP6n72Y5BpgQi0LFtNBGX
	 jETxzsKbuslGqxXvV/nSWDH9UifogsSlmUImYCsraV0DQD9HQBPnw0XKweoZrHQLaSwgK
	 D3lfsJsyea24vWW+TdVGnxUex07KoDYWpsTPWOx3pNkl1p3dMtFg55ylrAbkNIwWGbnC/
	 PQx9Hts6lUbDrCVGPMeOTuMH984kJ5uRyYKq4W/gRF1J3jJV/2EPODeDww+orojzm9JT8
	 zTp2gkwRm54LsfJhqoAbiLuG/z6krUIbDp0n3lPxL449JEg4/I44Es4AwAaG/JADG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832739;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jqDvmSzHtSmVjg6CnJbKMM/2OjOkIAmFm01CK0fIWoE=;
	b=1Ox+aahVgX7mKnKcUs2RuriQsiHqSbjYUGsoc6s+x2CuGO9iV526FEPHzhIp7pHc92wm
	 /puwIVZ4hXPRrfr9gqMwDAYKNUq0+8desYjwF1fPbvSB8qf8MegGGsh3SUPXp7dx7ribA
	 NFaQdRNdgt0ZjGDsjWiTPL7sUG6bgU9+RttkA/Ep2ELqz1F+pkRSuF/zTpZ5SIuFlqtQE
	 8aEw5WtYp/qxdzDEo03EXid51A10Z+eEFY0+M0pm+GOjTf80AbJ+OG70i4RFeWWDH0/xc
	 s8DVPwtBXFvPsVtwc4Z6wcv5l4UpckkdpxduTr0wuHqw22kRk7UL6h7q3DzZfWuuhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="POe/FZZw";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JgbMdVeq;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD3606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 22:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AD3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=POe/FZZw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JgbMdVeq
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 47564EC01DD
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:52:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 04 Nov 2026 17:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793832738; x=1793919138; bh=jqDvmSzHtS
	mVjg6CnJbKMM/2OjOkIAmFm01CK0fIWoE=; b=POe/FZZwJCaWjRVqMV62GFsUD/
	M8+Tgz17IxvNiHH9+Pf9hxbNPtZufr3x5N4GswHG0VLbyUHOD3anqJsfIm4vzn5/
	S5SvG6snuG/QJ+TWtP3HEAieItZJeOHmLTktgUDxD9D3QuX590FZQ0efsQMlH+eX
	4yXsDy6uDRoKZiI92E4v7yNAQoc8snehtwqOGk7NY1Ot3oNdrdqbIeyXC/MzGY/1
	K+k3N+bM0y3AzddfR3scMHGl9+wB6OIl6l6Etvivh8PE5wb2C4JsqnzAjZeC0mWe
	8kgXrzSpfHM7p4m96cCP0H7Ypf7GprXnxy3ZwkJgjnBbDh7bwrLs/AY0xuMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793832738; x=1793919138; bh=jqDvmSzHtSmVjg6CnJbKMM/2OjOkIAmFm01
	CK0fIWoE=; b=JgbMdVeqO5akyvjT8rfwb7N/UG3+gOghX8ibM5hXpNa95pbIkVn
	a6liONGHvvF16ZG7xDC+INSdTZWBcWZhB+f1rfAAKRdlhq+JcCy4ejtGMDZghdvs
	6aJhy4VLmz6fBnKwYEPRf41RemOMkdsQUw/4hllIB95Y7AhCZWIdaWuPzIxNMFQ1
	Wk5+iqNubqI5mgjZsclpeyitv6WXOR8dmfB5eY+5yAhhCuDP1zJ8BpMR5G9BVaZz
	/lOOp6rvkH6i4WflLjMfmUvcBQyvoKs7os/wBLIgewBUsrJLszzqP4iP5gx0Q8bf
	O5eIA6adNXsYEkig3isG4UxtM8A7UINNnQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793832738; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CN1CoRtfRXAKgANRvBRTF7FcHYlIN7B7JxKB4+Om80ZlDM9
	Wo9aDAupc4hAwCdZDHNk+IeVT+/9WTAfjzAsgqm46MkHFCyv2NypdkKlCr1FfK7l
	UUtUEY+SxEl51RbwoNS/jgb/PASBq1uHMCzBnRYMvfNF2fnzjlJaLJ6oUO697FuO
	W34xayGscw35EyBag40g9NQr6Fsc8g4LzbMgufS4bNFc1VRQEDiIYLHKxWXSxOG7
	fWU2cVhfEBCDBtzPIVXy7E5oWVz9+0ac8Zy2OegHnAPDcuSSn3SFASLPEpslCXPl
	t5QqwTZf1VV+TF6vmq6ZPwkN620BIh684InSK8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:51/Hq6o2E+SvP1aC8NCmj/Wfw380jvpcwVEo57+qWog=:VuN2FfCHNhIQE9HnQTHXNGnA+luHPhnm2DSH889+gvk=;
X-ME-Sender: <xms:IrfrahsTqTAYFO8KP9OAX-jFp5qQTd4jI_zLuDY9qvLOwvkUmvUriA>
    <xme:IrfrahVLOMGc_Cb5-pvSd2uqnhRDvnTbDhf7Lgg_7WRxZ1aWOsSbd2nuVXwlQMoQA
    1mmE0zGV54lwUzes2mRwGfxupqyY_57Ao1aGH3lyVx8eeXvTCqkt5w>
X-ME-Received: <xmr:IrfratFo2-gRfKXh-CuiscJNlwZHphv20C9wYHiBM5Rc2xWw2CnSlmVo3meCy7VDROtdPTB2oWjNPX_hhWbRb-YUy-bZmfQRnME_>
X-ME-Proxy-Cause: dmFkZTGddHAxacoMgBV5U/yrFpMyWRWHgMkW8xrd8y5rpMe3sL9adllwOd9Rh9dpj9Yroe
    bDo76Y9vqaN5/XMjP1v+YWvcQXiXdR1zQQOMP2A0GgE7yugHMP0hfW7+ALtPpyTh1elYfW
    xvodneuyqqxCMHwi51sJitpJAcONJdhkBQ2kMy1bh2xTw9SPKKdpqxcn9bDs/OhNXzsjSD
    uV5pq9EeIckZZPI3359a9EotkbKuBhlw47DH2hGZ9OiKw0igJInnL/+XV22pKtUli3i9KJ
    WlTPu9FSwWiSZTabZhLJKU1E999zSKSVCb7q1Uy0W0E+8HQJOgNtzdaB5NHH6Cyc7UeLB3
    OEEXhLvjqBXX5mteQ+UXblXdKr69xkjuGIw2NJzWlbKwQ0/ySmf8XR43zo56iajah1cuC5
    cPF5YjHUeJLT1fdqzVVSdy6US2oDibdEV07g2/UfG4WxiGzlcwV0RX2WtKC96A/FtkwDbO
    rOAHq1kk+uYA+tW+ZPwUFujaJWnVRo6SwcYU7oD/CC1kHagI1YGQCqwAAz7rO70qi07Qg7
    8JsZEXCgyaYsw3XEkAeRmaAeMbG3Bj1mXMk/PrdY1fgICSR+S50kpXaIKlAfVbUqlwVLWD
    SwAOo7m6mlTyW4aqlCeL19tfzPttmkn91nA/mZX+WymEjk4Pk5bGBIrSeUpA
X-ME-Proxy: <xmx:Irfraj2R5Knpj9Gv1f7h8qlyR7tQLTEuWhnKrBhgUDp8WhoI-1cO7A>
    <xmx:IrfravNhILDoZP5JGN3K96dzhz-LWVX3Dwk5dmmZTM1wDLI-qryFeg>
    <xmx:Irfrai5gyh-ICNFU4O-dzU-It9Xa-7f7Fdq_guaCvi6A1p4QOQZRZw>
    <xmx:Irfrap2PNUB99U75LytgCNKIvctdBqgv2bVFbqs16n0btoSt8vEKPw>
    <xmx:IrfraiNj_VdARpA_h39Bg4YunZLeyb3BqbtYVzfSNWndlvgYj2FP_u-b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 17:52:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] fsmonitor: invalidate untracked cache after losing history
In-Reply-To: <pull.2295.git.1793806679163.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Wed, 04 Nov 2026 15:37:59
	+0000")
References: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 14:52:16 -0800
Message-ID: <xmqqmrroyztr.fsf@gitster.g>
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

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When fsmonitor fails or returns a trivial response, refresh_fsmonitor()
> clears CE_FSMONITOR_VALID and disables fsmonitor use for the untracked
> cache. Unfortunately, this may leave untracked cache entries marked
> 'valid' so future commands may miss necessary updates.
>
> A command such as 'git update-index --refresh' can save the replacement
> fsmonitor token without scanning untracked directories. If the next
> query returns no changes, fsmonitor use is enabled again and 'git status'
> trusts directory contents cached before the loss of event history. New
> untracked files can remain invisible.
>
> This integration bug between fsmonitor and the untracked cache has
> existed since the fsmonitor feature was introduced in 883e248b8a0
> (fsmonitor: teach git to optionally utilize a file system monitor to
> speed up detecting new or changed files., 2017-09-22).
>
> To fix the problem, react more completely on a failed fsmonitor token
> request. In this case, invalidate every untracked cache directory and
> mark the untracked extension as changed. To guarantee that the index is
> updatede, set UNTRACKED_CHANGED so that the index is written even when
> no tracked entry changes. Keep the directory nodes intact to preserve
> pointers held by callers.
> ...
>     fsmonitor: invalidate untracked cache after losing history
>     
>     A user of an internal monorepo reported this behavior, including an
>     AI-assisted powershell script to prove how it worked. I used an agent to
>     assist in porting that to a Git test script and a code fix, but then
>     applied significant human editing and validation on top to get it up to
>     my standards.
>     
>     Thanks, -Stolee

Would this be a viable replacement for ik/fsmonitor-untracked-cache-trivial-response

  https://lore.kernel.org/git/pull.2247.git.1791127155614.gitgitgadget@gmail.com/

that has been left unreviewed for a month?
