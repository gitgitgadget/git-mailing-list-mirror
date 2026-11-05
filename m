Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892030;
	b=ZPKMFXsJXHyjFisBRckwS+PkI5Of8WHYGS33g2f5wK4gkbr23C7OCL7ezQRdI75o7Cu5
	 H4CBDbP9Gcc6gR4k36KGLu2uRuvfLTbI7Gte4+sNxikB4IA4QJR2XMaIunl2tLVC88ESl
	 1to0hYEqcpt+rwtRZShKWEpLfgKdH7vfr9Rq4+7REcj0k33cUEw8lRS1gECCAXZNKDC+V
	 Q92gXPmUaujrFvcDMWdi2+VIyagJPUdu0fvXIwf7dMhG0yoPpgqxp0lVdpykkXEWqCp2+
	 kpdcQbEyERLxOJXY2VYD31OdbMkT0HcIJDtc28sBkTX75BWKlWDcraGNR63z4MIILkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892030;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NJcYxq4Ww7gVWHE5pOd9FUNsFzldeGQtmV6mst7mzbw=;
	b=K/bDD5Adx+8HC/GuLuNKuXHPZSskMqUZGn5wSYeHrq9PKKJ7/VliPP65InUUbV9D38pY
	 avm+WsftWwgk64YX7nsCWZEScph468GDBxRB5LM/2pN+rIyrOtCTdwGMOPUPl1sKPZdvs
	 MtknM9cOv9ukiDjBlWXGKrxqqKRNYkhGN3Xe3QH4fdcu6/96vNn4vf7ca1a9SMSKMxSFc
	 d347eulUBAYcCH9TkSyiXsiaNxgNRBhaAsV1AT+fHpdilDWh9mXpOfJpoY33k2IIhCahM
	 3+qtd1f0i1HTIK601RLVJji5j4VeArn/a9nNx3xJl3CZtBrg4YZu3REGp+Qi+gYvGGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Muijleql;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Ss+Eyxv;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE51606A333
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE51606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Muijleql;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Ss+Eyxv
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4B2714000BB
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:20:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 10:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793892023; x=1793978423; bh=NJcYxq4Ww7
	gVWHE5pOd9FUNsFzldeGQtmV6mst7mzbw=; b=MuijleqlBrE1fEYSvWs9SIsGe6
	b8aEZhGkZVyQy+DyfhSZ0OxS15YopQcJeXBTn1WvLiL0CV2m/pPLc0BqKWXYh3Z2
	DfObiMn+vs5159cnBJn6jAdZU0hszchmTVWNanw2vl6wfzX615G0sqNwjW2775za
	FxiOLCmsEgS5pnXJfB9KNskvtm8i0LbVQGFDXca/5OQ0J/OoHwI00EZqxzIoHY5w
	L/TIlu6BP4YxLJUqgaWcpN/9XKqXD3Vjdf+nG784N87mFX6DQht3OqK+KB0mj+ay
	sYIE3JpSxQjD1bHeeauFWdTl6mVdcE4ED7YnEO8VAGtEjokJKV9g34l4wHHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793892023; x=1793978423; bh=NJcYxq4Ww7gVWHE5pOd9FUNsFzldeGQtmV6
	mst7mzbw=; b=1Ss+Eyxv3S+y8WhUeRPXdllKi33twiOXz1teoV72ar4LT2RZQmd
	KyPfALFmSUqkZ/JOdii6ayRqJ/6WCg4H7FoRK+sSz3ZWrOHCABZC7Dtiyd8wXKc0
	VM77RpjoYT2RYEjsfzER3yYtvbf6OtRdqia5XpgGtZ91uAN+GZJAoFjzyPBSE3GF
	PbVIOqPQXLCVXZt9xbf/3VLrGHkLiURE6HnsejYB7epdy2+wBjdLuAeY6CuyaZLB
	Dqq7sT/Bi6cPZjZoTDi6KrgJVyOr4DNtcn4c219UaCmsJid1Lo6z1/W4hOb0RnkW
	yy7cYc6VxADQNbvSmK70bw+N93nxE+/9bdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793892023; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Nx1uq7h5wecfjxJNBl8BmeUMbVKR1YoO+FRCxfROQnYcvaT
	MzcO798/a15rCtlt2U/jzyaRnmbpEoIR7Ja62rDkYbLLsfDtudM/eYCOss2RVNge
	4HcL1XDSLZyvcblbhVhhoJFQ+Em+ubqk6UyufQDV0VFhsG0T1gbieNMviZQ7v5G5
	7MOJX1DIFJGUPwZTA6Q7AJqLDdJUOe2yjJ02edLC4FtKO1oVNDo4cK57vV+a7pA1
	XOHZOCl1unZu6XFzNd4tiM36j2yWVcn9qmMwoWsDpxm6fD44lYj+vyQ3QAhEeSZ+
	UcBxFGnXhEyvtgiOwD+sgucNxBNq3KX1aXBMQmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UGSFFdRz3+eGtfA/CgFPKvNvYeiftQzOIG30XETvNhw=:bTQAL8mG+GTutLpFItzMh0F0b++jvMo3qpt3ZNiMljs=;
