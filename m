Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617736;
	b=Uy7zqRN+arpNkOnVwHobeL3rT2IMe+d07tppzomLQN1qmpVI1TFeesCz8n+Dnbd+EYB6
	 1NNfm5oUZnoVHE6BGkAO2IxxyrGTTJS1whByHT+7XuanejV7boZIpq7D7b+tdZqOjbKzV
	 n4HnqGIHnCdddg/AXZz9c7gTx85RUuAJ3BYuUPm4Zk6xcFHKnUR2ixA5UTfxDJMy0IV1I
	 ZTc7f/JfFoQ/x0w+Fn9xh7zjvxGfkeoPpq9+BTWzAm9laOoE4Mu18Gwb4p2g4a+BTXcez
	 wNGBuy5rVGDk3pBNDdNTBCJHClacokO838K5qxmG2DtoKykbsdzvoPqCu8kZRrqxIHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617736;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0Yh5lSmVa5ZK26mXcH1KX4LyId9fLnmWrYnjijqJM3A=;
	b=GqftebgOLGOg2y2X5vLO8EHhGyyCgE8Cn2ZuurijYQB0mNRDe4swHi4jksUgosTayfBl
	 0/uwIR78hDFxJdL+huLixXKOramsfh0zLfiuK7i1fae7oIkeW3PXwGAhdvXm0+X1xER8J
	 MGGWhY7+qrsJR0mWOQkXG/MMGTOdkk8fUYNCOWy+LHAAjrviVQWHQ2AuZfCrGf9Y8hDHB
	 MFemzyluYz+1O6cIb8YL37sPy254P/T/RGGAkA0DOreqscx9K3kqLRVvaeEgZHi3uuWF+
	 XSpT8Pd162VMzbhezZCTTdeK/i3jv1Jj5WqOBcfUmNk1agiaDuUyzGcfZ3UK5uVJqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pNDh0iN1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YYLehvs2;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E5606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1E5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pNDh0iN1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YYLehvs2
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C9FD1D0008E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:22:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 17:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792617735; x=1792704135; bh=0Yh5lSmVa5
	ZK26mXcH1KX4LyId9fLnmWrYnjijqJM3A=; b=pNDh0iN1yuO+8opTVUBB2ucFrI
	zI2I0kJTiEEzzZBMWacgbPXysRShAmUugcyFJsVxvqxPPIvBPgbc4+EW57cwZUPw
	QLz6L+32ja6JtSlP88uquB1iu4CfYZFvGitvQ/ABRtEgKrkMCsgHbxpTMkh+DZv8
	7s0OR4mHH1h4G+Kt3jbJ1jM76Fux5LrFh3Jv6R3Z3Ml3X6gEbgK4XlT4LXcVBn5c
	qA/KDDfb9Lp3mvvOCmdBgTNQaszcG+CxceSf0lP64tTsOXC0X/+Zikm8p/e5M0L7
	8Qe+AELY4sZidiZmoM6kqxf6KgGcje7NcWk/gwua5k9h9T2UALkVTASZFEXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792617735; x=1792704135; bh=0Yh5lSmVa5ZK26mXcH1KX4LyId9fLnmWrYn
	jijqJM3A=; b=YYLehvs2UpVQf3zYIAwaMlXePZX+BnQxtms1ePbKsYvPZOVs0/a
	+WLtv2n4hWluYTCVaDeVgNua0Qx0i6YM2u0RgOt0JdDj2yb6UOrkB8Z/Jj6m3FcL
	hqmqJjIepCBD61nT2Dlpuua2g7JECgeb5zNKJoe0ppxnQ57wvW7SAiwibBPQgT8h
	zqzuxxel59nHAYmruBWUu74XCVyDBMV1V65P17clUrzW4+ZnbgRQL6iukGeCqVwu
	B5WHOXCb3/FFyi/vidS+WJvRlIt0v3lyLFXPwcusJqDT9RECIewVRvuic/hAsKt6
	Jhgyo0M2d4LNtlLV5sDH/1dPfpXKeK7K5xA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792617735; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:R7gngQFNyLNvp0507eyiq2tNRtbUBdI6iJ9Hskj/e7dY8SU
	uxbb4HDppeafHKyv/4iS+nnFEEtD1ZxBMtjGt0uCrSEvIzbuuORMC+jRO0kK3pmC
	4vCM5d8w6ASNz1bbNtptzkqxiFkN1oeLjaOncI4Lb+Rl4R9yOAEsrm6xd3xsC3un
	yydqJq14qy9RBfpV19sunXUYKP+FsOMj70StZNownh6e8KnLWlEJ+EOoVldS7Nwl
	PSduMspD6OG5DGZMelJN8FZ2KCsMJPkxPq27SOPRdT/eeodZaryDoP9YTmclgZTo
	WI/kkoBWsaw5sWzx8rdSDcpx3lsY5YE8uRoPG5g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hzBsgvLd1hxd4H2IB2Tfe4g0TVYWMsPXBNU79kUoSJE=:+AlZvcu12K/8o0ZLn1nwOjM0IgXFHKf7c9DPI97skW8=;
