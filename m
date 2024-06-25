Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2A1487F6
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303984; cv=none; b=CIJm6sNvVKwq8VQHZt5i3NGNcMzmYApu9NC8bNshAmuMOX8OFT3yDGZgFFmkJo4Rff5e3R+SVLsKPWH2T2UdI/GGZeUvN11id1kfnGbSNM/r5GYQI2x95YJ+higGOc1t2AnxBZCvDKRwGLZAMCWdlQrFqoMCGgYMQs5EMSuzvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303984; c=relaxed/simple;
	bh=bb/LtFdSxxZkjEcoXDXOAL9f1NNUp1t7opf+QF9a9rk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjJibyGIz+9GYifvkMDTMZJ6zkqhzHovPHMRxDFnDySKrBFo0H+93qLjzvLAX+UtN0sArg2xflnMoGVw49OMGJKV8QhtU6JC5v+3yD3skoeYfB5ZF/6+yt4gohIy8+7rYwLpsn47QN6xGJCHxfQZI+XDtqOsJs9OE6xhjy5kHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F68zI96W; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F68zI96W"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2598001aae7so2589304fac.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719303981; x=1719908781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx/Y+r00tnE2V9f3AmfTaXVOUra8yqYVHCJM9BGSRNE=;
        b=F68zI96WXcGyU8+Ptr9P6/WoZachPoHySpZiSqMjBg1Mfsb7Kdx3r1E7cjAcRKN6qy
         WYKPrssuVC2wdNIet4m5t5OTr2VidVeBMP7UruzlwOcn2s2HbwPduK3tVI+o8loLkEEQ
         YFNyy3eWu6lOeAvSyLesovfJOfbR3nr4fW8sjJX6/VIKEj2AppO9QRy+H0jL73OZg7jp
         t7m7GR3mOFgFHkdFDqEOVh0YWOH3xWIJM3o5sYmrG9iZL1d9BGnR1h/NNm/xcxCncUUO
         VLpECPOyQnebe/XtrkMqVsnAQqIC7tT4GRPm/Be020Ay26NPL3lSHcfbZEGDcmsFhnKn
         Ltlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303981; x=1719908781;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx/Y+r00tnE2V9f3AmfTaXVOUra8yqYVHCJM9BGSRNE=;
        b=uMGPqMdU8afkH94xqjsEU0vQuTGFJ5Fvyn1HRQbr8rixeCie0lSmzZHvuy6dv/1SZc
         7im0pn6TxfFcLfvMNZAOeN+EnV3u9/pxvDq49H0HiGI0fUhxGC0vpH1qgggpW5CXuHTY
         IYysG6/bqF/TghRKvtyYSzQIlVLyiiUw1WrtNkUNkZyvSuD/UPp0u49maCgkGQNeOzxQ
         wTDFogiFXeiZ4JW3vTK6ANnUG7mIW9BOed58HPTcEsaQfo/lClEH2NlkR8ylstXFvGHk
         eelkncdRjCN4JalQuU2CmbRPy8/eVWBTzlExFRK4hopzqQM6R/gbSv0XHzFuvyWRa79J
         9fnw==
X-Forwarded-Encrypted: i=1; AJvYcCWV8h4aXMcAFHGZICvXbNa7mWBegBhWqQdcGijCazt7MuZWfiJY7jDdLjuINhr169jKgU/CCus/HKNL0BmI/F3wEQBY
X-Gm-Message-State: AOJu0Yz5Auc/4gVc0u/VugDxWtZNA4x8e4qcJMuLQ53XxJgHcD7Y7rNu
	OOfxYjtNkoCLEpURAmzIHpa2jxnqtEmpM2pBpJy/gr8hli0pAQ0MOh30ftB3TBmLqlaFELgKyRe
	Wyqi6GVYzLSaH1JnkpHv2j6xVwNcFls7+
