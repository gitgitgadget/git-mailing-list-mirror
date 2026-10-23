Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791905;
	b=haXz4xTDKkiyVTLEJBxEYFzEvZI+h0BajL0y0wSFmoUDEuEIbHi0w4jADUZZ/Dzr0RTy
	 Vru3YcfyZ0odErswDO/qe5XX0AXMS+lkWJtLN4F8H0a/q2UL04oC+wFfo17ZMmqeGeBgK
	 y4/JqXIKGP5q3cWuMp2RTm+Byij/YzHY9gTrWRPkOD74gOnLuClq0ZzSDIvQgTIZkmKDP
	 G9IkDWPGmPAsQm4IJi02RUI9ZvKROOfp380XKVwMxe6mDjA24S5OpQihJnth6Qi5xXWZq
	 6VgqdoJgSFxdt0Z3Eke/hfVHd6OYayRTW+VYToUeTV1dKqsOwtMZMtHKcOEQ66TAhQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791905;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JFUxxFbda5o/eZMonJWxs3unwsjDzXeGiY+rtojoOjU=;
	b=jDy0s8FtrXhqVv5rYp+HKHYRsXJB0KuTiHZX6NcyIMZYKDBTlWCz7KbklFY3p9OBSWI4
	 5j4Gvqc0bnDm09P6d2gXtO3oLhWL+mwBn24QrMOc2Mno24B6Cd0sOVS81QYNctH05LVJe
	 tDA/v6KZw2I6x3ImDogyJQI0vBNSEDc77BP+0VRHlXAyDJANaarRiU1RmYVmUC7qkgW+g
	 gkQyWs4merXZdcMDzsMoASUBHveySSr5Q/FSgMeHswczmmVkU+V1RUK9dyUrBA5WW+Ypg
	 4ADgKhbVKYkuQISmKND5ECLfFIcibbv0vihA2QgxL0orPr5zJ2XfUN0Qk+zhQjGzafA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=H24XQQzC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ueRs4UQC;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3C606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C3C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=H24XQQzC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ueRs4UQC
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 91F881D000F0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:45:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 23 Oct 2026 17:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792791903; x=1792878303; bh=JFUxxFbda5
	o/eZMonJWxs3unwsjDzXeGiY+rtojoOjU=; b=H24XQQzCzFsM9M3QOw/A8nHL/H
	YjShVnoo7xFO+x899sMhQTkSIJpshV3xszxMD/at7okLpgCswTsFK51+TvBTBaVY
	/+tsPvPix+56KfONxx3ShtpjBtU3OBiFYdqiE8Cys2Z5kSXYoJZKPpAqrUrbG7OC
	wwQ1LCwETsHRznN4v5xUrnnruGzlBjSdCq1E/++0n/rOfaC6HXRXVanjO2hBORgH
	ghe/N0RunCQTnE0awOaA647BaDLZt7HVv2rEwrFIPno7CaVsWeXZrKuTmNxZw/py
	aCc10oUxxdKpQvEgvUFdGbE7AmRbpepGSZF+03ZWPzYUYXiDpxQiXgOQwyxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792791903; x=1792878303; bh=JFUxxFbda5o/eZMonJWxs3unwsjDzXeGiY+
	rtojoOjU=; b=ueRs4UQCOS3n2JEWeggdvZ2UWYn2NFBNpf28NODpvEFY7OPrtsp
	iEpwEb5x4RkBwDTtSFAtLpoYdCwKPo2yNClNsiwCk6Ok3SVjl7eE0FYF9iQnT96/
	Rr14KODG1F8cJKJeFD21N4JlmWSpIEcZkqMo2TrUgC0I6qHxVOwDbQtnwgcGW9rP
	Vo/oxvQSCYuOLylICbEUqhIDHJTjbUs0f8Rr9BradJ+wfIBHzH8pU20tp8xETYbS
	OAy99iVVnP2sslJ9yvzeMPIUH0i8gdf0/dF0OvNb3dzV7Bnyh9/neX6SG//4K/bw
	tfVeYZkrvQrdBTmbh7BDi2J/cRmp1Njfw5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792791903; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:H6GVG+kegtuVV1oKgePGjF6wWGE1CqJck/qTRLmGNr4Dgqi
	6SQsH0DSO5xorfEu+JdAi7Xg1FrVJ+z6u8YWpfz6JypWSlaH9vsxY3aUvwNa6RUd
	9cvKtUfMgC4cMN+DvcbecIgzN0v7jLZ6mBHYYbYs9Jt3e+UlRUoJKfjq4DRhjEcN
	a1cltw2sBYtsNMs1XB5tgFn2qwiI2yBbYBhpQ8Mv3KunwFsTepVLx5hkcvDsgacp
	xakJvA1hbiW/rfCjF+Py8U95+QiujIpyQg4YxVVo94MSxcy7goL1r0LxxC4/o0g0
	WH9B2T0eSfnfwT+6hXQzWpP4g/6WTh2UvA+fopQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:adfFwWBZT94306YIOFCNE33mHV69wx1r2qloT8ICmXM=:jmlkjcxxB+8j++C0pwr09vwBg2Rhmc5PTCp+A3+caaQ=;
