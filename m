Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908F1487E9
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361671; cv=none; b=tu17/SZQo25mLFc/JmK8pa0XXezpF+qHMKNYaDmhSKPdpjLQ7QX8wOVtMbK3O3zlfBP16LXT4Wamr9dXWeNo/AdrlXIJ+qV0P/Gj3UR1roficWkV/mSGph+eS+PCTrfKGeAB3i06aMBDO4WGkByYguJH7sKwNBZrngHAZCawZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361671; c=relaxed/simple;
	bh=iyfEcxzIwUSUZbOWyyK2tNtJJzXZXHuBgYklmp7aTzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et33QZEazlAvYGBhhdVYvZIGtp1QR/EWxPFh1zBOYdPJmfaOEDOq+QX04QNt8cnrWAgwgIFAQMLf3X340byYg/2iAanJQbKLh4WmuaodtDFJ4WZMXWlp5ugAUPoldVtROu1FA9FTTSe6yLbB1Af284GKe3ZIeP1ZZUxHNslVz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHCogmYe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHCogmYe"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab925654d9so477545966b.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738361667; x=1738966467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yCg5+qcR4FmF6UHcRVoFmef81DNhGv9qYkWgP4TTmA=;
        b=GHCogmYe8URp1Ttrj6VoxhKix2KxI3aKTumNqm2sbRt6U2RHmAI82M5teLY4fMVslk
         dfH9/8kPePueeIx/yY/Z33RyeYQeD7orKhnY4Eytx3ApVQngzqVAd25vB/QOANoWr2mH
         pL8ETY4/sZzI+HVs3L3kC40528FJ8/Nlz3LJsGvXL2AVjcqoezYiAbNgUmg2TF76c95w
         tcAe7l0RADFRqoViqk39Hp+7+bXV7E/ZfXL+5gLsnB8zdthbOcYaK+LLmobVympdkCoX
         0YfzeUOIkLLWjUVvKmkWkSFnMxfPzOwtvBdV8yXVHnb8CqD48R4/BTRhsqx0dFZxux0S
         NlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361667; x=1738966467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yCg5+qcR4FmF6UHcRVoFmef81DNhGv9qYkWgP4TTmA=;
        b=wxS62IVASos7TeIwcKy3mREFACkh/g4W/CBbs8KHss87GpbZf7AdsyH2Y1fxPZBRz/
         o4dwgrxlO0bCybL6w4lJvQYE7qApH3/ZTffQwDkIA3gTH9m+UH4J+yx1nTZl+Q8kpPok
         III0iJKx+TaNYJtHGHvAAkoYUCgknDsciplsj5rslsZxpgO35+e6xoDg8Kz/F8liSyl0
         wFutE1wFzGNnV5x+XOXVIA0On23fpap9pe8n+IbmHGaduG41S52rPQ33T2hGgjxIITLI
         UZtuOUy/KN7ZMpW0zx3yPIRxeplhUy4xZN4vnuXxvZ4mAVZFpAqhRQklz7hHovhQsMW7
         +JQA==
X-Gm-Message-State: AOJu0YyhWMeOqXNELneOvrpHRHeBmn2fch8PvuL6R/UUOLde+YiWGFAF
	8a2b4Uh0aaKlfJNRDI2x2pPhWTEaq7mExa9PIAagXekW/qgCV4mp449kXAPfBwhy0Q==
X-Gm-Gg: ASbGncsQbgy9Zvf5hZYvmBDF1vPH1AnLb8iqzIPeurtd1TPpo46x3E811+f88rjDUHW
	dImGydN1fiKwLJZWlCV+RI/SGUqoTzE+wDk9DPUETc+q9JoEBdQjBWgCQz6247Xh7+nL6mWtKDs
	TYBsMdINVBGrlrWaiXxor+DwBS5gMpXzQx0nFzLgJJ6niT8qO5Gk15pjqTPRRXVGhL4JOhGDW6v
	ExZ/j5+oC3tt6+wiacVbdzN8yqtHOxfUcWB1a6F29mDJOyt3BbO+3O+XMPrkS7qU101VX0wF2Qs
	FcT6KmPFBzieItanssnW5EQ8X30H2TA=
X-Google-Smtp-Source: AGHT+IGcy/RAas7B6dA3cF3CoKkdFRrofzk7pX/BVQZaEr66bRHEnPzhJ4QRpZXEutVHY4xzz4d+Fg==
X-Received: by 2002:a17:906:7949:b0:ab7:c25:7afd with SMTP id a640c23a62f3a-ab70c257ccamr182220766b.0.1738361666711;
        Fri, 31 Jan 2025 14:14:26 -0800 (PST)
Received: from localhost.localdomain ([154.120.111.177])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e49ff77fsm359288966b.108.2025.01.31.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 14:14:26 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 0/4] t/unit-tests: convert unit-tests to use clar
Date: Fri, 31 Jan 2025 23:14:16 +0100
Message-ID: <20250131221420.38161-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250130091334.39922-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions the existing unit test files to the
Clar testing framework. This change is part of our ongoing effort to
standardize our testing approach and enhance maintainability.

