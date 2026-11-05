Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886922;
	b=UJ6V1aUYCJT9isO4fofAMUE+wJ9tYzPh4OAzI1M2FDY6LrC+xsKDenNh9IX/FTni2vG/
	 7olQy2WTSdHNj+dWkx85ev2KcRnef4LDoHLvWAs5rwccvnXa6R7DM/4RtBR9zMvFLwXD/
	 vycb07Ci8YopRtbls55VnnX51lOGsQvHKhsYVV8rUljudwuBov1xpNOUYzw8oiA/hWj2X
	 n69NQf5qbgTv68t09uymJS079OzSwXc261g/uM3ySsjVeO8U76tTTYBVFQkL/ML6x8U+J
	 BKuYKHwLEqnDbUga8KqgF/WUYAyZ4VDJyRAoKXYrl2mWynRRl7We58iizzRbEhzvyBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886922;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rQ8UGXhx8O1TR0bHm7xxhAcMfNnPlf53eGboL+W12ZQ=;
	b=bnni7kYUtR/+IiSGKdpMgnp0cWSmUA8x7AihnKlE+CqghpEnEXBKpO/Md/ylHtbB7RFR
	 nJojDQ4VU7M97VKTvJX+FX6+oMzD/7vPI7Q7ZSvbSX4bvuLYx7vc/K3nlRoRAr4q+HQ7z
	 80rVEr0nk4b7l8FtQ+HpzJRxeeoW203cEGzWynE2tkZWDGip1odZYsuiz1IYswwLsH7qL
	 WK0US0iBvUO4RE/T+FIWnlIN4oza9v80K8Ju4FxtSpRsycX0QcBnIwlgxg7cCSofj8uzX
	 yHyS+yrY/4fbWeLiCtsGPzWpJB2xmDKERKO98A+4nIZvKyrXMi40+qc59TjXDaPCNxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VO1+7WZD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u38BKwvu;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31C606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD31C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VO1+7WZD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=u38BKwvu
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A17AEC0609
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 08:55:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Nov 2026 08:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793886921; x=1793973321; bh=rQ8UGXhx8O
	1TR0bHm7xxhAcMfNnPlf53eGboL+W12ZQ=; b=VO1+7WZDD5H0yPnI3NsFhsybhl
	dsu7erRt+RfB6YUrJb61KexO82kRKTbjD+lq95aBJFc8LnB88thtByQp9wCvHy9F
	XNa2gRnLy51Zek+p1V1NFq276gCUWSe37mnmH3rDE0r2QeKuTZa7aSps8rDIFCYi
	UdbDeUEM0jPt9v84TcY3uuu2+rT05qvBEsxAVeTKy0sfKAPqyjMatPTNT6yZyaV6
	NKkTpPO7wTaatZiyZD9p48yQ2syvq7RlGNAHikoBix3FMtkZusUrGO+Xza+kiL7/
	2kr36ZY8u5dIku1p9f13k9mcEgMMWnSS7jZaksANQdJxnXQc9mOvI6T+lcGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793886921; x=1793973321; bh=rQ8UGXhx8O1TR0bHm7xxhAcMfNnPlf53eGb
	oL+W12ZQ=; b=u38BKwvuCTek0nPPgMCYVj9DLQWEUYYu54nuyY0svLiXwkiFgXQ
	dbcH1T5SBxCv0SWL+ttshYN00Ee8UWn7uxQtdceoJCBHzWNOsZ3srWUCz8gWOdtW
	r4NYkvy55NfdGBuH/R61cleJMhyssMpP5gk9m7myMwg8Opp1pKdIFW463NSyRoBM
	lEw4An2gqLmCf0xwljLZKpxTZUDABI+BA0nsmyp65Mxt1VNTJpEE+B3jrUlFWlNC
	k221OnPrUQ5AfhyxT7cZv/kXJ8GRCBCZAhGGC2ac8QHQxRcoTAyTgspstlvNFb0X
	L8Iz5vtdWBWcblMEdIqA+KZqQYASQOAzuow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793886921; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:XI1/5R8eHgQ6n1g6DbLYg7t3b0GpkbnvxZtc0PZi9Atni9f
	lnWJRVANwh2vstiXhBjF8ZrdG/HQXZXA1yd6R5xaIXXwiOCvUsr701wcuoNusDeo
	GZfgzMznM+4yqMMHR1NE0haMYKYrYEx3s4HoOE2uJABtHrxU10Yo9YdCr/dr+zwm
	ZzGdAWFRJGxib2ios97/jFVt89eOyvEPTQi1fueRKISQ8zhrkZZYW8iW+dVizENL
	Rq/JV7zU6LbABZ3jg8BvYUnC9LsO1gDzH00deZONYtLbb+6RItziTJVKDFg7WrX9
	Lw1pysNFl9Utpj01o2JdmgrWuOslNWfHJ3ifUDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8e8EnrwW0cQ83hM2Y2QUDUz1rILbk1dna9Q9wRCdZxw=:a/CLgdaNoFxWYKsijcsScLkEK4u7QQVMPLtuD268KJ0=;
