Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF031ACEDA
	for <git@vger.kernel.org>; Wed, 14 May 2025 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246783; cv=none; b=rbqub/O9KYcBpG4fUBTQF/n7vXoA+YMq3gvxVaRV3gUaRVJPyySNancK9L/ifC5RXpwlmrGCh/EZmWnTkKRI9AkgPA5uW1CNeAJxTDJz/OclR/ei/IRBJMLVJ56Z25xKfGEt6K+lmKL58uOadcxuMPXHCnTi2vWKJ6hJzDtpFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246783; c=relaxed/simple;
	bh=0NaUUGSakRUdXhcdR6SmbMoOjEsux/ZpqA9MzzJ30b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRd45dGS0Q0NkGJAesdvd9kYDVd4qWiR3rIrKtwu0frVECy7CXo+QApfIVijmJKPNA45Ggyh/3Jv7bskG3w+sUJQB6ELcNKlEdBpg2djGzgvDC3IfTLpmRXw5tOWyzdds/jBJxF7UVbWtIhX6GEsp0YRnRhaSdOgMSP/AMOpKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gXDffNTO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gXDffNTO"
Received: (qmail 22931 invoked by uid 109); 14 May 2025 18:19:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0NaUUGSakRUdXhcdR6SmbMoOjEsux/ZpqA9MzzJ30b0=; b=gXDffNTOKZJ0p8Xi5TmR0fsWCXH7nDFNzFLqq2xz3dnqGhH+yRscxygew9NceASTzTBMOUN7Ljd6LvX2U43lYARsIYLolgK0QdiEpMkv7xt9AsHgN/uKtvSu746dl+3JRSX/yqgIUyNX0Pzg1I/9rbu6ojHVvq7X+2bN2cSFPZQMLiO59BQQetxAQIgJbd4A7m0VfHzzv72z2SNYqurvvGhV3ROAlwQfgMYFE7qsqbcTQhhfsj8uWzsyv7RpsMWQ88xJh1el7Zzg3IwEeW6+qrw7DhN9QcbQulqmZbhTEiZO4RxBAr4ddlou9f7D3tSessfIUlN19PT4uTk2+0dKjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 May 2025 18:19:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12769 invoked by uid 111); 14 May 2025 18:19:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 May 2025 14:19:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 May 2025 14:19:38 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
Message-ID: <20250514181938.GC2196784@coredump.intra.peff.net>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <xmqq5xieq3fs.fsf@gitster.g>
 <aBmg1_wlF2fuk96M@pks.im>
 <20250512135017.GC1191957@coredump.intra.peff.net>
 <aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>

On Tue, May 13, 2025 at 12:13:30AM +0000, brian m. carlson wrote:

> > I think diff-highlight is something that _should_ eventually happen
> > inside git-diff itself (because it would be more efficient and we could
> > do a better job). But it wouldn't share any implementation with what's
> > in contrib/.
> 
> I think there are definitely users of diff-highlight.  I remember seeing
> a reference to it recently and not realizing it was in contrib, but it
> is actually used by others.  I don't use it myself, though.

Oh, there definitely are users. Sometimes they contact me outside the
list. ;) I thought the discussion around contrib/ here was more around
"should things in contrib/ spin out to their own projects", and not
"should they be removed and forgotten". :)

I am perfectly happy if these things stay in contrib/ forever. I was
only voicing that I'd be OK taking them on as outside projects if we
didn't want to keep them in-tree anymore.

> > >   - Credential helpers.
> > 
> > These ones are tricky. In theory they could be spun off into their own
> > projects, and we already have examples in the wild of things like GCM
> > which are maintained totally separately.
> > 
> > But I think we may need to find people to step up as maintainers. In
> > particular, I think osxkeychain is probably used by a lot of people, and
> > probably shouldn't just go away. But I don't know how the maintainer
> > would be. I wrote it originally, but don't (and never did) use it
> > myself, or even have access to a macOS machine.
> 
> These are often shipped by distributors.  Apple ships osxkeychain, as
> does Homebrew.  Many Linux distros ship libsecret and it's the
> recommended choice for desktop Linux.

Right, I know people use them. What I meant was that if we wanted to
spin them to out-of-tree projects, we'd need somebody to volunteer to be
the maintainer of those projects. If they stay in-tree we can be a bit
looser (your "I don't want to be _the_ maintainer, but I can
contribute").

It does put more load on Junio, though. E.g., if there is a security
problem the project has to deal with embargoed release engineering,
whereas a separate project would do its own releases.

> wincred, while not super popular, is still used and is smaller and
> lighter than GCM.  It doesn't actually look like GCM is seeing a great
> deal of maintenance either at this point, so I'd say they're about
> equally well maintained.  Since I don't use Windows, I don't know if
> there are other usecases (such as noninteractive uses) that are better
> supported by wincred, but I'd recommend keeping it.

I don't use Windows, so I don't have a personal opinion. Code may not
see updates because it mostly works, or because hardly anybody is using
it. Or people may be using it but it's still broken. ;)

Last time wincred had a security hole (in 2020), the phrase "unsafe and
unmaintained" was thrown about on the security list, but we ultimately
fixed at least the immediate issue. But I find its general matching
strategy to be not very confidence-inspiring.

Dscho (or anybody else familiar with Windows) may want to comment
further.

-Peff
