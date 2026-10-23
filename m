Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778338;
	b=AdFxyyB2o7LeazVPYuYkpjfdEmpIxyrJhtmFgUFHmrv7nq753ox9ksB+qkchiMNszjvg
	 7dVKBBjftQmhzqeGLgzqBg7ojKNBzVreZ+WxbM0nIL0t6shEFYoTFnuOLeXlF9i1WgXSW
	 apbQx9bxa7X52kYUZRzGJF1gbpAbEH3Cc101Eq1Gbcr08g8rRcDp1JItGmYcStifTIwF/
	 wiMik2IrDDR4WnzEuwz47xj9mOZn4XSrxMkHzPpjmZsyYeLxi1MbQbdCZfmLXz2z1N08Z
	 ulWaHYwjphcdRCErF5vnC26rn2f5tqseBnv26KAwqJHTXc3kocp7bBIo0hLiaU0ky5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tgdb1TAn/iwiB0WIJHEuVQPxjrrexuYP5olJ6PItjG0=;
	b=zScS48PyM2L9WACsFMO92X9m/+bDxsC/2840Mvtcbq5erCd1vt69bFQC4qG73bC+o9Df
	 gp6VMBwNg+aSL0ledcq6499LNb3uZRl88a6SdM7qtuPqgzmDvkZZNbsJUbM7oEL9vtthh
	 S7JI6EsuUh1YyxeajznAvx90Cpk2Fc4qCJ5ELXMhyti0LsYHV+iq61KBqE2xlOOAUxRZh
	 9Y9Jb2uNIImaF6h9yINXm5MEJHq/qj/kSASD8qG19skv/8V24gtXwJcT9aCP7sdXymwj+
	 38h89sgbE3hbihWip/JrMCYluCVixT3XtjL0tzvO40DTC/wkenC8wQbmmwwIuk+Tzlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oTK2ZWLx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="CI/c0hMo";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7D606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C7D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oTK2ZWLx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CI/c0hMo
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BE93BEC011A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:58:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 13:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792778336; x=1792864736; bh=tgdb1TAn/i
	wiB0WIJHEuVQPxjrrexuYP5olJ6PItjG0=; b=oTK2ZWLxbB/QxxSj2lzz2+UXgE
	YS/AnIhX/AMqv6Fu16P7EJYGhmh3kDKn8Wru/TebJV1MpovJBVzV+7jYagOqkobA
	+XbiK1vhZ8n5NbX0k4JKDgC/WGQTRO44r5YCgF+DsfyFz6U3Km6kUaOeRqi1UU6p
	XQ0+KQMn1UsjM1ay+q3BFy5vG5k70CYwKXQ1w2gYbyCn0M2wCTwSfPD/1cq1F1hw
	cMPmVTmndA5l0MCDz7Ucd0vqwrXlF/Obr/KNgIAl0FTjeJ32klX2WGrw0gAEUgC2
	MbujhOD+IVkIEOufMJiEECS/v3Rs7QH5NC7hNKVLswX5gvQ6KpQG/t4xr2xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792778336; x=1792864736; bh=tgdb1TAn/iwiB0WIJHEuVQPxjrrexuYP5ol
	J6PItjG0=; b=CI/c0hMoxVDA1WIm+NlsxwAxooxhA6nI1NMzo2ejP7CuBDb6Y5C
	RdizAblQGI2tM4EqhrlTa7qx6nVzG6KA+sGqCByrKP3z1uWGXI8d99Eo1uzZWBZt
	j4UdDdlIL3fcC4FzKc2FivMaEkB/9tIZJoYj5yAuWs1d7Os6mM1BGAxXg+auK1Xy
	bjD3g0xUCNeNXh81N6+So95hr1UdB6s7fNuuBldvvJfP8UKM68lRKZyXJ7jzwLoH
	kImaLK0cRNPy+jyZ+fbG+79PGlw//oomoq6/Q5lPcZ5nk6Ngx5Ek4I6kpF5d4sxD
	oAFpOsR9Ujs8nq67mGIIHn0x6TktREcqZ6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792778336; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IDfROsCGSa1FQk1cWnk2XJfZ3XPfnnXS1kRekZhziWsuHkP
	FVl9ps43mqnAXw1lTxMt/yRzBh2dedL+2G14l9W1Dl9dpa0q7xij8QoKZwqlhNaV
	d/0jpk+SugFZ/8Rxvf89FPkvmf4ose64qLYw1fMb5lwj5sc3DyTCI/uy5QJw5bAn
	SfJ3tvN9AcDrIPecPne1Fxy/vx8733E8yAAYV0xWc/X7Uw2/TxG41/qJWgguJS7t
	//uWVEcy09vY8uCthFNObRCXtQmgLv5GNHm2qOcP2awcSCPB//5It+eru9QVoTkf
	QSF/kei3AfcC5JhaLjvSZAebiLNJ+KiM1aSTDuw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yZOIbrDNcXR0uRjU5OvLy4KwPBuJhZIxa5qPEmknxRo=:tgdb1TAn/iwiB0WIJHEuVQPxjrrexuYP5olJ6PItjG0=;
