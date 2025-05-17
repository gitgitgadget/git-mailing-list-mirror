Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C864B1E77
	for <git@vger.kernel.org>; Sat, 17 May 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747511608; cv=none; b=T3M161SGseCNw9ERt25Pz+1j4co5fwDGrqd9p/vtEzn3Ykx6tFaUXIv/8H769FmwikbW6kNYbwm3Poa4oqRsBh7M2rILMfJCYUpgiV+0J4t7TkqgUHQBIGf/PXXyauBqfkpbz7xOPS/Pn0drmRdEP0/kvr3XVLPYgYWfnp9Lq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747511608; c=relaxed/simple;
	bh=+WuQIQK0J1pyZw8uRtV+Baza7a2sJksiQctxaipHbMU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZT2bU/hjo1JwcdGUyB90Qjq3UwwFA4NM+BmMVDo3FVSUaqfGPqwPrt/FF7P94xg171u5Kcs/OVD3NxIU6LW8EDfgV6UmR1896rR94niZF1vCSPcMNTn4U/Puc1mkBez2znT3YauRcg4IjVg5U+No3r1/r9+Ma94wMYbSGXWPsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lq5AJqec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHBZce9P; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lq5AJqec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHBZce9P"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A9E1B1380187;
	Sat, 17 May 2025 15:53:24 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sat, 17 May 2025 15:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747511604;
	 x=1747598004; bh=1sB1cQOldLS5yjwQj6MqnXl4DPDUWnvV8ePB/Ez+A/I=; b=
	lq5AJqecP1MMQQZaiemIxTRJbeXn1kmOhDhrnU4CSA9Sce7CFd/B8EmH6mXDf4lO
	Ty9tohjlxKWHQ6qzv0Mvqedv/VJ5TotKTQ45f3bPA5JbWhMPwv+sPmgnXq4DhcWA
	gNWcSafxRuZsGlaJAjXJV3TQx0GClFKkDOfpHlxx2IJfBnAb2is1dAcvCFJTCWv3
	SbMYxVsn2+/dQvkEMB409BPl8uM5xZRzR5dh6UnrZwvykVWeKRFnx8sqxjwJBefv
	Kq5eWk420GaPSOq4tqR7O8Ev7JxhNM7McRBpFR8uTmugkhIKl2+zkiTtzEr7Wbsi
	w8Ua+gX/fHecJ+vPpjUdEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747511604; x=
	1747598004; bh=1sB1cQOldLS5yjwQj6MqnXl4DPDUWnvV8ePB/Ez+A/I=; b=t
	HBZce9PNkGu4mGSDMyAhwjryETmAY3DVoit4ASEfLBemOr+NwBlBbXb1VpA7Jvn2
	wy21kgjLkTSIYWIZo8fsqYnSV2WrHUpfZAJHTxe5S2G46kf69qFe6sFmyMdkTSpU
	Z95PY3ltYStYwJkLYQxRWDxRSXt0QsV27fV7644MU3HRKTggOP5kNU1hGOcGa9eJ
	IEkNJunVlOdrnsSHYlAs9EuLIj4qRx6njqe/5t7kcX5NlCH4lUlGIJRy+u8/QfIN
	rAxb+bHYR0nqdodTRgX1278KbIFPAqDqlUbhdsj097fh4M0DDtEL4gQe2n4lX3dP
	nMgJ1fG+9PBz/TGDzwxCQ==
X-ME-Sender: <xms:NOkoaDpS-_BxWOw8nkQ8lX5vVHKrHeOxjq8fPHgOW4GoefA0sLfMAVQ>
    <xme:NOkoaNo6UMhmzDZvmIEqK-A2BTXhDI1eX2TidMDrEUSDrkzkuCMX7a_4AtNpcqt3I
    JOJ6Kcq9SouleH7Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeihedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgie
    fgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NOkoaANDYaN-3mjKv_H5P7EnLUkYcpnMr8csh3w-fEPpiVQrut5kRg>
    <xmx:NOkoaG6mRZgM_kzLOX0FsD42u7eZqPtnifTNiDVHcVzdD2DJEmzkTg>
    <xmx:NOkoaC512nYQ2QG3UY2L1T8HZtnPeBtnr5T4J7PZOhbTgE0KwI6Qbw>
    <xmx:NOkoaOjUmUsQ8YyZDoZsvwK-h12Riqqp916slmsEnFlSCTk1dEWyvA>
    <xmx:NOkoaGRlNMHmSWE8dX-qP1yEP9ORfSOJ-DCRnxfpi7iH9-_hYe5dFgLB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71BE2302005F; Sat, 17 May 2025 15:53:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T370c812ec62578b2
Date: Sat, 17 May 2025 21:52:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <6cc85081-bbdd-43f6-b17d-8baffedec8c9@app.fastmail.com>
In-Reply-To: 
 <7c40d3c921610576dc7947bc4c517055717dd94e.1747425858.git.gitgitgadget@gmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
 <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
 <7c40d3c921610576dc7947bc4c517055717dd94e.1747425858.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 2/2] merge-tree: add a new --quiet flag
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025, at 22:04, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> +	if (quiet && o.show_messages =3D=3D -1)
> +		o.show_messages =3D 0;
> +	o.merge_options.mergeability_only =3D quiet;
> +	die_for_incompatible_opt2(quiet, "--quiet", o.show_messages, "--mess=
ages");
> +	die_for_incompatible_opt2(quiet, "--quiet", o.name_only, "--name-onl=
y");
> +	die_for_incompatible_opt2(quiet, "--quiet", o.use_stdin, "--stdin");
> +	die_for_incompatible_opt2(quiet, "--quiet", !line_termination, "-z");

I=E2=80=99ve been using git-merge-tree(1) for some scripting but only to=
day
tried out `--stdin` for printing refs that conflict.

```
# Pipe in pairs
merge_pairs=3D$(mktemp)
tee $merge_pairs \
    | git merge-tree --stdin --no-messages \
    | tr '\0' '\n' \
    | grep --extended-regexp '^(1|0)$' \
    | paste -d' ' - $merge_pairs \
    | grep '^0' \
    | cut -d' ' -f2-
```

(Previously I called the command in a loop)

I could imagine a `--format` option to just keep one of the arguments,
which means the tee(1) (for cross-referencing the ref) and all the other
things are gone:

```
git merge-tree --format=3D'%(if)%(conflicted)%(then)oid2%(end)' --stdin
```

(But imagined options aside)

`--stdin` is presumably for efficiency and `--quiet`/`--dry-run`
definitely is.  But `--quiet` can only be used in the mode where you can
only do a single merge, not in the `--stdin` batch mode.

`--quiet`/`--dry-run` with informational output (c.f. the above
die-for-incompatible) would =E2=80=9Cbreak=E2=80=9D the documented outpu=
t format since
conflicts haven=E2=80=99t been computed all the way and there are no OID=
s for
successful merges.  But the user is opting into a new mode here, never
seen before.  Can=E2=80=99t they opt into a new informational mode where
`--stdin --quiet` can co-exist?  Then you can have dry-run batch mode.

--=20
Kristoffer Haugsbakk
