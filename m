Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711761;
	b=fWIEpJJLU3hsoZ3DZM9jtuJAmt78KlRs2AjVyCHoX3IEbxkFY7ZrHvGyuiXdm9bS8J/e
	 +mXSknKc5jasD/kv6aWOt1ZihMvnL+dTxv4JtFcvd68TcreSszGoDKjCnk1U/It+Z2nQ1
	 UJ3tcv05J7twS7YRB0VcXCd+O1N8k+jJ5J3Jv97Adpcutch+Z7ppe0gHgTIzvXMDHcY6f
	 wIRFSg08i8y9GKX4o47DnzyaIx/uOR41TT43iF/ZGswsvAyHy3XbI2BIXNQzsRYcLd6Ns
	 JMWFmJVSBJPNV9fUhU4wmqTWU+XX+6/obclqgoyTGgHz9rofbww4LDLN+BMWd5Xa/Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711761;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rZ2acNBhSjtBAtgxg6xxmSWaO4MAtUbZE171NygF58s=;
	b=FCPf5e85MAR1mpXhS3WIW3rm6zPjpthqrhwH091/u9sqbmxIYmxxYvU9vkgucn9T7esu
	 3pclxFtdJAJhI1OgvAeMW37tjXAlSE7Mv166spzOY9KRPqUTavZuDx8NmgO4ifgApMIZm
	 GtyTZLq7rEWlD0uwCHrk02/sClQurfQdka6L3PKvw3eURIVavU6e+q9Adgbb6+NCyOaTT
	 fBl5eINSbrhRkqA5WE4d2vHTQKpj9nXZajKmsMoYSYkvoLFABv/KtNndjAcvm2w0d+S1B
	 ycwo/qzkI+YfJwRfnpRVbmSppcs3X+NKm0KJfFlYLC1f65q7gepKF+g2elyTjZ7Gg1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EvqoRfp8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Oqz8gTZH;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A161606C091
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 23:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A161606C091
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=EvqoRfp8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Oqz8gTZH
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D17DE1D001C3
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:29:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 22 Oct 2026 19:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792711759; x=1792798159; bh=rZ2acNBhSj
	tBAtgxg6xxmSWaO4MAtUbZE171NygF58s=; b=EvqoRfp8sgFoA17y9JwGPqkyrA
	PcsUa5JdsVHxBLtOnnB+wfpyRRL4n6+rjHPJY0Ua15q7O7MFQbsug2RZ4fcb3efj
	x9mjR2fNYHQnlTJfL3a5yPeBXgyJ06L/iaMzdzv54+MHdndJZYHAenklEjlRNDCA
	E0zvsze/1jOU6j3MOI0Uyh/y2txYTia5yRBQV81nX1ay/pRylI16v9i4/QuwGtzX
	f94YnQdPl6bDgCorqSdHrxELpbtxg6sHqtUXI5mI9bIIWRqcwE7HTzcR/PaK8b7t
	dTRIxrj2XdGcUCPyuohC/RoLs7McsfK04nC1/tejcCFsam5qRfaLt33qrZhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792711759; x=1792798159; bh=rZ2acNBhSjtBAtgxg6xxmSWaO4MAtUbZE17
	1NygF58s=; b=Oqz8gTZHkWqyVPIcI+MRJdqC4M1VgLaK/RsbSW1F2R6Dba+WNZh
	5ppk3m5trmMCH3dcWsSDQbtwErcKGlDq/H1sCbprD+9mzssbYoT2Z656jAOhT4gN
	EtGTX2Vi5cI6eOqb1PNLjoxlmjetNJajQREtqJc6PYntsr0ymUqltbIs/Sh8LBKZ
	k+25wCrha7Kqpmzi/0hu5MtXtlqVxzfF2ep7aJT9WSZ3YNLjqyZL062inpK6eMLA
	A7FCWOwjDSYL815kHZHg+r0WlpSUi3Y56IM5vGSjtNI3PVoRlntbbNLskmcuc8+A
	wsbz36403z6qVcfI9NxRqDCrXwQsZkTa5kw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792711759; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OE8kMiZSy+n/PCIZGkKb5k94kDeTdZXq/bDrHFv4MN3esaY
	IzzoaEW7hPQmZC7V1Zo86f/fUxBHnHQPngluzTrQko0bKRZdbXyHtlPolVuvoJo8
	y3D1fCAHsESGkmgtrIui4oqmFwt2dgfErHux1ek+W7b8mo/b1Kx+M5xV0LCQc4Q7
	BvAZ3Dx64xYJrw5eyeLVnX/SL+lO9SxFSHzM+wDrV7Qmm/xFgRuNMLl6nWF6ovpq
	49YQ8ST20SJeooYAF7kq4flylF4P435DMI3FVYWQRXcqyxKxnmOyczdY1TWWeO1r
	NNuHpmFvcRKqAUFiiixpvhSldQSXLtOJ6RsDBfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Z56mGSCSyNmaoLB81Kn2uIXsXHzEpjaJkkA7r3RPXOc=:b/6iA1CawHSpIech4zL640xqee5V9g1DkWRr4JIPGp0=;
