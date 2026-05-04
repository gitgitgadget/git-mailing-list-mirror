Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB640DFA8
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777855481; cv=none; b=Mmj1nu2ZlsoPs0W4rFIKyuyyxlqRSdzC8O9tuYHmfogv+osYPSGvXWMwh2w6FRNKIERhnCfaNxgZQgjtDvIWimGWhOYte5b/Bo0h8RW1ugLE1E7ytfXZ4jnQLv4WJ303DRDBGcvLuxcIsY2p3eoz4XPkBT+yIU1bqgAHUjDDP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777855481; c=relaxed/simple;
	bh=c5M4qDT7IgIqTDDezWDEjmv6O+G5z1UclMW+uamXQ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojoy9UPHaLi1xbQMKR2RwxFd041JE0lfAae0TP/I8msRwp1OTv/SoNdJA1AHdyVhSrLsVJh47S8wnRGuGNGPFqMOy/MvgIBn+J1dURWONxMDu8dqhVCnX9Ke4RpmWa+7+gl1NbSGM5ANUoHN+BNbmzCnJ3uWK5wF1sSSTaj13P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MuV0+rWs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MuV0+rWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1777854896;
	bh=c5M4qDT7IgIqTDDezWDEjmv6O+G5z1UclMW+uamXQ5Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MuV0+rWsRrJzDyOA+NHfHCKSb7ywINWJynfbGdxFF2tUvISq7pJOai+y/iqJZ1LyO
	 wH6kC/iEt85rHK6GlOQYkjobPcgwZweqESTwCQf5iUl/GBpIA3TyJ1r4u6pb1KAPQt
	 K5s/5qyk7GsljarXwcZPTPLid8/iAxOYIsTuyQCPlKs0M0Cwd3Ovhmwug7dwWAkKha
	 enCVSlkbas+FoLRHJwVjVnj+ALXKfI69hrdTuVPtFJfCMQPM7LRmNkECE7wXv/kynB
	 wWXUU3R0g64yvW7aFpOVVcB5Sc/F20sUvtBE8zjRLReRH8cUZa4liLmGL/a/b1bk9E
	 m467ufA3A7+I2wcxuhvw12l8TEC54+M6w830ZIWNIP+KD0snbv3MqPVe+OSJJvWETF
	 IL7Nsb5tZTdR90uwbj+tdlKLyRzEYP20YKyQa9hBBrHCrraydTkDdshOAwh1h6+uGg
	 RGmt/7MaPNKW3wrGkbxfpLPJ24V2IXVx3PrOoGEXvC3CFb3Anns
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:43fd:681b:c55f:3c80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 49BC220122;
	Mon,  4 May 2026 00:34:56 +0000 (UTC)
Date: Mon, 4 May 2026 00:34:54 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: =?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>
Cc: git@vger.kernel.org
Subject: Re: git 2.54 fails to build for rhel 6 (2.53 builds fine)
Message-ID: <affprsBwpM7L47j6@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?0JDQt9Cw0YIg0KPRgdC80LDQvdC+0LI=?= <usmanov@ieml.ru>,
	git@vger.kernel.org
References: <9692091777837852@4991cc90-7cef-4f92-9de9-e195e7f2c04c>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajbx6XodwkCMZe2v"
Content-Disposition: inline
In-Reply-To: <9692091777837852@4991cc90-7cef-4f92-9de9-e195e7f2c04c>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ajbx6XodwkCMZe2v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-05-03 at 19:50:52, =D0=90=D0=B7=D0=B0=D1=82 =D0=A3=D1=81=D0=BC=D0=
=B0=D0=BD=D0=BE=D0=B2 wrote:
> Hi everyone! I have noticed a problem when trying to build latest git
> 2.54 in rhel 6,(2.53 builds fine ) nothing has changed on this machine
> since I successfully installed 2.53 . My openssl version is 3.5.6. Any
> Ideas? Below is the log

We no longer support RHEL 6.  It lacks security support and
Documentation/technical/platform-support.adoc states the following
requirement, among others:

* Has active security support (taking security releases of dependencies, et=
c)

We normally do not consider extended support time frames in this regard,
but even if we were to do so, RHEL 6 lost security support in 2024[0],
so it's not supported.  I would recommend you upgrade this system
immediately to a supported OS to avoid it being compromised and becoming
a hazard to the rest of the Internet.

> /usr/local/bin/ld: warning: libssl.so.3, needed by /usr/local/lib/libcurl=
=2Eso, may conflict with libssl.so.10
>     LINK git-http-fetch
> /usr/local/bin/ld: warning: libcrypto.so.3, needed by /usr/local/lib/libc=
url.so,may conflict with libcrypto.so.10
> /usr/local/bin/ld: imap-send.o: undefined reference to symbol 'ASN1_STRIN=
G_get0_data@@OPENSSL_3.0.0'
> /usr/local/bin/ld: /usr/local/openssl/lib/libcrypto.so.3: error adding sy=
mbols:DSO missing from command line
> collect2: error: ld returned 1 exit status

It looks like there's either a conflict between various versions of
OpenSSL which are being linked into Git or perhaps the wrong one is
being linked in.

[0] https://endoflife.date/rhel
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ajbx6XodwkCMZe2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmn36a4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ1GnfyADn21YT45tWlRRtswEk3lDTfAVv6BVUIu9LOOA
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANmWAQD5kG7tiW5Nen/wDOeYhUTDq2sk
qbpO9eYuPOAf60IJwQD9Fl0QgClnPm6qbiG53sfsakJ2a8yMnRLjWwP4njRxNgI=
=x0lA
-----END PGP SIGNATURE-----

--ajbx6XodwkCMZe2v--
