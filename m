Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794517825;
	b=NVKoHxqkhbTKEtrH8lOlVLWC5Q4hGge7ERE3GKZKYwvfkFSaWky4iyk8r9eFQB7X19tk
	 bJnOcvTkRnRm5T3Kbl8zNlMxixdVxbRL1dhOJ/lcihjCKsekIE5Sie8hwvaoNDI+nd/Fq
	 Ggn1ZnSkG4GJD3ATGcoB45JDgPEtjobakSxylxO+sYLKiDb5Nq30gtVClDzUnhJ3uamRH
	 9i3U76Tf4zeAVxgvzhkiJlbCGkv2+XXN+pj6Z1kE23gzncurg1Z7TjGzYsUNLKG8u5TTe
	 2xPJZovcTbS9wRvsBCIj8DZrLs7bXgrxSfG3dWNhflMgqVTICHAZSHoZFbHLjQ75GGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794517825;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v1VyTdwBRtGzmULI+dOj1TFmkCjdP2Tcpu9mOSz2HbE=;
	b=Ub+rIyZpdvWNN5uNaMXoFZUIZ4KBvuoj3f5rYknxYRgOjBhjYE6Wil50QWbbyFNXV7vH
	 nWU7Jc3w8wTkdk8+L/aKxtseCtNYsRJRuPFAeF1D5xm7ftc30qEtNGquc2gj2uUtEEoo2
	 JEwt0lccKHFxvjPTFlxGrl2S4+TrRf84OUMOFQjZDUFzP3tV7UJL4sx71E9Z7JVXZ/Lvu
	 +cZ2xDfeWA+zQvkWG/KA9VUbbsYzpKG0CRaSeFcqAPYGRfL8/+cTeYaSUIDaZLqrA5UPv
	 15zJZIVvSjTKn+66bOwl3qnK6Wx70WfwEregu46hhS/4vtMDbAWAPcDFgqlxe7+adSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=H5bfAacf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k8o0sCXY;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF7606A332
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 21:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEF7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=H5bfAacf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k8o0sCXY
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 806091D00693
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 16:10:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 16:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794517824; x=1794604224; bh=v1VyTdwBRt
	GzmULI+dOj1TFmkCjdP2Tcpu9mOSz2HbE=; b=H5bfAacfCMEksNAQSAgvy0ogFB
	XVhBMzu63cIBVFeTBbID17RQlkkPTwznNuM9V080kwA8g6mb9T7/pnihVWhv3JRf
	+ik5DRjvOO0KwGcrZNsx4wejrKYZVdrhNuEFaZ9m8B55jGWq2Q3VxtOkfvvWB7wO
	Efc7qsCUlKjiaSfcZhEzufGZuaKtpcc88BfWUqOj4NjEOhythbH5CkexmZ5IPv9z
	LGG6RqrQ8kgSyibtCubL6QUhXsXoIxdJWQM1pNQbVcfp1gqYFcmR+pS0fRxKSnQq
	27gEDGv0JBYY6vOcNr2FlOpxbhuvU2fBOBNnzvDMB947h1Y9gLiElZrEm20g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794517824; x=1794604224; bh=v1VyTdwBRtGzmULI+dOj1TFmkCjdP2Tcpu9
	mOSz2HbE=; b=k8o0sCXYQKmGe8Fcl2E8vGGBiNZ3nrDIVagB50tpGNZTzRdW18c
	wsmjwDPUcaZfX+NcXaZSmwaN8sx9oYa+HMg4KR5wE5LuM1tFcTHsmdNS5n4dAYst
	heiN733TUk6AEq23alEPVXaLlFJlALQ5tgfmvPfMBBK+dtX1ozvFidVUMLCcwNA4
	7TDt+c0tOhxiGhihZzY8lerM68FZv76I+zJYrSIxEmCBlyHL+oHlJQYRiMjIi+7/
	0zDwsniP+0yq3Slv5G/slS5FQZyCddRVwc5mA4lZEN5+PaFrCJPUL9kXV2tTUZ6f
	6UM+egz2GHEN1hQ1io7guI+dWJdlqwGMUww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794517824; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lnRRj5F5PMAC61x4AC3/x0NEp/XgSbaJlW03gehzqVOrUJ5
	TIngbwRsG7yiLmcM4R6aBJT9L70hK19uWJ+1EjMngeRCu6KoUFDdtsVfB4BB4Ewp
	p78gI9d6rmJy9lKeXVyen13IcVszqN3je9Kri19dvq+N5EZC8bXk2sk1Syw5wxy0
	qoZMk63F6Ryf/1ttfmrx+oBRn+Q/YeEFGshVrjNoCBzG7c3b3MlaxSlpzT4xnrYp
	q79xlKH9NE7oYbtoG0GgyyzAvOD3KcTyXQkauxoGQbiypP9BqfSocCqwiMo6wTLi
	EmK6wk03AxiljAuLcz9MBxivYqOKc0+TfM0wNgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:f2MIrzVmG+D654KQptfBMQnw5a11ieOhp95B9Lu0jBQ=:RwzPx5WwIoMDuQAEvhvqWHyTOfgAl7JSsgagX+twnkY=;
