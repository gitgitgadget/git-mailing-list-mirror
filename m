Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A017A2FC
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750451333; cv=none; b=SF6WIrA0SA6xAK7Zy/irVEZM5347GqWEnN6TFy6iWE1YkPuxj5IQozAP/qBnBrPVkoATu8yuhtlcrrjteLLG/Aj3wR0A/wYM0o7KnL1w2C/vTKxgEws505KnL1LSKQoiJ6NDjz65RUFERMaQfMmWhH835DapmP6JTHsTqmEDUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750451333; c=relaxed/simple;
	bh=QoC8FIZR7r7sI9G+V2Zyz0zIjhyJ53ziURoCB/k0ofA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukM/yDY1BKjMkOAqRRnKj3U8IeE/87YG2yJTN80z7OT/7ONHwym+jabhv+HbMxb7KQUBy5/PeeB0MwQvRw0UaZYcNK3sg+ofdKYPHXw7xClVU4bR/2v4lke16blI7E7jlTYnZ1a4TxbkyCfnfz4osL9Od16dsbAEOwsKik07jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wSBsCBez; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wSBsCBez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750451329;
	bh=QoC8FIZR7r7sI9G+V2Zyz0zIjhyJ53ziURoCB/k0ofA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wSBsCBezf5WS8ORfMfLQTh0J6G4vOowkHzx36Cd4vWyWvaYRa4SwK2JaLdAeMbyq7
	 vyu9O/xyPQm26EnC0cxD6c6YTIvRBz5HrLk5zDhlUXrEGxgN4HU7sUH+vorlFiKOTF
	 /6ywW3QqB0eap7/EQYdKFUCp4bLIAwARAzij9/UgwAAwD1+mUQjqsdkADqz30tLJpi
	 uTKDuTL4cm5U4piW36bvVIKVVeUouxCP75Y5VksxNaSSe84iej0pOnImO26nB40m8X
	 UC+V1ftlq0atriuUX2U23Q7hV0U8TyyRJmUV37XOB0Gp6QjNdWzyQc9e4XR+zn9DO9
	 htSSNv3I7YgLPZJ4kiJdfE4TzbX+8NrSpQLqQyEO3XLcktF8b/EGbJD4sw9Hb/p8UH
	 bNifC7NhxvvrrgN24p0wsNNYg5GGdUmJXA2PeuddlFpY96V5Ity1sOU96cCHMOPix6
	 lqizRuxS92vxzEdZYdT+pdtT376nK/ziXZz5QdZ/wRgUWH6ZTDK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E40C820069;
	Fri, 20 Jun 2025 20:28:49 +0000 (UTC)
Date: Fri, 20 Jun 2025 20:28:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/10] setup: use the default algorithm to initialize
 repo format
Message-ID: <aFXEgLRLRdbaPOb2@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-6-sandals@crustytoothpaste.net>
 <xmqqtt4a5upb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DoVuB7RaU371MAXz"
Content-Disposition: inline
In-Reply-To: <xmqqtt4a5upb.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--DoVuB7RaU371MAXz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-20 at 14:55:12, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > When we define a new repository format with REPOSITORY_FORMAT_INIT, we
> > always use GIT_HASH_SHA1, and this value ends up getting used as the
> > default value to initialize a repository if none of the command line,
> > environment, or config tell us to do otherwise.
> >
> > Because we might not always want to use SHA-1 as the default, let's
> > instead specify the default hash algorithm constant so that we will use
> > whatever the specified default is. =20
>=20
> All of the above hints the use of _DEFAULT instead of _SHA1 but ...
>=20
> > However, to make sure we continue to
> > read repositories without a specified hash algorithm as SHA-1, default
> > the repository format to the original hash algorithm (SHA-1) when
> > reading the repository format.
>=20
> ... this explains why we may want to
>=20
>  - expect that we would be able to read the hash from repository
>  - read from repository
>  - if the repository specifies the hash, happily use it
>  - otherwise it is a lagacy repository so use the SHA-1
>=20
> Is that what is going on here?  Because I find some things that
> happens in the code somewhat questionable.

