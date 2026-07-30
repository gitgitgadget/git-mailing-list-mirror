Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4C38331B
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785446325; cv=none; b=tfL63K37yASzFPtIZOJXJs/ozUvN4BhCVgQBRKUuMREDA9Sy/vkl9MMUkuyYOdLH4k8uVd/6LTQoOG3/ie4Rz9ebog9WkeHOhDAF2KnngNmWB+jYNDTcPkyo8C2HFte06gEv9di5AhMED08gJ8OhDvWeX+0eShwpRNoLFNHvHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785446325; c=relaxed/simple;
	bh=/u9hdz86PvXcsqHjEEKQNZH7Z86oI54qv/XjMYNunJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4Lq+yX/Z08Rkaynibvyl+dWRZ7vyMM1i2cmIVbLnX00udZppPfFjYYKpTdaFZAufPkMKHj18RmOAZcDQobktiY3I7Tz2f4QXNOXrioz1SpP+xrQByOdLOfOcdjeMyKgNpqsAXSaqmXhZkLqiaVK7TlYggVo3ul2FA6i3BJTChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0R1HW1tA; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0R1HW1tA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785446321;
	bh=/u9hdz86PvXcsqHjEEKQNZH7Z86oI54qv/XjMYNunJk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0R1HW1tAdCHCuMqzOi5cW9eAWp0BVJf+3YXURr9+lwTVU//uI6K65GNhrbjrVOX00
	 7CpKQwiOQ9iDOpXrBU1cUex8SyNiu1vBoBcQnzUBoqdCWrdKhmJPA30RyGtcHh8G+H
	 NUhqJuVFFqZUi/5ItvR10TJ3DSJJ27SGgvigF6b0XrWnIgzoznWgnxrHECKj74YROf
	 nAfCS3LwePOjchzocfytEMxX3AamzXl0u9JgJkoouhrQDfXhspI/9XhH1WNmmmzkQ/
	 Kk7+pzqlcJdKtQnnwUzgRtqmT2ujWpieG3zy77mTnUsOjXBxdYic9PP7/JK4LxlgS2
	 pIrtLkA97e9DpwLQjYWg/SpyEhnB5KKavD4Bw82qYRswUAatkI58IEQi+AuREyoeJN
	 TvgsLHkL2gPlHHSzyTaau+Iv97ktZu1nnDbhcb6KOAZ8WtASeprb2acKo+Fc3nG5tB
	 nlxIt/zAVlnhWetZ0FxOkpZ2jLvCyiJ5PZsix7HgfNfKxA7E1XM
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7c1c:a10f:6f51:3bb5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 90196200C4;
	Thu, 30 Jul 2026 21:18:41 +0000 (UTC)
Date: Thu, 30 Jul 2026 21:18:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Git 3.0: restrict hex object IDs to lowercase
 only
Message-ID: <amu_rzanuYc_2lww@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
 <xmqqjyqclwf9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GfSBpcbbYH0TJC3D"
Content-Disposition: inline
In-Reply-To: <xmqqjyqclwf9.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--GfSBpcbbYH0TJC3D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-30 at 08:21:46, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > As far as I can tell, Git has always emitted hex object IDs in
> > lowercase, but our object ID parser accepts both uppercase and
> > lowercase.  This leads to much software relying on hex object IDs being
> > broken because it doesn't handle uppercase object IDs and this can even
> > lead to security problems when people assume that an object ID has a
> > unique hex form.
> >
> > This series proposes to remove the ability to use uppercase hex in
> > object IDs in Git 3.0.  It is RFC simply because it's not clear if
> > there's the desire to do this, although the series should be fully
> > functional.
> >
> > As further evidence of why we should do this, I'll note that there is
> > exactly one testcase in our testsuite that fails due to this change
> > (fixed in the last patch) and it's not clear that it fails
> > intentionally.  If we decide not to adopt this series, it would probably
> > be prudent to add some additional tests for the uppercase variant of hex
> > object IDs.
>=20
> Before going there, we should hear a solid argument why doing this
> might be beneficial longer term.  "Just because we might be able to
> without harming too many users" is probably not good enough, when it
> is not accompanied by "... the (low) risk may be worth taking because
> we will gain such and such benefit".

While I can't speak about the details, I've actually seen multiple
security vulnerabilities show up because people didn't realize that
uppercase hex was a thing in Git object IDs and so filtering or other
sanitizing was ineffective.  That's the real motivation behind this
change.

Also, as patch 6 says, a large amount of Git-adjacent software,
including common implementations such as Gitolite, don't accept them or
don't handle them correctly.  A quick code search for `[0-9a-f]{40}` on
GitHub shows a lot of these tools.  Our own hook examples even use a
similar pattern, and although in that case they are accepting only Git's
output, users see those as examples of how to parse object IDs.

The situation is presently that Git will accept them and this leads to
surprising behaviour, but almost all adjacent software rejects or
mishandles them.  I'm arguing that we should stop accepting hex object
ID formats that cannot be effectively used in the Git ecosystem but
whose presence is effectively only ever the source of misbehaviour and
security vulnerabilities.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--GfSBpcbbYH0TJC3D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmprv68JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2TdQOEh3beF3Wyw0vamTqNXRSGnuIzRmz1uvuuY9lSE
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAE1lAQCoGsZUabQQa1UOFjqc4ycFj5Sy
wQ95tiIQjBxTIImkKgEAqsLs8eAs3HrZ9ZCUx69dX1YblRLOpJpCHiB8y8wc+w8=
=XCLa
-----END PGP SIGNATURE-----

--GfSBpcbbYH0TJC3D--
