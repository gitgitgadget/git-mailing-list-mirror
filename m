Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF21A6816
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487496; cv=none; b=oQWWDkmV3SVPkqvg8bZRVasmSuKtcPPi+FklXBcRuURjyNg1AleN9o13XkUxEkbSrTtqfzWHxhw4HiBZw9c5fYigDBXCOwj5qQu3k0I7GU73bfdURqLszkBIyM0xPzEzuWYPWlv+4TL7tUnZh4c/lofjQh5qwH1fGPsU2wqVbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487496; c=relaxed/simple;
	bh=xxX1YCa2Zg4fzXkPx3/VGKA6+gd8hnvHF3jMahzBtvA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MWbbB5ztMzEkoziOQwsVaKBucVfKisKXrmyjOQedJv0K32qZsPJRGeSkz/u4+vQozdgrGFolXLejHo5FJXuZA+busmf8BGLtNo4bYwNIhYjiVgCyuYeBXvKgHOJHnooGtIraDmm1notizu9fiW/DjYy4cVw+MebB8LViYKAVRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev; spf=pass smtp.mailfrom=braithwaite.dev; dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b=m6WLErfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KYUZ2AoO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=braithwaite.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=braithwaite.dev header.i=@braithwaite.dev header.b="m6WLErfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KYUZ2AoO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF00D7A01E8;
	Mon,  2 Mar 2026 16:38:12 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 16:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=braithwaite.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1772487492; x=1772573892; bh=xxX1YCa2Zg4fzXkPx3/VGKA6+gd8hnvH
	F3jMahzBtvA=; b=m6WLErfgGX7spkyBZC6Ew7mDIBKh5My9cD3R/4yBhf6Z0EtM
	Kyon6CZAQnD7afqniKLT7FMvv7dnWaWKpSFLOSRnHuVkk81dHYIzcMOAOmo7iOsD
	ZvNO+5JriaR5ZAj1OqEb2sMaDtMb6pq9B9hRLHVUR0TrnVkJlWqgh+HGEMLlROTS
	l7OBHHm8KYGX4scD+kzgrq8TmMoJSi/6fXcw4nTeRtM7qsWcppraeuzISkXVOWGX
	UMmVMWXpT6seUHuvAsMNJYWd2lKH2oyeCB/kvtEetEz0ivDPkngQHFvne8SqxD3v
	t4psZ61qJ4IH40p5xFAZUeHMtVfCpntOxvQWlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772487492; x=
	1772573892; bh=xxX1YCa2Zg4fzXkPx3/VGKA6+gd8hnvHF3jMahzBtvA=; b=K
	YUZ2AoOJvVydaJG57z/uWUbysz7aLX8EShIVaHsgoCP7xveya2ZVeF8kkFEYFWdB
	Q60/j5Ti/IULN1ejrhIrrTRMpLO1zitKlfJuUDtk+vB3VxLm+G8tvONWPp+H7saD
	NZQEZ3gsullR2E9KISIbKYYyYX+eU+iwNhM1749DvM3CpC3WBYVLX/T1ZRCIopss
	5dri/ovQizPraP4LCN7i3kZ7bZn8M6HX8P/ON8UYOQqBoUNONeNCv35T15j+LyPQ
	gYyltiTkodQXIAxlx+P2DuY+OJFvGW+ugjjdMxJB/yEjhxZ6HxOeNAKAhOpFp6e4
	SJjSrWQcBNFvKGXiacVhA==
