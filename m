Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88664101E4
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r0A3O6Wc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7TrevVt"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFF2590
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5804E5C0321;
	Thu,  9 Nov 2023 03:05:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Nov 2023 03:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517126; x=1699603526; bh=dG
	YdfWRWmG8jln7J3Nz6YVUvE0CuvkYiRD4WpLr4hgA=; b=r0A3O6WcB+UmXqGy4+
	Erw3hnCYHXdrJSpBmv1DIje6cXkLZgbc9GjEfPsq+/5t/HQaNaC5W7MeNcnYMc5I
	FP9L/juCbpXzO0tSJ1KuWxjjdORFtihbq6pY38fJbuYlOdWGa/GwVVJKhHqC7Tc8
	FRXjX7BXCFnia1+w+djmSdfJbbgSVentlzi8juJT07qpuYziHrBscjS6yBGSwahR
	z86C2zZ8mUnlolJkaCbGGBkYB2Pe8/BHhTAW0/iiMHlHDLkt97RiO8dt1zq7nJzH
	BiKWbJO47ojQGSdVeOXh8v4YSUVe2L0FGDASOKEjdnfZG40hA0Gjm7pdT1bgM4qE
	bWlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517126; x=1699603526; bh=dGYdfWRWmG8jl
	n7J3Nz6YVUvE0CuvkYiRD4WpLr4hgA=; b=s7TrevVtEm21UfpPNxG3ZV8JTOCzQ
	7ufSURanckl4awiMjlz+fTVgBwqujEMJB8WmXxHFm6Il8pLgV+qFs4nJUe/cx0WX
	dzBetDRyJv4yAUWhl0n3tB75fPraJ1AQtV8VwEsGTxDyFlD6UEarXit7UfMBck5c
	/dUaB2sRfNlkcTo+U26bBql+rgk3fv8U69nzwiJj6joZ9+EPU5bRNeT6+awDkRXY
	mgD+e9gQTxwmfZribt4kBv7WO3SgDDNPJCWBdcu0NahvhMxizmiScsBfJPBg6jtT
	8WGgfXQf8vTxg9RfcrP4iIxb1AV6/1ddRMe2UI+WGbKmaFNLN3lG9Dubw==
X-ME-Sender: <xms:xpJMZeVU9i_QG2RBPQPsJfhX4RMPuYGftiW8CfAk26jvKdeDM8Ln-Q>
    <xme:xpJMZan_Od0XTMfEHIY7H4uyGEVYPz2qmWvEpLuvq5hLskEmau27V5iR-JoNx_TYS
    3LI-JLAgOnmndREPA>
X-ME-Received: <xmr:xpJMZSYJkIJSL9ho9SscZAvNCXu_BC8cg2SjgU59fv5lMxv96dASx8SqoHn-NSzB-5jXpJDF8xxXxMPUGd2nhJsl-lIWGn_P9Y2XqbSIbWTgO8UG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeevheeuvedvffdvgeekieffueeiveejleeiffefieegvdduheduleegudejfeei
    udenucffohhmrghinhepghhithhlrggsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xpJMZVV1d6fVRSr-IA9ipnSzDYB3uvskIOQM9SAEs64UCk1BBI4ZmA>
    <xmx:xpJMZYkX573vCe6SeYBjt_HrkAvW3ONVUSp1f0qsaMyykLFQVzwGmQ>
    <xmx:xpJMZae3vHsl56PvLj-lCgG4xxvS7SvGFdJsY8RfMaJHLxKlU3CUSg>
    <xmx:xpJMZXv2YVmUYvFnKXs-6slkYEpMeOUMxO92kyYLiKRFITphs1mnxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0176f6c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:04:56 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 0/8] ci: add GitLab CI definition
Message-ID: <cover.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="85isz1NaNj02/yAr"
Content-Disposition: inline
In-Reply-To: <cover.1698305961.git.ps@pks.im>


--85isz1NaNj02/yAr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the 6th version of my patch series to introduce support for
GitLab CI into the Git project.

There's only a single change compared to v5 based on Chris' feedback,
namely to move around a `return 1`. The newly extracted helper function
`create_failed_test_artifacts()` indeed wasn't the correct place to put
this error code.

A test run of this pipeline can be found at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/pipelines/1066250852

