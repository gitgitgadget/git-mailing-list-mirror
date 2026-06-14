Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75511E505
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 01:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781399308; cv=none; b=CuoWXvtlTA4awyq4d2EIDYI99Mk4BPKDKiBqpku6k0KqPPbV6yAqJOV9nMqXbYm49YRb2dminqAwB8uDFzNvl4NI/9cfuPjO7JxDFk4268wI/3+FCydRwHe2DpwF2Ehk11HaRNyPKgSq11BOyWxg8S7AhH8W5aVjSCcls9JosDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781399308; c=relaxed/simple;
	bh=TsNkK7u2JlumjN752u1xn5UaPZFVBuNEqBf1maP7QDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC5LQggQsPvFeujaBytnCIPppozKPe/hcYS8f3Gd51M5z+q8k8OoZqcW4Q5n+0k/BMo6hwLRjnfpM+kB9OTXyMvNNneRWn6HYoNRh9ip5WTLhrvo6Uk38lHdNC7D2vmjWwgY0tnOzPpo7yclBh2eMOhyP7lrwWsI6QWWu9NtDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Ish82phY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Ish82phY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1781399305;
	bh=TsNkK7u2JlumjN752u1xn5UaPZFVBuNEqBf1maP7QDc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Ish82phYLiU+pemXqYNcO1W3bwbDIJOx7bqWzyISu+6qFXlEQ1FlOHy8aUUlSRzfS
	 /XCwVr5Z4cXbYbSFF/1Ankg6skSrZ7g9cG2PqdpAeS03WF3E10Oyw/0lA13QU0qK1P
	 d/1YOWA37HqfDu0zMMAWnk+MhuQksQqSQLCPLbU6Iw9pmj6tZRgoIFz71DF5TURJA/
	 Ar6V3M4Bk1mtUa3AxK+A+j258RiigXCOjG4ZhRNJGkdW66h4I6ahxAZLXX2kPWBKfc
	 4vmUMHIVPqatDsFQZwNXd9QJIES3q3NyfmA8UK5k2hjmUwL4efMuxyutmxdvx+211y
	 WbaV3JEs2XYaWR/9VYQ0q8fiU4s8qyCv0eGzfer/bR3JZqH5OeNYO9UyrluEW76Z3w
	 hHpv8Dpege2XKakoWZO4u8JMmAX/rDS4UfX1M+m5BqUK5TjaBeb+5g88qCqq3uZeIL
	 q04WnQ+JmUvwO4ummFrV3rGh9k5Yy7d2Fa5vXhm6kRUGZiLXeZT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c09:7eb3:49a1:129f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9E315200AF;
	Sun, 14 Jun 2026 01:08:25 +0000 (UTC)
Date: Sun, 14 Jun 2026 01:08:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Hadrien Loge <hadrien.loge@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, gitgitgadget@gmail.com,
	hadean-eon-dev@proton.me, m@lfurio.us
Subject: Re: [PATCH] clone: accept DEPTH env var as fallback for --depth
Message-ID: <ai3_CEstWqtw51MF@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hadrien Loge <hadrien.loge@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, gitgitgadget@gmail.com,
	hadean-eon-dev@proton.me, m@lfurio.us
References: <CADeHOfw6kNstNFucG7an6+Mbm2+=-PnOH8xtZkO9RK8=eWsx=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ccN4DHryjpEdtsU"
Content-Disposition: inline
In-Reply-To: <CADeHOfw6kNstNFucG7an6+Mbm2+=-PnOH8xtZkO9RK8=eWsx=w@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)


--2ccN4DHryjpEdtsU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-13 at 17:43:23, Hadrien Loge wrote:
> Well mainly I'm asking this for packaging (Arch/Alpine/Etc)
> These all follow similar conventions (PKGBUILD/APKBUILD).

Debian builds packages without network access because they want to make
sure that every piece of the source is in the source package, that every
package is reproducibly built, and that users can rebuild source
packages if they like without worrying about needing network access or
having their location exposed to the author.

Wouldn't that be the right decision for reproducibility and privacy
reasons?  If so, then the download of the source would happen before
building and could be tailored to meet your needs with the existing
command-line option.

> But in nested flows the ENV var seems like the proper solution.
>=20
> Mainly I gave this example on github:
>=20
>     git clone --depth 1 url dest
>     cd dest
>     bash run.sh
>     here run.sh has its own clone deps (perhaps even multiple)
>     --depth 1 is now lost
>=20
> And only ENV vars that I can think of properly propagate for CI
> flows/clean chroot envirs.
> Thank you for considering the solution. It would be very useful
> for speeding up packaging.
> Even on 5k commits history it's 900kb vs 17mb.
>=20
> I have also reworked the commit to include tests/docs.
> and rename to GIT_CLONE_DEPTH

So say someone has this set in their environment and then they run a
script that clones a repository and runs `git describe`.  That no longer
works and the script fails because it assumed that it had history.

It's also a problem if you then do a fetch into the shallow repository
because shallow fetches are _extremely_ expensive to serve (more
expensive than full clones), so having automation that now runs
thousands of these shallow fetches means that your requests will be
throttled by the server operator whereas they wouldn't with a regular
fetch.

There's no one right solution here and while I am sympathetic to your
situation, it will also result in hard-to-reproduce breakage for other
tooling.  People rely on `git clone` and similar commands only honouring
command line arguments.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2ccN4DHryjpEdtsU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmot/wcJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8KmdlEQcjZxGhOQZVNclMrhIaZ+oUK7rroKgPtWUYgU
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAN5DAP0TrhP5QpqkuJgZ1WufveeME5kb
se+A1M2ujjlxkVrgswD/cRqntQ3y452vT62AySfbIJjplWH7WReWu9XxTrSMcQc=
=AGhJ
-----END PGP SIGNATURE-----

--2ccN4DHryjpEdtsU--
