Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLB8vzbW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cz7IsPhT"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B0123
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:37:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7A3CF5C0163;
	Thu, 14 Dec 2023 08:37:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 08:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702561030; x=1702647430; bh=+BmBebyCFe
	s0DD7JN6R1Fyf0FfAoHBkfs1MLjOfHFrM=; b=ZLB8vzbWDDf7Vwcp47Eo7KjAA5
	Z/omUYdPW144Dp/uaD6Xadbk3szlIz/LZm0QCWT1vQyAO6+A/dwg7eyCwxF1JylB
	klPGRsiscKlxm1KuuFBJ1zPKdreeWfCWK6TPN7F0f0+oxjtxG6t9Zy6dchYt2VXD
	zlG1rlKN+ATGfE3M2WbaRfYzWUpTcWLToSQD0GymlVf2NydLzg7qwNG8Dsj9T0eM
	4qXDStSF3UsioBVln2u9A3hFrpclDc73RWpn/F/m/CF4HLmI0+osIO37iu9Mg/da
	6FROHPrgmcFEebMfpT3SZPtxOkEmDEfvETJy/ejxylt1Lmym5s66LzHtyOJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702561030; x=1702647430; bh=+BmBebyCFes0DD7JN6R1Fyf0FfAo
	HBkfs1MLjOfHFrM=; b=Cz7IsPhTXM2fbGVT+lRrz3U3SPeqKDLkXOo7N3eqMfWk
	x/sQ6KFCy4gv6UL49JIWr9hIBf0M0y2IIkUlN9tYNKVTGd3YtPeVIsbP3uv+XKOR
	yTwn2H9WC+LdaqP7JfAWirz1aX1sQwNTghwjIV8+zJRcr7vqDeORxOW22jJr80qE
	SysYpm0FW3rLgAOl6eJlSHfKa6dFpgYHHZEkVoh8fJ+bklgRa7vpI2Buc78Ibtty
	O67buY05ZSSsOy+bgkCaWgzpEJJdQouxsEdVXTYD5uUEEJyOe8STqWepou3/iF1j
	R5lq8/6v3ZjI0oJLRXtMg1Ylv9MEVA/l0RhfOxoFiQ==
X-ME-Sender: <xms:BgV7ZagT-Q5S1XaophAEoZtNLy8ru-t2M2kvWm3MPozhIFSnj9-dRQ>
    <xme:BgV7ZbBqjD7uYYpYL2_cIFp7AcNFitzyYEgRAB5GZcU7-5jWlTu-BLLQfrxoJC8MI
    JecrlgML5CBE1ypsg>
X-ME-Received: <xmr:BgV7ZSHlQ7ukIAajA7YkSH4QOc2IqFYOJItbp97WayuzNxitgSz9zTG38tAiheXPzWLCmUO6hzSD2CuTT7MyOGcbVb4R7d6e_UGkMMPpH0wlKjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BgV7ZTShE9lvZ3PbYrCZn5_X2yHh5RTUkwVvIzbuFV6fld1F5j42cg>
    <xmx:BgV7ZXwfZACpCT0aFCNBNo-6OSGFV63fuPAx83k8rkV3k-wky0dx_A>
    <xmx:BgV7ZR5sIS4LNlsmyGYTSyCSjD6XS4ZxdEtdVq3ohqjXvn_FCkapKQ>
    <xmx:BgV7ZS8gLYo9HeDVvucxmGJyyXASrbnRrxQ9-Ojln3rHYpDEIu1D1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:37:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03dd695a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:35:26 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:37:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 3/4] refs: complete list of special refs
Message-ID: <81ac092281d9ebfc0f231faef6adcdce05cdb1ec.1702560829.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702560829.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XprxDeecW6y7ojvv"
Content-Disposition: inline
In-Reply-To: <cover.1702560829.git.ps@pks.im>


--XprxDeecW6y7ojvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some references that are more special than others. The reason
for them being special is that they either do not follow the usual
format of references, or that they are written to the filesystem
directly by the respective owning subsystem and thus circumvent the
reference backend.

This works perfectly fine right now because the reffiles backend will
know how to read those refs just fine. But with the prospect of gaining
a new reference backend implementation we need to be a lot more careful
here:

  - We need to make sure that we are consistent about how those refs are
    written. They must either always be written via the filesystem, or
    they must always be written via the reference backend. Any mixture
    will lead to inconsistent state.

  - We need to make sure that such special refs are always handled
    specially when reading them.

