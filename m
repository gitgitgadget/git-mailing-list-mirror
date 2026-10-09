Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D549738E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558565; cv=none; b=WlDwEWN6MlYfeH+LdZMxOytpbJUZYUH94VigT79+SvyqBdsIP4+Bh6/zLBDSWvDGnxGDTd6e00l30GYG9k63KdMpGfN2rVs2c8Trf8d5Eziq7FDa+edRj6apzG13mRMxeiRjIf7Myo0hidijbJS9vwredVtu0XNxtPS457xcFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558565; c=relaxed/simple;
	bh=DzmGYzaweZ00rfeLCtisOQu8tL1LVXolNG02i7Rh988=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB+uRc22jgJJ5W0hSVhi7zn7Dv2nIKOODd+/7czi4dT/lgM9IYEWWABo2IYKJT57NV2b2ljw4ig87VnySFGHzp1f7ZVICsIDlTpFYloSsjDeJEs774J/G/yg3K9NwKB7ybCDqj5qwXPibm4ZHAgYTe5UgzHC0sCrZRSwYai53Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6DNWwz5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6DNWwz5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso783824a91.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558562; x=1792163362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D97e5lMiaKd4bDyL9TZHP7/CLMvY55OynXdrjtjbim0=;
        b=o6DNWwz547M2mlJ6ZYqbc+WZQxqcOL1m9NYsNc6eljFpr3HAmaUrv2+Qz2QG50UvQ7
         X2sb8sMthMt40Oo7RWz3unJmYfySA/HNp9rLU+Wvl4y+FHbUj+En/Zdqh4W8u7COEvfC
         GMUxZCnE0S2FV03Ws4rZQoXatjrBJfsgs+fxIY/DoDylG1SJmeiyaECMvyH0Nc7gZOyv
         YZGWrDR6drQ+dKxFxQvPtZiZ6x1w/YA3CnLpITSR5ANeYOrjUxDgfAqhadpR1Lqb15kw
         y43WaFavPKWXplAtoeweXlEaoTuWHxrMOwFcJXUJBlB0npUuUHzHr2ioyPCg6hLcuOl/
         a3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558562; x=1792163362;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D97e5lMiaKd4bDyL9TZHP7/CLMvY55OynXdrjtjbim0=;
        b=k1qGiHGdNsU42kf09UG+4Z3YAVgnQbRMYbPQDKIY5J2VjY0GAAxR2/R0mUCZ6NqhTu
         VjJhQDgRZXCwPzeqw3TYArixVKCRX15cKNsHVMDHVP32+DRe+blK0FEWuNjJkZ5kEYh4
         uPKehXWtcEkKydgb3tpUK9mQvCYVm3G7sJ9QGe9w9gbBu4UFPYL9T5a/zmeEc+1t/E7j
         WlYOBnengRUrhWCutoThD6vjsIK1nqH83q18SjDBlAi9wH1O1R57mIN2/NX+DjN0aGFA
         u33XwEZaq8YUT2EX09NlvyNbwNpPqZJVzJQe54haf1c5jFxJC7W6+JP0EmID+mo4tviR
         IaZQ==
X-Gm-Message-State: AFq9FYLapIP6XyXr8luE3NlR14wLZVSVM2/ZJ5WAXbuVSqeLG1Rrws03
	wzkMLKh6EdM7UzksIkxDRYCTGkij05oHLsxlqS3UsHK/OzeYs5UjHOxLJzESDXAalRo=
X-Gm-Gg: AYBFou1SmwxekS/YoIxdcbjr9cHNVKIt9jX34X/3Fbqma8urgKzWGdFQk8Jb1T+Rs2o
	TzDwK+Tc+o7o4TaK0QLsD0UTHuLNOxO0iXDYovhd5eZZmzw24GVPuBEoAhzKgeE6eMdZlVx6+IQ
	j1bGbc3mGrc+0fNV67Yw/VM5pH4YvYlMOxEq8kTXz/i/nfd5P2rx76i3KCIH9qDo/rGpfnz509P
	yktMiPlp5zq76LeHjSZsglW4uiiEn85fQLqTXffy8iheOFP6BrtWnqodxmWl8PbgIeY+shexo3Q
	P9LpTdQ6HVfMXGEvxo82UID/N8t9wOgLwURqT8BUypar+fhhKtc2Yk5+CmzAL8XTSkpDD80twQf
	knchl2Zue3C8cjzM1ixWPd0A7vo3tEsHJ8ri4tLkARo/HMiJvr/oSdRhpRGnVyNUmty5cPPUPt1
	IW09v6lFYgJuAN41G/lZQTC/dMfatZOa8z0gfpJYCunz/jcjRN1RBVEK8qg1C+IeqPnr8zaU6VG
	fTR5A==
