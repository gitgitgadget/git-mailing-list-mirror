Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523510;
	b=wZkFNdMlgEj7Df+TMw6cIh2qJiq1LcmUjVm2//Q0cy0234h0M2BOy/xuxlbcOYRC6+uL
	 CsQxnbYQDRGmy0rbTe+cL0nQdstTrVZFnoqYpv0eFCP59ISR4VxGcm8sunACiwaholWUk
	 ZmZ9/oeOGCoCCxAs+/aLIhGIW55PBpmU1/xwprmwzL15odxHKBmFOqB7mmK+dloTRvyOX
	 8jU3fhhD4ZQgZAG6J9yt3UT+5nLZKV1+S0VlFet7fDtmY7HN9+k9Gr7aRdGGoniYXUh/W
	 dqgRl2Ggq3XcX1dD9veMD/oFddhsq40hauMs4XymzSBEwiJfN+GNLgit1Xnm7GrH9bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OU8bjve2dwkomhFnuN7GnYhFPoX7nZr4BW/b+iVABko=;
	b=mF8FAPtnVUFRGAifUlMIb5vh1NmJ/Oeh8H1QfemmogrhoS6TeWTmi7yeqEwkPctohe8D
	 T7UIxjqWwPPlgVWFheMJJcY245Mq6p9GuKHGXz29jSQ3z1z2soUyP2uxAyoW1l05FWP0B
	 IClHjh3G6z7yi21laMlvaYV7Oy3ESkrkJJSyFxEj7u8tCTy1w7p8CGHHiSpoHKZ0/tngY
	 frayqW60sJaJNb/tAi+jBRvRYNtGF3TkWcVrTVNJpP9T6z8j6fDwF29KuaULThd9jVpHK
	 ZBQd+14kdOFvj3g70ytsP3Im0rAfpKHC6UKgCI5c2htgWlJsoUGpp1rNESkL+JOaHiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=IU+jJcP5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ahi12QSJ;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61FE606A33A
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E61FE606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=IU+jJcP5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ahi12QSJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CB2DEEC05AC
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:45:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 17:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794523508;
	 x=1794609908; bh=OU8bjve2dwkomhFnuN7GnYhFPoX7nZr4BW/b+iVABko=; b=
	IU+jJcP5mguexGHey8RxGNWhco+81ovJh23DYRYMd0/J5Jan5rJcD/OaprPDU0Lj
	vG126RtGzHgkMoU12Z7Vbj/EmXUmtogtQcnUtID5N2bvZS862tn/Q1fOztJ4hRPY
	EAC92C8f2allvXCCnDZPzQ3ZOPSr33C8ol/0GsuLyae/h9sCuxx4907tW2JIzHhu
	r5ha0P7Y9zLn2X0yw/KIGDHMKHqz60Nq0vkrj4mgKK+BI+w089RsgwgbJPOlZuzq
	/0T5bz0QjgUzDKcF8A2PSEbAlg/WTFzigvH5gHGFSuXupFcidvnvAfxg6IEqIDgg
	T7xdrmjYVJ1wJq3fFHj8MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794523508; x=
	1794609908; bh=OU8bjve2dwkomhFnuN7GnYhFPoX7nZr4BW/b+iVABko=; b=A
	hi12QSJfwtx1Hftx4C6re4ZYTSbbvplo9KmJvH3uvOy1DdMWESvR5V74bEV1g8m3
	EQ17qEfJUjXyFpvekdJfNOwY3MNkbWrIJnhiNNMyDls0m2um24w1R3H+LkcUN2tk
	inIyp/RxxStvbhLl948I0ckiPoNUtC5S6fUwLSlg6OuVYx/GxEL/K+Pb7b/ZFEME
	vUb8l12JmTHOdzEAXf73xkxcycvt2WgBxDljgvZkEBUSaPCrJiRMUqrCDGkC34Aw
	heAA7MmbZ594fF4wNUSb6j0/0a3YeHyX4ZBoK95evvsxwpHRgERmbxLZkQzNQf/V
	qf1r55DtMf+W3qBjyh8rw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794523508; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xRlBEsAMAqQvf9PExh/h4vtyWw+m4Hf4LnKafa/Pz4TJ1wV
	L40LP9EUOgh1tPC7/2+MUEWC/dfftonHjzdVxVB08fn2V36nqaBtKFwSA8DFv34A
	ZbtrVol6bZyTdB4434iECOKRoyZAgjEnesK19MQ3MpihB+y79/0wSC+ZkHSMYiJR
	lnDpxB/aGae+RCuZGRiJWvqjWmIwSGRu+O+NLtV91hnoaiv3UrD67+Qmp4HVn0y2
	kQN8wC0ELoUnDrK23zDDkK1db6HsnUTKoxa5xGRBfauHPBXJoXMjTKGZYbh7DUdI
	d5xuCh1mtWa5xMvbXfgUffcMKzvELzSCCeJLWzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hG02HNpR5lz//0sevxkWz+RNPsLBrVm7O9mQDDySPkc=:ui5OTW7/wPlevusy/L0+3IVNSAYu5Y0rJsga9g1MB0w=;
