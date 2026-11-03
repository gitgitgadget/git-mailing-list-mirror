Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733080;
	b=Ab6TSiyGJ2aS7Hv8HgrxpKLXbZyAlpO3EdbPmp5NdiZ1z3R3xoK4txFh4HbQiU3wZmvt
	 4EPjjN7nXIHGMKXLbdHm+7w6woV2araUdZB5qktQXXeaJdNwwASuVrIqGr89hAzOv/Ur+
	 vXxdWF3UJ5WiLOfjRWbOnB5KJ2WOsOj9/TGe49HeRemMORHgoU1bjfD76u5s0Vl+50JAT
	 7/s4dZklFv8iNFZASfS05oiSTkPwmJAatpcGr95/FE5DoqS3YtdRVu9FeCtxdTK7gQbbW
	 kPdK4ElXRBBRMUcuoQI8ES7zanuMd1iZP2KxmQzkyIqEbrEni0rzwUotjsoEhLFxYUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733080;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZDAMMbNiqGdJPVIzsBgHYElgK6oCCX3fxcK0d5hsXtA=;
	b=uBg99p3maxG7CnIm7BtABHpInUXzZoIhusTVbMvkGppmeqMIt38S0wF1f3/G+tYUCcmr
	 BcNZy4rMUc31Vi1RVcqQ+dG1SJemVox1qjhKgS3Kbe3Pd7QmZ974H78ZFJh3AW+q3UNaD
	 1QdiJcO1OL+2XFAC81S1SLmWelPAFvI2kqprGcOKaoZmBNYYvU23FtSabqv6sYSiGzujf
	 3KP95kG3Gl9CMash56daCqGA6y+KMTFvG+oIltXXG5VDNLOhov4NPm2Mz7KAFWYOx4UoW
	 Q2gofUDh1p6u55PxSMCiJd7rcpzWYQmYRVkQmC/LCEilpjMkVEHMJewjLnnyIJMim4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l9+C5nAQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P5HbC2Xh;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D193606A32D
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D193606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=l9+C5nAQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P5HbC2Xh
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7A3B14000E5
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:11:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 03 Nov 2026 14:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793733079; x=1793819479; bh=ZDAMMbNiqG
	dJPVIzsBgHYElgK6oCCX3fxcK0d5hsXtA=; b=l9+C5nAQ6umEvQCihYwri9v0rG
	E8Dfavs4Qecfyvk/+VSO/QIOPGjz/FoU3gKtMQHZ+6e7BjmIF7gj8kSCGNSpLOb2
	OcyeWKQi32J9WtAPqb6ohBmT9qbYM39V7Kttd8cRCm2Y/xwzoomi6LVy/K/7W+KG
	+AKFHaZGO4TF0BauG8rmf1yM9lTHPU2nqCpDjs2EvI3y6TUBf4s5Nh2jep6gtdT4
	qg2dvvqDXhUQVnYRuicYRVYc963QUlu1lenYastHTW9FmO0s12aFRTlq/VJb9EBI
	t2BJ4X8EbiqsvGH1CJiPTVrQlBYkAjRo8cTesHZWzf3g43k2liLOX/Ejq4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793733079; x=1793819479; bh=ZDAMMbNiqGdJPVIzsBgHYElgK6oCCX3fxcK
	0d5hsXtA=; b=P5HbC2XhKlHoK+JXve8WeiYHUIcJ8KGVD4QiynxM/gc6M+C9gKZ
	Y8pvPm8tPmQyLebiwmuJzdDjDCIs1tEBg0IAIYj6fYva2l3N7bx6s4G65CFBIVfR
	fYWMN6QXzIDsqBcSmyE//p3+hc5wWhzbk18voalb3JdY7ILRk25vadBsfrqPBa1u
	wIgJk5jQv60plUByJ8nkV7APGrZgyhtKrixe14JbosSx7EI0U28n+p9JohPKrcLg
	yA0h65K5qyStauWJ1+lmpb2Yy3N8FGIpc0X9iWCfpi371ZG634F0nFFEiMDQxxRJ
	9T6lJY2WQgZWSnLwSq3HIiNCR2fAmm6MPpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793733079; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mAXM9bH4zq/IKXWKC+2OR8zhniIUOPgjHYaSzPCksuBgkfm
	/kNhxebFTMlgMH/4umko70oPOg4IBIgLgf5NEd6HjsVA+ZlJT5zfSSKN1z7sAZq9
	i1CPKDSVoZrF4j1KAEk9iOFb/MNYoREAR1vp0NLqg9czh4eLwJ/Xt+/sVCKWQuxo
	zxxk6BlWWNonoaQ+m0I95IgliOBNiMqOqLXq4UEuSyCtf+GQdCTX0R87JkXHJrWS
	uilhJ1jIL7KKih2NZvKW5Pf/0TLbOtPQIXaWTJYmiYLl2aj+lgScQaCKsqK3rgRL
	AamB/o5pgri5LP3L7Y6ahTymzWOg4I0BFFWX1XA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:x+WFbb9qNz9cvGv9us//uCu67P07MQy5Z2yJgtWpYX4=:GSKWx/F8JhGtgXiugCoYa/HglpfChqXVWqudwmbG6dk=;
