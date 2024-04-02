Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229615B102
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082637; cv=none; b=KhKRbAVbjdH2iYN+fljjTPYZVnO0stvYOlrmEQKOpSD8fk0ZfxPDSj30uTnEysFYbMCg9yLFw0lvkPBre3EOkK7iImcfGO0ffU4ac2yWSl2AAzZelRYopN0jlPjpUB2imwTj9BPyy6cTuvno40mA1zAj8rg97n4SfvSbJ5bEQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082637; c=relaxed/simple;
	bh=Hk62REiBcfBhbecMBBiTl60Vdd431SPRniBaZ29bmdU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=Ss9mTNeJpC70bEU+Wm78RwwhF2J71hglLGGrw19DA+tloZsyq/0/xqp1Ve/jtr396YgPm57jMprfuZZ3ZUIEG2VArjlKq3cft/Dc1VuBHqrfAOGtZlz33HqKuo+xzNL3KLr3gOIGSs+ja4vlB7FJpF6X0THpe8L6T/wYWX7F+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gtEvF8tx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gtEvF8tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712082632; x=1712687432; i=l.s.r@web.de;
	bh=mlUhaGmtjrqi3yss2dba0PFiAt1Fv1HEPMpWYEuoDsc=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=gtEvF8tx3/bGDNwCrCW2/p5W2qfxEIShmE+cf4M/YWMKmYBqV0Yz2itmJe9anIOn
	 YPa9MpbJNRCBxLP7yS4DVg9LE0YbJ4Ct5jCfvZwa9dfu0Qyj4Du0K0jRIlHE0xEbl
	 ea8bIb1r6nCi7d1p0vMnwWEoOKbJrD2zOg4cyXewhby11tqARrcJQDRt3PyzbXmRM
	 DNlTXr4idxc6JfysdgyHwPj/eZhffvOyXIERXD4hp+o7t7zKfNVuioal+rkiQ+ABf
	 IfNwqRz4PZmiGgN/Rm0n60U2CrNGc7hUWLuNxoqy9aFX2sSrPfjssLxB12ZGTdqjp
	 CtkerbU+k/nDlzkM+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6HK6-1rtvpQ06Su-006vwg; Tue, 02
 Apr 2024 20:30:32 +0200
Message-ID: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
Date: Tue, 2 Apr 2024 20:30:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [RFC][PATCH] t-prio-queue: simplify using compound literals
Cc: Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EM1E7OoFPFoeXdpjPQDUETNX1ku7yqbywUiYrLLkylniFypNcS1
 QYeHpk0LV6PZE3aKEwLOuASE/5b1Q/whozf+NbwByp3kw626nrKMm3hTWXmlTdD74DGYYFX
 yvec4VaM/cbIR9OYjxya1GgFaejA7cKwatIxkLLzpkoCgMUyYLqSRVOGl24bU8IKHv0sTpm
 D3u6rHmMiANqRwSDYqt4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hcygbgXJqvs=;I4cwc8fxmCK1Y8zmEGY3saVFWVv
 1iTVANzpWFCI+37MD8p46uuA8e4IT7ugc4sPTXBLkZo6IpI1IUtERsAeQGl5XyXQa+xcfRTMT
 KVaPF1FvFmM32aPtk7rtpqk6pRBm00//cJp1E7XTdNNmUIlBVVxJFcztLHVxyamIyFPFQE/+p
 PqoYaBQO7QVefSkdjoI0j74YA+Q/lM+jFCXAEsGxTozW44n9eJRgqvjdMszVNSQMtzqOPf29j
 2N24Z7VsWwP7Fcnf3Bfn0AGZEmocWmy0X2XFCUowKoxnsZ7ws1aIn1vPQrM+v1JrCWkvXcypl
 N/SUQm+D5mHz6GsbV1rLkM7VHhN8r3qRJ7cNUYr8lrFbeVMnAVbXUMr/KQ1/DBhgDrlh1Wp47
 D/4unoEtETbTNakrrlGVwVDH4iBHeSCiL9mApG/iAtVn5Qu1bnRXW62t0uZTNzkWe4tF610Dw
 91i+EsZRbh2YMlvvCBbKHll4R8EonlAyBW9etPoFyFCxpkNRMEHmjBIHC2pSqmsJQe3IDlpMJ
 ZtSZC1fcdwc5Xb9+LtYzvAECbmOwD7AANnn7fiJSjqThjgUYZM05FiWPw9e5UQ4/BseGaGHr7
 9A9psaYKfWIJXRmj6209qTQ8WLyu9dqQU+frDuGHt8yHSbGyLqz+R05zC+EWtseTpdtdn5YpQ
 84r/bAfRKwUBpnEQnjBMkSeFWGKI7dVNSz3GZckDSPq5OUpggd8zVbt5oFqmrbN+rYMNLWNAl
 +5ZmjYqMG+Dbv9NkVyijfzAJjkzDZtiEnw8Qr0Ft7ZrLed8RZz85XA6PKGpT5C1tVoYwYSO1i
 qSXbBkutLasm4Po6yT+ix5h/wO8n20x1VcZWIfC8r0+uw=

