Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908E4207A
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736204717; cv=none; b=co4WQqq6ieMrXDhaapHIox10N4rYAaJ1XzmU++EEKMmSfxYneZJrw5v0SXnmZfDFQdey5UrxDtZvVfeFkQx3vMpQ8dU2Cb8oSmWcz3ykQaW1FRMvZEm0Cc7yflgFtvxr81JS/auhgSi6LMuy7uO9Mn5kT5H+vn5d2BFEGj/KBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736204717; c=relaxed/simple;
	bh=nbSKvT0+TFePK6yCzdIl0LezO8Bj6a/GYUNOyYYm7MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH+Y9Ny2QZhX8JY8ydgjHc0eBMWmuqGRfOYXePzQqHC+k6/dazMSGrNhkxJNl1CTp59pcK1dQg1fDDAO31AQ40jSrVjujeDseidjx6cly7M8uAuiO10rulXTrbHFn9NMHW3NWOGQu9kHWeK0cZsPhcpqRzfV0P/TCmkgeOX1FqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PQEtUaW+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PQEtUaW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1736204713;
	bh=nbSKvT0+TFePK6yCzdIl0LezO8Bj6a/GYUNOyYYm7MY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PQEtUaW+uLcwE8kwHPLPUTpJDWrcx6RSmMY/SopKWZGCh5FoifksdFTsPOH2odS7u
	 D8hLoJVOpUpkHSiwKRK5at1Pxgnhf4lGwwjIwd+68ZtYHjXeZqU0HSofOunxjQ/NqS
	 pQuvddkglb28an2ymNw0qr9vL6ecmpWIU4fnCRjmdDEvTraMlbALZAxVuKFO2GtI7P
	 zGSTOW3jg2LhVaP+xTyXzaBk6DzCkxDQ6woI67nMV0fTBjoFUZD1sqXFFBk8QM8BiF
	 8yyglcXiR6C13qkGYfJCE+HCQTKTVsSHGG8k92TM1oI+EgMd9HNNXnhq2ZZc6I17j2
	 qsEIFstSefSECpDMpJmAOYlYpn+/4CkpeseBwxV91/A+MN5peM9gB8bjirTlQeLizH
	 nS4aVOw2FJLEj1WwZNBEDlg0tSSfj9M8L4/AJuYHCCRrf5H+ubocLi5DDFZT64I3nI
	 RTYK+kJCHq7ZQB1W80xUKPNa1bwqZM8lx4nVE9IJdavVH1F2lWD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5697C20991;
	Mon,  6 Jan 2025 23:05:13 +0000 (UTC)
Date: Mon, 6 Jan 2025 23:05:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: M Hickford <mirth.hickford@gmail.com>
Cc: M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] credential-cache: respect request capabilities
Message-ID: <Z3xhqCf7Gr74BHO4@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	M Hickford <mirth.hickford@gmail.com>,
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.1842.git.1734729534213.gitgitgadget@gmail.com>
 <pull.1842.v2.git.1736193131798.gitgitgadget@gmail.com>
 <Z3xaE_v45G447HQe@tapette.crustytoothpaste.net>
 <CAGJzqsn6kV4LeYKk=qWu3GvbtNrJ5LG9LvbDVMQoHqibR9ieSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hkCdA9xRtJR2YZY3"
Content-Disposition: inline
In-Reply-To: <CAGJzqsn6kV4LeYKk=qWu3GvbtNrJ5LG9LvbDVMQoHqibR9ieSA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--hkCdA9xRtJR2YZY3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-06 at 22:57:06, M Hickford wrote:
> On Mon, 6 Jan 2025 at 22:32, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2025-01-06 at 19:52:11, M Hickford via GitGitGadget wrote:
> > > From: M Hickford <mirth.hickford@gmail.com>
> > > diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-=
cache--daemon.c
> > > index bc22f5c6d24..692216cf83c 100644
> > > --- a/builtin/credential-cache--daemon.c
> > > +++ b/builtin/credential-cache--daemon.c
> > > @@ -134,17 +134,16 @@ static void serve_one_client(FILE *in, FILE *ou=
t)
> > >       else if (!strcmp(action.buf, "get")) {
> > >               struct credential_cache_entry *e =3D lookup_credential(=
&c);
> > >               if (e) {
> > > -                     e->item.capa_authtype.request_initial =3D 1;
> > > -                     e->item.capa_authtype.request_helper =3D 1;
> > > -
> > > -                     fprintf(out, "capability[]=3Dauthtype\n");
> > > +                     if (credential_has_capability(&c.capa_authtype,=
 CREDENTIAL_OP_RESPONSE)) {
> > > +                             fprintf(out, "capability[]=3Dauthtype\n=
");
> > > +                     }
> >
> > This part is not correct.
>=20
> Thanks for the review. I'll revert this part and amend the commit message.

I applied this without that change and it does still pass the test,
which I think is good and shows that can be omitted.  If I have some
time, I may send a follow-up patch to add some additional tests.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--hkCdA9xRtJR2YZY3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.45 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ3xhpwAKCRB8DEliiIei
gTHKAP439+YWr7N4/c4utfhkYbi5t/uV8rLo0V2IMLTWgmVh6wD/SLG8KG5LMObD
PX65j7puffusSEt8RHclgHGng+4C8gQ=
=HHYM
-----END PGP SIGNATURE-----

--hkCdA9xRtJR2YZY3--
