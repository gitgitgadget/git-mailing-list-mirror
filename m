Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918981;
	b=hWUzxaitJDRgF8fAA4ittJPgfIMcQX1F7hFuWI6LCy02FMLm9XxDe8vMov7kqUprB13r
	 MfDcd9hoIF1s+3+HrAFkCjr1wCfN5LkjzglraelRLkkbD4TXTHa75+eHCN5C1napO1RIZ
	 qWvxdV45y+hlm784QDq+tkFCbvydDWZHaB4LFMlCqE0LDKkLSw3cIOepmerSGwfEkUZ+9
	 ltlBYENX0IcGcVdQYfm6JjuRHj5Tl7z9J3eUsbjqNLr5izjCisYKVFGwSIIZ4WlkscQOi
	 SV99KLzQEk9mE91mvQclxTAkC9aJPtBfMXXsr9nHTCmaY22X1izhcOnX0kAfPdh07iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918981;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lD9y0WBqy4kkacEX88lNly7WXONGNNcb/+rWfpYiT+I=;
	b=5AxrCbggSEcJ66gB5oM7KBl0uEC939lNV8bzcY1vfxXC+sqQpZE6rvxVedTxEhOUBWs+
	 Yfpp/SsBcwJl6QiIE23pdpn3Uyr0oCnNhkWb0YVEC3d7h7F2+6D94qij8ey2Ijm2uO4EP
	 xQPBvAfkG7/wzbR0V8OtYB/afQ2nadQgY4ckUC1baF7ULYaWU9BqSoNeB8uKU4kUada2S
	 787lVTRmTIWPXzRxum9tks5gQBKHoKhiJN/9fzoZjWJVAjsJZnaCfrE1NGVWFVlJvc8xU
	 nrWohgMW5LHI+I8ktiUKJC8W7cI9m052LDdEiJL9wB7X9HeM971DJSCRGUSoemuLgqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NICTAF6l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SlNyBbSr;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571F606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0571F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NICTAF6l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SlNyBbSr
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 33D0314000EB
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:49:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 05 Nov 2026 17:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793918980; x=1794005380; bh=lD9y0WBqy4
	kkacEX88lNly7WXONGNNcb/+rWfpYiT+I=; b=NICTAF6lQ4z5C+hFYdJEcY+/Q8
	k3birzdS6ua53LPjU5iq4815sDr71Y8xblfazu5EiIS+810uSl9Ro84gwzlydVEQ
	zCWH6kQlOcNKCSuVSo8xXFpLzbbhnWwCA/1Y8MSiKPM/bO8BxWtoHxQ31Itj4KL9
	yPs/fzGimzrGBe17oSaFblk2TVW74uxkVWGJyP46lOPbIOzY26hxg+OAaSBrDNrH
	0/lCwFD55EddNjNrWNB6hEMKeKTvhD/yBq2Bog28D7RZ78iSd+puauu3CDLYgUzV
	Jb+3j5RO+/3Uh1KmrmczJAQXCrwZst3Nz3XKi959xh+fypgCqNtDZIMR7PZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793918980; x=1794005380; bh=lD9y0WBqy4kkacEX88lNly7WXONGNNcb/+r
	WfpYiT+I=; b=SlNyBbSr/KJpBTKcoI1nYuGp/3PRuF7s9/u16xu+NdVRo4iqtVC
	XrdJ1tWfnCv1VPAwfCDCC9OHWVhwSW4NCim6Sob9g6LeY3gkvGrzgV6oo4h6N9ng
	UdIV1NStwlNkcEm5/z+Q4MwKlRqnq4Zv/JTdVxFIiwBCntVXNdiR0AvCzerY12zh
	GjleY0YDBU1VFxLbt7FgfbqTQ3/YFrERt1PP9iPNrD5OhiNZWwAJ2bmRA0Vtfbwt
	BWtEqsgRWzeLsTVPrYYR9G2TdD5ridlkhJUmYaOU88i1H0SCcevgC3svhZIyAhqc
	wTy59XPtt/Qpf/Y/bS06IQE4gAZJ1CFlK2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793918980; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NLNs/0efE/MtaiBWKf6a4drz17vDimjQpcnXFT9w4zYmd5H
	4kWYrCKpcqMKlfQJCvQukX/I5+3cnTRGfgSxAqlPjZsRHdLLg66Qu9LQS3LmQbNg
	GZPDSq8UeskvPWJ33GYDv0oJnirG5Jgdzk62O0JakA3EL7ZUvZ17UGZj8777sxvA
	Fvwd1Y3uCxfWutVF6UJW+ZKvPvihS780UkKYLDK47FXp4WtNG3CcJGHgmitAzmqq
	N9ijKWdnsPn4oaVOxv4xe9bEDR4qpXwkkDXKf+Y4Ez57oxYVLcRnFqmRwzWbCD7D
	YMDDqOFJh6Y1uonWnfcq4t3qMqerWsiObVLUBAg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:c5WdUrL1eW9l5i1u+vY+xhSvu7hRNtoFShbvFe3DdOY=:8Bmn39NZFUQXB0T58Mgx68uLirfjHM9RMgG85hgTjd0=;