X-Google-Smtp-Source: AGHT+IE/F1I3sH+4RY9cRM0e0BsxzVWGXqfe0Mh2qNADbPEc49dLHvhLo2fhpt0tHJLnJm8AtC+lWE1aMwXSMu3wLBs=
X-Received: by 2002:a05:6870:d623:b0:25d:1c0:803e with SMTP id
 586e51a60fabf-25d01c080aemr7722354fac.7.1719303981212; Tue, 25 Jun 2024
 01:26:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Jun 2024 03:26:20 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240621115708.3626-2-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-2-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Jun 2024 03:26:20 -0500
Message-ID: <CAOLa=ZSmnMLMoKKWMiM7M4Jw8CJ0Jvrs0oMLy18FHaLv_6s6yA@mail.gmail.com>
Subject: Re: [PATCH 01/11] t: move reftable/record_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000000fca97061bb2a77b"

--0000000000000fca97061bb2a77b
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/record_test.c exercises the functions defined in
> reftable/record.{c, h}. Migrate reftable/record_test.c to the
> unit testing framework. Migration involves refactoring the tests
> to use the unit testing framework instead of reftable's test
> framework.
> While at it, change the type of index variable 'i' to 'size_t'
> from 'int'. This is because 'i' is used in comparison against
> 'ARRAY_SIZE(x)' which is of type 'size_t'.
>
> Also, use set_hash() which is defined locally in the test file
> instead of set_test_hash() which is defined by
> reftable/test_framework.{c, h}. This is fine to do as both these
> functions are similarly implemented, and
> reftable/test_framework.{c, h} is not #included in the ported test.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  Makefile                                      |   2 +-
>  t/helper/test-reftable.c                      |   1 -
>  .../unit-tests/t-reftable-record.c            | 106 ++++++++----------
>  3 files changed, 50 insertions(+), 59 deletions(-)
>  rename reftable/record_test.c => t/unit-tests/t-reftable-record.c (77%)
>
> diff --git a/Makefile b/Makefile
> index f25b2e80a1..def3700b4d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
>  UNIT_TEST_PROGRAMS += t-mem-pool
>  UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGRAMS += t-reftable-basics
> +UNIT_TEST_PROGRAMS += t-reftable-record
>  UNIT_TEST_PROGRAMS += t-strbuf
>  UNIT_TEST_PROGRAMS += t-strcmp-offset
>  UNIT_TEST_PROGRAMS += t-strvec
> @@ -2678,7 +2679,6 @@ REFTABLE_TEST_OBJS += reftable/block_test.o
>  REFTABLE_TEST_OBJS += reftable/dump.o
>  REFTABLE_TEST_OBJS += reftable/merged_test.o
>  REFTABLE_TEST_OBJS += reftable/pq_test.o
> -REFTABLE_TEST_OBJS += reftable/record_test.o
>  REFTABLE_TEST_OBJS += reftable/readwrite_test.o
>  REFTABLE_TEST_OBJS += reftable/stack_test.o
>  REFTABLE_TEST_OBJS += reftable/test_framework.o
> diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
> index 9160bc5da6..aa6538a8da 100644
> --- a/t/helper/test-reftable.c
> +++ b/t/helper/test-reftable.c
> @@ -5,7 +5,6 @@
>  int cmd__reftable(int argc, const char **argv)
>  {
>  	/* test from simple to complex. */
> -	record_test_main(argc, argv);
>  	block_test_main(argc, argv);
>  	tree_test_main(argc, argv);
>  	pq_test_main(argc, argv);
> diff --git a/reftable/record_test.c b/t/unit-tests/t-reftable-record.c
> similarity index 77%
> rename from reftable/record_test.c
> rename to t/unit-tests/t-reftable-record.c
> index 58290bdba3..1b357e6c7f 100644
> --- a/reftable/record_test.c
> +++ b/t/unit-tests/t-reftable-record.c
> @@ -6,13 +6,9 @@
>    https://developers.google.com/open-source/licenses/bsd
>  */
>
> -#include "record.h"
> -
> -#include "system.h"
> -#include "basics.h"
> -#include "constants.h"
> -#include "test_framework.h"
> -#include "reftable-tests.h"
> +#include "test-lib.h"
> +#include "reftable/constants.h"
> +#include "reftable/record.h"
>
>  static void test_copy(struct reftable_record *rec)
>  {
> @@ -24,9 +20,9 @@ static void test_copy(struct reftable_record *rec)
>  	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>  	/* do it twice to catch memory leaks */

I'm curious why we do this, and if it is still needed. The original
commit (e303bf22f reftable: (de)serialization for the polymorphic record
type) doesn't mention any particular reasoning.

>  	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
> -	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> +	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
>
> -	puts("testing print coverage:\n");
> +	test_msg("testing print coverage:");
>  	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
>

This prints for any test that uses this function. As I see from the
current usage of the testing library, we only print debug information
when we encounter something unexpected.

This also clogs up the unit-test's output. So I would remove this from
here.

>  	reftable_record_release(&copy);
> @@ -43,8 +39,8 @@ static void test_varint_roundtrip(void)
>  			      4096,
>  			      ((uint64_t)1 << 63),
>  			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
> -	int i = 0;
> -	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(inputs); i++) {
>  		uint8_t dest[10];
>
>  		struct string_view out = {
> @@ -55,29 +51,26 @@ static void test_varint_roundtrip(void)
>  		int n = put_var_int(&out, in);
>  		uint64_t got = 0;
>
> -		EXPECT(n > 0);
> +		check_int(n, >, 0);
>  		out.len = n;
>  		n = get_var_int(&got, &out);
> -		EXPECT(n > 0);
> +		check_int(n, >, 0);
>
> -		EXPECT(got == in);
> +		check_int(got, ==, in);
>  	}
>  }
>
>  static void set_hash(uint8_t *h, int j)
>  {
> -	int i = 0;
> -	for (i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++) {
> +	for (int i = 0; i < hash_size(GIT_SHA1_FORMAT_ID); i++)
>  		h[i] = (j >> i) & 0xff;
> -	}
>  }
>
>  static void test_reftable_ref_record_roundtrip(void)
>  {
>  	struct strbuf scratch = STRBUF_INIT;
> -	int i = 0;
>
> -	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
> +	for (int i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
>  		struct reftable_record in = {
>  			.type = BLOCK_TYPE_REF,
>  		};
> @@ -109,17 +102,17 @@ static void test_reftable_ref_record_roundtrip(void)
>
>  		test_copy(&in);
>
> -		EXPECT(reftable_record_val_type(&in) == i);
> +		check_int(reftable_record_val_type(&in), ==, i);
>
>  		reftable_record_key(&in, &key);
>  		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> -		EXPECT(n > 0);
> +		check_int(n, >, 0);
>
>  		/* decode into a non-zero reftable_record to test for leaks. */
>  		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ, &scratch);
> -		EXPECT(n == m);
> +		check_int(n, ==, m);
>
> -		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
> +		check(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
>  						 GIT_SHA1_RAWSZ));
>  		reftable_record_release(&in);
>
> @@ -143,16 +136,15 @@ static void test_reftable_log_record_equal(void)
>  		}
>  	};
>
> -	EXPECT(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> +	check(!reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
>  	in[1].update_index = in[0].update_index;
> -	EXPECT(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
> +	check(reftable_log_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
>  	reftable_log_record_release(&in[0]);
>  	reftable_log_record_release(&in[1]);
>  }
>
>  static void test_reftable_log_record_roundtrip(void)
>  {
> -	int i;
>  	struct reftable_log_record in[] = {
>  		{
>  			.refname = xstrdup("refs/heads/master"),
> @@ -180,12 +172,12 @@ static void test_reftable_log_record_roundtrip(void)
>  		}
>  	};
>  	struct strbuf scratch = STRBUF_INIT;
> +	set_hash(in[0].value.update.new_hash, 1);
> +	set_hash(in[0].value.update.old_hash, 2);
> +	set_hash(in[2].value.update.new_hash, 3);
> +	set_hash(in[2].value.update.old_hash, 4);
>
> -	set_test_hash(in[0].value.update.new_hash, 1);
> -	set_test_hash(in[0].value.update.old_hash, 2);
> -	set_test_hash(in[2].value.update.new_hash, 3);
> -	set_test_hash(in[2].value.update.old_hash, 4);
> -	for (i = 0; i < ARRAY_SIZE(in); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
>  		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
>  		struct strbuf key = STRBUF_INIT;
>  		uint8_t buffer[1024] = { 0 };
> @@ -217,13 +209,13 @@ static void test_reftable_log_record_roundtrip(void)
>  		reftable_record_key(&rec, &key);
>
>  		n = reftable_record_encode(&rec, dest, GIT_SHA1_RAWSZ);
> -		EXPECT(n >= 0);
> +		check_int(n, >=, 0);
>  		valtype = reftable_record_val_type(&rec);
>  		m = reftable_record_decode(&out, key, valtype, dest,
>  					   GIT_SHA1_RAWSZ, &scratch);
> -		EXPECT(n == m);
> +		check_int(n, ==, m);
>
> -		EXPECT(reftable_log_record_equal(&in[i], &out.u.log,
> +		check(reftable_log_record_equal(&in[i], &out.u.log,
>  						 GIT_SHA1_RAWSZ));
>  		reftable_log_record_release(&in[i]);
>  		strbuf_release(&key);
> @@ -252,14 +244,14 @@ static void test_key_roundtrip(void)
>  	strbuf_addstr(&key, "refs/tags/bla");
>  	extra = 6;
>  	n = reftable_encode_key(&restart, dest, last_key, key, extra);
> -	EXPECT(!restart);
> -	EXPECT(n > 0);
> +	check(!restart);
> +	check_int(n, >, 0);
>
>  	strbuf_addstr(&roundtrip, "refs/heads/master");
>  	m = reftable_decode_key(&roundtrip, &rt_extra, dest);
> -	EXPECT(n == m);
> -	EXPECT(0 == strbuf_cmp(&key, &roundtrip));
> -	EXPECT(rt_extra == extra);
> +	check_int(n, ==, m);
> +	check(!strbuf_cmp(&key, &roundtrip));
> +	check_int(rt_extra, ==, extra);
>
>  	strbuf_release(&last_key);
>  	strbuf_release(&key);
> @@ -289,9 +281,8 @@ static void test_reftable_obj_record_roundtrip(void)
>  		},
>  	};
>  	struct strbuf scratch = STRBUF_INIT;
> -	int i = 0;
>
> -	for (i = 0; i < ARRAY_SIZE(recs); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(recs); i++) {
>  		uint8_t buffer[1024] = { 0 };
>  		struct string_view dest = {
>  			.buf = buffer,
> @@ -311,13 +302,13 @@ static void test_reftable_obj_record_roundtrip(void)
>  		test_copy(&in);
>  		reftable_record_key(&in, &key);
>  		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> -		EXPECT(n > 0);
> +		check_int(n, >, 0);
>  		extra = reftable_record_val_type(&in);
>  		m = reftable_record_decode(&out, key, extra, dest,
>  					   GIT_SHA1_RAWSZ, &scratch);
> -		EXPECT(n == m);
> +		check_int(n, ==, m);
>
> -		EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> +		check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
>  		strbuf_release(&key);
>  		reftable_record_release(&out);
>  	}
> @@ -352,16 +343,16 @@ static void test_reftable_index_record_roundtrip(void)
>  	reftable_record_key(&in, &key);
>  	test_copy(&in);
>
> -	EXPECT(0 == strbuf_cmp(&key, &in.u.idx.last_key));
> +	check(!strbuf_cmp(&key, &in.u.idx.last_key));
>  	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
> -	EXPECT(n > 0);
> +	check_int(n, >, 0);
>
>  	extra = reftable_record_val_type(&in);
>  	m = reftable_record_decode(&out, key, extra, dest, GIT_SHA1_RAWSZ,
>  				   &scratch);
> -	EXPECT(m == n);
> +	check_int(m, ==, n);
>
> -	EXPECT(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
> +	check(reftable_record_equal(&in, &out, GIT_SHA1_RAWSZ));
>
>  	reftable_record_release(&out);
>  	strbuf_release(&key);
> @@ -369,14 +360,15 @@ static void test_reftable_index_record_roundtrip(void)
>  	strbuf_release(&in.u.idx.last_key);
>  }
>
> -int record_test_main(int argc, const char *argv[])
> +int cmd_main(int argc, const char *argv[])
>  {
> -	RUN_TEST(test_reftable_log_record_equal);
> -	RUN_TEST(test_reftable_log_record_roundtrip);
> -	RUN_TEST(test_reftable_ref_record_roundtrip);
> -	RUN_TEST(test_varint_roundtrip);
> -	RUN_TEST(test_key_roundtrip);
> -	RUN_TEST(test_reftable_obj_record_roundtrip);
> -	RUN_TEST(test_reftable_index_record_roundtrip);
> -	return 0;
> +	TEST(test_reftable_log_record_equal(), "reftable_log_record_equal works");
> +	TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> +	TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> +	TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> +	TEST(test_key_roundtrip(), "reftable_encode_key and reftable_decode_key work");
> +	TEST(test_reftable_obj_record_roundtrip(), "record operations work on obj record");
> +	TEST(test_reftable_index_record_roundtrip(), "record operations work on index record");
> +

All other tests in the 'unit-tests/' folder use a `t_<name>` format for
the tests. Here we seem to diverge and use a `test_<name>` format. I
think the best outcome would be some documentation around this, but it
would still be nice if we follow this pattern nevertheless.

> +	return test_done();
>  }
> --
> 2.45.2.404.g9eaef5822c

--0000000000000fca97061bb2a77b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 53ee64a894ec1a5e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNmZ5b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWZrQy85aXZFYlZFUDhGYUl2SXEycWZDTXZ1ZGY1SApoY1lPQ05TYUVC
TW91TkpvKzhVZnRSS1Y0SUdOWFBUUG1GZmdnYlp1TVJOVytlNnRac0FJNmpUTWhMVUZEV0s3CkIv
SlU4d0x3enJOVWtKQndYNFkwR0o0WXhVa2c0emlCOVcwT1NYbWc3OG04ZE5zWU90eUp2THVHbTJM
aFJ3MnMKSFdoMnNaaysvRUtjUUtzb2oxR3pCdk0rRWppWG9iVlJLOUNQQ1RyOVpCdUhLbUR6Y1lQ
MHBxZzF5dUl0cTVlTQpqRXZrSEs5WGcxL3lGZjBsVlpBSGhOK0wxRVdmWjdhVXJPY1JIaEE2czJY
ZDhvTVNXZWZpSE9HVHArWXpMUkdQCmhaY1ZKeU5rMkpNKzhhdHFNcDJxeVVGUUIraHRaVms4MUZj
VTdHVGhWdW1jOTFyUHhZeHJRWUswbzJOWXkyNDIKUTBkdE15NkhvVnNkWk1rQXNBSWJKRnNiTEcy
b05XWW5JZS9tMy91VXJUUXJqNkNTNGxKbENOU2M1UUt4TnBpWgplN0hsZ2lRMk1icktpdnhhYzBC
aVcwOHFCM051cnplLzRBRytENzNYeGs5SmRHSDhQVGpMa2dVWGdpS2ZreGk0Cjg2MmkzM3o2VVlT
MkRFaHo1YUpHMzY2bjhpOVVPNGNzc3RIS2FwVT0KPVRBT24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000fca97061bb2a77b--
