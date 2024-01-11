Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF314A9A
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tay473rF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hb/1viRN"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B425C320034E;
	Thu, 11 Jan 2024 05:06:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Jan 2024 05:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967607; x=1705054007; bh=kWfZRTI6C4
	6V2tI4qQ1kEo31dLwpGUQx/EySGEjZLMM=; b=tay473rFd5NmPldfSNEp2KDzws
	bLEpIQbPUCrTkDk1+uOan4kvQ1a0RCo8MwF/aZ66aMfb0OXkK0xHeJMhkoygpOKn
	dFfNgoezrS4JW0E0nZIfuId3Ee5o0H+23dHkhlaS7E2+8QxfeP5jaitvJce/zcRk
	5Kci9j/C5pZldRbQx5RwLAarLElNlgm+a0gWEt9NmM4J/+EbvBo5Ocl+o2G7Dc51
	sUcrCeo1OAkLr4W39RIwFMB5J3Iz1VLuXWInBqp09pWz3HI6fSym2bLejUetXIk3
	cVY8ymcoIU88+UFp7MRzIe+bpyWOZ2R9MuVw3O9JSquZgN1J8LIeF/l47JEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967607; x=1705054007; bh=kWfZRTI6C46V2tI4qQ1kEo31dLwp
	GUQx/EySGEjZLMM=; b=Hb/1viRNJigH71J5KzaZdgdDQ7vwq9Uc2t7q4m7A+nuL
	oOuMH1rJBjFS444Tzomn34VRsNzf+iYam1HKHxi/fg9STPOkRzUYgm4G5mP5RYRs
	HIrHZKMyzluWnNvtTKQfZqeDkgfF/B+jFgvMK3pxzB9ciB0ipIZhn0RDZ4TZApbN
	KwM8sn1/W1zzrpoySviBmpMCga3vO4pJqfDcZ5ptm3MmPO+GNf/d0g8JmDgKmdsR
	vhbxxLei/zfkUjYlLYhljL2cKCTc4OHtljf36HCf82DBWTThqNmW3RsWTgxRKuIO
	ILCBcW7WffpRS/9vC4qOxYfvaf9UCgL3FWWcymoD0g==
X-ME-Sender: <xms:tr2fZQj9uReNJPKyZw7zyvS4wcKyjqdXDlO8tFOHZ1z9nXSDk1vFRQ>
    <xme:tr2fZZAI3K6C3nmwVi4ahYPd6dIAvKhdINi-KFRgSsld_W_5BIGz2bqbJIPMymDXk
    cQYvsad1lF2avCKiA>
X-ME-Received: <xmr:tr2fZYFdgd-Zd9XAg3tdbTd-xTumm8wmoCWbeyawWEM9WPGTKmJxbGw3WvuiaEhIE_KsYswWyzx_tdJnr3V7azCPEajCOITIWO1n-8qG1CUgEoEiiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:t72fZRQi5rlGXxi9CKTSLZtdy9EF_ec6_w5QMuIoFIim7mGr8bgOvg>
    <xmx:t72fZdw-TuiExDAK5B0WNhTMZnoeDYOM5b08op2Itv1QUgVvZ21gdw>
    <xmx:t72fZf4HgXE6yFd_sFXxXGogFJ3Xt3Jk9-aV1EjXp9LfYcHBOpxtVA>
    <xmx:t72fZerbD1oYCIZhQy3xVhP6ZsG84gwt5-cUBItAPu-0hSRiHNiH4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3ae9fbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:04:03 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] reftable/stack: refactor reloading to use file
 descriptor
Message-ID: <36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QimlI5FILkw/avLO"
Content-Disposition: inline
In-Reply-To: <cover.1704966670.git.ps@pks.im>


--QimlI5FILkw/avLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce a stat(3P)-based caching mechanism to reload
the list of stacks only when it has changed. In order to avoid race
conditions this requires us to have a file descriptor available that we
can use to call fstat(3P) on.

Prepare for this by converting the code to use `fd_read_lines()` so that
we have the file descriptor readily available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bf869a6772..b1ee247601 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -308,6 +308,7 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 	struct timeval deadline;
 	int64_t delay =3D 0;
 	int tries =3D 0, err;
+	int fd =3D -1;
=20
 	err =3D gettimeofday(&deadline, NULL);
 	if (err < 0)
@@ -329,9 +330,19 @@ static int reftable_stack_reload_maybe_reuse(struct re=
ftable_stack *st,
 		if (tries > 3 && tv_cmp(&now, &deadline) >=3D 0)
 			goto out;
=20
-		err =3D read_lines(st->list_file, &names);
-		if (err < 0)
-			goto out;
+		fd =3D open(st->list_file, O_RDONLY);
+		if (fd < 0) {
+			if (errno !=3D ENOENT) {
+				err =3D REFTABLE_IO_ERROR;
+				goto out;
+			}
+
+			names =3D reftable_calloc(sizeof(char *));
+		} else {
+			err =3D fd_read_lines(fd, &names);
+			if (err < 0)
+				goto out;
+		}
=20
 		err =3D reftable_stack_reload_once(st, names, reuse_open);
 		if (!err)
@@ -356,12 +367,16 @@ static int reftable_stack_reload_maybe_reuse(struct r=
eftable_stack *st,
 		names =3D NULL;
 		free_names(names_after);
 		names_after =3D NULL;
+		close(fd);
+		fd =3D -1;
=20
 		delay =3D delay + (delay * rand()) / RAND_MAX + 1;
 		sleep_millisec(delay);
 	}
=20
 out:
+	if (fd >=3D 0)
+		close(fd);
 	free_names(names);
 	free_names(names_after);
 	return err;
--=20
2.43.GIT


--QimlI5FILkw/avLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfvbMACgkQVbJhu7ck
PpQ8Fg//SRydCfIzyVt1yS9C6RusmcpjeCxX6aUndDN3SM8c2kPhXN7pMpICIZm2
8yy4MjAeQnBjanROuAsitUGjyA7PD1JEQzlZyWbwRwyAyj7JritqPfQRYRESsylI
VGMxzPYFED8xj4kDm5Ykbh+T4mcalDpmf2MfQ2/AUg3U3lX33b5e9YI23SQPp8Gv
4pEH/jhS+mUVIjRA1UIrsGxOudb9dOGnZCwLGpTA1s1p4SfU4iK100TTNQbXe3fn
BoX60YLlanj3MAHPNh4C9W/k3WkSLzfxSpg8xGQprzIX3Mm3hVIOC6itmu+z8Cnq
8fbGTuXMhdSmF7EBM51VS/5hvTN7NTMh2E3zrY7Kc0K0PK+2tEA9KnCF69RdEMd6
3n5fQQYdeYsMWXWwt8FOjfP/ugdFSmJouEXMfeR4xm5Dr8A3U0VZDrm3LJg5jtS0
qTCmKRe9uZcO+Sb+sijft0FnhznTfLErNGq7pXa3XzQhn9NdRrGxflIq6G5gvx4f
5WcuJP3sPW2QsCBQCYSGdrsUfFmC/YGq83rBNIzds6keprLX3oYyyh/po2siOyfM
w2+Yn1takNwnlYZB+BxYSeRT6GZjIK1EhZCmvEOld00DnHYRvHS44r23zJfyHdY7
esDdwVt9O2QMkXjVkVReaAaymbNI5A3M9wE7TrdWktVQi5kmF9Y=
=OLCg
-----END PGP SIGNATURE-----

--QimlI5FILkw/avLO--
