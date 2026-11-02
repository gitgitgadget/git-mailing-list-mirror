Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610077;
	b=TI1440KlbZd7OsHePS1A919Y6g4UV4MwccVwY1QuFMn+oiFxquz6hAAdmJcxJ4oObB2M
	 v7LYHLUXER2pa0uVagRbVaE9kd812tS6wcYEjqqirvo0AkYuKT97e0rYOPqNaz5O8g34h
	 HOj0Hz6rnlP9nh+ef3bGdZTKo/rZ23xp+0pEXPelOfx93XEBPndLKdSVNqgH7X0zcPO/6
	 Y1q99vWJKd5DzahKUoqoZPPTY6Dpa3oAiApaSvYFe2wepuXUcG6WVmesu46YxiaVT28eR
	 ljI1ai9YuWVHjfpsZ53t4UF5icNPcQWfb5EokAN51HNewxTYErzwNql3P2PvBzM6cVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610077;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dqTTuNmfqELQiPK/nZCtEGdqEjZ9jOWhuNNdAKtPIJI=;
	b=K9Fr3RVWaUG9Y/HjIwML1UueoOEt7efWUE6GrJwwmDvg5Cye1INmC7UL9QWMHYtFZReG
	 3visTwrJ//IaRIR2i2b/oxmcfDykcy+S1AZNBEYADqWHchWS01uNGW2Bxa+4+n9v8XHEZ
	 lpYUcn+23jFQ3Y/5oTaHtnNazejvcxgeau6S6DzZrPR7AR1WfcZEJ3KxpP72En3VRSR+q
	 azmCKfERkrCKoiKCTAuBxAQvbbAwKHIFuhJJAYXYjBZ4zH9GDgMEJ3xPMEJmNJBlyRFea
	 tE1qZwVZd/xPRjd/CQKAYD32Dl8ONv+Istn0J3Cx9MzBrJXZAp2+Z/CotWJqXh/HT8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=T1mIFhNt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ho8KZNmo;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781F606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5781F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=T1mIFhNt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ho8KZNmo
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1CF67A0056
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:01:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 04:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793610076; x=1793696476; bh=dqTTuNmfqE
	LQiPK/nZCtEGdqEjZ9jOWhuNNdAKtPIJI=; b=T1mIFhNt+GNfC/1UdKOUq9Iuyy
	WUdFmdNg9w6MV2UmIf+TVoc9JohN+QU3ZvYAKlb6BDbwL90YX2I68OltDZwwHR0E
	hYoIyOc6NcZywAzwMQn2GXTHZ+y35t+oSbCzuNOBWAhv/n334nJweHd0vZefDgIn
	Ed9gTWeoL2rnoJLndzZjN8jZ8Hyly+yiNw6rhXjoX/xdySIr43htH2Euko2jgJiM
	+zRffk4gsBbUJ8GEFwk1wHCN2Mp4gy6WYo6rp7vmABjAF8zvUH3IFBWFTGk2Y76z
	7XG2YYffKIqTKUuXv9dAS1sBgQSqH5ovf6Eo6003q3nwqetifJCViofablEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793610076; x=1793696476; bh=dqTTuNmfqELQiPK/nZCtEGdqEjZ9jOWhuNN
	dAKtPIJI=; b=ho8KZNmoMXtjKxunpeC7/pt92LvmoD2IYqF3oLocBnjYX8kI3xs
	FBCT4BsXWSdktbtkAEKEb75TlTVwzEWgjg38lO3zRtpGfSop7L0erbwMbGOPYRxf
	CFiJVzVwUmly2zjqeT0TFjV2/GvXTAFqAlg3B5aftIM9mAwuS8uIwXXH7PWQe6et
	irJel/TjZudneJaTTgsWsqwQ3t0HhmGxWr661MexxBSEs4TE8Yx9V3k2My9usZ3C
	y2CCWCiLM0P3Pk/0u3swgD+skwHO3nTcAvNIAJvVk7M7XwL30LO4B9XSICgVAFZ+
	eR4xJFhykk1R4p5co6n2xYy2xptGsyy9/wg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793610076; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KPIoAjkeJCeD2IFEtEy9SsHsreCKdrQaVCzf8kTOfO6Plm8
	ZTzA5u4WhQAHSC0o36G37S75/unX18ZR2Qfq+URp+5o2Hmn6s9+STHzdqraXgtC5
	I1SGnPS6HamBtNDWLectO99usqastwv/LfxnEIVB2mnPN6KhRBY2RhrfxGvgOvnS
	S4cE5QAD2xXxftkULkp1cqa4QM8KTsHNmL/VbmMab1ExsGFFvVcHgoMi4BuK/M37
	ZG14KjlTnraII8dsq5OKJIhj6NeCD+1zPlDHB1WhGr8cEVaeJ1jWJdos474h2GA6
	W54Vu8j01tidQuosUnLv5S2Liw7+JdZmvORPkMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/m7/yB2zJ/fqtTaiVtLjdO8/5MdQOemXK4iPDxSlKMg=:nlJ7ocMM7Yjajk/J9uLWb/iQKoT2QZipe7eS42jvf7U=;
