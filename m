Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26A411FB2
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375487; cv=none; b=V8nWWSK33sq6hTRRPqKoM1xbpEjMPoyv38kGcN5pmqdX3h5mny457sAZvLbnpRmHgrePR1kznRIS1U6OZ0Jf/i4A9DF2D0vCPyS1UnbKlASuzw4UZlEVIDU0VrNUe6h6e8x4krV8yxwDY6beaxkYUdH9WLWSITefLb1oMaLKLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375487; c=relaxed/simple;
	bh=XGwXTKM94/S3dO04f2Da3DKmP7iwxuV9JsEKI3Wc2hs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cqk1HJVQ8fBRtopDfe9NbQO2Pg+BFYbn1WO055Ghvbayj93dHB2D1voeOEeOJPmBbp9aZweNXpHlIPBHtoW0IF9muI/NogNQdTNwvR04tiD062nzprQxqPBvLsnmx2sTk1KQJghekkanD+S1Mcf3/oslpAON++Zw6MsOd/dgco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MBNKSBHp; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MBNKSBHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791375469; x=1791980269;
	i=johannes.schindelin@gmx.de;
	bh=XxkIIFlW9j7SrFnWu1L3euvI/zK+I40RTuX7Vry0+7k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MBNKSBHp8zwh4yzKP2IYigvxVzDqNbKIDMhg3FTa/OPq2PUNyWVIGErlqXpmukNP
	 0ryr0HUFCaWsxqOWL8CfiqSNHJIW4AVV9ihYPI1dYFy5QguyVEoMXuUjFK+OoBgVN
	 nBCpRbwXm5IdJMxTgAYOyYz4YDL6mO4DR1cOQll/JBcC9GvXNix4VyN10hc6j2BKX
	 NqGlHbX/kz5f/6pnzxR83o6RwTIyfwEfUHJd4xv+6PpLkO4U2Of4Jb+uhTdi8qGCf
	 xSyOVIvnsnyth74U6Y6qIuUGlD3mqCNr4pn993GI1A1XgHITYMugd1yW1l1ycdzHn
	 lO1DAoh1K2nfCh5I4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1xAJy81muf-00PYxf; Wed, 07
 Oct 2026 14:17:49 +0200
Date: Wed, 7 Oct 2026 14:17:48 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <scott@gitbutler.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
In-Reply-To: <20260929112544.86511-1-scott@gitbutler.net>
Message-ID: <76b7e19d-c9f9-0a0a-6154-a797b64cf9b0@gmx.de>
References: <20260929112544.86511-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY=8323328132921224917913077121288
Content-ID: <908f9295-5c8b-a9eb-4767-267e53447911@gitforwindows.org>
X-Provags-ID: V03:K1:yRonhf9qFIns0OVGUEpl0S0E+2WFJlGfvafphvge3hgzrpIjqSZ
 FmgvUSsJHDN2Cc2lexDAuu5F1TjcDaT/mZD2KgBFCnI+dBU61Y0JEN5zmiuTf+JqYi6GCHJ
 Pha3G5mP0CHGj55B1BYdH8DJkz6qI82Ezbxvox56Erc8yf9KL9bq14GDjLZ7uDeBtT9sHUR
 +gVYS+44s8pmq0qRWwjKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SdgaGrFyucI=;eNmyQd6C2lnAbFKvYlLBRqqtnxQ
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328132921224917913077121288
Content-Type: text/plain; CHARSET=utf-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <22433413-9e2d-0815-68fa-3db4395474c9@gitforwindows.org>

Hi Scott,

On Tue, 29 Sep 2026, Scott Chacon wrote:

> So, spoiler alert, the code in this patch series is mainly AI generated.
> I would try to fool you, but too many of you are far too aware of my
> actual C skills. That being said, I thought maybe someone here (especial=
ly
> those of you working on server optimization stuff) would be interested
> in the speed increases for both the server and client in making sha1dc
> quite a bit faster.

Hah, I beat you by almost a full day with my "competing" series at
https://lore.kernel.org/git/pull.2240.git.1790610691.gitgitgadget@gmail.co=
m/.
I put the "competing" in double quotes because I think that both patch
series have merit, and I would love to see both merged.

