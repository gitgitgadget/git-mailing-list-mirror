Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EC6FAC
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VvfJS63l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1fvpl4vT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C037F5C00A5
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 28 Dec 2023 05:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757606; x=1703844006; bh=Nn0WPkgjVx
	YWxUJ8/aEpygOfG+H9cMfHQPQWQW9nDlg=; b=VvfJS63lZSzDghSNRPaddGrGpT
	qXsFj8Co/cLUQXeBgUhEaV21IwGz9eiv13VYM3CeXWonBLMO4hOGWHI40GH0bHHM
	T1lzA5K1vTpCUmkaH5VnBEdUxjfo8jKZlHL+7CW1TC4kmnhLBqrH+T1n1I4xlzc5
	xQqd8tboy6F3NUgYw0Xtu1+xAv3MOcZnkvl0RiKpnbbKkeG1cUxLXujJuTuh3V95
	WFexfM/dTuzlnLljAaaDOziJOMUIcaccksbKqLdDpqGbUcfFk6w3q3gDNZgB6EKt
	JdLZoYBMtXnMpCSrL97iWq7cM5ydXmWOJR7LZIFuFsaE8zTZd+6vkR/K/vxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757606; x=1703844006; bh=Nn0WPkgjVxYWxUJ8/aEpygOfG+H9
	cMfHQPQWQW9nDlg=; b=1fvpl4vTVK/drfZJoE/IazZnfTHaxVBIweIU2NU6pSRl
	iH/QqcOQNJLXZ7QSmJB9AZfIpf+zmr1vFHxeYwvoPcFjUjTkW2hA+E02uyN4ilCQ
	6qEN0cduuFTPlzfOqa9pmBf9TC0mTUa2fenzCJpHaxJ+dT1LdqD92ijYzr7gcmOG
	rcvaQDNhu2oh99ScXpTq+MEN/IGRorfx2M+KpV6HVwoorYI7vit2XDW7q4OlNIeh
	H3uKxLDiYyh8JRDCjAKYWq2Zu2Zv+Lh3UVw49rAQOK3wrjk2C860WzVyj380hRq3
	/zB5x3Va0cZU/uNJwVp4CrL8w0JL8as70accxj09jA==
X-ME-Sender: <xms:JkeNZZoKKJiH0LQpRjNbJnjdzMyEo9-qtqylxzEmPzd2Iqu30sT5wg>
    <xme:JkeNZbr7gFyL5UjLzqMr_hCeWLKLEpPSqV1i1RrMQQfp8aqOrw21egwrJdGsbsRC5
    vPQEFd6fH7gVuGajA>
X-ME-Received: <xmr:JkeNZWOi7JdbeFV9upaCWm57Y39LTmgRYBgawHvKKb-BboQ7p7mmPcDrdmkJK54IdcLtEVAf9yGsvPOqn6_WOTzsWYYKc9OfqMOCZNCNek8fxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JkeNZU6CzRu4iXy9dVbw1QkpfkHYcpyUTHUETgLrxKiWrNdXi2PFdw>
    <xmx:JkeNZY5TvnmP4cAb6thU6O51w0W8UjEEEruL0zbzaabxVQSKKl_Osw>
    <xmx:JkeNZcjD6YADTH9snungdgvtTJhtGMfBh0c-ae0NNnM7EfIIaN94Uw>
    <xmx:JkeNZdUrn2DccaBQen1lVcg5X7Ve-NIUGTZr6NRWF280pCXW4O8CPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 05:00:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e2fe4e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:52 +0000 (UTC)
Date: Thu, 28 Dec 2023 11:00:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/6] builtin/worktree: move setup of commondir file earlier
Message-ID: <1a6337fc513f4c3750649a940a84be94b5855a35.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1p/55mI4OQ4Llt8k"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--1p/55mI4OQ4Llt8k
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


--1p/55mI4OQ4Llt8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRyMACgkQVbJhu7ck
PpTbxA/+J8zBGFYWaUctiqol3zSpcmpHus1UBX2x5s/zgYowYRZoFVzqEkrmMSmw
FOcjB9ejnUDC0QM+VJ9XcNqTBg5uoQI7qTT9Tnh432B3on00j3x6aaSU+XqhZQPI
p+gRlzNn1GvsEwOYWWQf0bCjc2YXI3JXZGTRm4bxR1Fw9eO/HytcJHBG9jFnV4BV
EdC3R+GS3EbNQrGyimegFZObLDTnRflIp70UoGiMKA4R8bxEN3HbKYDd9dFEXpej
HJBk2wKQLGR2ZpsU6hnzgnglLFvkuapocIRHhYwaYiCGjV9kLDa/VaPi1/6vSXZI
PUfhBawIaA0PaGzi3oCrz90/2iPp+ucuyaJwoqTgIYBS4+A2rRNW55bDMatzGCQv
ZfkqwAQOHICVv/loj4rXVtM15SsT8YHs3xIXHhIuAFJxJQk22GYDQQz3glnZbaEL
m24VKo+KINQdOS7PSuxcAGyHNmHd31y0Dem2vIYnFpVd6ISoJ1bQYgVQoz6o3mPW
VCPkbngbg8wTq0RBvM9cX6KzEKJnNBFpRWThmAkLkpYxsEkRZsLL7fB+e6fCFscF
2aa3ywGsDT8CDSdnyogvPKsN0r51PZ91fuqmIwZBYW4hqyojD9cVw89RC69naFxn
Uaq3H8Jpx8XUwKqMGzazSmSPnXZ0djvetLBpZ73b5rzxqHgWm0s=
=rFMO
-----END PGP SIGNATURE-----

--1p/55mI4OQ4Llt8k--
