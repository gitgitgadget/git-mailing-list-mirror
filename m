Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o8B5hg8F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GsnrRv/u"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8710F0
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 00:14:15 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 14CE05C0213;
	Wed, 29 Nov 2023 03:14:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Nov 2023 03:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701245655; x=1701332055; bh=ch
	3hBqL0Mdl1re3JnoFPKO1kmtlhgH4hk5aGF8olVnY=; b=o8B5hg8Fpd5UzIPwMQ
	BFkbDhrmnf1B4E5TtCIXwtkeNW2Xr9+OdjTs70WqoQqHftwOcmStLPp97OLAmfzM
	dHEJGjaVbkZr7GmHKiiGw2ZFguEJN18b4YlwfQrkcyb0jsEst79j6COXsD9yRqkA
	WOJggFFkQJJj0UJfqn4VvJ9uBPvZHjPLrNYVjnQae0i5ZFAtwfGMWQA2kTLa5dAs
	cC5BRrezrl/aDJlabtVC7jlFk/MCL0hULW8wSxPFRFNfl6yByvxEyH2pNmmXw8t4
	74NxD3VnxZYkZBpCS+S90fKn9GsrKI3UXZFbWsCbINAmePxmUJvsk6vKN7AUmPKz
	N7vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701245655; x=1701332055; bh=ch3hBqL0Mdl1r
	e3JnoFPKO1kmtlhgH4hk5aGF8olVnY=; b=GsnrRv/uIgky+u7+D7XUy7FtesbDV
	Mfn5vEjbMhfB2aJUK3o0r9UMLeWezDKKmY2L4RZ8mnOs2VgdmkQleT3yXHiRahye
	8RtparAkTwsU15rwoqPJGxwbJCcy6eJgLZoQx4PEOpvTfrQ1d83QXq/Yeskt7aNo
	SMkk57wwkLOLM5UGhDqd+bU3kZcA+jHIuJoTD2+e/xaJii6uv+ATzWhIdf1GeH1z
	5S+SaJAD0UqX3hazXkH8+CHMtaR8dLWIlrA+UxWJDL3rV0g1XhBElaMhwyiqMKqJ
	2a52o7sedjHf5LMz/T6HASdUjFKcajpdAQLQg/xpm2zysISaqTd+kwL8g==
X-ME-Sender: <xms:1vJmZVuqJgyyMi7GSpXuzqxkbSoSDrygxep2u9IDvpWl_OAHQLeqlA>
    <xme:1vJmZedmXie23seEr_EcxM7GcJZGq5pFIasmvpBl00_uD7ZaDJCI1RqODCQRN-7IU
    2S6P61rJP2ut-D9lw>
X-ME-Received: <xmr:1vJmZYyy-bm3THLbv-r1ptZohRin3t9LgwVcV3tLyxcklxbCIMhYVs1VwzQPiSl3Qu6_8fUhpHFTCFT3tjNwSui2LRda6M_mtmTbBrta0e2yMut2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1vJmZcM5rstsPSAau4mOmB9lAex8mkWRfUeJ5bNd3kh7CC1lq2d8Zw>
    <xmx:1vJmZV-OG9eJJBl7Psyc_AshSQMa1fECAe2s2LgsjziBz63AbXK7oA>
    <xmx:1vJmZcWUH3uwmuZMl66bVn6WFzFtKb16YOJ697llmPftWZbO9aSqfA>
    <xmx:1_JmZSEVnvmJV5-vtOIZSVbqJ9s6rfHsaWxiDeKKfjk5McJtK6feGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 03:14:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3fd99be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 08:13:03 +0000 (UTC)