X-ME-Sender: <xms:RAOmaYtbeO_MjPubwGHutiGA65DKufRxTeNwm4p4AeeIWE1CiE8qug>
    <xme:RAOmaQSwMOKkIWibZriiMPxtyqwzANbbmtqSfczhGWCrHAMLSc_eEChLSm4NxH7dS
    latFoSuOa9YWpHhxXW34SaBJbk6VDw6eRuboZgxzVa6qgSbXn9KSSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlrghn
    uceurhgrihhthhifrghithgvfdcuoegrlhgrnhessghrrghithhhfigrihhtvgdruggvvh
    eqnecuggftrfgrthhtvghrnhepvefgieeutedufeeijeeuleekleekveettdffiefhjeei
    hffgkeduleduhfevjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RAOmaaHq7jC-Cv-a81InUPwzAT8Z_hjcFQdUaS6eOk5sOPehN_YYLw>
    <xmx:RAOmacD6ofVffb88SgNnZ8qfem2mseqhPd2pgfoTnZSX8g7JisHSCA>
    <xmx:RAOmaSUY9Q00z7G3d1TpIHSaCTUe5EjvGjz0Oo-aCfBaiD_Mzynr6w>
    <xmx:RAOmaYrldc8Z_U9HdDw7shuP1oz2Vkko5aPmoqh-QrRppRoJCnFO8Q>
    <xmx:RAOmaQyQIHdcwtQKLo_-whyKhmdkmHLiTpLvlsoTAGuu6GzJ8gELWnNy>
Feedback-ID: i1a914699:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3FCC31EA0070; Mon,  2 Mar 2026 16:38:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKwwuKWZdwNg
Date: Mon, 02 Mar 2026 13:36:40 -0800
From: "Alan Braithwaite" <alan@braithwaite.dev>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: "Alan Braithwaite via GitGitGadget" <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, jonathantanmy@google.com,
 me@ttaylorr.com
Message-Id: <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
In-Reply-To: <xmqq342i12ky.fsf@gitster.g>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im> <xmqq342i12ky.fsf@gitster.g>
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Patrick, Peff, Junio =E2=80=94 thanks for taking the time to look at
this.

Patrick wrote:
> I'm not sure that we should make blob size limiting the
> default.

To clarify =E2=80=94 this is a user-opt-in config, not a default. You
would only get partial clone behavior if you explicitly set
fetch.blobSizeLimit in your gitconfig.

Peff wrote:
> We actually can do blob:limit filters with bitmaps. See
> 84243da129 (pack-bitmap: implement BLOB_LIMIT filtering,
> 2020-02-14).

Good to know. I'm not positive, but my understanding is that
this patch only touches client code, and the server sees an
identical request to what `git clone --filter=3Dblob:limit=3D1m`
already sends today. If that's correct, anyone can already
impose that cost =E2=80=94 this patch just makes it easier to opt in.

> All that said, I'd be wary of turning on partial clones like
> this by default.

That's fair. I'm not attached to getting this merged =E2=80=94 it was
more exploratory to start a discussion.

Junio wrote:
> As to this extra variable, it can already be done with
> existing remote.*.partialCloneFilter, it seems, so I do not
> know why we want to add it.

I may not understand the config as well as you do, but my
reading is that remote.*.partialCloneFilter requires a specific
remote name and only takes effect on subsequent fetches from an
already-registered promisor remote =E2=80=94 not the initial clone. You
would also need remote.origin.promisor=3Dtrue set globally, which
seems odd. If I'm understanding correctly, there is currently
no way to say "all new clones should use a blob size filter"
via config alone. But please correct me if I'm wrong.

Separately =E2=80=94 is my understanding correct that partial clone
with blob:limit works today without server-side changes,
assuming uploadpack.allowFilter is enabled? If so, I'm happy
to maintain this as a local client patch for my own workflow.

Thanks again,
Alan


On Mon, Mar 2, 2026, at 10:57, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> I'm not sure that we should make blob size limiting the default. The
>> problem with specifying a limit is that this is comparatively expensi=
ve
>> to compute on the server side: we have to look up each blob so that we
>> can determine its size. Unfortunately, such requests cannot (currentl=
y)
>> be optimized via for example bitmaps, or any other cache that we have.
>> ...
>> Another question to consider: is it really sensible to set this setti=
ng
>> globally? It is very much dependent on the forge that you're connecti=
ng
>> to, as forges may not even allow object filters at all, or only a sub=
set
>> of them.
>
> Both are good questions, but to affect "clone" you'd need either
> "git -c that.variable=3Dsetting clone" or have it in ~/.gitconfig no?
>
> As to this extra variable, it can already be done with existing
> remote.*.partialCloneFilter, it seems, so I do not know why we want
> to add it.
