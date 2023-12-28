Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6E6FC3
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HLVKBmgc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JAoI8Lgw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CFF215C009A
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 28 Dec 2023 04:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703757598; x=1703843998; bh=fxKrwS3vh3
	ofL/RRvCENk+WHQYo5/52Qf+L1olVvcoY=; b=HLVKBmgcIWejh7yopX6Yv9TAgn
	plYpSCdFU20bDtPeMwjIpTWG0IlsfDdD/UK4USKvm0/7BTwOz9rd0xvDWY2G8g5o
	O2ugtYUdNV+ahhME4aibLSvk3x/W3aKmxpJa1OiugDQsgn7x0BDvc9KSE2W36saC
	ZYDXDeD4L0Nwz2Q7vNUK2h4YpDyDaYjG2tDFeD7S2d0NUhcCggzsUTtmOJzy1SMd
	jjbPN/tj2lPdFtMyniF0bbEu2NTIGn7iUnm2homOC1GSY3RjGUWjgZylXTDBOlKO
	Mxw043uEf9LE0aOD5V76uKU9Vux265iV+GO9qmAWRu0L/Zrc9N05PWYKTqBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703757598; x=1703843998; bh=fxKrwS3vh3ofL/RRvCENk+WHQYo5
	/52Qf+L1olVvcoY=; b=JAoI8Lgwqgx3Zitl0X9hDNqu5NSoRuoXknxltN63mqU/
	5mq26ke2yOFEgcqSrhuNC56O6rKRK2rq8eTCcKhRzXR37Cmtj0jPg9iS3lyPjjQm
	NX/487CMv2UN0wleUqviuVPk0OUfvSNeaR9THXPQWMlox7Xaqdq935Bv3MmBIo3c
	QVZ4XBWzj7XsAPYlYpZUF/fH3sLJGa8DKObhH2EVqKyCmI3unM2KfSkDhKDmKG3a
	11PEtpveZPhVZ8kcdnOnNhnhM3Fcd2oznaU6KXno7Wqu8ZZPRWvrwXFHp376jT7q
	YqjJbpO+r6FOQfJFbWTQy47wokx/dbk0DsBzgNJDZA==
X-ME-Sender: <xms:HkeNZeKPRXSbs_mtnyfyGqMm2oc0arEIE0ZinzCs7OOk7i-u23JjIQ>
    <xme:HkeNZWJrMelF35FkQWYI1RC2aa4ZngVBMNXNIERNSFvqVtuDQmr6NSuIVW6Y_XfNp
    fWv3rvkcDLuUFalaw>
X-ME-Received: <xmr:HkeNZescPaIxTqSmmuN1vE8Rx8AvcHu_teKqFhcEo_ryaiB7CjWaJDuDWRziZwXYYRtL6AHCQvyRBw36tpkeF60j1ZatFIuw7cwPwo8LGwWAAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HkeNZTbeh7NBuEOaQzmvHZPr_StTynRHYh2R9AMrcaenOTG1gzEXJQ>
    <xmx:HkeNZVbliWzNPwLgz8vXGHEgqgaCqIvtWAr_OgoL1Z07vT9a5Ho6NQ>
    <xmx:HkeNZfCF8JpZeRJW6wJy8AtelY9NusFQ74oiLLjAO8w2ZKhdZml4kQ>
    <xmx:HkeNZX3o_pOA61lB1iaXo3TyQDE-jGzI02Lr4FqIbY23G4wlik1N9A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 28 Dec 2023 04:59:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a583fa65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 28 Dec 2023 09:57:43 +0000 (UTC)
Date: Thu, 28 Dec 2023 10:59:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/6] setup: move creation of "refs/" into the files backend
Message-ID: <ae013eaa4aba0d68172ff03dbe9f2c2bca596285.1703754513.git.ps@pks.im>
References: <cover.1703754513.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P89OqfpG/QodzeLF"
Content-Disposition: inline
In-Reply-To: <cover.1703754513.git.ps@pks.im>


--P89OqfpG/QodzeLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating the ref database we unconditionally create the "refs/"
directory in "setup.c". This is a mandatory prerequisite for all Git
repositories regardless of the ref backend in use, because Git will be
unable to detect the directory as a repository if "refs/" doesn't exist.

