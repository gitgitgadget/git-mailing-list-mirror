Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687088;
	b=Vn+muXU0k4TuVuW5vr/jBpepClmNrznhYLs/bqaVpkdV9mwQIwsFxcFbFqCM/vb2wAXu
	 yPVbU1CDD78Ooj4sVXL5YbHZsqjsoiwC+W7ZNr9JYLKydo7LezGpAuM9rNnoXFoEvkG0h
	 auqUi6N3Uh8jk6iIfhXf9zJg4dhXO//v7BDMVSGdMW/AmUKZ6AT1Xx/6uGqebQuahEVav
	 Qu83JqeghNRA+VlP6/XylPeB/ecTVpaZlEh90jRple6rE41Yh5uDeYY6OYxIDno7oJdik
	 ze1WlTjO1DOrzUrc2PSiYn5P9SJhzkqFyFcLLCOq62OWnEQLGwioOWXv4+kaFnevP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687088;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AVpNAMD4s2PUdsBZvjuSmbU6RackNixrRAMB5gJ0sJY=;
	b=hoc4JQyq/YFCtIzY5jTssiihXKxX6UByzdZcJhNYd4Lk2hnCtE1JvB8n5dMFE3xacVHy
	 lhfZR8JE5UMQI/kzjFF3fK3tirWA6g+jvGMsU8cTGcfklHQrTNkPKM/VuxkhncdVxhSoP
	 cmb90ftUQ7l0PZ5pfYlN+yzGXWXAerIGbPayCAaHl3+WHR6nZ6fL3DEeTIX1ysMWvOC1v
	 yIwK47I3PfX6r6SPPJMS9Jb2KrBgswyQfh19cA8pP2kHKtb+4dPIj5cBy0Iw+i9CA9tWN
	 4u1ZhmKSRRoMZZquIV5xsXS9o3KGm5vMcg9mLPy8l1grjz5xma7HXYf1qs9fnEXodkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lKd4dngJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QdnHbVq1;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC1606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9BC1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lKd4dngJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QdnHbVq1
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E10511D001A1
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:38:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 12:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792687086;
	 x=1792773486; bh=AVpNAMD4s2PUdsBZvjuSmbU6RackNixrRAMB5gJ0sJY=; b=
	lKd4dngJOGSCoji9twh2VH9u85vZYQcOLquwrEO6YDtXzrypKct5ZVSNJMuDs326
	VG00dsbCTPPbKjuiqtq2/A/ReURQ3kEqBB8f9BLyDceYoj2EPWQIDeaLeLrkxpcf
	QhFC3ONlsSCNSzDrXYUjQcjVpmMwvzthe8YgRLwvNy4vdrl6DACOs9qmthG2bOgf
	KSc/paJWCbr5X3WlyIvXoyjhL5w2NEdBuzlnOCCItLMevSOUkDPFSHNqazfxmCNw
	7Oj47pgx3InynHxsXGxoPzslAnKOxTMDaXG2HEYju+almf3uAkNiBmW7iGPcsKLF
	jxtBpul6jZYYkP8hMegrNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792687086; x=
	1792773486; bh=AVpNAMD4s2PUdsBZvjuSmbU6RackNixrRAMB5gJ0sJY=; b=Q
	dnHbVq1iqtpH0e7Ps9B62NcmGyRpIQR00coM9uNf1NpCqwA8C/C1QQ1Cxweca298
	vih+13hrDYUX/HhpI5gd5nhVn8BlaDOIjz6TX5Ob2mlu39NjUbuG5923HkRyxkKt
	U/p8lwuZ9I1NzGOwAx/ETJqOJBd9kPIpdWzBIgL86n6kvjd7b0YRL7T+EkIhKenK
	1jNvF0yH4n2Y7zRdSXiTeJFOyZDIJHpFfhf+zihdLlZBUWTzNMEfY7VJydDByx0q
	zpUYT+bMRypijx8eZaT/sNeN+RkdHQbH4WIAJdyjKAvjVF16dK1PCdjS8f3QPUoU
	LtTeoHlJjGE1Df4OMbrBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792687086; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LGLxcmnaXk18dBPDPCOrSsNt8cLsYPQnNk7VSdl+nvFphU/
	Ak9WtUZixxStUstuzo0j3zIUatMI56nBp15YVcUNUqGn5lcQE9gEMOT/KxtBLIOc
	MuCB8DiDIhk5Pqe8CRyWpbfXcTlOLeTh7g6NV+lBbxzpq+xSjZM+pg5IwyClHovM
	Nw+M5v2e7hPnydms0OguGWGw76e0VFuyZljw65ZXG6B8JUjEOuCyeVZgyFtRQDhN
	k22lb0DEDggmGVRNLH1+lIfyajwFEJbe4g5oKMtqLF9UI4psdD2IQAw4vVmTnFGl
	j7JigkGHV7RqK5hx27J8DJKQVgMrsSm5Bu8jCKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:XPIEplgsMqf88YXEFhY3loT8EzunskMkEdanNn559mY=:zef5SLniR6ysbVlWacRiwIo8wFHMcxAY7tTtunCxmZc=;
X-ME-Sender: <xms:7jvaauxhiG53_xxpFCiMZSjRD5GWpIzizG0gSAjEK2qfBEwF9Nh-vA>
    <xme:7jvaahKgyKBWHVben1XvvBCCrRjBTezFhh54IIEif82lHZ4-nbgxTcMKHDnPxmt76
    1pwX7Xtdd-1yvnjUyEFnV535o4V03RIVNvRxTeppmGX26fogc95gXg>
