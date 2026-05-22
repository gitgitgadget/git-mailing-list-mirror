Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415D935AC1B
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466903; cv=none; b=FCLVWaWI/jGWklYEv77EVq4oCY3Kgz0yVUJhnm99SOybT0eZBtc9VRtrNkcXyXIXSR0vaTjBC38TJeVlwjQON+sWLhDon2CR0NG8Q1+k+/K5HS+3j5CI3WCtU8erBxk000whxn+InOwpXvWffQ86WboIBfCeNXiHRDhMubkZt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466903; c=relaxed/simple;
	bh=Mj3GJ4Hv+dWZCzp7y64cW5b7b4J+SjX1CVIQVlkqVgQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TDk69OSNk7n35tO4deiWFYQqCwlH4pKfLWVK/3RsZE15EJQ0pbOyNr7xkf2jtppiK6oPJltM2m2Pnb5eW3FYq1VJ4Dc0SYfOSVBKYfAODT//3zESorW/lZbCF0lXLxFJ2JvuDragY7iZ0wWiSmOgy/cgSAh8/I4Y8bjCZPLYKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p0ysvD4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiSjLTjr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p0ysvD4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiSjLTjr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12906140006F;
	Fri, 22 May 2026 12:21:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 12:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779466896;
	 x=1779553296; bh=96KvQjibT2TSf5cOA6KOR8RwTOBsECzuHwo7JF541EY=; b=
	p0ysvD4puDqLOV0f8xeTq9aMErFbomiX9q477yxpnRMMQLvSFQAKgMuWVGnhfrtk
	6cBhi3SiNF8oL4OjWEtI+Kl7nr16wF+RlFygn33nBHA9FodsGjex/1kmsj9NzSi5
	lrjkhSPNonv8+kCU3e+1OGYbhEZN/9PGjFrAzB8LjHhNvJZ6kDfdcGaRR6N8h4To
	hl/0HWN3nocBnFGHbRwxs/gszxveQpG2VcMdB3Th+vWdLHCgnypC/Um4c7unkWOg
	zSITubxyQ+h0sEQwkVfcAKbGY/OHf87z2FSiqwMDk9MacrYWM0qF4kdd7kd6qOTX
	nXKJKlvWt/3vULMRFL4CzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779466896; x=
	1779553296; bh=96KvQjibT2TSf5cOA6KOR8RwTOBsECzuHwo7JF541EY=; b=f
	iSjLTjr/Wk79Huaol2H3e+LH7PBrV+eKVANndbPz06SJ/YIil1sBOdVyGsr0SGfE
	QzotiBF8Cp7FSzacpQXImKo+nvLuqafkzoSltS6mpdzUJAN19xfDUVWkZHdkcfCB
	Ys3EUEKM5nsF46Bh6sgnO5QZvocXSBAXh4cJtFsilqjTVXxAyHGcWZsCPsC+JDWU
	0ZPPVpIy9hefS7uYwqqGL8Hq8zplhH47v4UTo4iVGozuDF8QEnl+10wnRQ5y6YLN
	mJR1n7Oo22aARAIV+vr7tNoxqIwAJnLZvmbIy6Lf5y9f6l2kPPjTGcs6gogUb+cZ
	pQuVZezJ4LPJ07hh4qfUg==
X-ME-Sender: <xms:j4IQah1ST46KMebBktlQmbYRHZuZ_yAw7YpEVVzc8jv36nZvB0f--3E>
    <xme:j4IQai7Y1o8b3o0dvE0TeWcE6bxsGxj5-9rUpjfrCrOAYeQqavrnby_htwwB0BznV
    dPcUC3LxxY9Xhv35hk-EpoumlBNfeVFy0WrX-mwSvbztyYwB6RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehudfgvefgfefgffdvhfffvdevveegheehudetvdfgueffjeev
    jedugeevfedvfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehhihesrghlhihsshgrrdhishdprhgtphht
    thhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:j4IQancaR0uf6oKMKV5fYJpj9dt3FV1tWJJfbvu6AjnTaqbpBbcdBQ>
    <xmx:j4IQarA84V9whfBPYlafMz0yEpNKbL0xkBSPwGjogAKe-0d0yJgp7g>
    <xmx:j4IQaq8s7m7r7Mfp2FofH9taIuck2KgrEQNA5ouKvZbFr4lnL-T0_Q>
    <xmx:j4IQamKOeHkqojQ9i3gADTJzmrdGGJLPzDYm7NKudTFfCM7kOl4WSg>
    <xmx:kIIQamSnTvmDHI8hvbI1bfUCvmZ2XqFgjheTWp5IM99nRzeXvc-01tGY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6D093020073; Fri, 22 May 2026 12:21:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADHeAfI0scng
Date: Fri, 22 May 2026 18:21:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Alyssa Ross" <hi@alyssa.is>, git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <60a0ec9b-0263-42f5-83b1-c55275c7772a@app.fastmail.com>
In-Reply-To: <20260522154418.5883-1-hi@alyssa.is>
References: <20260522154418.5883-1-hi@alyssa.is>
Subject: Re: [PATCH] receive-pack: fix updateInstead with core.worktree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026, at 17:44, Alyssa Ross wrote:
> This used to work, but when push_to_checkout() started being called
> before push_to_deploy(), push_to_checkout()'s side effect of adding
> GIT_WORK_TREE to the same environment that would be used by
> push_to_deploy() wasn't taken into account.  Fix by only mutating the
> environment for push_to_commit(), rather than the shared environment.
>
> Fixes: a8cc594333 ("hooks: fix an obscure TOCTOU "did we just run a ho=
ok?" race")

This project doesn=E2=80=99t use `Fixes` trailers.[1] Mentions of commit=
s go in
the commit message body (outside the trailers) using `git log -1
--format-reference <cmt>`.

The Linux project has uses for this structured information since there
is a lot of backporting of bugfixes. But I haven=E2=80=99t heard of a ne=
ed for
that in this project.

=F0=9F=94=97 1: https://lore.kernel.org/git/72839071-153f-4306-a705-3be0=
dc203109@app.fastmail.com/

> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>[snip]
