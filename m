Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51723231CA0
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728849496; cv=none; b=Ls631Ow+XFi9uots/IMXjciwXIybz0fl5n0nf27j+qMzVkqtxTHm/xnCpDORSGXww2IPxFmRGz3Lmk5ARoHzwAc+6YQZRYcuUUXhYnGK9BWOhnjMWBJsrvJBac+A1/8Aw1FxgYyIFXtP7tQW922YVp6oKMzltCDQFYm7PYnFDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728849496; c=relaxed/simple;
	bh=mkjIhvTpkXL/z5GbX+2b/AGhv+D+nII++1oY/maDORs=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=mi3oYZ2pMKep6cSR2XgC+b70YrEAQoWghx3Bc+QTAXY1zR30g7senBwfB4jlC/SnyYzZic8i1BjamyvXhUHfQZJt1CZaO1MhefMmTkFC0IYlMNCJ7lmPca/kT42BpX9jD56qEF/XvagL2p0SkYHla9SqnUrv5qHwRS7ewglJKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=TKqOLWOR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UtAQC+2A; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="TKqOLWOR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtAQC+2A"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 58C8813800A4
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:58:13 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 13 Oct 2024 15:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1728849493; x=1728935893; bh=To
	OEFyLN8PhhCXahOIaV0yNf6sYzv59jFElarGojwxE=; b=TKqOLWOR3YSSaDNWc/
	91Zqlo0P9lDJfdgSJT5yX+fILnQV/p5R0MUsRP53OiA389yB9H8m8f9MZy2SSDkO
	uP4pTYlfSoGH/CJ+BFcvLG2xZcQQxQSDbxTxx34nJVULlROzUvmkZ7VmulyQsjZH
	vswMvOUXlis2eAGVwB1ChXJfIJOvs5r9yB/+Wt8EB4YRXKD9dHkrMlxvD3ml3pWe
	XvkYCH5V1WAUGKD1vhP7pMRL7b/QE46+3sJPVYgRVpXvjT8/e3xl045d2QrGMQay
	zwsjqw6Q7JkDkD6tjuWeYFTqQJYl13B+1tWvc1SHbHcHgNh7oxE8Hv3RaMTEnLZb
	KlBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728849493; x=1728935893; bh=ToOEFyLN8PhhCXahOIaV0yNf6sYz
	v59jFElarGojwxE=; b=UtAQC+2AviMCn9vUoJTvd+42OgTmkHGFpWMUXVyxX4gP
	OFJwphZzBNcho9+1UlV3idizPfogcpxnkNGSSiT4IzKu2E0Gwd186SxDH7Er14mc
	boUEFT0TTzUWnUz/kXQuog/ReOfuBjblZZ179BGhcr1R3nAr5yh8s+8duj7XCpbh
	vzPlNUiPtEzrAah38nN3GsM1Bng+9GmYFSpnO5iMCkOIXtQVQ6Nel6RsmuLiKftD
	9Ql7Gd6GFRe5wzYvwgIZKVFl8yXOEqRRNNWbMtYfbHhDo303573jZbCGGr5SdBY6
	l8wPn4i8MkgrGYe5OTkYaLwr5umAR0r2GdDlbiGaVA==
X-ME-Sender: <xms:VSYMZ4sdj0hhlP4PAOsezzbg_-nbosBu6_GkGQls6RRdv2KtFbB6Sk0>
    <xme:VSYMZ1eSlIeigEmrdgvtUu6tRt-yEat9vAZ_q6BsUinyopA4lHbDYXImixlsqQPu9
    9M305Ir6AdUqcANhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeeftdektdetjeejjeegueefheeuvdetkeejgfdtgeefteeuveeuheff
    leelfffhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsthgrtghkohhvvghrfh
    hlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhnsggprhgtphhtthhope
    dupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:VSYMZzzRUIeT4G_uOnkUEZGfjXNqt6jq1-pBayQTq48Us0-g1FBfaQ>
    <xmx:VSYMZ7NqmGk9ExLFM-_pxo6aMcJLf2tVjW__jeI1VL6SlflX19UaKA>
    <xmx:VSYMZ48ECrkrzPBXQpUx2H30NXZqATa87HdQ62OecypD9U40narkaQ>
    <xmx:VSYMZzUHF4BRtslPGQ2KVTFhO3a9nJR3DoR1gBVbIyDJIc6BEpOSsA>
    <xmx:VSYMZ9FZWE0zEChazdHSq_-o_fI4mp6fcCfp6s4EKCFpGGMWQYSzp0PZ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19D8C780068; Sun, 13 Oct 2024 15:58:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 13 Oct 2024 21:57:23 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: git@vger.kernel.org
