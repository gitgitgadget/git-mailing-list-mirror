Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A92367DA
	for <git@vger.kernel.org>; Fri,  9 May 2025 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820212; cv=none; b=qH3QCAX3JlFc+/1QJI6VxH2UG/5V9O68VDSfkx6LMI7M9j3udET4Ed1tmeWETvIKleo/tbTzWicuRt32aJSMMtuKXpZCAScP9ai9gKqSvJXLYi/FUSly2xIZeoIMO6S+rvNYQRWm8rZNTcd5JRKueUEU8DuS9FS0JpkJAEVb1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820212; c=relaxed/simple;
	bh=RnELupGkiKlBhgQ05xrKx5uSwyLFJbN9CMJoSKkp35Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APpK7XC5l4E1EDNGDW+RyIPWB88fMJIAVfvf+t7wW2evt5bevgvGKyOcUsRZ7BOBVKWRaX6vmuhdebwYIhsSYDU1gxVXQaEt6J3lpozkQI5chf+WPAjQGiatjzklsW5dhYm5OqXKpBo66mtNZHlsVJg+0w1dnQgz6pr2u7dAE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MrbWm+gv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MrbWm+gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746820208;
	bh=RnELupGkiKlBhgQ05xrKx5uSwyLFJbN9CMJoSKkp35Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MrbWm+gvmvYCgH9Ncjegm4A4/PggQ8dva0JTSuunsPshuHOhMVtau274xF3iEMMqh
	 G1HeKaM+GpFmTo5OVXtR8z/2+Q8tlXQO1iZ4Dmov31f5E/PCgLESAuhfBFaB4ignst
	 qb5dEJ0AS+FAWSQ8LrYAnb68wtZrwgZ3zyKuUPoFZnLStZ07IK6MjBzeRiW45cocU0
	 qw2t0OjSzJltAV7R3iorpP8zfP3fuvGlCRBBUg4bcIkrINnpj4UJFj56vHGw6+xFxL
	 bc14rSVBgDQG1fykcxIAg44fQldC34AqkjqGespyfeqJUvxQsR+W/DJ2FMn9wI80C7
	 DzTkuQWSdqwSHdgAAuAA2NkBoJ74BPIwCFwTuegt/pBb+L8KsmUBiKFpq4pR0DvzZM
	 4LVg5S2YD6oyVd4dUWOP7ABK9mzNqFZ0Em7y9/9sYz59YWIK3WfGdL6NPpzAno1cZR
	 PxyinEb6EpHdKt5zAlwfe4O1y1Yc9IlnZzamk79bO/8StdeUNTT
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0A319200C6;
	Fri,  9 May 2025 19:50:08 +0000 (UTC)
Date: Fri, 9 May 2025 19:50:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 1/4] object-name: make get_oid quietly return an error
Message-ID: <aB5cbjlSKXt-uOw-@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-2-sandals@crustytoothpaste.net>
 <xmqq4ixu4kfo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4x43wHvr2mJYie2O"
Content-Disposition: inline
In-Reply-To: <xmqq4ixu4kfo.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4x43wHvr2mJYie2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-09 at 01:55:23, Junio C Hamano wrote:
> Almost everybody else in this function hits "return -1" after
> detecting that it cannot yield a valid object name, and this change
> makes the oddball case do the same.
>=20
> Ideally in a distant past, we might want to remove this _GENTLY
> flag, together with the code path that is not so gentle, and adjust
> the callers that depend on the current behaviour (which I somehow
> doubt--- they need to be prepared to deal with the error return from
> other parts of the same function already).  We might need to make it
> possible for callers to tell which error condition we got (e.g., did
> the input give it a non-existing ref?  did reflog walk run out?),
> but these (including to the change to just lose "die" and always go
> the GENTLY code path) are totally outside the scope of this series.

Yes, I think we may have discussed doing this in the past and I
originally considered doing so, only to realize that was an entire
series to itself and would be pretty disruptive.  Last I looked, we
unfortunately relied on this case more than you might imagine.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4x43wHvr2mJYie2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgeXG0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0F7V9kn8CUfibWDh4bN6VDmKmTURxva41RETeaDlR+s
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACklAQCi9zbBNnUcQdLo9DNFKQV8UHfq
yPzd7T3m4ce1pbX5cAEA9nWOS+xeZ1wU89Q+BrgSkfwP+TBn1OR6qZKjkUJUQAY=
=kqKq
-----END PGP SIGNATURE-----

--4x43wHvr2mJYie2O--
