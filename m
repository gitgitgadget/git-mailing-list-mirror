Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1730F927
	for <git@vger.kernel.org>; Mon, 11 May 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493693; cv=none; b=iDWv5zu05a1VX3KmCnDno5YzLo3BXfCKNGQFSlJ7WQgeCQiqzwUh8BwKB+x5PuFZ1RTe86MFEh1MK5EEen2pjN6iSgdi0mOEqglM5HzyR6Y4z0SR4stmbmQ04eUlEg7CjNB5FEGDSu5ch6Jk5fxjW+58Nlf8mAX7D0VR+ufGLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493693; c=relaxed/simple;
	bh=hFQB87u1CBilP7AIBviVmkfV8u/HtOBp1NUvAbpKkkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHuJta/QqQFbWqsui0lOZ3HJ7y9AFTjZGVbf4GB2IJJzH8Z9azTsvKkTqKXIlIHW3VzA+sxNQzIpq5P0fkDcbHgNbfN5f4cTkaesbs3AOd26MJgOU8brXPhfRwiKD+TnZFNRpr0Bz4nTEMFNKTJW5zC6oD89tDC+/VIGGzvT8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Px2kvNBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C463eiGi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Px2kvNBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C463eiGi"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D288FEC033B;
	Mon, 11 May 2026 06:01:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778493690;
	 x=1778580090; bh=XYapDJ5V3Ov+Fr5Z5beYQryJiLOnB8EaolzP05vo+uc=; b=
	Px2kvNBDoA9CbecNE7Yd6jdBO4UlqKA50B96GcrXjdxBsvCtIxbqu1E1SpVUdzy8
	6mhgzOLIhQWfNybNYesN/IQVRG7lZNZkjK2Sd+NjXs2Iv5oGiHZGKkDmxniemqCc
	iR8sJngXLEmRk8/vPyJ2AelBKtWJnV7olvO/ILibQxtHQ53cdQQSOqL1wQK2Snp8
	Be+XTXSlQ4hvv1R0YHsGLCpdpCcLHZAYZGlAd4gEyYfCEzBupdtkOtTTZELttycS
	0OL5ncPXJeTy+aBnegd0lakXa+NWsPrWN0YKbJPFT+AytUxrwPE7GFo+iGN0F3hF
	/hvOWqUEaou4tK59Kkquzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778493690; x=
	1778580090; bh=XYapDJ5V3Ov+Fr5Z5beYQryJiLOnB8EaolzP05vo+uc=; b=C
	463eiGiv1PmVANuFtrYr4k5tQ6DRP9QhEyskuHNQDld4Gyml942hxm6IMybu8ho4
	ad9O++9j7ghl5pJJqXc3ZZueRKhunYpvnTmX9D5TcJn9lCm2lPtzsaCo74X8U415
	gegckhpueWq9o4UFE9q6C1ZqjwdAjrZSlmxuNMuwA/rMq0ftlog1jMqfbJ1fe3XX
	tseH5Q/ZmGt33X6hZWWZlnLgGP1o9hOI+Ak6pX9QSYJWwEO9pYZyVm8G6c4TW2sJ
	dIz3XPmh7mcWbLfWOYe4UoLqqYbGUd+HK+G0xiJgaIlVzd39HbQnggiLecVibkf5
	DFS1KXNBoS2OtQ2SoXbfw==
X-ME-Sender: <xms:-qgBarhBhsOQeYVJvJQWUIYPJSc7Twr52a1Bkb6YMDUfT4JO-PvJ9A>
    <xme:-qgBavdCp7YbWQSoPrF-Qux1x_5HdlVWC0mcnl_CZejRDQgdu2ffVU1CKuGSkJ1wW
    ES8f0fOTxnPOplhDegFfiJCEpNvrQ4m2hrsxn8PxmdDC__m0Igplkw>
X-ME-Received: <xmr:-qgBaod1ky1qGKEh5qQIenwMvUDIQjfUMmUfpeLJxeewZsGo7d830LNWDkMQcSVPuEdyQrNcIDqN9uYsDSbTpIRMGyMaVgpsSf52NwAi6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvrhhgsehthhgrlhhhvghimhdrihhopdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-qgBah_YnjbpjUq7paUMc-4FQadF65wtkCuRSdxWjEfThlIAkSzcOA>
    <xmx:-qgBaslaw4BDezarvWCRlHIHrM7_5fZ9M-0QHFSf-r-J9T8kbUn5ng>
    <xmx:-qgBar--m2DoEqcMJ1bXLOc-3fA-hpmmyaPRvVzizjawigf55Qb7OQ>
    <xmx:-qgBainblvf9h0Lopd0Wek8Gst07mHjsA1IyNRBW0eGPwMRsEnrhbQ>
    <xmx:-qgBanoeOOqQlMJfUe4ePFGXskzeNUO4_ne9gSVaEZ3ZwF4SJZW23tpF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 06:01:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f8125f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 10:01:27 +0000 (UTC)
