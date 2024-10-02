Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D55B198E7A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906687; cv=none; b=EO7L1FE2L6Cwz47cRCOwqpVjKWHMfOVrcsO4F0Fed+YcOUcivpO/bxf2wBLt/nYKs4AcPd5BvmE3DnkKrlXZqIZ9O/RWriX4AFWY4ipayGN+Bipu4Loao7COarfoml7aI4NFDan7nFdL8Y8cjH2aYwe3C7Dg3YU6cdIHa6sW/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906687; c=relaxed/simple;
	bh=BAb2XcrwYQF6jtxGsKIzZV+rQ4FqlbdUYSH5+m83C5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3MGuHaXeUZWLBXu8sLSuBSoCEh/0ojmqBBjAaHlwRwcvGw69FxubaXuOLJqyQS1m88CqUN9Vmx8MmIv9kyooWwyZxsT/liYumgTXzXUWqxCdhAQA4oGes/c512ygkQaxCBZKPxVPYhDvHtuCU4Zwwo9qmIRLeIk1WrY0m47cXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=iiVzotrg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iiVzotrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727906683;
	bh=BAb2XcrwYQF6jtxGsKIzZV+rQ4FqlbdUYSH5+m83C5s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=iiVzotrgxBwsbxLtoe3XFseVukk0ZiitmBBRZDzamvfAbRcvYuKeXKsO9Fz/Lwb1w
	 yg02VWu/2nQfyqIxLvecYX3jBbM1LG2kxhyooM8BOsgUtZhlomTLKNV7Us9nJl+syB
	 UUeoWqBeO4XSoDWmd/QPOOR6uVj40ZcvRUP7rYG14QxvBBf48qsDH30LBOyVI1JJHa
	 Tfeo/h8nBS97H4rbIoEgS+8IFRAObSh+Lin0+SRXYm+lM1XthDiCwDjF+9j/DCBSMz
	 /NTxNEglDJbBLi0O8fY/mvJ/RGhAA2V9bwgL8PsndtDoVl/Y7lH2cVZd7twT9uIFGT
	 3OSGdbXfWD8DREUiXQI5jwGgmMh5rlcp4tOFmp4nnzk6BM02EtdYimwK+urcU4NUt5
	 Njfk9mhfTUDBlmq/CVIkO8GxxQEx7Wn23sJUwXK5GWTt48pkVGsKG7Vqb56OJR8Qas
	 CxVoKW8gyae7qeHHUk2EJjCOyrZE3huCeYSdMqN49aCB4il+jvf
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4698D20075;
	Wed,  2 Oct 2024 22:04:43 +0000 (UTC)
Date: Wed, 2 Oct 2024 22:04:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH 1/1] Add a type for errors
Message-ID: <Zv3DehUxEN6SJI1M@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Emily Shaffer <nasamuffin@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0QuWQml7JUJRX5qV"
Content-Disposition: inline
In-Reply-To: <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0QuWQml7JUJRX5qV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-02 at 09:54:52, Phillip Wood wrote:
> On 30/09/2024 23:03, brian m. carlson wrote:
> > There is work underway to move some of the Git code out into a reusable
> > library.  In such a case, it's not very desirable to have the library
> > code write random errors to standard error, since this is an antipattern
> > which annoys terminal users.
> >=20
> > Instead, we will expect callers of our library function to return
> > errors.
>=20
> Isn't it the callers that will expect the function to return an error?

Yes, that's correct.  I'll fix that.

> > To help the libification process and make our code more generally
> > maintainable, add an error type.  This consists of on 64-bit integer,
> > which contains bit flags and a 32-bit code, and a pointer, which depends
> > on the code.  It is designed to be passed and returned by value, not
> > pointer, and it is possible to do so in two registers on 64-bit systems.
> > Similar functionality works well for error types in Rust and for the
> > standard library's lldiv_t, so this should not pose a problem.
>=20
> Part of the reason it works well in rust is that it supports discriminated
> unions with pattern matching and has the "?" macro for early returns. In C
> the code ends up being quite verbose compared to taking a pointer to error
> struct as a function parameter and returning a boolean success/fail flag.
>=20
>     struct git_error e;
>     struct object_id oid;
>=20
>     e =3D repo_get_oid(r, "HEAD", &oid);
>     if (!GIT_ERROR_SUCCESS(e))
>         return e;
>=20
> With a boolean return we can have
>=20
>     struct object_id oid;
>=20
>     if (repo_get_oid(r, "HEAD", &oid, e))
>         return -1;
>=20
> where "e" is a "struct git_error*" passed into the function.

