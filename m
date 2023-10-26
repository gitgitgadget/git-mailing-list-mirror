Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4F2D030
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KQ1UlfMD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZf/yqox"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B5196
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:57:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A212E320098F;
	Thu, 26 Oct 2023 05:57:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314220; x=1698400620; bh=yg
	B7IeWhUT4cltMwwgYeY6qSBMZWncbd6TfzGypuEUs=; b=KQ1UlfMDooA54fk6/n
	YPwhVxvVe7aq21hSublLxA3LIYdeKRItD3QmrTZRCeEf8HYq9kVGwi48njBMxuUi
	O2LxqpuQ6b/VIVhV7S7pj6eMXlUGltXMVTNz9ocSqvUsSmqVUL+2tv1gyaBSk8+D
	FHs2hjmM5AfzNxKBJ6AkePGNI+WaGrO8cGpQZhaCj9R7Vhf/DEiQGaOljZ4g+Pqd
	lA3F0elhmqde9S+RKB6W4iL6cPRK0XSV/o4oB5G7X6+RZhpxZoQtKaU9anenmiYn
	kfMzaw1Gsu9oIw1IhhC4vMqjvQ5GcW0maJ4wfsT8wK9Y2YzxqWsawoD6Q0Fe6tvg
	2x1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314220; x=1698400620; bh=ygB7IeWhUT4cl
	tMwwgYeY6qSBMZWncbd6TfzGypuEUs=; b=RZf/yqoxhLK5hKMrDXI72Mb5pG2el
	L9RPnAK6J5kT3G5GH7a1X8HkH6GufsRbWLEQR/UiEBco8R0tbnwC6pEKQ7sjq4fl
	GVyKIA5EU7jd7Ij3hiWKbauOJy5/qdfjD5MdoWITdNQMVFk1YqKNHG4QnjIQuUv0
	w/EQJvYpzYS7FmUxdPMGJtXX2NkxuzjVIcrIG1tZVqJrGNUDkZvNNhtOI8pYVh65
	Q8NNepwdMrySk1VOo+zq9pFZ0wU6a1sAZ6JiMWOgcBeXZZjpcPI8llRmifRkT7Jl
	kDb2KHkNEu7pcgZrQ7qeMcrBRPnXfT7y0r8MSpNWAc26Pr1iqvfUGiD3w==
X-ME-Sender: <xms:7Dc6ZeqIzZOmHp6CcnqZ_Ju_LgJQAV_CRQKSvCvzIeWuknGl1xlyZQ>
    <xme:7Dc6ZcqjMwOi7TMkxU9YcIXsRVMPwxk1jND_2q-OvZXBIP-mxf_htz-tYGQ8pyFHF
    EMrPoBWBCQOs2xYkA>
X-ME-Received: <xmr:7Dc6ZTORvOMFhFqjbahxfIrbTpBgG14bBgdwlF0QCpuQlpopXi-JvGT3ywGwlfAFrFGBksIRCUF6ky77i6iHjdIcCkTgyU41vXzsTJlSrna9OBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:7Dc6Zd4Qpbu6BhFwy1lENFMQw2wpD-FfPLH6-YDc6FigaVwvyBTbwg>
    <xmx:7Dc6Zd5mW39oCpVzeOKzgiG-M1f6Ed-Q3QaeCj1PeNtqpqx_Hxnu_g>
    <xmx:7Dc6Zdjc5DHGMwO--rQ5S5C-iZdgK4DMtoh3K6q5H72SLp-sQyPNLQ>
    <xmx:7Dc6ZdExjaxiFxABvJ0M-4YZGSyCz_oxGeDyWPIuSRAXruxplzYeSA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8937df9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:50 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 09/12] builtin/show-ref: ensure mutual exclusiveness of
 subcommands
Message-ID: <5ba566723e8742e6df150b12f1d044089ff62b59.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hcDKNufFU0v+twX"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--0hcDKNufFU0v+twX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-show-ref(1) command has three different modes, of which one is
implicit and the other two can be chosen explicitly by passing a flag.
But while these modes are standalone and cause us to execute completely
separate code paths, we gladly accept the case where a user asks for
both `--exclude-existing` and `--verify` at the same time even though it
is not obvious what will happen. Spoiler: we ignore `--verify` and
execute the `--exclude-existing` mode.

Let's explicitly detect this invalid usage and die in case both modes
were requested.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c  | 4 ++++
 t/t1403-show-ref.sh | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 87bc45d2d13..1768aef77b3 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -271,6 +271,10 @@ int cmd_show_ref(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
+	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
+		die(_("only one of '%s' or '%s' can be given"),
+		    "--exclude-existing", "--verify");
+
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9252a581abf..4a90a88e05d 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,4 +196,9 @@ test_expect_success 'show-ref --verify with dangling re=
f' '
 	)
 '
=20
+test_expect_success 'show-ref sub-modes are mutually exclusive' '
+	test_must_fail git show-ref --verify --exclude-existing 2>err &&
+	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} can =
be given" err
+'
+
 test_done
--=20
2.42.0


--0hcDKNufFU0v+twX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N+gACgkQVbJhu7ck
PpR/VA/8Dc9X1uTaxQnhQYG4ZPiaHUjM2i2r58g/T10NKwqd8sNuMheydRY24nQd
tmH9009029zxTzkPIE+wcwdKbP08+v98gPsEnEBb9lA7tmfqMR9iBnTGZmc5AMCV
SRH0NEDQPzH8q4r5QDisBTAiVTwbcNmcgF3JB1QOuzitBB5LWriUpyd6VGIyd0Fz
zIDaBvHrD2S+pK+wERp5VW0CB5EcuNBOWbkYEoycYcm5VhsNd8f2cRddtzBtHbsT
QyKqBk/E3biXsAvGUCRLF8hDliEW//dLtNSqzhvTGd5gjt/ZiBVbV8lQ1unFD9VI
GGbCBBv+aTc8cehNPUaSXFsXv5ZQy+gl/X6EFHME2bVDQf+q6gWkK3q7wpgNJKG6
790RD8pajUGlYW0NiGyzAf87iNLkBojVf+eCX3h61flOLKmhQr133gPFcTFc8u4o
4ClhULQE80zyrospVMuT0jAJM/0GYPzX3ln8GqdWvP+4E2vpWDRETSeXXOr8AJWi
wKMYj/K3Mh65Dld8t2FRnk+Tu41DEQw3Exijt6BnzvZAlz8CnFIXVkQJC9dgeILA
mLbCWf6oi7xEQrp8yuvekhh2K0lusfuVpbZWOwYzSVbP2HbU9Z++IgnbNrtvZfVS
qMzUbt46aAizqw47pYNesA+UW5O7tIw4T+wSnE4gooMeMFsiv5Q=
=uubU
-----END PGP SIGNATURE-----

--0hcDKNufFU0v+twX--
