Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769432;
	b=E25gK1JUNLqz0Epu5+GEi/SJUWaiQgGazZ+hBEvgXCevueH3Ck6Fb1Ms0gPb6ovKSfJQ
	 AfGQe8ZjxPw7f+V3nxvauWIugg1VTXc7L5U94N0micWf036DwGvZ9zpmfWSNeU3KmD1P/
	 5ZlUvN1q8r8BQMo3CyvwasBrQb5WlY4ixqZO/Fa7dgaxmYRJFQ+aAH+xbD0uiq9Mc2/fM
	 J8PIhpCjlKcRN5KQxcnWPNPZGO2mRMU0HEv4HzK3+fo/szg956OhMTm7tV9IVy6GHspg5
	 0mAg1wdBTN10/TZEuiAsnvGqH1NNUFbS4f0H388op3owGcnz7z6w/YKyuNOjdidH9VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769432;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xwBX6SSI1RCXBc4KJ7JdlV4rjjrtLd7suQ980TOfQRQ=;
	b=ga9PyT/AmZB3XHJHNGv1MVXPbUnS2vrKeCSx88ErqPUqyaLjHFuW1mi3L12xaiuKILlj
	 eMda6YAmtEz3L0YTrR81HNfDLm+qc63mwEDmbpHfen6nYy9uFuDtEECUmxUlFH9hB/27d
	 EUb1fCsnRVBwlREQOdREECnV7ZqHbXH1No4/De100IDvP00HjeF/6JpiYgvnzavWHF9Ry
	 b7hBsByGFvDO7UiIN6h/OL52jN6Q2joRvk6+GdlLNDOmzofR9PvuKcTkWbfhIWOER8Vr/
	 Gj+48ZtTvNMKTcGnt3CnpS23lpKY181JCRAHmTqf6THmUzU920moJiB0u6vIDLLvjxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V8whZr69;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g2QJVnEL;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD9606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAD9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=V8whZr69;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g2QJVnEL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1064414000F6
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:30:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 11:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792769430;
	 x=1792855830; bh=xwBX6SSI1RCXBc4KJ7JdlV4rjjrtLd7suQ980TOfQRQ=; b=
	V8whZr693hbX4AxRpSzbQgmaYGuWh37Pwzd+PezSFLkq3HxnPdMKoqQeqKqvqeeb
	ha9RddDxrYfKxGXHsrwVnsY37xD7Q0T2X5CLBb+qmLTh4XX2Plk6Sxh4W49nx6sx
	f5usF8emWCdJmXK3zuY7XF3gE/wdfHSzr6woQlRBtwTC06sZLHFSH3vWXXG4/i1z
	RMpprJ+E3v3Ozz5fjrJYc15dhBgWs/a9UVamOdHwPFUbfDtmCY+Py4kCH6nHgKvV
	J8yokapOOEvXrfOih+xJYYFOcW/RHeFhYWyPVRs41gBl4jqwIpPQEzL2cOWnCVNl
	F+l5ECqB7YZlcV3+TT9PlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792769430; x=
	1792855830; bh=xwBX6SSI1RCXBc4KJ7JdlV4rjjrtLd7suQ980TOfQRQ=; b=g
	2QJVnELz0BgDLtZwLAAAKgJ/I5ezyZvTRpVCeZOGhPrGmlbYaRsyf+hyKrGtv5Uv
	s45maJvxpdRcIVEBWG9MBip74A5jqIVqi1BHXUgFrn8fHA1NAClOGToNK9JxeRxJ
	MAKzREt455H5rHKzq6rwpq5n2HVzg7VTTgsAbUxe9mnP7CuC5vCONfyLWlLw7EaQ
	gR1ezvCNhfB/kQupSrfcogV4JXt+VHtFs3PAodS74gW/5khBXls7AoCRINrFiGlv
	lHZGABD1sHCeswQ7U1F65esqTOXefvTK+iM6PHloAcfKqkR1HtWj7NipVNMvNzLj
	p19O6gtGuLLNTPUUrpXCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792769430; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:phbOheu2LA2CJLxlsTlcnI6iuugPngTbuiOGcniGDrZY2ma
	IGaClhpnFMOhMptNsVcJ0KrpPqKL6QjV5r+DJyELAOdgZ5Yz2NG/bcHGQj6MMAl0
	bt0U1d0Hr0rCg9ffnMCNQ4H2/KmlvGGO12oYSdZBBHg2a3ghBE5woR7JzjyGymmD
	rFtFfYIgTtYA6OoE96a2N356utn/JM//1ilhfyef5izXmznQWReyHI4iNZd5Hhaf
	MPENNsIcCneUFEQXiMvvkBSV9yL01LzRoEQFXpXnLlo0Grxo26XHpMa4ugSd0mLW
	AcGOdvV4F5qT9ySOicABxFKl2WiMNQ9r9w38lPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:vsQha/mDm2foOGHY/lMwP2HEXuRhWR7XRiJ2GpYd/AY=:Ok0e+PTkl1/0tjGPkJei8yPJqYYB2d1UWojkCPB8Fy0=;