We are about to add another new caller that will want to create a ref
database when creating worktrees. We would require the same logic to
create the "refs/" directory even though the caller really should not
care about such low-level details. Ideally, the ref database should be
fully initialized after calling `refs_init_db()`.

Move the code to create the directory into the files backend itself to
make it so. This means that future ref backends will also need to have
equivalent logic around to ensure that the directory exists, but it
seems a lot more sensible to have it this way round than to require
callers to create the directory themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 17 +++++++++++++++++
 setup.c              | 15 ---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 387eeb5037..ed47c5dc08 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3228,9 +3228,26 @@ static int files_init_db(struct ref_store *ref_store,
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb =3D STRBUF_INIT;
=20
+	/*
+	 * We need to create a "refs" dir in any case so that older versions of
+	 * Git can tell that this is a repository. This serves two main purposes:
+	 *
+	 * - Clients will know to stop walking the parent-directory chain when
+	 *   detecting the Git repository. Otherwise they may end up detecting
+	 *   a Git repository in a parent directory instead.
+	 *
+	 * - Instead of failing to detect a repository with unknown reference
+	 *   format altogether, old clients will print an error saying that
+	 *   they do not understand the reference format extension.
+	 */
+	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
+	safe_create_dir(sb.buf, 1);
+	adjust_shared_perm(sb.buf);
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
+	strbuf_reset(&sb);
 	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
=20
diff --git a/setup.c b/setup.c
index a4eb2a38ac..f2d55994e2 100644
--- a/setup.c
+++ b/setup.c
@@ -1904,21 +1904,6 @@ void create_reference_database(const char *initial_b=
ranch, int quiet)
 	struct strbuf err =3D STRBUF_INIT;
 	int reinit =3D is_reinit();
=20
-	/*
-	 * We need to create a "refs" dir in any case so that older versions of
-	 * Git can tell that this is a repository. This serves two main purposes:
-	 *
-	 * - Clients will know to stop walking the parent-directory chain when
-	 *   detecting the Git repository. Otherwise they may end up detecting
-	 *   a Git repository in a parent directory instead.
-	 *
-	 * - Instead of failing to detect a repository with unknown reference
-	 *   format altogether, old clients will print an error saying that
-	 *   they do not understand the reference format extension.
-	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
-
 	if (refs_init_db(get_main_ref_store(the_repository), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
=20
--=20
2.43.GIT


--P89OqfpG/QodzeLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNRxsACgkQVbJhu7ck
PpSUjA/8CYrnaypNz5kuikxzrzfJJfaOBfLexRitVVAnoS5tMKhltqfzU2kBvcpi
hdovJpEeNr8/OGIPoSBjxzQkdTZfXG2B/JyB2Y5wvsSx3sBNiZhUBsXt90bEZn1n
7MSWud3TZa5BK/0931iHWGW4m9bS/CvHMTWxG3QC4gUJja9ct10vq2VGZTBNk8OZ
DWAc5DsEull5ullUGKCI2tI63aCZbxbbjkrbSWMzyQirCY27V5sw7Xf8lSJxM1Ew
K5V07VmrY4OynPBmYi5VggF615uYgCWc1jO3aRUZvOLzJyUcYouChrp9j/MoJriW
DvCCFg8z+9tjwwaySlSTNPzdVoOxknxQ72ZjVHO4ASSLMp/E3R9AXPXw9o2yLJHR
1JNCf2682ATL6hueh92QyIHYIDB495sJPQ2KLvLoCYQx5gj9cRIu6NOKfQNyUaeH
hKAoU7kMAweOpw4zPeoR3m7BzTqJ7IKLpV/49mfz4oSDm5kwKVnTv6WQVBmlF7iz
U3BEt0FSTKmHUkZuTjP0xBuOnicdJ9cBp0V33OPavGyHAf/NPgtz+gBAhD5cwfSb
6AneNpM8TcIp8vsauTBonyizX1pxrq8awkCxDDkqWGJyMyckz1C3mcL0G8H+Nj7f
UN8n1h1c1PdD6dR7QhjDFMtBYtb9mWQofmUMUDX+NcZb39LTAkU=
=7oqk
-----END PGP SIGNATURE-----

--P89OqfpG/QodzeLF--
