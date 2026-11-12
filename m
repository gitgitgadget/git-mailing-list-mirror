Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515391;
	b=kqAlUmUyB8dMi7DTOfV90IMDwdLa3YjwrLuEWiVxJZpJ67E5XdTCLf2fGeXrC8FQu5ZE
	 KtlTyBhkLHgmzFqIeb48ep6gPBfxR3M52NulgTwWp8XX7z2QeA+zBB+dV/nBgDrd4zFf3
	 pB5ZPSLolhiyl4LLyVIo03S9dwIm8ANi6A0BWj29rote9uahOlFGSQE/61Qp/YU0fDN3V
	 9m9QK952IFzT5W+GobKp6sUbAzCkPA99dAIaf4sgiNcwUyIuJfVae/CyDK85yt+55ZtOZ
	 zTbOjN+/Tg5ujp5HYGyeFIe8UTCBpUmo1Yclyxb/rh8sPdMvIfTsI4oDRiM6PyAgE6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515391;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kdKkmX3Ii1JnrWbxrQpsSkCYDYlHie64EuHYj4mgazc=;
	b=O89++6+A97XBTgOSEkaEGDtkQ49Gcc47jFsNIfOmLV1ea6tnbTCLRi9ZYgRJzOUpDJaP
	 sFSituYzRPixnbsXDbhBsAYSGEVG5mq2dmfYJd71NIPdj2eULt3hWx5gqSNdw7YY/kP1f
	 ra1c7vSkxCrrd5aNRnqL0O3hZyEQ2g4kYFumTJ+27aAH5KyuwNo7QhMZGnBM7gwDYfxzW
	 T/dXQr0xDEUxVEIv1EVHaEFK1+iPKBcjZzI4MnjRYuxxLJM8w/o6gtCvx3dXctb9g0Jw/
	 8heGYYInSB4TU2CR08I8rQmOpsgidGj1QOxkrcytme29uuFddtih1GhaGsCY/SxcrpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KqsYrkFf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=djqeoD2v;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759BE606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 20:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 759BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KqsYrkFf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=djqeoD2v
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2E517A0634
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:29:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 15:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794515390; x=1794601790; bh=kdKkmX3Ii1
	JnrWbxrQpsSkCYDYlHie64EuHYj4mgazc=; b=KqsYrkFfNXOkYXmL7gM/UzLa2L
	Etk/MvFYflZqAKPth0IoZm+I75XUyQPyt4dgwobhGsHsmksBah9MUEQLDnVabWAH
	uD+q85SCANQqLqm5puEZ74kWZ4uH37vNnHZ6Uulwzd80/Es2pi9VHf88UHYBOrwD
	3+61FXvcMDsaSnxJFqbuw+z5/4pU6uv1BgkUoC+Z3GLedzv4NA94r5k758yxmXrV
	9pTHvx3xxqZEqML9wGpvvwYnoMz9OeBjLhERV8j9v9+K8eqnf41X9UyVD1KGfw/X
	F8rF85oamnbw04mn8RSfud0T1KQ93SOz/N/Aa3+CBOGf2vTKlCclzN2gnhhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794515390; x=1794601790; bh=kdKkmX3Ii1JnrWbxrQpsSkCYDYlHie64EuH
	Yj4mgazc=; b=djqeoD2vkgY5M7MGoZudSoziuWNjoLZacNc8LQhrEvixLfzuYiN
	1CBSlT5yKdhMeKgwUX389FuP7hAEjJS9+JM+x8qjVpkZMBETRb4n4aFj8Ud++iwU
	0n7Lin+7X5D5UULo20N1URe8kdYZ+Amk43WIaFnB9xIm1YrWIEKXkqrxz81WNc2X
	am+hOIKkmG45qlNxSV0QOCsGwXba8FZxHoRmVkZ3ccr0bFs9sOpdURqdphpDARIT
	gVVHQiokQvVPavq+oRqz5OonkBWqkR7EOMhskYrc+aT2mecL0gkdNvG5oSG5cBLV
	MI/abdlY6lkDnvfZXYjMuikaif8E9v1P91g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794515390; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kYasCClbH0PLUZI8LVQKc+q4pte4VHxx8rcuH+RtVePe4vD
	M4GiD/nrmI4W6LWIbP91fwP/YcB7iVUQp3i8yH8XtZz86H+WbYQEujdW+SbKq7uY
	IyYw1AvdaNGu1QkiBv9i21yQOw7A0Y2kYCONmj1EmO8xby/ObDsn9Jv0bvKFL8TA
	Bejf+7R8jMyVThwCF0gSUR7ReiDysslslbI2pE3mrL0026flqFZvjR9aYyhZwqzl
	EZXPKjR2aCfTLoEQA8IzEjsqcn222qAAL/ti0lt6UccUjSUUz5MtI1a7OIg+fX8O
	NfymeYgcUW+aqUzH4CMiWJMXsHpeeZHES5PgUnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:e0ATB5D+WBKpfpnsrlZ8J0z9KySa1p3k72/0+08I5tk=:aZW7/oyXXtNjtxboOlInsS27C29AEteVQvEvZ0YLCPw=;
