Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687555;
	b=pIwYThEYrlbHUrJVXeQKjn2qwkN4oVjX8C/+GltDVWcOicz1BwM1PvAWMTTbxFWJ0JtI
	 fPWd7tQ2TRdDeaGoDh0VRPyUS/PTPW+rn93CWZafyDbVfkvXdLb0DnqRKWNhZMGfPUzh9
	 h3jaZM3odyQQLa8Wd5vBPMgrzhk55ppWytzUnCF5P90vFA4zJpjwq4yz8AaqNDDh39nMO
	 1jNm7XTmSX1GyYocOEJJgPsL7E4Z2mS1FLpnp6iontFzszB8M7x7PvW+nY1WgLrv5BGA7
	 5c9QwHjEAcrNxbE6alO1ii6+4CNNdFymfcHTXy1TOIx7QErcubL0lLU9/gVACnnOlBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687555;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/sBKCuy+rreZBjlrwptiCT00v8QnTfVubyFlleuZ3mk=;
	b=vk8miWhjWBQDmwWcHFVILZzHeDtrejB/a0hhhq7wyg4HH9/yzfFi2+7A9r7iMZDx6Es1
	 +Be/qyS6dK80o5BAIQkZpqAr9F8QCmZCyBy0ezm1w4ePsWz7O6lskmk02ezKF0ZhzkwXk
	 J6rVeIG/LxphM3X/onxjhQPKHDE492Giqo5itS57tr5gjAlxRmGOdeIP6cMfegpta+jzX
	 tQF5lt5Aa72RcIUGoZDReaorGjfGViv47Lfjy4Id6vrNKayT231kM+pGFrn5lztW2PU8w
	 cZ1I/LJYZmlZ/GWZpgh67oSPfWZxSVs91D5FxM5ewD28h5Z0U3zBGAGkUA+rNG0LNqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h6c+4kv4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KDdpkqVh;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822F606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A822F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h6c+4kv4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=KDdpkqVh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15D727A01CF
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:45:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 12:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792687553; x=1792773953; bh=/sBKCuy+rr
	eZBjlrwptiCT00v8QnTfVubyFlleuZ3mk=; b=h6c+4kv4Jhm6CL59/mcGE7Xo7F
	RYPze0ev5vf+hCVIy2T7MX0skdAMjPqx/Djs6K3XyVv4RafrTIjcUYguaTaQER1b
	uo8ZS9vpDpsgnB8YYmvt3D1mUbzVo0SZ9ubOT9ATIDYw7igb1EW7cF59IlhZZQlD
	wwsUsyoUGsbI+VPZrovz/6KvnJRMQRu1Gp6VUDSz1yxPld5Nu6HIh4VBwF+NO/J1
	djvy2J+pX3cDfDKSfmNsXfF9NKPV/rrmtP/8iI5GABaU4Lyn8hPlH3w7Ha8QXgCD
	XXTX5H3RcVbTcBtacNOD8n3XJptu9Ou1EHVtHDiknTteoETHl87CpA/M2Gtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792687553; x=1792773953; bh=/sBKCuy+rreZBjlrwptiCT00v8QnTfVubyF
	lleuZ3mk=; b=KDdpkqVhf4JXZTXPHXwEjtchLIFFs3aEH1K8Li0iuzr6nz4HL5s
	eSDHxqiDiTkYQK55z5GRXb/zvnqkGu/Jtlu01RM8OOW1fdEPsWHrsPaHHBugmns6
	zQ0qqM7LkEyzV6ae79wpwxbo403Dj2J327JkMoOn/v/4hfcxGlSrZbOUK0dB1dP5
	K9T3zUmSlREu7Nw3uyKlQSsAkGTGvgiepaRm3nSbAQDjF2T5nd7gLx5vCE1X/edi
	WsmJfjac4yrv3CI909+EUkvALMS1r6Ft8NnXhVSVo1Z3E+FzlcpJ5zF8eaM1Hbri
	SJB3KnirTIFxd/nBn2kMmb0p7wX1ysMiKpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792687553; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fQX+4fnlqSj3k7mOJMRkJKV79UqwK9GEahsvtcfyzT6B2w1
	bFStJtdRMOjW/Qg87ePJ4KM5sXSyrDiaoghzZufKN703WN9TBBb1ZvV970JMKSoe
	+SkJBcBayOngasxmSq2e6+HYo/L2UYo1bmQmWcJeDSFAAbaW/i0QZIcgZtnE4+GZ
	f1pwmlAhNfdQYyMiVHq9Jrz3PZ0dl4vax47jYVfsjGgg11U8bK5nM7vpBgOiyRfC
	D/cHCCGNyygfi3vtQws2TrRFPynpaLQgJt9IWnaBcztAGRaioCNMg0lmLUEgiHUu
	d5q52moF7UritYCbvQ5W8iAj4m6/Os7aR0+arwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Ba/6QXGooRXlgGVPHnH/B10Wyw3SszhLmBCxC0Cfy+Y=:F1d8Za7Yiyh54RaVBhe6wHVzc4YH2jIhFdWalRtTdTU=;
