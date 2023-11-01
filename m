Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BD33FA
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXkiehJI"
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD480110
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 15:54:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso367626b3a.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2023 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698879288; x=1699484088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VXXEL1reBvBRfpxjTTUrshJcL/6MWAVqmA6ZrRpXIg=;
        b=QXkiehJIK011VsTWjT+Nm9bD9UhcEQvJGUkOOfSuD5XHqJNN0YAZaoDW5Iz9I4zQNk
         clbYf+jM6qQMaKW5xB0QHZdh4pOMxtf7vEKkMtOVgBaQFbLSwy0DFxFCwXb9i3Ix5+2e
         yI8OgLG7Ye07YUx+vwFNPZsoVMguvDSXD6ZgPy3DVQ7ZJrut4+P3Ov8YHoOYqt240KR3
         AKkhwZXhJSweYr/eYz5b80mTRy0kfbw0FrUk34qvWgEM3rziwwUya6ivJqF1AoAwdDlF
         Ee2i2Fapc6ODGmG3ZfpQmIr6JT2seFPFkCdNu6hA2/Zm7JfSIM+5hUH2BhzeZKTXTlgL
         PHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879288; x=1699484088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VXXEL1reBvBRfpxjTTUrshJcL/6MWAVqmA6ZrRpXIg=;
        b=ccfN47DOiAbi2Xf3hDelm4Um1Um3qupd78+Q6Oe/4ABiqFWmdhhJyfi64gHoaCK1f2
         SapUtolv3KMYq9k1SMPxKCz035mfrVY/yrpj5zhvhLWxc8VRLbEsP1snW049xINe3WOd
         FboYDATfO+5kwHkhPOLEKAl8KipCjq/PGCojwbExqFyB5fH/fXLnc24zw7wIcF0iwb2x
         qqICy9HglmmgSLlfUnY2A2auh0jDcarv0nbcflLrtXH2Rqkb9zouqrfKSRv/lF+tCwm4
         k6JYtfrv+7zlvkqgeJb/8Pbn52SJahO9Uif0tMXAdLQ3WQfoJMO6T5CrwkgAuZNIB+G+
         hDig==
X-Gm-Message-State: AOJu0YxVhsv1hCniXSy4gBqXtQTr9D8UI2ehXPUIztPbtmBthzl1kuzD
	2iTqt5PlL2DXJb7J0tumhtraC6vWLTdPb3PbPL60qg==
X-Google-Smtp-Source: AGHT+IHTwxzFwdAXql9xavj4dTSJ+wdXwtQhNFKVwheDDqh5wt3eEqRTSgmwFAMxeNQF/jgpxie8Tw==
X-Received: by 2002:a05:6a20:8f03:b0:13d:5b8e:db83 with SMTP id b3-20020a056a208f0300b0013d5b8edb83mr18713454pzk.9.1698879287957;
        Wed, 01 Nov 2023 15:54:47 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fc30:220:f2fb:969])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b001c444f185b4sm1760425plg.237.2023.11.01.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:54:47 -0700 (PDT)
Date: Wed, 1 Nov 2023 15:54:42 -0700
From: Josh Steadmon <steadmon@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
	calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 2/3] unit tests: add TAP unit test framework
Message-ID: <ZULXMhD0ajESkde5@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
	gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <00d3c95a81449bf49c4ce992d862d7a858691840.1696889530.git.steadmon@google.com>
 <CAP8UFD3eY_i36YO0OcpAp9ey5KO0q-PrwvjSLRXKYQb=iZ8JCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3eY_i36YO0OcpAp9ey5KO0q-PrwvjSLRXKYQb=iZ8JCA@mail.gmail.com>

