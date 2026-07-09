Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2913E47B
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589953; cv=none; b=D3YP4Omm1vpNyVX1dyF9qME0AwUZZdKg4ibgcmhBubrK4+3KMmYHopT4UoY2BPXodVBXTYrqLpb62PCLVhz54RVOBXL7jbotg5n/RUrtW3J4k4j7ToFnGeV9/TKZTWSvB9yyEmDX5quKucw+HMHntdkYv5ub6naCS8VaMj1lD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589953; c=relaxed/simple;
	bh=kQwIkHzAVOl8geTojAvHy72R74zQhE2JzpAGDkU/Vsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4+Va1vwuYWxDWIw/dMFQve7rkO6f7tuE3NbVJCH3k30QUGdVWNHQwxBz0Fc4JGfqzCM4cX42HoK9FHFK0CPVrtWlx4e57tnnuLfYjESskx/yMwksMN5HViz6U3s0EaN0XsMbKEc4GcVOOBgGrqEPI4sJLelW7MVVLeULwiFu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AoOou8jq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvHkieNq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AoOou8jq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvHkieNq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B819E7A006C;
	Thu,  9 Jul 2026 05:39:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 05:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783589951; x=1783676351; bh=/ODezJ/kFm
	4y4nk8xwv+fxZRjBw2nyhZE0zpRjgCsoY=; b=AoOou8jqcovTk1NKuf9K0C5prC
	x+CoohF5EAT/9iEHOsvkrD15tNSrClzruGkgs8BZG+dSXJUjmFX1YZBHXnPSxhCK
	IamunkFZMm3Is8xOKzfV5EMNNkdX0uvjRf99QL/Ij/4bmNTTzKOhPd8IS0oyxORN
	+htfBdmNA1n/FhVABKrpcr+fYliANDO9aQlIp79oNQJu4Q55+92ZLeZ/Kn3+AO8P
	j5nYA+2dFqu1+UKof9oOZia4AR5Rly12dZrfsbu45Lh6En7khyYMj9WHcTTGkFBq
	/FyXlS4gyZlBmOB/K9nOiUraG8mQ1p504zxjLrfjR4fQlUtq07HW5oueiTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783589951; x=1783676351; bh=/ODezJ/kFm4y4nk8xwv+fxZRjBw2nyhZE0z
	pRjgCsoY=; b=jvHkieNqw6dUSGbdoLROLbcIKL3ujNcWwF1gdG2WpdmlvVkIsdh
	pjnDiVudyT7Fze1VtlGZQZ8lV8mUZYCqUG/lk6k43nuXIGyjWR9vP8x2HlKURcAm
	JB3LrIMqAEFWm2u7YYLcwqBqlzdmfd3FjX4KjezMqcdciIbPqCqowbcG2lEw35WW
	JvI+L3Q1OwBnUvUkX6EGrjoKZPKUy5O8YEDsEV18/qAeilTt1698MmKRtr2L0DvP
	HapchP4PQ5fcRGx1jGBYdFJ0NlwfzYVdSLjcv+J1n6rQsKWhP4P04T60uUyGyj+U
	JyjX+Mt0FHkeEb7ZOn64fLDZtRg3DbtUfFg==
X-ME-Sender: <xms:P2xPaqiz6wMLfQKy8mrWaqYcgGG_iWTbafLGkGr4dHdQbkzEBMBNxQ>
    <xme:P2xPaidmdm-rcXxodDhhtR391kZJIYYLgyLvMJTj44FMqgJ2TQiH04RVkDzItxJfz
    NdV2wDwSVDugz7vUaCV-pgsLVMhTkhbwXQ2C3ysCfBiEs-71CKRrg>
X-ME-Received: <xmr:P2xPaveQogf0mOsd35cpKv1M2cHmhgwXgMlJtUjPjAxT0SqkSt0tBDnnZm8exROVPyFu4ucUbMtw9KjxatGA4_kj4wmnxBGJmqao_Siepw>
X-ME-Proxy-Cause: dmFkZTGOksP55TLb5CHg9URKxxuvY7lH+GhlwrLgHsXqB8dwyukKEnjEj+gcaOiTl1B2WH
    LFnhZR9I91NnvKOP8+89jTgXKAcvDSBUqEDlIDSp25rBT0yeVMWpiYkMXPFnvC0UHmdVgG
    fccZXeys19ofZnCc7dC9ooZ8YMaALHMiC0FzhZufoN5oDI62RrxpEyBZECSYtxA4Qr1Wbv
    K/6RT2lfQU4VmBPeDrvlcSaLzIoi+3DO7qJ8q0dNeNlJslknbfJNre3ZuM/FNTFf9IR3RZ
    avgibVN73JEVvgSwlb6QwLJxeO8GZ1inVGAoZk6TYqApqZms/6gQ4Z2t+pGbVNH3/8xKaq
    GNLasCWZ5e7gP1ujdIfXPBrEgDLT0WhaA2gstVEcMxp7JfD2Z3Az7DXy+PmjxHUBF5AZPh
    BxpfpmTTxEEXMES9DYEYa+osy9u3l/GrYS9UbOFeZr+miXIVwvaPFqzdm71ERXI0X4u3uo
    +Tz5wwFheTy1E6gA8JinxLN92v/nxDU95VWZYAspCy7+IHJ61/bECzbRkzv/2bCgvs8QbT
    X98e4DVjPliRh42F+5FhWo0rxmbS22uG5MNwbvmlZxL9mN4wNB74RZgChjqIs8N1WQLXnN
    qd7t4jklLx0Q13L4Z2WSNze9afBNv30A1POq+dSAbFiyNMQrlgiCGXDB1vZg
