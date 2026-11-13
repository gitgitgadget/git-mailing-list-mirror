Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573925;
	b=cyrnV1sgOem9Ljpo06OWWmj1Pl6fUQSGiFXbULR1X91Zi5CTighXl8GzNBBxtIj8MbD2
	 lgp74bWcFx/LUbX0Ms74lt8VQt4vh43wFu0hWb6OZEiQmpCqOLXNj1pzwQ+L1ofU8zeOe
	 tR0F9Xn6IZd0ZZT5mjgTUqdKDu+BK0wQQPpN3QG1Ka6nriJNk0iJSHw7yVjLl75QG8eM+
	 CTD4g+ZdCyZGJxWbhh2yzWoYq0oToxNvHyMK9/gGg0ufbKni7Z78z5gxZZNbX5b7yyDcj
	 6Z+OBJYTf6mY/oaMStYB+jCfPaGvsoAljgDy3v56wXeN9GnfSUyGH4BrI8h4FHWmOGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573925;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=iFi2dlJnqe0bOTu1o95BfzNS8+xp1CQ/x6dFAkWOJvQ=;
	b=qhDs0s4rcnCnEZcQaX4p9KtFWgSCfoJ+TvU6txYjYG7rd1ch11xswYXkB/VZDaq7sHxj
	 VyOjEh/KPtGo3JkJt124MgifUgXGLYGf/JQ0X06xWknUAUDyINDHmpxKBt4GVHaqyeJSf
	 DeUl1rI/TeVDMqh7CdkLN1PN3oSgA09es9K31sabcfu5VIbs5z5MCEfIjo1hrpFB+zNTr
	 bJqvvwEQFr95qgV4v+2hMBJnOlp9rwgjYVgw0MhlHGJ51K9K5LH83iiAXDyPMoqU/TAq+
	 oFOVZL5V0d4ZJnJ8JN7LyDM3sGVdvgc4d1OZOeWb7bFQQgn4X6qYl6aEMfz9rWsrmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=AWXGM5z5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rvQbmmGD;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFF606A88A
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 12:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EFF606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=AWXGM5z5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rvQbmmGD
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FAE41D00247
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 07:45:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Nov 2026 07:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794573923;
	 x=1794660323; bh=iFi2dlJnqe0bOTu1o95BfzNS8+xp1CQ/x6dFAkWOJvQ=; b=
	AWXGM5z5ZbXQ+PqE0HQSa8sSsbO9HQa5zXdLp8LfYFuGNWuriN3FrsDlzWWf/Mlz
	dyvTerIPZN4p+ILJJycNLgjApqzDBb74i+szLATVpv4a+v6YLLYKr8aVYUBYg09e
	UGFpQ3kahsRbofX4Jw25cjfkdsr+LTOMDGgwYgpM2DhBh6AFocEgMXKE8DKloe1n
	RdyGrM1tLJbCsZpGM119FZJn3ogZnIKp9Z3QvY6CClrh3JEMJi/94pOW61VUFIaC
	Kx/NR7nvfFZFBwBJUy1UWgJW5GPQ+yZ3vtdRF9XVbHBCMDBMYcEWc5+keH257OAD
	JG7RKHB5P5q60qa0bpNYLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794573923; x=
	1794660323; bh=iFi2dlJnqe0bOTu1o95BfzNS8+xp1CQ/x6dFAkWOJvQ=; b=r
	vQbmmGDX73BQSRkW+r7ib5rZN/NKdqQoGSR7Mt851y4WxAZVsSAfEJnIQA9l7y7v
	63HNb6Z9IqAAPtW+TDFIJ8Jax+AI4shxzT0u4DJhxqrQfIaYmUU2TyasoI3x7znC
	LK8a3Hqh74A2N/AuSLmdlJKZvluxOk0h2JY+d37HplMApgx5MDayeJ57ed60uYUo
	Pj8cgjlDWL6SzISC1OZZI5SrhY9wbspqKo7yDBQd1jchpD5CTr1mRtL/sVKy/w/F
	A4ePEOcBY39I6NUR2fuTvyHysS/yRhJ1u1QeG2//ab7M4aTzfUw27Xjnv7+hViwy
	PFAjBFTPUMgHigM7OOGcg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794573923; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:m3+xbEs2FoKyDiL8hJOR06mcfpablmZIqh12CisY/+vc+6q
	WG/w5bYPY6XDN4gQoznIRbve7A2SVgUcD55ldDRswwA6tq91fUUQDw3odEa5rSac
	6Opd+H26isUnMERon7GkTJMVJzi4zjsB7DKGWlxh9Qfu/7j4kxybhkeWnQcuyje0
	cTuhs6vFGyypmcD4DwOITLtIT5ueOcFTc5KOJWbGIxf95PMhvN99YVlk4YfOjteU
	yt3KJoUtWku7cWs+iXMyCOeViGeMcDgxD/Bu5nksNQuCXAl0pUjSWwu12vv8g8pV
	SBSl8nRtA8SDXdlDoB2qxNZsdvgIYh4HN8tHE+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:O9PuHteHDLwUBx4mPlRXju7971oTzVIChahVnjYZJnA=:N06xeg79euO2NpIAoA3hzAZxPRsEak7phDnEgujiu6s=;