X-ME-Sender: <xms:YKDbanzmBbYOJM7a4-DoxtLU4a90InsscGddLH_gVqmCfZxNBqp64w>
    <xme:YKDbamJxE-vX88RWbYGZkrJwzje8Syhc-HCELiDxqHCF4Bi3eNsuedKG_eLcwWmsx
    D8wY48FfvuEoxq4pApIJ6Hpotv5owd2G9ISRtT7d4rxKwThHmNHF8vb>
X-ME-Received: <xmr:YKDbaprlj7Trdv5PzxzYGrgt3iu7swh6Ug5BUGRn2fvcFoCY8ENokoXsPhVVhcDov9UfgAp2gJpB8Wu2pIzQ2jzDjxwJi_WVrHD_>
X-ME-Proxy-Cause: dmFkZTF+6tFyzQjzvTOjOi9XtxEWy2XIQIbT+ts1j3w92o71050qvP9SMHRhqShi7LBtPn
    /p/K46rGDe79ruQrx5BJBlVY25ugNrXLJFPVA8zZwdcCL1H3OJnNPoR11NCbF1KXzeno9J
    /utu4fDUMojCjRrpBcyf/xcyBOcwqFApOuMWnZ9BSUWnXdjjzU9N40m1Q5d+MFiBy4evJS
    IeoD4ZIEojjMJOn4ug1aXH/iJcSk2MMIeTxOmR5ZN6ICykziM3mdseBxgRkVvxCZgx68Eo
    G30pk+h/ebmEQU9ys4oEP/OBil0lng/a9r7qmvje+BX8Br3JNNg+urtwGD4p12L3NXSdTd
    u+5V4FKqzzwrCbhnFFQtmLPmIZ4BsJpg6FcbRZqMq8CEWGAlKM/qRVtYlbDIbBKjMS1cts
    qI8IzEdPUjmFEycKHa3f7U+TMEd3Nq04Zkdcz/RxMgsNX0Q+oMlN/jDZH+8iKta2saYp54
    QYqo83/I5u0NDrupiffG6+/0arRoG69KAnL8zXBOkCeXITAcK0gwEs1dD23iKPH1MLdH8m
    z0tVx+5t8Os5Ec0LiPca8TYVB7lAhG34kIDWKjmWEXkLPf6HnkJx+rBEu4i9GrM9KOjRFf
    P0Ahkm9NDt4B7L4OeiD1liddRAr8IuUPckzkNDSlciFNXvETLK9ZDzIkF6fA
X-ME-Proxy: <xmx:YKDbatJIJuW3e7aQvqWfzt6j-uiJAYPtGM_vHW31dtniZWPyt1sqXg>
    <xmx:YKDbamRqZ2mVGWguQEgtUhFlgQfu3AVj1bqGCl5KuPCwUFQS57d6Jw>
    <xmx:YKDbakt-yprQh9pj_eG03qGsvo79YMPtfY0RJ2wCK6bkHzg3dzVtQw>
    <xmx:YKDbavZvDKPzpLzRdlJg7wyaCT-Z88dGnGcp7vUwXCfyZDQQ1eauWA>
    <xmx:YKDbavJRAB5XRjZ4Z8d-YCm4F4hkL-LwZ3OqyACe6EdX26Yt6mWvDYbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:58:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 5/6] connected: add incremental connectivity check
 via rev-list
In-Reply-To: <CAL71e4Ngsxv=JU_qzVGVyHPZiB2Qzvjn22NeVQAtZOdCr2vyXQ@mail.gmail.com>
	(Kristofer Karlsson's message of "Thu, 22 Oct 2026 18:11:01 +0200")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
	<d76dae801b3303ef4271f71c7b3999c10cac8556.1792581744.git.gitgitgadget@gmail.com>
	<xmqqecdin6xr.fsf@gitster.g>
	<CAL71e4Pe_NRxeu9_+pnp=pBOk3SBNyePUbT5DDtDhd1bJpwJng@mail.gmail.com>
	<xmqq4iedkd2u.fsf@gitster.g>
	<CAL71e4Ngsxv=JU_qzVGVyHPZiB2Qzvjn22NeVQAtZOdCr2vyXQ@mail.gmail.com>
Date: Fri, 23 Oct 2026 10:58:54 -0700
Message-ID: <xmqq4iec70yp.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> This ends up nicer than what I had -- I can also get rid of the
> BUG() guard for checking that flag state.

That's great.

> Do you still want me to include this reasoning in the commit,
> or is that now unnecessary given that it would no longer touch
> fetch_if_missing?

I do not care too deeply, but the next person who wants to add a
code to depend on fetch_if_missing may appreciate it, no?

