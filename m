Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616673;
	b=c+F69SQ5cOvRz7a6zf1muLN6ydapO5HxdgmHMp3yH3Yo/4Zalm4QfHbKW1Y0fGH0fVqr
	 Zhn6GkwLiC9BVgoYz60/pFZHwedvqRilFsu9bcGe3TG3ihXYPhTEgeieT6xPxnFHXf7/K
	 fBr32t6hfP2WQwj7eGJgDTQveUHYt34WxuDB4J83OowpY32eYpIrLp0Y4bKjfweVYNb/n
	 kB87Oiy5g5ROauEAio9hsO2BJpmDoXXLByI2izJa36PcWWDCK4I1BHRMkAyslNkfJfUM1
	 DsT75F+z0XMVNBu098E92nGfziEL4iKnsZiWRf2kjSHb2vsxL7H9tuWyd2ReTL32I8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616673;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=qnibSezGsSOKhXIw5tsqvPfeYSIQuio9Y0smKkO9Swg=;
	b=ScjllhMI9CWnVjdgb8bn6t5xkw2qJJKesP01ODeRV8eTW5RYvG7oKmmLPCnf1m0qMkMd
	 WXylTs+VGIyikdxyOZkzeoflyRh3/2agbbjlwSRHwQwEMfr1PSTXJZLa7WcBWiewngGLf
	 8yldcyy7r5fgmx2gnAEzDUrgCqWXqIGPehn8/GLRj1FXn8pzDqtygnjjfAf+Z/UY9rVst
	 WbVbM1w19sc8CU3uMX9k/ILvnsy1cShs+hMz59ZIXD+bfKmvr985Q5TWRM81efituDZGn
	 3qIz3wkaAfDikRT2+f8lXh4J821+uleNVBmAgKLYHdlKKlrwoI9Zumels2Tms5t91Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=rq02zQn0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mKiXHWgL;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D516C606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 10:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D516C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=rq02zQn0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mKiXHWgL
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id C7529EC022B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 05:51:11 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 02 Nov 2026 05:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793616670;
	 x=1793703070; bh=qnibSezGsSOKhXIw5tsqvPfeYSIQuio9Y0smKkO9Swg=; b=
	rq02zQn0jACKVP22NxRzcs9nvGDrUnQIBqvLArvWIQlTt7Nz8gRZKyi7boG6nvGU
	1AY8S538EwMjVZQDzniP54pKOGR5U4WG2Rkwik3N0xGwmg6dKfkrVZIMI2sl6U7Y
	nBgfyuLQFJ4KRZ5Qncdu+TsOkntqu8ok4QrCQq3lVJSb0EM5ZcJc+Np+1qf7KRtG
	2Ils8lf5ubtH/U7CgBcw8DFppqg5t0tVjC0E/sbUQ4VEGZuqZKQ6AJmA0PgOXcNp
	tyNMNQdrfP1oj0SgK+O6PSzoXlHzRIiOw70FpNLAiA7TpKRvJEESrljgL92IfRc0
	q7P2XrFxBFz+IKDUimBPMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793616670; x=
	1793703070; bh=qnibSezGsSOKhXIw5tsqvPfeYSIQuio9Y0smKkO9Swg=; b=m
	KiXHWgL+RSN6m+qGMgnPLuCKlaFp+JALTu+LJejsE3PKiu5i9tiBLDzwXej9KFki
	01VESLLOlLZ8vcMC+Z+7luSlXf8x0/9vhpUv0so0gtYo8Q/s3/dc7WErbvHQUpna
	vzWnQI5dS9LzomVNFn8xqoc2u29KXpEK6UDhAYDz96rvD3dsQrk2SdijhlxNLmvU
	KT2Sg05Z94ssNeaDYfUqwGO8d3+MJgE0k/V88Fw0UH2opBsbGMBd7aoPTAH2BJCL
	dXOFt9N2KWeEntoHFXgjTwic1b8wwM4EyKcUBYALLKcVS+gND/i9b3iTYniD++M0
	9UgvGZ1Q/QQ7JDgYKYLDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793616670; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O5+FncMG579IL6j8hesPM7qDMqJz1oeoTV0z8IoR/eYbmfp
	7aq2QQcOWErvg3vBBRxUqL2HbA6mF4f2HKx55lxJclPrBQv88zPt6rgpovqf3FTB
	wgFwNHT+fQ8dNXCKHsFl7/2Vg27Ha5+41PmpgQucnWZF1ozVrtPxRcoatc7mP99O
	lRDcXwknWoK8vnRxbje37MzaUnrMdT6UY/qxZl5M25yKNkCyAA33Rq/GZwhZPjww
	0vXiaSoMetehtXT6mmt7N+vXJm+A/0p/TsUyGShRaarZtG/ivn+/vl8MuN6ZGQc+
	7LYYi8v0MeGLG4DOa0RD5RItrHgC8Buyz1QXSuw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WdU65Bzt49MQ4XolDEAzeOPmozMqDYOfivVn/hTfuXc=:GVG4C5vEsmkDODKUCcsPfhhLwW7m04FT2FCiniHp/ck=;
