Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aI834BZ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DaCzfP6v"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB75619BC
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:24:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CCF265C018E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Nov 2023 02:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1701242681; x=1701329081; bh=PWFcj124niJSkmgV0WsuZ8tPY
	XiFg3qYP+3v6WaIVoM=; b=aI834BZ2bPSmg8OOrpCt+t//yKIZr24sob4rmtFju
	2qqKtaij+siNOctHYSvP1gvvt9NemgOboiYjYsXekt7ndY1tOq1+si6hqpfbSM0L
	wF/HZXfzIXPduKRTQBqrJSp7A5on4mMIGShNIbh3Ocu6LlvoiWgsc+MwKwSsekqj
	xwrtSL1SRR+99GyOMOZ4DW9tXrw51rJkAFg8htZ4PBTClb60R/m7YH0qzR2e7vhH
	qi8/vXBo8HcQkEKgqvCdGcz/fzyJ4BGDbP57gPwpz57ImhZo89jFD4RTU9q24clC
	hqSuH2Jzde0Uu6BKzWu3bJsv9QU3zUzfem8NucC7L6pEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701242681; x=1701329081; bh=PWFcj124niJSkmgV0WsuZ8tPYXiFg3qYP+3
	v6WaIVoM=; b=DaCzfP6vZSul8FJnylxAyRBW4W5LraEdO5aQsESpLN/Y+eP93tJ
	/ZWeKvGQo4MJpfMIt5gQw6anVDI5TK+LqVHzGR6GJllXACXEnLHDxWB06uEWFWx8
	a/VcAmnOpfV6GKDvylRCIvKZ6S4OViTCl25SzF5yoX3e1Xdja1tLnyy6wZYOprWA
	5Q7nOOEuzMedVqfk/MsWz0QdKAvfYFGXS9xC25GKBl4xRxSKD038BxDf48VhrsrX
	mCP1/jIG6tr1GUtqsUjil9RTPUOPeIQYY8P9Ivb1fCCmLi3NUFyDmNY8HOy5LnNj
	GPcpNsXvmBIk5OuKdT6Wdhb2ISNJzsZ2OcA==
X-ME-Sender: <xms:OedmZVg_S1Y9GFoWWjS2IVw4BgBnC72Ny9xX1PG8zZdJK1HPAnPaYg>
    <xme:OedmZaAkCVah03_ZBgMNzVksKcMwOCDWBXiz4qRYd8NRvVga8BTA7Om66XjCY0GAL
    IPupjU4VgRxEV7CEg>
X-ME-Received: <xmr:OedmZVGwrFObqQg5lZy9cJkzCnxMB8gJp2L4D5V4DU-Wr6GHBQLR4NckJ_mrq6LPjnPHO1eu2SpowEPVZymVoHZRbQGgjQ-Z-Y_L5R3UZHoZh0e3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejgefhueejfeehgfeuieeugffhieeuveduff
    egiedtgeevteeigfdtffefueffieenucffohhmrghinhepphhkshdrihhmpdhhthhtphdq
    fhgvthgthhdqshhmrghrthdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OedmZaREf9S-4dqQpLyq0aKQ5_T0F2Qf9Ott3-Fnd01kFRe9wsmNVA>
    <xmx:OedmZSxWT43GJD84PWX5J7Zzm9xiukF22ShwY8RRgCSkuqjJPbdRxg>
    <xmx:OedmZQ7VqYtYGGfnlld74ZRXB3dE1J0NVESDz7Q1cnS5JqoNGpO5jw>
    <xmx:OedmZXtL0d-0hqsh2zPTOci6I9Fcks87k4T73KbTu_G0nd7bgmhezg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:24:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99fb3eec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:28 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:24:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/10] t: more compatibility fixes with reftables
Message-ID: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lyezBjw/dEBf9wrk"
Content-Disposition: inline


--lyezBjw/dEBf9wrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second patch series that refactors tests to become
compatible with the upcoming reftables backend. It's in the same spirit
as the first round of patches [1], where most of the refactorings are to
use plumbing tools to access refs or the reflog instead of modifying
on-disk data structures directly.

Patrick

[1]: <cover.1697607222.git.ps@pks.im>

Patrick Steinhardt (10):
  t0410: mark tests to require the reffiles backend
  t1400: split up generic reflog tests from the reffile-specific ones
  t1401: stop treating FETCH_HEAD as real reference
  t1410: use test-tool to create empty reflog
  t1417: make `reflog --updateref` tests backend agnostic
  t3310: stop checking for reference existence via `test -f`
  t4013: simplify magic parsing and drop "failure"
  t5401: speed up creation of many branches
  t5551: stop writing packed-refs directly
  t6301: write invalid object ID via `test-tool ref-store`

 t/t0410-partial-clone.sh              |  4 +--
 t/t1400-update-ref.sh                 | 41 +++++++++++++++++++++++----
 t/t1401-symbolic-ref.sh               |  4 +--
 t/t1410-reflog.sh                     |  4 +--
 t/t1417-reflog-updateref.sh           | 10 +++++--
 t/t3310-notes-merge-manual-resolve.sh |  6 ++--
 t/t4013-diff-various.sh               | 27 ++++++++----------
 t/t5401-update-hooks.sh               |  6 ++--
 t/t5551-http-fetch-smart.sh           |  4 ++-
 t/t6301-for-each-ref-errors.sh        | 13 ++++-----
 10 files changed, 74 insertions(+), 45 deletions(-)

--=20
2.43.0


--lyezBjw/dEBf9wrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm5y8ACgkQVbJhu7ck
PpQUrQ/9HTDkI7u/j/Y4TTFByeiimKIPCnR2FxdD1i7KA17bI/7rEud45/8HpRnE
Cgl7OutetF/s7uInFce6Z4R1T0J4a93cTeXHxVORIC5M5jxDbt1869V3NP1ZJxz1
LnJfF9ecIrBmNbsXX5HhROP9zpih3USE+CIUgs6C642E0W5Gk0Z3ZwWl0bmvkdi+
wmLScyudzPezoHVJcbN4TFyBcVv/MEJIdPR0TmER1eLiKceq/x7hkW496Y4tlRRG
XIgqqXea7d9A1M3jYZWbVbUDtwBsUvMArWHITuqItxJrnQRLJljyH0KxcMEELu8p
HFQD7gZd9XrQiZdiy++8q0ut2L9bmYlbH8WEIbmsd/7NG6GyDiwdExJMlZihC0yB
3nxgmq5lqUENvAiQbNI2q6SFKH4Sw9CPZ85bKGLK66oklMK1vf1Ovb/nMce4g/RQ
OVKXeEjGLs6zAVVhZk8PKXY+aNbQy2qyG7POYEH8l7HpN7+GRTbohIZCrunQoljM
1fazsPnmv+5emJsZdWkU7Uhph4/x+3AwfRwb2Q7DBK5QO+SvwcgzbIYxPhd61YEu
oSP9ntA/qNguRgOkmKwT4e4sRQLtea0583FpSO/23BWLLIGxVY7FkLvzcVUfWdNb
6PjTu785miAh5eQr4vupUhimrBbqF9C2ckQyTTnX0m12bydDXIQ=
=8hMu
-----END PGP SIGNATURE-----

--lyezBjw/dEBf9wrk--