X-ME-Sender: <xms:BAjtal9zwJJkChrAkR4CtzoRuEh6POFYKOePKaPhMQehJWJUFyRrPw>
    <xme:BAjtahJx_tIIBu6PS3Q5Atr9UUpio3gccjMyyuNDZwv53d1RCMZ1GrCshVm03bsoi
    _7sYWKJxhsBX97rOjn3Su9LRRjPztVADZhrqKC6vGQ1QEvddZvM_eI>
X-ME-Received: <xmr:BAjtagZZAn3gzd38B1ox7l9oSG1KvD_oTnsx0AIc3s-yCMgH0-RuXmsFkwNzSQtvblYJxDYX5Bczil1NwQRY3ggXNaOIOiYt2Y0Y>
X-ME-Proxy-Cause: dmFkZTEt0jINh/AgyK49edBh0d3AN8nxulsrOLOtu60lcgVI+xm6uW1k+3ASZ5XpqMxiwc
    RXewS3nn00SbO4ibtPkPSlzwnj3/vHni6sAljX1Sopekst3WroIMtj0wG1MBNkbCUkaysd
    5zAlwr7baaGLx8Xr2dIYeRjfVfhKSeZbt8fzQ2otSayC6KXgPwLgKUGHD3sMJX/m8oXuPZ
    fhd96dF0nXH8Ue60C/Pdw6cwvANzga8g4q2l66nQILr/nnu1slY3lXYTED0NZLUfjxhZu+
    U3aK76S3txo7w/HmCxit7QQh9DFzXPqH/bhtgUilj0g04YCyb8ekcYsL9LUbH7kNLTUqVw
    D5jNwKNpUSOE3XvVbJKH7hO3zChKqlMTghCZrfXw4YCTM5fKe4SCEiNm7CO5SLivzaDwtc
    1R0Qfep4bmhnE8nLYbqt3gAYp/psKKVp7+tiiLyOBLPvHmO1akZeqAGhmFHUBg9fr/s+8O
    1T6gU3DUO/5J8vu2Nqg76qoZZnO/akoQKRNBxFyP55tyTOQ84+wp/Av5WcB28aTQQDzQRR
    a3r14AjJItasfJELH4G11e56rDyWZRjEwcQPm0Glv56kcoX5WVPr4GSdjzvZ7ZzFnf+dXu
    7wadmZzd5S/AEf2G8//nktbJPdaK1Pqx8TegxopBqxGZajHDZuIv+D8fExVw
X-ME-Proxy: <xmx:BAjtajLPTYRdgpjQhYdQD6PYH_K2733rgz5j6dw0r6_tiSI3wmJAJw>
    <xmx:BAjtauCfwQU871PMDJLtQAxLJM_FBK5gwSVk4vYfxHF_xcxWZjU8WQ>
    <xmx:BAjtaorTJRYaGAR4OoEO_XZ8K7sSzkXBsydCezHpcTDi30BaYcSmbQ>
    <xmx:BAjtapgXNIeiNqXigmdMNREwgsIgXensDWOsnHRCTtQ1xx_B8xXpCQ>
    <xmx:BAjtakzLlGcEwgwn-lIbV0HbGs3fh9OnqUtZzsd7ml9BoGYWoK8IVSSh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 17:49:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 12/12] remote: use strmap for apply_push_cas()
In-Reply-To: <20261014031347.50433-13-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:47 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-13-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 14:49:38 -0800
Message-ID: <xmqqik2aq4fx.fsf@gitster.g>
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

Jon Simons <jon@jonsimons.org> writes:

> Optimize apply_push_cas() by replacing a linear traversal of all
> advertised remote refs with strmap lookups.
>
> Before this change, applying N explicit --force-with-lease entries
> to M remote advertised refs entails O(N * M) calls to refname_match()
> in apply_one_cas().
>
> After this change, we build a strmap of remote refs O(M), and use it
> for O(N * rules) lookups of the lease entry refnames.

OK.  We may be checking multiple target refs, and we may be checking
with multiple cas rules, but the order of check does not matter, so
we do not have to be linearly scanning the remote_refs list at all.

> The refnames are resolved by issuing one strmap lookup for each
> candidate rules pattern generated with expand_ref_prefix(), as
> with earlier strmap conversions.

That trick is clever and apparently very effective ...

> p5516 timings show the speedup:
>
>   Test                        HEAD~1            HEAD
>   --------------------------------------------------------------------
>   5516.16: empty:lease:1      0.13(0.07+0.10)   0.14(0.08+0.11) +7.7%
>   5516.19: empty:lease:10     0.16(0.10+0.10)   0.14(0.08+0.11) -12.5%
>   5516.22: empty:lease:100    0.45(0.39+0.10)   0.16(0.09+0.11) -64.4%
>   5516.25: mirror:lease:1     0.16(0.09+0.11)   0.17(0.10+0.12) +6.3%
>   5516.28: mirror:lease:10    0.19(0.12+0.10)   0.17(0.10+0.11) -10.5%
>   5516.31: mirror:lease:100   0.49(0.42+0.12)   0.19(0.11+0.12) -61.2%

... which is very nice.

Thanks.
