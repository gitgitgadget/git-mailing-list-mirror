Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D7AFC11
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="afZeYYFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3i4YNQl"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADA211D
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 23:10:04 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 6499D5C02B0;
	Thu,  9 Nov 2023 02:10:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 09 Nov 2023 02:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699513804; x=1699600204; bh=03
	HUJ2E3pPYRi+zAhg2WIJc7LtC7AQy0iFUvlWLdtxw=; b=afZeYYFybLJgZKEkW1
	bC71cZyvjI+5c5xJ14I8KoDkEswFwzoaXZteOUdinIwdltExRo6FJyd1ge3IAMUG
	4sAKZ6GqiZv1zdbSmTLIMI+YcT0Fq5WYWi0aEcDh0mVvwWCK5Gd+cjp3+zSujNFt
	UZ2RF+IZYsLgnHUafFNYkbPiJ9GKWgt364Wc19GO05L5LHUVXuGfTq57rVlDHNxi
	58JeGJY4MOXGdmF1WOLhUaxuIjvI5B59npnmkk7xF/SeYeB1guB2VqiZp1OwGxri
	QEzBEkXmhFKP+zN67klVLIdHtglqmOgH6AoWFYQLb55sgmTWcARNU6til1KOEt7E
	XfFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699513804; x=1699600204; bh=03HUJ2E3pPYRi
	+zAhg2WIJc7LtC7AQy0iFUvlWLdtxw=; b=S3i4YNQly/4W2gU97wOlnvc/xScfj
	LS+2KxQ6h+RkHVtSYJupYDZ4pyqdHZVmFg1XZxPWTx8EnqMFVagutW4Gri8DVHTb
	TqbM3tPntzBPyabLoVbjXjWGDftjATUGuRDrGcvQ17Q5F2mGHOmnjFACP4mGajls
	16LBnTSLrGJ2YoABxRC+cNvDeNG4QHGafci4gjpLwSnCv3WgIDW7iadsFo+ZKjK7
	zHRfV9v012k/3/lyUSe32dwSFQJa83dn7DExwcs1p5VW+pM1OLz6QehSr3BXvBZ9
	Z/2g9ZLVShlWXEAOr0olHTNALgrZENg9ZWBAPTC4v+eGAP6r5m0MzWjQg==
X-ME-Sender: <xms:zIVMZV7lgpcL9HWJJ7bWaCwqMsmqnWRMHHRDxhk8oAUCf8sfKrfp7w>
    <xme:zIVMZS45bFsfDxo9X4gcQD3sXDjeqIODOpvBGPViR80KhFucyIxlDKwehQXrg-SlG
    LZxWaVDiWXQ4tOEOA>
X-ME-Received: <xmr:zIVMZccEPLoQV6mp9exyBxJx2Y-E4Y6SHDdjqirIp5tz74ZxrsG6cl9WLv_2Loi5lVgiNxLH1DkHsg4hXguVh9FXyd7LdKQd85B_1yOksz9dhYst>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zIVMZeI-MHaAxmoZxO6oVgQ3o2bTJ3cLSOEBlQh42Pl0zf_G2z7KXQ>
    <xmx:zIVMZZKWpdsgN7uTVcN9lG5jYicoeC8Xoajw9Ycsogw3qRzhp7iJ7Q>
    <xmx:zIVMZXzkRjaD4NtsQfkJyMO3Z1gyJf4CiK-YLt_rH_fJHojxcg8yXw>
    <xmx:zIVMZXiER8O8giVRQ2z4nLIzxIdnNFYg9mWYuY8GBRJg3AOzS-SMWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 02:10:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c18fcdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 07:09:36 +0000 (UTC)
Date: Thu, 9 Nov 2023 08:10:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/3] t9164: fix inability to find basename(1) in
 Subversion hooks
Message-ID: <6891e2541552073c6827d81d2b761252f253bea2.1699513524.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699513524.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SJjGvHyOfOL82URy"
Content-Disposition: inline
In-Reply-To: <cover.1699513524.git.ps@pks.im>


