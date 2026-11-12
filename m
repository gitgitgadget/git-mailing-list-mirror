Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794524133;
	b=NS1/dAJkTJEmqCyHROTKnPMTRgUpzua3nZIsRuYyHfmWG+XjfYTMpuxbCMc2qmJBhosT
	 OsfaRqZaAiVEwr7zpvRPG+yIUqUVJQ95QQHFf2V3BXRCX659oSUbKgkZOycgOpQQArU3G
	 T9PhL7dZ3IJOs11xOPlu1kDUikYHV0151w0gXV/Bzhuae9I4ZADMQgd1KEoGDezbiOR3Q
	 PwDeiXa2K5zRIUgeinUSORSJh2gxLNkeXeK7C39LfXelp30U1xyGnabkKPBMQVoxTZAxV
	 9kZoDvK0VV1+xUP6FxJQhgVdoEntEYW7r8iPpChK7ye7BqiUk3xkJvYe1HaTSgVJZzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524133;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EbmnzYkkPZHN+pjWZ4bnclNSDHXpHz9gUJvLNhwe8QQ=;
	b=GH8ZqmyfqvbusUywrmwS7G+N5kJHychX+zCowlz0iWm+lUjX2AwUReLFROg8h1nWMDoB
	 6IQ86VJJ5AiKiiFCqRJ/QOO+b6ugJdyyjXkoLLFRr1SseHKO/L2E2L3ik/kp6E+lNPj83
	 0jA+q9ls/iPCOlV7MbxqWdq6oZ4lPRVtInY4DENV1nVnNWhBbFoLO9XF+IIYKLXlXCrPG
	 CPYlcKGderJbYSArWBMN+bQGF4EOsgcMZAF9sIVRo1gNISTG+rT6C2XwxZ9mulHa7eGYS
	 e12Yh9JDOyFa3yPJDT0I+RZOrXYHXpF7Tu9u5ncJaPOdxLs58OG9glOSqTSmAVYla2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dmDJH+Hz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b2yX2D42;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD312606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD312606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dmDJH+Hz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b2yX2D42
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 402577A07CC
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:55:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 17:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794524131; x=1794610531; bh=EbmnzYkkPZ
	HN+pjWZ4bnclNSDHXpHz9gUJvLNhwe8QQ=; b=dmDJH+HzxxRPn5B8+pCGSckSoq
	ksBgfuGDxzsApRNZ/1goP/aevLsW9WwHx1NyIxtHZAWDiiqqEixCYOG0TKVzXpXM
	EbNUWaGH9mq5YmB1YXHT3Ysb+maRxyIwDFDLXVNsRTZkpz1HzZCLT+FFeY6qNGyB
	8D4sQPi3RASU9vzn4YW2KONCDOKhct/hDM5hEbtEZjHsx476PUPlHXBsa6oWTydp
	VPmNDsYhRltISPjj5nJ0EY3AnCBl+DCG7OfbuSdUdyklkqJELcecEPTqmoECLx1p
	wTGuWcB5fA040ERA0MqI3LTLKT9+kbl4Xr4nyfUvSspMliupEhwFV+XygrgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794524131; x=1794610531; bh=EbmnzYkkPZHN+pjWZ4bnclNSDHXpHz9gUJv
	LNhwe8QQ=; b=b2yX2D42tBBj4vCw/lnfxyZ2eZSlSOQDazwpUYLtfaaTODxa5gV
	api52si1H0jSieaDBro5Tc/aooeDXxBLwAl9nXmopwvKqLAA29i2M3Kfat09xhMU
	CPgCDHd5rXoHoUgtK5zEd5S0HCKQf/Dd6YNthz+qsRodQfGPL3kW+uX/0d2QbSK9
	6anmNPs5g3J62JFcLiwWq/8C7pfpYONs7417oQMsKaCJPvntWK8kkGnBvEAWAjPB
	ryo1XAYp53/a5ldMT0fFa8ped1wBy1xAQOvh5NZWPLOvxwYYhdaciQH6NaWPGY56
	m3+54O+uZcI3waFxaOWAELC6+bx1jsAc4dw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794524131; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bMzt+nDb4J75U2HLaVcO/bNSfW8FEYciEIQzLw30OKskpqy
	a043XteukL72QDHlZGsJUZK5giIXtnZTb0KnPzV7sV+AAMHH/w4HGkF0bbGiCiIq
	BnmdlMKPCqgNeuJCs6VPt2ajPn+L0O8McTQRjmtP/irkwOkODPdaRPHvbcQwNlb1
	eI/ZdiNseFM6A3/w2igAwNvo6lTsSDq4uHuAGOSpshCyBK5h7hM50s4havUCwQss
	ky3bjAv8PxAjkD06ocz43pz2CwmbNWSN2wdzY4c1OLs8hrqJxhM4ZLmhUh1IBGUF
	g7yFrxFIaVYnfh6Ng7UDpdmmRGFZAmvC5+QQMgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uqHmMPHEpBCgg3I6FOXyqvOJ7hjjp5mqifWOZ+YXkG0=:afQqPk8ZHkmHbzJr6RQ/aTBG8o+qQfhNGg8UTNlpn3k=;
