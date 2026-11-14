Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621293;
	b=1RgIRtJ1vvUWirWyeH4OYad0WLCsODoBIdioAmuQAv+wY3IMRdk/6eFYkYpC/mi9TCVF
	 ZPpsU+9ijiu/e5rxRhZWXeY+SvebrboNSXS2GLpSh3sB4eRkBSO19BGjHSjmqLY1lU6vP
	 pr3ykYBGjLPOuTMlis8cre6OKZVYenuBtLGIROpa6tVDYbS8BOM0l6kSGi2i8eWuowgZv
	 zpffNjko4nuTLCHIUqu3fepFoitARsJPw0oPZGkP3JHkcjSLG4BPU0FFocMaDKfk0YRes
	 bowOp+L0U19xbCF4xXLwJ95H6ghOYZRYdh/Q3Y2EgxR0P/T2Z+YxI7yC/MEZS0SowzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621293;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HpP+52LIOiDdFkpfsj5zXJwy0r+poxw/pP2Kr4IW+WA=;
	b=Qb6X7QhLuPixl4kSddz3GAs22yjroceGN7o4qOUn1WXWcF2DWEx6l6RFsQJY3LBYO7qU
	 qvyfOV3gW3GkU6dpua69zdF3d3Mnxm5XUlXLlHPftsS8OZYpnte1zA+QOcmG+aeVFwOw4
	 PslQB5r0kftCuZDPCHUenG7oBuAwiceZdpM54ZZcIEAZ9oJzzDV3KCJrU6YwhiTgrS0LD
	 ZfPLCtZQbfy7w2KG9pDQQdwQaG1fjgGyDiKFRx5dbtXnFyCg+Z6hfBS3f6g+Mvo4fLxHQ
	 GqiOjc2civU/SkiLAy+ZxN+wxpOdoIiS5Ky6rAus2DCC1zGYW6yPUsqDS4Fe6XZkKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DIil2+wd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JCmRzKNo;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC8606A33A
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 01:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2AC8606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=DIil2+wd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JCmRzKNo
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA33A7A0035
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 20:54:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 20:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794621291;
	 x=1794707691; bh=HpP+52LIOiDdFkpfsj5zXJwy0r+poxw/pP2Kr4IW+WA=; b=
	DIil2+wdTLn7LaWFmZjUI+nAIivjxcmoiCYusMyvrfy2dhfmbHkaS+zuV6DOfwoJ
	y/HQtuD33WZM2vPu/rtlCN1eRe8rG9wPAgzEzoBevRsOYHPNlQ8B+iVoyMaGov0A
	j1RRddpbVF1XlXS06U6G8SDQxfasIczrfVhctrlMuvKj0yNz9Bkz+juINR6m/AG6
	TTsrcXRC+iTM/uNT5rRM2Go7kIPSWGERZ56AXesCpEKi6syoI1itCHb76f1TKW6c
	wNpTrqYd0wL4W+oAerJk2i+B3P+gWhJAtKSYZcRnK0JqB2A33kU+vNwoQZZYKBVi
	PntX3KgNHMEPzx0PriXoNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794621291; x=
	1794707691; bh=HpP+52LIOiDdFkpfsj5zXJwy0r+poxw/pP2Kr4IW+WA=; b=J
	CmRzKNoNHU00wfABX7cMQ4PtlbpyrollOdqNKrMz2SPAta6IvcYjB5BbknsO/mdI
	RHeAlBUrnhNFfKXay2FXp5J1xZHz6Aam0+xXZnm63AV8RaoiPu7vd3KdDoX5FUUF
	9y65f3gieUxetOaoLfjoNgq8ycfDtdE857pBbE4ZF3DQA4t9YOMS7LaA7cRHDeuJ
	0DCyOAicEUraVPXl31ChPfVt4PZMUTNGuLWfDYUZ4sYPU6by6YWKSN2+msBQuIVW
	1jhlhdZQjXd6ywbv42ZsctMuS+3VmvQHeAaRXM4TwsBhRgXM3bx7+ZN5x9lHmBzQ
	N3sWQ0plyS2kzJmcEJdzw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794621291; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Y8kgWhEBjlQvgdrdzg9mTITsoqcbZjgTIGCPe7GnrRMx5tq
	mLQPLrb9PnqJOyR2a3pDaJ/s3iY87T5XYr+mb4iEYj4lmZSo358kgu0Zj42KZ3sR
	yH9PpdKqhi3V8fctnCOxzr/6pe/Mb4raG1J6lnDYEcUT1grjtz5Fcu1tbnRKDKrc
	maHpak3Pww4N3RPuoi2fT1T8OksjNPWioW7yR7fGko16+JRvPKv9sGQsb6J8dOTg
	Rih7TdMT5WxR/bgUn09N6EwMqeoqy6kJWW7WWh6wyWhvljoI0erNPMptibgCKYwj
	zC3h662UCI4KqgbEyx2gxfCObuU1x2WU2/k0/Cg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:NgraoAX0E8NnyjHy2JU3x/rEkGVdDlix1BPYyoJvxas=:sKZ58I+dkecW8II/WzNhlUSGhwYOcTv2VI9vbltDjtI=;
