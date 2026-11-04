Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807794;
	b=R8QV9/gqCoAq7KwGZ73WPG5jOSOAK8Gz5kpnNpmhR69lNNzHGn7gqrmKWhwS7UV9uokc
	 O1r6DBZJJX20meHBTra5kgLSjSNDx7dy4T9oGwrgCDlM/2UlL22fMxCgfBFHjuPvZ6aRE
	 4LKgvse0sNrzT2YKCFnAhEZBL3U2qPhI5WPezNPPWYX4aFy9+vs11A9vje0LDgJ22b1rB
	 A2F9yyAvDNK4ILvA2Kry/W9p/caJmuCWJdq20OLHtE10BIimTTBox9hAcUMpGpVaWYJy1
	 zQAN6QiCUtV0NAHhoPKZH3OGeyjJ9Xs/iLmQF4itI2kFyvmYXI2ebxbaGrsH1jxbcBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807794;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3JRQcnq4Rn2WLFjdxc28Aalrbt2I9KfqJWg/Ol75iSc=;
	b=pGxqOlRKEmPqfHaguE3Tkw7LsldGXZjjX7SCdMsypxOt7rUEWEQ75AYMKlOYV17bCBGr
	 8mrbL0EXHsWcz+/Q/HPtSVkoC1zLIWCoVHmDg8lj23dvbEUmSkSw+AG63nFKj0dwIduxD
	 n2U0rmRh7VL/4MfDhJ0gszxap1zCPGUImkOA2GAypF/sngM7pkgrbagqgPnJ6ls2By2/2
	 YmmgCBIanIZRbc72WiECfkkfozYVkp2yHa7btLO4987A2fEdBXKXiOy3ltNbQHrZd/bFM
	 SDyylG8/KN83tkbzG2VuHweQQigeoHqXwlDFJoCCbbzn05hzL9ceRaw/j15G0S/HTxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="aS2gb/A7";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=is9JbUb5;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA54606A328
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA54606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=aS2gb/A7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=is9JbUb5
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D47EC1400080
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:56:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 10:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793807791; x=1793894191; bh=3JRQcnq4Rn
	2WLFjdxc28Aalrbt2I9KfqJWg/Ol75iSc=; b=aS2gb/A7lx+re+uKJman9olZkl
	d0mCzBojUoV1S01OHtHkQ5/Xuo9BcXmhfEh/aZMr8gem0LJ/yWGsg9+Ze9J+nZM3
	GQF+tcd3u/2Wy9fsjxvNHHwVCa8oNyRMgoQWuEc+ETAq+PHLNYT3LWBzxFUkuLrQ
	kj6GAFgmAZ3RCXZYeIubLCw/8UwmuCfn8RTiYxSo+lDRYSvGFKGVOq29asq99Z2I
	wIvU5XOMFxZUIR3Xl29i2nXDky3WB+NBWBkvdLVP+2hZLSmmmT9Cq8cUpfhE3Vye
	9VUFV9ggo3TqPqrsTkdDghRcvKdp35kBGK30bp0fMLeKYQ2dqhL11YYPAtIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793807791; x=1793894191; bh=3JRQcnq4Rn2WLFjdxc28Aalrbt2I9KfqJWg
	/Ol75iSc=; b=is9JbUb5g+kIkvn4bnKb/XuTSMpVHn3OFFQH4xU4fnnshO3tabe
	dDaUoM7GAnY8m0e4k7v24rmiTBx8FNivzLPp4w6eJksNFvZdo/rr/6HAqMFp5+np
	7HR75ZG9OplH/G1jBdRfG+hPtxV5+DWF9LHABS/h3m5OXxt9FYfLkAQ5Ohmz+JbO
	iLcObVF+Y9gKs8KX1u+LrgOnulrxVdL1d6LkfqB1yQU4X9O7SWY6daLP12KrheJk
	5utwf5IrUoca1iIOiD/IlINWZUAbzp1Xa0RPODgF50udHHzBbAWSMvcU7pTPvf6i
	YMl3XEArV7KBGuFgqSdwQPQ0ZXVH4Sk57rA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807791; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:r9ECBLkd3xFZX1niNNJ2heV/5EuA2q/Hrp/WHXpEXorC2I/
	+iWmxGKqFw5m7ZP1XVxC8NTTqPX4J4pA35SHIXLYT2x5UAukrEKRUswtJxo+GbfY
	3hZRvU1ZTQvYUOJy7pmQv7noZFs92u/vtKDYPNxY/kfR89N+m3KgFc+1LES/veCp
	jaIXu0OMu4qUj0zeBdOsMVsGm1JUyPYuCFL2C1sHRL/kQAZgeLsdOjG2BvPgq4pw
	Xal92ifDIUm6g0YFXroy/Kv+g5D6fU6YdLONycZDON9CE6fnGKtt7GmiXEXzlW82
	NJ7sDhrR07s8DvEcVZ0+oVMMZPF+v4AKK61S2Dg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pXVSqBG70asUQqSx9Xi5x4nCZhvOfMKYUBgDW4Ov8Zc=:IzKUwXAb5ts0alTKbSCesSeaNJx5ctx/xs5PgU4xk2U=;
