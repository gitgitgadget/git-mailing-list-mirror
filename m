Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176407;
	b=WTUGkJ/BjGwRobxtOpEUlzFrNhXsLVAb3MTdF7KKPpQgzD4KzRq8BOUsds1w4H564fqm
	 G+TUvdYpmoULdQIn1ACpiNzlf5xjNTTGuoSprwIeywA2QIzn+S87uHo+V7rsQr71tI2Az
	 lJO8Bg0KV0PVyhZQbH0sjl73MGrh3wv0w/xxBcyyBDIAMq9RR5Kh6nwUFi3OHndcN+8ZU
	 QNzGa/F0Jwm9jOxCJq1vUC9vOAhW8xnRRySCe4agAPPb/3Flr7yt7qmz/uDKh+fK7mkoa
	 8CMONJ+AUCxBOaX27wj51jNY05xCDGP8FrQgqCF3kD1rFPc9Qm9RakVvIGCgMhkG6Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176407;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AI8hHmSTyvSjHnYCRommbKP5PZ6lSX5n3LZM9wbE39E=;
	b=xDuQ8ilZNMIiPdLR0qZVucWUR2nvL3Ifjv+R2fGL5nCF+7OcyqX0+p3CChRBDA8T9eyX
	 kkR6EGE55rGolZXagoA8TfckDt810QoGLSUg6hq8y92Lyefq54XiNpev0i1ahMo9yQHKs
	 6BJX2bweUtNeaJAFM6UeCaNc7ZWxVR6XJgSQS1NlYxHYIvcB0vbRC31EbqGl2bp4xteIn
	 N3aAYhs8aWiu2X3sw0Dw6zKFFj1qkoFQELMxS0yGxA3xW7JGmgNyyq60ZvpgU6wW3eSlT
	 bkGimrMOWwYTzywZStKgXK2IPfX2OeyRZTFHDQkDoyMoYVLmGRynqVZ+turYJcKJ5SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ee0nJVjH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="pj/yLJZ9";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0343606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0343606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Ee0nJVjH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pj/yLJZ9
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EF191D0018A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:33:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793176405; x=1793262805; bh=AI8hHmSTyv
	SjHnYCRommbKP5PZ6lSX5n3LZM9wbE39E=; b=Ee0nJVjHBfllWil6/ddV9mbF2Z
	CUDf7gu7qJ7AWtdD48HczVXGfBXu0mKEVolKYM8LaRIQsMrEniCbOG5iiz0eA2Dx
	cUogGXSO5WWOywMygSWGDOTSHMA3HaDPnunxx25KEOCKmPZYkEYFs0BCBhkLGRDM
	fX/iwTEtLKwrNM6bvlwb0j9MJpnO9XlDuVrGznyosJ0sKvpN/0ABQ1RjkqYTL7I8
	r+3k0ZqAORCLxkBHpg+/HvdtTJafV8Y2UuHTw6vJBxc8Ys9EG+ia6zlwch/uUHVC
	6eU5gMtgwKjNOw9gjM0sK7g9NgO5sFn5O5AicVkRtBQJKQnmu22Iprr0n3hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793176405; x=1793262805; bh=AI8hHmSTyvSjHnYCRommbKP5PZ6lSX5n3LZ
	M9wbE39E=; b=pj/yLJZ9rzRrxomHM53/FErbNY7Rbg42XuCPLJXm/Ax89+Ax9lC
	zAv2Dp6nFsSpXA/tqTILRNmZgofYuzkdr/ojmyrFOmc3bTiBYGcq2l+P5FJfgJ9s
	V015sJAEET9cprS0OUFx0Di5nyeTvm2b1DHMUbmBP34Q09qKNNe7ziZ4ErZMjRwa
	EFaMRyHsFgPGfVoZ1DOb/uFa8xZnIF4BC3hshKdtTZHFwQjrxwV0kfjCi17TVCZi
	Bb2zBonXbxN0nNIA9A2MMNKtiU4pXMJjogHEkBKWKSbsIma9tizbXVvafv3Niuu9
	icDtWeCWecWaLfNbY9HacNLpCzlvkY3csVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793176405; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UGlX+HBL1gEKJqIgZoz9DhiOG2YvGIrzZ5Ic26v7jurLF1P
	6PlS1xZWB5mSd/fDrk9I6nKfG40oINmTEQszCvownxV8FJXCYREmdhI9Djtnjruq
	Pl1xynRA12DydyG0AMhCETc47xPcv2QowfE4clgiI7lNzlbJgfEfzoD4U0QettiS
	FEHxatK05Vh+v6VYRITmJN3Gz0cme94fksuLweKEQBIsZ/9VFvt2jcx0RSPi/XxW
	Ub2CNZgC3vvP7iTfbGzFuGofheCX2k/MkH7UsI0iz3xRbQnm1s1hvkPKdb2UdFsa
	FFNGMD5ARgelC3/CZWWRzSYnrKwvLVJZg82PM0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cnkPnb7q0927D6PEfxdfeCxeMZ+UwWho5wUep8o6OUs=:Ctl+iULjWbZcmi6zBMQ4SFTmttPgL1glXfE/OkIKibY=;
