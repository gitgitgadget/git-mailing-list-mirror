Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEA928B7DF
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188893; cv=none; b=o9R8PXpgjqPvU99Bw8hGvtCy9Gfur8PzgeJhUswJZcJUQnSrFUGY/EFJ95/FpJf8bUkN9TuFOKVOTHopgievKnQsQtnzqO39HRUw8lpzSYn0z8em8PcovVfNlOiSQYXFfGFH2AQWBzLKO1ucY6tEp6mL0aeqIK9kcAnuqhQFPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188893; c=relaxed/simple;
	bh=Rm9e61lut0wGY4fg+04TEovVC08jGfMlFlP6MpFZ94U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De5TqCaXLYb73bFko7CLpm3GhG5G+qy9YziAFLyEkDw8qSq+a//Tzcj+XyDK7cyFYYVStXVoL3yo0WwYXMSDHKwmTGKU4WD+bRjj4x/+rm/jLSdwzqmfTe72zm0i0kh1CAONuXbJD2q9wwlygEIax2VlMjGUPua3UPU+YENCFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SSQzOSQX; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SSQzOSQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752188884;
	bh=Rm9e61lut0wGY4fg+04TEovVC08jGfMlFlP6MpFZ94U=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SSQzOSQXx/TcUgGxKM5Jp9gZ1zJGRIuZNC4T/QO41t0OkheK51miegp33VSGb8fpA
	 /w453Db120XLfAmAlla56MF6xhCo4Xc78ER7sh9anwa/OyA1fUJenkg6JYCeIoyn2A
	 FCm/gDuT6abIjnV025avXfSd9vPOf5qehBy2i/UXyfLlqkOppzAaYqiM3FuyQSYpz2
	 DclWPuh8tyAqoTRrup2Jhqov8+2kSjLH3S7SROmL9cab4r6i+PU02eLoSsywJs8Wud
	 9lPB/gZrd4IADrx+k5/uqHf9vw19OHqj0u2+NXvcoDaA5v8YndiNxMA4LC4IrB0ys8
	 R6fO6geuOeD2LbKnGyLmGA3A/yIgYTvB2v+AQQrMr0zhHq1YdBzMwBaK0eZBm5rWcJ
	 eGaFr4+jTds7WtcYL6vyF9Gn2/0KRqaAs2x5V53TgjXoFqGjMjwgVYOuwZOtEHKkPI
	 WLc825uzA9hURob9RFC8G09APMHhfL8VaFz3QJeEB4d7dUM2Dd9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 34F6F20077;
	Thu, 10 Jul 2025 23:08:04 +0000 (UTC)
Date: Thu, 10 Jul 2025 23:08:02 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Filter C and POSIX out of Accept-Language
Message-ID: <aHBH0nRLPxBg2HAj@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
References: <20250710221641.857081-1-sandals@crustytoothpaste.net>
 <xmqqfrf34qdb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4Z0Jc9ngt5oq5tp"
Content-Disposition: inline
In-Reply-To: <xmqqfrf34qdb.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--h4Z0Jc9ngt5oq5tp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Dropping Yi EungJun from CC because their email bounced.]

On 2025-07-10 at 22:45:20, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > At work, I've seen some cases where people provide "C" in the
> > Accept-Language header of their Git requests, such as when they provide
> > us with debugging traces, but "C" and "POSIX", while valid locales, are
> > not valid languages and do not belong in the Accept-Language header.
> >
> > It turns out this is actually very easy to reproduce and fix, so there's
> > a patch to filter these out.  I have not actually myself seen "POSIX" in
> > the header, but it's equivalent to "C" and I've seen it in non-Git
> > requests in various places online, so we reject that as well.
> >
> > This can be seen in GitLab's issues as well at
> > https://gitlab.com/gitlab-org/gitlab/-/issues/412077.
>=20
> Sorry, I am confused.  Is that Authentication failure in the cited
> issue "caused by" the client sending "Accept-Language: C"?
>=20
> "reproduce and fix" makes it sound like a correct exchange between
> such a client and a server is somehow broken (i.e. unable to clone,
> unable to authenticate, etc.) if the client sends C (or POSIX) as if
> it were a langauge, but is there a breakage there?

No, sorry.  I just meant that the trace in that issue demonstrates the
incorrect Accept-Language header; it's unrelated to the authentication
problem that the issue is about (which I think is a GitLab issue).

> I understand and agree with the change in patch 1/1 that it is the
> right thing to do (to more strictly adhere to the standard in what
> we send out) for hygiene.  I just want to understand if this caused
> real problems, or if it is primarily a preemptive clean-up to avoid
> non-standard behaviour causing problems in the future.

I'm not aware of it causing any practical problems for people, although
I could imagine some cases where it could, in theory, break things.  I
merely noticed this in trace output and thought we should tidy it up.
If users are using the header and expecting a localized response, this
will make it more likely that they get the one they were expecting.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--h4Z0Jc9ngt5oq5tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaHBH0gAKCRB8DEliiIei
gQfwAP9eBRmtyrqq3xkRcXeOfJRaNvdCYRX03dDH3rOKCwzGgQD+PoP1FPIZzYMz
9OSid5OWKbKkzyw4RnYllO6QxcEltQk=
=vn9F
-----END PGP SIGNATURE-----

--h4Z0Jc9ngt5oq5tp--
