Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051486;
	b=D1ob+lqcem/RDf81wOY4fXXMqOcbS7NedkT0+qrOADYrHTRps9mW5gGShTpsMI6B3nHt
	 lf4cWHziU3s4tqc8td/enTwK1ogzm6XHBiUH0CXCdLtrEn54QmGLaT6bsIvjG31jgm1HF
	 VuMweV2kmh2+JrSmm+vb911D3rdSmIfEAqDykF7lIJBs80/YZuIIv+ObjpiKYF+4ZJ3Tc
	 QIlF9JaTrLQZzU0StgRv7fi4h1QE/m/48BoxOhP9vF3JLDKwL/JRGFhJ9f5FjKE1C5KM5
	 LMbPbSj2iHgVPtebvJi6dHffTPcRxnG8TEt6D9YEOaNkB1ogx4a1/Tvjm0q0NKofmXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051486;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OKkLI74TSBt2g2MydQhBSdea1rgJxeAmoZ5jHQU5zJY=;
	b=wfEP2+GG8Kl5EqBovtqpG90//IFNcM10V1W7MxG/9SLBopjmBZIqAs1TW6NYnEGg1cwh
	 UFKe/v31fWatLA1XvTWzfkRIM6hM65Wzx8bKIjCdvR1c9KpQl4XXuaduDT9BLmhGxqcZf
	 aeAUXB1d4eM8o3g/OFbv34TYf0bG9aC8xYyU0uOha0+8MsWp851UUHObdhgFqoJXDsn5X
	 yoAUQ5b5mONi89XEogTfYEggAe5oNW5lMiCTU9pCecHnl6nIhaKA3wTMnkzWrOM6z9SxI
	 iDmZX82iXuIZ786Bf8E9sJUQmQ4LJ6GoDO8X08xC8vseiL4CoS5iMzoieT1YzPvQ5eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ihiBh54X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1WTojt8Y;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE96606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 01:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE96606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ihiBh54X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1WTojt8Y
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 759B1EC0184
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 20:24:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 20:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795051484; x=1795137884; bh=OKkLI74TSB
	t2g2MydQhBSdea1rgJxeAmoZ5jHQU5zJY=; b=ihiBh54XPG+yqKzg2/CnODVTPW
	i2/PXbVwj+GZT7x568ZbTwhHDKzSM8pK1WK4O9J49yAZLKH5PzzQF4ZfHlzCGC8T
	cpTshfscTfpPPte/2sLCDEC/x4SMk9ZfQ3Fm+stx+c27dvth4aS2IuB/x5WwzqxX
	q23jQxKjvJZKrjxkkRNc83GxF2TQLjQI99Fot81kO40/TL6D6pDtuvYSOclcIvla
	aCZCLuskb2MRO+GemU7OnPxWKjySIBQnYCcxerce1pwYDLi9F9Nd9g7PHieqDLBh
	Q72OckXlfMZoCcojSdOz0mnjeu2aamueEisnKJvJ1BPazd4cnjn/amC93kbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795051484; x=1795137884; bh=OKkLI74TSBt2g2MydQhBSdea1rgJxeAmoZ5
	jHQU5zJY=; b=1WTojt8YYmlohSrIYwgiMlzSa5iOSXiqcDwO2zP3dFzrYBpyugB
	FhAhwzLWnY8jysmiDgGuIWHREmHDkPEomgx8Qcq7xE4x8+LHCjNvlWxHDoWx+/o2
	TGtYUJb+MscmMv5Ogipu+RNeXQcyecAiqdap1ZuWPhk6dYwpYDH2gjF2U0B4QEft
	RcswUwz2LrAYGoHx7uFt/CH5x+qrmVtidaX5NPqMfHz0cudII/TmfTjyc0SNm+ej
	iIjiaznhOCT5JL2ZNa+qCMJTBf9VhJ07y9FTVsXxzxtCHZOQ9fLyOQ+pxdEa9ieV
	fgU8SwrvbXjAMP12TO0RY9YM5OcsA67q+zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795051484; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dl7DxvM9oRmPytiMYfgwNwAK0Xy4zTrGwbsoPMtB3AUiyVR
	xYgh+tQZPKKvmoHo/Dq2Uec4eGFhpUF/GzFW69+7jcyF757PKhouCosD4V6zVFju
	b951LWWQ9OfaE7MgpDSgzKlgNsHQbJpcWB6TEA3wJhGjra8POWgVajLteTR83rfl
	jKghPCbN7OHhCt2rUS5VO6EsmeQ2ZhmjY9UMRMMc28iq3GiZSkHUrh5MS6SKadzL
	WbXxFdQdVS8PnK4+1g2ExBgmgIK2UdtKshQZvKJaTTpTeDSAZ3b12BR5DCgrDWmd
	wHBF+za76Yi+AmCfjLUuS8ihJPsiDDFFhmWjpfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IGuH9tunrp5S+9X55Z2MenFZYOafJFlex0OAqEfCscE=:Zs7s8nWi4J+aLVbGtT+QX6IeNIkEqrvSymvupUEX+Kk=;