X-ME-Proxy: <xmx:P2xPas8m9Az5HGDnejIwIuDsXhToEpD9awRGKBuPcoNjtl7eZ-j1GQ>
    <xmx:P2xParn7B5ITLs3uuHeVhTHVTaz3Gd3Z6Wd6exlVr8pV_FBahG-qIg>
    <xmx:P2xPau_kq-CiSl-NLj1VyWhQq8oaSq6BQjcv4yw6iMQ-GUiybNOTkg>
    <xmx:P2xPapk9BtUXhYt1KvmbTKYURbLgWHXvUP_8mkN4xJLiKBxzpgq8Fw>
    <xmx:P2xPaieny6KJVBDaK_dgRl8osh5MPMNyR-bKbuuydGebWE3QpjSuOkrU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 05:39:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 131434c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 09:39:10 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:39:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 06/11] odb/transaction: propagate begin errors
Message-ID: <ak9sOqq-WvZ7U0Hq@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-7-jltobler@gmail.com>
 <ak3xJFDqTSN1Naoy@pks.im>
 <ak57VEF56HkRKygQ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak57VEF56HkRKygQ@denethor>

On Wed, Jul 08, 2026 at 11:56:43AM -0500, Justin Tobler wrote:
> On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> > On Tue, Jul 07, 2026 at 11:14:07PM -0500, Justin Tobler wrote:
> > > @@ -490,10 +491,12 @@ int cache_tree_update(struct index_state *istate, int flags)
> > >  
> > >  	trace_performance_enter();
> > >  	trace2_region_enter("cache_tree", "update", istate->repo);
> > > -	transaction = odb_transaction_begin(the_repository->objects);
> > > +	if (!inflight)
> > > +		odb_transaction_begin_or_die(the_repository->objects, &transaction);
> > >  	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> > >  		       "", 0, &skip, flags);
> > > -	odb_transaction_commit(transaction);
> > > +	if (!inflight)
> > > +		odb_transaction_commit(transaction);
> > >  	trace2_region_leave("cache_tree", "update", istate->repo);
> > >  	trace_performance_leave("cache_tree_update");
> > >  	if (i < 0)
> > 
> > Callsites like this really make me wonder why we even care to create
> > a transaction in the first place if we basically just commit it
> > immediately anyway. And while it's a bit sad that we have so many sites
> > where we don't really know whether we even have a transaction, I think
> > it's a good change that we have now annotated them clearly. A subsequent
> > patch series may then eventually refactor those sites so that we stop
> > depending on `odb->transaction` and inject the transaction via a
> > parameter.
> 
> Call sites like the one mentioned above are using ODB transactions as an
> optimization to batch the full fsyncs in bulk. In cases where the is not
> already a transaction, they start one to take advantage of it.

I know. But in the case where we don't want to batch we create the
transaction anyway as far as I can see, and then we commit it
immediately. So arguably, we could've just `odb_write_object()` and call
it a day.

> I fully agree though that an ODB transaction should ideally be started
> at a higher layer and wired down to these call sites. I have a couple of
> patches in my tree that start to tackle this which I plan to send in
> another series. :)

Yeah, let's not worry about that too much for now then. One step at a
time :)

> > > @@ -36,11 +38,21 @@ struct odb_transaction {
> > >  };
> > >  
> > >  /*
> > > - * Starts an ODB transaction. Subsequent objects are written to the transaction
> > > - * and not committed until odb_transaction_commit() is invoked on the
> > > - * transaction. If the ODB already has a pending transaction, NULL is returned.
> > > + * Starts an ODB transaction and returns it via `out`. Subsequent objects are
> > > + * written to the transaction and not committed until odb_transaction_commit()
> > > + * is invoked on the transaction. Returns 0 on success and a negative value on
> > > + * error. Note that it is considered an error to start a new transaction if the
> > > + * ODB already has an inflight transaction pending.
> > >   */
> > > -struct odb_transaction *odb_transaction_begin(struct object_database *odb);
> > > +int odb_transaction_begin(struct object_database *odb,
> > > +			  struct odb_transaction **out);
> > > +
> > > +static inline void odb_transaction_begin_or_die(struct object_database *odb,
> > > +						struct odb_transaction **out)
> > > +{
> > > +	if (odb_transaction_begin(odb, out))
> > > +		die(_("failed to start ODB transaction"));
> > > +}
> > 
> > We could make it a bit simpler to use this function by continuing to
> > return the transaction directly. But on the other hand this results in a
> > more consistent interface.
> 
> Ya, I was a bit back and forth about this myself. I ultimately landed on
> keeping a more consistent interface though. Happy to change if others
> feel differently though.

As said, I can see both arguments. And ultimately, I don't care too
much, so it's fine if this is just kept as-is.

Patrick
