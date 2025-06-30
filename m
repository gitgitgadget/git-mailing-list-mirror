Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582B4A35
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317645; cv=none; b=ZKK+BOa4LevITYBOnSflFVCAL/It9DANr5EaD/VomLij01jdLhtcnWHn4MW8+joFuzq7nPz9x0tp+ktgZnKSn1Bsu6JWvbGw97D+H5oXmsGHHLRZso8LiEcc+pUSzr8gTHi68C6zD0N1TJX1xrPrmrQhcBG+8w7PPtiu0h4bNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317645; c=relaxed/simple;
	bh=heGJomEW2pyYj0Gxuv6ShgcvWhxQMOB3xJIa3l5mtbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIjqoPi43iGTXLnQE1pZJgvdyIEf1Z8Nr3iMcrKcLwxV2UAsc9Z1lYLjE4Jv0leLjW+BNBQWkvNngoXfxZkqTFFRb1nHQARoVS++FRodRRtx5AjI5Mi4SWzYSunRNtUI2sI62V4vYECaKefjbkIHoNvf+hiIgvRE/KiiCFfQgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JNqFmKN7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JNqFmKN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751317640;
	bh=heGJomEW2pyYj0Gxuv6ShgcvWhxQMOB3xJIa3l5mtbs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JNqFmKN7+tF1UFO+rdHcaz06HZSJXGm7ehZFLftIDTuJORJnx+ommqrQ3fS2iMeZ8
	 6+HbsTfzd9C4wJfVxpBJeN50DU4/YVyfsZmv8oAJtlR85jL1CC8urt+vE0ZEuVrP0O
	 slwoPgAzmDpp2Um7T0B2udakfUlDrwoY6lkxhUo5x94+oyp0DTPh1Ddz8eejScsoW4
	 dF/bTDJfvGJ6WtcYAzONrVxiRYcqS5NMzTmf3k0IgEbczC6Qao8GqxoRaKSYPaD3dL
	 BAYtMOcTVejFcy1Jljdv0DBKLgprouD2e0+9VVe9Znf8xCE0pYR8LRQ/IUWdDU+VGO
	 TJx3qFMJtch69ifGeRBkhuXt6l93+N0c7r6e4EZJaoR8I11fuqi7/K3IAINKAZxVBy
	 V1PxysqyCVQWNPoMQLYBUCcNQqq/tBZHN0XGB0cbjsJUPEHu/w/nNtXnu2shlM/7Lw
	 5BQJeclow3ZvTscLse+eLgRFmvHpJkhR1MFVo8QyqPLMMC3oisD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a75c:9d59:319d:c156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2F8132003B;
	Mon, 30 Jun 2025 21:07:20 +0000 (UTC)
Date: Mon, 30 Jun 2025 21:07:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Git PLC <git@sfconservancy.org>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate
 changes
Message-ID: <aGL8hubqY35UAaGh@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Git PLC <git@sfconservancy.org>
References: <xmqqcyalm0mh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LvXeyeDFbvUjBsas"
Content-Disposition: inline
In-Reply-To: <xmqqcyalm0mh.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--LvXeyeDFbvUjBsas
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-30 at 20:32:22, Junio C Hamano wrote:
> Following the example set by QEMU folks, let's explicitly forbid use
> of genAI tools until the copyright and license situations become
> more clear.  Here is what QEMU folks say in their commit to adopt
> such a rule:
>=20
>     The DCO requires contributors to assert they have the right to
>     contribute under the designated project license. Given the lack
>     of consensus on the licensing of AI code generator output, it is
>     not considered credible to assert compliance with the DCO clause
>     (b) or (c) where a patch includes such generated code.
>=20
> and it applies equally well to ours.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPa=
tches
> index 958e3cc3d5..63fd10ce39 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -439,6 +439,23 @@ highlighted above.
>  Only capitalize the very first letter of the trailer, i.e. favor
>  "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
> =20
> +
> +[[ai]]
> +=3D=3D=3D Use of AI content generators
> +
> +This project requires that contributors certify that their
> +contributions are made under Developer's Certificate of Origin 1.1,
> +which in turn means that contributors must understand the full
> +provenance of what they are contributing.  With AI content generators,
> +the copyright or license status of their output is ill-defined, without
> +any generally accepted legal foundation.
> +
> +Hence, the project asks that contributors refrain from using AI content
> +generators on changes that are submitted to the project.
> +Contributions in which use of AI is either known or suspected may not
> +be accepted.

This matches the advice we gave contributors to GSOC and similar
projects, so it's good that we're being consistent here.

I think this seems prudent given the fact that there are 181 signatories
to the Berne Convention and even if the courts rule that the use of
generative AI is acceptable in one country (say, the United States), it
isn't clear that that will mean anything in other countries (such as
Canada).  Considering that there's ongoing litigation and quite a bit of
legal uncertainty, as well as substantial pushback on generative AI from
the open source community, this approach seems like it's in the best
interests of the project at the moment[0].  We can always reconsider in
the future if need be.

I'll note that this was my interpretation of the DCO from the start (and
I have governed my behaviour and contributions accordingly) but it can
be helpful to explicitly document our shared understanding.

One style note: I noticed that there's two blank lines before and after
this block.  Some sections have one blank line between them and some
have two, so I don't think this is a problem, but I thought I might as
well point it out.

[0] I know some large companies feel differently, but considering our
status as a member project of Conservancy (which is a non-profit), our
comparatively limited assets, and the potential negative legal effects
on downstream distributors (many of which are independent people or
non-profits), I would say we find ourselves in a different position from
those companies and would need to make a different decision.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--LvXeyeDFbvUjBsas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGL8hgAKCRB8DEliiIei
gdRbAP95BSZXs/hnegkWHbUzBUOvaiKxdz+62kxFlH+Tgmpp7wEAjUsc1SFFKBTs
bxSvQ55IB47AkhJXzJggnfLOpXFVjQE=
=9Fqs
-----END PGP SIGNATURE-----

--LvXeyeDFbvUjBsas--
