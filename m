Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F71400F
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V974oVQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7IXRSgK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B2E7C5C17BC;
	Mon,  8 Jan 2024 05:05:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Jan 2024 05:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704708337; x=1704794737; bh=kRKIjfy0Xu
	uAM0F79enq0MA25gw+f/ErEj+yqZEvgJ0=; b=V974oVQUbU748e2w5Aq1b97wAM
	uJq26qKy38+xXxJfitrPxVlvMClDUz5mmQoUz/uZxXPiWw9Meep1Bfb2sUjwpMgX
	HC9EhXUJYqilljBNUN7BZeKlpJ6z3T7DlzMhda2rzzXI5Y6ws1CupM+G6TPovDLl
	4DXo0vvEPoTcYsN1ikk9J3enEDbo6X7znxXdzPjGdyQFdUJJ2SEg9u7/XSS9+9rT
	rr4gWbM1wfg2gKyXhNwmTwKbNugAtr4Y0xnTIIXUuC5wkjY4RrhMMPcnfVSXL6ZE
	8F7JjpKWlSUlepXsyfKNPXXw2LrGa/E2jGNlmfRA6TdlNEPpZd83G8vwwBGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704708337; x=1704794737; bh=kRKIjfy0XuuAM0F79enq0MA25gw+
	f/ErEj+yqZEvgJ0=; b=Q7IXRSgKHNY8F6PFVxFZhksH9RzrWyHOp+0ulfFwJx8+
	MwtqI9SSt07u33RJoJAOPjRWl0Fb3fLsUagcfwmlNUJ/GwTePuXoNOiXsLoKtQxa
	PTnwkkfnCjVdJq2FnuwxPD/Ya3bW/+2ei8FaQw5wqO6mhzNbPSfwNxUVDrJQepjh
	2kKpZ58eeSxACTSPDGA8NgO61OtvobAQGVSM3bXQsflFHSGMLki96RF3KM6IxUX+
	reRjkfzB0j0aOI/SlqccqQzLgQCYBDM1Y8qZJ/r7DIOda5ExqzWHyjW5qCZgJ571
	gQLfqW6GJyqIY2TzIZ6HCuihqxZSITzCmQ2Qd8GkxQ==
X-ME-Sender: <xms:8cibZaVxcqQtmOmsx5aprDt2PIx7ODXfPtFDum8MSuQR0HB8SxwJVg>
    <xme:8cibZWm95vguzt_wdLSmn9uDrrBibkXrDFF1Woj4PxiI25UglSSNDJmJKYkklQ1r9
    sKwMr32NyBAkR016g>
X-ME-Received: <xmr:8cibZeZTl-r2sSeY0X6WaFzg8MvR4VIvuQV4yvdX2MOTuBrGx2Fs3wBmgjD1JzV0AoCCmN-6xoVGBoUl4vv1ta-oLMUfqydFKQMy3k0VVUaHr_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8cibZRXJuugMdq_SGpv3mjyHDXOKjG4BA9Q5dV9BlqMHe3Yfj2wP0g>
    <xmx:8cibZUlA0Lmtq2KfFUMWjZyYdA5B1wTgLF72Yz3cWtKjD4P_fHCqJQ>
    <xmx:8cibZWeRn0kYmSY9oLXxm_8MFXKsXqZgWxJieLcvnQ_F6j44LXsWmg>
    <xmx:8cibZZytHapevqiSDs0RGSWhpBEBNrlpU9ajm2gBR2rkKG0fHCMHoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 05:05:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db3492e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 10:03:00 +0000 (UTC)
Date: Mon, 8 Jan 2024 11:05:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/6] refs/files: skip creation of "refs/{heads,tags}" for
 worktrees
Message-ID: <9e99efeaa384286a51a34993fa47f5c42bd81fa0.1704705733.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
 <cover.1704705733.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NAFTRjMGg5cQJcsK"
Content-Disposition: inline
In-Reply-To: <cover.1704705733.git.ps@pks.im>


--NAFTRjMGg5cQJcsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The files ref backend will create both "refs/heads" and "refs/tags" in
the Git directory. While this logic makes sense for normal repositories,
it does not for worktrees because those refs are "common" refs that
would always be contained in the main repository's ref database.

