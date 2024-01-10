Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AD3C466
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U9szqsY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7fImizCg"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8F1543200A02;
	Wed, 10 Jan 2024 04:01:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 10 Jan 2024 04:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877314; x=1704963714; bh=AHUBPTRIdk
	2XQ23ZlFiS9PVLuF8+pbs7IAZIcTdf0Do=; b=U9szqsY7OkGz5B7rlsHHTekfYW
	ylVCAhh5M3v2F2neVNi+khAUfH9CScVZkHQGxl2wyU8xfAReX0v3PX/5ev1xiTUV
	4M3aD1jvNYGkO5VqJHe3kANIolAroEA8Sl1bFy62Lkvps1BNm06aMUI4B2FoCok4
	O+yiP2qVMTdcUHWQC2rENwvDES6NkGFfj79Hn0oJ5vxCU6rMA66uCoETjY/CtO9Y
	InXO92ySK7tUZiwXjJBc+rflbe/rqyoq2TcrbfMloxUy6nKhwya0ra+MupGIDli+
	iGBtI7MowfGVQ+DMVcwUU1jpK9DpGGd+Q2TVL4cRWlzc0POk2Lfhin/V+PoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877314; x=1704963714; bh=AHUBPTRIdk2XQ23ZlFiS9PVLuF8+
	pbs7IAZIcTdf0Do=; b=7fImizCgt6J2i3p8AAbZpphcWHLYjJGSp2GMF3asGhdd
	2bKLveQkZRXFCQ64wLnr7/OLonaHO0IgW1FIVUkLrO1yeGG0EXq8nTGarGJzMSiU
	5F4ZpKJEaeB4MTEVpGn/tl3ltOC0xdcAyCgSAN7YtnuGQIDQg65SzxGosa6PZ68b
	Cj9X2vtp4g660zpp5JAqpraaJtQnkfQMxCAzDL0tyxn58QNPm87eqP/GRUkf7ebB
	EAtT6r/NFPSAT1+RdliX1lBCj00AVJBbIWGPHqOHb5TlAXUyo991UqvwyS/RJRHT
	8FsuvoZU/HF0FgiXPkfJ1OTRr35OYRoppzpX6sgBwA==
X-ME-Sender: <xms:AV2eZc7C2neNB3UdZsUKu0Ttf6yoi_E5XiA3VFy15HoYkn943p-WUg>
    <xme:AV2eZd4hCBXRrfD7pgH1C7ok8XvNVU904YcptlobzV5_qZQEYGDAaBAH22KxzDD28
    Rk1-AtTVid2yCWDxg>
X-ME-Received: <xmr:AV2eZbc37PbCCD-P31N6wrTW4liW-tuMQvuJKz4l4JZWY5Ziu8XDUl7r_GvcvPwV_wNp1SIgLT_msngcZNVnkNwqa--HrCV_PpDuDDBA6ZQX3f4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:AV2eZRKPObBf_YjDHfyVHdKM8W0Uhgrg0_O-DzO96EyZO75b4Gy4wg>
    <xmx:AV2eZQLb53tBdPxb2bzpLRrrfSuKApp-V4DxEIAq4GuUmtcOE-MGXg>
    <xmx:AV2eZSyoOjOyyI-KlXIsW5_Oe0LC25vyc0iIHr5rUUG1shwGwDIH9A>
    <xmx:Al2eZaiqOG55c0bZ7TQZ_gp8jDovC0U2tZzNpvftI88u5eYa5d1xDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac0f7ef1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:13 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/6] t1419: mark test suite as files-backend specific
Message-ID: <c6062b612ce5793a716bfaec8082a5ab992cdd75.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gml0pbnVoYVohA7O"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--gml0pbnVoYVohA7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10) we have implemented logic to handle
excluded refs more efficiently in the "packed" ref backend. This logic
allows us to skip emitting refs completely which we know to not be of
any interest to the caller, which can avoid quite some allocations and
object lookups.

This was wired up via a new `exclude_patterns` parameter passed to the
backend's ref iterator. The backend only needs to handle them on a best
effort basis though, and in fact we only handle it for the "packed-refs"
file, but not for loose references. Consequently, all callers must still
filter emitted refs with those exclude patterns.

The result is that handling exclude patterns is completely optional in
the ref backend, and any future backends may or may not implement it.
Let's thus mark the test for t1419 to depend on the REFFILES prereq.

An alternative would be to introduce a new prereq that tells us whether
the backend under test supports exclude patterns or not. But this does
feel a bit overblown:

  - It would either map to the REFFILES prereq, in which case it feels
    overengineered because the prereq is only ever relevant to t1419.

  - Otherwise, it could auto-detect whether the backend supports exclude
    patterns. But this could lead to silent failures in case the support
    for this feature breaks at any point in time.

It should thus be good enough to just use the REFFILES prereq for now.
If future backends ever grow support for exclude patterns we can easily
add their respective prereq as another condition for this test suite to
execute.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1419-exclude-refs.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 5d8c86b657..1359574419 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -8,6 +8,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+	skip_all=3D'skipping `git for-each-ref --exclude` tests; need files backe=
nd'
+	test_done
+fi
+
 for_each_ref__exclude () {
 	GIT_TRACE2_PERF=3D1 test-tool ref-store main \
 		for-each-ref--exclude "$@" >actual.raw
--=20
2.43.GIT


--gml0pbnVoYVohA7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXP4ACgkQVbJhu7ck
PpT+4g/+I5kBri/RuFSDpXiXXi1ErlpHtLJIkfAi+BveXZIaFKabjRJYxh/o6ilt
LC4umgq5LqWSsk7iriBsD1aJgqjfB82LqZ4bl5fto3rVNAaV/kmZexuS4yBtvGFd
maDF+mqchCnu8H8hGI4Eirl2nAOhl0iGWFl1cdlye3n1ds+o3IxVdDTrJBWh1yfX
KHkZfsvhE7n/xAG0DJId1sgv/DiAdpYD1G7eyNPcBcbqscVA/EeDhbLpPOhV3wXD
SRb+0iNy2SjbgqTrc8m777la+yz4vJiasFOipblaQKBj8dQXJNumz/XnHeDEiZ79
64DRwP+UEhwtCPUUn61gRgB+XyvJrybzl9lmHJTVmLIka1GneSbNvC5+nua0hwWy
LI/+BNWviyAWXYISWmoGw1MN8xGg5uwhwy479Rn3KThfsHYGcGKSrySZRMNgob3o
iKTkfA+iC35Qs/vOFa2mj+dGaE6OjALddIIW391CVRGPkd8CkNooKd20FRYglt8y
1Rs4C6UrtEbJgyR/NGFnDSH7Ts8eT6zbR4jOFRzBoLUsBbNMOFDvy8UPoOXd4bpf
V7d3RkGYDQ1JSGIEnZkHyVnS+lehZQdfsmy8gQfH6GculnWv5rBUp3pJTma1U76a
vE0VjKLpPUrEL99aWFPcEFsApCeNqXeoItnPO5WSIdrdKFQvt/4=
=J4xi
-----END PGP SIGNATURE-----

--gml0pbnVoYVohA7O--
