Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7F71B260
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QxlWP1AS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpqQtiS7"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91377C2
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 06:58:45 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id ABA105C02FF;
	Mon, 23 Oct 2023 09:58:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 23 Oct 2023 09:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698069524; x=1698155924; bh=nw
	1t/IqZ1C4ullLUSE2V/inmDSFXfMeGUjfv5pkiLVI=; b=QxlWP1ASAtwxAbA7gS
	7fcLnqOqWluP1FEgH8EQhu9ftC+B+sPaI8Cpbl2zu6O6cDZknK8dGKoQ7GZq2bu5
	CLt3bqJf+if5srFgVu1Sc49NVNKwkrmgjB/oM0FpfXKWDAjc69T59D4X1cDsUb63
	xTJ0aoqH6P3U9J00fNChBIMzp41Sr8HVNb6PPDoJ1DunDysz5rpJN4fvrid+EZw1
	d8a2kbQKx7enhlSaDBkTUJwim70a3sv5XpIIGJW/qJ/l6JPQhvy4atvk6I0GUDQw
	2ZalKGNhCU802MLBByUPxbggeDYZsA7cqVxY1o3bV1ZwqH/h5sveEIe/L+mR4FBW
	0P4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698069524; x=1698155924; bh=nw1t/IqZ1C4ul
	lLUSE2V/inmDSFXfMeGUjfv5pkiLVI=; b=qpqQtiS70JfE1sqb+14ox/FEso2kJ
	91+CqWfjaIXP2h0TQGe3PzhL9/i9oLPQofUvzysE54xsU2JFwq4Htodq1jD6gWh+
	PC4to4OhsFc0tYUvBB51f3NiLiuz0OqLfyveMhDo3GLq3FKgA3cRrnaogY/kTfvO
	7jhHLO+dxODMlESG/0is0hvmTFbQH50PxdIe8+cqsF/9k+CYCRXDLPkcgE/9vHDy
	S4kx69CBWQ8RPDU5ciEgRy5a7zYDn1EOoiOObg2wloB+xkYVvIzuXj1CqkMthLo7
	6RJJ2WJFtcKPbYOMP/Cz8rmC94n8+/27+cK4S9gyJ+nlgSegGyFgmzsOQ==
X-ME-Sender: <xms:FHw2ZUygZWBxDLNBQ40IE02HmmcZQT8l7ESfG1r07XSQoxgGAJjLkg>
    <xme:FHw2ZYSkT0_IktLJ33brrPSXNFBEYLWOOTso57oy4wyEk3ZdKxctENQ7NtmgBHOZy
    IYYu_YY6jV89ASHAA>
X-ME-Received: <xmr:FHw2ZWX8x2tm_7UdQRd8zhe7YWirJeMbGA-WRBbOxrXA7gWmt_ijU3psBgOsvgUwNUeAYGCKBDLNB3MOXxfZv6LkhdI5ZC7u3Wc8SLp_JrGy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:FHw2ZSih6Bh_BPQK0Q7LaofsCytjdFdjLysQNdpQAQ4j95Q9bsrrLw>
    <xmx:FHw2ZWBS-hieJdsBOA9D_BuoURZrFfDLjkV13CCpz1c3ygElR04b4Q>
    <xmx:FHw2ZTLv_TnDAhVaNhbBqK45RNYKecyiy9pbeDYVQwTAjbJ65oBQ4A>
    <xmx:FHw2ZX6pM_BWWopMetLEyoC-9i7kK9x-35V1KPX6gpdYRREQ6734pw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 09:58:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 549b9e9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 13:58:40 +0000 (UTC)
Date: Mon, 23 Oct 2023 15:58:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 01/11] t: add helpers to test for reference existence
Message-ID: <ZTZ8EfCgilMP_NCp@tanuki>
References: <cover.1697607222.git.ps@pks.im>
 <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
 <CAPig+cTueWuiWiw9_vou0Ud71utVMRkk5tR==tfkkMXBj9qWxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6towL6kqjuQeZ7n5"
