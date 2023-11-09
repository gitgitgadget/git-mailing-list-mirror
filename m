Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DD107A6
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oy2IWgaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbX23n8h"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3C2D4D
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:33 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id D8D655C031F;
	Thu,  9 Nov 2023 03:05:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 09 Nov 2023 03:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517132; x=1699603532; bh=+t
	kx3fx5EgGHUfoUOBZoiUDk+gIjHARAvgjBoP3TOr8=; b=Oy2IWgaXIYM37ZnE2W
	GwOawhnux2rD1BY4/n7y0X7wkqGGciMohh/JBvlcwL+J6zuf4NC++ONQMPL7P57J
	NS6f5FJe8qPz0WVFXN9osqjQN5FQHcVPBq9G7anoYtDNzvsXanRoRdyAEoLrjfCN
	JGUs1FY7MZ1tMrOk90y9H5cPDWcv3b3Y8wFjZ++HrnanTFi8r574w8yVRsm9nk1F
	Q0VgZ9clOQNSNpIAqzR/KDJ8pLlwtRpQYkXsvTZFyipAV24VOPTVxyk8rCFN4G81
	PRq3QuoPOtSLfzsXIsEXrHEIIawmVXd/u1SQsnky8lviSYW7ugrRqozNR7thSGos
	SyPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517132; x=1699603532; bh=+tkx3fx5EgGHU
	foUOBZoiUDk+gIjHARAvgjBoP3TOr8=; b=rbX23n8hPmlA9VVDn+HajvtXGyCma
	QmLfYW+IXWjzeErA+wup8USK0wrWq2+QhklOxJWjimqvMMVP7LAq1VeUN+CKRO3+
	AHkjrKgAX/D1ogW4R9bNJzRPZsftN3rC5smViHR372snBleffJxjW5aipA4lxqOL
	ugIvO2Ag691NCXSqr+0tl6OXGTY2w8gRd9Z2YZuF6p4MwcHqwGB7gTnGU56TSUSP
	1EHB2eSnQAYufHADdRa3cNXNQYLnNqg532us0rwJbGSuI8KCnm9Wi/3o2cEdhRai
	/UCIm4iQhk/RJh/Tl+gRPuwwvlhHnWuXzjtsz0e6K+mANo0kk1CSQBfMw==
X-ME-Sender: <xms:zJJMZQBO62Ugzmyfex7jsQEdKAGZM5FCUrnsYEqWETLcd5ytneFnDA>
    <xme:zJJMZShSOv0riJMuGyS51q95KGVD-71gzVsSxTJg-24aw2nR5Db1hR4G3SS7rBSQS
    mNLZXthDWjPGg3Yiw>
X-ME-Received: <xmr:zJJMZTlD5ZudicLj6WZ2D3BDDcN-m5qCQUZ-zoq8ia6QSBOFwDNvsR-_wl7kJrJ-Tf0QBeFAx1vv2OcOc79M-QALkJO_qmd_W1wO3JelIT-BLbBm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zJJMZWxBcgaJfKTZXzD8yANU6aCOPrRkFWJSxweYJSKJWbQ0KpCTDA>
    <xmx:zJJMZVSnQJmW1P6xXakkwF-gzIW-_ShPG20qLmVtCTUYVFfqAva8aA>
    <xmx:zJJMZRZTM_GhNpJl1QGejwHuaWlDax_ohnRhiGKYTzbQOTXgbCPI6A>
    <xmx:zJJMZeK2PfrG5IhSPbkYS2oeaRVOeWG-4r1Q6MXB2F-2T70qIiCGFg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcc852d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:04 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 2/8] ci: make grouping setup more generic
Message-ID: <29039d7aa3ae65f92d3b32dcaf26e753d262869d.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UIVqmb2RRHeK9rzZ"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--UIVqmb2RRHeK9rzZ
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
index 029819673b4..2ee5abeb02d 100755
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
@@ -285,5 +283,5 @@ esac
=20
 MAKEFLAGS=3D"$MAKEFLAGS CC=3D${CC:-cc}"
=20
-end_group
+end_group "CI setup"
 set -x
--=20
2.42.0


--UIVqmb2RRHeK9rzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMksgACgkQVbJhu7ck
PpTwPA/+KWZ3U9qZ6RuoYJInUlmuTkjuYtx4V1IIjV9EkBdQng+FWZKt0WeOUcpP
ewLPvX0ZubeHYqU0upmKFqviuNJMwts1y+kYBZ+G9MFPYoiVTvvrVOqJlzqgzF9b
/NR0iivNzwa/tyqi0a3/oP4J2m00Ff8quxJz0qhm49lD7hYNslBuuvVs485SxR32
bof28nwdUDbhwUY6UBVbOaGjf+rxT0j2gVi7N07AHiECwRUu6CrzdLG9M8XdsTPA
R2U1xZGbpEN/rlDZ6c5N1VetPM1FaTaYhy1zUQgKwIM+ffLDoGQrKknPn1bQ5k13
CKT1CcXcDX3MSig9Sa6tmxtGDwVJm3wK83q6xIc2xIlHOMwuhoO8TVSXYNnK1Ofq
ydQ/igOSUI9vdll+yhKCq878HcGCer5Nr1z4HN/63dy9W5DjJQEEQTGp+5zi6uip
XiLCCFqkxnf4+DNKiMDm9a9MaHonK530qxfAIvSI2EuZ9ho6KxleR0Cvm+ns6ze5
5WIy5xqPUJ0dtaQyDK9ovdp6MDT+HXBNxKmg9FHujB1hv/yJtlVLyCUzvFRfRNB0
ZBISKZIqRA3OWPasyh4vTCzQrx3nWYyDAVwKMhme/NCJmcf/bob6qBY+V8c5rbM4
3yIrVlKNld01KBs33OxToIP2n8RrBk0okEYCk6Hf7KhyeXeVGGo=
=qyiR
-----END PGP SIGNATURE-----

--UIVqmb2RRHeK9rzZ--
