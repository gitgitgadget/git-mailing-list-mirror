Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D15161
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880800; cv=none; b=GosT/pH2nKmLqydCOo5wZHkKXi+IPlZHB2YnhQ3i07l67vYTg8MsM56La6nNWsQXn5egVCCC1Ts4AteLTryt0J9zrFhHpDQPVs9ggsZd0l7dG3EVAr7fYw91emGuCpkgKYsEs5FuN9g1wtYpgkld0p2xHKnKW4ZFwJd0xP1gk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880800; c=relaxed/simple;
	bh=WE0bdnNQ469H9LeHGzUYi66m0gR9TkmZ8Kf0vNyknZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISpAjnybcedJbTqDYW8C5674KpNZJcZyKzKsVn3+pvAG2BVJ8LYhzxnYQjVKMpwYOix4UTzbfgeV124bhPb5/Yvkw9k6EH6EcsuIopZUHk12GDJTPQ96fxSkfZVXSyuIqGReXt2fboFsbSieadpBXT8TkKFeQvRspYpy/720Gws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gZOOakgx; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gZOOakgx"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B69935D4D8;
	Fri, 12 Apr 2024 00:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712880797;
	bh=WE0bdnNQ469H9LeHGzUYi66m0gR9TkmZ8Kf0vNyknZE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gZOOakgxvhwtPmoZWz7K5UStvm+/HZCo4FIPrc0YQSnsvTbdwz4o9G1TryHELe+g9
	 bTTmzKgNuqBcOLtW6Ogba9AMCQeeMZXQCYOzpXLK5IPk0ZKm3mj/ij9Ky58Zops68I
	 3shkYY39iBrVc8srJ9ousVtt9hTtTPicIb3h48mQ+NKbAH0wMXcOltjzOQj8YmohMD
	 HHp/uIJg4X+sxiPdIF0UhxEhyqx/EQdFhGQzkbqbUtvE1NVh4pZRYeA+HYwUfmQgVd
	 1215GE828qAz1/2rgbq4mWbqhOxNfopgc+kYxJ0q/oUmHGNItymJcuSw97PZDNsSJp
	 DQBIiLEyJKFkBQobCA+AOE2/C1jTTSu6DNSSziK7eeXhsJWD+xaLTWL3ovunst7pqE
	 WBjaNtY+ZzsNW42DcNdqt8xzmRywcctBB+TDWoE5lxQK8areD4zW8seayeWvS8W+ZG
	 XM+WxbH2DqHYUuRCBQepxClY5+EoDDIAttgzNQcvhP1Vl/1yor7
Date: Fri, 12 Apr 2024 00:13:16 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
Message-ID: <Zhh8nHWc8J8HpJ32@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <CAGJzqs=N79qLXD7CNo6m4x+KPzMFq5n9_wa5mbJw94VNatksNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yPDDNvOtmVtRkVa8"
Content-Disposition: inline
In-Reply-To: <CAGJzqs=N79qLXD7CNo6m4x+KPzMFq5n9_wa5mbJw94VNatksNQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--yPDDNvOtmVtRkVa8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-11 at 07:00:00, M Hickford wrote:
> Do you happen to know any public Git remotes that support Digest or
> NTLM authentication?

Azure DevOps supports NTLM in some cases.  I don't use it, so I can't
say in what situations you can use it, but I know from the Git LFS issue
tracker it's a common configuration.

Note that if you just want a test environment, you can use Apache with
Digest authentication.  However, it's limited to MD5, which should no
longer be used for any reason, so you'll probably want to try a
different implementation.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--yPDDNvOtmVtRkVa8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhh8nAAKCRB8DEliiIei
gRJAAQCPHE7SWKy27yQmsAO/ZI18rBZtWt2ggCDkw3euxOnMRgD9HbBcIVP7JzGO
y0qz83gUOvJGC+ZiC/CiMvxTb/MlywY=
=zSIE
-----END PGP SIGNATURE-----

--yPDDNvOtmVtRkVa8--
