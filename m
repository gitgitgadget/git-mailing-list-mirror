Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566654;
	b=JZhUNSAMHhWbfZ379+B9OhK0/sJWyJtJkW/0hkZ8hwi0s+LJLBCtySbajoN0WlcOuBCX
	 ip+NG7dT6uiK84GZCWk21Mc9XZFYxTjAnfkA6NUnMQVsqDKQXe3HBPAf8Jh2oLjZvCr2W
	 29etuThR14Fpm6aLdLMumMhOo58VdYe99b3nWjAjvhdMQ7DZfp2qjPDnlUCOfUEqxOlU2
	 LRx5kUNrZq9w07H51yazhoKIHHNCnkufYsaYERmum+g9DuaEPEtTx/j+wH0aTF3OMVZbx
	 PgaOkNSjoiqv0LBS3kR48sXImO5tS7nDcHyltYoReT1SpXAbNMCEn9zKvMn+Hq5U8ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566654;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LFolXZdiNE0cRBatx6g8E+ErWY6NEgs7jkegmo4gMnU=;
	b=NzjMKB0xSwywaVQziI2D/c1RfrXGWL6+6znG7KSCvLpemARZ5Wi9zefveGfrRbBkBDbf
	 gnSBbY4/svtMP8tqIGBZJnLpBMEneZio6rpiAYUwhDaRgcpPSdahtAIn39URukaRhEie4
	 ulD9Xm/nd4zhxAnm5rGIGzi/DaOrNEAEbpKRJTFICNauyIdRVHt8jBWWrmD1nU9R/pyu6
	 u1fvKfh9WLzVD7CIkyD1ITaeXiaQSyJ22vcDJWVJdrdcIM9J6TJzOXJUAqLpZURHHtY8s
	 rfm7RcWxCa0AOwR/4qyuPDO2KYlhIxuncNIFcSLXlDg0KCupWr1Du7uC4UbvshA2y3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NohmtB0w;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QSpE0bvq;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4CC606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 20:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4CC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NohmtB0w;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QSpE0bvq
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5AC51400179
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:57:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 01 Nov 2026 15:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793566652; x=1793653052; bh=LFolXZdiNE
	0cRBatx6g8E+ErWY6NEgs7jkegmo4gMnU=; b=NohmtB0wRu1m0ecGj5Ei6RPv2r
	1YU49jnM85mDojTP+PZDqPtigEfRB9LWzVk80zO/u90FJhIunyeeQZShLTIMCRlm
	/psjSCpD9re1NzAQjhQEf30rYPe7ZydzR4T6b9c+OVO+kGZEi6vV0ltfnAbxZVQZ
	6LoruGhE7St8kbcb/IlfjaMPsB8p0d6D04Orvh4tR7MXNWjuX4Zwq+ppUjLtje4b
	X4cUVf/1J0ONu1LzkaogVKLxVO7q0ikM5BE+3zcQOwJIOsnwuCDGLF2FkP+JQQ8w
	08ZB4Avs7kOTzx3p7dlOmlpOX5MB3sBwiV1LkXG3k+8+GglJxjIeJso4V1bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793566652; x=1793653052; bh=LFolXZdiNE0cRBatx6g8E+ErWY6NEgs7jke
	gmo4gMnU=; b=QSpE0bvqm+KgtqTFXLTU6dP5+0RZvSGigPBhp3JfY/LUgepIupS
	OwMfL89Pn1sY89fzmq93f+AlpCimWZ6eQgD1M0hlpRG878BAO/Fc9z5JpyXyBDq4
	FzdngCRH/QVvdzHjZnEaDEQP/PW2YW62CBCpfWiLew4kUMMcReovT81nTeiZIU10
	NOc6wBolMBfu07n5liZlGYBrJOTrkCNCFqe9S1A5iMJ+/el2N2GsSYvQxtu8cW5P
	dw9yazVFnhlfOZE4lvr4enrYVLEg01ye2T9mGBgD16nCVXmeU8P//U2qC5e8xDYy
	QXIfoO7qvW+hny6KQaQyG++MFyiCuKXgVYA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793566652; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:SfZ7LbkbSvoVw88sTTndErT4LsHO56pPNbq6z8PV8k7WhZX
	PnaeXRvaieCLfyFhMt+1Nw2MqJLLvHs8TFAGpSHSUvPu7Z+4gRmvzMyBpG3fc+Bp
	u1r+cgSDm9KL8t9MycfqCzZTf7RstpiaYy2Od5od1QDz9RrJvtnZQD+53aoEpSOz
	vxYrD3RG1p5g+U3apA5v2usnjyszjBD6suhFar69TwOhms+6Xt1sHx2ToqI4VlDx
	RFv2rmW454oPaWy4gOrWB+ShbQocAl6JBrl4shKw0n/42TsjQGMDZTKHRGL3oR9w
	kaZyeiFFqNZZoFtmAvswWGzz0aOaKd7KVewSVPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5GPal9qmP61g9q7Js0FdEgbsEVwcwgrgCjVt106+XI8=:+8SWdfaLIYEcH447U1cF0P3PCr1TNdzjD9fsLKjEIZ8=;
