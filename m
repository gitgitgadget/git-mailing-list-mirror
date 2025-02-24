Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD9524F5A7
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388306; cv=none; b=Estlvk/HXqKoH5hAxFxDokJQ9gD05nuh0l5EDNOMP1+fAVeeLMgd6iFLg7b9PtLHV8iHme576KjhPCA3QSjVsReLzKS6IetUsP9bbzUTe1zjr1RsWsLHeE9myC5IFpEhEB9Fa8IimToGIX5PthLahVlGaVRgysobnvz+bsM2tIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388306; c=relaxed/simple;
	bh=4WKNnffzZ6QT5I4flTABEd9UQ1duiRxJBrBanQ2tQX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8WpyRp30vS5OQjqEvwV+XUdFGODMipc4JMN8mGAVdYDdnLWoEDNScYGzVqvW//pfoPasmJbtasvjN+hpKCW84AxisWGCyzL9OmUEZuUaJIP0w0iMVIYdbR0MeByOjH+9FSNzmhaaCGhY2ZrKy3nXLWvkTI42HEQLiCOK9zmcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ8OlCnT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ8OlCnT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f666c94285so35896677b3.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 01:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740388304; x=1740993104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KsqRSRV3OXMiMSUxVOadWGk0jPc+6q2gdqUPMqpvilU=;
        b=lJ8OlCnTO52aVNnnsJIPWsv9jS3es4qvmQkWcGjt86xrX45Mv5URhEq+b+pJW89wL9
         x6LB9GlU4mq9c9QepkrQajoPLRF9bIAPFjajig0A970RfHQ65SfTSG/1VFk5JqLN16Wi
         MvbWTUEqDHvOgOgQbbzwuLmUPmUbsdFhttmMqFU8vXkJ5He/C1x71+YgrTVROOZrMsZS
         gN9zdzGh+cTYsHPdNMCOYA+7agtIU0hCkQf8TC0g6GuFbAFZLJO5a9GsWbXt3CbgAif4
         d3hZWHm0IqL1zDJ5QY+P3223h/WwBnWVy/fPwPBxKo7XH8AiUTUY5ni+P/4guExLPZh4
         6EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388304; x=1740993104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsqRSRV3OXMiMSUxVOadWGk0jPc+6q2gdqUPMqpvilU=;
        b=c+8+7J/JfnKPbHZ+PE4HTkuzwED9mhTQMWFzv3YcccTNetq89sM0Zo6qg5J1FPkKNE
         B1rYWDzAnm923V+KOIWhPjX6+eSrmGJyB310L8zkKP6MA2m9X7E6crPEWOg5t5n/tGuG
         5xl1rJv56UOxab7QQ+3xK/RkvCFVw2Je2H6JZIy+QJaj34VB9/j+XqtfB2GF7jiv+2eI
         1rsmIghAWq9228JVVbjjXvqnlUu9gjVCQ2ADLJPtYHvER1jP7BfIMggPaD2kRox7gcRk
         Zq7FOwm9bsb5JTFnOb3Zq520hRX/uWRuE48vZvTuixMOAJqVhucWzDJT01G8YQbsoOaW
         sUfw==
X-Gm-Message-State: AOJu0YxOAyDt5vr95T4q6mcLz0SBT03K7HoM/p75NrZjbZAGQE4FzzYG
	Sq+aesfhpgKp2RqdSOadxqBmU+HDsFvoJOvTslc3SLL0sbBl0w5Qm1lmYIFi5XSUKxgtJKS7Fjf
	HfyigzV+ENAwLW4UsQ4rF8GTYPKM=
X-Gm-Gg: ASbGncuE3giS/+bSl2DCdMEQGYh3TICpVMPOdHvP6wCC+uy2dq3fE5zxV7PvHmNkUQb
	QJkGm8fSvm5mh+k3s0bnVnqL7uBYuzYgUje877d79L8WX6NTDOqbXsizO6URWVtKLtzV9iWTNgA
	1XedtMXZs=
