Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597117;
	b=iN2xWOoS0F1wgO5gAw2BQ7OrsrOpvciWVj+jN5BkCWwyYrK0rJlSStwEzP1ulAu6JhOW
	 TTa5pcMPIQJB7CRxEt0CQE/kSDk1HcvJwyoHh8OYEV/zvbVJuwmbNa6Qi6dHpfCjLjG+Z
	 B5ClymOZgFMeoK3ChxB2qsA+zqTll/iN/09AAMmny6qdDY5zQBRVve44+IEadYm6Oy7pp
	 MkDsQS+IqLQI3uXR3pUNUP+vp8ckeZCtefFPOYUU7BnPM4ZNe8RsqL/yXuZdfMErw2/VW
	 sZevMz/Obgm+fAYMgBbT1DaUpqhyNF2WfD6OEagvenVCbdrlykBxUcaT0dGLjC5Rr9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597117;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9NZcZessg8eMRUgIgXPNvAQuuUHxibaqt938vFQ+BXI=;
	b=4AbR/ZtL90OJm3ylmgYlQ8d3YKhoFE+zIurhKuipeMUxur8EC2/+blvuLtVPPofKnt8W
	 vY6soJDXDOKcg+4lq/DgGYgwNeIR83PbpjMcA3xCiwrUzzwNX3Av/TlxNNrtcekYjlLg1
	 UrJGqxREX2CDeiKPjw55YmEOJqrsqxGQEAVh8Jp342wRodhRQYhQGxBQVGlxBxSbvZPjC
	 K2vILoUr8aePjri5yuA3Z/kWcXrQED3j9c2CAoz2lllzowZrT4425eIlyyGLb/Juy7NhM
	 Z2Kottq2ABwG2ma1vGq21pNJzqdoAeRhugXRu8SNZoHGGmh70y0D1RRgdxprbN6FAmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QlC4nQ46;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2g+ZdYEA;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD8606A327
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EBD8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QlC4nQ46;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2g+ZdYEA
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 988AE7A0124
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:11:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 14:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794597116; x=1794683516; bh=9NZcZessg8
	eMRUgIgXPNvAQuuUHxibaqt938vFQ+BXI=; b=QlC4nQ46g7b9TVZt7mMt05lODQ
	+Vm/pQaTE2vEjHvxglYBZ/qZHZ711EttIR5VdQtJylHRexWTYj6TcO6WgvTLzuv1
	HX8lu28z1+kxoqFibYdvtllTyGHgtzM2/JCLnXNZmDQMpY8NfqtX5F1ePVVyFXd7
	UMUH+UQAMBXxFO7ZRBKcyCg0zRMGLXt394ErUjjt+iO+Qt7GLoBrj4u9TaaFKSB2
	2LdmJg26uavYcg1hzw+uMaPy3bjn6rC2fNpkH+vgQhNuofwfV6ZUUBnW3fAysdDn
	JFR6u7moiYflOYQwYQ7EavTnufNIaCTab5Hfn3RuvSVSShwUz32fmOo8Ap5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794597116; x=1794683516; bh=9NZcZessg8eMRUgIgXPNvAQuuUHxibaqt93
	8vFQ+BXI=; b=2g+ZdYEAGKaTUcIVWHP+a8eoyYnrNlfuin4z43KPGLbQY+HLmiG
	QxolWli5HJhWZOCRaGyowEvTJ/2smhPbRN0WE5SHIkTKiwuaPEdUfGA1x4SHeT4K
	/q2DKHIe0aaEHtogZgN7F9+vYmvhVybBBDF35BiEY7aGahELW8IpzGWnkeLnfJmt
	n1flvR7jlckPIDJDeNx2zgPt+LFzvf560Pn55IqDM5L3+q22ccwbGW+9U5M3kc8g
	b80Q8DsL1Q3iYpV7xxj1TQgOH7JUJtG6ePWAeXft+uxUUBI/4s2dNPjIEKgd5OTC
	v5N2Ap3VFqBYaIF1FVlHXQ+QQ1+hJRCT63w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794597116; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aEpikomkRfX15vqCwOQfsIVQTmdqEv/HCt+4i9DKiRHatPK
	oWJkmH8nv90ppAVPOTKTAP6LsB+i53hTd7b/S8v8yD2Rqebxwky4x+V3nyOzCTv9
	bwRQJBvpqj0foC1lhEgGiA7wkd82BGTxA2z3n86ceOibzXN9EJik+PKjJJq4qbXr
	UsEgmOB9PnSgL4WCGF9xZ2/uQJ3MuzhzXtiX5LHTc5x4qRmxYH4oNs4DGdmzg9Zc
	dIHIgvATLD9N96qhdG2+n0xAHJHRlfGJvGtxFsgMR9goKdl7r+WsIcoGVNdd776a
	U+ntJKzVxvBJ5iJAmiX0SJz7oeOXkYOKeZrX5NA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TPizxloVA9RNX9YWDwymwjkW8u0h8MW3bylC2RzTHv8=:PY5ncXI+/eIs2EzKsbUGeKSHN3OHI4GGwOFPzwo7Ng8=;
