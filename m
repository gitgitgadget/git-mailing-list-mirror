Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250385;
	b=UYi1ruOqywvi0qx5XDQ/MOc3e5J7ufvpbNuzzdciuwgYaoGLQxVSON3Z9v7zGK4DEnkJ
	 WMbJCWiydHjvWcR0Zb6kUlhWi0R6PwhpUa4uDccwuO+OXsN6NsSyIFLRD8rlu563ejpWH
	 E0j120hP7jdj1ZplldoazuRL5D4COfYTZyiTInLV60M+DDRihksVk9ejdv7LP6aPFVDu+
	 ia+pUp3YnmZTJEKpXNe+O7wZUJArD+6GOOeRPgZDIUjUKj2RMjQSryAWvmIrLCG3IVJqc
	 CuaSvEk/JfdDRVOWKOnuROg4qSRmEIJ+MeAhzeTxxoakFgR1Zdj5jzpd9rEY5fBKg0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250385;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BwVrRr/Ef5Ns2fRzaYx/t1YSJIRpWPVDOdjXO0tbCgQ=;
	b=5gyKAJ5OoKUA/jtW1bvbh+gjFQgs3Q0/rjoOeXDF/P4tNajaN54J5GtamvA0JmNHYwza
	 iE05Q9Ly3ENrA9/1YaCFYJ73fO5A8A8YWn7kh7CI3fhoTiUfgLSGZkq3P0/1LNo/5kNwu
	 XY/yeJDTRyrEFHKTDMxgyZNF1r0qimlFH5045IJWxIFih6HIU7YEvpPNJk8XYe2j/ixJz
	 ZY9/UmOKDL5DjCv24CV2BFmYsXKV2jdPA27uR123DaGd1Y3AB6liBT2zyUDINlwS2CX5y
	 wm6ZGjjY4Tg0MYlOO+gUmMCrsFJ48Xgw+Ol2DU1zaaPic2ikuSE59jJxDPogD4kxc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bv32WGRU;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C332606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 18:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C332606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=bv32WGRU
Received: (qmail 90152 invoked by uid 106); 9 Nov 2026 18:53:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NSOAcTG8J6E/yDas874pWmxRozTZm6kEIaJbXV8eMZI=; b=bv32WGRUqPlfao07r1KmUliswbKSPXPz+RDqjNVL4SX7SOAvWQEapZ+Wj1NmO8ucCE0PkvAoo04ahqS2ubcfKRAFQvPlOGTDvGaLc6jNAvzkXbUep4CLav6aR3C1LTN+SbtRt62QvRmpo9NsWUk08v/jHJa40aWpGnw2qwxO2ehn2Zm3RAVvIq4q3hIiQKCEte4XQgUhx5gWSqKmiqS7qgHnMLMNZcRg7uniT3mjeMkDZ29PMruqbCSoEB1SEZE/pajNeRKSuNbiJ83uAkQ0km6PbR8rSVCZLSAwyCuJ9GJ/y39Dx2Tv5KF4MD2OB1TKEiOMg9i/iBYkD1aUHI57xQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2026 18:53:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157494 invoked by uid 111); 9 Nov 2026 18:53:02 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2026 13:53:02 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Nov 2026 13:53:01 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Message-ID: <20261109185301.GB1322417@coredump.intra.peff.net>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
 <20261108023730.GA1242909@coredump.intra.peff.net>
 <xmqq33tc6ium.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq33tc6ium.fsf@gitster.g>

On Sat, Nov 07, 2026 at 08:35:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Nov 05, 2026 at 03:40:17PM +0000, Julia Evans via GitGitGadget wrote:
> >
> >> +[[name_only]]
> >>  `--name-only`::
> >>  	Show only the name of each changed file in the post-image tree.
> >>  	The file names are often encoded in UTF-8.
> >>  	For more information see the discussion about encoding in the linkgit:git-log[1]
> >>  	manual page.
> >
> > Sadly this syntax seems to work with Asciidoctor, but not Asciidoc. The
> > latter doesn't create the anchors, and then xmlto complaints that the
> > result doesn't validate.
> 
> An offtopic tangent but didn't we repeatedly float ideas to drop
> support for AsciiDoc, make sure our documentation set renders well
> only with AsciiDoctor, and tell folks who do not use AsciiDoctor to
> use pre-rendered documentation pages from git-htmldocs.git and
> git-manpages.git repositories at https://git.kernel.org/pub/scm/git/
> during the past several months?

Yeah, that's what I was hinting at near the bottom of my message. :)

But it's a big enough change that this series should probably just
accept the ugly syntax for now, rather than waiting for us to drop
python asciidoc support.

> Perhaps I should add an entry to the BreakingChanges document (well,
> I know I know I do not think it belongs there, but since we hit this
> so many times already .....).

I'm not sure if it actually rises to the level of BreakingChanges. It is
a build issue, not a user-facing one. And there is an easy workaround
that can be applied anywhere for platforms that can't or don't want to
use asciidoctor. So it may cause some slight hassle for packagers or
those who build themselves, but it's not really breaking anybody.

-Peff
