Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC51494DD
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547580; cv=none; b=DcWQvILIEEmYtkKCIyPAyaH5apLTnj42w3AAO1HW55K+puq6udVqFe0+F/zBSVBiRoDErzUNEJ7CcFAU1nND/1mRwo4c9J+glVF7hrjklPMq2UDzJYfOo9ZatZR6yG+iWn9D+mLPxJeNgtGCboDKFMuBUbzZhi2WiDxyk+FLY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547580; c=relaxed/simple;
	bh=/8n9u+85OH1nPGLsR7xiPtyuaO0dnuyVn54IbIjFCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUTrz2KVjgXeFcj/SccKsNiLyx7iu5n98gxUoNI/6VKYFiY3L1K1m8hyKcZ6KImwprZp9ecPOvpYurTB5uCwiK8wnhqnd9WOjLL1iy1OZAEZUfSppw63orb8rpVukb61AF/rRE9oD1s/fytAqW0OFl+byi4Z6lNZkqZwK/qIHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Kt6AwRyr; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Kt6AwRyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722547569;
	bh=/8n9u+85OH1nPGLsR7xiPtyuaO0dnuyVn54IbIjFCz0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Kt6AwRyrRoSwIux4YEmtMMZ+rghwUCiYldSvye2xpGkUMO376MgVKcm8BWWefQ01+
	 tArt34osGnJPFEll1HlAXiVFaq0smJcpxK7bBYAmAf9b6gclQ+P4YeEdPJDGU1XYTe
	 Adogr+ZvMMy2fVMy/VVFgGzoc8u9XGRcKdDRyuoeFMfpIe2xD1mf4t7l5N7fanF+fX
	 kHzrgOx2/Fm1WTWPXof4LdUQJCMwjrJOf51kfyyFc/ijpSYkYCcTKdOCUVeA2dnGub
	 z4fj4kod2A5gRijiNpFyz4Kj1qnKE2HcOGrIFoXXdIej4FKXV5QZ3HqHiu8BceLuRd
	 QAPzYsh4OrSCSFDmMmNu91paoahbvsti4hNiTXIDOPcy5uYOyhUw3XgUzIKUclzvXe
	 K8Bo29j7TaMJuTaTU3nZgr4l2h5r+5BVHU9M3ZvlhHd3Fcn0DPd8nVILFG9wKIgN1y
	 lBzz8Iw7f7pyvpPhxx3/CJqHB4+W6TtO9QKWBVcF6+aKySi64tM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B59BB209B9;
	Thu,  1 Aug 2024 21:26:09 +0000 (UTC)
Date: Thu, 1 Aug 2024 21:26:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "W. Michael Petullo" <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
Message-ID: <Zqv9b_B5wKGp331o@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "W. Michael Petullo" <mike@flyn.org>
References: <ZqZjRMqpEV_3WIkD@imp.flyn.org>
 <20240728224807.GA1299337@coredump.intra.peff.net>
 <ZqjQi6i2kiY4gcc1@imp.flyn.org>
 <Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
 <xmqqv80m8pha.fsf@gitster.g>
 <ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
 <20240731072832.GB595974@coredump.intra.peff.net>
 <xmqqo76d7coa.fsf@gitster.g>
 <xmqq1q391afc.fsf@gitster.g>
 <20240801061417.GD621899@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ZSdGR5Hyz+w3tF9"
Content-Disposition: inline
In-Reply-To: <20240801061417.GD621899@coredump.intra.peff.net>
User-Agent: Mutt/2.2.12 (2023-09-09)


--1ZSdGR5Hyz+w3tF9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-01 at 06:14:17, Jeff King wrote:
> ...this is doing that loosening for upload-pack by default. I'm not sure
> if that is OK or not. My mental model has remained "it is OK to run
> upload-pack on an untrusted repository", but it would make sense to get
> input from folks who looked at this in the past, like Dscho, and/or to
> reassess the threat model from scratch.
>=20
> In particular I did not follow all of the potential issues with linked
> local files. Are we good now after other fixes (in which case this patch
> is OK)? Are we good only for non-local clones (so this patch is OK only
> combined with a fix for clone to check ownership for --local mode)? Or
> are there still problems if an attacker controls the repo paths, in
> which case upload-pack should remain conservative?

I think we already have such a patch.  In clone, clone_local either has
option_shared (in which case we simply refer to the other repository via
an alternates file and don't touch it in any way), or it calls
copy_or_link_directory, which in turn calls die_upon_dubious_ownership.

The other case, where is_local is not set (and thus clone_local is not
called), calls transport_fetch_refs, which either calls
fetch_refs_via_pack or fetch_refs_via_bundle, both of which I assume
actually make a git-upload-pack call.

One related topic that is potentially interesting as well is whether
`git bundle create` also offers the same security guarantees as `git
upload-pack` in that it can be safely run on an untrusted repository.
Either way, we may want to document that.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--1ZSdGR5Hyz+w3tF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqv9bwAKCRB8DEliiIei
gS3vAPoDGOmeBOuxOILG0omZ99pTgzPpp2oj2jkQHWahG2DnewEAwPzvT+F0X6Bd
KUxQhVHTPX0ti++Qs1amYW3aYqtAiAs=
=gIgI
-----END PGP SIGNATURE-----

--1ZSdGR5Hyz+w3tF9--
