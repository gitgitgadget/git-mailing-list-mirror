Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129621;
	b=okCX3TJQOsOmmGhIabVP0KImWC8PqPdyvzMvLExCFsqu9H+1dZcoROZL2sHsvwqH1+R6
	 42Ysl0DcRxh5r6es+/ysVORviIksu/HBecsirIkWegBx4VVwlgeI9MkBgW7neVhxTAPCb
	 fw8mv+WMQ5nBRpzUuUsa7bHAM9ozGKGJRnZkP25UiPCxPOx/rGCRW0aIvhzFNuf+vIyrK
	 cfayViNGbYMMyFvDury0JfQ1mrXKyRY9uLfY/BVFyxNhCfFK/8um1Tk7RXI2tzoKHv90f
	 b/eclnHO2fuPF/oa+xsPV4mrLN8e6BI1ekCXYA60y2hbW1lnhcjjQK5MVs6JvCcRVug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129621;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0hss2KGAy7RlWhQK0/O7CR6MLbATKl1JPP3BPxPdbgE=;
	b=uQya/powXhvCKnZMm0pT3GEKXKnG0Li4ycQt72xdoufSnJayJwdux8IOMmchRBpbrGDh
	 O1QNKv2wKPmCJrKEGc0bPNGmc/D0reBPh9pYtQsPFrXmMtyL703ol+CeqNKPzc01JJd/M
	 3DRe4kEHMytAbl5mEkIw4w2m7X1pqQiXUY9SIVSQY0LZIpE9RJFPOGSJR9O6JYY3NVOgk
	 DWQI3ZeQ76Ijb+TRmFqVoZzJwBX+WFjDEmglY13jcuf/8mTzg50e2VgbDBomT/kNHOtxx
	 wlz13o1LbxyoWpDUpSD5+4ddJ+nPFyvd4zpOaYYIDS3LxN1O+nVfCz584MMT02aGjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NNaxFciK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hiKwVwAT;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D825606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D825606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NNaxFciK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hiKwVwAT
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51D777A00F5
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:33:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793129619; x=1793216019; bh=0hss2KGAy7
	RlWhQK0/O7CR6MLbATKl1JPP3BPxPdbgE=; b=NNaxFciKWG2n1EDdo3RgWX0uJi
	JT/ftivvUDnCwfn7skRGiuREUTo9aHc5Q9x0EQBmOSl8nr4xwa2OF5PZDk1CxoQv
	fGiUCoGNmzY+Qpe+HwraSOTN/eDFmfZy9FBBSdGQPsUPbiVqnKCHmPECEIdYtHvM
	0YmZdTAciS1t1vA3UUhURxrCrq3zKgDrOAfNE6mYIKPY3i0Aby0vMveu3sbdJSG6
	mmVL7PVkKiSWgXOHnXYRnvw4GzVinGQ1A/MR1jUYYkFWUltJWHylut0g7W4QMNOY
	KpQHqxWibxLHpSbsAPKQ8GtMMTEvAXBmCYQj0UIveOadwou/JqqYR3Fvq1/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793129619; x=1793216019; bh=0hss2KGAy7RlWhQK0/O7CR6MLbATKl1JPP3
	BPxPdbgE=; b=hiKwVwATa/UXYrzHBBHBO19em9UtuNmamwmzdMW3Js3clxTvBOy
	qJdfcz79EmA77XBSMsi035f4D1Fw0y150WDN2TXQa048pZ7gCotA7atwVVw7DNYM
	9qoDqwP/aRIc+nk3xNnrAezOlTJnr5ZzBf7v6j1v59PGrgyo9HjWTkJQ9F/JfLDq
	PMiDR9/aYeOT4tCLWBIH8SNP+QkCTZtniYpe7BxKLsONmyPy/AOC8tMhKHXkcYOA
	ShyDzxu7YjGe7xvqJFccZbFuaX97+YTvC7TpQIuYFmrpOVBNdnZg6mjH23qsa1vj
	QpxSjKtKgiW2KUtAYGszPj8RTiEqd5BNOMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793129619; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WR4zgilgq2FGkXq3sba4ar01w7c4prkxCcGLTmRw1PjiF0W
	reKJF3DR/2ELlCANFjKdr0Z8paBms/azEZ6oElJ9z9LawVLAb1qmjhAoORlZJnJC
	cuFw0X4OA1rkUXg+LjjQ+jBAVDRzNwHAQuMEKo14+sS6sQCPvTzfOxdzTcYZSVW8
	ju0o0A3jT0DTfAlCGy41tyx+tOFrSd1Uq/00zkeooEpKNe78ZDWDn5g/548/3rEj
	Gyzo65MS7z1JtsYLhpyd8iMrI0EM89AzVnX6EHxx98HXK5OMDDznz/M4MTlVGjDE
	ed+pslBtz7yuHRKOYfN90UrLpK29U/OyC17KtIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:l88Dkt5DJ3qeobIKq73cgTJb/Zl4MQ5d7uGkLXF42RQ=:wOQwKcqDRAF+WIZLA3dDhWivMqanlubpmvylzz/8FAk=;
