Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792736812;
	b=uH0u/ippTSBwbS7xz9ZajgR9fsYvKnBoJRlAVP0a+f1XLkmmAbAKshe5kKDQ0RRSlzs1
	 17+dVAuzAB7IG/kU7UDhhnwtySfjZMgoYIhcoc0HMYxZqxQWr3ftRPlRozyAgGZfA+zdJ
	 ly/X9DelhXXzlwVZyQMOKeDYfnAhSPOuJiFmSd0K+9E/wWIxn08y2rRy/e6DlwVPjilBG
	 l06HMaMD5UmS/Qt5ZDUrSbKhcgSajkdrCCpjh7BGC80AoV8UVHyPw4e5YtP+tcgZoYfCJ
	 fqvT5xBP80LIVcOvRRR+syYH1v40ukj+jysU58HHVPJP6zdoPagMM0jY6vTjByEZliw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792736812;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cDZJXNwbWw6M23Zi8bdmorwAPCmptBpUAqhNblzGxus=;
	b=k7sFSVAdluVImG4cpI71aP58Ocqlgi6GZljOPFuvHuoAudGXhmAJnoa9RTjKBMrzaDra
	 evWiM2BlTvfkj93pfFGHYOO5j8LBusJofnp6CdniH86O7tU722uiKcSyiCfKqudVKyx2N
	 Wsa5r77/XnmsbUwrCmfqTK2hCGLl2aYKsV7dtQaLcHayUmBWs23OV524WHj0c5jFoiQJ/
	 merc/u/PUV366FiRslITdUYsy2xPx1MKof9xZ8r+q4feQbTOw1Bzus4b+kW2U3j8lPnO0
	 bgfrOa9TsmpDOvnHl+YX0UIwe6y8VGW0Pcf0L2TP1ECNwOMW2isDaIBafSLYMGyhINg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NQB3mVUT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GRdunbUH;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57760606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57760606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NQB3mVUT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GRdunbUH
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D1EA1400116
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:26:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 02:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792736811; x=1792823211; bh=cDZJXNwbWw
	6M23Zi8bdmorwAPCmptBpUAqhNblzGxus=; b=NQB3mVUT+pFB7eRuUom4RTfw9f
	lsUTIqLdrbXpuo1VjrNd/6h3c7FrM8DYWpnz0L+XjL127sE9rSfrs3uwujNLwHRM
	BjjffHRuLa22hjMLxZLAKAZzM0QSV/XKUhem0m5mWUwe8iAw6gHJTn3qOdhYUOCG
	qUNyYHarHHSK89g1FoIhY3W9chxL/Le8a2v/rmNlrNK64py1uCg4lsA/YtVWxOW/
	7XFm62mt6DeqjXgAcmT0yh5PyMX45CaWaES/9ylIwIofnb3dZokb4MgT2hqUTrta
	tgjHN/7slKqiEaseTrRduEvDtDOWB4xizn4ZB4dvnz10YFodFYkJ5gNZiRGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792736811; x=1792823211; bh=cDZJXNwbWw6M23Zi8bdmorwAPCmptBpUAqh
	NblzGxus=; b=GRdunbUHq2VZhjgFaEcLwrkyTYOGcbu9Pq9COcP1JU6bPKjeAP+
	Lwuxex47ouISW4enAMCxqMJxwgsqtkywu5CyGvDju0wvouBBc8cSm7rxrMEoOM8z
	+h3veGSSeDAnWfdFNcNoCEgPJjHi5yI6TZ/pE1oHdqD7bFeTaw8C3f5Q2Sf4alBV
	dZi9rVoin5fCZXkUknNbOKGF/4J535Yjb4z41YoXAlnRHm8X7rv4WoeFNBn+5jK6
	pVWXwK6oXBahKMBQ7jtOKmAWT+m2whba8ULhVbbSUqlY292SONrV5GzVO++pbbZ6
	9tL/XX5asPmvcUS+HHvjiKV7VcU/jcXTpTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792736811; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KGNdLM4j0tduQa4TIEGD6ReNCoASjuERO1XJagh7l/9Licb
	9B2xckqCEshN+bsnfltU5OPr5F92RXB7j91KpiVgStZC1pXDxMCKdZVjQKBVw3ho
	dZXQF99YnPe4d6ifh7If+GdDqVq1HFsvypCEM+fT6EWZAiikCBGcwctk7sI4zeBh
	IWaTr8SpjuhtF01mvykqdkbvs7QsA6u1BnZS/GcUjiDk67iPClQgU/YMwJCS9+BJ
	6ymEmpljfSx3e1gZ4vGzTj15s3UDaoporRzmbo0+xLIgjkd3Zs3cfVeLU8Mpm1aQ
	Wp8sNwVHFDKAf/jvi7Rrgz05Gmaah7clD2dA5SQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hR7wIW9vHu2blAi65OMp1mydUNek3v9FgLX8NC3kbH4=:eOy/eft5XcLqWP/1rk6semkKvj1giSE2klgJvp4Nay0=;
