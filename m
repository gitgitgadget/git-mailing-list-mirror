Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018618;
	b=2/fOSadM6pFeDPTVgk+wEE85GXq5eAeyeUj5Y8bTkedGCaZImvPLb1jOMqc9YEQQrDsI
	 41xq/BcBWaAHmz+71cqn80iY1UVHaEePgauFG1nbBTSSW7iKMdJYaNYmTrnlQ6S2TDpxp
	 zu2VKnrzg/dVXWA2oJgsHlwmFOBL0WwmB+2baTYjFuzAI2V2hl3xfX9tvGt+f2OdtIOBF
	 6f8E1J+FPoEfqhPv0681F8aX04JQ2VyLrzGT8IKnEQ55lOYdPV3vHcb8usjKj627EKfxo
	 npx2WjwL1EFoHfwmR/J99Bzq6WZLGO8IMFzD2LJvlgGRXE540M8T9KJz55ikLdYOKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kfbQ9zlidwb3fEptM48omARg8RHgx/MLVA99GcVZevU=;
	b=2PksI2YyCEhBViXdjUs0M2WQJ+XpwPTLfTia9cwECG6oPN1PmVevJ3KWc9JwGx9CS7Ye
	 wTJb91xJ5NhBPx1S9AHAiNWmJiuJvKCCrAyu0m6xgQGrK0GSyax9+yGFcHBGNq0Ne9Jxn
	 G34bgHYgOFGGBHSwzhz680rOt8LqmnFvu+oV4upezXbJIWhuUcZ4rzqfInn7jbQ/3a0v8
	 A+rlP2BMoHuwuCXR+cn+c9x9n3gWGnX4Yg0i2RQWN1BsCoiuV6Wh7hQKGX1/QfBapUfGf
	 3LW65YRNko98WGRimLra25m3jAYC+RD7h47dgwZPbVmGz+br6roQyhT2rC3/xSM/Qpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Gcquc1uc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dC16vDj0;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62497606A332
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 02:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62497606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Gcquc1uc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dC16vDj0
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 78767EC01CC
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:30:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 21:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794018617; x=1794105017; bh=kfbQ9zlidw
	b3fEptM48omARg8RHgx/MLVA99GcVZevU=; b=Gcquc1ucCHSRHT0fesSxYCx3zv
	krWP2r0LQ0OeoC+SnUlEs/xkVsE4KN/JJ6BIJUzxIiayptN+LZ45SNI6apTmJweC
	FmvPRh0z4e38andn/ugIwvwSw1nl/cEUDdgu2JjdDLk20kK6YfgrVjg3/oRy7OAI
	ACMzPg0/CpsY/uAe4BZ5KwFmRyW575mBRaq7VAilv1in2X8+wJN/vPHl8FrLbAf5
	upmR6cXw/ezpSbIqW22rVTF5ckPZHCOphDN1DI4H63XP5sxupXs2dza5a8eh34PT
	XhNuHmP0BbJp0+gseRV8NOCtZHzwxlSsga2qelPd6koKFJNPCNCQ5L1WqWnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794018617; x=1794105017; bh=kfbQ9zlidwb3fEptM48omARg8RHgx/MLVA9
	9GcVZevU=; b=dC16vDj0mE6gVZrlcAyTq+Ptje0z3vsUTR73MrSMmcOPBDMDMPk
	jc7XP8spVpvQ2c8xHBFkTUP/VpCNBywXzsHn+XEt47nFdkHp8Eg1xg4j1iphPPQN
	/zgx/oMZBR3sZ14t/U3llF8+a+WIv2rRWaCP8qwVmO0cc6zbCCylgc/6cYhvyQ6R
	OTgLaQpfSjL1hZZetg2kdVt0AG3Ov0Pm5LPas2s/bs5+VnqbLcyYDCu/6aVkkwnJ
	6q8tWmRp6PWd9Uacfi3IAG9xYxQ8ElZB4D0DQHPrzGn4e25qNTIKT+PX/fG2B9T2
	9tU5Wx7FGUqCg5ED2fCFEbVhd+lveg1aANQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794018617; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IscwDm06BIx2cMQi2JehkgTOzdBboCwARtLSs1vFNwHoHbX
	672bI9CsRTb9qc7RqC5bXaN7GbZYryDtHLjdjvmhOtoKT0Pyjn/hhSC3c1J00m5r
	alLmMly9R8EJwfho8EZYRlQR1Ncn2M1UVq0e4o9hGZY9vsiZ0oiqDh1GT+N+5TSg
	O9x82lQ2lYiIHrerIYmEd+dJTae04xQfQpPqIzKTljMa7EMcDhdIIccj8Be4+oSK
	IBLMs2aEYfQL2iPoacfFGZDdTVPMDH4X23HRazrk42HwEj/wO3+E8m5oPmnKTHzC
	E5EPIJijgUlRyOE9n8q9A4OjJhtuzk50jC4JAmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oDEkW9AvwYxi3kO/NrWpGSrV/o15cngHA2+M7emH+k0=:p0eEP/WvfRmFc8q199PGHLGEujB8N0qh1a3zvRAIKno=;
