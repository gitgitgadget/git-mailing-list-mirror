Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E4329E4B
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968025; cv=none; b=EZPCaI/CRh7UEDgJ/lAM0tXBmX2oTBzi6qrqpdyu2mQC5p3OviZNDjr5QNK/CZvaiqsnZzi9pJHSWF1Tod15L92nuesfnPrhjb74N1azolduLnl2t6WFdvpxPZSEx8Lyo/pPh31vfhRevL3L/krkO9eeKhVQx0Uj3UWQwi6vQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968025; c=relaxed/simple;
	bh=ev6D3E3ZCifqHhRyCyvvrsMPeL2ubgDhkHQrqEfm0Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atKLIrg5mUNQBXdzhhWsIKH0FZ5J36F89AR/fcEfL+poH0wcLJPfKiMjeOFIAzmjqionyxYgWFvYVJJBUysKxmt92wzOB4eHk0247xknpsV7xWXRL374m+7ife5yS0d4SCLCfZqe5e2V+nl69H83kicm2kwCDVNTj7neAtLj9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEhcj+Ys; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEhcj+Ys"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso3212792a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774968023; x=1775572823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQEmUVjU0oL+GlBKs0K5739huuKDsXrmfpsZxw8bRDU=;
        b=XEhcj+Ys0oGz7Qf4PppnQkpsJvBfG0k7deQ2bSJkuvyB/k5fhBrOzr/fE+AjprVeGY
         UXQhlac/gMKxwj39HIipBzsramOD7jz8IZ54f4UVrXgKBKl/9vsGGAn7YYqV45LHERih
         ydtCxq4scEwhZwfse+pMC1SLJlm3NrqiWZMofc/MNMEjbRI5fZ0EvLLn6FOh7iCaU1+w
         gZMbpcS+Cm1VqnbyphEnVJqa6sh6et1NSDl1IN4uHWh7D5gdThJPtk4mZ6c9/3/qFvZy
         yJOoE1c38RaTLvP1a4RtVSa8ROYW1HYMyAmrTvLLQFA4E0//HdkbLNtYYN0+iDlqCowo
         KKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968023; x=1775572823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQEmUVjU0oL+GlBKs0K5739huuKDsXrmfpsZxw8bRDU=;
        b=M9Xc0jITo4IA9lyliDCDMPLZPF0ee8v/ZR71XtJSQ11YTbIntQiq3RNchytdWU1XE9
         nneZBNR+VbtJ+Qk5FspCqyg6clpmZL7vsdyj8d7XSGqhhowJcc4mYRRLbHRVgvwJ3vx4
         9+y3MFxt6jyafo0RRuk7uuTJlIeOaAT+QHXFyU1gpsP7vhNhpU7qFUmEwMGNn0BaCyEv
         nAPIagm+wRfL+u2OgJUHqcKx2tPMXwoAVW9Put4cWq4AI1CXrW3oC+ccDcOgx28ujs7Q
         mRhngiUXuB2rEC0ebXvFQovOKKzTOM4Uc5ahXpAuYl/Pf8n40oU5POda8rg7Ig3ZmOJK
         7ANw==
X-Gm-Message-State: AOJu0Yyt/TcV2KdYvlw/cfor8BoHin2HHpK4M/eR1BSJPeXxm+QkirWP
	viH4mvYyYlbuMOKxigIuiXbW4RsgiogAwRijLqVUjtkx8cZtDMKr2FoS
X-Gm-Gg: ATEYQzyUVLbc5S5Slrh/dTb3w4EjcghRUBLFe22sfibQsnhrowlNKDNyUyNVXPcpOI1
	hnYU0eCJ4yhA2gFeD7WkQaVVUHCPq6T7PuhCSN2rm0sWT0H7vW64q6RI7CvMZoLA31CtrOkUriK
	pwny8ViwIldS7de2AfXSVSvSL4YoeKMwiHFhV4803hK51eXbyj0+Y9ZNZcAbrD/8A3IH8kR/ipm
	/2akojtCdBsoYxwUq/VbjIIUyyZfRxT/twfj+UZJRtKtLf4FzTeakMTZlHzpi37gEdgbxhqWlS5
	7VQQnYGTTefdBLbdeanxCLIqCsfHHgZDQ4mYUKl4qUSdlE4/ALkHJ2oegvpz6QoyvNk859+CODL
	Ngcl7+AlJbcXLFTVXl2CVWAOZg/Bp+WpKTmPeukAVUhjrsV5AWZprnZ/4Q3BK17qUC8UvbhiGrb
	4VOEV3FbvQs+vZoV9S
