Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514B93A1A2F
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505981; cv=none; b=kOEznDNRP2T0iETbAryMytw8ISEL0b7+s56FLtcKPNkR0Fim9aAyTftL9iKYq8JTRWDNKzOOXB+99+8KUkJkie/r1gt1IqxsxeTiyapyU8y5e/y3bhhwy6KgVwMAEAfywIuAKohvDR8Czuz4VXfA27PvPzN1vUPMawcmqofaGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505981; c=relaxed/simple;
	bh=Ik45h1Tz4GJCV26nq+R3jKlLCP29UV8ETWClx3qgLzY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G32dQRigQl8nuUUIz7oMq5GltipM3exDAwyWOvJ+5aZJuT9b7TEm4S3jsTMtxciK2cBXRjoyW9mIVp2QsQAEl0Te9zT4MfnsmedDVL9NVGv985IzyMdE60qLfguOZIbb97dXLIm7rbsYnevmbyOU4N1gU+vdS9wxSDo4LTWga50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Aaros2+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BW0jdEZv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Aaros2+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BW0jdEZv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 889A5EC03B8;
	Mon, 11 May 2026 09:26:18 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 09:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1778505978; x=1778592378; bh=iQNsuGY7VT886baXxMT0V5MdEf2D7cc6
	E0WyielT8KA=; b=Aaros2+gJu961S/azTNVEiePl+NBVmGZDuoW1m6G36ns7ZZg
	wYkvRcVwJYoCkbMmFAF2t+yHhTeDnwZuhN4llMex+1XMAdwaPJhWOffmqCQw36Mq
	URickPuqpIVBO63pYdFQNQwiPgRXrgzEYi7QPK7Orjt9frGf1iaJG6NmW97io/lR
	x2ybaLxaRq20drrunElIkGeX/vdzJmrpHtYfdCPXFQ9vxcvCZqnGq/oUwxmbNTE6
	Yijyb3bTpoHgH6XgjAAQ5YgGawmsP1JMxP2URB9/eANzD4MNiUWWT7KSE8xEFeg7
	R2WmmPQ5DSYGd6hYNiNgP7vrbGgbireKEU08dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778505978; x=
	1778592378; bh=iQNsuGY7VT886baXxMT0V5MdEf2D7cc6E0WyielT8KA=; b=B
	W0jdEZvanJFV/L5sRF4yhqPbcScQLyXfF4TMKmOYZYR9c0zknTwmnqlLBU44x9uR
	Nn4oISfZFF4WcPtf8OLVGuXFc5EByq35DD7yvDJmM7bF5ErOl2INTaTj0ZMSrtC6
	kvwdUoRmuLSoOU3jgwwzgxvgqVtOosZuPHtkHC1zJXBshLWRZyQeuJCb+Y/eJDPs
	kPhyGwUDbQlqfM8kUSx54U1JyDNDqNls3+h7MEPflbXai02iIdacVtgvkjiAhmdc
	NpTLLoSl23lk0sdGPekUEzP/yhPeUFDEII1ciUv4IK/d317eIOeg1wkKdx6c+iJi
	ZY0nYR9aTbiYjB5hRdtWg==
X-ME-Sender: <xms:-dgBajJZJJCiN_2aRheV_wBjAxcIucpLQ_-6E1ZNQKUFoZkmhgKumR4>
    <xme:-dgBah-6Q3mkVModDclIYob0pjz38UszT5WhenNwc56gOXlVNqlAMzQr0KRJ2TTQ7
    UWfnctk4jymV9ohI6k-G8oiU2P1Bp8RPNFQN9wEuMdD05cFn9jq2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepfeetgefhgeefveelgeduvdekteehieevffdu
    jeelgfduffffjeelffffledukeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-dgBahs0lyUbBf-Pb3RKmeo6I3bLYQlCD66wtNELMmeyP-eMFqsUEg>
    <xmx:-dgBast140uZCsrAGTFt100S4rF3jtEsQ-XHTJ-Tc3mfsiZhYJm_aQ>
    <xmx:-dgBanBlFTgqs0aLL6GQqwPTKEqmA4aF4-iyeZI0nu0BJVe_vi_0aA>
    <xmx:-dgBauM-LkwCaRDExHPmzA226ZXS0WCRau-2HCmYjug5Ul5_eb8M_g>
    <xmx:-tgBamdnZh6mM7dVoL9Gdd_lp0Qy7cCXgHHVoZg23VveFsI5wGOcBOSW>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8BB65C4006E; Mon, 11 May 2026 09:26:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq0cXLUbXG1o
Date: Mon, 11 May 2026 15:25:57 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <c3da244d-9e01-42dc-a4fe-98b2d1c30570@app.fastmail.com>
In-Reply-To: <V4_format-rev_new_builtin.6af@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz> <V4_CV_format-rev.6aa@msgid.xyz>
 <V4_format-rev_new_builtin.6af@msgid.xyz>
Subject: Re: [PATCH v4 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026, at 21:34, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Introduce a new builtin for pretty formatting one revision expression
> per line or commit object names found in running text.
>
>[snip]
>
> diff --git a/Documentation/git-format-rev.adoc
>[snip]
> +OPTIONS
> +-------
> +
> +`--stdin-mode=3D<mode>`::
> +	How to interpret standard input data:
> ++
> +--
> +`revs`:: Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
> +	section) is interpreted as a commit. Any kind of revision
> +	expression can be used (see linkgit:gitrevisions[7]). Annotated
> +	tags are peeled (see linkgit:gitglossary[7]).
> ++
> +The argument `rev` is also accepted.
> +`text`:: Formats all commit object names found in freeform text. These
> +	must the full object names, i.e. abbreviated hexidecimal object
> +	names will not be interpreted.
> ++
> +Anything that is parsed as an object name but that is not found to be=
 a
> +commit object name is left alone (echoed).
> +--

This nested definition list is malformed. I=E2=80=99ll need to fix that.

> +
> +`--format=3D<pretty>`::
> +	Pretty format string.
>[snip]
