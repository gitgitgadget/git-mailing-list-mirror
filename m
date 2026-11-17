Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794949581;
	b=M68i51FJE0N9eBK4zpjPexTMBsTL+jqxCNpGbvEGI+FNouW/JasFRLAtvfgfYfKaMu+c
	 UjlWPuj6sayp+2ZeN90/2ecctASfFK4mgk5JseGL6mCHpzL3OmKVv+fQMMr/dsf9tau+g
	 MJFXxtAdsHDzUvH0ameoii6crTdHv6bVhENcxz52L/f38jkVZS+sXuLaNW/rSlsdGoONG
	 VAz9v7AI5AgrqDNhmKuM8nD/3TaiFcOkf29zEzQCkqn5chJbMa62J0GKicu97O+XyLSM+
	 iJuQ7KQPysa4cqeKrOJpROtzzDfWADiW3jd5oczz1tYCCWxLrsvnmRIi7rQ9v6CKyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949581;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oWGPYn5IYiZs0hqw+mmrLnCoc3I8ZYxTOljywvjJaAg=;
	b=dIuxB5u5rkXW24w1yUaSqZYsB4nwENO2EDwtLbA+afX4f9eB5zuyvTHLcjODyKdQPEvs
	 8DjJ+nniYSikw3+UbKzdoGMfJG6xm0bz/HgjCSCkw+I07+gNgW7TyBMluIGrVGJqRfcxU
	 449xxdH0D37frHtxhUSF9egj9l6Un7ftLfnNBtfF5+AGp7SpFBw4UlRFU7UYa8ExKaPuD
	 pgjvzDbFQgxTUzg11aZ+vgYHT++p+syUJgvOs4qh+9Svx7tXboQ/toVJKuLZEeHycLd9B
	 6ZnDLDLVvZh8+nhw4l5N9qp57YAf1bLkSS2WFRHNXv0mhINOTnh+TnaH8Fdmr8Dw5Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KS00wX0Y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tbJFrygt;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561B606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6561B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KS00wX0Y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=tbJFrygt
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C087A1D00268
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:06:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 16:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794949579; x=1795035979; bh=oWGPYn5IYi
	Zs0hqw+mmrLnCoc3I8ZYxTOljywvjJaAg=; b=KS00wX0YvLhtmJFlMGWVdAPQMN
	53KimeIl70JlqsK9NTlLmdGzyyGW1mh7vZNu+XXDoA6hHiw+ztsgA6/+YCl/sBvv
	zZiP04HTaAF1S74/SX4Bq9HzInv2d6BCf85kKMsN9PJTH7FfK+WvCD7qYbvTdEzS
	34/IXDjBNGtRP9TV1IUlc+QkUxwzgCizF0TEJrCU1FkV96KrhMiTjk7FSsBmv8av
	f4Pvl6U0fqqYGk9+UPmK6mqzJQffjlHbpdEoVfA4hsKRd/HngyQuKrDc8+QwMQ7D
	Y67GLSQfbD5164Wd1Xq5i/NJX5VrSmOQH71UM4WYHRl55nDqvCXPIPSoTPqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794949579; x=1795035979; bh=oWGPYn5IYiZs0hqw+mmrLnCoc3I8ZYxTOlj
	ywvjJaAg=; b=tbJFrygtxToqxFZAL2JufyD3lsB1gP6LEDt5qK17IORnpyrkxJC
	2IH27fiD9DxaYelPcqpl1n/EwTnNw0X8ZidLD8PE95adNwu7BSQ26iS0mEfr2gT2
	c8QkkrVwn8cwQ1pg3U9a+RJsiDGQ+evW87ENRaghUBSqmQKCq2Eqs9gW4ARHZIrg
	ynte+qu738rSauWUUSUjquuM9KDuPhNvMtDp1krH/sf1Tg1OCOnIDRrAQ/uRKTNM
	m+g0lE9YqABu3fTQH8KU/wTu/lyPxt/AWTKYtvBoD2ix5+f1OYN2cQCzLq29Jci6
	i/etLupJJb15X74rHpJGHfqhRmqDXdbRn8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794949579; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JQkaf9tT1EerAAYp7D+7EmfQI4udANQ+LUjOESPQ9mgSyg6
	Oo8dQAjnVQFoWM42OLM57hlAmuE8Y9n35xrljyDwuk1ZVjTPicNhgYdyhcwkFSra
	YKfW+G5m6sqtYJU2EGSKsPFv8LEOZvOfFEUBKQsD51M9Z3HisH5JFdop5PjZOS89
	WD1hzhw0Eeb0kP7NqexDc07VCRsaTtGuJSy/grvIgntOw0GOT+HvuKs9iBU6Misd
	BP0Ghl7nkK6ej5EYV4CJ6ydFCs6+EUMNLJ+yEV7z2WsI0vTabZBhVWDcRm0PQm22
	UEz2IEqesY24X8qAZnSVQ8+flVVh8Ud8oe/9Rqw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6vXsicZ0xpf+0SqCeH0jxQBJQd2UkaZrzn8uezArfxA=:hOhP3NwGO35OxbhqIZob42xQVdiB2/oni4pNx8nESEY=;
