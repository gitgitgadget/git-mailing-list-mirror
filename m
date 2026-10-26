Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011967;
	b=knsgczdstY71rDK7vWQxx7vcQFqqnJ6uUjyqvYP1aPYYIYn2LDq1rr60wtwZmbc6jNi+
	 enzzgGRIM8QJcdrbUqv3I/2/5mTpWM3jsIr86as+GdnMvmv+mCn90HMMpeGDXNg0WMRHg
	 sZbBZ3FAAQFFTBd9HHaexvYa4pWDukIFAgwH4w0Sfiy976yFaEi91jUJG7VoEz7ZSpdyZ
	 EXRumwbS+pmJCbWaZLiTbiEf8pEMN+bj3S6S0TkriXXlsDmLDBcIBiEtNurd74Xl/nsxs
	 AaKCXkcc9pCy9y7LfYDlErZC0sP4TrbhHiZe5ETnyQbMGzvZWgjugUGEHlPh7pVSIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011967;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+8moHfuJ0QDcNSImVr3l6cvEcJo6MGAi9p7OfjFNN0Q=;
	b=K9ObELfMU/aSqMW35qgljwixK2MEK9BwlSrR3lq9J/6m7VmJd3tmWPpDsQ6ukEcZGALJ
	 tyEF/Ht7YZBG1nlshoN+E3FPfFHB6bhwegiv7NWKPnbq5sRJG/v1A/+Q/aKfB0vTuBQTK
	 WKHpeJHwsQzfajEMH4fsKN8p4ZV9rk3POKHo5bTWvfh5/yYXC4fZWsqZr0Ec6trpftJKr
	 ig9R9Bcn+XotPxs44U4pgVU/jRy55RVaaRoQmMmqGz2OHyNoV2BBo6T6/oSTrMTxtO4mU
	 jdw3TXY0Txy1RTX+J0m9ibPGnnDJHRSjFiklbLdPKEqaoSUALc5T/faVpJZdKLs20nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jDX+9e2W;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HCWYTa8q;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA5606A32C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BA5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jDX+9e2W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HCWYTa8q
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D079E7A01DB
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:52:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 26 Oct 2026 06:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793011965; x=1793098365; bh=+8moHfuJ0Q
	DcNSImVr3l6cvEcJo6MGAi9p7OfjFNN0Q=; b=jDX+9e2Wi44t/1zI3MVtXzNWUv
	M6c02tbimilDbYMEf+5QVdJcXCVKF/UI10cZVjsTg28aXYAaQmLOM0/ZYvy6l2zK
	rvIJziiLdaEN97LcbX1kodlqcZun05/Qz8IjMM5iiYIaCriVValmyHYH46KzwQqy
	oQjQtPNnHJsj3KafzIOXCyUjohjz8EAHnUm5PWQScXENHz0K/mNL9mHCgPJeV+qX
	Tm4XIYDB3Oilxm9sIQjZYKo+R5z3Xt89AT6Arz+NquqRN6EubnNLCORB/47ZLUBH
	59yvAMa5RM15NQMbHxtAaR00PRpA5TvUlLY+sYpg5Zx4Eldm86QQf8C9bnrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793011965; x=1793098365; bh=+8moHfuJ0QDcNSImVr3l6cvEcJo6MGAi9p7
	OfjFNN0Q=; b=HCWYTa8qNx3y/XPCMisFaczTensor3pHhJ6IyE+XaeqGxjIAsLW
	DFgEoRv6kXMq9bQdSJysW4bFWixExFDi4sepuclKd8U3J/q45wC/2Gc1+prdIxGW
	/WUyQrn4kgRh+yhhFGakmu+qqoYT+otZTT2jeW7/eyAu8NJmROrcszrSihTWhZH2
	xN7KytFkdakOqyPEQUxfmfoZ/hNdTAX+HcY30E/+XfuC72yLitRq5u4zNRufbFfD
	WyLGcV9HsXYTkvK2uIz95XxwePGxTJE77WEK60Z25r9pWzgLvvYoovwRRDJnzE/0
	7yhot4VwCRL3LMjowcX3quWhKUaI1JBTAqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793011965; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cMNwN7ppFFTCOksaGgnKjhujtsAY+tlUYxJWD9YbNOeqjf2
	PgLzmFBsSCciFJbpJiFIJhhXCc70ECzJ1w6j1p1s9ojZcOOGuLsIJRYb9r8FM3ce
	0J2KOpfOGdNErokr36TxOJ8qePxN1NBOrwAKB+u4SpyJ1T9QKy0BoA3Bzx8tlp3s
	fsIuVSYlfOKI6xAOfSLJ9SbQRTXC4+TX4KkR5yc/nqPNLFPf8SrazCugh2odyEbK
	z3jTTd0r3flph4/XQF/pKVaTRZZXEGL9hpc2zU/64fZlAaojnRvQw5W4woEnXM7q
	qK/5Mx8ukCSrl+ACWcItwlBE5DCb+0yb05/K+NQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KvEcJKGSyVgTGNU7yEPqIvoIHTijgKi6+NnulCYQRPs=:wtIBXeK7LfCYoTbhF6rqdWO7F3WhZh+tZL/MPw0mY80=;
