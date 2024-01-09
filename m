Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF338DD6
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y+QVXIdi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6iYqq9G"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E8E8B5C03AF
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Jan 2024 07:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802638; x=1704889038; bh=tZRbjzl0QV
	dGeYESEJ0Jfn4Oba5mNumZdzbFyilPiBg=; b=Y+QVXIdiBM5cigCMOfDOVYdDQZ
	Q7nfqGJ5o05az5cLhEeHJd+ai0z0/RaWoF9qMovywjgMaXnsKNEgziWo99alx2vC
	zwxI6Rzzf/sR28VvzPxbP3nmW2qzXe3A/2smMRVUunEQBUfhPlpmQa5d2q6JX2sc
	WXSx2wi1Klaf0G9Kaw/kSiiQ/8Kf2NRnhaTy+Lk9VyFLlvZnRKQsfq2zapyMXUub
	+Yp0nouLpVzn/azho1XNftYEUfmqG28JD4kyEe95YT8yygCS9IfHdmqb56CboECC
	DCoqb2OX4qGNVi/uRm5cidEZ3XuDOGI/Z8p4weMQ3KzY9oH1+m8PsIXAfP8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802638; x=1704889038; bh=tZRbjzl0QVdGeYESEJ0Jfn4Oba5m
	NumZdzbFyilPiBg=; b=h6iYqq9GjMVt6PXw5hqQNdyfONCa9z1r3LkEcVANted1
	VMmk3nnfRa9JNXApVGnQCpnlUEOEIVOedn8LZcaHYXn9svuz6ignFpQh3pITGGpR
	OmQUvP8paKEs2CkPk4ukC+UN65m9YTNiIQPUQGMv9w0PzxjN+tGOJbiM1Tsa2gUL
	28sraOlLawJhEXcYgSVh43+XES3TzN1aww1rsQ3D3ybkXa0/mrW3VlIHwZqW9Moj
	5BX8biUA8A0yY/yOY9tVKD6qSoQK2/9UljKA6vGZGpn5nZgVrsMzs4T22oQ42aIg
	FF4cbK100iKl+WCr2zn/VUDgmapXZS1tmInKa3qcuQ==
X-ME-Sender: <xms:TjmdZfRveMhzlkcMQTDyjDd00i3Dj4ip14dEjdHtaEI1N2eoYplbgQ>
    <xme:TjmdZQz_wqQ8X4MBYDoKRsM919inECqEegUKinbmebxkqpjV2TZELCL9xG8YMU0p-
    U1_xHozD3yBrvDvpw>
X-ME-Received: <xmr:TjmdZU24m9Z2w7F-ZgSEca3Pf0w_YUv3zwgNmwsCZa3FVWlDLaI7BYTUWvw7ybWyKed4ybmQkZnMJZDI-4m6xpymD5XtvgXRwEl7F9JwVqx7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TjmdZfASwjkY4TJyy3wmBBA6tU5Q8odKCHb0yLaH7Qb_tn_9UlJOZg>
    <xmx:TjmdZYh0KcZzb5NxY6EZ_UIW1ofkhARdx4oR8FIQ3OM-Ns-TDfyF8g>
    <xmx:TjmdZTpqn3yPBAijTfcCoohB-Tzz7VabIocSquytgLhNmJhzX5jsyg>
    <xmx:TjmdZWeHCxp_yYA-eLkoXL2BTb-vXI6bz1nqVrN9IimR4Z59-kv1Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b64e425c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:40 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/6] t1419: mark test suite as files-backend specific
Message-ID: <d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+GxcCR1WOBtJbgFQ"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--+GxcCR1WOBtJbgFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10) we have implemented logic to handle
excluded refs more efficiently in the "packed" ref backend. This logic
allows us to skip emitting refs completely which we know to not be of
any interest to the caller, which can avoid quite some allocaitons and
object lookups.

This was wired up via a new `exclude_patterns` parameter passed to the
backend's ref iterator. The backend only needs to handle them on a best
effort basis though, and in fact we only handle it for the "packed-refs"
file, but not for loose references. Consequentially, all callers must
still filter emitted refs with those exclude patterns.

The result is that handling exclude patterns is completely optional in
the ref backend, and any future backends may or may not implement it.
Let's thus mark the test for t1419 to depend on the REFFILES prereq.

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


--+GxcCR1WOBtJbgFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOUsACgkQVbJhu7ck
PpRIAg//cq7IyiMgwde0eblR0V1jwbVACxVNTM7d+m7+pkWMLGA3zXMQxcsECC+A
mI4luPd0Oo5stEMWfg+bZC9617pO7ZdXJVxG6gHtbYZC32l4wRZBK0co/6uglvoO
xX7B4ybCSLKzDBErboasKUBIzmMay4vOGTCOiKG6X2ejOIKQjJxJiy8smN7FO3vw
xl2wjyVZYP0VKOyRE9GsVp8n1Spmal/qLRUzqMKxvfsrlbQgG5zLG3OljsytzxEu
siLk3VPJVxuv2hg3/uFe9a6p8OqG6WW8Fe/CD5xl6zOdxZ8IOfx6y2dpuKtEQgKS
hN22Ey44++dPlUs01SxGwFE7VK+eSVaNF5EehyChWgggjVag2qEABWKg3FE2Itq6
Jp2EDwsNKWu0/fqQZRAcDggb3bBB7TvvbaqsVqOgeoGnVUBlUGA1Y+kv9J8lqFHL
P8akOiWyh3efBr+RcsTJNVENX5s0/FgYDjDv7CKJ5fiCPpw1xYoannAVqcZljwdF
1VglpI6xeHq6UU+EkZw8UoCSIldIds9kooQZhWqO28yDCYvgP2k4x1GY96MgrHY+
DxL6P4MtsQd7Qrolci+OReuLGnxAEdDKy5mxxnUpQYglHVu98FB/n2B/yZJausNP
C+ivq0WLp3UkPoNv3eXoqx3Jf6OuYUBJgy8X8uBABUOBIc4k6wg=
=Npwf
-----END PGP SIGNATURE-----

--+GxcCR1WOBtJbgFQ--
