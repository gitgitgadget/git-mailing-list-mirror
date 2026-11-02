Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629902;
	b=TCUKQ+fbn/NoZkszXuatTDnTaFvj3Uqs60mJspSWQLzxXh27lYsWmR4S8ojPEeXgC9Pr
	 eGNCPL0x7uB+TV9nbacxb0Bjdseat80hZK4/T+J77XMBOF6Xd/nBv8aUaeei6EkfvfaEZ
	 Pv1ZdKDPtKmbQAWlCzbdsEfpceicIiVHg0HieE40X/zIWtAXOV4zg7tTyMmGTboBgWNbL
	 rS8CR+nF4gbBtBLNenH7k+niWvlIl+XZ+vOUsF6fEmutI3qwIIEXGlr5apQCJ2fRq63Lm
	 jnogUUgiXZfvCtAUp9abWipduXVqRF35kcQYN2B3R6soGbj5lsvBe1NifUYE1khmL1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=F44lYpg1mqH7Wk9+DJT14mreREJWKoyBNda4SgY5krk=;
	b=ggROfOufZb6B858i0wtPxjhgmolpYPK+N5Qw39azBsMN4ERgPMQDyOhtTcBFsPOQrirZ
	 vLyuD4kwdq03A2vblPArlWVdHXSB1RKV9Bn0IAz3HSywrAcHQtrOkcUqtwgOZwNG0Snwe
	 k4sUmcwvdyDfz/gf+FnoKuzmwoHHCnIfAFMVg2j9lNv0qL9eUAlg9bebbque9+49a2c5h
	 Rj5jtCxtEa7IiQE/yVb9DwAfgRoJqsIU4C4DlBdVTkgoilkKxadqxNowzYfyORsXrskfy
	 Aw8QWaQkrAGhokUkvvG3ViYsCO3U81FVNP3XipeFZsdl0/q9aGpweFN4PkpNpYjguXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="d4J/5s/i";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iEqsGXJ9;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501A606A33F
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2501A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d4J/5s/i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iEqsGXJ9
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5563D1D000CC
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:31:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 02 Nov 2026 09:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793629901;
	 x=1793716301; bh=F44lYpg1mqH7Wk9+DJT14mreREJWKoyBNda4SgY5krk=; b=
	d4J/5s/iPn9QyxCzgQnF7O2FgkU8Jab6nOqTEbiswu1H+g1iTcKFUOkzo3jrFAiY
	yna97akqLh/ZHLaWgNyAuXoI3Zn1RVbYt1zVQqkjGdkOpj5254Sc/xN8iTIGYOah
	fnjpTkCZMQLPrjk1fYZUPyz0QuAoKOOODSFwn8iNHiFXc57lbTVHdwlcYqiVphyz
	UYSDtxD0ulOVr+vgHsOpSWRUvBi96qaSBfNFMhMCNwro8K55+aA72b2/fnz7vdVc
	IRuDQupEtWwvuiFNXaBid1QOVFQjcPc+AW+gv0WvS8CDSOuWV0KM9aUt/P9TkBaH
	ha/DAn7n3hC4QS2cg6HNFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793629901; x=
	1793716301; bh=F44lYpg1mqH7Wk9+DJT14mreREJWKoyBNda4SgY5krk=; b=i
	EqsGXJ9jssmblAkw8wb+8GLg/Ke60Alo4FrbCCCKW15uPhe6uKBMUQYoEzKFMJ1R
	Loh13lnB3Sris6EHae9ndmacaepIDZ/OKCsBW/seKq21p2hhsbodmWfj9wQQnFyV
	iARC3JKbjgIWZqRlQVNex+HJhmqtOES2wHlXTMdKB3uCDU1OyencqDvex1wNC+Co
	cBL3eeFDJQeawcWqdV9X7ZRUp3yXoV7QuZUVpYnsXRxw4krWe9pi1Q5jmSHkq6Et
	9kxIwcdQy6wJJgWCgziu52qY6CuMr+bQn3EEJLp7y9OctMoKWphDY3veGruzDXkJ
	cyPCi0Cv6PJtyAP+N68Lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793629901; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:goiIAVadbqL1PWU/mf6P7IfK9o9tqzVYhwSovXs7DEkkARX
	4MBaYnbE7oPWXPBHMjnnC913gv6Mj9GB3oeopnvyFOaEqmtTskt3rh5Jp7NhvZFQ
	kpYtLwNX5Xi1VSmWiJ86rWp8C8z2pSvb55mciT9zPJX9cjXluSOWf1m1SDhNDmU8
	THGhx8ORMXecjbVtaAD8j2wGtH7q4vnFK17FEx1aNxV2wMTvvp3cP5c5ZZpYcj3/
	6aY6vzO6y5blYTN8VyN3IAQbQf9BXmCCe3dA7WUBqn0a75aR3Fau0aiQkp0/lv7c
	bBALZaApCRYkddEjKbXPm5VBYJ759L4AaA6pw2A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NCHfnqXEZ7D33Cg2czFCdvXrwiU37Mh36bsdBVxXbfI=:G/dMmk4ggH+zbK7uXmGnUlNbUb0slCKuhOhbOQ6FYdc=;
