Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677DDDA7
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M4+j1b9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0mrRRSN"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 80DFB3200A61;
	Thu, 11 Jan 2024 02:41:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 02:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704958915; x=1705045315; bh=8KeOtmcRKn
	4XDDAPHr9xKZ4y2WBE0sOdiLPt8tRe5Xs=; b=M4+j1b9EARWmDMOwizCiioPXEN
	auktiNtdRKw0yKy1hZMdYS/FRx0M0nSL453SOWyUMPtIKbytJAuNW442DgjMSkU/
	lFCWSqWKDYybukE7Ud4HXX4/CixmKjczZxGK5ZhHCn8fci27gM8ckdMu7Y3sbTLq
	fMT1pFzkDiAMKEWozt0YVLM2nkHdw+qBVqMfjXgAD91jzzs7A/sSuUIw8Zt/GCO4
	xCh5HYDT12LovifwvJPw8pERWNmR9bQQY65GXoi5Qx8VpOFZgxyirLk346mEsdMV
	0a/lvWd+Xs7x00kqPE0aakc6EuaBYzJp2IEvR5465YkDRy8eQX3jnMIDH4yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704958915; x=1705045315; bh=8KeOtmcRKn4XDDAPHr9xKZ4y2WBE
	0sOdiLPt8tRe5Xs=; b=e0mrRRSNjM4FXFd0WwaTyKId0ELpmdIUsV5yfBDg4bFG
	T0FUUSlUX9/cHslT3NXOkoDNn/x4wFWTIhkkft2Puf/LPx7WNsgh5yfIpUWEMJlf
	1SDl/3ftY6AA4KlU/BeLMSItal7tar4vigwRgDfSpnpLpIQ/FsoRhNvaIpEM990x
	o3VdAjW1ezQBmpFpAvDq6+E/A+EyGZ9SdJPeJmhUnc6SJjvERn0uMy9R/jhq2lHd
	YtHLMoaAkNBKaPsGE+IyHMMCtmQElgshO66c5hP6R3/SEAgJS4WmkybPM4Vt3ljp
	ksRxEzFCLR7csRDNWrr0Ya80+w/+wcjaIhjFNmIEiQ==
X-ME-Sender: <xms:w5ufZaJIDJ7VtQxuTdXvbO9zasMHE_jbSuDB7RsMapUVarpBm7492Q>
    <xme:w5ufZSKVyg0CSsc8yv6lmNb6F1Mak2m7V5BYOliVgUdoDi_GteOpxS7805SKHzBJQ
    992vtB5Ze8jvBzYvA>
X-ME-Received: <xmr:w5ufZatj9s80XC_cantcLIvKSz7m-GpXBmeuo0jAH_JaI7Eo7lbJ1ot9UKRXxivZ8RmolWbuYttfxA0suTdgqVrr4OFZbVSw--_1opkgrO2oVlRYSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekke
    fgffduhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:w5ufZfZ9-1nsJoN53KDzkGp02hVRUYC6_7bcwbsvAl9pKhhZnIaf4g>
    <xmx:w5ufZRZqS_Iu2LnYg1BcMJrlUuiBgRNHOp3r5d7LvpKT7QPWyYTKFQ>
    <xmx:w5ufZbCLmkztzOFLfXU5z6IUllwjYaytHabFb49Odq79kxrglGqueA>
    <xmx:w5ufZQwSjObm2e9E7ECBCjzRzbxSgfdItSrDGYPURl_RxFBztMUGYw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 02:41:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1a2e134 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 07:39:12 +0000 (UTC)
Date: Thu, 11 Jan 2024 08:41:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 3/4] reftable/stack: use stat info to avoid re-reading
 stack list
Message-ID: <ZZ-bwC66hDpbm6qm@tanuki>
References: <cover.1704714575.git.ps@pks.im>
 <4fabdc3d8016dbc1e20fbe90058ee7320a5f770b.1704714575.git.ps@pks.im>
 <xmqqo7dt9ckn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YvJks1AJj17dSUoe"
Content-Disposition: inline
In-Reply-To: <xmqqo7dt9ckn.fsf@gitster.g>


