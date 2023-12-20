Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4B21352
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ktvdBkle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TS3/aUxw"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id F12075C01DB
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 20 Dec 2023 05:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703069726; x=1703156126; bh=rbMvPN+HOI
	8RwJGRVY4rmPQGIOt2MHNJK5mwxuMn5c4=; b=ktvdBkle3ynslgthxPPp5DQ3l3
	c+dLM3KSpWqNpOoPsnDh0nKvLzYlE1Wb6MHK/Mg6m0AOhVJGNAfXr1jOSnZKcoJw
	OSHM334mv63Uh2DClbEXCzeKex1fmgLaoLZ/o5PES8hDo0jRmgIjOjQ4dWuWAR8h
	xfs5cMPgqWrs+TzKLxhm+n0kJ/sATe45pEkSn8QM61khx+XOY/Mk+VgnbTJOUJ4n
	MSLhKASiDDeCl72QkqzEh2rdpsOtlc8kv2CzDF/CLjbcxhopv+EnhXqaxAxmfj7B
	Sd2DGFcslaq4QTSRsYV8cqWA/2TRxX0tUrHnZUPURONTQwXbtL7aJHWuBHXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703069726; x=1703156126; bh=rbMvPN+HOI8RwJGRVY4rmPQGIOt2
	MHNJK5mwxuMn5c4=; b=TS3/aUxwN5rSQM7vznGCcHv3IERI/thsjFSEQvad9Pr7
	9AuJ1q7yxSdUN7GTTGR+aBncCztvPEnkCaXSoQwlzVqIIMhYol7VTvubu2sdmzoB
	fbVhJ3v5y9Jiyyc4vfKjqQ8rTTG2ZbEdrAptt83b5fZoEdRo5UwEXsVyoDXq2zPO
	B9ciaGt4A9tT/ts/0XbX6dhNj9TcL1zsrPIcufvzDO0SitphlqIvw/HceGY3P4TK
	YEU9iNDitaInJMd7miGLeME90HCy3WTNbKf7yR76FnIS+lf7fpGi9lrkh/r4/1tA
	/wgzhkG2iNuCpmYB+2Fpszp0M57RpZQUDdVFKUc2tw==
X-ME-Sender: <xms:HsiCZQAplD-vX4Ea0Um1nozA3JqQMv3KazKIjEvkBVs0k2ebg655RA>
    <xme:HsiCZSiR4UL_wXopFePObsDQdEEhyhxglPSy2O-4S_sYJOJQZTRIFhi7wB5kMj-Bk
    GL31IpfAhA7_SIVkQ>
X-ME-Received: <xmr:HsiCZTkWtZrDoE2uz2IwdiRdfGfB2RvK4bUO-Rbq4wcuqVBKRQNP4Z2LWmZI_ZA9PqOXUfQ0MtBReCLmmKxQHbWFZwmWHIafpjeSyQ1cRikymQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HsiCZWwYgcAxcp4teOqlBoZ_m3HIqzB3YpDHE9ARl2f8IHMXvzatlQ>
    <xmx:HsiCZVQyvFpCZkHFRUMeoA39z37bSAowGUSZsBHRYpYZzFUL31HUkA>
    <xmx:HsiCZRaCr3W63XF5Hxyo68oq4dKa0exRD5h2QDNazZvtBKOL2yCNuA>
    <xmx:HsiCZQPBx_r8Zub7YDggHqZ2P8NU3yWcDFVXU62ya7mAP2yxicUoeg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 05:55:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50e8d6bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 10:53:31 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:55:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/12] t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar
Message-ID: <ed3bf008cdb043fa51bb6c1e211760f0e83a813c.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N+fEypTkeLfA4APY"
Content-Disposition: inline
In-Reply-To: <cover.1703067989.git.ps@pks.im>


--N+fEypTkeLfA4APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new GIT_TEST_DEFAULT_REF_FORMAT environment variable that
lets developers run the test suite with a different default ref format
without impacting the ref format used by non-test Git invocations. This
is modeled after GIT_TEST_DEFAULT_OBJECT_FORMAT, which does the same
thing for the repository's object format.