X-ME-Sender: <xms:_GD3aqt7K6D2EinxaAGIr_cgXNUOI8s1q8KsClw-s4hMc134VD3yqg>
    <xme:_GD3amUwcKrGbFEGJMXj4XzOw_eFR0IojCZOXHyKUrGkiLpvAZ6QkBsiop5QJQUNs
    A-szYmf-VOTfrUAq_ysohXSt7o5IvtpUB3A0O34QbR1huElgotpwPI>
X-ME-Received: <xmr:_GD3auHrbTMauXkNUT-XYjgk2kbH-UGEEYekmQxnFLMEVMq9zV1HfrQDyOP6gSYe-4ohQkm3AEbd8yfNctpdHTChhA5ca-y9hiNO>
X-ME-Proxy-Cause: dmFkZTEQVgq1m5wjryW8hiu8zTpP0VtIeubD6fodrG+xjcfz+lTdVwQT4i2PZLHVPXTjWD
    kWxdoC0PNFzO4aSdcDxvuJ1vHgdUlrFkl1/EWdjNhUcVQWiv32xmqY/q4vq0zwTu1FeIZ+
    7OTHcMrl+iMO/kS73C7zCN3xFgNRtkA5W+V30kbAEGmbvzIsXRtotVi8N14VZoOcChHRVD
    7CLWKbzjf2gDNk/NK5Y8nEPJguEvmT00fNSWrAftpFwQYKt86JEr17v5RODHYvziRB9HwP
    RLgTMPQ8RI0ZY0niPhjHX7FNfgCAxocC4jbLCV5baAVEEM0el6kuGfxG7fy2+MR8T9vPM2
    5ZZTyMBP6gCiiDnurGcNhofiCkaYNlJMjtv36pS5pMWbPqRRO/bUKXlFgSAYlNjnca3IUz
    comV2NINBuYKKlCrp1R0jZpyFZJCGYu+8MDLeKb3tcAFO5bWlTPpRKbikOJe3VZxVkIIsp
    wZk0jIh+i7SnWk6+BBUngCKu8YOe/5z1Xe4Kb6kG6xhxXU9JYOHQfa/FQAsfx9FBGs6+ze
    L4ZUAYXpGM7kPK+J1cfxkphwY+tptb/FO093d/r+JJd8WbVAGprnxmyjWyJKHFzrmwVXkG
    PATqitYa46QyuHtMSGKNvHIoqTlvpgAmHmkAtHVpxtq4EWBad6zHu86Re1aQ
X-ME-Proxy: <xmx:_GD3ag2_xr76KvHgGzf7ptbyinkdiw7KhrsehWduLDqP0eJPvBfBcw>
    <xmx:_GD3aoPDVmV5I2Dx-5B-lTLBSf1xpeUGwygkgH9Rc0kxQrW3P_KnTw>
    <xmx:_GD3an5KWfQJk3v18ZV0qmyVgKw_xcb81QOKCuB5aowGv7bN_ZmeTw>
    <xmx:_GD3aq0zU4netmSbZ-25-czEw5C2IXhG8dX3tW1xm0z9_FHE9eqESQ>
    <xmx:_GD3amwMFzawKlN_PiLkxbTuu0uKktpuF7a25NTLFn9-KkKXKZSSezxj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 14:11:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Matt Cote
 <mcote@nvidia.com>
Subject: Re: [PATCH 1/3] connect: let write_command_and_capabilities() send
 a promisor-remote reply
In-Reply-To: <CAP8UFD18rTvM0mu9oSPMd3V+J9GBgc07RM91Pfh4RJqZg0s9aw@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 Nov 2026 14:10:57 +0100")
References: <20261112195858.53788-5-christian.couder@gmail.com>
	<20261112195858.53788-6-christian.couder@gmail.com>
	<xmqq8q2xhexs.fsf@gitster.g> <xmqq4idlhe69.fsf@gitster.g>
	<CAP8UFD18rTvM0mu9oSPMd3V+J9GBgc07RM91Pfh4RJqZg0s9aw@mail.gmail.com>
Date: Fri, 13 Nov 2026 11:11:54 -0800
Message-ID: <xmqqh5hkbl6t.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

> They duplicate code for sending "server-option", "agent" and
> "object-format", while each sends a different set of capabilities.

That is all the more reason to clean them up before we pile more
stuff on top, no?

I do not know if that deserves to be called "significant"
refactoring, though.  It would not take a series with 20 patches
each of which weigh more than 30 lines touched, no?

Thanks.