X-ME-Sender: <xms:r1XrapRG5ogp5EI5D96wzD0_adJbwAejIa4tfPZFnhQ_3pEy1nGztQ>
    <xme:r1XraoykeG61rKWfjTkan1Uffh4eG0fTx7L8RIGrtM2lNcGABi5oTLTrFgRsmDw1K
    Iihd2NpE0Jbkx0YcEczctHkWDn4e57ANZCplBzk9qk-E13TTYLAWA>
X-ME-Received: <xmr:r1XrasfNjLqgXFkOxVBEubKmVfSCh8xKwl1s6zzX2_1TxjnuMMx6V4HkUXYDvaCF6hCkqz8>
X-ME-Proxy-Cause: dmFkZTFAEe+Zl/n9SjsNrWUzSYE111bbXmbK2xcB5Eu0VW2ndKIuBEVMmlupci1sQjfngE
    E2vFDOck4OyDYj1T7MlID526lYLauw8draETLEqwC+Fw0A5B3JRwHldDLd3lusyn2DA/DS
    WaMf7cAHqog/pfk+kuU87/4Ia8+p/CEzkl4eUi6CDkHlEXa5PXPpaV1QX17Q5I8vR9j23V
    OZ/yRnNDExUPyquCbozinVNBYFY9/eC4ROjzgH8ifSnRT5425L5uorhNiJFfguQeMOVTuF
    Olfv3rsJFMydXgolVEZFkerKLSSOe1Qc+jQECUf6VGJO4M/jI1XtVzdrX5JomGP4Yglcbw
    Pz+qK5oSijn5pYqGlpGMI2Dwk+dERq3Ctu0uqIzeFxruNNWOb3g4WUWsVT8QhZBe9cMogH
    A3p8jFrkT2f/SRwOAE4wjSNaPAo6EBNF1oAOjvuhrMNk1b8vScmv6AQGqG99OtNIdntEtu
    nx6Fi36CyvfBv6+nXCWptPHnVP+/g8Wx43BX/G3w9w1I3IAEyVYh8BVRVqFChtrEf7Tbuu
    pXMPJwWUyk36XBgj7iuySAqe/Z/Qzb95f2A5oPO83Wp2Hd4U33bY8S8r7u09+YNAZgy2Nv
    tJcWPcm2nJ94l/Jwz/unsNJTqNMjqn+tteyOxcbHdxTWw0Mqh9DNKZBg51XA
X-ME-Proxy: <xmx:r1XrasKwIlw3mLHO96IirNRcGemgx-gWWcT6Qc8Ge8pPgal5lHAlDQ>
    <xmx:r1XralEMMn6TaPZTGMqd5i1QPg0uePpXV0Sbqx_6fg69pRgWbQAAvQ>
    <xmx:r1Xraurvo-jOvXrcnLeFVXtyMdA70vB3WvziF_HCbLYhMGdGPK_qFw>
    <xmx:r1XramQVpkqzPqo9MalYusAO6eYbAck31L2OnNBBpji4qBwl4_c5JQ>
    <xmx:r1XranvTB4ESW9UH0bhshUWd3KXmB1-F5x7vzELsqS3Xlk7rvxguR8Z->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 10:56:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21cdb70f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 15:56:28 +0000 (UTC)
Date: Wed, 4 Nov 2026 16:56:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: b.murauer@posteo.de
Cc: git@vger.kernel.org
Subject: Re: bugreport: performance regression on git log --follow
Message-ID: <autVqTLs_pgwVcSE@pks.im>
References: <1491d49cdb1a96698e5572d9de3ac280@posteo.de>
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
In-Reply-To: <1491d49cdb1a96698e5572d9de3ac280@posteo.de>

On Wed, Nov 04, 2026 at 07:58:25AM +0000, b.murauer@posteo.de wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> I ran git log --follow on a single file in a repository with about 30k
> commits
> and 27k tracked files:
> 
>     git log --follow --oneline -- path/to/file.ts >/dev/null
> 
> VS Code's Timeline view runs a similar command automatically:
> 
>     git log --no-ext-diff --no-textconv --format=<format> -z -n551
> --shortstat \
>         --follow -- path/to/file.ts
> 
> We regularly merge older maintenance branches forward into main. The
> affected
> file was added on main and does not exist on those branches, so many merges
> have
> a parent that lacks it. The following command reports 692 commits for this
> file:
> 
>     git log --full-history -m --diff-filter=A --format=%h -- path/to/file.ts
> |
>         sort -u | wc -l
> 
> What did you expect to happen? (Expected behavior)
> 
> I expected the command to finish in a time comparable to earlier Git
> versions.
> With Git 2.43 on the same history, it takes about 1 second.
> 
> What happened instead? (Actual behavior)
> 
> With Git 2.56, the command takes around 10 minutes. It uses one CPU core
> for the whole run, with very little system time, and output appears slowly.

Thanks for your report! This is a known issue which was originally
reported at [1]. That thread also has some patches that are currently in
review.

Patrick

[1]: https://lore.kernel.org/git/as44NVKZA9C9S5ae@pks.im/
