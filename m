Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2811DA62E
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423515; cv=none; b=MgjIgvHCJ6gRxBCFm5ObDNOxx21BnCCMT1lgIyGDdnFonnrj7XJsuDYZy0DMvcPPL+I8LElIcV9M3rCUEpbyrl4tYXPpvfW0lxtdIrfcfgUR6NU7pBSfvYdXrmQtekUSXjV8kg39COU7W/a1O0oXlUX7TdsC/+tkrR83Bdck7sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423515; c=relaxed/simple;
	bh=qO3SAIISjo6WRkrZf9Wsk9U492ZSF/vxeakejXvMF78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTKS0yv/o46qvEhxpGb+uPSAQdDWBqncKzZ5Z2ywaJsfOLMtsGLshsNc9dIgoXb2zYCNYViz8/g8ox88p1n+lpBAiOOrzsFY0RZbmaKxu6NnHloUa/6/M7OkevYdlGDXAMbqHsaNQqI54ZFcRiIh02DSyXT9dXO7HfXdVRi9s8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdm9oIwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CROjN6Go; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdm9oIwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CROjN6Go"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C7011D0004C;
	Tue, 14 Oct 2025 02:31:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 02:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760423512; x=1760509912; bh=+IyPwMkS1N
	cGfH5qarNStFQLppf7GLQ7sghx8p7C0Vk=; b=rdm9oIwGznkuxPfqMrWb4kQg0O
	XUIa/8tN2pmZ3A2EvphtKv3ZXRnlQ7C2D/63HFVk3Yh9b2j8E/pnQBV1FB5jpUeq
	t/WQ+AVmFjU3t4Qg07VnZO77NZ8RzZ0fjU/jmlP0u7JVru0844zAE0WffwZTUpr5
	3cGDTvGjTUZD3hTBAAu5l70HL0P6x6PMNP5fd8PA0t/SuY9s3hSkGWI/ZFTcwYOI
	VGYa7HyUcfrEXjnhxQLlJbKc2dBHy7VGBj6gZDbXT2+ZZWcTreUOytBaoo2andpl
	vKw6Gfi89zyvWIu3wy2oRdREDKs/ELiip+e2dMlGow573o7eoB076g8+Zowg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760423512; x=1760509912; bh=+IyPwMkS1NcGfH5qarNStFQLppf7GLQ7sgh
	x8p7C0Vk=; b=CROjN6Goe7BUETNY/7qq8H6uZbsyqDsrdJCEMNei1tAbvMKyxRO
	5uWbnkVjqvOW17yKCI2z+sDQQZ+nY27Jx0XmBGr1pgZqGAmG0rrVOenGQ7E+PPxr
	HcWxfLPE/vEKrS2L/ikq2Jqm9ROLWOQZpw2bGHbrwYQmhhlkSeJ5LVery7D2Hfme
	qg6BGUZVQvjwetDpdox+N0eiDb+0IiIVqWHEyoaikaUblpE9Gb9OUJRxRgbK+oOV
	t0Q777TsAPkUMKXFs8+h+zbITw0zd9N5OjC/JnyY3QK7SJ0mHs6yT0icQSwafuuA
	j1NJx6QkKdoE2ZrwpbdLwRS+Dmj0oHJxhzg==
X-ME-Sender: <xms:V-7taGgZo-F0GVP2RsQA_uu9lK4HvFuyv4YvWm5kx3le5StuWXszDg>
    <xme:V-7taJRF8zXcw0ojHF9uxn0kTKvIgjywkWu6CniNUpFgHfWikLRSe2d5osmdyEqTT
    pK_0_G9pnnnqZT9WleubBYHn8nIlc2odA4Ul9RdIa7nSES5L89AsQ>
