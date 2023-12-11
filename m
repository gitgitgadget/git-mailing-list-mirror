Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MqviRA2E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epai8ouh"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956A1DF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:08:03 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B38D332026EA;
	Mon, 11 Dec 2023 04:08:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 04:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285682; x=1702372082; bh=o+
	omBwsfZEekVbC9W2C9ko+HJ1hayNDHplnPVS05Bog=; b=MqviRA2EG5N9KE8cPV
	2N38FsVRZBMppcEHhdtkEEDGN/VnFcG8VuaWuL7gfcaRIZeQ5klVsJObKBWryCEK
	b/Q6ItgQkOIID20VVc2ZtjVdfqPhOddLZWwQad4htnauy2ftOfjtOXa+cIIS+QpN
	bAIX7RtgWroCxpJ6fBvJnbYMtlhCUEDeFQXBJUY8/FvIVWX5D743vjJjmm+z9HsL
	oWeEeHsNw5nfyi32B8Rcm1iNZk5K/nIYP+Oy+pWQYrCpgZ34F16NAqP+MjA0iOat
	NL6Sfnb/SdRxhjZZFDU6v6u8/NAjGohJrBkFGolmSmIgND/9Bw6YC+AdD4Tah6+b
	B2DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285682; x=1702372082; bh=o+omBwsfZEekV
	bC9W2C9ko+HJ1hayNDHplnPVS05Bog=; b=epai8ouhCANSHqXI8Lq/KCQyu/6NZ
	78AXbpCKNGWRIbwTWhchH2QY8EiQ2Gbu/Q3IvVHh8bPxCOGtg8MzmLPQDYVnfPPK
	4j5zxJsUCKFD5bb2QsBQT4LKZk8PUlTfxip339GJRdZwzOytIYm8gaY8WpHFjR2U
	1cfGO81i1datqLMS6vJx/PS7i+Q6+sVB0+174Jx+mEALrPMvy7e5UZ8RluNzIrRA
	ZkPQUKimnQvO9Km8LFGPltIyu70toicKRiqBA2kw+WoWhiNqoOZQd33eYol6ufEF
	NmxEATVbnS1W7ZZChJFHo7gbdHx8t5t+fsVlT8lbmW5wMSr5v7mbtcpHQ==
X-ME-Sender: <xms:ctF2ZWuD5T7QPSp61XCxBsjPYoMobMBw2MaKrzYyUB9ADI6uimpOpQ>
    <xme:ctF2ZbcyZTTVy47C-BZ27ZyrT_NGA-1mD3oZxIxNZkOUjG9SMqDEyN7yg-qHKmqg1
    GqloT1NufT7nm8r1Q>
X-ME-Received: <xmr:ctF2ZRxau6RBnEVw0xPF-p4V6Jp_XwHh2bogwbK9Hm66fACCYlMIZ9tkSfCxudOR4WtvVj-jCKbPHbYyKakGivtRs7RyO21lN3-ut6JEmZK_lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeegvedtffehvdehheegueeuffefteeitdefheejheetveeiheekkeeifefhvdev
    heenucffohhmrghinhepuhhpuggrthgvrdhnvgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ctF2ZRPybRU8KYiSRDuwS34yYoWO51cmQksG3sgNbOroCjQBOxwK1A>
    <xmx:ctF2ZW_oFMdVMDcYRwMGUkuJtPLyft3tNj90qQl60H2bz-GVjxSQKA>
    <xmx:ctF2ZZVN9ZW1DPkvVLf7IZ7E4MWJuDfMeH2NW9qEGhCmCc7nMrRuUg>
    <xmx:ctF2Zdbw_1asdPyKQu-0DcMMhemsztWcTJiPgv9vXpyejgrYssMu1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:08:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da6ce7fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:06:24 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/11] reftable/stack: fix use of unseeded randomness
Message-ID: <5598460b8112e20d5f8a3889a482732d9475e6a7.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7EokB8Ex5Ah8epVp"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--7EokB8Ex5Ah8epVp
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
index 0c235724e2..16bab82063 100644
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


--7EokB8Ex5Ah8epVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20W4ACgkQVbJhu7ck
PpTNoA//Xs0GldhbcvTx/wUkC8GS6+pBpmFDfk6bbtoCtZki6ZrGl7ukLcILxD11
0/XGckQ52KDDb8i58wjtecJTcsJMPA1jJ+bJfC6+SpwwKm928uAPrjPnm/f+gMB6
kEbac4xhGCJkJdevb+xGMxiWOOf00rfdf0DiKBJ7hl1G6Ox0mSTj3YKeSJTnRqr+
g8T7y4vYS5LHg6r/TWt8fr0L7LCLPVzBiQqRewBJxqlmdK2SqCO3D1x3pFDQmadf
ppd2cBRiMjer3BeF9c0Nonla79nztPkuHEuWq+Ba+UnFlLAO0DmEJl6sG8jgfTns
Tue9JWNjqay3ccamfjyUtFYiEgWvTn7CQgRqvYmj3K+vODXRLeGMGZaeLrY6/tHH
vm9KBjnUzg3DyZI6kxsfJ0tTSIelJkBLhdBDztSgsfTcw/F3VJyo/BlR3pu4E7p+
uuHZB4xCrUbdMOupfi7kQQNEOdin42TxTckaBe9yVLdh8xO+pcTz4N9zf9dtIY+7
xWeHfJ2ugGOlpkDvlc7vk4K33bPe6e98J56xZP/lV7KS8RTV2pvPDBDSqaIOZmyr
HegY3FYOWlDrps+1tokI+6Bs4OwbYrssb3//2kUys8d4KCVdfQumvogBAwlVomk+
ZjEtYd2c5yPcL5lC7gUzpvKpju2AlfJo/nkigIrjO0JQUhssM2s=
=6IMu
-----END PGP SIGNATURE-----

--7EokB8Ex5Ah8epVp--
