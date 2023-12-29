Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE48BE3
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CXz67w5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLr5qiFa"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 45BA75C0175;
	Fri, 29 Dec 2023 02:26:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Dec 2023 02:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834806; x=1703921206; bh=NEwyJkQiFZ
	M9S+oJk2QWU46pl3+KnqraOjIoWZIdmuM=; b=CXz67w5b/s3J2URrb9tRrqX3LC
	/7nsx9prvE0gA+3N3BmrqaQf4PCXRzsJPMQP7qxZn7bq39z5F69T4O9XedqQWrzF
	Rpx548DQXcwZpTcFYWOkt7QN9OB/wFdXjFfPBXiSlKeqhftYPa5wXcuBNJx/znFo
	pHaP6F7CZMC1DnD5qZrj7QWi663Nu8CC2yZufi4sSvvVUYo3pxqBm8ThhO1j6dVt
	hYBkPelCzxLFxudPbD4o9OrvNr4mOS9lf40FMIb7+mseeQ5xiZ8n+vpkIKaMieYG
	GSsS4fzM6SmOwC0UXHbk6+cfb+oH2cGiBPZ2sSpAIxyk6BfYy6+2AWRqCVNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834806; x=1703921206; bh=NEwyJkQiFZM9S+oJk2QWU46pl3+K
	nqraOjIoWZIdmuM=; b=FLr5qiFaw6NA8gDCFtwIlAUohEDPpraMdDIlD+CZUakB
	UuBrCbV+5Ju5OtU5neuScTxnfrteMy1vGXJbxoylCJPXxLV1zMckcIPExeWvKEXy
	oNcyeXV8PVY7XG+dYa/bKJUr95WaIwDMJZjnvhJjRfY0+p7bQMuUI4N4RTwsMRny
	b6TspxHWw+cwkX+akKiW0t9jpF5xjdx57f9dBWM9AhX+pm9febMgutYHlyTLb0d+
	+HdgekhroLrV0VC9AxtaTGdeFaOA+A+kyTS33ump3pjZ6zIfN5sLBTiXJ2dljFF1
	pdXMI3S6OxFWAVomxZzBdU2zPoLG73T+rRiGRLoDjA==
X-ME-Sender: <xms:tnSOZU5xCh3XCYLARtRV49rP80UGFEgMaGY2x0FWNC67iFidRLq94A>
    <xme:tnSOZV5uHB97HaD5_jGF6UbWlnbXLQESvCg50F1tF9Z0PSNHmpMCNgfgsqqChb_vC
    -wz53kEoGmUcSdSyA>
X-ME-Received: <xmr:tnSOZTfKSwQI12pMIjNiodNuf8y8qCgkj5dAtfjJoakmc5xWJ8rJ0FZoEG26BM4t2VF6nr_Fds7wBMT5MuiQn0U0bNRbMX9L9ZFfwr0LrJ8SqLlxMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:tnSOZZLviU0Z1xmRENS-7iKXblUMZEkEww7fWn9N01-pphbyU_3jCg>
    <xmx:tnSOZYLx06MalcTJbTbNhGGI_VhD8bYqzGoBvskayJub4F-2fERNUg>
    <xmx:tnSOZaw89wxDKEjGbub2Ih44aE_H3WrlnpU7NPRjcsB6dg0cIOFlWQ>
    <xmx:tnSOZfXs5iOLewxtrMz9RwfiPlDtQ7RyvkSvs0gp6EY2cN-AwEWyUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0e7131c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:29 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/12] setup: set repository's formats on init
Message-ID: <a51da56d9b843078b3c8d013902c38c5b65728f5.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ok7XyFFvLIlqkBB+"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--Ok7XyFFvLIlqkBB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The proper hash algorithm and ref storage format that will be used for a
newly initialized repository will be figured out in `init_db()` via
`validate_hash_algorithm()` and `validate_ref_storage_format()`. Until
now though, we never set up the hash algorithm or ref storage format of
`the_repository` accordingly.

There are only two callsites of `init_db()`, one in git-init(1) and one
in git-clone(1). The former function doesn't care for the formats to be
set up properly because it never access the repository after calling the
function in the first place.

For git-clone(1) it's a different story though, as we call `init_db()`
before listing remote refs. While we do indeed have the wrong hash
function in `the_repository` when `init_db()` sets up a non-default
object format for the repository, it never mattered because we adjust
the hash after learning about the remote's hash function via the listed
refs.

So the current state is correct for the hash algo, but it's not for the
ref storage format because git-clone(1) wouldn't know to set it up
properly. But instead of adjusting only the `ref_storage_format`, set
both the hash algo and the ref storage format so that `the_repository`
is in the correct state when `init_db()` exits. This is fine as we will
adjust the hash later on anyway and makes it easier to reason about the
end state of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/setup.c b/setup.c
index 9c9a167f52..49570e6b3a 100644
--- a/setup.c
+++ b/setup.c
@@ -2207,6 +2207,13 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
 				      &repo_fmt, prev_bare_repository,
 				      init_shared_repository);
=20
+	/*
+	 * Now that we have set up both the hash algorithm and the ref storage
+	 * format we can update the repository's settings accordingly.
+	 */
+	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
+
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo_fmt.ref_storage_format,
 					  initial_branch, flags & INIT_DB_QUIET);
--=20
2.43.GIT


--Ok7XyFFvLIlqkBB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdLIACgkQVbJhu7ck
PpRZaA/+LXhJGmLLSC4LWHZ5xXd5vz3RBg6mqJu9FMsPcoKQso+K4Li8elJagQ97
QytHb0d/qAKa9QJ0pKbjVuW2QyrIg7gaHft7/pLMzUWPyATUShs3zVlX5x458912
DLEPcioouoQVpv6qf3MZe8HGDQEfIEswzY4DueRpNT7DpyJL/EuNYzehdtc6wFj+
sLk+7bGk5+Om8tjWH0EUGH4ajUkW01DIaYe4/f2ro98Obyo7a2HWVBMZ7mWQwxya
/y4U7V60N2/++vQs+fz7Tz1wX2i4/w6bOD3o0U/Wo70cd/+jfABLBxxS0n/3/QPp
5+tULJ5aJ+Z66k2r+baFUDnPYhpqDYwh2HTcaLEijpQUU2J4TYyn+DWl6s6xyCIl
Gb64FPUslZ86EF1RQ+FLfQsnpdFoQLl+3N3Z0E+9E4xJjsJxMXyXUBHU6kPTYZKQ
NTRUhc2+MBKM7ZQF+rKQr1HvHQklJu0cSNSz/l4iwvSu6//q9E8M9iclzK8eANYA
NOneCEmfBsvMPtkY8N9cVi+mF0fgXqNO7vEBFG+AuH+Q6jPoJNFNr0OM5ljqPuRv
WbjN5ODoMzRcI7vJeC27huD99lsuFlFgq249kEmeuOe8gMm5Arx6mmz+fJ0tnftz
hJaeWD/Xvu6mNUTHTv1GFrjAFcw3nScc1RyY8u8DSdX52N0lw4s=
=Bjfr
-----END PGP SIGNATURE-----

--Ok7XyFFvLIlqkBB+--
