Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RVqA1L5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNf6SHDY"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0AC3
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:34 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 997F13202629;
	Mon, 11 Dec 2023 04:07:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 04:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285653; x=1702372053; bh=MP
	Px12L6ZY4rNKw5Pnejundaqx57AtRza1Skh5nhY9M=; b=RVqA1L5epVoMOueHKq
	womMqcK4TjE/vDjlmQ+9duB3b8Zf97zzEKx5nQ5mqZI7wWkoBlVlrKdm7wMVaDtA
	BnKyTt9hz5cPJzPGKuvGlVGim7WIZfcplIU8/PyiI7ByMzJwNmjFEl5D8M5fXkji
	P7GjIgOLrXrYOkdwTq/8bMO3gP2WV1lkbEZEehPPEYY69Hhb5oHCQ+nzZ355Y/Ce
	AiagE/+gTjOuJ2YLxAlz9IYfiFElBSOOZctJqVM0W/pLyL9VgmEMWaCWy9AlG1uv
	eHe0Nk/Wp+ZXcGVYVo6s2wjGw5+d6UhMHTxEQfCKhc7IbRLD2/tT83H1FPTb8FqA
	mCeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285653; x=1702372053; bh=MPPx12L6ZY4rN
	Kw5Pnejundaqx57AtRza1Skh5nhY9M=; b=pNf6SHDYtO4DytvT3j8oz9Z9Z2DB9
	izYAGDI8KVxsvR7S71ERnyFGlJS7lGgtkbcCAZGkDdUcItvB2oltcUX6HSBu664e
	z9qkvCEvuukH4auziN73UNC/JIvr/+SM32qvVZAWWeRbBCwGOt+De9ZZbM0h3P9K
	LV7AdMH+I757VykvGZSnkWkYgghnaoHldeb+nu3wgWwiotyR+8NlYSlvl7vmhwKr
	PXkm+MBeMdR7tQrKHB3dvJjQC2aR0eLqKYWrZ69OH9qkdzoI6v1p/8CAEe3cspA9
	M0/4H5kab7UFISXz1tENb3twQ0CmZ2/5gWBO+oYOyk9PcZMz+px+pjpcQ==
X-ME-Sender: <xms:VNF2ZSLaZGrT9fg2-dch4_i4ag74qg5Ths8zNumw-lKAFNUZD6uDag>
    <xme:VNF2ZaKIOcS0LgfqXWNIkxO6gE3kvuM8pF-WFicLarcoAGlNz7tZiOGlKIGdAjEdr
    eL5ytumdZpuTttacA>
X-ME-Received: <xmr:VNF2ZSsR-aWd0EbfphuHgO6FdMlnfXd7YYFfaW25a4vq1WZ3tXvBerNAMe4nW-K3DQoW0zeyAfn1dtllAseXQD-IpepkIZhlMtnXx6v4P9UcGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:VNF2ZXZdANPmTmoW1Ywz5IadU3Tk8Q39teKjLFcdVwwYz25DVhxb2g>
    <xmx:VNF2ZZaTK-RHMXqXGVnoNCx4djsCRsspEIgkloNqyr1UCw5UJXMAtg>
    <xmx:VNF2ZTA3VfDJWAyu5MiWfqw5RNRb5ZNwtRiSgldksiReBILMx1MKrw>
    <xmx:VdF2ZdFS25fA5brL1VTi96XGT6uLRVtsUk1iG8JcpDCJ6gJwdP8tqA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e701bf95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:05:55 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/11] reftable: wrap EXPECT macros in do/while
Message-ID: <5b2a64ca9fa1d290b5b7838ad15c0894b65ae777.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702285387.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k9W//2jLMlKCchB7"
Content-Disposition: inline
In-Reply-To: <cover.1702285387.git.ps@pks.im>


--k9W//2jLMlKCchB7
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
2.43.0


--k9W//2jLMlKCchB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20VAACgkQVbJhu7ck
PpStAA//S8jbLoQ56jDcxyBZaCXqqX1LjBIGQAVJ8ptLGd7thPOikiFR5RYXifsm
xSs+UxqEhDhFu/og45o3AkTKmRn4M5EFKlRmfeFyf/BVKBRneiUXKTtFBenq7Pbl
ID+h0vEn32flZYVYbMqe7IDME7zAJHOqZAsUKZII8rgoFMTCZQjkYRUcqwnaLQTt
2yn0ooQjLvmtQo/GnvgQUTa1TR2+EmCJsz7XN18QCSsiBGvx5Nei4xN/yqf36HaV
cmYB5Sgc2YPSe7wPGrsu1uQ8EMZSLVV9SJm0yQvrcHRjBzlKMFhvEvMPmq8bj+Nd
NXV99vmEESw2Ofz+dP2ezx45u3JoXqFsbOa8PBx+7z8XNcvqlDaysqrd4P6RpJfn
W+FRKu/HfVXguXagoN03pIhvfpuw5H2F1q2RKJNsKfwQgZBPD+70HGNO17gPaVoq
efrDBYkVV/QFBhHuKuSZn0xy8HudiC/C3H84wW3Xw97kw24Ej9epzwFg0yWKeva3
KeJ9moIgn6uhq/8hJaix7d8sEEZzR0tbXtH53M8isJYBKJ5ZNoN9WO0iNDW1GVkQ
0RJcjZj69ZmNqIoIT0ji6ZsqdE1ORlspms09RFS2dIh9bUx6QjzVgevQElp+1Y+g
i/YyFPF+e9qSefSEzewq1au2yJ2xmAiFtMV9MBZriaXyIciSfew=
=DNpj
-----END PGP SIGNATURE-----

--k9W//2jLMlKCchB7--
