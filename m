Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3421D28E
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NtBtAG09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEov7f38"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06A1711
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:30:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 7CBB03200929
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 02:29:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Nov 2023 02:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699428599; x=1699514999; bh=DR
	jluC3VFOUNpZ33gUJnwCPW0H8UuhJhoGYb73KqGqQ=; b=NtBtAG09s/VobrBLbp
	7alU1eLN4TxnhimT4CqioLoj1wA8ifqGxVxgqL92ukshd3BKksPhpkrClG1ZHPY6
	Q7NyGtoA0XDJJ49KtbAjhJRLS7RMZNEcTotnlOGR2j5Mwlgi5O83nho7mfhGvsxI
	AVEWyYMP2lkMjKzbYrhcX49+xNQ7rLYfwCPxqZHksEySQdISsFxlqr8OyyMUQuMV
	gZDSnocXPaokFHcOb8wzDhtqF6C8cthqHVAzw3uhW4+bFuuttlUmnHtrSRJ5pNJf
	IU4JJDuC1ayztzrENJGuNPGAy9cwDwWU+Mo74gfmEPHO3CyXppMqz39EnyIqt8Js
	13xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699428599; x=1699514999; bh=DRjluC3VFOUNp
	Z33gUJnwCPW0H8UuhJhoGYb73KqGqQ=; b=uEov7f38Aic3TXlOlMiofuEIjIrL7
	kyczsnReZZJIm1++hkJr8UEaIdWD7kdMm/DZA+XPw9BSgaPneEynGiC09GBNlFP6
	vDC+hxBx0a3O6Jl9sFfyUWJQpwXYYiVSFhzb8KHl6qEQR2UFgYA9Tf2sQBsYdEp8
	lYzyOWFQVUVgPTfolMeHyU86rTkHPQK/JY4CBHj90ehgA5Wrfwh/AieB607FKe7m
	Fe6NIZvpuaPF5FzaFG52qtig6CUDVuBfPAJJ2tXHoOMwlnHP+yWefOldOpmcGb/l
	C/Sv+c6kxznfjjSjimiSpeS4RSf8GrhZAqTd1HuixCCDphZF6R+grBS8Q==
X-ME-Sender: <xms:9jhLZRx7pNMh8_zISWPXKzV4yTFDX39ZGQ-Acz7PfqZyk-njsuPBIA>
    <xme:9jhLZRSvafF9u5UBsfCs17o23Cm9BA_7QRpGT3DmL_kfF0ETi60FnV7G6m84j3HuZ
    QlA8dVScDX_ORkwKA>
X-ME-Received: <xmr:9jhLZbXbG3NnwrwQpnj3gXJOzvv9C0Tz1fnxrBjJ2wQ9PEY0HMAYoVe2AEFWrBJ_SZZ92otHetlNRftKMnQtFbV2WpzB5p0_vkg3Xrk3go8_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeejffevhfegkefgtdehheduvdeuieeite
    eufeduudehtdetvdfgvdefueduieffffenucffohhmrghinhephhhtthhpugdrshhhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:9jhLZTiWAND35GMimZ8xyPaRQfol0k0PbDrOxv0_dSh7aNzUDyLJWg>
    <xmx:9jhLZTAKGl8xw0rziQoPpjYzy-ycgWgrSlayVXwrOPZUdXUO41n4Vw>
    <xmx:9jhLZcISZGhdFs6QirFn4Vv1fdsWfwCmQ-XZZXbYDUKUn85baENjpw>
    <xmx:9zhLZW8wBeyyebm6K9XVpnylUbuySL4OaKnxb5-2um-IhCmA1KgsEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 Nov 2023 02:29:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eca21282 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 Nov 2023 07:29:33 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:29:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/3] t/lib-httpd: dynamically detect httpd and modules path
Message-ID: <ac059db8fedc6493c64f703814c7db11adb4385e.1699428122.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WCC7p5JVokn3q8qV"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--WCC7p5JVokn3q8qV
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

