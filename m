Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511A85931
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545685; cv=none; b=b3mxKq4AfZEAeLGAie9DgEbyBLS1D14xyVzAn/5uWOOoG0vSL8bFk5784FB5mUAtd3Iy63FUzLUiEJbBFPPxkygTd5PCr0tWIaDxzadMUZp8LT5iI0dZszb9b5DVpERSQhvImNgiXHKiyrmaxK2jU3oOZDqQ5k2rVbV5093tHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545685; c=relaxed/simple;
	bh=tcvWuHriSlbhQ7lFE0/gpMcGo3S75njmnfkKqV8Y7pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1h+zyBcZmqClWi8T6iUbhZWVVkNHsKV0ZlIJ9b0Jf1jQFWJGblrcswo/sR+CaEbYJQJKdviUv0kqfX6FomMkINNimxdWJOlnvoebFF9E9+Ci1HwiayW2YXgIOGTn1CFloyfWfh7nh6j4FzQA2Lawj8qQXGUsOB7c2Eat6DlCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JESUXUS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QinNx/xw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JESUXUS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QinNx/xw"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D6FE5114012B;
	Fri, 24 May 2024 06:14:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 May 2024 06:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545682; x=1716632082; bh=LrayIHCNeI
	+Amd4et1/E6CHPKSfCB5Z/nG49Rl2Kt/s=; b=JESUXUS9u/s44Q9Ux3hvnoQ9zx
	9ib+QZOaTh3pz1meaFKXIxgIaC+MMETi6TXx0IF0AE38r4t+BuCFSnKzE8aQ6P4x
	l36NO+7bI6YS29ybANx/RB3eHPJp03GjFHxnGEAKHnmrnMvbVSPiLEae79vGU3eb
	a5kddXaYkmcrVcHcZAL0/ZcHUWhNia1X03FwujuUXa/S4z2SMdAxWXkvnLgciLDz
	5eO2T8oigFaIXfVkXe800Ji6AV0ilNUp6U2bzDZ1LP2aop0PYhSHUavDguKfQrFP
	y38YBZ9pi1t/MzE1imCshc+i1pDfjhSgwnfsr/Y54CZfY/R63ZvO822B3fxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545682; x=1716632082; bh=LrayIHCNeI+Amd4et1/E6CHPKSfC
	B5Z/nG49Rl2Kt/s=; b=QinNx/xwtWA39Fxh7vqAJrWDUJ9SPOWPa8U2BavDBdKm
	w4VnX44QCO9m6RwKqCSbEuG5E0BmTb36ByYoHX48LdRHMl/R0sA23j5NCGm3/UiQ
	m/lZrJOPONaWHvgFaTJDpLVHz4ULFiXB74iH1nAAXI+mfbVPdzSfTCT79DqsW++y
	hw+q2oWc87W0pLHJ7GwtoR/lpt91o8SKRsMeTt77CXdRbXipUO7hwICOOjIU4/Yw
	BVUZLdT0AAbVkk5ngQ7GcgFOhgmpdRrQACm2nadMnxs/catdNMydfsyIfyiRFLgt
	MDeDGBJ0AOrVOTMbOv39ZbZmY6BmAGnoZg0rrYrrVw==
X-ME-Sender: <xms:kmhQZnRu-uxmy0l_DO6JGXOPV5QqMlVsGU74GAuiECpCB0mYtGjjhQ>
    <xme:kmhQZoxbw5iQ-PKpRotuvj6EY-DvRCijAoD0uLiJbNkyxOQT6dbstLPvv283idWn9
    s83h2Bg1lsIXZvizw>
X-ME-Received: <xmr:kmhQZs0a3lM5fOBQZZnzNKqWtZhX8uU7uZcr15_OU3-SUwEnoXkpXiTxrFPwHQEHIHxfR5VppEajO5vLT1N-A8HZCrxcJBuGkUz15N8zr2svqPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kmhQZnADhQFrBevMhXAnsIV6oEcO-BBeX-Vw9jK_vJo1SNOUvQ2YAw>
    <xmx:kmhQZgjbPK4qqih_zMnaYVLKlK9gptdTgdBWHjrdn9Le--Lyo7GwvA>
    <xmx:kmhQZroO-TgCFJaVR57TrxwGCRc73lZHzifk5l3K1CE4k_xHWPQnLA>
    <xmx:kmhQZrjyW1eHokcyMkckA2tTO89EKDc5gYCBF-BApt2_tv-7WuMvvA>
    <xmx:kmhQZpvRypRhDHIuauiYXiUb0KVvxywjvGEN-jnW3PXlnuGYcoFiFo68>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 57d89369 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:39 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/9] refs: pass storage format to `ref_store_init()`
 explicitly