We're already mostly good with regard to the first item, except for
`BISECT_EXPECTED_REV` which will be addressed in a subsequent commit.
But the current list of special refs is missing some refs that really
should be treated specially. Right now, we only treat `FETCH_HEAD` and
`MERGE_HEAD` specially here.

Introduce a new function `is_special_ref()` that contains all current
instances of special refs to fix the reading path.

Note that this is only a temporary measure where we record and rectify
the current state. Ideally, the list of special refs should in the end
only contain `FETCH_HEAD` and `MERGE_HEAD` again because they both may
reference multiple objects and can contain annotations, so they indeed
are special.

Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 00e72a2abf..8fe34d51e4 100644
--- a/refs.c
+++ b/refs.c
@@ -1820,15 +1820,65 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
+static int is_special_ref(const char *refname)
+{
+	/*
+	 * Special references get written and read directly via the filesystem
+	 * by the subsystems that create them. Thus, they must not go through
+	 * the reference backend but must instead be read directly. It is
+	 * arguable whether this behaviour is sensible, or whether it's simply
+	 * a leaky abstraction enabled by us only having a single reference
+	 * backend implementation. But at least for a subset of references it
+	 * indeed does make sense to treat them specially:
+	 *
+	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
+	 *   carries additional metadata like where it came from.
+	 *
+	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
+	 *   heads.
+	 *
+	 * There are some exceptions that you might expect to see on this list
+	 * but which are handled exclusively via the reference backend:
+	 *
+	 * - CHERRY_PICK_HEAD
+	 *
+	 * - HEAD
+	 *
+	 * - ORIG_HEAD
+	 *
+	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
+	 *   rebases, including some reference-like files. These are
+	 *   exclusively read and written via the filesystem and never go
+	 *   through the refdb.
+	 *
+	 * Writing or deleting references must consistently go either through
+	 * the filesystem (special refs) or through the reference backend
+	 * (normal ones).
+	 */
+	static const char * const special_refs[] =3D {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"FETCH_HEAD",
+		"MERGE_AUTOSTASH",
+		"MERGE_HEAD",
+	};
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
+		if (!strcmp(refname, special_refs[i]))
+			return 1;
+
+	return 0;
+}
+
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
+	if (is_special_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
-	}
=20
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
 					   type, failure_errno);
--=20
2.43.GIT


--XprxDeecW6y7ojvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7BQIACgkQVbJhu7ck
PpQfYA//SmJfDMxa9cqmE3MlMXkGlilNah2Ol7Q4RUiCtR3oFSwo5ci8ICMWANvN
twEyhWdj407QAAn093FpuK3ywiJQpfWYV5ewz3dbVnh4bG05zciJV0rGCxMEPL8m
x4Q/PUYsIG+PTVn96a23ShY6ES4QCAwSagLRKDi4W/BmIVwk/VZoeNTk4OVEJNdz
BpOfDqvOOnv/KBuZTX3OwsAe/ZTuR7ubHl07934nn+Q/kQkzq58LsxZ2McWNQesz
UHJrsy3fE3i3+xMXPiQ9dUxeLkr4oavqyr41OaBn5/onOa9wFYw0Zn2NM4UROEvq
th/P5mVXxmjr7uhEzR02a2UsKf8DMlzvegwXQY3qkCMmoyaBWvDYy2E1O51I0xa0
ElsnVeLsP7TpJMRISvfdJqmUi2XC69+Xs7Ucx8G5iQMy1mw5sVqG3x4kaCrgNUC+
DO2DHIGEI85w+uiVCUkMlg8xgYN8nc0zK5vDbPbQwSv3VxWCauPuVb2GzKA7CoFn
lKhjt5M8ei35zjfIw+V59er8ex9kou6L6Wi5EB+zC1eRmgG9wVxN0Qs5YtBkJFx0
1YKL+d5bFUJA1qjmmUwI230lqAVvXz7XZLf54RJLBw3HOr3v2tYDlnDjUFpl0FaS
mUj5jrJf0hBu3n1Msgy32L9qKtkcfsl6/FUzvSgdXLNUlLtl5fU=
=iw+J
-----END PGP SIGNATURE-----

--XprxDeecW6y7ojvv--
