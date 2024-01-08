Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065A3FE59
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="me7ULOhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHaOquxK"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id C59E53201202;
	Mon,  8 Jan 2024 07:18:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 07:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704716314; x=1704802714; bh=HJBG+tHJIO
	nQlbNESF+ioFtJ5tnNG/slUH8eiY2yJek=; b=me7ULOhDop/wHzTVbHxyNgofFJ
	6UjAVL4WIk3NXtrk0eeKtz95UN05AXGo7e18Ms1Fa5R8GXQyAafaIArZXxKcm0TB
	f2LlvO+6IC+oavXWj0UeLHVmXyp20KVZSFrmMHmPgXfTYnG+1C0PYwW8Tdm0zfMr
	QkfJgyIjVmcau7IUUqW4cXKJcpqFB86+VYKEg1g4o7zhhcpvu/QeVtggY3BnJPFO
	B0XsjAfcQTyPPvkwuJbTrYMovyqLvQ9z8xxYtWEHkHQSwIlWX2Hd0Fx+IcVCIRAC
	gvy5ia1cbwLOH6XA2C5/PhJ+RL4WToK/MNFQ0mF1qJv3pQuSbnAkDK4xZ4DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704716314; x=1704802714; bh=HJBG+tHJIOnQlbNESF+ioFtJ5tnN
	G/slUH8eiY2yJek=; b=qHaOquxKKphwds7USyPX2QtQWxqSdA/0KejXhFENp2G+
	XCOwA7aX5sQuhidPEsuKWCuvuEffBGFaYmcnJL8trRMI0WyYOw345jb+eGH91/5J
	WqotEEKiiddiLoAzSJtEb906Wz3zmJOn1UIKy7ABhwmU3R92BOl3bnOxD043KzNS
	dvBCdUO0lB/xFVMRFS/eW4VbnyE4CVuPRub5l1yI6HsWvt9DEyqzsT+EzuG1YAX+
	8tLoqdSqhyv4hhi5v6n6zi+zBUmFlqWPqBifXNVOUpPe4BONsdG7U86RVenWnZHU
	DZ8Vf9hjMHxOJizplMQ4fBxw4pcl79XuGjNfWXZAjw==
X-ME-Sender: <xms:GuibZaPF1xgYF7L6jh7GcyLC4i4cfZwkrlLVzxfxJXi2Es12PTqlpg>
    <xme:GuibZY-0qUNmx1MHysl4xi896_o4DUVbeBE_IiorhG4yfNMpLOic8CIq9hdc1Z5l9
    sPlN4AvAp4Hp_kYWw>
X-ME-Received: <xmr:GuibZRSzrrS9IKwI6yWzLCZ4rDbxAsS9mPD6letm3cQVcyrxZAQdJuiDuzm-P-BzZEgY14GskvlQL8Zjp4eQzn2w3gC2SYvT85V4ZzVNelwudJY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GuibZaujmZbHpki43Vwfm48Xvl-WEIG3xT5p9e8YRnB9AicSjxK4oQ>
    <xmx:GuibZScWXpAskn5bacS9ea3R9DUKQrL8uxSybqVRJN3koHFtrMeesw>
    <xmx:GuibZe0U0b41wHsYftTB6jkniGG3rPyXDjBRLqvJm52ZQ5g-xY2iLg>
    <xmx:GuibZame70Gcg6dvZAB_C8F9b3lrupPvJZimYbmJEhkJijWBiK7E5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 07:18:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 457f4ca1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 12:15:56 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:18:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 1/4] reftable/stack: refactor stack reloading to have common
 exit path
Message-ID: <01ece2626dd4cb494829e146d99c172fa8428478.1704714575.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l1waret35V2xsEjc"
Content-Disposition: inline
In-Reply-To: <cover.1704714575.git.ps@pks.im>


--l1waret35V2xsEjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `reftable_stack_reload_maybe_reuse()` function is responsible for
reloading the reftable list from disk. The function is quite hard to
follow though because it has a bunch of different exit paths, many of
which have to free the same set of resources.

Refactor the function to have a common exit path. While at it, touch up
the style of this function a bit to match our usual coding style better.
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


--l1waret35V2xsEjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWb6BYACgkQVbJhu7ck
PpRxZQ//bm+CLNtndZijc5SOCHpg2LUlt7ma6J3BjpMvyy3JcpSVIiRcK0qoiMe9
xZPoa41KhXXPw1d+vYfpqQkwt2T0AJ78ECGGxomUZaEaVJXLHQb8GttsvmP19SYR
d6XaoBHBw6f84y03UdjtAkEAeyek+KBJZayTk0P1RUtO1MXNcLkzHJQ+BFjiJklw
qICYJtDP8FgARb4r6cwOxvZwbyDJCgs+WNYx5T0cTc3DOy4vCH4Y20NnXt16vf0I
Qb+xaJBJT6LLSUuJ7kOQwE+yUtT4ZpkiXKoO2A6GdBV7jflIX/3JlI0YHl+DvFe9
F2DEYjU0JNJaf/AcPaWtFUkTvQScTUSiWG5Ws14sauhUQSAL8ZE04ACg6uhBf1zr
AIR4UGZKKEx21zPGgEEiTlDZZksgD6S1wiNMt16KGKj/AVG2z42r7MuW2R7F21Sp
4wC4CGwlnLqzGGKGORFIdt9O+OSyleiLrJ9hkgO3FTHZI/vR8A+2PraKF5QTt+VH
dhQY55ysQrkGEMibZhnq2WOtVWtyaOxcMSKbAcvs+duddmNsD1N6AqcMKT9oIjuP
IicbeEfS96Z4QhWQsIDRC8YmNtqzURVTzwMAB1TiPD+N587bW29fdzz6RUU7XuhZ
Svqy0yZpNR0gvpeQePN89DBRJusgC/Poza5aI2X9Bbib7R5zUgo=
=oRP9
-----END PGP SIGNATURE-----

--l1waret35V2xsEjc--
