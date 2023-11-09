Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453FA10782
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vAOSNVeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+gUF4s1"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70352590
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 00:05:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2B6C55C0321;
	Thu,  9 Nov 2023 03:05:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 09 Nov 2023 03:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699517129; x=1699603529; bh=wE
	p6xVJHcacwxWiSje47XOFZluykgxlYr4xfkyfHM7A=; b=vAOSNVeASEU1FlVsgN
	Fn8TOrH4kobMswtsrm9KM6il49Na8LpvH6kEtgiB4IRexfrZ/mgl8N3u8TEku0J2
	fiKalpkOXwREwYCM/rc6LeLgmEpJWFM0YqMPqzklc+YYMLj7Ox8c9DCFOkejkIpR
	2p3XTowarHBEl6d4DJWEbiVMST65uwD0/jPpyS1AvthwKYGQChIt3LP4VpxfiDm8
	JNSQVF+e/5FovI+3NSIFBUUEtOtCfuRsnXy4qaDXNeCpmbkR0tuMDJCXci3XH5zD
	mUSoxY6Bl+z/4hULGNvTHoDZxJfbZtBi8zR+J8LM6+XPxMIVLKoYd1CrMrRc3onJ
	OsTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699517129; x=1699603529; bh=wEp6xVJHcacwx
	WiSje47XOFZluykgxlYr4xfkyfHM7A=; b=c+gUF4s1nW2wdMNI3qlg9I8qkbOrS
	CS+a5sBpi1V2oB8h9Nr9qNT0UMoq4f3OWCcs1SOYdvZf0/Fn7bt5T+M9zlXy/b9J
	vaVma2wWCLx8YKYeWc539Ff/cid3DH+IrAjUMMJmb346zM5b3kODmHQ7CypNOHyq
	w7wQLGivVmxUFXFnI3h3E2SwSy0Pkp5mt3FbHM2MPopbPYR09jVDwl2f8dVzVTtp
	tKIiYM9QQcanETniiS3bCBJEHjyUxO+xEj+JhAoqpZ/erhOZV6DhWlSbkS6auzWl
	f9+EM1WiVjlzK5rkAMZhGkm4o5eaN+FLhAhFV83n+llqevOZN3j6cTGuA==
X-ME-Sender: <xms:yJJMZb7Bm7dpFKPuFIln17rGH6m5ckyvEDGY2vfJzmjSEzaapk-jIg>
    <xme:yJJMZQ5OgMRFnw-A-a3XLZZ1xWzr1yV5_I0AoWpWGnGIyMcd8PFCGiWAqu9vA9tst
    CG7ApdzfyZvigRa0w>
X-ME-Received: <xmr:yJJMZScoCgFN1vfQrEIiZkxxiUeJ7fR9PGOjNlSXU7QyOKEcOpKgPZbzS9BVp7F5kT6kLVrN78OjGXe3wfW31_eEZTe2uNDkYHZ-Y_75KyZAmAMi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:yZJMZcKOPaxe9al330NLvl6Gz5_Kidu6wuZRARP1Gy4CDw7MjbzSgQ>
    <xmx:yZJMZfLYk7f-v9dcW7iEMmoYWY-HEOjXyuc44ut_xgAREzEIr8__YQ>
    <xmx:yZJMZVxn21qUXqHjVmbF8NAMfgIq21WY8wK0uITpj3-UZZ1ptu-XVQ>
    <xmx:yZJMZVhkzZ-i81ndzYdsZsSDQIN4p9Cm-kJ8NPgUowh2MMVsrpd6YQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Nov 2023 03:05:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e668795a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Nov 2023 08:05:00 +0000 (UTC)
Date: Thu, 9 Nov 2023 09:05:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Victoria Dye <vdye@github.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 1/8] ci: reorder definitions for grouping functions
Message-ID: <a1413b76422b85eefaa23a5ee341d6e1e79e708a.1699514143.git.ps@pks.im>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1699514143.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SP+0f0HehrPVNlfd"
Content-Disposition: inline
In-Reply-To: <cover.1699514143.git.ps@pks.im>


--SP+0f0HehrPVNlfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We define a set of grouping functions that are used to group together
output in our CI, where these groups then end up as collapsible sections
in the respective pipeline platform. The way these functions are defined
is not easily extensible though as we have an up front check for the CI
_not_ being GitHub Actions, where we define the non-stub logic in the
else branch.

Reorder the conditional branches such that we explicitly handle GitHub
Actions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index bc0b23099df..029819673b4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,16 +1,7 @@
 # Library of functions shared by all CI scripts
=20
-if test true !=3D "$GITHUB_ACTIONS"
+if test true =3D "$GITHUB_ACTIONS"
 then
-	begin_group () { :; }
-	end_group () { :; }
-
-	group () {
-		shift
-		"$@"
-	}
-	set -x
-else
 	begin_group () {
 		need_to_end_group=3Dt
 		echo "::group::$1" >&2
@@ -42,6 +33,15 @@ else
 	}
=20
 	begin_group "CI setup"
+else
+	begin_group () { :; }
+	end_group () { :; }
+
+	group () {
+		shift
+		"$@"
+	}
+	set -x
 fi
=20
 # Set 'exit on error' for all CI scripts to let the caller know that
--=20
2.42.0


--SP+0f0HehrPVNlfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVMksQACgkQVbJhu7ck
PpRY4BAAooikx3g0zELbkiNieTSjDse0ohNRgeA1ND/402FI5To4X7SdCs4Yr++c
mIPVnWwxv/Zc3vgkH36gQl5gc4OYuFk/tdQq116FV+bvoeQ+Q7wMzM4FTLhp9jV/
FHe62MsbBMx6Hou7C6Kp4JAhec4eNFcRbH3QcQiOdTBjaM6M9ablSQ3GPMnrclOb
ULha6l+Qw1pGgNsGkNkbvmgBCxRWbRaYIKhg8OxzTwVObgmeiGmyskvLy3DFFJIF
UOZFkXhv35zaFFjlOJBk6DwPpvdKHZ9BMX+qBuQq9Vl2I5A14SAPvzgQjz4m343R
gSLqXq2EmgXdJGv5yZ0QzeF32qLb3ffY/fsV/iWXviyOc2c2MrC8yJPTFDmfwecv
8s56ojK+cKZLBBzxJ215A+ThnqPMPSjx59gOvXlxU8fnb7r6HU4PwwVhGo10ew4F
fYOinxtVD23KvPdsE65YjDsuJevsZQs9X8NMERGboigkcSdWrWuRO3hMq2WuC3lG
QJloYFi46cZx1usueu+ypFUW5n/UkTJ9Tafwtd3YJX0OCrF5NdKmcH/l4mwSHmp2
saKn4kgnKbRvqCJq2tjIOkKVodUzmxenFLxVnx3dJJD7x9K+gq3JETzvAaUveWCt
Z/u9m+kSRJjNkRP6QwX9L5VIL+aV4JSdjPn1YprH68Y3bZ4Yo+4=
=M6K1
-----END PGP SIGNATURE-----

--SP+0f0HehrPVNlfd--