--SJjGvHyOfOL82URy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hooks executed by Subversion are spawned with an empty environment. By
default, not even variables like PATH will be propagated to them. In
order to ensure that we're still able to find required executables, we
thus write the current PATH variable into the hook script itself and
then re-export it in t9164.

This happens too late in the script though, as we already tried to
execute the basename(1) utility before exporting the PATH variable. This
tends to work on most platforms as the fallback value of PATH for Bash
(see `getconf PATH`) is likely to contain this binary. But on more
exotic platforms like NixOS this is not the case, and thus the test
fails.

While we could work around this issue by simply setting PATH earlier, it
feels fragile to inject a user-controlled value into the script and have
the shell interpret it. Instead, we can refactor the hook setup to write
a `hooks-env` file that configures PATH for us. Like this, Subversion
will know to set up the environment as expected for all hooks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9164-git-svn-dcommit-concurrent.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommi=
t-concurrent.sh
index c8e6c0733f4..d1dec89c3b7 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -46,6 +46,14 @@ setup_hook()
 			"passed to setup_hook" >&2 ; return 1; }
 	echo "cnt=3D$skip_revs" > "$hook_type-counter"
 	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
+
+	# Subversion hooks run with an empty environment by default. We thus
+	# need to propagate PATH so that we can find executables.
+	cat >"$rawsvnrepo/conf/hooks-env" <<-EOF
+	[default]
+	PATH =3D ${PATH}
+	EOF
+
 	hook=3D"$rawsvnrepo/hooks/$hook_type"
 	cat > "$hook" <<- 'EOF1'
 		#!/bin/sh
@@ -63,7 +71,6 @@ EOF1
 	if [ "$hook_type" =3D "pre-commit" ]; then
 		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
 	else
-		echo "PATH=3D\"$PATH\"; export PATH" >>"$hook"
 		echo "svnconf=3D\"$svnconf\"" >>"$hook"
 		cat >>"$hook" <<- 'EOF2'
 			cd work-auto-commits.svn
--=20
2.42.0


--SJjGvHyOfOL82URy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMhcgACgkQVbJhu7ck
PpQJsw/7Byty1cpTM6BwHrw2WNQInSMBN5TPqpqj2EfkEEGIzryGAHHicdUY45hG
iyf+qRgKMrYhTwHJts9CXATJf6Nst4/Unv5B/qEEUlkrRip2cvyKwLF+DL82BkrB
N78v9UqwCdYOpiVvavUyqci1xKYCr2ykTeJ0rP12O8hAa9fBaTfZ1IeIYGxw1wDa
93nPZm1Y8slfppMfW/hh5Py9yt2xAEA6wuv8VYzvvQ2/cP+FpUMdqqHgFfyLSmqp
Y5qZtWaOtwLuWgQBVK3xYbgpG1zIgnsVtY3PnVjZmoqo+da8VzY8rHIwz8LOUFQe
KMlD2KRm+NWetzVMEBVvSO8xsJjR2HH7uAtl3x4vUMzoMuRcKO3TaJduNBDKHbdK
TyuM2s5lNSxtSaNDl3E++Q9FBNZYCbfYUlyfUWxU86HtB1Nl6+h0dblGhDgH9Hgf
JFpvKNBxhRvaF303Hs3a+IgK64DlMLVSsHbTilOqRy3ZXbhxHIwaEX8yYRN299Ll
4TyXyf4ZnHVtVkZrpLCTJVLyVXpnN7fT5EnSXbwtgCrIullDqepXfKrhLHkTPgK7
2lgJMF1pzkMu7mIiN/4qnn0BJS9kU2utZkt8uk6xVm7rmJ7/hfXbAKsxb3/x3YYm
PcZRjOyJA/W2nwxYlvpDztBb1LiKBYG+ql2zwooMv+GeiHJWEj0=
=qf0X
-----END PGP SIGNATURE-----

--SJjGvHyOfOL82URy--
