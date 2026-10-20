Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522006;
	b=ew9wDsL6ErRHnwjSoJdLeop7G632hv7k2mWxKRzLaOFrLNeTu9DgnGEJuOBblQ0ALAcL
	 c7TkSs0N11Z1xTZEeQhP17xqBLgG7eTYZ97/ZDe7YaNsgAaKsClnJPvetiv1DDKSZfUZt
	 pFpMma9CtWF0muH6udCWnefqsNeYDiPiguLqTCUHJq/uxJjrb6ktD3SKkj0IkQvULYYC1
	 ZWQQAyFc/30nnXCNHGQSXMToSocROHDAqiXXx39UkCZG08E2wQoSyb0PmfrkrnwCl6hDQ
	 vf/3/RjAb8lLjOM6XAWRE74ue0bvFxH3UHIcMCWu9i7GWYj+ePZGsqJlR0yB6ycp0+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522006;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=59xlfL9Cgf+oiQ5wAlyT7K0raJO765atYpJvwVgwdXQ=;
	b=Gc3fDJjjDeQVx3L8WxusxvsEyh2LpOwCoobeXjRayTvVaV5swzu8OM2OQcgZhm8ODrW6
	 13P4bIEMr5N0f7OqW/5Bls8IHSOxDVUlMOcNKqrR76BCQeNsXkW+UxM/QMnEYejB9QsSY
	 YAhjnWusfyFNIJbNHncYO3UHZlgJofxfqZkvvloD58AL126hU0HQWhHa8yTJkDIEhujaa
	 MmSCiOBwOChYtsF1tgyYKxlEcAs5kR4/KHXufQ7rViHKEnpVQKahdYpiT9e9lkFd4rR14
	 1TAhEpgdsiOdyv5B9IqnWy8w5k7C3ttRrdR8chccsroLjRqjF5UA5o4ES8xb99LJt3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fyfPMETs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZIfDSGjF;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC9606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DC9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=fyfPMETs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZIfDSGjF
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55B99140012E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:46:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 14:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792522005; x=1792608405; bh=59xlfL9Cgf
	+oiQ5wAlyT7K0raJO765atYpJvwVgwdXQ=; b=fyfPMETsZgISn0p1ipVN9BRWAY
	RLpIaCIDPgi8LCgEopE0/vR80vQalN/H293Gbg32roNK1PHi1mUEG2Hn1d80nSlg
	t7IvILhO3clpHx/yg/Rc9RCAo/kC1E4hFbqS+zYxR7qD5kI1c82wDAWp03DujWgu
	AgBefK095U/oYHgtV0bkrY/jVOBvOkfx4TpeU+tyvGhJW7Pdqrs9OVGbREKosqLb
	EnN/5MlwjqfuQaVAnmRLHwSDW33CxqbJxzLtvWBANTaNnS2aP4DiLk45Zl66S1gF
	Ws4TSQ/0OJ+A9zJqnuP7Fq3uGkUrSI1dipwuUyQh2m045nFw1PMV/cJirfzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792522005; x=1792608405; bh=59xlfL9Cgf+oiQ5wAlyT7K0raJO765atYpJ
	vwVgwdXQ=; b=ZIfDSGjFQGNjg5yVh8A1V/icU4IjM9jWa3Pa9Taf9g5A+7GZzGO
	PydNPBHCZpvAwLhFkWBdGNFMZC4+T3cQF8jQH9d74GgC2G4pLVc4TUCGng/tI8Kx
	/t8Ebb/nIMfb/PU1IJzjIcU/GeP7ISSOz2LiqkVoGoMGvaHnqL63fEulG4lbuUDz
	HaAKCB74GeSeGgX4TXCigoPFtfHsfaBRCMQOLlb13X1EyNzNevfnnBCXdY2JXAUo
	y513qL1fuShaVM0RS/4kfr0DOXIRqquaY0uFfjbhv/RDy4BNPHTgTagRPwcK8HbG
	OfkaPW7w9hrEskRKwrKz+DNCs6tZWGytMcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792522005; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UnEm/oMzI9NHCLq0clCL4df+NF042/wlNdy0NRxE2U7r2Hn
	Ta/npCdHul+nihj8kX0SQRlBc4fKcFbO88U6pomBEPHXs8T5RAsAQV0yT+XCNMrw
	4i8vIGgJtq9Eb2jf9LGmzjAGHH5cGcJjRgAnwShQvj3o3A+nvk5SyxS9VU7erREW
	rK2bbWet68d39z1Lhjkfwh8mEMeUqwUi8c/AR2yK0ZfGS+YBb9Y/xvz/weqORuMN
	ZsRw+PqtJwIo7AcI1OdHSYI0BEci2hAjJXI574IT1GQYwnIOE4lyy1ePKXJKxahW
	HaI31BApXcql5EbKi9WRAjsxMooMWtXgo61SBcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KFF4SBqW3PyP7dt9cbRcWHfagai1UR3bO7j5dO9oiYQ=:G72OiZF02c2wW9rODphchxiwxZH/kbXa13ZJZ8LEzOU=;