X-ME-Sender: <xms:viH2anKQjpKr1EPyZ2MIjPNh5dj5rUVhLAHI5vmwALH1CuJL_xD2Rw>
    <xme:viH2au0tA3nJBlfzUhBqnacRupEoTTmAYxWfUZcFPa8p0uM7PYjaKFiCjCluTr8vz
    Lxyly7zzxy_botd44UxD5N0PTV5YbByy50C3AtF4_9M_Iftc8fqAw>
X-ME-Received: <xmr:viH2apjW3IbSQoTcBBNXKlGOx5lodKlYIqlQeJBFRhL53bKgT-2yifc4HHqEtz7Ox-e7Aqv25CfrkhImv-CTCuBn2U9PZOEMs4xc>
X-ME-Proxy-Cause: dmFkZTGoZyr3p85IrIrv8gNo02SnznDSaoyGmPwGNM20fIAuvBnKsgdPVrX/H4G1hFg2nv
    FgRxcRCZzLdPF2xrt2riiwk2gECZNVJ6El1jU6B6D8nnzdtAqoWXxloaS+M4XVi3XUDXd2
    0T6VuEkXWQD6aGyfV27QwcSMTw+8KCwz4SziMz7Wr9UFH+UOJ145ru2p20JunYooqS28kH
    t/EKXTV17BZhGLDYjSX8Eonr9Zz3HsUnhus3KkDOfhWQC472GMtPAcsAEJVQ+nlZ9uqvbz
    37JPu86DPthAk9mfezA03psXJzkjP3piNVUkEpxTKLoWCejczWouFkcsTYcMjPjFXPFtfz
    ayXakn74BzgebRzsWdHHXxD2Kn37GNks1hMuAs18A9X1nvENsqjT3L26cnBRqljFNgX8xL
    z1et6Yi8lXmM1UdMPS4mHh+RP3k8ORP7OGOJlmgEdtFUqUjWdYGwTEkM3GEMm79Dnbde15
    kd1bQJdIVIdLmjScWVx24vDiwiR8c/XGIF5z0goKz+YyNab+A3w4aVNBlmM7NoHkWtnDoj
    oCCrMxs2VGEHNZBP2Xuu3HsG3n9NOeVkcPXaQCvPFUOsCdbgM9kDjlc6ZgD+4HKrJ18zbO
    7XqpeFqaj1UMFg51NJEfQdC3T55ZN68Gn+WMKC2rzsc4c1+2hTXMlIolys7g
X-ME-Proxy: <xmx:viH2anVe4VxhItfO4crCr-qLiFF1u-rDnjRWMlezMRiPwtlczVvCPA>
    <xmx:viH2agUlJPcuFyfXWn0ZShNyaK4vkAqwbqsz4bPxo3Iqk7WJwOhQpg>
    <xmx:viH2avhfcrk83At5NzlTrW4WmctegKsxETDecrf76t9qOTOVQyGp0Q>
    <xmx:viH2ajYjlE72PSTw2pGIVVYyCyVDbCSvL9KGjFzH_04dy-WZET-NNg>
    <xmx:viH2aq4YacLNHyhLZ_HGm2fO28xg_4G854gOZej2HKn9H-UGzCpyqbRh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:29:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Mustafa Bayar via B4 Relay <devnull+mbayar.gitlab.com@kernel.org>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Mustafa Bayar
 <mbayar@gitlab.com>
Subject: Re: [PATCH] ref-filter: fix double free when an object is missing
In-Reply-To: <CAOLa=ZQuT5+x-Rvxcv1CSYka3aGG2nV_hPFRDTYJEGgjbLhJwA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 12 Nov 2026 08:44:30 -0500")
References: <20261112-mb-ref-filter-missing-object-double-free-maint-v1-1-d6d56a3c8dbe@gitlab.com>
	<CAOLa=ZQuT5+x-Rvxcv1CSYka3aGG2nV_hPFRDTYJEGgjbLhJwA@mail.gmail.com>
Date: Thu, 12 Nov 2026 12:29:48 -0800
Message-ID: <xmqqqzgphjyb.fsf@gitster.g>
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

Karthik Nayak <karthik.188@gmail.com> writes:

>> Similar to `maybe_object`, reset `content` at the start of get_object().
>> Add a regression test that exercises this path.
>
> I had only reviewed this patch internally and we did some iterations
> there [1], so mostly just rubber-stamping here that it looks good to me.
>
> Thanks for working on this!


I take the above with "only" -> "already".  Thanks for writing and
reviewing.

Will queue and mark the topic ready for 'next'.  The patch is very
well written, together with historical reference and all.

Thanks.

