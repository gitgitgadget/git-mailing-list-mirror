Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872351;
	b=CLlwL1wXwW1uMxyKKwwshDlcyPpLW5DdyPiPIgQlX78iQUHoRiVsP9OnCKiig+EsWgPV
	 e+p6gGR/jav4f/PWeo3NqQLNd8q3mMbRsS0+DVG5xOJm3GKs2jCCZVbLIN6U75DLWAN5p
	 bHdb8xEMAPljq/uIRFob3lhwBBoSw0ykoTaEBTvGlEdipLHU6XTrnMgx4Rgu7AqLsgrnO
	 B3hixS1A7djvV0Nje6alzLgf1cJhjxRai0Latj2ljr9ZgEoo+7rOi10RDHIXvmNMB09XW
	 81tbqBPaSz53huoxO6r/kha9oL3leco+EuBzjF3G1EZIahY2O25WmeSxou77bXhzdMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872351;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=R4L16va28wh85A4HuMnQNjf0Rg1hZ9bb17ahP7vlH7E=;
	b=3yu7tn+NhSPtHNDx+n0UbnHUQdLF1q6974ddfGwcYUEnIbflqF6YQOa5k754tLE87I/q
	 tlunDBsQF+XCQ9+iZ8DankpmRkj9wdlrOePGiwUmorIuVIPbQGeukvVPoJRNPN3Gqtm2q
	 F6RjfiMWWp93/I8tQoqqi5ANdrrgA0Y1mwP96auQgzL5mhK0cD6NDKbE1R2UlSVW3ghBI
	 7zbJIYXnhhQd4xO/IQ0ttXGL9LVYxddcyuxRDn0RaXvL5M/Ani/3qP5zwgidFv75GTcWT
	 aYfvyeF5IcSpkA+Gzr4cCjq5v5tcGhtBSPOsxIxyF5lDZZ/2KeqNz9Z9k9fMHIzwRzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RBN+7AuG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jSgEhaMF;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71A606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 23:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A71A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RBN+7AuG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jSgEhaMF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CC9AEC088A
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:39:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 16 Nov 2026 18:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794872350; x=1794958750; bh=R4L16va28w
	h85A4HuMnQNjf0Rg1hZ9bb17ahP7vlH7E=; b=RBN+7AuGa1fsXK6BEiLWuiGsAl
	29siqX/kZAVpEJO5YryiXfbQgtAaqYYbXj1Zo4k4xfpzi4pXsStYVdw0pCP/lE7o
	4iyO6mFpyQmBAFfE3zl5oELao0Uy80LlCLeXu+Ht/yvRd9fdUoTxmKIykVyN7YO1
	zZ5ag+bj7gBztyEHiGAlwv76UlVwyLqrEqU81MZjUV6Z2m4LUhA8axtC5gv3Ay6S
	KmAd6JxfhcLB7I6vJ0ldEYTchilNXCKc2f/pmXcDIfMtFxKFpa9+294WsfBfxNwc
	agyfELefb2GcPsGfNURUPneaymfjWIrG+VTCc2adloO7zkO9rkmkGJtl3Jeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794872350; x=1794958750; bh=R4L16va28wh85A4HuMnQNjf0Rg1hZ9bb17a
	hP7vlH7E=; b=jSgEhaMFmIajCy21B1PBq5UXinbCU4Kaepxp5wzao98MEArLRae
	QOAPTjr3YalZZ4fD9NLctZaS+XObtBga8ARVIoNJKC86ngPa7EgCngYQtQ4RHJz1
	VlLdSQd1t/N7JO7kiGnwAAHOhz0V/Q8rj/94OuFpLN+Hor7r7aic78YqD97LnVXc
	41CglgjI84ELqSP7dvXSGqeHRoB2WN9B8R6QKdbTNxTIKUykCMv5GesczpP3KeFA
	Qj6GJ2I96QEaVJ6BRiire3q3XpzTOhcvBXj/tzI2RD4YbMXmH0wxY/JK6DfR1Eek
	e9PL+q4WUyRk2dPKqCGrskmpRRtDWsVoAjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794872350; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hLxabBuq3qf3EvV0gS6DAyJtJX41nawVevuU3hh8k0qrHoH
	s7v6Gc1ji3aV52XlFs5x7HE/RRVRH4unn+MAYtDoadM7MAiHaAa9KNHl4ZB4ZItE
	PzKEAvD+xR51/bt7XBgGYf5Gvqk1c1msnn0IqDiQ7oXp1Bf6YHkt9Bmf5A5ciX81
	VCAdIy6sDVlo+B2t8p4kue4Oi64Jv3lrdXPhmbpieHxmq6WvZcX4BrOe3B3ZIijn
	1WxzIIdt911p5XvxJp9c5NfPv2qdfbIsXTRufYdcL/cuuAmj3arPXrnnTb+nxWK6
	qty+qsGb/ry3TtIfelAsvvADCTI2/NoZPRMa9pw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8xK7ybcfyySSisj99yp3pStfs/ZAGP18OExC0DDtmoo=:TpjyheN4ZgFlcGzcPbYyO8To8JTFpCXilD61uFfeNP4=;