X-ME-Sender: <xms:wT3aaikJwG-TGLiTotXkaTTXWP4YO-7eoM2B0NyAfY2wEp-smPS4zA>
    <xme:wT3aarXma6JmJrx-WLvpcdcrj5i03dVvA0JoNiUZ6kPXzeKRHYfFjZKViLqrrS-WG
    GfmRu5C4NBqB91UTXqe0XlwyIf1uA2ucCnJ0nagTiY-ifgZk4XP8L8>
X-ME-Received: <xmr:wT3aaguWKfNjPAF8_dYGBP7nuT71NbRo-FUgah-lrAZ214n14cyw10Wjf-KtdqipIiyhKfrd9Fs5gSGsc2LIF4fLOAP3X8bvD0Ee>
X-ME-Proxy-Cause: dmFkZTEAHexaCw1epD1CqTtV2mnLGjQu2NbsI3QcXe9lxeDGrkm6G77zRHatMaBOVJKBFV
    IFvgODEdWKlllsnhPn4rxMWahm1wnN/ASBnE8/A45UZzcgYHg7qOqRJzm4fgoWsa/G949A
    8e/GjsaoNEE8H8iCY+oThfToiZRYW7vBXcMpo3XtVRi3GsXzZEzVO6YMfDiR5+HN9+0dYl
    tleqP9QCdBAc8o65BdUIaQ5NjL9WS6n1QhUe7uiiVXT7TfPaS5lF9x+V9lqOS5LTJb8yY1
    MbEFJvw7vG15j7dYGhDxFJtksPUaq/4KUw1vF6zN7M/kK17q6gP8iUd8+axS2gLSMgXFdh
    iOLHiJP9MELgD0ceZvvzCNtcMzOfX5ivV/Y/jNkOD2ajxSo3jaVH0zlLLnPN+LtgLsh7Bw
    uj4JQjmLwkg3r1+XvddvLhl7o7+flhNt4E08NVyL9VNX305Qq0+R4fZ8kxoM7sUpwkViGJ
    yvxaM20sYQRLh9w6GaTIC6gy/MoAH0g2Z7mAEURNQJTlKjuA868Ihi+CXoIfgj7pC7/ooG
    BGN2bSH7X/qCRfNlCb6fvIKAQ7XRCle8dHnHwqpu4vOGxvofLfUOBkAt64IlROMCL7AAOZ
    B1MuOkbiKQF8m9E8IUkE2iiKcUr89msgSomstYhI2ZbZTrQlNcNwpZIU1MAg
X-ME-Proxy: <xmx:wT3aamYeo8W7X3Et4GUuE_qom3Ue9Whym9mE930z4WJIf-hZMJHGfw>
    <xmx:wT3aanXdBITaSxcRY839N4xBf6L8t4jQyBV9Z6jtHZqu6iSZL8tO7Q>
    <xmx:wT3aajSqVirxtNgUolLJY4XXu3MjCsLxzRmTwORBS6SzjTy5z9B8IA>
    <xmx:wT3aatOKhCxlveba1BaGdz2z96lFKVsu4_qtSVhcePx2EIlWPWczeA>
    <xmx:wT3aanpWvbR_B33C1uA-yc25-9oPhmqUtDQcSrKAcVc8UInXD_DmHf-t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:45:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian =?utf-8?Q?No=C3=A9?= Ramos =?utf-8?Q?L=C3=B3pez?=
 <chris@nortesoftware.dev>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] doc: gpg: say which date SSH key lifetimes are checked
 against
In-Reply-To: <atmsSIJrFhA0t1rH@pks.im> (Patrick Steinhardt's message of "Thu,
	22 Oct 2026 08:25:12 +0200")
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
	<20261021030347.565306-1-chris@nortesoftware.dev>
	<xmqqqzhior8t.fsf@gitster.g> <atmsSIJrFhA0t1rH@pks.im>
Date: Thu, 22 Oct 2026 09:45:51 -0700
Message-ID: <xmqq1p9hiszk.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> I think explicitly pointing out that the timestamp is under control by
> the signer would be useful context though. It's implicit to us, but it
> may not be implicit to everyone else. So maybe something like this?
>
>      Since OpensSSH 8.8 this file allows specifying a key lifetime using
>      valid-after & valid-before options. Git validates the signature by
>      checking the committer or tagger timestamp is within the validity
>      time range.  This does not provide any security guarantees as the
>      timestamp can be chosen arbitrarily by the signer.  But it allows
>      users to change a signing key without invalidating all previously
>      made signatures.

Sounds sensible.  Thanks.
