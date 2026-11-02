Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610677;
	b=IkuNru+tXC/aLoA5ttQW7uH8Lb9mn2bt++YU+O8AbSZqY8hCDokaazH1hp+zzu/3xBQ1
	 letw2YUSjVEcZv4q2SPn/QflN4gZIfzUN1mbyuxCGtz97VSLrxGKT11gLZulDMIIX3Zt+
	 Bz82IopFy+tLKrq8wcfDrnMwvX3IE+R6GBX7O56+wd5L6neSTFa48m9JvqK0tJRWvnxXq
	 WN+855xGnw1SUxzITgDEbsWcGD3pwYw2SOpOz9ULya/su7ZPvpMzr0UkRwu/Vgduo1Ewv
	 UPggmO+qbIOz6fGnyhbZ+gpmDjfiemkI3ms+MxhvDPzeSkcXjcHkcU5Xx5oYlG+XROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610677;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7OnCQuTQLBaVTVQWWwuBG1p2mdeEFqVOxUmXwOb8O+I=;
	b=tTHHNxfsdIQyGySGlmHItrO9jqwutHZ/dVtYcfA1mnuX74OUWOGdpZFWDn01MhRSIgZY
	 BfTV9A9/fGbgfXcGyk5+dcCVVn4guf7NeahVSzTzPKhyEYUWZrLw1WwyRYAlGbtR6jkI1
	 p2KCFSBe8MpenLhnPAdk54wllysHZVrS5T+FJDeeZF0Bb1z7uRgzZtxBBOCemgsMBjWDS
	 WisFzJko4D/7gFQFn7lQ+C08BLuDOokF9UpgcBGjEuIywjCUEQJK6Bi5ilwAuYr0wRo/o
	 4G/4BnELwAvNeAH6AF7weNafqT1p90KyILIN11X0Hwbb0kjeqxPgXpBy9y53fxoxEyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IdHz4JIX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FHch6Jfz;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD6606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53FD6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=IdHz4JIX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=FHch6Jfz
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E11B7A0071
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:11:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 04:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793610676; x=1793697076; bh=7OnCQuTQLB
	aVTVQWWwuBG1p2mdeEFqVOxUmXwOb8O+I=; b=IdHz4JIXr2n6HlinU3LYQ3RQwG
	qvNirxFKRREHB/rV47QoS56hcBXvzNQZwWn8TImHBA+CL9ImE9QbkjLErylkJZeN
	TEzyT0komOLasJWnifjvdVFl8Xr81T40EO/M9bwnnEThets8TVoNmM7dEqG1+QWb
	b2AaiaYZze0KtDgOvmJ6gT4unF5//00tguH6GMdI6W60upwI5ekG+li5ZyGEFtPh
	1z080UGyVxX7UQLXTEihzm0KsM63jWbl1MjLK5jeEfmXzWqnJjHMq9ixHvifIv6x
	Y8SAah7i+QoXsraA1O+gC8kU09vDHknbTtSy6SYvl5E4ZTgkcJ6qQ3FijOwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793610676; x=1793697076; bh=7OnCQuTQLBaVTVQWWwuBG1p2mdeEFqVOxUm
	XwOb8O+I=; b=FHch6JfzQ+iLjxh1LM6UX9odNEBh9CxJCOBznL4Oe8Kv+AWZH/F
	ECFzL+SAIeq898wXKnQ34bawhn9fpIIQghA7HVZ/YbSPi8Go25cQcg3iUrvqES6E
	KcdV3k4BhVs4VhtmNE5+jRXDUp5HV3vDCfAj8nfOy0Ir5cO0PSTPqOS1vbWJYuHK
	eN1oLNuSehto51Cym3Mn7CeN7ppHQqLD8iaM4yUcv4hUOiuBUu63itKQQyHTvOSQ
	CT6eJHoSXyAacxMSlxnKXsleCgEu3/NPL9LXsnFab/twFuryxhus+UrcvNBEzrgD
	OrZD3EtfqlSrJp6m6scV8tvtB0CFc9gGgrw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793610676; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JmIHJbZWcTWYqEzczPPxkVc//5VNsrwlzAi8hua+81lu6J+
	0DgvTsIkxbQM/ShUbMcwwzoI5P0ohqPE/HqXeDJxwPJD5DNrx8GTHatelYG9NSlO
	mDRtjsFwIj4EiFQsoxAhIOdowVBz3Wy/n0+agmsLANTwP2yuZXGQy/jhokamDw7T
	6ALpHuKXinouJ2RTMJ5NfhD6SvKbcCB/cA7pS5ZeQXx6x/bUBWKR6KcTbzg2QLdr
	DvkZ2v+Icoi6+HvPkSYQ1aiTTOlC0UMC4CaSAs+Q3p4Ylctd/LDMjXqbPY5xmC5G
	FjudjzLs0Q9pStsWxw540xDLvW9u0Fh24Vgc7gQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4oGuhpNVY97WWo1Zg62p0DovyVvB0Cy8FdgihmifdNA=:bEWBytmDPNxqr3Hp6YAUPSPoleoUYWhwz+awHBs4Tb4=;
