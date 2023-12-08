Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8x4m//Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kWAPfDp6"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C64F49F9
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 06:53:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id DD9313200A1E;
	Fri,  8 Dec 2023 09:53:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 09:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702047180; x=1702133580; bh=Zz
	0iv8TEZagcxXQ9PtKJFySXBoGfoSd0GOGycMwMR04=; b=J8x4m//ZZ4WeXD9Lyx
	Yxo13WxJs8K5kGiwzHlleatPL3DxlySVxeOxF2OmCaUQ3pZBePylde5lsAUnjTEC
	Suw/9F0C57w1e7l9VRUWzYl/LpXiKDIOjV94/Gy/06gGB/B0i1Pfv7PlihT7ExMd
	uPIQowknges/wzsSNwGRme406Bu0mJqNbKAIxgzjvFQkVS7Y4A2O7A1bR7uXxAR8
	2G3VpZsoBTWveHiu8nffZCyWC/8HrsgWnEqK5ysvdSv4MlBpzXpNaGu1k/eYovI1
	BqfD+3YRrfGh3yP+l3+sE375fnTWzoVe+OXjQcT7IKCz11EODukgKuIm1+rPoVZ3
	SXXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702047180; x=1702133580; bh=Zz0iv8TEZagcx
	XQ9PtKJFySXBoGfoSd0GOGycMwMR04=; b=kWAPfDp6qL9sbRwP0ZHk+CcEIr+fh
	1tT3NKGMEYfIsbWpNjfPCn8M6y8VVvflxVg8UvK0xHX6NjQcsW3jCEUhKIJKCrz4
	besGhoffoXeSYwn3PNuBHcvxA5fUCab0zm6kK+AEVhlhlqjSfv5zmbNBCmCB/s6B
	T+rRueI2sgAEKRnF8+zQGZxzT5J5lMxhQrbExRk4QN9hWiDfxMa1BWcNgyiG98Y3
	CyJC0jb41mwdLJSr2Af377RcflwCnxDaN2HIEBmcwgYUP8NmdpVgMPQJqwsSU+cL
	4prpuxMG6wbak8KTf8GTq6EIcQNXVNNr5cdTBPK/vYTTscSRctJ72x3KQ==
X-ME-Sender: <xms:zC1zZVoOviJNqcJqlicaDlh4SfwG9SP_jO5MGxEaDyIS7NVnlAI3cg>
    <xme:zC1zZXoUvxq7ZOgkn1NnxM3-igQB-Ag002AVk2-6w1ATcY3lFXn8UeDNlBT-vNCvz
    5xp9fZ2u9O6xklexg>
X-ME-Received: <xmr:zC1zZSOsmbMhxL9rhLy5E79VoyPlFdmZ03nm8NQKwgeP6X3vkIQ9NxXxjaCN9HsZtBmjvv5Yoth6QlXMj0atJJ9BN9Avr4RRoTMZAOp9f7xiajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zC1zZQ4pPdhBrCSgF3hk1BfNMT74Yj1_aqS1pXTNQockJa0GApPmKQ>
    <xmx:zC1zZU7TGD7yB9cRqHREFKOX0zSUjMXcSk8GnXFZAg0u-5fOdFwpCQ>
    <xmx:zC1zZYioOK9qnhTvDemi9-_kpbegAWWdnBncT8rNAUdDssFtzB0NfQ>
    <xmx:zC1zZSQIv5hNHhHkJcMPPLby5RR7ipvcUAcnq5UjU20GAoosBBqz1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 09:52:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d60eb7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 14:51:28 +0000 (UTC)
Date: Fri, 8 Dec 2023 15:52:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 01/11] reftable: wrap EXPECT macros in do/while
Message-ID: <0ebbb02d32e1f1f483c21157fe076c0890665f69.1702047081.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B2hrub5rLcuPLfK4"
Content-Disposition: inline
In-Reply-To: <cover.1702047081.git.ps@pks.im>


--B2hrub5rLcuPLfK4
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


--B2hrub5rLcuPLfK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVzLcgACgkQVbJhu7ck
PpTMww/8C6sxIZaKEsr+/Uz5VFx4yn0l7etmN2LenmBqtuuegxspLXMZ4YrS+KAw
sb3yzZT2HkgxklZi3aPVy/d2pV4AMo6WiqJXlmNrzQLYbPIt1xbhE9R7dLK/pNZN
Rd9a9jZJvdZvB4EMtW37d4w9V1RvQVoEsiW7C9E2SOasCQkYbjElD82UmOLVhsRn
zXqEuC/qMVutfNmsAx+eDCQ8U1C90Q6NsbyTTSyiWosOUpf6TsUOyLdP7mtzY/HL
rBBSMMLYq6I087UBk4wy1HT+ZbagSgfu6ZWZ5dTNILDJcnRItvQRCfGPkVb0QDfd
CpQXsxPIpAunMgSHXqomHWPgTh7PALRPOsbmbdLnS49rVNmE1PdblUuTmWH0P+8b
iJjr892DrGfDHO1pbZgOM1d77NyS2z97JC2sjfLHXYlwDQeOHyzjkkbx1EL8PvXQ
JTt/FTMmgrIEBpGxmco/D8H8SfdWA1E3HGYSUWlqoVofl0GS3xTNH316Nsm5aJ/C
87qQ/AqopQyQ6RVwYNDf69+gih2EwoCuglhTiR+cYXwmjHdlzTYMn3UX2l0XTAWk
+0m9v3m/N1YWsgOTNVd672amFW90zmqhAVwCZCKNDF75cZpPD5Yw2xBILhtbHSzW
RLU0mByIiOAJvw88h/tSXtgxVR3nFK/OsIQizwU1TK9JDiYsEKg=
=BMr3
-----END PGP SIGNATURE-----

--B2hrub5rLcuPLfK4--
