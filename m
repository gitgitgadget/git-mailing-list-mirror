Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201226;
	b=kqiH8Tz8HnsGjy+KjxHcRugdQ20Soi9pMwDObVEy8vtdSWCBt33lYMWUJ0PPttc4Pv2R
	 hu66KkApiB2jwgP07Yr53veLCuP1kfR9/hKRZfmS+ypNyc1kIp3ple4xBxh6X37HlttuT
	 vI/Z1NODQ+CyymwGLkQ5wNSSv6LN05Qeqa1ZcCG+56+JTul2K6iggerDZSlJglTp4NSj1
	 MvOtsrvLGDcJ3ItKlsCpET2O/WA9Zdt7l2mc0d4wmFD53qZhfL6fPk+DGbWilPY/1Ijf0
	 JivI5kJk1u0wdLuPeHHmWy0+S/+qgN+oYhbQQIatWrIE63O9BzaMe+SD4LkzBkXbbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201226;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=E0SZNZXiD3XYnDdIIIIWliuhJJt37wT4uBi7RZB6mCU=;
	b=q/h0PcuWC9QFJnhaWi06tGp3i8qdBYXTr00G1kHs8D4dfiIy7E7d/PoSX7UXMQCK5JBd
	 sko3AiLyuJqh9Hs4P/9fBXqul6NbhH/whfHgKLKcUqmdX5+I1sQk2paToUqiWE3fs6k+3
	 imK2MIbPXnhaflz4yiBKc6CXuINg2FBIrB/QVUNaZdLxpV5fZM5s4MvRbobfOGT4MvfDH
	 xIo4+gKslsxmD26bCBrcX8thvOyugm6b9SGtzvim0/dW8R7JaClz9EIzLQ4hSPdfT7u15
	 C1dcD3iOgbp8L9zDWwfyshdowFQU8hzRs22EhazZI38dfjE7BlBirJc1Zll8BBC6A6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Q78FjkBT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E6Utm4Z0;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A8C606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 15:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Q78FjkBT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E6Utm4Z0
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 571947A00F9
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:27:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 11:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793201224; x=1793287624; bh=E0SZNZXiD3
	XYnDdIIIIWliuhJJt37wT4uBi7RZB6mCU=; b=Q78FjkBTvbZV8CVZ5ziB2adtxL
	zeDhxJBfcIew92sxn/FAAbj+KuJhqO4sE0aPqJoElvCRUNsIp9COWQdixX8fafvm
	+jGFovytynwfmmdg5pGd2Gqs+oTnE1YeWmioZyIEy2hlmcErPg8gHwqglg2onRFB
	LBVfbSCNIWTV8SSwW4RXEPS271ha8J4lRoeHM9Pn3QW0ljaPMwNgH4ZKiuYKSlyF
	HCpvfcUv8itsl1aTLwsWOYNeccvwvVYUo8aY4pNEmmBMnoV0AxpWQP/OXOXlyNAu
	jZ+jRr2Sb1aZoGWYgoWDHGKqFD+RQX6aqtbClifRIA/uIEKl7kQD51hAB60A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793201224; x=1793287624; bh=E0SZNZXiD3XYnDdIIIIWliuhJJt37wT4uBi
	7RZB6mCU=; b=E6Utm4Z0kP46SmPfPPl4K4yJ9VS5fj9AQM2Gua22FIDQn1Xl6Q9
	DdUk+9DeHAcRLXpyjY0W4Ya+mWbwgrUJDltK2SQLVHSeVnCsBETwbGO2WdvyXX80
	e5LPBypnyNU95cV5vy590jOaB8Eq2Wo7N4I/6dj+oKUwA+yICbO3nGEsHCeLclDS
	RMpc7SOPeI9KZ/JbJjdYuCHbb/AWPygqPZ5BRcFqLmEthX0Hnbdbsr0v8L3T8Eh8
	fBAAlobEaifaLgpikrgvbaVQU0SdIF3fHpEotwttykGBH17LoIRlXRuMKp1e3i7N
	+hoHMPn5JU4ztSytmgMvS/3HVqSEm4pT+MA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793201224; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:H3pwhOtKHYYgb4iV+H/wavR7heFrHP3eQWCxRfTG/4QRPl3
	GWSv8cAzhYJeg3znmW7nYMu9H2Iq9Ud8ua8XNSjdPQ1OFsR+9YX5RGkf1HkodYvL
	9vz1Epbu0XJK0Q1TUVJIoM2J5XBrq8HJPdu2+R0h981yN52WSnjBwmULWfcP5YDn
	fyziq9YZ8jBVX8wjQCF8Sge69D+1alves+Juc8V3uUyL+iLRTUpaS4V5QchlskZm
	2/58lI5IiHhnxL0PYmPbVbkHSRDKHsOMenSZs1/dqvQgB0p/zionhLEHGyyBATYy
	CtefXLtC6Nx0GIi41OS3LOKDtV6vSr7e2iPfQGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:JzK7Vp874G2Hlr/qXMTtH5SC9cIc7js+THaqza7leFk=:gDFIJG+NBLkLHE97LHcmKjshi5GR6JpvCGfBoZ26JS4=;