Adapt the setup of the `REFFILES` test prerequisite to be conditionally
set based on the default ref format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README                |  3 +++
 t/test-lib-functions.sh |  5 +++++
 t/test-lib.sh           | 11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 36463d0742..621d3b8c09 100644
--- a/t/README
+++ b/t/README
@@ -479,6 +479,9 @@ GIT_TEST_DEFAULT_HASH=3D<hash-algo> specifies which has=
h algorithm to
 use in the test scripts. Recognized values for <hash-algo> are "sha1"
 and "sha256".
=20
+GIT_TEST_DEFAULT_REF_FORMAT=3D<format> specifies which ref storage format
+to use in the test scripts. Recognized values for <format> are "files".
+
 GIT_TEST_NO_WRITE_REV_INDEX=3D<boolean>, when true disables the
 'pack.writeReverseIndex' setting.
=20
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 03292602fb..61871b2a3b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1659,6 +1659,11 @@ test_detect_hash () {
 	test_hash_algo=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
 }
=20
+# Detect the hash algorithm in use.
+test_detect_ref_format () {
+	echo "${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+}
+
 # Load common hash metadata and common placeholder object IDs for use with
 # test_oid.
 test_oid_init () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4685cc3d48..fc93aa57e6 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -542,6 +542,8 @@ export EDITOR
=20
 GIT_DEFAULT_HASH=3D"${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
+GIT_DEFAULT_REF_FORMAT=3D"${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
+export GIT_DEFAULT_REF_FORMAT
 GIT_TEST_MERGE_ALGORITHM=3D"${GIT_TEST_MERGE_ALGORITHM:-ort}"
 export GIT_TEST_MERGE_ALGORITHM
=20
@@ -1745,7 +1747,14 @@ parisc* | hppa*)
 	;;
 esac
=20
-test_set_prereq REFFILES
+case "$GIT_DEFAULT_REF_FORMAT" in
+files)
+	test_set_prereq REFFILES;;
+*)
+	echo 2>&1 "error: unknown ref format $GIT_DEFAULT_REF_FORMAT"
+	exit 1
+	;;
+esac
=20
 ( COLUMNS=3D1 && test $COLUMNS =3D 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_CURL" && test_set_prereq LIBCURL
--=20
2.43.GIT


--N+fEypTkeLfA4APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCyBsACgkQVbJhu7ck
PpTQsQ//cWpsXgE7Bp6p8Uoy636wMGK+7flZHy4ifrmnfop974dhYRc9jNcDvBZS
ly63LuxCjWjSSTvG8h4SAJsNNjMbhGhIPtabzo1IqrwjVnvasG0LRY0/Ai0HUFzD
3e65RTVffK1ouCBjO5vgdTgrKoJtqGggKn4GWv5oNwfA9Ai+BT3vzaOGMZGlBss0
ZQ75IXZ0JT/mVN/KBJj4fqthCeKnQC+1Y6fJWcXdMuZOTv2N5NQFnOciTIGjUsG8
82CzF7/B2zNg6OE0z4f4VYz7ZDWqyZdc9/BFWS5Q3WKCwQSlZ+eRIfw8pQl+gnjs
CHPi/9cp6z4giBkbRGvoyr5PtPZTiySE/NaINsvzW7mYSDeJzheA1uaLNZGk1tLF
aM1mgaAp2JzoHqzZaAC1QS0yT/zLBvLQqL7D5KtSLztjqt4WgQKPNfmYnidfujmV
0l736tsgKi6/u1MauPVPO4iUjKaJlhNzPq8S8RZFY7M8aNhkqy1XjNwNTFw+EF0X
dryolzrrzIO5kVYW5Ho0SiJaTkgQ5kshS/eQ91mx/cLHz+kG6sWBLwJADeadqSVH
2gBhs1qkYbn7aACY437W6orQS5RA/6+vGDwCh5QZYoZP7tiP32KSZbeysqoRG6FF
y+EtN/q/BmAsjTi/0oAlODL1IVvUaZL00S76bhi2QQjWUzMAHNo=
=YVE4
-----END PGP SIGNATURE-----

--N+fEypTkeLfA4APY--