Yes, that's roughly it.  I'll explain this better in v2.

> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  setup.c | 5 ++++-
> >  setup.h | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/setup.c b/setup.c
> > index 641c857ed5..fb38824a2b 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -835,9 +835,12 @@ static void init_repository_format(struct reposito=
ry_format *format)
> >  int read_repository_format(struct repository_format *format, const cha=
r *path)
> >  {
> >  	clear_repository_format(format);
> > +	format->hash_algo =3D GIT_HASH_ORIGINAL;
>=20
> If we expect we can read from the config, and otherwise we fall back
> to the hardcoded legacy SHA-1, do we need this assignment?  We
> cleared and version is set to -1, and then we read from the config ...
>=20
> >  	git_config_from_file(check_repo_format, path, format);
>=20
> ... so if the file said anything about "extensions.objectformat", we
> would know it by now.  If not, wouldn't version be left to -1 as our
> previous clal to clear_repository_format() set it via its call to
> init_repository_format()?

The subtle behaviour here is that -1 means that either there is no
version specified or that there's no config file.  I was surprised to
learn that we do not require a configuration file, but we have tests for
that case with `git branch`.

> Ahh, this code is prepared to handle a repository that claims to use
> version 1 but does not set extensions.objectformat at all.  And in
> such a case, we do want to use SHA-1.  OK, the above code makes
> sense for that case.

Correct.  We can set v1 because we want reftable, for instance, and we
never set extensions.objectFormat to "sha1".  We always rely on the
default behaviour since that's more compatible.

> > -	if (format->version =3D=3D -1)
> > +	if (format->version =3D=3D -1) {
>=20
> And if there is no core.repositoryformatversion set, we will come
> here.  According to the comment before handle_extension_v0(), some
> extensions.* should still be honored even in such a repository, and
> the above call to git_config_from_file() should have handled them
> just fine.
>=20
> However, I do not understand why we clear all of what we read with
> another call to clear_repository_format() here.

Because this is the case where there's no config file.  If nobody
bothered to write a configuration file, then we want to reset everything
to the default.

I don't know what we do if we have a repository with a config file and
no version, but literally every repository since Git 0.99.3 (I believe)
has core.repositoryformatversion written into the repo.  I'm certain
that the behaviour we'd want if nobody specified one was to do the most
compatible thing, so the defaults seem prudent.

> Admittedly, I find that the way how check_repo_format() does its
> thing somewhat questionable.  Even though it reads into the .version
> member the value of core.repositoryformatversion, it slurps in all
> the extensions.* regardless of what .version the repository claims
> to be in.  So even though there are two separate functions to handle
> "historical compatibility" handle_extension_v0() and other extensions,
> we still end up honoring extensions.objectformat in a repository that
> does not say what format version it uses.  And clearing them with a
> call to clear_repository_format() may make sense, but do we want to
> clear things we read with handle_extension_v0() as well?

No, it looks like that at first, but I don't think that's correct.
`verify_repository_format` complains if we have any v1-only extensions
(such as extensions.objectFormat) and we have version 0.  That's also
where we check whether there are unknown extensions in v1, since we must
refuse to read the repository in that case.  There are tests for this
case: I added some that v0 with extensions.objectFormat is rejected when
I did the SHA-256 work, and I think Peff and Patrick may have done some
additional cleanup here (and maybe others; my apologies if I've
forgotten anyone).

The reason we need to read all the extensions is that different config
options aren't ordered and the config callback processes items we see in
the order they're in in the config file.  We might first have an
extensions block and only then a core block, so when reading the
extensions we don't know yet what the repository version is.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--DoVuB7RaU371MAXz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaFXEgAAKCRB8DEliiIei
ga7WAPwLxtkd2NSwAvAiAAydVSQD12pQy9w2z4KU6hZoWg/H+gD+IXw2YOYl6rmD
L3vukg+UZKd/LDcoXHrbrsgJafe1EQw=
=qrYo
-----END PGP SIGNATURE-----

--DoVuB7RaU371MAXz--
