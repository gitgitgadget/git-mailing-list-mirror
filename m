Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791627;
	b=ulZunCeq5+3q4cF5gAXnXpm0m7hNVAiXr0X6ux3x00vQlxuQ2pJrYy4t5519IUaVHG41
	 XLYzyAysIGXWI/YNDyxd3svpVFFr4iKt93vcY/3okwODHTKiyrv4HDp0YOZl1KFlcYCFa
	 TA2dmAHRAtQ5TESNxf+ejFAfaWdV+RVleYnqrlYcfi/R7t8apzKsGdaiLziMPwqLyxbSZ
	 QpjRthi60NEKdMCLuxHJTs0QT7LindFUgOA7Kx0dnWSDkTeKYDiMmRMOOmIft6JxogkVi
	 oGguOb19SKXth0u0DE+ZOXnVJvTFuku8k/9LjJBsKnwiRrEe9tHNxBXlhVMNdR6UviA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791627;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=553J/K2G5Az5JsdIcejDsPy9KLsKzHZ8e6muZLCG/Ek=;
	b=WuVo0tfdP1RusHRu0HVIR6AXBBHS85DpVGuhZEnSEfX91wqIm8OHbcMMhLmEwc51TxP4
	 vL+jqXN7R6mCNvN/23dDgpqbkMJ/UR1OtxTJ2GV5HCu6A9SQMa11fDEqwgftNbHulQssA
	 hj7ylBvQUyMyDOfvQowcP7FB4/wbXJt1X4I9kDKKVb5w/CYe4+MyRVM/zp7uLLDOAB5/+
	 5VPQVBjSeUL5BlEDUa9pWR0QN88oqWCG+9kn05L/adRGkuvOCynElkTh6hEFbYB62V8AH
	 oQ9d+hfLUcAPU3cfhgH2zqSd4SBELpMeG3Ie57CZvx98wQDx0oJHWqol4k8KI3c98gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=CmwDQ5ZR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lCgj7qww;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707A606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 11:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A707A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=CmwDQ5ZR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lCgj7qww
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF6B51400041
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:27:05 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 04 Nov 2026 06:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793791622;
	 x=1793878022; bh=553J/K2G5Az5JsdIcejDsPy9KLsKzHZ8e6muZLCG/Ek=; b=
	CmwDQ5ZR/X/BGgh+3AJiQDI7pvN+vvlBJiaOiUYFBpvqSRcBt9BdvrTYWvjyUMKh
	esXCP4/F7sEOcYV20tp1//eYnlG4BgY5pkFXmbNsOf798N0xAJu2O/+gFBCsG80j
	w5WDoAuwiYZyHgCgY2x5haIHAIl5OE0rri8Fm/hfkIYkEyMaD+kYem3PPU5CZex/
	u3letPNjxkO6L5D5oaDdKSXYrri2QOk51sVV6+oAma8MJBpSMadCtqcLtJ+3nf4R
	L8ADBJiVAslNrqRG6iUnAoqNQQUP3fFBnnC+F1t+CpmXi6gP7xqfH32nSUfz9Cnl
	wn4YAr39lNCZutHg/PIOHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793791622; x=
	1793878022; bh=553J/K2G5Az5JsdIcejDsPy9KLsKzHZ8e6muZLCG/Ek=; b=l
	Cgj7qwwZfIuOb0137AjXHOfBsfPdSY8kshCvoZjNoAtFTUpGL3N8pEgB/34j5b1v
	UzgtcTo7bTuoVcoCagLdCwlkKpoTpDEJEkhNphoHUhCe2sjo8mQlcNrfWyZqfGWj
	n4NVVQvezg3pdXBi1XjdS9sJZGWu79DXTft4QcmhnKaPHdRV28sTNjWIGHIz9q7Z
	qexeugE+7cHCDxDeHHBug1Hko4PFRbsFNSoOuEe/hKBQMWCDsa0qGyX35/gwKClh
	wmivM1w+NQ7S3UjiPeboEbpxBHNat1Lo0/vaoxI/hcPBRBfb/3w49yGs+C61PYgp
	0VL/IiLItRPmKvSv1DPHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793791622; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HWZtdgD3ti/xvoMflkdt0ERLeDB0CZZIWvEd8jokWhSrS5N
	+IOpwLF29Py/KKPubvbNBfbkkuOsFfyBBBjlP5pABmhTVQPEg1TSniJyAkZlNiDf
	8KOInxDwj9DC/cEvrg6fmr/m3nR6/QPeRGGxsJxyjr0P/SrXHhTUzvwp5dDyJt0/
	AsON68u3SjINEJXHL+DhMfJvJMVj1oYx+oiSIAKKt2W9lBKQm0twu7HeG4OsxwUJ
	J8QpVhFP5iA70Wz6Be2AZjtoyRVT1Y7fTdsYCJKDg5p98J+uH1Fvr9Tp2alf48u3
	DbCo+RZoNXOdLgHMr/hUmnv4hwfEG39AzM8q9Bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:L3bTtkjoGN/KoQlQd2Npuf2skvJlYMjaiKMg4eiVlkY=:dZY2Q8wBN4Dbps5Y885fwFzzPvx9VfZ7gg0M+mXC7oA=;
