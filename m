Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB1A153BFC
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742353; cv=none; b=Q2VJWjUzsUtsJ7pqIQh1NzWqyPv5P49lliEh/v/pctRt/UcJ5LVtPHj9ew9ZGbUIt7z9kqrIlLO3/1W4+oZHSSBph29dOAvzfnaB+FMHWRnoooJyGO3p+5BKnXkXIUsR6tZv0VqvN52+ppoMoxBueYti7bdkucYoXNlyupXzCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742353; c=relaxed/simple;
	bh=i67vFad5Ot5Dj8ehshhU5dTGfqtU0+gzw2E0ZAb5Rks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsz4BcwDy/zUvP5a8OqJenVgfISpgZQynQMaMIYoLm3djpUKSaMhE1Tsyi7jTCZkgERUXm0xO7Wg4PV1CPHDOWSuFCP2KTHsJ5rQ1mPMtlmMIXxxKckG24XGfjEbAa2iUJRXcKfVeSA6IEtjRkMLk0+S1vXUkiGGmuOse4396no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L0Fn4OGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4S9/zYm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L0Fn4OGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4S9/zYm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4EC1A11401EA;
	Fri,  7 Jun 2024 02:39:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742351; x=1717828751; bh=2p27yCUu7T
	JgiwGnlrLZeFJDNAge3wNUQjHHxo54l54=; b=L0Fn4OGUnv45gNYovuJxb4Zvsm
	lZB4tDfbPEOFw0v8ftLDckFIdz596xrIzmzS/KyLHEiNQ75+WQNjAo4hphK3ggxS
	yH0B9DI1WlbSlyNpoa/+9IVGKe5hj7uuBs7F6yo+7COszF+sOa8DX9iCqcmdb7Gf
	WcsvA3+Ci76v+FH1YD2Fh5P2XlC/N8giHvj5VdqknKGpTEu5GZ/MAx/ReF+asMxL
	doZhn5nKQIrSO4pB6Xt//P/4lmiNPHVqQJgZ3NDm3my/Lx4wm45SVI70nyLrbNWt
	5Ko4RnaOq5pEi/HhQ7mgKO1nwZPe/mNKTcOaTr5YUN0GWXG4e3F8mAeVSNww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742351; x=1717828751; bh=2p27yCUu7TJgiwGnlrLZeFJDNAge
	3wNUQjHHxo54l54=; b=L4S9/zYm2xN98vt/CC1PWrOmfIb01bbSmHf5fFMvzgJJ
	a3BC/X5057ZW7vQPg3DauGfpmlcXjTkcw+kfdV9LJ5W1B9oUI186D4oZ+6v13m9g
	9w6WOhZBGqJ/l8nf7m4NN67HWK4FwJiWnsZ9lFlbJK4Vczy+qrI5dl3EAFmcJ0KL
	q/m1+kSM9J7HalVqqASctk8yn64IwG9n+SvgCMZc6jRzo4RSe6O3oeFsMRA7K4Yl
	Rgoi1x8wIpnD6FkLPhB2ZfhD3+3sMjUdlDlqTyFKuPR2Ip/bPzRNdyhiZ9998GBs
	m+5qqU+WLj+JfImermWo3cXTQvJTxyc2S4+r+NEC1g==
X-ME-Sender: <xms:D6tiZvKBqwVW3EZNlSLE_moIEoDJKWybujlHSWQcN99qqcbvNhwatg>
    <xme:D6tiZjLc02-tUO3SfrCdLXQOPBNyqZih02Lyl0ZJpPt1M_xpRegTUQpP4Zmmh_ZzV
    9DKVkcd6ncV2L7UVA>
