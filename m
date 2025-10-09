Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832C2848BA
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048464; cv=none; b=ch9TjIdkf4OSKQjropcqvyTd/iEKS2rasOhMFbTDaVlSPjS0UflfJiRQ20EKxtCdqWWHdFoy6T/rnKJcEqcmNs4Mc5TykOCBqbziMwAOOL7bIuhVVhOyYeed/D/5MCqMhUCz0W+OhFOtnQ4JseCJpAGTK5YA9DbWYHuHSLdVtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048464; c=relaxed/simple;
	bh=BueN0BOVTYSH0coCwTX+eZotulZbxQa6bP6wvM8flpk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OXUxkXRoOF7LwTgCeTUn98YuvaLjfQngUg1y3E8Jp3eZCOJ1gE3aIX5nc1Up+yoWAj8laqMPNA4Ke2gqU/qfYxByZb5EB0wU61MC98RpR92w6Q9aH9z8U9/wxugECVLlxjp4jaDU4rsuRUB1HFVUijAiU4y9nS4iJiiotYdwF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SCt7vaIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bp7DBhjD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SCt7vaIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bp7DBhjD"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A2035EC01DC;
	Thu,  9 Oct 2025 18:21:01 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 18:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760048461;
	 x=1760134861; bh=rd8r0ROPeuPDUoLmpek5FerhOT9DAITH4L+jeFNmw6k=; b=
	SCt7vaIOGtTiQ0jWc8kAnKfSEJo3B1WVPmAqUXg98HbSLMWO8hsT/gPsUGRiEDjq
	/gU6LzDWPS7OOkW+cQm8UEuI3s2QdGygYoH+u1BugUht3tuKHOusMnWo6HHw70hY
	OqZUjsOpKsXvhiXzU+empGiNp/tbNXF3jcbSVtGy0rjR0pDCYQFkX9TcdVakdz+o
	ORkCLOGZVTLaXTg6XsymO/S58ezF+4ele0X0GyyYdCjMittnxdzwNigZg7if0IUJ
	u4M4x6LUSYW5ouYjqsdIBpttkPUIVRan0YGv/g88ylSf0spq6Kdxbsya7962IcL/
	ZFD6Tkdbe69+AwbWwm82kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760048461; x=
	1760134861; bh=rd8r0ROPeuPDUoLmpek5FerhOT9DAITH4L+jeFNmw6k=; b=b
	p7DBhjDJdnowBOu5+q4C0FEKgUqXr7kel9OXm4f96ZIbzVa9myA5nTieufF6qXmt
	IK2G6BWhrhWfoShNQXtph3P5uDrYOyaztMMb/Bpz4Zqt8sEbVx57RasbXRF4D5T4
	s1LCxOYOuGHhRVzDb2v5Xa1HkSFUa+R1okYOqQfmu1WABnwPIku/4t8y/8WbijYe
	8hFDQxIyhT4Bc9n9zmJpgYhGfckiPiRDg4v6smKa7Dahe+YuyyIrzD17MdkcgkAM
	Dw4+7rMZIzw5WEcR8k4J+y/IgWVdxDwv/QM8vpGphMqrzAU7cH1W/26ZyuK6gksl
	2cqlmGb3GpPrZgdTRovvg==
X-ME-Sender: <xms:TTXoaDzKEGlew9Yu06mEmNXcP5CX68IP6It2TRMOvLAIgEzRDrhn4eU>
    <xme:TTXoaGHXtiQE0E0DTqwlDrlzTQFyYjH8IJubGxJzCIibUSzIQQ8W2-YYfUGYNQgjn
    uUlVtPPb-ZA53T60aE8n514t4pj-qNnl4CDbB-KsQNzk84JO8abktE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptefhgfejudff
    iedugedtffejfeekfeetfeevvdejkeeljeetvdfgfeevieeutddunecuffhomhgrihhnpe
    hmrghrthhinhhfohiflhgvrhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnsh
    drtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TTXoaHeI9vHiTD8PDH9ksCyzYu31kC4Ib7GYjYgLXsvUWPIjEcHFYg>
    <xmx:TTXoaGh0NGj48AS54d0DG_9o66t584cg9r7lf7EA4Rp9nkPSEpQglQ>
    <xmx:TTXoaHzPQGWVL6R9M2e_cq1trTqZFZzrgjx0rFo6A6gbTaxmhY-yJg>
    <xmx:TTXoaKPegbRkKxJI_lHwuW_2zCOJl8dyf1XVMLbnq1kN0bfd2_A22w>
    <xmx:TTXoaLW6Rgx0TiSj6D4i74s1iwIRuKokyBr5TD_DhfJmDPIqWIL6Tfi0>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C40D1EA0062; Thu,  9 Oct 2025 18:21:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfozKx6wiI6s
