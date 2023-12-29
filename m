Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA023B5
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y+0ugiif";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwm8xqYN"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id DFED35C0180;
	Fri, 29 Dec 2023 02:26:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 29 Dec 2023 02:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703834789; x=1703921189; bh=53J8I4VJuw
	XFrFrit1FX6vtx4cZym7HamKXTAjYPnt8=; b=Y+0ugiifGtZSpg9pfEuaL91aCd
	ekb4VM4SjfVE4/B7R2o01QyRNk5W/c1/8oRmwsmk+DVzcxoC+qwqqwikSA7UHYN6
	3xSkODAeMNbIpHasK9HAE22nLH8+IzZS/iFZVys3K+N1hCYqk/3XEZiMeOLrYBuT
	0YV5jRRvwkqME95SL0IQfBUnY0USF7kENUpkkt5MX+tqLxdAEm7luxNwbsqzwSge
	1xSDOG0uUgjWD/GmhVYjBcLMCKatZvK/xhKzRLInLMf2CQXMV+/jQZK4kkbkGNMw
	2Nk2qPX+xY2918EXUFjrcv13RPx7PsvGuvSEeOlIfMMBcz/fbDySJcOWLOKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703834789; x=1703921189; bh=53J8I4VJuwXFrFrit1FX6vtx4cZy
	m7HamKXTAjYPnt8=; b=fwm8xqYNXANd6EtoGw8W5HFKr1pAN+WRsFgKtxbSNg8b
	y28mtTO4GiWkM8lCOzrUIDP+vZA9prIWpvBqVvGFjYVQWNNFAOkO7TwBHD/FiQR8
	4+flzjkABMNMXDlWiovd/pDcl7p0RAk3w2ZMF6hMn+BqeOz4Gxrb9FDOS7PB53cf
	zE108cnWw3SZUfk4ZOyil62xMSQKVgFgIAv/kkN87p4e1vdHQoc4FBZVOhpnPxHe
	5R0oFCthrWnecRBjGAueW9D5b4jNfAt98kwNXH9W7l3z4MhqRiatupssAOeDae2a
	8m2i1wT8SMBw5xcGeKjcPp1cnfTLouboMxSBOvBsmQ==
X-ME-Sender: <xms:pXSOZa0iWcn_NG8TuSCOFfUHOcfAMewGgnN6vUvTq0Nw2y233qvz6Q>
    <xme:pXSOZdFNjRWAQRGuju26tEuaPnHSoxrCkgSLeblfnmjKLfNO2Wfd4Rt81bWmIoVNV
    mip7I7ZBF1uQ57aKg>
X-ME-Received: <xmr:pXSOZS5AIBMVt8XiB67GFoLv6xlxkVrIXIBiNrkZYJF5NHWx4qTpUki0w11eQVCq4vt7wLm4fPdc6WoYAH9go771mXTwqzOiKcrv-VYd5Ak72oEYKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefvddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:pXSOZb0TsHH-_ZJ7DU6Oc6rnuwOOPy6UU-g01ZgxzNEOLU029rhbZQ>
    <xmx:pXSOZdH5M-5wLAwYlfXMvHHTUG4szMQH5Z8FbFEyMs5L39k7CBp-Gw>
    <xmx:pXSOZU_AJSr7cWI3MCzdUGWRpOHK9dijqImEM2RiTqwKChHCkzJ0_A>
    <xmx:pXSOZSQQ3KNuaxHIaSaFnLXGcBJi6YlU-4PyR38GGcbY1tEj7at7OQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Dec 2023 02:26:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d9cc5d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 29 Dec 2023 07:24:12 +0000 (UTC)
Date: Fri, 29 Dec 2023 08:26:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/12] t: introduce DEFAULT_REPO_FORMAT prereq
Message-ID: <578deaabcf5fa608a62993dd7586d7eec272c4e2.1703833819.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
 <cover.1703833818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yFFbMLkbrvkFX7VH"
Content-Disposition: inline
In-Reply-To: <cover.1703833818.git.ps@pks.im>


--yFFbMLkbrvkFX7VH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A limited number of tests require repositories to have the default
repository format or otherwise they would fail to run, e.g. because they
fail to detect the correct hash function. While the hash function is the
only extension right now that creates problems like this, we are about
to add a second extension for the ref format.

Introduce a new DEFAULT_REPO_FORMAT prereq that can easily be amended
whenever we add new format extensions. Next to making any such changes
easier on us, the prerequisite's name should also help to clarify the
intent better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3200-branch.sh | 2 +-
 t/test-lib.sh     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6a316f081e..de7d3014e4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -519,7 +519,7 @@ EOF
=20
 mv .git/config .git/config-saved
=20
-test_expect_success SHA1 'git branch -m q q2 without config should succeed=
' '
+test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config=
 should succeed' '
 	git branch -m q q2 &&
 	git branch -m q2 q
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 876b99562a..dc03f06b8e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1936,6 +1936,10 @@ test_lazy_prereq SHA1 '
 	esac
 '
=20
+test_lazy_prereq DEFAULT_REPO_FORMAT '
+	test_have_prereq SHA1
+'
+
 # Ensure that no test accidentally triggers a Git command
 # that runs the actual maintenance scheduler, affecting a user's
 # system permanently.
--=20
2.43.GIT


--yFFbMLkbrvkFX7VH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWOdKEACgkQVbJhu7ck
PpTP4g/+Nn7M7UqpYZhrLZoNSoiyWnNZF+5h94i9kRWnilSFLaEOgct6iwcLqDyi
sXEcQr24Sc4NV3DqdMCg78B2SYcmGDbm1tXtjuQ9JYn/PY5BePcG3qd0fj13QfJo
B9u1gh5OeNrSvHBL8m9vTxpTl+FsfLKqPgRDk7RPsCEa9cxvPbNhNnqknqKipL2z
8+PVDYv5Mn80dFqbxb7G0gHoN1xMTJVyFPVUpI/u7wubBsFoyoMdJxQTbr0lpzDF
tT0OKLHS9ahhSrluIP1MBz4l13SAnGXUGNjjSwykiQ1P3tq+SZyoqnioTEEPseJ8
ZZzW1uhnWC+0GwDtA4W1fH0H3pBMIMwHzg9nrTthbfGpB+nqxS1FKCYdIg6Izohm
mhvjvOqS5bguIARKaenswcC0UQ43v6dftawC50UNRLTk7Z1F4ozhOpRQ3YyIAYzh
5j73UCeUwX8Gn2P6ByZ9YfICKRURlvwrTOetKjHujW9N3jc1bH0b+G4ek5g3vNSd
pqy+zN1PNM68Cj8S6o5QhyqcxUYk8gdub5PB191bfLKSQ/K9HmYlrlKXzZX8sF+y
EPx49YAXPejRyIHAXdkMic/jEjXigjEgOunIVXDprA+uRGF8Vgwad03PXzkwRqyt
LEvSXeocjwSakys4c2KnDDfYB6BxIGrCzi1lIFi26s+OrwNHNvc=
=7ttT
-----END PGP SIGNATURE-----

--yFFbMLkbrvkFX7VH--
