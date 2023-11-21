Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Euh9Tezp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M39H+IVM"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF9100
	for <git@vger.kernel.org>; Mon, 20 Nov 2023 23:04:14 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id E35185C14C5;
	Tue, 21 Nov 2023 02:04:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 21 Nov 2023 02:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700550252; x=1700636652; bh=w+
	BVaHKSDw9Qpi+DFwkruhGex3t4z5YjavfLYPsyIWU=; b=Euh9TezpzM3ZV5B04h
	PO7ey5Ti4ClWRiF9aS6wQ+EH6i9Ra7Q6AbC0Bsnuc4fNsIwEvUoAJ/v7hSLVzkKX
	iDuibe6EAthorI4oYMpvbgLlw3QyO5J1X6hmbHYlLc5sq7ILoKZdBXLIbaDU09S3
	T9QnhDVsKRA1i5jpKb8NYD0WhmN92X0Rm0KaXfDY2wg6ajuC8rr7D/Xa45YLOIN8
	pBKAucad6EOi6+32/zjukxe5fdYtWdW8BVivr0GUmgKB0gSslCYa0vHl9/pYOR9U
	LkqZ6qkZ2KqrpojSJamhXinuKJ00SjN5MS+O0kZS9YCvqq28/BUog8bNRf8hH/k6
	jALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700550252; x=1700636652; bh=w+BVaHKSDw9Qp
	i+DFwkruhGex3t4z5YjavfLYPsyIWU=; b=M39H+IVMZIMa4LuEsECetn2sqTx7S
	P5t6EPD6BAXzzgrt/3yvtHeUVONw7ufHOQoOxiUt0omUkSLlH0kUneM5yir4fjk5
	g3Igcu2ZtNk+c1sccsFKRqrAUmUELXDiBU2hl+wIYqWbdmCG6fL5vSiR4exXpNQU
	BQjsOlLJOoq4g5BhkL6ZV2NPcECwYXKtYXIruaYVCZVgviGqwgdDEaVyA5eCjLNw
	bQkb2PhMt2vk9zAvLQ2mUTeUHVJN3Zh8SVpNhaRhY/5sCIlYN//BYIxGD74eeIwx
	y6DOiYlq0lR+4ubxlFbSoLMwAfbjO812AZFkfTvE1MvADuhEjNoSId6Gw==
X-ME-Sender: <xms:bFZcZekterGRBbuscCvlHEAfaIRmIN00ELXyHqguq5j1UI6Nfg1fNA>
    <xme:bFZcZV3-Bv8y5PSsEfcGiirGWWg-I74n2LzdZxMK5KzLacrJ4o0jj3FzyiteaeuGd
    0AGWIwfZvloBQ6oAw>
X-ME-Received: <xmr:bFZcZcoznvkQeViffXPii-GJe_89fTnenBofNCNN8jxU34P1Sc0vzCnE6ZQQv5rv980N3R97xc-b7b623WpnK1SI4YsTIjv2v-0yKyQZSwmv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:bFZcZSn1_pkqHVW4zDTmeIQA1Ua0Dz3z9Ai_UwrSqGpNmxpqoGVyjA>
    <xmx:bFZcZc384G3XOqBWTCMMjqIQGFl-DZTrDDmN6sClRUHtmn6LhWGE2Q>
    <xmx:bFZcZZttzj8ILXS8KAtY4PtbidTixtITl1suJ31hPFVjphQugHkXvQ>
    <xmx:bFZcZZ8cZjW0Q77ILQecc0FejOfMUXep-Ftxn9zu_CroE2znk6Z-BQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 02:04:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c49690e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Nov 2023 07:03:19 +0000 (UTC)
Date: Tue, 21 Nov 2023 08:04:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] reftable: wrap EXPECT macros in do/while
Message-ID: <89a953135573d028ba7769953f50bf3f43e57d9c.1700549493.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="laiGi7xW+0TnqIhl"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--laiGi7xW+0TnqIhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `EXPECT` macros used by the reftable test framework are all using a
single `if` statement with the actual condition. This results in weird
syntax when using them in if/else statements like the following:

```
if (foo)
	EXPECT(foo =3D=3D 2)
else
	EXPECT(bar =3D=3D 2)
```

Note that there need not be a trailing semicolon. Furthermore, it is not
immediately obvious whether the else now belongs to the `if (foo)` or
whether it belongs to the expanded `if (foo =3D=3D 2)` from the macro.

