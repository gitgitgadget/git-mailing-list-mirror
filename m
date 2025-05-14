Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1391E1308
	for <git@vger.kernel.org>; Wed, 14 May 2025 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197113; cv=none; b=BEqXseluhQCgc1phBFElR1+06/ayINOTte2csFRgF4hl3T/LJLsD1yAVgf52eTYNYwsqRPMXI9JuZdPkoDt3OtfI3MjKZC0j51IwQb0/KIFwQPHB02QNk7BaiIpzq6BKJ/aTn0ILIK6rbec416tDroc9tpWx707oYkTOJH6p6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197113; c=relaxed/simple;
	bh=ibBT8a/SzDKPg5gO+85fMDPqBLgAVlC8F7JQrvdePwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ8/MBcjROxH37A7JmlJs3VJybQw9Stcr4+dDUzhaVw0aq1+EZM9MUoxuL0UWMxeFNVLF2vymDYv/TeeJgu3jBw+xxn3FTHLlM/m0EWsYYplBmhA+0FLz4OyhA0cFBGv7tRpTh0keC+AHcg64oXvplLq8zDADMwZJrsik1hh79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lm3rks4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXgf9rtN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lm3rks4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXgf9rtN"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E33E513800A9;
	Wed, 14 May 2025 00:31:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 May 2025 00:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747197110; x=1747283510; bh=+ucftS+toh
	bCEuv2+CwAW0z1nleE7yw/H3LQ6U5hlCQ=; b=Lm3rks4Ip6BFDMNYboEsI1aOkE
	IW2JnpMfMPkbuN8HgVmAfCxWsm5F6LIyq5M3KGq107pStgDYsm3WnAWEoRISlUiQ
	KCI6G9oYPEaljKeuEl3w7ieDwemG/ZqOn3CXmNBgMTBuvWUU80pb+Lj7CRTVV4oO
	+V0TQfRM+Epg9+xUW/AsLZlzC1EBRhXxk2SiVoBBH8bRfWif/CSINYfgH1Fp/TTV
	NNAPtbN6zHp8Z44dQDX/fQ3/AjZ1yiQdFv19RQ8xUI8+FjeQZuUrShl5MkuEz8x7
	pEpLhl4IV1Zuf/LMU18DmhDZSSLg1584Ne7AwhxoBYkv35eyeWWftAYp0mRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747197110; x=1747283510; bh=+ucftS+tohbCEuv2+CwAW0z1nleE7yw/H3L
	Q6U5hlCQ=; b=cXgf9rtNdXGeurYDKmwjnh0Pm8gwqpGXgBibN6rDDzqJ/9ZHWaA
	u2Aeyqe+eD3QUVHhehI51oIG1o22tEAxkZjbnIMOLkRydPaTWCSEVa5ToIWwCuPX
	TKeNaE5rPD1Cd2WlL47tbXn9VbnBlOe24OFvtIs6ayZueDjFsygP6jHmDrDFPnhn
	cSTmVQUcvWVPXqS+HuHEdkLpHnnDLcWBqRtWozM+vMV0e/oQZa1AYYYQGQXoNhEC
	u/FFhSV6BTYu6P9cLplgwvAiyLFJVOamYpk31tG2Q5kb1Vm0e2Iwy0+g643ubil7
	D8lwhMeArG81NJtWPMroZAsSDtAY2UQsu0g==
X-ME-Sender: <xms:thwkaF7YmX6JB3jFXUZFlrFzStCsXZI7cyKki6IuQCKh1zgT1rFj4A>
    <xme:thwkaC6wg2LSlgGQrRzrF_Z5e1igNSOTBm4tUEYVqvwkl7sZWEWX9-kitewlCQZ7J
    gvC8SE8ucVuiy2FfQ>