X-ME-Sender: <xms:k_zgalJLludlISPJRFt2pSysAUrT9yCKB4BfMoFI5FiWtgeOdPSwKw>
    <xme:k_zgak3_siUfKxK_aGaE-S4noYXr7voxm9DQYZvqg4WF8iD8A6GGIn2BorbGNNsb3
    Ps47OjCOqV9msAdFnWvOHwyTcEKZfb4k2ZJy1FC5qiD8EG8iymEVJg>
X-ME-Received: <xmr:k_zgang8VUgoF-wIuvP3oJNaW66K3v5Ud8vyUgaSosJcpwuM7FXuMjVBO8tTIwzycGacaWt5CfKP4MRnLJKknuojYKcJMJPy4xTp>
X-ME-Proxy-Cause: dmFkZTFx3VJNdMFkD4IG8kAgM0TcSwyxaCGDwK1jAPne84w6jgss8bFpmQNe8d/DJcvK6s
    WcatTAWqD47ZeBFTTrX5Cc8iyDVPCCElRh6OTZ0ImAxd0IE5MSC/27q0TaMqi3ZiYGgowa
    +rzDBWF2pvHiU/7JQpd/7dJpbT29GmlPAvwWQVXYQQzzVtAME/y8YswD7PJyQqxViRHBPF
    F+QPQunqWdL+lG41Mw0K9Y5UzKMkAUzXvcyUWIsT1nbJmRJdoVyTL7bw6y+Bfr8XngBMvY
    FJ8ZeL6vWbY8H8VYH7ZanGlI+OT5txvf3Kekq81Ra4vpk21KZohuIZsl4TrrB6Mqu8heET
    iz1efjjNIZhGD4vCrE+0AQl1CDycgpQ+VLOEPDHlmJJhCsO1z2tlWk/qQXr/DITsuywXkh
    UdClHWbz+7vL4qWwoqgHa0beQ9zAZqCWJsoaJw/+97tfj6iI1CaehrQ/4vn3AwpjdEqFMQ
    SMYkUZiAwIqxnk5y+E3s0em5OpwddYzNM8Y/pZBLjPpSMK2mP1kE7NN1CHTXaXkU9I/f8E
    9lR4ac7wc149V8UP10O+CtPV7OaZarmxklHUnUmdJLduElROgBtoFGt+E2qxDMGzuGsE2M
    J6ElMWcpriXWQe4b/4zLq8QQzFLctTGzUPCFlbosKWkWNjQXqxC7mIPkaeuw
X-ME-Proxy: <xmx:k_zgatX-KxPiBRwKbW1Dp1s28fYbJk_rumlrheF2_nTwZR2WFqLb3Q>
    <xmx:k_zgauWtgLnrdclF8UDkrEGpGMNNpISgsiMqRIx73BrYGJgd44XxuA>
    <xmx:k_zgaljnUQzRFYSYBdXdM-FICCKmIkOKKa0Upt3LgzOHAU6FT74OfA>
    <xmx:k_zgahYH4XeuxOECGRpN23ClETcoJkTDV-raGLB0fQCjHKxwgqsIPQ>
    <xmx:k_zgakvCsw1z8S1vrotJWUZpEvRe0CBP0Zu-ZYCgz9vIKjPgAo5akYwg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:33:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kerylefondji7@gmail.com
Cc: phillip.wood123@gmail.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH v7 1/1] archive-zip: replace _() with Q_() in path too
 long error
In-Reply-To: <20261027085042.7150-1-kerylefondji7@gmail.com>
	(kerylefondji7@gmail.com's message of "Tue, 27 Oct 2026 09:50:42
	+0100")
References: <20261026192803.1985-2-kerylefondji7@gmail.com>
	<20261027085042.7150-1-kerylefondji7@gmail.com>
Date: Tue, 27 Oct 2026 12:33:37 -0700
Message-ID: <xmqq4ie7j5v2.fsf@gitster.g>
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

kerylefondji7@gmail.com writes:

> Just to be completely sure I understood correctly: regarding your note
> about updating "SHA1" to "object name" being outside the scope of this
> patch, does this mean my current work on this patch is finished,
> or is there any additional change expected from me?

Not at this moment.  The "SHA1" thing certainly is not something
we'd want to worry about.

As far as I am concerned, I think this topic is done.  There might
be other issues raised by others later, though.

Thanks.

