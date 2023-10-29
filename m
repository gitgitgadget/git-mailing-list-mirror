Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A68835
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C3PReCB8"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FEB0
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 07:18:59 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 715825B09E;
	Sun, 29 Oct 2023 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698589138;
	bh=0q40W/20Xasp52GwiipdViZQhv4mspXoQcwwe/0p3Rc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=C3PReCB8DuUqX8PZDNXCLq+VFnjZ50ThQ7sO2VBuPOGTw1jHJHuPd7wNhsJO9gHgk
	 nsPMuylW3NQ8Sd+vorTy855wOtSDsPZFLW6sfvab1ISkSozKARW0WYSbBL1HLT8oJp
	 4LQB/s5xWNV0m99wNrSKMpFsqLtV+uYCTaNPnLNsDVbRou9C8eEW1LegBLxByzP6OG
	 iCArlNF14Kkw6k5MMYUDhnUMgQKpS8SA2Ftj6bEbTZ5O5GxX6DsQwKqtrTXwz0BxyO
	 mdEdWXFBDvrKuU/a3+t6Bf4OJZE18hEAij6mFeHfX9oe0ihS5PLspPj2vaaFagqDzK
	 OQtO3Ql59dd1ZyHhi9mtVHFStIWo5HZHvKovbF8DBOOYj1VNMpUSgXKghGA/3JCHQX
	 07uP6dI3UdxAtPM2Bb8e1sDNeC30NeEGJhRGmM8AmCp3GgkdSJvC4+85kD3ZE9yVMZ
	 jz+KoNiTClqmPi7KzZrWBJG1hDBlWYYWW2mGCgLXMK0mLUbHYgu
Date: Sun, 29 Oct 2023 14:18:57 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/1] merge-file: add an option to process object IDs
Message-ID: <ZT5p0WUw7EeaY8vW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
 <20231024195655.2413191-2-sandals@crustytoothpaste.net>
 <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/rDfEQzsswgJ/tfn"
Content-Disposition: inline
In-Reply-To: <CABPp-BG9Y6aZ+TWdkL4QE9e12fu3n61V16G6DLtawEDe=g9F4w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Level: *


--/rDfEQzsswgJ/tfn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-10-29 at 06:17:09, Elijah Newren wrote:
> Hi,
>=20
> Overall, looks good.  Just a couple questions...
>=20
> On Tue, Oct 24, 2023 at 12:58=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > From: "brian m. carlson" <bk2204@github.com>
> >
> [...]
> > --- a/Documentation/git-merge-file.txt
> > +++ b/Documentation/git-merge-file.txt
> > @@ -12,6 +12,9 @@ SYNOPSIS
> >  'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
> >         [--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-=
size=3D<n>]
> >         [--[no-]diff3] <current-file> <base-file> <other-file>
> > +'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L <o=
ther-name>]]]
> > +       [--ours|--theirs|--union] [-q|--quiet] [--marker-size=3D<n>]
> > +       [--[no-]diff3] <current-oid> <base-oid> <other-oid>
>=20
> Why was the `[-p|--stdout]` option removed in the second synopsis?
> Elsewhere you explicitly call it out as a possibility to be used with
> --object-id.

Originally because it implied `-p`, but I changed that to write into the
object store.  I'll restore it.

> Also, why the extra synopsis instead of just adding a `[--object-id]`
> option to the previous one?

Because there's a relevant difference: the former has <current-file>,
<base-file>, and <other-file>, and the latter has the -oid versions.

> Does "/dev/null" have any portability considerations?  (I really don't
> know; just curious.)

We already use it elsewhere in the codebase, so I assume it works.  We
also have a test for that case and it worked in CI, so it's probably
fine.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--/rDfEQzsswgJ/tfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZT5p0AAKCRB8DEliiIei
gU6nAP9eP+PUlAFlPaDKRqbdiPS2DdZLwK41QZFktN/vy8XWCQD+OmBoa3BSGhWQ
Yx2k6Cdw0xVMybR4jh32TKVN5SfKxw4=
=IEL4
-----END PGP SIGNATURE-----

--/rDfEQzsswgJ/tfn--