X-ME-Sender: <xms:tFPoajWGEXldrqW2RqQsQOM-tHAK3BTyKMxm3oH0Lh2YKG-vjkVJSQ>
    <xme:tFPoavQDV_Frhs-Eno_ZoetO844vUrCfTlqKOCCOBzGbWkwQBWhvu31beUS9CtsXX
    Cx62KRzfpeFg8nb_DOIb99ng7q7lrmP0Y-hYZGB0OW3y8uNouNUBg>
X-ME-Received: <xmr:tFPoapNBTXV6WSlUkkxEm33TyaWMbOIcm9fUBwD_EQTy_OKYZS3l69jaZ6AbqKXUQ2_p9lgXCF55r0xLZVF3NpCKS8imyWAIYKR_>
X-ME-Proxy-Cause: dmFkZTFj6fRNoRTi0gEQxUMvLc+dXQ/xyI12ccST7dIqhh04KpcLOuK/vhHcVV6X5DMNdu
    ZkinUgBQin06UPzC+N1naY6DYM4Ecvc30YiDInBZQrPw1nPJF7damrUqjywQ4Qu0L/ojj1
    ieAcVpAjproz2ezfuce967u2RUoewmfSjGxetD2L2uQrWwq7wv5KA8p7GfF1eg4MTd4Dcm
    +iHf63o1/evsrnTtoa7c4N/2cGlO9R6QUiM2+Oumhi/9A3GRbIuC7FsqKcPXGKeCOEN25Q
    CY7sJpbYuY6URTLB1wzYhacOKutWAihYR0e3H27S2v5oi/pyAEMVNeBhBVStX4Gca2mgVT
    BtB0YQa1fpLZQOCyfBG/+hoix4XrW6SDtBWpJXrfTGI3dei85qfeZaIS9b1wkaPW1Wpwf5
    AndNmoxydIdN+6oCPGZxspJ0k9hnMVeG3gHtup95m+yqGvX92CISh3LywmZ7H1VVAw0tRn
    aZCxz8vFMlcZKCgTBOxKbbLj9gSg9CSFtYpFgBBDjJ+b2usi0McDpX8+qXktNJg/4eHPei
    Zdv5Qjb5MjsySG/GJEZRmc+rQLj2KKHTL1WjGzQDaiJPzQrnSbcNnvocW9PW3l6vsPl4JI
    Xe0A7w3f4Q+GzG86Vn4Xf0qiQIGSwr7G/PxhIJfID2Qld+ml9du2CG2dw0nw
X-ME-Proxy: <xmx:tFPoalRtQCzXDZM-z7bEirCbzoznANYQTESijc6tiESE4D_AhzGQ0A>
    <xmx:tFPoavjTjcF6nLm9vDg1-R3EbfAaoYfXdSer6IHzDl-h9DHDuahGfw>
    <xmx:tFPoam8vpN08JyU8CNtiwNuLWBzrSPFeEk6Pcr_N0rY0lDI-SipEEw>
    <xmx:tFPoauFi4ut_-_cM-K2UsITAjqZRsDVlzicX5Hzc8NDtQcYVE88__A>
    <xmx:tFPoagGPxr8xLQyVyIgUKQuAU4yNMxHQ9DgrG4TsJ2YlWUy4_vw30FI_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:11:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Git 3.0: restrict hex object IDs to lowercase only
In-Reply-To: <20260907195941.1024289-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 7 Sep 2026 19:59:33 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260907195941.1024289-1-sandals@crustytoothpaste.net>
Date: Mon, 02 Nov 2026 01:11:14 -0800
Message-ID: <xmqq7bivmwct.fsf@gitster.g>
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

> As far as I can tell, Git has always emitted hex object IDs in
> lowercase, but our object ID parser accepts both uppercase and
> lowercase.  This leads to much software relying on hex object IDs being
> broken because it doesn't handle uppercase object IDs and this can even
> lead to security problems when people assume that an object ID has a
> unique hex form.

As far as I can recall, this had quite a lot of discussion during v1
(or was it RFC?) but nobody seems to have been reacted to this
round.  Can anybody give it an eyeball (or two) and tell us that the
iteration now is in line with what was discussed during the review
of the previous round, so that we can mark it for 'next'?

Thanks.