Performance-wise, in my tests the Rust `sha1dc` was a tad faster that this
C-accell code on my Ryzen, something like 3.3% for my favorite
`index-pack` benchmark with 30 randomized pairings. Naturally, I tried to
figure out where that difference comes from, but I haven't been able to
finish that analysis to my satisfaction, although I would like to offer
this patch to avoid reordering the message schedule, which closes the gap
from 3.3% to 1%:

=2D- snip --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 4 Oct 2026 12:53:56 +0200
Subject: [PATCH] sha1dc-accel: bring SHA-NI performance closer to Rust

The C SHA-NI path spends instructions reordering the message schedule,
while Rust uses a mirrored schedule. Avoid that overhead without changing
the collision checks.

Across 30 randomized, AC-powered triplets on the same pack, C's mean
fell from 8.201s to 8.053s. The paired mean improvement was 0.147s
(95% CI: 0.083-0.211s), leaving C about 1% behind Rust.

Assisted-by: GPT-6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 sha1dc-accel/internal.h  |  7 +++-
 sha1dc-accel/sha1.c      | 22 +++++++++--
 sha1dc-accel/ubc_check.c | 82 ++++++++++++++++++++++++++++++----------
 sha1dc-accel/x86.c       |  4 +-
 t/unit-tests/u-sha1dc.c  | 34 +++++++++++++----
 5 files changed, 112 insertions(+), 37 deletions(-)

diff --git a/sha1dc-accel/internal.h b/sha1dc-accel/internal.h
index a50b294b96b..bcb60811a8f 100644
=2D-- a/sha1dc-accel/internal.h
+++ b/sha1dc-accel/internal.h
@@ -4,8 +4,9 @@
 /*
  * Shared between the files of sha1dc-accel/. See sha1.c for an overview.
  *
- * The schedule `w` is always the 80 expanded message words in step order=
,
- * w[t] at index t, which is also what sha1dc/ keeps in SHA1_CTX.m1.
+ * The schedule `w` has 80 expanded message words. Normally w[t] is at
+ * index t, as in sha1dc/. SHA-NI spills w[t] at index 79 - t; a candidat=
e
+ * is put back in step order before recompression.
  *
  * A "state" is the five working words [a, b, c, d, e] before a step.
  */
