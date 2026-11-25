Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795568646;
	b=M+R+l2Jjei8KwpROsELdfKeyfp0ZA0XyCv67tkOGQ6v8Myn3gsv8nIJ865d3bzkTRG5F
	 ZsiUNEZ57ABoHZPEOp9cS9+ZrQx2oQRITeJLySVcxlrHT6k1JEXKnVEfmZdri/HANMbZk
	 49eJyFVV/+qHwxoADR44l6DQlbTgY2a/ATrOGQvr4E25SzIDGlx84/jK4PYFubQGfcj8P
	 tPSyjUqKg5spvEQoQSru2BLrC35XAQ5VpcL9/eNpbqHqA2G/9a8+M2TXUKAwRCypL3uVI
	 jVQFH7DZXodER3KJQNAJyIZxeIrkMQmfipd8etxgzQ08v6tBM+9WuCyxpUqHbUqzWWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795568646;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=pcgoiEnLYkWOs3KffD4hpLbQKbvSiLSzoP1ycjiZxng=;
	b=Jnb9fD+r7E2OeeEh4pXFDjf8roSjmPCWXvG7+lmijMgISL6EdVx4dapUAmYK3/l9TlH8
	 GXtlpIgOy/v+oW72w8RZ+DU4iYs8Oj985VMdl+X5b3Byu+C20NQsCWnAhubyJ82bXoPzh
	 LVa52FasDajfX2uxe3VzIx/n69blMLNGbR0EKBYqZYStS7YmLnN5iaocKTJQobOxfg3hh
	 9CqPlhKZTaSxTATXEpZ52w32mq/q4JSslHniGq3lYNRovNMnodzidJ0n7kJ0HwByJgIMY
	 YKL2ceTB/H6N/NCVCC8Xccne8YTQOFPqxStGxQFKSDkktFFoXDIaSok4eMJE/KrFP9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kkf2SY49;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Je3PMJcx;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08412606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08412606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Kkf2SY49;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Je3PMJcx
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6E2671D00622
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:04:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 24 Nov 2026 20:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795568644; x=1795655044; bh=pcgoiEnLYk
	WOs3KffD4hpLbQKbvSiLSzoP1ycjiZxng=; b=Kkf2SY49kfKp4Trj4jAyWxXRq0
	IflS7pV6PjjVHvjP7/i/CeECpTTIwEX4tm8tl1pVlJMAoM3citA4xsT7C/Nnu11u
	uE8Uo9V3DLCKbw3NMCavOENkRKmrc7tQ55r5FdBu7SoBKczA9Yx+Ty9XH4czUu78
	zxyN3sFhaSA6LC2KH1VP2C1j1EmNqELHVRpBRqOxG8nogQNdCUvTL5EgaR7adp7y
	qU8UJmbRS0kXidjS9YuJZByCrimluUKowYiSPa9aR6anxmTQzy97c1KOl8noipwm
	pQiIG/FWYmgMsCHHnzfEA5ESsCtD1uyOQCLeqyW0V4mH/wGmm2+lE+bppLyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795568644; x=1795655044; bh=pcgoiEnLYkWOs3KffD4hpLbQKbvSiLSzoP1
	ycjiZxng=; b=Je3PMJcxKrsPzQ9gTrodM8TeZbuxZbq980Ll814aAhAMeZfV9y3
	c0Hz+FLtFDiliJi2h1c6ezusmcaMDU2IVU28j4bumjUvDL3WWnn2pjDIRrzYD49P
	TQOq2qfi84WlEl+1WeQj6Hff1MSZk3D4w5HhwClZZivThyF4mEZt0A+pEEvmKFoz
	ahMU7OIyOwCL5Jg8QXEoc98PE5OH4ZgzHithJG1nq1AiPBdHQl582wuIDxFaxUH7
	2SYuO2nj2gLRAb7M1bqKvhFnrV/ujWXsRlfxsSlrxtl7zC89P8watmiyN0cX6Xbl
	LDQ1pFHwtQO/sbEjB2ZLtbismOuISk8K6Yg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795568644; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R1HjXt1sGx75OSJt3UPW8YGow3R03eCJWBHiyoon1fUoxkT
	jIDUuBhjsw+L64KDs57OhWOxh5nFpk1ksKz4rXBydq9FMWRHxAQrUTP9QS8Roqi6
	RNa+2+hhxrY9I5U1IslKWsm1yJwmP32vh4J5vYtXrP13XAN1sktx7SqbKv3fhphU
	Bxeoh8fQesUIOIvuV5oSC0KeqhK8TK4DSWSNylfKDx+EvWOEo9GSO4Tf/0mkEWv6
	I22McoLG/ooYkz7stDB+fbyfljFNluy3j/7TijezE9VIV8JwvonZ7jWKI5G146FB
	8hde44B7kIoIAZREFaF9GLjzAxTeq7mPKHvW2jQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pXch+fvY3MRXO9b2HnOBs6pCZqPtShdAOUyqIk6Rpxc=:pcgoiEnLYkWOs3KffD4hpLbQKbvSiLSzoP1ycjiZxng=;
