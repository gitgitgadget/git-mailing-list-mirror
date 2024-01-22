Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72248783
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960798; cv=none; b=eLqBddG+duuKkfDPKZ1mNDl9H4N/LccIfKcJ7wtYATKXogVcbfxq64Kxx4XwujQDeKC7jdVqr0gOuFkGQnEB/pZazXQuFL+SkuN+dYVBecjEM63u0VoaE79Q8Yfex2peGYv7h1N1GMo9J9OY4BeYdWf0QVP+piGjAgOeLDzzofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960798; c=relaxed/simple;
	bh=ck7Rff5IRhQ5E5artzQjAFR8J6tFD8gcee2EPuf//lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW0XcmAhU05V2YJGYfQCXGyQwcQq326FwimNkBfbdj7qVqeQu0g4BCf3a+d+KrRy0oFmEkm6hNE2U99BXzGzGe5ci65NC1OU6ahpgGI6O2s94g02waFpRu6r+HaS+9dc1U0nZOllGj6E7D0WGSZwGjgEv/JTG5NkKKCInfZHu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11389 invoked by uid 109); 22 Jan 2024 21:59:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jan 2024 21:59:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9797 invoked by uid 111); 22 Jan 2024 21:59:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 16:59:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 16:59:54 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
	=?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas Coronado <raulnac@gmail.com>,
	git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
Message-ID: <20240122215954.GA813833@coredump.intra.peff.net>
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
 <20240122213410.GA811766@coredump.intra.peff.net>
 <xmqq1qa9rqji.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qa9rqji.fsf@gitster.g>

On Mon, Jan 22, 2024 at 01:45:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > PS I hadn't realized that --exclude-per-directory had been marked as
> >    deprecated. I do agree with e750951e74 (ls-files: guide folks to
> >    --exclude-standard over other --exclude* options, 2023-01-13) in its
> >    goal of guiding people to the easiest option, but I don't know that
> >    there has been any discussion about removing the other ones.
> 
> I do not think there is any value in _removing_ the perfectly well
> working --exclude* options, even though I think --exclude-standard
> should be what users and scriptors should be using if they want to
> emulate what Git does internally.

Yeah, mostly I was surprised that e750951e74 used as strong a word as
"deprecated".

-Peff
