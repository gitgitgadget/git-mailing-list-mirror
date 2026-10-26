Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038256;
	b=C3ID1zqKrApzupcR51YzECIJt4MYENTyscyG2GAUnJzP6VqlNSpJMLWP4muvRV4tPc5B
	 WFwzYVGw/tnSDYigQ85lJR4uMnWvBvCqjzlk1+/JC6pc54w/S3VrLqelbrMBI6pCoq/G1
	 8ia2qDcRgDPPE59HFhDebF1dK05O0vAcxrj7vayzVO2AlvP5MSUujikQ3FCnQMuS/kbmS
	 tjwe4cpqQtjI6xtSlLhmX8dFLNhvo46geY5g4qJJa1PgNJoUxuohRI1P6nD3rEpVfGWmM
	 CTuyxxgyBVxYJfKCx2i9Goj4jOAvjLO0+kO/VOhNEetjRbE4TrMcpS8EYpv28q8YoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038256;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8VXQTO2keDcq8R2DPWLkqn7vkp6hAxpz818o/tASljs=;
	b=HHd3wgXWVMSkcQZYueG5gwXWcb7ISowM3KESgfyAWMnNhxjYma/JHV4W5y09n+RXabSa
	 +8fBDO4KM+kraCT8/5oUuD3E6UzpaZXE3kHHddZ7s3+BR+faY6a1Y1xxZ9samH/kLNLPF
	 V5JiIe2dTT9snZ1ua5RbqyRuBXPysQ6DvG4eMwedDx0f1R2CL+o+VQBUs4aHP/D2DXNqg
	 DugLV5sHJnmTPSIV8TRZ0jOZEsa0jwnjgybhuiVgsL4eDAUaL0jQeBRkz55naTL6RPCH8
	 qkpPsMxCK1pR6d4IoZY3WuPvtWqZe7eVfb4JwQIPjEmlbXVO1ZI3oMlOp/j2ieqVblg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DPdqncEG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="vYntx/gp";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA62E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DPdqncEG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vYntx/gp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D724EC0AD4
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:10:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 14:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793038254; x=1793124654; bh=8VXQTO2keD
	cq8R2DPWLkqn7vkp6hAxpz818o/tASljs=; b=DPdqncEGmpMwljGTX/yuWzx2gP
	acM7dTWusiegcb4WVYbwKMwpXgF7N6+CpW7AHauhmauWDFXpypK92U6AIqd4lXWa
	DgI0RmKNlFreRVczXnr1PEWyqjmFV38ppdXjpua5zvKEmqNgggxOcixW71S0w48d
	14aU/zRsdh0Hem9Ar+snHHMLvHbNK/j9H9fP/PgjgF7s6Zd7+whGoAT8X9dUlnQy
	naDo8bMrra2MK426SBFxUQ++CjU2iUxxEcRDxE+18ZaEv1ZeQYydb3JNyfgzEqaw
	R63IybVL1fbxAhamdfJOK9VvrdF+hjq8GjW04AD1WDFYCwwU/jqfuTdSDvrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793038254; x=1793124654; bh=8VXQTO2keDcq8R2DPWLkqn7vkp6hAxpz818
	o/tASljs=; b=vYntx/gpgvI5zWNTepcmNdNHJIFTqlpuTNIhMO411qZblEs/rXE
	5FVr8PolsJXwqAk5g36FG+R2apSdkIjyQi4mJ2KVH2SENiM3eKB5+TN4rwfMhwTR
	IgzlJKz8NQc9QI/fTRRAv0K7KpOFaOmDuB6dEfjzJokieoUkaY5mHuASMtPEqDtK
	HfimmYz2QiMu7yjvQKccSjTY/pjtE0pQ/w5pSHCy9cGetbHe6bm1n1hXM22sfp+b
	yZg49R3mzPnysWF/mGAO6vMfEjLENQfWSzGteWDPiXlEsDMDWImUiDNtzGuTaJID
	HnXxKyUaCMBktmtEFhIPCsHzpcjdpzYusrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793038254; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MUC1HLWYco5Pq4g9G4sLHKmrqd7buaJTxJnrPRtlk6wRWui
	SuSP5+z+oRTv3YrinKs4J/4f7dDaRmkshkRC0INtM8jqilq9LJ392zxRES9es6YD
	C+rpgFVysR2cwApBUunRyOzT09hJlxEeOVwZXNtDFPpUKh2ynfpuD+HVBoMNOMNW
	w8UqzLxi0I9nFmPX1KACBulGQ99qUFXGOG22YFAAU7Nph652iJeYgXIx3LKMjz48
	l/MTQgs6gcZFVd+fYyHkgSBI/DyJ7u1T0+iU3SJ36kGrza6uct07eg+Ahb4PGLV5
	YiOfSriFbeQmIXNJVgOoSUPE60EAODgasZpHkOQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lzFDG85loVuv/UL2xPHomBUdyEbZFXOoOi/1sx4i+dg=:ISjOCoRaI8oJL3I8d/gSDh1Jmh9mn8usZOKGVYZwfFw=;
