Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590599;
	b=ema6Rd8zUcpnF4GPgPLCjDloUCM4fjsmX8pxBnxlH8bFrbr7wmWp5ppScXdtOG5o2ma5
	 b+GR6Zvp/2tohzyJriLXR5M93kgUj6I1tc2TBnA79ty+FspMe6IDrWhIzgqhhoJtzpr9D
	 mIdSI8XBxXUEYtTzF1hHo88mLjpSHJnFcZZXQX+mrhYnY08UMJotxzWyGlrKtn2Y3Cznl
	 jc3qiuNH2e9NvseL4z/CZFB3ISisCi+GejmqB9+I1s20QimjhpOmjvMCYP4tSmU50/ucF
	 LSV2HkqERZl/XFqXR4kDQQ6GI1cjAFu+ZZUR3mtYhuu4xf1va947s5bI2TL6ySiYvfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590599;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=K/3qt3n39Ltm2mplLlqWGyI3BNnKghltrBA0Coyqa78=;
	b=ioIMjQOJ7OT7akT5FW2yI03AW5Oo54h3pecxlSeUQ2cbXSpHlg/U+F05ks8fuEECbNQe
	 H0YLZfykZBztc/y4KE80f1xgp9VBKRq8EREsqBVAyu56I/dbT1hegr8RCQerkjgsJlLXy
	 tg79SiFxakcwm7EHjF+XgxosdpbO3g2ZoDDHfiN8HNc91GigJNGMkWi5pkGnlsVrqzlHx
	 kl2GXhzgzR7gUvFytfyuqPmeQD2H0GniHgMSaNYlehnPEkQVCp9IVXI3inOTweruDSaVv
	 xtHId5EcfhOSGJZ3AOH3IpdXzZcwTsJoYNscILgm6Wj1pxpeATX5FxF1CSG0YtOxptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PWnp1YMV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqOriSKg;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D7606A330
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 322D7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=PWnp1YMV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hqOriSKg
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 569D1EC05A2
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:23:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 12:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794590598; x=1794676998; bh=K/3qt3n39L
	tm2mplLlqWGyI3BNnKghltrBA0Coyqa78=; b=PWnp1YMVD1B3/EtDiE66rcn4Jj
	gQT/jDo6j9QlS4nke1HpLgGhB2RAKXrPOd+RmxyM/JkMyZ0RcaAodeOP7gMqnIya
	oPk01X2YAP3fSP3qZerp/DEhQuEwE3zFtpOM6/MLwRdO6oYwIJTZUHZV09ZOXFnl
	Lg6bjTQRWXTUsFq3jz8a61uE3O5oHA+q7cJ1huVONMKk9ujHOARFEB9Ezbs9YmT4
	TlcZAe3C0Xh84AN3UHD89MlquGKbrE+L7ob/94wSTH6mipKntfDF0wVdjIGSAuAW
	JekwwLws0re7od+xzuxlfS0w2bVa1Z+wKh1qt6hw/30gAK3T21+WwBcoceTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794590598; x=1794676998; bh=K/3qt3n39Ltm2mplLlqWGyI3BNnKghltrBA
	0Coyqa78=; b=hqOriSKgRLOFmcyci8PtyR5Q7cysubGM+xSnkvbakO92Z15fFli
	u+qU2/H9Ldfxsr3jIE4qFK0Zq6RMT+Px/ZT6PfT18xB976TvziMxrn0oG58vw5mg
	dMPex8fAQkjGkhsmeWi6kVGRsyC0nYu79PcqwyYeDFYoexDaCifzw4gwum+Jvig3
	UO63bzuUGn7GMajkmChaOnGW7CrvUKujPcJtk5FMu0+eXKvk7r2Nt/69hFItIX5N
	Jq1y+U0AZexWOjDZ4QLUMxQocB22DU35JYQi6Tab25gc1PGph4kD9+djess67gV2
	aPUWLTYtC2ymkl5rNUXyfChvrTb3H1zm8YQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794590598; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:C9K4CNZFEiYp5kSA/rCP2kWhCv30XJAFH26+0h+uWQPfQoi
	K4P2dCX+BpQSnMh16oBng6WgTlJRssAuW1nEibXuqL9dJgpjdb6r3KmAI+Jld93o
	JgY4/WzEIt+L1SUjsQ4GUtUULv7D8vkrc6IOAZcbq/8VCxaVHDUCZrccP3wvtrWp
	LqIyFkUxDRlEdF9UYkFVWDzrGhHdHD9FlqvUEPxGJjhMn2m6mZQzXIjYjRWjBg6c
	fRBvE+VR3I7uHYlTyFtFX24E9d0700XHsc0pOyl1kyBXVmA872CEczlXr/xoDjGS
	m8Rwdof2jlaHxscP1UDX/zpN5AIF0eT/3qqR2fQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:11B1cF2Hwg+LuY7oz7g4w9FWOuBHq4fUflZUUYwNhaI=:jo+vbQhrKJPcqubar7YpD2NaTPEtkyIY/VRc1VU9Zig=;