X-ME-Sender: <xms:XFHoao53OaT-_TI_VgfHZ4r9oNq5TVEcyKIVvmBjseCzX_caJ2c9DA>
    <xme:XFHoahVzm5pLFmDAk4mpvJjZu_zQF7DdCBEHqC1aoV13qGr9BMYI_FhRA1-MeCOEw
    12EMTpOdGml4SDvY2B70PJ_I0y7ArJYLVGzXy93u_ej2kNx0ZSez7Y>
X-ME-Received: <xmr:XFHoak3mbv8DFGzfkFvvIjmosbhINxh_iBHScTKrY0lULAfj-KjsY5BDbOZSrinAloppTswa4x_WcWQx-0tUJzjflfZHSkMUvibH>
X-ME-Proxy-Cause: dmFkZTFoxXqAl0cYhkZI4CUOXBn74OHeSTruGzujThl3Q3sqaEof1d0mHJXtqdb4TIaK8K
    V4wdQCruLcobwrL+qIZrAmAz8/+g767ZEJrBAaJFmh1j5L6o5R7rO8kop4kw2KIogX3GuK
    5yJr5g0gQVMT4FvJctMDv1E1zkpBNHyYjDeEaNp6lYemCUSfD95WtzYa7teov3WxJj8HtY
    qHEt/2EbwtOlluxaWhOX7dcHf4z1hoMOB9drRxq+Ba6XiiXpYvjges0bxsceTntMMOACYf
    sYfhyiCbplQcSm1eRk1M4SrzZ/BvEbPacBpOhYHanf47xfjAblNObnl7Q1W9vL+Be82VIE
    oLNaTINs4n+tplgZs/1GOBEAQA1HfICSzIyLPLBS5EI49xdIK+UzJCYQse3J4EMM3b+NZx
    bRSryYzBMFDhgCP2vQPpeJwhHFSbSFfUEXEBywfakBFgcrHp9LqVfzA3UvOSCD0iumkipG
    /1eOZGz+wKBGjSCXzSeau/Yc44wvTPRhVFZgd8GqD96ccue+pbTM6ZyceM7ea3dm17Elbh
    9VR2KNokYv3EfxbntGl18G9pBstARQZQ9HfH6im4AwXB8z3iCpsYCTAi4EtsM+4PnbnTXi
    +RcuMmVlHdWNxrcA/JxdgkiMtw4b6hitCyKVV0WOz12JZ03MAPjTeHIBQD6Q
X-ME-Proxy: <xmx:XFHoam3A52LvLisR7zs1RJyUNQJzq3cUzYh_TAv3FNQfgxflTCf8EQ>
    <xmx:XFHoav9XbKh23FVRjNyDvOuEjEDORXPUHVvryJ93GyAP9ZCh36kQkA>
    <xmx:XFHoar0S1li6zxkUNLVXA6GNJlgQc9cK_YeOVHZsZdv4dr5wowCt0A>
    <xmx:XFHoak_SCsKyOh7lz2FSyy74FLc1FuXMVe6rxEVtmCOcUSzO-1jhIA>
    <xmx:XFHoamTdO-OwHIirTgqHvzt5ctxa0oZAN7uMh6SD7Ft9lfmMD4BoPjkX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:01:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Wesley Schwengle <wesleys@opperschaap.net>
Subject: Re: [PATCH v2 0/2] git-svn: don't print v1-layout migration noise
 when there's nothing to migrate
In-Reply-To: <20260827234345.1037130-1-wesleys@opperschaap.net> (Wesley
	Schwengle's message of "Thu, 27 Aug 2026 19:43:43 -0400")
References: <xmqqy0dr8npo.fsf@gitster.g>
	<20260827234345.1037130-1-wesleys@opperschaap.net>
Date: Mon, 02 Nov 2026 01:01:14 -0800
Message-ID: <xmqqjymvmwth.fsf@gitster.g>
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

Wesley Schwengle <wesleys@opperschaap.net> writes:

> Sorry, I missed the space when I reworked the patch a bit before sending it.
> Here is the new patch set for the change.
>
> Wesley Schwengle (2):
>   git-svn: don't print v1-layout migration noise when there's nothing to
>     migrate
>   Makefile: add NO_GIT_SVN knob to skip building/installing git-svn
>
>  Makefile                   |  8 ++++++++
>  perl/Git/SVN/Migration.pm  | 16 ++++++++++------
>  t/t9107-git-svn-migrate.sh |  7 +++++++
>  3 files changed, 25 insertions(+), 6 deletions(-)

This has been hanging without receiving reviews from anybody since
late August.  As the number of topics that are in 'seen' without
getting any attention is getting unmanageably large, I will have to
drop this topic unless somebody volunteers and gives a thorough
review on it in the coming few weeks.
