Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AED134A0
	for <git@vger.kernel.org>; Sun,  7 Jan 2024 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DxWGKoIU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704631564; x=1705236364; i=l.s.r@web.de;
	bh=ETG4LeHR8vDjZqXyBO34/KPmjnxVG/pqc+9tI9lCF3I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=DxWGKoIU0jDa/OWWzmUb9jyjhymIXLqGjMSLdCBoYU/LxWjvVatLBQZfCqr9p/mC
	 lmn/RKqowc3JR9cj0RIxOCd9qnjYrN2XgUcep1ttampEM2AxkRITTgqMSpgQ2JqWV
	 U/0AjUY536rtw0y7g14dKUonnkAClehC9DGvNy/sMi1B0cQzIPROoag0ObYaVHqzT
	 Fe6WTQiZgSYgsIg6ZCKbzCi/De9LvECEwItlydAjPTUopTRzW24bVj4heodCvLvvs
	 kagrnekSLojSSaVEkfV9b7UOQSHdC9++dL+dFtqbEtFlAsYwNY/6E0f4jk40PueXI
	 Y7JfEm6xnueSnD91nw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UgI-1r6SAQ1Tpq-01759U; Sun, 07
 Jan 2024 13:46:04 +0100
Message-ID: <a087f57c-ce72-45c7-8182-f38d0aca9030@web.de>
Date: Sun, 7 Jan 2024 13:45:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy][PATCH v4] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
Content-Language: en-US
To: Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, christian.couder@gmail.com,
 phillip.wood@dunelm.org.uk, steadmon@google.com, me@ttaylorr.com,
 Phillip Wood <phillip.wood123@gmail.com>
References: <20240101104017.9452-2-ach.lumap@gmail.com>
 <20240105161413.10422-1-ach.lumap@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240105161413.10422-1-ach.lumap@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fbblWyIvL0TmnbsRMbVQkhR4eXNKxbSadeNan+nb3/6sf9jk/KT
 AoFBi8jKjlf/ybwboZPc3VgYaL1UqL0O3lxH03H7PQXo8azAGLg9MpaDyzsmKn4812K4r/D
 cxKphEU62XrmmPlHFjAoWHHeJHshKIN1kSJY3JZUPC+pY0Zopg3JHwktvCSGgCagCQcDm6w
 /Ke7qRiyQdwCf5uZbEU5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R63/kO4KaE0=;E7M5xab0gpEDlPINeGnW+Dpxjz7
 2l/p24QFG2J4Kcxs96aJl2ZTfKqCcBu3ZB4ICrVf69bUh7qQ9qMCcpaBKp+5gtrXRBbPwirPI
 v3jWX/ghkUYVWNJLg8vTvECq/qMsM/GhBMcu9dsaXqXr0th98TQ5kae1Ps99zNbDXfOoP/HOM
 XBDR/giwU+HxdJHOCUA5F6sRdfKNFlmcsjE+9pUZ4DWxw79PC8l/a9xe+kmErv7t8sqdfaxcW
 PF29r+/0bc16+1bB5elTEODD2kD1rfBB2mezE8sk9+gNOXgjfLOZQrI+BajFMjb2KJPbC2oB4
 ZQN9mIR7w62N0BUZ4NwiiDaPuX+KoIcRNNOB5sdMJ+i4wxe2Fei7nQ7YdOgjGCEpYh0wFrcDn
 MJwLweMlEzNnB1Fmohgkv4RkNQ/+LVSk0dkyeSsjW4OI7t3uZTkxoX15K8y74fQ95zxtGF+pB
 VDDvEDeX61ltrFspp0+MU6TO4fJRp4Ch2eAOwvVvKxLp3vN7oJ5pYpIfSw6epI/Yi6huYkYpU
 IKL6u7+sXS/A3s7k+uvNXTh+/Qf1yg+flrCEr//lnqzA3kAHqC1ggfyFuc0TFpoiyk7XH7CnJ
 rs9C8H5tTwn5dLP9f22JaVN7TKPhNWzDBSBuKuaQ3OGA4IF/HhtzWWG8r8uS7HakW6QYxEJvO
 FOhyZAzuygbdD6jUI753iZIfA1eKLGx5uVm3Y+1OGuZkrJ34EVLtGcr7Wobn/E90ZGW/MK+Yk
 PHj9JpCIjcx5HVUwvWPVxfxhjyoko3KIGukzQyy+1gmK6+Ig4JCwBeUqiM/HYvFdSVhC2g5SP
 lwbBW8gwngTzNCySPdATeXaz+ZEVRP1YmcfJpegMzWWGeM3Rtlypv3x0vHg3GyUOEJLzwopOs
 rFKS/MNCwoCQWL3Fi/rIl5+JC2/Kn1lF8MuDIgfX0fK2iIUpQokUJeGDkFENHGbCKHtA/B9Nj
 ik/9V3E1BiQYIaQtjdRLAl/NgKg=

