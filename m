Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69321283CA3
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113491; cv=none; b=W1MlDssYLgEpVgmo/Ss0pqprf1CPZdgk6e+F/hYfE7OTIA7UzEoJb/ugAxQfvRpHszW4rLfy7u4JMdAnPFcH6KKJqdB6lUFh+oO+zqIPWVXx++1xwaRUlr596VzL9WmcnOFYRD+ijO6czzzY1+LrI1mM27s7chnBTRrL0zmxdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113491; c=relaxed/simple;
	bh=7iejqIRb659etJftKJ84ZYb2OkNiegFmEkjS6VbtL3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNMxKn4yKTq/WnMLufAF8LAfPgEXar/xkVXX3J/rz/Vq1F2gdRlRJyl/SBN9EYuE/Y/KORAV6AkAZ9LILma4CcPAqvm2FK2hdunRxVrvgJDSseALAiNabnVMVyUf/pwunXSfD9JPouGrENsQbxwrxy7yTGI35gvP4hLsvoh5jJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xwmKxLCK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xwmKxLCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757113487;
	bh=7iejqIRb659etJftKJ84ZYb2OkNiegFmEkjS6VbtL3g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xwmKxLCKSjuhj45MlorDfGA2vnzHrLQb5Up4RGRA3AAWPtY6FoiewA1TA23qctGfX
	 /3WbfCQz5RnQ3OsjHF+2ORpxRsyIy6S8aGBejekvo5F4iQ+A1o8I8IoybdFcAQag2M
	 9Z78avLIcivp+QMaCajrajkUu10lybrWp7U6KqUaFdG8CLr66Y4vtSiBtIOE+VT06b
	 SnBxteyQzp86tUOJgwpVjvTLC6JmZwR5CySttfoovl6b9136JoDhaCddmAlLd/oBvK
	 8vaWxnrtlZoENO6OBXk+s66Dn3WN3fqMfFeH/unqGBGalwbjWf5s8lX0IPgDeeRZVW
	 RnvgBBMudOgQYj5CgZFqHAIKobXDhJsRdm1YfGj9o8UuM5tMd8UD+WPcopesxeWVHs
	 ppHsDyiEVDt1DiGsMIdS4CUdB7Gg+aRMVXD6seuIedxKIJJ73phm3lSt/B4C5ajcmf
	 M/Jdvr3IA8qYq1MRiNpLb2N9v73AtHlXKHMCGLtvlUmHmhiGsrk
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 88139200BC;
	Fri,  5 Sep 2025 23:04:47 +0000 (UTC)
Date: Fri, 5 Sep 2025 23:04:46 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 4/7] rust: implement a test balloon via the
 "varint" subsystem
Message-ID: <aLtsjvV3GWyFByMq@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-4-6939cbf4a0b8@pks.im>
 <xmqqy0qs1sk5.fsf@gitster.g>
 <xmqqqzwk1q3z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TQ4bcfeo9nFxDAnc"
Content-Disposition: inline
In-Reply-To: <xmqqqzwk1q3z.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--TQ4bcfeo9nFxDAnc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 22:39:12, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > ...  Interestingly, disassembly I saw looked a lot more
> > optimized than the C variant compiled with clang-19 -O2.
>=20
> That was a false alarm.  With right compilation option passed, C
> version of decode_varint() compiled to identical assembly as what
> rustc/llvm produced.

That's not unexpected, I'd say, especially since the code is very
similar and uses very similar data structures, including pointers.

However, as we adopt Rust more in the future, we may see some
performance optimizations because Rust allows making more guarantees
about data.  For instance, the C compiler must deal with the fact that
you can cast a const pointer to a non-const pointer, but Rust does not
allow you cast or transmute an immutable slice to a mutable one or
access it mutably at the same time, so the compiler can then assume that
the data will not be modified, including by another thread, and optimize
accordingly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--TQ4bcfeo9nFxDAnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLtsjQAKCRB8DEliiIei
gfvkAQCoMnYlKW7AJbeJ/6JZvJ8PlVFOPIlF93jq5/8BR/UYVAEAslI9+iTFm+8/
+NHzjrqYXSH9/94I+1MJkFLWVuQpHQE=
=pyz6
-----END PGP SIGNATURE-----

--TQ4bcfeo9nFxDAnc--
