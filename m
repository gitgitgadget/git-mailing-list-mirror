Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792458882;
	b=EHCYjlbIwMQASN0C93lGDsnYK7tBzqPgHaC2k4TSQ6RcB5UWhJXzCWICYWYVomsilpSL
	 piSK7Z0nk3/iM22vtXg9K/NRsXiLmueHTB/vZ/JWWqBCQna0BGjrXBWgeDIGZMhOA6xsZ
	 lE26y7n5DivagWU3CVuueYBkAqjCUbP/8Yvaz0iNnQXxotiIdV891jGpVEuEvtQpGa+l2
	 JSFFx9uO5jqvbHkCL1iuOY1zJ9lM/lH49MV3+kxNNH+6W5HSO/9z30yu/LBg+lnyZ5SZD
	 NkIwP9GX6a7IovYOxfQiKxF9RTYmXSlv6ttd0bAMu8O4DVKiMEG6evRr9POoh3QHtrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=byg7rJ9bULj+GWRFNbqFTKaA69m3jbZR5sOOALv0no0=;
	b=ZSVBOUE9VD9Hx3qBk94bayO2luQg47pmdQR5mpIWhde0m8LX/NFb4feqyZMGvzlaieto
	 jdC0KBd2FqpcpcvlOWnRFtupRffPltcPww0wwfbjBch/ApIfSNUXykLdbA45qiKeo2lIQ
	 Wbb+WD6bhtIqYVq7y+zuxC8AJJMe7sS5VATmQ6Nf+Rf6H60C4hzBQv5ZfW9WopmJvlOMT
	 CfwLZOCfD2glDNmS4b4IqpGI7Sd3rgQidHC9VMQyCkTWg4fRIg3lZmJh1Tm2ehfhGsBE9
	 EyU8StLOUxyPIlh3v/i/Kn5LwMzCqu5zz/y3IRbt0CTRONrrJLV3SLchA+Ah+br+qJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JA4bjnA1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EFMET7zb;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B18606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 01:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B18606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JA4bjnA1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EFMET7zb
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 762E514000E6
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 21:14:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 21:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792458881; x=1792545281; bh=byg7rJ9bUL
	j+GWRFNbqFTKaA69m3jbZR5sOOALv0no0=; b=JA4bjnA1vD16QQ+Z2KF8Kq9SFm
	dxDmefmFKV38a73DbFPZkunePZrNr+mD6RxIWSZJpElCdVVmbq9nYyQJAtHXXk0E
	g1RuQ2aOW4i1/cqpNTYYMAq8vZGG1AKX6tS8XMMp8hVkDbQLlEENTcx/VSby+5Y1
	RUQi8qlAx0SGcT5Ptu34xXqFzt4WJ8bNIY7C78SapqnHUH3KCGMzU0bXldDKN7K4
	I63FES7rfhRgiVZ/dKSOsknbrQu/OOs7xj9UtL5GpSw7BIp2vxXopNWXSBb3B/uh
	E2bmObbAfMecIPThIKbWThGVTZuTFPjThGficWwXCN5IRWyQOk6K4O2+yZcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792458881; x=1792545281; bh=byg7rJ9bULj+GWRFNbqFTKaA69m3jbZR5sO
	OALv0no0=; b=EFMET7zbVB5AOxQKt73whe6YTgRkDj/dIWehTFK/xRgRDlXe486
	jmKeFqtV1fb9XTlIJlPcrGsj2PsVbV/KA2eN8OuMcjg9E+kJpQoq2VzDwn6QFrib
	YgJXubJ+zR4awpuvVC70fRLO9s5xOSjB7BSBvMF6Cgxg5f3nOO4DI9ul2y/BG7qy
	cwtLbRdIih7Kwd2xLqkbbeF1BTNVQ41UUJUHgR6Y/RB/R2bZRKWhY//yGhjJTzwI
	6LtRJCgtM+c5OiQjGyDf6r51svbBiwSi5fIK4FtuM6FBBMYsmGKH3maDQTOROQwE
	7q+343K86iIfphp/1gB7ZKAypoedgSX07pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792458881; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jtt3tUkWDmKTTNjhJZHqBE2bdX2IqYFNlVHhw7v5pPBS2tp
	DYVhzyuv0UmUofdpHr2jtAcTk5fDaRBcxXNqFwuJyuIQzquHUZlOwD+zjguANrSy
	ZobYi4vKCdAsN1l6lwHXBcxgDPdGGks8q5j3aYGEz5fVQzGUDwTmyTDlDHtPbNhZ
	dzhG9v+q57tFv+UQ5XhJyWyTikB8yllYNHfCgqnafxN03BO59PMXrQXIevQI5nM9
	ulAQnB6J9LmlOqLF1YrQSOtxHjwO/Q5D/9duxAMKf0Hg6jmtob/96c1jiPHqrYwR
	kBQHiWjNIP8YZHAIea93s5e3oFnjqnY58k1Ts8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/vmgwRvjewSgTQu9SvjaDDKUNFovImuFVWoOfVdXPyc=:T9IbLYuSN9jdpH8OPbEanE2XZf1qUzjREH4DzBpZi/o=;