X-ME-Sender: <xms:VbPharohty-DjwLXp5n4fY5QVR8dOuQot1-5SUA1ss-kXnZwK5yUrQ>
    <xme:VbPharoXUhXE66Cg5PJpZ0aCH2q3NIbMjWRDHvdsH0g_T82aWzHcpxSOe9MxPAHPn
    XQ--I_PCC_29loqEnRprhWosiWDvXwMsFoTnXkO3vOHHZKotYGhgg>
X-ME-Received: <xmr:VbPhal0sBjV3YYAPn31mAqlg3SZ-TZ83Fd0H927uHwAf0NPybKBmnw>
X-ME-Proxy-Cause: dmFkZTGJzd3hm9Y6ShJ20CJO9s2IFHLHydvFGQbZsYmPVidbUX1cwgBUpKSHx9hPkgo3VM
    dZYHttLi2etAGwq93H9tpbX3SWuLZp4mtN3+I001tBCmN4/Y+PUfh8abDWsfCozLlgrrw6
    fiRoM/hPXS/HDN73PwyCh/D2VaXXVS4viykcKdNaze0m7gW00BM2f954XyP9NtxwHTZtPt
    3kIMKPpEAgd7OoQmNtKH0TC/hJqYDasLHtHmEPDsUMKWZHYf2/HOkKCiWGCbW44rt/o5H7
    XhM5mtMn+uTzafUNVzydsA7qSE7IT1VhhM6vaefxKwBwRn4DTxvyGUMf85QloUU0xWt9sH
    0LiTX0vEDF4tGmkeZYfhgCrFQZcY1bHlOyEyx5LHSfrhxMGCuziCm55G+s3jZ8poBzVrEw
    kWIbGZrWYEXTCvO/WiYgG4xZ5AQWz+oIszk5u8aukyF4jTrh8sgcfPu4XtURU9VoFTV0NY
    lR5Ux317o+m/5cQ3j7UUCgpukT1WVig7Quvk7LSyP5pH5oxZLcTraFILtEq+dM0PEelsFP
    aCkbC01L+SzknycLL2vucZdljdI8okbA4bvxWY3HUZopHUjp7Ubzm+9Q23WJIZN71L9l8X
    SeITgl2DE9wFbGN3jWgO332VNcLieRukLOheHvSR34Kf9g7SD6im10Yj7EsA
X-ME-Proxy: <xmx:VbPhaqC6EtOrmyGq1o1GN6FX9kmnSgpAzESKQisKv2IRYH1Ss34qCA>
    <xmx:VbPhatez62fG7UVmP9oGpK5U10JiZsHXgFce5eQhr17V04kg7il0nA>
    <xmx:VbPhavinutzfKKaDuN-GCIRSSlUuxAhM9OAlTV92wq50SPGtoWR22A>
    <xmx:VbPhaloHl3L0Lxe984SonEYtKC2qadEIF47a1_Yx_y1ufIfk7vJ9xg>
    <xmx:VbPhavCUcf2w5wOvB8ArvaE0CFsRH6V8iQQ0ECIx5leW6QJJa0oAxtOU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 04:33:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dfbf118a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 08:33:22 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:33:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] rerere: rename `repo_rerere()`
Message-ID: <auGzRmkt6Mk6peSp@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261027-pks-rerere-subcommands-v1-1-d836c36ce0c5@pks.im>
 <xmqqv76mj563.fsf@gitster.g>
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
In-Reply-To: <xmqqv76mj563.fsf@gitster.g>

On Tue, Oct 27, 2026 at 12:48:36PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `repo_rerere()` function is the only function in "rerere.h" that
> > does not have a `rerere_` prefix. And while it does indeed receive a
> > repository as first parameter, that's not a good-enough reason to give
> > it a `repo_` prefix.
> >
> > Rename the function to `rerere_record()` to be consistent with all the
> > other functions.
> 
> I do not think the convention to give "repo_" prefix to variants of
> functions that worked only on the_repository should stay with us
> forever, and losing repo prefix from this function would be an
> excellent first move towards that future.
> 
> I howevr take isseus with the verb "record" in its new name.  What
> the function does is not just record.  It autonomously finds out
> what situation it is in and does the logical next thing, which
> varies.  It resolves when a recorded resolution exist.  it records
> when seeing a particular conflict for the first time.  There was no
> single good verb to express that.  Perhaps "to rerere" or "to
> perform rerere" can be invented as a verb to describe such an
> intelligent operation?

I was picking "record" because that's also what git-rerere(1) says:

  This command assists the developer in this process by recording
  conflicted automerge results and corresponding hand resolve results on
  the initial manual merge, and applying previously recorded hand
  resolutions to their corresponding automerge results.

But I guess your point is valid, as we don't only do that, but also
update merge conflicts locally. I'd pick your "perform" proposal in that
case and rename it to `rerere_perform()` instead. That name is somewhat
vague, but I guess that cannot be helped because it actually does a
bunch of things at once.

I guess that can be helped with documentation though.

Patrick
