Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512960;
	b=PN2AUSyacj52EINo7YDCuvUVTklx9vyvk+Nx8Vf5IChMRWv5+rb2lLnAbWp8t69GYwAr
	 E9VVC2C0CuKNW2FiJbJcjyjhoxKHTCtUK5Y6MgmcQJklNSfjTKBGNEWnmMgcfn0gg3JmO
	 rczFD3rp6HnW6lx4XkeOS2w6kbHfcXb1GHGpUXlHV8nj+O353QUkn0+bhGy1/PsGZjsyE
	 /znXKmDxnDFRxUEYdt5Z2ajUrp40oJAfQDnSBITxYIFTTVGPtNGJy1DiFt1gmG/pY1osX
	 iMSA4T4q8sT287pgyWjs84LkEXDaq7Xo34F1+wdRezUKIlAfuCuAZwk+/4EWgzq0ycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512960;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=66kpGiOUtA/q28FkCdYqTMci7qyEH/ss0fpKNq255D8=;
	b=Vtip9zswGtnHNIsL83J4qf5rFcHpkEZzCi6nQNSU8XOZvUtGvIe55jw5tKGCE3hME+cs
	 KN1xFUOneIu3VKbgtYSIB8z3mTx6oEGoRnNLw8nDJ9KN5ZKmquCDTnSMiBA60G7HEgV43
	 Py5uct3CXK6xV0nhpiIKq8A/k4voFxrutTsQRs82uVAa5cDKE+1ewVGt3NNasC+DXsflL
	 7yxQ3FYzb1jkJiyihIKTdi58R49pS4VXZ5H4vWFo/NvDNVbDj0t5Wxdx2xAZ006cDRNb9
	 qVO3/LBKLLYXMbUTRMdKDUgb1aQVtTnIHpi+BqOgCusodfjwba8Q3KY9BFNFPhI3GoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=X2Fd+zv2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3mjrgJ1Y;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724A606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0724A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=X2Fd+zv2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3mjrgJ1Y
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 424261D0043E
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:49:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 14:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794512958; x=1794599358; bh=66kpGiOUtA
	/q28FkCdYqTMci7qyEH/ss0fpKNq255D8=; b=X2Fd+zv21bPpR/v4+Fz2YVrRdx
	ckH/reeCD6OnM77IppSzF69h9F9FGqh2HETCMxszm15mxpqzJLZoQo4eWbP2gJzK
	viT9SC5C+kmWgMzx/BcE5ZziVl5jTWkX+2ZX8Z1RRVNdE3rB6o37ArPf0LpMpCDH
	P6xZ0YIhvs60dZ4KbeuOmHQSjcpy63DNuT7Q0RQLs3IGEu2Y4ICdwLzvSCCNPkND
	t+xZomZfM50m+jcaUQaGY7KTCbP7dmmAyl9P7/DhsFflM/SLD2a8UDFJukDBk5KT
	v3URAjEGBiCm4WLh9YcRoF4fGRstWYFxtgqKdpTLCQAGoFOqWOC/ul4Be4vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794512958; x=1794599358; bh=66kpGiOUtA/q28FkCdYqTMci7qyEH/ss0fp
	KNq255D8=; b=3mjrgJ1Ysa/mMITBsGkBB/7VPR5Ff10pSJ79eDsxSd6KjFE7CXo
	D3x1qJjzFC04Xgf3TE4/AkJIfvUhc28v7su/pm0PAB5w2lYMTtDl2IavGj63AFRs
	NaZvap5a90AaouTHnczrrlWfg6zdZ0pIaSJByDE+bCYPbgQCguGo/KTZEQ4MZQdz
	WKXjgIoDbMo9F+3N8sefH1hrlY510OQO1J520smGoChZMicJHzqzwhn1lCm0JNq4
	obJisRvTYyHjoGlD0U8F8RIWpiYancGGuNikKlDgUjR/NMEpyCZ+NjDW5xrliYSw
	Rud0xr+CM4urVmTmE0eqnrmSYqjDKEXQXsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794512958; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XGgxdztDoRivKyeTZGrilEEap9WeO1uNXRHUjxq2mnHHRlC
	tivW0cDVpurqJYeA3kEOksj9hg2G8XbYQazrKyXQvUoenXf2UcodRuPv4XV/fzQI
	V22Z81CSwRWMmO74MOH+B4V9RmA+Syi1LsfRpme/92KIfRnSXCDlXxy6t8R6dEf5
	TiljFZchAmh3kSCcuJ2e4XSib3jLFnR94sW8rEd9BGHly+UlbCtbE2+Qi2WVrDgF
	TPNKEr6i3pHwyTONN/hwNV7RwPA3x9/yHXXP2bOl2hLNjTC8K4l/jJF4bM9u0toU
	TR14AqoUo+5fRikgTVTKRkjtxkH/s2uU8Mf+ygQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GrdErBF4KMbB06INJoyH1d5g20suNOO3yWydUbdcCkw=:SX5BoobK3ey8HChK1Q+Zq7MuK+cZNApt7bkDVf7600s=;
