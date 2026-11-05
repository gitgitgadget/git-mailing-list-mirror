Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793919790;
	b=r16WqLme5MPNXhHlybRZ0WPOqoxbKd7zpBS8gV2Sd3yr3txSTvez2ETo0v8Cbp9kKjbr
	 lT1EM8vtMUrbTgveAG5JtA9oxDYKydtjftA5lAlijjYzJOVvnvvsEXGFV2iR/3gTybyxz
	 hlQ9lGImLUOjYIXfBjul2qJomulG+kCapS5CrW9WWjHj2/MXW8ozNqngRY1Kt1DARXkWe
	 g1wo+aSvzZ/u5EHhkm3Q9EVg0HIgMdWFpuAfxm/dq+87PLy3wP8hQwvuHH6G78rGmzMe5
	 Xkz2mOaXonCHT0N0W1y7jbsyOgUu2zLP6nOzMuxSxwBXt/xlRkG1O+hAoHU7jSUI4uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793919790;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5Ccz43muVZv39bedDkSkX54RUFuf7Hc5LWfrPieKi10=;
	b=PulwczVRaIONrJzmZ3REDGuZIrFNKCqLbi1GSXQ6d14GRWc6cRqKG4YpSQILMS8JJPKO
	 UlFMisAPzPIFU4jTGkWygQXFNlmITiPqn0gtqe6HUP949K6rEximCjxsV7XeXLQhX7/cR
	 m9nVOys5GaS+XpF268Hit6mLCtfogVRBDhgixaSjngkqi+QmaB0uBEELS3Br/95xBajq9
	 ZZOog2C/AqBRZ9nUhsM/kICxV7m6r+hwSSIVpG5sFa/UUaP/A05cXTLNFbCUOah5HXX1A
	 pru3SGTn934YC+TzcfChHcoyMthXCCz81Ub2qKPsQQ26wwE+TT3Le2fOfcpW24NXC9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cYuTaQPV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Zwxd6O2P;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9D606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 23:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F9D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cYuTaQPV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Zwxd6O2P
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 84E77EC020B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:03:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Nov 2026 18:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793919789; x=1794006189; bh=5Ccz43muVZ
	v39bedDkSkX54RUFuf7Hc5LWfrPieKi10=; b=cYuTaQPVRs375k8jdMce5jbg9c
	D1fjWat18pS5Shu+QO+wUfaNBruAE7jKUUHd/OnvpWd7yDJ0GetFNmCGtxFpF2pv
	cNXa6s9EPXLhLksZXDBNsclNLKWBRy5NTms3dEYLmJnW0cCB82eKaeu1l4kgNS+/
	kYMDgGAbVtYyqEzAzdEpCMfqA1aBf4lvzZ+2V/q48h4ytrPuzgOJ+EnuSWtaC8yO
	/aBhlgZ4WVIX21q/EdAiTxZeqP9ehHDUKgwdOC8wbU9jckuWCjFMExsZml1NWfrk
	yJ7MBkTjs2GJUnbyB3nsHAcbiT/HLv3hmZmpqosz+rOuX8+Uyapg8hbLFp8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793919789; x=1794006189; bh=5Ccz43muVZv39bedDkSkX54RUFuf7Hc5LWf
	rPieKi10=; b=Zwxd6O2PDxqjV/OTU/apH85KSSUN21YcZuIZ9C0mcPJB9H5UxMv
	wtAmSiHQead/mNYmhGfYpiqrsM2o6uUZQLtXrNTlHYQaPHW7SnZxCcSocZbRxvJl
	GYbszZVSyW6zuGtHl72pbPYEoBX5OrhAFEm7WICqCHxZQ8H0WnlJp3WkggiIZy3U
	LuCZZ/iXe6gPE9846Xpd00UITktQAebjhFn7sTcZwqKZTMpBW0yk50uQ/3xigScv
	GNc7geKYUukoEkOW1geXanrnHW9uAdtOs1GwDQREtlRbUoOxEjcemPFYeINy5+wJ
	xJNLohT6pF/hajYObWpLgxxkNT7FvArmWNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793919789; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mtY2/GlmneIEDjxiVB3PTYPMuw1lC1HEdd6nPu6putP0m7i
	xpoDeCCqjzhNU9XHHk9oGjf4mo3Xwzp0fYwvUq0fozT2uD4at2cbnIZJb44x6dM5
	2zkEkE8OiNfzTYBZZOVkt7NRrnyimEtOznQ6u1P7mARApYDDjb3oqlFNdUYcGXgX
	4FfOpoUOXGC3Tw70YM3E6JUK7GJIsZ/pPs1ia2qL1vbUDFBuc/F40AZ5mnSOpe3j
	42rBt7YBOa5Y48EmJUeCNTnwywPnVCHxY5GM9l+qrXbESWV4ZOHrqX1vErKybUzW
	U7fxRK9dmfZ01OueFyWuZwbjY2H52JWq/nDMkcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aPmiZv2ipUVba9hT8ZKNMgv5SvKkqIbtC8CGAgo4Y4E=:+KJL8Hzaq+8pd540AcWnUK0E3hb/nCAcqLGcIWwTR1I=;