X-ME-Sender: <xms:Ywb3arPIQaE2U75oKe2OLKOUwRZJKV1-wZEWYJ7nK4gj9HsbLHLzFA>
    <xme:Ywb3as0shB2LR7hyuRp37vsUoNB2EgDs2Lbq4hTt4AiKMeRmZH0SSC4h7Rbn3Ix0j
    MsZF0VEO5fpx9et_H27qqR8OMPtQnVFvrAnovh4cWlSLsvA_szF35l3>
X-ME-Received: <xmr:Ywb3ainUlQcfHBuG8EaQWXct3DK3bY6a8jOkR-6dvPUKAxLYKOYtN_wdsbwlXDOo2UVyEq8crQ8aVeCI_PQc4Y5u_2-waEbKm7qswcokbaRN__2hdg>
X-ME-Proxy-Cause: dmFkZTE/Qqsw9Xjzo1n312l8Me02F9ugssg5yg3F1aWIjxrHoSFIDxVFCAJjFVG0Hpd3f1
    Sdrtp0sXYS8jRWBXTl5piMshMnDkaS2N/ZzoZX8pmuj8ng4OnUeshGE3QMFF9vySxIOANw
    y8fNCWPVFSPxNu72T44rs+ym/wwEXVGlNZr06udMO4V/IINQ7zbsOZaZtXsNxNpq8aVq9j
    SwMeW/eDor5c1dYXYqKLAu7Qrun6EVTqZ23NXvS4bMnw42CYBpXzLJCUgNXAQr+w4J9XEX
    XHQYPCFCONVEfIjM5uZuS1UnTPyZ9IWbCbnFI2dotKLcDvXi7EAEAGrno6xHF+k9mDWIs7
    b7y1hWcWursUTZK0OnnceS5Z1/qruIQfO7Db5gJeAHS9L+9vg0NNJRBPXj1YEiLE6/tEIK
    69UPMCwfRPWNXT5gid/odSUGxF/qedMOEIQsb2OYk40obGPmjqhaYZdZF/ebj550rVuQcT
    pvyNZlIsx58wTfLUBkV4+wezfyIu/WPiQBfFhTodS8oLeqJMseh2HXvYoaA3uLIgG++kHo
    GY6ida6W/LZtmMEKm475qj+vjNqG0V0kqM2Zl64/rAnzgtVTAt77XpY+hNDrkCc/kogQoY
    nUJOkUJig4gZ1jgCLYBy0hI+dFIFPZYAMEDRqtIMDHlQPiaAo7r3/hG5fFKg
X-ME-Proxy: <xmx:Ywb3arVV1YCB-4wcrOgOd1BsZrJQrN3MjmOL1vTuUE5gJSuOW8Nb6w>
    <xmx:Ywb3agvZx7MalANYzb7YqSEwEODtiU0d70x5TxM4bDMckFNJqGTeuA>
    <xmx:Ywb3amalN73v4d_kPxYrU9pAOCDJRTpiGXJ3O1JLsbEPMbtD84RPWw>
    <xmx:Ywb3anVYjNPZzQ8t4WjAYWdE_w5b106tYZMZrBNBcB8MH_2t9m9BkA>
    <xmx:Ywb3aikM_2odU_BlEGQDcjRSV6r4wTgq2wATA7EMMhTkMUBEw_Hwh0mH>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 07:45:22 -0500 (EST)
Message-ID: <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca>
Date: Fri, 13 Nov 2026 07:45:22 -0500
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
 <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca> <xmqqfqx5foxd.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqfqx5foxd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-12 9:25 p.m., Junio C Hamano wrote:
> Julia Evans <julia@jvns.ca> writes:
>
>>> I think the central difference is that you
>>> seem to consider detached HEAD state is only about pure sightseeing
>>> while it was designed to allow touching and breaking.  If the user
>>> is not making any changes, of course it does not make sense to talk
>>> about "your current changes" or "next commit".  But detached HEAD is
>>> not limited to such a world view.
>> We say very clearly that you can make commits while in detached HEAD
>> state so I don't think there's any danger of readers not realizing
>> that's possible.
>>
>>     But it's important to know that if you create new commits while in
>>     detached HEAD state, those commits won't be on a branch.
> Yeah, but that isn't the purpose of mentioning "next commit" etc. to
> make readers realize that.  So I am not sure what you want to say
> with that.
>
> The mention of "your current work" (started at the HEAD) and "next
> commit" is to lay groundwork to explain what happens when they make
> that commit, and how it is different when they are on detached HEAD,
> in contrast to when they are on a branch.  After all, what we were
> discusssing is an improved explanation on detached HEAD, and your
> commits not affecting any of your branch *is* the most important
> aspect of what detached HEAD gives you

I read this a few times and it's hard for me to tell what the issue 
being raised is.

Are you saying that we're not explaining all the details from "`HEAD` 
can store either a branch or commit ID" to "if you create new commits 
while in detached HEAD state, those commits won't be on a branch"?

That's intentional, and I can explain the reasons for it if you'd 
like. I don't think this is the appropriate document for that information.

Here's an idea to resolve this:

1. Add something to the commit message explaining why we're not giving a 
full detailed explanation anymore

2. Add some extra info to gitdatamodel.adoc to make sure the information 
is incldued there, since I think that's the appropriate document.

3. Add a "see also gitdatamodel..." to the end of the section for folks 
who want more information about how HEAD and branches work together.

