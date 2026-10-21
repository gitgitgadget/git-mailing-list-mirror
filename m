Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561010;
	b=1ULqcf0H8gd0wfVOB+xzW4iN5NIcLlgerp33zcu2XWbyAd22OsJyIdTnrJsTyifG8L3K
	 Yx3jOAnkEk5y9sxds8uGJbwZsK/xEMOkngqZ/WtWleJEcXOC73tPNBbt6dDnRedY+c2pR
	 69lDrS1bMIvlaobu/cUvUFPjmB/XiREtR8sI68w+BwEbalJgw2fm9VVOrXN1QqcIjvcHq
	 V7QJruxsA02NBKLSIkJ04uI3Z3UzBTehO3tgj5wdaz5TF/QI1bOrjYcr9y3+tvASg0aen
	 jQnbIG4WxQpCu4s5wbC3b4D1RpHLEXCNfPD8JoFEl7E5Ga/oNjO03IWQxwoz8tL3HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HIF/wRwDRUuUETEhKrOpueGfp4N8vMEsFzn+IMYYjo8=;
	b=OUo6DjMVr4J52/HwmayLv8vIC2XoTXOOyihIN21gCs0K5RWjM46g2GJ09R87SOr22n/7
	 zZOvGftRhdwbmW+wvBsZL2AHbqz0qkLi42MMpPTSmShtGeAaLcHi4SPI0aeRbZjhU5ft1
	 1qj+jjUqRqcOminPtpXqS56btos8y3znZHtwe6QpszInsAMB2rjd8D774nnPlzjR7IA2F
	 /tkqQ70UwHaLCKD/6nM3KLXm3KOvbzDxHA+goAI4YpEVIgad9VCQN8A2bWBePmUis29Bc
	 tkbFsWayTtV+8442w62AZ9ezJUGD6nUi09s4SYGO0ZonzuFGyBuvpTPXoqk59g3tYuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=MXUNIORL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H8v5lPsq;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50F606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E50F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=MXUNIORL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=H8v5lPsq
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id C40AB1D0007A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:36:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 21 Oct 2026 01:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792561008; x=1792647408; bh=HIF/wRwDRU
	uUETEhKrOpueGfp4N8vMEsFzn+IMYYjo8=; b=MXUNIORLfReKYCHAjygkNDgeKN
	94wcTJZVN1Fu1klHdjImZubPl5Zq3T8dycVpYfzDlrjn/DAC3wDNTM3TS3O9tDfs
	BjlRD1VkQzktsTYQ9zMgFx2ZW4QgBIrgshNjGdAcPYGX+DvK5NpWvDK2Zr4Riw9w
	eYjUbjVXg0XKImLeGeH0Shb+kgy1Wccg0PDvE+JVy0JCVSAHZQn2xIZrM5LOAtze
	x6nnXh/nT/m9PTlHryKLA7PT4FmkoNkjqWjyoLMzAoxgHcffFxHNkW+1ysy/SHT4
	7Kys0jn0/fJgvNjrbew2Zrzx14xWo3CB16vjQ1ezi6qszFXdTxn9HO7Gp5rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792561008; x=1792647408; bh=HIF/wRwDRUuUETEhKrOpueGfp4N8vMEsFzn
	+IMYYjo8=; b=H8v5lPsqdTBu+33PTgQ6Q4BcbyU+NT2hlJV+B5xMLvX9U/r0cdt
	3NT6so/nyl1k2ne+ezQJxxIbQc6817Gcd6+KvxXjHZmMOHTgmZ2N45Ky1/KINsiM
	+s1NSPGA7twGW+neJLQysxSKBwk/pnEsXwMD9zGX6f7xguSIv887biNh9vlMX0VX
	0Nt+xRQ3i5yvwQXaRVsFNwLHDbtzwZjDAxDmefj2EKv7l/IkA/JJqUt9Jr0tkxZ5
	dm798pQq9r8uJh/htOwwEO6d380FtfNGHFVG/DKRMGfuxcfn95+EfIfA72O9zkpy
	wKiUNN4zWChQ4aiyLJ94XQUpXPWLPlUUg6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561008; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jbBCwUREpQ0zC9uX5PX0gTvu20Bl8L1HFVkA2IsJoA7hFaf
	KrKc8wr3uJcGySgRv4i5yngI9tnHSr5hkBVWV+FW33Mqcep4BJhGhPiFWHNzxaCF
	bA/yUTG1tHr8vS7huEFMc+QNIvSCTMHH+enbopfLP+geeLpg+Ko6hPpdrYEGoX2m
	sfBwud1iDS9zuZOtkogI3ZJwnYcZEsiYb0igBTY4f6tKYf/U+RAJePve5f0FJZgx
	f9wkGtWKDATFsGQDzOxwcMUGXXLqxDpf17zYFoQt9KSKHOkUPJexKeFDJA+YyfD5
	dyLxi1WhMT+mcy+WrYrnJR82IX1CnIPnx/vUyYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:K0ZzVXb9dRs0rxMSmYgoOPvvMz4pIAli05jHI04c5rQ=:W5ehDKODADp2IlR+mjRPUxlx6BNeihSrLeNCujpbH74=;
