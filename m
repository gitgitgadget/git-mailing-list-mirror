Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182F22324
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074918; cv=none; b=o6IKpHd1lO3VWHaFeX6jbtR+4EVMSsJB1aOC9gJfEVIrhHlT50hvccEsJ0zLrSfJsE98KXMzmEfgbYBxuyvpJwR1DuYPNYYZmzAYcv5S0gkSMf5jKYOaMKNKeUf2bq8QLKCWBCW7i23DH6sEpbm4DMlddP8FVoC8KYGBVlTYack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074918; c=relaxed/simple;
	bh=XqBgYQ7DY3mZh3cOIsuk9yj4g3gunD1ayh5vrL3R6Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpNOAifRlEkcI4+x/kEh+8ksX/S9evF+znpTK8KXchscByq5GbvT17zVwS8JVZn/vq042zp+s9MZD9A0OoQFTVBi4dkm83K9zDrlhEoMXLoa5fi+obMACz75M5GMP0jECLR/+jxA1XK5Te2dQ/5lniZiPDaeaQjiCMBsyqPtS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bpBpbN2l; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bpBpbN2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1710074903; x=1710679703; i=l.s.r@web.de;
	bh=XqBgYQ7DY3mZh3cOIsuk9yj4g3gunD1ayh5vrL3R6Jg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bpBpbN2lHR/KdlqHf/VTmvAgYbHfYcwRu33esfMvX9CxWhzHkrlBsO9jEI8Une5h
	 7RgtkzVVXUmzVonilTsTX9xD0GMDtEr7A8/eBaP7y2fdY8gEDerVpSe1U2/pj8J6a
	 m5pnfg3zxJHKZO4YJfShj3+mEwtNLSGEWyjXbjtZ5khBaSdqJVNF/11kt9zpbLp8+
	 1tilnz95oG+rD1LTjuV8He3/rTNyDOqQGscIRY11+Y0MGX0DdxrRTi4HvHNMhaIXZ
	 7O+T8vLo5c9v/x8O93/FI5Yjr/2qbqXeKcnKKI2jGX9AMOx/zeS9GmTKFeKxv4kzH
	 RmLFw4tSz1BOkKS04w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB4F-1rN4vG0hqj-00VHEF; Sun, 10
 Mar 2024 13:48:23 +0100
Message-ID: <69e24019-1fff-40df-9aef-cdfd058124c9@web.de>
Date: Sun, 10 Mar 2024 13:48:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] t-ctype: avoid duplicating class names
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240303101330.20187-1-l.s.r@web.de> <20240303101330.20187-5-l.s.r@web.de>
 <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com>
 <3ef0927f-4d7b-4061-925e-c113d1c8730d@web.de>
 <4f41f509-1d44-4476-92b0-9bb643f64576@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <4f41f509-1d44-4476-92b0-9bb643f64576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SMOaamQrx2L9EBaWMwx/EbS8Pqo11uMWcRVXN+KWl4TVpyzo19e
 QKnrUOJh2fr2e6QZ+d3arCw2wmzrylUfQpS0kd6MerPXtGu4FcBr29Opymya1RuS7ulnOF7
 aZNOdWl575gWFGYqwdYfuhzhQfQPou8X2U+7oDmF2oDjloc25yOINtf8TiSuVwQsAmumN1k
 lxhI8QxByFbBFE4EHa9dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ds2D1b8tnys=;dqOMhS8KTXhz9aypDAml0MotQ9F
 h+oGnGreucHSwEPlEhNzazSpR7yhSuP2LDs5s5+2w7CjqEfZhm67a1roDyURelmwL41oG2EjN
 iOXqzDrnnkvQCE+4I6+CLPqyKab82ED8OMUwQpWhPhw2BzIBzgorf++zdekwvU2kC44OF9rgt
 8ZSrluM1+/ciXpUINHUH+5Svpz030ths7Ndw4Ad4gri23CJNaOQpPyPWGsClOs2MyrlQmE6tr
 GVEqL00EmHHBgKpyj7hy+x4QuLCdahhCotJI6qmiUh7pixNZhE+SkRRmD/0429VqXtg6ya1w+
 1UROBbUrKbWTZOUgO2iUnr3xNBVAcVQigbfqmXpiYi2pFs8SjW05Yv3KDBlvbrKZZ2suEXdOu
 VJoZTZWyaP05tHRbePSssHoB7+8HJmNETp1ZwEPi6YWTyZMo8frfp5srNeL8Xs+sanULu73fc
 1FF8IZ0oqCdpfjDpkzRzwbKLwrTYxCaXVIqnuOSK/Vd4sZLMZ7QnO3jShWP0+489F7zTJFOpY
 cRjPAWilaMBBCD/6J+kPDV/S/hG9LMQVt9HHulA8LyV2SwmL1hbYqzYKr0AZnWkr9eS6mOy6/
 KwUJwiIcL01qUGEfRiFhhHyAKwEJbShyinNjCJwnnSAPqCUfI1G65LcyxjfZBseVOjcgYydOa
 +3eAjoYm81WfAQlfZFVm95PlyJlJ8Q21iuku+wBpg3ICdPJqY5Hra1WXXzkscS+RT9/HazE3C
 w/4Hiy+HIdby2P7vBIIv35+T/nlXs5HkDjIGBwlzb0M4/SiToDoWIApD2wJ0IM8nQ+VifvhJx
 BYG2SditEQDn9IUCdkMer6pwUuNYrl1RE/7n1V6AssTOc=

