Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31570200C6
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w5ilDFHt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJx/uSrW"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id CBF463200AFA;
	Thu,  4 Jan 2024 03:21:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 04 Jan 2024 03:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704356517; x=1704442917; bh=UEpFXYofSi
	Fafpf7UKCzHhhz7xrxYSdApz/oLjnuIs8=; b=w5ilDFHtmvVzMtex0Z4gcdKmpg
	rLkTEEEbYP5/UxVQ+FwFDulracOChHwe3U1Dj/v7Q2FkakCeDI8A3z9hicyYzwsg
	0VyP8nQbY46Eu5ws0MRfnWmEA7CKNCT2pSmL/cY6kB9aaoHR6ZkAeutddAMQS98u
	HrTE1EojZKyslp7PyyWNMHafT875D6Na0ZpQxO1WOg8hmMH4NGyUaZjkohSGp5gu
	CLtOJ16y0kY0+wZmQl3mXNE/W8Jw6H8Tnv8TIZZQGNZVYmwqXWE3SGFzr82EVD2B
	ZiYHaPVF2nOlvkxbsfPstSg5G8+L4xQCnvVutQuV0ZCksFiuqIa+EUc2hCiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704356517; x=1704442917; bh=UEpFXYofSiFafpf7UKCzHhhz7xrx
	YSdApz/oLjnuIs8=; b=jJx/uSrWbYzU4P49uGPhYPFmen93Ex54i0uc0lkHNfw3
	OrIEl6Z9HcNimY1q9BNMkQFEH0FegMR29LwJH5hb0b7QIFL5llIk2kKbeondeCpd
	ZFv+yxrTJ1zcNCvvK1O5TinpDKTNtKr3m31teS5XHcRocQVuBHsZBd2rmhKjBsff
	9dOTOkE7A3q65saojFTHj4cgtoJ1E2SRkpmoNywnuOCio6gos7ZtxounHYJog//w
	SXa3cFBXvPM/jA4KJr3SKXUs60lPtHGXrMBBVNkeEl50b7RrBLNeFPf7bGI5Vbnh
	1cchu5sOhejHzyXvqpsIWprhybniDlA6CvN2nHQkqg==
X-ME-Sender: <xms:pGqWZS3SEYixqyz-y4xZvK6hUrkDt3Sg7is_l727ncIOyIZvE2idrw>
    <xme:pGqWZVEH3QHRZ6RycDJIOthkWBsK48iCw09p_DEDCnSBcx5_Ju1IVGTrJu5WZTEDW
    zPVuId0tYEGynhLYg>
X-ME-Received: <xmr:pGqWZa47u1OQkruV_CgfZ4U_10ODCkP01pZJOTlWheD4Fw2Vm8pykn3HvI64VOmKOstgTGGKFNOi-o97N2D4khpzb54OyxvMJ7sHnTBTRv6bRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegiedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:pWqWZT0poguy4pWMpuw25da3ikroAoCVH_4QfjP3JxBjzRC-BYl2iA>
    <xmx:pWqWZVEhmMtJauPnho0Lj0FhVWg7C5au3Zhw15e2Po2AhvYwD2T8_w>
    <xmx:pWqWZc-RR9P6fHxD2_Qrm5bWV-gVj9H7MTb6A7DhlQxM-aH5GotC7w>
    <xmx:pWqWZaSnzZeLNeuQHzBlXVmRqIupFuADbBcBNTGi25ARx5lS0Kku6g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 03:21:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e27f054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jan 2024 08:19:26 +0000 (UTC)
Date: Thu, 4 Jan 2024 09:21:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] git-prompt: stop manually parsing HEAD with unknown ref
 formats
Message-ID: <ef4e36a5a40c369da138242a8fdc9e12a846613b.1704356313.git.ps@pks.im>
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l3h/Bbg4ZJinAjpT"
Content-Disposition: inline
In-Reply-To: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>


--l3h/Bbg4ZJinAjpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're manually parsing the HEAD reference in git-prompt to figure out
whether it is a symbolic or direct reference. This makes it intimately
tied to the on-disk format we use to store references and will stop
working once we gain additional reference backends in the Git project.

Ideally, we would refactor the code to exclusively use plumbing tools to
read refs such that we do not have to care about the on-disk format at
all. Unfortunately though, spawning processes can be quite expensive on
some systems like Windows. As the Git prompt logic may be executed quite
frequently we try very hard to spawn as few processes as possible. This
refactoring is thus out of question for now.