X-ME-Sender: <xms:Phj2amS9AvbtBSdE-ED_8BPMcangcnKhVmNwiR6d9qad0534_gRw_Q>
    <xme:Phj2ave883wWrszjmXZaVvGm7p2c4JeYyQnRaaW3dwxySjftA4sBS3T76nRdEKNfO
    90tEoDxWuVEwChTRBM5l7TvEav5wrti-nUbG-PQoD0xdXmiTvWJZw>
X-ME-Received: <xmr:Phj2atq5BN7ZcSqUM0EvmYNpONQhwslHqr-lYIBBoXQ-o8jOJFYm4Qv5CNVBjQ8HgtldzqKgqk6RhYpNsd7JVLdtpl6ccW7_lEbL>
X-ME-Proxy-Cause: dmFkZTE5STRT6NuFKmQBb/fsEF4eqXWfS4iIEByzs8POYEHXBjl9c8hqNzfGfthctEPJys
    GmM9IBUnnw2vlWxuC8W6Dsiy6MJ/yEvt+h1kHxCuAd+QOFbMpLfxrfAMRHh06f36bajl6G
    Su1vjzkUhkt7t8Y6gF1oRgZtyeWiLPUdcpn8mxEc8IfzuplPKLWxKWDzuWpP/hTtWG5LIa
    im+t6zvGB7p241XId/nwW/s97Ghy3mONYVUwFMYLfoz25AwJQ+32J/+TtaehZgShHMNsdj
    gM5kUiox3m/WSszB9fBAst94b8bd48MnbpQvUgGMGiYLDSE+cCdPn12VHaWOll51yNmxR+
    sdv3pCs1uswHYJgnOO0Wl3rW4OtSnddAjKaKo/FUmOSFY47n7ZqWt1PaBcrAGKuV7ZL7V3
    UaHdRlIIdQeYsjAClv1Y4tLUR+cvdhY9z8SOAms5Fu4N4d2bGedPWPiKYeuxXAl43vezk9
    8RV5Vhi4kMAnAwKcTRcOjgh4e8JcMmLd6ldhEGAZABWUDIyyEsFvJfFAwcDNngHelAqMP/
    kLkY0IDW8ekIl7fRxjWCS+Ukauh6E3RJURLGzpbgfrcOa/w5xRilgXy+YRFRztY9PG0ljb
    dvE0GntlfSN4AIdyK06lTubDw1Pe3A9CT5gm9hWgLV8pLu/JUhX7p9cnDWPQ
X-ME-Proxy: <xmx:Phj2ao9t4guZE79UvyAC0qlvNuV4gGzyWQrW_MErz3clRCo2EYg4WA>
    <xmx:Phj2ahfvIOZe-M7tLKvEiRntJxEKLnV2DaSvkwxnrbgzxS0rshuFBg>
    <xmx:Phj2aqKVOH1NOpCwRyZp5sUHIn0T2xkrksT1b4Am-yk-oGgAhqm2iw>
    <xmx:Phj2api456LtTm9MWTUlaYcJNJseZ44kY0pdqhoqcBA6GI8qe7PB0g>
    <xmx:Phj2av21TAihH4r6THk707_inumvyjtSvKkvU4O0hO_jQETiNyP4UVdE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:49:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 1/6] fetch: add remote.<name>.fetchRefmap
In-Reply-To: <01a799bc-5493-4984-8b83-7f2aef698f85@gmail.com> (Phillip Wood's
	message of "Thu, 12 Nov 2026 11:00:37 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
	<07081828d1d65373bee4b2ef5e1916e65a217db6.1793357550.git.gitgitgadget@gmail.com>
	<01a799bc-5493-4984-8b83-7f2aef698f85@gmail.com>
Date: Thu, 12 Nov 2026 11:49:17 -0800
Message-ID: <xmqqv761hltu.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

>> When remote.<name>.fetch is also configured, it still decides what to
>> fetch, and the refmap maps what it fetches. This lets a remote name
>> only a few branches and store them all through one refmap:
>> 
>>      [remote "cabal"]
>>          fetch = master
>>          fetch = next
>>          fetch = seen
>>          fetchRefmap = +refs/heads/*:refs/remotes/cabal/*
>
> What happens if remote.cabal.fetch is a refspec and 
> remote.cabal.fetchRefmap is set?

Good question.  But "fetch = master" is a refspec already ;-), so
the question needs to be clarified a bit.

    If .fetch is a refspec with a right hand side that stores the
    result somewhere, and that somewhere is different from what the
    .fetchRefmap suggests should happen, what happens?

I think we tried earlier and saw that we store them twice [*], even
without this series (i.e., specifying both refspec and refmap from
the commmand line).  As it is a long-standing behavior since the
--refmap feature was introduced, and I do not see huge problem with
that behavior, I am not sure if it is worth tweaking.  But if it is
wroth tweaking, we probably should do so as a preliminary clean-up
before all of this, since .fetchRefmap is merely a way to allow you
to avoid having to specify --refmap from the command line all the
time, and this series does not change its semantics until step
[3/6].

[Reference]

 * https://lore.kernel.org/git/xmqqld7hafhy.fsf@gitster.g/
