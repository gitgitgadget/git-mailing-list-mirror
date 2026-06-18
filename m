Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32942A82
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762364; cv=none; b=X5E5g9bHqVgWA929vCpwBSqRQYJhqtOJC7EsG0GB83GdXmdpT0uGc64AwvPgaTCN4UEs+0/hMMjwwa25GQR0rh3EJlkrXhG0IPgtWj4CZj8G2QXhJnIQtoL0kpIctn/pn4Lo36UQUtDxq0uCqIZ9CLyr0u8LzJlQTVpPIGZAdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762364; c=relaxed/simple;
	bh=H/d/SYN4DnckF1u821rv0WOuEUthLluoVuqDpvs+ta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6CQmfie/NriDieB4mKrUB8kC4LINWLai5wYPobFFfPoCvGXV63bSaHbSugkzY7iIS9MvkLFDXTtEqmQuLSz5rXGDP3i4u2Gc4u3kP6nK5dzq0pjI4wdAMhV1ATYhXmD30D41P9dh1uokO7hvbTenCPEBtZjAClpVrcYG8uD+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QmeoO6d5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cd6z7yEN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmeoO6d5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cd6z7yEN"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCF187A0138;
	Thu, 18 Jun 2026 01:59:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 01:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781762361; x=1781848761; bh=wtva/jyoZq
	XlVD5RwqEIaQvYHfBalB1Q6wbCL5VQbyU=; b=QmeoO6d5YadIlFZA+HIwJXNoBA
	XteeSgAlsmFlnrfnZnUhGeB94on2/HqhJmNxtKHaP9QQlqFoRWzRQ8JPb3VQhuQY
	hK92X8tdW5sQ8v01avYBiOOiAAJJn9PIVdMf9zJuBgt/RfS8V/V/oqe59oyhOBgA
	GFM+vV9HEV60OujvaHpmn3eQkVxZZpW08Y+8NOpZXyt0pXRXChJ7roQfwVU7cykY
	0jUqIfdYCXzjVBKYIqvBYxlmQhX2m1Moe7moe7dceVYYasxA06wMweunGngUcBoZ
	5z8Tn9fTaZd5R3VjfeXhl/uq3JvHWl4CaLANQxUjodJYEVjLyeaIFHxZanWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781762361; x=1781848761; bh=wtva/jyoZqXlVD5RwqEIaQvYHfBalB1Q6wb
	CL5VQbyU=; b=cd6z7yENQHWZWKAeBYD8eHHWqX33kf1JCO3W7OiItoVmBwZGggk
	lC/i0WQybuwYx4mHGqoVoXFRSIlzTG2mpyHYyYCyrfNwNE7WDm7rYB9jLf6Q28JB
	T4EcRbdd3E+oirSVyxpKKLb3fM5rOFtpAcbAcl5kkeH3FnPKGmNNpwfc7+pmN2AQ
	0SHXEz1X1W+qIg+mHoE7w2aLRH7jq06nuP+aBd4V5hRYMp2WmDl2rBOlyIMK2Nba
	9KWbIe84LMOHaITl1qIOsKqqHVKxYW6ZVP1duWZ/AwA0NbsWOQ8Vvw4eSWeHCZqf
	ycM5kIMSmnFiIUU5+K+0kWB1YAU4FmqVc0A==
X-ME-Sender: <xms:OYkzaimgsKU4o-1i5O2Z2t2Y07DT0VOrezskEzuqlbN-Kz_Bz5wkYA>
    <xme:OYkzag3IE9OwFH5VY6SrQDCxTqzVX-lYEynP8Z6GSSEfKHjlvnHVMp7VNY_Is2SQm
    d6Bs3l7jlggOsD6osccLLxXHu-NXmR89eZBsN781rEvd_XE2sMkfFw>
X-ME-Received: <xmr:OYkzalrpDcWOldDCj6L03v35F6eXVCIVnP0u_kZnFheGVvIFQCkgeSJmWPupUyc27EspRmJKTFgispkzEqEcrb3wVNh8_5nzJ7M11qXByw>
X-ME-Proxy-Cause: dmFkZTEHObVHUhJtFqTr6JMa3KHr0ct8rRHFlYGscPlfyfKaP9qbQiVLLixV0vlTh3SWEP
    gEEwn0tzVPQuEA5diVVxcHaLLFiLvqjE/amFDA82lsfN/OEVFgYYLIp32jWxNJAVA3/VW1
    cueRrvXiG+rJHcesTJdgT703OlxKHGFVLDzzt2oAOJ18GHf3ZyUG5FOPng0zTHB0jV+TsS
    xrQMqUPDS8jvryPzZAvwRTSS6N0kPNSgUydYu9r54fhz0AS29mUq4gD2qgxKkGzXLmD3c5
    QDEy55pJuPADdrsbTvemTafV/pk0s3oX0DHuBBnFD80GQkaxK3WYqmVliQAZmJyl8d1+kv
    I2eS8sPAXOsHfP2/Ce/IwYR8oQkuv6Rf6ZogXt0I2H3gxQIgkjseTNpaESNjcrrPl2hGm/
    rQkA+M0aBWm+Kn/peYK2wJVdlOqndMS+IZQN9zreLBh94JMk+Zz7bpLB2PpdgQ24qWfol4
    5EzVFuzTZoudp2lNmm/+7iWKYXtsmJ4vTUBO2Il+tiM3fZt1q1ZpabiLOnnhqW8KMVuPDe
    AxwlCeumnkc+dKg/D0LZKZ/7/64B1ScZRP9sPEASdSP+7kGiPJgzBeWBV2f0l034/+GMKG
    Yk4ZZJ+t6/0IIQvhBOVeAAtHaVi2oDwiduvBp0N+6VrOLP4631L5GTYXz14Q