Instead, condition the logic on the repository's ref format: if the repo
uses the the "files" backend we can continue to use the old logic and
read the respective files from disk directly. If it's anything else,
then we use git-symbolic-ref(1) to read the value of HEAD.

This change makes the Git prompt compatible with the upcoming "reftable"
format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This patch depends on "ps/refstorage-extension", which is currently at
1b2234079b (t9500: write "extensions.refstorage" into config,
2023-12-29).

 contrib/completion/git-prompt.sh | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prom=
pt.sh
index 2c030050ae..71f179cba3 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -408,7 +408,7 @@ __git_ps1 ()
=20
 	local repo_info rev_parse_exit_code
 	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
-		--is-bare-repository --is-inside-work-tree \
+		--is-bare-repository --is-inside-work-tree --show-ref-format \
 		--short HEAD 2>/dev/null)"
 	rev_parse_exit_code=3D"$?"
=20
@@ -421,6 +421,8 @@ __git_ps1 ()
 		short_sha=3D"${repo_info##*$'\n'}"
 		repo_info=3D"${repo_info%$'\n'*}"
 	fi
+	local ref_format=3D"${repo_info##*$'\n'}"
+	repo_info=3D"${repo_info%$'\n'*}"
 	local inside_worktree=3D"${repo_info##*$'\n'}"
 	repo_info=3D"${repo_info%$'\n'*}"
 	local bare_repo=3D"${repo_info##*$'\n'}"
@@ -479,12 +481,25 @@ __git_ps1 ()
 			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
 		else
 			local head=3D""
-			if ! __git_eread "$g/HEAD" head; then
-				return $exit
-			fi
-			# is it a symbolic ref?
-			b=3D"${head#ref: }"
-			if [ "$head" =3D "$b" ]; then
+
+			case "$ref_format" in
+			files)
+				if ! __git_eread "$g/HEAD" head; then
+					return $exit
+				fi
+
+				if [[ $head =3D=3D "ref: "* ]]; then
+					head=3D"${head#ref: }"
+				else
+					head=3D""
+				fi
+				;;
+			*)
+				head=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+				;;
+			esac
+
+			if test -z "$head"; then
 				detached=3Dyes
 				b=3D"$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
@@ -502,6 +517,8 @@ __git_ps1 ()
=20
 				b=3D"$short_sha..."
 				b=3D"($b)"
+			else
+				b=3D"$head"
 			fi
 		fi
 	fi

--=20
2.43.GIT


--l3h/Bbg4ZJinAjpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWWapwACgkQVbJhu7ck
PpTAiRAAkveFf08UbPFE2Ynj4jTrrVj/uMwHrwBxXHz7n971HVG9yuKjmeaP1IeQ
7yxuPaPd+1NxmhuaElGvI4b9RLSzrOBLHOogsmy70d/poXFIGNYBjwL7vRZZK3Tr
Ku9PcjtQ5eV6EUo8+tCGnlk4zm9zuqY+mKPZHDGMRbJCADrBRQHTEzbqrCS+2Pdt
MNP/dOE9G6Q/vkv+/vitu9rULjlzxwL5SLbKuZ90td7sHLb3huDNGW7y6sfXxvuV
feuKsvKU+RLwRDUPsMJFpHlhWOiflpLtrGyyaDqfh7PzyJiVTS4CuP+m3QpS1RSE
UZiueeTGZegMrOCShOnORSqgTn8Z7mt1VXunagFLwHFFljL66Z2dg80iIlo4xu1p
xsl0k8SvMKccgTK+JtS6aYC/65rtOZT2Nt5W9Glz/647yKC4YVekcL8O1cxxYcw+
8G0lUVsC8chPy4DlCaWximKrtWTsjlGpERKNh8UU3J5rTZ961z/2vwD2OM1YtfR+
hjGWyvnYDz6nljZdhyUmpRa7vtZxeqfR0tSSi+mlsOkpqb8e6UtHLw7SkbW+oe9M
/B/UC4Jsh/F3DB9Od5PCT5NIkd3jmxQr66OFkk69WZZjpa2nvs8FE/q+KnkBMKom
6jj8HSi3g9nu0s4h0AiBSvcb74/jxXyv/brWY7LEdOlvybKk+Ek=
=49Uh
-----END PGP SIGNATURE-----

--l3h/Bbg4ZJinAjpT--
