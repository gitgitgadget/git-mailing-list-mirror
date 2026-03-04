Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B112238C1B
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632931; cv=none; b=LENPm1DEeF/2mJ8j5qiAhwZcPkOEPEyEoWAblpFEIQK5ls1hcQoOMmNQtRYNrZXi8OhTxrCRq5G4WBQ/dflQnesavg85vmdthIqNo0J8bpne6MWovODjtXZ3CTTOLXnVO7XvR9mN8+/+Q/QIsj2dxB1iWXKDETfYMbXiPULCQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632931; c=relaxed/simple;
	bh=epErQ980KlUcDXj3fP1s8hgaxWc9vPBFngg7/O3eetA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LgZ5pXj/1zoP2hDtkMaueJCrYmvTMlM3X6hEMmrdfi6vRbX/HPiuR5J2PEG5grzCLPq4aAQ7ri4ECLexSmG/nIzC1Tt4zJc6GU5xZvWFjwhAExjR3LDXGNbn7Qy97mYdJ7EtJ13TvCW00qVjgqLioZf7TNa00faIhb+FN0WTxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EaVRYMOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAX1KT8E; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EaVRYMOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAX1KT8E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 36591EC05F3;
	Wed,  4 Mar 2026 09:02:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 09:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772632929;
	 x=1772719329; bh=jgWJM9fXsQSsh29RxOyo2jNcmmyhfnfPRS1wY4xnRDo=; b=
	EaVRYMOw/yAMt2R/HxUEznczdV7Thh2mYamhhCqdwlt9+TAa/vIjouvgJxdbRLLL
	kOa359qbtNK9CM0UO2IQdUHUbzQIfMkMuedKDmyvcobOJcy10JJHXVL+TMzqfS+B
	wF44fvbtXqvLbTGFerjgNtXGzeyIF9/rqGIi4Cwmx6Ob4cbTRwIGbmOPMfAULxC2
	mYOmtobk1ot+gt9PfpQY5B7mSdpopcJH87V3JmyvbfcG9p2ugpgTDQiK26E7KpC4
	R98qIEVO64XKfNhwEeBGZiZUzVC91RRQMhTa7DquJC1kfm0utJKaOwlpFk7wJ6n0
	ga/3hg9G/0UYf6TlAFtpUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772632929; x=
	1772719329; bh=jgWJM9fXsQSsh29RxOyo2jNcmmyhfnfPRS1wY4xnRDo=; b=g
	AX1KT8EIobCdKUyhJorslhxsn3JLC3wfutFh11ZqiKevmJrfY1eegWl0eV9tWk6L
	eJPuI0fyO+HIOyAx/w5uEAcyDn46sN7/BFb/ePbuogcThK5G0tRwU4gs5gWu6YHW
	18ZOEuEFXxZscLkcpeUGNAbvfClc78+ZrCIwZ4DXxC8hNBkl9B3qSfxi0sActkx7
	v6Cz+RJOTJ9QDnXm/wxK9JElbkubQO+x78li0J/F/VXarFEUUZ1t0e2A/5PwItnR
	tlPlaZeWil9/QZjI3f7eqqVi3ee7kFFMmbA6I46S0fCZNdvPBMm5bYBMlJcUD5Wz
	TSfTs14sC2gXtrIt2sU+Q==
X-ME-Sender: <xms:YTuoaWdkfhq4GK7TA7dI1o3ims8BzG44YMijKKeJkaxuT9w0g9SDyCQ>
    <xme:YTuoabAdiJKCxLkqrR6zZ9UQ8QAu3fUWgaR2mLZtNDX0PALZ1GefwnRaocRwEu3Ra
    JN4s4lSFtWK1aThrXNXnCRtuIxeEiqlgDG8RmtejvCFLzRKLf4iBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtlhgruhhsrdhstghhnhgvihguvghrsegv
    fhhitghouggvrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sgifihhllhhirghmshdrvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YTuoaTwRchjhTRFijgJ_6_cgAoLPAXfSI_GdpvpMI3x5pu2q_4dnbw>
    <xmx:YTuoaVRcRkR0JluK22dlnxasEwPp601mL-irpWEfwq7l3lj6M2exKw>
    <xmx:YTuoaT9Wl2atL2nxRjyylPNrOs-61p0HMpbI3Ag6tT4x6YZjIprjzA>
    <xmx:YTuoabtQuKplNbpZ0SWfipyO-7_o-SK13CnHz7lo0fHR-denPsWlCw>
    <xmx:YTuoafdfhoIPXnw7y95EcfF0rYeQli7iuMUG8TvkwruKuWFe6kur0tZH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E535F1EA006B; Wed,  4 Mar 2026 09:02:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvjKe73Q8VX3
Date: Wed, 04 Mar 2026 15:01:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: gitgitgadget@gmail.com, git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Brandon Williams" <bwilliams.eng@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Claus Schneider" <claus.schneider@eficode.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <faf8622b-b960-4f58-add7-28b5e081afb3@app.fastmail.com>
In-Reply-To: 
 <8bfaa14d44e224c5f8a3cfe1a0c55e9ca9415a98.1770384180.git.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
 <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
 <8bfaa14d44e224c5f8a3cfe1a0c55e9ca9415a98.1770384180.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 5/5] Documentation: update add --force option + ignore=all
 config
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026, at 14:23, Claus Schneider(Eficode) via GitGitGadget=
 wrote:
> From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>
>
> - git-add.adoc: Update the --force documentation for submodule behavio=
ur
>   to be added even the given configuration ignore=3Dall.
> - gitmodules.adoc and config/submodule.adoc: The submodule config
>   ignore=3Dall now need --force in order to update the index.
>
> Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
>[snip]
>  	all;; The submodule will never be considered modified (but will
>  	    nonetheless show up in the output of status and commit when it h=
as
> -	    been staged).
> +	    been staged). Add `(new commits)` can be overruled using the
> +	    `git add --force <submodule.path>`.
> +		The setting affects `status`, `update-index`, `diff` and `log`(due

This is in `next` but: should be a space: =E2=80=9C`log` (due=E2=80=9D.

> +		to underlaying `diff`).

s/underlaying/underlying/ ?

>
>  	dirty;; All changes to the submodule's work tree will be ignored, on=
ly
>  	    committed differences between the `HEAD` of the submodule and its
> --
> gitgitgadget