Content-Disposition: inline
In-Reply-To: <CAPig+cTueWuiWiw9_vou0Ud71utVMRkk5tR==tfkkMXBj9qWxA@mail.gmail.com>


--6towL6kqjuQeZ7n5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 01:08:45PM -0400, Eric Sunshine wrote:
> On Wed, Oct 18, 2023 at 1:35=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > Introduce a new subcommand for our ref-store test helper that explicitly
> > checks only for the presence or absence of a reference. This addresses
> > these limitations:
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> > @@ -221,6 +221,30 @@ static int cmd_verify_ref(struct ref_store *refs, =
const char **argv)
> > +static int cmd_ref_exists(struct ref_store *refs, const char **argv)
> > +{
> > +       const char *refname =3D notnull(*argv++, "refname");
> > +       struct strbuf unused_referent =3D STRBUF_INIT;
> > +       struct object_id unused_oid;
> > +       unsigned int unused_type;
> > +       int failure_errno;
> > +
> > +       if (refs_read_raw_ref(refs, refname, &unused_oid, &unused_refer=
ent,
> > +                             &unused_type, &failure_errno)) {
> > +               /*
> > +                * We handle ENOENT separately here such that it is pos=
sible to
> > +                * distinguish actually-missing references from any kin=
d of
> > +                * generic error.
> > +                */
> > +               if (failure_errno =3D=3D ENOENT)
> > +                       return 17;
> > +               return -1;
> > +       }
> > +
> > +       strbuf_release(&unused_referent);
> > +       return 0;
> > +}
>=20
> Unless refs_read_raw_ref() guarantees that `unused_referent` remains
> unallocated upon failure[*], then the early returns inside the
> conditional leak the strbuf. True, the program is exiting immediately
> anyhow, so this (potential) leak isn't significant, but it seems odd
> to clean up in one case (return 0) but not in the others (return -1 &
> 17).
>=20
> [*] In my (admittedly brief) scan of the code and documentation, I
> didn't see any such promise.

Agreed, let's just be thorough and plug any potential memor leak here.

Patrick

--6towL6kqjuQeZ7n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2fBAACgkQVbJhu7ck
PpRBfxAAjs1rKpBEaHaBm1TKuI95/dCjpc1feop8ImBYYaZrQnl/UI6DilyWRnVa
6ajVA0SZVxYRJV0KR0eZBHWLBElDULU0c114D+HBorxIMmMAILAdjFN0QirZ8I0O
+Z6eRBCv8Hwu03yQZK7vlMmevJjRPOG29gX4t2l9TMQ1EY5K/L3eNV6aVqol8OGm
X05EuVLbvKDRzNc+Jsin7GUVBOVTbz1XRRWq1opwwKniGE09DVEmTa3IHG/BKWIN
nfNHCga7b64eBM7ewCe6YkcYvFFNS27WDjxnIzv0Mck8I/rJOJQkeXvX3J+aYzZQ
tuN+csGAM8Z+CRPDLvr5AwBeHLmuxHAHwa4E1IYbOrJh8vQ6TNJqlFLMLAKSxh7T
3SQ4mVSaxKW4GJP6uUxAzd/eUo6dlU3VYGfklJpaF+YONmlYCldlCpkm/VIR97Hw
yMY/LIF/7uJXfmcSxF/IrsYtrTW+HbNohZBLpFIOkIlge+L1uixrVvLkiYanPyn9
aeD6lRUT6z2w0vt1rRl1O2IJXxHCyg6acLo2N2MHuug8F+Wwlo88LQbztHbYJ7e3
TdPAZLcmW7qYrdUZi6VVQT9hIX41np18V5lPqGDz7y0OBptyu6wpWdZiswJ/wqk9
oUaK4m98fFHUNraqj7Xv6mbhGCi3lL9HVI1d2C2+ehKE4fOf6XY=
=2WtF
-----END PGP SIGNATURE-----

--6towL6kqjuQeZ7n5--
