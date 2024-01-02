Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05515ACE
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IqFRAOf/"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dbfbd2be99so3861068a34.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2024 10:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704221758; x=1704826558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THjO2THfkKuYIB4ouiPhHfVGB4IV/9kERoWKvlI6l4Q=;
        b=IqFRAOf/7SFir4xTjeLvKYJ7W4mj/Tg3sj0j3VvsNNO5f8GZucXJhIYRiS6Nz8lLxc
         LmgqHQ33UIcYulPy0yjxjaA2iXudprjcsl+eWmLb49KJlmoJhlprSL/0vyyqNS6Z4cvs
         ngeWwwiaqqGHWu/Phq6YMxehrjBkUEbMZv5PT4jtzQZ1cD4F4o6kgAFhN1bY4AQ1MRRg
         GhAsjTgdgbDVLtTrYFuTfZng/U0AVJu1+5GI6AhwOcfP0YViA9olKtZv8P4seB8tgjKm
         p3LqtpMnENVkSWd6gTgKNXFiAZ2AYDD4evzZO91e2jVKfUj4ZGjfnUMRsz8M4p0p0sIH
         aaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221758; x=1704826558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THjO2THfkKuYIB4ouiPhHfVGB4IV/9kERoWKvlI6l4Q=;
        b=uwHn/XaKFgiWotvSH0Vcbj8IA/W6ISH4UOOEISt/7IZYGjqsew+ZOnuPEgFmSvUBpk
         UiTjJtj7RAxYm3+jGj0gMOufR6aMVoSGnfhhbFXYhEqfUU3gnHDU8bkvB0jDKHoEt4eH
         3jrh98/jPYHPabayXDBa/yAxk7To4OpOMlSreixBug3Fee0IRRaJ9X6sqh5rz3Do3iOM
         MA/m05Lv+kr2KXqi1j3dfqxPhwSp08FQRfn2HIAoEUr9Is9V0PC2EDDiBd9s66r0CXJA
         naa8vK7xzcNZ3YaArkKNmsg9v8t6OYBmc0OgcM0H2c/55KZ3SvbjTkykbQkGin1IZP7N
         UaIA==
X-Gm-Message-State: AOJu0YwJ6GZeawX9oZ/KrBsFEW95JBS4MO8rW256b0rmbPmqaQmbdVY4
	OFw3OFrgJF4XnKu6ewuRMwbcg+q8+FVumQ==
X-Google-Smtp-Source: AGHT+IHrs34vGy35d6uMuO8iyoCSd59Dl/jxdu1VcpbltwwDFCPKGYH1LCCF9uX9YRST9AhYbgqC8g==
X-Received: by 2002:a9d:4d94:0:b0:6db:da6d:d4a7 with SMTP id u20-20020a9d4d94000000b006dbda6dd4a7mr7779337otk.8.1704221758466;
        Tue, 02 Jan 2024 10:55:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y20-20020a056830209400b006dc5adc53e6sm786805otq.78.2024.01.02.10.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:55:58 -0800 (PST)
Date: Tue, 2 Jan 2024 13:55:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Achu Luma <ach.lumap@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
Message-ID: <ZZRcPapIHFnyZTYB@nand.local>
References: <20231221231527.8130-1-ach.lumap@gmail.com>
 <xmqqsf3ohkew.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsf3ohkew.fsf@gitster.g>

