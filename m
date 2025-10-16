Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A7314B70
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616731; cv=none; b=TC1OwDZULTNTbTe4mhHEcKVfhYfy474sv52/i9qkvI7xdT1kWqWqBKxHufo4jrZt6i+K37SK+ndSi7F1F87HMu3tSSxQ/fg/njfJ62maR2zNhdrG1BBOmQTMuHdH/mc/qi59+eT8/hOXs+VAwFu6pSJUK1+9vhTggOwO2ZSHRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616731; c=relaxed/simple;
	bh=zidogfYPL7og3N1XjqNuRvDHO+bJgdyI7xBjXJVy/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h10idiGps5ZLXjt+hgvxrbIKY0XMHgQyDNzSmOmR75g9oUVbOf/26DlIFwP72QyNEodPJKy5Onj4FMU1c4xKKHAxPQRlvUSTg/YfbQf7jPfF4aMn4YceZSDodsoRDNZvdvDUDO3Ovzp+n1c60StlOks2KHbbL5n5FDJCVyfqasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qSh0V2Kn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3gcBwIT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qSh0V2Kn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3gcBwIT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA6387A0092;
	Thu, 16 Oct 2025 08:12:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Oct 2025 08:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760616726; x=1760703126; bh=uDooysNGrj
	HrYnA8rPCT99ReSaw2yj0J6l+ZnB7Wt4U=; b=qSh0V2KnUHs3r1RyyQXfikKwsn
	dkzXziX0wDsPPxjT2mR8L5AYw1Q3UyOr686y8VmD16VhfVCcQQlU6TeenRV0mMb8
	OjhFilD5uHXu6OhRK5Vt6cXbtFefDjT08HbqRXc8nkOkcsSPQCVmzKX0OFTCio9Y
	b4GbICuz+JdSTrEml28YGsz9HIeWchyfwjAlfEs/ObjdrpXBaw8cBoaMQULP9iuh
	qtTq6tQj4IFUgq/Ze5DJEamx5MlavW4iEkAg4+xqtghp/9fVCPf4nY6kpKxZ2QLF
	eIZ2jgzKjZogWi1Y38rWN6p7byIuM08FEZig90CGsFWUnF9Q8S+K2vbVC+gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760616726; x=1760703126; bh=uDooysNGrjHrYnA8rPCT99ReSaw2yj0J6l+
	ZnB7Wt4U=; b=H3gcBwIT2aUilJTZ/zGHuysYRPgTHwiS6WXyDkePMf0sbqVuWeP
	lQpYzSfaEfttWdfDMj7iGpBa0GoiRm0oBYZaaB9NX4zrb1baOvvUpHw/1TUOpXDh
	MpuYYG+03cPRj5Bx1kPhRf6ttdCNeDDgq3TKykYvlHbEhEyDRctuKmvEEBtxjJp7
	PvSBom2Jy73iLGFfGhrK17DGIDiBLsccBcLHo9OQ6rCNniXotE5ftZ64oNiMLjr1
	dpIxQOB9A7sQlkTgOt2o4cKw8WuJV8LQmAg6/rCRAIpeuW5H5/719xHaiWde+Kak
	eNrcZ2Zh9tiC5b3xHQyf5dhihPBU+QQ4J9Q==
X-ME-Sender: <xms:FuHwaEuST0rSUZLbCMXj-qYYviJCs1Df5oWMdz4aDIyuihOj00wfoQ>
    <xme:FuHwaEu08jwUcuA5towALcReIIFUa6MabIaBQz-ZSpVqbJNstpFH9Vf7mlQV6EI-7
    XQ8sswcz26M6oVhUi55Ekk6UqAqsbEGNzXRyzg6OUQwY-TgJcbm>
X-ME-Received: <xmr:FuHwaJOpQClgD1NJpGLop-d_Z6eVoPQfi-jsBVasiLL4ghWkF7jp7pA-v6eYPtu9jz66-nXzy9UgwfFnCwZaOHiKE8KLQH4ClqTmJ5eM5zQXZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeivdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:FuHwaC3Bx-CMkxNenhG5C2c4i8Q54wAXZktS5YJEGjR07VLAB1ivHA>
    <xmx:FuHwaFMvqVLqyMNP3-XWheIOwEE0ZwMxe9VwlCwg8fBdI40UZP35Qw>
    <xmx:FuHwaC3C5DrEXVlamhbVzOvMQ0JfiHybTnoA9wQWi670fZj_ia6KXA>
    <xmx:FuHwaMHbhQQ18onPqQBeDuvUXxDrw-lxC-MjkKmToRpYh9HR_9vxVA>
    <xmx:FuHwaCr7vnKUXPVFc5OtI23kQU11r0pBaVj-y_LW53UmSqnf-N5vMUf_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 08:12:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a4af564 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 12:12:03 +0000 (UTC)
Date: Thu, 16 Oct 2025 14:11:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs: move to using the '.optimize' functions
Message-ID: <aPDhDG1kfja8dWXv@pks.im>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com>
 <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
 <aPDKzqT2YaG2NmEu@pks.im>
 <CAOLa=ZQGQ_Qan9PtE-akUpWwGg8j6y5xcKpyOpztN7bZp+rMvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQGQ_Qan9PtE-akUpWwGg8j6y5xcKpyOpztN7bZp+rMvw@mail.gmail.com>

On Thu, Oct 16, 2025 at 07:07:33AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Oct 15, 2025 at 05:05:46PM -0500, Justin Tobler wrote:
> >> On 25/10/15 11:25PM, Karthik Nayak wrote:
> >> > @@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
> >> >  	.transaction_finish = debug_transaction_finish,
> >> >  	.transaction_abort = debug_transaction_abort,
> >> >
> >> > -	.pack_refs = debug_pack_refs,
> >> > +	.optimize = debug_optimize,
> >>
> >> question: Was the debug backend not using either of these callbacks?
> >> From the commit message, it sounds like all the backends were using the
> >> optimize callback.
> >
> > Doesn't look like it. Overall I kind of doubt the value that this
> > backend has. I have never had even a single use case for it, and I have
> > been working with references extensively over the last two or three
> > years by now.
> >
> > Maybe we should just drop it eventually?
> >
> > Patrick
> 
> I'd be happy to drop it too as a Git developer. But I can merit in
> keeping it. It does wrap around all reference subsystem calls and if
> tracing is enabled it would log these reference calls. This can be used
> in bug reports.
> 
> However, a counter argument would be that these only track the surface
> level APIs to each backend, but not really the internal details.
> 
> Considering this and also the fact that we need to update the backend
> for every change made, I'm for dropping it too.

Digging a bit deeper: I think this actually _is_ exposed via our tracing
API. So if you run Git with GIT_TRACE_REFS= set it will indeed use that
debug backend. TIL.

So with that I'll reverse my stance and say that this probably makes
sense to keep.

Patrick
