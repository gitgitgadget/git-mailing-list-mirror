Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s+2HgnaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJLLs2he"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8111F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:40:09 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id EDAF65C0297
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:40:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Dec 2023 07:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866408; x=1701952808; bh=fe
	+aRzJVFhYmEZgmnb1uwhmMIYlwS6wyQrnp+ZPJ61k=; b=s+2HgnaMkU84AY1fjF
	9DP2FSOByqBXVsIzv5Bi/Nubaqe2Z1M6DHkw6LHCLYuGJgmE5UV8I3I+pw0dDTQB
	VhzYamWpdtzqn5bQ1NlH0eTqaaBO3khdDeOoyCo8nx3tjG33htjtQivFN6o2eo4A
	F/UNTYq/6LU5ErtHHgZ4xY2r1ONaqS6IyycJOlRDU67l611lvGGgGar3NPVoyvBA
	XPfNM4YXuww7k4f0rmI4936y60oy7flCTM44vCBHvVaNpzyTZB8J/Fu49VgeBrQo
	YiodebAY6/H5s/srdSfwew/JohhQo022WZhr3e7vpSRRZI1IrZuJl3YyUNqfkxf4
	sCKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866408; x=1701952808; bh=fe+aRzJVFhYmE
	Zgmnb1uwhmMIYlwS6wyQrnp+ZPJ61k=; b=bJLLs2helPwIfCz1IfQnjMRRLGzs6
	+87Do1Bw1Eaw6lP29sRXOXOOKnWGC0FUXXsaShVfOBHEPvi1BWTHURmt/RMVTr98
	WW0eAz/Ciql3fi0jG3MxzHcjnGIJEx25VW8H1yEIEIQauepj9B9XMReotTruzl1O
	9kCkhJt+q/FR2pG3r/vAQGe0QC0nVZtgFj9xn/2XvQaVTs+ZPnr2mDi6adjYtvB7
	J5a2Wr0Qj/fSpCq5HMyfwr41pmjBUFlZhyCLQtyjrzxlAGYqGQOVvoLTux+sVoNz
	14hgBkhVwtIgvbfiKn6VvRhJAV4qccn1lvuoJUICduidFn4Xo0JMvs/Qw==
X-ME-Sender: <xms:qGtwZTotQs-cnS03sVf8vBZSgnwGSrc2b7Y8c8TgNFof5hVLVaSMWg>
    <xme:qGtwZdp5PflrnPsdh7xICBpUwy-3XYide1qe8cxzLZ21vIp10G_p2fwdwKd7LKhk5
    kCTj4MRvjyNtspYjg>
X-ME-Received: <xmr:qGtwZQMW_7I2Xh4DSYHzgUYqzamiyx56qGtI56Yl6pRRkC68WOR1YBJ3oS0NuBAJ9vWGnF2uP4y9LNHEGQbDuqJlHJyDwrcSLGelzX6-l7dr_dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qGtwZW59Co4FXwPe-b6rOaD1LCM_G_Vg7irVJjwBTpGltKS-AdkD3A>
    <xmx:qGtwZS4A1CieH-a7ljsegXvTONPi-JqqfoGSOmApN7jWUmXb5lmECg>
    <xmx:qGtwZegDvGl_a_RiZQbSX2XtppSF7bLRCitnpZyQ5yronvInCbtMwA>
    <xmx:qGtwZfVN4cHkDtoFKnyFTC_JS4DwuF6eGjDtFIaJjSdEM7Bu6-wqaQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:40:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c06127c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:41 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:40:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] builtin/clone: set up sparse checkout later
Message-ID: <703ff77eea6daed0d44908e6a8a20aaa64af99d6.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FvY7cABC7FA/asO7"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--FvY7cABC7FA/asO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When asked to do a sparse checkout, then git-clone(1) will spawn
`git sparse-checkout set` to set up the configuration accordingly. This
requires a proper Git repository or otherwise the command will fail. But
as we are about to move creation of the reference database to a later
point, this prerequisite will not hold anymore.

Move the logic to a later point in time where we know to have created
the reference database already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d188650881..9c60923f31 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1185,9 +1185,6 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
=20
-	if (option_sparse_checkout && git_sparse_checkout_init(dir))
-		return 1;
-
 	remote =3D remote_get(remote_name);
=20
 	refspec_appendf(&remote->fetch, "+%s*:%s*", src_ref_prefix,
@@ -1426,6 +1423,9 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 		dissociate_from_references();
 	}
=20
+	if (option_sparse_checkout && git_sparse_checkout_init(dir))
+		return 1;
+
 	junk_mode =3D JUNK_LEAVE_REPO;
 	err =3D checkout(submodule_progress, filter_submodules);
=20
--=20
2.43.0


--FvY7cABC7FA/asO7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa6UACgkQVbJhu7ck
PpS9ehAAnruzgdMK6A4OoHmnJk2rcQMtdslmyzwQEr37Ik+kwwdLdp5CTIKT2EFV
7AABHJKIo8OKAsV7XB83XW/RrbhkW8DkEgGpfEbm74M6GQ+/B0YTnrsL/PG3r7lP
JLo/nqwTJdSOk1Jh9jcQtJq3+CJPoqLNYe48H5Wi8pPK0PKKuRYD8gyGqxvEYc2S
hyzvQP1C532gsGP7u/iWEFtlB/nb2WntL4EJ1fY9V+NOAL1UQ1jYsRK9R09x49BY
rF55u9VhhO4Hle/Mi+eUQ3azpHEvVSO+mb0akEL2OF9MtFAl7YvELO/clsYJWeXA
U0cQ4GQlXoxuQ5gij8QZt1Bv1VINifa7FNjWRAY2WR/igCV3+5ZrM2jmyD1Znn2x
BnPsdGRxxGZsskbWqZxlC/o8WxKMXqLZ6JJafsyxMbDtvrXTeqX1F8BLdvIAgccQ
n1nVvWhcg+Oo1efYTNw1QZbOv+4iHvmYIaFjrDKF481zY4Qk8/qmlMELNrIvPXyw
kcM6aDhFy289jRY+GOHhyQhwJwSmnK6059tiXFSVdJF5aOhx0GXtEWeyJv00ETpV
47uY4Ry27OnJMzRJPtUQJ4MFmsmaSNcdyluRplZ9SFvOwXJserswdiJMMTLTW63g
hvtRCYH4k3ijSqhPC1nEsgIE1xaERlVBPk6JIvLrIv1f9LY5fGs=
=b0N8
-----END PGP SIGNATURE-----

--FvY7cABC7FA/asO7--
