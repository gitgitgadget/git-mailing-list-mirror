Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D358145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504663; cv=none; b=JLTSSu/NiwFFituz/Sedm6rMksC995yo/MyD1e5us7MxmdQKyte3hAyc/QvOcWZUA0yUQbV/jghJquiDPbTgNG88JhxuXCAzN4YW8ZdaMmd7IeSIq4r+GtGilIV3jDIYvStY5ouDZILs5jhc+QWDlAbW1q83r8+dHrore1ryzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504663; c=relaxed/simple;
	bh=F7r0pFAsp7KHI+ljrzUNnVhjGhWny6lXWAYzRisNIdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRajaGJKJx3UETXggUDCIxrORn937JJFjwXkGLCA4XcM9N5dl6yZQhCbYdw08Ahqm80zggI07yxf5h78CnTIYRC8evyWzl3plNgpqOct0Bhmf9FUl/A/rtBVz5uZzF/LGVzdlbqA/sg/wYbo/mDEqSPG1UCiFiZSDmBlh+GAEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2od7Hyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phR9je9e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2od7Hyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phR9je9e"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E7B5D1380153;
	Tue,  4 Jun 2024 08:37:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504660; x=1717591060; bh=/3QF+ebj/V
	8Bc4eF2hlWLwfmSsfgOj5adohu9qaFOws=; b=K2od7HydhFfaKI4vSdJNzTE41I
	lJBxPX1WJLko9uqYvGajvUFl2R88rwLypxnQfNGiQxitAvpINzLxVfq7yaOv8kGu
	kjvETkj5P1t8/3yzAhy4j6TDx7qt1GKr1y0EELUpVGB3zbv09qD1sukoZRZmD2HF
	vOw5fVl449od61cgITS98JEGWsdFi/5bBW/kSNHfQcqQIdU27bCcdEJFr4vyMYSx
	3lkopJW9wxjQ/6vsgXJMIO19dCGBTOC347PHeuotqdx7uD4TF5nRHlSRxjypDI5R
	/IlWUDo73EkvMKUBhw1eUIzEsmvlawZdvxP5iSP7zs56+UF+aR/fgd0+NgFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504660; x=1717591060; bh=/3QF+ebj/V8Bc4eF2hlWLwfmSsfg
	Oj5adohu9qaFOws=; b=phR9je9eF1agkfQRbZzX7CaU3TOQuOnyi4kSbey53l30
	C30KXTAHLnBHucI0XPcmjTtPKqbv4XPQ4KuXH7RLkSxjZAlzAFwkcW+k15PIvSkW
	UqdrpC72Y7Dnnl/xPo5L4W9PX7fyM7SC6tSGxxwstGo+/d3kj1ICGEf5VeFgX2PE
	S051ttmf8cZ//6N/AatiSZuvcYS5k9r6cRgoVEmLojQk7MNj6xe+E+isVl0fX5SG
	mwdwZr+n37/3oELGW8azmEpj/8B2Ptq5chsBgR93b5nu3eKphyjMMo2PlchrI4ZQ
	DNZ7/tWuHkL7Bl/nfdVs0/ePE7MaqcRgq0s5U7OS9A==
X-ME-Sender: <xms:lApfZnUIZ_sFFSOCi3PxXfgqNruht1iNng1YhLSUAxEV0HNuYvt0xw>
    <xme:lApfZvnTSSY877b3ZHdWWZ8MQyVFRepc6UvQUUbBkG9VUpkB73XILpCnhDxZLWE1-
    j2KayyiMs17bd8mwQ>