X-Google-Smtp-Source: AGHT+IFqAkUjwQqiH/umUuRSzdayX/092h5gqb9JZvlvBgyFnx3sm8/y0Uu3iGoDu/aui+JxoaAbcWaUAu42JmLmu34=
X-Received: by 2002:a05:690c:6a12:b0:6ef:5097:5daa with SMTP id
 00721157ae682-6fbcc856ce4mr105143937b3.34.1740388303817; Mon, 24 Feb 2025
 01:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220082959.10854-1-kuforiji98@gmail.com> <20250220082959.10854-3-kuforiji98@gmail.com>
 <cf9d44d0-20ed-4d8f-84a3-1bf284075605@gmail.com>
In-Reply-To: <cf9d44d0-20ed-4d8f-84a3-1bf284075605@gmail.com>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Mon, 24 Feb 2025 10:11:32 +0100
X-Gm-Features: AWEUYZmnFrlgUFEFHyxrSMYR3YdlnbVkF1BhS8VnJJlcu5w6X2Vikb2ktfpdFP8
Message-ID: <CAGedMtfgYzEBFe7_jghhJRHt5MXAesc+GfJXDDgP=BLg8LeRyg@mail.gmail.com>
Subject: Re: [PATCH 2/5] t/unit-tests: convert oid-array test to use clar
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 15:38, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Seyi
>
> On 20/02/2025 08:29, Seyi Kuforiji wrote:
> > Adapt oid-array test script to clar framework by using clar assertions
> > where necessary. Remove descriptions from macros to reduce
> > redundancy, and move test input arrays to global scope for reuse across
> > multiple test functions. Introduce `test_oid_array__initialize()` to
> > explicitly initialize the hash algorithm.
> >
> > These changes streamline the test suite, making individual tests
> > self-contained and reducing redundant code.
>
> I think these conversion look correct but once again we're losing
> valuable debugging information because we haven't added better
> assertions to clear.
>

I understand your concern about losing debugging information, but it
is more beneficial to prioritize clarity and simplicity in unit tests.
Unit tests should be short and easy, and adding extra debugging
messages increases complexity, making them harder to maintain and
read. The assertion failures already indicate where an issue occurs,
allowing whoever is debugging to inspect the test inputs directly if
needed.

Assertion failures are rarely hit in real-world scenarios, and when
they do occur, one can manually print values or use a debugger to
investigate. This makes the additional debugging messages unnecessary
in most cases. The lack of explicit debugging output is not a
significant issue in practice. Furthermore, there are plans to
collaborate with Clar upstream to equip common assertions with the
ability to print custom messages in a formatted string where an error
occurs. This would allow our test to be simple and easy to read and
also maintain some of our custom debug messages.