X-ME-Sender: <xms:K_7aave2NN2tnFPLTfcd31DWUq92qFk-_A4VvoGdVe_eiTWinVFwWw>
    <xme:K_7aasORtsytqDEDz-PQsYKH1ZS0Fs6kxzS7ovNeshtjVaYVJRneGKrYs3ViQ4HyE
    9pRq4twy1o1VGgv7pLyqcONtoqDmqCDH6KxQSofNyXI7QGg7ON3PlQ>
X-ME-Received: <xmr:K_7aathPXxjUneLorFf3Q8HopTaRDJL1ZF0WCuJGm24YGvwJ_s_f41WV1MJp43Cq59TFmQ>
X-ME-Proxy-Cause: dmFkZTE2mDsyG4mZD2Y3bNIQKp6jJ2wyqask4phNAulJCyzYjG5Vxw8fQnSsDL4jXddc4H
    j9WBuHKjvvF3kwzAAUDgdL9K+1S5vj+C3109fQ33rpRM2TPoR8QJe6PyWxTk+Gt1O0J3Lc
    5/0Gwr6Wnq0zu/qEYIQdJCvMht3szqxsYvx7ZblfhxkpH8QT0PulriLC6Af1yyvscpuFFg
    CkV9Dpu8z0Qm3f09zPkN6UhckN5fYbqMs/Q8+ibaUdLvAIKKQ6IAmnnoQY2NhCc7hnuK5R
    gt69j4FT1gIo1luD4xcSV0Y04TbH8F4Nf5cGPXKD7MtEIAGkGVNX4Ni/+iLIlxznX4J6Zp
    X+4XdN/gCbcQjIXHIpOG2sk8QnkntbLq8HlnKqD/Q1XYn6A5HsFToaqF9nTbZvrSdqNQ1E
    5ASkIGxt9CdDH1U8iI7CXycDlLM9wAjxWl+FDC47Gkbp3aJlsEyYYuKwMbremb89/T6LEX
    3YH2jkva3LEFfOf9N/GRKxlO26LB+jb8EgW91GWuS4IAIZ8hRCd8CfbAs1ItKPD0GiNCZE
    j/Jx5SqL55y+274EvJfvs5/zJeszUMBWdFGlc+7uJbgKBsfIN+1h3GyboSuxW9BNGk8bHp
    Swcw0pkuPl5RZcFN+JykTmvd1MJr6ylRvMuoPY2olNhkLg6mBHjoqTFvz67w
X-ME-Proxy: <xmx:K_7aav0ckcYgJYzjY35TvnytoQXw98jLIs4PLRQ1wOjaFxjLJPKlcw>
    <xmx:K_7aanjbUbiyZ8WrthNSvPD1DP3B7sexX0MAzuVJGaUv8gjS6xrLuA>
    <xmx:K_7aavePPrfYQTrMtN2cXW748FRi-m5LlyGj3kDC8pI7-1_QBvrXeQ>
    <xmx:K_7aaqlJmqxKFooxKQP_wIV7ZtUVgs274jKd1-jcbmpNtyNrPAczFw>
    <xmx:K_7aalT_9vHZkPpD_oz-S2bTFi8bkLOSiI7lGunv1h1gNchmywpFlSsT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 02:26:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15acac48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 06:26:49 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:26:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] init: show absolute path of (re)initialized repository
Message-ID: <atr-Juww5KZN-ugM@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
 <20261022120749.3567828-1-m@lfurio.us>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022120749.3567828-1-m@lfurio.us>

On Thu, Oct 22, 2026 at 08:06:32AM -0400, Matt Hunter wrote:
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index f1d227f27167..fbf8a0e41dad 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -1000,4 +1000,10 @@ test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
>  	test_path_is_dir custom-odb/info
>  '
>  
> +test_expect_success 'init shows absolute path to gitdir' '
> +	expect="$(pwd)/init-path" &&

I don't think this extra variable buys us anything, so I'd just drop it.

> +	git init init-path >actual &&
> +	test_grep "$expect" actual
> +'

I would have tested for the whole message, which is short enough to be
reasonable, I'd say.

Other than those nits I'm happy, thanks!

Patrick
