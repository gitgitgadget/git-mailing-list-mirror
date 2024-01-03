Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A062F1799A
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gbunOJ+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NmtO6noT"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 88D895C01DC;
	Wed,  3 Jan 2024 01:22:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jan 2024 01:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262935; x=1704349335; bh=Y4tzJ45r/+
	RjhrXXIK89PFK2Y+AZPkz7gE0HDvEkL1Q=; b=gbunOJ+gaNrC8a48t8NInxfwhv
	jQWytPcMXB/0oAoxFCr27CgdEcifG6FiglJR7+RoUoSCEfFKAb1dWeR1NBgjDBJ5
	2KTjeCSVuBgkNygT+46dHP+wS3y+AoUtfrAq4vj54J8oinvTuAW45M3XYsAPuVyo
	i2Qq6/yM2M5NC/NLWGjk7Ju4U/WemizhcmphnuMjEg68MGRrvTudBS7CjJ8YhZk/
	8b7VkxRNiuD1DMgg86cpTaPQ6rIC6ZXueK4XSgMqa4Ypt+qY9VZUqMT3lN1mgNiz
	SAz++jiYguHXr3FvDm9MYwrw2YmsZpuTyrCFmWOCW8k2AeZiQlCB6+LTgyQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262935; x=1704349335; bh=Y4tzJ45r/+RjhrXXIK89PFK2Y+AZ
	Pkz7gE0HDvEkL1Q=; b=NmtO6noTJ9K1gwhh7T04IN9ImWSn1VY2bFk+kZ6sFQNq
	Zv7ILPEra+0QoiPt7S/13LTDrsyTf7O3Szg6FSoFX85sRjANlsIBLoAOldIoryYQ
	v6dFN2K6AsmNgB97C4rek6J8JIWOOX0Xyuk5Prl31roao53NtSQ5kHatmD1h5idL
	gYnehsw3WCseRjHqlFld6T3H+4xyrivhEnbxQmqGEcOUS7/ARxheQc03RQi2u0Tt
	BgG+8Opb0LOBALXzIUybfZdoxm4n/AwVcRx+8EaeXA4pg5AVJKoDGHtAR3CrOt6o
	DvxbANRS7K+1AzS4I1b5Lqftc/GM630XGlDyzKiHDw==
X-ME-Sender: <xms:F_2UZe4J3O8yEMkHiFa-QQ1QB1dtmgV770Myx_cmXj2bNl8__jcb7Q>
    <xme:F_2UZX4q-qS4mCqXXVc8nHOfzwuJPVAyuRKJ-vKaisMQ7-znysj-PqkoO4Gu2QCmm
    j-dPSpjhr1JEfilFg>
X-ME-Received: <xmr:F_2UZdejOWj2K9ToJz_6VAZ9NVaj4SlUaEAQ7KPGBREjr14TxTqH8kWvEoOBvg8JTuLnGd2sWsMjK-1bVEDj7_g_6I_Yo9wx27mEvKW_vn-nLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:F_2UZbJY1epVY8GiPCm28HIjp81d9_LKT6vCDGLysYVIWrAcDxNeHg>
    <xmx:F_2UZSJ04gZIq366srRlu1_3foiVD8xtMqKrK5XRCNcXare8NkXGhQ>
    <xmx:F_2UZcyaAG-Q2ArlTuQzfnpK1PDNzk3aeEMptDxZ2yiF72eYOJAiVg>
    <xmx:F_2UZUgIqEIc_OZp3EllGx7ShvQxOInd2_2PJmxkJEOJcTrH1ePYNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bf19f5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:19:49 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] reftable/stack: do not overwrite errors when
 compacting
Message-ID: <1dc8ddf04a112c38f41d573a48dac3f99b4b51e9.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzIVSIuE6zdxVcA3"
Content-Disposition: inline
In-Reply-To: <cover.1704262787.git.ps@pks.im>


--fzIVSIuE6zdxVcA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to compact multiple stacks we iterate through the merged ref
and log records. When there is any error either when reading the records
=66rom the old merged table or when writing the records to the new table
then we break out of the respective loops. When breaking out of the loop
for the ref records though the error code will be overwritten, which may
cause us to inadvertently skip over bad ref records. In the worst case,
this can lead to a compacted stack that is missing records.

Fix the code by using `goto done` instead so that any potential error
codes are properly returned to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 16bab82063..8729508dc3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -801,18 +801,16 @@ static int stack_write_compact(struct reftable_stack =
*st,
 			err =3D 0;
 			break;
 		}
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
=20
 		if (first =3D=3D 0 && reftable_ref_record_is_deletion(&ref)) {
 			continue;
 		}
=20
 		err =3D reftable_writer_add_ref(wr, &ref);
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		entries++;
 	}
 	reftable_iterator_destroy(&it);
@@ -827,9 +825,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 			err =3D 0;
 			break;
 		}
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		if (first =3D=3D 0 && reftable_log_record_is_deletion(&log)) {
 			continue;
 		}
@@ -845,9 +842,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 		}
=20
 		err =3D reftable_writer_add_log(wr, &log);
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		entries++;
 	}
=20
--=20
2.43.GIT


--fzIVSIuE6zdxVcA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/RQACgkQVbJhu7ck
PpR95w//Y5HyjsiqGfcQBU0aEXHq+rzqaIOQ5pan1/brmBYc+oJFthsvYR11j0+P
lJnjR4UVVEaenRRlPdJscfRufCC3NzCxnrzGZjQambsaZLOTBWbzYf0ybiSPkSRe
JuYlYqjGNLAlrO9mEr7rnYGU/i5c49dRUdqQA0ygOBdGyFOsPka7zo/LHhEl2JtX
YlpBLKslLaFdgPJ7DmKesFCEzWQKvTriwAqF4z66qW8R27W7U5pP84MLFDnFRaL3
L2/+Ytv3YrZLf7luPJKoRl02PU3k4sbiDhCjbJawxzoUC8NMBZUbLRuNw1cOSH1/
SKkRlTgnKbUk2FUjeW7Qn1CG+TdFu1Q/VbV99+VaprA77Ymd00VqRo08VOzoeiUT
zuPdf2elnD5+M9Yi2erPE1WQMdfjCVvA3fCyCHK5UxaOLX5ZeUf4r5fXHAP03Ptt
uDFx/4IJAFsIIzgS0H3ojYeteoSdM0Fl9Hu77D0+lEcGyF1nC1QBZ3WCSIBLlUgo
31maTRP4tSsDPrjxE8NU2GdpXj32WKqcNex5VnaGIMS+vo/OoIdXL8oa08d0uDyU
59DAO8O+NiPHPQWLmozUDAYgO0vQzbQZGjz5I2XSizZ2h7KfJbLEByQ3ZkKRcdlA
69xOevrkieNy4Ue5oC7SSkRroUnrfRurtUStDDwmXwx+LtuoaR8=
=WaMJ
-----END PGP SIGNATURE-----

--fzIVSIuE6zdxVcA3--