X-ME-Received: <xmr:V-7taAV0y_DyzmI_DHzS2vet_h3qyQppPzDC4h9HAVcAbs5UC0LIRDonafelcNOQU7xIsdYpmGC-C0yJM1w4f7mczZFWdBtpT_xX9iV5lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:V-7taFRSKCpqcebrZ6ey3nlw4nADXLsNQZ0VAJ_xmBdRp13tnZCrNQ>
    <xmx:V-7taClaRzKoHljuq7jfbjxd9IjCbDFJo33vKxXTli6Jl3Q4Xsxc1Q>
    <xmx:V-7taD6Ze4FHjv8ZRhv1DD0OBNiwIdVC2KPdiuCAMxWq6pr59G8aOw>
    <xmx:V-7taAhPUKqSL50D_M3cDY7UB2TlhEyOGzG4QcuahyZcRN71YrpnZg>
    <xmx:WO7taCTE-lpJ2vipa-PAC4THleSHliWqcE5CJrKdj0kp1QxCqI1r59E7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 02:31:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fab2594d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 14 Oct 2025 06:31:48 +0000 (UTC)
Date: Tue, 14 Oct 2025 08:31:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/14] refs: improvements and fixes for peeling tags
Message-ID: <aO3uSz-idPWahgw7@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
 <20251009053825.GB1614343@coredump.intra.peff.net>
 <aOdRsR-k77uTWJRb@pks.im>
 <20251009063956.GA1622884@coredump.intra.peff.net>
 <aOdjM8F6WvTEBIo_@pks.im>
 <20251010051242.GC1897715@coredump.intra.peff.net>
 <aOiYFPTNLL1Fgz5V@pks.im>
 <xmqq8qhibwrn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qhibwrn.fsf@gitster.g>

On Fri, Oct 10, 2025 at 08:29:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > So to move forward, how about we land this as-is and I promise to follow
> > up with another series that:
> >
> >   - Renames `struct ref` as proposed.
> >
> >   - Introduces `struct reference` into more of our APIs?
> 
> Sorry, but I am not quite sure why we would want to do so.
> 
> Does "struct reference" sufficiently cover the things we want to do
> with references and "struct ref" is not sufficient for that?
> 
> Comparing what 'struct ref' caters to its users and what 'struct
> reference' offers to its users and declaring that one set of needs
> is more generic to the 'reference API' than the other set risks
> getting blinded by the area we happened to have been focusing on
> recently.
> 
> Apparently, the above proposal is not claiming that what one wants
> to do is a subset of what the other wants to do (if so, you'd rather
> not be introducing a new "struct reference" but extending "struct
> ref" to be usable for more things).
> 
> Or would we add more to it than what we see in this series, such
> that it would no longer be "a subset" of needs various code paths
> would have around the reference API?  If so, is the longer-term plan
> to have callers that use "struct ref" to eventually use "struct
> reference"?
> 
> If not, they are serving different subset of the problem space, and
> they will continue to do so.  In that case, why wouldn't we rename
> "struct reference" to something that is more focused on what it is
> for?  In the context of this topic, would that be "reference found
> during iteration" or something?

I think that `struct ref` and `struct reference` serve quite distinct
use cases. `struct ref` is all around references in the context of a
remote: they are only in our code that interacts with them like for
example "transport.c", "walker.c", "fetch-pack.c" and so on. As such,
this structure naturally contains a ton of fields that are relevant in
this context:

  - It's a linked list that identifies all refs part of such a push.

  - It contains new_old object IDs.

  - It contains information whether or not such a reference should be
    force-updated.

  - It contains information whether the remote side has such a ref in
    the first place.

  - It encodes the FETCH_HEAD status.

There's much more, and nothing of this has anything to do with a plain
reference. As such, this type would be a very bad fit for use in the
"refs.c" subsystem, as the basic concepts are mismatching.

So what I'm proposing here is to introduce a `struct reference` that
really only cares about the specific concept of a plain reference. That
struct would thus only carry information that can be yielded by the ref
backends standalone.

The benefit is that it allows us to have a better abstraction boundary,
and it allows us to achieve things we cannot easily do right now. For
example, if functions like `refs_read_ref()` returned such a structure,
then we can now also peel such a ref with `reference_get_peeled_oid()`,
which is currently only possible when iterating over references. Other
higher-level functions like `reference_is_branch()` or similar things
can also be introduced. Last but not least, it also makes it obvious
what kind of "thing" we're working with in many cases, as a `struct
reference` will always be the fully-qualified and "raw" reference.

Hope that sheds some light on my thinking :)

Thanks!

Patrick
