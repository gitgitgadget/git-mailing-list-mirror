Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793462064;
	b=ZPYnG+RXv65cWjF/O4hRfaB9rtNTwX4IJpLKsxQPhws7LZ1Pc0XEWP+kpzgI6ImmgmQE
	 wZMIk9i0zq401jjF+kDnaVtlthKS8IpScqXtQ3WbZeyMdjbZ6ioXQB35LRJ4KHzFaGJ6p
	 q3q6Z5feuKeI/abXm0w5nCHv1yVYOEDsZCatdoyZMgelE5CZeWlBLwFZ6tqL9Zh0sXSSQ
	 VR08KRXQDC5jG3/uywSxMmoZh5izykTs4dER680wuBMamEHLR3R/synKetEQqdluRsdy5
	 DNqTqhRB0LwGg+muDHIe4FDguaRvIQ5wk5vq8l8TRKqxvMPqkWX2ZkjRh7txANOAPUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462064;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Iv2chM9Uc+0AD2T0eXWUJ5SeNYwzrVbdBjH76gtNqk4=;
	b=SoKjGX7Z1ZmQghsosPS0M0j5ByE4knYILo4ZeBEvOYuegXwvw1YFyDkT6tvp6u9xfZXf
	 mZu8GcDZWeHBbHRQbw2ZlDKyXWmdqwTuLA6hoTeukz/ChIUOQr/HTjVhK/91Dq3/X8rMs
	 75sCXS6Nr6j//Gkb/E/1Gy3M65RIzcF+Zs9xveRTU+ohdmz4MyhmgHP0tGkFBvAvjNiYB
	 B3lR8CYBXLKBUmGaAC1as0kEYqGEW3d5EyBxK6YxC3oVZGaiwN0KH09scrgAUMsBz8W0p
	 VGQ+SnlH5xEvdfAG4EQTJ646muyfl/NPLoKxhL4yM4VCyYA9qa9EqVz+FyCIj5J/dIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ECBn3p5O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PFImX0HB;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F0C606A324
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 15:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47F0C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ECBn3p5O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PFImX0HB
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A17387A007F
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:54:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 31 Oct 2026 11:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793462062; x=1793548462; bh=Iv2chM9Uc+
	0AD2T0eXWUJ5SeNYwzrVbdBjH76gtNqk4=; b=ECBn3p5OI/AY9FMgWzB6PTbKkA
	xsaWer5YcXAvQN1rjYJ6dB7BlnHvltAJDw+3yf0bLemS/M+OQdDprXJNy7THc/DK
	I+gqv7sBND+em/y9RU0MPybD+ID21Ega9CT+vByBoPkrnOTlCiMOIl2AbImkp9Oj
	sFjSJx36S2aahwPWBkIbHN2Qc1hlosKOB7ZkuIfUnxX+ZLJXBLBQf0DdUhQls82n
	0tmctOTYqqUX1hfg15yp5wPB5ts+s+qH9IEvLYjUA93AyRU/yzjxutx/dfixQANk
	XFP5R+1kmoDm1ki85h+Lv0r4YMAXxI2MMgeRwA5mLlsXJzoSFHYpM12fmr/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793462062; x=1793548462; bh=Iv2chM9Uc+0AD2T0eXWUJ5SeNYwzrVbdBjH
	76gtNqk4=; b=PFImX0HB9rapkKIBoqfRwdNrvXU04d5wvwgqiVF20diqbEYvx28
	kL1newmvsEzmmoAka7dcjiMSRNg/OE6XMRdKbAKpFUEfnaqBTR5xXQufCs36mqPn
	iL4K6T0q8lbH1VxujvEmLaJXTDeSPaVkptYyIDiu9/4IgbadauPW8gPxlhXyqCAC
	53FYCZp1TTEukoJYJRP7vabS4GfxHekTNTGzS0n8Bvm9/Mfsd3Fg4wvThRabI8oG
	4WYmtYCvUFNEaFATIE6e9a7epTvgUAyCfLnHg2uoyBb9AhmO94SbGdu5I0OzGhGw
	CaXg6Tr5oLXd3aDiLLQAKKaxLbHLnx5JCYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793462062; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:S+AxknQYgkOwGcGCDsDq3jzJehRsTSXkuc8RD/+pQPxkh2M
	pl6ZbP6bTwP0iffIgQ5w1EKQgnmGwYd0VoSw0drSr+YHLu7joAOQ8OEds0dunzd8
	a6w3H3exl85505izXE+SPznRUb8Cb++HxjCwJVc4fXI9myfcTUAq/q+uorrWy/Rz
	xlzRdatyw+lVlGYyZUMC1SEayjl0wl3oaPJr5M4TTfU10+tGXoGYittD78I1nriK
	KxAFKyDQwOtG/5OQrr1v8iDnHYteNo8NsrAiT/P4lmnpGNuFQmS8GdzXnIHPhdb4
	hHHCAf92tJ7Rv97IBfUmfdHhWsRzii23Zb2vlHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MP1wdP6y/BNmcJpYmG9wRW0s8/ZmY8R3r+hqgwKlwmo=:Y332ugnGis/7Zzfq39pC+bBP3nnoVrevsuHShBjajbo=;
