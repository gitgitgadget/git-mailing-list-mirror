Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993DD2F3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R/ZIQGYm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmpKfhJN"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA752139
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 02:53:33 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A61E25C02EA;
	Thu,  9 Nov 2023 05:53:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 Nov 2023 05:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1699527211; x=1699613611; bh=Q6nJHhmytuRJ3CY3Sfb9XehBu
	KzaD/FZS58lCww7sg4=; b=R/ZIQGYmQM2iXE4eBTjlNh6kitSr2I0ThttSc/PaL
	X2Z7ITKECoYc1Xl5Giun+5o565CAxSMx5WEt3B6qza2ly8SybDMbU10avQsekXmo
	sLboe+k96LXsRU2KxORgkEOAmTHDzHddiC0p5BfW/0N86FydTqbVqajxv8joIyP/
	a7P+x4pdHG+UHMvy2ncVBFSl4nS8SdfAOjvPp3MlT/rjoDbICd3H75bIdhHhZnFh
	It6C+SHGAeFhcKtt/eD1De3qSo3fu/0eCUroKL5ZGTKHGoJQFz2Rf0jJh9+RVWJp
	dEzpeekjGnDJuwbkzQHzyy/6qOMtsq8F3ZaqLUF3V66Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1699527211; x=1699613611; bh=Q6nJHhmytuRJ3CY3Sfb9XehBuKzaD/FZS58
	lCww7sg4=; b=qmpKfhJNOJ/8y/Se8NiPSuFRtNgB432LgZkv5t4tLF+M4qIRtA7
	2CzAGuHZfkRSiECMJWHqdF1OMOixderS0vgAFpAUQMzgUaKjqUOEFqHX7TRtwQEE
	F6LeAEC7rv+Jj8FwnWsVQd+NlZPVK3uNrVBeB7YmAP7xQqUB5FVG3oqhwHEOckbL
	pHlo6SI6Sloehnk22ZIuO0Ma6NqVXnbBNZDAAK15VynhLpHq1wSLRK71ne+dl6+X
	WQeGJqFj6D0LOdnaAYB5qJA5REnesofz8B2miewkwqJ9hsl98uCqxGPi/eCJQrXr
	6aJmbz1PLlYbsoqhoFUgyRPtyzonnTVR/3g==
X-ME-Sender: <xms:K7pMZa1p8_5O1u02jaXxsLibscBehXI5U_xfs8qHqUkuEzOlBDyi1w>
    <xme:K7pMZdGIB_habuQ11fXegZJ7qGyj66LmImYJ6ohSM3uewTFmUyVvMzaoZ4s6JiQrD
    j7Dvt54gfRWtve7VQ>
X-ME-Received: <xmr:K7pMZS5fLbbfk387l3ASGw6k2FE4k3sPnOyKENzsW7pG18TvPw1MTivkc8dylCp74eIvN5-wrWbX_cYM4Cz2FMOHat_yn8l5T498d8FuvvDP0741>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:K7pMZb1GIDx0klc4-GvluW9cU1xYLfTd0FrRDCcYdNqLDjNt3dhDdA>
    <xmx:K7pMZdGwy_GfBSFWS8-8VTL3-1cXTqp4XYi_ImNtxbC8hJYGWugouQ>
    <xmx:K7pMZU-rKLSjqJRVBnEtdI_kenIatmL_ZCMrDM0aIfH4zMzFH48nGg>
    <xmx:K7pMZbOMwIM_weTkPfgMizPG0T08nOvlCaWAy5bwDJQUQ_BMzuY5kA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 05:53:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a6308ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 10:53:01 +0000 (UTC)
Date: Thu, 9 Nov 2023 11:53:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] Replace use of `test <expr> -o/a <expr>`
Message-ID: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p+Vtng1TKNqcgFFE"
Content-Disposition: inline


--p+Vtng1TKNqcgFFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series replaces all uses of `test <expr> -o/a <expr>` that I
was able to find in our codebase. This is in accordance to our coding
guidelines:

 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead, because
   the use of "-a/-o" is often error-prone.  E.g.

     test -n "$x" -a "$a" =3D "$b"

   is buggy and breaks when $x is "=3D", but

     test -n "$x" && test "$a" =3D "$b"

   does not have such a problem.

This patch series is a result of the discussion at [1].

Patrick

[1]: <20231109073250.GA2698227@coredump.intra.peff.net>

Patrick Steinhardt (4):
  global: convert trivial usages of `test <expr> -a/-o <expr>`
  contrib/subtree: stop using `-o` to test for number of args
  contrib/subtree: convert subtree type check to use case statement
  Makefile: stop using `test -o` when unlinking duplicate executables

 GIT-VERSION-GEN                |  2 +-
 Makefile                       |  2 +-
 configure.ac                   |  2 +-
 contrib/subtree/git-subtree.sh | 34 +++++++++++++++++++++++-----------
 t/perf/perf-lib.sh             |  2 +-
 t/perf/run                     |  9 +++++----
 t/valgrind/valgrind.sh         |  2 +-
 7 files changed, 33 insertions(+), 20 deletions(-)

--=20
2.42.0


--p+Vtng1TKNqcgFFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMuiYACgkQVbJhu7ck
PpQP7A//asLPkNMMhx7dU3Tg8U0QmABzIc+cl8WZXzsoS3IFVZfeH0o5S6iIyq76
rwK+ncSADBwiol4SHc1pYl43Nt8QQURC2yziG4Q2EwOQeKxiaB28DCB+QheQYQra
TRNCDpLMATo4MP94e6ejiYSL9GFI7FdyQpjkhNc4thx0V/T4RaujrA9+vgSI453b
D8te1G6h1MSckEpLdrc7P5V4or5sOnJ4ivzSl9B61vOJw9O4d75lGBxr5LIiOr7x
7EUncHQhAhkRXHxu7rzcE6YnIDXZdmmBW98yhUMNp91FpRWJCLHZPOmP2KKXLTkC
zEPBt/J+mTHnpWiKfSsMDGjk7i0jVRSdfGlR/mzGLxY2LSwi30h/vf/uyAk9RH44
Io19LYu1BZSIBuIiGsUUux5ehPjviSur2z4c7NlC4/csq5C4hWoCihlXQ83hKBGw
+RNLw55ce31+yoEADXtjKAWI66cHAS61sUy/UTcot+9HXPmDdPAk7Ksc7nRLw28l
N7fVUCXAXRbVGIdt5UFFpMYieWYzoC8zLSAgTIClH59+Po9FyQnZJam/UERMnRO2
+GWd/aOkxPKe1zpgLHqG1ShPlWaIbsPK59qdnlo4/P8JywgQlXTvKftCmRKFukjv
1nhy3lZiH0MVFusU0qNa8rLkuINTa99Gu0fGTkHuxTr37P+glio=
=Uq9F
-----END PGP SIGNATURE-----

--p+Vtng1TKNqcgFFE--
