Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B33134AF
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sZjM+yS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQg7ABng"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8DF26303
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:01:19 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 987B53200A02;
	Fri, 10 Nov 2023 05:01:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 05:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699610476; x=1699696876; bh=Om
	ckioAytyB2LpBcxLEYi1pObbEKMhS/fQSbNZVplyI=; b=sZjM+yS8wBMDV+AJXA
	tWGTyTE8G+BUbcsGcJs6BzwQJws60Tjgywqn+5g4MJoOAWrk3wgQhVQD+I/0GBjf
	v6UslF9yY4NJsHK2lY0P0NepxDQF1C/vppFvsdrmdnUOyZuRaoQIUN4WZxJXugFD
	HKzTKvA5hc7K9U2Y9qSL9vJksiiQQVSEtFZZ2MObl3CEGtQOSwXwQQPV/p9pLlI3
	36CiLmYsRwnNb8Ce+HzJnpPfhMx/lxF5eiX23830MkyGY26UGBu/LVrwF7X9602x
	ap0ExfmnBI8vTOWzTet7bpNQ3Sp3ALFfAP2rseN5QtNGNCdasO+5P7tH7CuTnPh5
	z7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699610476; x=1699696876; bh=OmckioAytyB2L
	pBcxLEYi1pObbEKMhS/fQSbNZVplyI=; b=LQg7ABng9YCuzKoXeKeVnF3kEcV+d
	JvcUTWUW0HdVP865QK7CxHBnzrxm3S6ckHmN26055IkJD2VQWV5gxi80uZ0f3axf
	BMVzb8PaSldkG2/q+87kQB5P+mRbyvdWjwl8TSS4lTOhIdjexxoHtH3w+yB15OZf
	xZK0wDulrH5DBHjXBLVt3Gx3hSHNibnQotafXuu5TgU9vfA0hxGjELMCQKUtEC+X
	oBFxW2Vn5OLu7dgFryNvuDRDf+pO+PvU0S0k/B8ZeNIe6aznKp30yvsUKdKzB/vW
	xeRmXN2chn/Q2zF9GJ7JjA0SbHfng8tnUo1HUb/51lC7WIe2jlnZOqT1A==
X-ME-Sender: <xms:a_9NZd1n4RaamhaylyW5LirmKi-PfjYZvLXdz9T8ZOed0w-NaaKIjw>
    <xme:a_9NZUHj--7yn-ysYpkFvDi8Tx4R7TeWapRId43HfQrYJZAE9LqFTO5s7frhUA-cG
    sp5pSMjz_Z3Q6J31A>
X-ME-Received: <xmr:a_9NZd6AuOSAbZm7bbM1LAOD0-v5msf6pyfMqfyK_l3f44sAhX3qUblqOvwxGyYRS4MX9tA2xfgFGgOUeOLouBlPxXA_nfgKhjxmEqOQMJpO8LG->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a_9NZa2-4bs6fJop8buZbrOKvcWo8M_l8A9k8yIiy0ctcpwGH9atzw>
    <xmx:a_9NZQFiLdqPLbeh_lx3jJF4DTYmHFH06N4O4tYUtyjHgH7ZH--j6Q>
    <xmx:a_9NZb88MmOADWBoWdpLg4gQYPb6hb0hg239Buvdv650ivBA-HRtZw>
    <xmx:bP9NZaMS34rF3hBGpX5iHgyDyAgUL7TEfvgJgyd5lLiK3leo8NgUQg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:01:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4325d579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:00:43 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:01:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] Replace use of `test <expr> -o/a <expr>`
Message-ID: <cover.1699609940.git.ps@pks.im>
References: <cover.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgevs0dwtPitLO+6"
Content-Disposition: inline
In-Reply-To: <cover.1699526999.git.ps@pks.im>


--wgevs0dwtPitLO+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that replaces all uses of
`test <expr> -o/a <expr`.

Changes compared to v1:

    - I've expanded a bit on why we want to do these conversions in the
      first place in the first commit message.

    - Dropped a needless subshell and added missing quoting while at it.

    - Explained why we need to decompose the asserts in the second patch
      into two asserts.

Thanks!

Patrick

