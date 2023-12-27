Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B1A446B3
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="QsVILvPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703678252; x=1704283052; i=l.s.r@web.de;
	bh=OKop4FzrfZv1dnsgxNbVhWxFNNI/MuJkOvnAU2k3ed4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QsVILvPapQXlo/4AyN70VYxAJCsp97VlgusCqjB0qk85nXJIZPXSqsFQCcuQ/ywp
	 TOgZ6M6QhJ+QhegcC5gC5fs4vchlKNRFOtmUCDEmmb8NkmjCRqEJRZalrEx1GpEYM
	 HZ724bl06fNxpHnwIIYwhI88xIgNOkEMokNYZU7kXQFVuFShHrO3avdWdpjOJLbDr
	 pdJ+fwce192qTk7UOThyirzCcyV1qwKO7PJKcdO8NtuCMnxWOTYjIqK/6mf1wzrr2
	 T5OX69nfF+ksFoD8cKcli2SAyAF+wnX3OOZLvj5HRofLZjAPga04oHW1WO68JYJvC
	 P7sdSJ3ZYPt3ZlQ/zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1qgfHJ3YL8-00dPCr; Wed, 27
 Dec 2023 12:57:31 +0100
Message-ID: <f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de>
Date: Wed, 27 Dec 2023 12:57:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
To: Christian Couder <christian.couder@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 Christian Couder <chriscool@tuxfamily.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <20231221231527.8130-1-ach.lumap@gmail.com>
 <xmqqsf3ohkew.fsf@gitster.g>
 <CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fcxgUERpPFWRyuPg2L5jSxn8WgF/AdGIfC4vz9G8AHOSLNMKl07
 K6YDtxcoAQYSbvFvRTfgCkQ4qLYAlkn46YhsibwtWPzxBeCz8VJXg5J9GIN3tIfXuKaJemh
 ceDml512yfTLEt/pKNBM2UIcEoJtLPFERSKtM0jA2iv/o55KUbawebneO+S/m/5plRTfGZB
 HGSJgbTD6SJ9s+NQKiOkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RPI74cWCKh8=;K9+XycUcleLEX7vsET6D1v7PWcg
 93jxDmSVDE3YdieNqZJzjbWIjrKMWtkVz5An5r1iOJ768qhfpeAgcwieJDQU7fHof7mcxqhHm
 SCWn+pAUa4lUuAQx8NPSn1dYEc4gKuq0zdZuFk586Redu5AmjiixRqzHNWA/d/tFgNE19ZZVU
 Dgvh2/etH2SjsHtanU5SwaGCN2v8uwlqgHmJ4tnz7+/spFQZp8xJ3Dg9j2G8DzJTFig7/iRyh
 tb7mE3q3YM7D7qUMfzFlbkO58fdsfXGwisq5w5z2rqOIBPPlx6Wo+W7OBWC63/NbNbx7Qt2Pc
 XUa1A+veQos8hXSNmGPzmcV+pcnkw3kBh5fKbn4kHtI+H33U3vXzCgclA0UBJWPWjE4lvZ0U/
 weWALrJCu+6WwnXjQbeL6Hk73/k1fXq84S7pGC9eGXpnL198kuckCwf3QzeDOYO2+Y2vVHEsd
 dc1UV2QKrpTJddOrRXkKEzTkgAyCPCCgvnkt07fU7hNyQjf7kXrxjv8uRfVYdtEh1zlbIe9lu
 rpSzgvJju2Qw0O8iV3CksCV43d+o6O2MaF4KJBZQsUTdwpH006FRwqaABrL7mPhVkO9gukv72
 Aky5Bykh5cmoNJ6iNr0x8gA/DPL67iBRqaAW67FW/B8+uElojNwG6wwdLzhfSuwsQXwlKb7Hw
 yaIWbACJNzEVR/S9AHv1TEeSAfvdz3SSZc+dJKyI1N+aTIo8KIx+yRAY2irxuPQVOgiyvy4xp
 kL/7LAtDflnr/F9E3DrCo9BlYkQh6ocJtbo0dpAzN747jZvWh69h+52e7Pqov30O13D+51+xB
 n99at5MQtosjAJ0Yk3bAFcihAkFPMvHSiWAhVEWuh2yOYnRQbcp50A/lQ82I2d5dLrQFGLC+W
 khEuQzaB4Y5/V3z+fTOWvo5xUzm8yuo7eR46+H0rH4NdGBp6NsG9gF9e3NKCvWOLtBPo5JSdj
 emdc7w==

