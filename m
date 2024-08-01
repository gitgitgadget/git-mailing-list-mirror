Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EDC18950D
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508872; cv=none; b=F047CeCi3pUIoYf3xd+mLraMUf1poxlLyixcyTSkhCcZaIG8gs23q5ApKu4HW6nKyXPku2ROggkiygsc2l+be8z2Sncb9tINCRwsvOPss4Scn2ZtyBgcMNu9sz9ZlEt5si/VMD67BjucALGYLUwAw+fC4Bvyz75Yj/igwtANOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508872; c=relaxed/simple;
	bh=62NryDJYZUWsvg7L0DXbwUoyYGOY9BrT4l0/hNASRww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYbzAIUi3gjlPFerOJ7BM91DAm7cbogC9MoOutQbrTSxyBup6s2aMAHb2wlEnraShWyjKadPgfFa5fq66MA+3X7gFwk7v+WnDxgTRDD9ZGGa13iCvJWxgSvddis6ivvyjcg5mM3YEe2kvkVl188zWX3/2YRLI8Jyt0X0FKOK5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z1vYSi77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krCR40tH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z1vYSi77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krCR40tH"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9DEED114ABC6;
	Thu,  1 Aug 2024 06:41:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 06:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508869; x=1722595269; bh=Ccknd61NFN
	z85nSMNkkpCFxRymCswArm6L90MBrRUtE=; b=Z1vYSi77mpY1CUZ/Z8iYFwqMoi
	ZqZi9EgCdFYusdnenM+rV0tkMNZX6OhUK7c9fstmiNDfpn+8l/OgGYjb7j1cVOHx
	VTHJJmK7/KrcFjXgOcMOQbATMZFHM+nFPwZD5xOSXGlHRMEieDOftuIt58mge3gc
	M3P01vc7Cd3dHyr2NBUTTl+eE79IrEHq/+UCNYgNF6taAdLhXOileGYkcIo2QMVO
	Jc2SGXx6we8JCm2OgKZdOVdOEg7HfNis+ZE0f130D+Nf8evrVLPR+qLC0lxMziUr
	L2IdStl7bphp6ZQn3+z27E7l0rhDsgJljZUrg+iEHSlCZq9/LZg6G5477fyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508869; x=1722595269; bh=Ccknd61NFNz85nSMNkkpCFxRymCs
	wArm6L90MBrRUtE=; b=krCR40tHVcBWAahKtMa7GEdeIUzI1iwvuTtE0vq7YnMV
	Jtd9nzmCPnLTUpzzBQZeCK4SBTbiDylvRaxsxBy7r03NXKLZQFnjycVz+ST+myD+
	EvjhoHxfstNNbkDCOCp0o68PdrD19wB8FQO2T4DDXgPo5fgs31fLMh3fpsiEgT8h
	C4eLuU7lRF+sinoztOhA0WolUQCcKsClKZnCyyBJPFQlxWay0zq7ppYmt8I0lDe8
	th4jcQ0mA4oVoIFdtD8JuUK0kiz4CEMxJOzPDt64xT4UPwhGiwju408R20Laljz6
	SPmJKv0/jkMD9kEniOAWZz2j4YD6D+vzypuTQfXttw==
X-ME-Sender: <xms:RWarZmaTL2WYma9MR03-wV-cgEXkY3TwzynPO5a1NX-cL8VfAyFbWg>
    <xme:RWarZpaCrXGLwBd599PV9ah21W1b-7Mbk2RxaThObiUxjnzJPQJgoZ1q3YMaCvNPq
    IAk5ikeojFo2eXIOA>
X-ME-Received: <xmr:RWarZg-227c4n89-zbHgQXdPJuRsGbH-Nc4j61sGlhKrrGCte3WRoJrPrDh50_ZDbdxsjfKCi7mgyegpjSXvvMeH5t9oiE7tVwZL0BhcR7GF50w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:RWarZopq1cquiFdU844rsWoOhMygTDV8uyUsaZ0Mvth3TK5vkZPwfg>
    <xmx:RWarZhodEjrQz7-jfm5F2Di0O_jNKrC14gLhP43cpyNehgKM7gonrg>
    <xmx:RWarZmRcuuAGMAtv2ct20BmU-tBCbQcTeFoMD6Wgmptf8JMA5hurNw>
    <xmx:RWarZhrAKHVF_FO3aYACg_ESooSRGoQwaEEMZB2sVJMThSMQXSFkHQ>
    <xmx:RWarZqD1MLFH0ESYblH48nsYjxvR-05fGjkWwhEiI0vIkjf0uRp9lJ6Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:41:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e4edc6b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:36 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:41:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 22/24] entry: fix leaking pathnames during delayed checkout