X-ME-Sender: <xms:ln3bak4U_xbJpmH_QI5_Y6HmzITSdy2AUxpofzwOU-YH_1M0DI-1XA>
    <xme:ln3basyf7m3-gQJ7nrfGQzH0qiDGBL35kJB0vbz0ntLd2bk08sdYfdcjoZCoW6K2I
    L00__df-R4xrosKpsP4qTbJhbXfySVv8xeO5TyfjG-yNhNw8VA3Q38>
X-ME-Received: <xmr:ln3barzkTQ3SGSWU3NnFLh4ty0JuEvwQd_IPd2Gb4yTTs2GOjhkEn-Q9kqQVivDhzXT1J4ObKVxMITh85eIRNjF6I2uj90Mrb84Y>
X-ME-Proxy-Cause: dmFkZTGf83e4Opqc4ToSPDnQPWY81W/aOyPPdiB/DMwUGFPftU9FZNRDsTuLhY/h9Dh6yQ
    f2ubA8zVeTSJdPv+bHfSvC6316Mq7b1wnY3nTN88f/g/Ms7Xlk9o74ycwg3qApdEMxsflH
    IS0lHdTkp1NuxvqDphaw4TQwJzIv0oNdu7XuRbLHUom+6qmWegdf+/r4QxKe6SL4g/8sHo
    JWQTlCXHzYY8XXXG9RyP6DFL/sg52PIoEP5PEwB7Z97x6T/pV8sKfpa/TZFwiW3ZHPkUS5
    FFAIaNkflNIqvRPiIimwrlnGu2AGCRxO1L3v+OV7wcMyAdqaEsQOZSS2beDXDA230/zeI/
    lOlU+RYXwZMwJu9aGHynhDgV7q8rUBfNvhdT/uLWgvMONIr9BN2nhrQWs4SCWrbLpA1tjv
    cpEOyrl4hMl3YlmB5zJQ9tuK0aj6jKlSOJQf41DkdlXxXVrsmqxskPc/ef04oK54kSCG7e
    LPBlh8eZu9sKeccSIhABtqxA0KLYGPjE2LrH05kdJGF8+DkX1AdsrZXFL4paSOP5sZfDjl
    fN+4bu2bIzDjDQLy6zZc/F8Vd5oEzrmg6RUbykkkwFeVeJ6FAGw7DnbOZxD5PtqrE+v135
    kXJzXOK5+tafID6yEL+QOnCLKYtoHMtONjXpVL0T2oMtmCwL2xXhORccnxfQ
X-ME-Proxy: <xmx:ln3bakx2nBCvQ-1DuALxDAQivcSZWIpxcLSu8eKCKWkfhRiDQc-hGQ>
    <xmx:ln3balZjDNCFvDpZkk1hgXBii0hhGCyT6Of0v4WT55qeOI2gaN1k-A>
    <xmx:ln3balXpyeEbdK_ra2FSVY4Zpaa35_RnZYJRrdqNCklfOyq8iCfpFQ>
    <xmx:ln3bajj_L7H3K7keGtCIYTGldnPnVTkFFgrkFbZ8Hi_zwLhwETcMRQ>
    <xmx:ln3baoAvxYEHi5JfHHk3TOVDHaUjOjgmQK-ov1DVFfsciR9pAbGjTR_N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 11:30:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Srujith Poojary <poojarysrujith@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  Srujith A Poojary via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy PATCH] diff-delta: use safe integer arithmetic
In-Reply-To: <CABh_KWiKmXP4KTgF=k2gGdSvcZXkRipD61AVn+AS7ZgvhcjHWw@mail.gmail.com>
	(Srujith Poojary's message of "Fri, 23 Oct 2026 10:59:45 +0530")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<xmqqld7paty9.fsf@gitster.g>
	<CABh_KWiKmXP4KTgF=k2gGdSvcZXkRipD61AVn+AS7ZgvhcjHWw@mail.gmail.com>
Date: Fri, 23 Oct 2026 08:30:29 -0700
Message-ID: <xmqqtsmca0yy.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Srujith Poojary <poojarysrujith@gmail.com> writes:

> Thank you for clarifying this. You are right—st_add() and st_mult()
> call die() on overflow rather than returning NULL.
> I will update the commit message to accurately reflect this behavior
> and submit v2.

Please don't, before making sure if it can overflow.  With the
number of entries capped like this:

	if (bufsize >= 0xffffffffUL)
		entries = 0xfffffffeU / RABIN_WINDOW;

and then computed

	hsize = entries / 4;
	for (i = 4; (1u << i) < hsize; i++);
	hsize = 1 << i;
	/* allocate lookup index */
	memsize = sizeof(*hash) * hsize +
		  sizeof(*entry) * entries;

it may not be possible to overflow size_t even on 32-bit platforms.
I didn't have time to do math yet myself, though.

