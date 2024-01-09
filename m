Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D037163
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gQiQTVUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pC/RXugt"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 211F15C03AD
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Jan 2024 07:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1704802624; x=1704889024; bh=em4sDKPUUyfgUDnLr1jBzY7JHKR+WvhZ
	LrRF2pETXKc=; b=gQiQTVULKICQuujCuQbpns2gjwQq5yE+K+4rGl8kMEHQqS6t
	+zkCGq0yeP8iG8aV81iDzVeJ4xFJgloPcULAyKqCEXN3IXv1pJ0MZfK+5MkcO1xo
	vnGwUoToLLHk8A1QDOCKpRmugSVb29Ul5Q/+D1co6c3Cw0Zv20P1grkWPORv8ctt
	PYgjKCPX14r86+1DfNmKEO0GNxnLZFtnyczlfQWpQbaykqORDeJDOJYMps4bVM6W
	srgfwb0aMdF5fNdDXha8MM0wZOOsRBbBfUi5iuabt+br1ZfJgTIpw6bQ9R/acJTw
	UdikvbiDypKrMrUAW0736+SfQgLDZrpQhmraWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1704802624; x=1704889024; bh=em4sDKPUUyfgUDnLr1jBzY7JHKR+WvhZLrR
	F2pETXKc=; b=pC/RXugtcN+zVUpA61rqfLKLUFg/x3tc2avgGdGcPlvJtsBhhSj
	fcMCjsOUM3cXtTJifhHQcTu6NaVezdZ7AhrCVQxZ4M1t+RPBWb7zSRjV1Akh4DOQ
	eOrilJTEU1KWlqXakFFVuLaZxiNAtlU+ThH3DpMlWdB943CMVN+Q72v2zX9ke2ek
	EVGFjpuC3n5fUbckrjmRjNttna8PtHJ71k3V6lMrJIpE/8HM4GAkVE2SjVu4eXiz
	y+hhA0p+aDZ7LP0B5fMvItugHD9dWznNsrMeJLYHWm2x33as/85LaXMBNR2vsKZP
	vnxDKLpvM+ydp+hQLPhVxs2g3yRxjv2kE1A==
X-ME-Sender: <xms:PzmdZQtnoVFvFDQ-QChhdQaWsNxkNC1tI4ZWGSAyw1Mohn746d6vSA>
    <xme:PzmdZdfdZpRWwVP0haT8L9RGmmPFreIEAtiVyNgLAapey8SZgJ5w-2cDCmfteLTiT
    A6HCeoOYLY9UzaIMA>
X-ME-Received: <xmr:PzmdZbz2r4Zf801keWbhSuXIRg8JoGjQKIRD-Zktq0HNAXeyN8WQTqZ3N3WUVk-ip1k64k3WKWwmQ6d1TLOaRDUZdU-QAoMum4wzKpkjpPHB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PzmdZTNizDJbVdglsHXAL96LAR0kqASLk0D_E_D0QyI0jdKMSmfEmQ>
    <xmx:PzmdZQ9mhz7O5-svBskwUauwA0_YfItF9Ky8aCFU_O45eSKZSlEkDA>
    <xmx:PzmdZbWKEt7hwjYbLVz7mv5NAM4LbklMX0jF1Lw3g8JidYOpjDVgTg>
    <xmx:QDmdZZJU4g2YJYkoj9pZkoGiU87MeA-pxKUNgtiRtX8NN61wIYnhiA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c78add00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:23 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/6] t: mark "files"-backend specific tests
Message-ID: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tJI+fJ0OgZqwVNTz"
Content-Disposition: inline


--tJI+fJ0OgZqwVNTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series amends some of our tests that exercise "files"-backend
specific logic to have the respective prereqs. The patch series is quite
unexciting and part of our final preparations to get the new "reftable"
backend upstream.

The series depends on ps/refstorage-extension as it makes use of the new
DEFAULT_REPO_FORMAT prereq introduced by that branch.

Patrick

Patrick Steinhardt (6):
  t1300: mark tests to require default repo format
  t1301: mark test for `core.sharedRepository` as reffiles specific
  t1302: make tests more robust with new extensions
  t1419: mark test suite as files-backend specific
  t5526: break test submodule differently
  t: mark tests regarding git-pack-refs(1) to be backend specific

 t/t1300-config.sh             |  8 ++++----
 t/t1301-shared-repo.sh        |  2 +-
 t/t1302-repo-version.sh       | 19 +++++++++++++++----
 t/t1409-avoid-packing-refs.sh |  6 ++++++
 t/t1419-exclude-refs.sh       |  6 ++++++
 t/t3210-pack-refs.sh          |  6 ++++++
 t/t5526-fetch-submodules.sh   |  2 +-
 7 files changed, 39 insertions(+), 10 deletions(-)

--=20
2.43.GIT


--tJI+fJ0OgZqwVNTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOTcACgkQVbJhu7ck
PpRgqBAAro/Y6yfwn5lh+T/2GSsNW7Se5uV7g60qaebLkaxW/kpk6TGZrmuyvh2G
UPOcL3FdlyHeW/oeG3TIxOSPOCP1STlrDahW98Xw9fIiZHK4eRn0ZNcQRzkj2VUq
Lr0jKEqous535eDWiZu9zQ+vk1XI88nJu/MQtoBLyEIlH1JDDR+5dEROwmdWcJ1A
fLofL+jg4yKqKOqVo9dsQyuZG4XMs6mSyoRsIxkSoNKI9Fh+M7ah21oEBmYwMNmw
xrvxEMr51gj3Fba50gePxaoPUotrG6PcWxBJOttarh6DPxQZ4C3AE50lr0AzVwKp
9gU6VB+p+UvO/ZyLt2Dz7F+ewF9SJh01t6ziSUlTe+/ZG0FG/ByHZKP3RQNL3pCk
jObCH03Pemfn8YEFHuPGLvOMgb2t5Lc91fszFKHpgQhN+ghdXqoK4P4bosiAXYQ/
bsVNSzOyN2tS9ssDm2wwk7XdvsKJrakYgIEhcYJWgGLLXv7vuYpwCxL6CZfysSkM
DOlfdhwh7328Ph/wHwUOo9642SKAZ6kvAHAOnGqRtR45TO2OP1QgiVVDmIAdWJ/Y
E4dibCDWPD1YkbOv0m0J+RIHeomKo78GSQLQ0tqnQnhaD9QnaWWQ458GJ2nJqoJu
t6jm06mitcUBxDZUjIpd+ZW1tVQRlUzzUSGxn6QsdE8ohBy4oAY=
=1SqY
-----END PGP SIGNATURE-----

--tJI+fJ0OgZqwVNTz--