X-ME-Sender: <xms:T5zaap7VFHJQtrReETrizqijBr-Fun3qnOGYsCBjHx-LPSCy4eFUCA>
    <xme:T5zaauXfRO7L3h6IK4WM6c-Apeuls4KBKjL9-jVfDNINELo6i5q5x0EHPIjYdQXK6
    9eYMaObX1t_iW09aZt7tBQPOdX1cmmhbpvO2BfgPnRu1BkQjav5PA>
X-ME-Received: <xmr:T5zaat0aFYbbq5A9Ygcd7hF4TA4F2oxIYhnRpmg697ElJYRtrfdgcpe9RSqtF5tLW-lhmu8xJBVHeItKxbcpu1aFSHgKdhPZqbDY>
X-ME-Proxy-Cause: dmFkZTFXoGkW+3VivJa0rMEqyToty8VxxwoaQ2Z6nyzodlhZzKVO6G+j34BSw92r+cyRnJ
    qb5WoGMhn0NslsF2WWShKtw8YMF8DNLbmdaqasxcZ1FfjIYpYlh+HpJYN+MN55TmKTJCPZ
    RU5r0JseEYHDCmt4htp/hgdrn+b1SfKQk45m/DmbYJ+BeKbn20Y/u/G+OQKde7XH8Li9OX
    4MwZLuKjaWgNYH/r8oGa2kXJjNKbl0YzqhkKVc63ug36P/bzS/1Rvc7zLGka5iJAmg4OQU
    9+p3nWHEqzY06tKHEMs5Zh2wmwbyEYpNZOWq1MSrqgjYSKyhFeCw4ralafV+KLtz3SXGK4
    U/mn1jE+Y3JQp16ZQEDEVlqJi+kHikfFWYtfhUpCX2Tu16jEs7FqfDxf3exgrj5ml6E5p+
    0PBQjtEVx3GBa0pNFp+pR7P7prwySPMnbYnO0OiXM1OZsFm83cVnHHHWO6NLwFb/2d3nZz
    xrbO/Etvs96rw9pIgkJDxDzKMP58YkFgQ1spUD3fDvbskarXWNqWm0Ch3NPW1lN7j9OJ+t
    8vKhUrDdFFq8DPm2Rh1L5M+4N7Nd/nUVOA5i8FAhvPgG0iNbJ+ydaDoMThJq8pCZ27EMke
    Q337AZmokJqoUOIt3Z1PemXnmXzsykkf3+WMn66k4tOLZHGTQf4T92S0gHjQ
X-ME-Proxy: <xmx:T5zaar2BpV_T_fFj_xkP27ecBURiWi-0ilYseUXN34Ui2g-MSdq0sw>
    <xmx:T5zaag-HpVbpZkZaUGRTZwM5gGf_Gt7eO5RUlazgmB76BQvUCsTV8A>
    <xmx:T5zaao18NypeG3tPeNsjC9PztvQ3PBNvveIIHcCwgBQDNLcAJ9sprQ>
    <xmx:T5zaat-_VVlGYikeRMBPE3XyWpDILxiPOiyPVYAan8rNRsdgyOotig>
    <xmx:T5zaaviayTYemvpAb8XbZ6N6CW5QbZA0hObGqOahxPnHcW8EArCioMqe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 19:29:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
In-Reply-To: <atp7Pvtp1rdL8Uj_@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 22 Oct 2026 21:08:15 +0000")
References: <xmqqbj8p7okv.fsf@gitster.g> <xmqqpkx1e9iq.fsf@gitster.g>
	<atp7Pvtp1rdL8Uj_@fruit.crustytoothpaste.net>
Date: Thu, 22 Oct 2026 16:29:18 -0700
Message-ID: <xmqqa4o5co1d.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't personally make that file read-only, so it doesn't affect me at
> all; instead, I just overwrite it with my personal configuration every
> time I deploy my dotfiles.

> I don't personally make that file read-only, so it doesn't affect me at
> all; instead, I just overwrite it with my personal configuration every
> time I deploy my dotfiles.

Well, I deploy my dotfiles from the freshly built one (the sources
of dotfiles are kept elsewhere under version control), too, but when
"installing", I make them read-only, just like all other "installed"
files like the contents of my ~/bin/ directory.  My personal
makefiles have "dry-run" support to tell me what the changes are in
the version I am about to install in 'patch' form, and that is how I
noticed that "git config" allowed to make such a mistake, even though
the file is read-only, to some failed experiment I made earlier.