X-ME-Received: <xmr:7jvaaorm5oR-w8Jp_Ljzjgguu24gj3UgdrDtN9sccEbmnK4b229prZ2fppXBPFp5fMk5Tv9EOznEdjTVTt9IRmwTcqVvg6uKn16g>
X-ME-Proxy-Cause: dmFkZTGvLnwKYNlyLWguCEVIX8hv3LaLTBYCBAx+uN0ptuojILJkLyy67eBxlZ/BglXGrR
    BwuVZ6Lb7yhEVYbZUjo5kFaFxGI4ExN7u+dC+87QI2hbMTEh1p+Quz76Va567EW/xducYo
    mE3ugVCZR4cyjA3JZ4eY2LevimhXqp8lbr7Hjkw3BaRuVyg7Y+YCIVIonmFnkrloJ7w5Zc
    g8uD+VSuPT5vrNyJMi+Dh4LdBTLfqoz0RxdHw8qeHK9aMsylGSI3947AH79Twcl4y8lzIT
    b6ovqf6ydTwSMiJJckDIlVkE1X95FHIw6gyXjhCXEV9L+W7bf0o/oUpDIeqBEuEGBU8rgJ
    gGLo9WFaYPwa+b42X1HxJz6XBEuEj5I4h6XzzEEafrpGysOoK/jiSlf8odYir3RmlFUNmj
    ZdQ4wlXKsdsUbxdgf+3ov/hy2UxyngjgW9hk2fPbB8SBxggQSz/LgOivqGyUcWp6pplqMt
    JUUNNc5vyhPxKJ+HxUm+lC3wvEE8PkxYAEETyF+m6PwHrZSfP/9jsEWVxdOfxsh7S49xVJ
    zV6ArpNmVBq0s4Thr1T4QFpmAs8xlxs1qCnZKoXEME/jIOA6COxOpq57OZMkPlZutuK6OG
    XA0i1iWaoZ08MTizBUNihSWd0oTE48ky4n9xsF+tCpoBCymnkSpi45fzCGvA
X-ME-Proxy: <xmx:7jvaagJPScLncZ0Ol1rk0EFYuyeudgKcTrSipIKa8EXF_6bFRUwgNw>
    <xmx:7jvaatQsIF0M0a1571WQ1MlEiRzurjejjpsO5ghzn-_LaSomMCGkyg>
    <xmx:7jvaavvnZb59Sx_gDBhXA5zLavrJyKROspNng9CAN9aBglClFhPciQ>
    <xmx:7jvaauaPbHvIUwwixPGgAgsiKs1cEDfuWqf15aq00KRylrn_7ajxPA>
    <xmx:7jvaarbHPUQtO0WJooRcCGXDhC0mUdvY2CPZqMfOdP-nLXXwVcOrjNPx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:38:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
In-Reply-To: <a219a76c-faf5-4c50-9560-bf48f65167e4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 22 Oct 2026 07:18:27 +0200")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
	<612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
	<CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
	<xmqq5wyvq9p8.fsf@gitster.g>
	<ab05a3c1-9da7-498a-a9bc-d586414ad0ec@app.fastmail.com>
	<xmqqy0bqlqez.fsf@gitster.g>
	<a219a76c-faf5-4c50-9560-bf48f65167e4@app.fastmail.com>
Date: Thu, 22 Oct 2026 09:38:04 -0700
Message-ID: <xmqq5wytitcj.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Oct 21, 2026, at 23:00, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> On Wed, Oct 21, 2026, at 18:50, Junio C Hamano wrote:
>>>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>>>> [snip]
>>>>
>>>> I do not know about "manual pages", but making this available from
>>>> "git help" would be good.  It raises a huge question about what to
>>>> do when Git 3.0 comes, though.  Are we going to change every section
>>>> and rewrite them to say "we used to do this differently before 3.0"?
>>>
>>> See me and Patrick’s subthread: <ar0OicAaDipYx-xU@pks.im>
>>>
>>> You could transform it into a section at the end for “what happened in 3.0” then introduce it with
>>>
>>>     These things changed in 3.0. They are written in the future tense
>>>     [?] is reading about what will happen coming from version 2.98 to
>>>     3.0.
>>>
>>> Then you wouldn’t need to change any of the rest of the text.
>>
>> The rewriting effort is not a major concern.  Rather, the question
>> is whether keeping such a historical document is worth it.  Do you
>> still care about what the major issues were when we transitioned
>> from Git 1.x to 2.0, for example?
>
> I’ve mostly just outlined how either approach can be handled. Personally
> I’m fine either way.
>
> As far as being a living document is concerned, discussions of old
> versions could be promptly deleted. People who are on older versions
> will have the relevant discussion in their installation. Beyond that
> people can use the power of version control spelunking.
>
> As an alternative you could keep just the previous breaking change
> discussion like mentioned in <ar0cjf3rdrp6NAba@pks.im>. Like, when
> you’re approaching Git 5.0 there will just be Git 5.0 and Git 4.0
> discussions left in the doc.

OK.  I was merely expressing my worry that it might be awkward post
the transition, but if the manpages (where? in section 7 perhaps) is
the easiest to arrange and will not be awkward to have after the
transition, then let's do that.

Thanks.