Patrick Steinhardt (8):
  ci: reorder definitions for grouping functions
  ci: make grouping setup more generic
  ci: group installation of Docker dependencies
  ci: split out logic to set up failed test artifacts
  ci: unify setup of some environment variables
  ci: squelch warnings when testing with unusable Git repo
  ci: install test dependencies for linux-musl
  ci: add support for GitLab CI

 .gitlab-ci.yml                    |  53 +++++++++
 ci/install-docker-dependencies.sh |  23 +++-
 ci/lib.sh                         | 190 ++++++++++++++++++++++--------
 ci/print-test-failures.sh         |   6 +
 t/lib-httpd.sh                    |  17 ++-
 5 files changed, 234 insertions(+), 55 deletions(-)
 create mode 100644 .gitlab-ci.yml

Range-diff against v5:
1:  0ba396f2a33 =3D 1:  a1413b76422 ci: reorder definitions for grouping fu=
nctions
2:  821cfcd6125 =3D 2:  29039d7aa3a ci: make grouping setup more generic
3:  6e5bcf143c8 =3D 3:  414655ffb2d ci: group installation of Docker depend=
encies
4:  2182acf5bfc ! 4:  96d710faec8 ci: split out logic to set up failed test=
 artifacts
    @@ ci/lib.sh: handle_failed_tests () {
     +		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
     +		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_d=
ir"
     +	done
    -+	return 1
     +}
     +
      # GitHub Action doesn't set TERM, which is required by tput
    @@ ci/lib.sh: then
     -			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
     -			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_=
dir"
     -		done
    --		return 1
     +		create_failed_test_artifacts
    + 		return 1
      	}
     =20
    - 	cache_dir=3D"$HOME/none"
5:  6078aea246d =3D 5:  486d4bbf8b0 ci: unify setup of some environment var=
iables
6:  d69bde92f2f =3D 6:  534b14f0262 ci: squelch warnings when testing with =
unusable Git repo
7:  b911c005bae =3D 7:  a060613f039 ci: install test dependencies for linux=
-musl
8:  5784d03a6f1 ! 8:  c05ff28cc2c ci: add support for GitLab CI
    @@ ci/lib.sh: then
     +	DONT_SKIP_TAGS=3Dt
     +	handle_failed_tests () {
     +		create_failed_test_artifacts
    ++		return 1
     +	}
     +
     +	cache_dir=3D"$HOME/none"

base-commit: dadef801b365989099a9929e995589e455c51fed
--=20
2.42.0


--85isz1NaNj02/yAr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMksAACgkQVbJhu7ck
PpQCNBAAl+Jm7LL3nGGc8UQYQW3ggcPtl8GJCCz3gjulzWEsDFB/LLWmld5IepKo
KFSj7EOxYSrEMhLWRsuS1HNNvkh6QznC/MsKjE7rEcVo6z6R4le6q5dkQoG0tXWR
RlmM4kiEza5Kn6Al7EF29Vg+9eyBrlDNnGnb/EejfOGlWC6XECZvvTOyJqjDeS8z
7d2kPKBADB/j72a6q5H/5oQsHYhzXRCc/OgV1tzyQcaoKEES54T4rkUbAX1jzl8X
YwjgW6SojDZNkojd5L/vBSNhDdCkyEiUuoHAMzd44m2RuYB7o4Gj5S43sdBULHzN
VB4tDoqvA+q/O6CT4rKa5mJsmnznWB/oTDPFFXs3DyigPutR4fMDTc9471/ssyUy
9Gb/NOqXFUrBH4HYsnsxeDtWzQV1E2bWnXa4Ln9oHXdaTi6M31JrXI3xtUL26Yaz
0qJaWhEyK1JLpJasC9VtLxyDwCUTAiBNdk7f5d5G8j6iYFra1Jfz5wWY7Q1LWEgD
cdi9u4saPCUwkHGqThT7aht9Ne9DSbQJ67eIZx6MGUPqFzSkvYxl4Mn2LRpsRd09
GD8sx59jO+s4TDayItlHrorzYg4IqTsA00dFBqNvOS+duzeu1IE9Y4GYWDW24nZy
rfwGl8ekTLLAf/L+yKkQKHEEF5G3FQocr2dnB9Hjm6ORpEqIRQE=
=Jii5
-----END PGP SIGNATURE-----

--85isz1NaNj02/yAr--
