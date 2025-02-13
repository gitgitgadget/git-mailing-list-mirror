Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279B444C7C
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485066; cv=none; b=Z/ZOPjh9HpIBnwjm38SbMJ44Dn6x5T7Z9wz5s7w9h7eYn/UeFsXkrt2z3GozWX9CaDOvLDMsJaHroXA14a80BE4vzEuK1xoe97F9QtbXJJ6hSQ3igGDV35/QRnQVYiWlZCX2B50Y3UhQSzckqRyOiTof9hlXV6W4jHAqIBeWfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485066; c=relaxed/simple;
	bh=ySRJxKULN2vKoBfO/FFVAR2nuW5EhuehWBvwxQChLd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbyGK58CPPgBKsFQcIja5bPnbDkNy18i0+u58+V8NRbbCpcNq4Gk2JYNpdNnkRQL92Kff8Vi4fZt9qw8xkRK6LxF6+nWa8kqnQjnaBAAZnQ5l1CBI3zTwpIbr/8aAWyJMV6kDAxccWq+UMSHFHbDlK2aoa2NBCNSKSml/EpSNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UInoaFd+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UInoaFd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739485060;
	bh=ySRJxKULN2vKoBfO/FFVAR2nuW5EhuehWBvwxQChLd8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UInoaFd+z4RJxbBvTojC6PTgjToSUFOQ77RqICA1JjVNtJD3ZTgPKqdGmL1OmpP4F
	 wxGSd4TnsAnpLg7ml5HfvcUpgrheh263JwNhegtWScGS3yrmtfHNLk0a9rCFQZGmUy
	 wGIkXgU9kaoHm0YcoxeuFKCId5MjvYPlDluBdlsPzn1pOjrE2QCc5HZyw8FbulffRi
	 sHMmXptiCvKiFZ35Zsp0kXLFa9N9kxY5GzpBrWnx+kE/pFrrLV0rhHdxMNxiCCwP55
	 I6OPhaEya6UvsmNcKEsl6r8jki8OOoJyzaBJLq35h1tHBSvvWiKtVUY9ztHfhHBYYT
	 A2c6BzotZY/5EvTJKdzUY2H9FKCIit8krThYB4b9VVsAKc2MUeGNSbgZMbcb1Crm3n
	 KVw1JAv9RSvAXLlYxD09G4zfZz/1YHxmbnTBwYhoMX+AXfsB6IFtSqgCEVql3ABBQ7
	 9Qd5bxuFeMBXJ48ghJzh19V6gDjTe3hpUOFYIScsqHMEY7hchNa
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 90FE220078;
	Thu, 13 Feb 2025 22:17:40 +0000 (UTC)
Date: Thu, 13 Feb 2025 22:17:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z65vgud7t3qRMD1a@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <20250213082221.GA916028@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QAgg56iLi23hr1Yu"
Content-Disposition: inline
In-Reply-To: <20250213082221.GA916028@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--QAgg56iLi23hr1Yu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-13 at 08:22:21, Jeff King wrote:
> Yes, we do similarly spend a lot of time there. But the problem isn't
> quite that repo_get_oid() also parses revisions. When we see a full
> object id we return it quickly. But you can fall afoul of 798c35fcd8
> (get_sha1: warn about full or short object names that look like refs,
> 2013-05-29), which does a full dwim_ref() lookup for each one!
>=20
> Try:
>=20
>   git -c core.warnAmbiguousRefs=3Dfalse update-ref --stdin
>=20
> to disable that. Internally there's a warn_on_object_refname_ambiguity
> flag that some code (like cat-file) sets when it knows it may be asked
> to do a resolve a lot of entries that are likely to be oids.

Yeah, I think both of these would be great improvements.  The kind of
case I'm interested in is reference updates in the context of pushes or
various API calls, where we're always going to have a full object ID and
there is never a human connected to the output of Git.  I expect that is
the case for a lot of users.

I also think it's unlikely that even the general scripter who's working
with `git update-ref` is going to want that warning.  Most users of that
command are GUIs, APIs, server backends, or the like, and even if I used
the command in my Git aliases or some custom commands, I still wouldn't
really care for that kind of extra output.  I _do_ always want screaming
performance in `git update-ref` though, since I frequently, even in my
everyday scripting, work with large numbers of refs.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--QAgg56iLi23hr1Yu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ65vggAKCRB8DEliiIei
gQtbAP9dchpQ5lJ82+8dT1Oat6OajQIxS0f3G/ocAjF4M7PQyQD+I+1PHQRbSLFO
Yy+UuNUMAhP4sqZjQifHYHq1I9h9eg4=
=lqpa
-----END PGP SIGNATURE-----

--QAgg56iLi23hr1Yu--