X-ME-Sender: <xms:gxbrai-VcSUukzTqtUDvQznXZutax_rAb0Wb5tHLc3gE8aLdGoh6598>
    <xme:gxbratiSRyLd5vdrcCo1awF5AVNMvJ73DOL1Ss4gtglAtTlb07MQzLBMV3Y9hfRPW
    -xy9VmLMUBGm6yqa92V9YuNdVgZsAx5KBR-5lyzsTcSm-0aO5py3g>
X-ME-Proxy-Cause: dmFkZTF6q2lMJiU+8qXvTYU43lwcepY31jlI/qP7P7RGnXqe0IVfjMXyzmwajjsPs/QNk+
    O7YE0VyqR7XF2v2Gj1Ynsm0KD1lLL8DCbdCK/zY5ISnhGJP1F3Tb5kT7+ZWYvncW/gMI9i
    sHQ6FmwvPNdgNfvR831mc+KVxP3L26f8Di5yn4lxbTwoYK1IWZZbUqLYv3YwWM9/Ww7dcD
    OHxJ2auoZiayTwta9A2QqEA75tFhPOvnhSO7ShOv/QBqxPPjJnv1qU5yFup2DS7uS15iZB
    M+WMxEoL/EOOxwKzqHcPu9fXhklzGT9tg30gcjunei7BPZNmeedg9I76X1ETqF8tsJHNo/
    NlKANlomPs4CfgZ6krGFyeKOrnOcOxvwTlwNQ53LKosfcR5twD+Y7ZRsF61dArxsDofLJw
    v9gB8tt/GtV8ByCA0Ag8ssaB24ThfUVLXts8Pv63BY96j1ZK+2qW/GpooEvu4pDq/pJLzJ
    XUDl751lMpbD3CVlaiQpuPnx6yv4dpSVFekSc/jp8pG2M4U5WpRz5RtI+gEhsUGBraldZj
    ZzLnJcLJ3GqDHMTqatIlnhOQeKG3FbnCL/yzeVyxrg2E8APQUt8XB5rEEJu3u5mGpM1/mW
    ByRGN4+4g+nHKcYrTONB1w0T0tnmYXIBT2pQSw8eXNfH30yp/tqu2tX6SkFA
X-ME-Proxy: <xmx:hRbrakpEPRBFWKX3D1Ldd1SQ-HPlU-YLuPjy6L1aRL_YOpTwGf99gQ>
    <xmx:hRbraj__lfl2Pm03ghJIyWoo0OtMUrg-Dis0tlCr5O-aPFZcBn31Rg>
    <xmx:hRbragcXul6u4Cw4OxhzfqNamxTyG44ytJaDyLlwZabYVmLMobuX5Q>
    <xmx:hRbratI2kGFdLuEeAR9AzFt7mY5uMH3babAirclY8s7km0yqpZLyEg>
    <xmx:hhbrau8GgSy1RvAVqCrKByp6j-Ly0XIWX_07tRX7EuhMYIJQ0NXelRE2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DA6E322C009C; Wed,  4 Nov 2026 06:26:59 -0500 (EST)
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
X-ThreadId: AC1ZdHX1Xr-V
Date: Wed, 04 Nov 2026 12:25:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Matt Hunter" <m@lfurio.us>, "Harald Nordgren" <haraldnordgren@gmail.com>,
 git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Message-Id: <62095245-8121-4698-b1aa-ff239286d9e9@app.fastmail.com>
In-Reply-To: <427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>
References: <xmqqcxsmg473.fsf@gitster.g>
 <427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026, at 02:10, Ben Knoble wrote:
>> Le 2 nov. 2026 =C3=A0 19:16, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>>
>> =EF=BB=BF"Matt Hunter" <m@lfurio.us> writes:
>>
>>> Wouldn't invoking as
>>>
>>>    git range-diff origin/master
>>>        pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
>>>        range-diff-matched-only
>>>
>>> address this case?
>>
>> Three-rev form where <base> and two evolutions <rev1> and <rev2> are
>> given, and <base>..<rev1> and <base>..<rev2> are compared?
>>
>> I thought Harald's case was to take the patches from the previous
>> round of the topic and rebase them on top of a different base (e.g.,
>> updated origin/master), so there is no suitable single <base> for
>> the three-rev form, but I may have misunderstood his example.
>
> I think origin..old-topic and origin..new-topic
> would both select only the =E2=80=9Ctopic=E2=80=9D commits as long as =
both
> bases are reachable from origin (which seems to be the
> described case, to me).
>
> I agree with Matt that better selection of inputs to range-diff
> makes this specific case better :)

I use the

     base..old base..new

Form as well.[1] Then it indeed does not matter if you have rebased or
not, as far as unrelated commits are concerned. You won=E2=80=99t get un=
related
commits.

But I don=E2=80=99t rebase topics here since I was told to not do it unl=
ess it
is needed. And also because then I get to use the often more readable
`--interdiff` output as well.

=E2=80=A0 1: The repetition seems a bit inevitable and annoying, but I u=
se a
     script for assembling all of the options to git-format-patch(1).