X-ME-Sender: <xms:SBTiampLOTFJh5iDxgQiSNwTa6eyLTire98bDOnViMXqfEhDxIQHsw>
    <xme:SBTialXGjW9XsFe_SIoQL8AeXfkNtJPgvgR4m_5lY731R_LlWdyVUUtDIkXOtLW01
    EwHSn-lS2mrni0Amb8S-43zOhfS4U6NnuvLSr5YMHgD-h5HCrfbqw>
X-ME-Received: <xmr:SBTiapaknrPJ-L4ieSB2sdY9TXnzeAFZRsAi89Ncjc0i7erk4yDlUIwr5t9IfVKXIw4uK3hxF1DbT-RZxF5SsUGz2t6_GNBf-vqY>
X-ME-Proxy-Cause: dmFkZTEyFLgwzijmu6W8fcwwjOrol8eWJrtZsvs4xDTvEFXSm7E0nzDFhSLFC4Fgd82r+w
    0M1cdCU1sWwuepO62akdQM4ZeAZBBnANoZA2tsofmM4/O+9QJYqNoOhs8MolLLQaf9wE7i
    oOyMaO2OQekfy78oyp4pf5ZBgJycQlsoyR/D7sZMXoNzin92AoLfFibKicDEyorc3t2U9w
    YKgcb+U5kM6qvt6Cu1oguZJDrNGWRUsWxtQiPh2GrRH/o/FwgxPLGoMcD7X12P66AoZSd/
    TwRTxWdQme+2j9EUR6GPJU2cVwuOsYBnssqNGhALe/+no8FXXoMYCNq98PX492iPJkxSqb
    3/uVD59vTdMSt6yw1EPZkXszNC/TsMgmJOC1qg+cY1n/LhDmOYO+jQG8B47tv0qEXI2LR/
    qgmfJRrg5tjdssY3cCZusw48Lgvv5NOfaw1dw2niOu4ogohVmAZRzbU0d4GE/snBrB2wBe
    BddKs8wUWvK6j8aQly849IwNMzl+WyDpgS0sDGUiL1zvmdr+tfKnxzExzr8S50n2o+zx4e
    RBuwe3u+9yhGI7+0ob1gHP1VDcdK86xEhJj9RPlgrapETrSZwqLYbOPrZptFgi+K8zDB7O
    E71uOGr5rirAFwWAzosDxLwJ5Eid2nuuh5wqHvVsCFopn1XwnsXMBo6k59fQ
X-ME-Proxy: <xmx:SBTiaqc3ACNmLrlD_epjF6LgGbLGBSGra3VDUqpv26vLljJiDi1Nhw>
    <xmx:SBTiar0X5qwQbxz6I0v4IyV-_wGmusSi3FOUCiDXyjOUdJqVCmTuAg>
    <xmx:SBTiapLk8K23HMKl0HCwbg32KLDbdcsYwvwbt4PgfKQXTqVWUdkl1A>
    <xmx:SBTiaiE8EWOh73SAah_7PAW4jeYIXcFHn7l5HY9O-k-92NuqKE8Y0g>
    <xmx:SBTiah1KYtzQ8hRJpsCqqV4R3wa1HDtsLWzPf_Bg14wxYspUMG-GAHyi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 11:27:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: phillip.wood@dunelm.org.uk,  Jasper Mayone <me@jaspermayone.com>,
  git@vger.kernel.org,  haraldnordgren@gmail.com,  ben.knoble@gmail.com
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by
 branch
In-Reply-To: <CAPig+cT6rxKptqSEKuVbi2FafBqh+DfcHAkHfz2-=SH3y2hfyw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 28 Oct 2026 02:02:55 -0400")
References: <CAPig+cTZEcn_5TG0iMVJJym8Zhu1KYP+y9Oc1J=JJgDYSzNSdg@mail.gmail.com>
	<20261024165311.57387-1-me@jaspermayone.com>
	<e08fd267-7017-493f-8f1b-d8dfb568b5fd@gmail.com>
	<CAPig+cT6rxKptqSEKuVbi2FafBqh+DfcHAkHfz2-=SH3y2hfyw@mail.gmail.com>
Date: Wed, 28 Oct 2026 08:27:02 -0700
Message-ID: <xmqqik2ldewp.fsf@gitster.g>
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

Eric Sunshine <sunshine@sunshineco.com> writes:

> If so, that potentially raises the question about how such filter
> options should combine. It's obvious that multiple
> `--filter=branch:<name>` options combine via logical "OR", but a user
> might want to combine future filter criteria via other logical
> operations (AND, NOT, grouping). Do other Git commands set precedent
> regarding filter option naming and logical operations?
>
> Note that I'm not suggesting that this patch should implement such
> additional filtering behavior (it should not), or even that all these
> questions need to be answered right now. I'm asking only, taking the
> above into consideration, whether this option should be given a more
> generic name to avoid closing the door to those possible future
> enhancements.

Perhaps, but at that point I suspect that the most general form is
to allow you to write a callback function that is given the path to
the worktree and determines if you want the worktree to be included
in the result.  Then

	git worktree list --filter-command='
		test 5 -lt $(git rev-list --count master..HEAD)
	'

may become a way to list worktrees with work that has more than 5
commits to be massaged down to 'master', for example.

"git branch --contains" etc. can be expressed inside the framework,
so "--branch" may become a special case for that more generalized
mechanism.

I dunno.
