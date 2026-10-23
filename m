Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793411;
	b=yLRYOHa+m5xKwyGK7SFlHLwN4842lQA+u5v5LRNrToQH+/2djHPpw/eDkdKgPJbrSOhv
	 OXfaZlqrSmQTBMbDEmF8OO68pcnP6XjeWJW0GuSgJS5JMH4jMY5ZQghLKTCFoomPe+n3H
	 oB0ZSGRl7Pxekt8FL0bo4/muysOprOxOf9iCT0QH4mS9Fy2fU0V2q7IS/Xvdm8V3XcB2u
	 Y+jbbo5fKWQQaJwq+yDDycyh2V86dKiVwkZ239W9+r/bhHXnOjousjH1BvAvDpVRxuK47
	 58IA7yJUhjzRkYYE4MW7zJb3bQs+ZlSEHcAnmQvqw8UOxDlZFZcMgV3OiO1PuCKdz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793411;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZeQ0R+39h5mWEYXH6hHV5MxqRUA0FWHDP+ECauh9ni8=;
	b=XLBhOXe3pWk4e1y3B+wknuClRYOSqv1dzZua3GrOjWrzevdieSaQ2XWLMv1Oekqivatf
	 pFZ8MhaQkzTRmLPGp6SMSrEW2k7QD7tEF1j1shSYm4eohAZLWOSdf4w5PNUPghtIJtYxm
	 vnPrfqCO8RMCfPOAyX2o/WVQ+8SNOhxJEpY3iO8oBYk7CCnGv+HTNQ8vRMSDYWpI0ot2K
	 bPkdluapGjGm5+IgBAKb3W8y74BTZnajVrliFnWity/M+Cj0i6SP+WgS2uzmsaEn4RD3O
	 RO9pT8VUsH2gG9m6R1z3hiumR8jVMYKGvBz5bv611Zak2SNQagiPmUkKT4aTX2CgKgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nUd1oHXZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Me93XfDr;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A30606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A30606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nUd1oHXZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Me93XfDr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 512AD1D0010C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:10:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 18:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792793409; x=1792879809; bh=ZeQ0R+39h5
	mWEYXH6hHV5MxqRUA0FWHDP+ECauh9ni8=; b=nUd1oHXZvphbzMrvVgUEOLg99T
	hDpyx6JcRz7OJmu9zUYxYt9fRspT+yRv/s6LVHJ6IGhjwvIqK5w4XVv0iq1WtB4P
	9fM22h65WLIz/hHt0DInMuJ4Y0+QqNOQRFZu94Zq2erMSrfSCc2mID0q3wA8U65F
	nEaftmWhiMBXIvGNvQ9PitHleMvdyv4SRMTe344pPWg3QD3Y5oLx383BfTMu26bY
	YJ+rd0KOVjr/4U+hzgmcrQgiYkaz/Hw/DlibgJ/zpUkUlrbzTE/oO1Iw+nQFoXxf
	4+3r5f9MtRv7w0V337v/bMsAUGBb0UQrPhgSlO1GvxqDiM9uvpK2RRl7jnuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792793409; x=1792879809; bh=ZeQ0R+39h5mWEYXH6hHV5MxqRUA0FWHDP+E
	Cauh9ni8=; b=Me93XfDrpiHQbGVIEqq5svcaK3st4nqvfpozReG60gIvhgd6fsL
	tmaixN7yWTty3V84oxzJlCWBeNZ4Kdbl1lQ6eI6KsXEcqVVN8s5U5YLhBg5gr47g
	DiHODVHEBlAlxpD+dmzOWkrwEdQP2mJE32nhgIxMbGpsakKNakp60jwdACPbwhE/
	CGC2eR3aZBw4a+SRAFgdLodFhEUBZqKmHvORW7kvF+KQeQ1egDWzs8nHcHg+zB7R
	Ar2zpHhxN2I2Cprn2NFTiH2WPNikUcX3C75WfkGojlvmPfI1bwIc0pG7qMoyu8jq
	fO2ZJuAJy5R8TOpAGuUOeJrzHcAa+g9aFHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792793409; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PgGDJzJERd4mXCDwmSVXbMkTMhNUzhD2SOyvv9WYeaLRQZn
	TAdY91xjHrhoVeoKoANJP/1c7D1FtrEUIIlX2We5DKjyiTW0vtPMtIbqKnKoumIh
	wGGUqOYCosrNj86yWcxgVYTHxgqL27b6G8aiaBS9ZdfWU/3ozlKvctRKGc2+DDDj
	ZZxW1LO4hRZMnE0b6FRFToPOVhvPYGiHJl5FWw6x8hvRigLcZ8U5NXlEZojPggx2
	hvxQtp7jDM9AnqYLaFiOPuRL71c6hEVivWF3UVqSoPUuq70eSKM5BNgZBP/b9g6E
	jbczQT4uvdEWHDPot1V3P8Uf+a/lPGKFHJERdtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JbPTSF6b7WeUVC6duCFHIbcMDFAnOssaeh1wP/aIicM=:kVMAR1ghing4lfn87wCYNoHWKyHqDtofHSfPxzxuzuY=;