Date: Fri, 10 Oct 2025 00:20:40 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, "Junio C Hamano" <gitster@pobox.com>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Chris Torek" <chris.torek@gmail.com>
Message-Id: <bf769259-af30-4b13-aa0d-36c244e7502c@app.fastmail.com>
In-Reply-To: <b432f1b9-804d-4249-bc1a-4f3629aff50c@app.fastmail.com>
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
 <122774d4cc8fa4e9184a0f82e9b6e562363ea433.1759951536.git.gitgitgadget@gmail.com>
 <xmqqqzvddqon.fsf@gitster.g>
 <b432f1b9-804d-4249-bc1a-4f3629aff50c@app.fastmail.com>
Subject: Re: [PATCH v2 2/4] doc: git-pull: clarify options for integrating remote
 branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 23:31, Julia Evans wrote:
> On Wed, Oct 8, 2025, at 5:33 PM, Junio C Hamano wrote:
>>>[snip]
>>> +2. `git pull --rebase` runs `git rebase`
>>
>> This technically does not integrate remote branch into our current
>> branch.  Rather, the commits on our current branch are integrated
>> on top of their history.  That may be worth noting?  I dunno.
>
> At least 2 users who read this also commented that they find the word
> "integrate" using, for perhaps a similar reason. Specifically, one com=
ment
> was "unclear if 'integrate' is a technical/specific term or just gener=
ic".

(confusing)

>
> My assumption was that the word "integrate" was meant to be a generic
> way to communicate "combine the changes in the two branches in
> some unspecified way", and that's how I was using it. I'm not sure what
> you mean when you say "integrate" (is it "merge"?).

I wonder if =E2=80=9Cintegration=E2=80=9D is like =E2=80=9Cupstream=E2=80=
=9D; frequently used but not
really explained? (see gitworkflows(7); one mention in gitglossary(7)).

I think Martin Fowler has the correct (useful) view on branches:[1]

    In thinking about these patterns, I find it useful to develop two
    main categories. One group looks at integration, how multiple
    developers combine their work into a coherent whole. The other looks
    at the path to production, using branching to help manage the route
    from an integrated code base to a product running in production.

Specifically the first category.

Then later:

    Branching is about managing the interplay of isolation and
    integration. Having everyone work on a single shared codebase all
    the time, doesn't work because I can't compile the program if you're
    in the middle of typing a variable name. So at least to some degree,
    we need a notion of a private workspace that I can work on for a
    while. Modern source code controls tools make it easy to branch and
    monitor changes to those branches. At some point however we need to
    integrate. Thinking about branching strategies is really all about
    deciding how and when we integrate.

=F0=9F=94=97 1: https://martinfowler.com/articles/branching-patterns.html

The point of *most* branches ought to be this: you need isolation, but
you also want to eventually integrate with upstream, the trunk, or
whatever else.

=E2=80=A2 Everyone working on everything at the same time is chaos
=E2=80=A2 Everyone working on their own thing in isolation forever is
  Balkanization
=E2=80=A2 Forking a private space to integrate later in a timely manner =
strikes
  the right balance
=E2=80=A2 (Then there are the dozens of variations of long-living forks,=
 private
  forks for the changes that you want to make but few others want...)

So I don=E2=80=99t think that

> "combine the changes in the two branches in some unspecified way"

is quite it, because the direction is towards one integration branch,
one upstream, one trunk, main branch (not whichever one).

> way to communicate "combine the changes in the two branches in
> some unspecified way", and that's how I was using it. I'm not sure what

... and regarding =E2=80=9Cunspecified=E2=80=9D: I suspect the contentio=
n might be
distinction between integrating the branchy itself (with those commits)
with replaying fresh commits (rebase). But I don=E2=80=99t know.

>
>[snip]