X-ME-Sender: <xms:zJ7oasC0q8IkLcTMAQ1RLMnGWF8dd-cnzQf0myuCTuvX8bnz3YpdiQ>
    <xme:zJ7oaiO38T_TJxgWCwCP23zFceOig843IqNGsIhBbfHe2gbO4XJAdhYtAkxoIxUA9
    yXqT2pVkbS16tXkGP9P2H4P-ofZS3BWuDrB6MRztEiIKx1B0GleYGY>
X-ME-Received: <xmr:zJ7oapbGe9v5yvo-SoBLD3kZsmpnHJ4m6AEaq2TbSB0aNUorYYoH7exj0f8NPqOvcsXG1A>
X-ME-Proxy-Cause: dmFkZTEUa+op8Vlj4YVPpkLVBsMWaYjZqpMJiidMzQfpOpJKm8bKbuPkHVA9vpld+CxLUE
    YvkWeW99ekRCJXk99Dgmu5CioZK8tyXKd59EmcH92WAD5n3bGMDBCr1vWfpmy0UjR3E40E
    rXv/iBkKaJgbx+21xB+kXhjMwpUuFNWlHD5mEjqXWF0M/naOuXVlaaMJ49A8jJd0+wJ7Ej
    1crjn6DwI3+KNs95iWLO5v2/RHyLoD9VUwa3LRDx5qZLCj1SyRI1sDuK/qmRGM4ErCSikJ
    FIGj652PjLe7hxEefws2BkrXEKLiR9eST5YIOYHGPStWhhcsx1/ofIk6swGhGVU/f+GTnq
    HY96uHcSxgUXYG7a3I6JZcayOdgUK9FlkJdpscQY6Ew0f6EutzHSS6PQ1FnYU2hd8aPjdZ
    9NSVIhFH7XJ6jqiBPahcnrhaagCiejgREpzD+RFV4jHHTxDq3BGFHxcqCvETdtfeGYMf7s
    iC0RZMmB+OHEZ0O/ZwqHPEBwbMomYho6QcZHAgqR1zg70V0008HP6kCRknFTs7w7E5Y8Qe
    76iqveqVEE/FmxZuZ+8WJeZZdoqaD2wDrGqSvNfRUGtHiG5j24h/+0fFbtYVWwLaA0SUqN
    iHKVZaCSJwOXxzGpjr0d4ArNIhG+QP+Z24nOOzmR4b/NISwGMEeJiMKptJYQ
X-ME-Proxy: <xmx:zJ7oapvBU7I7KqkDRyV9eqj3BTNQrSy8epYarhhxKTkFDC30gJxuZQ>
    <xmx:zJ7oajOA9Hios1JFNKsBqzs9mj1BQE3npZVqvtqFCsjFHVnxTb6dSQ>
    <xmx:zJ7oao6GfCMq1X9m_0aHFFfn_DK34n3CjwyhLJ7ezZ77W8kzZwESfQ>
    <xmx:zJ7oahRV2TkhkztxKSymkzQjEO56mO3TgJOXFowSYE9Odyz0iTGw2w>
    <xmx:zZ7oahlCOhbpP9ilzYI-Pxqt4We8CVfQJLglDyWwGHy6OR9amYt5itT1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:31:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 498f5535 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 14:31:36 +0000 (UTC)
