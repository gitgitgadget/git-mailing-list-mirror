Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019E25A658
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737081702; cv=none; b=i86mbwIyCSt2W3zSSxvLdh3o3QrhzmH9d31EXqk7W9vXuRBfI5hixs4gppRZId0PB0vIvcPEWPuBeZ2XVuZx+o7gkB1X2TleVmDIPXGQKngsHZeDSoczzZECLQ4sFHGhWpNbRjSEPU76c8vrXquyhVa/blHlr5XzXGrx1HoOVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737081702; c=relaxed/simple;
	bh=qq5aog+wrPvq1Du/fx328hj4bi+FD4w7qap84WBWZyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm6LfiNJp8xcn7Cgxi8R8BL3UVUm7smwYIdIFmvHV3eaUi4hrhv81r5mMiU1aPgnePskJsouhbaS6oaJ2hKDmxJHVDhYHEs1eDpOqJvVt/xUvWYZOLPxL426y1rPx4U8UxXTKTdrtp0XLu4iWeb/O6vc48rj+xpdcdzUNjraQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=HBvZweOL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HBvZweOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737081692;
	bh=qq5aog+wrPvq1Du/fx328hj4bi+FD4w7qap84WBWZyo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=HBvZweOL4V4D1D+6Tpr/nx8FqFrJQZMPO9//isc7vFAHIgbw0x47OylLgYNBaiXsa
	 3H9Md91G8K+VXMJjWPfrN7BQePK1kQtNjfHR6zl+pHC9IQtySmJ7bqZMTy1qPl6Y28
	 DhK24l3+Ig7iC02OdrDvQiTOWTlyNDJCGtvSvutp/s+VENjyuurjKSFK0Idm4Yed64
	 ZifB5+wCHR+46Wg0G/dxrmAcnAYaRRXb/FxMGsD7f/rVnbsEvqePsR/G6HTsyQTgSZ
	 FXe+D9hiCQHP+bX7276ZCI7vBSaJSjCfThdz76Y33fQrFgFPLjybuiOobBYvXSe7g5
	 AlaNqFIrhssxuCviunA3XTsmazY3C4XY82Q7ZPje++yG3ZIfE91KJA3ZYBTNK/XEJY
	 rTC2b5eDXQKYcl7qxbBQUrFkVytbZObIH3iB1F8jlRAPcefTqgPZ5Ns4ed8foAaPk5
	 SpCdOhPK0hl4sv5yxMpTOpp5KbPxIpWszVMYqYjJZw+oDm60KR1
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 512CE20035;
	Fri, 17 Jan 2025 02:41:32 +0000 (UTC)
Date: Fri, 17 Jan 2025 02:41:31 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] gitcli: document that command line trumps config and
 env
Message-ID: <Z4nDW2FQ-MdWbW5P@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
 <xmqqy0zanzdw.fsf@gitster.g>
 <xmqqfrlinuys.fsf@gitster.g>
 <xmqqzfjqmbza.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cX+KTR7SSNHeFynO"
Content-Disposition: inline
In-Reply-To: <xmqqzfjqmbza.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--cX+KTR7SSNHeFynO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-17 at 02:05:13, Junio C Hamano wrote:
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 7c709324ba..00b71bc462 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -152,6 +152,23 @@ can use `--no-track` to override that behaviour. The=
 same goes for `--color`
>  and `--no-color`.
> =20
> =20
> +Options trump configuration and environment
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When there is a configuration variable or an environment variable
> +that tweak the behaviour of an aspect of a Git command, and also a
> +command line option that tweaks the same, the command line option
> +overrides what the configuration and/or environment variable say.
> +
> +For example, the `user.name` configuration variable is used to
> +specify the human-readable name used by the `git commit` command to
> +record the author and the committer name in a newly created commit.
> +The `GIT_AUTHOR_NAME` environment variable, if set, takes precedence
> +when deciding what author name to record.  The `--author=3D<author>`
> +command line option of the `git commit` command, when given, takes
> +precedence over these two sources of information.

I appreciate you taking the time to document this.  I remember it coming
up recently on the list and it's good that we're writing this down and
documenting it.

This is useful not only for end users, but also new contributors who
might want to implement a feature or authors of other tools which
interact with Git, who will be able to write tooling that behaves in a
similar way on the first go-around.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--cX+KTR7SSNHeFynO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ4nDWgAKCRB8DEliiIei
gQwDAP4kepjctO7Z0srG3Wr/givA9O3vUamKc43A8eguVPBXHAEA6TdghrMRF+2L
5Krs4AfV/a/185tygDmu2vmL+lPfxAo=
=ACBY
-----END PGP SIGNATURE-----

--cX+KTR7SSNHeFynO--
