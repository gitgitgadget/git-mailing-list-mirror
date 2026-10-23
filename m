Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765123;
	b=chfYV5laSm/UN5tJbN7bRKPDScf1Ihyn29qjRleGIO/qeFVPfQ2Cqgj3ifQLcNDnUF6J
	 jY3Qh1nTzKMAdxvBh/au4WAjVXBvtj6DygDvxcitT+lIKKI7azz+KX4dzpRNqDxHuPF8C
	 vsMBAiWebHvgUpBbmuNqEFy/bgwIKBI4o8XKEzxH/Q29ZkwHbDd8xT1wJ5Lv4zQSg7a+8
	 Np/ewrx8WESbN6W6afAWCi9ZMfWmo5ifPf9qpeAtFSfHysE/XyeNFioBvXHZpPFrURkzZ
	 j3u5/MxiScKGz0zdJofU8BBzTjGMlOu+ai3CRwCJu/B/g2GsqYfHwnWnG4Aju7u3Mbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765123;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=QjSsOOinkAvGaGoz5/HhbZlkZsfgTFwnkKwegfSl3iE=;
	b=fP1oggj+2GwGRFzzsTYke5EHluuw4TR1PlwEeoRFmzerrEHEXMHq4/8R6TDByAkgcQ/x
	 0Jwb2SIjbuHEyLnR+UKv/ef77Ar/fOHGlBNrwN32BeOhRnIACYlafRDzk03aDlSdfXiEq
	 yRgqCqbGdou0e+pon8udZhkHd/Axj9Bpv36qJ8kuyiGDNmFDRJE5x9MybBo5Ccz/Vqe9Q
	 TKcJ/+IjZIvkLplKMOgU/e1NRMarY2lY4+f0gMYsu4tzTacN61AV4GYovVmFAOIBd69Y4
	 gayXzY/v851xw6ham85uYGUvjKWuvCSV6+9tUKxv/18q8GfUH8FQCvgxhTVhoOP8SlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=IZ7W1SCx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RBf5mJy1;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8860A606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8860A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=IZ7W1SCx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RBf5mJy1
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id B158A1D00151
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:18:41 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 23 Oct 2026 10:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792765118;
	 x=1792851518; bh=QjSsOOinkAvGaGoz5/HhbZlkZsfgTFwnkKwegfSl3iE=; b=
	IZ7W1SCxc3gReGdoMccHALdfIDLxyDYofxwegy83DjKk+p2HuMf+x2/SH22/lZ65
	qGQlJ2A3mJxMUgkLlC+NSgVYMNag2itZQq5GckugvK57WpckER+oMhkxFM4Z3RBI
	X9huXurHOdr2aW3zdZnGfeUv1TxCwXI92wWygOzfmdyRWdn5uEXw2bX6FGR+uYUr
	4zKLZHTYCtaWf3Z6N/Gmqc0uHNh+5bxQy7Yic5W5gwbwX9Rybh2u0qxdP041yu2e
	J0iRG6zew+Bmb0FEOrUXn663HbD5XbiQBrWtmhxfqTrKac953y8g4p+JrjkJTeqV
	8AFasS85nV2f/uVsxtg70Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792765118; x=
	1792851518; bh=QjSsOOinkAvGaGoz5/HhbZlkZsfgTFwnkKwegfSl3iE=; b=R
	Bf5mJy1OZh/Z46gScY3xienmR2lB8fa2A3m9njrqvTWC/fbf3070UGks04Ou4yjJ
	NvYTPXklmAqxBziEn1i6ApIRQ67x11CeBGvFeP/8Ff2BPifScI1JyeJK+bgZgaam
	Sc0k/erUtYpJS7Tjtp4JnIfJGmSYQQkEFnwlwp1EHl6AEqLk/iPdCdk0OxibZOtT
	DUdu1QFFA3JQIvbZDf0OnmHD0X5QG/bk/dw3Klt82ELJlhAgLPcw3bXarf5T+XbS
	g+DHH+bss2fCv4IczUkp6g8UIa507tL/g3DOPDRCU6IGmsDGb0vbCjvevBkBeQax
	J0uyDri+FJfitPUMZ8I6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792765118; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eBwlxrMCx8RSFfkzWcLZ7ujem28rBcl1mKij7dw6umW6Pb2
	hnB1tppa+8nVr4/bMQOjai3vQlE7B0DkEutal38mCPyahAjAiZWDV+IlFWvhAxb/
	dZMhDcqrtbOIZR9PHOTn2om+QbFk9zwUe/YPRf2K2s69yri0f6fgZh1vKGXvQ1Kc
	hJcdk6iIiTxu8RPOjFPLMIMW0HGnQc2iJAbvSMw0vUTJ4MQwvWe4J1YUahzTBkbJ
	hU7S09Y2/VQtoheqeaG+al2k02Mfg44c6JTs18HGxByQ3I8dykrkPmV7VyfsK642
	RmmdbSMNbce6z67wfxiie3rkNqOGsv8HWU6oc5A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YTdc0Lv4VL+blUupj+0x4i+Yp46S/07Tnwd9zJqbu00=:oXXUxrMVL83aRJmP76OZstGcOpNyPwkZTlYSyrxaenE=;