Hi Phillip,

Am 09.03.24 um 12:28 schrieb Phillip Wood:
> On reflection I don't think I'm objecting to allowing statements,
> only the use of the private functions to do so. If we tweak
> test__run_begin() and test__run_end() so that the description is
> passed to test__run_begin() and we invert the return value of that
> function to match what test__run_end() is expecting then we can have
>
> #define TEST_BEGIN(...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int run__ =3D test__run_begin=
(__VA_ARGS__);=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (run__)
>
> #define TEST_END=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_run_end(run__);=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0} while (0)
>
> Which allow test authors to write
>
> =C2=A0=C2=A0=C2=A0=C2=A0TEST_BEGIN("my test") {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* test body here */
> =C2=A0=C2=A0=C2=A0=C2=A0} TEST_END;
>
> The macros insulate the test code from having to worry about
> test_skip_all() and the "do { ... } while (0)" means that the
> compiler will complain if the author forgets TEST_END.

the location information is missing, but I get the idea.  That would
certainly work for t-ctype.

> I'm slightly on the fence about including the braces in the macros
> instead as that would make them harder to misuse but it would be less
> obvious that the test body is run in its own block. The compiler will
> allow the test author to accidentally nest two calls to TEST_BEGIN()
> but there is an assertion in test__run_begin() which will catch that
> at run time.

Thought about that as well, and I'd also be wary of including any of the
control statements.  Custom syntax requires learning, can have weird
side-effects and may be misunderstood by editors.

Below is a patch that adds the function test_start() and its companion
macro TEST_START, which allow defining tests with minimal ceremony,
similarly as in the shell-based test suite:

	#include "test-lib.h"

	int cmd_main(int argc, const char **argv)
	{
		if (TEST_START("something works"))
			check(something());
		if (TEST_START("something else works"))
			check(something_else());
		return test_done();
	}

It requires storing string copies and sits between the states of the
original test machinery, so it's a bit complicated.

The biggest downside so far, though, is that I couldn't find an example
in the other unit tests that it would simplify significantly.  At least
it would allow getting rid of the void pointers in t-strbuf, however.

> The slight downside compared to TEST() is that it is harder to return
> early if a check fails - we'd need something like
>
> =C2=A0=C2=A0=C2=A0=C2=A0TEST_BEGIN("my test") {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!check(0))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
fail
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* more checks */
> =C2=A0=C2=A0=C2=A0=C2=A0 fail:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> =C2=A0=C2=A0=C2=A0=C2=A0} TEST_END;

