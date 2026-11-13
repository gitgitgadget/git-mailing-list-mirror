Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608276;
	b=N9THacK/znXksE6u4I3Qq9d6bscT71eZfrZrkiYLry1R0hbs/Kz0CR9ZvRwsa3B3S1TO
	 UAggV797kxALZa5f9jTw2oH/BSNCLKnLyiTDMqUE4zb354kPf8/cmcgd36pLeT0MVbTVI
	 fFLB2QjrKHKpe9Dx199s1pP3vWnQJR+OyF6e2q8J8Z8eTup1xIIMgwwe3EluFIrj20WfT
	 bko8e7ZOmHkyp4cshS0QcXkFFmrNCpz2yEL65I9kF5hUdvCl55vaooXUckkKttt/cIeKV
	 LYiFsgMXo5L078KWZNNMBnkAtgoLhSYtXH3mm0NSaWtpbKOIrp1AywIf+fIAjyIPffA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608276;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VlEg6eWUfZMfG4F9uKKzg4uqi+8/X2JO4no99k1LlIM=;
	b=qjXm45gPMrZE+jylqn1Sv28vxdzN2yKDiOt/vXnZVF3kSkQs5btHj1wCJqZJb5ZY5CaT
	 3yrR/EZbkWwwpD3Ujem4EqRkMdzsq3SMZpKV5xQKDjdQcIa7zf3u1YtoKnuMb3/i5q0Ig
	 DwM8fK646U8rATTMLfjUNj++6p2QFoyK/Wl+EcA6NaRtbaU8i5Y60/Gyjrc+La1ySn4EM
	 l5FolCQL811LNEUX8468XMsYWkEEtBBBqaGR7Z9TrQrf4PCQMwM0rDC6ezQ2zBoM5GjJP
	 /kimXvBLbIDgwG+dArUN9WPLPv0eNpmJSSzvXwS8JymvuRMZOdESZxwgD7btvDcnMBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=ljhTCdei;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="C/IKp5Ah";
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48F606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF48F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=ljhTCdei;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=C/IKp5Ah
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B86DCEC001F
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:17:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Nov 2026 17:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794608274;
	 x=1794694674; bh=VlEg6eWUfZMfG4F9uKKzg4uqi+8/X2JO4no99k1LlIM=; b=
	ljhTCdeiPP5GoOeAnAKAK9k2pYKGR+N8+NrYwsr/RfUKLoUQyBj0shxk1R3fTCeT
	ZQWTbLUHE4rg502lsx1vmgbupR3ro41CeDVyU5UOrBZoNAne0XTEedjbhEGfIMgk
	fh63SrdxHHj8e0KDs80j/4NF6LbRwiYroaQzm5ZU2chByMvdTSzl7D/eyX6bUvft
	UYxqyXyfhzDY8HRJ6BwqqxDROzZuhtYziC0A0Q02F8Om+BfBgkmBFCtuR3NBqSWS
	lFPx4IThafsTempbQvJoFF1zHfYQmnFdnlUqNmuJDpPdlujJfIiy5wKC7tTjFrK5
	8nb9+KM8Y1eAis+6KaE45A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794608274; x=
	1794694674; bh=VlEg6eWUfZMfG4F9uKKzg4uqi+8/X2JO4no99k1LlIM=; b=C
	/IKp5AhVgCk9zzQ6K6oPLrr9+wTzFuifGw5Wirc754erSBf55xeyPngKGk8jctwF
	hVJ9pqTKI9raNj8mIXDSTnP8QaRQnphwegnrMClO3Zdp+jnP4YLIUziP7TYqtcvn
	pNJ0QaFTLrfMyPlvZkSEjanIkawkfSTGqzVIC7Epj1+YmH2rArIkoOhWSSSRZpIq
	Jt4/hHx1SZeTLDh+QYnE3ILVUCkJhtS/e32ghhmzeL10cQ26qVyruv1Yx5RwUaci
	zKmaL4uP6VsWjxfSDZZuI0RE4IRSd+g1yRhlxpciP4r4jOlMfxCafSSlCkEci+eA
	kYbkjix1DWsDPTdjsm9PQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794608274; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:RIDU+lTUc+XHOcIDm/LIw2wvc9s0Fo0V7NlGuXVU4TQuIkc
	ye9p1UEUsYbB558h8ZFPubpcz4Bz5is8n48I8a4ACstZoMUaCOYMCPVM8SSkRqAJ
	UOfqTFFsyjAj4XI/3pNhFWuekAsHi5Hg/Vi13RMheHNf9e1XTJ/S+DIo2ZGq5ZQw
	ZZBKf9UwAGtKKvEmu+nTVyyPjoioc19s84uHaTYw2LZT24/pDberpAmHJWJGURc3
	EaoHZULhqaCYs5NB2jTg86/4Mih+u3tcsgAiENdg0RboGpIVDAsZGlzUiaXwEj03
	hC5xb/3VUlJerHH6v3PyGQeeS3t13J83LJvheJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:f3oB8ehMR1es3ikWWoAT4srF8eIG+m3ne+qsr/Z4WuE=:xlJhft+s4jhl158JHISzwmTnv46K3IZR8d9RCqQUApk=;
