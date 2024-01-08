Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB86405C3
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CcIOlCe+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CBKbrS2A"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B22F53201202;
	Mon,  8 Jan 2024 07:18:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Jan 2024 07:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704716318; x=1704802718; bh=wUGPbTya2H
	I0qwMWHWvVPKRa6Lo6fizHuck+wBGXDI0=; b=CcIOlCe+npb7dq06NqV5t50vxs
	yJf607jTUz4I7hNyLP0t+gSk1G8R10RDmXLiNdTpud0gIZHcdRdorWs0l2jjDwao
	TxTZex8xRMnBrSECadAvFca+r3TUa2yGfybe/CmGg86+UoU+W4ZppxpHxX8vpbD4
	Cr5q0UhwsEMu2DNI+1I7Aar8nHe25BETGJZv6cn82iX3UshMJ5p3zfy1z6A1pu1/
	bngtcFB0jpMtISemw5IqaOCrH6JlmeLOpMT8QmjbM68hRVxI5LpN+IsAQ69T4KIO
	nbgCDfOyGDl15PziP+9rY+4ocnNMF0UqkE5T48B5/uyWm9e0f15O9wYBJhUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704716318; x=1704802718; bh=wUGPbTya2HI0qwMWHWvVPKRa6Lo6
	fizHuck+wBGXDI0=; b=CBKbrS2AxOJ8e8XYNJY8bdu6a8yUmAC2RYH2rvrE1x2U
	kwKqRXA+vwsHTFEVzyPngC2qmJJuRBWAK0ehcdvaQej19/Hyo/4oJvOI+9zAFLP5
	ZTpvhbFJdSCLysvDGLq/tejb+P90Q7nBvhAoI665skR5ZZpxmUIqTv3Xh6ZRmucd
	hze5wUykByaIJaO22zTvNS1eJhb5Zx5v+gDh/9n6+VuLtPmFderhnTvkd/wlFLtG
	7wiNkB18Syn6OrG59BTY6CGf1dcOninVwtqOSSn87u77x4bINX3ijBjkXRTXRosh
	emNV+P9giAniLcZW1F1FQbXSxF/Bt5xplMfzU4zQFg==
X-ME-Sender: <xms:HuibZe68Hj8ZKYkv-oM-xuzBZ1Y-bVZVp_J3Wa0U9VbedxKtOrxQKA>
    <xme:HuibZX5hMlW5kNsI7KGkTMltLLCEn5qZ-lirn9jNQebKiVjnZKE8K6J6xZjx3Vaf8
    NC0reOOngiVeSCWqA>
X-ME-Received: <xmr:HuibZdcOk6WIiSBZjytDqPWHhJmt5hXINrBDzW8-YUN3-x6R7fxIF6L1gi3sSCxnH-0eHSVkTjc2I1Xw6lpiooQWCIX2yNIMR4Y4aRLmZFAoUXk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HuibZbLnCQRWVlZtZMO4yCusiKdUzmTme_2qXJCC30Z2agAFibpZ8A>
    <xmx:HuibZSJXvc71bSnt35RNNa-Rb71sri5jDMwJCWSc_70Nd9Tniy-pAA>
    <xmx:HuibZcxBJXOVRymsxh6diDs6ik4ZkCSGHTkxDqGdfrlzK9kSjgayxQ>
    <xmx:HuibZcyPjIQ5EKqcBR91QFI-eaU4ytrnUsB_6GUrAXeypP7n12Z5dg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 07:18:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9de32cc2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 12:16:01 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:18:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 2/4] reftable/stack: refactor reloading to use file descriptor
Message-ID: <726d302d7b21a5b948575492c717cfdb701de5cd.1704714575.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SZM/SNw0YbfXgXdo"
Content-Disposition: inline
In-Reply-To: <cover.1704714575.git.ps@pks.im>