X-ME-Sender: <xms:LQvtats_Uiz1LEhJybrbhgM2vBu7bC9l-jlVcXzG7z-gjeJRoD_5Ag>
    <xme:LQvtat7pGT5eWaGEoHgTz2Q9Z3qXoS_R2LTWSjW6v4ZGd0RwtU5XglcDIQ4_TPLVD
    X61KSb_JjuiGv-FVEx95jnP-DEFO-KEDnDKSP5Rx5eYEAZW7__NJ10>
X-ME-Received: <xmr:LQvtauIPTAoornLssg10Gt09g0QHMm5wOUR55l_umKG40vNK09ceKAhThc99EcV5uSal5h3_xV0UR8RawZNJ_np4faaSdE_1Mu2X>
X-ME-Proxy-Cause: dmFkZTFueFx/+VLJJ6lxkFF0u2zy1zsGGFW7fxgcrRH1bd8yMDvP7o0GMSMueUC65tXgXg
    zJfy2sd5V34KI85OKSC94K8kbNLjd/mwlVXTXcVA0hqu53N/FU1qh3/aehf9JGXYcvWUBX
    PPzqvYAO42gWsnE4AMG1H/z7wJSe5okKMtQgv2aVxXtPNxASyj/KWJuWPp8wHw0c5cUe7i
    40vE8zFVF/INOFzAAq6Lw6V/0ackIeaqmUQWu3eJxl+TqumzeqgJUhUEQB2D6pTaI8+N2T
    FFz/NTwfIYFucI/M5Gklo+0UR3Us5+1kUQijU67pwmT84PsHpPJ1d54ZJOjYpcXDOEVrBJ
    HzjA1kIeagFc3o+ojNrIG6tQYx06ZRedpR823AC/pZTn0mjhwbWqAHxtsLKv7ebPV41fQ3
    kOamGgnA6xwoNkKQPViCjugxytIaSbaNBCR2u6OepWvvneYkTW0nUKjEsDPcO5r/fzEC5C
    Lxr2wAvPh54HoqhxW8Wk6PgY1F+j3UY/4fo9KPrVEfmFd+eqDpboaDFwgFjgH3jehTOSfj
    Rb88mQRG2l+nhciQmF7h7dm/pTpzDiAHq3pqXimzSBcOPOJZsJJBDBiF2/c6UcSIXN38Uw
    phCFetnaGfSQeDVgh3JO3jUtYSg5WxXJS3Nl8td0LFEpBBnlbrgBZsifn46Q
X-ME-Proxy: <xmx:LQvtat5SykERxgtHxUWuF1PV5VF13uv2tdMFTUFdXfgOxBsnDrhw7w>
    <xmx:LQvtahw4ohwAvRWzMJ_Y_VtQ7TaJT2zzBY5PL0s1owuGtRSypapqIw>
    <xmx:LQvtahaN3Pvv45Q2KQNaErimtv8Tw4XivAO1Qja2q7FFc4fwajmAQA>
    <xmx:LQvtajTgxPU8ENrKoQ91yDkgjsL9omrAUfjzPT-aTwcThM0qadPd_w>
    <xmx:LQvtanatS4d10KpWyTWe2DcJn_PTOLaItljWWt-bn9aWzdl9oD1UUqPg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 18:03:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 01/12] remote: validate --force-with-lease <refname>
 argument
In-Reply-To: <20261014031347.50433-2-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:36 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-2-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 15:03:07 -0800
Message-ID: <xmqqcxsiq3tg.fsf@gitster.g>
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

> Use check_refname_format() to validate the <refname> component of
> 'git push --force-with-lease=<refname>[:<expect>]'.
>
> apply_push_cas() will silently ignore a lease entry that does not match
> any remote ref.  And today "./refs/heads/main" will happen to be matched
> with "refs/heads/main" due to refname_match() usage of mkpath(), whose
> cleanup_path() strips leading "./".

Technically this may be a regression, but hopefully nobody would be
insane enough to have used such a refname.

> An upcoming commit removes mkpath() from refname_match(), after which
> there is no unintentional match in this situation, so that the lease
> is ignored instead of applied.  Reject an invalid refname now to make
> this situation fail fast both before and after that change.

In other words, we would be introducing the same (technical) regression,
so breaking this calling site is not a huge issue ;-)
