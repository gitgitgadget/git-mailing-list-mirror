Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A02E36EF
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798561; cv=none; b=Z5i8f/QP0S+q89YS1+xlpkvldOm3z1Qkq3Ytg5XsKNgpcAHBLZ8snF13EtMsRhcXDCgbbynPN8Cyp8gyUlQP57wON9DY33z84S/r2zw3ejv7jPNAxct8Rvkt9aAmGaUpfpMVS+9Rk09hFDAR0gH3P4HV/HAOJp5dUEwrIoQ8TSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798561; c=relaxed/simple;
	bh=l3uGKD2Tlsddh4hhqOSc+nK9nkSsfo+1pnRVd7xZHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS1qZO56IcLx4OHtyo0FF3QQ7yQhCpZrSzYR/Y4vFj/X8z1LVcLn9aAjrBWw3o++gXL3KJ1F74PxUExlh7FWLGGqeflHkjns7Ff38nbCwTD1sIb+hri/UCOwRQM/EaOCfO9LIq0xJFR05aqv9RyqsYbVNIko1wPZSTMCyyanUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=k/kN8vSx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k/kN8vSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752798558;
	bh=l3uGKD2Tlsddh4hhqOSc+nK9nkSsfo+1pnRVd7xZHIY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=k/kN8vSxkPZYBwcL+tbL7khMNOUFlPlS44AdrDnf2IIesXxomaZVqTSoMHlmlbBj+
	 Wiytlz+7vySy3MhZdWHeuTtYq8f0zN3X2x297BIU3Oeqq86zVXCYAN4aYiyD421b30
	 6ZB7W7+aK+chmOMIfCW9YIJY5mWEAo6OByNux9mx3qF0te3/EW5riLEgGxobEHJfuE
	 jKWJtKMCrAbZ4eU727RMy/K9mpVLrxHUo0CRJqgtKL9FlCj4Xcwq6tt+NWWrM09+/t
	 L3zDDGcCJiVEFpEzIhpojaZCglNtyNkhQe3K39VedlGR9hP/DXNyz2PYy4rGRG28+u
	 pAvMxiZxPakLuwclcK6WZ//JHDP6sD9jaFWv0KnjH686FEhfqQ/u8n5UIAvnWKNeDJ
	 adoiTwP8LNoeihZ7YOxiE4obu/CZjsxUxZ0Olh/76DCcm53Pw0aH62bGcHygA+EOlz
	 cA9UjdVFSyPx69sLStrWIG+CpfJxQHi49tL70wHLZLd0Sa7aldF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c351:2fb1:6e4f:b4fb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 000702007E;
	Fri, 18 Jul 2025 00:29:17 +0000 (UTC)
Date: Fri, 18 Jul 2025 00:29:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aHmVXDOiKzfKU8nb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <aHlwZPbiKnakMN75@fruit.crustytoothpaste.net>
 <aHl4U98BBvpA5eKF@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qB9glMthsNfyb85L"
Content-Disposition: inline
In-Reply-To: <aHl4U98BBvpA5eKF@nand.local>
User-Agent: Mutt/2.2.13 (2024-03-09)


--qB9glMthsNfyb85L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-17 at 22:25:23, Taylor Blau wrote:
> I agree. I don't think that there is ever going to be a "perfect" time
> to introduce a hard dependency on Rust, and I don't think that should
> hold the project back from adopting it.
>=20
> I am far from a Rust expert, but I think that a more modern, memory-safe
> language will attract newer contributors who may have a fresher
> perspective on the project, and I think that's a good thing.

Yes, I think that's true.  Rust is by far the most admired programming
language to work with, according to the 2024 Stack Overflow Developer
Survey.  We will likely attract new contributors who find C intimidating
or a bit of a hassle[0] but are excited about working on Rust,
especially in a project as compelling as Git[1].

> The alternative, of course, is to continue to use C and not take any
> dependency on Rust. I think there is a middle-ground in there somewhere
> to be able to build with (e.g.) "make" or "make RUST=3D1", but I would
> really like to see the project take a firmer stance here.
>=20
> I worry that having build support for both "with Rust" and "C only" will
> create a headache not just at the build system level, but also in the
> code itself. Having a patchwork of features, optimizations, or bug fixes
> that either are or aren't supported depending on whether Rust support
> was specified at build-time seems like a worst-of-all-worlds outcome.

I definitely agree.  I already find it terribly inconvenient when I end
up when `git grep` doesn't support `-P` and I imagine that having lots
of features that weren't available would be bothersome.

I also think that using a combination of C and Rust will end up with us
still writing a lot of unsafe Rust code to interoperate with C.  If we
want to reap the benefits in terms of memory and thread safety[2], we'll
be better off sticking with just Rust.

I will also say that while it may be more challenging to compile Git at
first on Windows, as we move more towards an all-Rust codebase, Git may
end up being easier to maintain there as we depend more on the standard
library.

> Agreed. Of course, I think we would all like Git to be able to build and
> run on as many platforms as is reasonably possible. But we cannot
> support all platforms for all time. It is also not the Git project's
> responsibility to ensure that every platform is Rust-friendly.
>=20
> Hopefully the platforms that we currently support but won't after this
> patch series have niche enough workloads that they do not need the
> absolute latest-and-greatest Git release at all times.

I will also point out that many OS and CPU architectures are actually
supported in Rust upstream.  `rustc --print target-list` includes things
like the following:

* m68k-unknown-linux-gnu (Amiga and other 68000 processors on Linux)
* wasm32-unknown-unknown (Git in your browser?)
* armv7a-nuttx-eabi (ARM processors running the embedded NuttX OS)
* x86_64-pc-cygwin (Cygwin[3])
* sparc64-unknown-openbsd (OpenBSD on UltraSPARC)

All Debian release architectures are supported, for instance, as well as
several non-release architectures.  The only Debian architectures that I
don't believe are supported are alpha, hppa, ia64, sh4, and x32 (which
is an amd64 variant that can run amd64 code just fine).

> Yeah, I think that this is the most interesting part of the discussion
> here. I am not knowledgeable enough about Rust's release cadence and
> platform compatibility to have an opinion here. But I trust brian's
> judgement ;-).

I'll see what Ezekiel thinks about this and I can send out a patch for
review if that's desired.

[0] I've been writing C for three-quarters of my life and I still find
debugging segfaults and other memory problems to be annoying and
tiresome, so I'm very interested in getting out of that business while
working on Git.  While the limiting factor for my contributions to Git
is often time, I would feel more excited about working on Git in Rust
than in C and I'm confident I'd write better quality code and more unit
tests as well (which benefits us and our users as well).
[1] I definitely think there's a cool factor to working on Git.
[2] Having more thread-safe code might allow us to more easily add
threading to other parts of Git that would benefit from it and thus
improve performance in many cases.
[3] This was missing for a long time, but it's finally here now, which
is also good news for Git for Windows.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--qB9glMthsNfyb85L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHmVXAAKCRB8DEliiIei
gauCAP0RMB0sPNh6dCTts4R7UqiRhVl3/N3hcXK3H1PY6MWkygEAuu1z0H8jbXJG
1JtSxW83HW8MSIbuA9kyxhkgBUWp7gM=
=fRex
-----END PGP SIGNATURE-----

--qB9glMthsNfyb85L--
