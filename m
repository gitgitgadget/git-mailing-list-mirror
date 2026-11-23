Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448241;
	b=Z/pw0G7EyT0dugYyLE4+dTba/hZYDdQEq8raj1arOSYfGR+bc3CfCPywlx90h64UsPvj
	 Xpt/WO3G5CTFkcVW2i7Z8s8grfFug1rJVjaBCIMaB6QMb3q8Kcv/2NDas4mUXtsfAmmdZ
	 vntz3W54kkDoSwlHi7mD6qwjBeEN6QAXcqbStui3d4dztDUqD2VrhAu0RWGJRsgE9UNJJ
	 0GoVymoxzCJh/+W2AuKaVpKxXvQ0YQujZ7TRvujuvtW7czU1F8SiSn78tqs+BWBDxlibJ
	 WaJtliiH/AVhKlRSAJi06z4cqBvORffXsniM+D6bvmHEZcDPQM4CX6j/ylu0cScvCWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448241;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=N/RYFpTzdVRz2CFfqUe/NLjJjEWqqMxYk+SQgpyBJx8=;
	b=ejhVBDTiaCWANBMLnuHLZghxs4GevhNeKaikLBzime8i3jUZ1b6Ne2jfEQyBc5yi7r8X
	 nXoqWFmYCnm15MlxPfpM2KgvN0TpPuE2kXMvlSdvM9Zn02tIIzQEU1gC+peVJe9K1PjBx
	 dN4Ya0EeKTRcqJyAgeQ3J54Kiyj1b+ZjDOBuJuUECx5BvDIyBAhi4yvG6vqIrGTGYJxq+
	 d7+YJUf2niz7q8Mvogd2DDUwgRTSdKQ4p2L3TAJVYnIr/moyU/oqfI0vt+YY9BJQJLBfe
	 xzj2rdh5amBWHaIdS9LPtuPClT+beP+6XSc+thvvTtPUv3mHOgyMq+rd7dunxQ2tgCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MsVKmgTh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZP9Z9ydZ;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE157606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE157606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MsVKmgTh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZP9Z9ydZ
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1636E140038D
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 10:37:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 23 Nov 2026 10:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795448240; x=1795534640; bh=N/RYFpTzdV
	Rz2CFfqUe/NLjJjEWqqMxYk+SQgpyBJx8=; b=MsVKmgThD0IpjSnkv8T28dqEnW
	AgG8c6cF7rOCvv9+6OC8NZVlA7Oer/3eVGgTtX1fxIRGUBAoUMzeHG/xl6DUoWT0
	0BdkiWpi162dhtw0xVVMBtUUc7qb/fTC8KOkxeA/YuWyFYQYfqQaduPe3v+arCT+
	x9XOp+qrBAd+JvLQmz9BLOxnHYL2i9wgv/9DneFGtG08QkW3chdzKlldSAkv0hl3
	t481zrUhIv+blHT2xz9FfnfpNRKTcX6T2dA/sm/Yt2lXkcYyMUjaPN7asDArAKqy
	8m0N4kDV2HrR30HjfH8jyjVCfnfCrJ8OeNhp5iorYLsANhod+Fzt7ISyylTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795448240; x=1795534640; bh=N/RYFpTzdVRz2CFfqUe/NLjJjEWqqMxYk+S
	QgpyBJx8=; b=ZP9Z9ydZStMTTDmyokAX4lxUoKc1ilJlYAxz7jkj1X+kr7QfIQd
	wgxcQMQLYzO6E7mzSYgTHhaq+dv6OHVjFtsJWzSLopbu+lUBrh7ugF1bc2wz6G/+
	o8QZHLAjmR12OxDa3XFSiXzyq6AEVTV3liYEYkXTBmZxC0ku39UJxSxFmSUBVbvv
	gFGV/VKzut08zI2E7C1c5JqxB8YCyRuOkIvnAYtQTMcMb94qrcFjd++INqGzpyeD
	3cs3zyNomKgNAdjVyEmmX4X7LDjiX+YpXt9XU3gn+HKmTtnZpGRUnzi7VR0XtEqT
	n9uikv2azYw/Yctn5OFhV5j+Y1voKF31F2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795448240; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:S4WdP4raV4RujGXmkFR4WyHZZ1nsGYfH302qYF8IP+mBJUa
	teY/8nNZbkEGKm+Lu4uG3rCq3gL971kiR05fFCKpl6fah09x0hY8tCd5C/7cdZE9
	VVQMtcvp9vNVO4cX/cBmlwzwBxISC79PCGgbcurlOPuwEOeIEoW2/N0gCfqTDaqG
	qoo1jqt0kxztchYmLiwo5095puB0jqo/8YDF6ab3XAyaY0ZaQjirf/GqbzVpjOfF
	oibpGAhMgvP7UG9KTo6esRFThe9NDJD0uRiFyFVrhhZ/i4bYZwwpO2yX9XXgOwgk
	F/bR7vVJgqwsQmPEEBL4qec9LGV69z06sK6UtGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pEX/QgUC3fTT5eKKOLz0fgdN+X0vvT8iE2BryC++QAw=:owuQ6s4wctYOkuPYTQu0dFRUd0Vod31MwiONLiAvLbw=;
