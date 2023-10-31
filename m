Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4013AC6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o/XCSOQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gV+kWKzl"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86451A2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 02:04:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 9C7563200077;
	Tue, 31 Oct 2023 05:04:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 05:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698743089; x=1698829489; bh=o+
	/fVWUHURDneiMahar9ykRw0+Xn8DG6uPcEBqOXIjg=; b=o/XCSOQlTeCBDUhAPX
	VBsLTen+FsbU0ES6YvrcnDBOI3BRcKs7G/QPo9LDRO6MlpUKQBXW5vemqrp6aRnY
	jXSTJel71YzXbs4tyZcWGFKbS3uTQHDXxceGX+s8S01eu2cMuRneDL/U0GBbHvpf
	bTB059tJcmsOgjkHEbe7zU8wNRZds4whsl28c3uBZRt402iZdfa4JKZWcAh2eTbv
	nj50OvKaJoUHufkPal1hvyhVywKaqerx4Ict2NLu4z2VpfAjsLHmzBFhPmbhE1vl
	fdVKpxnfpcnO+t+Eq7SRd0PaVs9EzE/apGl4S2GmQFHyydxeT902AeZbZHAt8ZNf
	4VqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698743089; x=1698829489; bh=o+/fVWUHURDne
	iMahar9ykRw0+Xn8DG6uPcEBqOXIjg=; b=gV+kWKzlgzf202lBYS0h1qANi4aoS
	S5487x8/MTVbXWgFhSqn1fkaY30Zv/9/PH4YRaATIORMJl8SMApAaD1ViI2o/TnS
	0f7yRJDGl7JuvofhPI3oB/5QgNraE2vP8Xjh6Qh2iCEWzU0WAEJ7ueECMAWYB3sA
	9IWn+KGLvCM9Fs0IFarA2ctcf3rM1ZeCO+iq1ZFo4Yd4aTasMNhuwjzwkTO0IIJB
	CAqDsXRpRDQWaGr9sXX3SB8C4lnV7DpDOsClQaRAHhYb0ckAgOy3Z85wZKEUftRY
	qxwVgABeaIMjRqQ97G9seuaDoMtZtxnrf9TOUNc1JyqcfZBWDd5PGdEew==
X-ME-Sender: <xms:MMNAZXvQzNuAQef7869fZchbK2s440k7UyB8lj4AVsJhvE-Vbkzsig>
    <xme:MMNAZYdi3bwwaKe79Oplh5o3MD5kWTjAWo3BvyfZJlVpG-SzkZKr-eOw82FJukIJR
    Yq8hUKS4FBHfKL-rA>
X-ME-Received: <xmr:MMNAZayVnC73x3REoCgjAbGTaoCFDM7YMZ86pkIglUofjnKjFcDqvEqCmZfsJWpwjbuckVbsrp4WJ4BzI700I3n-uFDPAmUfY69tbNkdvnnXZanP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:McNAZWOul-5TGMLc_drNvyQ1JaFtyd5DDqk1DDc-RKhgOkHh53KkAA>
    <xmx:McNAZX_2ybYFl4AablVTGLW11NFZtfiU49gjEDB2zu9llMb2wWBtug>
    <xmx:McNAZWWqbifrAZpAxVYhodmL-XH9mvtYRZDVqcjuW50m_tAJWiFlbA>
    <xmx:McNAZaYXWhKOE8Z6d3qgy51SnHlnk_XloY0d746qNn68eypvNksKYg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 05:04:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c894318e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 09:04:40 +0000 (UTC)
Date: Tue, 31 Oct 2023 10:04:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v4 2/8] ci: make grouping setup more generic
Message-ID: <7358a9433927aeb61cd9dac1b8ae651f13e11f5d.1698742590.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698742590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PWyojgZHfgyKwAeL"
Content-Disposition: inline
In-Reply-To: <cover.1698742590.git.ps@pks.im>


--PWyojgZHfgyKwAeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Make the grouping setup more generic by always calling `begin_group ()`
and `end_group ()` regardless of whether we have stubbed those functions
or not. This ensures we can more readily add support for additional CI
platforms.