TEST is worse in this regard, as it doesn't allow "if" directly at all.
You can use short-circuiting, of course:

	TEST(check(!!ptr) && check(*ptr =3D=3D value), "ptr points to value");

But you can do that with TEST_BEGIN as well.  In a function you can
return early, but you can use functions with both, too.

In your example you can use "continue" instead of "goto fail".  And with
"break" you can skip the test_run_end() call.  I consider both to be
downsides, though -- the abstraction is leaky.

> Also unlike TEST(), TEST_END does not indicate to the caller whether
> the test failed or not but I'm not sure that matters in practice.

Most TEST invocations out of t-basic ignore its return value so far.

ctx.result is left unchanged by test__run_end(), so we could still
access it if really needed.  Perhaps through a sanctioned function,
last_test_result() or similar.

Ren=C3=A9



diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..e7c846814e 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -4,15 +4,13 @@
 	size_t len =3D ARRAY_SIZE(string) - 1 + \
 		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
 		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) =3D=3D sizeof(char)); \
-	int skip =3D test__run_begin(); \
-	if (!skip) { \
+	if (TEST_START(#class " works")) { \
 		for (int i =3D 0; i < 256; i++) { \
 			if (!check_int(class(i), =3D=3D, !!memchr(string, i, len)))\
 				test_msg("      i: 0x%02x", i); \
 		} \
 		check(!class(EOF)); \
 	} \
-	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
 } while (0)

 #define DIGIT "0123456789"
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 66d6980ffb..bc484c92da 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -16,6 +16,8 @@ static struct {
 	unsigned running :1;
 	unsigned skip_all :1;
 	unsigned todo :1;
+	char *desc;
+	char *location;
 } ctx =3D {
 	.lazy_plan =3D 1,
 	.result =3D RESULT_NONE,
@@ -123,9 +125,45 @@ void test_plan(int count)
 	ctx.lazy_plan =3D 0;
 }

+static void test_run_maybe_end(void)
+{
+	if (ctx.running) {
+		assert(ctx.location);
+		assert(ctx.desc);
+		test__run_end(0, ctx.location, "%s", ctx.desc);
+		FREE_AND_NULL(ctx.location);
+		FREE_AND_NULL(ctx.desc);
+	}
+	assert(!ctx.running);
+	assert(!ctx.location);
+	assert(!ctx.desc);
+}
+
+int test_start(const char *location, const char *format, ...)
+{
+	va_list ap;
+	char *desc;
+
+	test_run_maybe_end();
+
+	va_start(ap, format);
+	desc =3D xstrvfmt(format, ap);
+	va_end(ap);
+
+	if (test__run_begin()) {
+		test__run_end(1, location, "%s", desc);
+		free(desc);
+		return 0;
+	} else {
+		ctx.location =3D xstrdup(location);
+		ctx.desc =3D desc;
+		return 1;
+	}
+}
+
 int test_done(void)
 {
-	assert(!ctx.running);
+	test_run_maybe_end();

 	if (ctx.lazy_plan)
 		test_plan(ctx.count);
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
index a8f07ae0b7..2be95b3ab8 100644
=2D-- a/t/unit-tests/test-lib.h
+++ b/t/unit-tests/test-lib.h
@@ -21,6 +21,15 @@
  */
 void test_plan(int count);

+/*
+ * Start a test.  It ends when the next test starts or test_done()
+ * is called.  Returns 1 if the test was actually started, 0 if it was
+ * skipped because test_skip_all() had been called.
+ */
+int test_start(const char *location, const char *format, ...);
+
+#define TEST_START(...) test_start(TEST_LOCATION(), __VA_ARGS__)
+
 /*
  * test_done() must be called at the end of main(). It will print the
  * plan if plan() was not called at the beginning of the test program