X-ME-Sender: <xms:LQ_mapXKTTT2M89_GXRQgnlvDtokCZR7B4sgKccX_8-Gd2JPDeKXTg>
    <xme:LQ_mar0jSx-9Cwhg3F8FTwRASDwAqs4tNkNkELp7_ZfDPuhOrJR3now2CmuKBOTMT
    Wz7_dZmfHunBH3TgDkUdi40Vucxa18ysME4tChXvm1VN_cFQQT7S3g>
X-ME-Received: <xmr:LQ_manrhmZjLJDimxxiGWrv5Xk86LdalIEUmpyKKbTNQlYASufhc4lDQ_knMz5Y99w6ubbTBJqryhgXq-GbioevFTEviR4FGl4er>
X-ME-Proxy-Cause: dmFkZTFFlC81JspvysM3kwoZxZOZOQKpwwPIg2jLHxWYqycsncsaqBYsod7dQigTzyVFN0
    A6nKNFrAWxnRSMirEAbespNxlVZ6TiSyg6LlpYyUYZAMMAgA/PeC6robph3DIjOPj2QQMa
    RqXgRVihdIf1icGZqhJtwMsO5k75g41No36XDEm1XqQl5GC3bKeufzN89wEqUJIsIP6Avo
    C86dOa8NhQ6Vqx85PFG6VgVbd29UestLgISaS9jOtOIG1p1NQY4/Dk6m/Y/4zJUD1d2FeW
    EhYgdfwEIxCr1CTIiW8Lx4/IOtws/mZGwBQ3Ewva/narz/J6IBVjOBzee6AiGiKtHbKBne
    S7rp4e1pAgFx68wgSw8logxPqe5BFqXt4k5ZkgjcFMQuAk2O/cJ/EJ1CN/Vcg+k8/4y5po
    NULcmww09FkWY3bBFETN3PIjUl0s5EKPrx6r34RcWj0uEJeOtejb3sSIo/2CbRxSV3pPuG
    dJmdlYeQYkMXsrHNEwCCOsTyibML2haRXyPn9HQfVx36rcFjThLOIL711TThpMX9Q4KfKr
    yvYmHLq/XdLzB75OEqe4avqwmsTTK+pviTbPNkU1iCvKVGuDH4vjb6Oj1zJ0qRtyE3mBkR
    Mb/mJcY6F1a8f6pgHX/Tl7qtWCTkxfkYXPHAntVvJM9FY+9mize8zycyrVcw
X-ME-Proxy: <xmx:LQ_maiULQHGmQlnGaYIec_9PA2tcrQBWmIYAear8jpWp7gLYNSV9YA>
    <xmx:LQ_maibRGGbEuoLuauNxOw7ha4USpVbN0gYhEp2P3n3ZQCe6S22evg>
    <xmx:LQ_maveQztlvyhf2gTJ9P9RA1KeAiU-IbkWouNmBefAoe82xg-ECiQ>
    <xmx:LQ_mas3-v5xfIj4E_ACnh2XVO1cFsM730Dey170JzsZw6WjSLWh4tg>
    <xmx:Lg_map8_BhIYpVDdBbkE2sSB4fz8yCzN8RIGeGLpqIvTKN4n_TZQEvz0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 11:54:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Adrian Ratiu
 <adrian.ratiu@collabora.com>,  Jacob Keller <jacob.keller@gmail.com>,
  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
In-Reply-To: <20261030150739.3855910-1-lightofmysoul@gmail.com> (Stanislav
	Aleksandrov's message of "Fri, 30 Oct 2026 15:07:39 +0000")
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
	<xmqqmrrzkppq.fsf@gitster.g>
	<20261030150739.3855910-1-lightofmysoul@gmail.com>
Date: Sat, 31 Oct 2026 08:54:19 -0700
Message-ID: <xmqq1p9550ic.fsf@gitster.g>
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

Stanislav Aleksandrov <lightofmysoul@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> One bad news is that t7427 is taken by another topic in flight, and
>> this topic will break tests when merged to 'seen'.  I'll try moving
>> it to t7428 before queuing, but when a new iteration of the patch is
>> posted, please make sure to check (1) it applies cleanly to 'master',
>> (2) the result of (1) merges cleanly to 'next' and 'seen', and all
>> three pass all tests (not just 0060, 7428, and 7450).
>
> Thanks for fixing the test number. The t7428 squash looks good to me,
> please squash it in.

I'll keep them separate, as the fix-up will become unnecessary as
long as you remember the need for it when the patch leaves RFC
status; the test number crashing would not be the only thing that
needs fixing, I presume.

