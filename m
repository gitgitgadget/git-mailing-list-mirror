Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525916;
	b=pdUXctDD/Eir0lSFRH0R9HmQLkL7sMu8LonKg0ZWW1e3+ytxj6vWjKDSV4thlxOIc6fQ
	 SDGUrAn4vHwqtgqD5hL+H8RJ6uoSSClNDcy75h6nLFNaI83aKVTY6swBmLu4QtweneAzW
	 p6JqBq9ZIfLa5w0Mou7VM61oXF7zmdUY/+/UkSgFBpzVVwfkLwEtD8d3cyXK80eUYmIH0
	 CU/r6mbEteytjcfle5yhke6NaEqSpJ3zjel8hl+EjHgivbqn1/eaLxmGZaRQesk+nGUhp
	 9lyi5VM4boSuw/aN4UUDdY/+K14/R6ph3/At0ylPMZbwQZLWcbf1T4Ucu6lFcEZtpkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525916;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xZSq4dwKhtOZzvrWDe8me5oCJItkkdO8nVMvLZJIHmI=;
	b=cFuR2Hq7KtONNHr85CWHIfOzhLltoyitGdAxYO8hmegOHe302Yjrz29hHn9hpYyfgj8L
	 d6TlC+N6gduXECkoZ6C0Rf3+YxjaF8PMPwJtZYXd/rWU+0A17u5OX6wFFTNElvbW8+VYB
	 A4rLWPXfICDTc+XkeCkjK3PY91+CSH8nq/dZYKHC3VgGO33SZFnsbgMYesfwIUdGsh4f2
	 xwHUNWcLaGu2qzeMWzk3vTsDuZniiWF2nvDGfDg25Hkpj8vmU16ysK13QGwVI4J43orSx
	 lcDurocZ34zd6UTQvo/E/YBdn+25BqVFG4KofyYgS/jtT0JjCPc/ufxyoLP4NrJ1jyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HcdPh8r7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hygneeFr;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C7B606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22C7B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HcdPh8r7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hygneeFr
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FC17140007F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:51:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 15:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792525915; x=1792612315; bh=xZSq4dwKht
	OZzvrWDe8me5oCJItkkdO8nVMvLZJIHmI=; b=HcdPh8r7v+BET4G4ve/0yxxnSW
	YVlFNf1LSZeVGKMc5JrzncuQgDUdbS6Eb898d9yHJZadOdHtbuGj5WmlcUbFAXUR
	CZnSfsA1xdtuXQZc875csZHK81syXHT9uMVixnm0OCWnLp+poa9JFPf/7V1zV9DE
	pxaB+WV47O49r252mP089F4scUCuIhnNclJIJ0dMNAjiJGWeq4wCpWQl4/RZedWK
	2aXfe7hgikB9KL4tx1DT8D9oWyS1Km/y4Ccbt4i4Wl9miIloiRvJ5dsRpoFQ1jqj
	3UopHtYZxfYgZ8ayeUrrx27kw+eoqjs7HTnEKw1X1R2YzXWHp1wAUkYKUR7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792525915; x=1792612315; bh=xZSq4dwKhtOZzvrWDe8me5oCJItkkdO8nVM
	vLZJIHmI=; b=hygneeFrq0ibrqeJ8/+Qgqi/rpa+6ghtTvW0xFbwCpSDAoIEWk+
	4lW6SbDzUZWK+zLKQ680x6MpqDI3dV15E4oeBGCSe9iR58HRZNdFAwmEsdBH1jx3
	f+HU2Alr1uelRR9oaAb+gjvPPlALj/Qt9LdpwgaziC1Hz+Fgq3yfbdiPrTzqJWWV
	Rz9RlQ0BMmdmaN+swyHFQV7Kjn7219eI7FVu3pkRBoZmTdH7Z6aPLRzJ2njHyxNs
	sM7A0gJrdAej7n7f1RXaHzPD2u3LXQONVSCgEOL4GO++Ge0w8yR41NOwZ86F8F7K
	MOUef/kjy7Sb8YV7kZqCdrVsBklI0bqQEqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792525915; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZN2azB+8B8ll1DpHjy/e19PuTM/eJpb951K6fjaMoMopWa0
	GI00k1OMBXDqetE2TRqWtuKpMpM+iri6LQIIVzybjmYyZ6JW5oeX1j72IkSGl7Qq
	z0SEeyoOakkBqFA/GXaMohB/U7l1KOg8Tg21L5AQhni1G8f9UMuSQXw345LTyUv8
	zjLJrFjA6lQoARRGbODEBElKuJDU7omTln/DWKd/Xww1MBR9WSirQ3qxeabdHoqM
	hSszCrqf16YpDH88tyDqodNjNrieHnVa5n7Bdk0AqrcBgncNmtdLisy6YDsYG6k8
	dx9uoyxngubnH0nn76AQesoh6XUZT4TsCBqzykQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NWLX+PI+wT5/cLny+xmB45p1aH61hcSVmhStz1gbA0M=:EvtDaBZpy8EKrBJQ7DTiy9itjeDJ0D/Uf6vxxO81MfI=;