Fix this by wrapping the macros in a do/while loop.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/test_framework.h | 58 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/reftable/test_framework.h b/reftable/test_framework.h
index 774cb275bf..ee44f735ae 100644
--- a/reftable/test_framework.h
+++ b/reftable/test_framework.h
@@ -12,32 +12,38 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-error.h"
=20
-#define EXPECT_ERR(c)                                                  \
-	if (c !=3D 0) {                                                  \
-		fflush(stderr);                                        \
-		fflush(stdout);                                        \
-		fprintf(stderr, "%s: %d: error =3D=3D %d (%s), want 0\n",  \
-			__FILE__, __LINE__, c, reftable_error_str(c)); \
-		abort();                                               \
-	}
-
-#define EXPECT_STREQ(a, b)                                               \
-	if (strcmp(a, b)) {                                              \
-		fflush(stderr);                                          \
-		fflush(stdout);                                          \
-		fprintf(stderr, "%s:%d: %s (%s) !=3D %s (%s)\n", __FILE__, \
-			__LINE__, #a, a, #b, b);                         \
-		abort();                                                 \
-	}
-
-#define EXPECT(c)                                                         =
 \
-	if (!(c)) {                                                        \
-		fflush(stderr);                                            \
-		fflush(stdout);                                            \
-		fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
-			__LINE__, #c);                                     \
-		abort();                                                   \
-	}
+#define EXPECT_ERR(c)                                                     =
     \
+	do {                                                                   \
+		if (c !=3D 0) {                                                  \
+			fflush(stderr);                                        \
+			fflush(stdout);                                        \
+			fprintf(stderr, "%s: %d: error =3D=3D %d (%s), want 0\n",  \
+				__FILE__, __LINE__, c, reftable_error_str(c)); \
+			abort();                                               \
+		}                                                              \
+	} while (0)
+
+#define EXPECT_STREQ(a, b)                                                =
       \
+	do {                                                                     \
+		if (strcmp(a, b)) {                                              \
+			fflush(stderr);                                          \
+			fflush(stdout);                                          \
+			fprintf(stderr, "%s:%d: %s (%s) !=3D %s (%s)\n", __FILE__, \
+				__LINE__, #a, a, #b, b);                         \
+			abort();                                                 \
+		}                                                                \
+	} while (0)
+
+#define EXPECT(c)                                                         =
         \
+	do {                                                                     =
  \
+		if (!(c)) {                                                        \
+			fflush(stderr);                                            \
+			fflush(stdout);                                            \
+			fprintf(stderr, "%s: %d: failed assertion %s\n", __FILE__, \
+				__LINE__, #c);                                     \
+			abort();                                                   \
+		}                                                                  \
+	} while (0)
=20
 #define RUN_TEST(f)                          \
 	fprintf(stderr, "running %s\n", #f); \
--=20
2.42.0


--laiGi7xW+0TnqIhl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVcVmkACgkQVbJhu7ck
PpTT7g//aa70puDt/4ztvlamTNUkmABApwTI+6/FO0CC09HI4qhyA5DOa4XBPe70
vqc8MnD5NS+c5XjCL1bwC/RdcSmUznHfJIOUyXi5EQG0JKeySDEWVqG5T+JzHuVY
drnq7auS8iwLYgVeARvFqcpDvyHu1e2vmCmwmPxt1tmaLlTh0H3H6wkX1xaC17Gp
5GlE22UdanXsUu+d5+HhxxWPGRm0kSGElDm4IJu//CWNwunK+nsycyPvgruDsEea
ceBegCP6vIF43f1YoL9vPTuhJ+tc8qlPZdF6esMh/e2Lu7Nu8XBAhvAIBc/vk36m
aWY7+re6M2vyxB3fryk+zjlRdPf+nHJH2LUYjtkrIUoAIhPnVfWKHxxqdxhRrfRE
HjMpGZxrWSJsupwjQ9oXkZ0SHmQ+hkhsaGBvf8c7VTcjUORfEcC8d+SV3U44v5Ac
2klmp9TzGuwgVTq4OU4rDR2kcKtEFgWYVIKY17icgGvvpWNsJPrto+2vV6s7qF37
N/+PwbcvjhP8ArSi+ELh5O7pl+dEd9K2lUE/kbTMuXsDGXAPps+Htt285RJGTRUc
sHCKPIyVYW7jIvDrmIQF/q8MrL5dMkAh5gBQFuonJ4WARnCT+XchV4JIi/CwFm26
3kXB/57LsFu/r1SMHl4rbiz89kWwFHxpL4oUuFKnt1nkj1uQx70=
=UJu3
-----END PGP SIGNATURE-----

--laiGi7xW+0TnqIhl--
