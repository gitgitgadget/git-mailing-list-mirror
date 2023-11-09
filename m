Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D4D10787
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z+Cwl8Iz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4ycRR7T"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A62737
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 567265C00AF;
	Thu,  9 Nov 2023 03:05:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Nov 2023 03:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517141; x=1699603541; bh=BH
	/yRn+k7d07ViP3FBTEyj1f8JyqGkl7/23Q62EEFLg=; b=z+Cwl8IzSrcT0yBF82
	PlyQnX91X4vBfdcjdx5PJC92nQGkFdt10wWpRjcUTyOt0RKUvrG35hLfTghSMisd
	A8S47lOX3+aSZltag7PMabX0Fr97+qvjEfWhmbFDYBpjKLVG1heEdzZAezj2KW6W
	umG8+K2sKceI4XnFUPhhLx4vgexzXIyiP6VS6U4HVcQkMmMUuSbzf7w8eaSNP8wv
	fkkHJuF0v5lfNIOJDFe8ag2HiWedT6lMz2kkv7/gzg3aY/93cKSRQQxmJ7FnOndg
	wQtjLpMMeO1godljOZHMlWO4iteBMUMbP4YwmpqXFqOy4kTYECUSawKIZc85NhkU
	Fy4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517141; x=1699603541; bh=BH/yRn+k7d07V
	iP3FBTEyj1f8JyqGkl7/23Q62EEFLg=; b=S4ycRR7TV8eERhkfivbgGglCktW1r
	H3A1v8ZM7XgYtLuLS9qK1jvSjwF7MV0d3Dm92YuhBF+oSKX0m8G4ek/LAqjnkrMd
	IhOjwphOlJ7nVcuG2+REs16ud+YpgPJ1oFJl0DRmZjbLDxRdNxPvTNjq4phPcNtQ
	iAO2QH3MHZYaii9v8Ebre48yDrBhGuubbb5s8vu5s+fwOquKaBHJYw62DHu35AWr
	ULrfU+J5lJaQk7RpRZqTaj+X66HbhSvZK0CB2wZYh9UvfYiW4c/yVoZ3BASWpUgH
	2OYEqhJVv8a0nabG355qn6x7qXgcLUdv5mRTlBdyCX8e4iUnxlUG2CXXQ==
X-ME-Sender: <xms:1ZJMZa8_tFjKQ9ztud-CjIX8NifR4cBwRqeLk5LylocklnNoe2SkVQ>
    <xme:1ZJMZatzQHVgjR0gsci4dFFE5W7nlEAplXjh_hFkrr7l_otZiFA09CztllzzotP4d
    nEaXAZFwGgQtnuS_Q>
X-ME-Received: <xmr:1ZJMZQA6Ybe38oc-9jPrs9_NDilTjDYSvSqVwAVnuAGMTrI6syg-Hm5HHTpJq490UYmKPVK9ZNd67QvxroG2xAuWwyDGTA31W59pIr3R04PxU8yo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1ZJMZSceZSu2m9TknrP1wzJTkb7x0mIO9SdXkahIZx25KOI3Rl4FRQ>
    <xmx:1ZJMZfOkXC1-kvK7J8W1Li4Wxy2SVmglJi66WapCw2rlCblCWvlFsA>
    <xmx:1ZJMZckpj9eCYCmWJ0lgsXTeHTNEgw0W4s40M9xz3uHRkoW9jiV9pQ>
    <xmx:1ZJMZa3m-ZBdOiGq_h1llrO8IkvEd_vYm9T_l73mcB9KjBzOECKllA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 844996f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:13 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 4/8] ci: split out logic to set up failed test artifacts
Message-ID: <96d710faec83daf965cbd7747c703864f4dadd70.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jExGm48A1BZGyT53"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--jExGm48A1BZGyT53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some logic in place to create a directory with the output from
failed tests, which will then subsequently be uploaded as CI artifacts.
We're about to add support for GitLab CI, which will want to reuse the
logic.

Split the logic into a separate function so that it is reusable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2ee5abeb02d..6fe3c08be83 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -131,6 +131,26 @@ handle_failed_tests () {
 	return 1
 }
=20
+create_failed_test_artifacts () {
+	mkdir -p t/failed-test-artifacts
+
+	for test_exit in t/test-results/*.exit
+	do
+		test 0 !=3D "$(cat "$test_exit")" || continue
+
+		test_name=3D"${test_exit%.exit}"
+		test_name=3D"${test_name##*/}"
+		printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m\=
\n"
+		echo "The full logs are in the 'print test failures' step below."
+		echo "See also the 'failed-tests-*' artifacts attached to this run."
+		cat "t/test-results/$test_name.markup"
+
+		trash_dir=3D"t/trash directory.$test_name"
+		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
+		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+	done
+}
+
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=3D${TERM:-dumb}
=20
@@ -171,24 +191,8 @@ then
 	CC=3D"${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=3Dt
 	handle_failed_tests () {
-		mkdir -p t/failed-test-artifacts
 		echo "FAILED_TEST_ARTIFACTS=3Dt/failed-test-artifacts" >>$GITHUB_ENV
-
-		for test_exit in t/test-results/*.exit
-		do
-			test 0 !=3D "$(cat "$test_exit")" || continue
-
-			test_name=3D"${test_exit%.exit}"
-			test_name=3D"${test_name##*/}"
-			printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =3D=3D=3D\\e[m=
\\n"
-			echo "The full logs are in the 'print test failures' step below."
-			echo "See also the 'failed-tests-*' artifacts attached to this run."
-			cat "t/test-results/$test_name.markup"
-
-			trash_dir=3D"t/trash directory.$test_name"
-			cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-			tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
-		done
+		create_failed_test_artifacts
 		return 1
 	}
=20
--=20
2.42.0


--jExGm48A1BZGyT53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMktEACgkQVbJhu7ck
PpQIfA//RIpgl/RwOmBnCWfcTJVa7QzOa/9IbzQxHd9O+pRv1a8sR+SacrxfNb8w
7+z+plwrrhx11OKVQlVg/FrxYW+E0BRAymzDRuyJ4wIm9SCXWOtx6l62CHpifhHj
65gJMPAqDsLphRMS9iugeKQGrq4W5oH9UPKt8wISWkVSh2l6cpMQwDvFMJu6b3F9
SeccYkb7XOFknlglU++XUNxa39T4GIoemOQpgAvHwS17fUQIL4AL/2btU3ocg6mQ
Hs9TWs/hxP+kodXFD8n22l7kLDYjYyXR8S4lrr6WXuPhdH031Xo3gQLZ1VMnwL9C
l1rIpOekM+K4Bais6cI9HGzVftXNW4virJ4XemVFGGc7FObTuGOqvIXqUfvItGgh
RvOL2OxbbfRqaerJfUqjtAkV3Z1762VHkmyL7eiVB13dQT56iPHd/zvb6xoDXv3D
7K5b/S6GVnAAmc96hNg876OMR1Qp9nFIgciNckIJWfcJDjYiDvGvOkem3YCS6x0G
+WM9swul81aP0ohs66nLLhTjhSDUq3nIocXLFCF6+z6YT9HwfrQfh6s4NAZ7Y2zm
QQwLlZ8JmzD6BCCErG2dlmWskCrMW7it0k1GBEwUUxfHGDxZoOElcSFKWwSlj/XG
mbiIhanldueJS2Lld5KD19uld8LMAaVEl8CORw5UyABfrve+0yE=
=T0K8
-----END PGP SIGNATURE-----

--jExGm48A1BZGyT53--
