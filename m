Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907173;
	b=Fh09ts7YcFeLAfKRUk7YGcYSzaCGGleLsoksB8fXNgO5Uu1aIZuFAHX3LtipkQyNBzr0
	 GgEBSlQxGGvwCle6vG4zYG7QNzslwlMF07zmW2daEcqqtRIEyQkqGYtnmWAiYIIUiY+cm
	 DtezRjGhfeD5jISZDLnmjdSi/zH2XzJQeXsdagTOJOm9lwdoFqC+gqCMzb5kA53aoiur5
	 nHj1C2xsED6/YWROmjAKn5TtUIOhKsYXz/1PDHfwLTZS1RLnHTn0e9TooEZm0ytuEYHgM
	 P82kA4i+9XyPNg4oJ/UT6bl+aX7Yi1nuMABKUM9GXJnfIS8hvQX0DT9Jj6Iciw3v7iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DtgF9I7k6OY4FgCJCbfywEeVYM5Q0gXvX0O820Uxzxc=;
	b=QXJ9c2Dq/meyJKHSG8tfpnnmFwTpBqc5Qi4ryQfieLUzWDNmt75VCa4mVHTflHiQInaX
	 ixeXPEc3J6D+SCgyp6MTWXlJ9VaNgILeiqO7omp0M2enDX2Ml6A0L+OCgKw5Ua6Qw2/wC
	 J+H0TlIEtLndLXOqnX2Dr3H0q4P+dpCiuQ8PjErDgioElATd+RLbCo/qpJ5dkn4ghYYh4
	 AoTKKlzrb1xI2wWe7ZxeTinQPKPcq7opdSFRZe0OacfjQPgqd1UF2vzwV7rpC168U7I9H
	 0RhVjZGiNzg7Ji3k1G9U+bbLerlNz2paF6FOtQ1mHtcBu4FEiYnVGwJGVjh4gwfiFLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eXVpnVgN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gOA950ND;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A1606A6C2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16A1606A6C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eXVpnVgN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gOA950ND
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 25DE3EC0583
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:32:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 14:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793907172; x=1793993572; bh=DtgF9I7k6O
	Y4FgCJCbfywEeVYM5Q0gXvX0O820Uxzxc=; b=eXVpnVgNxPMNLUxNSbaJqGfRem
	dGvRdFxjOtaX0vYiee1OR4+8xpQw7L4FtDWQE8A55lqTYDuRZtNAEyS4iG85uUta
	r8ogALet7rWekhdTNCaldMZl5/8hqO7ZZ9OwK5ENba+v9vvzCg77KPmcIpeRuaMT
	brOSlQPGFkdw+p5KaWOR3hbhJz0xMQhhLUluH6JpmjIm3nRNL6s/EdFXAqO191Vt
	oS221S7+9QY7K9SAEKlDMZ331uxN2MNvznFsJ/eoVn4oCLei/SFJNsYe+oiq6Tjd
	m5wg72c0v8fLhbVRt6xFyfLciUHTEp0tQyOzjc375kGI8adkg3FiMdK+PEoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793907172; x=1793993572; bh=DtgF9I7k6OY4FgCJCbfywEeVYM5Q0gXvX0O
	820Uxzxc=; b=gOA950NDd/mywlqBU6rBhctHS6LlmUL4aaeVpUAgRQS+886sSg4
	pDu5mqtv22bPOlEaHU/P0xqJywHJWpd6o796sHQNE8fknHisMutD5OVTODMdp0wW
	xoYwirPXcW+E6cnCDypre3wr8tktcRSANG8p0JveaAav3ExIWSNg6gwzyLgjgGDL
	FUly8HJgNt1jbEkYUfAEEEKWsqu9M3BGVI7gTRIwWGc1SDnMMe2eoth7zXzbykGv
	G7CR0GrCxNN/GQs7x5SXTld1qDbvWNtxXq25D4ZPYMosK8qNlvO11fEEEElnF/eV
	NsZ2bBYrP7tPERrYhlyhoSSfX0OWxCsE1FQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793907172; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oAbE3/qqlQ62nDS50VW0vtOQ765XSQKeBssFpWLyHz5t6wF
	OXA7PxRkohZmjGrxcRNeiIQeygyXtejUyNIYVBsliRORSSMkn0qmGZ3Smtt2XZgT
	VdSLp0tJSTnBPrZ0cHFgxD4Edt7ORaN9ouMNAv19zooNHApIYcTqj/pPwj28wxld
	znJyYE5Iyh3IaBs+nyfWpVmdrhrmAZyWYawZ9ZFVGrgeJZu458moCl2d9epjdBLo
	514jBAm4IGTCpfeTHgzc9c8ZRF92H8Rbn4Pq+w+mtRZfJtIdJ7Ed3t9a6CggXKVG
	DUq0XuyHPConeIlmBcrdjSNt4yZNTsVaFu9l2cQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rfoCHDJVGapp8WgKCcvxTNmRAF1PdXvGKkThd/C1tF4=:cLAN0rjdpnW6vH2ZldB1BeihIgy0StD6s47isEHjX1I=;
