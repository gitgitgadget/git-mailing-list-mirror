Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A14A8D
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OKVc/T5Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYkSuIKE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 386855C17BC;
	Mon,  8 Jan 2024 05:05:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 08 Jan 2024 05:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708342; x=1704794742; bh=rq39K/0IFR
	FERDws20nMVI9KKN0Ty1Qanko7HeTZ4wI=; b=OKVc/T5YyOTpar7KsUwdAs7w6j
	/b6FEOwr9PZRWBRO2oiR3WIQGF7w4g1KRJatHG+H2sjATgUnvW6We83zHGeYkYMg
	QWNZKO/mmdF8jtFHxiR+RQEmpElYJDzsKlnLj1WfsJot1b8PSmS1LdBuCpxReKJy
	Op4ffpsGsehyNZ5oPalHorl6RJ3F9EheyTjn2EpZQQvZPRe+RxrCc0voy+p9lJ3F
	NDWAtVE5iL7NlePSXzXM7u7RuC5h5jBYtHQ9xIs6sRQs7eXDwGCp7YTK5tCkLtQv
	53W1O9UUKN8wIkmZDBzRWVzK2rlp1l0b+MglPa+Bv1qtBRhd7C0z62ld+drw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708342; x=1704794742; bh=rq39K/0IFRFERDws20nMVI9KKN0T
	y1Qanko7HeTZ4wI=; b=uYkSuIKEjRl6oKceKe53Zv4memsuVLWQk3LIuscHyh8c
	LjRvIjvQEEUGcdtKGjvG1Q6wZztSNH5DFL8HzLtLu4YzKHN3O5L79rRJ0ryrdc1s
	hT77QJ1co4JqDRXa8JzODaT2/xX3XZqEw9WczQuj96pc2x2CpHNnuTNCe0M8876z
	nBtMRxEZANHYNs+bhH5YzAv8j3JdEpZ1gnJGrYeQSUsptFFIYupSNwH6vqQJ6W1W
	ab6TIa681kI6ylFD4TigzTEMjWmkw87RBRXSmNRWrFTSp1Sn41PMcuYiAi/OWYDv
	0QbCTS+3dhy/DHYY6BNJ0DJym3XKB5Jn6Hi06ZZzBg==
X-ME-Sender: <xms:9cibZZpa2n_mg0qts2EYNRsdfLIZMQ7o2MWxggO5Czzndf7ObBExsw>
    <xme:9cibZboLTffOePm5EaVvQ6DXfTp5O8zEnxXY5SxRDpQuacgtabGb8YqUnJE7u5T4H
    0hpyJwSFybYfroWYg>
X-ME-Received: <xmr:9cibZWNyL5c-4Hzm83IqBubNwU8L8bI5k4Ynwybg92LuHMbIwxtyrV5zP7gZjAMglM6asFFiwPuw_c6iHut7pzdhc1RNqxfgeuiJ-xwSG24LVOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9cibZU4SIJIH44rP9Ualo1WR-MmRp4Zr2jBdYB3SJX4EvugDa3rtKg>
    <xmx:9cibZY6jRcgtEApEW4MV2uIIehnrkw6lYGV0xJrI2kCKfYuxCDblMA>
    <xmx:9cibZcjTZkIdhSNj72ubylxYp5fBOnX-qKv7l05oky2BGgxWrm0FXw>
    <xmx:9sibZYFU4KOj3nfWsUor2VF031VwqyqSpZtJqhcB1E9c1zntIwZiuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5c5205f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:03:04 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/6] builtin/worktree: move setup of commondir file earlier
Message-ID: <f2eb02028840fb791b038550d6af7fba3ff49731.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyZVWAtQ4IPPIS0T"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--VyZVWAtQ4IPPIS0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Shuffle around how we create supporting worktree files so that we first
ensure that the worktree has all link files ("gitdir", "commondir")
before we try to initialize the ref database by writing "HEAD". This
will be required by a subsequent commit where we start to initialize the
ref database via `refs_init_db()`, which will require an initialized
`struct worktree *`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/worktree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4ac1621541..58937a2a68 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -495,6 +495,10 @@ static int add_worktree(const char *path, const char *=
refname,
 	strbuf_realpath(&realpath, get_git_common_dir(), 1);
 	write_file(sb_git.buf, "gitdir: %s/worktrees/%s",
 		   realpath.buf, name);
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
+	write_file(sb.buf, "../..");
+
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
 	 * or is_git_directory() will reject the directory. Any value which
@@ -505,9 +509,6 @@ static int add_worktree(const char *path, const char *r=
efname,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, "%s", oid_to_hex(null_oid()));
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, "../..");
=20
 	/*
 	 * If the current worktree has sparse-checkout enabled, then copy
--=20
2.43.GIT


--VyZVWAtQ4IPPIS0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyPIACgkQVbJhu7ck
PpRpLw//WVcWqftYhKzx6RsfcggXBolZYCzOiT37KMKhRTHFpLhmpVqXJnxEPuUI
Yq6mU8pl7kryh3BA/9KZdJNrBrVZz5/LcbqT+IzK2OXPpNpTp5todRJJ1WIrv5RE
qtwz4rZ9LNt42oxg3KnyEgI+ln/oBZLkH22ND5wIzKXWS4J6JGjKonXNl0pJ2wsz
sgLQjQllChfNeg9j+eCec+gvQ7lwjk+MpJhspQ+PPhTLSzMpq3o2SM6cNz2fhlql
9KmcyGR2d8P60falleFJ8b7Q7Hivto8A2Tg6RYI9/WmAXz5ka6puRSeSdjtxZ4KC
xJvLGQuFTgwdYicKGypqhGz23/VZCQR0wGNPMbL/r4rumhlgEicMCQ+FKOoxdbla
z0tdogdIXZwZJbbXtCQKuAv7QYcRn+EyKRvLT9VH/NLfxM+NtVxsMeFHFJk5JGVj
YGG9BOI0DMxJvxkCm7hdzPHrB5W7Ose2EZfQXdS7qfxgIlz7TObNK16ORHwM/OJZ
NvhGWYa0NTrZOzeb2RVTqBxBGaxHylkmQ2223SK0iJcO2p2e4Jway2MBLC4hsiDK
TBKFcKauwwLd9Q9Ocn2M4S8xhSwSL7fjvwvCCUWU8FKTro4FffBDvYBStb1j2ki8
4SPHJOYtaK6x0qok4oGbon5W0FhAwNVauii0piVkQ05ytxQHq1Y=
=rrqC
-----END PGP SIGNATURE-----

--VyZVWAtQ4IPPIS0T--