X-ME-Sender: <xms:u2zbajR_QRtyF8jHANnrzLVylYb9f1WrDcDPOk4PxB171H5uiFV8vEQ>
    <xme:u2zbavm0qqrz25fxfJqHflhhHWssKiV_AvTJozA6fCX7O6BnQOIXWO1_aDunAIhtP
    WaaXIHfcEfWna8Ouw66bLm4zfCrPBdf3sKVtp94Y7M-7NA9q6cI8g>
X-ME-Proxy-Cause: dmFkZTE7MwTQEPJnb3PfrnXpC+HXgufED+04sCa6np+1k1BYzGmSWtV4+TyPHYQSk54spq
    IAIk3MOHS3GZGtNiKPpEovJ82+4m3sDN0O2a+wOgEcAxyQDmQ9CbcsOz/8YpRVBXxDCrhc
    S/RkfOx2HS60tZ5x1LNSR5ZzmtWW80DzVavX0u2xQzxccP8L06hhaaVOa+trgMCvb7/o7j
    6iOX0/LUfdZRex8Z5P4lmUYEJZaZeujvsULpGTDfYLhU8WkHHES6e+7QsupopM7C+Hoi6O
    J0rjsERKpTAcGL8vmCHuNsQn4XX4WEL9GSV0a3F4OdpEYyMErKwibqGI2+Q0UIksQfKPGQ
    fLnsAPEakUOgJ78Sx3KOoh3esH5BWzccoHvk/FKRC8bPOmZVryVmcbcOh6fU31CJ6AjcXl
    UN0Z7u5tma0oLD+KF0TmohdQLfQyAMgkQw3WknYXeu4BUkJMtNF/0Sc4P6kiYAkuC8lZC3
    sZkuwQGliPpanbbAi9iESERP45X7w0wliSCXv2XeblfM7FM+vi4KAZ3Ykl8N9dk+LVfWO3
    Ml2SpNmq9+z1QuQhkChjYFSN6SC/AW+5AMLEE5oBXazvFMVIS3rQDd1NtwJh4YGG8RBkyA
    0YaXwEiZa6kH1cz3M2u9FQ1QkmrMhJKSw1QpZmmVyfcWk+Q0vZkezIrwuh2A
X-ME-Proxy: <xmx:vGzbaudpGkjuPGALs-giwYt6dFW1iPfCy-JQfkrcDdWHeTt17RLWSA>
    <xmx:vGzbahL7VGWzty8Se27LXCFogii0Oc5qVG7AoO33Lt8_lPwmc4L9wg>
    <xmx:vGzbarFakuUacP82YAyAGd2nuuuMowmpzDCfPCz5gWuVr7izZagIMw>
    <xmx:vGzbasDkaE3LsnfHB3wLp8tT5bdizcXIrIXUywB01C4TbfO0iNUlyw>
    <xmx:vmzbaoAo1cBwKzrOM4PkYi_a73dv_6w__s9O74jDOexBvmjxwxpZRmPe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1170F22C009C; Fri, 23 Oct 2026 10:18:35 -0400 (EDT)
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
X-ThreadId: AGAb6ilPifF3
Date: Fri, 23 Oct 2026 16:18:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Emily Shaffer" <nasamuffin@google.com>, git@vger.kernel.org,
 "Justin Tobler" <jltobler@gmail.com>
Message-Id: <037a97bb-af3e-4e20-9845-c2d92ed3a2c4@app.fastmail.com>
In-Reply-To: <f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
 <f192e10b-c7d0-45d8-8f67-21383474d16e@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026, at 15:49, Phillip Wood wrote:
> Hi Junio
>
> On 23/10/2026 05:48, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>[snip]
>>> I also think it would be sensible to restrict eligibility to the cur=
rent
>>> set of active contributors, who will have to live with the consequen=
ces
>>> of the decision, by requiring eligible contributions to have been ma=
de
>>> in the previous two years. I have historic contributions in a couple=
 of
>>> projects that I'm not active in anymore and I would not expect to be
>>> able to influence an decisions those projects make now.
>>
>> But do you care about these past projects enough to (1) notice that
>> they are having a policy discussion, (2) bother visiting them again
>> to learn their current voting procedures, and (3) actually cast a
>> vote to help improve them?  You may not have been active recently,
>> but if you care enough, and if your past knowledge of how the
>> project works still applies, wouldn't the project participants
>> appreciate your input?
>
> As I understand it the voting systems that are being proposed
> automatically send a voting link to those eligible to vote so I would =
be
> aware because I'd have received a voting link. Having a time limit also
> limits the amount of admin for the person running the vote, for example
> handling messages from someone claiming to be a past contributor whose
> email address has changed. The voting system is only going to be used
> when we cannot reach a consensus. Having seen how much time and energy
> people, with no real interest in contributing to git, put into posting
> to the list when we we first discussing changing the default branch
> name, I think we should be careful to limit the potential for bad acto=
rs
> to try and derail the vote.

And this is a very relevant example since everyone can have an opinion
on GenAI, just like main branch name bikeshedding. Contrast with some
technical topic that you would have to be involved in the project to
even care about.

Some people care whether software projects that they use but don=E2=80=99t
contribute to use GenAI.

>
>>[snip]
