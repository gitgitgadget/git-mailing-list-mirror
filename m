Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD1125D1
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OqqEWQ1E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1SYxj+t"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E0F4
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 06:02:51 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 2EA425C04A7;
	Wed,  1 Nov 2023 09:02:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 09:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698843771; x=1698930171; bh=DK
	cHsghbITCg5CVzN6KHVu0FC1otSQM+4z7ZaXo5Wug=; b=OqqEWQ1EiJ04BSxbBw
	Da+YBY6eBwqXSJZ+qX+E9MKXQd8u6eRUwYB3iYFPV7CTKeFAXIX5keEI6k1sWlXi
	GvJVebfJnmbhz35n/0LIq1JFwu4eRE7OjYqCgr61GvqP5mzXurGdG/uysVobBdcI
	kcqyHPDAwiZE8R+M5w/DG9b5B8YpQ8Od2hepXGjwU0HnLb+uKmgafyv7r9hPROjn
	ROhbBsQUj6cRBjtibefPNLuTNyutGMXYUz8wd5vPyUgEde+ldvcev3BrZRPyVwgN
	qQAC+EL/2C1FIH08pkQo/RYokMbBArNEeIJP9nM9tQj8a+829U+dltg8XxBTLnq3
	8xmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698843771; x=1698930171; bh=DKcHsghbITCg5
	CVzN6KHVu0FC1otSQM+4z7ZaXo5Wug=; b=D1SYxj+t3oE5gvdVCwk8ypYVyFIKm
	kg8xg2q4s4LIXohhMEmksItFVL+zLEbz5aP8zV5HKfoN9RjgkPh8W2o4TV1hkwY1
	hvJjpS0veCqUFT7/J192ZI1eTNROe2aLccFbSLhRz4PlvNgFt+ldxnDVhJVkzANg
	Pce+uQ4YvwBPPi+el4pnBBWwYwSVmNWEHItF4lN9GEb1i6rhIkf+pegCaTvC7n6X
	RxNmwLcPCpUwpcO7TQVRcA6nQl/3Lq6vvspY/Ts4pEmnTS/+2SoDVqbYnG2npyD4
	TORY2HKsjEI7lsRivhH4COwDvDc5TLHaW18AX7LFcHGouJB/93MWWyTyw==
X-ME-Sender: <xms:ekxCZbaBUvrsVyKIXOPaXYXO-8lMp3x3Q0dOo-uvsfrDu_6WWmY8TA>
    <xme:ekxCZabaaGVeRHGttCBdsI8b2r-TTbNJmRXLh84K-Bzcxq7mO0IFRt_ejXzsrr0dp
    tJdBTUtWpkebGB8sg>
X-ME-Received: <xmr:ekxCZd-Uft6fAm8p8lVIu2wmkaUUx9DrgL3N7wkiFpfzbraVrVVvSGjZSmznwLyeynKmOUe5IY4rlpIfw2sis5vhzMlgrmsjU_LOVKcc_7gvGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ekxCZRopHVraNS8fhG3vJKxrNmQ1tETXrUiL8Lp1EnXtg6Ra7JRrkQ>
    <xmx:ekxCZWqgkz0LNGFlxC7dOARm9ZTtYNL-aXecZvGYU8mkCedKJSXzZg>
    <xmx:ekxCZXQlmSh3WPIITzWNZKVdjtiDc33-gXI7Z4SWfSrNVuxV41Al9g>
    <xmx:e0xCZfkd-p_m3JJHV33eZ5WnS3JOAcqxBH60wYusIvckFnbxtGT2mw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 09:02:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3321c172 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 13:02:39 +0000 (UTC)
Date: Wed, 1 Nov 2023 14:02:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>
Subject: [PATCH v5 2/8] ci: make grouping setup more generic
Message-ID: <821cfcd61254ace6981288a9ad23999502892873.1698843660.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698843660.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LAG+1UdyDiR11B++"
Content-Disposition: inline
In-Reply-To: <cover.1698843660.git.ps@pks.im>


--LAG+1UdyDiR11B++
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


--LAG+1UdyDiR11B++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVCTHYACgkQVbJhu7ck
PpQVaw/+OvfTT3el3qfMFwJtlT6dRJ0DhDYqM/iPqFMfp8g1l1fYr7OQZAAzPSCi
5GhfU3vOMHxLggYZKY3mnrLd0SJBRHZJvgWEaueSp48q4mCHFOzdmPfI+hiUvMf9
eVnJAta5VZlYvilaAK1WLaG5+4zCWQ2//FSjhUehdwErPdSfp2Tsb8mwXjiQVIkg
FhB2i0GFUUCnwHIYKEgOq5ZqkFZE1xJs7Z6o8c9ieoYDNYx3q1SMhuj7UlI1+E9G
PJnllM4yh1dMbhdB3lc0Shzh9KWYsVh1Od2dmAdS7sL2Yof/ZSU2aApdCxuOA3FT
VvHlgP0C7E3BpKRWzYGmNTgftzd3F3Vemsd4GkDT5W9EXnklsJHOLVYW+gzuYUUw
RIy2ujDVZD9eUROH72szsB+eXRa1zmMIUhqJmNMlNnvemp9YY+o07LvWArvDHXvF
qTCOJMlGlpjrlGbPy0Jib6thWWRgKa6pbZASkY6mVSECRabHv5OITr+wZYGxoVAE
bAoUqwAYSGthjiIV/4ZuYa0BnDVhQ1ytt6U1fHLM8inIxaXG9Z2dgBXhhB4HczyW
lwis1VUTFBexcL3cKpgYLkiHSkrhWEN1lN4LOSNdQhslU3aew5xu7Ii031Cl44UU
d8EDSmJUJorGerTin4lzg4kZlrCZt1wngl4K0H95TzinFfM4FrE=
=2nn/
-----END PGP SIGNATURE-----

--LAG+1UdyDiR11B++--
