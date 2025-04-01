Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5878F2F
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468205; cv=none; b=F4TTeztz4pUYtMcY5Qgo0VGK3g3khSI9SWMOSJkHHPND427eQQsRV/dq5gXMClr5sU3Nof9XKPEirBwxo/RP2kruKav8UAtcHKSsZpL70bVR4Sr1wusm0ez4+hZEV8aW+AMwhAyHKpawZOJnVhZvF+qJ72VoVdNPmqgh5NRDeMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468205; c=relaxed/simple;
	bh=611AGtN9hxt0cAi1FG1GAbbOUSbaex+OhpIxxJK3JpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnFVEMgjp1rFs/GKxS1+7OUzDiyL31jlTzJrfhAF5RFsJA0dsZIxgtvDmn4G8tnylvPZam+hT/emhNxnNoP5eFSQNM/bIQN4Ag2lhSoeR5GEdkHemWBVLQlFmEzBSGAIibBrJBupVRoh18+BmXKpm4ap+Y2MSLgag2Rv1iAxghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vhzARGke; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vhzARGke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743468201;
	bh=611AGtN9hxt0cAi1FG1GAbbOUSbaex+OhpIxxJK3JpQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=vhzARGke7etVLqhIWRBfdTnSXNrrT3AsMq2gKDduUINu/qVQ4zRCySX4BiZIv/7QR
	 JtSM44+YtMgNbL3gv/P1xL3G32MAGlecWk6LJPkssXdCyPlARw11TvQx8K7r4YgMeA
	 GnDm1B1UdGxziRAMHSGx2J9L9SFIhOFhXdl+eYfydzuxlxy9ok14nQyr+MdONNEsan
	 DEWBDqa6RRNG0GP4mOxTV9jbWnlu3N71+pqxeDDWvqpBXC8ln5r+FyHImstJiW9Ayj
	 l6itFr/h+uas51CnRXPZx+MyS+4WDkS6hEQw5MLENH4TQYDObJW8jvUD4r50ibvCAF
	 cNbeQHBfmiZlkjK5I3qaQgdTQ2G97W7z3M2Pc6Bp/TTXRwBiSLiPjszwI2Jf92Y9W7
	 OxivcobQWsV1xxP45zkElDHbEPhcAaecye3WvG22sVReGvicu4Rh3QabRkBBSaDoF/
	 tTCaksCZZe1u2fSUS8NrhCISLILU9MgRTBhwyB3iKv91ehhRoO2
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0BA45200BE;
	Tue,  1 Apr 2025 00:43:21 +0000 (UTC)
Date: Tue, 1 Apr 2025 00:43:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: --reset-author does not reset author date when used in
 post-commit hook
Message-ID: <Z-s2p-ak-KpU6uaX@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Devste Devste <devstemail@gmail.com>, git@vger.kernel.org
References: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oJkSCf0ZI5wQuHat"
Content-Disposition: inline
In-Reply-To: <CANM0SV2huiGtWMcP+eEkNBHoieeoXmy_fM7vAOwyoW4=FXw1pg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--oJkSCf0ZI5wQuHat
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-31 at 20:19:30, Devste Devste wrote:
> device time zone is not UTC0
>=20
> post-commit hook:
> if [[ -n "${SKIP_POST_COMMIT+x}" ]] && [[ "$SKIP_POST_COMMIT" -eq 1 ]]
> then
> exit
> fi
>=20
> TZ=3DUTC0 SKIP_POST_COMMIT=3D1 git commit --amend --reset-author --no-edit
> --no-verify --no-post-rewrite --allow-empty --quiet
>=20
> ---
>=20
> Run:
> git commit -m "foo"
> git show -s --format=3D"Commit: %h%nAuthor: %an%nAuthor Date:
> %ad%nCommitter: %cn%nCommitter Date: %cd%nMessage: %s%n" HEAD
>=20
> Expected that both Author Date: and Committer Date: show +0000 as
> timezone. Only committer date shows +0000, while author date shows
> time zone of device.
>=20
> When manually running the post-commit code (TZ=3DUTC0 SKIP_POST_COMMIT=3D1
> ...) it correctly resets the author date to +0000 too
>=20
> When manually setting the date using --date=3D"$(date +%s) +0000"
> instead of  --reset-author it also works correctly in post-commit
> hook.

I can reproduce this, except that I had to use `TZ=3DAmerica/Toronto`
since my system is in UTC.  A quick look at the code led me to a guess
that ended up correct.

The `git commit` code sets `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, and
`GIT_AUTHOR_DATE`.  The latter contains a timezone identifier.  As a
consequence, when the hook is invoked, those values are set in the
environment, and the subsequent `git commit` in the hook uses them.  You
can see this by placing something like `env >/tmp/foo` in your hook and
then reading the output.

I will say that this is definitely not the intended use of the
post-commit hook and I am very much not surprised that this doesn't work
as you intended.  You could certainly fix it by unsetting those
environment variables, but I'd encourage you to adopt a different
approach, such as by using an alias that sets `TZ=3DUTC0` to commit.  That
will be more likely to work in the future and will definitely be less
brittle.

For instance, your call to `git commit` will still invoke the
`prepare-commit-msg` (and possibly `commit-msg`) hook, which might
result in unexpected changes to your message or even a failure of the
second commit.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oJkSCf0ZI5wQuHat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+s2pwAKCRB8DEliiIei
gSoBAQC14jeOgE5rCuEe4yxiiJsUmME2U+UaQzh0dn/x1VKQdQD8DpvjCcGlIV2O
/uI8FdBYQyAsO14WeDPiElDSX55ItgE=
=EUWZ
-----END PGP SIGNATURE-----

--oJkSCf0ZI5wQuHat--