Am 05.01.24 um 17:14 schrieb Achu Luma:
> In the recent codebase update (8bf6fbd00d (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
>
> This commit migrates the unit tests for C character classification
> functions (isdigit(), isspace(), etc) from the legacy approach
> using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
> to the new unit testing framework (t/unit-tests/test-lib.h).
>
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---

[snip]

> diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
> deleted file mode 100644
> index e5659df40b..0000000000
> --- a/t/helper/test-ctype.c
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#include "test-tool.h"
> -
> -static int rc;
> -
> -static void report_error(const char *class, int ch)
> -{
> -	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
> -	rc =3D 1;
> -}
> -
> -static int is_in(const char *s, int ch)
> -{
> -	/*
> -	 * We can't find NUL using strchr. Accept it as the first
> -	 * character in the spec -- there are no empty classes.
> -	 */
> -	if (ch =3D=3D '\0')
> -		return ch =3D=3D *s;
> -	if (*s =3D=3D '\0')
> -		s++;
> -	return !!strchr(s, ch);
> -}
> -
> -#define TEST_CLASS(t,s) {			\
> -	int i;					\
> -	for (i =3D 0; i < 256; i++) {		\
> -		if (is_in(s, i) !=3D t(i))	\
> -			report_error(#t, i);	\
> -	}					\
> -	if (t(EOF))				\
> -		report_error(#t, EOF);		\
> -}
> -
> -#define DIGIT "0123456789"
> -#define LOWER "abcdefghijklmnopqrstuvwxyz"
> -#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> -#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
> -#define ASCII \
> -	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> -	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> -	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
> -	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
> -	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
> -	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
> -	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
> -	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
> -#define CNTRL \
> -	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> -	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> -	"\x7f"
> -
> -int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
> -{
> -	TEST_CLASS(isdigit, DIGIT);
> -	TEST_CLASS(isspace, " \n\r\t");
> -	TEST_CLASS(isalpha, LOWER UPPER);
> -	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
> -	TEST_CLASS(is_glob_special, "*?[\\");
> -	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
> -	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
> -	TEST_CLASS(isascii, ASCII);
> -	TEST_CLASS(islower, LOWER);
> -	TEST_CLASS(isupper, UPPER);
> -	TEST_CLASS(iscntrl, CNTRL);
> -	TEST_CLASS(ispunct, PUNCT);
> -	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
> -	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
> -
> -	return rc;
> -}

[snip]

> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> new file mode 100644
> index 0000000000..3a338df541
> --- /dev/null
> +++ b/t/unit-tests/t-ctype.c
> @@ -0,0 +1,78 @@
> +#include "test-lib.h"
> +
> +static int is_in(const char *s, int ch)
> +{
> +	/*
> +	 * We can't find NUL using strchr. Accept it as the first
> +	 * character in the spec -- there are no empty classes.
> +	 */
> +	if (ch =3D=3D '\0')
> +		return ch =3D=3D *s;
> +	if (*s =3D=3D '\0')
> +		s++;
> +	return !!strchr(s, ch);
> +}
> +
> +/* Macro to test a character type */
> +#define TEST_CTYPE_FUNC(func, string) \
> +static void test_ctype_##func(void) { \
> +	for (int i =3D 0; i < 256; i++) { \
> +		if (!check_int(func(i), =3D=3D, is_in(string, i))) \
> +			test_msg("       i: 0x%02x", i); \
> +	} \
> +}
> +
> +#define TEST_CHAR_CLASS(class) TEST(test_ctype_##class(), #class " work=
s")
> +
> +#define DIGIT "0123456789"
> +#define LOWER "abcdefghijklmnopqrstuvwxyz"
> +#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
> +#define PUNCT "!\"#$%&'()*+,-./:;<=3D>?@[\\]^_`{|}~"
> +#define ASCII \
> +	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> +	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> +	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
> +	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
> +	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
> +	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
> +	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
> +	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
> +#define CNTRL \
> +	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
> +	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
> +	"\x7f"
> +
> +TEST_CTYPE_FUNC(isdigit, DIGIT)
> +TEST_CTYPE_FUNC(isspace, " \n\r\t")
> +TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
> +TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
> +TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
> +TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
> +TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~")
> +TEST_CTYPE_FUNC(isascii, ASCII)
> +TEST_CTYPE_FUNC(islower, LOWER)
> +TEST_CTYPE_FUNC(isupper, UPPER)
> +TEST_CTYPE_FUNC(iscntrl, CNTRL)
> +TEST_CTYPE_FUNC(ispunct, PUNCT)
> +TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
> +TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
> +
> +int cmd_main(int argc, const char **argv) {
> +	/* Run all character type tests */
> +	TEST_CHAR_CLASS(isspace);
> +	TEST_CHAR_CLASS(isdigit);
> +	TEST_CHAR_CLASS(isalpha);
> +	TEST_CHAR_CLASS(isalnum);
> +	TEST_CHAR_CLASS(is_glob_special);
> +	TEST_CHAR_CLASS(is_regex_special);
> +	TEST_CHAR_CLASS(is_pathspec_magic);
> +	TEST_CHAR_CLASS(isascii);
> +	TEST_CHAR_CLASS(islower);
> +	TEST_CHAR_CLASS(isupper);
> +	TEST_CHAR_CLASS(iscntrl);
> +	TEST_CHAR_CLASS(ispunct);
> +	TEST_CHAR_CLASS(isxdigit);
> +	TEST_CHAR_CLASS(isprint);
> +
> +	return test_done();
> +}
> --
> 2.42.0.windows.2
>

Quite an improvement over v3!  Now you only need to repeat the class
names once.

Can we do any better?  We could simply have one test per character per
class like this:

#define TEST_CHAR_CLASS(class, expect) \
	for (int i =3D 0; i < 256; i++) \
		TEST(check_int(class(i), =3D=3D, is_in(expect, i)),	\
		     "%s(0x%02x) works", #class, i)

Which would be used like this:

	TEST_CHAR_CLASS(isspace, " \n\r\t");

With that there is no need to define any functions anymore.  We also
don't need any custom output, as the test name includes the character
code.  Downside: We'd have thousands of tests.  But is that actually
a downside or is that how the unit test framework is supposed to be
used?

If we need to aggregate the results by class for some reason, we
could use strings, like we already do for defining the expected class
members.  We need special handling for NUL, as that character
terminates C strings, but we can put all other characters into a
string and then use check_str:

#define TEST_CHAR_CLASS(class, expect) \
	do { \
		int expect_nul =3D expect[0] =3D=3D '\0'; \
		char expect_rest[256] =3D {0}; \
		char actual_rest[256] =3D {0}; \
		for (int i =3D 1, j =3D 0; i < 256; i++) \
			if (strchr(&expect[expect_nul], i)) \
				expect_rest[j++] =3D i; \
		for (int i =3D 1, j =3D 0; i < 256; i++) \
			if (class(i) =3D=3D 1) \
				actual_rest[j++] =3D i; \
		TEST(check_int(class(0), =3D=3D, expect_nul) && \
		     check_str(actual_rest, expect_rest), \
		     #class " works"); \
	} while (0)

check_str escapes non-printable characters when reporting a mismatch,
so this shouldn't mess up your terminal.

By the way: Like the original code these checks are stricter than
required by the C standard in requiring the result to be 1 instead of
just true (any non-zero value).  Perhaps they should be relaxed.  But
that's a tangent and independent of the convergence to a unit test.

Ren=C3=A9