Furthermore, the `group ()` function is made generic so that it is the
same for both GitHub Actions and for other platforms. There is a
semantic conflict here though: GitHub Actions used to call `set +x` in
`group ()` whereas the non-GitHub case unconditionally uses `set -x`.
The latter would get overriden if we kept the `set +x` in the generic
version of `group ()`. To resolve this conflict, we simply drop the `set
+x` in the generic variant of this function. As `begin_group ()` calls
`set -x` anyway this is not much of a change though, as the only
commands that aren't printed anymore now are the ones between the
beginning of `group ()` and the end of `begin_group ()`.

Last, this commit changes `end_group ()` to also accept a parameter that
indicates _which_ group should end. This will be required by a later
commit that introduces support for GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index eb384f4e952..b3411afae8e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -14,36 +14,34 @@ then
 		need_to_end_group=3D
 		echo '::endgroup::' >&2
 	}
-	trap end_group EXIT
-
-	group () {
-		set +x
-		begin_group "$1"
-		shift
-		# work around `dash` not supporting `set -o pipefail`
-		(
-			"$@" 2>&1
-			echo $? >exit.status
-		) |
-		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 f=
ile=3D\2,line=3D\3::\1/'
-		res=3D$(cat exit.status)
-		rm exit.status
-		end_group
-		return $res
-	}
-
-	begin_group "CI setup"
 else
 	begin_group () { :; }
 	end_group () { :; }
=20
-	group () {
-		shift
-		"$@"
-	}
 	set -x
 fi
=20
+group () {
+	group=3D"$1"
+	shift
+	begin_group "$group"
+
+	# work around `dash` not supporting `set -o pipefail`
+	(
+		"$@" 2>&1
+		echo $? >exit.status
+	) |
+	sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 fi=
le=3D\2,line=3D\3::\1/'
+	res=3D$(cat exit.status)
+	rm exit.status
+
+	end_group "$group"
+	return $res
+}
+
+begin_group "CI setup"
+trap "end_group 'CI setup'" EXIT
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 #
@@ -287,5 +285,5 @@ esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
=20
-end_group
+end_group "CI setup"
 set -x
--=20
2.42.0


--PWyojgZHfgyKwAeL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAwy0ACgkQVbJhu7ck
PpTXSg//b+HQ903MMiTL0LjQWXJ0c9JSS3wscTNsh4TmBP2gEEdA7aDA70llzIOx
DURanPHzfTWCU1VxCF1zcktaIgl/gpkYiX8wgIXUDA4c9c2KmWYYac1hpS5JR+3V
phHSH9xCSN7Yq+sluU7qjLhkG6MbQd7D/LvYctyPQRF3WC4erip9dZXLxl6pnbZQ
vwmVCp9yuDGM9eHW6eR2zKsDGA3G4Dy53aYUQV9FKeSTjluflFCgy+kcn5eUFqzD
DtfcaEJ4W9iajfhr9zRM18kSqsVUsqcWKPXHsru3R6+1fjd4lA3OdWTnaoBdSOjX
uwDUwNX8Sd8qWfN9FVQQ31fXif/k//THX+6pkoBFEa9wY8ERKDBY+A86eOu7qrRd
H9YvcGaCrdxsay904yhdsdp4CLXBftMmHevv5vgN5OA5xvZWrxGV9b2jM5dRUfSG
JwvkdClyAcekLz51FfiexByXTEoeOvRZWA6RLPoutrN7NUEW8W1MgY+0JcSg/pMb
PP0fmiGEv3yWCc3+nBGaGG6bcVxGuSEIhJ3FFNNZJl1gCMWXd1w97GuDn98tN+uy
JM7SfPaG+APGDxnDNE2O4Lm/wpTFzqnMG4+oZld40R6qE4QhWuAAN8ch2wQp2kR1
9Bdx4/knp3+2eQTw/IVlcCwL0zKqYz8bvpQd2ZMLDXAAtyO/MjU=
=nrrm
-----END PGP SIGNATURE-----

--PWyojgZHfgyKwAeL--
