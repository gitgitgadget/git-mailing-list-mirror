Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D23B47DD
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274442; cv=none; b=Szri5xrFD8yL2mXs9cNqG7QaaVGsaMU7foU4cTRf11skXSxvZufc9PLpvYarwI7/KLpkAaZkin3RwNWCe/mrDQbrPGRgprM7Mkei8/79XZzKtVGO3sOaTCifDDnYKIKtKIR2mU6oJbThBnlRq8IRhFBz4qGwFcKmKiNrCSvWEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274442; c=relaxed/simple;
	bh=9zrx0fQwFCI3WLTgIOtVAuUg0zbPMz2j/2OcDQXRWWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5zpVEG/is+5T4T6hf7dyQkjIGP76eyx6lSIcAQzOf71+Riq1eWGV96PrzizdVvj8Ex3PP5y2oa8mTWFjW06gFuK64Y+MBR7TB7dM4kK5cuOFmj6RBQsrKHLlaz2WTjB/tN8kW1aTvh1hf348dGPyGpx/G7imzdKggEFuTFHBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=A2JoswWy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="A2JoswWy"
Date: Mon, 23 Mar 2026 15:00:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774274431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DuChWxEEaxgMEUdr09UJeNGdsFhX9DtQ6ufbNaqmKPE=;
	b=A2JoswWyPK5oi2MeI18It6/ryojcFfvrKCtaQYrkYu4MqKWLJ7OVRMk087gdTlr4MWrJvs
	Q7xwOn2PkMHayegtrbSPyI5O3TEQ1UB13Pm/Cx8SoXUnFJIkWJHJXq/LCq/MVzzgmO/Kpi
	v6HnR0IczImTAQb5MTPP6Bmlp7FVjLitrOxz0GErrjwarweo2rRoXSor9s5dtpIsJ1Juu1
	QIwZIBrQCwoGcFMShhECIpSz7LeGkgkjAknU6r1G5KpW/tNYVbPc0ee2kQF3rxsm6Iu2OF
	Aj5/KSFfiNCt8VI0GpGrrvRH9Gu0zep4+3EDDFyIbhHops+hX8iJGbXYIqG7xg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 4/8] docs/pretty-formats: add %(count) and %(total)
Message-ID: <acFG_4NbhvvyHbVO@exploit>
References: <cover.1773530191.git.mroik@delayed.space>
 <cover.1773959395.git.mroik@delayed.space>
 <7b1e5cbb243cf3421a4affd77bb45d31f3e7146c.1773959395.git.mroik@delayed.space>
 <73663cf1-3112-4e8c-a6ab-10a30670d355@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73663cf1-3112-4e8c-a6ab-10a30670d355@app.fastmail.com>
X-Spamd-Bar: --

On Mon, Mar 23, 2026 at 11:29:21AM +0100, Kristoffer Haugsbakk wrote:
> On Thu, Mar 19, 2026, at 23:38, Mirko Faina wrote:
> > When --commit-list-format has been introduced to format-patch, two new
> 
> The past tense here is wrong.
> 
> s/has been/was/
> 
> > placeholders have been added to the PRETTY FORMATS code without being
> 
> s/have been/were/

Will fix.

> > documented. Do so now.
> >
> > Signed-off-by: Mirko Faina <mroik@delayed.space>
> > ---
> >  Documentation/pretty-formats.adoc | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/pretty-formats.adoc
> > b/Documentation/pretty-formats.adoc
> > index 5405e57a60..67dc0f2a82 100644
> > --- a/Documentation/pretty-formats.adoc
> > +++ b/Documentation/pretty-formats.adoc
> > @@ -253,6 +253,10 @@ The placeholders are:
> >  	linkgit:git-rev-list[1])
> >  +%d+:: ref names, like the --decorate option of linkgit:git-log[1]
> >  +%D+:: ref names without the " (", ")" wrapping.
> > ++%(count)+:: the number of a patch within a patch series. Used only in
> > +	`--commit-list-format` in `format-patch`
> > ++%(total)+:: the number of tatal patches in a patch series. Used only
> 
> s/the number of tatal patches/the total number of patches/ ?

Will fix.

Thank you for the review
