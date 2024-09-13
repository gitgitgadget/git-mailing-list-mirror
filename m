Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C474148832
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254107; cv=none; b=aa9yzaAQMeJvOqdtA0Cmf1oavJpQhbciV352P6foiKWgmQMg5n9FHAMPI6C5XeXnHXNw7i8H9imaL/uZRELb7gtRtcQFeOCCMPXE7UdGbBsZXrEgWzpbEMZtgeHQj3fMwPzs9n8zhUMkID7Oh5rV0LvsMHne9EryOT91XSHyqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254107; c=relaxed/simple;
	bh=VPSvYPSOLP3fEQARQNjcbt54PxJ95872cm1tsbVR4fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgG4J9hCBPMhaJca86OvDGsRpPTq3gNZl6eva6sGI4aSTCMh025TphLYHmimInybr2NStaWCCKAJRM+UcWMbAiVHgPk1/MMfiifnTt2p5SUOAP/3BMP81o2b4NOY3bNIzirai8ZgwdxjBzL/NNlVUeeDwn0QDp48KOganS6iwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NR5jLbZP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NR5jLbZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726254103;
	bh=VPSvYPSOLP3fEQARQNjcbt54PxJ95872cm1tsbVR4fE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NR5jLbZPvZe8TvStUnzCLT/Uteyvlh49a4bACt+XmrCBfdlK2ChcI+5sCycTukxvB
	 55cuj3ZD4dCc7+VEyFmdMHPiw37SqMLb1Sf0VZvoWWlpKhHUgDSPm01vtpNA78TTHT
	 XKsAFxpZVTsTt+rl7kJb+hvcTiWhBzU/gGn6fyttxBT3ztZZEAXOVh2zthgPGomInH
	 BKlP1tMqzh+uAzBWtj3zi9nFLgBIscW2u2wugWzQgFzvJ28LY7q3xfRScm5lV2PcTI
	 suLufXvuR23eXSxp0G1ePmdhJ8SO5UgnSXRYcdwXBHwFrH9929qjj8Oo5FYL9HVCN+
	 hT4o9NlBaNxLUVEuDFOdDRXD+tIvsLNJYWcGknuS3OuGtEGrQ9K2dpmtdYIg7f2u7o
	 etf+Lt3PO4Y4sIqGNoEcS+NdFeqFCJ8+s2Yh31pT+MiFrjZKCTaLMBwchLJw6opjB6
	 yjahwLaYD+sj4BUy0DbA7cEn6YzMeDoNOe7NeF2Mh87v2xOpDu+
Received: from tapette.crustytoothpaste.net (unknown [204.148.121.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2124A2447C;
	Fri, 13 Sep 2024 19:01:43 +0000 (UTC)
Date: Fri, 13 Sep 2024 19:01:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Sean Allred <allred.sean@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	steadmon@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
	mh@glandium.org, Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <ZuSMFAyoD0CIfE3H@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Sean Allred <allred.sean@gmail.com>,
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	steadmon@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
	mh@glandium.org, Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-6-calvinwan@google.com>
 <m0seubo5q7.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Z8ZEVkh+vcFq5UW"
Content-Disposition: inline
In-Reply-To: <m0seubo5q7.fsf@epic96565.epic.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+Z8ZEVkh+vcFq5UW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-07 at 15:15:12, Sean Allred wrote:
> Calvin Wan <calvinwan@google.com> writes:
> > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> > to their respective Makefiles so they can be built and tested without
> > having to run cargo build/test.
>=20
> I feel like clippy should be run as part of these somehow, but I'm not
> sure where.

Yes, that seems like a good idea in CI.

> > +libgitrs-sys:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs/libgit-sys && \
> > +		cargo build \
> > +	)
> > +.PHONY: libgitrs
> > +libgitrs:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs && \
> > +		cargo build \
> > +	)
>=20
> We should definitely be setting `RUSTFLAGS=3D-Dwarnings` as an analog to
> `-Wall` in the C world, no? These crates should build without warnings.

I believe -Dwarnings turns warnings into errors (at least it does in my
tests), which is equivalent to -Werror.  We don't want that because it
breaks compiling older code with newer versions of the compiler, which
makes it harder to bisect changes or compiler on the system compiler (or
sometimes, other architectures or OSes).

That would be fine for clippy, however, because that would only run in
CI, where we _would_ want to catch newer changes, but we want to
compile nonetheless.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--+Z8ZEVkh+vcFq5UW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZuSMEwAKCRB8DEliiIei
gVqXAQD2Wfse8aVPldTX/8wx55vT73m4omRSqeH9sqm0sPjlHwD9FftQ1aiuV6Wq
KiQ3/Hz8uT00mW+8vdpfjd38R1jbVAU=
=Q7u3
-----END PGP SIGNATURE-----

--+Z8ZEVkh+vcFq5UW--
