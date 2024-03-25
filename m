Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94A15539A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355805; cv=none; b=n/OtU3oCJN2+tuo3wzTTKsYEQsm3BHZ7es6t+FlZ0awJVia2tpgo+p3YV3SVYZvpiBsVFDl+ooJTkrydcI5/L0omoOKIqPA8AVLGW8bpn2T5TUOIi5ACDllj0/HleL8v5ZWNDgXKJZ/gsiSrxjbmggdC79xMyUWysgs+8Sg3pPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355805; c=relaxed/simple;
	bh=UfPYYwnecrYP2LTihIxhYurB+ADnkt/W8WBrd90r/Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwOrvUSgZdT4nCAbFnONHQBPbc+yr1C1nBXUTzsjg9EjLrkTZViOqpf3KqyBgmChjHvf5+Kg3qEs5yVGpPRM61LUVc5ArVcJrv7J0wlzRerOmZz7l0pUXuflMisZpMisWXhbpwyW91hMHC/+Et7HO5oApKUepMvxUaThpP8CadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=pBsRvnC4; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="pBsRvnC4"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:d5de:3293:133e:f31a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id AB34E60384;
	Mon, 25 Mar 2024 09:36:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711355800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sswWaW0LS2cQIXFEkD4fWq+XIz7x5IvgR5AGdh/YVAs=;
	b=pBsRvnC4dPqdzZJLZou1ewgBmV+Ar2bEvu1BRGSe32YqORY2ELHcAJ3V9TRdcAOk//KZeP
	Oh1rR8CDc0tobGLl2W4WR2/dgbaraIS64hNOol//izLYJs24BS2F3qB6PDbSqWnQAr8snL
	VhG6xAx9Jh065XurJ9Q8USehhqRvrgCYGU30IeyvJqBB/+5PrPeRoYP2Qpmw6GtNih4rLj
	uF1BDAd2YuAO4G5IRJBoCeg+Y3OC6KDafvrFRs88oVbwPAvo8LZp5X5TjiUaRydlnZIO8s
	wNDcP6fv09yzPYvLKHVhzvFkGq8DExHbFcu1OeijTLth/ntql/g/YLBlc328CQ==
Date: Mon, 25 Mar 2024 09:36:40 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/6] maintenance: cleanup $XDG_CONFIG_HOME/systemd/user
Message-ID: <ZgE3mHsPfKbuQLQP@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-5-mg@max.gautier.name>
 <Zf636bsHs9woXRAS@framework>
 <1cce271f-c3df-432b-94ff-bf7b11c6924d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cce271f-c3df-432b-94ff-bf7b11c6924d@gmail.com>

On Sun, Mar 24, 2024 at 03:45:45PM +0000, Phillip Wood wrote:
> Hi Max
> 
> On 23/03/2024 11:07, Max Gautier wrote:
> > On Fri, Mar 22, 2024 at 11:11:09PM +0100, Max Gautier wrote:
> > > +/*
> > > + * TODO: in the future (~2026 ?) remove this cleanup code
> > > + */
> 
> That is rather optimistic - users only run "git maintenance start" once so
> any unit files that have been written in the past will exist well beyond
> 2026.

In that case, should we hook the cleanup (in it's final form) in more
place ? `git maintenance register` for instance ?

> 
> > > +static void systemd_delete_user_unit(char const *unit)
> > > +{
> > > +	char const	file_start_stale[] =	"# This file was created and is"
> > > +						" maintained by Git.";
> > > +	char		file_start_user[sizeof(file_start_stale)] = {'\0'};
> > > +
> > > +	char *filename = xdg_config_home_for("systemd/user", unit);
> > > +	int handle = open(filename, O_RDONLY);
> > > +
> > > +	/*
> > > +	 * Check this is actually our file and we're not removing a legitimate
> > > +	 * user override.
> > > +	 */
> > > +	if (handle == -1 && !is_missing_file_error(errno))
> > > +		warning(_("failed to delete '%s'"), filename);
> > > +	else {
> > > +		read(handle, file_start_user, sizeof(file_start_stale) - 1);
> > 
> > Actually that fails -Werror because I don't check read return.
> > Alternative below (on top of this one), with one question:
> > Are VLA using size_t const OK ? It's folded to a constant array by gcc
> > but I don't know if that causes portability problem with other platforms
> > ? I can always repeat the sizeof expr if it's a problematic construct.
> 
> I think it would be easier to use strbuf_read_file() instead - it is only a
> small file so there is not really any advantage in just reading the first
> line. Something like
> 
> static int systemd_delete_user_unit(const char* unit)
> {
> 	int ret = 0;
> 	struct strbuf buf = STRBUF_INIT;
> 	char *filename = xdg_config_home_for("systemd/user", unit);
> 
> 	if (strbuf_read_file(&buf, filename, 0) < 0) {
> 		if (errno != ENOENT)
> 			ret = error_errno(_("could not read '%s'", filename));
> 		goto out;
> 	}
> 	if (starts_with(buf.buf,
> 			"# This file was created and is maintained by git.\n") &&
> 	    unlink(filename))
> 		ret = error_errno(_("could not remove '%s', filename));
> 
> out:
> 	free(filename);
> 	strbuf_release(&buf);
> 	return ret;
> }

Thanks, this is exactly what I needed, I looked at the strbuf API but
couldn't find this somehow.

-- 
Max Gautier