X-ME-Sender: <xms:yIrsag8QBKfPln16DcRQ6POon3NYB34tIkM-j1E3iKuTtytcAsX7rA>
    <xme:yIrsauvvj2tY43N1_PiqdgpYzOBjtBrzwNI-vY_9hdT2lJChSxxPsw4XDR4-oP8QH
    KWLAdgRGk5Nc4ALc_d5HcyLySFTeVsNVEJdjo5DhqZJX8v0-bpeOeQ>
X-ME-Received: <xmr:yIrsajo_w0jAlIM0zu8bMMleyCG5ax078aNvZjL3X2lXzIqUB3-h-g>
X-ME-Proxy-Cause: dmFkZTF/5u05dS3OZIK4owA5/IO2++n0/fubvYmUtt6gWOknluPdzugDHboNJmWMcaIyCY
    WaaW4wFXHv6f2rx2n9HDO6mscIun5H03OafSD3WL28FVqn+9T107OBFpNin34iBavlpQRq
    7Nwc9Yiesat19fHZ1mcanyJDQ28a7BCjMqWUEteF8+tVYvjcrQ8v1weSOMwJ7Fod8C33Z4
    JWMOuSAHte0n3Pa2HyZ2emftKbyt+u3pw9pBB/YHhcjTsA7aZSlWP3AZULt6nRbOdqZaha
    snbTO6HrB+XIpqizt4/lbbJ7BvCuFww/p1M8RPVBLNcryinyj6UJ936+OUPo5lzx9hsoh/
    3+N/7408KJEFtIIIAOa8ERIE7aNGe7xjNK2CXShwnGT7RlbPehIpc8tRXk+tsYyiAQz4Xu
    uxC9A7QGrCx2i2VyYbuZnb8d+QTiP4GC5pH34s+RRj4/FbitwQgkDp5Xzy9jnCofm+JcCQ
    ocNHALkx3PKgOPfR/4Icu6fXdRqs7UCz8g58xFvVdX+SdtFXK8bgoJaF9OOZootQQF+FsU
    avj98TkOs1xyDHOclMtEgxFtOHqOexsiV3e5StTdVnbiWFu1p+hcAIoD2JKLiEyeIT9bSp
    3vKVj1Xg8217eeRrgq+Zgknr1RM8RaCUFLa0Imh9PZxGXuAAHp3G8mT5NsCw
X-ME-Proxy: <xmx:yIrsarlQQiNpYG44JqK4GQ7Rgj7R2z5X2LvoIjg9HNks_-XAilZW4g>
    <xmx:yIrsanwSFVpUND7l-phmq-ScKGSOdbso8V0LtzYGvpENFr09m5H9hw>
    <xmx:yIrsajkyfHkZIye9CeihUJEAuUiS5kmvQEi9__4-nPxA3jgGnvtPzg>
    <xmx:yIrsagdLIeVJk6mdDfU4RCyFj_M118EvA8xoBkPeFlUUQ9itPDYioQ>
    <xmx:yYrsavsz2U__ti7wezKzNsOEqqrOwwv1Omu5Rbvs3SL9Jp7DJhM38tTD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 08:55:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f707f17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 13:55:19 +0000 (UTC)
Date: Thu, 5 Nov 2026 14:55:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
Message-ID: <auyKxKX4l3QmGG1y@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
 <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>
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
In-Reply-To: <0e74f6c3-2f43-4829-a071-27e96ab5e87b@gmail.com>

On Wed, Nov 04, 2026 at 11:37:11AM -0500, Derrick Stolee wrote:
> On 11/4/2026 10:57 AM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series includes several small cleanups for the interfaces for
> > writing commit graphs. Most importantly, the series refactors options so
> > that they all get passed via `struct commit_graph_write_options`. These
> > cleanups are split out of a bigger change to make reading and writing
> > commit-graphs pluggable via the object database bakcend.
> These cleanups look great. They are carefully constructed to be as
> simple as possible at each step. It's good to bring some of these
> conventions into a more modern style and to simplify things in the
> process.

Thanks for your review!

Patrick