X-ME-Sender: <xms:49nsasZWZZXLMMJVs5Tybq_QJU2ze6EAA0TliTVJa_lQQb1I9e3vLA>
    <xme:49nsapracVnnHMEF3QJ3j6d2C0LiJG1gc1dJt9IWS-kwNKUmrU9u_-jzM8MLTO95o
    zzAW8EYzeSDu_uOO5SWHDYENMppgShznGGpb5Mbh80YSichwWMoI8I>
X-ME-Received: <xmr:49nsapNLHF1LaZCZTMZ9_HIv0UO0T8m6h3L3VNKxTTxKaPG2XiOya9CcFnGD-BngrCsb9HdRwnsu5XjsJZR5LsBlfAtNVNBZY7KX>
X-ME-Proxy-Cause: dmFkZTETNjN6XWkrwjU4MZlBfrksiRLKMvAZ2IyCIvGU/1og0qHGgoeyCjCfTA6nKK5vmz
    yeJTbyXZaUkYUt+uN0PTS3Cjf3CC0TBX19K8jPthwm8o3gbmmwvafdYLoUfPWlUwvvoCgV
    wxgFaedOIeCAny5g39BUgZgoX/xF+zINlARB+Q2v3Gr6L2kOm4mbI2mjFyFN3SHOPtiZbq
    BqxCZoTCGw+Wm2gIaR2zPlfipawci75J6mswS1yRgTl/J8p09hEcjUrDLqF616eL0SBuih
    f4WmUlarR33PhxCYln0SyAkgBTr3+igSH2PCR7D3YQueKxaKLMfIO9uPXurOMmj0CzRVmy
    IDOaWCqZ0oyTtZrr9Hc0B1ytnKwLWuiWMJa5mIednFYljPEGaXDH5jSMMLMLHVWk63lY2x
    i01RibLBfZm4t1pX+tyxemX9XGI29ONArsX0szSZQyZuYViESAh77eJDAumklPGqPFxpHW
    ef8+giVkdtrtwmRIvDQUMJgqwtAmrCiEOzUXUUG9cJNCxfwMFrIxIiBqSieNuXKJ7bwg1/
    /mM6cO2AGH9EqPJ4kN1i21nV2WCN0zhR15HHMgiAYklLqbiwt+ZBSz38yNNRUW+bbpAk9y
    OfbilAseBmk3i9ppwINoXxYamI5SXKctNqgHT0Lhmk3/dUmo65cHizf9HoFw
X-ME-Proxy: <xmx:49nsasqtJcVo2ZsCEs8a054loCxB0IFsC2WQfI5mlKBUyei9KlDY_Q>
    <xmx:49nsamdPG3WIqqKnNNESV_TAjLrzM6Dor1odfN33y8bACkPBFa-1tQ>
    <xmx:49nsaqS4OD0rLTFWIazq027uMI7Q3HayfQNzwBzPq-pDV65XP57Hig>
    <xmx:49nsanZRFOrfRuy7luBqs5bfkzxuV6P_Sl0yFj6AVx41f6rBVs2TmQ>
    <xmx:5NnsauORKiWnC8FFjFq6Jil8uywlnDfHnrpvt9Sn1tBCKRoopG0Y1upG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:32:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>,  Patrick Steinhardt
 <ps@pks.im>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 1/2] command-list.txt: add gitformat-loose(5) and
 gitpacking(7)
In-Reply-To: <20261029184834.2273-2-taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 29 Oct 2026 20:48:33 +0200")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20261029184834.2273-1-taahol@utu.fi>
	<20261029184834.2273-2-taahol@utu.fi>
Date: Thu, 05 Nov 2026 11:32:50 -0800
Message-ID: <xmqqh5hvt6ot.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Three manpages from sections 5 and 7 are not featured in
> command-list.txt as concept guides or interface manuals.
>
> As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
> and make gitpacking(7) a 'guide'.
>
> That leaves only gitweb.conf(5) which could be added to
> 'userinterfaces'.  However, the manual would then appear
> as "web.conf" in `git help -a` which is just confusing.
> So, perhaps we are better off by leaving it out.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  command-list.txt | 2 ++
>  1 file changed, 2 insertions(+)

I agree we can decide what to do about gitweb.  Is the list
otherwise complete to cover the available documents in .adoc format?

Thanks.

>
> diff --git a/command-list.txt b/command-list.txt
> index 5c649c882e..d96f56a379 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -225,6 +225,7 @@ gitformat-bundle                        developerinterfaces
>  gitformat-chunk                         developerinterfaces
>  gitformat-commit-graph                  developerinterfaces
>  gitformat-index                         developerinterfaces
> +gitformat-loose                         developerinterfaces
>  gitformat-pack                          developerinterfaces
>  gitformat-signature                     developerinterfaces
>  gitglossary                             guide
> @@ -234,6 +235,7 @@ gitk                                    mainporcelain
>  gitmailmap                              userinterfaces
>  gitmodules                              userinterfaces
>  gitnamespaces                           guide
> +gitpacking                              guide
>  gitprotocol-capabilities                developerinterfaces
>  gitprotocol-common                      developerinterfaces
>  gitprotocol-http                        developerinterfaces