--SZM/SNw0YbfXgXdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce a stat(3P)-based caching mechanism to reload
the list of stacks only when it has changed. In order to avoid race
conditions this requires us to have a file descriptor available that we
can use to call fstat(3P) on.

Prepare for this by converting the code to use `fd_read_lines()` so that
we have the file descriptor readily available.
---
 reftable/stack.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bf869a6772..b1ee247601 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -308,6 +308,7 @@ static int reftable_stack_reload_maybe_reuse(struct ref=
table_stack *st,
 	struct timeval deadline;
 	int64_t delay =3D 0;
 	int tries =3D 0, err;
+	int fd =3D -1;
=20
 	err =3D gettimeofday(&deadline, NULL);
 	if (err < 0)
@@ -329,9 +330,19 @@ static int reftable_stack_reload_maybe_reuse(struct re=
ftable_stack *st,
 		if (tries > 3 && tv_cmp(&now, &deadline) >=3D 0)
 			goto out;
=20
-		err =3D read_lines(st->list_file, &names);
-		if (err < 0)
-			goto out;
+		fd =3D open(st->list_file, O_RDONLY);
+		if (fd < 0) {
+			if (errno !=3D ENOENT) {
+				err =3D REFTABLE_IO_ERROR;
+				goto out;
+			}
+
+			names =3D reftable_calloc(sizeof(char *));
+		} else {
+			err =3D fd_read_lines(fd, &names);
+			if (err < 0)
+				goto out;
+		}
=20
 		err =3D reftable_stack_reload_once(st, names, reuse_open);
 		if (!err)
@@ -356,12 +367,16 @@ static int reftable_stack_reload_maybe_reuse(struct r=
eftable_stack *st,
 		names =3D NULL;
 		free_names(names_after);
 		names_after =3D NULL;
+		close(fd);
+		fd =3D -1;
=20
 		delay =3D delay + (delay * rand()) / RAND_MAX + 1;
 		sleep_millisec(delay);
 	}
=20
 out:
+	if (fd >=3D 0)
+		close(fd);
 	free_names(names);
 	free_names(names_after);
 	return err;
--=20
2.43.GIT


--SZM/SNw0YbfXgXdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWb6BoACgkQVbJhu7ck
PpQP+Q//V2/bWnVb7jTlMnX3Mij/k7diAayZrrsx6+WlPOqBV4IAXcaVSKBR2jk1
NmjUMdlbp4bFlBk7DQkcSg5ttJBthOyxuQL1miLhQHmtbXrdefJpoBhdwf6mAk+D
VPRK6c1fGArZ2qpDQ1QESmuN8A3bEe+lLAfb378d9wRO6qtOF2L2r+rlGmvXfpHX
ear3SKRRVxwoQqr+2YjCWxfr+XTMTjTc7d5U09G8KnNeXdYUsiJdopkv/1AL8Sfw
dW/EVblAa1v4LSl4Ixmdg+0/TODq+5yRLnfJrWsKn2reWHYBBFlNnij7+ceynKHB
+pVJ60ocnp+FgIDWS6DygXKwiglijBlKVLGpdkJEJ3Z2Q+/zfuzjTbJptIevdzgb
e79nz59SjuQv8Ko8X3QAJd/YTcbrPllYx0STg+BGf6hfTcB7/FrSVBg02WudOqUC
fUtW4F0SxJIg2HpFOGjX175tLFg8T8kRk6PFMZ5P5KUBeIe/ow86d5Et9nxM7Cu5
o07FUsQAX01MBlGHG9aYYtBQzll04rw5eZivCPsSy+o35WKJoVUGxmwST5C1rjOG
Vj57csh1OALRLiLpmaEGyZWV/UcLa2aeZNoy+a3TpBHSdffqvrCi/nBJhhRvPfQO
icxykUV3lFeINGGyLC2VcU8zF5Qt42Al4XLZUM+GTOnvQYnXPq4=
=oyvz
-----END PGP SIGNATURE-----

--SZM/SNw0YbfXgXdo--
