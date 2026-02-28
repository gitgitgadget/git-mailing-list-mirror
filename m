Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB32BE02C
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259114; cv=none; b=hEv7OLTBQq3aQBdEZrYznNzqeeuWiJ0OyDXFw/CSUVrrH0gQpQG1hvmvR/2QMt8V13JX7edWJtLU7kvxnysxGQUL1Rqtfk1ben+n6H8G7wgljHTPgMo+FkwYK5esmRIG2uaUss/jnvLVNsDhwZSt3FXt/5SYH2V4pBHVAxDaBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259114; c=relaxed/simple;
	bh=wy+NBhthmxVCHtfa8ZBHC3Xu3nSx4CGeoC5d5Ym9xQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swV5J1jccrf9qmJuDpQDitx5HCDGmnWMhn/d6bYYD28VUafK9rM6IqVD8qf9PlZ2zjnofahDmueX6SWUm7ibh7U2aJWhizils6OBOkJri0VDFx8CJsuf/SjBHKNEAjhLkQrVMXvN90JagUebg0GSE8YAy8TGGN5UqnLYYbldgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kitware.com; spf=pass smtp.mailfrom=kitware.com; dkim=pass (1024-bit key) header.d=kitware.com header.i=@kitware.com header.b=i5w72fuq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kitware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kitware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kitware.com header.i=@kitware.com header.b="i5w72fuq"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506362ac5f7so26124991cf.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1772259112; x=1772863912; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3IF/rL/DthjtTtXpZgqgm6AV83e4NotwHzWvGu/Ayk=;
        b=i5w72fuqyMbbxbUQGdMNXlwKMCp2ejIs4dIpVA6sK8guCiIqgxGeugm1RNKQYhdYp9
         73h61tGj83OLP2KOQdF78vDaXs87LAYXkILC9ArhWaUHqCwyqblxqui2xTPyVbfRQCJm
         F+KrWaGIscPMpUcxnttshgObXPR812os1nwYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772259112; x=1772863912;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3IF/rL/DthjtTtXpZgqgm6AV83e4NotwHzWvGu/Ayk=;
        b=fHicnyqJ4iN5pYS3NNujdPpgrgoRE/i7Uy4T+LEFAMg6cpqm2Gg62fgKf5oFW38nXk
         lTNp9uI/AxTMRxYJzdYWglCgNIF2UaD766sSSI9c27rplSOWFAtd0aPuhYrWSMeTYKKX
         MJSYOmjXgv4CVXEsrl64GzPlryhNQ2K/GvWyUripUfs7uCy36/9KzU27hOKRMEBPZECJ
         cpf5Mwu+bGFqje0etw43s5luKl5rBOjP1ZS4bo4LPrRPXQNg9fhW926XjbcPcwEK5Fyx
         vOtkIQOLV7Zi767MqaDE0hZbRRthgULWjqoJzlmghr0+KMyHDE3ApcAWs6vA7Wn//bH8
         sbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU//cD+CKThY+ghZJgdprAV0jh+/FKvInx0Ho3+VENTvFhgMNaTH5VmU2RXLLwu6LyKS0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpBmZKzVGd0a03r0ndUzGBoND4q4ZyTYIfcYhzPMTv7/akq9O
	IpmaTBN9GLLPtpYEBabRP3y/OVyE02tB5Cf+R2wiMfkVaR8oZ8TD07sx8wv4IoFh2hw7/VwZQYp
	5QZbbAw==
X-Gm-Gg: ATEYQzz7HNwb6iBy6DInygjrmTEqJ1LU7sQxB5p3NQs55uq+SvGyWJYOhmPbodDM/2G
	7rZtO90nsxg3vPCodxzJdgsrLPHWFuelR5HGH91i+PX8XikSDC0EQOr3cAxp1sMOanIf0OkL15b
	6VDLLGkNK1UAE8XvmwPFs/mUUp5e8JrfdpBGRNilE411CCKZcpEeowsqSNcee+LUlydMo+fSDq1
	dCtm3wufEDBHDqNKAANDhoAkg8idvPpb9ITSHe+iUDKILWcqdX6BJWJ56VJhR9I0iLC4jMl3DKG
	3gaUq7++9kufaQgk2bcvxw21X74pSFxOwsCPFnDxPUHreqzt+alsFOJDFkN0I7xJXCcJIPZxvqB
	ooCidQ2SuLDMtaPszAFRuJbDbEuQ3GoSiCoMg5o9A3wIvPp880rgb6ji9e4zmxkEstVhNMICRrO
	igJ4O2G0xtdBjMQtudaj/llyOigw1T
