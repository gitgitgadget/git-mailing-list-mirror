Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4539281D
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694121; cv=none; b=qhBzh9kx9jOsYZa/FbTi47pEfgts8zn0QaKCtMNaQOE6ntfZRzRBcVfQO0fKVmP8FABz36IJ8lmpWEVDz+nP7v3sRp744LbCoSUJXjf9XKZwSt6Sb+T8ltrLV9PCTlYEISygbvkKS8BJMh5+ZUItUN5epE/IoD5AHbYRnfT1488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694121; c=relaxed/simple;
	bh=krEB5/95CMpWjBccUbr3sT7IGlVu03qsluTGkVYbMdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmdLKmZUKa8xOF8goGfaj2bQrovCoKME1xKwAeur78wu9wAY5LNKWco9fcZci5MERow2Yg1RLCkYz0/QyRrcJJYgW5+aigZKmmuL1cJH5QRSSjxuxst35scdl7a6go9aSICKouAxANKNZmjN6DSlAdmTN4CCGhmSJhROVYtdpB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=BHiqd0KH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="BHiqd0KH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787694118;
	bh=krEB5/95CMpWjBccUbr3sT7IGlVu03qsluTGkVYbMdY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=BHiqd0KHNXKAVq1eCAYjG2u1g72GE3NnclljNTx97Zn5qn4QDJiQ7tFn1AlqywH1/
	 AEd0iFL4dHii7sDuwzWFmu7qqptWCaDxBXEz3B7PQ5RKdaiNo8TsfO/fK09NBrfrqe
	 JcewItTGcnNJj+tLSJPd9wLap/v1juJsoKGMm8b5GSt/ZJYfu7ykIHTi+oks5xvWp3
	 TFb9LH0BWGNLa/l5p2b0uSt5slpyyhW9MGex8XSgQO4zPCpoWhFGVhFdXutLO+RKeG
	 8odYDO0GhIX+ToCBsAMuTKlas+/z1nSFXUZu4X9MzREFAPD4TGuaz4TqsdeIBUi1Nm
	 ++2DIZyesAD8SpT+YPxEVBRm1GXP/nz0AXHJ5bTXshKEhOxyF5nSChSBnmaf7RUZ29
	 gPnk23eaftKJ3HgflHhdjNhn1+KkNY75Iwez72O5jUUGslu8+nNem5C2JJIpY0dmAd
	 wqh+xAkLif6bqw3rpJquR4+3OTVka/YYAJbHkNCvoiYfQgoQFPZ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:23b3:441d:199e:9561])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5D9C920101;
	Tue, 25 Aug 2026 21:41:58 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:41:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] object-name: use hexval
Message-ID: <ao4MJQgp6Ai4tJxi@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <20260729233215.398654-6-sandals@crustytoothpaste.net>
 <CABPp-BFDaWdahoOnNRGQjshzQXin1YLuROv94W_PrajnLWDAuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzQItSUaHuz98YZG"
Content-Disposition: inline
In-Reply-To: <CABPp-BFDaWdahoOnNRGQjshzQXin1YLuROv94W_PrajnLWDAuQ@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--pzQItSUaHuz98YZG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-25 at 19:44:34, Elijah Newren wrote:
> On Wed, Jul 29, 2026 at 4:33=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > We've open-coded a different implementation of parsing hex values here
> > when we already have a perfectly good one in hexval.  This
> > implementation will almost certainly be slower because it isn't
> > table-driven, unlike the other one, and since it's not constant time it
> > has no other advantages either.  To tidy things up and prepare for
> > future work, switch to hexval in this case.
>=20
> As Junio noted, you may want to call out that your replacement drops
> the case-normalization that the former parse_oid_prefix() provided.

Will fix in v2.

> [...]
> > -               unsigned char val;
> [...]
> > +               int val =3D hexval(c, HEX_KIND_OID);
> > +
> > +               if (val < 0)
> >                         return -1;
> [...]
> >                if (oid_out) {
> >                        if (!(i & 1))
> >                                val <<=3D 4;
> >                        oid_out->hash[i >> 1] |=3D val;
>=20
> hexval returns unsigned int.  Is there a risk that someone "tries to
> fix" that discrepancy by changing val to unsigned int here,
> inadvertently causing the `if` immediately below to become dead code?
>=20
> In patch 1, in hex2chr, you used a (val & ~0xf) check together with an
> unsigned int val; would that make sense here, or is that overkill?

I can re-roll with an appropriate change, sure.  I think that we'd need
to have a slightly different check, but I'll tidy it up accordingly.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--pzQItSUaHuz98YZG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqODCUJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8iwsKGWD7sCJcWe1Kje4eFrmrHSLPhJxYsQKToSr+Ql
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAP6gAP9ui0SfbYxx4MQwkxQKnXOoVRnT
OSeBlpV9RxMlKcdWLgD+Ozd1loIQzXFSci37cJOzb0n7Zqesbom3WnA0EVEuhQA=
=rMZN
-----END PGP SIGNATURE-----

--pzQItSUaHuz98YZG--
