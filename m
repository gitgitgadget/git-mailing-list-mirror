Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730E79D0
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jrTmD8OJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tOfAse1N"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CC61F5C0080;
	Thu, 28 Dec 2023 04:58:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 04:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757484; x=1703843884; bh=d4izZi5NOY
	KXFAiBduv6X11yySSt1mVu9NYNcUEqMX8=; b=jrTmD8OJIDQ6lHMjzB/3TtwSpH
	TXPtFrSDt67Oqbv0HxDe1jENqmppinHIyH6P18ZRKguYY4iiYZj8AbnkwYcR+9dm
	PNorrS72ySs/7QjpNKdmizbsz/3DK9qPjr1GsREhqXm8AUqqbUXJ78YLM67y+vmx
	WSxyKtl+XsHgN4vA23wGcj+/tcrSLsB1m+McMfCYq+nqa9QHnlST505GWrfAQ1xy
	MZ5FEF3qXPFmYCbT9TQuIglB0MrTK0ACCFsDTQiMm7pkMUEccrQqDmFBLaM8p715
	NfZfK+2M4eRoJ8U7ifpTvX72hxVeW+yJ357y24cJ2CS1LXVeoVcsrhUSfXyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757484; x=1703843884; bh=d4izZi5NOYKXFAiBduv6X11yySSt
	1mVu9NYNcUEqMX8=; b=tOfAse1Ny8eDr/iOCOZS9MOEH3WCx1vFfjRP81ssaepQ
	n3Dqcwu6Q/SFCVZCvWzPt4k1vQ3iRcSnuNkh/ZPQep35j4zQ8AW1R/Z+iEYUul4Q
	ahIVQQDDBIGNVWnPp4REuyjy3gyXpgnRG1FDBRulkPgI1ks6pDBDWIyPrCprYGv9
	0t2d+JCW5pF4Wg88iFCef9cRDnwxxyYN1LPV9cj5KmsXpZZlmFOYK5XBkEnR5nQR
	gaU9EaYz9do5++JzwSJi2BCpCBp5jWcZDG95LZQs4UrA31HmHPAI0MerB7CKXUag
	isLCJNMHaRoWya1OZZ3tgyAY9vbnoYVSIpS7nruecQ==
X-ME-Sender: <xms:rEaNZe4xEBGKFpiSGXReKnYNBbjnndLUw-oKSSMxlvrQwAIlPTwIVw>
    <xme:rEaNZX4yH4RPK3axnS93FEwVLD8RmCu_PM4TLTUgHYljt7tG4ctOaMJUt433EFocR
    6t6BK5Yl-GUhDkegA>
X-ME-Received: <xmr:rEaNZdcLLhC3teP3wfnkisiEOgf-AFZwupD9EXWSqNbvxrtVzKqmm_c7J4cYYblWlJMEfSYCp2SyAa_usopxvqA1iT9wfV-TryJq7VJr_HfyAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rEaNZbKgVeP9ncdIHxiFKc5GwsUFnoeVASYkBMyQkLzaBGDG_ElvEQ>
    <xmx:rEaNZSIcMXalQLVW3iZpjGksc9S_Ft5sI29ARdI1rE0ap9znqRHOpg>
    <xmx:rEaNZcwibl6z92lBxBhhm0wkxj0cSwsJ2lxRgG_qnjLUChSqmayF3g>
    <xmx:rEaNZUhQ6V9-6R7WGCmqDHnquaU4pF0uL04XoWb-iYFzqa2dbhJrVA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 04:58:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c6ec3dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 09:55:50 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:58:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/12] builtin/rev-parse: introduce `--show-ref-format`
 flag
Message-ID: <761d647770845320682e3a89fe1a92cb3bd96cc9.1703753910.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703753910.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A7ZGdrJWJ7g7chgL"
Content-Disposition: inline
In-Reply-To: <cover.1703753910.git.ps@pks.im>


--A7ZGdrJWJ7g7chgL
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


--A7ZGdrJWJ7g7chgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRqkACgkQVbJhu7ck
PpR9MQ/+Lt3GKPAaZnQTFyu8SF+UvTE7wGP5SEQ1udHKHU+NHmnKsWPGh86QQbgr
OWGkSrhJFZzgCoBwlue+QpogSRDzYivXLoqg6yUa/nGb3mr3HPlYsajQvZhQGjZ6
zSaRoHgmcjOMj/vP0FdXBvUq/cUO3YOrrLWKHPjcTkjKyfM9jyKT2br0UxGMp3O2
3tlx+cdZiQhbJXT8m4bf+8Wdbz1vW6oAfnR/v+xUF9t1CSkqfu9BR/Zvt8CuEatR
0fYa0GDMYQrzN8IyBJM6DUsUOmknwRBENctHLFiPNsAMyR2SX30DfW8XKwRIMeDr
HCsfpZUh+cijE5DySXq5J9TwLxarGtRyPCqbBb7Ny7fkAhcnyAWqI5FPaRIvTh1l
JbJZ+L446v9WGrsvU8+UuIeeOa2xriX9aAIsqdBP2XUaNKfB6a473e35BKiNsBLu
aL3Nlx3kD3UG0Iqj8i1qG7YkuLIeJk9wjT8eGhu1LAdrpte0SK0C7O6fAOVW8U1m
l+N6FT5gAJ4gBxrNZ5mYLbM0zihizU7Zyqza/vMkkAaOHgS6iHv/jjiqZHkT82ht
OlCrmcHiaABW89jJ7xmvBWOkW/2hhwD3DMM7isSUnI/mjqVcVivZ5ZZPczBoNkLI
e/wQsvELbdkCqvsZpg41DzGpHNVnftJHyp41aBIRAwcfgwB/FNA=
=+oCH
-----END PGP SIGNATURE-----

--A7ZGdrJWJ7g7chgL--