X-ME-Received: <xmr:D6tiZnsFgkaFQivWsFGXTOj9TFSQG3je0k9kxjq3nNNfRNo6S6-s2qv4Lnx6rumhFt_MkFK5KVOLk67KMLj-KxJbgGJobk0Oe0DOm5xlcInFMloR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:D6tiZoZDkNLhhFGND9CMDo69_mK_YsJXfZHlPiBxJEseY5tHo9l4BA>
    <xmx:D6tiZmbo4vP99tcd5mDVmBiocdpEIA8sSqgk2hQs_po3kGVMpP8Hlw>
    <xmx:D6tiZsAzV-c4PHbXlF9xm-gxYd33lkExKbcehmrJaZZu_5PsFP5zeg>
    <xmx:D6tiZkYaPYBLG9jzsjeT_OmNAhyhNGhAMwETUAyJH42x1wvhvW1m-A>
    <xmx:D6tiZtVrQRaLK_OASg3dy8HprmwNGDDdWCyyONWaSqnNaMu3tABLhCt6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 13f85735 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:09 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 20/27] revision: always store allocated strings in output
 encoding
Message-ID: <03556233d6296973176a4edbcaffb12746cd2f1a.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVC8AYdCir31hKl6"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--iVC8AYdCir31hKl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_log_output_encoding` variable can be set via the `--encoding=3D`
option. When doing so, we conditionally either assign it to the passed
value, or if the value is "none" we assign it the empty string.
Depending on which of the both code paths we pick though, the variable
may end up being assigned either an allocated string or a string
constant.

This is somewhat risky and may easily lead to bugs when a different code
path may want to reassign a new value to it, freeing the previous value.
We already to this when parsing the "i18n.logoutputencoding" config in
`git_default_i18n_config()`. But because the config is typically parsed
before we parse command line options this has been fine so far.

Regardless of that, safeguard the code such that the variable always
contains an allocated string. While at it, also free the old value in
case there was any to plug a potential memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c             | 3 ++-
 t/t3900-i18n-commit.sh | 1 +
 t/t3901-i18n-patch.sh  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7ddf0f151a..2ee6886078 100644
--- a/revision.c
+++ b/revision.c
@@ -2650,10 +2650,11 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match =3D 1;
 	} else if ((argcount =3D parse_long_opt("encoding", argv, &optarg))) {
+		free(git_log_output_encoding);
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding =3D xstrdup(optarg);
 		else
-			git_log_output_encoding =3D "";
+			git_log_output_encoding =3D xstrdup("");
 		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^=3D 1;
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index f27d09cfd9..db7b403bc1 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'commit and log output encodings'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_with () {
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4b37f78829..5f0b9afc3f 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,6 +8,7 @@ test_description=3D'i18n settings and format-patch | am pip=
e'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check_encoding () {
--=20
2.45.2.436.gcd77e87115.dirty


--iVC8AYdCir31hKl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqwoACgkQVbJhu7ck
PpSz0g/+Lvr8zBVnl0yuM//TgSiYoRMzRcBEoogoMQJL8TycuDripk2pwjxnNGY+
9liDfabY3ctOxlgeRKUQsg1sNxVa+LJ0W6mlbSd8yrTSHEgI3TRrBuBIwzDtK+t3
RvzGltCnlTIGYzuH5kB2RhHDj1gU1Hb+slDpUAVMwPiJjZwR5oa9w7V2kgNexqj1
LwEoxM/52iT9mjL4Cp3HEL/iSuwiwS/r90FjteQKdQhCTK3mcsEpZOED+A7W00OV
6gzNaEs94lI46JgqDsNtTEE+o5VSa/JAHva+ptGpHkfK6N5UREfDlYSTSJJHwgHZ
Ksjk2HFj/unKz5m+W/TOM0YV8EoWkPZQfT8XXPqSYvSUfXmVgAIa1221gxkixWz2
CDY1wa/vLaX3FZVy2IAadzfP4wHMrAYZ6dkRws/IPYv1j+WWkfKsybVE7vcVOYuo
xR8Y2BNdx7Y3Vmbws2LgLDYLkIuvHTQgs3UIa2UAFY9mOGRZRfBVbh7rnY7gyGwf
xT/sVaOLiy0312oecpBNfY9q2qg6NY1QKGwYlnYj4BBinZ3djTsSPkJnmrZcb9L2
MeIRm3HIlUxrHHN4LddAryksv42UkK7fc4uxjk8t4xtzS4laBWVsKPyKR+XhMk79
K+d5cTcTX2guA2S/Li9f4SZ4rnwO1O+2/rug3kdqfR54/2yBgOU=
=Ol7Z
-----END PGP SIGNATURE-----

--iVC8AYdCir31hKl6--
