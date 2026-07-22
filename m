Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1547DD4A;
	Wed, 22 Jul 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734366; cv=none; b=H4xMwglSnClk3tWe/zM4OraCWI/hg7XGwvZH7LL+6KgodiB4yy1Jo/U7WgemAIJzhrOHzlKcbwo59Vsm8okSPY0AqC/EIvGxAnLhQMg03OF1INl8uzKR68D97Ba1Aynl/q4xlmyg44PVHkP47ngsjc08wzT2nog8VPFDnm3IlEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734366; c=relaxed/simple;
	bh=/wdTS+f4uLBsPjr0iqwi53XHY0aWR7oEauCT9edc+X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9hiGqe+3sMraW7W0c3vvnU6WAyTsL6mxd/+eB+3Q4gkSrM0cbjuVnM2jDIzu663g0pBUNhQPbnkK0rfYgxN7kbYbt0EQoNHdTiIbfAXI1kxUtn9qB5NNzgg4XWII5q4/NRUgsO0voJe+490KjEh0dHDbdx1aawcnm41vqWBpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V6T3oiay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nE7KvB7q; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V6T3oiay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nE7KvB7q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50A741400122;
	Wed, 22 Jul 2026 11:32:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 11:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784734364;
	 x=1784820764; bh=4Zg2nnTQLXlCugUeoSxcBmfEus8rVi7k0AOTDmUH1HA=; b=
	V6T3oiayE9Bju4sXd4giE4V/FxAi0wy7gtVs2CJ6BD8w/os5RbtqO+Yi+9dST6RF
	cvLQ9yjIiMsYimurYXfzZWWwDItLUNRihbgQydncao/1VuWosHRUQ4NP4Vb26Hj+
	/OxRH4oGU3AEGmZfKZGAhay6lAt4e56qrF5oLnkBF9zzythwHwVKc/iGry9w762U
	TfYdt36MJC3iPWdfJ8/OZ625f/YtP/vTNQq0J1ZJuIdR2KIkkzuSZaJ87SaYy1Em
	zFIchgu+QvyVPwsFc0SoqwbKGS/QktTFxgBppNKOuXLvWWgu3+t3+p0QC5jhzTs3
	HPAF2qRRJhv7iJyNTS4B/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784734364; x=
	1784820764; bh=4Zg2nnTQLXlCugUeoSxcBmfEus8rVi7k0AOTDmUH1HA=; b=n
	E7KvB7qrAApuvZwQv29TFfcaPAUKMUUFhTIX4RqjRcn7Lx4S/a7XCe6EJXxCxiyX
	97LFJGHy9p+3YpPIi7J2xSuqpMf05fg6ZNtjbHwBhBO/5TyTnx+Uh+DxiA/FHPF4
	pUbdF9UHn5yylb0wHMatvanzMq96e9MwYFm8y7jXnc3j6tNylpDUQKOmwR5XLaaa
	J5xnYwfgFKtyK8rNbOOSbtrnq8UGAECzoZG32av/0VsUbR5MGjqI/ZsIyTvfQgo/
	PwprLDCD5i4ca4NGNtdNaSMevKYYDaOmRQ9k1yJwV3zHgfe91IBrVyw1Apg3ILZV
	4RBkEhbOvxkg2FCUxOMMQ==
X-ME-Sender: <xms:nOJgaqEXzaxL_J9Fu0UHhfcHffkOvu4Bh2TSnBkdAyZgWK9rDPr3mw>
    <xme:nOJgaua2bm3ArZ-ASrzL9_cSW7iR2LNhl1jiIIvF6yVQPQsK-LzuaGm1X1KelwGMN
    udHcgeIIgxU2i0j-H-XpStOyC0UnCkY0VJF04Jhm41k56mDuQqlKiY>
