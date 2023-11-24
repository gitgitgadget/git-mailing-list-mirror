Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o/HPigsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xq32Y5Kc"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0036ECE
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:37:13 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 72A053200A3C
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 06:37:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 Nov 2023 06:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1700825830; x=1700912230; bh=0IZTtCCzTYk3/Muf6lT1bmVnO
	TWZMXH+TxUJTTnKPto=; b=o/HPigsxNOb6UAeyuH8cQna6MQM8UkxNUQiUm7tw7
	/iR+fS939K1gSkAUaDtenI9t5QKOeYzNtK+ufxSU1U7BCasrp5rYi6ccJAtStFlA
	uBQgySMQrRpAB1qI+CNyhcbSrYjRQoLAnST30uOAsY5P9M6Ryd7mVwqEYGozJzO7
	j80SyNUPGPUTqctWVcyHM6RgpcCiVkhkYFLgk4am8gzHYYWslCD2cJ6ONFsAsq9V
	K1IOZMbMMz/mFOhMHI45hFp9SRMfaoH+q/M8hgJ9UMX99hQfcgMn7P5WcBL+RURP
	utFPoS2JqW6ky3EVsNmf06eDrExJDp0Ni3B9n6rNDv13A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700825830; x=1700912230; bh=0IZTtCCzTYk3/Muf6lT1bmVnOTWZMXH+TxU
	JTTnKPto=; b=xq32Y5Kc8RfJy5JJ+9iwujO5gfIJ1+TGUAwdF/Z+MuNWtFzKaYa
	G/RBsT5yL9V+OFNALmsnr9e8yYuUREXAR6VoN8i5xSrGNyAlIeUgIv4BdW8EfegH
	+KDfMJmV2FepxbPvYIN2ywX9G5bpzOt8V44/ZzTF/eoB4Dlxz1KICD7j37do90bR
	d/5lWNUuTJgNC0kHPV0hbi5S3/UcXAqIxsbRewDAX9tanIAgrk9URZQSRYYowlP8
	FRya/Mlo4Hb2YwT8F31yC5GXQZHylTfc7/HMMnLfB3eGxV3qf+qobS81Ujw9Kolu
	TgsH/216SOblZ1Sur1khKih4r33cXBFs4AA==
X-ME-Sender: <xms:5opgZU_732m7mRzvC6fsa0cHQn2UMP52Wcb71Vik1uFL4GktSSPffg>
    <xme:5opgZcsW8cbrwT_x46SH1fvySvIBoIBxg-SdqseuY1frua2PU_tGr-ZvLKRlAUD-R
    VNzb0AKM6MfyZMxww>
X-ME-Received: <xmr:5opgZaBupVMaElkLdY00uoSzPUPunaV446roFV_IW04YeFqFHvo5l-JKtv9C4xmgp9wQ4f8tLaxBUjUoWT6KV6aXZgiRGp6IdDwU3msE1uqe2GY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5opgZUdGNz-lVj-o0xUFLzbmr6IXzg5MJMmS-vIDTUwp9HCdWyW0YA>
    <xmx:5opgZZN6ZCvnvcVsooLRViUAUJhBCeUZ9cnbmdESv_nNcHXSqvuSeg>
    <xmx:5opgZeneUroAI4xAeL1sYeOVKZCC_o8eH3puptppFcZRq-CCqh5bGQ>
    <xmx:5opgZQY4VzKHOshxHLI9GPrZamOQfsacElyH3atprl7A9D_9k3TQ_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Nov 2023 06:37:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a7ff13f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Nov 2023 11:36:09 +0000 (UTC)
Date: Fri, 24 Nov 2023 12:37:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH] git-prompt: stop manually parsing HEAD
Message-ID: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KiILIaAHZSMWEOk3"
Content-Disposition: inline


--KiILIaAHZSMWEOk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're manually parsing the HEAD reference in git-prompt to figure out
whether it is a symbolic or direct reference. This makes it intimately
tied to the on-disk format we use to store references and will stop
working once we gain additional reference backends in the Git project.

Refactor the code to always use git-symbolic-ref(1) to read HEAD, which
is both simpler and compatible with alternate reference backends.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/completion/git-prompt.sh | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prom=
pt.sh
index 2c030050ae..05de540e13 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -474,17 +474,10 @@ __git_ps1 ()
=20
 		if [ -n "$b" ]; then
 			:
-		elif [ -h "$g/HEAD" ]; then
-			# symlink symbolic ref
-			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
 		else
-			local head=3D""
-			if ! __git_eread "$g/HEAD" head; then
-				return $exit
-			fi
-			# is it a symbolic ref?
-			b=3D"${head#ref: }"
-			if [ "$head" =3D "$b" ]; then
+			b=3D"$(git symbolic-ref HEAD 2>/dev/null)"
+
+			if test -z "$b"; then
 				detached=3Dyes
 				b=3D"$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
@@ -498,9 +491,14 @@ __git_ps1 ()
 					git describe HEAD ;;
 				(* | default)
 					git describe --tags --exact-match HEAD ;;
-				esac 2>/dev/null)" ||
+				esac 2>/dev/null)"
+
+				if test -z "$b"; then
+					test -z "$short_sha" && return $exit
+
+					b=3D"$short_sha..."
+				fi
=20
-				b=3D"$short_sha..."
 				b=3D"($b)"
 			fi
 		fi
--=20
2.43.0


--KiILIaAHZSMWEOk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVgiuEACgkQVbJhu7ck
PpT9Nw/+JDqe2phN4dyjAsNsAp1Uq5AFlA41ayxWWD7Z47AW2mIJ1H82JEHfA05D
4hLMekYfDqiGLczQNgXf7CCsydqtb0iVFkL5U1hI4AUou0MdJYjoSVISMGvRdy1C
ZKPJ5HdDNyW2LNGPyDQw7DhNVOgtz5uIw2lvbVa/Ne7Q+QxB+pUdD+CHzZzcBDa6
brCi1F4nKqs15ApHpaKdpEM7amy6qxKGyfopSAtjZrVUTekDLmmjqolGBJz5xvMr
7eE6QfG7crCPp6XNcfjZ8YQrnJhL6+q218AkQddtb4cqHlvmGvup66TUk2o2STfO
a/0LCGKp6wC9Q+qtg6YeYi/i3qPnR61OtxoOjL8bc2VhWG+1crE5eO7NdNttMcJG
1EGWVOSWT7Dup11vv0EygfIbwu6weDBDAiKpHr+A7RDVQn3Oex1gjpuwfXB/Xvrq
cMpA662jaLXcWGXHA855UiMUd3MqWbKKxqSm+8RZXjggc6hyQE1bnPzYQk+m07ld
+GKNZ8JVRTu2qz5yiSyt6bvsHYEUmlUZ9IITmOJN4qF9HXaeQ2ZQH45Un4scXb9N
DTodeYh0OCF0wc0jpvvJERqlrV5+dxq+3ShtD3kT/oBpL7vuiCs3PhNO/fuCShNO
+tlFKkvy0++nFtSsT47tCPW9zu6tZg6m/n3e0PcgMxaFQeiFFh0=
=PIJp
-----END PGP SIGNATURE-----

--KiILIaAHZSMWEOk3--