Changes in v2:
- small fixes to the commit messages and how they read
- some small code fix up and refactoring

Thanks
Seyi

Mentored-by: Patrick Steinhardt ps@pks.im
Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com

Seyi Kuforiji (4):
  t/unit-tests: convert hashmap test to use clar test framework
  t/unit-tests: adapt example decorate test to use clar test framework
  t/unit-tests: convert strbuf test to use clar test framework
  t/unit-tests: convert strcmp-offset test to use clar test framework

 Makefile                                      |   8 +-
 t/meson.build                                 |   8 +-
 ...xample-decorate.c => u-example-decorate.c} |  76 +++---
 t/unit-tests/{t-hashmap.c => u-hashmap.c}     | 226 +++++++++---------
 t/unit-tests/{t-strbuf.c => u-strbuf.c}       | 115 +++++----
 .../{t-strcmp-offset.c => u-strcmp-offset.c}  |  36 ++-
 6 files changed, 232 insertions(+), 237 deletions(-)
 rename t/unit-tests/{t-example-decorate.c => u-example-decorate.c} (30%)
 rename t/unit-tests/{t-hashmap.c => u-hashmap.c} (60%)
 rename t/unit-tests/{t-strbuf.c => u-strbuf.c} (35%)
 rename t/unit-tests/{t-strcmp-offset.c => u-strcmp-offset.c} (39%)

Range-diff against v1:
1:  90accb2f75 ! 1:  19697be26b t/unit-tests: convert hashmap test to use clar test framework
    @@ Commit message
         t/unit-tests: convert hashmap test to use clar test framework
     
         Adapts hashmap test script to clar framework by using clar assertions
    -    where necessary. Test functions are created as both standalone and
    -    inline to test different test cases.
    +    where necessary.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
    @@ t/unit-tests/u-hashmap.c: static void t_add(struct hashmap *map, unsigned int ig
     -			}
     +			int ret = key_val_contains(key_val, seen,
     +						   ARRAY_SIZE(key_val), entry);
    -+			cl_assert(ret == 0);
    ++			cl_assert_equal_i(ret, 0);
     +			count++;
      		}
     -		check_int(count, ==, 2);
    @@ t/unit-tests/u-hashmap.c: static void t_iterate(struct hashmap *map, unsigned in
     -			}
     -		}
     +		int ret = key_val_contains(key_val, seen,
    -+						ARRAY_SIZE(key_val),
    -+						entry);
    ++					   ARRAY_SIZE(key_val),
    ++					   entry);
     +		cl_assert(ret == 0);
      	}
      