X-ME-Sender: <xms:BDQGawGLlizf4oR2cOnRMlAhutWZUnAVg6vpPl3j0C9b9CLhAcsyhg>
    <xme:BDQGa2PqBcfcLsoB72YZMsvShsg6hqI7Ah-a2KnuxJLl9d7tlwckq-y0V1iPh-bpK
    HKor-sZPXVW12EqOTvQ52CXNBayJGd9JuLzULsow3kRIdrOgLkC>
X-ME-Received: <xmr:BDQGa55z6ggolPYvLyn_02sSqwAZmVZiL_e5FSRiQCx_uO2Yba7F53_eBmnneRoC9EfKTDpQJZ-ygFoIwtI0ge2TgN63KwRtV7jNnYc>
X-ME-Proxy-Cause: dmFkZTFenBdlt+G7rPK3uBQt9m3rquRB0Kb/XKfpmxcAcr3BeQc+ebJOK1JnUyHLFACPRc
    XjfkJzBv+2QnxzkNenWmWcC0cLsC8XkjVhRv3lYQgyhpB5QL0HHyDyekHLJPkFtKJNS8kC
    25+5482kRG6IinceGBPaOuoHICEbOWS+hgWRP5E+nkxcqCo5YX5jKCBSy+ivFatX1jiFMi
    1JUCPg3OiKadc1ErhDduIZkHezBLPD96OoAtBP6T5rAs/MtnKYiW5ivt2gMdG8gVaYOZcg
    BTXIRB3BT9WTLyHARt9DUClbfB2ONyEHDRoD8syl/UuyOZvNruu6c+Nopg7oVwHU1TcUkL
    9IfyBl7P9rc48BTc40FxnmmGCo8TpRd63UOGFT/+n3qozx0mzHl0RgpOSi6varDIeWm6Vk
    uwKJ9Qdmkj3wlbXWDu4Rztfykuq7ZxIB92Imxtp+HN3V2/xDIRQ4o+e382y9ym0jZajFm3
    A5EBFtUsdZIuN4XJpxsijs1kTU6AaYFu9XarkXafHSe7FckdGw5mRARtAT3Vi9xm6tXYOl
    lAiLVznUV4Hm5JhiByhFeiv49WBjzARyrQmxjWmCfGu/a6g2SivxdMoIDjs211rvgXzW3K
    +xndEYN3WhrzFDFjAOKICpVLCPB9abkO014dTHJVXM/P/WmmLXCehnFH+++w
X-ME-Proxy: <xmx:BDQGaxhe24ofxNYngpsZP3UKuiiecfiQE3by8-8lu0mz2vuQoFaXxQ>
    <xmx:BDQGa2dWstVMsdNo8O33ki52w6JilS7CCmiA5mGCi2paWQBZviYIbw>
    <xmx:BDQGaxxQivgTn037tvWV0qvXWC0kSjawYmIN9ZuL4RKKZW3h0rCAzg>
    <xmx:BDQGa90qebB981tas6ck_dE5xtOKu2ZEddhBmuTzglxA6Ky6h7xH9Q>
    <xmx:BDQGa8Z6_PQowD-dSI867b-meewIIx02lQgMtLQ0ftogw1jjZURn_rhT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 20:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>
Subject: Re: [PATCH v10 0/5] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <CAHwyqnW4Exnfd_mTy2XFbATWb3ExwY63_ncZgkJ6_0NH8eaK6Q@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 24 Nov 2026 23:43:04 +0100")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
	<xmqqse0r44y2.fsf@gitster.g>
	<CAHwyqnXs99Jd5ajrskjpGyVQZmR1DOOPmXturzDxOyWuE9dfBA@mail.gmail.com>
	<xmqqld6iouk7.fsf@gitster.g>
	<CAHwyqnW4Exnfd_mTy2XFbATWb3ExwY63_ncZgkJ6_0NH8eaK6Q@mail.gmail.com>
Date: Tue, 24 Nov 2026 17:04:03 -0800
Message-ID: <xmqqpkvtg1rw.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Fair enough. I wouldn't name it with "yet" though, because you never
> know if we forget about it, just better to not promise anything.

If we are talking about an experimental command like "git history", I
would agree, but "git branch" is part of everybody's everyday toolset,
so I am not sure if such a stance of promising as little as possible
would mesh well with end-user expectations.

