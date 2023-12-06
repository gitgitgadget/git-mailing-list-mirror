Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hNt2LUmZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSSuuZbQ"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E1211F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:40:00 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id DD08B5C0288
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:39:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 06 Dec 2023 07:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701866399; x=1701952799; bh=01
	GGAJOWd3Swn+hAXwTOpobA1AKOmJMucNCSXBa1SjE=; b=hNt2LUmZfKwkT47Jii
	LTCuN2G819isVokYgoWmLACP6a7KUJ7RiweOAC17wmKco1cTSiZbcqNoAWpTAyU+
	EMHCDbsl9N4s09Hn9sq3yN8kvoHa2a9vnFhiFa2Mry2A7ERvQVV5BPZa/rOoAvls
	W3yFkohTKyE89bvMScC6taScmlBz8XSI+zRI6U26ZXd+Cts0GNosI1tRYcRrQ0kE
	x0i02PDr4XFg0LVzuvcZ+6DzyuOAdPpPDKo8VMuBt7IVN/Hf2A27OLMXBBdICays
	OmsS4O4PzKC7Em/0RwWOaO0ZpTNYH1G3rWW6d9UTAMvCcIfY8W25cXp5uLPY213V
	08sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701866399; x=1701952799; bh=01GGAJOWd3Swn
	+hAXwTOpobA1AKOmJMucNCSXBa1SjE=; b=nSSuuZbQoKf0EGfiJODxoc2erRNen
	rm6JAtfSX2dKsVywbH7uIAtCMR35IjY8EBkS2swKwhX0e9iTLi9VxiisnchMbWpO
	YrqMnI4AB8VAV5DpGJd0zfmxFUrQtpXtJHwILIUAqNBpO8Z+Y2fc8O5Qpcnz/IrH
	NraQgWpou9/GAQwz7ac4SWEtOUNYpm1z2UCye+2rs7/v5tiPizECJRwEO+j373v7
	Zk3QTnXtuH2hbe5dPAJHrWGw5HDd5ED8jQSIaJbMVhWJdunFpA1kNkEW77u/iWpp
	x/iyx9HMrAoXwmjT1Xn04j8K21WA1PuwOHgft5psZiHhu5bRorcq1KBmw==
X-ME-Sender: <xms:n2twZam6FtJcD63ZfhuEyBlOT1vzjTjrWguko5Kl4_RyYYlszViuuA>
    <xme:n2twZR1sI8kTzAmVs4Zg7A71DJkpAgnd25hvwqmcDGM1oiTDDW-b2G4GLM7q7PnWB
    ZRw6ugvB_cyMJYCmw>
X-ME-Received: <xmr:n2twZYpuUz-beAI86ZP_73Zc4s48fCmpFZEtCx21g5yPYlpR28xOvAOa5nEPWWlz24I3CyU6cobXtkXhBzOWPAxnOWzCdGrZWQOuhTZ68mHpz9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:n2twZel48cO25zOOk_yslwEqFvVGo984KXVeQN-_95gXE3gcD-N95w>
    <xmx:n2twZY2VgSFF8hOyavxxyBwiglu89uJOaai663xA4pU3xciW0s4Vng>
    <xmx:n2twZVv3a1UJrP_OBlOo5UsPQwuQpsn0Qb1W84mHKnU4TfEiorZong>
    <xmx:n2twZZglrAD1VYhoTMeOp-hIiIkrlpxHG80rkKC4VP8T3HiHuPZirQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:39:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b377bc1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:33 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:39:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] remote-curl: rediscover repository when fetching refs
Message-ID: <a1b86a0cbbedcc6610b2c563e9e38d439338869d.1701863960.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a1kFyGJ5JJjEf8KA"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--a1kFyGJ5JJjEf8KA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to change git-clone(1) so that we set up the reference
database at a later point. This change will cause git-remote-curl(1) to
not detect the repository anymore due to "HEAD" not having been created
yet at the time it spawns, and thus causes it to error out once it is
asked to fetch the references.

We can address this issue by trying to re-discover the Git repository in
case none was detected at startup time. With this change, the clone will
look as following:

  1. git-clone(1) sets up the initial repository, excluding the
     reference database.

  2. git-clone(1) spawns git-remote-curl(1), which will be unable to
     detect the repository due to a missing "HEAD".

  3. git-clone(1) asks git-remote-curl(1) to list remote references.
     This works just fine as this step does not require a local
     repository

  4. git-clone(1) creates the reference database as it has now learned
     about the object format.

  5. git-clone(1) asks git-remote-curl(1) to fetch the remote packfile.
     The latter notices that it doesn't have a repository available, but
     it now knows to try and re-discover it.

If the re-discovery succeeds in the last step we can continue with the
clone.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote-curl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..fc29757b65 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1564,8 +1564,11 @@ int cmd_main(int argc, const char **argv)
 		if (buf.len =3D=3D 0)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
-			if (nongit)
-				die(_("remote-curl: fetch attempted without a local repo"));
+			if (nongit) {
+				setup_git_directory_gently(&nongit);
+				if (nongit)
+					die(_("remote-curl: fetch attempted without a local repo"));
+			}
 			parse_fetch(&buf);
=20
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
--=20
2.43.0


--a1kFyGJ5JJjEf8KA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa5wACgkQVbJhu7ck
PpTn4A/+IfGTNH8VgM5vW9PgI+NYiygMWPtX9ZCfDBq/PEOMQowC1HXcAuJ432c9
lak9bWOXHoH3THUgdKtdKV1dZIJ9AETRkAcxTkBWuF+z4iNPcNkuFR6i1Ol5CtJ7
51xttWWdwQao4bIm5ZhGKhzw20YWUk8sT38gzisEBV0HBzosQcGPqxQxk7RP7E2c
sO46uIeL4pGpcmLKNZrRT05Gwm17g54Hdrw2QvsqItZAvwgJUHFlfWcevd0oLi2p
Xw8cZ74cAbjt76Dnz1Jymed3gEtoeIb/NttEdmEl1881GsgDS9G8zEfs6itzDcWJ
cfAq9i1QK3KYTHPO3jaBPHayB1Ik3Y8i3jjeFXQV02xaCVYQ1VCbe0oC0dWMnivB
zCJMhov0Du8ITLHSUx425PZ/ohO37SrZbMtZfEvn6QswBM36LTxZLA9U/p8vof45
warjh/FIop8NZQNb6dqLq/HbBXIEA+eLppH84tgDOjVxEK98rXoXVnE4isc8L1tI
6Yz/qdmFbDHd+HWniTdG100hDxu2eG91YR1U56314DsEEuEghGHYqDmneCANYObp
KE/ZFw23V7rO1PqWvkyQFIcoWPEgGLYnDB/+xqWRc6Mg4mO3WVKYfS3DYxfBpywu
N3ffLhG3zwZILnMe8dg1ELy++fyasmVLu3xaHBOj4lLTZJ73SQU=
=64r8
-----END PGP SIGNATURE-----

--a1kFyGJ5JJjEf8KA--
