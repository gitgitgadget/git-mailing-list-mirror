Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBB21579F
	for <git@vger.kernel.org>; Fri, 23 May 2025 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042533; cv=none; b=kedm0GLE2qXOyNjzc3aAK72Pu5JWz7SOMPpfau4rrqLF6/MENElcf9f4HtDUDxzEtIUpF+9i7QTNfgOCwJZWWl/rWt4DjsqpZulTpg+lOvKSaP8aETv7YYftxh9WorbpqfINrkufpZeQ/wpJZjCWG4innVpCoEkoTc7k3fMfQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042533; c=relaxed/simple;
	bh=5ZELYiFdbBn0kPu0648JwOo//GKSmYDPhF9OYJ6heWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2qd2gSwYcuIxixs8fot4/KHtlssUsKH5q1UhRroVeIioKX7UPNATJJNW6HBCMHGaNF7WdzXyrWRckblg7Lix6PBSONVvuvrK8YvAuTu/sDuCVMyNFKhRR9Ui7qKFqg68Q/dcnOFBqUEvjeAND1pOWDzM93nRlqTBVVyiYzVhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mwDoogfP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mwDoogfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748042523;
	bh=5ZELYiFdbBn0kPu0648JwOo//GKSmYDPhF9OYJ6heWo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mwDoogfP9z8XGSvm77MGtgMTuFIFH22ru3pSx7Gx6qORGWxKIp0Cnt/ccj/EEsDp4
	 KcJtXe7tmLHAEqvt77EiM/cn7rYeRK+RawmBjrbUFnD++3QuBIPdaERNknLmCwX+r3
	 3+NyBMdrwbYMZKdRrLXsRUYbLBhLCwkFQaDq3MKevSGh3Hm0MuzyLiY48dUN+dOZLB
	 mfvaoyCMsl1yM0CpvO47Iuq6Nx3fK00+KngzL9NF8lyg1szoFrPu1lVsyay+vGcjJI
	 8p88qMjhpnpRK1IK0wZqj3Aur5WngHWUnSk8LDEuDgRaDBmfoXN79/lGAtTQ2qDVcX
	 TRO6poN1HNTVCPESXEeNAcvz/JhZfLtXA4Na7IpIyS6+Kto9WO2SM2msMkrYz/CSOg
	 rPIVBfVidjiQ/9eaSX+LUX/xSgyaDbqmcnAnk1H0s4zp/u040p/XR7gFE9qgNE6uH9
	 7Qxw3jEN8OYrPnuIk9YRjSkx2b3RHrHDI9pPPMz6B4ky6DFtcuK
Received: from tapette.crustytoothpaste.net (syn-071-015-116-126.biz.spectrum.com [71.15.116.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8136B2010F;
	Fri, 23 May 2025 23:22:03 +0000 (UTC)
Date: Fri, 23 May 2025 23:22:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
Message-ID: <aDEDGfyvkTFyf0I8@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-4-sandals@crustytoothpaste.net>
 <2e8e7eb0-f526-49cb-8f75-379fa7ef6446@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TL7peQkXR9zzoaWk"
Content-Disposition: inline
In-Reply-To: <2e8e7eb0-f526-49cb-8f75-379fa7ef6446@ramsayjones.plus.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--TL7peQkXR9zzoaWk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 21:53:27, Ramsay Jones wrote:
>=20
>=20
> On 22/05/2025 19:55, brian m. carlson wrote:
> > diff --git a/reflog-walk.h b/reflog-walk.h
> > index 989583dc55..8f0640f662 100644
> > --- a/reflog-walk.h
> > +++ b/reflog-walk.h
> > @@ -1,9 +1,24 @@
> >  #ifndef REFLOG_WALK_H
> >  #define REFLOG_WALK_H
> > =20
> > +#include "git-compat-util.h"
>=20
> Why? 'git-compat-util.h' must be #include-d in any compilation
> unit before 'reflog-walk.h', so ...

One of the CI jobs fails if we don't include `hash.h` for `struct
object_id`.  I don't remember which one.  The rule is that we always
include that header before any other header, so that's what I did here.
It is also needed for `timestamp_t`.

I will also mention that having complete headers makes clangd and other
LSPs work better because then they don't warn about undefined types and
they can actually warn when we have failed to include the relevant type,
and since we actually both headers here, I decided that was the right
thing to do.

If we're dead set against it, I can remove it.

> (Sorry, I have not studied these patches, they were just floating
> in front of my eyes ... so, please ignore me if the reason is
> obvious! :) ).
>=20
> ATB,
> Ramsay Jones
>=20
> > +#include "hash.h"
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--TL7peQkXR9zzoaWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgxAxgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3cLLXctd6eHOut6ghrz436GdS2PKUeK6r+xHAm91XRE
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJvHAQCn/KpAN6GvhcWf7DbMOUtqjiHO
4t/y6CGzLZPGTXUBtgEAr72gZ/ZtGgu7yVK0lFcoSz6YVwuNTXEANDO3ks1hSgA=
=KjYX
-----END PGP SIGNATURE-----

--TL7peQkXR9zzoaWk--