X-ME-Sender: <xms:vKfnahuKBy1o9Km_S4xBiQGK9c7MypJbBuQpQRQb-wvwcB9TaQ3AVQ>
    <xme:vKfnahX2WsggvrWoj3m0KDkRX2yWmkGe5jED8peM_gsKWrSFARap91TLB7TqjskcW
    2CIaMuME1FVVCUzrBKp7pvLwedN5VbqASnUhoAukZ0NxJ4WMgTGe-8>
X-ME-Received: <xmr:vKfnatE3QLw2D2IpxrrCWreTUa-o5xXMjlv4-_Mls8JZO_3LzOgmR3g7pqHcxhAhUNBPUROErEq76f0UZBbH8L02p0k72U2zrH56>
X-ME-Proxy-Cause: dmFkZTF4wMRVi6n2Ho3I8r6p68AmyEJddhcsXSdPUoxaS5cOBXtoY/eDsAmX1O1q9WY8oD
    jTaPbwVeigbB+X2LE3ccQpmeLezyoyHuFy0vKXyoRk9kqAVYdPa0BQdT/4rblYBJoG1S8z
    8qtb4TLU8XLJr+bic0oC0Kpid1vLFVSh0752inDsqfv47sjpBWeQZGy74aLSJwSkSn4Ews
    ssP5uqtZ+8GlpXgguGO5x/e4B/gL3vgyoxpi9RZ5EQn2jDSI4YAHLyDqxqmd+LFWwUg/wW
    urvZUIa+OHQsWWFnJIL/tdFTuyB9HAYonLNojh35r/WRCfnj+ajhOrPDw2bR8RwIohiwr1
    MT5B3+cslUfQTSqBA+YC99BpRYYdEC+xkqGln16iKXTQfNKKjhooJaOVkbZ5TLdtfldonF
    3xUn0V0SjYk4K8v+/sW5ZoGPh0/4MiqZCKtdVTxp5Ni3FGeg0e5Sau56FpMxJZW7OlhKVg
    +FfaZdp8k5PjQOjPQ2ibtAwMg3kZHTbggPQinq5gOdWRiGnd+2s4CNJ74T4I1mEZ/Dxs1j
    U0hXLNVN8IKTHNTgVxXh7cl7xgGVJF872BRu6N5VfZIoJbGO7YM2KmM62OWn9edeaWyNok
    /v5H4f/FxbdKC0Aeiyqj2N/VDIqHqGdiC1Ik4pHGru4ism1L9lrw9KJfQG/w
X-ME-Proxy: <xmx:vKfnaj20yhFofdclIJL7_vMbZuF3gQynPdPaIDTWn4T5pOoAZyNOCQ>
    <xmx:vKfnavNIj_T1vRCM5jDH5NgSwhMsTSdqgwiP4XeDHsqiGMhMuNUZcQ>
    <xmx:vKfnai67jNoMmkz3bv1kN257EY5CcYiAnUcd1w0oovEIGmB2-7eLmw>
    <xmx:vKfnap1OuEatiY2zJXnjszjxh3PuRE-q1a6YB5RhS0Dh81I-q3IWTQ>
    <xmx:vKfnarCohZ5Uod-0cnmAYrFJ5u1q1om5Z7KlTotb4OtFmZ__rznT-8GX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 15:57:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  ps@pks.im,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
In-Reply-To: <4brq3bxkdq6ewviznwrg7uqgpp2j6xf2bladpmdrpaypcjp63t@lqfpwwagpbss>
	(Mike Hommey's message of "Sat, 31 Oct 2026 08:20:47 +0900")
References: <xmqq5x0df19l.fsf@gitster.g>
	<20260917060415.2986259-1-mh@glandium.org>
	<xmqqh5i6g3b5.fsf@gitster.g>
	<4brq3bxkdq6ewviznwrg7uqgpp2j6xf2bladpmdrpaypcjp63t@lqfpwwagpbss>
Date: Sun, 01 Nov 2026 12:57:30 -0800
Message-ID: <xmqqtsm0z2v9.fsf@gitster.g>
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

Mike Hommey <mh@glandium.org> writes:

>> I was looking at discussions that are older than a month whose
>> patches are not near 'next', and found this patch, which we haven't
>> seen any comments or updates on the discussion thread.
>> 
>> It does not seem nobody, other than the original poster, for obvious
>> reasons, was enthused by the topic, and given that the exchange on
>> "what happens post Git 3.0?", I am not sure how badly we want to
>> keep this topic.
>
> I, obviously, am still interested. Selfishly, I'd rather avoid having to
> maintain a fork just to move files around.

Sorry, that does not sound a strong enough reason to keep this one,
when I am trying hard to keep the number of topics in flight.