X-Received: by 2002:a05:6830:3809:b0:7d9:f582:cb6d with SMTP id 46e09a7af769-7d9fad8acd2mr9111844a34.6.1774968022788;
        Tue, 31 Mar 2026 07:40:22 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a38a746sm8955684a34.8.2026.03.31.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:40:22 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:40:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] odb/transaction: make `write_object_stream()`
 pluggable
Message-ID: <acva5CfnflhXExh4@denethor>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-7-jltobler@gmail.com>
 <act8ZWi5On9uQptf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <act8ZWi5On9uQptf@pks.im>

On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> On Mon, Mar 30, 2026 at 10:38:35PM -0500, Justin Tobler wrote:
> > How an ODB transaction handles writing objects is expected to vary
> > between implementations. Introduce a new `write_object_stream()`
> > callback in `struct odb_transaction` to make this function pluggable.
> > Wire up `index_blob_packfile_transaction()` for use with `struct
> > odb_transaction_files` accordingly.
> > 
> > Signed-off-by: Justin Tobler <jltobler@gmail.com>
> > ---
> >  object-file.c     |  9 +++++----
> >  odb/transaction.c |  7 +++++++
> >  odb/transaction.h | 25 ++++++++++++++++++++++---
> >  3 files changed, 34 insertions(+), 7 deletions(-)
> > 
> > diff --git a/object-file.c b/object-file.c
> > index 4c797d6498..b1c97faef3 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1680,10 +1680,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
> >  				.data = &data,
> >  			};
> >  
> > -			ret = index_blob_packfile_transaction(odb->transaction,
> > -							      &in_stream,
> > -							      xsize_t(st->st_size),
> > -							      oid);
> > +			ret = odb_transaction_write_object_stream(odb->transaction,
> > +								  &in_stream,
> > +								  xsize_t(st->st_size),
> > +								  oid);
> >  			odb_transaction_commit(transaction);
> >  		} else {
> >  			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
> > @@ -2146,6 +2146,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
> >  	transaction = xcalloc(1, sizeof(*transaction));
> >  	transaction->base.source = source;
> >  	transaction->base.commit = odb_transaction_files_commit;
> > +	transaction->base.write_object_stream = index_blob_packfile_transaction;
> >  
> >  	return &transaction->base;
> >  }
> 
> I was originally expecting the upcast to `odb_transaction_files` in
> `index_blob_packfile_transaction()` to go away in this last step, but
> that of course doesn't make much sense as it now _becomes_ the
> implementation of `write_object_stream()`.
> 
> But should we rename to `odb_transaction_files_write_object_stream()`?

I initially held off from changing the name because in a followup
series I plan to migrate `odb_source_write_object_stream()` into this
same function and was going to rename at that time. It doesn't really
hurt to rename it now though. Will do. 

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index a56e392f21..584e8de36e 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -12,14 +12,24 @@
> >   *
> >   * Each ODB source is expected to implement its own transaction handling.
> >   */
> > -struct odb_transaction;
> > -typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
> >  struct odb_transaction {
> >  	/* The ODB source the transaction is opened against. */
> >  	struct odb_source *source;
> >  
> >  	/* The ODB source specific callback invoked to commit a transaction. */
> > -	odb_transaction_commit_fn commit;
> > +	void (*commit)(struct odb_transaction *transaction);
> > +
> > +	/*
> > +	 * This callback is expected to write the given object stream into
> > +	 * the ODB transaction.
> 
> Should we note that for now, the expectation is to always write a blob?

I plan to drop this restriction in a future series, but it certainly
makes sense to document for now. Will update.

Thanks,
-Justin