X-ME-Sender: <xms:a7_3asRIAltYa1Sb09aBrJU5QAWNTaXr2a1Uu6f_1kOzDodwzZm-iA>
    <xme:a7_3atdUetFUfdTCyIosYm5_V70oXzwc1oDXQx7uTsAww1rzGfZQK1Hki6QAJTD9e
    yQ5wTjvbfR2GX1wTG7pbXo6k9piOR6crWy4MqeZnHshm-9Dk0Y42Pk>
X-ME-Received: <xmr:a7_3ajqkRgpqEEKcOqvhkRzH3HXuAutG11jv04QfH1ay-pIzuEQHJFredg6kO0uUFynrX2b3Z7U1qXgqADsP1xu_y_zOC2fSE_wo>
X-ME-Proxy-Cause: dmFkZTGeTdGZNmSJnv/++4SYU4zeCxwSEmp+DsT492ims7AA9Dp1823t1lpATusGZHn52i
    cilMjseu4k98GfSmv2yWFJiw1gn91sxwRXWMAOT0wc79MBPqi7e8q4woqPTSMWE8yUKNAV
    kdSzxaUD7Cm/sZyAbLJRTahcid0TST+mP+qrHWodFBTmivmmzVYupCqwbG2z+B3PEljFjl
    m9atBbZ4PIaz1EkH+OjsBSDPH2teS1jxSV2lWCCypdVbdGeRHHlwzU14uY+4jio6QJ2QIq
    dnoV+BIdxn2Cc737B6503PLpQcWraMrACOM1VDETRIvFjrsqvWG9X+v7/IL02PxJMwbtH2
    YoD+bzFJOPSMlTahYVaIg8cLoIPGXuAt7jn+xPyPZkmWu7qzqgDTizL3mujM4Zqy+F9KT4
    c71VqdLZ/JEy+iyhiY27vn00fubiIP26l6yjGtQtgdzLTUv1a4NBqrr8ZqB8jQ+uudFlgo
    9d0WahpT5KSKIyJKKkxZzVlOlPyXVVeXIMEA3czrUVR6iKMIfLPBT4Cr+fiGQU1cpIBhUu
    NJnUzaeyWcfdk35hVqbsZslzXK+4jwijz8zNhQ+//B/z2Ga/jf8ETQh3UtJtNu37AJOXwT
    sOYmqHeSOmDv7kKHQfZt0L04e7S1E/+1Kx9AyP6N65QyMthVlTpaU6Y2j7rw
X-ME-Proxy: <xmx:a7_3am94BW3cACzcQz-xq9oMz5VsGhrXnjnMM7IYUymSWxdhS7-knw>
    <xmx:a7_3anfQUQSUQ165APqI9nvcKZdO6IZc8Qu93DXLzm8yhN6K-u7CLw>
    <xmx:a7_3aoLLBEfkiimcxpcx4_yTLF-gyTl9_nnwr7pyb7zyMcsMnBYHZg>
    <xmx:a7_3avjowfESD6REhxkfaYYTSStxCgkBRmNyBF52MWdxNzvssFe9Yw>
    <xmx:a7_3al0Pgfp1m6rzzPHfrnj2u-wVELcJALRTmsgFwZ35u9yBM2WZbxIT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 20:54:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca> (Julia Evans's
	message of "Fri, 13 Nov 2026 12:57:56 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
	<xmqq5wy2kqhl.fsf@gitster.g>
	<931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
	<xmqqik21j1ie.fsf@gitster.g>
	<4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca>
	<xmqqfqx5foxd.fsf@gitster.g>
	<36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca>
	<xmqq33t4fxx7.fsf@gitster.g>
	<a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca>
Date: Fri, 13 Nov 2026 17:54:49 -0800
Message-ID: <xmqq8q2w89ee.fsf@gitster.g>
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

Julia Evans <julia@jvns.ca> writes:

> Okay. How about this?  (the added sentence is between the **)
>
>    For example, a data scientist could use this to run an old version of a
>    data pipeline or a programmer could use this to figure out when a bug
>    was introduced. **You can also use this to make experimental commits
>    without being on a branch.** By detaching `HEAD`, you don't need to
>    create a temporary branch.

Yes, taking the "data scientist" example as a "pure time machine
without touching, just observing" scenario, and the "programmer"
example as an "inspect and experiment" scenario, the addition of
this single sentence is sufficient to hint at the wide range of
usefulness to which this feature applies.  Nicely done.

I think this is short and thin enough to be good material to be
shared between the manual for everybody (which would want to cover
wider workflows with possibly thin coverage on some and thorough
coverage on others) and a survival guide for those who are lost
(which can be more targeted towards specific audiences).