X-ME-Sender: <xms:OY3uavcwA3vm5llsDV4KwUGbuFlwInsvCzYVcsVT0p7VtKUx-q30_A>
    <xme:OY3uanfH25LN_hYW5Wf5SCnlhJdH-seCSIBlFZc1sWqO9Z96P_HBST6Xp0VH_S2XZ
    T-qk8pb0i009-ngqdxuXghb1jlWxaWOmU191kPCIqrSJPqGVVw9cU8>
X-ME-Received: <xmr:OY3uaqyzwPvgguxSacsgwoPnMvlYxJB2TBAOn51hxh1dNkTddmghc21PEa8e7ZafhBmUEfRC_xi_ThC95K4vY1HBE34U-2reXEJq>
X-ME-Proxy-Cause: dmFkZTEvUXWp8m5qonGFUZqW6w5cSrysjxNtdqwaGc1RwjR2G3WU3yQUKDs9ttOfcmLWBN
    bpAZhw3S5E7xMNDeNlKWULkuZ6fugmWoVvAjuUK3gIwfabiqEQJKGShVagkf5wJ6xadX7i
    HLY1ViejRsQCJm7QDxgbJX1UqdYzVePA7gOXQUCvFS56o5wHJwr32A1Yn2TgoxyXLH2X4p
    9xo0T4f8PqhveaoSI/rBU2CyKaBYdAR6Tb/d39AQkEE9sKjVL6NKSwlOdIdFM/qlejouN/
    PrJDcK1gqrabd4rTMDj+Mf9LFCRvVZuiOp7q19O047WltP4qD7gYRsdOljkgYKavUa0aNa
    ct9BDkVdDJYMUtdOwPjBiTPiMDIZ1kKHUR/baZqD1LEM/79o3Lp0JtYoYneTrVV3f7TjGK
    FMoOOi0IuOa/i0j1wUdO10oTOIZzi8dOEff9seFEK9xLhQaq+XTQGB52ZzFVf4bpPINS4f
    5KJry5PvAS5xf1T11TARQ8gFizyBkOYIkY66oJkczC0e/aCr8gKlABpukk13Py98or2tuY
    aM9zYHXT+bV1Ch13XiKZ6adojCTAXk9yy9bf4yIdNe5QBswkqnBsiF/XfhMiMbx4P0JDGy
    apTw80gGdO2hCrsoD/NmPFiJDdPcmrelz+iurEg7hvqrNn0Fyp0tbsByGcrQ
X-ME-Proxy: <xmx:OY3uam92uKt4xT21GY8dSMssKoXYI9pWcsWKrsWZt3Khr4dK6WeafA>
    <xmx:OY3uaqj7-o88QAM6EmQl3WmoXCU8XHGrMsVHrEUi1DKL0wFbzyO1Wg>
    <xmx:OY3ualF2I82BVSg6hoa-9rI_0Kl3r2HNPPoVXi1bCWBEktOrJD59bg>
    <xmx:OY3uah-C7Pi3Z2GM_Pz3Fos06-fP1C6wxzvsF63nIp3_6RlAQrqixA>
    <xmx:OY3uatTZEQETTyQNm8Klht3adJuz3nwrEczRPJ6Cdjeq6z8yzJGU2hFE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 21:30:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] merge-blobs: stop using the_repository
In-Reply-To: <20261017105244.90295-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Sat, 17 Oct 2026 11:52:43 +0100")
References: <20261017105244.90295-1-okhuomonajayi54@gmail.com>
Date: Fri, 06 Nov 2026 18:30:15 -0800
Message-ID: <xmqqy0b59xvs.fsf@gitster.g>
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

> merge_blobs() already has the repository through istate.
> Pass it to fill_mmfile_blob() and use it when reading objects.
>
> Remove the USE_THE_REPOSITORY_VARIABLE definition and
> include the headers needed for the structure definitions.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  merge-blobs.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Even though I would have introduced a single repo variable instead
of dereferencing istate->repo number of times inside merge_blobs()
function, that probably falls into personal preference category, so
insignificant a difference that once code is written in one way, it
is not worth going in and rewrite into the other way.

Let's mark the topic as ready for 'next'.  Thanks.

> -		return odb_read_object(the_repository->objects, &our->object.oid,
> +		return odb_read_object(istate->repo->objects, &our->object.oid,
> -	if (fill_mmfile_blob(&f1, our) < 0)
> +	if (fill_mmfile_blob(istate->repo, &f1, our) < 0)
>  		goto out_no_mmfile;
> -	if (fill_mmfile_blob(&f2, their) < 0)
> +	if (fill_mmfile_blob(istate->repo, &f2, their) < 0)
> -		if (fill_mmfile_blob(&common, base) < 0)
> +		if (fill_mmfile_blob(istate->repo, &common, base) < 0)
