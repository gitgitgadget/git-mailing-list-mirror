Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F/l6FKhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WI6sL+Cl"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EE8DA
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 23:25:04 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EB7395C01AA
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 29 Nov 2023 02:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701242703; x=1701329103; bh=z9
	fuQ37dryeoyhB9ho100m0FmM/wIR+hQvEqs4Lt8no=; b=F/l6FKhs4cIfJ3SyaO
	2tOFdEikHBTYAM5QNS6qXITQAVzwi5iSwClYiLi3R0gdK5ECXdjgWTjsG4ymy/Bb
	Q/qmZ698H6WQwQSlZeiTsjd2+Lu0iu4YPh0MiBGsq3uczdDZ24yVQFZ5TtaQgJ22
	XBEdPc+fBXWM5bOeitgWdvU/psR6cmq06Qt/GSt69RfkOwluYQ8xeZGML/ojGyxq
	3llHWLaqZswQ7v+lv/7wK2MUhz1Hmn/52nWysIA8Fsj7s5M1xpN0lqcq9lbIWpH7
	RWAy9EgVwV0OipZ0UKlwTL6MmSKo1QiYDx7VzpY/6jrkn8rOE5eZrBSS4mqoCFIH
	62iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701242703; x=1701329103; bh=z9fuQ37dryeoy
	hB9ho100m0FmM/wIR+hQvEqs4Lt8no=; b=WI6sL+Cl2zYvt1z5r25WROdUyqTtc
	DPumOQDggaoA65Ahx+J/8i3LNzysq1K1GRqoTn8307ywSydravVpqHSPoYyVm6oL
	iD0aljyRkCk2hMg+CxZEaAwhhwBtEqk6hMpsuKnSTvbJdK/lCnYuxGfctmKr/eXZ
	TjOynTRFxVER9fHe0ynv/TIERLBuogYDc5j58AWqj0LmCMU4Gm4DBicEqFbnfyIm
	HuIf2v7RkadMgWe4dNWpb4zybYAuJovxqOh/k8/b8ewhVdmM6ulwf58Mb7ERSz+W
	TfjYuscD0O9iOlt8pvkySn5Pk3MxiNSOx4RMN63fiLYkdq+SlNz0rmwmw==
X-ME-Sender: <xms:T-dmZeBB8hdTTrzYbQAk6Z2ULolUh74-18UN0Do1t6gDwulyxazwkg>
    <xme:T-dmZYhoyxvtZc3DVLTZANsUOUVahIBNXyauseVx8VpxhIZPR7d9tVwPPutYZ9NVI
    FT5u4ShLVM826gv2g>
X-ME-Received: <xmr:T-dmZRkKRtqnrCViXJfFVmRuXBjLZPww51FNN9oQXPhKZYA48pnflghn3c1VNzQmibi7Lso8nJ3anOvKWQjhTOT43AX_SKE3grPJhQM4xqcvOQU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:T-dmZcwu1B6XkE2cGcJ5oYYp97h_VDEQiZo5mX9ym43tsjMHzbHpkw>
    <xmx:T-dmZTT5tgoVtfI5kRQWyDQaA_wXegesWAZVZHlm9wX_KMtCsD0DKw>
    <xmx:T-dmZXZvo0jk3ZiIEUoYoH3Rg15N2Xxf9M8wXb7RTmlv7jtefgcPNQ>
    <xmx:T-dmZWMkke4kNsHfyRT_hi9conEthQLsyG6ddm7RptFQP5YQZ9kaxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Nov 2023 02:25:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b3bf3d30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Nov 2023 07:23:52 +0000 (UTC)
Date: Wed, 29 Nov 2023 08:25:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/10] t3310: stop checking for reference existence via `test
 -f`
Message-ID: <58c1f0ba47110fd452d83cb6f72871abd7891c3a.1701242407.git.ps@pks.im>
References: <cover.1701242407.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="im+6aQH1xl/Eqr9F"
Content-Disposition: inline
In-Reply-To: <cover.1701242407.git.ps@pks.im>


--im+6aQH1xl/Eqr9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t3310 exercises whether the special references
`NOTES_MERGE_PARTIAL` and `NOTES_MERGE_REF` exist as expected when the
notes subsystem runs into a merge conflict. This is done by checking
on-disk data structures directly though instead of asking the reference
backend.

Refactor the test to use git-rev-parse(1) instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3310-notes-merge-manual-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-ma=
nual-resolve.sh
index 60d6ed2dc8..597df5ebc0 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -561,9 +561,9 @@ y and z notes on 4th commit
 EOF
 	# Fail to finalize merge
 	test_must_fail git notes merge --commit >output 2>&1 &&
-	# .git/NOTES_MERGE_* must remain
-	test -f .git/NOTES_MERGE_PARTIAL &&
-	test -f .git/NOTES_MERGE_REF &&
+	# NOTES_MERGE_* refs and .git/NOTES_MERGE_* state files must remain
+	git rev-parse --verify NOTES_MERGE_PARTIAL &&
+	git rev-parse --verify NOTES_MERGE_REF &&
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha1 &&
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha2 &&
 	test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
--=20
2.43.0


--im+6aQH1xl/Eqr9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm50wACgkQVbJhu7ck
PpTTJBAAn82UkphKe7ZDXck/zl0ewi+VoKENLZKr0EyYvr31a8sJrSVbvKa1j9Yy
sbQX0mRkKXMbHk8+ye4G1YCaR88fwXtlPzReSR4WaRvqcYvfCiP3s6cHXbiNSsTF
rF8JcStQlcAbsAqufElNA4eWkyh7EurbMKlxBvYZA12Z/l4eFtrChNMx1z6Z3omg
OjNhLZzwZB2VNL6wDltl6jXUuMWbDu4PvRDFdh/NtgSL7eUDMY9+IyU2kJTsAjdF
uQAJ0uypsZVEfbczkzyLG8pqcchp7AgT5Peb50Y8wmanC6UMchJue5ikHRrxGhYQ
TekXq8PzYW1KsElVdknij/HCPCurtxLCfd87NxlOZxXubBjfF55TC9Ga1vdbXVRD
yJiVUGmtSqGnFCOnWBcfuHgYNQea0/z9Jeg4cSkas73TVBnCDUdwegxKfrihtDyz
jp7DYFdeYy+VFrBuQNTGqheuy70qYsdY5kOZ3nEVbd1QIr1KolocPWuG/CnR5KsC
3zz7hJFqbbnb40NjVhyM32k6lCEDhpHEqCub8xDbEWr10QPGLJn1SYIle1yQ7BfA
gzZVYQlCofyf4tmZjcI4mvo+rerwDO3cZrNhvYNJTvsFmyDpW8qi8ZlOYg1xHLWI
FG6BKnmoYf2dPAYhltjQqytNDHl0fxs7pE/de++WL972FeHk3+Y=
=9d8F
-----END PGP SIGNATURE-----

--im+6aQH1xl/Eqr9F--
