Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A7156F7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l4cOAn9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vCD0Fno7"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5C194
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 02:25:27 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 54BD45C01FC;
	Fri, 27 Oct 2023 05:25:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 27 Oct 2023 05:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698398727; x=1698485127; bh=aP
	wFgVogvWN4ndtDd8yzqjtRaABKsgRB10KYGuLNBWc=; b=l4cOAn9Ce9vrWqtEzL
	MpDm5499aB2CWZ2kJ4JZdaqgOuTmv9nUbqwAMVti04hZpYCeG1dBprhHg4gTMqTC
	Xd+/UzC4zaZOOhLcg8XXJGks22KQpHsNRsu6LOhhTmahpjG8poIfVUyk8bJHgUe9
	8KE6EncOUB15MehIVVgEmyZbWRnRsq6n4HgC0BArfw418mceaz09qdUpYCZbOJF8
	acB+qoT81eLu7/ofG7QDc64swJxz81YZpoEnIGrTGLysNBL0s30+e+IH3zjbmDTp
	CFr70k1Oz88oz/u0tqVe5rzzIRoj9mCs5cjK76CL/b6SIgfcgd4dqxbvm1H5hSfV
	nHwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698398727; x=1698485127; bh=aPwFgVogvWN4n
	dtDd8yzqjtRaABKsgRB10KYGuLNBWc=; b=vCD0Fno7K/6WzD8EYxmmiTmlwGN+7
	r2KRFdJE6lBG3ySTCQ+p71Rt05xODTRk1MYuEw2Qe989vlaG+Yrf6DnGfzrDZf3l
	ymHRjvNS7CuLhe0hfnOZzDCNbYh4EDa4dPOTUVjnAJkeX1BwZgIEjJLmJeqww9JM
	INAPeBvwd/kKdz3CUEFAR9eYXEMfrQTKK9G7eIjl63bIUublx1wDqpnfbfHXvkhU
	6GkmnjZfmyJmqNYfx5oeWzXAXwyLeIZETEwSLzayz2izzosJoEP2wL+I3t4sWVL/
	EQVEHVQIjSZlSfqDuKlo2x3B+B1MIj5g9z37SsSepYGbsBTaAzmOycj6A==
X-ME-Sender: <xms:B4I7ZS3T2p6To2kW2sscyUFZ9TXulc2Wb9FdAKL_xjU0qvBYBpgdGw>
    <xme:B4I7ZVF0WDjQk5jxgBtkrtZfonp8zBd91H3NwEKiPlFGnZCISXzJVjGQMec7sX4kO
    y5cxkSOgPGAUA9m6A>
X-ME-Received: <xmr:B4I7Za6kNuZjM9hwRZhZlGG8kGoYiFp8HgJpLWAhH7GrYv-9iYCypVXYQY6XkzdE3ANau9ZHfXBpwwu_Q9_4XSVfr5BmOl5RobdOcmyqDpBkFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:B4I7ZT3egxYiNIPwyYl8tfxyoXN8x7Ig-7W_kwiVrsuteq0vZOD3jQ>
    <xmx:B4I7ZVEyUBK3fBmtKGjqaJTE1_mM_kerp-1XZV0fyNQ51E6Ayb0npA>
    <xmx:B4I7Zc_O7PpSZoa8TWK64v3NOBw4S2ZDx1QcoYeal4AoMH4sX6iIhA>
    <xmx:B4I7ZYNpxqSv6CY5klWIpzAp7aX1A3uZJNoiEmyq_guAb3SoKvI-aw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 05:25:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8f14b1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 09:25:15 +0000 (UTC)
Date: Fri, 27 Oct 2023 11:25:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v2 1/5] ci: reorder definitions for grouping functions
Message-ID: <4eb9cfc816b160a8fbce1bbec03df10f82c83dfc.1698398590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zaj/puWMP5BYeWTa"
Content-Disposition: inline
In-Reply-To: <cover.1698398590.git.ps@pks.im>


--Zaj/puWMP5BYeWTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We define a set of grouping functions that are used to group together
output in our CI, where these groups then end up as collapsible sections
in the respective pipeline platform. The way these functions are defined
is not easily extensible though as we have an up front check for the CI
_not_ being GitHub Actions, where we define the non-stub logic in the
else branch.

Reorder the conditional branches such that we explicitly handle GitHub
Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6fbb5bade12..eb384f4e952 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,16 +1,7 @@
 # Library of functions shared by all CI scripts
=20
-if test true !=3D "$GITHUB_ACTIONS"
+if test true =3D "$GITHUB_ACTIONS"
 then
-	begin_group () { :; }
-	end_group () { :; }
-
-	group () {
-		shift
-		"$@"
-	}
-	set -x
-else
 	begin_group () {
 		need_to_end_group=3Dt
 		echo "::group::$1" >&2
@@ -42,6 +33,15 @@ else
 	}
=20
 	begin_group "CI setup"
+else
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
 fi
=20
 # Set 'exit on error' for all CI scripts to let the caller know that
--=20
2.42.0


--Zaj/puWMP5BYeWTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7ggMACgkQVbJhu7ck
PpQyMQ/8DcbfjaFBQeQQH5ElwsFlSh5RAlefAjhcDxR4ayfu5UP4BETCheBPiEsj
6jztFqkH0s8sP8A/o7f6WgaK8QFuhlbNGOXkXhX40Vw/wAW9A79U5aHHNZ7rYg0i
YknGZBwJU0tnv65uo/ilsFnws8VHPVJLW2H+YVwB3gI0vnzgbymPIdQ979OI4FKq
g+8GIAnilOktz6to/5T1ckZ1tTTKSZghi55sMQ9GNGEB6Vr2ue+zmL6umBHLC2jh
csNPy3YG2voSZpyFv/vpV62f87QWBIk7ANgBB6h/FQwf5Syp5EUpFCs0kXX1QNlr
78jVaiEJ6TDvkUxJiUXeyPpfbR39juSWcmYAdOXJOXpZQ44qKldg/B/eDbCvPGPd
lm9bE3sJ21i27yK6A1k25e5KZYk7kVBsPDRYgyynq80lwbs0mD1Fl9MYjMVBI/l4
vfeY1pBdHQQ0soxsOUMhxXAUaodbIO1kHNmXrzq5tVoMjGYUaG6w5XbNE+ellobE
l7buKsABo4a4cUYzt0ygyi9ZhASEiR85sbM2dWS1zVLNjhTkvDcEes4UzmYDKUyf
J2mT8JoiGRd6N9a4OJNaU93voViC4RLcuXfHPvei4gc1JddHDzfQuDmMmEX0EnzZ
mQvQ3tCtGS8SgfxkyepDOlPzncvx+9IIQvRJsOGgoAkKNih3BMo=
=1RVd
-----END PGP SIGNATURE-----

--Zaj/puWMP5BYeWTa--