Date: Wed, 29 Nov 2023 09:14:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: hanwenn@gmail.com
Subject: [PATCH 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <35b74eb972eed7e08190e826fabcf6b7a241f285.1701243201.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmjbi/CM+gghUbj5"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--gmjbi/CM+gghUbj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We read both the HEAD and ORIG_HEAD references directly from the
filesystem in order to figure out whether we're currently splitting a
commit. If both of the following are true:

  - HEAD points to the same object as "rebase-merge/amend".

  - ORIG_HEAD points to the same object as "rebase-merge/orig-head".

Then we are currently splitting commits.

The current code only works by chance because we only have a single
reference backend implementation. Refactor it to instead read both refs
via the refdb layer so that we'll also be compatible with alternate
reference backends.

Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. This is
because we didn't resolve symrefs before either, and in practice none of
the refs in "rebase-merge/" would be symbolic. We thus don't want to
resolve symrefs with the new code either to retain the old behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wt-status.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..fe9e590b80 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1295,26 +1295,27 @@ static char *read_line_from_git_path(const char *fi=
lename)
 static int split_commit_in_progress(struct wt_status *s)
 {
 	int split_in_progress =3D 0;
-	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
+	struct object_id head_oid, orig_head_oid;
+	char *rebase_amend, *rebase_orig_head;
=20
 	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
=20
-	head =3D read_line_from_git_path("HEAD");
-	orig_head =3D read_line_from_git_path("ORIG_HEAD");
+	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
+	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oid, NU=
LL))
+		return 0;
+
 	rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
 	rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-head");
=20
-	if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
+	if (!rebase_amend || !rebase_orig_head)
 		; /* fall through, no split in progress */
 	else if (!strcmp(rebase_amend, rebase_orig_head))
-		split_in_progress =3D !!strcmp(head, rebase_amend);
-	else if (strcmp(orig_head, rebase_orig_head))
+		split_in_progress =3D !!strcmp(oid_to_hex(&head_oid), rebase_amend);
+	else if (strcmp(oid_to_hex(&orig_head_oid), rebase_orig_head))
 		split_in_progress =3D 1;
=20
-	free(head);
-	free(orig_head);
 	free(rebase_amend);
 	free(rebase_orig_head);
=20
--=20
2.43.0


--gmjbi/CM+gghUbj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm8tMACgkQVbJhu7ck
PpTDxhAApxVymHK1HWgG/5agg/1drv7u/+f7pQLN8+eMIstElcfpNX533FZx3ibb
1RvVlJ9Z/BtCw+210COdLEzbyNKVAp08ab1ZgjXxJejbGo1SViSRGXxLHAp7Rhar
fG6NZrNBOTSkRRhypLoOct87xD3lwYNtJMa7T3SIUSHesAKopYcXF3kJxuPiTECl
qawjwHUCP3tLuV0QVUuLDmAN2qhXo+PM2Ovo/Im4EtojOXnzcsVIJ8jw8UYiTIeP
aXUfN0d1sL5z81rQej0CZvWHy47KKUFH4f+0bDMOUa4kp7bu8yoICeJTgm/PFWtQ
1zbmiEbFBJECimD65B4rl7ues8df5c+5hazTRu2AyEXhFK7dYbafdqJ5BCKKQFm0
lSwIFOXCHCUH8MNBUSteLXjKNf52aB1cA+k03u4I5ZR548N541KFjYIqAp9ZcSHT
uEmiWpgBlwOax6cXjSYFpaPSBMSPBfnXtgBo7pWaZHLYrLxRJMG1J/JbLJI4rpqU
lzNSB8jc1PZeBEvepd1G5obVPaTnX594yd6Zd6u8y1aA/D7bEFO0NFfXPQzJf3Z3
R5A8a7VWNOKBOt3PybKshfkJU5i+1R0lJnOa99e3Q04Tf58WPJHV/Ftw4lGxAZs9
w6jPNRPSmKP0hzpyoDECVwFnaSl4U3aSGnYEj61AW+u4vGrfsEM=
=0Lvb
-----END PGP SIGNATURE-----

--gmjbi/CM+gghUbj5--