X-ME-Sender: <xms:dEH2arjDyEEcKAqrCEctzvCl30bUTi8Z7ZC5qzmAinPukmy1g_RYZw>
    <xme:dEH2au6LH3sKx82iHW7TLrUs7K8jREWG9UTRvwuXkUGDrMDi3Ot16X9AIC7J9etUV
    kbiqfeRwpHmiqvg3CCXYYQURoidjDHOqyDimIo9KGfO_ord-LU4aYrA>
X-ME-Received: <xmr:dEH2ajb7oMqYq7icYkQqLXEeordowoOHbwrovPW4c1UmahPbXH0DVAVilimXtsoaVPlvvn3OIMDlFIKfNQ9YBiJoW0dAR3C14L7x2GkSwCx9opjo1A>
X-ME-Proxy-Cause: dmFkZTFUzYwFY0uNr8Hc0q34Njz/8Ml12QDJ9Cdkj8EHDhMUIXDUGyxz6z2q859tyYzfu8
    KHMrp/Yeitr6y+hG6VOHa5vvKJbFSJS7M+g8/KLPSDHfl3aGrL9MrWpjygkoXUV7PLk1pi
    1EXckiq1S9hiAN1R0PMeFYaPwcGz324dhMuMfRCEHSLbT7U1dlMuOkEHBi0C5NFKtmhxUj
    +P8S2wqf9KF1WQxrdTIgdvtcx3HQqU+66RoYwhr8HUloMU+HdAd4I+j5SL8PRQfKh1y0q4
    nUn1wLls7ZMFge//mr24S8QFAOgPemu/gIzJF4KRY1UUPAo8Z5dBK0mSPnqLgJj0L7UxPe
    25FICJC7lOOFhoMdMQ1d0tr3N4WQsBWIjMS+URdgwjACMDviLZuB3JxMx5DLeKLx3ZSM6M
    4IO0ZzEJ/SPYEeuVvwdmIgDq4nIaLPrXpoK4Pt9z82GAk+Z020kXuhcTZSZ9YjmvDlxj0d
    840FeWD7cvr7EoD1tOz+7eggfphRlCa+b3fs60gzVDQ9odqQyBXzLtN9PH38lGE9mnyriT
    GGgD8dfSBB+gMa3h05uHJDlXBIRZHSwAMnetVheKzojYBihGP+iLNZEnJjPXD8ydv0BITp
    TaYNIVDHMDn/tBrtIeyrC0Xr5AdYdh8fWU0eVADkG9Ys10Zy2f3k4R3eLbdg
X-ME-Proxy: <xmx:dEH2aj6kpteOBF70t7c3z9VCzE0xT0ddxRiBdN7iMBfUP2ZYP8gImw>
    <xmx:dEH2amBfwes1o_6xpJv96PZBpNnZe5S7CTKLQaHHFMHOn-WC_szE4A>
    <xmx:dEH2apc1gk2_ONBdsDbzS7aYNSckk7OvICLRCkaNGA8nHDCrYLbpQQ>
    <xmx:dEH2alLDA6wLXQIM-WuhNarKrYLb4417ERJBKwvHTRzFr4N-M_mSOQ>
    <xmx:dEH2ataYXNuWa_T6OJpk6o9odLV7L2jEFTRzs2Lz2oCYjRRNI5SVEix2>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 17:45:08 -0500 (EST)
Message-ID: <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
Date: Thu, 12 Nov 2026 17:45:07 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> <xmqq5wy2kqhl.fsf@gitster.g>
 <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca> <xmqqik21j1ie.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqik21j1ie.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> I think the central difference is that you
> seem to consider detached HEAD state is only about pure sightseeing
> while it was designed to allow touching and breaking.  If the user
> is not making any changes, of course it does not make sense to talk
> about "your current changes" or "next commit".  But detached HEAD is
> not limited to such a world view.

We say very clearly that you can make commits while in detached HEAD 
state so I don't think there's any danger of readers not realizing 
that's possible.

   But it's important to know that if you create new commits while in
   detached HEAD state, those commits won't be on a branch.