On 2023.10.27 22:15, Christian Couder wrote:
> On Tue, Oct 10, 2023 at 12:22 AM Josh Steadmon <steadmon@google.com> wrote:
> >
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > This patch contains an implementation for writing unit tests with TAP
> > output. Each test is a function that contains one or more checks. The
> > test is run with the TEST() macro and if any of the checks fail then the
> > test will fail. A complete program that tests STRBUF_INIT would look
> > like
> >
> >      #include "test-lib.h"
> >      #include "strbuf.h"
> >
> >      static void t_static_init(void)
> >      {
> >              struct strbuf buf = STRBUF_INIT;
> >
> >              check_uint(buf.len, ==, 0);
> >              check_uint(buf.alloc, ==, 0);
> >              check_char(buf.buf[0], ==, '\0');
> >      }
> >
> >      int main(void)
> >      {
> >              TEST(t_static_init(), "static initialization works);
> >
> >              return test_done();
> >      }
> >
> > The output of this program would be
> >
> >      ok 1 - static initialization works
> >      1..1
> >
> > If any of the checks in a test fail then they print a diagnostic message
> > to aid debugging and the test will be reported as failing. For example a
> > failing integer check would look like
> >
> >      # check "x >= 3" failed at my-test.c:102
> 
> I wonder if it would be a bit better to say that the test was an
> integer test for example with "check_int(x >= 3) failed ..."
> 
> >      #    left: 2
> >      #   right: 3
> 
> I like "expected" and "actual" better than "left" and "right", not
> sure how it's possible to have that in a way consistent with the shell
> tests though.

I also prefer expected/actual, but I don't think it's possible where we
accept arbitrary operators, and I don't want to plumb a flag through to
specify whether to display left/right vs expected/actual.


> >      not ok 1 - x is greater than or equal to three
> >
> > There are a number of check functions implemented so far. check() checks
> > a boolean condition, check_int(), check_uint() and check_char() take two
> > values to compare and a comparison operator. check_str() will check if
> > two strings are equal. Custom checks are simple to implement as shown in
> > the comments above test_assert() in test-lib.h.
> 
> Yeah, nice.
> 
> > Tests can be skipped with test_skip() which can be supplied with a
> > reason for skipping which it will print. Tests can print diagnostic
> > messages with test_msg().  Checks that are known to fail can be wrapped
> > in TEST_TODO().
> 
> Maybe TEST_TOFIX() would be a bit more clear, but "TODO" is something
> that is more likely to be searched for than "TOFIX", so Ok.
> 
> > There are a couple of example test programs included in this
> > patch. t-basic.c implements some self-tests and demonstrates the
> > diagnostic output for failing test. The output of this program is
> > checked by t0080-unit-test-output.sh. t-strbuf.c shows some example
> > unit tests for strbuf.c
> >
> > The unit tests will be built as part of the default "make all" target,
> > to avoid bitrot. If you wish to build just the unit tests, you can run
> > "make build-unit-tests". To run the tests, you can use "make unit-tests"
> > or run the test binaries directly, as in "./t/unit-tests/bin/t-strbuf".
> 
> Nice!
> 
> > +unit-tests-prove:
> > +       @echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
> 
> Nice, but DEFAULT_TEST_TARGET=prove isn't used. So not sure how
> important or relevant the 'prove' related sections are in the
> Documentation/technical/unit-tests.txt file introduced by the previous
> patch.

The "unit-tests" target runs DEFAULT_UNIT_TEST_TARGET, which can be
overridden to "unit-tests-prove".


> > +int test_assert(const char *location, const char *check, int ok)
> > +{
> > +       assert(ctx.running);
> > +
> > +       if (ctx.result == RESULT_SKIP) {
> > +               test_msg("skipping check '%s' at %s", check, location);
> > +               return 1;
> > +       } else if (!ctx.todo) {
> 
> I think it would be a bit clearer without the "else" above and with
> the "if (!ctx.todo) {" starting on a new line.

Fixed in v9.


> > +               if (ok) {
> > +                       test_pass();
> > +               } else {
> > +                       test_msg("check \"%s\" failed at %s", check, location);
> > +                       test_fail();
> > +               }
> > +       }
> > +
> > +       return !!ok;
> > +}
> 
> Otherwise it looks good to me.

Thanks for the review!
