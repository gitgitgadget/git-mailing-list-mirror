Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767D35F199
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717561; cv=none; b=ot9g57uJP3H+4HUPbSx779KaWhhwOspUpyT0ZtEFhBps7vVTl33+ogpi6D4XAKqjb4Lou6m8qQ5nGwaquPb0LGOiX9hJnaw9jEi1PHdDGGphfP3nDoh3zwUmYdKlNZrORp19Y6O788KiVxoTUszdsJD9II47OnBAwDbniHxMlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717561; c=relaxed/simple;
	bh=dqsjawIPgeD9j0YYuM+4FSmfBrdoDe8r1rHOhCb3WQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCzySa6Hzw96Xo5F/qCstzZWqHu7UtNEw8Humyz8u6sNFtpcbcXMHotMCUB6aV9RCbWpIeqL8Iw9x6CutHMcgg4CyqyKkD+QakylGg1R4RJIk0bY5jR353dRc8XfLJsV/6bvOr+2uJ7YFZcGf3/sKJeBwQ7vAxdGniRwV+A5LuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zYPK0Ptm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zYPK0Ptm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790717549;
	bh=dqsjawIPgeD9j0YYuM+4FSmfBrdoDe8r1rHOhCb3WQw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zYPK0PtmNBhdXbAPtx6FJNJf7hkmIQ5niBg+wvSryLwfNNt3lSRyH5w/eHNI8gYo3
	 A37Qmlfd8cHvM0TqkYpOFFnJhefmnRnK94DMZN65CxdUK8I3k0g237nlSkMnj8wRBU
	 GLhGS/uaQ32dMog8dV6cK3y3gjU6hN2gKJJ7N6ZbVVeNOqp4JktKa8TEqY2MlbSMN8
	 qB4Eou8Tl3ExJZylCXenELXn71S+Tj8Tuc2Vu7feOMjT18P7D4M3Hutznw38fzaOId
	 bNZpu5GoZ/qWEsmWL3kDMVkKlGAQ6dUyI0RdQQosAcSbNw199/fSRjUO/ysOSML8f7
	 Y2etOZOP4mMApzLJHIhYkioSEBMeqRvYESiCqrY1FtA1R2cvB9MVzv2TkQMn9W53Rj
	 1pEv1GPOX6B0m7RCm5FW9YVEN30QYTDdLjzzDBKAJdGNA3jk2HWOhL8bZ6youmhNee
	 BnM4UwdmdlL5mLDPf2SJRYvxIaCEBBLsH2Xf9KTYdjYFnbwSNQ2
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:52a1:d982:d7b8:f826])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D6F71200FF;
	Tue, 29 Sep 2026 21:32:29 +0000 (UTC)
Date: Tue, 29 Sep 2026 21:32:28 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Dmytro Lymarenko <dmytro.lymarenko@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] Optional per-repository consent before running local hooks
Message-ID: <arwubFmKkRcbbto3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Dmytro Lymarenko <dmytro.lymarenko@gmail.com>, git@vger.kernel.org
References: <CAF1QGTmK=WY_AODsfETOtzOSuwpZ_4KV5SiNPoRv0SAYeJ7T5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m1TuojRiH8Da6fVs"
Content-Disposition: inline
In-Reply-To: <CAF1QGTmK=WY_AODsfETOtzOSuwpZ_4KV5SiNPoRv0SAYeJ7T5A@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--m1TuojRiH8Da6fVs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-29 at 04:23:43, Dmytro Lymarenko wrote:
> I=E2=80=99d like to propose an optional safety setting for Git hooks. When
> enabled, Git would check for an active hook before running it in a
> repository that the user has not approved. It would show the hook=E2=80=
=99s
> path and ask whether to run it once, trust the current hooks for this
> repository, or decline.

In addition to what Junio said, we need to consider what happens if Git
operates noninteractively.  For instance, a CI system or a Docker
container.

> This would help when a tool or setup step installs hooks from files
> supplied by a project. The check should happen immediately before
> execution, so it also covers hooks installed after a repository was
> cloned. For scripts inside the working tree, Git should ask again if
> the approved script changes.

I agree this is undesirable behaviour from a project and I typically
consider installing hooks or other external software from the repository
without the user's consent to be malicious.  Installing hooks from
things like Git LFS I consider less of a problem because I have
installed that software and configured it on my system, so I presumably
want that behaviour.

The problem also becomes where to store this information because Git
doesn't have any sort of data store to store per-user information other
than the config file and as Junio mentioned, if the repository can
install hooks, it can also set config.

What may be kind of equivalent is to set `core.hooksPath` to `/dev/null`
in the global config and then choose to set it to `hooks` or
`.git/hooks` in the local config if you want that.  Or you can do the
reverse and use `core.hooksPath=3D/dev/null` in the local config for
poorly behaved repositories.  Of course, the repo can override that, but
if it does that, then I'd just report it as malicious to its hosting
provider.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--m1TuojRiH8Da6fVs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmq8LmwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ6bIJJ/2/mQNpReiaAjB1Qzab33SoY2XPEGSGsY2pnXE
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHW4AQChInoak1FKVGakzhWLE58svxaP
31QX0dT7Aa3J+/HAKAD/dEH3mQno2/+d/zHw1peVay5AMNMrsGyEuJ1VuEhJwwM=
=1DKc
-----END PGP SIGNATURE-----

--m1TuojRiH8Da6fVs--
