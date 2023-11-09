Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C310944
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aanepgTe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtPqzqod"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD412728
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E9AF35C035B;
	Thu,  9 Nov 2023 03:05:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Nov 2023 03:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517149; x=1699603549; bh=Ve
	Z4V07NdItDpfD7LBdWeRZYf90uoWBBxCu0X2mJAE4=; b=aanepgTefgMUvSUaNe
	TaMFvqjAADDAuKJpOzGPrj6EFIx4X+1A6f06ZSq9ghwzmJ/BYSMrtGKk91s1tgJr
	DNU3MQKjBrJshhXn6nXemBF7/yCKm5SXUNTceN84UcVqhXMytWE9FT42Dz7RXbJK
	gJFSPnwBCOAn+F86QFHbMSi/qQYS1Gtt7kvGHqf9Iz/+XxJpw+mqBo2PLerR1jut
	MjlNBJyz+48iUgRvpgW3r/CBxSOFbGAbimZNWdBEJidfUuyZPpSs8oTNAobVfEUF
	y/yZ7oznWK1b8Scgw1fx8AlDY5U01nExs1EUYnNoPLlOAt6vPSXy1Jia6+QtEKUV
	BJUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517149; x=1699603549; bh=VeZ4V07NdItDp
	fD7LBdWeRZYf90uoWBBxCu0X2mJAE4=; b=OtPqzqodcuO/oB1IL9K2RUzONADli
	ZOYDOhdOwxf/qBwsGJOrVC1ULlycDlkAMCQFeTPaHN0tlxqy81OIZeLUNdP4AAYx
	2YFbyfjsl8bW7un00L4t0kScNcKy5JIcifxu+KSFDNm7hfYjTUwBvBX7tkwFZsz3
	wTeWVKBU3ryy7s/seYG9gY0Td/2XDC9vh1zQeA3b5ETLI4y3p+VaIZC7B5CCVRzs
	/reLScskeyrHN5ogWRxwAXDUcMzu/pEku1qZ9puej62yzIuHmk4k8PHquUHH3rUP
	WCDdbkdVRK1be/bzjbDvR9liyVjo47S0t0Ts/6wj/MMKdaoFfue6yu7zA==
X-ME-Sender: <xms:3ZJMZUtcuRl4otxU7cBofM_Loh28aSxZwyIgUNkH0G08AiOpo-YtEA>
    <xme:3ZJMZRfK8eNvl_seckHLTtHBXJ5eyhmcdVDTw74YpzTMtj8V1B1VHVOzBedX0Dffm
    rK_HT6S6ZxwXBqaQg>
X-ME-Received: <xmr:3ZJMZfwNGIBIDelWxDBOsvDXzkxZGEoLG4MYzo3M9oPfR58RdrUkdmJLPNUM7gY3geEeiagnwt8mJFnSJZ184_HckRSIrKKF_ze5zSyHLIPnyUtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3ZJMZXPIAdi3fTCUoV9ve3SB-M2CE0Cei_uRGD6F-7GasrsstpltuQ>
    <xmx:3ZJMZU9vIVO8KwZC3_HRyR_BTG6e4ocztqzQvxDqLvnsDxl-lzWPmA>
    <xmx:3ZJMZfX69w5C9kOD-TouXXX7YN0CFpAzvzbkg-XDzd4pHZMYvt2D6g>
    <xmx:3ZJMZTk_9MV6nxo2Wov1tOZOhSZ_MQ-weLqzx7O9zfymBhHr99YLig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28de0c9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:21 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 6/8] ci: squelch warnings when testing with unusable Git
 repo
Message-ID: <534b14f02623273163f9d3950380e85d81c6b773.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="exHBikDWAPYZyf31"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--exHBikDWAPYZyf31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our CI jobs that run on Docker also use mostly the same architecture to
build and test Git via the "ci/run-build-and-tests.sh" script. These
scripts also provide some functionality to massage the Git repository
we're supposedly operating in.

In our Docker-based infrastructure we may not even have a Git repository
available though, which leads to warnings when those functions execute.
Make the helpers exit gracefully in case either there is no Git in our
PATH, or when not running in a Git repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 8357ad77e4f..04997102308 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -69,10 +69,32 @@ skip_branch_tip_with_tag () {
 	fi
 }
=20
+# Check whether we can use the path passed via the first argument as Git
+# repository.
+is_usable_git_repository () {
+	# We require Git in our PATH, otherwise we cannot access repositories
+	# at all.
+	if ! command -v git >/dev/null
+	then
+		return 1
+	fi
+
+	# And the target directory needs to be a proper Git repository.
+	if ! git -C "$1" rev-parse 2>/dev/null
+	then
+		return 1
+	fi
+}
+
 # Save some info about the current commit's tree, so we can skip the build
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JO=
B_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
@@ -88,6 +110,11 @@ skip_good_tree () {
 		return
 	fi
=20
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	if ! good_tree_info=3D"$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$go=
od_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
@@ -119,6 +146,11 @@ skip_good_tree () {
 }
=20
 check_unignored_build_artifacts () {
+	if ! is_usable_git_repository .
+	then
+		return
+	fi
+
 	! git ls-files --other --exclude-standard --error-unmatch \
 		-- ':/*' 2>/dev/null ||
 	{
--=20
2.42.0


--exHBikDWAPYZyf31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMktkACgkQVbJhu7ck
PpSxrg//fy/r5/p5ZP6nxyUDAst1Y28Tw+CcyOaZ/CcSfLIqUK6OnwuLk4L2sWri
QgsGdVEPP+ioRVuQqut2EcijPddb8QTwE8lijxCmigAjdmWKzm0BF58LgGTHVneS
EUfYeCPiDEhjI5n6N6wOPTTuDUp1bdHQvAUhKvoCPyYhzdcyNEkkITLrCkl2WUj5
fWF2Pmr50p3LTzli9TJYCJ2jG0AJ7acOQwKD/dBkSZ8EtftcvhYhPNUJc44zBf3a
yE13/YLPzgNROiE4890+U8pZPTbrlgaqlqE9ZmbA9OjopHrlVpuwBlsaQ6Nqhb7L
yTR5Gzjh469CadrXGGpN0vhNYEUhBXaj9OInxsvrQkh3/tgkfwcYHFocxKV18yXQ
eMps4iNbf/UpCBu9DOWi0q+9jBlBViz+xR+t5jbU8DBN5s5tm9PcLrfMNmT1r3pY
sRS2wExm/U0CkJtUvLEbycAi8WY9XiwKwN3J/bpmFs+tu7BGweXvpGZdAz3PMPN7
YrfZCS6UySI3JB8vi4CFMLj+fAyE9l+yCgg8pWQLPh6g8J7D4H2RkVSlk7ncYCUf
7/srqD3dhv/edD9N5u7/etOwSQ96Pu8cln6Ex6Xpb0azNAxrDjFCIOgQCSYgW9B9
KkXpkcag5044cE/YbZPyRNjGHPK2zuo1Vf9dJvGKnrTm4v7fp5E=
=7mIr
-----END PGP SIGNATURE-----

--exHBikDWAPYZyf31--