X-ME-Sender: <xms:HZT7ak8oQtdK_QPmUEcHgsqA4TeMRvJ8lmccxJuiZZt21sU_CZwHYw>
    <xme:HZT7au8nBMG5pZhyHQulTpEiaoHyuBbICsWYxGBgyimef5vW7lobwl0GTNeDj7dy0
    jRqAKBVth5MN_bUEWx9KdvwGqVs980btR_2mguR72ci5lwTGaaz>
X-ME-Received: <xmr:HZT7asSWPegkNeXhkSbSz_1IzvJtKSlBPLnGovgp9z896T45QDhh0BLKnbleKSayRYFDQ01t1dvnuM7DPFWyapZK84H87NHgiURh>
X-ME-Proxy-Cause: dmFkZTEOqZupTZXP6FmI9ge/Vv0v5vpoQWZtTZlxN5C+qXfm5qdlv9Ijsq8gdbFdZg+Lyv
    Wac1xeRTZZK+RtbQcUp3wcOOB+6DGQ1Ju7PvXdyK4zcsXhU3754XIx8jFmu2xRlWbIVFNO
    EH8pX+d6SMf5WhFywPnlPTcfk0Fe6JhYp1t/9wEoln6F726iCyhJoIlFXu+ko1AlC91clM
    HqhcY5RFfKGPh0O6gMXaR9vLpZr2/sNnqdC8+9CZb6vRpp2Cu/KSLKiBw/fLYTFwON6qZC
    /3sBFwv9/orurP0VMVUu62zqBFEViFRawKInL/sRJGJt0DbnNH2lngXKjdOREbpPdmRyYH
    3ZZ4mrLm7GqqdYTIHuTPvQ3mX6Rj6s3O2RQ7AVWlfFhekszb52YxdaU23hJZ+O2WB4B5bs
    ADcYAu2+1nk/OMPImRrLeRtC2bpWukTJS8Z0t9bPSAlu88bPN85+3D6HJD1/9WNVIrcoNp
    djEo9kTv2HILWQt19aZdq5+e8ccfSlfP5tFytwFoOx+yKIEtOT+l8OTXaeWRzyE7GIra80
    aWowgQqkHzEspQuXIf9P0j8cLkORI7tFJFwa5EW4fdfikRRwm6ObYkZx+6WqiqvUKLfMEW
    4hKo7KPPfq0H7/w8a9iiBC71eqWk43qgChaUdjYJ/llmSjHpR/Sn6JUng/GQ
X-ME-Proxy: <xmx:HZT7aqe3DLv5u4o5L0BrRtvEBFo-Kwjnsvr1pakMDZkXyak4UH_zlQ>
    <xmx:HZT7aoAQE3mMKTlCOq3Yf7x-Nnk_a5bpZ7wS30zKwUOEGWuuvx_lBA>
    <xmx:HZT7aklmPjY594w6NXezO4O0iV-V97ReRRy9rmWzknJYVSh_bRNYDQ>
    <xmx:HZT7ard-nTV6_MtDDMWb8-uokvGHrFlZLhpIldDnN_0Z3ehEtCcyhw>
    <xmx:HpT7asxvQ-Q1fEaM7ux54qg2z2XstZLPsYWlmWVXP5ReOdwbKSDwQiTv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 18:39:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v3] credential-store: add lockTimeout config
 option
In-Reply-To: <20261116191321.28837-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Mon, 16 Nov 2026 20:13:21 +0100")
References: <20261016212216.58000-1-okhuomonajayi54@gmail.com>
	<20261116191321.28837-1-okhuomonajayi54@gmail.com>
Date: Mon, 16 Nov 2026 15:39:08 -0800
Message-ID: <xmqq33t0jqhv.fsf@gitster.g>
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

> The other settings that retry taking a file lock are measured in
> milliseconds and do not put the unit in the name:
> rerere.lockTimeout, reftable.lockTimeout, core.filesRefLockTimeout,
> core.packedRefsTimeout, and core.configLockTimeout.
> credentialStore.lockTimeoutMS spells the unit out.
>
> Add credentialStore.lockTimeout as the matching name. Keep
> lockTimeoutMS as a deprecated synonym so existing configuration
> still works. The value is still milliseconds, which the
> documentation states.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v2:
> - Reword the message to say why the new name drops the unit. The
>   other file-lock retries are milliseconds and do not put the unit
>   in the name.

Looks good.  Let me mark the topic as ready for 'next'.

Thanks.

