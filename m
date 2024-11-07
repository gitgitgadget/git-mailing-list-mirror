Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC067E1
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940512; cv=none; b=ZRVOdDjVPwbcGBxK64uulhsEpZ7cTGBO4wLPOkTkxApKKUOuF1WbwNBrUtNvCuC/G/1xQc4WQYkT4DhlxsGvjMO82axAqUsKKd8VTRqWj04nPcJWD06PbqwHjEYke/LDWFLRoFe4e+YNkbh7iaQZCmqe2Z8BS8r5/aCBmpOH/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940512; c=relaxed/simple;
	bh=tnWmhXWwub9I7KEoSKv3+BUjtTWaHYRMCRl2oy2fTOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMYHT1vHP8bDKJVMWD3JiojDMAXTgZ5ocZn9DOL9LW5lvL/iods52pavMmhskLFNi38ZXP44T20TfY35Pqpkpov0rd3vi7CDjf2X7Blk1678qrX1RbfvCx97yOoh/lN5FB5Zh55eoyhZmc6pd7McaQLPohKcr0BbH3UCdiVDt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bZsC59qU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bZsC59qU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730940507;
	bh=tnWmhXWwub9I7KEoSKv3+BUjtTWaHYRMCRl2oy2fTOM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bZsC59qUsXFTRisaBnZkvk6d/NlUiaEpZ/YtXP7L/PEywFdQyBo02lIgMsoqXmZVm
	 DVC254dTVGoROf3+jcok+0dGlsC/qBQ2uQs55hRQqTavIpCod2ahUghzGLvVFxQQbj
	 2vaumvnm16SpXrgFHVsbYwwoI+sQBNVk4Ls7+bH3mXhdYr3GqJUg++/T6eABnCBRXv
	 he87hFHGqYMjBivkdVQaUndb1u+B2ztixhx75d5o5LQdelu9oQyAIRL9TjnUVmygII
	 c7fiqt2+vTy5Td3f2u7I2XUROJBlQtssKXzVsfNpVC663wOue3cljO8/EjVonyudBF
	 tJMhSDd0dkWderUx6gv+yu6SCSt7d8EHyFOAVM9pAEe2h7yJGzXFODcQy3YyD5IKx+
	 kAcYa26cYAkU00RfKiqRuIDqmb9lafM5oPvgOEpU4/Qfsl7xd8OizN+zOcTwyhQiDG
	 q49F0+TpC3UA8k76iXa6PntQYg7psnNVasjx1iKxSePASwnU+tl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CA3EA20080;
	Thu,  7 Nov 2024 00:48:27 +0000 (UTC)
Date: Thu, 7 Nov 2024 00:48:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t/helper/test-sha1: prepare for an unsafe mode
Message-ID: <ZywOWn08cGBnBWM-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
References: <cover.1730833506.git.me@ttaylorr.com>
 <0e2fcee6894b7b16136ff09a69f199bea9f8c882.1730833507.git.me@ttaylorr.com>
 <xmqqcyj9qgyf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obM7x+XUBs4RIVWm"
Content-Disposition: inline
In-Reply-To: <xmqqcyj9qgyf.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--obM7x+XUBs4RIVWm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-11-06 at 01:38:48, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>=20
> > -int cmd_hash_impl(int ac, const char **av, int algo)
> > +int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
> >  {
> >  	git_hash_ctx ctx;
> >  	unsigned char hash[GIT_MAX_HEXSZ];
> > @@ -27,7 +27,10 @@ int cmd_hash_impl(int ac, const char **av, int algo)
> >  			die("OOPS");
> >  	}
> > =20
> > -	algop->init_fn(&ctx);
> > +	if (unsafe)
> > +		algop->unsafe_init_fn(&ctx);
> > +	else
> > +		algop->init_fn(&ctx);
>=20
> It may be just me, and it would not matter all that much within the
> context of the project because this is merely a test helper, but
> giving a pair of init/unsafe_init methods to algop looks unnerving.
> It gives an impression that every design of hash algorithm must come
> with normal and unsafe variant, which is not what you want to say.
>=20
> I would have expected that there are different algorighm instances,
> and one of them would be "unsafe SHA-1", among "normal SHA-1" and
> "SHA-256" (as the last one would not even have unsafe_init_fn
> method), and the callers that want to measure the performance of
> each algorithm would simply pick one of these instances and go
> through the usual "init", "update", "final" flow, regardless of the
> "unsafe" ness of the algorithm.
>=20
> IOW, ...
>=20
> >  	while (1) {
> >  		ssize_t sz, this_sz;
> > @@ -46,9 +49,15 @@ int cmd_hash_impl(int ac, const char **av, int algo)
> >  		}
> >  		if (this_sz =3D=3D 0)
> >  			break;
> > -		algop->update_fn(&ctx, buffer, this_sz);
> > +		if (unsafe)
> > +			algop->unsafe_update_fn(&ctx, buffer, this_sz);
> > +		else
> > +			algop->update_fn(&ctx, buffer, this_sz);
> >  	}
> > -	algop->final_fn(hash, &ctx);
> > +	if (unsafe)
> > +		algop->unsafe_final_fn(hash, &ctx);
> > +	else
> > +		algop->final_fn(hash, &ctx);
>=20
> ... I didn't expect any of these "if (unsafe) .. else .." switches.

I don't think we can remove those, and here's why.  Certainly Taylor can
correct me if I'm off base, though.

In the normal case, our hash struct is a union, and different
implementations can have a different layout.  A SHA-1 implementation
will usually keep track of a 64-bit size, 5 32-bit words, and up to 64
bytes of data that might need to be processed.  Maybe SHA-1-DC, our safe
implementation, stores the size first, but our unsafe implementation
is OpenSSL and it stores the 5 hash words first, or whatever.

If we use the same update and final functions, we'll end up with
incorrect data because we'll have initialized the union contents with
data for one implementation but are trying to update or finalize it with
different data, which in the very best case will just produce broken
results, and might just cause a segfault (if one of the implementations
stores a pointer instead of storing the data in the union).

We could certainly adopt a different hash algorithm structure for safe
and unsafe code, but we have a lot of places that assume that there's
just one structure per algorithm.  It would require a substantial amount
of refactoring to remove those assumptions and deal with the fact that
we now have two SHA-1 implementations.  It would also be tricky to deal
with the fact that for SHA-1, we might use the safe or unsafe algorithm,
but for SHA-256, there's only one algorithm structure and we need to use
it for both.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--obM7x+XUBs4RIVWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZywOWQAKCRB8DEliiIei
gaCXAP4yr4rTQwo6yZvQinpqqPgqYmAg1yDJGMSrCdw6JhNWYgEA25/M1Ap6Kq6C
KHJ9t1rPALmBPjDsSxIVRnlQNj/RQgA=
=6A8a
-----END PGP SIGNATURE-----

--obM7x+XUBs4RIVWm--