X-ME-Received: <xmr:thwkaMevI4gLMdT8uQj5LdqVfluHT0XLzb_JMa1GXR_Glxx9AdyMxfysOpiKVHEr-ucTdpyHuGqtNGOWWZTztWg9BCsEBDEaUc8fC94vq6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeitdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hm
X-ME-Proxy: <xmx:thwkaOINdukpRwc4jhjQrgQDJqBtgWX8uWjWR7LZ06G17Njm7QywtA>
    <xmx:thwkaJK5WHw1wcYSbKqqEtegIoZxMFtCN8l_CaBaNC-4KYL_hkvs8A>
    <xmx:thwkaHzL_teo4s506Aanp0T7ZMF2isy0KnZ5NjUHRfYbwcs_z4KNtQ>
    <xmx:thwkaFKdO3N46bCsBKPZO0QYjQ2ylmxSyTziMagf_-grK2yZD7IS1w>
    <xmx:thwkaKP4Gj9igEruMYYdExMC8Hy3hxp9SwqQCWIXzdCQYGkT1TA2fVf->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 00:31:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7bed850 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 04:31:49 +0000 (UTC)
Date: Wed, 14 May 2025 06:31:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <aCQctNv5IkVJAfQL@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-2-103f59bf8e28@pks.im>
 <87bjrwjoov.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjrwjoov.fsf@iotcl.com>

On Tue, May 13, 2025 at 09:28:00PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 53da2116ddf..cd7db11d825 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1591,12 +1591,12 @@ static int add_possible_reference_from_superproject(
> >  	 * If the alternate object store is another repository, try the
> 
> This comment reads weirdly if an "alternate" is a location where objects
> are stored. Maybe say something like:
> 
>     * It the alternate resides in another repository, try the

Fair, but I'd prefer to not adapt too many of the surroundings yet.
Otherwise I fear that it'll open a can of worms that we can otherwise
address over time.

> > diff --git a/object-file.h b/object-file.h
> > index a85b2e5b494..f1601200938 100644
> > --- a/object-file.h
> > +++ b/object-file.h
> > @@ -24,23 +24,23 @@ enum {
> >  int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
> >  int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
> >  
> > -struct object_directory;
> > +struct odb_alternate;
> >  
> >  /*
> >   * Populate and return the loose object cache array corresponding to the
> >   * given object ID.
> >   */
> > -struct oidtree *odb_loose_cache(struct object_directory *odb,
> > +struct oidtree *odb_loose_cache(struct odb_alternate *alternate,
> >  				const struct object_id *oid);
> >  
> >  /* Empty the loose object cache for the specified object directory. */
> 
> Also here s/directory/alternate/ ? Or database?

This one remains valid even with the new terminology. The loose cache is
specific to loose object files, which does have an associated object
directory. Refactoring loose objects to become a bit more self-contained
will be one of the next steps after these refactoring land.

> > -void odb_clear_loose_cache(struct object_directory *odb);
> > +void odb_clear_loose_cache(struct odb_alternate *alternate);
> >  
> >  /*
> >   * Put in `buf` the name of the file in the local object database that
> >   * would be used to store a loose object with the specified oid.
> >   */
> 
> Not sure if we should use "alternate" here?

Probably rather "loose object directory", as it is again specific to
loose objects.

> > diff --git a/object-store.h b/object-store.h
> > index 34b8efbbb83..2dda6e85388 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -12,8 +12,11 @@ struct oidtree;
> >  struct strbuf;
> >  struct repository;
> >  
> > -struct object_directory {
> > -	struct object_directory *next;
> > +/*
> > + * An alternate part of an object database that stores the actual objects.
> 
> I'm having a hard time trying to understand what you're saying here.
> What do you think about:
> 
>     * The alternate is the part of the object database that stores the actual objects.

That reads better. I'll extend this even further to give a bit more
context around primary alternates.

> > @@ -97,16 +100,16 @@ struct object_database {
> >  	 * cannot be NULL after initialization). Subsequent directories are
> >  	 * alternates.
> >  	 */
> 
> The full original comment can use some love too:
> 
>     *
>     * Set of all object directories; the main directory is first (and
>     * cannot be NULL after initialization). Subsequent directories are
>     * alternates.
>     */
> 
> How about:
> 
>     *
>     * Set of all alternates, storing the actual objects.
>     * The primary alternate is first (and cannot be NULL after
>     * & initialization). More alternates are optional.
>     */

Same here, I'd rather not touch this comment for now. We'd only catch a
small subset of outdated comments anyway, so I'd rather focus on the
required changes given that this patch is already quite large.

Patrick
