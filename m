Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194953;
	b=yzPMMKWx1WdJWKVrfAS7yIe3BZpc67Xy58UnyM4zVmaHE8830dgLzGyzu6qXwOMhARYi
	 W6Zhl1suaUhwAAM+qfmpLfLUJsMyr4H5c2gj6VEU2MhD7hQD3BvxT2FFY/ucGT7qrPVYK
	 LMHvESGsVRR0064/BKbnHTaG2KGLCBBPa5uKa1PjRQRX7eh4L/VMzsD80ocMnp849g9wF
	 s8N4IeJozLqHXuDsVcOfmvfOq/8OeSOtvfvSB7gPpMLYJJz4d8ogKxgD8ahERsusIgqnZ
	 lfTdY5e+G/GfyqYLS4w5zbTUjoliLQuiIC4VSOOn/txAzdE1xddo0eoJy30412YDVDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194953;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=sisPh2W+h1WSZWppvgqjVpt8Yxdzw5v7Zok9LQNH1NE=;
	b=pktYE8HTKE5AMUws4CNE/FtU22UnK+2QGaJQjFphoI3r0rOW80t32cCJDnBgeXw7ayj+
	 37UGOsS4hbhaeAs/Luu5EQKC+vYBm8PmNhCpW70MfUgWIXp8ouHqQoxM2Opmugql202bK
	 6XLYDA+aMSG8tvEzRVR28kYn2p/Z199AeSfmionZdzPZr1b/bCcS+Ffs9MQJwUUWmytgT
	 OxsJJf02p+VfEmx2wF06WGcM49ht9MY2wEaD3s45xKDDQGIMV9sWnTdf3Z6jjzJ/tZpKV
	 1jRYDrqwP/LatGUA2nNuZoeM+jjZkm6aSL/ZC7CM6EK6TxlAs1qZEMRtqPmB3eno8HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=WGw4BosI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TAHbnzkT;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376A606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A376A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=WGw4BosI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TAHbnzkT
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C1F11D000D9
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:42:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793194948; x=1793281348; bh=sisPh2W+h1
	WSZWppvgqjVpt8Yxdzw5v7Zok9LQNH1NE=; b=WGw4BosIy+Cv/j92v+YShQQ6BY
	ESrqQ+eEPV/cft0OR/TnHjZSqWKBbOssfgSbg65bc5lR0kylCEI+pqwKklf55ZeT
	Q86xsawiUVuJKoCjOOyzPF51o47X8g+UipUxYi7hXsKOS6eVZT71VOjrYxFqhbVB
	8EvmglGOGT+D6i04ZBSJJdEF/m+rqDV4NQvTKZR3tZrvO5dQNQPgvm7o27UiniP3
	2CtVNcMIB9HbdX0as4kjAyFQXI+7NrEqraGNbFm1E3utKrnn4Fcv1xSu9WIJ3xCM
	mn1HG+UnSw7WngzWJzcObygVJk1/HPAX9b8+RCZs/odS6Ar2MyD23Y0C6otw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793194948; x=1793281348; bh=sisPh2W+h1WSZWppvgqjVpt8Yxdzw5v7Zok
	9LQNH1NE=; b=TAHbnzkTnyA7nUrqs6YAT13GzErdMrrly8JMFhOO0uUMB5KZdlQ
	bti1dJAma9YnZwMQefn6YYs89ogDQiXUw0eZB2Zfk/NEjNrWSYz60fuqQve256FE
	BMIY4Ibl1xjz2HBcvsXUNO27fMn5SFNfC1HgOMuZn1gQy8OzYFehYr6Euv1pkzoK
	g/93i4yvBQTgIH4J25Z+dhEDPnIOcGfTQwQOz2kWtl+GGPAOjpkjjPlAQ2O+mRNG
	riRDxiyuNNGOzAknQ46EAjPywTL3NiKY73PVLxXWtL+ChiL9XFlNDlQVUpy+682R
	kxqqgeZpyKcvBhD5kNWTFIG8kho3LzcM8pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793194948; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jV8/pSipZCNyJIqPTccZ11FI89c8SyojeiJyd4OYJef7b2k
	m2DgQosGTK1Fn9+reSydDnbJK+nru/DmshH5AckaJcQBQzWgPZJxwlklKPPiHwXV
	lKHbKL3a8uMyV4/rUv4mrSJWx9eArcs9Nr6V0/MUDPn8goXreFdBAvMt9l3EJQXV
	8q2xuSsjPzAUn3fQAr+SE/r2wibqhxJ3yV9+PC3fwjBiCci/Gn6TWISRl5AAZgUZ
	PfpJf2XJTmst3ky99FZyi3TGV3SM5ViC3mUrCv8Jb4C0AbqnLwmQJFGJ4PsjIXES
	NrfpeIKb9zCtzmiOfmAcLmO02RNM+Bic/ERe+Eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nhXeGysdXyrBDHmVCzlaVDfpUNsb5zf3TJmxmpK6RBM=:qrPxKdM2SImGn/0fc5+48OnYBvD0F2C7x8YNLuDC4h0=;