Am 27.12.23 um 11:57 schrieb Christian Couder:
> On Tue, Dec 26, 2023 at 7:46=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>
>> Achu Luma <ach.lumap@gmail.com> writes:
>
>>> +/* Macro to test a character type */
>>> +#define TEST_CTYPE_FUNC(func, string)                        \
>>> +static void test_ctype_##func(void)                          \
>>> +{                                                            \
>>> +     int i;                                                  \
>>> +     for (i =3D 0; i < 256; i++)                               \
>>> +             check_int(func(i), =3D=3D, is_in(string, i));       \
>>> +}
>>
>> Now, we let check_int() to do the checking for each and every byte
>> value for the class.  check_int() uses different reporting and shows
>> the problematic value in a way that is more verbose and at the same
>> time is a less specific and harder to understand:
>>
>>                 test_msg("   left: %"PRIdMAX, a);
>>                 test_msg("  right: %"PRIdMAX, b);
>>
>> But that is probably the price to pay to use a more generic
>> framework, I guess.
>
> I have added Phillip and Josh in Cc: as they might have ideas about this=
.

You can write custom messages for custom tests using test_assert().

> Also it might not be a big issue here, but when the new unit test
> framework was proposed, I commented on the fact that "left" and
> "right" were perhaps a bit less explicit than "actual" and "expected".

True.

