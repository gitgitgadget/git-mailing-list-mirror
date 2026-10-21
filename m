Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601256;
	b=qZ02xjCTv9ZkHMGDtwzH0IdialTJu3gsPdD3LFP67xi7eRImqbqD2NnQSzdPlMnn47NR
	 6iUujBt66KmZF2+uDFoS/9Q4q1c58zotS8Pm9w1e74ghmrLf3LdgQfAc8b2l44MYhw7tO
	 yIQ/zsmeDIDCVWyVrHVkgnLPVbt/RVY3+jTOgGOlvHeNF/eXHPJwleQKo0SCj/EHkwzQq
	 Ump8wSF9tq0VeUoHzsdgDzVeIXXTMMXbcq/dkHwA1M7veC99MijvYz5gvJVoMfgkgXSJr
	 S70jjCzOxlP6pvnuFW3MQuVqMdS8ouEX3ZwwH/XHzp/gUecqne3EUqVHLRvM7eHXFwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601256;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=beSw6NtyK6O9qSTBC5OSLeHD0jKIKYR3D3q+XyDwOJU=;
	b=GXrwhEpryIbBCotrBm98RFkk92+THZu705WkWdG9she/H9V/XasoK9aNFj0xIOtzfNXQ
	 V2qQVF3oGssiqv1fHHSaPavzC5bO40mdrtocTzP7qIX+XLvwAWBp1IYZ0x+R7uHKuvL3T
	 9lq8yf8miFJlCWgEc4Oxu+Xk8BSKQfj2GtIjPKJuMvxE478hqkvTqBkKFbA83kb7enAdB
	 O4TRXY7lKwDSRUG4KsPWEpbnIHSz4V8gRzVAMoJnrOpnmwzLHHIuUFny8lypl7mnZG/g+
	 Iug8ng2//gZyi+5ZEyXWIzMGHvmuIACUCOfVPaMIZKucX1rPQMk4zFFVX8Djn1BNhlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CLB9GrPg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kBgwGAD5;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B5606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 213B5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=CLB9GrPg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kBgwGAD5
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9182E1D0011D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 12:47:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 12:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792601255; x=1792687655; bh=beSw6NtyK6
	O9qSTBC5OSLeHD0jKIKYR3D3q+XyDwOJU=; b=CLB9GrPgKdelAqiqsVihDSctMY
	/CMxuflrApFz3jMCSy10ECMayJpnHF57hQaQrLqkMUOAsCj16m825CyXucZaC5m5
	h4VURjWBl89QnOClGj1wzwGsZdiDTBiq0jtyan3Gqe1bafw0oWPcflJRKZplqq0/
	/ac4gm/+d1LbrZ5+r4UkY4y0O1rUKbv+VUdQx2Qyl7aZkE3wp6FIkqiecFHPDJaU
	4vVE9mt5Hp/GbqVehyIwA+husNyLOG5YU6IZdsfdX40kFbZ8tzKIrAeHReSVZbR/
	RdqUO/LWdXAyoyJyOXtesm22RSLa1DP6/cQjEPbtnwAxVkXJSZ+HJdrc0k2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792601255; x=1792687655; bh=beSw6NtyK6O9qSTBC5OSLeHD0jKIKYR3D3q
	+XyDwOJU=; b=kBgwGAD5teGQo2ZIsuIsR+Wd5++fmmW4ZxkG+P0aErxu+Meampg
	wqo7FqR2YlaGsbZAG2FteTMSBze/45vnFamp/0fZZaspuLTJk4ckkwaetwrN0v0+
	i3CPrziexI5Oc2NXLLtxmBuKHWZ38+ejUuEY5ZNXSEm/9QQl78+0pfV3KUZnEW8j
	MtVvqMQjp1aOcJoC54Kjx04MZdqLVoZks7uGKLvozZyCWiNkf+LnrsBqi8qKiLwU
	6rUVxZPnllbETIMoBTo8u0p993fhZyZseEsBFrtQEk1/iwqF3EVM2rY3s6L6PneM
	HTxUliPXtZtnT3WPIEoU0OGLpXNx68u62Vw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792601255; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ck0K+1D8sEcj+fAw7FOnnbBpMMDZxKGsM2DsSpS1ZpRuWhN
	Em7b0R982c9FmpVRjYHFaSmVCxxwGYKm7T2XJBvZS6JG/n1NZvkR3cp0twQseoHX
	zUQ2Lr7sQrLZcuaVQ2zn+ui9eiPX4ozsvH1y/mEGPuRIJrYO/VEJkPx+1rRiHktj
	2ENkRK14yxNU6KfBlTBwe+6WJAtgXoZxlUz7SAqBjwdLh4roj49nXPHPLyxcamKa
	EGH1p3pD1AezfgMjgIVWaUCYAkDdkEkwCyCrDOxftlemj55viOpFCnoFg+3WbCpO
	JXmUde9FQSAZr4MwA+iuEi+S90GX7wvzDbcuMNA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Jtyjipt68oK3pJJ1vNZMuyLFser8iODxqMRA1u8DH/s=:1TK0/eBES+J9zEOCzHCCvvuRnFVYdlFcKsNUF6Po0J0=;
