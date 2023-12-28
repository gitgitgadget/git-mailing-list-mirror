Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DF101EF
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 20:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eRukDZey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpZOOHg9"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 1D701320031A;
	Thu, 28 Dec 2023 15:01:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 15:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703793718; x=1703880118; bh=lH/NNEu/fu
	mTmOgQtpjmBqa/GSUBWDJ5FHfzpTF+H7k=; b=eRukDZeyU3mMIURyU1c8ZpwU/2
	/GZdO/jbkVc3HJuvrga1u32t25mcUWSX2+GdeGxS8/2CJJI/KuF6SAfbR1G23vgJ
	KmRXavKzHK+6I4OFfGphpd4NzrY4D1z3rsHI9duZ1QRrb3TkAwv938Z7K8Y0uNyK
	9LWpZxqRacNJL6xfdBjc8fE2Pg/1yjWDtnNNG4B1Fwhl1lEzbzQ/QplRfFSfu8Zq
	IgOKRD9TSsg3wMMr2qPBbWXvnw5YD1tMw8rLo2tKKsFZJanBDU4oC0stjrJ0Jx9m
	2of+kJO5AQlckh1GsGjacF19TN1KCuQ5h28WOn2+NMDQ05xNnu50UVq2Kefw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703793718; x=1703880118; bh=lH/NNEu/fumTmOgQtpjmBqa/GSUB
	WDJ5FHfzpTF+H7k=; b=QpZOOHg9ZvckCq4K7p9HOPnhZ+9mR1+6oL3zC6Y0COkM
	VwYd8+HABLsBOzf1mdv8xC8ruZG/uiD1qrtcDYt1f9Wzdh3+L1ax9UylunswuB5l
	JjQvd9Q02YbVWnD9h0jZqXXspusFxIIwmO0o50nYaGIawSlGEa+2phn1ggMa/Ky9
	yxAiRpq4d5X0ll0fXvqFxejgjAawy75QXiwj+7fERVeCiurxMNlZbOxsSTvllYSH
	6gi1czVmfHYJRW8X4+HevYh19VtirI4rTs+iAmU8Di+FOZae6DELLLJYa1jnNBQ5
	+1F54/+7gOLTtyRJD2aNYeW8LWUKIT60YO941eEhVg==
X-ME-Sender: <xms:NtSNZaKTMn-FxkOb8PdKK0uInVeyGFR19lRtNEY2IMn99RmVCunh4A>
    <xme:NtSNZSKEenbhQNlGaZLtRtyJ13kyR9OwaUujuJECzkjaDpUjJeW0rhOGdNfc0b_kU
    vW8_OPURYQijnbiEA>
X-ME-Received: <xmr:NtSNZasmmcf5CkIML6kf1C2J10bMFGSy09l8YsGg_oPN9YmgHHaDbXgUY_rcgDzYGWQ8jYEEbKi2Dq_uDuv5UlliFPgIecZHUhf4SfqwJBj4PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:NtSNZfaEesmW6LlhthUGTCcqgjvZ-K4IIVF0jwWI9LSXgCL7dUA2wg>
    <xmx:NtSNZRZlq_-17xfiV33vyRcpVCTPIbqAPc65nu4Dngc20uhIiI2KCw>
    <xmx:NtSNZbBq-p1rP62WwWi8L2-jVvV-Cim134H_w51DVAQ_SUhjz0ebjg>
    <xmx:NtSNZSBOxs2EXUzHZbqkDkfs3JSuABUZ6xIVtGl5tNFTKaPIch5XoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 15:01:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb8cefb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 19:59:42 +0000 (UTC)
Date: Thu, 28 Dec 2023 21:01:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/12] setup: start tracking ref storage format when
Message-ID: <ZY3UMwe0X4gVHyAm@framework>
References: <cover.1703067989.git.ps@pks.im>
 <6564659d403de098799ddb8101b74c2803a655d4.1703067989.git.ps@pks.im>
 <xmqqv88ssp4r.fsf@gitster.g>
 <ZY04OlTNUEZs5T-T@tanuki>
 <xmqqplyqgsem.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0eKy0S9alMUXIc9d"
Content-Disposition: inline
In-Reply-To: <xmqqplyqgsem.fsf@gitster.g>


--0eKy0S9alMUXIc9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 09:15:29AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Makes me wonder whether we should then also add the following diff to
> > "setup: set repository's format on init" when both topics are being
> > merged together:
> >
> > diff --git a/setup.c b/setup.c
> > index 3d980814bc..3d35c78c68 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2210,6 +2210,7 @@ int init_db(const char *git_dir, const char *real=
_git_dir,
> >  	 * format we can update the repository's settings accordingly.
> >  	 */
> >  	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> > +	repo_set_compat_hash_algo(the_repository, repo_fmt.compat_hash_algo);
> >  	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_form=
at);
> > =20
> >  	if (!(flags & INIT_DB_SKIP_REFDB))
>=20
> Shouldn't that come from the series that wants .compat_hash_algo in
> the repo_fmt structure, whichever it is, not added by an evil merge?

Well, the above code is newly added by my series to ensure that
`init_db()` results in a properly initialized repo upon return. So the
compat hash algo series cannot yet call `repo_set_compat_hash_algo()`
because the code site doesn't exist, whereas my series cannot yet add
the call because there is no compat hash algo yet.

So depending on which series lands first we'll either have to adapt the
respective other series or do an evil merge.

Patrick

--0eKy0S9alMUXIc9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWN1DIACgkQVbJhu7ck
PpSLXQ/+OcMKov5cpkuJ4slx5nhTl6XMjDg7syi5ivqRK4pRCaA7WkqtjriLmUZb
mt1ooiF+94lnXc6O/mblFnvxeBf5dcyYldk7+5HrMO5tLaSTegjb9UaPAnJHQ7T2
2VcVafUuZo1O1Lk00pU4xOf8dyLRGyDjRqkjdQF2YtikcxviZUGt1xa40uI3TY6T
WlDrWsSBUZv8v4qPdAnc6xAkIAa0ur4VnedGbSb9CGuYqc/IYIRAq2pa2md2skTb
Anqz1ua8f6u8u1VwIC23q7DH+V3zTNlslsrJJO72gbauhqQYgFnifCTWmhE4DxWv
iI2K8P3EU2WEx5HUC68DPcvWdGDvZ/AmRDRNbqOM5IFVOPnOGvOljGg389afIwlO
lJyd448VF8w5Ma+BF+ZyBkdCzt+VqLJIS8deby2MDaCTOFjoDhEqD4ZD13FNO9I2
6MHJww32BIGF2t0GPmqN6CRTKaq7aRJVWCfZQFOQ2o/rEb6uH+JJNz/iayhFe4IV
QlGYh/Hh+d8TdVPHepPd0wUglHIZT1LC9ERZoiJ8443Tq4DXOlrI6Wd7BP8BHRMi
df+gBhCO+iiJX3w6pNCSDQruFGK7fSA7V8sEZ65/Ya4KujyW4XHemUGrm7QmF2Vt
Fji7w/dRTW4LCjj6cxBZabiJ4oRKeTGj7ZoLvH+noz2S8iFAU0o=
=GBbB
-----END PGP SIGNATURE-----

--0eKy0S9alMUXIc9d--