Test names like "basic" are mentioned seven times in the code (ignoring
case): Twice when defining the input and result macros, thrice when
defining the test function, and twice again when calling it.  Reduce
that to a single time by using compound literals to pass the input and
result arrays via TEST_INPUT to test_prio_queue().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
C99 added compound literals.  Are we ready to use them?

Test definitions become more compact, but look busier due to the added
punctuation.  We could hide some of it with a sugary macro like this:
#define INT_ARRAY(...) ((int []){ __VA_ARGS__ })

 t/unit-tests/t-prio-queue.c | 51 +++++++++++++------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index 5358346361..7a4e5780e1 100644
=2D-- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -66,43 +66,26 @@ static void test_prio_queue(int *input, size_t input_s=
ize,
 	clear_prio_queue(&pq);
 }

-#define BASIC_INPUT 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP
-#define BASIC_RESULT 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10
-
-#define MIXED_PUT_GET_INPUT 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP
-#define MIXED_PUT_GET_RESULT 2, 3, 4, 1, 5, 6
-
-#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
-#define EMPTY_QUEUE_RESULT 1, 2, MISSING, 1, 2, MISSING
-
-#define STACK_INPUT STACK, 8, 1, 5, 4, 6, 2, 3, DUMP
-#define STACK_RESULT 3, 2, 6, 4, 5, 1, 8
-
-#define REVERSE_STACK_INPUT STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP
-#define REVERSE_STACK_RESULT 1, 2, 3, 4, 5, 6
-
-#define TEST_INPUT(INPUT, RESULT, name)			\
-  static void test_##name(void)				\
-{								\
-	int input[] =3D {INPUT};					\
-	int result[] =3D {RESULT};				\
-	test_prio_queue(input, ARRAY_SIZE(input),		\
-			result, ARRAY_SIZE(result));		\
-}
-
-TEST_INPUT(BASIC_INPUT, BASIC_RESULT, basic)
-TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_RESULT, mixed)
-TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_RESULT, empty)
-TEST_INPUT(STACK_INPUT, STACK_RESULT, stack)
-TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_RESULT, reverse)
+#define TEST_INPUT(input, result) \
+	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))

 int cmd_main(int argc, const char **argv)
 {
-	TEST(test_basic(), "prio-queue works for basic input");
-	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
-	TEST(test_empty(), "prio-queue works when queue is empty");
-	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
-	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
+	TEST(TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
+			((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 })),
+	     "prio-queue works for basic input");
+	TEST(TEST_INPUT(((int []){ 6, 2, 4, GET, 5, 3, GET, GET, 1, DUMP }),
+			((int []){ 2, 3, 4, 1, 5, 6 })),
+	     "prio-queue works for mixed put & get commands");
+	TEST(TEST_INPUT(((int []){ 1, 2, GET, GET, GET, 1, 2, GET, GET, GET }),
+			((int []){ 1, 2, MISSING, 1, 2, MISSING })),
+	     "prio-queue works when queue is empty");
+	TEST(TEST_INPUT(((int []){ STACK, 8, 1, 5, 4, 6, 2, 3, DUMP }),
+			((int []){ 3, 2, 6, 4, 5, 1, 8 })),
+	     "prio-queue works when used as a LIFO stack");
+	TEST(TEST_INPUT(((int []){ STACK, 1, 2, 3, 4, 5, 6, REVERSE, DUMP }),
+			((int []){ 1, 2, 3, 4, 5, 6 })),
+	     "prio-queue works when LIFO stack is reversed");

 	return test_done();
 }
=2D-
2.44.0
