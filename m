Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F5111AE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qL3Kx+Dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U7u/TLec"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97291C9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:25 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id B693E3200905;
	Tue, 31 Oct 2023 04:16:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 31 Oct 2023 04:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740184; x=1698826584; bh=Mq
	pEtFyMr4zAx9s91RlgYVw/AHRt38Uro8MCG5QzkC8=; b=qL3Kx+DqAMKvMu+1NC
	Z9aJJNm17JJaz9/1bsJqxK5gOsYNfr+AE/BqHW0OYyyrqOLXm/5ta8dH3h3WozmO
	eQSXsMRgLKKaOFgcre9rZK+NzO9z7VyixlPTYptZJEiPNY98j7JUFKSwQKYva+dg
	4vZHU9IRVqvQS9B+hBPvutPQgBTuc3Ev5Q0u0YHGAM+5CRB+sfts1OA9Ot+LuO+I
	MwJv0imSdXsMFCI6CuEj8fMAI3wxcKc+JepsMAohZ54JARn1cRa1RTavrLqgJ0Ti
	5nz3u4tA7wC/3hBRiRFAXs95QKIqHt3iA52YDIfT6lmSQ6eCPei6w0QsSj3Tl91n
	y7sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740184; x=1698826584; bh=MqpEtFyMr4zAx
	9s91RlgYVw/AHRt38Uro8MCG5QzkC8=; b=U7u/TLec4RfeQLWyYeTOIYpdFgYcm
	9UjjQ96vzX9e/XIut2NdhUoiyO9ajWegOJEApfp+ies3Qh0EOBHlHdW6P/NPi/4F
	I3T9jqdEcRUXv1s/RhB/fvHLVRN14nziy4ZLPLADYDlqhTJm62I8G0olNElLsfGN
	VQ1JixzQBHAgKcQHbhfwE1TM0Hk1s/nYaAYNYluP6a3f930o5+ZYJjczzMc9QZyV
	mQQnYemH+EnkCVWXQfWkIqlzKBUT1+RFmHVkY90Lpry4xmrarOwsY3n98TcNYRH2
	1iyPnZ+hB3IASDw9WvaydG0TqUDScEnE5Q8nPhHTPJQlVxkhkllMY77zQ==
X-ME-Sender: <xms:2LdAZbuO0hZOf62outEbYZ2sXINel0SmV9gxxMPNQqkcUUxEiH6nqw>
    <xme:2LdAZcfjPOoPNkMq_kuOQ3AGM3LGlTeq4AvBEeW2AMPt9YegyNClrIOZ3CwNhNV-L
    3REaimEBoVSkHIK5g>
X-ME-Received: <xmr:2LdAZewdZvXlWOh2LtPfafoHzJb8l_-hKvSGjPenyiB4S-ghAJOjesEITBbKgShRDCJAUi5dh9JO-W_0kk88O3frDSQ05ipmJCPfNYPgTYRoOWhW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:2LdAZaMx0L2Vb-0uBnR07Y1TZ18-AqerjY1ph3cIIThuYsQB9DIxqw>
    <xmx:2LdAZb9YxTaT2Ve4NJ0Smo5q7CMJEGZG8lCLAZbVmN88_eSJcepmoA>
    <xmx:2LdAZaX_vJI9pc5uDD3jPe1wIjZEIz1in3CJisvvLB7ap3D3CNjq_Q>
    <xmx:2LdAZebUpaBzzjgGZttU8AEl9gwrGd7xEsj7WxKOQfEy3t8aE41v9g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67e93c29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:15 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 03/12] builtin/show-ref: fix leaking string buffer
Message-ID: <b6f4c0325bf19ffe9fb67be043bb02bf86ee7276.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p19iwU8HcJU/DNgR"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--p19iwU8HcJU/DNgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a leaking string buffer in `git show-ref --exclude-existing`. While
the buffer is technically not leaking because its variable is declared
as static, there is no inherent reason why it should be.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index cad5b8b5066..e55c38af478 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -106,7 +106,7 @@ static int add_existing(const char *refname,
  */
 static int cmd_show_ref__exclude_existing(const char *match)
 {
-	static struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
+	struct string_list existing_refs =3D STRING_LIST_INIT_DUP;
 	char buf[1024];
 	int matchlen =3D match ? strlen(match) : 0;
=20
@@ -139,6 +139,8 @@ static int cmd_show_ref__exclude_existing(const char *m=
atch)
 			printf("%s\n", buf);
 		}
 	}
+
+	string_list_clear(&existing_refs, 0);
 	return 0;
 }
=20
--=20
2.42.0


--p19iwU8HcJU/DNgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt9QACgkQVbJhu7ck
PpQuIRAArCbtUM9UBT0cCaoSVzjrm837bA6fti8uRZDxjavNdQLLs9C3NIh09eMk
jpB8pudRhGc3U6bc4EUiKuZNyJVFUoNFh4cVTbIy7ZmbWz8hEWjaOF9DUhO+j+XL
ilfsS2L+xkSZ4f8qqJDagWrxJ1oyNCl/+09fcvmoVmu5NskcUG+K02j1LyQaSQQk
FlwOJAyicSGbJdxraAun/D7bmL3o/kbNjDFwhx4bkUjqYwryTiPAa+6V4nRBp04l
qhLJWtxkIh82Wm2BIPoV4L4RiCPr/yKws1OcFEL7KLOsVGa1bjETjYAHfVd9CWW6
YEkcYisY/yUzGZ//NWlddfe5uMJ2Qz1pMyI+7QNPrYc2Ju+8dJ/ony7uVhyUUBu/
Ngcr+UMIT7QfhBgXX98SQqhEBS0HtCIxhjUShYma2IcLjT+jReaLW2jqsPzA3fdn
gG0LfPTBxbnv48LrS8VKTgQY9Y8c8vMz4/aJDVlSIy9Gb6V8QOo8qYwDP0PRoPd9
lsc9hqJrgdYkr59WmQDHtTykKFpk2ldBVjYZYX+6/uJS6inNEo5K6YY8vg4nTuYj
Irzd44bogag/67HGIZSoHV2DIRMQqYVYKNgZQEgY9O5Ljj6zrqt0pm1JhvTxFXwt
/mzgI4y/rBhB2pr1k3LASHTsQ851jnela9dkMGSfJuHBj/4iZNw=
=+h+n
-----END PGP SIGNATURE-----

--p19iwU8HcJU/DNgR--