X-ME-Sender: <xms:Qdvbaq2Ga91_RseFZyT83ad-Mz9NUljErOGKwtiNFoRTucaLdVoHgQ>
    <xme:QdvbagwHtQYzQDyB14CMNJ1apTcCsveWSxbJE99T1n_R1mkmMsdGjHwh0ojSP5rpZ
    fpy8-7EeohdNiLZ7r-UNmS3LmhkG9UIIXJIMOG0tCosEGK0zHM0BBA>
X-ME-Received: <xmr:QdvbassiPK_6kYujxE-ef8QOQE--8D4-JBr1YqtW34Btog7GrnPhmzhDzHwWZm4x03bey3h9qB5nl8QlPH_SWeT5w2jrW4imbAIK>
X-ME-Proxy-Cause: dmFkZTELqnifsOb/PeRFKu13JdTqZGXB1cN1oTzR8erUSdMnmQmuwl897gKicHUFQw+ClI
    WYOhcvL5fanwPlvTvnqez4qY0ZOC51XRJMkJVEV25Kk0VEODHXFK+jVgr93h10zjEIsauu
    R5ZzOf/KhsqIzRIYmI7+IsFq5RWGJhttrlHMYMjGAxzPGS4Ox9OmStEwuUY73XTuYyi7RN
    5CWqxtKsnn3KiZv4i/oLD18gypK0JvysGPgYW/N8zZ2WXUEW78Wqau/yebYvrkbwKy4/Fc
    MPEP/xPVWGc786qRu6ncjg6PwsScrTU0dZde8M9I+z51LF4zTPWPvLsD1WaGlMbrkkyyVp
    YD6UMqwmJzfzBeBukb+Ais7edaZNTe74xjqH93/5UnAfx+1GT962fF7hM5WNz2z6MNp53t
    3hyYHOiCA98MUiYCVKoJpwBAYPa2sP9FKHArGNlE+o5vLwucvmR8W3EJu38GZ2VIaVqK7M
    FcBYT16ueywT6mSvZYVtujX1qIYrfiLEcldK41OrcSVXuNWLQazMSG/YKXi7o3maAo09Uk
    6SY/frVpN0eqS8qNM4UMKxs2EezeEbQ16vMBrhGfcavdimvsWWVcjpgmlJRJN0oNw4qmKF
    Z9tQc33TO0zEzqgBnLPH8uU5Ju/slOOU3qb5HJjbV7BV0CwMACJABqkeYS1Q
X-ME-Proxy: <xmx:Qdvbaiyi7qR1NZ3qnD6uyeBAIgrBhrFMQJYJZmqFglZ76OTaAHNz6w>
    <xmx:QdvbavBjVK47hg3Q70HawtvszYA7AIZo64AvXyQoz5-c6UmJwKkYVg>
    <xmx:QdvbagdMKNx_zpmPbIsjDkxHTlWn8dbRsAY5agdElwNX8Fn4ClMvAw>
    <xmx:Qdvbapkf8yctR0PTUNMfX5lTGN9Xwfs3FC81pGUVW2S04tjOyPEKKg>
    <xmx:QdvbavXuEtiiw8bUbIFTxwNwUgKzU5Ldyq-yMk6PGipgQ-3bpHrvVKgy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 18:10:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push
 branch by default
In-Reply-To: <CAHwyqnVMgAhyHrevXOJ0sBKkaPPzSmCcCPSSeqm6dm-MRX65cQ@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 23 Oct 2026 20:48:30 +0200")
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
	<pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
	<xmqqld7o71ot.fsf@gitster.g>
	<CAHwyqnVMgAhyHrevXOJ0sBKkaPPzSmCcCPSSeqm6dm-MRX65cQ@mail.gmail.com>
Date: Fri, 23 Oct 2026 15:10:08 -0700
Message-ID: <xmqqtsmc2hmn.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> This is the point behind this: To ease users into triangular thinking.
> We should not assume our users are git experts, many of my them never
> read the git docs.

So instead we should assume that they start from mental model that
was destroyed by use of GitHub?  The need to do so somehow makes it
smell like a sad world.
