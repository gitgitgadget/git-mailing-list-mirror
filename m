Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCDF1DDC1B
	for <git@vger.kernel.org>; Mon, 25 May 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779669938; cv=none; b=KeFhg9BYCkhCnLYpmVhAfp73psWV1d6rVAAkxX4avPgeLLHFCFQ3fG8RsNqFh+Lm9/AoFHd49lTynmJ99zwsPKl8x3AcqV1CqZN5CDb2KsXZ25pb78DmrhF1Ff9yq6wDMHSUj8HUUr+rMOIt/U0uOAPJebGaEbXmdq0JIO0L8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779669938; c=relaxed/simple;
	bh=UUEozrmZN47Be63SyMFdPOF075H/mxMF5qGxIDu2QdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwFXnPIhsV82QnvbejL6nSoBvMjoHFc1+ZnWgczXM1zXC0q/VOhuOig7ZKXbGjvFbJvmjtzB0PkUkl1rlVscu8DEjyl4L9vYvSs1uKsHeB547t7SfZ5SQU1SLiW1oJW4r3wg3Ec2gTJ6Bfsm6O+90vUxLgHjA/P5bkOpCT6Wp7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=siKuflpP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="siKuflpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1779669927;
	bh=UUEozrmZN47Be63SyMFdPOF075H/mxMF5qGxIDu2QdU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=siKuflpPV8CxFVSeITkrnzq+/H2zOMRth7bpEvKQsP7zuR3jjj3a2ISK83bm4qjh7
	 XAPFjuUEFjgML3mc+yF5A7uIAjLZ3vqT3NWXZ0cfiKwT/+qxRcVph+OjsRCi5iB65x
	 4fkII1nqgcbgO0kkWRqHbq+eONCCH1oXbZ3z9VsTH6DZ6ogt09Ad2zjvOiqHt7wfSd
	 KlLcKlKRpbTJyF1BukuaH7rqAC8s6SLLoNR3XHbDTcPZTjZtN3T2jbBfAYO6BTo5yX
	 AA3gU8KVlADWB6tbs5FILY0h5tW7gJLnk6/KFroxC/dltFTmUbnEI5CBdndP4EvIFc
	 2VHuNjSPBVj7mZrEni0mkvNllYH5SeB0eIRZ2GePAKVmtoFKvA1gNyC9z4hBSnKDu4
	 1R2eXTvXQT6HAXmeOVtbsi2Yi2FuqyYFwIcpYJonJuSQP/zW3Q6dUcSvshcqdJvvFU
	 Vn04SWdIhT4mrZoWvKKiYpYFjSdlLHHgx6o8cfxhWgbWlb5crHi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:11ee:847:ddde:4d08])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id ECCF320103;
	Mon, 25 May 2026 00:45:27 +0000 (UTC)
Date: Mon, 25 May 2026 00:45:26 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: SURA <surak8806@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: I discovered a minor issue with `git fetch`.
Message-ID: <ahObpiF9WvL-EfsB@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	SURA <surak8806@gmail.com>, git@vger.kernel.org
References: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5NOGwYzrh6o8o92S"
Content-Disposition: inline
In-Reply-To: <CAD6AYr9YmcnkdW=Nx=HUKcuaNbv1ukrAbXRnKyGibCQDy8N3hQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--5NOGwYzrh6o8o92S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-22 at 07:45:25, SURA wrote:
> Hello everyone
>=20
> The child processes spawned by `git fetch` can become zombie processes.
> In most scenarios, these zombie processes are reaped by Process 1, so
> this typically doesn't cause any problems.
>=20
> However, within a Docker container, the application service itself is
> sometimes designated as Process 1 (for instance, a service written in
> Go). Since these application services lack the capability to reap
> zombie processes, the zombies will gradually exhaust the available PID
> resources.
> This issue was discovered within a legacy service. A few days after
>
> upgrading to Git 2.53.0, the system's PID resources were exhausted by
> zombie processes. This is likely the result of recent changes, as this
> problem did not exist in earlier versions (2.4x).
>=20
> To be honest, this is not an urgent matter; I have already deployed
> `tini` as the init process (PID 1) to prevent the service from
> becoming unavailable.

While there has been some discussion about this on the list in the
recent past, using something like tini is the right move in the general
case.  There are a variety of programs which might daemonize a
background process for whatever reason and those will necessarily
require an init process to reap children.  It's considered a standard
requirement that PID 1 has that ability and Git doesn't provide it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--5NOGwYzrh6o8o92S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmoTm6UJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2FnNy1R8y0+GsxmyUdJO89ZpAgGz0FgI6odX9NPMsYY
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKBcAP9/28k8he9dwWI+VnMkgc4TBpuy
TTzuoxDWsGVhDRBK/wEAwVRUWTwYLBlFCTNpkTCcMEUgJfjz2G5ClHXCpW07cw4=
=IbvR
-----END PGP SIGNATURE-----

--5NOGwYzrh6o8o92S--
