Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172C717332B
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739355; cv=none; b=Psjr+6jwQou4LIfAEQKhpnSnoFpJRnTSBG4wZVKaRBtkAVvznlP1cwRsc/RmN29FxxtWQYU+9d8y/oMUOvNHzbOg1dnrm2ow5uoZN0XjWxMWXZku2MmVKiCQ7FzX9LnTus4q7Cb2Gj787fZxKSCwGbi67/y2HoXRKUVUaOcTHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739355; c=relaxed/simple;
	bh=8PI8AckKj8pMGOiNe6EmHlrzmOMS25jV8xbOY03frSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcDGrOwHvVpYLTWUtdIIKLddtNelqeH9BMVAT3LZFu/zgJa/2TO/H9VMkeidLZLHuNjrsqLt6BvJ06xCRQI/uuz9FHz6jnJ96zKs5QjCjwTaFHCCTtf7SjCCtvIVASa6AB9YI3gFbhzdneGq2tOQHd3AWCqvHVuxxel2lkcvw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GTS5h7pH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GTS5h7pH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727739351;
	bh=8PI8AckKj8pMGOiNe6EmHlrzmOMS25jV8xbOY03frSY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GTS5h7pHQpEI67oeEps+WfRC/NW0EIa2wv5s9Tu94fN1qKEWPuOZUhsA+pCigXghu
	 O+kfjpRnG1W9WDffbsFFWnwFm/Cfc9UpaZwOCAadeQ/bilNOu18cm4Fxgpld86a5XO
	 wsegl7cGQEoebWYIIgDZ9L59iLN9KLeOiEGvCJYfRMQAoeQHHYZ5EcidNf12BeevTW
	 T9tEcx/svHb7ooiCLOe9W2l2vAbkljDpacR5z2nqqz47TmonpWRTIhSrCeo+/CAYZE
	 S4IsZUZib4UdGlNZ5gXdOZH00jGVuwpMeM4KHPFgzec0Glj2KwGT1YF8O9xgTwYkXT
	 lAM95rkhRfZ4bawxEn6y12VdKIu3d/+uQ5otoGj21fC8P81LsCHfrbJs0DuF3/6woY
	 1d1IkiVB0nPhsygZuo0PCA7OZQOWnq1XCm1SHl8pw9bIhUzTX8GZbxAC0HU2Iln6Z1
	 IHcC9Od5rBFEmMBrbNuWN/mZWFuP0MuIIPQgXETOue03Co1wXP/
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E17C42007B;
	Mon, 30 Sep 2024 23:35:51 +0000 (UTC)
Date: Mon, 30 Sep 2024 23:35:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <Zvs11sEe_6c_L8DA@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Emily Shaffer <nasamuffin@google.com>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <xmqqv7yc3goa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aykMemNTVw8onQUJ"
Content-Disposition: inline
In-Reply-To: <xmqqv7yc3goa.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--aykMemNTVw8onQUJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-30 at 22:44:37, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > ....  It is designed to be passed and returned by value, not
> > pointer, and it is possible to do so in two registers on 64-bit systems.
> > Similar functionality works well for error types in Rust and for the
> > standard library's lldiv_t, so this should not pose a problem.
>=20
> It should not, in the sense that "any reasonable platform should be
> able to pass two 64-bit word in a structure by value", but isn't it
> optimizing for a wrong (i.e. have error) case?  In the case where
> there is no error, a "negative return is error, zero is success",
> with a pointer to "more detailed error info, in case the call
> resulted in an error", would let us take branch based on a zero-ness
> check on an integer in a machine-natural word, without even looking
> at these two words in the struct.

We can adjust the first word so that it's always zero on success, in
which case, because it's returned in two registers, the processor will
be able to branch on a zero-ness check on one of those registers.  (We
can even optimize the check by looking at the low 32 bits, which will do
the same for 32-bit machines as well.)  The performance benefit will be
the same, and I should note that Rust does this kind of thing without a
problem.

We did discuss passing an error accumulating argument to all functions
at the contributor summit, but it didn't seem that was the way folks
wanted to go: people seemed to prefer a return value.

I'm totally open to other proposals here and not particularly tied to
this one, but I told Emily that I'd send a proposal to the list, and so
here it is.  If we like this with changes or prefer something different,
that's fine with me.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--aykMemNTVw8onQUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZvs11gAKCRB8DEliiIei
gWdZAP9QxymhY4+d2lW4ApvcgGF9AqpkzaXnk3g6SbOyNcLzhAD+MBAvJ+ODOfsN
2HXcV5bOnov40b+H6QjVFtJdFJ3r2Qc=
=ASww
-----END PGP SIGNATURE-----

--aykMemNTVw8onQUJ--