X-ME-Sender: <xms:rpffagK0WKl7Y8NLT1TCaYbgx9WjF-5AjkbiWjl-F-gFHnuUpIimEg>
    <xme:rpffaiZ1JHl1BjDfquvBaTT47tgVL9YWKVmUgC1NyRal_j7Azim896jICEiEL83cM
    22DCKJL1fXtVy9lkFk3xaS3ydZ9nYU-ilyW8RQqMeNKexW7KDqKbw0>
X-ME-Received: <xmr:rpffai_hETSpJf6A8vRQMeEmpdMUyBHPXDROaG7K0QNorAzwdDjlh927KKjtkgiIDPN0gQD331APy6qxEPB8_nHrzWCrMFtdmbi3>
X-ME-Proxy-Cause: dmFkZTFa+u3JoJ0kRZAzzNvBKbk9usJND2UiSRITcFofcfV3ijgBbAPIx7fbzN5thlY/Yo
    B8u4Aa6iIEDa9PlRC5XSfKz3SnVj+8jlMLyiW0Gj3R4ueFoBbvBPw6SNO7cDk+PR8EQJN3
    DeTNp8hB/Eq3DdxIaFQ+xBCCtBHmGk4fzMCGE3EGefB3pFvRvWH+X4RCy/Ph40SNU7+c5n
    L1wMy2+M93MDnScSMozNwtB8IZTeNRpJC880unxP4FRO5M30CUInxMda8ujpYyjmkyjK1S
    417eZCSOnBKARmpMy8tY+6InL5wyk9YCmBdaHVj1hZZyRuGEpcP4/n4Cjm2mllf57PUFkF
    sMknFODSR05572GYPEu4lVwMaotN5sCoD8W0/6+N49MHBAUanZxAPfEziLnPw1dIXn0cNb
    XR7TfrBk5xZDD/LSLZ1MiPgLNmG/7BIh/UVPMg8ejI7JA1hf45dOu4g0aBNR2p0G2LdzK4
    nsGDY8wPI3UO+J61gNGxL6mWT0rDobAhj0n+rHeUiAL+TZkgVBQpdr9nHG7so0SM11vQ2O
    V3o6O00KYuQYFlWcX3Ta/myeehVurqbAr6bolvKaTcgLHI2fLUeCbnQ1exH7sO3RxAXJ5r
    GhmbN4okOVn14Wn3S7buQIHxmQwDaWRIwxPCNe1AcBaLaRO3M7tg/8RYjmRA
X-ME-Proxy: <xmx:rpffajaJ8COBlvurSPNRZJ0BWcND0KzlL4hVYPYDOFH1akJF7rRgXw>
    <xmx:rpffamPELQIKohvTecBLoOcfXr_oQRS-BgsgwCjD8WiYrkaS8PcGQw>
    <xmx:rpffavDvfkPOyGvtprFMPrcNjCv3vVlch1C36OjbEW9ItPzUdS9wVw>
    <xmx:rpffatIkuI3SrtJK2p_VvaH17TQFgB547muA7O8oeeiPM_XwLMCqgg>
    <xmx:rpffajPw6lNfuvNVBhrrLbysoOThU0-3IQ0R0LL2IJMlBxKgIdb4ocsc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 14:10:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] diffcore-break: remove
 USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <20261014114904.85300-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Wed, 14 Oct 2026 12:49:04 +0100")
References: <20261014081209.61966-1-okhuomonajayi54@gmail.com>
	<20261014114904.85300-1-okhuomonajayi54@gmail.com>
Date: Mon, 26 Oct 2026 11:10:53 -0700
Message-ID: <xmqqbj8gqqmq.fsf@gitster.g>
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

> Since 84325f0730 (merge,diff: remove the_repository check before
> prefetching blobs, 2026-02-21), diffcore-break.c no longer references
> the_repository, so it does not need USE_THE_REPOSITORY_VARIABLE.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v1:
> - Removed the last paragraph of the commit message, as suggested by
>   Usman. No code was changed.

Thanks for writing and reviewing.  Will queue.

>
>  diffcore-break.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/diffcore-break.c b/diffcore-break.c
> index b5bcc956cc..71d0e48beb 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -2,8 +2,6 @@
>   * Copyright (C) 2005 Junio C Hamano
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "diffcore.h"
>  #include "hash.h"