> >       oid_array_for_each_unique(&input, add_to_oid_array, &actual);
> > -     if (!check_uint(actual.nr, ==, expect.nr))
> > -             return;
> > -
> > -     for (i = 0; i < actual.nr; i++) {
> > -             if (!check(oideq(&actual.oid[i], &expect.oid[i])))
> > -                     test_msg("expected: %s\n       got: %s\n     index: %" PRIuMAX,
> > -                              oid_to_hex(&expect.oid[i]), oid_to_hex(&actual.oid[i]),
> > -                              (uintmax_t)i);
> > -     }
> > +     cl_assert_equal_i(actual.nr, expect.nr);
> > +
> > +     for (i = 0; i < actual.nr; i++)
> > +             cl_assert(oideq(&actual.oid[i], &expect.oid[i]));
>
> If this fails the poor person debugging it will have no idea why as
> there is now no indication of which two oids were being compared.
>
> > -     if (!check_int(ret, <=, upper_bound) ||
> > -         !check_int(ret, >=, lower_bound))
> > -             test_msg("oid query for lookup: %s", oid_to_hex(&oid_query));
> > +     cl_assert(ret <= upper_bound);
> > +     cl_assert(ret >= lower_bound);
>
> This is another case where we could do with better assertions in clar
>
> > -static void setup(void)
> > +void test_oid_array__initialize(void)
> >   {
> >       /* The hash algo is used by oid_array_lookup() internally */
> >       int algo = init_hash_algo();
> > -     if (check_int(algo, !=, GIT_HASH_UNKNOWN))
> > -             repo_set_hash_algo(the_repository, algo);
> > +     cl_assert(algo != GIT_HASH_UNKNOWN);
>
> init_has_algo() in unit-test.c already does this.
>

Thanks for spotting this! Will fix this in an updated patch.
> Best Wishes
>
> Phillip
>
>
> > +     repo_set_hash_algo(the_repository, algo);
> >   }
> >
> > -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> > +static const char *arr_input[] = { "88", "44", "aa", "55" };
> > +static const char *arr_input_dup[] = { "88", "44", "aa", "55",
> > +                                    "88", "44", "aa", "55",
> > +                                    "88", "44", "aa", "55" };
> > +static const char *res_sorted[] = { "44", "55", "88", "aa" };
> > +
> > +void test_oid_array__enumerate_unique(void)
> >   {
> > -     const char *arr_input[] = { "88", "44", "aa", "55" };
> > -     const char *arr_input_dup[] = { "88", "44", "aa", "55",
> > -                                     "88", "44", "aa", "55",
> > -                                     "88", "44", "aa", "55" };
> > -     const char *res_sorted[] = { "44", "55", "88", "aa" };
> > -     const char *nearly_55;
> > +     TEST_ENUMERATION(arr_input, res_sorted);
> > +}
> > +
> > +void test_oid_array__enumerate_duplicate(void)
> > +{
> > +     TEST_ENUMERATION(arr_input_dup, res_sorted);
> > +}
> > +
> > +void test_oid_array__lookup(void)
> > +{
> > +     TEST_LOOKUP(arr_input, "55", 1, 1);
> > +}
> >
> > -     if (!TEST(setup(), "setup"))
> > -             test_skip_all("hash algo initialization failed");
> > +void test_oid_array__lookup_non_existent(void)
> > +{
> > +     TEST_LOOKUP(arr_input, "33", INT_MIN, -1);
> > +}
> > +
> > +void test_oid_array__lookup_duplicates(void)
> > +{
> > +     TEST_LOOKUP(arr_input_dup, "55", 3, 5);
> > +}
> >
> > -     TEST_ENUMERATION(arr_input, res_sorted, "ordered enumeration");
> > -     TEST_ENUMERATION(arr_input_dup, res_sorted,
> > -                      "ordered enumeration with duplicate suppression");
> > +void test_oid_array__lookup_non_existent_dup(void)
> > +{
> > +     TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1);
> > +}
> >
> > -     TEST_LOOKUP(arr_input, "55", 1, 1, "lookup");
> > -     TEST_LOOKUP(arr_input, "33", INT_MIN, -1, "lookup non-existent entry");
> > -     TEST_LOOKUP(arr_input_dup, "55", 3, 5, "lookup with duplicates");
> > -     TEST_LOOKUP(arr_input_dup, "66", INT_MIN, -1,
> > -                 "lookup non-existent entry with duplicates");
> > +void test_oid_array__lookup_almost_dup(void)
> > +{
> > +     const char *nearly_55;
> >
> >       nearly_55 = init_hash_algo() == GIT_HASH_SHA1 ?
> >                       "5500000000000000000000000000000000000001" :
> >                       "5500000000000000000000000000000000000000000000000000000000000001";
> > -     TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0,
> > -                 "lookup with almost duplicate values");
> > -     TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1,
> > -                 "lookup with single duplicate value");
> >
> > -     return test_done();
> > +     TEST_LOOKUP(((const char *[]){ "55", nearly_55 }), "55", 0, 0);
> > +}
> > +
> > +void test_oid_array__lookup_single_dup(void)
> > +{
> > +     TEST_LOOKUP(((const char *[]){ "55", "55" }), "55", 0, 1);
> >   }
>

Thanks
Seyi
