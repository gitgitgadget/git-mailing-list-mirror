Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791418041
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v1e7s+Ol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8ZrUJHIW"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 1D49F5C0268;
	Fri, 15 Dec 2023 04:56:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 15 Dec 2023 04:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702634197; x=1702720597; bh=kkPPDy4FMl
	9R4d+wylSFvcdY3VCxjGLctpDa61w71L8=; b=v1e7s+OlM0/iv7ImSAeJJcTEKx
	mCcqW0VTomh37IFCjPz3t0js5rvT5q169DkbYctsMn//BAZXMue6BgYLZxV6m2EW
	cWqR9YatHEIhaZZIuJctwk/DCEzQvzlDgAu5k8n+a/kkvY/ZTF5eDgNYDg5oFTR+
	ZiKLT+T/KqEwWbs13wC2L9O0Kp/NY9KntXMlLmiWB58j9Dm9Hsq6uRsSYmIqzCl2
	jD1VOxkGwLDeqm56yto8hBEmUW+865z9+o79vyNqf0/nuSQ7jGaGHbKT6lXI3FIk
	cCeetkBKjAUjKIx89jQgp1wV2c7FFcizxz60Zej6eRE7/m2fW0vQAPELjgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702634197; x=1702720597; bh=kkPPDy4FMl9R4d+wylSFvcdY3VCx
	jGLctpDa61w71L8=; b=8ZrUJHIWyK8gWwM3z6bLcEsAt7dSZnoZT1AA8y2QalDg
	jgrw7K4Vtbed6E1mSFgARI1S9xVpjUyMfrTPvTWe26ApbHck+DD586zCNuWS/POl
	Cwj7iSF458v2Qu4kw5H1fZOORqayzyV+1zKh9KgHTHA24YyUpleQB09IG5NqC/RJ
	9QXFBCRB6I0k4OmBNCRz9l1klDSy2PWIzQlzNj5cwwK0g5o4JXoXVPxQ6hnv8/e9
	ChWTAwMw/Kx3XquTjdcsfhxZD92Jd2LpFWCPC1CElxIcNm40rfh6TqPc+1ztVgzv
	h7bS9hJvwTMECr9cQftWQHxHzS3Q53NdM75UeVLYLg==
X-ME-Sender: <xms:1CJ8ZXjSG3N9wppNGyh0VYLRmvZBIJavd-Vq7jdRuj6wOuxcWcjh4A>
    <xme:1CJ8ZUCJhmBiFCAjzVftaQWKsXS5Xv9Hdb4-KmlQu8X4A6jEPHOtn0P8dRPdHUcPm
    5y9JHEJLNAlBzbsvw>
X-ME-Received: <xmr:1CJ8ZXFI-Pb5-KUhPyiGh6L-9Sws91gQe2veoCfnSd7Buf8KJQMPvggAQYyYaLIZpEzLZPWCYa8C__iiE-ummCT1qQ2YxY_c3uoCtQN48q2fVb4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1CJ8ZUTK20PQRBkXCvbZVWdvITTqFRMkTFVybgnCyt9csN7fi5X2gg>
    <xmx:1CJ8ZUz7QQdFQIR2Rv8jm5JoWs1csBV530Yc9CgvSJHwiPhFTDTafg>
    <xmx:1CJ8Za7j1HGKh25WYWv3j18YorkhqSZ0tLOTn-Ljvpi97-qommTklA>
    <xmx:1SJ8Zf-lXC2W9o9NhxAfrt0phSAcD1uLxKqu_CNQSnx-iajwLGvBAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 04:56:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b0f470a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 09:54:49 +0000 (UTC)
Date: Fri, 15 Dec 2023 10:56:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 2/2] fetch: no redundant error message for atomic fetch
Message-ID: <ZXwi0DgfhG4AEE9m@tanuki>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
 <6fb83a00000563a79f3948f9087c634ae507b9f5.1702556642.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rSg8EC6C5Y8a6k+Y"
Content-Disposition: inline
In-Reply-To: <6fb83a00000563a79f3948f9087c634ae507b9f5.1702556642.git.zhiyou.jx@alibaba-inc.com>


--rSg8EC6C5Y8a6k+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:33:12PM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>=20
> If an error occurs during an atomic fetch, a redundant error message
> will appear at the end of do_fetch(). It was introduced in b3a804663c
> (fetch: make `--atomic` flag cover backfilling of tags, 2022-02-17).
>=20
> In function do_fetch(), a failure message is already shown before the
> retcode is set, so we should not call additional error() at the end of
> this function.
>=20
> We can remove the redundant error() function, because we know that
> the function ref_transaction_abort() never fails.

Okay, so this still suffers from the same issue as discussed in the
thread at <ZTYue-3gAS1aGXNa@tanuki>, but now it's documented in the
commit message. I'm still not convinced that is a good argument to say
that the function never fails, and if it ever would it would populate
the error message. Especially now where there's churn to introduce the
new reftable backend this could change any time.

