Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32E33B6D6
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539314; cv=none; b=rUKgk5n78DYrSW6PKkceimQQHfyk/yq0HUR6Go+Lw0EgGM/Wo4yzUCtNbYIpDLa/Z/G+KDNeCC/YnuQ6zCdNzEB2hK8/zFn+lkHnAP6xfH55IMFCqv4Pqp9Dzqqt7moVGuopPAwYUHiCdCOHaOhjmU9JkZcaIBuckBEHFb7P51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539314; c=relaxed/simple;
	bh=2jsz9d/e9yeTWrI97FpDszyYb4KHVZFuAP7RqXDfdIM=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qkMcpJE9rrgzPm0Y+QTGVqmzlJ2L8lD2Hhi5zcEpFN0bIUMVa1z5i9uo6Kz4ywqelVJXOqeB5AMZoD2LYqQf6km0CnJKd2Es6nQj7QR51FewJKcdbJSoFC6Vtwt3a5DrfC2M6hn2dQi6EzXjmpVn7Ez4yUU/YPDekjRVmE2v7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=od4dQc9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jqchks8m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="od4dQc9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jqchks8m"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 145071400174;
	Wed, 12 Aug 2026 08:55:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 12 Aug 2026 08:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786539307;
	 x=1786625707; bh=JowMDW4Yw93+gIwZsydy2AShKC5Zox+LqwqedecBT+s=; b=
	od4dQc9DiuOM/YH7VAwv9XCfSkODzd5oJ+UdSByjgI/Yo/9pmMvqAyJ/TcMJDEtp
	c9gYZhbyhUOqxYxjW44oXif8oJI8QyyPIE+RCLPozg54u4oM6g99MLoqmRwcpcrx
	i+C1N+wCo9vRsGXcKAnko68Ym+B1IbWnqGgtMDmQi85ytAz6X1ZQkmHMftt2a9oW
	v2AdOSJSxhH7ZTiyX3U0gl5awRNMnQn4vfy7scPOc6HZdF16ednZGPZw9DF/G6mB
	w/nmukO0/pvofeBGJu8xB8DSAiIBBlghw4B8N7+bIumatl4VGz3kcdGMIH3/yLyA
	WW6Gd0e8nL+tiI31/YLyYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786539307; x=1786625707; bh=J
	owMDW4Yw93+gIwZsydy2AShKC5Zox+LqwqedecBT+s=; b=Jqchks8mlAI6wAtrv
	guvpbbqtGgZpU93F9UoVdcuECGGV8vNlWQNxb4f6aXikUI5NNPOURKzXJhvThljN
	motmLSo5xQIZLwal1XAecbsD+N6kfYE1DWRGrdPYxNCdmfH2TFczH2OHCf1BTOZN
	S07q7qEM4k07um7HoNOWyUmTcr9acyt24fmcvPJbdc5qV2nO5Xn5COsliwAbZQM+
	F40U1qlsCaAOLi0TPuJq5WnPupGdtg0ANgmfI4eg537EEhxtRxZXB46qHQbW/TcW
	7chrfx3VBG2hyeouV8RfsZ/LeVYLHd35+k45JMIvgPSDHUQYF7vF7i0AYBRi/Gd+
	wXcnA==
X-ME-Sender: <xms:KG18asprKLqO0OU-e3nXEThJTTb7KxP9T2YifF91iZOisG39d8g0O5w>
    <xme:KG18atc01Pm4KPVeT0Ipu4ra3RnFQqgSYjbmgqgxaAhAZT6hY4rGOZieMrY7u9fCL
    Q0MAH8LNO3hWthfjQFb8rfUAkgH0PcHQAoqVfGu8dezhQeFqyAM_z8>
