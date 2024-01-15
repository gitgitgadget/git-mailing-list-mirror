Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13F1E865
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IxJK/ET8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nr7RJVMQ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 0282C5C00ED;
	Mon, 15 Jan 2024 05:36:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 05:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314978; x=1705401378; bh=wCCU/d1kLL
	TS0GW0fA+45QZMekQzArGY+W8T/+Wk0V0=; b=IxJK/ET8ByMUe6D35Gm4NMq6QW
	s/xQU/noSTykl6c7WvJtIF7MOPsVK2MB7tA9SobBvkTqpjizhHc1pp33VYvKjLt9
	HE4/jNaePNihSm62s27uT89A8gHh5QXlE9qChpPHq7CoVrb9wNr5V2rimID9aNqy
	DJ+vBzE/eee+yrgXeWrZnmPBxXxd3X+cDm8xH240n5155FYeuPMK4/cogZTH9RgD
	xmEMOb9C9WHk0n/iNr3plmrK5DUHE6eMkL9dAOtLQooJYFep4g8p2d8Z6SvLUL8C
	FWvicpcPD5qUW1xtPHU0kxod4ol1FX/QTq7aIELYV/FVLy1nwIJHtfDqJp/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314978; x=1705401378; bh=wCCU/d1kLLTS0GW0fA+45QZMekQz
	ArGY+W8T/+Wk0V0=; b=Nr7RJVMQQBFTJUEVAmBzVlohmi4ofaP++Gp39DSQLloq
	ArEOd/DZAtndVAYpoKCEZxojb2/OrwJaGWg8vxXpA4xLi5keqOOIY52oBh8Qmvrp
	LlbZZ37ILobnzCe/CuBkhNvcj/BOy1TGKa23zulBhWRRKRGv4PAA4L/UXM1ZeUFA
	BlQE6XH/Ul9VFYHhqYF/erUcCt8RYCkbX6ibrpfheDv0n5E3P3V1r2CNZdq2+Wqi
	UWd8ReI+Po3bckfBBw9L42JE25wylYLILqzp6K/gENz/GiAcW/1w8wDxAKmDDK/C
	veNeyapGBCeXcCbTIBeA0ir0DqiExDHMNohFU+/EDw==
X-ME-Sender: <xms:ogqlZfQff5q9UVo_0NAzASzA67agtds30pcIzu-JTS6iIU4LxFVwwA>
    <xme:ogqlZQzvu1NpsLOwQ_Tm6_7d20Q6Pd_6N0JQ2l5BZq6hraAP-jwoDZyzsUFcp6iLu
    sX16X9D1XXKSX9MSg>
X-ME-Received: <xmr:ogqlZU3oOT7W99fzJWPtYPpJum7NQrXv3dMuboUaYl3ao3io1pVOcx7TYFmR4jNr96cOm0_lbysEgFXslLr3zp4Ld7c4R3ZabzThhF0Nw2oV0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ogqlZfCCPLeuJokJ988kM9-W4curuwMucd_Q1NwSae_XPOBgccoGng>
    <xmx:ogqlZYgk63PwmQxEzAHdH3ihkauZyUWWmXe3zqUk3OuqVN63IrLvoQ>
    <xmx:ogqlZTpaN7z_hhA00DGYY5yMzLUA30eW37gt_PHMEtC8u45L667EGw>
    <xmx:ogqlZQd2rnYjUERXgczfenZn1Ot1zu54UCeNypxP-Yva-CiSJkajEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:36:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78e833b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:27 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:36:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] completion: treat dangling symrefs as existing
 pseudorefs
Message-ID: <22269af050fc9379c1049afb8ae51cbfec2a3670.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
 <cover.1705314554.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XIJpZ+kAA5vNY0bm"
Content-Disposition: inline
In-Reply-To: <cover.1705314554.git.ps@pks.im>


--XIJpZ+kAA5vNY0bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `__git_pseudoref_exists ()` helper function back to git-rev-parse(1)
in case the reftable backend is in use. This is not in the same spirit
as the simple existence check that the "files" backend does though,
because there we only check for the pseudo-ref to exist with `test -f`.
With git-rev-parse(1) we not only check for existence, but also verify
that the pseudo-ref resolves to an object, which may not be the case
when the pseudo-ref points to an unborn branch.

Fix this issue by using `git show-ref --exists` instead. Note that we do
not have to silence stdout anymore as git-show-ref(1) will not print
anything.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-completion.bash | 2 +-
 t/t9902-completion.sh                  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 54ce58f73d..6662db221d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -148,7 +148,7 @@ __git_pseudoref_exists ()
 	# platforms.
 	if __git_eread "$__git_repo_path/HEAD" head; then
 		if [ "$head" =3D=3D "ref: refs/heads/.invalid" ]; then
-			__git rev-parse --verify --quiet "$ref" >/dev/null
+			__git show-ref --exists "$ref"
 			return $?
 		fi
 	fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 56dc7343a2..35eb534fdd 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2743,6 +2743,10 @@ test_expect_success '__git_pseudoref_exists' '
 		cd repo &&
 		sane_unset __git_repo_path &&
=20
+		# HEAD should exist, even if it points to an unborn branch.
+		__git_pseudoref_exists HEAD >output 2>&1 &&
+		test_must_be_empty output &&
+
 		# HEAD points to an existing branch, so it should exist.
 		test_commit A &&
 		__git_pseudoref_exists HEAD >output 2>&1 &&
--=20
2.43.GIT


--XIJpZ+kAA5vNY0bm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCp4ACgkQVbJhu7ck
PpRfCg//a5Ezx8bMkVVl4iqJWUDb1pmev3UZpfZbcH7rhJnSmoL1GScNo9rmuvt3
zK47Tl1vxd9L1Sn2uJl79hSrxr/BXi2phTjH4LXIaGDzOjs9RQBSnD5nJ0wWc4Ld
uj/SPoTOuwtXhMqkUZw1xhmARD09UZXn9aVOMWftAw8Njl+paOs2hUNVDtpjgYNI
29f29b35CIHQrxwOVSvjmgdGFdatOQ/JceRjeapUeSE3RpCtY69qB1oLVtzYwxBz
+rcP6wVVtC1Tro/ezlSS3UN+tP81oSnjbnGTPkth/yO+s10DaH+10Lh3mWb6M6vq
5LYBJPInTPa7G8EOSwQRg1OqIEejD1SWRCtnOjIWyD4I9XEyWIK/yXi0p8NuIoEM
7Y9NuE9nneQ1d5b5jxXwxo6kH7IpwNWnuD0d9nm3isuP4Vh2WqYwehRLf6mwlQbv
ric3da13j9nccYK4tXk/TZfEyL/J3XtmPvRieN8aiKmFFrdQ1ztGXeA0eHkDJ9wM
UrdlfcmZX9HIcgIZB5MPgVgiSKTd0dtNFuktv+yFlTCL+wxwj09eLClVKROe1wBk
3gFR8oFtK7Q0EbpgPqVoE7GxXlV+mCRz66yDy0D5PcXDyA0liSMYQkZICW8tZuZB
V1gEgTtUK2AN2qbtwfYS54yBqEf2RHQWE9yGZ+8ZhYqoCRrE4Po=
=HMMx
-----END PGP SIGNATURE-----

--XIJpZ+kAA5vNY0bm--