@@ -75,9 +76,11 @@ enum sha1dc_from {
 uint32_t sha1dc_ubc_check_scalar(const uint32_t w[80]);
 #ifdef SHA1DC_HAVE_SSE2
 uint32_t sha1dc_ubc_check_sse2(const uint32_t w[80]);
+uint32_t sha1dc_ubc_check_sse2_mirrored(const uint32_t w[80]);
 #endif
 #ifdef SHA1DC_HAVE_AVX2
 uint32_t sha1dc_ubc_check_avx2(const uint32_t w[80]);
+uint32_t sha1dc_ubc_check_avx2_mirrored(const uint32_t w[80]);
 #endif
 #ifdef SHA1DC_HAVE_NEON
 uint32_t sha1dc_ubc_check_neon(const uint32_t w[80]);
diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
index 1f1133169b5..bddc3bcdf2d 100644
=2D-- a/sha1dc-accel/sha1.c
+++ b/sha1dc-accel/sha1.c
@@ -259,9 +259,11 @@ static int shani_avx2_available(void)
 /* In order of preference. */
 static const struct backend backends[] =3D {
 #ifdef SHA1DC_HAVE_SHANI
-	{ "shani+avx2", sha1dc_compress_shani, 1, sha1dc_ubc_check_avx2,
+	{ "shani+avx2", sha1dc_compress_shani, 1,
+	  sha1dc_ubc_check_avx2_mirrored,
 	  sha1dc_recompress_shani, shani_avx2_available },
-	{ "shani+sse2", sha1dc_compress_shani, 1, sha1dc_ubc_check_sse2,
+	{ "shani+sse2", sha1dc_compress_shani, 1,
+	  sha1dc_ubc_check_sse2_mirrored,
 	  sha1dc_recompress_shani, sha1dc_shani_available },
 #endif
 #ifdef SHA1DC_HAVE_ARMV8
@@ -432,8 +434,20 @@ static inline void process(const struct backend *be, =
SHA1_CTX *ctx,
 		return;
=20
 	candidates =3D ctx->ubc_check ? be->ubc_check(w) : 0xFFFFFFFF;
-	if (candidates &&
-	    attacked(be, ctx, candidates, w, s1, s2, ihv_in, ctx->ihv)) {
+	if (!candidates)
+		return;
+#ifdef SHA1DC_HAVE_SHANI
+	if (be->compress =3D=3D sha1dc_compress_shani) {
+		int i;
+
+		for (i =3D 0; i < 40; i++) {
+			uint32_t tmp =3D w[i];
+			w[i] =3D w[79 - i];
+			w[79 - i] =3D tmp;
+		}
+	}
+#endif
+	if (attacked(be, ctx, candidates, w, s1, s2, ihv_in, ctx->ihv)) {
 		ctx->found_collision =3D 1;
 		/*
 		 * Two more compressions of this block give a digest that the
diff --git a/sha1dc-accel/ubc_check.c b/sha1dc-accel/ubc_check.c
index f95b799f9d4..cbd21d33e68 100644
=2D-- a/sha1dc-accel/ubc_check.c
+++ b/sha1dc-accel/ubc_check.c
@@ -105,9 +105,13 @@ struct ubc_cond {
 	uint8_t i, a, j, b, c;
 };
=20
-static inline uint32_t cond_fails(const uint32_t *w, const struct ubc_con=
d *c)
+static inline uint32_t cond_fails(const uint32_t *w, const struct ubc_con=
d *c,
+				  int mirrored)
 {
-	return (((w[c->i] >> c->a) ^ (w[c->j] >> c->b) ^ c->c) & 1);
+	unsigned i =3D mirrored ? 79 - c->i : c->i;
+	unsigned j =3D mirrored ? 79 - c->j : c->j;
+
+	return (((w[i] >> c->a) ^ (w[j] >> c->b) ^ c->c) & 1);
 }
=20
 /* A condition of the scalar prefix, and the DVs it rules out if it fails=
. */
@@ -149,7 +153,7 @@ struct tail_span {
  */
 static inline uint32_t run_tail(const uint32_t *w, uint32_t mask,
 				const struct ubc_cond *checks,
-				const struct tail_span *spans)
+				const struct tail_span *spans, int mirrored)
 {
 	uint32_t out =3D mask;
 	while (mask) {
@@ -160,7 +164,7 @@ static inline uint32_t run_tail(const uint32_t *w, uin=
t32_t mask,
=20
 		NO_VECTORIZE
 		for (; c < end; c++)
-			fail |=3D cond_fails(w, c);
+			fail |=3D cond_fails(w, c, mirrored);
 		out &=3D ~(fail << d);
 		mask &=3D mask - 1;
 	}
@@ -569,7 +573,7 @@ static uint32_t scalar_prefix(const uint32_t *w)
 	UNROLL_TABLE
 	for (i =3D 0; i < ARRAY_SIZE(scalar_prefix_conds); i++) {
 		const struct ubc_prefix_cond *p =3D &scalar_prefix_conds[i];
-		mask &=3D ~(p->dvs & (0 - cond_fails(w, &p->cond)));
+		mask &=3D ~(p->dvs & (0 - cond_fails(w, &p->cond, 0)));
 	}
 	return mask;
 }
@@ -580,7 +584,7 @@ uint32_t sha1dc_ubc_check_scalar(const uint32_t w[80])
 	/* Every check only clears bits, so an empty mask settles it. */
 	if (!mask)
 		return 0;
-	return run_tail(w, mask, scalar_tail_checks, scalar_tail_spans);
+	return run_tail(w, mask, scalar_tail_checks, scalar_tail_spans, 0);
 }
=20
 /* neon form */
@@ -980,7 +984,7 @@ uint32_t sha1dc_ubc_check_neon(const uint32_t w[80])
 	/* Every check only clears bits, so an empty mask settles it. */
 	if (!mask)
 		return 0;
-	return run_tail(w, mask, neon_tail_checks, neon_tail_spans);
+	return run_tail(w, mask, neon_tail_checks, neon_tail_spans, 0);
 }
=20
 #endif /* SHA1DC_HAVE_NEON */
@@ -1343,7 +1347,7 @@ static const struct tail_span sse2_tail_spans[32] =
=3D {
 };
=20
 SHA1DC_TARGET_SSE2
-static uint32_t sse2_prefix(const uint32_t *w)
+static inline uint32_t sse2_prefix(const uint32_t *w, int mirrored)
 {
 	const __m128i zero =3D _mm_setzero_si128();
 	__m128i acc =3D zero;
@@ -1352,10 +1356,18 @@ static uint32_t sse2_prefix(const uint32_t *w)
 	UNROLL_TABLE
 	for (i =3D 0; i < ARRAY_SIZE(sse2_groups); i++) {
 		const struct ubc_group4 *g =3D &sse2_groups[i];
-		__m128i lo =3D _mm_loadu_si128((const __m128i *)(w + g->lo));
-		__m128i hi =3D _mm_loadu_si128((const __m128i *)(w + g->hi));
-		__m128i test =3D _mm_loadu_si128((const __m128i *)g->test);
-		__m128i dvs =3D _mm_loadu_si128((const __m128i *)g->dvs);
+		const uint32_t *lo_w =3D w + (mirrored ? 76 - g->lo : g->lo);
+		const uint32_t *hi_w =3D w + (mirrored ? 76 - g->hi : g->hi);
+		__m128i lo =3D _mm_loadu_si128((const __m128i *)lo_w);
+		__m128i hi =3D _mm_loadu_si128((const __m128i *)hi_w);
+		__m128i test =3D mirrored ?
+			_mm_set_epi32(g->test[0], g->test[1],
+				      g->test[2], g->test[3]) :
+			_mm_loadu_si128((const __m128i *)g->test);
+		__m128i dvs =3D mirrored ?
+			_mm_set_epi32(g->dvs[0], g->dvs[1],
+				      g->dvs[2], g->dvs[3]) :
+			_mm_loadu_si128((const __m128i *)g->dvs);
 		__m128i clear, fail;
=20
 		lo =3D _mm_srl_epi32(lo, _mm_cvtsi32_si128(g->lo_shift));
@@ -1376,11 +1388,20 @@ static uint32_t sse2_prefix(const uint32_t *w)
 SHA1DC_TARGET_SSE2
 uint32_t sha1dc_ubc_check_sse2(const uint32_t w[80])
 {
-	uint32_t mask =3D sse2_prefix(w);
+	uint32_t mask =3D sse2_prefix(w, 0);
 	/* Every check only clears bits, so an empty mask settles it. */
 	if (!mask)
 		return 0;
-	return run_tail(w, mask, sse2_tail_checks, sse2_tail_spans);
+	return run_tail(w, mask, sse2_tail_checks, sse2_tail_spans, 0);
+}
+
+SHA1DC_TARGET_SSE2
+uint32_t sha1dc_ubc_check_sse2_mirrored(const uint32_t w[80])
+{
+	uint32_t mask =3D sse2_prefix(w, 1);
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, sse2_tail_checks, sse2_tail_spans, 1);
 }
=20
 #endif /* SHA1DC_HAVE_SSE2 */
@@ -1743,7 +1764,7 @@ static const struct tail_span avx2_tail_spans[32] =
=3D {
 };
=20
 SHA1DC_TARGET_AVX2
-static uint32_t avx2_prefix(const uint32_t *w)
+static inline uint32_t avx2_prefix(const uint32_t *w, int mirrored)
 {
 	const __m256i zero =3D _mm256_setzero_si256();
 	__m256i acc =3D zero;
@@ -1753,10 +1774,20 @@ static uint32_t avx2_prefix(const uint32_t *w)
 	UNROLL_TABLE
 	for (i =3D 0; i < ARRAY_SIZE(avx2_groups); i++) {
 		const struct ubc_group8 *g =3D &avx2_groups[i];
-		__m256i lo =3D _mm256_loadu_si256((const __m256i *)(w + g->lo));
-		__m256i hi =3D _mm256_loadu_si256((const __m256i *)(w + g->hi));
-		__m256i test =3D _mm256_loadu_si256((const __m256i *)g->test);
-		__m256i dvs =3D _mm256_loadu_si256((const __m256i *)g->dvs);
+		const uint32_t *lo_w =3D w + (mirrored ? 72 - g->lo : g->lo);
+		const uint32_t *hi_w =3D w + (mirrored ? 72 - g->hi : g->hi);
+		__m256i lo =3D _mm256_loadu_si256((const __m256i *)lo_w);
+		__m256i hi =3D _mm256_loadu_si256((const __m256i *)hi_w);
+		__m256i test =3D mirrored ?
+			_mm256_set_epi32(g->test[0], g->test[1], g->test[2],
+					 g->test[3], g->test[4], g->test[5],
+					 g->test[6], g->test[7]) :
+			_mm256_loadu_si256((const __m256i *)g->test);
+		__m256i dvs =3D mirrored ?
+			_mm256_set_epi32(g->dvs[0], g->dvs[1], g->dvs[2],
+					 g->dvs[3], g->dvs[4], g->dvs[5],
+					 g->dvs[6], g->dvs[7]) :
+			_mm256_loadu_si256((const __m256i *)g->dvs);
 		__m256i clear, fail;
=20
 		lo =3D _mm256_srl_epi32(lo, _mm_cvtsi32_si128(g->lo_shift));
@@ -1779,11 +1810,20 @@ static uint32_t avx2_prefix(const uint32_t *w)
 SHA1DC_TARGET_AVX2
 uint32_t sha1dc_ubc_check_avx2(const uint32_t w[80])
 {
-	uint32_t mask =3D avx2_prefix(w);
+	uint32_t mask =3D avx2_prefix(w, 0);
 	/* Every check only clears bits, so an empty mask settles it. */
 	if (!mask)
 		return 0;
-	return run_tail(w, mask, avx2_tail_checks, avx2_tail_spans);
+	return run_tail(w, mask, avx2_tail_checks, avx2_tail_spans, 0);
+}
+
+SHA1DC_TARGET_AVX2
+uint32_t sha1dc_ubc_check_avx2_mirrored(const uint32_t w[80])
+{
+	uint32_t mask =3D avx2_prefix(w, 1);
+	if (!mask)
+		return 0;
+	return run_tail(w, mask, avx2_tail_checks, avx2_tail_spans, 1);
 }
=20
 #endif /* SHA1DC_HAVE_AVX2 */
diff --git a/sha1dc-accel/x86.c b/sha1dc-accel/x86.c
index c2a0c71f17f..dfdc1fc3b62 100644
=2D-- a/sha1dc-accel/x86.c
+++ b/sha1dc-accel/x86.c
@@ -66,8 +66,8 @@ int sha1dc_shani_available(void)
 #define LOADU(p) _mm_loadu_si128((const __m128i *)(const void *)(p))
 #define STOREU(p, v) _mm_storeu_si128((__m128i *)(void *)(p), (v))
=20
-/* Writes group `v` (steps t..t+3, held reversed) to w[t..t+3]. */
-#define SPILL(t, v) STOREU(w + (t), _mm_shuffle_epi32((v), REVERSE))
+/* The group is already reversed; store it in the mirrored schedule. */
+#define SPILL(t, v) STOREU(w + 76 - (t), (v))
=20
 /* Schedule words 4k..4k+3 for k from 8 on, from groups k-8, k-7, k-4, k-=
2, k-1. */
 SHA1DC_TARGET_SHANI
diff --git a/t/unit-tests/u-sha1dc.c b/t/unit-tests/u-sha1dc.c
index f629f59d1d6..c658c219a3a 100644
=2D-- a/t/unit-tests/u-sha1dc.c
+++ b/t/unit-tests/u-sha1dc.c
@@ -151,6 +151,21 @@ static void check_ubc_forms(uint32_t w[80], int flip,=
 int avx2)
 		check_form(sha1dc_ubc_check_scalar(w), want);
 #ifdef SHA1DC_HAVE_SSE2
 		check_form(sha1dc_ubc_check_sse2(w), want);
+		{
+			uint32_t mirrored[80];
+			int t;
+
+			for (t =3D 0; t < 80; t++)
+				mirrored[t] =3D w[79 - t];
+			check_form(sha1dc_ubc_check_sse2_mirrored(mirrored),
+				   want);
+#ifdef SHA1DC_HAVE_AVX2
+			if (avx2)
+				check_form(
+					sha1dc_ubc_check_avx2_mirrored(
+						mirrored), want);
+#endif
+		}
 #endif
 #ifdef SHA1DC_HAVE_AVX2
 		if (avx2)
@@ -243,14 +258,15 @@ typedef int (*recompress_fn)(enum sha1dc_from from, =
const uint32_t m1[80],
 			     const uint32_t dm[80], const uint32_t state[5],
 			     const uint32_t ihv_out[5]);
=20
-static void check_compress(compress_fn compress)
+static void check_compress(compress_fn compress, int mirrored)
 {
 	int i, t;
=20
 	rng_seed(3);
 	for (i =3D 0; i < 2000; i++) {
 		unsigned char block[64];
-		uint32_t ihv[5], got[5], w[80], at_60[5], at_64[5], s[5];
+		uint32_t ihv[5], got[5], w[80], expected[80];
+		uint32_t at_60[5], at_64[5], s[5];
=20
 		for (t =3D 0; t < 64; t++)
 			block[t] =3D rng();
@@ -260,14 +276,16 @@ static void check_compress(compress_fn compress)
=20
 		memcpy(s, ihv, sizeof(s));
 		for (t =3D 0; t < 80; t++) {
-			uint32_t want_w =3D t < 16 ? get_be32(block + 4 * t) :
-				rol(w[t - 3] ^ w[t - 8] ^ w[t - 14] ^ w[t - 16], 1);
-			cl_assert_equal_i(w[t], want_w);
+			expected[t] =3D t < 16 ? get_be32(block + 4 * t) :
+				rol(expected[t - 3] ^ expected[t - 8] ^
+				    expected[t - 14] ^ expected[t - 16], 1);
+			cl_assert_equal_i(w[mirrored ? 79 - t : t],
+					  expected[t]);
 			if (t =3D=3D 60)
 				cl_assert(!memcmp(at_60, s, sizeof(s)));
 			if (t =3D=3D 64)
 				cl_assert(!memcmp(at_64, s, sizeof(s)));
-			step(s, t, w[t]);
+			step(s, t, expected[t]);
 		}
 		for (t =3D 0; t < 5; t++)
 			cl_assert_equal_i(got[t], ihv[t] + s[t]);
@@ -321,14 +339,14 @@ static void hardware_compression(void)
=20
 #ifdef SHA1DC_HAVE_SHANI
 	if (sha1dc_shani_available()) {
-		check_compress(sha1dc_compress_shani);
+		check_compress(sha1dc_compress_shani, 1);
 		check_recompress(sha1dc_recompress_shani);
 		tested =3D 1;
 	}
 #endif
 #ifdef SHA1DC_HAVE_ARMV8
 	if (sha1dc_armv8_available()) {
-		check_compress(sha1dc_compress_armv8);
+		check_compress(sha1dc_compress_armv8, 0);
 		check_recompress(sha1dc_recompress_armv8);
 		tested =3D 1;
 	}
=2D- snap --

This is admittedly a bit gnarly, and really, really hard to understand
unless you immersed yourself in Sam's work. But it _does_ accelerate SHA-1
computation with my Ryzen 7, and I'd be interested to hear whether it has
an equivalent effect with your Xeon.

> This series ports the approach of Sam Reis's sha1dc Rust crate [1],=20
> which gitoxide recently switched to [2], to C.=20
>=20
> The end result hashes roughly 2.7x faster on the Xeon and 2.85x faster
> on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s to
> 12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.
>=20
> Hashing throughput on the Xeon, in MiB/s:
>=20
>                                 16KiB    1MiB   vs OpenSSL
>   OpenSSL SHA-1 (no detection)   1234    1129      1.00x
>   sha1dc/ (today)                 435     450      2.67x
>   shani+avx2 (default here)      1002     901      1.24x
>   shani+sse2                     1075    1008      1.13x
>   portable+avx2                   553     654      1.96x
>   portable+sse2                   603     681      1.84x
>   portable                        466     565      2.29x
>=20
> In other words, currently collision detection costs about 1.5=E2=80=932.=
5x on
> top of the hashing itself today, but only about 0.2x with the series.=20
>=20
> The patches are:
>=20
>   [1/4]: sha1dc-accel: add a block loop for sha1dc's SHA1_CTX
>=20
>     Just groundwork: our own block loop around sha1dc's context and DV
>     table, with the same results and a few percent slower, plus tests
>     that compare against sha1dc/ directly, including on real collisions
>     in every mode.
>=20
>   [2/4]: sha1dc-accel: vectorize the unavoidable-bitconditions check
>=20
>     The UBC filter rewritten as SSE2, AVX2, NEON, and new scalar forms,=
=20
>     using the conditions the crate's solver picks for each. They're=20
>     carried as tables, with a short loop per form to run them.=20
>     1.29x on the Xeon, 1.27x on the M5 Max.
>=20
>   [3/4]: sha1dc-accel: compress with SHA-NI on x86-64
>=20
>     Hardware compression, with the schedule spilled, and recompression
>     of flagged blocks in hardware, too. Another 2.07x on the Xeon.
>=20
>   [4/4]: sha1dc-accel: compress with the ARMv8 SHA-1 instructions
>=20
>     The same for arm64. Another 2.4x on the M5 Max.

I really like this structure.

BTW I have run the entire test suite both on a Ryzen 7 (using WSL) and on
a Windows/ARM64 Cloud PC (using straight Windows because that Cloud PC
does not support WSL), with a slightly patched version: running the
original (slow) sha1dc, the sha1dc-accel and the Rust sha1dc. There were 0
discrepancies, which meshes with the Sol-assisted analysis of the code,
comparing it against the paper and Sam's detailed blog post.

I also wanted to compare the speed, but unfortunately, my tests always
suffer the noisy neighbor problem (working on a laptop with parallel work
going on, or Cloud PC that is of course a VM in a rack somewhere in
Virginia). So all I can really claim is that in my tests, the speed was
comparable (with the patch above).

All that said, I am very much in favor of accepting your patch series into
Git, with or without my suggested changes.

Thanks!
Johannes

>=20
> The x86 numbers are from a 4-vCPU Xeon VM with SHA-NI and AVX2 (GCC 13,
> Linux), which is unfortunately rather noisy; the per-patch hyperfine
> output has the spread. The arm64 numbers are medians of 9 runs on an
> Apple M5 Max (Apple clang, macOS). The full test suite passes on both.
>=20
> [1] https://sam.dev/blog/faster-sha1-collision-detection
> [2] https://github.com/GitoxideLabs/gitoxide/pull/3008
>=20
> Scott Chacon (4):
>   sha1dc-accel: add a block loop for sha1dc's SHA1_CTX
>   sha1dc-accel: vectorize the unavoidable-bitconditions check
>   sha1dc-accel: compress with SHA-NI on x86-64
>   sha1dc-accel: compress with the ARMv8 SHA-1 instructions
>=20
>  Makefile                            |   14 +
>  contrib/buildsystems/CMakeLists.txt |    2 +-
>  meson.build                         |    4 +
>  sha1dc-accel/arm.c                  |  274 ++++
>  sha1dc-accel/internal.h             |  126 ++
>  sha1dc-accel/sha1.c                 |  498 ++++++++
>  sha1dc-accel/sha1.h                 |   31 +
>  sha1dc-accel/ubc_check.c            | 1789 +++++++++++++++++++++++++++
>  sha1dc-accel/x86.c                  |  260 ++++
>  sha1dc_git.c                        |   18 +
>  t/.gitattributes                    |    1 +
>  t/helper/test-sha1.c                |   95 ++
>  t/helper/test-tool.c                |    2 +
>  t/helper/test-tool.h                |    2 +
>  t/meson.build                       |    1 +
>  t/t0013-sha1dc.sh                   |   47 +
>  t/t0013/sha-mbles-1.bin             |  Bin 0 -> 640 bytes
>  t/t0013/sha1-reduced-round.bin      |  Bin 0 -> 128 bytes
>  t/unit-tests/u-sha1dc.c             |  366 ++++++
>  19 files changed, 3529 insertions(+), 1 deletion(-)
>  create mode 100644 sha1dc-accel/arm.c
>  create mode 100644 sha1dc-accel/internal.h
>  create mode 100644 sha1dc-accel/sha1.c
>  create mode 100644 sha1dc-accel/sha1.h
>  create mode 100644 sha1dc-accel/ubc_check.c
>  create mode 100644 sha1dc-accel/x86.c
>  create mode 100644 t/t0013/sha-mbles-1.bin
>  create mode 100644 t/t0013/sha1-reduced-round.bin
>  create mode 100644 t/unit-tests/u-sha1dc.c
>=20
>=20
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
> --=20
> 2.50.1 (Apple Git-155)
>=20
>=20
>=20
>=20

--8323328132921224917913077121288--