X-ME-Sender: <xms:3E_-asWiG8ESCsLUM8xUrNRDjSahqdAwX2Bx1ja8qlsAZunUb9_6dg>
    <xme:3E_-akSNDug4n_Ill5KLDEaYZ8Odmf0bP9v2JHGP4ochGcXdBzm9B_RKLsQQ3jGSl
    DCZRh11IWPjrm6qYkvDZumYO0ALNoF009k4kXpeOC075JRPRdXHYDw>
X-ME-Received: <xmr:3E_-aqOYkFz1s7GcTOHTR2mtwxrV54RitF08wh2TC4cQVHkgwbd8PMRrbQqH8v1wAj3ScYYBfL751jpB8Pz_6xDmDHFwZKDeRnfY>
X-ME-Proxy-Cause: dmFkZTGyjLbTJIlYmW3/3JCdivbU0bcnMDvyMsy0b5I68EjsWYAHKeMA5oq43ntWL3SRE/
    uQiKTnwhR0s2xJnHz0iqMmF5eNZoVoyxyweMe+ZEe4qaEYOJWCouEiBrc7CInGP5jfw0lQ
    rEDCufhFvyWEGF/ZPXWZl5VMVs/I9YbQL1TVjggjfJPDQfI3IUbIzCGA+OXAp7mYCB+s1V
    cLfjEM/F71Yxwt/qrb9QbiKcNalXdj+P2Tg2ICtyEe1lGveOHVt2s4BmZjbu7GljkG3Jle
    /iJol8LiZpWHeQgrFc7hlnGA2jr69vNrKE2J01l466N5lQB4SWtuuhuCLbD8HUnSUk22mW
    U+IBVIluYKDryNRWnhuWv2EDx4y7umaR7c9lbwNft6TbrzhW31j4aYEaBEaMukbo/j4DmZ
    gcPBTY5uwBLNMW3ZNZgwQDwnjoO3+3pBXTeVHFY4ph0teicE2lK75rOmybBf/FpcrTYAZA
    eQiUOlKBP0nddsbXh/XUUz9OiEZinBs/WeUJCyfn536Qo52L6zo7ptT9B0nBoYaNrW9Ryp
    bcZk8mN1VLGcT9ZC02fOsXsl8s89to6ewWIpgfqSayIDSpOykoCsCxPrE1VSuxu4PBklx8
    NTs5UDuZBtfUp6VMlvH9/FIW5wk9OvyLZhcFU9A9wKdRGdXBxdwCgCU0H9iA
X-ME-Proxy: <xmx:3E_-aiTf5EYC5gPPEx_g5h-iMKPdx8pUxNvk8dEhAa6MQfWb182QxQ>
    <xmx:3E_-aogpkyPaJjEMq2ZUAhunmdjpAAQCAbadQazQ3EKIYLtw6gFAXw>
    <xmx:3E_-ar_9iCXKCcsExFauF3ko6IhJ3G59RRn07KnMaR07t1gofC5aDQ>
    <xmx:3E_-avEaaqv0844-IbcODUIaTjsTo4BMhZ1Nf7WoZakQwpq_POmiIg>
    <xmx:3E_-ahLmlTqU0Qg7qwEohmdkt6_QPWMkvzl-psMZsoF8PmHalQm0VQlf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 20:24:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Noam Cohen <noam@noam.me>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] ls-tree: do not quote %(path) with -z
In-Reply-To: <CAJeEYUaJt49oz+Fq7qwWGyB9p=Hibdzd3113FBhbK1RDn3oHug@mail.gmail.com>
	(Noam Cohen's message of "Wed, 18 Nov 2026 18:45:42 -0500")
References: <20261118-ls-tree-format-z-verbatim-path-v1-1-718987241861@noam.me>
	<xmqqcxs120c8.fsf@gitster.g>
	<CAJeEYUaJt49oz+Fq7qwWGyB9p=Hibdzd3113FBhbK1RDn3oHug@mail.gmail.com>
Date: Wed, 18 Nov 2026 17:24:42 -0800
Message-ID: <xmqq8q2p1ulh.fsf@gitster.g>
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

Noam Cohen <noam@noam.me> writes:

> We could avoid the filesystem and synthesize the tree with "git
> mktree" instead, which is what I had at first, but that made the
> test noticeably more complicated than a test_commit in the setup.

Yeah, that, with forced core.quotePath setting, was what I had in
mind.

But it is not a requirement to avoid stepping outside US-ASCII while
writing tests.  It is much better to have tests that use bytes from
outside US-ASCII than not having at all.  It is just that it would
be nicer if we do not have to worry about platform anomalies that
cannot store characters outside US-ASCII range.