Yes, I agree that this is more verbose than in Rust.  If we were using
Rust (which is a thing I'm working on), then we'd have nicer error
handling, but for now we don't.

However, Go still uses this kind of error handling, and many people use
it every day with this limitation, so I don't think it's too awful for
what we're getting.  I won't say that Go is my favourite language and I
do prefer the less verbose error handling in Rust, but the fact that
this design is widely used means that it's at least a defensible
decision.

> I think the design of the struct is fine. It does mean we need a global l=
ist
> of error values. GError [1] avoids this by having a "domain" field that is
> an interned string so that error codes only need to be unique within a gi=
ven
> domain. I think that for a self-contained project like git a global list =
is
> probably fine - svn does this for example [2].

I think so, too.  libgit2 does the same thing, which seems to have
worked out okay.

> > Allow multiple errors to be provided and wrapped in a single object,
> > which is useful in many situations, and add helpers to determine if any
> > error in the set matches a particular code.
>=20
> The api appears to require the caller know up front how many errors there
> will be which seems unlikely to be true in practice. I think a more
> realistic design would allow callers to push errors as they occur and grow
> the array accordingly. For example ref_transaction_prepare() would want to
> return a list of errors, one for each ref that it was unable to lock or
> which did not match the expected value but it would not know up-front how
> many errors there were going to be.

That seems reasonable.  We could add helpers to extend the number of
errors.

> It would be useful to be able to add context to an error as the stack is
> unwound. For example if unpack_trees() detects that it would overwrite
> untracked files it prints a error listing those files. The exact formatti=
ng
> of that message depends on the command being run. That is currently handl=
ed
> by calling setup_unpack_trees_porcelain() with the name of the command
> before calling unpack_trees(). In a world where unpack_trees() returns a
> error containing the list of files we would want to customize the message=
 by
> adding some context before converting it to a string.

I think we could do that with either a particular error type (e.g.,
`GIT_ERR_WOULD_OVERWRITE`) that contains nested errors and text or a
generic `GIT_ERR_ANNOTATED`.

> > Additionally, provide error formatting functions that produce a suitable
> > localized string for ease of use.
>=20
> I share Emily's concern that this function has to know the details of how=
 to
> format every error. We could mitigate that somewhat using a switch that
> calls external helper functions that do the actual formatting
>=20
>     switch (e.code) {
>     case GIT_ERR_OBJECT_NOT_FOUND:
>         format_object_not_found(buf, e); /* lives in another file */
>         break;
>     ...
>=20
> I know this is an RFC but I couldn't resist one code comment

I'm fine with that approach.  This is mostly designed to solicit
comments about the overall design, and I don't have a strong opinion
about how we format.

> > +#define GIT_ERROR_SUCCESS(e) (((e).code =3D=3D GIT_ERROR_BIT_INIT))
> > +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code =3D=
=3D GIT_ERROR_BIT_INIT)
>=20
> git_error_free() returns the code as in integer so we don't need ".code"
> here. Also our coding guidelines would suggest git_error_clear() for the
> name of that function.

Got it.

> In conclusion I like the general idea but have concerns about the verbosi=
ty
> of returning an error struct. It would be helpful to see some examples of
> this being used to see how it works in practice.

If I send a v2, I'll try to wire up some code so folks can see some
examples.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--0QuWQml7JUJRX5qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZv3DeQAKCRB8DEliiIei
gdisAP4yQFCHElL3tatvLIYlfKAFTnNl3cv3UBpAhKntfGG/qgD8DMMH/x8ySIB0
Nws9fmTi4qkE8D6uMF7f1GkHfl/zxgM=
=ee5y
-----END PGP SIGNATURE-----

--0QuWQml7JUJRX5qV--