Message-ID: <6e7b9764f6290fb8ffe5941e33b72081e1c9581f.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/G9/lw8k1IoNz4xC"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--/G9/lw8k1IoNz4xC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce logic to migrate refs from one storage format
to another one. This will require us to initialize a ref store with a
different format than the one used by the passed-in repository.

Prepare for this by accepting the desired ref storage format as
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index e6db85a165..7c3f4df457 100644
--- a/refs.c
+++ b/refs.c
@@ -1894,13 +1894,14 @@ static struct ref_store *lookup_ref_store_map(struc=
t strmap *map,
  * gitdir.
  */
 static struct ref_store *ref_store_init(struct repository *repo,
+					enum ref_storage_format format,
 					const char *gitdir,
 					unsigned int flags)
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
=20
-	be =3D find_ref_storage_backend(repo->ref_storage_format);
+	be =3D find_ref_storage_backend(format);
 	if (!be)
 		BUG("reference backend is unknown");
=20
@@ -1922,7 +1923,8 @@ struct ref_store *get_main_ref_store(struct repositor=
y *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
=20
-	r->refs_private =3D ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private =3D ref_store_init(r, r->ref_storage_format,
+					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private =3D maybe_debug_wrap_ref_store(r->gitdir, r->refs_private=
);
 	return r->refs_private;
 }
@@ -1982,7 +1984,8 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
 		free(subrepo);
 		goto done;
 	}
-	refs =3D ref_store_init(subrepo, submodule_sb.buf,
+	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -2011,12 +2014,12 @@ struct ref_store *get_worktree_ref_store(const stru=
ct worktree *wt)
 		struct strbuf common_path =3D STRBUF_INIT;
 		strbuf_git_common_path(&common_path, wt->repo,
 				      "worktrees/%s", wt->id);
-		refs =3D ref_store_init(wt->repo, common_path.buf,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, wt->repo->ref_storage_format,
+				      common_path.buf, REF_STORE_ALL_CAPS);
 		strbuf_release(&common_path);
 	} else {
-		refs =3D ref_store_init(wt->repo, wt->repo->commondir,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, the_repository->ref_storage_format,
+				      wt->repo->commondir, REF_STORE_ALL_CAPS);
 	}
=20
 	if (refs)
--=20
2.45.1.216.g4365c6fcf9.dirty


--/G9/lw8k1IoNz4xC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaI4ACgkQVbJhu7ck
PpTXEA//SOD9QfnffyGNPC6z/wiijx5hop5JezNESj89uAvzCiVCjIAGmTA9irB6
EmB6GWe4QOKWazn09hGxCeSuWiqXKM8xNW2s7zvlosmlT6QgrpRYAhqHVKixy8Tm
uDqhwHiy2f8+9m5VO6o+dDTe/FMSKvqfNA4PE8VXgDvgnqFw3ZuoIxYOTKo/Sq1x
RZFXdNz3LaHds61mKmLzlW0Dhs1fjWJWmy48PrZ7hcx/v2XLF/wZFT9Ek1ehTXPo
RSjWTR7+UTgp3oqw4uGY/JhvonJzGnLR6YloJTI9+2Gujq4DfLFfRB0MokKhh9gb
PtVL4zpyctrH4KSAvLjJRlX3IRw/m7ExvJio+zxE/hJlv0mODFXB86RIqXd11I+t
MQGxxEXCJ91kR1+sWG1tznJpwvxiFgvrkqDN1Omtn+T+nCY+ficx+K8tqXrtvYQj
WIUkndpuiu1lV6UBYXmfwbCIAFPBTdUgDcffD/NSw6lYLEyy811XrUq/Wa0E8gtE
Bzj7Fh7Ly0dr1DzK+RA4DPM7vtU+AyneJnexij51t+W1C1mdcQRz6xxzsQ/e3gsI
91ReKYTO7Icw2seSpaFnQDdQ8iUBEvY3edHgO9E4A/C0r701NwX5XEkhsHWguryn
4oG/trG3jX8pTqDQ/S8QJj2cVsilr3TcjaHot35RrIESxRfquJU=
=8NYk
-----END PGP SIGNATURE-----

--/G9/lw8k1IoNz4xC--
