Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4D2C873
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Naop6MoG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UfIhjkej"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75815DC
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:05:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C5CC93200A26;
	Tue, 24 Oct 2023 10:05:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 24 Oct 2023 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156326; x=1698242726; bh=Ln
	Rlj6rvSYEp3PwNsfIS+5SxkhOMpdMHWtika5DL1rc=; b=Naop6MoG6pF817RgFI
	DSCybvBJy0HLPmRa/NLMnT3GLCpObD5XxfZVqFWUTpeQBw4n+kqvrCAHfUqeQKPd
	D+Ga2Vd321U8AVq4dFnwyyinuu1bI3quAclejUgv6L/J3aqUlV+NMRgTU0+BXNPu
	ngy+u2wdrItvbRivQG/i3GR1KzEixhFqLn10gyYQg0OZpbocSuUOGv+MX9taZuHN
	PeWWyYqIUiwJ4suXvC2RTU+EmXYzGKqLxh5bBDjw5oGP9mpWL5hMmp+pHiQbd3wP
	I7CgGXyKqqcrCd6iLeanB9P3rOq90KjuA2+SCHyzzy7ZM+/D5RlWVhLGO92ZB+u3
	fFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156326; x=1698242726; bh=LnRlj6rvSYEp3
	PwNsfIS+5SxkhOMpdMHWtika5DL1rc=; b=UfIhjkejHmDLmuaF4abDxI4i2rVM9
	7vP7cuUH4j6uzlapQsM0CJLDCq08tNBnEpUMU0xjwqotfs9JOMBpTAXmj/mupH7q
	ySWILmX4uPPLUKbkgmgpjuNWvxIEjrPkCT1we0xV5TFKIZPGT5Ox7CGGNKlZS0Vm
	qYYn8GT11bOBHGZlXJABbSTZcDPGr0z+h99n89o0cEyFotFaXUKCsS2RxR1n+QD6
	eof0xpQiFBjQgC42jPW0t3JklRRuzwaJOVX4w7MLN+QlQrRjOmMyUAC4B/04xcoN
	e8sVS0sIjbvmfR4xfxf5oYUUgne/bQ1X2vw2+qD4gZcaOR4dKqCO/Klbg==
X-ME-Sender: <xms:Jc83ZYK_GYt-2iCuR0ot8biI6sIj-4wxit5PBeWZioscNPRR0qclEA>
    <xme:Jc83ZYJy0-v26JI2ZRtY6m19at058W_taTE5dETIukM0Lm3X6QwFNUAV_LXnns6YT
    blkCK2vEjio1lFhNw>
X-ME-Received: <xmr:Jc83ZYvlIKXohLFvn8witt0kgF8ZY6gn5OI6pvqx-Yb3wgGYmzPzJkDfey3T6uaZRfAV9WiYzIXoYX8L9hAHUNGWegvpx8lus2KZYoxUhUBSFdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Js83ZVYKREj05Hz2PTPHN5FBZssTVTtNuufc67FSbRXVJSJa-Ya7nA>
    <xmx:Js83ZfZuzT1ac2ZJ0aBCtHK0IZ-obKfwotAqAEjGoKhygOMsW9tjqg>
    <xmx:Js83ZRDf1wF3fYZ_c0fAjCrY37iQAow-s4udpuktOWsdm_mkK1zeIg>
    <xmx:Js83ZbEWV2OmKVRi5ZzK-jYPo_1N15TkNKhg5LFp2D3WyYtyn_QrRg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:05:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf549bdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:05:20 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:05:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/9] t7900: assert the absence of refs via
 git-for-each-ref(1)
Message-ID: <a1bdea523971f600032eed82e29368fb6bc1754b.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cK6rL+FpnCl9lIOB"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--cK6rL+FpnCl9lIOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're asserting that a prefetch of remotes via git-maintenance(1)
doesn't write any references in refs/remotes by validating that the
directory ".git/refs/remotes" is missing. This is quite roundabout: we
don't care about the directory existing, we care about the references
not existing, and the way these are stored is on the behest of the
reference database.

Convert the test to instead check via git-for-each-ref(1) whether any
remote reference exist.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e56f5980dc4..cefecee732f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -157,7 +157,8 @@ test_expect_success 'prefetch multiple remotes' '
 	fetchargs=3D"--prefetch --prune --no-tags --no-write-fetch-head --recurse=
-submodules=3Dno --quiet" &&
 	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
 	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
-	test_path_is_missing .git/refs/remotes &&
+	git for-each-ref refs/remotes >actual &&
+	test_must_be_empty actual &&
 	git log prefetch/remotes/remote1/one &&
 	git log prefetch/remotes/remote2/two &&
 	git fetch --all &&
--=20
2.42.0


--cK6rL+FpnCl9lIOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zyIACgkQVbJhu7ck
PpTWaw/+MUZ3caDaJ/y2/5+ltyxOgkDcK+D3FAvV4gaUNkhmlYYZJCeB9J68HV95
EzES9iES2yvGqQtWv1jZ9TOPQB4yBTJLWLQN5fjpQ1APdfhnVGeD0Q1yFXHNPGSO
nDRAdaJJptMGZwpg2QDOeeRirTYCzyhVLn7Z/TgMTIAI12oqb71qbwMBtDJMVfTC
TvLvmqbPbAN5PWcRdxXghkTA7d5w47xce4coHaMCDbOr7BSrB/z4FBr77/FGfH+p
Yy5bAB2GzJQrqnt/GwXXYPYykPtozro0VAxG7dm25KDYhsNvm2kvJb28aZb99T/V
7EfZkL3Fc5quXmSDTuMNnNfJLs6JgJMaZLrOs2lHGr13iySDz4njB29F3jxKq63A
qYv73LQLLFQ9Gc+al83NnBIqNknInocHweO52PwLeGM0NnrPWaxwXaSx5El5ti2r
kIGV3Y464ntLo8QyT7yuchpPiRkripEJjEzeSrwe1q4KBElW8RnG/2rt3VEO2r0s
HtCDXYf4khbS9/6GW6npYK+F70CiqeUPbdcyO6eYHJNnKJVXJSqVilq5WtMRoAxg
PV+B+fbjXkkzvd8FGpnygTdBlzbAgLblPLVipmPL8Nt5jryDA5OgJw+kAGYOqNy9
rgr1q6jGRDOorpQ/1EcKl17RahuDkO0cllxxGZ4sa4vfv/dACpA=
=Cs/7
-----END PGP SIGNATURE-----

--cK6rL+FpnCl9lIOB--