Patrick Steinhardt (4):
  global: convert trivial usages of `test <expr> -a/-o <expr>`
  contrib/subtree: stop using `-o` to test for number of args
  contrib/subtree: convert subtree type check to use case statement
  Makefile: stop using `test -o` when unlinking duplicate executables

 GIT-VERSION-GEN                |  2 +-
 Makefile                       |  2 +-
 configure.ac                   |  2 +-
 contrib/subtree/git-subtree.sh | 34 +++++++++++++++++++++++-----------
 t/perf/perf-lib.sh             |  2 +-
 t/perf/run                     |  9 +++++----
 t/valgrind/valgrind.sh         |  2 +-
 7 files changed, 33 insertions(+), 20 deletions(-)

Range-diff against v1:
1:  c5e627eb3fe ! 1:  2967c8ebb46 global: convert trivial usages of `test <=
expr> -a/-o <expr>`
    @@ Commit message
         these to instead instead concatenate multiple invocations of `test=
` via
         `&&` and `||`, respectively.
    =20
    +    While not all of the converted instances can cause ambiguity, it is
    +    worth getting rid of all of them regardless:
    +
    +        - It becomes easier to reason about the code as we do not have=
 to
    +          argue why one use of `-a`/`-o` is okay while another one isn=
't.
    +
    +        - We don't encourage people to use these expressions.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## GIT-VERSION-GEN ##
    @@ GIT-VERSION-GEN: LF=3D'
      then
      	VN=3D$(cat version) || VN=3D"$DEF_VER"
     -elif test -d ${GIT_DIR:-.git} -o -f .git &&
    -+elif ( test -d ${GIT_DIR:-.git} || test -f .git ) &&
    ++elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
      	VN=3D$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
      	case "$VN" in
      	*$LF*) (exit 1) ;;
2:  b1ea45b8a88 ! 2:  977132d2236 contrib/subtree: stop using `-o` to test =
for number of args
    @@ Commit message
         of arguments we assert this via a single call to `test` with `-o`,=
 which
         is discouraged by our coding guidelines.
    =20
    -    Convert these cases to stop doing so.
    +    Convert these cases to stop doing so. This requires us to decompose
    +    assertions of the style `assert test $# =3D 2 -o $# =3D 3` into tw=
o calls
    +    because we have no easy way to logically chain statements passed t=
o the
    +    assert function.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
3:  7c54d9070fa =3D 3:  761cde1b341 contrib/subtree: convert subtree type c=
heck to use case statement
4:  bc9489ca5b8 =3D 4:  5326d86888a Makefile: stop using `test -o` when unl=
inking duplicate executables

base-commit: dadef801b365989099a9929e995589e455c51fed
--=20
2.42.0


--wgevs0dwtPitLO+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN/2YACgkQVbJhu7ck
PpREzw/9GY8asmY1yMFUWUVGVVGkCMvxnk4IW8P6NqclCJZTNUBXQR9ODZJL5O9a
zVFYeLAmSiAyFKEwpaD6yoHqVQEUPyuyWTyZPO3gZGgYXNi4IwSyHMrJ5YhW13Y5
MoqZ5/mQj/0O3OzBQLZSY1vw03G/K5SBvDnEwSpVQcHoBTnh5pp1n/FYC2XnHcFz
YBTE0T5ARH2dxGCghNOVKrVd5skIz55uXBuS7nklwdqetv1QoQ7OCjjKlWFE4REJ
O5XgivBw5/g7R/D9MW0Fv7gtUeA5Vy83RHxG/3fIcrPnYUub3gTVWOH/O7jrHsvl
ocF/96Vk9N4J/vCanJfEGfXMbaxkvC4XFvF2myLZxhOGKpEFAvy+/Kw8575DZtMb
v4BiT9TEZR1DUoRd6igaOgcG8FjGGoLca7CN2KYuzZDOvp2y7X6F3ZZ0odIHnuWL
mTY2wgxkQJiMTHm72Om3ZnO68VE+IFKd2gfMzh3nIcWsrHkfDhTUhUI/xmeuB6Wa
9x9Wms93qUVMOydvtKDcxzaVeFDNH/uIz/A09zFv3lx9Vp7ILe2k9h87DM8gmGSm
qni0F9VWA+IVYgUem7xB2VQv9ehQuJJuyx886I1PV4nOSQ/Unqh8ppu16MhrJbTK
mKNtMWnhjjFpOafhHBBTHT9BN0NFRof/P1Epr0VK+CVHC1JiDO4=
=O9ky
-----END PGP SIGNATURE-----

--wgevs0dwtPitLO+6--