X-ME-Sender: <xms:FLfXavXjGfq39p9srvwUoKbaKkSL2AimByES0vcdQ6hrygj06bUfUg>
    <xme:FLfXap0xflqxMPrpHkGJ95gAO00RCfzfVeNGUaleuY5pcqyBmneEjO3XaBhz8HBg3
    vIrhLzPrm6qr1g07h6FGc3ArLPbWMTHVbHu304sNd7WWnKhxY-OO9o>
X-ME-Received: <xmr:FLfXatoJTrY03iKuQsMN8x_yfTh1kMMX5L6hNtu6wBVPJSZrlm6UIPCXZhhCoISDzQugOZmW8XU5J_NaoKzpNohNQ7MQ-tM9qHqE>
X-ME-Proxy-Cause: dmFkZTG1I7u0Rtcs9btKuxNz6sbfYzz/TP8Vy3F4jHYTAMiEheqXxAN/hy0J6mjfzFoVx8
    cH+vlUDU2UmnSaTMvOaJ6RfGM+cvrEgAPAwhw4FkfvtPY7SLC0dyRZL/fa1BH/X8JSRfwL
    Bst6uQA07uHNSp1L0PCmnzbBxIRBlJz2L2+jBLZqF0EVN//386909adQ5868rwWZvaBs5J
    YEmjO/7RZwU+oC7Axr9g77f0h/voAgvyBTL8n+B0CVxecqYcCRyUIizG7WvqNQrvEJ/45o
    ySTVjAy68crYtAZtAGgpR0lX8b4sWLPOKUtMkwokSb7ugeihuu+3ASzOPWx8nw8YG7GKns
    Mp+7o+9K9LjQjL7QMCStqztf+/j4KL09uBRnb4eAIx4z8ax6aP0xKgQ8BQ3vgzhtoQprc3
    A9biVlwg2q2oPtxJ8yTXAwZdY5pBt796fA+cTrzNdh7RQJDlH94rblzAEfW/YqZ17YD47F
    jcxVrvwZaL52hVvY+2tUKp/6jzXvqF7T0qnS5qIgUYs8ulpWfiXQsFc3ULHoItNu6rRevf
    kQP+JpBHavwJRwBJo0fNdl2uyIRtzfSSL/GaAAbzDN0BXT1OZ7s1QICw7ofw10EHx/Hs/1
    7bXmm5u0WBXhfD12IiAJoj+2Uy6FUyax7VsfI7CZQKt/ATHPXt9kRhVdBErg
X-ME-Proxy: <xmx:FLfXagV8u2uWuLYyBDqfzSEzwxQ48XutJHIUZN6r5lB3URnQk4Bcug>
    <xmx:FLfXaoYgkUJZ80Po1-qf5TV7_WyD_een_1rBRwRdBjlzBVFfS0f4vQ>
    <xmx:FLfXatec2DyBimFafK39MVv08XX-IiELaCgVkutcvAwdKetxjOdvLA>
    <xmx:FLfXai1NMgGwngsqjvQXBFypXv7u35RDRWaH6v0NXPhHuSdaMw_VRg>
    <xmx:FbfXatEZLJ4NS7RGa_opIFRCNtO_Qhv8Q5rOpl-JWHpt7WNlkI9DHROa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:46:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Adrian Ratiu <adrian.ratiu@collabora.com>,
  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer <nasamuffin@google.com>,
  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH 1/2] hook: honor hook.<event>.enabled for the hookdir hook
In-Reply-To: <1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
	(Thomas Bachem via GitGitGadget's message of "Tue, 20 Oct 2026
	18:19:12 +0000")
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
	<1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 11:46:43 -0700
Message-ID: <xmqqzew8us4s.fsf@gitster.g>
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

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Thomas Bachem <mail@thomasbachem.com>
>
> The documentation added by dcfb5af67e (hook: add hook.<event>.enabled
> switch, 2026-04-10) says that with hook.<event>.enabled set to false
> "no hooks fire for that event", but only hooks defined in the
> configuration are skipped.

It is good to see that the original author and those who helped
were CC'ed.

I have a suspicion that the current behavior may be very much
deliberate, and the documentation was written too loosely.  In
other words, the author may have been so excited about their shiny
new toy, the configuration-defined hook mechanism, that they wrote
as if that were the only kind of hook that existed in the world,
even though that is not true.

Let's see what others want to happen.

Thanks.
