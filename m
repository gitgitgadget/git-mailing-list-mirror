Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED4C70825
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453613; cv=none; b=E2bwwOBhOQ9RvCsUpOms4MyKtVCYia7TPk38lYeMXRYP+8sHNbh537pydSmpqYrgMWMNJiuaUSXEWG2miJL+YNFRe4G2v8seng7BeS8rUYLWYhemX81J36tZWmF+h0vXn0J1tNCBilxNvRsgvCWAhmX899x7L69Wr6STvLeS/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453613; c=relaxed/simple;
	bh=CKr6Z/OaHakjD0pgVPP6SI/IEGTQkWI2Mcflg/CWg1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGoe7x71xgIOFEa7qcokFOOGXQPy5mNZG+LkQSoadxtd1yHMRBuTcLqJGnLM20exVLi3wfUz2ifvABLPmUV6LzCtaJJH9vTPOUesMO+GGn/NwcHXT0FexJdErAHJ6SwPUUMmAwYOaVYfFQHK+MEkNj+6BFgyCnckKVDoBp915fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Lc0wqoD4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Lc0wqoD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750453609;
	bh=CKr6Z/OaHakjD0pgVPP6SI/IEGTQkWI2Mcflg/CWg1k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Lc0wqoD4EK8pdJBHAXiNGyY6/bRyxw2zBr+Qa8UwOK7aobyxvqn8ihAKlZFsMDv3/
	 6/r3epxRoDITNgBMUDWSRvNKtCRtSYD/5RzOslaDk5yBi/L3/2hvnfwcSGJqXKBenU
	 cUdG+DieZoOG5aZOxCdjTZHxq8Tsc/M9/6vKQTOyZeh0DsvCx6SskDeS+AtN/W1PtG
	 dauVxW6gy7iGQ08vV3yazdTE8B+sNWFbaBcO38rK1mwmqpZD9pVvf6eWwajC/HBAMo
	 06i9lMEKWWvdF4CfDfgjCYPf9UvPsMUajpaGYRU1EFj11vrldtcljJvdeh+SuSyH80
	 +KtMfwH/YRG93zJPyVxt6e3qUAC2NlblHCbz4zC60w6ubduz1s8hWUZmeT6WSmnisj
	 hX75lF5TALpyhFzfHLy4A4PtrMt96wx447Di8vhs1nN9p14xMqHvwQDDEjS0dEZcBh
	 kKcXuu4YgmG3kq4yAgnh1Z+7XlvQbB0KLIRi/C7LGOgHMwaU8n6
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:15e3:a7c6:85f5:795])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D579720069;
	Fri, 20 Jun 2025 21:06:49 +0000 (UTC)
Date: Fri, 20 Jun 2025 21:06:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/10] Enable SHA-256 by default in breaking changes mode
Message-ID: <aFXNaItMBiPm8t-_@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-11-sandals@crustytoothpaste.net>
 <xmqqfrfu5ubo.fsf@gitster.g>
 <aFWzTv5-AjUvXWsg@fruit.crustytoothpaste.net>
 <xmqqa5622lgz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8KVffe6SGG7kd/Kf"
Content-Disposition: inline
In-Reply-To: <xmqqa5622lgz.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8KVffe6SGG7kd/Kf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 20:42:52, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > On 2025-06-20 at 15:03:23, Junio C Hamano wrote:
> >> Another thing that I suspect nobody wrote tests for, but we must be
> >> absolutely certain, is that the post-3.0 Git can still interoperate
> >> well with historical SHA-1 repositories (I am not talking about
> >> "fetch from SHA-1 into SHA-256", but "the binary does not lose
> >> ability to work in SHA-1 repositories or fetch/push between SHA-1
> >> repositories, only because the default is set to SHA-256"), even in
> >> old repositories people have been using for ages without the
> >> core.repositoryformatversion defined.
> >
> > Yes, I have definitely tested that here before sending it out.
>=20
> Is there a single t/tXXXX-*.sh test that is dedicated to that
> interoperability, or is it spread across commands (like,
> t????-clone-*.sh has a test that explicitly prepares an SHA-1 and an
> SHA-256 repositories and then tries to clone them with the current
> binary to make sure the result look reasonable, and t????-push-*.sh
> has a test to push between a pair of SHA-1 repositories, and a pair
> of SHA-256 repositories, with the current binary)?

For the dual-hash case, I will add interoperability tests in the future
when we get the interoperability code working and I'll include
same-hash, different-hash, and dual-hash cases.  I'll also make sure
that interop produces the same results in terms of object IDs that a
native single-hash implementation provides.  Right now on that code, I'm
using GIT_DEFAULT_HASH=3Dsha256:sha1 (which I added) to run the testsuite,
which sets up SHA-256 as the main hash and SHA-1 as the compat hash.
I'll add a CI job for that in the future.  (If you're interested, this
code is living in my sha256-interop branch on GitHub and my local
server.)

As far as the tests we have right now that apply to this series, it's
spread across a lot of tests.  There are lots of places in the code that
we clone a repository to make some changes that we don't want to make in
the current repository, for instance, and if clones don't work then
those tests are all broken.  The submodule tests actually add a wide
variety of nested repositories and push and pull them all over the
place, so those also exercise all the cases very well.  We do have clone
and fetch tests, as well as push tests, for local, HTTP, and SSH, so we
do get very comprehensive tests.  Most of those don't specifically
choose different hash algorithms, though (although a few do); they only
work with whatever the testsuite is doing.

Also, while I think some basic interoperability tests are helpful,
there's no substitute for running the entire testsuite in SHA-1 mode
because there are subtle variations in the protocol (e.g., HTTP is
stateless) and there are a lot of non-protocol cases we need to
adequately cover as well (like initializing repositories).  We're not
going to catch all the weird edge cases with a few interoperability
tests.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8KVffe6SGG7kd/Kf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFXNaAAKCRB8DEliiIei
gdM0AP4gF9rdIlixIPpMDYznGbOETK4dcJOFBgdyPLnpFlb/ngD/fMfmcsEw6ict
APPEuhkWkzjRzJjmYlQgw2idytFxNQU=
=96Ey
-----END PGP SIGNATURE-----

--8KVffe6SGG7kd/Kf--
