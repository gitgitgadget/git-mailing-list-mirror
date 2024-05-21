Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8D2AE6C
	for <git@vger.kernel.org>; Tue, 21 May 2024 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330803; cv=none; b=LseeKo1cd9pEzxyhsbUdf5C12RMq90tU/ZFPv4g6Cle5B6kgxdDckRlLxXNNk12roslGU5n4onMsuztJWGOkTvSq9erwEX3IQycn1YND8a0fjVZpXlQq094XEV7YunwH8KlMhqAK0B5aLt8GfRSBmqJu8eQ8AZeuz7VnXNiaio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330803; c=relaxed/simple;
	bh=W9sRjQaunJv6l7py5ZM3sv6a7q8KZo7sD88McYzP+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMGAg+OUEG7blTUNgyP7FT0HBKjEcKaKCb/y+xz4CjwbQ40Xgs/T9yCac9Ohaux0/kALl3hWDq3JOydt3on9DnqUJcLkA9bY4JQUoYivh9dvuJW1hfFX9FXBDOAanWdkmQ4+d03YgMuRLVmwl21qcr7unBq+OHhKTx9/K62ndYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=TL1c60j9; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="TL1c60j9"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 762565DA99;
	Tue, 21 May 2024 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1716330794;
	bh=W9sRjQaunJv6l7py5ZM3sv6a7q8KZo7sD88McYzP+Fs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=TL1c60j9CSKbts/zyEtxyCiMO3ofw3UOAk+lBNEn+UKhSKCU0zxh1R2MkQw38A4tQ
	 NaTxI38EdQorTbIVuICWQdJOW29nUp9J2BC7/nEzY67Nl3+W3w9PCOw1iZMAlWoAK9
	 OPXB4TlQ+1pQAL8dfafhL4mDQ7yOEg6YT7J1OO54eqViWWHvUkyl1Zb086dTBmlNFs
	 ES2RwOaMWGdO8Ydbysj3Rn7LG08aKKy32WsEdppE72o8k0KnpA4KXNHIHIoEhuTFW5
	 TDdOOgISqH2Ng+/yALG6SD4/d98DL51Q8bemA+jLLrX8aHYIO+Nphdzccnr/eLlfkq
	 lmfIBKnz/X+mWEiFqEN19EBko0065jK+mGNOQJrww1Wn/XdE59f05wVKXiq12fQeck
	 J0VmBU5HULwoOkG8NGPf2euHEtuabxuSmFNB/WLq6QRa7Ajyzyid15+bPCnwe3wMD0
	 /3o5/QRNHhteoO9iPtLBSw9RqVvnQg23Si8GvcVCOZKJrIRiH11
Date: Tue, 21 May 2024 22:33:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Various fixes for v2.45.1 and friends
Message-ID: <Zk0hKCsbjFGkguFQ@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
 <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8pcvsSUMDKsVVFeK"
Content-Disposition: inline
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--8pcvsSUMDKsVVFeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-05-20 at 20:21:59, Johannes Schindelin via GitGitGadget wrote:
> There have been a couple of issues that were reported about v2.45.1, and =
in
> addition I have noticed some myself:
>=20
>  * a memory leak in the clone protection logic
>  * a missed adjustment in the Makefile that leads to an incorrect templat=
es
>    path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.45.1)
>  * an overzealous core.hooksPath check
>  * that Git LFS clone problem where it exits with an error (even if the
>    clone often succeeded...)
>=20
> This patch series is based on maint-2.39 to allow for (relatively) easy
> follow-up versions v2.39.5, ..., v2.45.2.

I looked at this series and seems fine.  I tested it with the latest
HEAD of Git LFS and it seems to function as expected.  I appreciate the
prompt fixes.

(My apologies for not getting back to this sooner.  I took a long
weekend for the Victoria Day holiday and was busy riding rollercoasters
instead of reading the list.)
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--8pcvsSUMDKsVVFeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZk0hKAAKCRB8DEliiIei
gRAvAP9L6BPoxSzsSDAS/lOdpaqHZf/6VwinV1uNi2kELYiWswEA1wEFz9Wn8+ZJ
o1FDE8+wtWcaYy0g5YHyXQNuvox3mww=
=GQPZ
-----END PGP SIGNATURE-----

--8pcvsSUMDKsVVFeK--
