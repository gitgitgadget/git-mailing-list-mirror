Received: from mail2.viabit.com (mail2.viabit.com [65.246.80.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5B27FD54
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.246.80.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583418; cv=none; b=mGhmMg2MNjNmZqFufK1dXZwjR/rnA7gGE8Gi5gTn9O8RufDqbZcGkZ74vGD9qaQhJVIa0mIdHtbT7yCjiuUN0LLq6L7uN1WbTRN/TZmossiInD4Si9PVQ3GtKLLbWcg0ImA2HeiW6YsOXmvbH1tCukTbFlbwA49Xnk+wqTnfQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583418; c=relaxed/simple;
	bh=FCUCDWKEhnTH2VepvNIULRMzISSxfxFyAo7uOt0DF8M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8hHlaB5f90V5yLLKbpQZzD0ZmID9OL7B6xQ1lTIkU8TlLR6ybq0A/6/6dTIunYJKtu0rnU5H4+7XfeESSlH0Z+ttVGmo84GaNwenyxRJDNP73rJFc67sQRIvpejCXmOhwE/plJLt2s+pmnWl686Pb3V2i9QQiqaAILUAqsp8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com; spf=pass smtp.mailfrom=orlitzky.com; dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b=GB3VDDAw; arc=none smtp.client-ip=65.246.80.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b="GB3VDDAw"
Received: from [10.1.1.204] (vpn1.metro-data.com [65.213.236.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.viabit.com (Postfix) with ESMTPSA id 4cVzgm1cFHz48X3;
	Mon, 22 Sep 2025 19:23:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orlitzky.com; s=mail2;
	t=1758583414; bh=FCUCDWKEhnTH2VepvNIULRMzISSxfxFyAo7uOt0DF8M=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=GB3VDDAw8fiERi8SZDV4aKVeTrUrNBhrIaF5lZls+em86jAoxgFOqMMf+k7VvkP6C
	 +oX5PL+5UE1hRW9UP1eOrefF9ws2cetrIl905gb3U+jWFYQq2l+B6rNZHEiuQkQo9C
	 iLiRuLInVIOzqknbSyxghMrCk9/XTFwb6ndgE/QU=
Message-ID: <92bdf57fa8ca49159db3e3384784aa2538a3b48a.camel@orlitzky.com>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
From: Michael Orlitzky <michael@orlitzky.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	ezekielnewren@gmail.com, 
	20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im, 
	Johannes.Schindelin@gmx.de, ben.knoble@gmail.com, cb@256bit.org, 
	collin.funk1@gmail.com, contact@hacktivis.me, eschwartz@gentoo.org, 
	git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, newren@gmail.com, 
	phillip.wood123@gmail.com, pierre-emmanuel.patry@embecosm.com, ps@pks.im, 
	sam@gentoo.org
Date: Mon, 22 Sep 2025 19:23:31 -0400
In-Reply-To: <aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
References: 
	<CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
	 <20250922155949.27019-1-michael@orlitzky.com>
	 <aNHBIHXYPmS5AvpP@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-22 at 21:35 +0000, brian m. carlson wrote:
> On 2025-09-22 at 15:59:49, Michael Orlitzky wrote:
> > There is no problem with supporting rust on Gentoo. Gentoo users build
> > from source, and rust is a problem for anyone who builds from
> > source. I'm writing this on a riscv/musl system. If there are no
> > binaries for your CPU/libc, let me tell you, it's not fun. And this is
> > like, my job. A normal person would be completely helpless.
>=20
> This is a problem with languages that bootstrap from earlier versions of
> themselves.  It also happens with other, less common languages.  GHC (a
> Haskell runtime) also has this problem and any distro that ships pandoc
> has to deal with it.

Spectacular example.

In Gentoo we support the following arches: alpha, amd64, arm, arm64,
hppa, loong, m68k, mips, ppc, ppc64, riscv, s390, sparc, and x86. We
support both glibc and musl, for 23 arch/libc combinations (we don't
support musl on every arch).

Pandoc supports: amd64, arm64, ppc64, riscv and x86, but only on glibc.
That's 5 out of 23. If you're able to use GHC 9.2 released in 2021,
that is. Otherwise it's 0 out of 23. No one "has to deal with"
anything.

Coincidentally, I am one of only a few people to bootstrap a modern GHC
on riscv/musl:

  https://wiki.gentoo.org/wiki/User:Mjo/GHC_binary_packages

Knowing the amount of work involved, I can promise that if Git switched
to Haskell today, it would be our users who would have to deal with...
not having Git any more.

I agree completely when it comes to the benefits of static typing and
memory safety. (I've been writing Haskell for 15 years, after all.) But
for the time being, all of the cures are worse than the disease.
