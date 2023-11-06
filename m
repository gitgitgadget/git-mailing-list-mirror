Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81597182AA
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nu8MwDx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="svev3Sk5"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C3A4
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:46:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C958E5C0208
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:46:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 Nov 2023 05:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699267563; x=1699353963; bh=l4
	9SZDc6uvvIwK0RjpZzbiQ+vCSJgnnDzx+ZQ7IcxzM=; b=Nu8MwDx4ne7CXk8Khx
	35gAgtOoufi88EfnIGTtZX/f4Z47caWA4k1Wd83cEx3r4SJ3n5r/vZ8dVH8AyQBF
	I9e+LnSVrufeWTazN24n1wWIe6vN/yhuGumfhWm5xOuQknuAd4mNH1nk6ExSMDbS
	ebVZIE5nULX3PfdKbNvbLJ091APinY2d1lD3Y2HAI2EvNkTple+hgYLn3hZfKsgP
	UzpKPf/w4xZRRZPjbM3kIWwuOeZOw5TzrrFdyHBlodI6pd+2uby/bIEsD32+Vflr
	72y0lKNkeTU9SRTpb6RkqiA3B0xLBefMXij1BAAPQwL2jxCAstEoroHxlX7Y5ZYp
	gU5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699267563; x=1699353963; bh=l49SZDc6uvvIw
	K0RjpZzbiQ+vCSJgnnDzx+ZQ7IcxzM=; b=svev3Sk5I2demM38h2csqe7V9jabK
	LsfI965gqcob0ydenv6BLJCUgm8zzvj50SlYayVNvTwayduRh+JmjSkQXHwgblDc
	f29jOdP/MD6g+zFaHjLXGZ7ZPZGU0BjxLcw2MG7HpuUOg2hRgGBYD60WDL0hAD1j
	cmA8SvVt1hA5jtIZBnkaRSiVaLvspnFmVKtlFFuwjaBQfgpLlIG/a4OU/meNSJVj
	jO4m/F8EgALfTf/2QRSDjYuPjNR682Agcm/TsGTW3ddz21kU5WjAVwk6H+Jty2uY
	4uhGWb6FBsfcEsuiyUKggRzAOG/fKq1Ho7y/qNmwJRe3V1z8fsmYQUxng==
X-ME-Sender: <xms:68NIZSVgEFwYFNqgTGgZqnvPyJFSxof0SBE_FR8PvwTG6G7j4VC_PQ>
    <xme:68NIZelJbOnfwHfWjL9OY6yem7mPCqS88y64OMFJBsIS0azPxEvrmRsZnMHWhSjtL
    Yd6ogpVnrPKuSnUlg>
X-ME-Received: <xmr:68NIZWYmr9VY-Nsa_4tBb7va_BREyNUm7cqgLUIQoj9fYm7DAvhwUxDEZCoMvaFh1K3ngGrKMq_N22ctyxkbyXXccbxhLhimVzR2mPeoelSo8ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepieejfefhtdegffdtffeugeegveegfeekje
    ehledvgfehkeffjeeltdekgeduieejnecuffhomhgrihhnpehunhhknhhofihnpggvgiht
    vghnshhiohhnshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:68NIZZVp_nbRkcUzcenqO1x31__fUMCAT5BMoIAA8mLY_KeFDkmgKQ>
    <xmx:68NIZcmWzgSbjCD4OeC5tYgXPDHBKZarTxfQfDNDRkplxdUaPTrKeA>
    <xmx:68NIZedloXfsJ5NvUad8zXr_M-gDAhJYtvVAv3IS0vg5GtVGECcAzQ>
    <xmx:68NIZeRwTi5WE-3gxrfpIjGM2J8bTLbNsbYtHpUD218BH0nkTBmthQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 6 Nov 2023 05:46:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7a78007 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 6 Nov 2023 10:45:42 +0000 (UTC)
Date: Mon, 6 Nov 2023 11:46:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/4] setup: refactor `upgrade_repository_format()` to have
 common exit
Message-ID: <44e133dc8d8e2b2e2172edff0847968bed9c3f27.1699267422.git.ps@pks.im>
References: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JD/2IULy5Q24fvUh"
Content-Disposition: inline
In-Reply-To: <cover.1699267422.git.ps@pks.im>


