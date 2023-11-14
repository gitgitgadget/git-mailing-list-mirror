Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2B154B1
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T4MKqS+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTTU6ecz"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CF0FA
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:58:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 74D275C02A2;
	Tue, 14 Nov 2023 03:58:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Nov 2023 03:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699952321; x=1700038721; bh=hQ
	cst9/Eujhka2vrOSDghx4rNUm/LFaa7AyjX/NTz9s=; b=T4MKqS+82RrhhflDuP
	DdKOZfulj5f9SkegR2qFkQ9d03V47+vmukCARGGmKkQIxjuqk5cOMelwGY+vGEi3
	1l1fYSLt1aPXdIqzTejqEO2oikbuRSXIQM02oUyfibSGbsjPHv8r02H3IQ/BW0aw
	S6CtkONTqdptxOJ9eYhagcEkPZ9iOzjSsdfC6ssflTEWR4gtJuZAG6BhgwOG9kro
	uozLFhFJuXs9r/JxmQcZ+H+3V8kPooXXweGhzPMlr8SdGhqxTv0AaAIwez7OEF6I
	uVhSbc2kVvr6jElhEDpNyBhf/IdhB7q9tCr6ObbuXrZ0h91oxM+R0ZaqpBl6swS8
	0IBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699952321; x=1700038721; bh=hQcst9/Eujhka
	2vrOSDghx4rNUm/LFaa7AyjX/NTz9s=; b=zTTU6eczqahPK/48IIKmF1IHfEODv
	YxpIxIiEZJMsTrw9PtOGjH0wNYJA41FIcDFDoxJUczho7vTkzjZvCzgkx5+PK3In
	HMP5tGVDne/2/btCcCOFYyoPk4rBKu0WGqciS4NPiCfOmNhicpKIT2wRv9DI6p9Z
	boCSWzFmYkpfK76ayo444BES5sWnonAQ8eX/PuZUerc5jNJ0qoudEii9tbqQgYuV
	7tL/4uEoGE+4vZIV8U8XN8nXNQh0xmH3zQv4pbpUsYGqkzf2ZpW/SYXhW5ynNvc+
	Nke++QGj2mrJo03bI21l7u/qwaLIA79PTphL739e1RqVqVQUijvV2x/mg==
X-ME-Sender: <xms:wTZTZQA_ea2vIcUWb3plCz0LoJPSd2K8QGXhHCojCxdOcUYsoHU3XQ>
    <xme:wTZTZSjvLydapp-3jZ2FPp_NPCuonTcKkuZqIfBjivIs-6PBGqvmPJhdCWX28wKbl
    qlObDCZPxUi4ZTInQ>
X-ME-Received: <xmr:wTZTZTkch-DOf0VY6zzR8j_P-UH02OJkT6FFCaM0PQ61xPQv5VqvpbFlvuMv3Are1G-HiBDndhtrvGIDugVagzAxwBjRV1DK6fpixDD9JCSIXd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:wTZTZWymUbRxrzPM_pME2WZeJSNTPQO5_5DVn_2K9FSbv4mkHPaOVA>
    <xmx:wTZTZVSoHHInryaMTTdZV6rNRT2eBg1dvxDoym3S8Tptr6mSrWdosg>
    <xmx:wTZTZRbAxdsGuTAFT0g1eMMNJbx87UbY_yJwz080l5a8fYvu_DJ8kg>
    <xmx:wTZTZUKT1jFLm9TLHUR3COaNa2XbHtVmya6ZEO5mEoneEJog4Z2vHQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:58:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34b0fea3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:58:02 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:58:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: David Turner <novalis@novalis.org>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 1/4] t5510: ensure that the packed-refs file needs locking
Message-ID: <4be411fa413fda675314b8507d41f4141a1f97ac.1699951815.git.ps@pks.im>
References: <cover.1699951815.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hZYhxk/3Lfsmy6P"
Content-Disposition: inline
In-Reply-To: <cover.1699951815.git.ps@pks.im>


--6hZYhxk/3Lfsmy6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of the tests in t5510 asserts that a `git fetch --prune` detects
failures to prune branches. This is done by locking the packed-refs
file, which would then later lead to a locking issue when Git tries to
rewrite the file to prune the branches from it.

Interestingly though, we do not pack the about-to-be-pruned branch into
the packed-refs file, so it never even contained that branch in the
first place. While this is good enough right now because the pruning
will always lock the file regardless of whether it contains the branch
or not, this is a mere implementation detail. In fact, we're about to
rewrite branch deletions to make use of the ref transaction interface,
which knows to skip rewrites of the packed-refs file in the case where
it does not contain the branches in the first place, and this will break
the test.

Prepare the test for that change by packing the refs before trying to
prune them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dcadd56d3a..79592a3b0a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -169,6 +169,7 @@ test_expect_success REFFILES 'fetch --prune fails to de=
lete branches' '
 	git clone . prune-fail &&
 	cd prune-fail &&
 	git update-ref refs/remotes/origin/extrabranch main &&
+	git pack-refs --all &&
 	: this will prevent --prune from locking packed-refs for deleting refs, b=
ut adding loose refs still succeeds  &&
 	>.git/packed-refs.new &&
=20
--=20
2.42.0


--6hZYhxk/3Lfsmy6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTNr0ACgkQVbJhu7ck
PpS9iQ//dn5lNgJdeIp1P88Vfzqlq9GEg/mBXEKCMz6nokH30OeMdtq7xIDm2fgt
hihs8Qa1QMTmhB6xcjlkK+E/08yM61okvyORKE0s+h1FZje12lfGnPOMptAZN4I9
rUvsuAKp+OLoW4e5A49zJMA8dzoxR562XzACd/iQYpdpMRHEGuQKaJp5ve0mwR5c
SC4c1TKNc0q30vpD84Gghk0ERERXmYsb8uLgTMOlNbo06tBztK7G0mI8CQijBNhx
QJqGH92UVW6EeZe+G2wbIUwN3L3HwePCKNWqsMzQkqQRzwWHrvp2qHk4dhhYiJPd
orCLqzYL/ID8fEus6VI1mXqxKsvgNlQBPoW0OzkFGxhCg9m9sS7gF6LLnXE/agjB
qrR2Ir8CMAJD/k5/DyZha9qQRgg8gTMGiwgc5DLNh353qA6rWn/Pfx3sAbCfIr5Y
kcCJyyJh3hBY7lZMsJlXz+iPGPuXY0j1GjtLhePdKHjrJUYIDqSWLU/2nJJB2rT8
kGmKxclr4MnYJo1PPs9PzCyZoFjfWmUtz63ad3S+DkpliKvJtgJt+itGif+hxSsc
kR28l1ouRzyWKwaVmTW6y3t7tybyjd3cerk9e14IO7L/VClTroKMsEYZVmhngr2n
IWBQw+Np8wqBS3j2ucJxbSW73PYQqmAyy0PVv3YbbhDL64caeEM=
=2u+i
-----END PGP SIGNATURE-----

--6hZYhxk/3Lfsmy6P--
