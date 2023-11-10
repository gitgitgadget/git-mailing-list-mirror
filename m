Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC6748B
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xFs4fchU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6NPeuRU"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3393C7
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:17:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4C47C3200AC9;
	Fri, 10 Nov 2023 03:17:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 Nov 2023 03:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699604223; x=1699690623; bh=UB
	BW1RVm7DKir5nZlo1w/0HmmlYWjF+2GS7rDAEPYfA=; b=xFs4fchU2LLSqh2Fdz
	hGkv4OpUQj/yeG4oIPv9IvPeSNVIOpNUxlR6pc9606RS5JLEp4cljAvbrGIhDGhj
	WLdEBgMPwu5tml9wiK1GXSToyYoYkty5NXD3q0CahF0ejYFNddhMVmfrBsGvb772
	RuwU2VTaCH+UYyiA8/KMMl96Pot44phifr69xYzoL4I6qPFHNQ3sWo9kb2fiyLZK
	bnSiNmzC1SMnXf+kyeULymxU/i5202rwvKIqca2jQhbgozZfUpXiKQggu8E4MN7J
	vialubzMz1tVhgSqw1jKgmwhnM6MKIODMplJPiP7WVk646ccoZgdVtRNZxK4TYgw
	dU9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699604223; x=1699690623; bh=UBBW1RVm7DKir
	5nZlo1w/0HmmlYWjF+2GS7rDAEPYfA=; b=W6NPeuRUKuzQUf24Xm7MDDH8Nn+xg
	UQN9u+JZdYla4Npk3/8Yrl5LT0aLbxR9nyIR5q9CP/YyOyX5JO4T/h5flcO8K12o
	GPb0mvegYvuIWLnJ16VqtJ4cWtj3hC9HmrcD0LGAZtATaAXgK/joJ+o/4hV/+LxT
	7Z6vLXYUpKmufrbnNxP4dTGvVNv2MOcFXe9uuU8r2840sRo7wULOWh4adj78V/IQ
	kPepm4xMZwaDkgdWFfAvE05hEuPAMll8t5opTPRBsWVD1CLoSzNJYMSnNyz7qxX7
	qTLbge5PMvUsHijvRt1lbul/YtMSOGd4ha82dH/R48XjYjiW2GMsvZHqA==
X-ME-Sender: <xms:_-ZNZbCtu-8SbOorx4JQSg2TUeCM7a-FEZSc8-lU_BEVgBAKUS-PiQ>
    <xme:_-ZNZRgwK7c6B_29N_BpatBwtBeCRhEYNzIL9t43qBra1_OK4t7IpjYCNdu_MIghF
    Tt1-YhuBWpA-W6XOw>
X-ME-Received: <xmr:_-ZNZWliGegxwCNPLg5Umv3Rth24gkY3K_cQVBNdhKk1YOVMZ4BsIQqEdzoOuj9bdjamLszu-6ghyb81EaO-QYdnRl-hfrHDSHFoBxYEPCbWLlzR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdehteeggfevueevhedtleelveeigf
    efieduiefgvdfffeegvdeitefgteevveeunecuffhomhgrihhnpehhthhtphgurdhshhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_-ZNZdyo6KztVNj81dlAJXaqmfF--xLW-9DDyxis-lj_Gy38Hxgpbw>
    <xmx:_-ZNZQRS2VVeca9ZQ7be0yTxzzh3dYR6_4j3wEwnSptBFZUdF3ddcQ>
    <xmx:_-ZNZQYgzmFOi-8St04CN3vbffGhNa5GuGGM7uuxuF51Ja9x4friUw>
    <xmx:_-ZNZbJzAfI1j13imzVc76kq1FIfhhq_Rifhk3P1wg5yu7dgk14_sg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 03:17:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ae3279f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 08:16:33 +0000 (UTC)
Date: Fri, 10 Nov 2023 09:17:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/3] t/lib-httpd: dynamically detect httpd and modules path
Message-ID: <41b9dada2e0b2e713328e6a4d31f713a2d3ffa38.1699596457.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yhmVSIUuDzpbx4n"
Content-Disposition: inline
In-Reply-To: <cover.1699596457.git.ps@pks.im>