X-ME-Received: <xmr:nOJgauxbnHwTO7vecJQKsLL3-zZcEPgmYWU6P6CIwnJByEfz5ZrSc-wT-MSBG5sP8Wl_51jsL9vS12xMFsrL9pTWuPI-fYNfog>
X-ME-Proxy-Cause: dmFkZTFxsALUb4sR2NdP/9HHy32xz/sAse+DLl5J5C8Twg/JbGFg2UToZN21RDcj3PZLij
    05Yu5IuWFGAbA9M784MUid0jCG32grspNrp3JXk5Wk50nDYUW/SAn74cEqn/5d3As5Bbp3
    a+4OUpH7qAfhITC8z79Ibl/DCqPqAfOoFdL78mkZ1xdIngvYn3iWii/wUzAfpMhzPbhGP1
    aqrbl4YsVqyyIs46pnAZrgbavnCKjtMfk1mZskyJSGum21QHazuiRv4ITAOqS2vo4M7gkk
    dNIvhEG8NwKepI53f//2sYxt+LHDdOzdfTYdUAQuuc9RZ0QvQ6IS/bZM1h8DLH6Ud/UeH+
    W7gKektdFssAZd3z+Lnr1knmAiYl7RapMs7UCHQN4a7SpCZ57y680aLev1Mw6IS2yZ9jY8
    M0OrWvZ6MwQs6nawsuE4mVyZyyHMW/ty8RXR9fHxEeDGQcbVjjGz9/FtWvZ0bGBQOZUrbv
    1DIsu+o0a2IGwmU6ZLNquK1F8k9weI1VHokswcCR5ZcA1YLNr6l2aGYPernKgHFrcf44UO
    P6eLMFlfFvNMEjdcgjV5zqRdNBguXGv+ftfK4Tzr+TVjoR4MVzjrCR5Lr0l/412tso9hNJ
    vWOmbO4rhBSkgjkWL+nV9e8LCrBkp6Q1MtOeUVUKEGckSaCu528aBZWeaBEQ
X-ME-Proxy: <xmx:nOJgagSju8cYys3-8tBMekn7dthBvnXFOhAHUa1uncEGQA4F23b1Ag>
    <xmx:nOJgarJpyvI0te3hdK1nAbuMSAy8kCVzmiq4yn67ZAuMRpBPxONIMg>
    <xmx:nOJganX9rsmX4K1OYNK18QhZWv1pF31JAu_YO5kcwpZLioA9OaAjWQ>
    <xmx:nOJgavTKj775gYo1vwcziWk-eJsmCQoQpfIMOgeRJb1ojNkxcCe4RA>
    <xmx:nOJgapbS4ospFkgUjbLOPzWkyJu04CuFSZhFYIG0HRFBnzG-jRCsIRa6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 11:32:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>,  Yury Norov <yury.norov@gmail.com>,
  git@vger.kernel.org,  Thiago Perrotta <tbperrotta@gmail.com>,  Philippe
 Blain <levraiphilippeblain@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,
  linux-kernel@vger.kernel.org,  Codex <codex@openai.com>
Subject: Re: [PATCH] completion: complete paths for git send-email
In-Reply-To: <C9564DC6-6B68-46CA-A339-1A1774AFA7C0@gmail.com> (Ben Knoble's
	message of "Wed, 22 Jul 2026 06:29:43 -0400")
References: <xmqqqzkww3ky.fsf@gitster.g>
	<C9564DC6-6B68-46CA-A339-1A1774AFA7C0@gmail.com>
Date: Wed, 22 Jul 2026 08:32:42 -0700
Message-ID: <xmqq4ihrt4yt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> As to the tests, using 40-hex is misleading, and 0-branch as you
>> said would be sufficient to reproduce and demonstrate the issue, and
>> that your code change fixes it.
>> 
>> Ben, anything I missed?
>> 
>> Thanks.
>
> Not from my end, though SZEDER’s review merits some thinking.

I agree that presenting both refs and paths cleanly will require a
much better structure than a flat list.  I also agree that hiding
paths when we have ref matches may give us a cleaner layout than
mixing them alphabetically into a single, flat list.  While I am
still not convinced it is the best way, at least that is the
principle current completion implementations use for other commands,
and it makes sense to model the updated completion for send-email
after it.

That said, since I never feed refs to send-email myself, 'if we have
matches with refs, do not show paths at all' rule makes send-email
completion completely useless, at least to me.

> Traveling the next week+; replies may be slower (than usual, hah).

Have a great trip, and have fun!

Thanks.
