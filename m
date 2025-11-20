Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F818A956
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 23:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679784; cv=none; b=WTLx3JbP9zc1OJmlOcQ68YRm545zEq9LcVdzpPAdIJHBA2jBNbm72zhIj9wgmmkEgCdkjM6Yg6rYFV58HjSjRhrTEmYSj6QuaoNsx5Nl/b6SQYmAlAShaGq6aQb4ev77uZen7xranqXfp2yUwd6xYlbP+7aqvoqEUpeq8Vsm2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679784; c=relaxed/simple;
	bh=kG41j0vFNwzn4GtyGl4jkeXpdvuQIZOa9OKGoZi0EMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB0SQXfjkD32ngs1UsjlOLhU+BJFhh+py1aLPzKoPiSTx9BpO1dknh+kh/3vRFMxnteL7QNoxK4t2T5m7PgHWnm9L62uod7fIFWbvIzpHsDEq8pUGniiWRh8BR9CEZzLTMNxqILebO8r0XAV0ptaMPQ1t6jAzyXqiyh+093snws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dVfXY4Kb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dVfXY4Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763679780;
	bh=kG41j0vFNwzn4GtyGl4jkeXpdvuQIZOa9OKGoZi0EMs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dVfXY4KbFiFJyyNJ+E3GuQhgWPlx873ZIrhXadnn2GorK/u0wFwQeYH2MzZFUA9yx
	 ywCJ7O4jFXt6GFrGQJYmDXlZ9PC1jFLIJ3AGvRqjeUwmh1/nEHuAmDzzEwxJz+4ObV
	 +7BD7U7wOcGgm6tUskSsfhXsWjtxMxbv043Wbk6+82+BVMZ3hOtXxFHZIyn7rVTMbp
	 S3TMFcqBP/c8wvrkgFT+kYybgzp44ABToTS6acnpXoZUM8FIWThLwbLCSg1VcKW6Zi
	 x9JAOyccpypTKLA2vH7aJsm7+yg4t2kVWlZhI0Ef9tlwSsqNvqklYG2o/7PFyhzkGP
	 0ok5vfVPSUXB+Hf3HcD/fXZGGa+qxmJqm6BV2fdi9My2i/bR6rgMu/59gX2cN7aYQv
	 uPUikFTJ8i2pT1e30OY4pLBfheWVcoOsigfOQFK+b8h08ky5si+KhDEa7NDWGudPSW
	 HgPTVVKoyV/GA5Xn2kbNnaCsA30JgKn6GEYDaBPuoHEWBmE4qyr
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ae5c:878c:d4d7:64f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AD22F20065;
	Thu, 20 Nov 2025 23:03:00 +0000 (UTC)
Date: Thu, 20 Nov 2025 23:02:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
Message-ID: <aR-eIooTkjbktsf-@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <xmqq7bvsjzlx.fsf@gitster.g>
 <xmqqpl9h9mgo.fsf@gitster.g>
 <aRudLpkRdRtCAoi3@fruit.crustytoothpaste.net>
 <xmqq4iqsgpu3.fsf@gitster.g>
 <aR5M65HDuGlTsR77@fruit.crustytoothpaste.net>
 <CAH=ZcbAmAqWMYXhYT3bX_Q8cEkV0ZcjEtM65YS7DXPJbs-L3Wg@mail.gmail.com>
 <CAH=ZcbDER4OysywLZpCc=-GQ+rweSfVAQ-xj0gNd1rF4-=cPWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l1aJF+L7JDaarQhx"
Content-Disposition: inline
In-Reply-To: <CAH=ZcbDER4OysywLZpCc=-GQ+rweSfVAQ-xj0gNd1rF4-=cPWg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--l1aJF+L7JDaarQhx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-20 at 19:52:23, Ezekiel Newren wrote:
> Checkout my retrospective review [1]. Basically if windows + msvc ->
> <crate>.lib else lib<crate>.a, but it was coded as just if windows ->
> ...
>=20
> In the github ci these are the only windows combos that are tested.
> "win build" is windows + gnu + Makefile
> "win+Meson build" windows + msvc + Meson

So I don't think that fixes the build[0] with this patch:

-- %< --
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Thu, 20 Nov 2025 22:52:37 +0000
Subject: [PATCH] WIP: try fixing CI

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile           | 2 +-
 src/cargo-meson.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b05709c5e9..8bdb05e535 100644
--- a/Makefile
+++ b/Makefile
@@ -934,7 +934,7 @@ else
 RUST_TARGET_DIR =3D target/release
 endif
=20
-ifeq ($(uname_S),Windows)
+ifdef MSVC
 RUST_LIB =3D $(RUST_TARGET_DIR)/gitcore.lib
 else
 RUST_LIB =3D $(RUST_TARGET_DIR)/libgitcore.a
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 3998db0435..80c10b22cf 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -27,7 +27,7 @@ then
 fi
=20
 case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
-	*-windows-*)
+	*-windows-msvc*)
 		LIBNAME=3Dgitcore.lib;;
 	*)
 		LIBNAME=3Dlibgitcore.a;;
--=20
2.51.0.338.gd7d06c2dae8
-- %< --

[0] https://github.com/bk2204/git/actions/runs/19553883891/job/55991786359
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--l1aJF+L7JDaarQhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaR+eIQAKCRB8DEliiIei
gQUPAQCbuU/Z4tn1VWFXJhsRNlcUOll3B7ptRnvpFZ6CsfBQzAEAhHrwR/E1jv8m
Q0fHLdcwzp5JRfI/tfcc9k4s5O7BPw4=
=/7S4
-----END PGP SIGNATURE-----

--l1aJF+L7JDaarQhx--