Message-Id: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>
Subject: =?UTF-8?Q?What=E2=80=99s_the_intended/reasonable_usage_patterns_for_symr?=
 =?UTF-8?Q?efs=3F?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This was posted in 2011:

=E2=80=9CWhat's the definition of a valid Git symbolic reference?=E2=80=9D

https://lore.kernel.org/git/AANLkTinsJkzYggMtNrLRv-qNxRncrXSe6A46Z=3Dd8x=
kw7@mail.gmail.com/

And the answer said that:

> Emeric Fermas <emeric.fermas@gmail.com> writes:
>
> >  Once again, by reading at the code I can understand how those comma=
nds
> > currently work. What I'm trying to achieve is to understand what
> > should be their recommended usage.
>
> There are only two valid kinds of symrefs right now:
>
>  - .git/HEAD, pointing at somewhere under refs/heads/ hierarchy;
>
>  - .git/refs/remotes/<some remote name>/HEAD, pointing at somewhere un=
der
>    refs/remotes/<the same remote name>/ hierarchy.
>
> The code may be prepared to resolve recursive symrefs, symrefs other t=
han
> the above two kinds, symrefs that point at elsewhere, but all of them =
are
> outside of the design scope of what the mechanism was intended to supp=
ort.
> What the code do to them (without crashing) is not the design, but sim=
ply
> an undefined behaviour.
>
> This won't change very much if we decide to reorganize the remote trac=
king
> hierarchies in 1.8.0.  The former won't change at all, and the latter =
will
> start pointing at refs/remotes/<the same remote name>/heads hierarchy
> instead.
>
> I vaguely recall tg abused the symref mechanism to point .git/HEAD at
> funny locations; it may still be doing so, and if that is the case we
> should extend the above list to cover that usage.

https://lore.kernel.org/git/7vsjvpq0jk.fsf@alter.siamese.dyndns.org/

This was motivated by a StackOverflow[1] question/thread.  Which should
maybe get an update if this thread reveals some new information.

=F0=9F=94=97 1: https://stackoverflow.com/a/5000668/1725151

This seems overly restrictive for this day and age though? No?

I only know that

1. Symref manipulation is a plumbing command
2. That means that you can do weird stuff without getting slapped on the
   wrist
3. The plumbing man pages sometimes feel inert, like they either don=E2=80=
=99t
   fit into a greater whole or they don=E2=80=99t want to tell you
   (git-rev-list(1) is apparently the plumbing dual to git-log(1) but
   all I can see is some references at the bottom like =E2=80=9Csee also=
 the
   porcelain git-log(1)=E2=80=9D (in a 1200 line page)

In conclusion: I might end up doing things which I=E2=80=99m not really =
supposed
to. Because these commands are unopinionated.

What I=E2=80=99ve done lately that might give *weird* results:

=E2=80=A2 Create a one-level symref (one-level =E2=80=9Cbecause it=E2=80=
=99s short=E2=80=9D)
=E2=80=A2 Then you might get =E2=80=9Cambigious=E2=80=9D warnings if som=
e branch ref has the
  same name

But what seems fine so far:

=E2=80=A2 Create a `refs/heads/<symref>` which points to a remote-tracki=
ng branch

This is so that I can

=E2=80=A2 Have a short name for some long-living branches (sometimes the=
y live
  longer than we would have planned for)
=E2=80=A2 So that I can rebase and set upstream on the remote-tracking b=
ranch.
  That way I don=E2=80=99t need to maintain a branch which just follows =
the
  remote-tracking one

Is this okay?  And what can you reasonably do in general terms with
symrefs?

Just as an example of something that is probably not fine: I=E2=80=99ve =
read
that symrefs are dereferenced only to a depth of four.  And then you
don=E2=80=99t want to create some contraption which relies on many level=
s of
dereferencing.

Thanks!

--=20
Kristoffer