Date: Mon, 11 May 2026 12:01:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?SsO2cmc=?= Thalheim <joerg@thalheim.io>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
Message-ID: <agGo9Prt8Hs2gbic@pks.im>
References: <20260403100135.3901610-1-joerg@thalheim.io>
 <adYvSZeN0ZVqwRhi@pks.im>
 <xmqqcxz2vfpa.fsf@gitster.g>
 <91335804a092b09757331cac72092a3835020b3a@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91335804a092b09757331cac72092a3835020b3a@thalheim.io>

On Mon, May 11, 2026 at 09:06:00AM +0000, Jörg Thalheim wrote:
> May 11, 2026 at 4:32 AM, "Junio C Hamano" <gitster@pobox.com mailto:gitster@pobox.com?to=%22Junio%20C%20Hamano%22%20%3Cgitster%40pobox.com%3E > wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > > > This bites in practice when running `git worktree add -b` concurrently
> > > >  against the same repository. Each invocation makes several writes to
> > > >  ".git/config" to set up branch tracking, and tooling that creates
> > > >  worktrees in parallel sees intermittent failures. Worse, `git worktree
> > > >  add` does not propagate the failed config write to its exit code: the
> > > >  worktree is created and the command exits 0, but tracking
> > > >  configuration is silently dropped.
> > > > 
> > >  This very much sounds like a bug that is worth fixing independently.
> > > 
> > > > 
> > > > The lock is held only for the duration of rewriting a small file, so
> > > >  retrying for 100 ms papers over any realistic contention while still
> > > >  failing fast if a stale lock has been left behind by a crashed
> > > >  process. This mirrors what we already do for individual reference
> > > >  locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms,
> > > >  2017-08-21)).
> > > > 
> > >  Famous last words :) Experience tells me that any timeout value that
> > >  isn't excessive will eventually be hit in some production system. Which
> > >  raises the question whether we want to make the timeout configurable,
> > >  similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout".
> > >  ...
> > >  Honestly though, I'm not really sure what to make with this. We could
> > >  of course also add some validation that the configuration we want to set
> > >  hasn't been modified meanwhile. But that would now lead to a situation
> > >  where we have to update every single caller in our tree to make use of
> > >  the new mechanism, which would be a bunch of work.
> > > 
> > >  And adding the timeout doesn't really change the status quo, either. We
> > >  already have the case that we'll happily overwrite changes made by
> > >  concurrent processes. The only thing that changes is that we make it
> > >  more likely for concurrent changes to succeed.
> > > 
> > We haven't heard any response to these points raised in the message
> > I am responding to. Should I still keep the patch in my tree,
> > hoping that a responses may come some day? I am tempted to discard
> > the topic as it has been quite a while since we last looked at it.
> 
> I am not really sure what you want me to do here.

In general, the idea here is to engage in a discussion that can
ultimately lead to one of two outcomes:

  - The discussion surfaces an area the author hasn't thought about, so
    the patch is adapted accordingly.

  - The discussion shows that the author already did think about the
    issue, but hasn't documented the assumptions. In this case, it
    should be the commit message that gets adapted.

> I don't see how git can have this value configurable, given it's about
> reading the configuration itself. Is the user supposed via command
> line?

This is a fair point indeed. But if it's not possible to change via the
configuration itself, then the next-best thing might be to introduce an
environment variable that allows configuring it.

The other aspect that wasn't discussed in the commit message is how
concurrent writes are handled, both when they are non-conflicting
(updating different keys) and when they are conflicting (updating the
same key). After spending some more time in the code I think it's
ultimately nothing we have to worry about too much, as we only start
reading the configuration after we've locked it.

So in the semantically non-conflicting case there isn't really much of a
race, because things already work as expected. But in the semantically
conflicting case it's a bit different, as the latter writer will
overwrite the result of the former one. In theory it would be possible
to detect such conflicts by:

  - Reading the configuration file.

  - Taking the lock.

  - Rereading the configuration to check for conflicts.

But even that is racy as the first writer might have succeeded before we
read the configuration the first time. So I'm not sure whether we can do
anything about that in the first place, as the race basically exists in
the outer loop controlled by the caller.

So there probably isn't much we can do about that, and unless I missed
something I think your timeout is sensible. But ideally, such nuances
would be discussed as part of the commit message so that reviewers and
future readers are made aware of them.

Thanks!

Patrick
