Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DB38DD6
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q9Ol00LV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fvGZ0une"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id C73DA5C040A
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Jan 2024 07:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802647; x=1704889047; bh=JLdKoPlrc5
	jW0Cpx2Ws3HKBKhGoHfMLZNeBw3wpNJMM=; b=Q9Ol00LVdLYuIJjVXzRfsyrSnC
	cWHtt7VL6wFE4VoXOPseSFwxG0u6OBvNbmQkxDb33B6AguhyRwl2UxmTDd+0keDC
	jf+aDtwnNNJHVczAeJntbOBOBURZr0unfVvEuJw9yK3AKSmFdFiS9RUBmOtC7ttt
	15vfRtFkPtjJiE09SO6LiAPOFZGO5KDkXQp4ztHzhbZchZZxTd0lNELmZYXyIHUG
	RX+5KCModZrEg4BYRqymoICwN5th9TVw011l6a902gDbvsn7qrQuU8/b5b2zwI5B
	IOMcGLANXmXWCkSgLuNGtu1QBxVPFkzjY/ebrjvEM2n8CuA3GRVOFZkwlkxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802647; x=1704889047; bh=JLdKoPlrc5jW0Cpx2Ws3HKBKhGoH
	fMLZNeBw3wpNJMM=; b=fvGZ0uneVJdXHKEXGaGel70m/fs3k//P3+cHUCRR1t+z
	fswdQzATwROayDvuGb5xe4KPYZbqO4HTyLmMljkfuVJDT8soRKuifRQ13e31Gwrf
	iPzWPZby45i6lQOB0291NA99pf0Qmm6yIXwsvQUK+CPfVWcpWDesZN8tpfwuSyvk
	SuZyXPDbjLzMs3jMuHZooiGz9kyRWvZBnZ07AOHkI6AT6v4cSsrpQSEusbDWUm4X
	ZvTio5GjzQCRnL42kvj8whM4bxnZylk3edIEdRNHRoS3BXqKOUwwD7hkN4TCemoI
	ZglYljNQeX21VzwD6cnJ2cGL2nTFlcmtdTM9EaH8nw==
X-ME-Sender: <xms:VzmdZX58XUx4XPkaVzf414uCp1QWXMxCtHiJkLNo2haHL-hKtRUfLA>
    <xme:VzmdZc5RxdGtJD__60V5DP-4TgDhdTcseMfUihZ7SLniUegflX4dA3Wn3V8YOxc7p
    DrJlyt97P4eu-_v3A>
X-ME-Received: <xmr:VzmdZedAy53FopAiC2QzUR41Y5l4rZDCBezQWpytKeZTe3Jayy4MyO3-ad2M3Y4i0WPoCdsACvvvm8jeuZ6lJEUyZnRicq6zY4J3mCfbGaBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:VzmdZYKYsTdjxtxv2mTAawBgAuGCvzcb6CJDG2m458uX7bW8AI7fFw>
    <xmx:VzmdZbJ_vtXM3LIlaEU99phGfRgprpz1YJRCTvqFGVhqK2zX1Qe0qw>
    <xmx:VzmdZRzn1L2wSd8X6cRDd9izNSfpWpbgDmuizxv9ErTylq1_non4Hw>
    <xmx:VzmdZWmwyMwQSVQnehTl_S9Fa1rDU2cMfgfESntiOuecUQWkrLliZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e92365c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:48 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/6] t: mark tests regarding git-pack-refs(1) to be backend
 specific
Message-ID: <a9620f329d22c772b96737a5571d85a274dbf6f2.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4NSMdfkAwCRvEyo"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--k4NSMdfkAwCRvEyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both t1409 and t3210 exercise parts of git-pack-refs(1). Given that we
must check the on-disk files to verify whether the backend has indeed
packed refs as expected those test suites are deeply tied to the actual
backend that is in use.

Mark the test suites to depend on the REFFILES backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f23c0152a8..7748973733 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -5,6 +5,12 @@ test_description=3D'avoid rewriting packed-refs unnecessar=
ily'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7f4e98db7d..c0f1f9cfb7 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
--=20
2.43.GIT


--k4NSMdfkAwCRvEyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOVQACgkQVbJhu7ck
PpRnPQ//R0xj0ndaO7X3GgHiEzHi6OMmqpBq+8N0zf1Jv6M3OY6/Ka4DXUtn5KVS
t0wIzaxNCC04drx+R1kAajdUTAWFLR4AOZsXE/1GIApg53isRKsAaPbn9iNOOpUb
uO6qbLK9/LLbf/VDuKAGaAmFvaiIdbZWMdkzSlsuZtd6OXPsM2+gwdIba9u0PWnL
CvdnABXyPqELSwVcaQPJY9VYrfqU2wvB7mFygDC80BV3sgERbQjrwm6EvqEBuVY+
oPTyxVoSvnNOA0CMuj+0Bx/YlMY1nmzcvPySTqUl94Zf15WcATpNEynJuHPNxjL5
Igii6Vocrbdd8/vIK6jc34m8++qBYWt46uda4bNKfOvk6Wv0kh10pgLrLck2k40r
0Ex4CUAYRjnsViqrNo2IlKT1eJayOsogVZMKJiQcEP4/wFp7Y6P5EQW1+5JjNE1F
7od4oSdnLa0j6qBdMIawJs4FdtXmreZeUssf9noHmi5i4uO5PHHrrbT7HwHtFGRn
5FbDZx2WE6T+3nC1qi+pdEyomvRiS4A8+mhCA9fbj87LMGXjANJ06DZtbhNNxgl7
P6NwybrhFLMB8iayk9t6k4xapEHxjVfNX7WqlZnmBc8d2/3i/OhQImjvxS3o9EyP
Lxse3v3R/3AK8mCh1RSYKiPCfdf2BomlJ2PeiLdTU2p33HvVih8=
=02/G
-----END PGP SIGNATURE-----

--k4NSMdfkAwCRvEyo--