X-ME-Proxy-Cause: dmFkZTEOqTfapDULNhAFtox4S36V5ps6oPn3tp9bLtpvDNtWWXLIuFoK3YCJlROwGhYHDS
    c0MvQl+kn/jWf0+VX2AlS1mV9tA2oJne4tRDydz791+TPm/EwtiPFL4TmqbX0d1T6rkAM3
    rHbYMRgVzQhZKkg0ZcH5Ob/HULGluZRkkDY7JXQ5TvSMDt0hrVdjy2a+Sy5q0j8FYuA8pg
    kEVFmVXaBcBm+A/PPaR5oWon//22s34EE1ZmKiCaJ6/7qCnilozCjnXrX/ThIZr6sEVROO
    lSQLKejO8XkRPLTqp96/Fn6JDfAoMF8gYC59ue5oyz27nXieO6nQYa8dChFEnuh7Ehx/An
    NyRuZkmCu+A3g/Gyei9t10FbyzhXLCra8yo9npRGhqzGmRa1jPKJf3gni6hV7RsFda8FDp
    QnEAmp+65srLpvUgv/k99MvKXbDK4AsC0uMkf5RDaHRBn2iQ4hjepCu1Owi7K74seEoaHP
    VFtYnLIbER9ImqA5SoGZzZV9sj05uA5YJc/n2989FPOqtWHNgTqQPT2veTWVe/CmZM1uqR
    EkBPNXR0X3iT41O4QQv0rrY70LG9LUbwp2yQtjN4+LoqSoigEtcY05ilcpii81btb2cQOV
    bIYF57kO4+TxmXjyFbgsGW4xdKgfBy4v1XwUYkJnWvAVUz8fsMsBeiSDDGgw
X-ME-Proxy: <xmx:KW18anVZ7Sdxup2Jx40ft0EN1GsBh8ftx0T809gtO1fgDeCAAeY5_w>
    <xmx:KW18ath9JFTKbDnRZeLYubaI-Tl26BOD63SozW3CG1N-WQSj8r6XMg>
    <xmx:KW18aq8igNnR0SoaoYa1hGLsMmaCNmCxtMmiqgJd_mgK_R5ws4x80Q>
    <xmx:KW18avDpoxNxdvb4BjvZzpVeuC5pltFkF7OMvOC0WFiCD7nM1RSAeg>
    <xmx:K218ai4vA5ZHqbIGtincA0KfztSDx0i2MyoMkZeRwQTIxNj97JUstvFJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C892122C0070; Wed, 12 Aug 2026 08:55:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2-b0hDR4pQ7
Date: Wed, 12 Aug 2026 14:54:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>,
 git@vger.kernel.org
Message-Id: <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
In-Reply-To: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
Subject: Re: Bugreport
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have only skimmed this.

On Wed, Aug 12, 2026, at 14:31, Marcel Svitalsk=C3=BD wrote:
> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> I called `git lg` command to display git graph log in my terminal. The
> command is defined in my
> general gitconfig file as follows:
>
> # double liner with hash, time, branches and tags on first line and the
> message on second
> lg =3D "!f() { num=3D15; if [ \"$1\" !=3D \"\" ] && ( echo \"$1\" | gr=
ep -q
> \"^[0-9]\\\\+\\$\" ) ; then num=3D\"$1\" ; shift ; fi ; [ $num -eq 0 ]=
 &&
> num=3D999999999 ; git \"$@\" log -n \"$num\" --graph --abbrev-commit
> --decorate --format=3Dformat:'%C(bold blue)%h%C(reset) - %C(bold
> cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold
> yellow)%d%C(reset)%n'' %C(white)%s%C(reset)' --all; }; f"

Note the `--all`.

> What did you expect to happen? (Expected behavior)
> I expected to see git graph log with the project commits.
>
> What happened instead? (Actual behavior)
> On top of the project commits were added these four pseudo-commits made
> by some Git component(s).
>
> * f7b611ce - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
> |=C2=A0 Notes added by 'git notes append' - rewrite-analytics
> * 1a7605bb - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
> |=C2=A0 Notes added by 'git notes append' - rewrite-analytics
> * c2a05d79 - Wed, 12 Aug 2026 09:25:03 +0200 (5 hours ago)
> |=C2=A0 Notes added by 'git notes append' - rewrite-analytics
>  =C2=A0\
>  =C2=A0 * 01c630e0 - Wed, 12 Aug 2026 09:13:00 +0200 (5 hours ago)
>  =C2=A0 =C2=A0 =C2=A0chatter: initialize notes ref - chatter
>
> They are not graphically connected with the actual commits, they just
> sit there over them. No other graphical
> tool (Sublime Merge, IntelliJ Idea) displays them.

They are Git notes. They form their own connected graph. That=E2=80=99s =
why they
are not connected with the =E2=80=9Cactual commits=E2=80=9D like from so=
me branch.

The `--all` will include all refs, including Git notes like
`refs/notes/commits`.

This doesn=E2=80=99t look like a bug.

>[snip]