X-ME-Sender: <xms:xPvham-owqv6I27EXPn6vvWpG4hmbFfQbbDKd0DMIr-FMHVMxuqyPA>
    <xme:xPvhauJoWz_0a_XUxWNDISp5Zy55eMfB3daJIvcCiYzCs9ICvS7cCE9OJByuh5Tvu
    lu8th2m7PILjP8cdjWnyBrrrNzrr5uE2LEjDcMKfwS4IksWJJhybV-3>
X-ME-Received: <xmr:xPvhapa8_PqkzPdcQ362R6XKYTlRk6LtcU6-zIxKTcxeH8ecYm6rnMP7nf8Pdtx2IE84kkeW77JdDa7eA-AAcFTBi89QUiuLeCfe>
X-ME-Proxy-Cause: dmFkZTEKfnQE2Rw/7Pz4EXZDWT5mvPwtxlfLeAT2/OCAcIb2MtOkUefp0kgNal9Rle5lr5
    ynZm5EsRMWe45BVelEhk2BvB3bWErTp6VfdWz2nMZlMf8YRPY2NFEr1BwubKYRLyNdjooK
    BAT4fWv/8Sp3rUeE3LHC3O/PuZ59fj+qKcV56l6HHcU9JYmY0e/sy1IRIZWjPq5deJMJgb
    8RgRO8ubfAoHXpkFl1ROiYJeTDjVRvzcWm99X+IbVwZHYE5lCgWeCgNLOR5IEafIaE9+ZQ
    QAn0dsMkkb+V4BbtcI+KL35vXqGS29PBqcftPLrePtzCABBSij8lMkhNgWixJPe0pS4HYp
    6vw4JQ3XQAYsDVPOu2SkXInirFHu7hYMvYkx28CGh+YVTEeqxsp7IoqJjI+BE+lktBPnWe
    n4h2s44ICPyaisz9QEIaoc843KpbWqvWw7ynRNaM3tOK1FmrQ8eT3H9yOIr3UYs0H9QK7Y
    6wdPIBNiJnFR/c4t+slRCPor1deB3JHgsQ8Tg0kVaudIknkWVx9IvC0muraBP2VYr6R7Cd
    o7s2GGh/JynJ2ZJtn2jtQiYLlQKAkDEwYi5ra+XAZox0K0BIz/OX1fKDCR6y2TdkrrZehU
    6Gj9mmDQ3mqo5KI/zoZN8gJfs7L7TU1O5jZveQOpBGTMA1xoyzCF/OoFRg/w
X-ME-Proxy: <xmx:xPvhaoKTHcaHQ8_xVMRF1X2ER49G8P9zUJ9783UE5svKtVImk6W35g>
    <xmx:xPvhavAVWA-jOpDWce8ieHepKgOjRrFj9jppKR4g2bfmq64zk3qt6Q>
    <xmx:xPvhalp4CBBguMkU3PuemftLmrNVT500IG8oO36VpFTmQs6iaEYs-w>
    <xmx:xPvhaigkh9wXLZXTOZ0h04TqfscBgP73ojj4LgdZQgB0UOk2tUj74A>
    <xmx:xPvhaqJBbhReaTExPfRqm_HLn0VrTX5YS1kwo7eBlFB5BDf_eN9n6Kpl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 09:42:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
In-Reply-To: <DMGGJIMVUXEG.WJSWR3E4POW1@gmail.com> (Pablo Sabater's message of
	"Wed, 28 Oct 2026 12:07:42 +0000")
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
	<20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
	<xmqqpkwvj7bj.fsf@gitster.g> <DMFX8JPX16W8.9VBEJMQVF998@gmail.com>
	<xmqqbj8ee3g1.fsf@gitster.g> <DMGGJIMVUXEG.WJSWR3E4POW1@gmail.com>
Date: Wed, 28 Oct 2026 06:42:27 -0700
Message-ID: <xmqq33tqdjr0.fsf@gitster.g>
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

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> But with that in mind, what if in the future there's a transport without
> smart_options that does support object-info? The smart_options check is
> there because of "this transport can't do object-info", and nothing
> on the object-info path reads smart_options from what I checked.
>
> So I'm going to drop that die(). Later in the code there's already a 
> check on transport_fetch_object_info(), which looks for 
> fetch_object_info in the transport's vtable. It's a bit later, but it 
> checks the real capability and it will give less trouble in the future. 

That design decision makes a lot of sense.  Thanks.
