Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179FD16415
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nhZDrLhd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KsCg7bKD"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA04AD
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 00:19:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 19A565C0371;
	Mon, 16 Oct 2023 03:19:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Oct 2023 03:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697440799; x=1697527199; bh=gh
	Yr5rWZMHFjX52SliFw5+M9k8GJJZZRPKgZWGf8gBo=; b=nhZDrLhdtB8D92TyFT
	0XPmqb5/9WuWmGEN/v5kFTdNLGH3I2+Vp2Uz4xF6XKLf3l6KL6BCnHLLLoA8mmFL
	NdIkX4We64TfAwH1zZWiVQaegnqh++aA4Fa7U6dUi2ozPjZ5VO9X3OGZsnhesKdX
	Yap+PJi2FA7k4JS6JrQEqRBqgPSR/xNkJaxdG7gUim08VtW988SQ3H9dKhxxQWc+
	iXuU8NXm2d0rS/yBpoVv6E9qPgAs6xzdwc16Rbse/Gw7ic+ILwKtBgkAy3paaw+1
	Vwr6f2WGaEXDFvbs6oUCZqbYnTjkFiH9yFSSE2tWlPuMTiirGMGHBPvAdcfzB1dH
	qfgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697440799; x=1697527199; bh=ghYr5rWZMHFjX
	52SliFw5+M9k8GJJZZRPKgZWGf8gBo=; b=KsCg7bKDFKJs+9zZU/9AgjWSeACa1
	E3Tv+SMIGImvhZiKTC9//M+JP7SDk8YmCl847qmokj/fAUaTtq3jqOaSGZQ8aL7i
	beesyqEJs4y2UIijUHbnHWGjl1YURPtnOV0WTmbS9a5ro1j5l3Smz9w2WxM7A8uK
	WblzqBGIzkOViDCJYZb7hXLywkxfejm3ZDXwJfhGp/AWfQw/t68PO7L+oJDnzXwf
	d+GieO1esVxhvTvpGf0oDCBVAkfjdyVyIsBAFdm/CGccik4B9GNOF3sxtoXQxEIx
	UF3axff9nRnS4r1UsPRrWq8vDBeatKWAJN3I2CzHb1wrfP/wQjcbH2hRw==
X-ME-Sender: <xms:HuQsZQ6I3CnqVDDujZE0KYQOY57NRC2hpC9qSOtRXlRKibDkCJKf5Q>
    <xme:HuQsZR6eAM7-Y_z56eZuMM5mMaDH88ubjDUfEPg_DideIVxlqE8hhMZ6MRi1aFTx9
    fbOGTYtyr3HFdy4Ag>
X-ME-Received: <xmr:HuQsZfeeWgPhSMOyEaN697lE1REfx8ZRAraiG7GXvlSBnbil_488ylDWN_qnF8l_10r_nqldhX6dDBUM7sMAYqShbPa2Fb1Z4t6fda-_3sVv_Fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HuQsZVIF_9qVEChHJ0iM4X0lUG4trMnNrCMojY25Nd1wUgJAdFvDSw>
    <xmx:HuQsZUK0OJ0OxwD-tm9XSBBxkrmPPDxJXqJg5mOR4CUNDkj4cRRn3w>
    <xmx:HuQsZWyo1szCvwUSsx58xea_cmpQcch0BAyCLZPKFl-w76kIKZn1bQ>
    <xmx:H-QsZewDakICekefngpY0E1e7oZ_Q_jf5JGDTK8zWCLAnoTanYp-AQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Oct 2023 03:19:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c527eb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Oct 2023 07:19:57 +0000 (UTC)
Date: Mon, 16 Oct 2023 09:19:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/2] doc/git-repack: don't mention nonexistent "--unpacked"
 option
Message-ID: <aa0b4fef4d8397983676394472ff86e468bfc687.1697440686.git.ps@pks.im>
References: <cover.1697440686.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ftKSg28uKZspXlp3"
Content-Disposition: inline
In-Reply-To: <cover.1697440686.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ftKSg28uKZspXlp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The documentation for geometric repacking mentions a "--unpacked" option
that supposedly changes how loose objects are rolled up. This option has
never existed, and the implied behaviour, namely to include all unpacked
objects into the resulting packfile, is in fact the default behaviour.

Correct the documentation to not mention this option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-repack.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index dfd2a59c50..d61078b697 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -226,11 +226,8 @@ uniquely by the set of packs being "rolled-up"; in oth=
er words, the
 packs determined to need to be combined in order to restore a geometric
 progression.
 +
-When `--unpacked` is specified, loose objects are implicitly included in
-this "roll-up", without respect to their reachability. This is subject
-to change in the future. This option (implying a drastically different
-repack mode) is not guaranteed to work with all other combinations of
-option to `git repack`.
+Loose objects are implicitly included in this "roll-up", without respect to
+their reachability. This is subject to change in the future.
 +
 When writing a multi-pack bitmap, `git repack` selects the largest resulti=
ng
 pack as the preferred pack for object selection by the MIDX (see
--=20
2.42.0


--ftKSg28uKZspXlp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUs5BsACgkQVbJhu7ck
PpQnzBAAhZq7RUs+/Ogrub7Y20sxmQTUpbX6XEAQHiZHZA/apL76egN+4knsv9Li
YYG2xUlZVbIWD0SziVJPlkiQEUS65Jiv7MMiKj9DjhKrvb/y/MMz+n20k8E4cOMR
JYWGJC+p6HZ0h74md00YIJg7Gvih6f45moEmA0rWaM3K6xjA1hblo1iVbvaD31mM
YKqA+4diIvAj5GPaMTkV4h3qpriHHE6F7DljtYs9Cp9k3gwSaptHJBpQ3sNY3OzI
o0DcwqljOdTPpqTxeddCunFl1GCj4Hqv3XYEcpqYEqDjoBUPRzZkvYsA3IpnwiAC
+/4qBTcmzp52XuVQcfk+Wlbh/8WO3x/3mygNtTqTWPNd2ncdWszcO3nvS+lEyKLB
lDXYxAyjze/JAwVvYJ5YtK73cmffA9jzGpTfy+ov24oNmMMipkwfB0tLROBJnN3B
u9dW7pUI3xol576ttqMxKBRhtsBkkvne3e9lpXggUYEd0JYlh8owzp3jRRqs0nof
YVuoJ14xQeG6VuJ4WukGGer2KKE6g9JqNPXMxqLgcMekMDelU+1urH99XLF2+BEE
/U3Zoj/jbecGlTMYEBM3hVfVak+ceYX9xHg95Cvw+kloCoPJBM2Umz8oOeRBi3OX
IArvoqAhWeIl2KABi9NlIfjfbbhinyC1QPX97+CFZFB+8HKegMI=
=3J3U
-----END PGP SIGNATURE-----

--ftKSg28uKZspXlp3--