>>> +int cmd_main(int argc, const char **argv) {
>>> +     /* Run all character type tests */
>>> +     TEST(test_ctype_isspace(), "isspace() works as we expect");
>>> +     TEST(test_ctype_isdigit(), "isdigit() works as we expect");
>>> +     TEST(test_ctype_isalpha(), "isalpha() works as we expect");
>>> +     TEST(test_ctype_isalnum(), "isalnum() works as we expect");
>>> +     TEST(test_ctype_is_glob_special(), "is_glob_special() works as w=
e expect");
>>> +     TEST(test_ctype_is_regex_special(), "is_regex_special() works as=
 we expect");
>>> +     TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works =
as we expect");
>>> +     TEST(test_ctype_isascii(), "isascii() works as we expect");
>>> +     TEST(test_ctype_islower(), "islower() works as we expect");
>>> +     TEST(test_ctype_isupper(), "isupper() works as we expect");
>>> +     TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
>>> +     TEST(test_ctype_ispunct(), "ispunct() works as we expect");
>>> +     TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
>>> +     TEST(test_ctype_isprint(), "isprint() works as we expect");
>>> +
>>> +     return test_done();
>>> +}
>>
>> As a practice to use the unit-tests framework, the patch looks OK.

The added repetition is a bit grating.  With a bit of setup, loop
unrolling and stringification you can retain the property of only having
to mention the class name once.  Demo patch below.

>> helper/test-ctype.c indeed is an oddball that runs once and checks
>> everything it wants to check, for which the unit tests framework is
>> much more suited.
>
> Yeah, I agree.

Indeed: test-ctype does unit tests, so the unit test framework should
be a perfect fit.  It still feels a bit raw that this point, though,
but that's to be expected.

Ren=C3=A9


diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index 41189ba9f9..7903856cec 100644
=2D-- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -13,13 +13,23 @@ static int is_in(const char *s, int ch)
 	return !!strchr(s, ch);
 }

-/* Macro to test a character type */
-#define TEST_CTYPE_FUNC(func, string)			\
-static void test_ctype_##func(void)				\
-{								\
-	int i;                                     	 	\
-	for (i =3D 0; i < 256; i++)                 		\
-		check_int(func(i), =3D=3D, is_in(string, i)); 	\
+struct ctype {
+	const char *name;
+	const char *expect;
+	int actual[256];
+};
+
+static void test_ctype(const struct ctype *class)
+{
+	for (int i =3D 0; i < 256; i++) {
+		int expect =3D is_in(class->expect, i);
+		int actual =3D class->actual[i];
+		int res =3D test_assert(TEST_LOCATION(), class->name,
+				      actual =3D=3D expect);
+		if (!res)
+			test_msg("%s classifies char %d (0x%02x) wrongly",
+				 class->name, i, i);
+	}
 }

 #define DIGIT "0123456789"
@@ -40,37 +50,39 @@ static void test_ctype_##func(void)				\
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"

-TEST_CTYPE_FUNC(isdigit, DIGIT)
-TEST_CTYPE_FUNC(isspace, " \n\r\t")
-TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
-TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
-TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
-TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
-TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~")
-TEST_CTYPE_FUNC(isascii, ASCII)
-TEST_CTYPE_FUNC(islower, LOWER)
-TEST_CTYPE_FUNC(isupper, UPPER)
-TEST_CTYPE_FUNC(iscntrl, CNTRL)
-TEST_CTYPE_FUNC(ispunct, PUNCT)
-TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
-TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
+#define APPLY16(f, n) \
+	f(n + 0x0), f(n + 0x1), f(n + 0x2), f(n + 0x3), \
+	f(n + 0x4), f(n + 0x5), f(n + 0x6), f(n + 0x7), \
+	f(n + 0x8), f(n + 0x9), f(n + 0xa), f(n + 0xb), \
+	f(n + 0xc), f(n + 0xd), f(n + 0xe), f(n + 0xf)
+#define APPLY256(f) \
+	APPLY16(f, 0x00), APPLY16(f, 0x10), APPLY16(f, 0x20), APPLY16(f, 0x30),\
+	APPLY16(f, 0x40), APPLY16(f, 0x50), APPLY16(f, 0x60), APPLY16(f, 0x70),\
+	APPLY16(f, 0x80), APPLY16(f, 0x90), APPLY16(f, 0xa0), APPLY16(f, 0xb0),\
+	APPLY16(f, 0xc0), APPLY16(f, 0xd0), APPLY16(f, 0xe0), APPLY16(f, 0xf0),\
+
+#define CTYPE(name, expect) { #name, expect, { APPLY256(name) }  }

 int cmd_main(int argc, const char **argv) {
+	struct ctype classes[] =3D {
+		CTYPE(isdigit, DIGIT),
+		CTYPE(isspace, " \n\r\t"),
+		CTYPE(isalpha, LOWER UPPER),
+		CTYPE(isalnum, LOWER UPPER DIGIT),
+		CTYPE(is_glob_special, "*?[\\"),
+		CTYPE(is_regex_special, "$()*+.?[\\^{|"),
+		CTYPE(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~"),
+		CTYPE(isascii, ASCII),
+		CTYPE(islower, LOWER),
+		CTYPE(isupper, UPPER),
+		CTYPE(iscntrl, CNTRL),
+		CTYPE(ispunct, PUNCT),
+		CTYPE(isxdigit, DIGIT "abcdefABCDEF"),
+		CTYPE(isprint, LOWER UPPER DIGIT PUNCT " "),
+	};
 	/* Run all character type tests */
-	TEST(test_ctype_isspace(), "isspace() works as we expect");
-	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
-	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
-	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
-	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect=
");
-	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expe=
ct");
-	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we ex=
pect");
-	TEST(test_ctype_isascii(), "isascii() works as we expect");
-	TEST(test_ctype_islower(), "islower() works as we expect");
-	TEST(test_ctype_isupper(), "isupper() works as we expect");
-	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
-	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
-	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
-	TEST(test_ctype_isprint(), "isprint() works as we expect");
+	for (int i =3D 0; i < ARRAY_SIZE(classes); i++)
+		TEST(test_ctype(&classes[i]), "%s works", classes[i].name);

 	return test_done();
 }

