Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285833E49C
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qZVgDO4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EbHxi4o0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0DCEB3200B4F;
	Wed, 10 Jan 2024 04:02:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jan 2024 04:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877322; x=1704963722; bh=pX0vmVJoFU
	1KAX0JhNsdfIwq38pXPRueRRT8g1z9Jiw=; b=qZVgDO4fihKhLZY2MKKUYjPWF1
	EYSqYEFFt+v58bPsLlbuNJhKv3I/ucDlTmgYMgmRAIffl/5Mug66JPixNxOpulVa
	BXK1WNigL2t6jM7y3TnBiPES7ep/Bnu0hmpMn6rZw9m+1FWu8eV3LDT4NNGWrV2c
	32WyRoA/yvRHHppfhCZKcnTkLAAVj4gdvSAOlltEZvR/Sastzx60I5VPhN9Y8NwK
	aprWmDsuAxrnJv9wBtJ7kEUAauvEmyuDwiZ2LB70L4vMTVSb/ZYUaI6SLPcTf4Vl
	hLfH4pk8b4gH1HHuN26FNgHNFA3QfiNw/17A7mC58KF6Y0F/NupkGgYvZ1lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877322; x=1704963722; bh=pX0vmVJoFU1KAX0JhNsdfIwq38pX
	PRueRRT8g1z9Jiw=; b=EbHxi4o0EGGZwPwYMvHKT09yKlMbUNSCcj7rUWsS0vH9
	ztcb0AyXFxzNyq8Stw6qT/8kCh6WLtC0uL4gAy94gdHNFmIGeP1NbnnhByTTSoFC
	XLg9gCrFxN0CcNRDwcfKHAj0ySJRu21XqFoqcTf1FaxR3fNkczK3Raq2joyWy67x
	3uzKWNQQtl0QmDKJ10UmrGEcTNwXZbST0oyXUd6Y2BbisBOP/mmUr0lzrTXLI+jF
	58dWwwfOcuNPBMt4ozlkc6m9TWZWA8qNRUvNk8GUCQ2yefIABSy1O7xCGy5I7Daq
	wBOzjxZSobi8tsfwK09D1Pkc7T8E+b6UF4FKNgI1eA==
X-ME-Sender: <xms:Cl2eZaeGMvEe-MIBqEr1__vAzpqffbXCDKjHCPuvm8RXaCNtUyaydA>
    <xme:Cl2eZUN7Z1M_Rz9twdiVqs_VUVHTgxJ6z8PR_1_NMFDkyIFnhKp1OQ37uWhCxrV0j
    etjdHVTqBqZ9WYUOg>
X-ME-Received: <xmr:Cl2eZbgF8i4W-_BKUlRkB3QMj9c9skLTcv23gcYho5uVGIeFhKrpSjIxUEPhWxuNGsWTPepkp7kOdjiqbqupXQfO-HzHN2Q29AfB5fhKo0ZFvPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Cl2eZX8rs4hrpCrred_kyF5roEDgU9LuD4ixXMwsnJ7lo9neNRv_xg>
    <xmx:Cl2eZWtjtaS-GVMc-6A0QyOcyJDUVEHGd1h3SD2iMcV4Uu-tf1dz6w>
    <xmx:Cl2eZeESGAoDmmjAjkHs8A-vwCx7tFcQIcRP9--ewR_JlupHRED7JA>
    <xmx:Cl2eZbWHzixLvbZHXcxefWV4ZxULobf3syia3O4nnC2FyovS2Bdz2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:02:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 79edf649 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:21 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/6] t: mark tests regarding git-pack-refs(1) to be
 backend specific
Message-ID: <df648be535737551ce7b6d6680841c7ac9ec44f3.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c8IaOzmnhpa/D/A1"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--c8IaOzmnhpa/D/A1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both t1409 and t3210 exercise parts of git-pack-refs(1). Given that we
must check the on-disk files to verify whether the backend has indeed
packed refs as expected those test suites are deeply tied to the actual
backend that is in use.

Mark the test suites to depend on the REFFILES backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f23c0152a8..7748973733 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -5,6 +5,12 @@ test_description=3D'avoid rewriting packed-refs unnecessar=
ily'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7f4e98db7d..c0f1f9cfb7 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
--=20
2.43.GIT


--c8IaOzmnhpa/D/A1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXQYACgkQVbJhu7ck
PpQakxAAmErnxmBwnefOttYwrGZaKcY3YDH1RizPPUoI9Q5WP0Rx4t+s/Lnpl5t4
Ivb3NHRa0T/sn0ooBwX/27n/WrWinJOOzI2reEBNEOCO3coR4T47y+eWPcXUdFV3
RUJAHoC4Ix2Gw49ulhpBmPZUqi/9duREkJwcVeoCVUxGqrxl2yrWRK4UDtiSl+Kk
Pt+Zz9F6gp9jN86yzyrNW14N5LnGj3RiO7aJgA7cNn9zc8EYA2eehVLCM0kEwqxC
Xj5yStPwR5DHibTS+CGivW0+5yMmfmcnn/scGrz4Ugf0oQvAHusJM9B8MqWJ+1Cs
Ul3wh65CHAZ0gxZBMfW5+cVoIqKYoZPXZj1ePLAlUTnLXiKvqZLVbbPmqGYNXs6T
2F3VsbO+6MQ5QH85G1L0V20WNjv+4aBtvHbZjzWl1ip2RvsNOdLts1XlLme6xMa5
6NmtNmBbI3YkR+NPy9Q2WlzMdILHT5GuAX8OtKw7Nkqq7dP1hPF+yTcgHsN0Uqo0
xS3p3aA/2w8NnT2jNxb3CEpkBf0LhnSDdpVrcnx92Kh4StejQcxdA3ZhoZ9Uf0/B
p+vdkyRI4nkLQizpOw4Xs8xVoLTpPH9dCd+vl5nhoFgq+5zpZXaywnXwYiCwCkD2
a8Y5HaG93Io35WGqEwxGTmQM8xBCLsPDLiYkaTxXzTKhxbmiU9g=
=aPzh
-----END PGP SIGNATURE-----

--c8IaOzmnhpa/D/A1--