On Tue, Dec 26, 2023 at 10:45:59AM -0800, Junio C Hamano wrote:
> Achu Luma <ach.lumap@gmail.com> writes:
>
> > diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
> > deleted file mode 100644
> > index e5659df40b..0000000000
> > --- a/t/helper/test-ctype.c
> > +++ /dev/null
> > @@ -1,70 +0,0 @@
> > -#include "test-tool.h"
> > -
> > -static int rc;
> > -
> > -static void report_error(const char *class, int ch)
> > -{
> > -	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
> > -	rc = 1;
> > -}
>
> So, if we have a is_foo() that characterises a byte that ought to
> be "foo" but gets miscategorised not to be "foo", we used to
> pinpoint exactly the byte value that was an issue.  We did not do
> any early return ...
>
> > ...
> > -#define TEST_CLASS(t,s) {			\
> > -	int i;					\
> > -	for (i = 0; i < 256; i++) {		\
> > -		if (is_in(s, i) != t(i))	\
> > -			report_error(#t, i);	\
> > -	}					\
> > -	if (t(EOF))				\
> > -		report_error(#t, EOF);		\
> > -}
>
> ... and reported for all errors in the "class".
>
> > diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
> > new file mode 100644
> > index 0000000000..41189ba9f9
> > --- /dev/null
> > +++ b/t/unit-tests/t-ctype.c
> > @@ -0,0 +1,76 @@
> > +#include "test-lib.h"
> > +
> > +static int is_in(const char *s, int ch)
> > +{
> > +	/*
> > +	 * We can't find NUL using strchr. Accept it as the first
> > +	 * character in the spec -- there are no empty classes.
> > +	 */
> > +	if (ch == '\0')
> > +		return ch == *s;
> > +	if (*s == '\0')
> > +		s++;
> > +	return !!strchr(s, ch);
> > +}
> > +
> > +/* Macro to test a character type */
> > +#define TEST_CTYPE_FUNC(func, string)			\
> > +static void test_ctype_##func(void)				\
> > +{								\
> > +	int i;                                     	 	\
> > +	for (i = 0; i < 256; i++)                 		\
> > +		check_int(func(i), ==, is_in(string, i)); 	\
> > +}
>
> Now, we let check_int() to do the checking for each and every byte
> value for the class.  check_int() uses different reporting and shows
> the problematic value in a way that is more verbose and at the same
> time is a less specific and harder to understand:
>
> 		test_msg("   left: %"PRIdMAX, a);
> 		test_msg("  right: %"PRIdMAX, b);
>
> But that is probably the price to pay to use a more generic
> framework, I guess.

Perhaps I'm missing something here, since I haven't followed the
unit-test effort very closely, but this check_int() macro feels like it
might be overkill for what we're trying to do.

We know that the expected value is the result of is_in(string, i), so I
wonder if we might benefit from having an "assert_equals()" that looks
like:

    assert_equals(is_in(string, i), func(i));

Where we follow the usual convention of treating the first argument as
the expected value, and the second as the actual value. Then we could
format our error message to be more specific, like:

    test_msg("expected %d, got %d", expected, actual);

I think that this would be a little more readable, and still seems
flexible enough to support the kind of thing that check_int(..., ==,
...) is after.

> > +int cmd_main(int argc, const char **argv) {
> > +	/* Run all character type tests */
> > +	TEST(test_ctype_isspace(), "isspace() works as we expect");
> > +	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
> > +	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
> > +	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
> > +	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect");
> > +	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expect");
> > +	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we expect");
> > +	TEST(test_ctype_isascii(), "isascii() works as we expect");
> > +	TEST(test_ctype_islower(), "islower() works as we expect");
> > +	TEST(test_ctype_isupper(), "isupper() works as we expect");
> > +	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
> > +	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
> > +	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
> > +	TEST(test_ctype_isprint(), "isprint() works as we expect");
> > +
> > +	return test_done();
> > +}
>
> As a practice to use the unit-tests framework, the patch looks OK.
> helper/test-ctype.c indeed is an oddball that runs once and checks
> everything it wants to check, for which the unit tests framework is
> much more suited.

As an aside, I don't think we need the "works as we expect" suffix in
each test description. I personally would be fine with something like:

    TEST(test_ctype_isspace(), "isspace()");
    TEST(test_ctype_isdigit(), "isdigit()");
    ...

But don't feel strongly about it.

Thanks,
Taylor