For the record, I'm proposing to do something like the following:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fd134ba74d..80b8bc549d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1651,7 +1651,7 @@ static int do_fetch(struct transport *transport,
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
 		if (!transaction) {
-			retcode =3D error("%s", err.buf);
+			retcode =3D -1;
 			goto cleanup;
 		}
 	}
@@ -1711,7 +1711,6 @@ static int do_fetch(struct transport *transport,
=20
 		retcode =3D ref_transaction_commit(transaction, &err);
 		if (retcode) {
-			error("%s", err.buf);
 			ref_transaction_free(transaction);
 			transaction =3D NULL;
 			goto cleanup;
@@ -1775,9 +1774,13 @@ static int do_fetch(struct transport *transport,
 	}
=20
 cleanup:
+	if (retcode && err.len)
+		error("%s", err.buf);
 	if (retcode && transaction) {
+		strbuf_reset(&err);
 		ref_transaction_abort(transaction, &err);
-		error("%s", err.buf);
+		if (err.len)
+			error("%s", err.buf);
 	}
=20
 	display_state_release(&display_state);

This would both fix the issue you observed, but also fixes issues in
case the ref backend failed without writing an error message to the
buffer. It also fixes issues if there were multiple failures, where we'd
print the initial error printed to the buffer twice.

I know this is mostly solidifying us against potential future changes,
but if it's comparatively easy like this I don't see much of a reason
against it.

Patrick

> While we can find a
> common pattern for calling ref_transaction_abort() by running command
> "git grep -A1 ref_transaction_abort", e.g.:
>=20
>     if (ref_transaction_abort(transaction, &error))
>         error("abort: %s", error.buf);
>=20
> We can fix this issue follow this pattern, and the test case "fetch
> porcelain output (atomic)" in t5574 will also be fixed. If in the future
> we decide that we don't need to check the return value of the function
> ref_transaction_abort(), this change can be fixed along with it.
>=20
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  builtin/fetch.c         | 4 +---
>  t/t5574-fetch-output.sh | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fd134ba74d..01a573cf8d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transport,
>  	}
> =20
>  cleanup:
> -	if (retcode && transaction) {
> -		ref_transaction_abort(transaction, &err);
> +	if (retcode && transaction && ref_transaction_abort(transaction, &err))
>  		error("%s", err.buf);
> -	}
> =20
>  	display_state_release(&display_state);
>  	close_fetch_head(&fetch_head);
> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index bc747efefc..8d01e36b3d 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -98,7 +98,7 @@ do
>  		opt=3D
>  		;;
>  	esac
> -	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
> +	test_expect_success "fetch porcelain output ${opt:+(atomic)}" '
>  		test_when_finished "rm -rf porcelain" &&
> =20
>  		# Clone and pre-seed the repositories. We fetch references into two
> --=20
> 2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev
>=20

--rSg8EC6C5Y8a6k+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV8Is8ACgkQVbJhu7ck
PpSI/g//WCEmL8uC1cs8CwGFjwEM4JjAOewiIa1VrdLPCMLI4sOEaqY9KUd3q9cg
R+KVaIdy67+yjvG7UHthLRvLxsskJkfPHFaPeNBVDvzCUVoTXCkljFBDMdXTsCfe
pjYpc8BRdLiHIlaiogG/z/fJyXkRkcapndRISLyuBosmcfcv/yrpszjxqM5bNpZS
nPdODEAFN6GFCCK5UwyXdf+5S+aYhnz/c1+zReCQfH9nnEJzJhsSQg/y1+RzoaT2
5sqkaMjH2cLKUJi1R40X0Bl25cVFr0yD3HUcmZGh7wQ/6MqR1R9LT1JnmSDEtDKI
Ur7vVFuMCqO9V+3wu4pso6ob5OmAs4yEIb9h/F0j+nkDYZqeLraWGyl3A3BryWAM
B07/8PgxZBPUAEQLyuWO/ooVi2rt/xIgOu5iM2LyakSECbl7ARAfnwG0cO0zhcGO
WZ0YE3LBUifNpNvGdef7W+cOUXtvdscQtIrNvVVgg98pshNpP05zgl2WEV8Uf32i
YWUC70y0MFZu9bi0oiZGAlKt1i/B7eggQYziHNOrfjONWYZyiqAPtjueLNzZTOvy
NGxr+v5Gr0czxHB4pr1KGxPJfajwn5FIKw2ZObt8y7kqlDaCa+xTCEliVXcYuyfM
Azj9s2ykKWVEVsxhkq/a6A/xdZJNeD810QHrxhXl+DZVXBU43q0=
=38rC
-----END PGP SIGNATURE-----

--rSg8EC6C5Y8a6k+Y--