X-ME-Sender: <xms:1zHqajXQvuIWeczwhKbeKeYENMq_R6iwVQImtWE8RNLiVXQuhTTIlA>
    <xme:1zHqajA8_JIwn0Gge4AcXdjiRvJltGvNiH9qmgLGH_LeQ-118y_HLBxl1LkSpCgF4
    6-qAS5qll7CDtcAp9k6P5R_zfREgLoS2e1mMrZ6Cyo3Aj7lglpfSBg>
X-ME-Received: <xmr:1zHqaszINoRJItOJW3zk2AvAPR-MAgMHRZpo64kb3rKGkaKH1b1wZKDh-SAhN8hBxuqKHHZmDkcS_icmOe9wBasbH-_62RuxRFMi>
X-ME-Proxy-Cause: dmFkZTGj6Yip4RNvegBazQha7chwyoeOd/X9UWC2tGl44yZMVLLLiTGSq5x3OIVQKMqLim
    aFmKEec7qvqLW8zzaVV98IAdqWW7206CAnl0EnBrDpAJxZfZ0IeVuA7pJNi0wg+XPG7kz4
    IlXAn7RQG/AzZ1wZyPX2H/ZoCsbCEzIur2rvIh6w9PRdt3XuT8y9sRmv2ckFr8ZIqamRX2
    S31LZ2cXDwltRe7leKT6r8T4GrU1TzkuxCPmTDaK5eeYEpmDZNxmq8xLvXBYaOpRCsPgF1
    64MNpYjzYhI+uLKTvb92/O3sNJO2YFaQzaGoZyKQ0CCFSNw9jYaM05DIKwglgMCbNeHcSi
    RATFvaCpo8dYIrIUOqj+WzxY7wiwu819E0cVw45IMTQQj77nDOBUhIgial1CqtVd1OliYB
    /1lo6iBQKGYClzDwIt5Kfv5PVOcgDqoJrkrq7rBLX1cfMgdzBJFVNxoEXmF/cgqhruYebP
    yI8KvxQPSo6SdViS6aNr5BCqXNknHj3lYSF4xyRWAxRu4YrMGJkGoyE3i57uqBMbEwPZq4
    tvUL4kZhMcuuTg/IazyExuWeM697OLYLS83M4kGptzQnsm3tD12UMxsVFkp2dlZV/ZgeNu
    nEL97kwmafZZCfi+ocgCJv3QscRhpR14RZ4QO0s5A9FmryIz6owZ0JxuorQg
X-ME-Proxy: <xmx:1zHqaoBKlXA1K6ZJCIQU4IU-2BemFtXnzXAuzJp7nP929NrPZ6_gNg>
    <xmx:1zHqahY04SiFiviQOwZil3syGUDlrKjp2hV64cDXeAOo1Snse1khiw>
    <xmx:1zHqaohyiN8IgzNN3cN-J0XNsuJvFT4Em5UbRMRMmszpryzkwwTFtg>
    <xmx:1zHqar79MbcDOx3IM2xn2J9i0LG5I-CJ5-I3UDEkkjO3Y_t6q0aG4w>
    <xmx:1zHqajKCeQJAIinFc53yar47XAxkSm29FTNKuwW1rSJegIG9SlEg0TgW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:11:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] config: honor file permission bits
In-Reply-To: <aum4pZp5P0ZRC-cf@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 11:34:13 +0100")
References: <xmqqbj8p7okv.fsf@gitster.g> <xmqqa4o0v76o.fsf@gitster.g>
	<aum4pZp5P0ZRC-cf@pks.im>
Date: Tue, 03 Nov 2026 11:11:18 -0800
Message-ID: <xmqqld797msp.fsf@gitster.g>
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

> Nit: a curious reader might wonder why such in-tree files don't need
> such protection.

But isn't it self evident that repository contents are supposed to
be mutable, and you are not even supposed to muck with filesystem
level tools like chmod or mv to begin with?

>> +		error_errno(_("file %s unwritable"), config_filename);
>
> Should we quote '%s' here? The function is quite inconsistent, where it
> sometimes quotes and sometimes doesn't. I'd say that quoting is the
> better choice though.

While it probably makes sense, many of the existing messages in the
same function also lack the quote.  I would rather leave it for
others to clean up the subsystem as a whole, as I expect there would
probably be a huge fallout in expected test output ;-).