X-ME-Sender: <xms:hkf3auy8P0pxcJ-s_JTEysHVhK5NPxm1yKDqRA1IAtrpdlzB2k3PQw>
    <xme:hkf3at-54KnXIG3SbGk9K0rIYRBCsZi8_YAGxNzj0ZEoPxjIp42AlG2kfj-pXpoaG
    qFPV315ahUj1UEwGBsdebT5d329IBag69chc2Vhx9s5jOAkgWGj8Wc>
X-ME-Received: <xmr:hkf3aqLYBECliXZlDJX4ZmiwYTyIPFqs56y3Iu90WvJVYWrfOavj85N438dKV9v5TtZDqHXSwf9KAxGaNGB2GPGkG7nkWAQxHyre>
X-ME-Proxy-Cause: dmFkZTFXKgj/DvcdGJJmbbxBWOTrQCBH/7JpDB5EB5zYWnQmMb9riZ+oQp1UYKzuBE/sCY
    e892dTB/8jaC0X2rA1fNObikogJE5bkT+SqvbMEz16VEark1PKYPcuYOvrAcWecqTjnugB
    1+2D9mTmBi0w7jnZAgnMSv3fPo3IyMI+6Ju96M0qTvXILLkY/ydimGpAFlyxarQATjSvAo
    NjdUEONXeFoabtXS3KJdnWzzF4hSEy5mf6UCWQUCT9cWLL5il32so0CaLhhbnxGDcRtG7H
    yNatyviO8luNlZvem8iSiAp6lb9LoL+vapqlh2XbgDm9fmi8VoJYrIUeILCdNpWBBuzRUn
    HVyIhCibjoEOvucL7mvGaHB+YpqrN/0MZKTu3W1VGn3sTPmxS0HSGITPkP3N3wc9zutmbq
    Hn3eDJsRsIyrcQ7WIJ07KtsFa2aObXeLaJE2sUGN3sgEOkHKw903QZ1hpEjR8EN+Zf0Y4m
    mTxgzzoRixqc5HRAd5di5sOYq1RJDaNKym4UNGcoZDa87gxznE1szJgQH8GA86uVTNvFCu
    GhQaas5rO8C1a8t+RMYPQrsE2MrxR1u7H5FVTE/rsnx5ARSwWr3fO/djiLqKoZ4kyZ79Sn
    a5QhpzNYVVvhaXa2R3VKjeNYVAvpa3+N2TurXE7mtE9RFWlxZVeUjB8uEn6A
X-ME-Proxy: <xmx:hkf3arc497FG_60ajQlBV2pDaA3XYlIlpXLZV666LeZ6u5tztIRtAA>
    <xmx:hkf3ah9fYURus2Lfqby_MX6KPRc2KbzbpfWo6FTvzeG8XMRfZ7jZbQ>
    <xmx:hkf3agp5r7qziUFxE86REXc-t4QUpvZeUe-E1fjpRvCPiCV31-1B6g>
    <xmx:hkf3auD7tXLJMGOhxBFL_K2P7RBdTp_56HUvNpWTA_sa0uK3tGahDw>
    <xmx:hkf3agWAbgwKdai_HaZ9pYIdN_6NdzHHtBzl_-r2FsfCIk9VpPCW8MQZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 12:23:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca> (Julia Evans's
	message of "Fri, 13 Nov 2026 07:45:22 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
	<xmqqik21j1ie.fsf@gitster.g>
	<4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
	<xmqqfqx5foxd.fsf@gitster.g>
	<36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca>
Date: Fri, 13 Nov 2026 09:23:16 -0800
Message-ID: <xmqq33t4fxx7.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

>> The mention of "your current work" (started at the HEAD) and "next
>> commit" is to lay groundwork to explain what happens when they make
>> that commit, and how it is different when they are on detached HEAD,
>> in contrast to when they are on a branch.  After all, what we were
>> discusssing is an improved explanation on detached HEAD, and your
>> commits not affecting any of your branch *is* the most important
>> aspect of what detached HEAD gives you
>
> I read this a few times and it's hard for me to tell what the issue 
> being raised is.
>
> Are you saying that we're not explaining all the details from "`HEAD` 
> can store either a branch or commit ID" to "if you create new commits 
> while in detached HEAD state, those commits won't be on a branch"?

No.  I do not expect an introductory document to tell *all* the
things that needs to be known about a topic.  That is an
encyclopedia, not a technical manual.

The fact that you would not clobber any branches when you make a
temporary commit on a detached HEAD, however, is the most important
consequence of HEAD *not* recording what branch we are on that has
real *impact* to the end-users.  They can leave their temporary work
behind without explicit removal by just checking out a branch, which
also means they have to be careful about losing *if* they care about
what they did during this temporary state.

I view it as a disservice to deliberately avoid talking about it.