Introduce a new flag telling the backend that it is expected to create a
per-worktree ref database and skip creation of these dirs in the files
backend when the flag is set. No other backends (currently) need
worktree-specific logic, so this is the only required change to start
creating per-worktree ref databases via `refs_init_db()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h               |  2 ++
 refs/files-backend.c | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/refs.h b/refs.h
index 114caa272a..c2dfe451a1 100644
--- a/refs.h
+++ b/refs.h
@@ -126,6 +126,8 @@ int should_autocreate_reflog(const char *refname);
=20
 int is_branch(const char *refname);
=20
+#define REFS_INIT_DB_IS_WORKTREE (1 << 0)
+
 int refs_init_db(struct ref_store *refs, int flags, struct strbuf *err);
=20
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 054ecdbca3..6dae37e351 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3221,7 +3221,7 @@ static int files_reflog_expire(struct ref_store *ref_=
store,
 }
=20
 static int files_init_db(struct ref_store *ref_store,
-			 int flags UNUSED,
+			 int flags,
 			 struct strbuf *err UNUSED)
 {
 	struct files_ref_store *refs =3D
@@ -3245,15 +3245,21 @@ static int files_init_db(struct ref_store *ref_stor=
e,
 	adjust_shared_perm(sb.buf);
=20
 	/*
-	 * Create .git/refs/{heads,tags}
+	 * There is no need to create directories for common refs when creating
+	 * a worktree ref store.
 	 */
-	strbuf_reset(&sb);
-	files_ref_path(refs, &sb, "refs/heads");
-	safe_create_dir(sb.buf, 1);
+	if (!(flags & REFS_INIT_DB_IS_WORKTREE)) {
+		/*
+		 * Create .git/refs/{heads,tags}
+		 */
+		strbuf_reset(&sb);
+		files_ref_path(refs, &sb, "refs/heads");
+		safe_create_dir(sb.buf, 1);
=20
-	strbuf_reset(&sb);
-	files_ref_path(refs, &sb, "refs/tags");
-	safe_create_dir(sb.buf, 1);
+		strbuf_reset(&sb);
+		files_ref_path(refs, &sb, "refs/tags");
+		safe_create_dir(sb.buf, 1);
+	}
=20
 	strbuf_release(&sb);
 	return 0;
--=20
2.43.GIT


--NAFTRjMGg5cQJcsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWbyO4ACgkQVbJhu7ck
PpSP9RAAqQK01z4FY4baSf7uXD1cvRR2r7t9IWpKyM0deoP1xMJadjkRKae+4OGF
OWvaKjVUvrAYy9Cue2GCDghFTvVJrEoDy814XDa+/JoiBRcrXRUUtMIFw/ypw/zI
eI9Ya0SKrGaVPAJAvRMl2iCJAKnQvLQlkyFBxacK1EaIh/7wSZZAukl1N2oSA//0
g/KniW+NJO+mLlc7kJsZF9itlQHtgOcY6/TRHotgISG6DftfZCB5qcMy9BiB1xNi
4ltip09ULcA5ljIEy17U9dMGxTRX9pMFuTX0/cffNaMDeCXbXMbeoxzCd3M9k5u/
ndGnLeEwG5Q8lCI5jeNb2CBOx7DiBM2K+SMAUMZM3xWh1tLU1uCSNzP7dOH5hn1l
rdqjbDXsgR9T2OMAz4e7OzeWbTiEQb48hF0UgspPUzDj+VKmngbwWd6qHndlgOGB
KgeyY5B4Rp4L8qeHMiLqfEx1zeAJROVj9liaDWC4lDOd52ri1331DzRq5+UkhVlm
fIHoWY1vY/EMQj8WOPi5Du51zcAvhbaOXDMo63b+w8630e0TpjkUKvEpuJ7WzK5d
1/QmJ3TEvlokNI+X7nLkzyoUWDYXz0213ERAAFzGxNhh+F6eJ8XUu7l9EBJwhpRy
FxYbiyP2Hh0qjGF+9g1MgK6vjPZ0s2y/Tm50I+nJHEwHi3tubfo=
=FC79
-----END PGP SIGNATURE-----

--NAFTRjMGg5cQJcsK--
