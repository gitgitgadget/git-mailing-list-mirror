Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B72236EE
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572929; cv=none; b=NZBnVIFQ+d9442OOaTpVczkkIFoxWG0tFx78xjBwr/xLLC664bZc/UjImWxkx3t4Z+udBcSQFlV4osp56IOgDirYOssBPHyrzG4G79D4teLlP3S5SMQ6VxhuM6AOb7GLm5KluZ5xQlxZ4YP7iP6GRD1uBxsTLuh2wMqRn6gCDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572929; c=relaxed/simple;
	bh=9ZbCUe1XkEsvL6YR0isC2OX7AfE222J59KZvN+mvf5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qhA+Zwg+FVJfDEphZsYk6PVxfnQnLF52NMAw0r7QFizUUFnJd/Zv7m38emZ8UScbpe94UYquagGwVrZj3qdxsN1x+3BTpwz83bXUFrM1WLbglqJO08JzWSdSGQCi4qgnaaMosKBlQrNMFCasngSmVUI/6+MbXG6OMuplawe7azM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fxDUMg74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVdwPRZl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fxDUMg74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVdwPRZl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A4BC14001D1;
	Tue,  7 Apr 2026 10:42:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Apr 2026 10:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775572927; x=1775659327; bh=vxyY0g/+0j
	5kdHevd97bL8CZvj27kEi6FRY/yBNREFw=; b=fxDUMg74m4gF6Ola3iB8rzaebH
	/4Wc5T4jAlbqT7wIfYUE/47wV0yDlVB5hj/45qC0Rib4FNdV/n8wqEkJl90xj3fD
	ql0f9Da+LdP2ajUApzDkaB8pdBCtgPPRZWOM96Sgox1O8Whtt4F3dqNySqdg2CMG
	sR2joi9Qds1Gg9IO0bjVVAZsxqc6PkdO4sKU9g0f63eSGJ1MAFqsEcVjS2ySips0
	1bxQcxya7eCztp7Zz9lxJYlHqkYVOUrhbAGpBuPqm94vbAc3wENv/3DszDmIL2B8
	4k/dJcxK6EsKUrUjd0QoZRWKZuLgstpXqb80cm+4iqxON6iVT/Fr1uy5BVYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775572927; x=1775659327; bh=vxyY0g/+0j5kdHevd97bL8CZvj27kEi6FRY
	/yBNREFw=; b=UVdwPRZlfF3A4hOalNiM4w7sqRflyfhO2ZwtZqRlHeWvUbqBqU1
	KhVYfZvtd+NWrzQObkSFtKQXUC74YBfC8KFuViePXBhY6LZfq0kiaEVrLY2TxtuI
	G8vmAzsnXp285/BpgYdHXSrwwv4apnWhdAstCUzvO//LLXhic/Asd87sjmCeGaUp
	y01tOOJDfMPtLyuY4LiFEemsZcdp/sEn6+ikozhuJHKKI0KqTyRVCns2MCzxso4v
	l2FOvWxvJ7kNCUQLCU0VPsqNyDHlETJh7dPgZ55ewIsi2B0IFDvjFyImlxHCjJGq
	cgnoRyFL6sr8VxIA2GdlgkkwPOSoEPh+gRA==
X-ME-Sender: <xms:vhfVaVM1u4W_ZP9iH3bVCtq7BRRGMfMG1Nn9mVlPe0ehteLDLI2Pkw>
    <xme:vhfVaSVbV8xyiote3QOTz7sb340CK0nQ6WY-6phPvvk_Y4NoqMxygdEYqPotMCqYp
    m6zWUuOJ7a1NMW0863k0oF9OjkMHbFzpqQUwR2O6DH5-gOJTxOHsw>
X-ME-Received: <xmr:vhfVaaas90UghPPnVVsSEFPN_n6FR5XRHHY1D9xj53dSze5J9UdBwEe-mfqzt5yHftRfK5oaQqANThuKHCwIRdIgWP0voGOWOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomh
    dprhgtphhtthhopehmshhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehrvg
    hmohessghuvghniihlihdruggvvhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vhfVac3KAIgKUr8eCnF3Gx696hCMO8g-4bD94ZFIkq8E8E_nREF2Jg>
    <xmx:vhfVaWCMse1o8WrtHNeKsJzmp1E_YWGQaTOlyHZNe3wpLPHXLFnwmg>
    <xmx:vhfVaQ944ZT13ccyaEQ-kqJWB1E-s4-VhOUnAX1wUFuCYqnzQwgNWg>
    <xmx:vhfVaZUIlQbSebTcKU2Hx67XYiJsa6GbAspZkngAi4MizuJaDtDNzg>
    <xmx:vxfVaYcisvhVd2lpop1GaLW2WVYM_q2dC-cUxdJ_yrkJWGq-OP_mhB7s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 10:42:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Matt Stark <msta@google.com>,  git@vger.kernel.org,  ps@pks.im,
  phillip.wood@dunelm.org.uk,  Martin von Zweigbergk
 <martinvonz@google.com>,  remo@buenzli.dev,  Edwin Kempin
 <ekempin@google.com>,  schacon@gmail.com,  philipmetzger@bluewin.ch,
  konstantin@linuxfoundation.org,  newren@gmail.com,  tytso@mit.edu,
  rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
In-Reply-To: <adSO6zPwtFOWBcOw@ubby> (Nico Williams's message of "Mon, 6 Apr
	2026 23:58:19 -0500")
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
	<xmqqqzor76nh.fsf@gitster.g> <adSO6zPwtFOWBcOw@ubby>
Date: Tue, 07 Apr 2026 07:42:05 -0700
Message-ID: <xmqqcy0a7rya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

>> Format is one thing, but what it means is much more important.  When
>> is it inherited?  What happens when you split a single commit into
>> three pieces, which piece, if any, among the resulting three will
>> inherit thee parent's?  Should rebase, cherry-pick, and replay
>> behave the same way (IIRC, rebase and cherry-pick behaves
>> differently while propagating notes).  Etc., etc.
>
> Exactly.  I remember I argued that cherry-pick and rebase should have
> the same behavior given that rebase is logically a script of
> cherry-picks, but others had strong arguments that the two should not
> have the same behavior (something which is not hard to implement if you
> make the inherittance / non-inherittance an option to cherry-pick has
> different defaults for cherry-pick than for rebase).

Yes.  Even though I often feel irritated when I use cherry-pick and
see the "amlog" note not propagate when I should have used rebase, I
think it makes sense to allow cherry-pick and rebase to behavve
differently.  This is because rebase is a rewriting operation, where
the old incarnation of the topic is discarded (other than that it
can be resurrected from the reflog of the branch for the topic) and
only the new incarnation will stay in the history, while cherry-pick
is a duplicating operation, where the new copy is an adaptation of
the original commit into a different context and both of them will
stay in the history serving different purpose.

> That the value of this header should not have a format imposed -- that
> much is certainly the case as far as consensus goes, I think.  Basically
> it should be site-local, for some definition of site.  But the tooling
> can just treat it as opaque, perhaps with hooks to do any interpretation
> of those values.

And there is nothing to prevent us from doing all of the above (and
more) with trailers.  The existing interpret-trailers mechanism may
be lacking, but hopefully it gives enough framework to build on top
to allow projects to customize what they want them to mean and how
they behave.
