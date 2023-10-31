Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123513AC6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fRpOV336";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FD2EUEaJ"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54DA2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:04:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 15A8432001FC;
	Tue, 31 Oct 2023 05:04:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 05:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743093; x=1698829493; bh=qa
	4CdCuRnvenfmxGO+tLqy6c3DBmf/3+B1n98/Uf7WE=; b=fRpOV336Ez+4IMUJ1K
	zsm5unaQ//s0YoGJ/MdY7VIILkox0oLQK69mpo66ffteuMXDw3chTYKmhMG5aCeW
	HkeOve3L3tlZl6PwVNOAOdcJkqF7EziCMtg4G7zgU4IjUJrATtzEtqPejoTgyOTP
	XF0mg7x5Sm4jByuZJu3lG012JzCqUVYoOg69lNHCO2PCxnUX0hPqJnRsM6Id5gsX
	Nwkuzr8X+9D5Vw+idX0pRaNouD22lWY2tAEBxMEiIz9PXYoe1nCTREMKY+i6iZGc
	GzUMXe9j7x3mZOsJdb1YBz8oOCyKsJK8Q+Zf547POL1vb4E/c2qUeIpd1dk+K6fl
	tUNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743093; x=1698829493; bh=qa4CdCuRnvenf
	mxGO+tLqy6c3DBmf/3+B1n98/Uf7WE=; b=FD2EUEaJKW6+aahDi9PjmVJxOH963
	VoAoJNr4uG8cxehhOBNQVxXx+0JEZABOOvA5nrgdyUWpaSswacIWQd/fczOellqI
	yqwQKZVBHyZdxjkcbD0BViQ7l6eXec+WRrI5W6RNJYCnkJQHnbUdjyAw40SKkZZ/
	WRk9p/aGnZOVecU9RXii8hKC52/437EzhpBafYHSjWykRRSrJcx9wsaJbnqcf/CY
	4mHRhDRVRTThRN8QQA3sMc2VkJ9naAmonrnZZU+ZZ8mSbingEDq10QYUK1tYPxOa
	TPh3YlFnecCAFM9d9+5I39ECGNu8MrK0XHgMiFTUQnV+YP0IayFxoZSZQ==
X-ME-Sender: <xms:NcNAZQnrwOfSdkjeHACXNRM5EaUmzm7PKU7Wc7btr5yabZG7bop9HQ>
    <xme:NcNAZf1EkMKAgX0NCzadzsTPdG0v-XuS12xyVekvsgx-VV9DmvCOg5goMnyfnW-Hc
    S1bWW_cEzV9ksS9bw>
X-ME-Received: <xmr:NcNAZeoFBWx8RVWKCFgXiAQ07-IAuyjZY8nBZUp05019hkPPXR4H2eGeGQYPQHApQvv_l_HJLcSbOkcBU8S8vE4pXLhdV4yZebmRPNJZ14wIh-lM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NcNAZcksDyYpAZmgm2o12WZyBXogEe0v3RBjnDw_5ztvWnQkP0Qs8w>
    <xmx:NcNAZe1rQqpPkjXcbV7nhg4d609NyaX9A48nDwZIQqec8qKFja3hrg>
    <xmx:NcNAZTt-obDImRv5vpKDkG-GubhyQsy64vasK7WEUT74iCbpdzOzgQ>
    <xmx:NcNAZTxQZ9v7vh7JIzvuZq9bAw9g_E1KIQAc2XfbL_MtSnpkEfs9dA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:04:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c163f161 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:44 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 3/8] ci: group installation of Docker dependencies
Message-ID: <6d842592c6fb085b40997466d117637742de44d6.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OzBsVX9L1nHmS7sc"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--OzBsVX9L1nHmS7sc
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


--OzBsVX9L1nHmS7sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwzEACgkQVbJhu7ck
PpQBmg/+PUm0clX6enpEEP7H60NBP1DfCpyuFS1kbZbFjAKZ9NJG0YIbakkjnrEF
DSmYIInz69HyeJFOrL5EsjpXhIZPiFIHBP7L6V2Kq5qf1l1QJkwV9luSu2vZXPEr
dfgHs27QFVe61JIKbMgn3ZKzr+jC7J+bBxsauaw3354bXTTFoh6+w8KMT06yD/9r
nSULjXx57Cd3jzvP+wfdV6pO36fU36j3DYJYWo6gub3A7AUcgYsb50Yet19Uc0hx
CMuk3Sw2jtZ8sJS+KLv2sMrTFm7MpH4DGXnPeOVpgN/+jJQduvED0oiHO4z+hD5W
sMKAr0to9BQL17nugO2EpOMva+eEm17nNVYyhV4lHDkmgWGxb+R0mIFbVC3xlKcm
AdnhgiF65MNAhVnlsuNJytYsyLOc9VMwr1lR5Pnu54CtCFe2MLwJ1sO73AFJR/uI
VWVFJ9cXLC2hyO1suSrfB14ZvJtdOzTJf1VhFTbcrGBVUckRzlTrfIl6vGHKjIov
jVtBtpMskA5bxcUwO+rr3TuBrtOve9fELNnlRlSTQFdtzihjW77VQIyLvGF79Cqb
nKslxCWnSXi6JpGSYf6GnYqoRhJrD8SJ3hNRS/9YH01HuG4OKSWU83q5F14r6kOb
+VlS2OBRdd8Fge8HENmlgbCRlN/2omN0nh4+uWwLZu5mG8PosWA=
=Q23d
-----END PGP SIGNATURE-----

--OzBsVX9L1nHmS7sc--
