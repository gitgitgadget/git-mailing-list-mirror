Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2A13FFE
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m667/4kZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0KcLnvO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8A3B63200A3F;
	Thu, 11 Jan 2024 05:06:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 05:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967602; x=1705054002; bh=+lxEtsdJk5
	pNaPIe86Kril89cbW4pygxI+wpyAfyPWg=; b=m667/4kZJtT7cRknSBY+2qCFYw
	tTzPJ/K9o2hFCpxwnzcKp7CSh09YNS5o0+6+NWmkJyXOGWO7tF0S4RrF2D0EBCOR
	BI05rkcLpSlMqkcrmXE/vHQcmRwvCp7yoK8dlVxNvX0ojsfUU9NVG7cVP0nn80w2
	SYfVwO5eHw+BIq25IqJOr91aWsNjvxKUpkxYIYeO+zqBkIV/UDkrYQB2lumnscHz
	0jKNLnXkVxJATtn1N5ie7njZxtfpchNTeAuZz9HtbpftbOH2mjFRiQllQfgi6+fu
	kRbChmHNNdny1SoPUXCIMd/SuYZGw5jjKQIlfm9G7zs8VYoJyL5WmqGwqyvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967602; x=1705054002; bh=+lxEtsdJk5pNaPIe86Kril89cbW4
	pygxI+wpyAfyPWg=; b=m0KcLnvOoHYhu97qml3O2a7dfdFiLdNZrAHPt6sT9g0U
	HHT9/N8ldCBVQKQqdG1kYx/DSJQpyjwuVQIz4AZDxyIrybHhBZTEDjesIUofQ2fj
	jDJ7XDxXKHMO0Aww8fkqYVhDYBdOnusY8OuiupKuHrvNZn51J2j9ZwbqEI2rVrt5
	sqo4QPQCSYlWvXE9Vy9iUEfScGmcFecDNV53BvYTCelLWJPv6UQADC4S6MaCMrby
	8ekKnaoUpzeHUAEVMR7ZS+87xI72j77uoS5jg4QGNKBpKF3qYojDjfpegMiTgCI4
	Cm5Zy5T97YT2gA1SmnuA2dQ3IFi89/0jNpr2PdYChg==
X-ME-Sender: <xms:sr2fZTrGqHYHdiLi6Suxh31P-pNwZZEliRTzYc9yGmGJYeqo8huayA>
    <xme:sr2fZdqeYnlY2IRcx_dsa7_WVPa6aSPz6kIkd6UpC8B-mCECpqryZDgG_J_5akBSS
    eaY7ESAMCx6Wrdnxg>
X-ME-Received: <xmr:sr2fZQPXDb6zKjjWbqR7gJbDOghMdkr4e8vnVRT6DYFBMOYYfb21QnsNielK0duQ_0ctatnNvK6tvPPMS95cO7AUfCBbzCMTQvL1nMqWYqOMJioyyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:sr2fZW6quHDKrZa6f6rX8agZv5nDrI5I1HNQikRKA0YO5vUA0yI2iA>
    <xmx:sr2fZS4pa6V7xKGNJlKoQF-LmRlC_dbIR4R_E2sHe3FHQCd5M1Lb0w>
    <xmx:sr2fZeh47hB6Y572oTPJH8-UW31MBKL4WpMOYoP_5GW1-e_wsXzM1A>
    <xmx:sr2fZYRV5UiFW40GR0rTu05eeAx7D_UiNjPKHcTehbzbjHrj6v345A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54f07a16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:03:59 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] reftable/stack: refactor stack reloading to have
 common exit path
Message-ID: <4b7f52c415591616d0af69e43c1f8597fcf24634.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x49R1evWZ0ZINXqQ"
Content-Disposition: inline
In-Reply-To: <cover.1704966670.git.ps@pks.im>


--x49R1evWZ0ZINXqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `reftable_stack_reload_maybe_reuse()` function is responsible for
reloading the reftable list from disk. The function is quite hard to
follow though because it has a bunch of different exit paths, many of
which have to free the same set of resources.

