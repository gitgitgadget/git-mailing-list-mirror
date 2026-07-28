Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C550233938
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199603; cv=none; b=qEfDg5kuwcPqqEWQFJO/mlpZLizY+xjEiC2ry3GGg/tra7PDG9vw5/mFtjjPdYj3v9MWl3QKNIdr6epbDaDNyxTWpKGAmwz5f4R709WFPwZFrDSY32IzcX3Tm9Ke8fp52nCubCREBdy/7XgPBZRBpQbkbiyhp/zlVj+D4zUU/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199603; c=relaxed/simple;
	bh=/4rsAdCu2Cic8bfpVMsrQ0NnojuOCCaHMWIpUsR1pX0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=buus687kHFjHoa58Kz7lMqZlnIhudjlbyNU1mP9iYsKO3rsoJKUH3lFuX3+CqKgP4hzkfQxnIPfDkGhzagikehzS4yBCfbsVKQJM6IOOR2kqcP/rhhBe9QE14yUyayMB6efgKOTPIeAPHhQCwafCtMhSGIPVG1OQjS7iyyitMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ECeCictu; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ECeCictu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785199594;
	bh=/4rsAdCu2Cic8bfpVMsrQ0NnojuOCCaHMWIpUsR1pX0=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=ECeCictuaIS6XIveI6bxZwgYN/hPSL09WiA0XK828XCI2qMimvorYcut8VWYbASB8
	 uRqc7USs6a4TD0Ww6Z9iKM1MQ2g8J7uQyWQi31z2TQxmeRTVOQgGa2gJOYvGsmfIeS
	 Wu7Ckac+i89GdATItyU/raPQMZOuQJsYTuNlNkkJWDDvXSVv790e7HGYxc6KsVYa4l
	 3ka/osk1IQL30CAsw1Zw9hqb9CNujPUJW1A9v6pwRf6XD070LBLtgPaxP1IOXF7RAc
	 1ds8OILLMiflpjr8jzLJrhrWvB54X4wxIA7H6SFRjmJ9DP+aFZX0tB1D/6G6rIF6Eo
	 EXo7xf/YEFn8Y86qTBftTwlOnLiN//VhN5pqXONz9qgFHnpZsK5bDvezE9CDh6eX9+
	 y/NSlb+HHC0cGHYlmqDRIkC4u/oydxzqdD676iMXwxUH1N9JpLohDwawwtiWLbz+5+
	 15W6B306VH69FiEX5gB349+43ExbCtZnc6PnluvgwpyWx44D3MX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1373:b4f:f490:d5e1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 41AE520083
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 00:46:34 +0000 (UTC)
Date: Tue, 28 Jul 2026 00:46:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Failing tests with WITH_BREAKING_CHANGES
Message-ID: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oj1bBbUHAX/8+LXQ"
Content-Disposition: inline
User-Agent: Mutt/2.4.0 (2026-06-19)

--oj1bBbUHAX/8+LXQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have the following in `config.mak`:

----
DEVELOPER=3D1
CC=3Dclang
GENERATE_COMPILATION_DATABASE=3Dyes
WITH_RUST=3D1
USE_ASCIIDOCTOR=3D1
WITH_BREAKING_CHANGES=3D1
----

In this configuration, I've noticed some tests failing:

----
t0014-alias.sh                                   (Wstat: 256 (exited 1) Tes=
ts: 23 Failed: 2)
  Failed tests:  4, 8
  Non-zero exit status: 1
t1517-outside-repo.sh                            (Wstat: 256 (exited 1) Tes=
ts: 404 Failed: 2)
  Failed tests:  248-249
  Non-zero exit status: 1
----

These don't occur if I remove `WITH_BREAKING_CHANGES=3D1`, so they appear
to be related to that option.  However, I know we have a CI job for that
case, so it's unclear to me why these tests are failing; perhaps the CI
job is not testing what we think it's testing.

I noticed this because I plan to send out a series soon based on that
option and obviously I want to run the testsuite first.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oj1bBbUHAX/8+LXQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmpn++gJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/khL3mQuDI13E3SmHdQylUHVBnNs78PgAAFGlaARGCg
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIHRAQCbKA0uQCDyoQP9uuE04Z1xtWku
BU3hq1RrO/RAviqQHAD/RiUdpedI5EjyWZ2t5vatrdcsIwL9JEvwhSx5C5adAAc=
=RKls
-----END PGP SIGNATURE-----

--oj1bBbUHAX/8+LXQ--
