Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300E0194C94
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905904; cv=none; b=NZo3Qv6NH1pQONFDr3GcOnbYvoBCXYVJDlB7IwR7mQyw6wkG5aRcSP56m/Y7SS13l1vyGgMRDpuv2wkWh4rGSy91CY7ZDli0SzG0h0fn3Ga84PQGcZpkOAkLJDfm8vpG5SlVQt9zNYPDKyDtEnFzlX4/ue+p62lcxi2Uy9v4MW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905904; c=relaxed/simple;
	bh=Ais+Bb6ezow3DBZtJY7dCcCpM12QM8iyyabl6zH+u3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWNMbd7oF10NeH0OTaJB15O/Wg7gl2Ig8XWk/Sw/DMMxOGjpQ9+BWDn7aBL4LyvBaqbLl6s3aTh+UgL7JobGGHgwd8ImBqxlSVRoB8razErYC+YAYUPvpCLxtgPiGcAk0HYb384dqEM0SKu3AtD7/PqmF3cfvTn+b7bD80WpQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VV0tvT5s; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VV0tvT5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727905893;
	bh=Ais+Bb6ezow3DBZtJY7dCcCpM12QM8iyyabl6zH+u3o=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VV0tvT5sbaYGuGl7az/CtyOpF3UfdX2Dqb5fcmdgiy9MyxRxit31DiMXQNtzK4J+H
	 vLbZWM91IrgUUj35nqLTCRNpYO1E9xzzldVLfI0SN2i/eVtsHcu34dLjtAGxHT/Ef+
	 SFPvXTcZzx5VchMlXDufXezM99PmYdVIRmWhC+N94/seSoHoI48hglanwsI9AY9M5I
	 8gZ2GbFIB2VspDC4xh4yBW7E7bVg/GP3dRsEy83TauPgTVO/Sr8sUot4tKHGJhigK5
	 CTY+mFEKW3giIb1Q63xh9sbFA500unb+CB76gr5Z7hhAbMk5aK0DRMgM331mzpuZCv
	 mnyMHFKBuULbRJukSlJIMFN2MN+hEoejagh8yH+/DQzrJLKGQsqacVFSjrgZCTF67K
	 P2Yd3nLTBrWbCtT5Tz3+msaEoJNgZEDUxjQHx5+QnOnT2npHC270FfIdNZZsYRMStF
	 +/rQN9M/Sg/5SfIhDLeHxLmWuMWOq18ritfFSx5IC4ZOZracxJs
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B83FB20075;
	Wed,  2 Oct 2024 21:51:33 +0000 (UTC)
Date: Wed, 2 Oct 2024 21:51:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <Zv3AZKjcOoAKOzLn@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <CAJoAoZm2RJnu52Pb-vr0VWS_GQkL5n=DZs7KU50EZyuEYhawYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uSW+5kwTM7o75RLg"
Content-Disposition: inline
In-Reply-To: <CAJoAoZm2RJnu52Pb-vr0VWS_GQkL5n=DZs7KU50EZyuEYhawYw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--uSW+5kwTM7o75RLg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-01 at 20:31:15, Emily Shaffer wrote:
> On Mon, Sep 30, 2024 at 3:04=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > +const char *git_error_strbuf(struct strbuf *buf, struct git_error err)
>=20
> Is the idea that we continue to extend `git_error_strbuf` with more
> `git_error_code` values as we add this method of error handling across
> the codebase? I'm worried it could get quite unwieldy. Or are you
> suggesting that we could write `git_error_strbuf_object_store`,
> `git_error_strbuf_hook`, etc to keep the code->string conversion
> local? That would let us do custom processing of err.meta depending on
> context, too, wouldn't it?

My intention was to centralize this processing in one place.  Part of
the problem we have is that we have many different messages for one
error code, so `GIT_ERR_OBJECT_NOT_FOUND` might have "object not found -
(HEX)" or a variety of other messages, which makes parsing errors
difficult.  (As I said, we do this at work, and it's quite annoying.)

If folks want to do thing differently, we can, but we should avoid
losing the consistent error message behaviour.

> > +#define GIT_ERROR_SUCCESS(e) (((e).code =3D=3D GIT_ERROR_BIT_INIT))
> > +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code =3D=
=3D GIT_ERROR_BIT_INIT)
> > +
> > +#define GIT_ERROR_ERRNO(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? ((e).co=
de & 0xffffffff) : -1)
> > +#define GIT_ERROR_GITERR(e) (((e).code & GIT_ERROR_BIT_ERRNO) ? -1 : (=
(e).code & 0xffffffff))
>=20
> Aurgh, too bad we don't get bitfields before C11. :) (Although I am
> not sure if that helps with your register-level optimization at that
> point... but it probably helps with readability.)
>=20
> But, I do wonder if this gluing-together-two-types-into-one-value
> thing may break based on endianness? (And if we care? I don't think we
> have any tests running on POWER systems, so maybe this falls under the
> umbrella of "you should give us tests if you want us to not break
> you"?)

I don't think this breaks on big-endian systems because we're always
treating it as a `uint64_t` and never converting it into bytes.  My
first laptop was a PowerPC Mac running Linux and I've owned UltraSPARC
hardware in the past, so I'm pretty confident in avoiding writing
endianness (and alignment) bugs.  I wouldn't have written it in a way
that broke on less common hardware even if we don't have tests for it.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--uSW+5kwTM7o75RLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv3AYwAKCRB8DEliiIei
gdLdAP9e0knGV7VoYtrRgc45NuIBqY/0aKvqth+jis9gq+LFiAEApFHA0QvRcQSC
AeMrftxrgaTBh/1dImTnO/qZu3bpKwA=
=TH2o
-----END PGP SIGNATURE-----

--uSW+5kwTM7o75RLg--