X-Received: by 2002:a17:90b:4986:b0:3a8:10e2:acfc with SMTP id 98e67ed59e1d1-3ab3ace486cmr1830646a91.65.1791558561780;
        Fri, 09 Oct 2026 08:09:21 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da03f449sm1113553a12.28.2026.10.09.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:09:21 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v3 2/4] mergesort: simplify the unit tests
Date: Fri,  9 Oct 2026 20:38:48 +0530
Message-ID: <73ca97b0c721233a0e9d7b3cbc02fcbdf288c579.1791556668.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791556668.git.dilsheddilu123@gmail.com>
References: <cover.1791365181.git.dilsheddilu123@gmail.com> <cover.1791556668.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The old certification test combined several distributions with eight
transformations. That setup was useful for comparing sorting algorithms,
but it makes these unit tests harder to follow.

Replace the grid and its function tables with direct tests for sorted,
reversed, equal-value and repeatable random input. Keep the checks for
sorted values, the original order of equal values, and list length.
Keep the sizes around 1024 to exercise merges across a power-of-two
boundary.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/unit-tests/u-mergesort.c | 301 ++++++++-----------------------------
 1 file changed, 59 insertions(+), 242 deletions(-)

diff --git a/t/unit-tests/u-mergesort.c b/t/unit-tests/u-mergesort.c
index 56646b020b..50bca1db46 100644
--- a/t/unit-tests/u-mergesort.c
+++ b/t/unit-tests/u-mergesort.c
@@ -1,288 +1,105 @@
 #include "unit-test.h"
 #include "mergesort.h"
 