X-ME-Sender: <xms:HGvoalJV-xY6dm4_w3pWByRydHkoDHYC4RaL-Ldt8FtLPghMz5Wv8FM>
    <xme:HGvoar_T0TbfOpDIYinkp5j9lR1tzzH_kCMF2-4tEdMVCNL6iJAvaQlOrZ53O-8Ll
    Hu6jazHGWrfbwNa556c2-EWDVCBn3IO3N1AO6zeKDUVBv2v29t76g>
X-ME-Proxy-Cause: dmFkZTEtQcC5I3DLCjP1VUrBUn0uY6cfprhXKJVMcht7MPCi1wtNfJEay3UGf8pwVA0Otf
    2JXcLJFwWYOZpyiPTGw3jFR2Jdx0kFKSgeyg060M39FrKKsEJDniLTNhnyCuH9TmgTuVUZ
    LKHLyGJq+lmtIIWSyZ5olGVh5DWExqTsCuRgcdGMRryG8y7O6k9vpVaw16Apf3pbnsmjeV
    LCAVli9jnwJyR1SxCbue64dDLWNNiQSl6MGX5vmiOlpn1q5xq6G/FKMbR+hDdZnOJLtfIt
    gckswhM+tQV9b4/YS8rASCNpa2lAEmWIk3EC7RZbaEfxtUaWQqUIfqplYgq0FCbs1xOhPD
    dhw+ODk6QSOiJ1ZbPUUgtoFMUu/5mNkaL+XYcX6HmjrPra3k8mPYw7qOmImBDGCmHpq3gv
    H4ktjnyZ5gv2eyqpHlUAVg2DplA56Tp7nYxPgs3Bcgxyc89K+dx3LgN2t06KRnEMzk1SqX
    PsMyA0PelWA+YX6nQr5OgVj50aewvu8sqlZ7vN8jbT0wHHTESm2J5kY/g1ujbJcoSZ2k9Y
    rUmmcLGVLybADjD2i3hIX4iLIFyHgXmFAoO++EwQ0xQTN5BPCCRl8/k38e1moJkqbPMJL6
    TDFQGqrY5dxjz4Dqnl5l253CnqXS297s3XyeKguAr0ODnZzZGq05liI5oO4A
X-ME-Proxy: <xmx:HWvoapkc4QuNOjC2jhRGryZnttnle8nwO6v47tpxz63RKA7CFs7_pg>
    <xmx:HWvoaskmYUJKtAVsuZzvHvdE0XKkmzPFu_uS48c2lH7gvG0aOsyuig>
    <xmx:HWvoaiuV4wXFy1zZJUcQo_QRtPM-Kg1D0g1tf71afyuFuca6dp28IA>
    <xmx:HWvoanmmINItJSoiEWgDOZzGaAIkOsS7ZYzPgWrZrpxtTB7xrZXCFA>
    <xmx:HmvoarAamPEPFpHrCcqMbyJkRgJ8JB5BlyjHSgnSx_n5Xte9n6j7oPp8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 463EE22C009D; Mon,  2 Nov 2026 05:51:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AA0Zomq0_rWw
Date: Mon, 02 Nov 2026 11:50:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
In-Reply-To: <xmqqo6c7mx9z.fsf@gitster.g>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
 <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz> <xmqqse40ei5f.fsf@gitster.g>
 <xmqqo6c7mx9z.fsf@gitster.g>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026, at 09:51, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> Topic name (applied): kh/format-rev-more-options
>>>
>>>[snip]
>>
>> Nobody is interested in reviewing these patches?  They looked more
>> or less OKish to me, but I am not the best person to review this
>> series, as I do not see much point in this experimental command.
>> It would be nice to see reviews from those who are more invested
>> in seeing the command work better than I am.
>
> Second call.  Anybody?
>
> Unless we see some volunteers to give it a review in a few weeks, I
> will discard the topic out of my tree, as 'seen' has been crowded
> with topics that have been collecting dust without getting many
> reviews.

For you all=E2=80=99s information, what was originally totally unrelated
research has made me doubt whether this command is needed.[1]
git-diff-tree(1) cannot do what this command does right out of the box,
but it looks like some modifications can make it a replacement for `git
format-rev --stdin-mode=3Drevs`.[2]

[1]: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>;
    https://lore.kernel.org/git/ce69d94e-7329-449d-b3c3-47d4f3aa608c@app=
.fastmail.com/
[2]: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@app=
.fastmail.com/