Message-ID: <8cae4c44f4ef5bd7686d90ecc051a8650da7d057.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRsJ2o4vI/DGgqcD"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--BRsJ2o4vI/DGgqcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When filtering files during delayed checkout, we pass a string list to
`async_query_available_blobs()`. This list is initialized with NODUP,
and thus inserted strings will not be owned by the list. In the latter
function we then try to hand over ownership by passing an `xstrup()`'d
value to `string_list_insert()`. But this is not how this works: a NODUP
list does not take ownership of allocated strings and will never free
them for the caller.

Fix this issue by initializing the list as `DUP` instead and dropping
the explicit call to `xstrdup()`. This is okay to do given that this is
the single callsite of `async_query_available_blobs()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c                               | 2 +-
 entry.c                                 | 4 +++-
 t/t2080-parallel-checkout-basics.sh     | 1 +
 t/t2082-parallel-checkout-attributes.sh | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index d8737fe0f2..61a540e212 100644
--- a/convert.c
+++ b/convert.c
@@ -960,7 +960,7 @@ int async_query_available_blobs(const char *cmd, struct=
 string_list *available_p
 	while ((line =3D packet_read_line(process->out, NULL))) {
 		const char *path;
 		if (skip_prefix(line, "pathname=3D", &path))
-			string_list_insert(available_paths, xstrdup(path));
+			string_list_insert(available_paths, path);
 		else
 			; /* ignore unknown keys */
 	}
diff --git a/entry.c b/entry.c
index e7ed440ce2..3143b9996b 100644
--- a/entry.c
+++ b/entry.c
@@ -191,7 +191,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 		progress =3D start_delayed_progress(_("Filtering content"), dco->paths.n=
r);
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
-			struct string_list available_paths =3D STRING_LIST_INIT_NODUP;
+			struct string_list available_paths =3D STRING_LIST_INIT_DUP;
=20
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
@@ -245,6 +245,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				} else
 					errs =3D 1;
 			}
+
+			string_list_clear(&available_paths, 0);
 		}
=20
 		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkou=
t-basics.sh
index 5ffe1a41e2..59e5570cb2 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -8,6 +8,7 @@ working tree.
 '
=20
 TEST_NO_CREATE_REPO=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
=20
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-che=
ckout-attributes.sh
index f3511cd43a..aec55496eb 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -10,6 +10,7 @@ properly (without access to the index or attribute stack).
 '
=20
 TEST_NO_CREATE_REPO=3D1
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 . "$TEST_DIRECTORY/lib-encoding.sh"
--=20
2.46.0.dirty


--BRsJ2o4vI/DGgqcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZkEACgkQVbJhu7ck
PpTKNg/8D9/OOHzgDcKevqkghzAXaHvlGUyESYlMp+xA3M87wmN2kQR1Bac3qAPF
Fq4YhVeAglU8Ex1/2hpNmlImWqUTbmNg5V7ZBgnghh6218zAF9rFOyiMzSJ15u0e
GpZoZU5LSKyQ82lqOPRzE5yUOrtOeCngKehl4TnsRH5hleAfL4wKJNknyqxPCBI8
k4dhRq8IKtQ8WL/9sJfc/8s8Yax99DmALatCdpRPaWTg8y5MvaiBcV4My/mVIVSU
CtyvaXB2CvZwz0L7JvbBr4zLlkFC2ANVDwEsSJTB6Kpk5mT1tSivm0aDp5zIgJPL
G79nWP25vVwGDIDUTCb4SFD4kOV27PTmuS2sAGlTWo8CeLn43mrzcXY+g+gbSjZU
REiEEB3bo8Khag0E1JAtKrEa7Q0wC311T7J1kfCmv2veNDu1LRiTB9NXMn9pmLNT
QwsNmt4IRVUwttdSuT3xbquYnGWgFTHULYT9SB6/PnWN3+NTG2nbEKhL495K7bQr
J7fm6FpuP3NhBaftA0lO3yitp9+p/K6BZTw6pVwwST2Nhi0A/sWUMp7hc44wdg6p
fMWCClgjPK+asoUyhEbL1Arnz67bEICyV22LLYI2k8z8SoDXdhxNdd6zC1C/a6F6
G1BQf05VCeVU4t/vwzuh/xUwMdlpaRiI/VFw6XWHK7e7V2PflvU=
=3X8A
-----END PGP SIGNATURE-----

--BRsJ2o4vI/DGgqcD--
