Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sJjg2zj+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igqYCdye"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E9212D
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 16A663200A1E;
	Fri,  8 Dec 2023 09:53:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 09:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047210; x=1702133610; bh=Zt
	xTvqpV4ITb7Bp9x0Pj9C61/47efdYtZ8Tp3tEfEWM=; b=sJjg2zj+TSFH0OBgEg
	ZN7Jbl5o6ywWWH+CS5uGWioMQ9268hK5Fix0P/eUtvkxjRugLeUJpYiQFE4Frvi0
	lRzu1E4oOXu/jVffEeaXN+yXNTbhD3kOm9OTHl8Bz6wzCx/15P0+nVMOZg/4opi+
	DKHe9Rg2rDfG0RixFZtGvuyXuM2ntN7QI69YgW3vAar/sBYYz1GIVBhmNmMaBKmB
	TxX6VQ04vECht93FaU2TS0uYFJ6Xk0pwFsVZ0Ee1DA4lY6N+NZLNFsQnU2g4dyLP
	AJrYktambczX1Lj8ZfysR7GGcxFqtKPRH03jMRQr1vPzXd6H8FdufFM6/67KLQgS
	eQJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047210; x=1702133610; bh=ZtxTvqpV4ITb7
	Bp9x0Pj9C61/47efdYtZ8Tp3tEfEWM=; b=igqYCdyekeRQwZLmZXLI8OzKhAQp8
	e9dXWzoNiia+CHW8VdMo+CVygOMcsXSWegaElIv013ASuaplv/5L/91n2mddFQzs
	qOAZmggvyLeQ8PvA5R6tkT0uy6DvAV0mnmIg+jOv++3dsqCwpz/NXWN/xVYmNH4h
	8Rv4fwNYPZBXfecfkoOoQ0k3003U1gWnoH+dvzUFRGNA8/Y3+XiFSdZqbOskqR6m
	VBVM+o5+yZiyf6BJ2+U2XWGgKPCehP7pRVzTo6HaLsL4V2pMPfWKWPvU07ZTOuB2
	Z4ZJCFiQz1Erlm0XKirxlRWSUqfuD1v0bJghwDyIF3Nkaq4vOebLjTn8g==
X-ME-Sender: <xms:6i1zZbJc7pH8BJGrd6RbVoU5VtHpihH-JzSbl2oHsSKmybEdzAynbg>
    <xme:6i1zZfJ_02EcznNOFZ8XcGKrW4dixeQQPjxl2jruxYOFeyQ1pBnpxjTvFjufQBQMa
    Dt4L8L-WD5CCm5avA>
X-ME-Received: <xmr:6i1zZTs-eXJeLpQ8yvKonyJHLCAWNOKubmleBMgwv5vcRlkSXTrxRdUDfGiKG7pljM0hxm_ekMR5QfW_ILU7rOYojkwbwg2PieoFsgO69pzzJd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeevtdffhedvheehgeeuuefffeetiedtfeehjeehteevieehkeekieefhfdvveeh
    necuffhomhgrihhnpehuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:6i1zZUbtz3gDccf18GBIvlbzrCMbpEp3VcAzXxYeqnNxx-k2vbHsSg>
    <xmx:6i1zZSavgOy8d6zhRY-wi6PaMJ2ku9tAW3NNRs45hoFyT5Yv5UbE5g>
    <xmx:6i1zZYBTFTzh9M1aRBynfLdqWmDOUr0H5JoHRSKAFLRTV00INFWudA>
    <xmx:6i1zZVwboZdEvQOGw6c0Vqang0FuUATtVXYy5o8xhFwDcR2ucwnCQw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:53:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38a14f24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:58 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:53:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 08/11] reftable/stack: fix use of unseeded randomness
Message-ID: <bab4fb93df8d1a620eefeef99a49ea52c98dfc6e.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NGr2n6js8oXiu8cY"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--NGr2n6js8oXiu8cY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing a new reftable stack, Git will first create the stack with
a random suffix so that concurrent updates will not try to write to the
same file. This random suffix is computed via a call to rand(3P). But we
never seed the function via srand(3P), which means that the suffix is in
fact always the same.

Fix this bug by using `git_rand()` instead, which does not need to be
initialized. While this function is likely going to be slower depending
on the platform, this slowness should not matter in practice as we only
use it when writing a new reftable stack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/readwrite_test.c | 6 +++---
 reftable/stack.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 469ab79a5a..278663f22d 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -141,8 +141,8 @@ static void test_log_buffer_size(void)
 	*/
 	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
 	for (i =3D 0; i < GIT_SHA1_RAWSZ; i++) {
-		hash1[i] =3D (uint8_t)(rand() % 256);
-		hash2[i] =3D (uint8_t)(rand() % 256);
+		hash1[i] =3D (uint8_t)(git_rand() % 256);
+		hash2[i] =3D (uint8_t)(git_rand() % 256);
 	}
 	log.value.update.old_hash =3D hash1;
 	log.value.update.new_hash =3D hash2;
@@ -320,7 +320,7 @@ static void test_log_zlib_corruption(void)
 	};
=20
 	for (i =3D 0; i < sizeof(message) - 1; i++)
-		message[i] =3D (uint8_t)(rand() % 64 + ' ');
+		message[i] =3D (uint8_t)(git_rand() % 64 + ' ');
=20
 	reftable_writer_set_limits(w, 1, 1);
=20
diff --git a/reftable/stack.c b/reftable/stack.c
index 2f1494aef2..95963f67a2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -434,7 +434,7 @@ int reftable_stack_add(struct reftable_stack *st,
 static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
-	uint32_t rnd =3D (uint32_t)rand();
+	uint32_t rnd =3D (uint32_t)git_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	strbuf_reset(dest);
--=20
2.43.0


--NGr2n6js8oXiu8cY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLeYACgkQVbJhu7ck
PpTQQw//W03IQOrEEMPQwD7qId4LbXk2Wck36IppjhGvARGMmzHb9vp6LibQbZIy
sOJp4won2xPoR6xWhxo8zunPfigLlWfdWacmOJ9Ihj8djuet0qYgM9aT33B3x7Ye
9g76QNiFpzBDIyrjOgRYwI480moTzxZXCCZxtD4oYGUs7kYXspbq3uzhO8Jxsy5V
GtMMQHIKOS2pKQueV0YiluJlWFDBFWIJOirfkJjQz3cPA8co++0h+U8r/Ttad8pL
HUoY9W7LiRYBoxUrUidb6PR5fgI0Hrulzd8c/ktyHaspKEYRFtX1UaAxtNuHmuF4
vW5X6jHiNjOjRwq1UlpVsv42uyd7wuy6uRSEiVVCyoxKa15A99HboW8e8z/qVg2m
CWaSBiiQ+7JBX4v8qwAass4nQXRHxNmeaH9tljlCpm5JNH+irecCFzDxSIRPo4v1
85k/yT0eSVxdaO0fmCUFN24CsxIYyVLic7cIzQ+ogV43iPuumVezJm4gZtAPblR/
105/ZEV6W83rasqK3iqnmynGF6iX3sarq4LD0vOhVVAl9jedtWOMIT2Uz9dRQseP
yi6LJ+oirfhGb8oNXYoqECKPfBoj/n5ojxSxPOWRjre8IdVLCgcXCZKqaHpnNrqJ
hPr0Oh/Yf+pbZEwDiPEk63fe4tYlahc6AonddFWcx6ayX/hBbRQ=
=jFa/
-----END PGP SIGNATURE-----

--NGr2n6js8oXiu8cY--