X-ME-Sender: <xms:y8H8aoJDrLLd8aElg8mxdFHWZxjxP7TY5GYFShIlr7pNpMD3Oyr83Q>
    <xme:y8H8aqaOpc7YSSyxUv9NFpx1SezFFysQHjzyA7dW77YQntu8T8Elh-FYQ4gwsvIYO
    c1MooXMCKc3vb0tNDdtQfauo7bUPrIm6EuO5lJy3vAE4Zs94me0ejeY>
X-ME-Received: <xmr:y8H8aq-88hp-PfQQqYUQiEyV4PD38ox0FCdIPlD12HqT-fNodr0J6tfWYs5iw7k2pDcPJkHb3cQ_mbJqEqOc3aURPcYHALD7zFTg>
X-ME-Proxy-Cause: dmFkZTGGG13lbDjDIAiJWEBkBMB/+K5Y8gCfjeMFYmcYVC8WmerYLepJbn8cd8eSKTukYP
    g/9NLZlHseO7uxO/JiEF4EVA4L7Y4RWllWgOBONoqpJ5n9jFZ2Hu0bUjHS+GnJmIQ+kAOv
    PQdFgcN5tAP7ItnpyV9qYnK2AIebADXVTpv5FOVb0gsgf0t8zX4K/VUUm35LzYE5fYATvE
    IAKsVkx0Adwk2KMf7OPiI+eDBSgqkNEEJD5n4S5S8GNJN2BFD/wSiru4VL1pUmnTvJMJl2
    c60ZFjPZ4q43bINrfPnbed19EbLzw5jXnBe+JX2jEW6SpxEOe35ptAPYE37yo81xCglqgr
    aJuMhjaeAe8eBh/zMEYdwtwrAkgImzt0gia2VVgSa3F36ybUi3AF9/rNlY4Ya7iW88WDMA
    YDPPFrhvtMLecJqrCNbKSTycg97CXadVAVi8ICBg++skHL42QZydf2hPtHZmeiln0t8d/8
    smPzhBen48gqZctsMX+fGpMfEZrsAQxfy6IKBrfWUBePVAYpHgTuhbeuVCfTKVpfT+3Yyy
    3sZKTTkVtG+ayH9zHbvUtrPBAfbviPwjXBC0zurQAsxkgKHFO8UC4D895Fox0Ak3fSydYk
    sSkfCb/U6JhM1mtdPGZIaabh9ocHusFuFCvxXA9FhMDenZ9SDFNWvzwM7o9g
X-ME-Proxy: <xmx:y8H8arb-4tAotJ7qCMmE-B-3Nitir10KekXph-Kxxgf43XXGNkcOYg>
    <xmx:y8H8auPL-syx6zAV0AkAK3G3zv1dxU1xY5jOLZer65DCQdwCEhKDfg>
    <xmx:y8H8anAhiLvVC20rOD2tGDZ2bPk1z9vOmUKNCfKVPW6z-EdrpC5EhA>
    <xmx:y8H8alI4G46yjyJcVb_Ujst3vYKV2EtdMV4YViBnpi_obNXAYJyc0Q>
    <xmx:y8H8arHGm52yLpsM6lw0zguwLyA2w3cFff2M4AP7X4XOccJAd2jBJQaL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 16:06:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Matt
 Hunter <m@lfurio.us>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 1/5] fetch: add remote.<name>.fetchRefmap
In-Reply-To: <c40477c7-e1d8-4af1-859b-b739dac4bc86@gmail.com> (Phillip Wood's
	message of "Tue, 17 Nov 2026 16:28:42 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v14.git.git.1794681496.gitgitgadget@gmail.com>
	<c63699b40228b1d47368778d7397b1ddc6ba2a36.1794681496.git.gitgitgadget@gmail.com>
	<5a1a9f6b-48c8-4daa-9059-bf9459587a17@gmail.com>
	<xmqq7bibh3f5.fsf@gitster.g>
	<c40477c7-e1d8-4af1-859b-b739dac4bc86@gmail.com>
Date: Tue, 17 Nov 2026 13:06:17 -0800
Message-ID: <xmqqfqwzcgmu.fsf@gitster.g>
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

>> I can buy it if the suggestion was to allow passing --no-refmap from
>> the command line (or would --refmap="" work?) to ignore .fetchRefmap
>> configuration, though.
>
> I think --refmap="" might work as --refmap overrides the config and 
> --refmap="" is the documented way to ignore the ".fetch" config.

Do you mean ... ignore the .fetchRefmap config (not ".fetch", which
is used as the default for refspecs and not value to a dashed
option)?

All that said, it feels much more flexible if a refspec with a
destination (whether on the command line or in the configuration)
simply ignores the refmap.  In other words, the refmap would only
apply to refspec entries that lack a destination, leaving elements
with their own destination untouched.

This way, we won't have to worry about what --refmap="" means.

So I'm completely fine with going in that direction.  The only thing
I care about is keeping a clear one-to-one relationship between the
configuration and the command-line option: the configuration sets the
default, and the command-line option overrides it.

Thanks.
