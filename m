Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a6ayMmeQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBWkG4lc"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A2D2
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 03:32:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id B1CC63200A51;
	Tue, 12 Dec 2023 06:32:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Dec 2023 06:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1702380774; x=1702467174; bh=MX0yvtqIT1bWexskCJawFfjCMGGqqlns
	C89pP/qi0Rk=; b=a6ayMmeQVqxGjdfZyDo4B0vOq5rUkIMD4d96spDRyXO2hTXY
	FnIsTxnRaPRutG7TjOiJ0IqqGbYbLLW6i9aFPxo6190IfsMF13z2hu5x5j78VJHi
	pIRSQpSaVIVogz+2cq5NUczrDBxD8qsktYChBCTASwKXXFwnH7zvHqudIHZJUmFp
	+wfa14GTR3VCWPbX5eUmMI1NFPZWM9KQoPJsDANMW2gWeuHj+YHtgph7SNThr5ed
	bnl3/S1N8qfVaKi+4FThNHj8J0PFyRmieftXyEktgDsa7oHMxV1ecAmuf0OfY1kd
	WJWL//9rbtjnGGmsF4GZsD5gXkdjYpwww9of3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702380774; x=1702467174; bh=MX0yvtqIT1bWexskCJawFfjCMGGqqlnsC89
	pP/qi0Rk=; b=gBWkG4lczItvOEAqExgiy5SIZS4IIHoOeUJ8s/RVyA6AHhRTfOk
	6plpL4NQ64t12/jJelTzZqlESO8UR0tS+cZ49UWRYfXADzfWMx+skX1FcwkgVz3x
	37lmtdqf3LHo41HnRrVzynixIzMjTWFDZ7vs55E/EX4YU7Z6BOldnOXALhlp1ems
	xm8C93rS4+VUmE0r5H2yAj+Pm3NTuSgokwfH5GnB8E/HFcvKv/x59yOO4MAc9zv+
	Y33lCp+BJSqdd12xQ7Zc52B1Ya9jlORmHb9NRn5dBoPdhUth9HUTL72+Cy1ng04c
	XNHabIk8aVfUN1EWkNP3S/Q44lSE8P4iS1w==
X-ME-Sender: <xms:5UR4ZWoorBIMPYkDNFa7o7eG2FlwdmKPz8fFbiC0oFDU275f-qfGsw>
    <xme:5UR4ZUqNShWC39Ysi_8jxcmaEAJM0NNC1wJQmhzuh_7sNPfu3F7_CGG1SBfLm0pwI
    h1yrxGNRr4seRZ9Jw>
X-ME-Received: <xmr:5UR4ZbP8Rm-TG4-IUwMMHyiAx6_igimYNqbsb_3BMyl1bd-ojGqBaJe-3nBw5XeOEGFZf_F0JvxvI2R56mvXzHg4lpOZZ-7xpNjTcrfQ3BvvLlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuefguedtueeiheetleevgedujeekjeehleejjefhhffghfevgfekueekjedtieejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:5kR4ZV7WKZzgs9pNp5wbNIZAsAeG8JoY8xsPAGOj_y7RIr1mr8mAHQ>
    <xmx:5kR4ZV5-VHM3DxMesBDA3xjt7HJtcx5KhydDLkxXJGt1AIA-6ssieQ>
    <xmx:5kR4ZVjeEIhhNhWlc4rR-V-6zC4fmp1xepZNdNNoRq4Vt7vG-C6FgA>
    <xmx:5kR4ZSjdRUrYX4czcHiY-gdHq7yIAhK9jq5qLS4Acp8Q5tavd3OYJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 06:32:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 51f03c78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 11:31:13 +0000 (UTC)
Date: Tue, 12 Dec 2023 12:32:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] tests: prefer host Git to verify chainlint self-checks
Message-ID: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IY/H6ALst8T78ZDF"
Content-Disposition: inline


--IY/H6ALst8T78ZDF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "check-chainlint" target runs automatically when running tests and
performs self-checks to verify that the chainlinter itself produces the
expected output. Originally, the chainlinter was implemented via sed,
but the infrastructure has been rewritten in fb41727b7e (t: retire
unused chainlint.sed, 2022-09-01) to use a Perl script instead.

The rewrite caused some slight whitespace changes in the output that are
ultimately not of much importance. In order to be able to assert that
the actual chainlinter errors match our expectations we thus have to
ignore whitespace characters when diffing them. As the `-w` flag is not
in POSIX we try to use `git diff -w --no-index` before we fall back to
`diff -w -u`.

To accomodate for cases where the host system has no Git installation we
use the locally-compiled version of Git. This can result in problems
though when the Git project's repository is using extensions that the
locally-compiled version of Git doesn't understand. It will refuse to
run and thus cause the checks to fail.

Fix this issue by prefering the host's Git resolved via PATH. If it
doesn't exist, then we fall back to the locally-compiled Git version and
diff as before.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've started to dogfood the reftable backend on my local machine and
have converted many repositories to use the reftable backend. This
surfaced the described issue because the repository now sets up the
"extensions.refStorage" extension, and thus "check-chainlint" fails
depending on which versions of Git I'm trying to compile and test.

 t/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..8b7f7aceaa 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -111,7 +111,9 @@ check-chainlint:
 	if test -f ../GIT-BUILD-OPTIONS; then \
 		. ../GIT-BUILD-OPTIONS; \
 	fi && \
-	if test -x ../git$$X; then \
+	if command -v git >/dev/null 2>&1; then \
+		DIFFW=3D"git --no-pager diff -w --no-index"; \
+	elif test -x ../git$$X; then \
 		DIFFW=3D"../git$$X --no-pager diff -w --no-index"; \
 	else \
 		DIFFW=3D"diff -w -u"; \
--=20
2.43.GIT


--IY/H6ALst8T78ZDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4ROEACgkQVbJhu7ck
PpRZpA/6A8WUpzopuCeVWK3ySMbAAoCjN3CqI5Bdd5Kg08qFWN7EXCr6aHM3+M+F
M2BdkK+ZgwrWtrf49DLBS8XmBEDWBlRTSaLSyQ/QlSH6agLZwVyoBUdtlFY24xDn
DrCW/QOnzo/ZOAUL8yMAKjZQK0aO7zOPdfXIx9Xgg6HEuYHjYrhlKmFldBNpKJOw
9oUjPXiEReBQ7+hUQczrvfqDtFRM8zBVd6SUog2Cg+dyA8neEJt5Hah438/hkQAA
xNcNEVswhCXpHI6EIOUZbiPV3ZmYpuIJlmCdVdWF72EqYqbJyysLDdai88TWCw4f
sLHamU3bn4RgV++uOvViQHhZjGy2NcvKlVJxG7MFUOOBJVPlWhJnJPNgAcLaysRK
pH21++SEuTxproWeGPWe5a6ygKvjern0cA0zKxFjheFoL0ybWGoQyWMOqVRvzI0W
akJhDuN2vaHsDeAKT+Dg8NVJ+3ckbJmyGC2SLFbeyCcCxzGnJFBAyWBs43o/rvPZ
K+9N+apd36NQ8Dk57D8ocese0jsHt57A2djsqHAnumQruHyRU3+/6/oJk87X6Vqy
5NszozvWP1z9cyCq377YYU9PZfyaq5G0dz/oOh6rZ5Uk4xH2bHOs5O30S2vezJKC
ssAoi55eboyzurTNsp00aiP1vQAbnHMsNl24QV42cWTmW59QEzY=
=IIWb
-----END PGP SIGNATURE-----

--IY/H6ALst8T78ZDF--