X-ME-Sender: <xms:_TDfaiSfh7FL5st0xX7FyABezc_qZug4W4XWk0O8HzTY07aZiqBaKg>
    <xme:_TDfardbWlSxWb8C7ASOYRjBj-RW2rbxiaLTGPFVOCnTZPe4pW79lpEW4nU_cM5Ya
    RE_jAKEIHwRb0sQ2nYMew-ZiFLbkQBibnp2XmMd29DpDBCrdnItpw>
X-ME-Received: <xmr:_TDfaprRVqCv5E-E7MfQH7W60QOCcDfXLF6ZV_14qD_FBcSTQLEd0g>
X-ME-Proxy-Cause: dmFkZTFP7UwqhRbw4wzOmsoL1uZwjazIQVVcXH5m4jkqoeSXK7f7qUqPXgJ/UhGbLGYZHH
    dHsLbBQb22JXmwZliJmJrBBFwPqUpJzPtkWhQj9cM2WgoYY/J2aZzPxO9mOOQAJnysUD1n
    QRSt8JbqmA6KNYYGhUhVADo8boB1B/xBRDo0wH2xVT7FsMZs20yu+k/ixOaMQTix00qs79
    S/OYUw4IJzwjsqIAY4Rx73rpqEnlHzHRJY7LMSkhCBGXVsGxdNsN/f8+Yms3lc1U9Imszs
    ns9qW3VgETbVDKwgM7dG5+p4mQgORUsNAwn4PSfR4SMlS0dtE32dbH9mA/MBs+PnAtRbtH
    vlxSRZlCbY/2YXIexTAm7ALDXfSOEKlkvQn3htJSmQDY7wlqQim4HVsMFqvSnk2L4j9HYM
    PjSIqqRPpFpBabVen7iVlPjEVulHdh3lXduVF+E4KChJD5RFPh8DyG1oKm3dEVA3WUpV7g
    S9hCOKmyiljLYdycb0Mog1e1i+nZ0bNJGT3KNLe6DOwvHRsz3wx+2M3UKu6TfGgpshgK3n
    rjGLC5xa67SU1WnbL/eoq2D0SM/dtVO0UNjZ6dtJ3RKdsisaMgiBtlYDlAHzfhSJmoaZbR
    uIcgVgnvd9dqS8yqprUPKZCDisL06HbLNsVjw+GFB8yXcZcHv1ubd2eD2eew
X-ME-Proxy: <xmx:_TDfak8KLe_lipTSzZoWfEEErl7mLUr35nl4AVEyGS4mrXPEoldjaQ>
    <xmx:_TDfatcsurYBcofBcypjnkSf4VHwMGH_SYgdaPano78pUX_51W4njQ>
    <xmx:_TDfamJg8mgb0Nvp1WQSYxB3JFprFYwWwNDk10JjG2m5cauxrD0CFg>
    <xmx:_TDfaliMK1aaTwDvM5B34xJuVdCQqJyi_pTcXCJ9aO0-1hA5F1D92A>
    <xmx:_TDfalcape9E5mh6bg4VH_Erp1-AbJd1oDI096GMClUSvbCbhy5Pb2DG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 06:52:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8bc30afc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 10:52:41 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:52:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] diffcore-rename: stop using the_repository
Message-ID: <at8w9u6qA1dhmw3r@pks.im>
References: <20261024221341.92086-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024221341.92086-1-okhuomonajayi54@gmail.com>

On Sat, Oct 24, 2026 at 11:13:41PM +0100, Okhuomon Ajayi wrote:
> diffcore_rename_extended() already has the repository through
> options. Use its hash algorithm when checking for empty blobs,
> and pass it to start_delayed_progress().
> 
> Remove the USE_THE_REPOSITORY_VARIABLE definition.

All of the conversions are trivial, and we already dereference
`options->repo` unconditionally in this function. So the patch looks
trivially correct to me, nice!

Patrick
