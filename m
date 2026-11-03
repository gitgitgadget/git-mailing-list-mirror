Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734185;
	b=BS9PpgU/rNfO6ShnxGt8gXWrE/QRKG1WCJK83uOtrMLNF7hytCRW/RB+uEmDSZg+ZsJI
	 kNDjjB5pCJ+kt17J21kLSbbWbZAIt0pg5kfvFG8r9HZxnUIdZDr93jfDERKzxOytsAftL
	 zaMU/4gaAItERKEICXGBF0nF/EDSC6JKkw8zaQsFR/rL6a3IDn0zrxydcWlcWbUsOi0S0
	 30kAuUcSZn+8Xu6WCvaRviE2nW31MKewEoV/i0mF4DClU3ObUiSspJCb+o586xTzgEO+9
	 qjB9ZEA/CU8pUNKTzR5mViFsAoc5NMCHg9w533/BJZZEufx4SlYdczUUYc3uSViURSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734185;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9Dm7EYRpUk0tHGA9UoWZ4zwhs7bYdvIMupo2bhtE7o0=;
	b=3NhDj3O314jy3B+bYo4JEG37GtCJkQKUE4f78B6H6LRZfBGM9a2GsYA34vCmOw+rt1mN
	 fNu8fx9glLsS2xjVh/QCwGTIrP20XO0GeAIU1nfiSrjS75WBarZ+XHxNVV5FtklCqYP0I
	 IIkkgw7u9E6WYUT+rrcncim03ZJUsWGXHm/eG3SRtliiv0DxerWD4UswJ2IUOqe1iLipz
	 VYyKzel1d2Iz3Ss2GQQFWMdmscFmd8WD5Wb2g6UK4OKuMeMriUcb5cGphVQuoA4zyBcjQ
	 KEAoaxwgJXGKe+2zwqOJUPKULOFfeoO5vaa1gX9fmkZ56PESP6YAjlPk4udYhCAMvDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kUWGrtsh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TalTRHTi;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B8606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 371B8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kUWGrtsh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TalTRHTi
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 79F2AEC0654
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:29:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 14:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793734184; x=1793820584; bh=9Dm7EYRpUk
	0tHGA9UoWZ4zwhs7bYdvIMupo2bhtE7o0=; b=kUWGrtshI1plW8I+/0im/EfK1g
	7YDCRkK9SXbx/d5+55kBfnr5SxuVh1rTJ8jn36LzlpmAnyUtZ6yDm8gspw1/VGK/
	4hTdUjQ456uglOruTU2bvCECgHtCWi10OvrkOHwmkRxD3srh1CKPfqrVtGpycfw3
	M+SAEyjOLoiYdU5m5awUoQU9/LX2FGs53mPlVbafo7GYRBX5HtPXpiywjwf6GIx7
	xZdTLWtxunCfunsNGSyXu+5hvWI91rggXx2FCD0YfXXQuT+Jjpi7pVJXooJkZq4r
	ywrMxvDiwJrtr3p4L0glw8pTvVFuMfBFc2CAB6B7UCIw2fsE+izm6zdkah8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793734184; x=1793820584; bh=9Dm7EYRpUk0tHGA9UoWZ4zwhs7bYdvIMupo
	2bhtE7o0=; b=TalTRHTiDwFo0HH5LP+nzv+yAnwmxqt5BoAzxXiyYLwk3MRvosa
	lyJAkv5pblsCXO/qfbxJxti+2Q+ZJjgTX/DvguWi991Xgwn8c3fMFaODU2lBD1zE
	EXwvq7eqhOf1tZF9CeK8ryvwW4uqcY8txV8y5g4Mv4bE40C5tpnlG+o0DeCOhStn
	bE0rJZHl++FETgkRPYUDfPQ4EMT0M9HdaSLJ20sO28oFJ6uH9hmhAsBuzDLxxkkL
	UbltilihrLKUaNrFTC5S6u/2Ckfc92sjvIEzuS+T8sOBWTVomWFcer4ltLxt31Jh
	EkALAB/epTQ3hGWECblAgF9o16/9BVurTVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793734184; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:M2AuFSAVM6cDq3sxdDP1F6gf8li/h3honUJKVwoGJYzq7nb
	4/rOD7mZr9cAulvmbzlwkvvGv6cmv9dwHOnECmwDQuRN5epazBai7J1EVgg5i+By
	7NSfv1cYUxv1pWqYjRrJiRyXm+kPFXh8Wvl/Z0gMXGP8muPkXATkVcNhbsA31yJN
	uouGivJaSvbrK8d2ZwCCjM9ULBzdzseoamqvR11+p7DOiG0DfCIOtuQslznz8UGU
	D4meXaMKmlawndDeZmang6Z4MP7ZXN5vdKYESJ9fD1O6+9ija54EUsRJi3jNcspF
	mubXNui0isHJEWJZ9jJRUJBAYPdnR2ZRkx/bbfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:m+7w/X36x9mypKTn38oc7ayuq5MVgR0ZvdZ+Ie/E7uA=:+X/3f2FSHOOCE+BAglnznhJaVqc4Q06kryHiNSvyYCw=;
