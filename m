Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BABDDDC3
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749170686; cv=none; b=tYzcx/w/nXOgJImdNymI3ip0zBC1xWbtHEheAHLdOrmR5+u+rLIE7xLZ/o/HJPiEELr/fJL8i5N2YLGX+ZkQs5fUxqtVHZ0MfJahJi1HelnVuxvvMiG38yLKFQ+yEJCHJRmiwNTQqPBapspC/n6occ3m7ArX5tbXOAcBy5n8eFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749170686; c=relaxed/simple;
	bh=doSeU9OV7dXMmMIqyRu6yx/q7Eq2tljAo3v702gZMQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9PVM39+MZlGW69NvoXnrAsryOn5WAFijbg4Br8J73i5t6cm1fAv5WjPBXRYvDaMJls5LuKe+aZOxkQ/rsRPlkPUfBJVWsq/x/fhTzsUWTS5YioUDylE848HPEfn5BEL92O0TkAhybC5f26iu55ZM6OOfV/AjNWkjblwZstmesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=M6v+4Bd1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="M6v+4Bd1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749170676;
	bh=doSeU9OV7dXMmMIqyRu6yx/q7Eq2tljAo3v702gZMQs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=M6v+4Bd1GjoVteCZ5aYFHrTCHRNMotW0IkLYQPSVJyDYeNZYNmGZ0lOLGcALpKJ0g
	 zL1YMuxKpJRJ8Xg3mDbTrrP4nBk9S/g97eOR591h+/u8QSnabESrcFksPL2TqQorAD
	 kR61evJ94J9TkzmLNGDZ/r7xC9Jm3bJjjlXYJ+c04asr5Spts2ptvLwhJVGOI1JprP
	 M6G7D1V9ukpwXoJpf8O0u+KuPbSAYcDLFH8ZcrF/XH0ILq3bXjowAXKgJ2Ltbn+Eo1
	 3T1mztB/xD/5NRYG9Z4cuPG8Sr1UPl3YGGoeETN5LXOk9KqGqlr97ZUjCtQLBVTj6b
	 G+zeQtaHohznj97N7R7v4MiC6kW9QMRSgCJiA7y4NZs5WzY7vE4o3ptgqEqIk6kGnZ
	 cwpWMX2XMMp/8YOtRhYX4YMT/254L1J+jtZ3AmxZLg2lYIg8ZtOOBH/PD3JlGdZFIs
	 XWLxE6dUXirqsDWsq62lCeQGsKEaV1kI7gZFbBn5IOfflMXfNy6
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9612120033;
	Fri,  6 Jun 2025 00:44:36 +0000 (UTC)
Date: Fri, 6 Jun 2025 00:44:35 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2025, #01; Thu, 5)
Message-ID: <aEI584DNNP9vrpmI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtt4t69l4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tn5lKHeVxya5h+HQ"
Content-Disposition: inline
In-Reply-To: <xmqqtt4t69l4.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Tn5lKHeVxya5h+HQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-05 at 23:40:39, Junio C Hamano wrote:
> * bc/stash-export-import (2025-06-01) 4 commits
>  - builtin/stash: provide a way to import stashes from a ref
>  - builtin/stash: provide a way to export stashes to a ref
>  - builtin/stash: factor out revision parsing into a function
>  - object-name: make get_oid quietly return an error
>=20
>  An interchange format for stash entries is defined, and subcommand
>  of "git stash" to import/export has been added.
>=20
>  Expecting a (hopefully small and final) reroll.
>  cf. <127d9d03-e94e-4928-9c6d-07a5396ca325@gmail.com>
>  source: <20250601223225.464076-1-sandals@crustytoothpaste.net>

Yes, there will be a small (and hopefully final) v8.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Tn5lKHeVxya5h+HQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmhCOfIJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9DCeatBcLGhaQEaocB+3YJt86l08ZOHZ5PCeLfzIAX4
FiEECCzmip28ZfuD0cORfAxJYoiHooEAADchAP47DBDlIabApb6xpxmtJX9L1F2r
k2poIDSp98jjA0CiewEA0UXCZsPZKwZNonhf5GoQo1QLNsDVpngYhiQDLSorGgU=
=x5Gi
-----END PGP SIGNATURE-----

--Tn5lKHeVxya5h+HQ--
