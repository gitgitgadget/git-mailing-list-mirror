Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QZAC1Usb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xBi+k8F1"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373011B
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:37:02 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7E7F05C01B3;
	Thu, 14 Dec 2023 08:37:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Dec 2023 08:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702561021; x=1702647421; bh=nCymLJ6XS0
	Y4DAiOX+nRDTJ+BbXnaC6dlXTXMlNNkIw=; b=QZAC1Usb9GvzIhFVKtNz0WBUy7
	LrTsAlbf4tSaK72yQEvI8eiq7SUVLVxUTHQHwp5DFF01Xnp5so0N4H4/YoltRlnM
	R2z+/pICcTCRFBDyONGHf96XkeQyxgb+Yk4hdnfyiDUTdj7ASt2MOl2PXQo3c7/k
	uOA+pNe/ZkAv56DbwjNfAe5eFcCu7qh/9IjLbLWhP8hc47Ai+8OMpPQH7gWjglUU
	VI052G0kjwoclzlVwSj+Mg9Z8RojwsNTeQBPKOTnxkFE00BkZGyI7rZ+X4W93V2j
	AEqoxc6kvwN4PmnbmTLWJ3R5++u742F8maQZG3oaBa1qiKAz7wSnahfDIDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702561021; x=1702647421; bh=nCymLJ6XS0Y4DAiOX+nRDTJ+BbXn
	aC6dlXTXMlNNkIw=; b=xBi+k8F1dwTUl2iZ3fb12HaHY5Uu1QF1UynOowduht4X
	jgCPBTAC5BU0fRcBV1tK1vUWqXQKpK80lD7FGH4Jp08M9a1ZgTC77xyX6Yp5Iqm5
	loEUESqpN1L/hq26RBIUFw5RReIJFQxdoT3imUToNn67Jt7Nj5UbV/iwabUojzDj
	J+xToPYyRO6oiHT2Q1DcJP9o0mJTqQKVqwT6Ii0M5RWgcfAqYRjK83nHtFzo97eo
	b1dZHRZ9erH+cQPeB4SdYiTVTT6S1nw60HkE1lKNFQXrrxRG+7LyOHv0q+eIczAi
	4JHP/ku/4de5n8VE1+WzPhWEnr3KiG22WI7xqT2GoA==
X-ME-Sender: <xms:_QR7ZSUOdsDgl5lzu0ZCocKS3Ut8uwi4Jka0iCJq857y-z7vCX-ByQ>
    <xme:_QR7ZelfC2u2XEgroDdyYr5G_7iwa2iEyRY2Wo_-shqU3EGU4FL4TAcG_25d-vf74
    LAHy2An8OdAmQaLTA>
X-ME-Received: <xmr:_QR7ZWaELzwfnxybBXT1iYJRUn1FuAsD2oGEV2SRXvR-HiGQ9TnP_xzXT9lPzFQJxA6Zh5Sjo9EqPPhmy6hKBhl6S_tnAaOEG7D-eTAroV6duRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_QR7ZZVvGhgCdDip1jjU01_5gxIuXaXzhwq5ZySqhTy0NucLHAPjYQ>
    <xmx:_QR7ZckkIVPm04YMD5asi5hWxTLJG8tjpyzRCjPOpfmH2G9ZtVdfIw>
    <xmx:_QR7ZefbW-QQE4ILO2E6mD8TVREPRK1SjZWUSQj9crD1CrMELmndkQ>
    <xmx:_QR7ZRyi9jHOi2e83XoBlWJfQBYWPnbQvaxeU03KHmBho0JtAzOF4w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:37:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4dc766a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:35:17 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:36:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <aea9410bd9e1023e02d4a48ac7bbd2df52a819b8.1702560829.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702560829.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZR9TcAqQ5CvxTLVH"
Content-Disposition: inline
In-Reply-To: <cover.1702560829.git.ps@pks.im>


--ZR9TcAqQ5CvxTLVH
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

There are some subtleties involved here:

  - We pass `RESOLVE_REF_READING` so that a missing ref will cause
    `read_ref_full()` to return an error.

  - We pass `RESOLVE_REF_NO_RECURSE` so that we do not try to resolve
    symrefs. The old code didn't resolve symrefs either, and we only
    ever write object IDs into the refs in "rebase-merge/".

  - In the same spirit we verify that successfully-read refs are not
    symbolic refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wt-status.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..da19923981 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1295,26 +1295,32 @@ static char *read_line_from_git_path(const char *fi=
lename)
 static int split_commit_in_progress(struct wt_status *s)
 {
 	int split_in_progress =3D 0;
-	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
+	struct object_id head_oid, orig_head_oid;
+	char *rebase_amend, *rebase_orig_head;
+	int head_flags, orig_head_flags;
=20
 	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
=20
-	head =3D read_line_from_git_path("HEAD");
-	orig_head =3D read_line_from_git_path("ORIG_HEAD");
+	if (read_ref_full("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+			  &head_oid, &head_flags) ||
+	    read_ref_full("ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECUR=
SE,
+			  &orig_head_oid, &orig_head_flags))
+		return 0;
+	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
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
2.43.GIT


--ZR9TcAqQ5CvxTLVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7BPkACgkQVbJhu7ck
PpQRBQ/7BmY8fUJHeyVsG3EezQoT6pIcWW6p6ow9lqVdfAakAAqoaZF/vTQ5kz/T
UzV7jBZ9EboAKFqmPOmbu/5lDGUh3vrtV4VG7NthgV80LLonubZ+Y1T7jJFaXL4e
kWkGupzWVbb1R3MKSVuWW5CSPo8jR8GM5bNVLav4WZ3ZJ96QI2jh/QxHRjP49a6K
FUbndWYC8IQNv7NUUWDJWFlLRTdKnBv7yqfixsdfHVbk3vTymw0LBKbM3XXhL109
LRvBaNUj6ABRs8W0n8jH7o/hU0qbtDo6Z3qNAbXD9P7kDxevNkz8SE0KY4IT399k
4wbC6yABltxNLGEsLNrqXThVtUt9npDlQhjkn7itEYQFoARFaA+WH9MmNymgizov
eA5WKeG709EKMsNy8/Fd2+eCr3dQE1ma5U379FoHXwn9ROCjQhacRrDrT6z3YIgz
EbGURDo1jF5mLHbHQ7CkNAsAUE4b6W5yQOfpDEmUHS3lAqE6fPS3kd06TqJpfHpW
gQo94VBVh+1aRBeuRv0xkQBIJBYy0X1uIJyS47YCrn1fGFfHztgHM5OyqIfxk1Yz
3HoP9hYOHWHlnUCuTRVjzNh7EtpE+/SlV6NHaRIHwuDbBMtAuApbLveH75lPQoZM
OpV0Dwt5Eai0frF+WDw0jjzrts54CtzLYaGuIBUScGDzIMKUjN0=
=sg5r
-----END PGP SIGNATURE-----

--ZR9TcAqQ5CvxTLVH--
