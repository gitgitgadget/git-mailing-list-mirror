Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963516128
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agKAa7t8"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5747E5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:15:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so3873104a12.2
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698437720; x=1699042520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPPP6mwaU7f0JTo0p75RrARZsCppV5FVPwIIx9A9+hM=;
        b=agKAa7t8hUmzy8mR2NL6GubR4ytsyRAxXx3DGHqAW+QE4qv5zrsow9+dlaxeAZK8rm
         WFphp19YVWKY3LubAoRkltbn0l4Mhh0jWt5KhbzqIUuTi3HZ6bVN+qjTlZf9VLLLj54K
         H4dVrSN7r41jXJhjo88QXwIfWUIqPCl7AbqOdsiNitfCbZgvu+zWFKW4G6KxhcxrrLKe
         2LEsehwxu8rodeO7OLx0WMSdphqpJd2jrMIsNC+/MhOrn2UczYA6wB4jYuiaE9rNbl4L
         /2vWiMgHxWjKscmm2LFDcqTFWXtSzeufXJgQPP85HR//3Qi11xeAhFG+KpvTzXHhEXug
         gZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698437720; x=1699042520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPPP6mwaU7f0JTo0p75RrARZsCppV5FVPwIIx9A9+hM=;
        b=IQL/XyYqTaTkJqvkB1O9zQTs/sk8r6e2CMNltuoT5nDlMQCHSRNiv8GK+xLoAe0zh/
         kblCCmRZdCxkAZVuJs9ttmOs+PJMDSwhH92yTD3FQWVCkc1rocWh+emRnG7vEynTsEz9
         gZLSI68Gtiqsq919DMSX/R3er7McmZ2HfTQ92jgf5Yep2x3bHmBrkb7QlfEXkb7P77Js
         ebsnxhaORKF8D/xoxvLC11FxM+HA7iWNcjfuhiVPD7ip1VvUNX/IC859QDYZgr1N46WC
         DzjSPz3WS0cvArx+trsKKGYGLr7Yjpq7iUOITSEuv/CmCaOyhWoNkKGoVbqDZmN0SJ9/
         Eolg==
X-Gm-Message-State: AOJu0YxNENZvx7ZU82z55id41iGVN+ktwpBL71ypOkT54AeqnEkExqo7
	XmOtBIGHoy3ASiNUNz2WDNI9XrnfYo0aZV7X9w8=
X-Google-Smtp-Source: AGHT+IGUlySJu1S1eEWzCBSnGEUYVP6ExkVM4YQWAoQp99igDUKdq6b86Kqu207UgkGbzAG8FQa0Z2s/ZykuOVh0zNE=
X-Received: by 2002:aa7:d0d8:0:b0:53f:a3de:4b2f with SMTP id
 u24-20020aa7d0d8000000b0053fa3de4b2fmr3095059edo.33.1698437720075; Fri, 27
 Oct 2023 13:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com> <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
In-Reply-To: <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Oct 2023 22:15:08 +0200
Message-ID: <CAP8UFD3eY_i36YO0OcpAp9ey5KO0q-PrwvjSLRXKYQb=iZ8JCA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] unit tests: add TAP unit test framework
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com, 
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 12:22=E2=80=AFAM Josh Steadmon <steadmon@google.com=
> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This patch contains an implementation for writing unit tests with TAP
> output. Each test is a function that contains one or more checks. The
> test is run with the TEST() macro and if any of the checks fail then the
> test will fail. A complete program that tests STRBUF_INIT would look
> like
>
>      #include "test-lib.h"
>      #include "strbuf.h"
>
>      static void t_static_init(void)
>      {
>              struct strbuf buf =3D STRBUF_INIT;
>
>              check_uint(buf.len, =3D=3D, 0);
>              check_uint(buf.alloc, =3D=3D, 0);
>              check_char(buf.buf[0], =3D=3D, '\0');
>      }
>
>      int main(void)
>      {
>              TEST(t_static_init(), "static initialization works);
>
>              return test_done();
>      }
>
> The output of this program would be
>
>      ok 1 - static initialization works
>      1..1
>
> If any of the checks in a test fail then they print a diagnostic message
> to aid debugging and the test will be reported as failing. For example a
> failing integer check would look like
>
>      # check "x >=3D 3" failed at my-test.c:102

I wonder if it would be a bit better to say that the test was an
integer test for example with "check_int(x >=3D 3) failed ..."

>      #    left: 2
>      #   right: 3

I like "expected" and "actual" better than "left" and "right", not
sure how it's possible to have that in a way consistent with the shell
tests though.

>      not ok 1 - x is greater than or equal to three
>
> There are a number of check functions implemented so far. check() checks
> a boolean condition, check_int(), check_uint() and check_char() take two
> values to compare and a comparison operator. check_str() will check if
> two strings are equal. Custom checks are simple to implement as shown in
> the comments above test_assert() in test-lib.h.

Yeah, nice.

> Tests can be skipped with test_skip() which can be supplied with a
> reason for skipping which it will print. Tests can print diagnostic
> messages with test_msg().  Checks that are known to fail can be wrapped
> in TEST_TODO().

Maybe TEST_TOFIX() would be a bit more clear, but "TODO" is something
that is more likely to be searched for than "TOFIX", so Ok.

> There are a couple of example test programs included in this
> patch. t-basic.c implements some self-tests and demonstrates the
> diagnostic output for failing test. The output of this program is
> checked by t0080-unit-test-output.sh. t-strbuf.c shows some example
> unit tests for strbuf.c
>
> The unit tests will be built as part of the default "make all" target,
> to avoid bitrot. If you wish to build just the unit tests, you can run
> "make build-unit-tests". To run the tests, you can use "make unit-tests"
> or run the test binaries directly, as in "./t/unit-tests/bin/t-strbuf".

Nice!

> +unit-tests-prove:
> +       @echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(=
UNIT_TESTS)

Nice, but DEFAULT_TEST_TARGET=3Dprove isn't used. So not sure how
important or relevant the 'prove' related sections are in the
Documentation/technical/unit-tests.txt file introduced by the previous
patch.


> +int test_assert(const char *location, const char *check, int ok)
> +{
> +       assert(ctx.running);
> +
> +       if (ctx.result =3D=3D RESULT_SKIP) {
> +               test_msg("skipping check '%s' at %s", check, location);
> +               return 1;
> +       } else if (!ctx.todo) {

I think it would be a bit clearer without the "else" above and with
the "if (!ctx.todo) {" starting on a new line.

> +               if (ok) {
> +                       test_pass();
> +               } else {
> +                       test_msg("check \"%s\" failed at %s", check, loca=
tion);
> +                       test_fail();
> +               }
> +       }
> +
> +       return !!ok;
> +}

Otherwise it looks good to me.