X-ME-Sender: <xms:X9Xbaoze1HRpjEn7a2uz9Lw2XhcQRob24MrDbSsXibgoY6nJ2F-QaA>
    <xme:X9XbajRK0_Kfy1uMLmWr9Ivp51bc3wqCUFGGlZWDrZjMlVJeFI0lsykAm3fIXbFSK
    2CnOTHDMSkd87d75R6bwfbBlBK7QfEkhRCfPk7FA1V1vL9mCwyqXg>
X-ME-Received: <xmr:X9XbavVdeyZ0RJAcH88GIKyw1nIdzOTI4tCmNS6oPU4drDNApn0R5hkZPCww1uXwPQVp-a4RQj3ZYsgYHI07BFm553ci5O9NQfA2>
X-ME-Proxy-Cause: dmFkZTEOM4kgr2sx+SfDdYugXnNcI4LwJVz+i8YvHpgeauf3PIM2xXpGJmA1TxQDhE4s4j
    VPobGentNjNg1OxuBJIOJAxFd2SmbHppc3YZLrmzHp7/rdp4IJF4yFdBii90CiaF+jbLyK
    vN+U5BGkoAMSD3ciAuNXRSMiIZW6/F/v8PThgiqZF9pRt3C8/Kkz2AkjzK8GI47hU0StHD
    sPmaAC8Se/EKJKkkOIXf5ee6dAwyVpj8M4o9fFLjUXpoCZRpXY/lo5HXapA6XQW8jb26D8
    LWZKpJ+e0zOdh+IhzTvI3VhT9MdaV9FGt0dGBuvs1skhhPgnMGi/wfHQErbT5RmgobosXG
    hG+/y+mye4Tz1plsemQZELMUwzu3MRCqHrm5CWJlIbNQMtYCtYW8AMnK4T9HExglfERpOv
    SMqhHNlNyGtnZwsDjkkmnQG96F+UU69L8jmNJw03XpniemM4co8n92KMc89BkNeMRFlqXY
    nlIkZnvIu0g4+qZipwyFJ3zAQ7NsaUjWZq8d5w3DDSR4Vvn95bj/HXpuOeD6uikfOjW1OT
    kF8phTh0qfHVU8t2xFi/vIctXlv1eKeHg9qH2RC/HM5nqJlR+2T+pE2PNdOBgOMhEgd4Kc
    3EbT9wv0KYNC8+Mpr+PeoHpYWrEvQGqrkokdtQ9bJtozt6f6zHb6uRYyTAEQ
X-ME-Proxy: <xmx:X9XbalYt7SWXQ0LRHkX_4o4dqulvo2JIGGN6zcVoKvy4TLIOauHN-w>
    <xmx:X9Xbal3HQElpEAjdx9IlIlYQACU4Bq13SYX5EhaIYi0P5-VBLNCzaw>
    <xmx:X9Xbani-BCInaSjAcL2UiLNZ-SYy_IEId8FdjJ0Yw3qu63P5r69OaQ>
    <xmx:X9Xbapb8r-2oX3ATZ2bM2SCZ-sO3xPOcT64n7W2yxAig8eiO54PuPw>
    <xmx:X9Xbam2orkjefTsBKfeqCFUwiRkVxZ2OlxfO37U2d2Gi27tx3qF9P-k->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 17:45:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: pin actions in the main workflow to full commit IDs
In-Reply-To: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
	(Taylor Blau's message of "Fri, 23 Oct 2026 11:38:23 -0500")
References: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
Date: Fri, 23 Oct 2026 14:45:01 -0700
Message-ID: <xmqqbj8k3xcy.fsf@gitster.g>
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

Taylor Blau <ttaylorr@openai.com> writes:

> Some forks are hosted by organizations that restrict which GitHub
> Actions may run, including requiring actions to be pinned to full
> commit IDs. Our main CI workflow refers to actions by version tags or
> branches, which prevents it from running under such a policy.

I do not see why the limitations of other organizations should
affect our workflow here.  What if another organization prefers
readable and concise tag names?  Would they send a patch to revert
this change, leading to a "last one wins" situation?

Would it be too much trouble for organizations with this specific
requirement to maintain such changes in their own forks?  When we
need to update a dependency (for example, when 'checkout@v6' is
deprecated and we transition to 'checkout@v7'), it would result in a
conflict anyway.  At that point, someone has to translate the
symbolic name to a full object name.  It seems only fair that the
organizations requiring this level of pinning handle that
translation themselves, and the conflict will tell them exactly
which line has the symbolic name that needs to be translated to a
full object name.