X-ME-Sender: <xms:t57sahF-E1_EXeOqWxubfdND0--uyvzJLwSb07w0zmayquNDYFr5Eg>
    <xme:t57satPZaA8toGYQiBTKTszwsPtkLZxMligfo9PcaIn9VpODfLW22yr-Ip9ZnBu0T
    A68KDFQ-395MC_ayEUQcvRJBw_Kz59unXaMEdh3fijjJB5QFjKWTVkz>
X-ME-Received: <xmr:t57sarfj7i5A1sdpcNIF0jXxtJmIZc9eSBqsX7bPfJs82l5Lt_pPTyr_oOZF7wX6dZiQmimvvsxzu06qYqdOAXOzZ_7K2G00lMjl>
X-ME-Proxy-Cause: dmFkZTEY0Wd+a0dY0Zh88nhYiKJAP/MAOVEiQecJV+H3do5Q21N5tE0RfxtoE2gUIsFh+r
    1cUhok5XQic0OB36QdU0STmK1Xovt5yabS99eTqk4CYLvpvrFjYCHktN0f+Qn3v6wP4LGi
    SArYr90Rmozsdt4GjZrudNbZ23NASpVHh+ZjkGX1BtHVU4i1YZ5WawD/YIecGXqIh/2C0x
    pAcazQx97c4kp3OZK2EY9oX7nzFhjfr+GaAbtqurrldkjYXzAsJ0n/UmuuYiRgzP15vZEi
    I1zPJXAqB8/KRzcTRZKGB8zgdbhONqI4F2kIX3hbppMxRkTT89n4B/wWf7f9Yg7RS2IGss
    6l3t/fNi8L3KBl++HvBR0faF5IP78+vHzPM4Idvn+5rgiiiHXNZVUDAUMyNg/ASaNm/Jc6
    4Qt3p8KO6LJ2qko80FFfIEvtwwPfbGL6fgUMq6EZW729wr3Q/7ga2KdD+lnFWzE0H4N0C9
    5uXQWUhE6ZLArAg2dJSClfnrLZX7Nq/anch6k1R7RW7l5avcKlI+GvFTt2Cs4Sx7Nciu7I
    aqeYxoO01UgVvjbiV7jVuX4uTtvYwecXJtyneuH5j+roEZN3x2rG9nWQ2cTuXf8CJcPd8q
    dgK1GWY77Y1PH/m53RXagvK4WyHEJC5h7iFvDJxWZWV8q0GIJEiOh0ezwTEw
X-ME-Proxy: <xmx:t57saiuJosCt2gsda3xs2oWO8C0vNtfg6-maX0LcmNJVq4wl8OPFWg>
    <xmx:t57saknGKv_Q7ZVdxZrlizNTI2lQmlyV1E5-Bu3dgQ6SkEVwRpPp8g>
    <xmx:t57sasxcpDBuEnQr7oV-EiFwV-x_saXfSH-yqvaJHevu_WVWlObbag>
    <xmx:t57sauMSpCtom_FeanK5nXmN1dfPOeeec3lUhgt8SeqNJUHHZsz2lg>
    <xmx:t57sah_vzPKlJtH7zzrlAy01PcoVrKib5fmteig7DlKV1iw6mZTSQD46>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:20:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v6] submodule: use the submodule repository to
 abbreviate commits
In-Reply-To: <pull.2288.v6.git.1793821554097.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Wed, 04 Nov 2026 19:45:54
	+0000")
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v6.git.1793821554097.gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 07:20:21 -0800
Message-ID: <xmqqecczxq2y.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Range-diff vs v5:
>
>  1:  f94aa2476f ! 1:  01c3cc2573 submodule: use the submodule repository to abbreviate commits
>      @@ Commit message
>           Use the submodule repository when it is available, and fall back
>           to the repository from the diff options when it is not.
>       
>      -    The expected abbreviation for a submodule commit depends on the
>      -    repository's hash algorithm. Use test_oid_cache to provide the
>      -    expected value for each algorithm and remove the SHA1 prerequisite
>      -    so this test runs with both SHA-1 and SHA-256.
>      +    As the expected abbreviation depends on the hash algorithm used,
>      +    the test uses the test_oid mechanism to switch the expectation
>      +    between SHA-1 and SHA-256 repositories.
>       
>           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>

Very good.  The patch text was already good at v4 and hasn't changed
since then.

Let's queue and mark it as ready for 'next'.

Thanks.