X-ME-Sender: <xms:W8bXao85eFUBZFFtBD2lZXpZGx3bG5kDM1YRFV9ffTT7dPFA0gzCmw>
    <xme:W8bXanu86dx5BAmxE8_jDbb505LRvEZyK9E3QPJ-BH4rKcPknLk0je6r7NfEeKqvJ
    KE76L0SG54PhywHQ4WhQ4wuMlq-Zfc9mfNwteibBVhVzpnp7CRPew>
X-ME-Received: <xmr:W8bXajDQKeiVi5xOrsRODLnWNW2Wumb4ZUWz1Xr3qFB4wuOaK_kWmB020di-qnCYtus4UqumBBdblnLaqHuc6Qq9kxjgyezDs42H>
X-ME-Proxy-Cause: dmFkZTEpdcJ6UXBpeiYIOIT5aPmoO5id9HAJFQEyjanGnBmvovvURI7EOGp2dePsLLDrEw
    1qXN3G6MWfxXvlOTWmFTSHCTz6v7A0jxImj9a3mM9A+GX1ZrWdwxK6bR006j6GrgdEoaBy
    aL9XaTvpwaNidgz6/Gbep9jEqe7+VTpEzUB4za8Wa0e+39kr60f3MUPPHRQmiZpeLXFAGP
    hNHZGSy4noXyuWdtw8tNAWpLRPDZ0AAGL7ZP3k9PYdupyYAmaycWu8f1fFBBCc8w8t1QvP
    skVlWvRyx1VTQas2T0NAZpVHw8qRi50aMBfpnOi+203IXDIuVk24rNkthZlxK3rTQS07P2
    56oEJcfurz4O4Dj6+fiywx1T10AOb87YMFSr9hadJ0xV6j9iQ6sY3D7BhbGrmf9AVONQJV
    lWLQ77RMQafAXUMMvNTWzkHFpYE8C1Q2RayLv/eTzJqJC8c8gctlQ46Ml5TbVvXuF7GedY
    UM+NFEgbihBkDBf3F4hMMN3t18sxIir+fOMWfkIePGIdb6JHWQmx1D+uacyykUmvLYOtzt
    k6TiF/eD2EWDRQNFVJyrt2Q7qAKIKvges4uu/QiWUHTZXnGvq49T+V4Iv2UgAOQFUNUgNC
    959ZzU5LdO4J6EBBPSuKqOpnFXI3lhGKwM+MpLjJaaX9rUGX7to/pC1RuLAQ
X-ME-Proxy: <xmx:W8bXanXSONBPMkO_YioZosURGQCIUpdt2TiJm40xrj-F5j43pU7lJw>
    <xmx:W8bXapDvY9w76LLJ2qLvigUjv071CpBqo0DfM5ZkYso5VNMnhDzGzA>
    <xmx:W8bXai-uHqcCjewhRjDRXcNsUpUH7GRmd9yUAbnUgBxYEkkokPY8aw>
    <xmx:W8bXaoF3zZXzITTs47NAdEAEJ0FjFOjcSUuyYQN30QyfaemirQ_Apg>
    <xmx:W8bXamgS8RzLdWkOPPSQl379PA8-K1_54qB5zWCnTTSwlpqhaMUGkPzK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 15:51:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  tsukasa-ino <inoue.tsukasa.4@gmail.com>
Subject: Re: [PATCH] branch: strip refs/heads/ from the --set-upstream-to hint
In-Reply-To: <pull.2268.git.1792458904027.gitgitgadget@gmail.com> (tsukasa-ino
	via GitGitGadget's message of "Tue, 20 Oct 2026 01:15:04 +0000")
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 12:51:53 -0700
Message-ID: <xmqq7bjcup46.fsf@gitster.g>
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

"tsukasa-ino via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     hint:   git branch --set-upstream-to=origin/refs/heads/feat
>
> The hint says origin/refs/heads/feat, but the correct name is
> origin/feat. Running the command as printed fails, because the full
> ref name is not a valid remote-tracking branch name here.

Good observation.  Thanks for noticing.

> +test_expect_success '--set-upstream-to hint uses short remote-tracking branch name on locked config' '
> +	test_when_finished "git branch -D hint-local" &&
> +	test_when_finished "git update-ref -d refs/remotes/hintremote/hintbranch" &&
> +	test_config remote.hintremote.url . &&
> +	test_config remote.hintremote.fetch "+refs/heads/*:refs/remotes/hintremote/*" &&
> +	git update-ref refs/remotes/hintremote/hintbranch HEAD &&
> +	git branch hint-local &&
> +	test_when_finished "rm -f .git/config.lock" &&
> +	>.git/config.lock &&
> +	test_must_fail git -c core.configLockTimeout=0 \
> +		branch --set-upstream-to=hintremote/hintbranch hint-local 2>err &&
> +	test_grep "git branch --set-upstream-to=hintremote/hintbranch\$" err &&
> +	test_grep ! "refs/heads/" err

Perhaps it makes sense to also test that the suggested command line
is accepted after all of the above?

> +'

Thanks.