2:  13a407d504 ! 2:  1d8f8974a5 t/unit-tests: adapt example decorate test to use clar test framework
    @@ Metadata
      ## Commit message ##
         t/unit-tests: adapt example decorate test to use clar test framework
     
    -    Adapts example decorate test script to clar framework by using clar
    -    assertions where necessary. Test functions are created as standalone to
    -    test different test cases.
    +    Introduce `test_example_decorate__initialize()` to explicitly set up
    +    object IDs and retrieve corresponding objects before tests run. This
    +    ensures a consistent and predictable test state without relying on data
    +    from previous tests.
    +
    +    Add `test_example_decorate__cleanup()` to clear decorations after each
    +    test, preventing interference between tests and ensuring each runs in
    +    isolation.
    +
    +    Adapt example decorate test script to clar framework by using clar
    +    assertions where necessary. Previously, tests relied on data written by
    +    earlier tests, leading to unintended dependencies between them. This
    +    explicitly initializes the necessary state within
    +    `test_example_decorate__readd`, ensuring it does not depend on prior
    +    test executions.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
    @@ t/unit-tests/u-example-decorate.c (new)
     +
     +static struct test_vars vars;
     +
    -+void test_example_decorate__add(void)
    ++void test_example_decorate__initialize(void)
     +{
    -+	void *ret = add_decoration(&vars.n, vars.one, &vars.decoration_a);
    -+	cl_assert(ret == NULL);
    -+	ret = add_decoration(&vars.n, vars.two, NULL);
    -+	cl_assert(ret == NULL);
    ++	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
    ++
    ++	vars.one = lookup_unknown_object(the_repository, &one_oid);
    ++	vars.two = lookup_unknown_object(the_repository, &two_oid);
    ++	vars.three = lookup_unknown_object(the_repository, &three_oid);
     +}
     +
    -+void test_example_decorate__readd(void)
    ++void test_example_decorate__cleanup(void)
     +{
    -+	void *ret;
    ++	clear_decoration(&vars.n, NULL);
    ++}
     +
    -+	cl_assert(add_decoration(&vars.n, vars.one, &vars.decoration_a) == NULL);
    -+	cl_assert(add_decoration(&vars.n, vars.two, NULL) == NULL);
    ++void test_example_decorate__add(void)
    ++{
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.two, NULL), NULL);
    ++}
     +
    -+	ret = add_decoration(&vars.n, vars.one, NULL);
    -+	cl_assert(ret == &vars.decoration_a);
    -+	ret = add_decoration(&vars.n, vars.two, &vars.decoration_b);
    -+	cl_assert(ret == NULL);
    ++void test_example_decorate__readd(void)
    ++{
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.two, NULL), NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.one, NULL), &vars.decoration_a);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
     +}
     +
     +void test_example_decorate__lookup(void)
     +{
    -+	void *ret;
    -+
    -+	add_decoration(&vars.n, vars.two, &vars.decoration_b);
    -+	add_decoration(&vars.n, vars.one, NULL);
    -+
    -+	ret = lookup_decoration(&vars.n, vars.two);
    -+	cl_assert(ret == &vars.decoration_b);
    -+	ret = lookup_decoration(&vars.n, vars.one);
    -+	cl_assert(ret == NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.one, NULL), NULL);
    ++	cl_assert_equal_p(lookup_decoration(&vars.n, vars.two), &vars.decoration_b);
    ++	cl_assert_equal_p(lookup_decoration(&vars.n, vars.one), NULL);
     +}
     +
     +void test_example_decorate__loop(void)
     +{
     +	int objects_noticed = 0;
     +
    -+	add_decoration(&vars.n, vars.one, &vars.decoration_a);
    -+	add_decoration(&vars.n, vars.two, &vars.decoration_b);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.one, &vars.decoration_a), NULL);
    ++	cl_assert_equal_p(add_decoration(&vars.n, vars.two, &vars.decoration_b), NULL);
     +
    -+	for (size_t i = 0; i < vars.n.size; i++) {
    ++	for (size_t i = 0; i < vars.n.size; i++)
     +		if (vars.n.entries[i].base)
     +			objects_noticed++;
    -+	}
    -+	cl_assert_equal_i(objects_noticed, 2);
    -+}
     +
    -+void test_example_decorate__initialize(void)
    -+{
    -+	struct object_id one_oid = { { 1 } }, two_oid = { { 2 } }, three_oid = { { 3 } };
    -+
    -+	vars.one = lookup_unknown_object(the_repository, &one_oid);
    -+	vars.two = lookup_unknown_object(the_repository, &two_oid);
    -+	vars.three = lookup_unknown_object(the_repository, &three_oid);
    -+}
    -+
    -+void test_example_decorate__cleanup(void)
    -+{
    -+	clear_decoration(&vars.n, NULL);
    ++	cl_assert_equal_i(objects_noticed, 2);
     +}
3:  08ade6b5cf ! 3:  e88ab7ab5f t/unit-tests: convert strbuf test to use clar test framework
    @@ Commit message
         t/unit-tests: convert strbuf test to use clar test framework
     
         Adapt strbuf test script to clar framework by using clar assertions
    -    where necessary. Test functions are created as standalone to test
    -    different test cases.
    +    where necessary.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
    @@ t/unit-tests/u-strbuf.c (new)
     +	/* Buffers should always be NUL-terminated */
     +	cl_assert(buf->buf[buf->len] == '\0');
     +	/*
    -+	 * Freshly-initialized strbufs may not have a dynamically allocated
    -+	 * buffer
    -+	 */
    -+	if (buf->len == 0 && buf->alloc == 0)
    -+		return;
    -+	/* alloc must be at least one byte larger than len */
    -+	cl_assert(buf->len < buf->alloc);
    ++         * In case the buffer contains anything, `alloc` must alloc must
    ++         * be at least one byte larger than `len`.
    ++         */
    ++	if (buf->len)
    ++            cl_assert(buf->len < buf->alloc);
     +}
     +
     +void test_strbuf__static_init(void)
    @@ t/unit-tests/u-strbuf.c (new)
     +	setup(t_addch, "");
     +}
     +
    -+void test_strbuf__add_multi_char(void)
    ++void test_strbuf__add_append_char(void)
     +{
     +	setup_populated(t_addch, "initial value", "a");
     +}
    @@ t/unit-tests/u-strbuf.c (new)
     +	setup(t_addstr, "hello there");
     +}
     +
    -+void test_strbuf__add_multi_str(void)
    ++void test_strbuf__add_append_str(void)
     +{
     +	setup_populated(t_addstr, "initial value", "hello there");
     +}
4:  f648cf4a4d ! 4:  2dde9110c2 t/unit-tests: convert strcmp-offset test to use clar test framework
    @@ Commit message
         t/unit-tests: convert strcmp-offset test to use clar test framework
     
         Adapt strcmp-offset test script to clar framework by using clar
    -    assertions where necessary. Test functions are created as standalone to
    -    test different test cases.
    +    assertions where necessary. Introduce `test_strcmp_offset__empty()` to
    +    verify `check_strcmp_offset()` behavior when both input strings are
    +    empty. This ensures the function correctly handles edge cases and
    +    returns expected values.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
-- 
2.47.0.86.g15030f9556

