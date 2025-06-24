Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED22770E2
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781444; cv=none; b=f3zJOc8DCpAD14OtK6VXEsAfy/VLAk4nYwJ7ZMVwxTK4iwzHJ96q1I7d5BYnT5Zigpx3ZtqbCEX9NUfXA7OMtoPJkfBjQS3IdRSmJC6UcZExM+2tl+YC9qfzxv9jD4ffe84JTXQD5qbxhwzGrUx8XRcB8mFj9rzmXBPMtIMH6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781444; c=relaxed/simple;
	bh=a2XjuCdWfvNV/woO0Rh8gd+Ygzs7H2AjXyaDTSb5HFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKnyhjISDb/cJlqsDxXVTK1USELdZc1Y+SW1h29aPxo9wMBWXXEOUbtNKIn8t+bwbkA9tYu2G5Sb2dNPRjV0xzpdDSicbz1zX+c6gEyAbMT7bzUgki7YsMpZB0uTtoJ6POCDmgcVkr3OpF1OFbA/oqkAPx8u9hftG7vqXER1ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jRJouxIa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jRJouxIa"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58d95ea53so266471cf.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750781442; x=1751386242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPuwk+oR70uxO2XehYgcGNGldWT8C2cmjgGG8tlvm/g=;
        b=jRJouxIacwce3QFfsUSNpjFdAXEkeeDDLVzunhKTnVQnQGVtwkD6ZbShllQMP/N7ch
         fSlmfwoTU8FNBxtyIvzzLSqLG+c2iPF4p2QXnUhCaQM4h3xLC+x8wTQ/IIU0czC9OdPS
         t/FebGfIQ5eBlD4Lv1K8w+1DUcZXjgrTbyouSjSH/SB0Hfs7XY712IewOW1q+AMfI3at
         cN1tbx02CgQo4UHKcVd7nPLi4jOX0gcwYFXKGMTQ2hf4+6rv0mLJyTiELAfbq123Tel/
         gBO482LPL3txPOSKi2Ej0wfQspA65ukB/MujCecUMbVrDhgJnwUA2sF7WdBkJJIzuJcO
         OqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781442; x=1751386242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPuwk+oR70uxO2XehYgcGNGldWT8C2cmjgGG8tlvm/g=;
        b=n/xxF4qor6nxwhxcwHQv5QmB2qJJrunqJk6rdaGoy3lNrqoyOOiEdGdOcR9wnc9JvE
         peEaNW23pf5T7U+b4M0HU6dIWdbSbQjIpHQV0+QlgrTLX8Sg9GDd60XouZVHkkoaP2aF
         NWyu/79jbgastrrk+cIjRYJxxAwYKJYVBq/d3E3X42+gY5cArPKAQlqaCY3tmaJqPCZO
         4e+/+Um30Vl6H4Kc3uw+jlDkr2LkrQmm1pZLNcqXIY1ZoFuUyFjYtSHKS7Daqy6pNaLC
         4yXo+D8pxHW40rgbZqreBbBoRKFlATxinHdg1R3OGmgOPKYlkzp8QcoDzg7lM+iio8Se
         l0kQ==
X-Gm-Message-State: AOJu0YxFmWTcF0Ry14tYL0MKrwqWnkpvxjHUJm0J0lk1Ep303oF6rOFR
	tPd1DBFQlmbvaq/jHA/lBlqGNfajWoIW3bHxB2Ie341zNvBmlWl7sAHmyZKehCvRfCA=
X-Gm-Gg: ASbGnctQ1RgnZ2sviNwwYbF0Q5JZ6jAn05VcwpPfl0e7Jdw4QUHpHBs8QUw01Lnndlq
	rOhP7oJhFSXM3X2kbRV3qmMcC8ijowJEl/qlRoxkyDujq7MJOcmLT2FyCidlb35s+2jz+W7a+S9
	ZhkSeAt9B1ADCCr5HYDNSQUB2TaDwKNjubu+o1pCW49GTMNbz/uSyIVic4JalY2R9z7j6ZkFaqF
	kybiiECvbu3e8Q2EuPBTmzBXvu3EnOCGRr8EJ+v/xeUBQBrB2hxrRfsz1qZduFeE8Y6Sz3I6+ne
	fUklQzDEAGkmP4X5hkbtLYuuLux6d9yldQzjeuSzGHiobdnMPa1gB1E0RcmQLo1vzo6Hs5pjLGp
	ty7Ja/rML/oR09+T6fhe0O6/ADcS0RXf7xg==
X-Google-Smtp-Source: AGHT+IEbEcGpwWq8RqIxYECV0BU5XGUnuFc5NQsYXhg43ItzxNsxG9kk6trvX9TO7RKdl0Kp9+w2EQ==
X-Received: by 2002:a05:622a:7:b0:4a7:6408:b449 with SMTP id d75a77b69052e-4a7ae8b2de7mr63029081cf.2.1750781435755;
        Tue, 24 Jun 2025 09:10:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a779e79bbcsm50770311cf.55.2025.06.24.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:10:35 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:10:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 8/9] pack-objects: introduce '--stdin-packs=follow'
Message-ID: <aFrN+r2CdjAcO3DH@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
 <3699c25337e1c91388bad4c56441b39a9984798b.1750717921.git.me@ttaylorr.com>
 <xmqq8qli3ub3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qli3ub3.fsf@gitster.g>

On Mon, Jun 23, 2025 at 04:35:44PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >  static void show_object_pack_hint(struct object *object, const char *name,
> > -				  void *data UNUSED)
> > +				  void *data)
> >  {
> > -	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
> > -	if (!oe)
> > -		return;
> > +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> > +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
> > +		if (object->type == OBJ_BLOB &&
> > +		    !has_object(the_repository, &object->oid, 0))
> > +			return;
>
> So, --stdin-packs opened a pack and is feeding the objects contained
> in it to this machinery.  show_commit_pack_hint() calls this
> function in the `follow` mode.  How would such an object be missing?
> Ah, lazy clones.  OK.

That is one such place, but another would be that the object is part of
some unreachable portion of the repository and points at another
unreachable object that is missing. We take care to accommodate those
holes in the unreachable object graph when generating cruft packs, and
AFAIK in general tolerate broken links and/or missing objects provided
they are unreachable.

> > +		add_object_entry(&object->oid, object->type, name, 0);
> > +	} else {
>
> And only up to this point is the new code.  The "else" clause is
> just the original indented one-level deeper.

Right.

> > +static void show_commit_pack_hint(struct commit *commit, void *data)
> >  {
> > +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> > +
> > +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
> > +		show_object_pack_hint((struct object *)commit, "", data);
> > +		return;
> > +	}
> > +
> >  	/* nothing to do; commits don't have a namehash */
> > +
> >  }
>
> What is this new blank line doing here?

Weird, this one evaded my proof-reading as well. Sorry about that -- I
can send a new round with this and the other spot fixed up if you want
one.

Thanks,
Taylor