X-ME-Proxy: <xmx:OYkzaldFq2qthzFW8dTQvTR7AW08yB6UpSRgGuOiyCzO4rvgKlbxng>
    <xmx:OYkzasrlrVbRCoY_MHf_odnRUgX0ZBbL8dVMbxnOf0S_NDDoTgLYSw>
    <xmx:OYkzauGgTHWfSfwMN39x-Q54umStf1l5pIxaHGCcI7lFdyH_BHVK3g>
    <xmx:OYkzaku5gb_ap6077BxLl9jz6pnhr7Ux8oTvU1OftoFSrL3gSNqGxA>
    <xmx:OYkzaosMPLKpmAu1SCo4ZFRglxHUzg1DI6AH65i0kILarY7-Niu4elgo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 01:59:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a566619d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 05:59:18 +0000 (UTC)
Date: Thu, 18 Jun 2026 07:59:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/8] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Message-ID: <ajOJM8EvGWWkYNuL@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-7-f4854aa99859@pks.im>
 <ajLoiCS2mXP49eAJ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLoiCS2mXP49eAJ@denethor>

On Wed, Jun 17, 2026 at 01:41:40PM -0500, Justin Tobler wrote:
> On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> [snip]
> > diff --git a/refs.c b/refs.c
> > index d3caa9a633..e69b9b8ac8 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2351,15 +2351,31 @@ void ref_store_release(struct ref_store *ref_store)
> >  
> >  struct ref_store *get_main_ref_store(struct repository *r)
> >  {
> > +	enum ref_storage_format format;
> > +
> >  	if (r->refs_private)
> >  		return r->refs_private;
> >  
> >  	if (!r->gitdir)
> >  		BUG("attempting to get main_ref_store outside of repository");
> >  
> > -	r->refs_private = ref_store_init(r, r->ref_storage_format,
> > -					 r->gitdir, REF_STORE_ALL_CAPS);
> > +	/*
> > +	 * When constructing the reference backend we'll end up reading the Git
> > +	 * configuration. This means we'll also try to evaluate "onbranch"
> > +	 * conditions.
> > +	 *
> > +	 * We cannot read branches when constructing the refdb, so it is not
> > +	 * possible to evaluate those conditions in the first place. To gate
> > +	 * their evaluation we check whether or not the reference storage
> > +	 * format has been configured -- we thus have to temporarily set it to
> > +	 * UNKNOWN here so that we don't end up recursing.
> > +	 */
> > +	format = r->ref_storage_format;
> > +	r->ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
> 
> Is this really the best signal to indicate that a repository ref store
> has not been initialized? Temporarily setting the storage format to
> REF_STORAGE_FORMAT_UNKNOWN feels rather awkward and suggests to me that
> `include_by_branch()` probably shouldn't be using it to begin with if
> its not reliable.

True, but we don't really have a better signal to the best of my
knowledge. Ideally, we'd be able to use the existence `r->refs_private`
as signal. But that doesn't really work as the reference database is
lazily constructed, and the recursion happens in the exact function that
would construct it in the first place. And there indeed are cases where
reading the configuration is the first caller of `get_main_ref_store()`.

My first internal iteration tried to make this non-lazily constructed so
that we can use it as a proper signal. But that led to a bunch of
problems where we now parsed configuration way earlier than we currently
do, and that in turn led to all kinds of errors. I was able to fix all
of those errors except one: we expect `git config set` to work in a
misconfigured repository so that the user can fix the misconfig without
having to manually edit the Git configuration files. But when
constructing the refdb eagerly we will die early in such cases.

We could again work around that issue, but that unfortunately evolved
into a proper mess that I eventually discarded as unworkable. I think
this is an inherent design flaw: constructing the refdb requires us to
be able to parse the configuration, but constructing the configuration
may require us to construct the refdb. So this awkwardness is built into
Git's design, unfortunately.

So I'd really love to have a better signal, as I fully agree that the
above workaround is nothing more but a hack. But I'm just not sure what
that signal would be. And this version here does exactly what we want:
we honor "onbranch" conditionals in all cases, except when constructing
the main reference store. Even if it's ugly.

Patrick
