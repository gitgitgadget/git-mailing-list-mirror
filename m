Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5210787
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DBPEwuG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsdz+2uc"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205862728
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 90A065C0320;
	Thu,  9 Nov 2023 03:05:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 03:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517137; x=1699603537; bh=Hk
	T3cgvvjm+XRVeBVtKeMd2idtJUYuFvFxL3eSaAyCo=; b=DBPEwuG72f5Krof4lz
	1vAQ9/7dB2q5/n1hNCa2As9nVIWdRpynGnIrQhK+ypuCdZxMRTRfBxcDTMrhfOQb
	Si2FaHFFNPyDF+sms1UefMWRYuwVyvrG4ro2d9w21vx6EB7xmGAfBPM9StPYS6UQ
	gPYSly/yo1SpDnpWTm212ShhyAL20yeUYPq66NdXNw82VdCfW1pXHU0tUosYk3SJ
	aw2P7fg4SRxGkveLRalLNdBkD6kuvs7WKI2qQWIYJilnQt1C5Tq8iQFDRI7g5VCi
	uJyNnmnogd5kpnBW47306r2PX3FWl7oYaR+WFphECtdIGnPq9Sp687KcPwVAgYYS
	FtJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517137; x=1699603537; bh=HkT3cgvvjm+XR
	VeBVtKeMd2idtJUYuFvFxL3eSaAyCo=; b=bsdz+2ucviDev8ixZzEwpwAY8/0mX
	doKO0ZIGFNmkQfxmprFYZmFBljJO3umzl5DrAJykPplqh0e5rO2a4ZdQuBUpOPrm
	ZLEECG8fDA14yb6XVtDr8PY8YM59LhPvfykALGJlt0thkh7nll1mwih3Qdy2rtk6
	SLQ2mlKzOKYQtdwQ8vXjzj0Oj4mOsz9QmbyZetF1ho4d3yAN47m/x2JAN9Up/zHW
	zj46kJQjmE488FlCKPuSO3kdu35ueJLd54lEk0iJFXX8Df/WP6jiFORF68/sCL0S
	17qvou7kGuP4xTdLVFU7lAt8yjj4YMuTu2yean0QqYqeqFChajP1c7LdQ==
X-ME-Sender: <xms:0ZJMZXsvm2q5ASntqkSSvVYgdbhnQwKDCtZ_fa4v_DdIv4opRCAHRQ>
    <xme:0ZJMZYfVFYhhttsWxGbzVEnI_MdEuMDrza1lXExyuw91BKXgQ6YUlZHt0ezKKhjCg
    fgQhyRwGvXlzo5qVg>
X-ME-Received: <xmr:0ZJMZayM93A7tM8GtzAzSJ09xhoq2wuE53CZJvIR-UcCeUr79LvIe9LXHYVD26cHV9p3c3eimmz_7yNumeDj9iz-Bc0aJyA7jRJdKF_MrkluZJtu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:0ZJMZWPZPJ3CiGPEdZA8E62yZ154TrM5pg3o_vC8l6l-RYfbRhjXlA>
    <xmx:0ZJMZX9Fvxs_V9FAqo3YxESWFavS9L9zXPUlHY61Fus_Y07jQiYrtw>
    <xmx:0ZJMZWVN21xijCTvZ9yoH1xrFIJ-3gYxZlX8Nu4hGrY7hwOFJfdjcQ>
    <xmx:0ZJMZSl9hbivMNYTJLBYscQ-xQRxHWPUpkuCMAOPrwPgCCR5uf8t-A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66eeccbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:08 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 3/8] ci: group installation of Docker dependencies
Message-ID: <414655ffb2d9342515b26aaf197c797e8d93c646.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5bLVF20i5GXx2JR2"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--5bLVF20i5GXx2JR2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The output of CI jobs tends to be quite long-winded and hard to digest.
To help with this, many CI systems provide the ability to group output
into collapsible sections, and we're also doing this in some of our
scripts.

One notable omission is the script to install Docker dependencies.
Address it to bring more structure to the output for Docker-based jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-docker-dependencies.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependen=
cies.sh
index 78b7e326da6..d0bc19d3bb3 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -3,6 +3,10 @@
 # Install dependencies required to build and test Git inside container
 #
=20
+. ${0%/*}/lib.sh
+
+begin_group "Install dependencies"
+
 case "$jobname" in
 linux32)
 	linux32 --32bit i386 sh -c '
@@ -20,3 +24,5 @@ pedantic)
 	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-de=
vel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
 	;;
 esac
+
+end_group "Install dependencies"
--=20
2.42.0


--5bLVF20i5GXx2JR2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMks0ACgkQVbJhu7ck
PpSNphAAhlR9SyIB/vQMPPFDBq1qAAsBGhQqazAZkoXNlgV9y3V6IQiYh5ezkh89
1o/Wnz/X6cFpZyHlV2W7NJozCdssbweHhrw50Dhs7e/uqZYbJalfIrj/5Xmdrl3g
6+l3EuDNdAZELiwhQ8ktr61Is4f/xeEQNRA2JjbJ+t+njodLPw7DaEEFZ4kjCsuj
M6flhm9srPT7nzul7wRF9yyvOsrZshqz8dkg1spR6JSA1ev5+JkhK510NI9yIWcg
FRpgBJs6tUYupJjE6784tgO+WJz7gr7MCumZDqV7fMeiiii6cE2y1mjcDehaqKSf
zF1dW+6Zis7JH3SRnuuZsCATzMHlIjYZ/OdlmRudVGY1CjYEOk9FOXs9qSRwJGVz
CHURPqQ2C+EkF6tEROlqnuuKBDZaSvlBkJ8uzE9D1gFe7XFzsmW6L5OnTFs9PX3F
KTfzazWTiT2n7nLlpE9McUuGCUQuQRHe7/tBradqydPEkAiL1EeE5UfsPj7Lyvvm
7IiaFawMLYr8fvhOI+wmnOSwfLRv9mPIkdTOM2xskXe4u9EreZcIwptBqmfFBVLS
89fO6oxcFwHzZa3j7H26HCTPRk/glYNZnEbs030VbKd0N+gJSAkn/inrxu5fYwxg
XPit095HDZEvzRrVWh9InEiu5gDG6rKof5FhNU4o+hdX+iobYto=
=BwwI
-----END PGP SIGNATURE-----

--5bLVF20i5GXx2JR2--