X-ME-Sender: <xms:sF0Ea3ggUIWXRpdzrVAesfCkBxBzNVdmP0evPj2PTDzJwEOthjRndA>
    <xme:sF0Ea6BCfZcOerqAnucV4ir3S7o5uZaRjwgWyJu9D6-4xG6yJR_CSeL4f2llBZakW
    YBsx_DnStsEF5KiK_utu7Xb2NfcK8ZtfUHGtFAwBGb27jZNO7jE14o>
X-ME-Received: <xmr:sF0Ea0sU-mmLSe6Tp_ObrSXk-4wSBdySg1pnX-y4h9NA5GvyeWsz5FPnsK7QgPcD0DPFzC8rxs5Epmi9v_g93btxnGCSofg1Os4hnDc>
X-ME-Proxy-Cause: dmFkZTEmQx2+NLI77uOhspeTEwalhA9pK2DUfQPVt/jBqp86Iaywlq4t1WUye0t0gmLkW7
    wdAAF0LVEzcA0IV66Sg7Jgr/FKsrTrP/OfbO+jNyLXc6y7mW/wCGfMQnZqzIAZNgp4i89x
    nBpD9fmwjKzfXWUzMOiZ+sHSggPl7nZZjwhyO5kAOfCZiN6HHb2+Lgcp0/YHKLy0/caUY9
    XOV/bKD90Ptn9MIfsYE0iGAx498MOfiZ0lDr7kex8XZk66rnmkVZlrSzqhlrN/ecX/CrZK
    zX+oRiXQga1p5Q7ObCGo956S7GA52CGpsqeAHUVvr5HTwexa2zb1t+2o8N0L+OPW/pidKM
    DrMRM8d1YuTwzp12KlW71n7DyP6UOeH7l3BO8gUJfvwhJguxzE/yReRRwVleUgURs8j+oL
    lMm0QSLoy7VMvMtVP8gNnRsLH9jrmoWDUzefqIAhyW4T8skQ+no/ERee2MPWDRxkRxsYpM
    qFly6vsd9sNOzYNM9+E6NlApIXQo371G6fCbJgobOeUJ7SP9TDIs1Vvqbg0IcrIbitQnkF
    z8iszcqJpcIzvNo9mwSnB6nvz9ppa9eZ6G9z5vod26QSdXE+2BNpKbJJevesl6flVqBYP9
    YoINxbSROF2RZh8751OLo/UovOyCRkumo+05WmPqg3MdOOB70aSOWxSLBuYg
X-ME-Proxy: <xmx:sF0Ea_ZOtLQgHzwjshpuBjiHU5Fzu3yfoG3Bee5pmNGY0dNqtJsFwg>
    <xmx:sF0Ea3UgRfixdDuVv0o3IpFxcObC13Xr0PxFyB3OrU6IbFssnJ-DkA>
    <xmx:sF0Eaz7bC9A5F3WdwaYW2_I5QLZ3SZLD4Dh7cbMsYVwGKrLQg6zDTQ>
    <xmx:sF0EayjAwviyVQAUuxGJqyk1yGVxl-JhvYf_2wntqm5PCRC3yP8cZw>
    <xmx:sF0Ea67KVtWVVutUwbYnowqFR49s5xJtvM9y1u6kseb2k8uPrOLAF3hF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:37:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/6] getwholeline should clear the buffer upon EOF
In-Reply-To: <20261122140347.41990-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Sun, 22 Nov 2026 06:03:41 -0800")
References: <20261122140347.41990-1-gitster@pobox.com>
Date: Mon, 23 Nov 2026 07:37:18 -0800
Message-ID: <xmqq4id7d0ep.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> time.  Because the code that caused the existing bugs does not appear in
> any of these steps, the log messages of patches 2-4 instead give
> detailed walkthroughs and are rather long, which is another reason why
> the nature of this series discourages following the usual pattern and
> doing everything in one step.

By the way, I _could_ have instead called strbuf_reset() at strategic
places in patches 2-4 to "fix" the bug without touching the root cause,
i.e., strbuf_getwholeline(), and added test_expect_success tests.  That
way, the commit log messages for these steps did not have to be such a
detailed walkthrough of how the bugs happen, simply because the code
that make problematic decisions based on a wrong assumption can be read
in the context of these changes.  Which requires patch 5 that fixes the
root cause to revert these tentative "fixes" to call strbuf_reset()
which becomes unnecessary when strbuf_getwholeline() stops leaving the
stale contents in the buffer upon feof().

I chose not to do so, as a series that adds some code in an early step
and immediately removes the same code in a later step is awkward and
wasteful.