X-ME-Sender: <xms:b0_YagrqhpArVdI1h-jFkaBphTTzChitD72fTUt2QYIKXn08Iszq1w>
    <xme:b0_YatpiHZD-uksM6mLj_PbXK0Ohu_y9OpBTwCpUY9VE4f7Q5vDrFTB3U9AW7B9sB
    UqN7g9xIPUNZLkWBsiE-KTND5Ch6zQZGVoZUYVU5ymodGzHM1qv-X0>
X-ME-Received: <xmr:b0_YaqMANV6OBk7Q63UfDohCBgq5dT7T-jiLjQQxxHNG1D22v-yXcQ>
X-ME-Proxy-Cause: dmFkZTFUDK2RFOIVqeAtgsP9w3t9ie4v4+lZ0iI+lLCBVniRBRk7WiaQt9/TpmVe5H41FH
    SJvA8akt6zWEeVLPErTacW1u/EER39sk0NdX5mpJSLq9gXHPfZs/UFCA8vUF/fHnAT1zk5
    OBPCXjrxqi0/CVg8yAda3gIRXbh2HNbo7R6PzEcg7juUEA/4Cz2UqQNxC09cY21+v7STfe
    Vv8i9WsHzFJnzdT4vceuq65X1X6hyGc4FMu1LYbU9SI04dj1lzkfgq8iiHbz9JVba/72XP
    fKZDWRzeNyI8/T4+9AFBTkGzaIQufsco4qgXF85Zll5Yo8R9zQxn5PVrL1oJpe99SRSBry
    eEWOBrAxKNMTn4Gsm8nOTNEW14JCW0gEmon/lMoKnHhxvWoHhS6oeQEz7Eg078/UsnSx32
    57JIcPvVTBYAwdAJ5S5VtAULn311qPrk5EiItclx5y8nHVWj5rZajMuHopZs6ZqG+i5ew9
    PkGPtpXPBu2G4jwfnaUPsR8VR2cXIwSoZEcM0w8uSdLqcwW5mWL4y0nz0fi+3SfxIzFkcq
    n7RaLLokQlIH5sA/cF1FDPLa1+xWBCSgs0Tqper1WYzFryMazug7YzygKKJKXCL/kqGk/L
    y/1Dt94vd6B96kZ0kB7vRlO0zs3P9bVaOnu+7RfVgTPwmkIVzOfI5F33WLgQ
X-ME-Proxy: <xmx:b0_YamzFh4QyHCz-sPi4x-cDPTLfoCWXhJH3q4oeijsuvDAkiKNbcA>
    <xmx:cE_YartM_73kORZvoK2Tyk5g2gzyAGm1bT5VytzNx9a4sdSZ2Tgd5A>
    <xmx:cE_Yan77nXl4-MUrVZDVBmjWlkc30vvgD8rFuQdN2klGrhGNRrMBxA>
    <xmx:cE_YaiRcSlwnkWPM9abBMMoVem2-he3oiwHe0owktrgXbvRk3LKIfQ>
    <xmx:cE_YapswX-AYpijUA92y-Y5z8WPYy2M7NUEzWUGV_EhoD-0tg_g_BHNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:36:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab9d976f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:36:43 +0000 (UTC)
Date: Wed, 21 Oct 2026 07:36:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andy Koppe <andy.koppe@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] refs/files: keep root refs out of loose ref cache
Message-ID: <athPaILS_RqqMUap@pks.im>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <20261019203427.2637569-1-andy.koppe@gmail.com>
 <atcNOMxaz2WxDIA1@pks.im>
 <xmqqik2vss86.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik2vss86.fsf@gitster.g>

On Tue, Oct 20, 2026 at 07:27:37PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Changes from v2:
> >> - Drop fixes to documentation of REFS_FOR_EACH_INCLUDE_ROOT_REFS and
> >>   --include-root-refs added in v2. I'll create a separate patch with
> >>   those as well as other fixes for outdated uses of "pseudoref".
> >> 
> >> The range diff shows the changes from v1, because they're of more
> >> interest than dropping the documentation changes I'd added in v2.
> >
> > Thanks for this. By the way, I would recommend to have a look at b4,
> > which handles all of the bookkeeping for you.
> 
> Perhaps it cuts both ways.  Can you tell b4 to do the flexible thing
> the author did in this case?

No, it's more restricted in this case. But mistakes like this wouldn't
happen anymore if one were to use it right from the start, so it would
not even have been necessary to have the flexibility :)

Patrick