X-ME-Sender: <xms:QCv2auTizI9x3TUClepLuJV18wiKA2gA_jq8LTSTdKfBjNmhmfNoHg>
    <xme:QCv2amB3Ey-qaW1RLSc1nnUrKKezpAcLeGkndgu3I2ou_KLFXuig9GWUn7WuZ9dSN
    tnukyaFuKPxCkmOKHBHv1sjEOYA0TkMCjtfArG2n1jMS2loCQBP4pI>
X-ME-Received: <xmr:QCv2auHvTcAi9jsLHxOAvFEjfryVQeQvQvgbllAAJEtnIOFal0e2KgnEkNeiRlts4gBFLYMnbbDfzibxPJ0VKuAgGostWEIgtSl3>
X-ME-Proxy-Cause: dmFkZTEA4rsTQ1O/rpXThKIXB9+v6vi3SKpntM6mioICPb+OPKZWCtFUwYmmuzofYnXVFr
    P/hVZmKuihWo0/4uJtxz2x4UQwqn1d45nFdWC0BZR87JqyjdARPH5UnKSTb4q75A25WKFD
    6qbugvhG6NIyVmqTEybL5hD6Eb8mBBX/NnYsG8bmVq4FsJT3FaNNgmEBLmnc92j0A1+38C
    Odh4S7R4dCpv3tnG0Sh867RIXSbMFbCsug/o8nNh4NFwFDY7fhjmjvJgfMH9Wlyei2H+aQ
    Bdn4uF8YEDM1vSTMrvHLlzvz2grqPGDoWqspespGj5XZK0Sq+jENJrGRJ01Mm9jX/Gq6nC
    KLF3SILrbLyBuisQkT8+vxXmNgM/AH04NS4PkDrlRtwRlYuWCKDcVR66bZQ6uGkU10WMrx
    8YtGAMgW/+5P7fW38XgjSUjZ9TkUhI2sVDqLHnFdqCoOoe7Vm0na46zj08No+MpOkWfQIQ
    LjYY87MFStDHNBh4HJHlscXt2gnNA7mcaKcU6/+zLMhyoFRUq+024ZxooJyt6glkq4LFcS
    L8bMf/XuHUu3zaKw50og1TYNOavV8E+F5vEx4iTgdkL1BK9pru9vE3HrHDlBD/JIIUdwni
    YSwD67m4k4jZ7/1Mu/SY2Hr5KPZbfC92ydelL+axNx7aHiFY6YXpOp9r4Kxg
X-ME-Proxy: <xmx:QCv2agC3zrZVhvbO2BE0z9E66KdIpAvOHm2HSVJzMzJ0qNsYfD3xdg>
    <xmx:QCv2amW_Iopmb27BlMF1Tq3pIEBKSOC4ct3FG4ya7swLnWxpVn0OvQ>
    <xmx:QCv2asqbKWI-9E_Dpzdfui3l6eJTxluNL3xL8wxj9L4dI9ooKGRpLg>
    <xmx:QCv2aqQswWvRcOXM5clANrRdT9dua2cwOwfXAtJiHCbi_3A5LJegHw>
    <xmx:QCv2ao0wF-q8bif0UmZrcC1yf-dAiT36lLK8GsQUNhzPqdUQoYNZf_a3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:10:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] credential-store: add lockTimeout config
 option
In-Reply-To: <20261016212216.58000-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Fri, 16 Oct 2026 22:22:16 +0100")
References: <20261014232739.23021-1-okhuomonajayi54@gmail.com>
	<20261016212216.58000-1-okhuomonajayi54@gmail.com>
Date: Thu, 12 Nov 2026 13:10:22 -0800
Message-ID: <xmqqeccphi2p.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Support credentialStore.lockTimeout as the preferred setting
> for credential lock retries, retaining lockTimeoutMS as a
> deprecated alias.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>

Hmph, does this change even make sense?

Sure, there are many variables whose name ends with "timeout".  But
are they all measured in milliseconds?  Or are some measured in
seconds and others measured in milliseconds?  If the latter, this
moves us in the wrong direction, no?  If the time unit is not
uniform across variables, it would be more sensible to give them
names with unit so the users would immediately know when they see

    cs.locktimeoutMilliSeconds = 500

that the wait will be subseconds.

On the other hand, if we are committed that all timeouts are
measured in milliseconds, such a unit suffix does not buy us much,
and better be dropped.

Anybody who reads your proposed log message above in the future will
ask these questions, and a log message that forces them to ask such
questions needs more work.  State why this patch decides to do this,
and do not say "somebody told me to make this change".  Your readers
want to hear why you think this change makes sense, and be
convinced.



