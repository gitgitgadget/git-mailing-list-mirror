Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57EBE76
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w96ZwXGY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJlCe+u/"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E9485C0175;
	Fri, 29 Dec 2023 02:27:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 29 Dec 2023 02:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834823; x=1703921223; bh=jxVJ9rOYWm
	lnKgLPm14xSPG0U3p9OJSta0ABiogYLY8=; b=w96ZwXGYqklSXhA8glH6nUJpcD
	mpoBoXc33hj92/epnnJGsh8WDrb/Srl7o6u+lhy4xLZMGhivBL4O4tz4K2At/F03
	Mg1knlPW18Or65U0OV/tv7z+6tGncbIjlUuuiNkHh5cJoyk5yKyXIx0J8OU1BmGX
	NYWu+F/oeV7sM7lpPNcX3C/tGsWQMIgEtyRNbpWfwGc61No6vAyx3+ulEaPTS235
	izWXIO+I0R/NenGp7SDRdoSPYvKF7p9UCD2VqjrQAheqYGZ6dkCHA2Zbbbzgfzs6
	lcKn50vekho36IDx4G8A4nE8Y7qtlnb+fM3iC7XyhW/s7tUllz0MikDDypvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834823; x=1703921223; bh=jxVJ9rOYWmlnKgLPm14xSPG0U3p9
	OJSta0ABiogYLY8=; b=NJlCe+u/6HozPO7ic4SwLVFm5joRZV7CW3385yaiPNC2
	FZd210dg1aRYCZuMmvs088tHkffnztdAfQm8ARwyjjJbGSKRL/qQjCuqYZv6WGzS
	ssqxMdpWo+5D3evj00Z+qd0FjB3KC/cZS4oMdXYSp1zsx+yEfAtNklPE0L9bbbTG
	kswIKIpNKVVz34Ar4092TmJ64DzegTJ2mBvKdnStdvHFtTBpsiq3qyPPXOyyA7Fg
	F01knbeYLggC3+QjVhmPhfExjjabgbHMVfj2vfIpl30j1ALsLpUSUN+8meaXhBGz
	1nhAYvyOMGzZBHlqaV+KDppcOqWHCE90DMgZ8dRvtQ==
X-ME-Sender: <xms:x3SOZcR1OkQT9Nv9qOY65DxutCNY4i4zP6MzPcgQOHfYD5ErZCHifA>
    <xme:x3SOZZxYWGOJzCTVFDqoXVgUIyTHbKlPPXCVWqt9H76xEb84Fj5vVkX2IZDF1C9-v
    GeVIww_GDxyd0cT-A>
X-ME-Received: <xmr:x3SOZZ06apsaMMQ4Q6dp71q0Msae9BdHWXoEoHdRvC9P3U38MFN8e6Ze3mYQ8VVhIbwUI_aXYeK7GbT82gJc6iEruXZkfEq2EIU9pWrYkyVJ4Zpc9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:x3SOZQBvgxAVxV15Tibo16O5FDHuaMwqXP--2fYQqgYyuzryfVbfzg>
    <xmx:x3SOZVgH9K24dCEYDl2KmrXVOD2q-TYiA35UukEcnqJ2VU7Jxg9voQ>
    <xmx:x3SOZcrMhuXQvWGHX7uBC1hDxtrHEvWQxNqtNTt5umqPCmSN57Af5A>
    <xmx:x3SOZYunh3EYtbzm_1gNgFkiZHp3KMO5d51sNwLiFMIGsJ0ngQCJAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:27:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5100359 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:46 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:27:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 09/12] builtin/rev-parse: introduce `--show-ref-format`
 flag
Message-ID: <4ee3c9a2d169e5a8fa657531919f9b2833f2a1ac.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xvkk06tnpzQptvQn"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--Xvkk06tnpzQptvQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new `--show-ref-format` to git-rev-parse(1) that causes it
to print the ref format used by a repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-rev-parse.txt |  3 +++
 builtin/rev-parse.c             |  4 ++++
 t/t1500-rev-parse.sh            | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.=
txt
index 912fab9f5e..546faf9017 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -307,6 +307,9 @@ The following options are unaffected by `--path-format`:
 	input, multiple algorithms may be printed, space-separated.
 	If not specified, the default is "storage".
=20
+--show-ref-format::
+	Show the reference storage format used for the repository.
+
=20
 Other Options
 ~~~~~~~~~~~~~
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 917f122440..d08987646a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1062,6 +1062,10 @@ int cmd_rev_parse(int argc, const char **argv, const=
 char *prefix)
 				puts(the_hash_algo->name);
 				continue;
 			}
+			if (!strcmp(arg, "--show-ref-format")) {
+				puts(ref_storage_format_to_name(the_repository->ref_storage_format));
+				continue;
+			}
 			if (!strcmp(arg, "--end-of-options")) {
 				seen_end_of_options =3D 1;
 				if (filter & (DO_FLAGS | DO_REVS))
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 3f9e7f62e4..a669e592f1 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -208,6 +208,23 @@ test_expect_success 'rev-parse --show-object-format in=
 repo' '
 	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
 '
=20
+test_expect_success 'rev-parse --show-ref-format' '
+	test_detect_ref_format >expect &&
+	git rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-parse --show-ref-format with invalid storage' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config extensions.refstorage broken &&
+		test_must_fail git rev-parse --show-ref-format 2>err &&
+		grep "error: invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}bro=
ken${SQ}" err
+	)
+'
+
 test_expect_success '--show-toplevel from subdir of working tree' '
 	pwd >expect &&
 	git -C sub/dir rev-parse --show-toplevel >actual &&
--=20
2.43.GIT


--Xvkk06tnpzQptvQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdMMACgkQVbJhu7ck
PpS5KQ//QTLQ41ot05Vc/RMIlJOqVZA4mJUpG014FJbMWL+I5SUlxp+OzIxgG3D/
I5uuzfCKLn6wShYPqWoUWrqOA9ZAMfnouMymj083QAdmdyVsAwkqVm+rze5ALnik
2CK5/xadKpT3uYbRoWPH4R5vjGhk2fwDX+MBCfV4M9pd4lSEDKqxP3qupI3eqfOv
2LgixkfBPm8y20UHw+zWofVlZJlhGUmsMXAix4o6LNXPFespaZGeWcUTXJQxA1kq
ppfV3QlgaZTCZeTl9Z5wgBt8qlXIIrVrXPv3Iek/fAf84vu6jY5n3QnmHe8CzLIG
0FOwAQPYTQ4o365LF4xglWzya28ZQQh3yfmEewhMxoMRBrfklsYjMrsgUfVhXBAW
EDdiJ5fVPd/mkGME1TlHtedqTeKot5iJeUozoeL4/5sB2+6wqThl8JszDeYyb95K
C43XtMJtvUbhAJfTYQ+dWLOxINa92FRy40qLZNdoCz15s6kQnCggaGu4IegFC/yh
OGY8wT/QkjuOpUSvN4tLF+ThRCFULWJXPreI3MhFXasMF5AMkq4i8xzjy/J8Oy5m
xy9Hx9KFJuUoQRlAUZOSuYxx5pAKEP1xmewe3I/8ZNDCFAPKaR6dFsERSMQUQCi1
d2WW1cqreKZOWNeLTiPlyozJ6uSMiD03/zCovICVxL1Am2rA3uo=
=hZyC
-----END PGP SIGNATURE-----

--Xvkk06tnpzQptvQn--