Refactor the code to do so. If runtime detection of the paths fails we
continue to fall back to the hardcoded list of paths.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-httpd.sh | 51 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2fb1b2ae561..06038f72607 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -55,25 +55,42 @@ fi
=20
 HTTPD_PARA=3D""
=20
-for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
-do
-	if test -x "$DEFAULT_HTTPD_PATH"
-	then
-		break
-	fi
-done
-
-for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
-				 '/usr/lib/apache2/modules' \
-				 '/usr/lib64/httpd/modules' \
-				 '/usr/lib/httpd/modules' \
-				 '/usr/libexec/httpd'
-do
-	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
+DEFAULT_HTTPD_PATH=3D"$(command -v httpd)"
+if test -z "$DEFAULT_HTTPD_PATH" -o ! -x "$DEFAULT_HTTPD_PATH"
+then
+	for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
+	do
+		if test -x "$DEFAULT_HTTPD_PATH"
+		then
+			break
+		fi
+	done
+fi
+
+if test -x "$DEFAULT_HTTPD_PATH"
+then
+	HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_ROOT=3D"\=
(.*\)"$/\1/p')"
+	if test -n "$HTTPD_ROOT" -a -d "$HTTPD_ROOT/modules"
 	then
-		break
+		DEFAULT_HTTPD_MODULE_PATH=3D"$HTTPD_ROOT/modules"
 	fi
-done
+	unset HTTPD_ROOT
+fi
+
+if test -z "$DEFAULT_HTTPD_MODULE_PATH" -o ! -d "$DEFAULT_HTTPD_MODULE_PAT=
H"
+then
+	for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
+					 '/usr/lib/apache2/modules' \
+					 '/usr/lib64/httpd/modules' \
+					 '/usr/lib/httpd/modules' \
+					 '/usr/libexec/httpd'
+	do
+		if test -d "$DEFAULT_HTTPD_MODULE_PATH"
+		then
+			break
+		fi
+	done
+fi
=20
 case $(uname) in
 	Darwin)
--=20
2.42.0


--WCC7p5JVokn3q8qV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLOPQACgkQVbJhu7ck
PpRlwg//U8r3CvWN9ajy1dvGTgdT7wHGsiai5lRKmBV9q65NkDxoPIy8aqzMuCSW
lSPnbbnHf4xkU2VsJt+8ceIQZju5RALRhJUhfxgE9tl9pOsA8Dhtk7YkqP3fXQTN
nfc+U9GgIfjq4KigOC+AzYYfN+4bgV8y6PJl5YcI+mcCwikCBJTkxSIoEJOoI5zT
RH6uFa20D9fPEEL9wTn5vu4GnDOtB4cdno2A60NGUeQAgA8EjNgQtEEoqH/yO2CS
vZmUukdjeEwD5ry4lDQKXSlR4E+lILA8sjl5CQ3UQNBa6VTiBksgJNMaW8nOwlFD
3i/C3xhJpY4Wn5aclGIAjTtsNMg1fHeNN5xg4HIaKSlcFz8u7TeuxEU2jO38/t8b
efBXgaa/SOaPOHBceESh47FhZVw+rEoqHC7PKJvs+5dWn4bfK1VfXW2zG/V9D62X
UW3TLlaiTWDob3QanXWA1FAnaP3AMSz45e2xiYsA2Qi7NKdxzobGUVeT/p1UvCap
4qNFfeESoSysN8EA+5CNF8SUEUDEyec8mGNQfEI4QE0oOfbQq7UjYT79kS91LOkE
HYj+1745oD/ejlmwnaZuMmGGJbsdKNLfcy1UtPodESZC15SLfSgHvztQlOEeaxQ3
3+rrsQWGEpPgGWlnlo+wgXmQteIUG4pvJktBQEXyTPKEPWEbQKI=
=oBi4
-----END PGP SIGNATURE-----

--WCC7p5JVokn3q8qV--