X-ME-Received: <xmr:lApfZjZPzfBp8d1mUoibLeg7pe_UsT7ZsuEzaPR3gz-sgO6opGwTBnwLW1AVzwam-_x1JOQsoX6fZbCgcZVXun2zn0PMmSsM9iQm5DsyUEtHNc_9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lApfZiWqQBtRHaOKDJzId-mNuOizIyECKwWVyY8wfBqz6FSLZI-F7g>
    <xmx:lApfZhl0xd-y5RuSdUU6euR-mdeJuTqPH5QzyInPkMQkDgHdqqCWIw>
    <xmx:lApfZveAU-MBwH7fKd2JmWXXa9yKV331AOQ9NKbk2xqi1uHX__NIVQ>
    <xmx:lApfZrFkvVjg3EgljUkNY1UFxDtKA0e9ev5LfLY-6vVJEYeQVbP3jg>
    <xmx:lApfZqB4euMifHdmM8qb2U4oC8QT4e793QgZhS8B5EzvNYgZZ34ROUIm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f510e812 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:13 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 10/27] entry: refactor how we remove items for delayed
 checkouts
Message-ID: <b46dd3210d3e6f73c84fba6aaa8f21929f7052bb.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NSkxS2qVU+wmibMI"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--NSkxS2qVU+wmibMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finalizing a delayed checkout, we sort out several strings from the
passed-in string list by first assigning the empty string to those
filters and then calling `string_list_remove_empty_items()`. Assigning
the empty string will cause compiler warnings though as the string is
a `char *` once we enable `-Wwrite-strings`.

Refactor the code to use a `NULL` pointer with `filter_string_list()`
instead to avoid this warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 entry.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b8c257f6f9..f291d8eee6 100644
--- a/entry.c
+++ b/entry.c
@@ -167,6 +167,11 @@ static int remove_available_paths(struct string_list_i=
tem *item, void *cb_data)
 	return !available;
 }
=20
+static int string_is_not_null(struct string_list_item *item, void *data UN=
USED)
+{
+	return !!item->string;
+}
+
 int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs =3D 0;
@@ -189,7 +194,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -199,7 +204,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
=20
@@ -225,7 +230,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D "";
+					filter->string =3D NULL;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
@@ -239,7 +244,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					errs =3D 1;
 			}
 		}
-		string_list_remove_empty_items(&dco->filters, 0);
+
+		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
 	}
 	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
--=20
2.45.1.410.g58bac47f8e.dirty


--NSkxS2qVU+wmibMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCpAACgkQVbJhu7ck
PpSO/A//R6WUIW67HxKkaObhV17qcca41+CjPLEJ0UEPP3tf8f7YXUOEqKWEPmlA
f3e3CufTdiNpmBxt7BnnvbkXKzgMjTGy8S1F0itzCHTjWLwymq4/gefAsZwI3XW0
5YHvTDowi/bxlp3/vvsMVw87IEXk4w1AuP5DPS5zLP9BWiaPQRxuO9Pd4wGsvqkc
ilnHmn4/lvm/yIr2V7KEuQOO1oaIFZwCR4nqWH4CbmR6Mh63C8xZfXEqMCvCMhGk
IsD8JKFv53V0lZBE/XXOdfVUJc7ptBIRVKIOsEyL6eanjq0UMQML5LPNbLY/58Eg
B8CEx7kOHBdVXWtK2S9ZasDjbjI3oEO1VqQp7fLLGL6oI4g91jCW7rlcrRi1dY1h
E32Vn0q6eJkC4gXmbG8iLBg0gMWYIWg3xGy5Q515KFVmwXV8hKL5gH+OkZV5Huno
zdUaWjsk+eJxBHFx7IjwwN5mzNAZtrLHJVfCdqAsNiuAGFEMOV9ndm3rz4dTWt3z
vjkSvRv11NQtBos1JywOfm+gMs70GOhyDw7tlYElg7WVRmO+uzrln5BPr/D/IHPL
BSk0IHQixIirqFLQ9iHU5PwnHd79IfXKpu7cSDSf1+7Srf9uiOfuMGu2ZPpsGE0B
EVm3JkoJoAOtyKGb+MjqtKNlSoGkn1q/6w5OD6lVZRb2np6T54A=
=YBZI
-----END PGP SIGNATURE-----

--NSkxS2qVU+wmibMI--