Date: Mon, 2 Nov 2026 15:31:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	GGG <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
Message-ID: <auiexXLTwEIBF-HG@pks.im>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
 <auiBFhXI_xiBTPbg@pks.im>
 <CAHwyqnWXb6AOgK-tXzrZ5-=WYitv9iXv7N1R2JrvPJAXeCYoqg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHwyqnWXb6AOgK-tXzrZ5-=WYitv9iXv7N1R2JrvPJAXeCYoqg@mail.gmail.com>

On Mon, Nov 02, 2026 at 03:07:10PM +0100, Harald Nordgren wrote:
> On Mon, Nov 2, 2026 at 1:25 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Nov 02, 2026 at 12:07:29PM +0100, Harald Nordgren wrote:
> > > > > Is it possible that maybe the review process needs to change if too
> > > > > many things are getting stuck?
> > > >
> > > > The regular reviewers have been talking about review work being scarce
> > > > compared to contributions (contributor work) for at least several years
> > > > now. How can this be changed if there simply aren’t enough people to
> > > > review everything?
> > >
> > > We can loosen the requirements on perfect code, as long as it does
> > > what it's supposed to and doesn't have security backdoors.
> > >
> > > Many things like tests, leaks and linting are already handled
> > > automatically by GitHub CI. It's a good time investment to automate
> > > more, because it frees up resources long-term.
> >
> > Even if we automate more of it, that would still not fix our bottleneck.
> > I do no trust automated reviews enough to just merge patches without a
> > human review, as part of the review is also the conceptual direction
> > that we are moving towards. And that can only really be reviewed by
> > someone who is familiar with the project overall.
> 
> I'm not primarily talking about the review part, but about the
> mechanical aspects around reviewing:
> 
> You might point out that while the tip a series builds and tests pass,
> a commit has a test added before the actual logic was added in the
> subsequent commit. This is a class of problems that we can find with
> automatic tooling, and then the human reviewers can free up more of
> their scarce time for actual reviewing.

Yeah, I agree that providing tooling that allows us to automatically
verify some aspects that would typically be covered during code review
would be good. It would probably need to come in the form of scripts
that can be self-executed though as we don't have enough computing
resources to execute such scripts.

Ideally, we'd also commit to a cetrain machine-verifiable coding style
so that it can be auto-verified, as well. But the discussions around
clang-format never really led anywhere, unfortunately.

> > Now automation could of course still help us. For example, if
> > contributors started to self-review their patch series before sending
> > them out, or if we had a tool like Sashiko [1]. If so, the human review
> > would happen on a patch series that is in a better shape already, and
> > that would likely require less of a time investment overall.
> >
> > [1]: https://sashiko.dev/
> 
> Interesting if Linux is using that. Linux is our sister project right? ;)

Yup. I've been chatting with Roman briefly about this project and the
possibility of adapting it to cover Git, as well. He was quite positive
and mentioned that Google might even sponsor the infrastructure required
for it.

I haven't yet found the time to investigate more though, but I would be
happy to have such tooling in Git. It shouldn't be mandatory, and in the
beginning it might just be the web interface. But if it works well
enough it could even eventually be updated to send review responses to
the mailing list directly.

> > Granted, at times we err too much on the side of polishing the last tiny
> > nits. But quite often that's also us trying to train newcomers to write
> > proper commit histories in the first place.
> 
> Yes, this is a bigger issue than I think we understand.
> 
> The Pareto principle (80/20) generally holds for things like this, and
> maybe the last X% of code improvement is not worth the (100-X)% time
> investment? For sure it's not linearly distributed.

I guess that part of the problem is also that a shallow review that
focusses on stylistic issues is way easier to do compared to one that
does a deep dive into the underlying principles. It's simply a time
tradeoff that reviewers need to do.

That does not mean that those are meaningless though. As said, the
benefit is also in that it allows newcomers to learn, both on the
contributing and on the reviewing side.

Patrick
