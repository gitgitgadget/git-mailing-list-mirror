Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE73C16
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E0oPraUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufhg5GE1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AF4AB5C010F;
	Thu, 28 Dec 2023 01:27:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 01:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744859; x=1703831259; bh=eOm8G2tJDF
	3Dqla/n8CTufL1OF0PMSdiQhDl4GZAxoc=; b=E0oPraUxjqSU/PirfkCtF+Hvyf
	MiZj1d2eLZ99ur9axZdq6Ox212W/S371PPlcLVUuRgCmiUCT4TmZtlFAbb0rZ1kp
	4xNyT7GPT3m63ipwAYGQhYrMhFcnsbyTvFhc83uZVGPEXdzrzjMkDt8/bon/8xqo
	kMZGGCvLh0EJlmn5GfGwOpc2rs+0ZYK3ShBvJ9AU7/Dk2sCb8TheWg+GrHJWQ4SD
	fvjTN07JJaJBFLFgn8Zdlhzt3cV5WLYb/FgonNbcKvX1SGNWHzXjsnemoaX0d4l6
	8+2VCB9y9Ej+xLaWDSLWROKLfNbGDIHBnuNv48KHLSxKZXB8032E3zAgRNEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744859; x=1703831259; bh=eOm8G2tJDF3Dqla/n8CTufL1OF0P
	MSdiQhDl4GZAxoc=; b=ufhg5GE1n1lO0Y0Pw5CnpKOcWMIncDbX5FIT2i7iURUm
	wu72Bz5VEYBHEkTfHdTqeVwmQ9PHY3VuslwgSTx9qwy6F/Go5AqBT6f/DADDArTd
	gQgCfaDxAYlSFv5SV+itixNnH5+h2HMyPdWySD4BM30awit7eB3izJN68DmgYHMj
	3kIEVYTBs6KPfTK6gkNfZH5wvXmRC9yYeHRd1RPdBnIvfJKMECm28FSUcIe93Kqi
	S1lJuije3r8CQPxuzvsOexMqujq+I31Qfy5sP6LXX8/HAQroqM4Nj1dF0VtVduSB
	GwujLWC9PysDcHcUhTC303/yb8RfiZM6ryd7sA+oMg==
X-ME-Sender: <xms:WxWNZckF_88pSwsoJuHjzNAKg7f1qReK9fTV9x0Pad3YxUzztZxa4A>
    <xme:WxWNZb0oCppJJTqKK4fgRk8CVDgNCV7EiJ_zNBZyFCcW126NmVQBbxI9P1BvvkOQ8
    mKjSjoHglj0lYDnHw>
X-ME-Received: <xmr:WxWNZap-iSJ8OUjePDNK2Eq5GCdgtgYKC3z5lzZmZes24hpSGvMiPnKfqYwpSM1kvqnHFwdKy-yc8sEDwrakcrGNK36M9UwMkmZi4GEzaFzeqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WxWNZYkW87GMxVumCmyif-tiJ8UdsTkPmEnkTFM-FJAFykl3u7pR1Q>
    <xmx:WxWNZa1yT_sBjEg2VOOhkCQsxzrSH8QwtaIpXJ9wa2hfvB2multx0w>
    <xmx:WxWNZfvdPaCp51BDw5L4SBfhpsiLNfVW3zfX4nUNWXpAYEV1naGniw>
    <xmx:WxWNZf8JeV8nrji8qkxkTgOTcAPhsbGLlxwAjyoi6e98iVMG5Er0iw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5108d6a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:25 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] reftable/stack: do not overwrite errors when
 compacting
Message-ID: <22a57020c66551f1828b56cfccda97f1c77117dc.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="whdchsFdusjlG/S8"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--whdchsFdusjlG/S8
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


--whdchsFdusjlG/S8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFVgACgkQVbJhu7ck
PpQrSw//RwkVy9KCBEmGoAtxoDGLag8L4m1tWWSuiAQNW9jqFIaQNjJTkqPyPBjf
Kv7s2mEmFytWoVIyXbSpw5879VnlG22uaVQ5WUhjx+a9k45uXQ3C5ik/5iN/MADg
a3luXPpKYjXN8fCZTztp2qP+sV3hdHFZmPxSSm78lQvAP2XnpevjuG6PgZHM4aY3
pW0PLBfPwyMgm0kCGjI29QftxgvTjuzYkPmVrJu2GCNYDkohpTqwnd2y6uXETURv
ItOTs3eCY/TspLDaWOHeL3LCCdAPAhHPMck54AfyaQ0/8X0OpOkMaM1Y+XLlp5Mt
9/uF7ldr90/Ol+gZm6McKkc8O0cjzyQfihwOXOXWRiiV8NWJ1x0ZP7Iu93jXaXFM
ShtQ4jB4iC19TkiBQsCJ0dPQJ18ENQLBQ0G0pQPCyEdFFqAi3rKuZ23pYZS7LH7b
Dx8Tyym+dYm7jhAPPrJqrrB6GTfzDL3voHkA4CRSkRpO7k5EebUHwC8WBrbuJn3I
uZIMp68USQSTnseK2QmBh13p7seL1P7WXjFO4StMWQ0PKA8TutbQDR8XIaoaqOyi
dBSkDy901ojqeJRwnDURvNS98Rki8OjqpIglY7kLcYnoNfCHYM1hSotljsubrL2d
ctUHXDVwIoLUR/QBIaTvqScABmjzFfAFv/Cx8MA3SmxtYGedkkY=
=Au4L
-----END PGP SIGNATURE-----

--whdchsFdusjlG/S8--