X-ME-Sender: <xms:KDbqanfKsMerST0o9reBBL_lHA_iCE_4zUfgtiN6glVNMT4UpZ9nEQ>
    <xme:KDbqakPfDxdML-ur14rl21rDArrdqRXflwg-ZAKAd9-_chQE9XMoKfsVTS-bW5xRl
    zmMVD9QO5j-KGTmhyUw6xjaz4MlbehBxSsqpcs49GkCK3QTwi0Iga0>
X-ME-Received: <xmr:KDbqalhPBm6qRO7Ie9SfbpfXdzZxWOuz0uiAKYdWB9mXoAd0AEB7wZgOjklAclWsPN_IANz7fAFLK4pbjjo-j8rFNAJp_E8RVzdH>
X-ME-Proxy-Cause: dmFkZTFr0rfSVzn2Ebf35fCG5uXofI2nzEt3Y6DJ8pXJb/FbD1I3m2r70QkIQQw1VDOtj7
    3U1g4Ds0Gvsf2VF5jr+B0/kN+ZbnZk6z2Z44OmDA2oTEHFh/wtIBLi0PvaxxE43wQGibML
    BcAEE74WFMOZO4e5d+/sJnlK+k+7osjC/2yCmfb/JXA9i+9anFcvUB9PXKguP0kdDKKogP
    +goXJSfNTOnJqoXrjmqwVSkVv2QJncvAhbsw5FjYiqR0elT52hrYfvyQ3/VIAnbdAFnEBr
    pAgyY3syhGNOPhonFh5C4Ibkva+aMhRyoaChIFCswgJRTog9iGZ0wKXgsugM7JTItsQqUu
    iMtK0ZXe/K6CEJXqIt+mswx7D6J6RVheKwcJCyX0MXViWoj0wa1AU5TLslOuXZmcMDLY5J
    y6Bz/EgsHUMz1AztEFftBSkeYvtREBSNeKFw8uFOQbw27s8eeFKvAdHeSxg6MzZXK1FQi8
    V9jKnwc8Osz16n5SH9HuDr3L5YRrZuUsNVje/zZZILSpcz6F8DTiBHpHGyUcAO11FsuRAG
    b6xsnrThwTBjLYHH8pZPtmRci/s1+MiJ75GVLvOjC/8URHVAo8AOuHK4v9Or27itoXOhrM
    IMqbiBW8tNUXOyAlEExDiF0y24EUxX069ONbi0og08SwzbAccpxuGhrlAatw
X-ME-Proxy: <xmx:KDbqan3mONJnP-PY0_b65Sf05JbEKM4X8Be9Q3Zdrdzx-LYEo6zOQw>
    <xmx:KDbqavimyy9FFn3lyXCWidNeYmq-_VJbvktEc4pP-H1ZTR79eT4Qjw>
    <xmx:KDbqanc175yCnlPn7CZp6mKj1_Xl4wblK_thOjc8oV1Lj7TuZOxMhg>
    <xmx:KDbqainBgb-YDkaxuOE_3b0WCYOReC5S9J6bQBq6eWLIUY6Qhc9vtg>
    <xmx:KDbqapATjZvUzx7zczjN-HNK-tQqCLPVrN_cGu460uRwwVWHNbEmTF83>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:29:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Ejecting things more aggressively out of 'seen'?
In-Reply-To: <aumNkxzE7wfa519p@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 08:30:27 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
	<xmqq1p93ofjx.fsf@gitster.g> <auhfD1ryB-7JwOYl@pks.im>
	<xmqqv76fjjhg.fsf@gitster.g> <aumNkxzE7wfa519p@pks.im>
Date: Tue, 03 Nov 2026 11:29:42 -0800
Message-ID: <xmqqh5hx7ly1.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> An obvious alternative is to queue only topics for which I can, by
>> judging reviews on the list, at least say "Will merge to 'next'?"
>> with enough confidence.  It would reduce the size of 'seen' and the
>> friction felt by contributors when their topic is once queued on
>> 'seen' and later ejected unceremoniously through no fault of their
>> own, other than their topic being forgettable or uninspiring to
>> others.
>
> Wouldn't we lose the ability to integrate topics with one another early
> on to see how they interact? And it makes me wonder whether this will
> overall slow down progress of a patch series if it gets merged to "seen"
> at a later point.

Even when I see a topic was reviewed by humans and reviewers find it
satisfactory standalone, it would not hit 'next' immediately.  We
are talking about topics that flow into 'seen' without attracting
interest by people.  Quite honestly, I do not think anybody should
care if these topics do not play well with other such topics.  It is
the job of topic authors to make sure what they write meshes well
with what is in flight, and not cluttering 'seen' with hopeless
topics would help those serious authors who do their homework.

Once a topic is found interesting standalone, it is very much in the
projects' interest to make sure it meshes well with other topics in
flight.  But not before.

> So maybe instead of someone saying that a patch series is ready, the bar
> should be that the patch series has gotten at least one human review
> that was somewhat favorable on the overall direction?

It has to be more like a trusted reviewer saying that it has
potential to be a reasonable change.

We shouldn't require perfection from the get go and instead expect
some more iterations after a topic hits 'seen'.  But it is a promise
to spend project resources on the topic to have it in 'seen'.  It
shouldn't be triggered by just a random drive-by commenter saying "I
want moon and this is it" without any believable explanation.

Thanks.