X-ME-Sender: <xms:40P2aibZVNwq2KJ7TQuW_jz2jrXkijuiXypgnKeYxtUuW4nbxTXESQ>
    <xme:40P2apHasSUQGRP698MxxmUKRoxW8nR0y6RlezY99ZU89Ip-cgMa17UnI2YdaZByL
    eo3G2nVZ0H5DB8-aKnG-DZSm7fCKF9672Cv2UDxxZ01nP9NoWBBEw>
X-ME-Received: <xmr:40P2amywh1tnk3pXffhYrKF9-oSv6Z26uxkwJOP6_gm0bQbxzYx72LwJXKIyvPvEm-PSvPhxHK-BJO7D0qkxR55xn44zqs0GbSyw>
X-ME-Proxy-Cause: dmFkZTFtjrf+hN5G76+UlZPpBILW+ixmeusYYPMKLKd12thB/VEAm0UrBE0hWAbeqRthvr
    ILoxZTJNnt1Sb0ARXdjSxvYKk8YqDcuOR7889aClcRNfzqjCoLbq6Jj7cBigTyuwvVEG2/
    p8c76o60wD3sbSnElTx4dcfOBepsQbwrRG/CljCCAFtXl3Gpah1fQLEI6UQjZGJtVw7eiC
    bULj7J91T7M286VPplZmotB+f4P8ZcXciQxFGgJwG9zBfbVSKWWoNXQMo0gCC6L7duOjJ3
    IHHuUQp+xkGiYQ/u8M2+QFoJhbUG/By93qzLToNJkh3Kjy6a7wbIOnnusSGBbMhJdX3pYf
    cTiedPNeK+9BN/VrPX29cyu6AvVQdl3kToSx0sFwjx1jvdsVATAjELhgwDK2YuJdVrltNk
    KPD2Jb/xW7shKoEdaMvBAVLw5rdDdqxtQYmVioY+7+5Kz791BrX0uDf7fOfGJn5itPvHWB
    MSkQ5N4GogKmRHIrmSn1eddKB7dq/19J1bsU7Q3SE31C89IfIvSNiDHhEdQcN7slm8/Fwq
    Bt1e+2/51rNrjyemw8GhXboo8D+mVNqstvd5cRAgJe/D2gpQtuzBPxzlw8vwjCZ7+/re+C
    DFlaYjhtJw3GFgAiHIRiLqlh2bhTK3g43C9wSRXcUsprgnLOLYDLXD2sYaCg
X-ME-Proxy: <xmx:40P2armVxBByhELAhRntENEN_6-8xDdKOcynjGN_UUfdxtEG0jNr5A>
    <xmx:40P2avnEOZ3POaNRmy9dkmCbawDDG-vD2DO2nOzv98fPs9JFjTweJw>
    <xmx:40P2atyyTOtOGKsvj4cV5k3IujAuhOegPBf2K9VglWorEKAzIO_ClQ>
    <xmx:40P2akpGMtFoTqZyo8j4KVEMBkA8TwH3yZ6Cn9-pubuSt1tQZ8UPig>
    <xmx:40P2al_6dD_cCpIPQEbgxuU1AQp04rbZDvG372gYQTbhUmDnz1161a1u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 17:55:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Karthik Nayak <karthik.188@gmail.com>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 0/5] root refs vs pseudorefs
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com> (Andy Koppe's message
	of "Thu, 12 Nov 2026 22:05:36 +0000")
References: <cover.1794000450.git.andy.koppe@gmail.com>
	<cover.1794520948.git.andy.koppe@gmail.com>
Date: Thu, 12 Nov 2026 14:55:30 -0800
Message-ID: <xmqqzevdfyn1.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Changes in v4:
> - Glossary: stop contrasting pseudorefs with root refs, mention
>   remote-tracking branches in the "ref" entry, and state that the list
>   of per-worktree ref prefixes will not be extended.
> - git-ls-remote(1): describe what is shown by default, including
>   peeling, and describe --refs and the example in those terms.
> - gitdatamodel(7): mention the root ref naming rules, and drop
>   "so-called".
> - Reword the description and error message of rev-list --merge.

What I saw in "git co ak/root-refs-vs-pseudorefs && git diff @{1}"
looked all sensible.


