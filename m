Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9C171A1
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430377; cv=none; b=JBLJxiZByQV4SAAZEYAKau9ApfNGle/GVZ3sEfjZAPhq62LGgsiWgqscuh3tKXBKmdgcEMp3SkB+q6EjAY3x5G1fh5dz1YZXG1RRRuR4rCc96wlgxe3gk4RVWVmovozqxC23TTqbdbeN0J6dMgjvHJJ1MlhjJOyerpteLNkKaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430377; c=relaxed/simple;
	bh=J5nVqhgNdJfm9HKDz6KxaaFKEQRd4sqAtvtmKfdcojM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIgUID9Bz9g3eC0PEoJ1eQexwZZnJbCC/nCMQs2CoMlAdGoq9HT4Je35no5ntydE9dvVK89s+Idlq/sCWm7q4xM8gF99m7S2hCH4KA8w1BtvvCmeWtzmYBLtm8o8yRFlF76GQOpyN4NpXlulNV+wurAI2h5G5xBK/IhKywMamqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hdG4cFs3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXbfxcyQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hdG4cFs3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXbfxcyQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62ACA254020E;
	Mon,  5 May 2025 03:32:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 03:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746430374; x=1746516774; bh=ab0L8+jfDZ
	IczClS2sObiUVRh5Lo6N1ZVgonOLkQslo=; b=hdG4cFs37+m2mTc3WXZ4JdE8G9
	9SublTATjTc8de5deAbIiksFDzbb1G+dxiEjmFbT09YIAJq3H+JbGcjbKdoqvtHU
	YjihcE+Q2nfuaYp40lFQz94wRbJzP6g+XGQxxBXj8fMuJtaJhIW6ZxJl3sOZzrOF
	nnRWHoYvEVufTS8ptQuZaOwyHOUS9lOsgwU/HEbM+TWIrN1O2UDDSYHKfzZxEj6E
	9w6qK4xQ/Kk0QZEAZIxcu9GrPzcS9V5iLfHANuKLcb0NwnlrFF1p4emM7oBIZYfq
	cMQB5uINf94pbGaBJXPyokvfMOjpXQ+AAEZuAPACko1NtogaHNxm193Yp0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746430374; x=1746516774; bh=ab0L8+jfDZIczClS2sObiUVRh5Lo6N1ZVgo
	nOLkQslo=; b=lXbfxcyQTL8JEFcb8tFZMGUERWU9xducS48iPbLoav4idd7+CuH
	9FQlrZcHR3bppdrg6hThJfG9qXKJQp2g0nzs9Wt/s/4NGnPORuyXfQnS/XZCe2iM
	e5N0k36rQPD+irhOrNIH9Sgil1X+RhtfiCfkGatItegv1bG/OGgv+vR/ZvScHBRj
	pMwv1BMpVcW1+uM9bmqTFGiGN6jDSJuboavUPuzble7UXbX3ezF9iJ75sJgeD9gV
	VlgKbwCJe1AR6pY/Og2mHKQ7xKPHwlrD1mANvphfEu4ytXm5lptTzlWrHpGFT/sG
	AKSNsR4l7XDw+VmuzXAfeD3Umfb8ogJ1p1A==
X-ME-Sender: <xms:pmkYaIZo3OegCsND3HwhR-O_rPpMErwDonhb1Lz70ChT9g_SfZcKXw>
    <xme:pmkYaDYBP5apPsNqkADYrhlUmHp8LQpB6sIu4_abVER5eBNje_jLsWjmiceCs1xXx
    5DO1DtINM2mH5lhMw>
X-ME-Received: <xmr:pmkYaC9gEn1jyYWQKcMYU5bLjZTqwiEIKq8EyjwX5nc61gA1q8rE1-ur6eGsNbvlRB-ymmwPAtCpWdM4c2QPXYhFtEJLn79VhID7v75audG6oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepkeeftdffvdeuffeigfehgeduveekgfeiheeutdef
    ffehveefleefffetieetfefgnecuffhomhgrihhnpehrvghrvghrvgdqghgtrdgruhhtoh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:pmkYaCqadHXboNaZJgIEyqc8tMAEJbTGtT3cc1bsbS1-q6jHWl0RaA>
    <xmx:pmkYaDokI4y6MCAXNn4nV4qpD74TqxJ4K1fVpE1H1BD8AszE3ReRfg>
    <xmx:pmkYaAQl4W8gMXDVnQHWA4cbBQqc3iiWX8oROUn9VrFyFrgV1ah5zw>
    <xmx:pmkYaDrsa_QW5MDPZ_BB6Gh9uBfnuWBZmEyPRDyXygjAx197ZBf8rQ>
    <xmx:pmkYaHHMbUnaKzgc3LG4i1rI3zaT9bvqtZCvUGfhOKjN0x9yoZUjC1eL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 03:32:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e5ec437 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 07:32:51 +0000 (UTC)
Date: Mon, 5 May 2025 09:32:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] builtin/maintenance: implement missing tasks
 compared to git-gc(1)
Message-ID: <aBhpn3q-sgm3WjR6@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
 <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
 <d5307e82-8e45-4a2a-a8cc-03f84c2d5670@gmail.com>
 <xmqqo6wau3fz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6wau3fz.fsf@gitster.g>

On Fri, May 02, 2025 at 02:07:28PM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 5/2/2025 4:43 AM, Patrick Steinhardt wrote:
> >
> >> Changes in v3:
> >>   - Simplify the heuristic for "rerere-gc" so that we only count the
> >>     number of directory entries in ".git/rr-cache", without considering
> >>     staleness.
> >
> > The range-diff was harder to read than just re-reviewing patch 7, but I
> > think this v3 is ready to go.
> 
> I still do not think "configurable 'rerere gc' basing the decision
> on the number of existing rerere entries" adds negative value to the
> system.  If there is truly more than N active rerere entries
> currently in your repository with your workflow, such a
> configuration essentially decides to run 'rerere gc' every time (and
> without pruning enough entries to make the next 'rerere gc'
> unnecessary), and never otherwise.  It is not like pruning unneeded
> loose object files and packing the rest into a packfile, where
> running it once (even if it resulted in miniscule packfile due to
> misidentification) would remove all the loose object files, which
> makes 'repack' unneeded for some time until we accumulate more of
> them.  After 'rerere gc', you still will have rerere entries kept.
> 
> Until we can implement a meaningful automation (which may require
> changing the way rerere entries are stored on disk to help us
> cheaply tell if there truly are excessive number of no longer
> relevant rerere entries; code that we can readily borrow from
> "rerere gc" is enough, as I said), I do not think we should add
> extra code to make such a useless decision.  Instead, I would prefer
> to see a single "do we or do we not run `rerere gc`?" Boolean, until
> that happens.
> 
> Other than that, I think the series is a good addition to the
> system.  Giving finer grained control is great, and 'git maintenance'
> is a much better framework than 'git gc' to do so.

Ok, fair enough. I'll stick with the "maintenance.rerere-gc.auto"
config as integer, but will adapt it so that any positive value will
cause us to invoke `git rerere gc` when the "rr-cache" directory exists
and has at least one entry.

The reason I want to keep it as an integer is mostly to stay consistent
with all the other "maintenance.*.auto" settings, even though it does
not add a lot of value right now.

Patrick