-static uint32_t minstd_rand(uint32_t *state)
-{
-	*state = (uint64_t)*state * 48271 % 2147483647;
-	return *state;
-}
-
-static void dist_sawtooth(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = i % m;
-}
-
-static void dist_rand(int *arr, int n, int m)
-{
-	int i;
-	uint32_t seed = 1;
-	for (i = 0; i < n; i++)
-		arr[i] = minstd_rand(&seed) % m;
-}
-
-static void dist_stagger(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = (i * m + i) % n;
-}
-
-static void dist_plateau(int *arr, int n, int m)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] = (i < m) ? i : m;
-}
-
-static void dist_shuffle(int *arr, int n, int m)
-{
-	int i, j, k;
-	uint32_t seed = 1;
-	for (i = j = 0, k = 1; i < n; i++)
-		arr[i] = minstd_rand(&seed) % m ? (j += 2) : (k += 2);
-}
-
-#define DIST(name) { #name, dist_##name }
-
-static struct dist {
-	const char *name;
-	void (*fn)(int *arr, int n, int m);
-} dist[] = {
-	DIST(sawtooth),
-	DIST(rand),
-	DIST(stagger),
-	DIST(plateau),
-	DIST(shuffle),
+struct number {
+	int value;
+	size_t rank;
+	struct number *next;
 };
 
-static void mode_copy(int *arr UNUSED, int n UNUSED)
-{
-	/* nothing */
-}
-
-static void mode_reverse(int *arr, int n)
-{
-	int i, j;
-	for (i = 0, j = n - 1; i < j; i++, j--)
-		SWAP(arr[i], arr[j]);
-}
-
-static void mode_reverse_1st_half(int *arr, int n)
-{
-	mode_reverse(arr, n / 2);
-}
-
-static void mode_reverse_2nd_half(int *arr, int n)
-{
-	int half = n / 2;
-	mode_reverse(arr + half, n - half);
-}
-
-static int compare_ints(const void *av, const void *bv)
-{
-	const int *ap = av, *bp = bv;
-	int a = *ap, b = *bp;
-	return (a > b) - (a < b);
-}
-
-static void mode_sort(int *arr, int n)
-{
-	QSORT(arr, n, compare_ints);
-}
-
-static void mode_dither(int *arr, int n)
-{
-	int i;
-	for (i = 0; i < n; i++)
-		arr[i] += i % 5;
-}
+DEFINE_LIST_SORT(static, sort_numbers, struct number, next);
 
-static void unriffle(int *arr, int n, int *tmp)
+static int compare_numbers(const struct number *a, const struct number *b)
 {
-	int i, j;
-	COPY_ARRAY(tmp, arr, n);
-	for (i = j = 0; i < n; i += 2)
-		arr[j++] = tmp[i];
-	for (i = 1; i < n; i += 2)
-		arr[j++] = tmp[i];
+	return (a->value > b->value) - (a->value < b->value);
 }
 
-static void unriffle_recursively(int *arr, int n, int *tmp)
+static int compare_ints(const void *va, const void *vb)
 {
-	if (n > 1) {
-		int half = n / 2;
-		unriffle(arr, n, tmp);
-		unriffle_recursively(arr, half, tmp);
-		unriffle_recursively(arr + half, n - half, tmp);
-	}
-}
+	const int *a = va, *b = vb;
 
-static void mode_unriffle(int *arr, int n)
-{
-	int *tmp;
-	ALLOC_ARRAY(tmp, n);
-	unriffle_recursively(arr, n, tmp);
-	free(tmp);
+	return (*a > *b) - (*a < *b);
 }
 
-static unsigned int prev_pow2(unsigned int n)
-{
-	unsigned int pow2 = 1;
-	while (pow2 * 2 < n)
-		pow2 *= 2;
-	return pow2;
-}
-
-static void unriffle_recursively_skewed(int *arr, int n, int *tmp)
-{
-	if (n > 1) {
-		int pow2 = prev_pow2(n);
-		int rest = n - pow2;
-		unriffle(arr + pow2 - rest, rest * 2, tmp);
-		unriffle_recursively_skewed(arr, pow2, tmp);
-		unriffle_recursively_skewed(arr + pow2, rest, tmp);
-	}
-}
-
-static void mode_unriffle_skewed(int *arr, int n)
-{
-	int *tmp;
-	ALLOC_ARRAY(tmp, n);
-	unriffle_recursively_skewed(arr, n, tmp);
-	free(tmp);
-}
-
-#define MODE(name) { #name, mode_##name }
-
-static struct mode {
-	const char *name;
-	void (*fn)(int *arr, int n);
-} mode[] = {
-	MODE(copy),
-	MODE(reverse),
-	MODE(reverse_1st_half),
-	MODE(reverse_2nd_half),
-	MODE(sort),
-	MODE(dither),
-	MODE(unriffle),
-	MODE(unriffle_skewed),
-};
-
-struct number {
-	int value, rank;
-	struct number *next;
-};
-
-DEFINE_LIST_SORT_DEBUG(static, sort_numbers, struct number, next,
-		       (void)0, (void)0);
-
-static int compare_numbers(const struct number *an, const struct number *bn)
-{
-	int a = an->value, b = bn->value;
-	return (a > b) - (a < b);
-}
-
-/* Free the storage directly, even if an assertion fails on a broken list. */
-static int *values;
 static struct number *numbers;
+static int *expected;
 
 void test_mergesort__cleanup(void)
 {
-	FREE_AND_NULL(values);
 	FREE_AND_NULL(numbers);
+	FREE_AND_NULL(expected);
 }
 
-static struct number *prepare_list(const int *arr, int n)
+static void check_sort(const int *input, size_t nr)
 {
-	int i;
+	struct number *list, *previous = NULL;
 
-	ALLOC_ARRAY(numbers, n);
-	for (i = 0; i < n; i++) {
-		numbers[i].value = arr[i];
+	ALLOC_ARRAY(numbers, nr);
+	ALLOC_ARRAY(expected, nr);
+	COPY_ARRAY(expected, input, nr);
+	QSORT(expected, nr, compare_ints);
+	for (size_t i = 0; i < nr; i++) {
+		numbers[i].value = input[i];
 		numbers[i].rank = i;
-		numbers[i].next = i + 1 < n ? &numbers[i + 1] : NULL;
+		numbers[i].next = i + 1 < nr ? &numbers[i + 1] : NULL;
 	}
-	return n ? numbers : NULL;
-}
-
-static void check_list(struct number *list, const int *expected,
-		       int n, const char *context)
-{
-	struct number *previous = NULL;
-	int i;
 
-	/* Bound traversal so a cycle is reported as an overlong list. */
-	for (i = 0; i < n; i++) {
-		cl_assert_(list, context);
-		cl_assert_equal_i_(list->value, expected[i], "%s: index %d",
-				   context, i);
+	list = nr ? numbers : NULL;
+	sort_numbers(&list, compare_numbers);
+	for (size_t i = 0; i < nr; i++) {
+		cl_assert_(list, "list is too short");
+		cl_assert_equal_i_(list->value, expected[i],
+				   "size %zu, item %zu", nr, i);
 		if (previous && previous->value == list->value)
 			cl_assert_lt_i_(previous->rank, list->rank,
-					"%s: stability at index %d", context, i);
+					"stability: size %zu, item %zu", nr, i);
 		previous = list;
 		list = list->next;
 	}
-	cl_assert_(list == NULL, context);
+	cl_assert_(list == NULL, "list is too long");
+	test_mergesort__cleanup();
 }
 
-/*
- * A version of the qsort certification program from "Engineering a Sort
- * Function" by Bentley and McIlroy, Software—Practice and Experience,
- * Volume 23, Issue 11, 1249–1265 (November 1993).
- */
-static void certify(const struct dist *distribution)
-{
-	static const int sizes[] = { 100, 1023, 1024, 1025 };
-	size_t i, j;
-	int m;
-
-	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
-		int n = sizes[i];
+static const size_t sizes[] = { 100, 1023, 1024, 1025 };
 
-		for (j = 0; j < ARRAY_SIZE(mode); j++) {
-			for (m = 1; m < 2 * n; m *= 2) {
-				struct number *list;
-				char context[128];
+void test_mergesort__sorted(void)
+{
+	int input[1025];
 
-				xsnprintf(context, sizeof(context),
-					  "%s %s n=%d m=%d",
-					  distribution->name, mode[j].name, n, m);
-				ALLOC_ARRAY(values, n);
-				distribution->fn(values, n, m);
-				mode[j].fn(values, n);
-				list = prepare_list(values, n);
-				sort_numbers(&list, compare_numbers);
-				QSORT(values, n, compare_ints);
-				check_list(list, values, n, context);
-				test_mergesort__cleanup();
-			}
-		}
-	}
+	for (size_t i = 0; i < ARRAY_SIZE(input); i++)
+		input[i] = i;
+	for (size_t i = 0; i < ARRAY_SIZE(sizes); i++)
+		check_sort(input, sizes[i]);
 }
 
-void test_mergesort__sawtooth(void)
+void test_mergesort__reversed(void)
 {
-	certify(&dist[0]);
-}
+	int input[1025];
 
-void test_mergesort__rand(void)
-{
-	certify(&dist[1]);
+	for (size_t i = 0; i < ARRAY_SIZE(sizes); i++) {
+		for (size_t j = 0; j < sizes[i]; j++)
+			input[j] = sizes[i] - j;
+		check_sort(input, sizes[i]);
+	}
 }
 
-void test_mergesort__stagger(void)
+void test_mergesort__equal_values(void)
 {
-	certify(&dist[2]);
-}
+	int input[1025] = { 0 };
 
-void test_mergesort__plateau(void)
-{
-	certify(&dist[3]);
+	for (size_t i = 0; i < ARRAY_SIZE(sizes); i++)
+		check_sort(input, sizes[i]);
 }
 
-void test_mergesort__shuffle(void)
+void test_mergesort__random(void)
 {
-	certify(&dist[4]);
+	int input[1025];
+	uint32_t seed = 1;
+
+	for (size_t i = 0; i < ARRAY_SIZE(input); i++) {
+		seed = (uint64_t)seed * 48271 % 2147483647;
+		input[i] = seed % 32;
+	}
+	for (size_t i = 0; i < ARRAY_SIZE(sizes); i++)
+		check_sort(input, sizes[i]);
 }
-- 
2.55.0

