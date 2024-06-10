Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9814F9C4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056947; cv=none; b=I9Qkk5KBiwraZScXtEKuhnYcKwDlnETdzjRsHoUZNeFU7WmJ1NvAB2oR+cxJaomlaIl2ODfbUxIRHa832BCdO6rRZctXA0Lm4WEqXCbXTKBTGyU8nI4KOgz48QdfvNc9F6eNFhgVy5u3cnzmXUBKCWuSTz7FTGQJH2OE2RQ7nK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056947; c=relaxed/simple;
	bh=0X0mUzJJY2rFWcMkG1LOrMbBU5UIUZpQphRPNe2ePuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7qodNnINQsjby6L15wP1wiO5rlGH3sugo+jUawocFiqDih68SRauyq3i0igTx6IYjkzK8Gho5MLJtQs7HVD/+8F7gUftYJ6xykycKvXqR57aL/UcbOA/8CeRp33ulC9k9TrnTrCEo84j/7l1VTcwgb6ctugWlGyvmAt1I620h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SUZwh3uS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SUZwh3uS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1718056940;
	bh=0X0mUzJJY2rFWcMkG1LOrMbBU5UIUZpQphRPNe2ePuQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SUZwh3uSRN2sxCoqn8XmeJ3rp7Tl0Wf68/0KhQy5yBZsx7glySERBfwIlSLogV5St
	 9TAWVIUxX03lF80VcGzSwro+YZU53OfbWPmWot9AHzpvl29jSvQA50pPqjvqsvqwVp
	 ZY3diu5cdA3/mjc1wNnLCBVfBMNa3S3ij26IspDXKBhTTaDRj32QvH8Hst7ntjNuhx
	 g02O0vOtbkGh9lA0xdjbbwR5fsQdjcNJ2z3Ya42vsmgk5288RqYCpYYppxf5+3QVpb
	 xDbIdgq+tFxvHW+W5Q7a3tKoqkiWGJMshwfTyCekI45c2NXqbyEh2aesXxKhom+Zd8
	 NtUTiXKK+jCImId1fmg3gOoe4qwhVdJnuAWB3jIo5nPYIFtrJ3o4puFidqe1P3uoDv
	 aiMNISdWvqr7ZkAORmwYUS1OWqMxug8ydMRUWS8PG7SWvNTu7atml3trSGTCTBpW8n
	 G3k53Yw+nddNuAS8++P5vXJLChb2uWr6KRdwkUx/36QbB2NttW2
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5C2982639A;
	Mon, 10 Jun 2024 22:02:20 +0000 (UTC)
Date: Mon, 10 Jun 2024 22:02:18 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andry <andry@inbox.ru>
Cc: Git <git@vger.kernel.org>
Subject: Re: [ISSUE] `git submodule update --init --recursive` does ignore
 `fetchRecurseSubmodules` flag in `.gitmodules` and in `.git/config`
Message-ID: <Zmd36kkRM543zlQs@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andry <andry@inbox.ru>, Git <git@vger.kernel.org>
References: <153002248.20240610041910@inbox.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkvwboW8VAwvv9qE"
Content-Disposition: inline
In-Reply-To: <153002248.20240610041910@inbox.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)


--fkvwboW8VAwvv9qE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-10 at 01:19:10, Andry wrote:
> Hello Git,
>=20
> First discovered here: https://github.com/gitextensions/gitextensions/iss=
ues/11783
> Another discussion: https://stackoverflow.com/questions/58403616/does-git=
-submodule-update-recursive-override-fetchrecursesubmodules
> Manual: https://git-scm.com/docs/gitmodules#Documentation/gitmodules.txt-=
submoduleltnamegtfetchRecurseSubmodules
> ---
>=20
> If use a recursive submodule, for example:
>=20
> A->B->A->...
>=20
> And call submodules Update on A, then the Update does ignore the flag and=
 keeps fetch recursively with the error at the end:
>=20
> >  fatal: Failed to recurse into submodule path ...
>=20
> Is that supposed to work this way or is an bug?

Yes, it's working as designed.  From the documentation,
`fetchRecurseSubmodules` only applies to `git fetch` and `git pull`, not
`git submodule`.  Even if it did, you still specified recursive
behaviour in a command-line option, and command-line operations override
the configuration.

If you don't want recursion, you'll need to skip the `--recursive` flag.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--fkvwboW8VAwvv9qE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZmd36gAKCRB8DEliiIei
ge0HAP443EnQQuaTRJOSS1gEKzK8+/osGH6LNKCDLcmB6q8+RgD/dZCu0mgaNk8v
DNvLFxqi0CxJz1XE+49Mww8hGvXyTwc=
=j/nS
-----END PGP SIGNATURE-----

--fkvwboW8VAwvv9qE--