X-ME-Sender: <xms:p-zYalZO11Ku4P7k8lKwD_LkBzGLoc7qcoM5u_JP_xb0yyyv2ucl-g>
    <xme:p-zYajZfhOSWYtmFqd_63wQuyjlPsMgbGbIcBOGavDdZTenMalvEKMDsYmh77SQ75
    H1qbXV5fZzVALz5XlV8A9h1DXfiyOPdMx5vjabhwDy0W8UKIwmS6pI>
X-ME-Received: <xmr:p-zYas8bmUFJbHVsN4rfPWCwk-T4s_dIvIn2Y0g_lM4D95pof2nqch8QHdKJevDlk_pGtd3Ao3M-7xsa_QF--J48in_gBXWdRPkC>
X-ME-Proxy-Cause: dmFkZTE7t/4Zsget9VKVoqQo6RUw4wlZbtWfaxNJrk3fsGwIcDP0WXKl/igPtx91uNPxxh
    WbQG8GeCdExcItcnaObEj1AYuTooqWTtJN+q/2RvIGwYHUD9aBtZnHxj5MrVdLimbTiDVP
    oGdPDjas1npO4cvSvyIWXXJzFrWTA5kp6s5OifWw0OLAVW9B8t2HZvZ72dF65Yu3KUlUCA
    +h3Vj62CIjFE/m4Ru5yz+6sHyGVLaXBtDbypVBoeWO14EhYFr2LV88mvresiGWfDgiHM+i
    yaKBRaaxuz6Qnb4f0sgj0UK3uoNkA2ZmegSgAgdUulg7n1Im2wLRi9WuyYjReXKWMeD7qD
    tUPg2gHZCEk5LoP7GdDj6thU4ueaR6hvZFVHLKGfaPIYkhYY9LNrzwUVGC6UpA7qU0DwlE
    QCltb7ykA1dlF+4fSSVEKzFIjDbbgZS41GFsGGT4WSBr4FyjnpUnxK5/8biIurnZCXckC2
    5e4vJHel9W6RfSKADl58a7jhncWdGuCZ+reHrnUHs0Itu0W9LX7nTa0H3bZaTiQH2nMle6
    3/Yp3f8t8C/isPiCowlnZLzy30HYn9Kjv4U+8Hw75MexnsW1zVsRcKwwIk7X42XRQfhdjM
    0CdLyV8MHj6RPhDDr/cEBrVtBKy+RuYZx/ztnQi/Mfm12JkzxDUdRqed1D+A
X-ME-Proxy: <xmx:p-zYaijfIHtMibDUn6Q5hRHnwX2F0WiHOad3sI6PmR-NYwUaTaXaUQ>
    <xmx:p-zYascpngvN9EO19mNiPIQrmUP7WmkN75c6olw2chvwM9_12IFRiQ>
    <xmx:p-zYaprh6m8vKipMH7i8hPuwnT8_cE-gSq3SccXuxB80asK47BBQJA>
    <xmx:p-zYahB-lbsZiZFFtuVohjdyd4yRfNwKsls7Glu1QZjPWOScw_YsQw>
    <xmx:p-zYasd6GHFxDn41Dw1uq-Fu79VY0Jw08yV6j6CrHrT8U1niuUnqYkqR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 12:47:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] object-file: explicitly write ".keep" lockfile
In-Reply-To: <ateNY8W17UAVPZ9b@denethor> (Justin Tobler's message of "Tue, 20
	Oct 2026 10:51:11 -0500")
References: <20261016213716.593278-1-jltobler@gmail.com>
	<20261020132900.1208343-1-jltobler@gmail.com>
	<20261020132900.1208343-4-jltobler@gmail.com>
	<atd6IjqH8F_O44gP@pks.im> <ateNY8W17UAVPZ9b@denethor>
Date: Wed, 21 Oct 2026 09:47:33 -0700
Message-ID: <xmqqa4o7q9ui.fsf@gitster.g>
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

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/20 04:26PM, Patrick Steinhardt wrote:
>> On Tue, Oct 20, 2026 at 08:28:59AM -0500, Justin Tobler wrote:
>> > +static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
>> > +			       const char *keep_msg)
>> > +{
>> > +	struct strbuf lock_path = STRBUF_INIT;
>> > +	struct strbuf contents = STRBUF_INIT;
>> > +	int ret = 0;
>> > +	int fd;
>> 
>> Hum, not quite what I meant :P I'd leave the variable explicitly
>> uninitialized and then set it on all exit paths. Like that, the compiler
>> (or at least most common compilers) would warn for all code paths where
>> we don't set the error code.
>
> Apologies, I should have read your suggestion more closely. I don't mind
> sending another version correcting this though.

Then let me mark the topic as "Expecting a reroll".

Thanks.
