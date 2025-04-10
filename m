Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6131EDA39
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323068; cv=none; b=HorRRcQDlZV1OVXa3U7XZwTZt8yHP+li6FvdVYa6BC967keV3DCmguqq0ymWiUm1AcL+mFmRg9joasezFrxCc3DbLCWlE1+H2GR85XHtpTkeBpfVdIgcqn+CmuawC0CrnLwNFpcHX8knoKpQ6Wqx/8UxLw4c6PcR9iRXfXWTVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323068; c=relaxed/simple;
	bh=JtoE/PL/rEg77pTBqtSE9R2cHYIQnpwkCrrMzkXS0L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLee2O+xlxYXAqZ6Eiq5Ubb8/Ah0OwoqVywTKxue4sri1WuWzuWX3RMREDtQV8h6dfgS+6Vdemqj4/sx0+ShKOiPN2nvuxIAuVQ5Pr2grX2jPRkkBZr10Lo9xTLzMKbJD5DMETEqiRScUKRw9w+XaRlq8dLry9tBcbITfio+wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wLwN4AG/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wLwN4AG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1744323063;
	bh=JtoE/PL/rEg77pTBqtSE9R2cHYIQnpwkCrrMzkXS0L8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wLwN4AG/fWEW8Z0Dhrx3Ku6YeNXU6yE7XH/cxzH7vkHlAgf7v1LHqG2lfwmrwpxKx
	 +FbUgEg3FVhVqjA3SnwSzifhHbQnxiGJ2NoGHBrSEcGxxIngN7Y4d1RCnwUbHT1SG2
	 GDP8W8Xjxogivf0QqtS8gJmPoSrIc3rqFRH/H88shXsvEB9fYVJWvGWQ7VYx6VfGnn
	 jMMI98c9+nR6WwwX4iE02H0uR5rvEzx3/0qE7VKghoohvnWE3bPK7sL3LrBQ+ZIHnf
	 rRSX796QAxzk4yt0VrjT7X0Za45IOa8bt6IMDaEyUUOlbH75lxnJkkxL/PAShAs34I
	 5afFl3jQVgujQcsSow6oLVsMAEwOSQ21wIcrAj7WUoSWnaB6mfYket8D0gGl2DgIsp
	 sT7RAY/HB08XY1tvm7epLuyOHzSMeWfvpZCC+nnHdYXBE2bc4me4GkDslFV9pXaPMo
	 yc1UFep1/tToS2IKY3BScTXr1TVLeEZ8ARrNNnYzPmi+IHTD23L
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BBE1C2010E;
	Thu, 10 Apr 2025 22:11:03 +0000 (UTC)
Date: Thu, 10 Apr 2025 22:11:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ross Goldberg <ross.goldberg@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Command whose exit code indicates clean or dirty working
 directory
Message-ID: <Z_hB9gZL6FE7PezC@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ross Goldberg <ross.goldberg@proton.me>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <jreR52go49E9pIfAmIdRaoqIgKnVV7uOhR4Mbl9_p2dLG_7mPgO8qsUk7CaWC0nGbJD-2F4nGdQ8X65UtIQ5XOBNQXXzrnHnKbOCLCfEil0=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyGAcPRnLcKu0jMD"
Content-Disposition: inline
In-Reply-To: <jreR52go49E9pIfAmIdRaoqIgKnVV7uOhR4Mbl9_p2dLG_7mPgO8qsUk7CaWC0nGbJD-2F4nGdQ8X65UtIQ5XOBNQXXzrnHnKbOCLCfEil0=@proton.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--kyGAcPRnLcKu0jMD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-10 at 17:49:23, Ross Goldberg wrote:
> What is the simplest git command that returns 0 if the working directory =
is completely clean, or nonzero if it is dirty in any way (staged diff, uns=
taged diff, file that is both untracked &amp; not ignored, etc.), with noth=
ing printed to stdout or to stderr?
> If the simplest such command is complex, is there any feature request to =
create a simple command, possibly with options that specify what is conside=
red dirty (staged diffs, unstaged diffs, untracked &amp; not ignored, etc.)?

Here's what I've used:

[ -z "$(git status --porcelain)" ]

That assumes you know the directory is a non-bare working tree.

`git status --porcelain` prints nothing if the working directory is
clean and prints what's dirty otherwise.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--kyGAcPRnLcKu0jMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ/hB9gAKCRB8DEliiIei
gTtLAP9yTtmWrxsrq24O1pOhmWRv1fOlciM/wjb3nfPFgDfGrAEAnyscuVsvj1oE
YYf/8acCG8ro7l1rXz7pxdnHqSW5zgo=
=E8N7
-----END PGP SIGNATURE-----

--kyGAcPRnLcKu0jMD--