--YvJks1AJj17dSUoe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:07:52PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We can do better and use the same stat(3P)-based mechanism that the
> > "packed" backend uses. Instead of reading the file, we will only open
> > the file descriptor, fstat(3P) it, and then compare the info against the
> > cached value from the last time we have updated the stack. This should
> > always work alright because "tables.list" is updated atomically via a
> > rename, so even if the ctime or mtime wasn't granular enough to identify
> > a change, at least the inode number should have changed.
>=20
> Or the file size.  Let's keep in mind that many users get useless
> inum from their filesystem X-<.
>=20
> >   Summary
> >     update-ref: create many refs (refcount =3D 1, revision =3D HEAD~) r=
an
> >       1.01 =B1 0.09 times faster than update-ref: create many refs (ref=
count =3D 1, revision =3D HEAD)
> >       2.72 =B1 0.11 times faster than update-ref: create many refs (ref=
count =3D 100, revision =3D HEAD)
> >       3.42 =B1 0.13 times faster than update-ref: create many refs (ref=
count =3D 100, revision =3D HEAD~)
> >     163.59 =B1 5.62 times faster than update-ref: create many refs (ref=
count =3D 10000, revision =3D HEAD)
> >     233.91 =B1 7.92 times faster than update-ref: create many refs (ref=
count =3D 10000, revision =3D HEAD~)
> > ---
>=20
> Nice.
>=20
> > @@ -374,6 +375,8 @@ static int reftable_stack_reload_maybe_reuse(struct=
 reftable_stack *st,
> >  		sleep_millisec(delay);
> >  	}
> > =20
> > +	stat_validity_update(&st->list_validity, fd);
> > +
> >  out:
> >  	if (fd >=3D 0)
> >  		close(fd);
>=20
> The stat_validity_update() does not happen in the error codepath.
>=20
> Should we be clearing the validity of the list when somebody jumps
> to "out:" due to an error?  Or by the time this function gets
> called, the caller would already have cleared the validity and an
> error that jumps to "out:" keeps the list invalid?

It likely does not matter much. This function only gets called when we
have previously determined the stack to be out of date already. So
unless we update the validity cache, we know that the next validity
check would continue to treat the stack as outdated.

That being said I think it's good hygiene to clear the validity cache
regardless of that.

Patrick

--YvJks1AJj17dSUoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfm78ACgkQVbJhu7ck
PpT0rw//cANgmx0Ux+pVAmBP9OESKclc90ZvqStD0GstQCThN664RlZad/GrCJTB
Ogx8V8u0SpJDxaZKPPRSzgyE3FMvfU91KmUf1VOMlI9B3Pv9vTXXBE0TVH/mxgD7
LLAUc4POK0L0N1wdh3iq4Dd0Q0uvtKWezO6YvsuFBYtiZtENxi7v8DopQ2elXbp7
Ez+41cpLIQ/CEPSSWuVcO84jwratGeQC/ekz2yvzMSS1sQIP/eApmFkYwtcbAdle
mEVHEGjyNXm5No/fDDljK1sCiLDT0Q0UV24nFfv+AWBbdn4G2bpGbp7Ucjw4XjAP
KNXvDzbVx8SY4AhEMuAo3zwIHD9cmOcyxbipL4Hwmya/6RM5yB840E87a18QlkVe
viaGyvDSrRC2Pw8UE60uzpWr/5FZdRNINK5uuZkpTvPa4naTKQcq1RTd2sMR/5A6
VfHAY5cLm712eWmqqnUoKlgAfLhpW2sulIK2sBVG+2VWvbso1VxM4dRjVBAJ/qeB
5ZyFjdYhm5moGhaY0722rK/y/KY45hZjkt2tLoRJH2slVvM2rfymwfXFAYwD19RM
rFeiLw71jdCtYpUTqsZXi9O3IYIqtcH/uTLBs31MJGBiPKbgUPnx4zvcOcaCSMuW
1P9mk3AmYebUOlAACfuZqIU62/qAbDzxuz4ScW/vYAzB/4uhvK8=
=KMGm
-----END PGP SIGNATURE-----

--YvJks1AJj17dSUoe--