X-ME-Sender: <xms:By3Zany2nukbIVeqiNKlCf0f2ccqN17555FzEyX5UNKwI0siaK7vnQ>
    <xme:By3ZamsSqYS6vyN-TLPn2Tb33Uwmspjp0z8d-1mVY6Yz6IrQNRmF3nrL3SC808t_c
    ua6bZaRfVWS3xlTe6PlIZcqzd5iHcX640V-MXGGfKYmcw5TeY4VjIs>
X-ME-Received: <xmr:By3ZausBq1v8XaKeWfDFUHQv3PkJWTMQzBa6zrTyXrZgRCKxYFOAhN9AZuG3H2TK2MDv5UNRMpKCYavIlpRV0MfnMr4ZiIoXoI-J>
X-ME-Proxy-Cause: dmFkZTEsK+clX21tpbMlM2KWxPdPNj/ULUzVZojLL2v1Y4E/Uxx1jywe64d/80ePGwq+CD
    fgB0CPJzjljkLgG1ksabrSw7RU5RTkwtcusJelDwuNk/K8sWPUeUsSAfKe9OPFkZsEJftb
    k+f5c8tsNEmeX8htYrfg8h7seJ1ZRuHmbyuGMeSnW72RpEmaX3oFiTv83JiuaqRYAGaqHv
    5fjXThsvsLY7pCLMftKOxkJQ0pGE6nQo0xKr9/+tXqdT9WpFjEa9aEWACsPz1UuDN5o//6
    7r9dbV/Myc1nY0AXTg21pbHzVpzcPoPm7fmQ1VaotrALZwftxOTspLzW3NkJeuyvgxkuTy
    EmMFh4Q5r8HFyhG9qbr+DLNW6kTkQtJFIID7/Rw8wOvFRKUEJI2MTV80HxYpHCJBlMlilX
    d1jSIjfLCWTKiIikHHnwjxPyEzN0A1tXyEDgMUwm+I4UhMKCWLgrgRUb0OIKMQHLxiGVW2
    dqqquMseRa10VtCsyYE72vwkON2kJ4dK/c39JcT5HVxuGhJobi+9jqKv9HLUxEQB1Rn6HF
    9HT/QSVEUIWxONGO4sJE95gVz2/lVoLt0dyoDKaIQvvwKwNeP6eCoAZeZDGRUgOtLN6aqL
    mWxOsdgu4sJeGUefiJRTdFHk9gPESJ8PgUl/IefLw3uVncwoOI737LS0B9sw
X-ME-Proxy: <xmx:By3ZarN29yL9gSfuywpurq6fMTM21zA6NJ-IFDkzSjPQEOnGvhNaSw>
    <xmx:By3Zas3XZ0knJOxKQrsgdAc-EJpnv1RYloxf5JFtqi9qsZP7W4Hghg>
    <xmx:By3ZanORpk4Bj9IwxTxgJ5ifRS0Fz1XerXcC6q1te3sXMS52z7LOcQ>
    <xmx:By3Zas1JcGFpXOAKcwTHti76CHr59YUED7NOvfpHUWCn0HvfEzh15g>
    <xmx:By3Zak4Mbopy_ojqNSw_fO_Uasus2xmXuK1ZRpJZ0gG8pHCM-1oZynCB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 17:22:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <20261021200341.378978-1-emilyshaffer@google.com> (Emily
	Shaffer's message of "Wed, 21 Oct 2026 13:03:41 -0700")
References: <20261021200341.378978-1-emilyshaffer@google.com>
Date: Wed, 21 Oct 2026 14:22:13 -0700
Message-ID: <xmqqtsmelpfe.fsf@gitster.g>
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

Emily Shaffer <emilyshaffer@google.com> writes:

> Not all discussions can be settled by community consensus. For truly
> contentious decisions we need a way to democratically make a decision
> that represents the majority will of the project. This doc outlines the
> methodology we use in the rare case where we need to vote to make a
> decision.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> I expect the approval of the voting process itself to be fairly non-contentious
> (or else I haven't managed to write a fair process!) so for approving the
> voting process, I suggest we use a similar approach to the one we did with the
> Code of Conduct back in 2019[2][3]: discussing the process itself, ultimately
> coming to general consensus, and collecting a list of Acked-by: to put onto the
> commit outlining the voting process.

Sounds sensible.  One request to change the wording of the title is
to use a verb stronger than "propose".  The act of sending this
patch alone is a proposal, but once committed and merged, that is
not "propose a process", but "define the process used in this
community".

> And by the way, I do think that we should
> check in the voting process; it seems likely to me that we will want to revise
> the AI policy again given the pace of development, and it may be useful for
> other discussions that we've had trouble resolving in the past.
>
> BTW, there are some parts of this proposal that I still don't have a good
> answer for, so look for my self-review immediately to follow, highlighting open
> questions.

Thanks for starting the process.