X-ME-Sender: <xms:koz3atLjyZ-7q6mTptFYD3X_uJvo6PQupvO89r-Gau_olnfLhtN94g>
    <xme:koz3agCTaaiW2bGQfEizqObBc7Jyq0CaJQ26IM8nfrq7jGXNTgkk-XNDekIiZZhrU
    LKGf3eai--hbZ9yrUogXuzjAuiA1PO8QQkB0-4-RraD5Iy9TYvsqJiitw>
X-ME-Received: <xmr:koz3auApGLaqxS3j6HxkObkFlCmCfcOO-4y42gtA73FyW338X8_0K7Lz41vwjtVUxJ-p15PJTqQpFPuhfy7rFakg217yoKgnT-8gK5QjbMuwdp35Tw>
X-ME-Proxy-Cause: dmFkZTFQDB0gDCwJL/GdGrzQ6SlyCsYNX+9mgKmw5WdZZnPwtZ9w6xpUhuKzq9s3qICMkf
    9xPFqH+AyBo+f3PeL0XLkIU/p/+jzO1F7IJU0iWPSoD0ZNJFL8sY7vxXr4GystiYcT17NT
    WWlqW3834qnvkp0AIqWisqa6dhBjGYeyxPaOdtbtPwONEoxnkJCzNIVY3IPEuF3P+93UCo
    MaUiBeCtT0zIUl994OO3ZU76tOtamf5Yd8bzjyvrPXFG2A3KcLJYusQZGMk9BknFtaOTn0
    IVEpDz8QVj7CWYO6qm6WJhTha8M98p5mbRDY1U2lJCFmdHI2EYojd23cVpBb/Os6VZdba/
    +nQqmLvIYZqzsubezMzylWrDHHDN7O3KcSa6JyUgpFE6g8N/CMZLTHBJx1eWWRHgUM1gzo
    koLKLCR8cbI5Tyn0fxthTEP3sWl5DBqjljh9W1Uq2fZwASyfQl8eRyMG5HE3v476Yo9Gri
    UMNW/evhXSe1xXJI+1lI9hbJUYeQIgWyT0kM1bI+2lKn0CDA6C30dd3I8NWncnBBwTu89g
    5rOe7X1QHnOc80iKCxuIJIVPajWNKj2oDKanJj46llNglTiRc8HBMkGXgMvZLVDuil7S93
    dl43GjpjJCwXzD2JBz4E2vf/IZi4AH69nHW3NvXs/K/6mN2n6SbYbAcNUdJw
X-ME-Proxy: <xmx:koz3aqA-Cp4l8CFLz7B-9cH1MBdoOFaiW3mXU9QrhR7IRRmoBSRH7A>
    <xmx:koz3ahonNi8IT1qjmEvnjp-29HZ3oQ6VfR-yU9MrX1RhjinyEqRQAQ>
    <xmx:koz3aslbJF03sTyNuV9uXkZzvAtB-Lr_KShNxgV58SJB3MA_VxXwQA>
    <xmx:koz3apzydpRSu_r4Ne-K-ElPCwENibCmPC20h9cxrGzWOqJgA80Q9w>
    <xmx:koz3atQoTdI9M6dwXLNQg1D-FKt5pEm902FrjgQ_uTV30kBpugl1SrBi>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 17:17:54 -0500 (EST)
Message-ID: <c5b53752-cfd8-4db0-b6ed-9fdeb83397fb@jvns.ca>
Date: Fri, 13 Nov 2026 17:17:53 -0500
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
 <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca> <xmqq33t4fxx7.fsf@gitster.g>
 <c12bf331-0d11-497b-b5ae-874534a42385@jvns.ca> <xmqqpkw89yzi.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqpkw89yzi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-13 4:56 p.m., Junio C Hamano wrote:
> Julia Evans <julia@jvns.ca> writes:
>
>> Of course these are both important audiences, but it's always hard to
>> write a document for two very different audience at the same time. For
>> example, one thing that came up in this thread is that creating commits
>> while not on a branch is a problem for the first person and a good thing
>> for the second person.
> This is a manual page, which means it has to cater to both audiences.
> Unlike a tutorial or guide, we cannot say we target this audience
> primarily and expect the other audience to figure things out
> themselves.

My main goal with this patch series was really to create a new guide 
that we can reference as `git help detached-head` in our advice to help 
users who are confused by detached HEAD state.

I thought that it would make sense to frame it as as improvement 
to`git-checkout` as well (and that the goals of both sections were 
similar enough that you could easily view the content in both ways), but 
maybe those documents actually do have fairly different goals and it's 
too difficult to do that.

I can remove the changes to `git-checkout.adoc` and reframe the series 
from the point of view of "we want to help users who are confused by 
detached HEAD state", it's an easy change.

> To cover the "oops, I got myself into a problem?  I do not even know
> if I am in trouble, or if Git is behaving as expected, and I am
> totally lost.  I do not even know which commands I typed in the last
> 5 minutes got me into this state" situation, manual pages that are
> organized along commands to help quick look-up are a bad match.
>
> Perhaps a FAQ or "survival guide" that targets these inexperienced
> users would help?  Unlike manual pages, guides have more freedom in
> choosing the material covered and the order in which they are
> presented.  I dunno.