--JD/2IULy5Q24fvUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `upgrade_repository_format()` function has multiple exit paths,
which means that there is no common cleanup of acquired resources.
While this isn't much of a problem right now, we're about to fix a
memory leak that would require us to free the resource in every one of
those exit paths.

Refactor the code to have a common exit path so that the subsequent
memory leak fix becomes easier to implement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index 2e607632dbd..b9474b163a0 100644
--- a/setup.c
+++ b/setup.c
@@ -693,29 +693,38 @@ int upgrade_repository_format(int target_version)
 	struct strbuf err =3D STRBUF_INIT;
 	struct strbuf repo_version =3D STRBUF_INIT;
 	struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
+	int ret;
=20
 	strbuf_git_common_path(&sb, the_repository, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
=20
-	if (repo_fmt.version >=3D target_version)
-		return 0;
+	if (repo_fmt.version >=3D target_version) {
+		ret =3D 0;
+		goto out;
+	}
=20
 	if (verify_repository_format(&repo_fmt, &err) < 0) {
-		error("cannot upgrade repository format from %d to %d: %s",
-		      repo_fmt.version, target_version, err.buf);
-		strbuf_release(&err);
-		return -1;
+		ret =3D error("cannot upgrade repository format from %d to %d: %s",
+			    repo_fmt.version, target_version, err.buf);
+		goto out;
+	}
+	if (!repo_fmt.version && repo_fmt.unknown_extensions.nr) {
+		ret =3D error("cannot upgrade repository format: "
+			    "unknown extension %s",
+			    repo_fmt.unknown_extensions.items[0].string);
+		goto out;
 	}
-	if (!repo_fmt.version && repo_fmt.unknown_extensions.nr)
-		return error("cannot upgrade repository format: "
-			     "unknown extension %s",
-			     repo_fmt.unknown_extensions.items[0].string);
=20
 	strbuf_addf(&repo_version, "%d", target_version);
 	git_config_set("core.repositoryformatversion", repo_version.buf);
+
+	ret =3D 1;
+
+out:
 	strbuf_release(&repo_version);
-	return 1;
+	strbuf_release(&err);
+	return ret;
 }
=20
 static void init_repository_format(struct repository_format *format)
--=20
2.42.0


--JD/2IULy5Q24fvUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIw+gACgkQVbJhu7ck
PpQuuQ//Ra7e8vJIHSwdFpXuahTuXhhC///IllRG/UvKxT1nj2aa5smQ9jo3DMCj
A10kiCk5YdpNJ14xJwhR9r4r95eTjatDcYfCptq+N/OyZhx2V4dLapWwCkM7tbCC
Whs48iaDtraNZYjFGA+b6smlWzPxV7srcWESPCuAZdo0jegEc8lhvLhwofa+Dkx6
2rKrlJTDZzmwbEhJcgVbG7YIw2Zflo5v7tKnVARMDcf6S4Y+U4UH1kDG8ZFT8QxO
qPih5p3MTZjVHBBnXxKIyYDH5ZGyf1TMoGs1wGTyMh7uKRjb6+6O7g+r0Qj2HOsT
NIlVlTWfKxZJnTWdA8fOD/kyEmEjZStdvLTE09JgLydTzHQ/vrSweIZciXQi/FTn
ofoHIDBSdV+DvwFZ94oTygcyhDyL8E0KRGF+kc9uA9pjKMc2tdzBTIzaid44ZJGP
wxaimJGMWej75YKv+3+6e23MRYYDH5DcbNtiWCNrgJGL7/JVL6d+k4U4kMOoDD09
NI2F75iihjd+3to+ss79yJL9kkrNkzaP6cWT5pdf1hrYsVk6gfKNuTgFCkTg9gyF
Ly2pKM56ynbPOztFms/UahdI858AbIsuSZT4yCyVf48vcjjXflaybddNhSIsFMT0
AFzvhMuMr4v23DkNlhiyNL0wrNUhW+Yj6rwVOviZuZheuWCtCOw=
=HcKb
-----END PGP SIGNATURE-----

--JD/2IULy5Q24fvUh--