Refactor the function to have a common exit path. While at it, touch up
the style of this function a bit to match our usual coding style better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 86 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 16bab82063..bf869a6772 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -304,69 +304,67 @@ static int tv_cmp(struct timeval *a, struct timeval *=
b)
 static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 					     int reuse_open)
 {
-	struct timeval deadline =3D { 0 };
-	int err =3D gettimeofday(&deadline, NULL);
+	char **names =3D NULL, **names_after =3D NULL;
+	struct timeval deadline;
 	int64_t delay =3D 0;
-	int tries =3D 0;
-	if (err < 0)
-		return err;
+	int tries =3D 0, err;
=20
+	err =3D gettimeofday(&deadline, NULL);
+	if (err < 0)
+		goto out;
 	deadline.tv_sec +=3D 3;
+
 	while (1) {
-		char **names =3D NULL;
-		char **names_after =3D NULL;
-		struct timeval now =3D { 0 };
-		int err =3D gettimeofday(&now, NULL);
-		int err2 =3D 0;
-		if (err < 0) {
-			return err;
-		}
+		struct timeval now;
=20
-		/* Only look at deadlines after the first few times. This
-		   simplifies debugging in GDB */
+		err =3D gettimeofday(&now, NULL);
+		if (err < 0)
+			goto out;
+
+		/*
+		 * Only look at deadlines after the first few times. This
+		 * simplifies debugging in GDB.
+		 */
 		tries++;
-		if (tries > 3 && tv_cmp(&now, &deadline) >=3D 0) {
-			break;
-		}
+		if (tries > 3 && tv_cmp(&now, &deadline) >=3D 0)
+			goto out;
=20
 		err =3D read_lines(st->list_file, &names);
-		if (err < 0) {
-			free_names(names);
-			return err;
-		}
+		if (err < 0)
+			goto out;
+
 		err =3D reftable_stack_reload_once(st, names, reuse_open);
-		if (err =3D=3D 0) {
-			free_names(names);
+		if (!err)
 			break;
-		}
-		if (err !=3D REFTABLE_NOT_EXIST_ERROR) {
-			free_names(names);
-			return err;
-		}
-
-		/* err =3D=3D REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
-		   writer. Check if there was one by checking if the name list
-		   changed.
-		*/
-		err2 =3D read_lines(st->list_file, &names_after);
-		if (err2 < 0) {
-			free_names(names);
-			return err2;
-		}
-
+		if (err !=3D REFTABLE_NOT_EXIST_ERROR)
+			goto out;
+
+		/*
+		 * REFTABLE_NOT_EXIST_ERROR can be caused by a concurrent
+		 * writer. Check if there was one by checking if the name list
+		 * changed.
+		 */
+		err =3D read_lines(st->list_file, &names_after);
+		if (err < 0)
+			goto out;
 		if (names_equal(names_after, names)) {
-			free_names(names);
-			free_names(names_after);
-			return err;
+			err =3D REFTABLE_NOT_EXIST_ERROR;
+			goto out;
 		}
+
 		free_names(names);
+		names =3D NULL;
 		free_names(names_after);
+		names_after =3D NULL;
=20
 		delay =3D delay + (delay * rand()) / RAND_MAX + 1;
 		sleep_millisec(delay);
 	}
=20
-	return 0;
+out:
+	free_names(names);
+	free_names(names_after);
+	return err;
 }
=20
 /* -1 =3D error
--=20
2.43.GIT


--x49R1evWZ0ZINXqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfva4ACgkQVbJhu7ck
PpQ5mA//YPuc2xDW0moJCXtgrrI6b6OJIdNqs7+LtJWz7mu3ZJIsR3PkVXYFw38b
yU9rkVzO8lSHbZ0peix4QtqCLOl6UCRs1VMv+PIiKQQuJi2pQ+J4D/RhbpFWSWIM
UDAs54A59Z4vubalnrFunSJRLu6DvAtgS3Z5YEwQ4ZMf/oOS7MkzeakFhZPAerdE
bLF+HPx2zGDsMsGQ/I7r7eKS8ftUBNDFuOtyigrL7Pg9PVebZj2KxvPmy1mPP35q
eyzIbUSkl0OQIGVXn3l7xxVo3adzlCLwP7DvlwGMQCwchJCDwBMVG3SuVIiIsbKr
5pRUUvtjJCJBHsqP7+H6KqKIKEu//kWeaUBpcPsryBJX8DYouvygMPL4/3nXQ254
pFYUh5+Lpn1k7TapR0sX7gMBaO2sheNuWTdzbITula9w1TWho7F+CvnXW7tEMi1s
/y+9W7yHYDKo5IoppNHiJ+H/7XZQMuj/IHldVfiQ2ky8PdEHo/XOmB799/9qvArT
zn90/kYbY2KOYjsXsrZ604nN6oBjegiPQAr+D+/8W47RnC0dhJZ7il9kMGW7VaLU
bCQ8mi54cTYLqWAm3PXrwrt/XSyQqaRu4LLoiRgftFv/uGdFBRud1+OjTb3euBjh
ThdP8OKbwRALBpf8NXVFDyLfZaFoG6ky1rxblS4ggguV6Euqp/c=
=TAlI
-----END PGP SIGNATURE-----

--x49R1evWZ0ZINXqQ--