X-ME-Sender: <xms:gcDWajv_-JyCC_uyiuu233jzSmr0GpiUbLP4_kaOOWCtM56QCUJCdA>
    <xme:gcDWardu5mL9WYlCGZS0G_ToOu6_JzW5zA5ONfXqAabdYqr1fRUGfh7skNLddQtHG
    OGLKBVW_FlBXFBEtB5mdOQjexKgfSw97Qt9CJQKX6FRyKZzEHDf>
X-ME-Received: <xmr:gcDWarybM1Q2qynd5zByVHMAMQLAuA2gOC9HcjvUoOQuSpIlbFUXk0C4RVWeSiFElFQSKnvUzm83nmWmzPDOPq6tx4g4XRQyba_g>
X-ME-Proxy-Cause: dmFkZTF9zNCH3UGH+Wb3aOIPD8enRf6QID6PEB1NVYD/yQL0bdN7pRRAq8+meYNoUTwEHK
    0BuGXXoNAFOKqEnO/lrBjWcQyZc06HXeVdOvyBgt0oUXJtY3p4QcQk0n9SWfoqzD2XC9Wd
    lFpKM9lYRXEYNeA9DNH8F4B1AqbfSbX6UZ77296Qv6tVrDpSaycpr8QTNNmSj+jEJLcbLW
    MVAKRkwWkAqECU2G2vHdfG8hbOg4M9MU/4kn3W7wkvd6aD0cG1g+9WELrOG025rQZ8Jmxu
    g6xsVaYSl94X9yWk+QTUOYxeZ1wL5hum0qw89PpDdO4dlTwHN450HpnKjAxpgBfWZUZwrN
    9y9ip+JOs0rhMttEWmHJwXk2vTzOgBLC+A62ksU/bujrUs6rAo3TkOKz0/w/HIaWHwDWS+
    tUWAYAjs/BwgOyge1yu80k+tzPrF9lqyiymhN8CxgylODPJn522y5VvtzNWoQ5UR9FNP70
    qcWPOsecfo0xJVMMJDbkIcjl59Nrh554LXlUzNP74bCpTvikHO/hPH5PEKqHlgeVGBJLM2
    FX4BYZNazQi5JuDZBwL5UFXuGaLn/+zYmXmOPMVDoF3EbbVCpqKCLEEYW3s/jSbk1VYBvW
    sE6J0W47t8SeRK9K5l4VnRiFeChTZNyeP8H6c/fFozv9f9ocWAKpxTokwJoQ
X-ME-Proxy: <xmx:gcDWahFFVKpwJd4uhUhGtwaphH0-NfvNllNZyzbIcyA3PVa5zAuyXw>
    <xmx:gcDWavzj21Jjcsq9MOpwGAsvo5jXK5hDo7wavf5MqGh_ziDfaUsiJw>
    <xmx:gcDWaivIWtkDVQMi5hUJto9NF-Nrg9yKeubS8ApuTQeAgnX1gSPC3Q>
    <xmx:gcDWas3vDHVsiMfUKrEltY_AOu7lrv1q44YflNQpqICuDcS_M1xUDA>
    <xmx:gcDWaiaeFZl1t8ddLtQtNazgCbhk9goJrWOSdu2CIBjEUK9FGa9ww7_L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 21:14:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] github-ci: update macos jobs to macos-15
In-Reply-To: <20261019234724.H0mV3jqQ@teonanacatl.net> (Todd Zullinger's
	message of "Mon, 19 Oct 2026 19:47:24 -0400")
References: <xmqqfqy5clgz.fsf@gitster.g>
	<20261019194152.907881-1-gitster@pobox.com>
	<20261019234724.H0mV3jqQ@teonanacatl.net>
Date: Mon, 19 Oct 2026 18:14:39 -0700
Message-ID: <xmqqpkx5yxz4.fsf@gitster.g>
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

Todd Zullinger <tmz@pobox.com> writes:

> Is it worth using `macos-latest` instead of `macos-26` and
> letting those jobs move along with the current macOS runner
> as it changes?

I am somewhat torn.  Being explicit on both ends would make it
consistent between .gitlab-ci.yml and .github/workflows/main.yml so
that we can more easily compare similar execution between the CI
services offered at two sites.  If we could set to a symbolic name
like "latest" and "oldest-still-supported" on both sites, I would
probably choose that in an instant, though.