--6yhmVSIUuDzpbx4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to set up the Apache httpd server, we need to locate both the
httpd binary and its default module path. This is done with a hardcoded
list of locations that we scan. While this works okayish with distros
that more-or-less follow the Filesystem Hierarchy Standard, it falls
apart on others like NixOS that don't.

While it is possible to specify these paths via `LIB_HTTPD_PATH` and
`LIB_HTTPD_MODULE_PATH`, it is not a nice experience for the developer
to figure out how to set those up. And in fact we can do better by
dynamically detecting both httpd and its module path at runtime:

    - The httpd binary can be located via PATH.

    - The module directory can (in many cases) be derived via the
      `HTTPD_ROOT` compile-time variable.

Amend the code to do so.

Note that the new runtime-detected paths will only be used as a fallback
in case none of the hardcoded paths are usable. For the PATH lookup this
is because httpd is typically installed into "/usr/sbin", which is often
not included in the user's PATH variable. And the module path detection
relies on a configured httpd installation and may thus not work in all
cases, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 9ea74927c40..f69d0da51d1 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -55,22 +55,31 @@ fi
=20
 HTTPD_PARA=3D""
=20
-for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' \
+			  '/usr/sbin/apache2' \
+			  "$(command -v httpd)" \
+			  "$(command -v apache2)"
 do
-	if test -x "$DEFAULT_HTTPD_PATH"
+	if test -n "$DEFAULT_HTTPD_PATH" && test -x "$DEFAULT_HTTPD_PATH"
 	then
 		break
 	fi
 done
=20
+if test -x "$DEFAULT_HTTPD_PATH"
+then
+	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_=
ROOT=3D"\(.*\)"$/\1/p')"
+fi
+
 for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
 				 '/usr/lib/apache2/modules' \
 				 '/usr/lib64/httpd/modules' \
 				 '/usr/lib/httpd/modules' \
 				 '/usr/libexec/httpd' \
-				 '/usr/lib/apache2'
+				 '/usr/lib/apache2' \
+				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
 do
-	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
+	if test -n "$DEFAULT_HTTPD_MODULE_PATH" && test -d "$DEFAULT_HTTPD_MODULE=
_PATH"
 	then
 		break
 	fi
--=20
2.42.0


--6yhmVSIUuDzpbx4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN5vsACgkQVbJhu7ck
PpRmbBAAjQCjgrmuicaR37p4unvxEqjBh/wKPYikLYassOEebwpbLU+6H5aGclyk
zVZfvm3PeuDN9cCFsQEFQi+Bzj5bpPMucqWvUX675bzBimYJInbMrI16jtyshp7e
8BEkRt17BafWYPMiyBTI5IgPE0KgMZIoeYvTMydp2sjwl7x+8EdrxvuxBWjOs2YK
9hxsiKmiWKWPsbEVesykcIk7ET5NIPwBnQovsKprlY37k0eu+FuE5f3qZKauOXT1
XK2urapSKfLC0zBc8As/ihVGo+ET+zXugkpfIZ8WbpiVZ49ahG2pAMVDB57+9aeo
jq5ORgWw1UTLDQySwBi06WBsx4u9LPLk11OqwrdwLsmGhhyW+8zTkH9Dxuv+1xA7
F6FTTDQTHrhE858rquPlxRg4jm2NzFZwvvDESQtwhomcW8mxf1MFmQ3sFHhIMfTW
3r1DW4UYibPciyRN/Wv4vmMgpB0NyGD2iJzf64eSAhxcWqJJ2qwHay279HNomzL1
0KffCGtZLm59LutYC/4vtX/kWdMxa3SugcyFC+HJ85uAHJUFwaRGo6XE9YJg9Qg1
762xYb/aEiSM8Aak0MhdB47GMNleXfdXngonJM6cRAKCqZG+tjedmvBsXG+qgSoy
lFM5h2dfM1LDDU94cERqxX0pTc97c+6yMKfMVAjTvtOJPckUmH8=
=IzWi
-----END PGP SIGNATURE-----

--6yhmVSIUuDzpbx4n--