X-Received: by 2002:a05:622a:138d:b0:506:a15c:507e with SMTP id d75a77b69052e-507528a836dmr69625121cf.64.1772259112111;
        Fri, 27 Feb 2026 22:11:52 -0800 (PST)
Received: from localhost ([76.37.124.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744ae9313sm60881831cf.29.2026.02.27.22.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 22:11:51 -0800 (PST)
Date: Sat, 28 Feb 2026 01:11:43 -0500
From: 'Ben Boeckel' <ben.boeckel@kitware.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [BUG] `git describe` doesn't traverse the graph in topological
 order
Message-ID: <aaKHH6Mf_oKJ9H6M@rotor.dev.benboeckel.internal>
References: <ZQ3GAJ/AHsM9e9a6@farprobe>
 <02e701d9ed78$436b3c60$ca41b520$@nexbridge.com>
 <xmqqediq2j0g.fsf@gitster.g>
 <032d01d9ed80$5e569670$1b03c350$@nexbridge.com>
 <ZQ3ggxA7KOysXrba@farprobe>
 <033201d9ed85$991c6af0$cb5540d0$@nexbridge.com>
 <ZQ3leoLhljc+P5wP@farprobe>
 <033c01d9ed8a$c6916f30$53b44d90$@nexbridge.com>
 <aR6BlHflRVLN8_XO@rotor>
 <20251120080525.GB1283645@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120080525.GB1283645@coredump.intra.peff.net>
User-Agent: Mutt/2.3.0 (2026-01-25)

On Thu, Nov 20, 2025 at 03:05:25 -0500, Jeff King wrote:
> On Wed, Nov 19, 2025 at 09:48:52PM -0500, 'Ben Boeckel' wrote:
> 
> > So I finally found some time to go back to this. The actual fix is
> > actually rather easy (patch attached). However, as guessed at previously
> > in the thread, the performance is in the tank without an up-to-date
> > commit graph ("instant" with it versus "minutes" without). On the other
> > hand, it is *accurate*. It does fix one expect-fail test case already in
> > the test suite (also included in the patch).
> 
> Minutes? Yikes. Let's look...
> 
> > +/*
> > + * Topological comparison: always return parents before children.
> > + * This is reverse topological order: children before parents.
> > + */
> > +static int compare_commits_topo(const void *a_, const void *b_, void *_unused_ UNUSED)
> > +{
> > +	struct commit *a = (struct commit *)a_;
> > +	struct commit *b = (struct commit *)b_;
> > +	if (repo_is_descendant_of(the_repository, a, &(struct commit_list){ b, NULL }))
> > +		return -1; // a is descendant, so comes before b
> > +	if (repo_is_descendant_of(the_repository, b, &(struct commit_list){ a, NULL }))
> > +		return 1; // b is descendant, so comes before a
> > +	// fallback: order by hash for determinism
> > +	return oidcmp(&a->object.oid, &b->object.oid);
> > +}
> 
> Ah. So you are doing two full traversals for each comparison. That is
> going to be expensive. You would do much better to walk all of history
> one time, marking the generation number (distance to root) of each
> commit, and then comparing generations here (if A has a lower generation
> than B, then you know that B cannot be an ancestor of A). Or if we have
> commit graphs, just use the generation numbers they already contain. ;)

Ok, so it sounds like I should, in `describe_commit`:

- check if commit graphs are enabled (and verified?): if so, use their
  generation numbers
- if they're not enabled, perform a local walk to store a generation
  number (somewhere?) that is `max(cmit->parents[].generation) + 1`
  (however the `generation` is stored)

and then in the comparator, use this to exclude one of the comparisons
at least. However…

> We do all of this already for the "--topo-order" option of the revision
> traversal machinery. If we have commit graphs, it can output in
> topographical order in a streaming way (see init_topo_walk() in
> revision.c). If not, then we collect all of the commits up front and
> call sort_in_topological_order().

The key here seems to be:

	if (revs->topo_order && !generation_numbers_enabled(the_repository))
		revs->limited = 1;

which then goes down the `sort_in_topological_order` path.

> Sadly, git-describe does not seem to use the traversal machinery, so it
> is not as easy as just setting revs.topo_order. Either we have to adapt
> to using the regular traversal code, or those same concepts need to be
> applied to its custom traversal.

I suppose I can try to convert it over to a proper walk following
`MyFirstObjectWalk.adoc` if that is a more fruitful path than the above
ideas. As long as all children of a commit are walked before the commit
itself, it should slot into the existing bookkeeping fairly well.

Thanks,

--Ben
