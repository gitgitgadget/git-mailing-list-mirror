Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA67485
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867202; cv=none; b=iK+NkIfSdwBBn+GJIkh1vKeQbLTgkFB1q1JkCIvkHDEegw1B0hGmJ3wQKc7BVshiZz8NU1YsNldPK8a3WWjil1QWWRlBIPTZCzsK9q0PRrtTEvbNhdwr/RKeEy2hD0UkB4PUsx5dtqcFmRfofy+UoscWPN2T0yTY41ZwTRS0nis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867202; c=relaxed/simple;
	bh=iaM8OHf32hYbM6yyAzxDEaWn6z0SGI/fJKyknDWTjQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6v6IVTo6exMKYmaR3aHt6ghVEUFsGEb767RB7fr4AbPTpjiYY9YeWo9Q13c1eE/2wwistJIXukbcb/N3REu4aCgldo1MkygLevw9Q30653PBg6O/FB0o010bJEfefcSOLvLcADcxUUK6Df3OHoRk1a/91tezjt2RjhyKopLdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajv/q0Yj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajv/q0Yj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d54214adso11401965e9.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867195; x=1749471995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpWXXCX/KI3KlTC31RsIs09aKCz0xOxiGbY2quOkyRU=;
        b=ajv/q0YjBV3Y9/IJZEywak+LHJfjsaCiBHu1fGkvn21HZ2tOSBp5XfBT612nEHPbHC
         8ufkfzczu3EzCg4F7MRLb32QI2GYSBWix1F76vDv42Qib8D3egziwimZh4aBaXaa3sJR
         5qERxVcWVWLSHUv00kcj1a7jd/TLY+MUmBLSXi2BV3ZtWteVqtzkiMpeh2KDfqPZYmve
         g93gQvOF2adyZ6Pukwk4fIJ7k4RvbEAUt28oLYRD7eG2dpg2HOlhNkujYQVx0v1xVilN
         JEEJpyavONmwC/cWFqQecE4SxczB/tftr97R2g3TgMzPKRK2bWiZQp5ZOypxlFU8V/2q
         cZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867195; x=1749471995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpWXXCX/KI3KlTC31RsIs09aKCz0xOxiGbY2quOkyRU=;
        b=qbec6bnTYDtwjfKHNmaLtpDoLa0ptsQi1MqJEAAi2ecB5JKaX4Nh1Te+/16NpjL90N
         Gaw68NCiBW6d4jzQzTUB8dlE32OKEvgNFsNZHYyzqk+xoZ4QalOLWJGUSUNWGSZCYq4/
         g+GM3Jh0GJksqtM1lSDAufP7mXGoo7UcjxBuDlBiLNr9WdPcYo3B3EnBDY0KoeC/vpKZ
         iZFR5mnNRrH4NXNZsokJjYZ+C1AD8e6sVeVNS2n/drjKteArM3Cj5Kujs3xw/H7lHSKC
         bThkcw4rNWkr8pgaoVJsvtXF0OLKpYSEtoZ375Lhh/8wZnQ9EXBbhvoZjqPtg9eQ/VrO
         K/8g==
X-Gm-Message-State: AOJu0YxJOumeSVm+Ep3w0V8gmcH9HkH6HnDGsljTOVFMFtyWK/1Gjkr9
	rA9W5nGTDkNKB8bfQqsqTMd6u+JNTjZWymdJNr8trer0DXPoDh+MCXUV7e92UkAXyPk=
X-Gm-Gg: ASbGncscjyv7UpAwCURMhjhWazx6pQtAK759893w7fu5O6EO+GzuFdHJCnVFVGomH/j
	im1ETAp4JhYOAiyAcpOUleOKpHrQoZNAOcUdSnCDlxH7Qi8T7bdDxW4cb8j683jAW3LVaL+rsnc
	w5pmQ8/jh2vYukWaWo8sutDt3RPp6H3GEBAnSY5cdD6eQchw2XAnRA3lwUn0WPIAMjhekXO4eek
	oq6rzyBeF8/Hp4zhtxBHTy/GpOEqIsKnbdBljMNgrm/WSh/9ESuoGq/unq7Xm33DGp4Wjipi38O
	RgaYdirqo1WEH0qGkeDR725r3qdYZv6IV9fpTDJz4rwhsJR4coCk6WYYTaYBrCcZdQ==
X-Google-Smtp-Source: AGHT+IHEs4vKaX2OHOGSf8wUYTSTyM3bhhBxqfm+ycJhVIu7MweaftFZVunOyV0zoDeFbQwqKh2FtQ==
X-Received: by 2002:a05:600c:4e0b:b0:442:f4d4:53a with SMTP id 5b1f17b1804b1-450d64c322amr139274745e9.2.1748867194496;
        Mon, 02 Jun 2025 05:26:34 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:26:33 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 00/10] t/unit-tests: convert unit-tests to use clar
Date: Mon,  2 Jun 2025 13:25:48 +0100
Message-ID: <20250602122559.208780-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series marks the final batch of our existing unit test
files transitioned to the Clar testing framework. It covers all the
reftable-related test files, and is part of our ongoing effort to
standardize our testing framework to enhance its maintainability.

Changes in v3:
 - some code refactoring based on review, which includes initial creation
 of reftable helper functions to
 t/unit-tests/lib-reftable-clar-test.{c,h} files in the initial commit

Thanks
Seyi

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (10):
  t/unit-tests: implement clar specific reftable test helper functions
  t/unit-tests: convert reftable basics test to use clar test framework
  t/unit-tests: convert reftable block test to use clar
  t/unit-tests: convert reftable merged test to use clar
  t/unit-tests: convert reftable pq test to use clar
  t/unit-tests: convert reftable table test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar
  t/unit-tests: finalize migration of reftable-related tests

 Makefile                                      |  22 +-
 t/Makefile                                    |   1 -
 t/meson.build                                 |  42 +-
 t/unit-tests/lib-reftable.c                   |  35 +-
 t/unit-tests/lib-reftable.h                   |  15 +-
 t/unit-tests/t-reftable-basics.c              | 219 ------
 t/unit-tests/u-reftable-basics.c              | 227 ++++++
 ...{t-reftable-block.c => u-reftable-block.c} | 164 ++--
 ...-reftable-merged.c => u-reftable-merged.c} | 160 ++--
 .../{t-reftable-pq.c => u-reftable-pq.c}      |  59 +-
 ...ble-readwrite.c => u-reftable-readwrite.c} | 384 ++++-----
 ...-reftable-record.c => u-reftable-record.c} | 217 +++---
 ...{t-reftable-stack.c => u-reftable-stack.c} | 726 +++++++-----------
 ...{t-reftable-table.c => u-reftable-table.c} |  71 +-
 14 files changed, 1021 insertions(+), 1321 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c
 rename t/unit-tests/{t-reftable-block.c => u-reftable-block.c} (74%)
 rename t/unit-tests/{t-reftable-merged.c => u-reftable-merged.c} (77%)
 rename t/unit-tests/{t-reftable-pq.c => u-reftable-pq.c} (64%)
 rename t/unit-tests/{t-reftable-readwrite.c => u-reftable-readwrite.c} (69%)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (63%)
 rename t/unit-tests/{t-reftable-stack.c => u-reftable-stack.c} (59%)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (76%)

Range-diff against v2:
 1:  d85c5694ca !  1:  53a64f5551 t/unit-tests: implement reftable test helper functions in unit-test.{c,h}
    @@ Metadata
     Author: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Commit message ##
    -    t/unit-tests: implement reftable test helper functions in unit-test.{c,h}
    +    t/unit-tests: implement clar specific reftable test helper functions
     
         Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
    -    required for the reftable-related test files to run efficeintly. In the
    -    current implementation these functions are designed to conform with our
    +    required for the reftable-related test files to run. In the current
    +    implementation these functions are designed to conform with our
         homegrown unit-testing structure. So in other to convert the reftable
         test files, there is need for a clar specific implementation of these
         helper functions.
     
    -    type cast `for (size_t i = 0; i < (size_t)stats->ref_stats.blocks;
    -    i++)`, implement equivalent helper functions in unit-test.{c,h} to use
    -    clar. These functions conform with the clar testing framework and become
    -    available for all reftable-related test files implemented using the clar
    -    testing framework, which requires them. This will be used by subsequent
    -    commits.
    +    Implement equivalent helper functions in `lib-reftable-clar.{c,h}` to
    +    use clar. These functions conform with the clar testing framework and
    +    become available for all reftable-related test files implemented using
    +    the clar testing framework, which requires them. This will be used by
    +    subsequent commits.
     
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
    - ## t/unit-tests/unit-test.c ##
    + ## Makefile ##
    +@@ Makefile: CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    ++CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
    + 
    + UNIT_TEST_PROGRAMS += t-reftable-basics
    + UNIT_TEST_PROGRAMS += t-reftable-block
    +
    + ## t/meson.build ##
    +@@ t/meson.build: clar_test_suites = [
    + clar_sources = [
    +   'unit-tests/clar/clar.c',
    +   'unit-tests/unit-test.c',
    +-  'unit-tests/lib-oid.c'
    ++  'unit-tests/lib-oid.c',
    ++  'unit-tests/lib-reftable-clar.c'
    + ]
    + 
    + clar_decls_h = custom_target(
    +
    + ## t/unit-tests/lib-reftable-clar.c (new) ##
     @@
    - #include "unit-test.h"
    - #include "hex.h"
    - #include "parse-options.h"
    ++#include "unit-test.h"
    ++#include "lib-reftable-clar.h"
    ++#include "hex.h"
    ++#include "parse-options.h"
     +#include "reftable/constants.h"
     +#include "reftable/writer.h"
    - #include "strbuf.h"
    - #include "string-list.h"
    - #include "strvec.h"
    - 
    ++#include "strbuf.h"
    ++#include "string-list.h"
    ++#include "strvec.h"
    ++
     +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
     +{
     +	memset(p, (uint8_t)i, hash_size(id));
    @@ t/unit-tests/unit-test.c
     +	struct reftable_writer *writer;
     +	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
     +				      buf, opts);
    -+	cl_assert(ret == 0);
    ++	cl_assert(!ret);
     +	return writer;
     +}
     +
    @@ t/unit-tests/unit-test.c
     +	}
     +
     +	writer = cl_reftable_strbuf_writer(buf, &opts);
    -+	reftable_writer_set_limits(writer, min, max);
    ++	ret = reftable_writer_set_limits(writer, min, max);
    ++	cl_assert_equal_i(ret, 0);
     +
     +	if (nrefs) {
     +		ret = reftable_writer_add_refs(writer, refs, nrefs);
    @@ t/unit-tests/unit-test.c
     +
     +	reftable_writer_free(writer);
     +}
    -+
    - static const char * const unit_test_usage[] = {
    - 	N_("unit-test [<options>]"),
    - 	NULL,
     
    - ## t/unit-tests/unit-test.h ##
    + ## t/unit-tests/lib-reftable-clar.h (new) ##
     @@
    - #include "git-compat-util.h"
    - #include "clar/clar.h"
    - #include "clar-decls.h"
    ++#include "git-compat-util.h"
    ++#include "clar/clar.h"
    ++#include "clar-decls.h"
     +#include "git-compat-util.h"
     +#include "reftable/reftable-writer.h"
    - #include "strbuf.h"
    - 
    ++#include "strbuf.h"
    ++
     +struct reftable_buf;
     +
     +void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
     +
     +struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
    -+						 struct reftable_write_options *opts);
    ++						  struct reftable_write_options *opts);
     +
     +void cl_reftable_write_to_buf(struct reftable_buf *buf,
     +			     struct reftable_ref_record *refs,
    @@ t/unit-tests/unit-test.h
     +			     struct reftable_log_record *logs,
     +			     size_t nlogs,
     +			     struct reftable_write_options *opts);
    -+
    - #define cl_failf(fmt, ...) do { \
    - 	char desc[4096]; \
    - 	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
 2:  d24faa0176 !  2:  fec29d94d8 t/unit-tests: convert reftable basics test to use clar test framework
    @@ Makefile: CLAR_TEST_SUITES += u-oid-array
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-basics
      UNIT_TEST_PROGRAMS += t-reftable-block
    @@ t/unit-tests/u-reftable-basics.c (new)
     +*/
     +
     +#include "unit-test.h"
    ++#include "lib-reftable-clar.h"
     +#include "reftable/basics.h"
     +
     +struct integer_needle_lesseq_args {
    @@ t/unit-tests/u-reftable-basics.c (new)
     +				&integer_needle_lesseq, &args);
     +		cl_assert_equal_i(idx, testcases[i].expected_idx);
     +	}
    -+
     +}
     +
     +void test_reftable_basics__names_length(void)
    @@ t/unit-tests/u-reftable-basics.c (new)
     +	free_names(out);
     +}
     +
    ++void test_reftable_basics__parse_names_drop_empty_string(void)
    ++{
    ++	char in[] = "a\n\nb\n";
    ++	char **out = parse_names(in, strlen(in));
    ++	cl_assert(out != NULL);
    ++	cl_assert_equal_s(out[0], "a");
    ++	/* simply '\n' should be dropped as empty string */
    ++	cl_assert_equal_s(out[1], "b");
    ++	cl_assert(out[2] == NULL);
    ++	free_names(out);
    ++}
    ++
     +void test_reftable_basics__common_prefix_size(void)
     +{
     +	struct reftable_buf a = REFTABLE_BUF_INIT;
    @@ t/unit-tests/u-reftable-basics.c (new)
     +	};
     +
     +	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
    -+		reftable_buf_reset(&a);
    -+		reftable_buf_reset(&b);
     +		cl_assert_equal_i(reftable_buf_addstr(&a, cases[i].a), 0);
     +		cl_assert_equal_i(reftable_buf_addstr(&b, cases[i].b), 0);
     +		cl_assert_equal_i(common_prefix_size(&a, &b), cases[i].want);
    ++		reftable_buf_reset(&a);
    ++		reftable_buf_reset(&b);
     +	}
     +	reftable_buf_release(&a);
     +	reftable_buf_release(&b);
     +}
     +
    ++void test_reftable_basics__put_get_be64(void)
    ++{
    ++	uint64_t in = 0x1122334455667788;
    ++	uint8_t dest[8];
    ++	uint64_t out;
    ++	reftable_put_be64(dest, in);
    ++	out = reftable_get_be64(dest);
    ++	cl_assert(in == out);
    ++}
    ++
    ++void test_reftable_basics__put_get_be32(void)
    ++{
    ++	uint32_t in = 0x11223344;
    ++	uint8_t dest[4];
    ++	uint32_t out;
    ++	reftable_put_be32(dest, in);
    ++	out = reftable_get_be32(dest);
    ++	cl_assert_equal_i(in, out);
    ++}
    ++
     +void test_reftable_basics__put_get_be24(void)
     +{
     +	uint32_t in = 0x112233;
    @@ t/unit-tests/u-reftable-basics.c (new)
     +	cl_assert_equal_i(in, out);
     +}
     +
    -+void test_reftable_basics__grow_alloc(void)
    ++void test_reftable_basics__alloc_grow(void)
     +{
     +	int *arr = NULL, *old_arr;
     +	size_t alloc = 0, old_alloc;
    @@ t/unit-tests/u-reftable-basics.c (new)
     +	reftable_free(arr);
     +}
     +
    -+void test_reftable_basics__grow_alloc_or_null(void)
    ++void test_reftable_basics__alloc_grow_or_null(void)
     +{
     +	int *arr = NULL;
     +	size_t alloc = 0, old_alloc;
 3:  d9eb47645b !  3:  57d7541caa t/unit-tests: convert reftable block test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-oidmap
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-block
      UNIT_TEST_PROGRAMS += t-reftable-merged
      UNIT_TEST_PROGRAMS += t-reftable-pq
    - UNIT_TEST_PROGRAMS += t-reftable-reader
    + UNIT_TEST_PROGRAMS += t-reftable-readwrite
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    @@ t/meson.build: clar_unit_tests = executable('unit-tests',
     -  'unit-tests/t-reftable-block.c',
        'unit-tests/t-reftable-merged.c',
        'unit-tests/t-reftable-pq.c',
    -   'unit-tests/t-reftable-reader.c',
    +   'unit-tests/t-reftable-readwrite.c',
     
      ## t/unit-tests/t-reftable-block.c => t/unit-tests/u-reftable-block.c ##
     @@ t/unit-tests/u-reftable-block.c: license that can be found in the LICENSE file or at
    @@ t/unit-tests/u-reftable-block.c: license that can be found in the LICENSE file o
      
     -#include "test-lib.h"
     +#include "unit-test.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/block.h"
      #include "reftable/blocksource.h"
      #include "reftable/constants.h"
    @@ t/unit-tests/u-reftable-block.c: license that can be found in the LICENSE file o
      	const int header_off = 21; /* random */
      	struct reftable_record recs[30];
     @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
    - 	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
    - 
    - 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
    --	check(block.data != NULL);
    -+	cl_assert(block.data != NULL);
    - 	block.len = block_size;
    - 	block_source_from_buf(&block.source ,&buf);
    - 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
    + 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
    + 
    + 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
    +-	check(block_data.buf != NULL);
    ++	cl_assert(block_data.buf != NULL);
    + 	block_data.len = block_size;
    + 
    +-	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) block_data.buf, block_size,
    ++	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_REF,
    ++				(uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
     +	cl_assert(ret == 0);
    @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
      	}
      
      	for (i = 0; i < N; i++) {
    -@@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
      		reftable_record_key(&recs[i], &want);
      
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      
      		want.len--;
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      	}
      
    - 	block_reader_release(&br);
    + 	reftable_block_release(&block);
     @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
      		reftable_record_release(&recs[i]);
      }
    @@ t/unit-tests/u-reftable-block.c: static void t_ref_block_read_write(void)
      	const int header_off = 21;
      	struct reftable_record recs[30];
     @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
    - 	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
    - 
    - 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
    --	check(block.data != NULL);
    -+	cl_assert(block.data != NULL);
    - 	block.len = block_size;
    - 	block_source_from_buf(&block.source ,&buf);
    - 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
    + 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
    + 
    + 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
    +-	check(block_data.buf != NULL);
    ++	cl_assert(block_data.buf != NULL);
    + 	block_data.len = block_size;
    + 
    + 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_LOG, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
     +	cl_assert(ret == 0);
    @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
      	}
      
      	for (i = 0; i < N; i++) {
    - 		block_iter_reset(&it);
      		reftable_buf_reset(&want);
     -		check(!reftable_buf_addstr(&want, recs[i].u.log.refname));
     +		cl_assert(reftable_buf_addstr(&want, recs[i].u.log.refname) == 0);
      
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      
      		want.len--;
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      	}
      
    - 	block_reader_release(&br);
    + 	reftable_block_release(&block);
     @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
      		reftable_record_release(&recs[i]);
      }
    @@ t/unit-tests/u-reftable-block.c: static void t_log_block_read_write(void)
      	const int header_off = 21;
      	struct reftable_record recs[30];
     @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
    - 	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
    - 
    - 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
    --	check(block.data != NULL);
    -+	cl_assert(block.data != NULL);
    - 	block.len = block_size;
    - 	block_source_from_buf(&block.source, &buf);
    - 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
    + 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
    + 
    + 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
    +-	check(block_data.buf != NULL);
    ++	cl_assert(block_data.buf != NULL);
    + 	block_data.len = block_size;
    + 
    + 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_OBJ, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
     +	cl_assert(ret == 0);
    @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
      	}
      
      	for (i = 0; i < N; i++) {
    -@@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
      		reftable_record_key(&recs[i], &want);
      
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      	}
      
    - 	block_reader_release(&br);
    + 	reftable_block_release(&block);
     @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
      		reftable_record_release(&recs[i]);
      }
    @@ t/unit-tests/u-reftable-block.c: static void t_obj_block_read_write(void)
      	const int header_off = 21;
      	struct reftable_record recs[30];
     @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
    - 	struct reftable_buf want = REFTABLE_BUF_INIT, buf = REFTABLE_BUF_INIT;
    - 
    - 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
    --	check(block.data != NULL);
    -+	cl_assert(block.data != NULL);
    - 	block.len = block_size;
    - 	block_source_from_buf(&block.source, &buf);
    - 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
    + 	struct reftable_buf block_data = REFTABLE_BUF_INIT;
    + 
    + 	REFTABLE_CALLOC_ARRAY(block_data.buf, block_size);
    +-	check(block_data.buf != NULL);
    ++	cl_assert(block_data.buf != NULL);
    + 	block_data.len = block_size;
    + 
    + 	ret = block_writer_init(&bw, REFTABLE_BLOCK_TYPE_INDEX, (uint8_t *) block_data.buf, block_size,
      				header_off, hash_size(REFTABLE_HASH_SHA1));
     -	check(!ret);
     +	cl_assert(ret == 0);
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
     @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
      
      		reftable_buf_init(&recs[i].u.idx.last_key);
    - 		recs[i].type = BLOCK_TYPE_INDEX;
    + 		recs[i].type = REFTABLE_BLOCK_TYPE_INDEX;
     -		check(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
    -+		cl_assert(reftable_buf_addstr(&recs[i].u.idx.last_key, buf) == 0);
    ++		cl_assert(!reftable_buf_addstr(&recs[i].u.idx.last_key, buf));
      		recs[i].u.idx.offset = i;
      
      		ret = block_writer_add(&bw, &recs[i]);
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
      	}
      
      	for (i = 0; i < N; i++) {
    -@@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
      		reftable_record_key(&recs[i], &want);
      
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[i], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      
      		want.len--;
    - 		ret = block_iter_seek_key(&it, &br, &want);
    + 		ret = block_iter_seek_key(&it, &want);
     -		check_int(ret, ==, 0);
     +		cl_assert_equal_i(ret, 0);
      
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
     +		cl_assert_equal_i(reftable_record_equal(&recs[10 * (i / 10)], &rec, REFTABLE_HASH_SIZE_SHA1), 1);
      	}
      
    - 	block_reader_release(&br);
    + 	reftable_block_release(&block);
     @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
    - 	for (i = 0; i < N; i++)
      		reftable_record_release(&recs[i]);
      }
    + 
    +-static void t_block_iterator(void)
    ++void test_reftable_block__iterator(void)
    + {
    + 	struct reftable_block_source source = { 0 };
    + 	struct block_writer writer = {
    +@@ t/unit-tests/u-reftable-block.c: static void t_block_iterator(void)
    + 
    + 	data.len = 1024;
    + 	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
    +-	check(data.buf != NULL);
    ++	cl_assert(data.buf != NULL);
    + 
    +-	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF, (uint8_t *) data.buf, data.len,
    ++	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
    ++				(uint8_t *) data.buf, data.len,
    + 				0, hash_size(REFTABLE_HASH_SHA1));
    +-	check(!err);
    ++	cl_assert(!err);
    + 
    + 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++) {
    + 		expected_refs[i] = (struct reftable_record) {
    +@@ t/unit-tests/u-reftable-block.c: static void t_block_iterator(void)
    + 		memset(expected_refs[i].u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
    + 
    + 		err = block_writer_add(&writer, &expected_refs[i]);
    +-		check_int(err, ==, 0);
    ++		cl_assert_equal_i(err, 0);
    + 	}
    + 
    + 	err = block_writer_finish(&writer);
    +-	check_int(err, >, 0);
    ++	cl_assert(err > 0);
    + 
    + 	block_source_from_buf(&source, &data);
    + 	reftable_block_init(&block, &source, 0, 0, data.len,
    + 			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF);
    + 
    + 	err = reftable_block_init_iterator(&block, &it);
    +-	check_int(err, ==, 0);
    ++	cl_assert_equal_i(err, 0);
    + 
    + 	for (size_t i = 0; ; i++) {
    + 		err = reftable_iterator_next_ref(&it, &ref);
    + 		if (err > 0) {
    +-			check_int(i, ==, ARRAY_SIZE(expected_refs));
    ++			cl_assert_equal_i(i, ARRAY_SIZE(expected_refs));
    + 			break;
    + 		}
    +-		check_int(err, ==, 0);
    ++		cl_assert_equal_i(err, 0);
    + 
    +-		check(reftable_ref_record_equal(&ref, &expected_refs[i].u.ref,
    +-						REFTABLE_HASH_SIZE_SHA1));
    ++		cl_assert(reftable_ref_record_equal(&ref,
    ++						    &expected_refs[i].u.ref, REFTABLE_HASH_SIZE_SHA1));
    + 	}
    + 
    + 	err = reftable_iterator_seek_ref(&it, "refs/heads/does-not-exist");
    +-	check_int(err, ==, 0);
    ++	cl_assert_equal_i(err, 0);
    + 	err = reftable_iterator_next_ref(&it, &ref);
    +-	check_int(err, ==, 1);
    ++	cl_assert_equal_i(err, 1);
    + 
    + 	err = reftable_iterator_seek_ref(&it, "refs/heads/branch-13");
    +-	check_int(err, ==, 0);
    ++	cl_assert_equal_i(err, 0);
    + 	err = reftable_iterator_next_ref(&it, &ref);
    +-	check_int(err, ==, 0);
    +-	check(reftable_ref_record_equal(&ref, &expected_refs[13].u.ref,
    +-					REFTABLE_HASH_SIZE_SHA1));
    ++	cl_assert_equal_i(err, 0);
    ++	cl_assert(reftable_ref_record_equal(&ref,
    ++					    &expected_refs[13].u.ref,REFTABLE_HASH_SIZE_SHA1));
    + 
    + 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++)
    + 		reftable_free(expected_refs[i].u.ref.refname);
    +@@ t/unit-tests/u-reftable-block.c: static void t_block_iterator(void)
    + 	block_writer_release(&writer);
    + 	reftable_buf_release(&data);
    + }
     -
     -int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
     -{
    @@ t/unit-tests/u-reftable-block.c: static void t_index_block_read_write(void)
     -	TEST(t_log_block_read_write(), "read-write operations on log blocks work");
     -	TEST(t_obj_block_read_write(), "read-write operations on obj blocks work");
     -	TEST(t_ref_block_read_write(), "read-write operations on ref blocks work");
    +-	TEST(t_block_iterator(), "block iterator works");
     -
     -	return test_done();
     -}
 4:  6ffc7cdfc6 !  4:  db11c0eb30 t/unit-tests: convert reftable merged test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-oidtree
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-merged
      UNIT_TEST_PROGRAMS += t-reftable-pq
    - UNIT_TEST_PROGRAMS += t-reftable-reader
      UNIT_TEST_PROGRAMS += t-reftable-readwrite
    + UNIT_TEST_PROGRAMS += t-reftable-record
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      unit_test_programs = [
     -  'unit-tests/t-reftable-merged.c',
        'unit-tests/t-reftable-pq.c',
    -   'unit-tests/t-reftable-reader.c',
        'unit-tests/t-reftable-readwrite.c',
    +   'unit-tests/t-reftable-record.c',
     
      ## t/unit-tests/t-reftable-merged.c => t/unit-tests/u-reftable-merged.c ##
     @@ t/unit-tests/u-reftable-merged.c: license that can be found in the LICENSE file or at
    @@ t/unit-tests/u-reftable-merged.c: license that can be found in the LICENSE file
      */
      
     -#include "test-lib.h"
    +-#include "lib-reftable.h"
     +#include "unit-test.h"
    - #include "lib-reftable.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/blocksource.h"
      #include "reftable/constants.h"
    + #include "reftable/merged.h"
     @@ t/unit-tests/u-reftable-merged.c: merged_table_from_records(struct reftable_ref_record **refs,
      	int err;
      
    - 	REFTABLE_CALLOC_ARRAY(*readers, n);
    --	check(*readers != NULL);
    -+	cl_assert(*readers != NULL);
    + 	REFTABLE_CALLOC_ARRAY(*tables, n);
    +-	check(*tables != NULL);
    ++	cl_assert(*tables != NULL);
      	REFTABLE_CALLOC_ARRAY(*source, n);
     -	check(*source != NULL);
     +	cl_assert(*source != NULL);
    @@ t/unit-tests/u-reftable-merged.c: merged_table_from_records(struct reftable_ref_
     +		cl_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
      		block_source_from_buf(&(*source)[i], &buf[i]);
      
    - 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
    - 					  "name");
    + 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
    + 					 "name");
     -		check(!err);
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
      	}
      
    - 	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
    + 	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
     -	check(!err);
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
      	return mt;
      }
      
    -@@ t/unit-tests/u-reftable-merged.c: static void readers_destroy(struct reftable_reader **readers, const size_t n)
    - 	reftable_free(readers);
    +@@ t/unit-tests/u-reftable-merged.c: static void tables_destroy(struct reftable_table **tables, const size_t n)
    + 	reftable_free(tables);
      }
      
     -static void t_merged_single_record(void)
    -+void test_reftable_merged__merged_single_record(void)
    ++void test_reftable_merged__single_record(void)
      {
      	struct reftable_ref_record r1[] = { {
      		.refname = (char *) "b",
     @@ t/unit-tests/u-reftable-merged.c: static void t_merged_single_record(void)
      	int err;
      
    - 	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
    + 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
     -	check(!err);
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
      	err = reftable_iterator_seek_ref(&it, "a");
     -	check(!err);
     +	cl_assert(err == 0);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_single_record(void)
     -	check(!err);
     -	check(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1));
     +	cl_assert(err == 0);
    -+	cl_assert(reftable_ref_record_equal(&r2[0], &ref, REFTABLE_HASH_SIZE_SHA1) != 0);
    ++	cl_assert(reftable_ref_record_equal(&r2[0], &ref,
    ++					    REFTABLE_HASH_SIZE_SHA1) != 0);
      	reftable_ref_record_release(&ref);
      	reftable_iterator_destroy(&it);
    - 	readers_destroy(readers, 3);
    + 	tables_destroy(tables, 3);
     @@ t/unit-tests/u-reftable-merged.c: static void t_merged_single_record(void)
      	reftable_free(bs);
      }
      
     -static void t_merged_refs(void)
    -+void test_reftable_merged__merged_refs(void)
    ++void test_reftable_merged__refs(void)
      {
      	struct reftable_ref_record r1[] = {
      		{
     @@ t/unit-tests/u-reftable-merged.c: static void t_merged_refs(void)
      	size_t i;
      
    - 	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
    + 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
     -	check(!err);
    -+	cl_assert(err == 0);
    ++	cl_assert(!err);
      	err = reftable_iterator_seek_ref(&it, "a");
     -	check(!err);
     -	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_refs(void)
     -		check(reftable_ref_record_equal(want[i], &out[i],
     -						 REFTABLE_HASH_SIZE_SHA1));
     +		cl_assert(reftable_ref_record_equal(want[i], &out[i],
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      	for (i = 0; i < len; i++)
      		reftable_ref_record_release(&out[i]);
      	reftable_free(out);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_refs(void)
      }
      
     -static void t_merged_seek_multiple_times(void)
    -+void test_reftable_merged__merged_seek_multiple_times(void)
    ++void test_reftable_merged__seek_multiple_times(void)
      {
      	struct reftable_ref_record r1[] = {
      		{
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times(void)
     -		check(err == 1);
     +		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
     +		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[1],
    -+													REFTABLE_HASH_SIZE_SHA1), 1);
    ++							    REFTABLE_HASH_SIZE_SHA1), 1);
      
     -		err = reftable_iterator_next_ref(&it, &rec);
     -		check(!err);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times(void)
     -		check(err == 1);
     +		cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
     +		cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[1],
    -+													REFTABLE_HASH_SIZE_SHA1), 1);
    ++							    REFTABLE_HASH_SIZE_SHA1), 1);
      
     -		err = reftable_iterator_next_ref(&it, &rec);
     -		check(err > 0);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times(void)
      }
      
     -static void t_merged_seek_multiple_times_without_draining(void)
    -+void test_reftable_merged__merged_seek_multiple_times_no_drain(void)
    ++void test_reftable_merged__seek_multiple_times_no_drain(void)
      {
      	struct reftable_ref_record r1[] = {
      		{
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times_witho
      	struct reftable_merged_table *mt;
     -	int err;
      
    - 	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
    - 	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
    + 	mt = merged_table_from_records(refs, &sources, &tables, sizes, bufs, 2);
    + 	merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_REF);
      
     -	err = reftable_iterator_seek_ref(&it, "b");
     -	check(!err);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times_witho
     +	cl_assert(reftable_iterator_seek_ref(&it, "b") == 0);
     +	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
     +	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r2[0],
    -+												REFTABLE_HASH_SIZE_SHA1), 1);
    ++						    REFTABLE_HASH_SIZE_SHA1), 1);
      
     -	err = reftable_iterator_seek_ref(&it, "a");
     -	check(!err);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_seek_multiple_times_witho
     +	cl_assert(reftable_iterator_seek_ref(&it, "a") == 0);
     +	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
     +	cl_assert_equal_i(reftable_ref_record_equal(&rec, &r1[0],
    -+												REFTABLE_HASH_SIZE_SHA1), 1);
    ++						    REFTABLE_HASH_SIZE_SHA1), 1);
      
      	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
      		reftable_buf_release(&bufs[i]);
     @@ t/unit-tests/u-reftable-merged.c: merged_table_from_log_records(struct reftable_log_record **logs,
      	int err;
      
    - 	REFTABLE_CALLOC_ARRAY(*readers, n);
    --	check(*readers != NULL);
    -+	cl_assert(*readers != NULL);
    + 	REFTABLE_CALLOC_ARRAY(*tables, n);
    +-	check(*tables != NULL);
    ++	cl_assert(*tables != NULL);
      	REFTABLE_CALLOC_ARRAY(*source, n);
     -	check(*source != NULL);
     +	cl_assert(*source != NULL);
    @@ t/unit-tests/u-reftable-merged.c: merged_table_from_log_records(struct reftable_
     +		cl_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
      		block_source_from_buf(&(*source)[i], &buf[i]);
      
    - 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
    - 					  "name");
    + 		err = reftable_table_new(&(*tables)[i], &(*source)[i],
    + 					 "name");
     -		check(!err);
    -+		cl_assert(err == 0);
    ++		cl_assert(!err);
      	}
      
    --	err = reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1);
    + 	err = reftable_merged_table_new(&mt, *tables, n, REFTABLE_HASH_SHA1);
     -	check(!err);
    -+	cl_assert(reftable_merged_table_new(&mt, *readers, n, REFTABLE_HASH_SHA1) == 0);
    ++	cl_assert(!err);
      	return mt;
      }
      
     -static void t_merged_logs(void)
    -+void test_reftable_merged__merged_logs(void)
    ++void test_reftable_merged__logs(void)
      {
      	struct reftable_log_record r1[] = {
      		{
     @@ t/unit-tests/u-reftable-merged.c: static void t_merged_logs(void)
      	struct reftable_merged_table *mt = merged_table_from_log_records(
    - 		logs, &bs, &readers, sizes, bufs, 3);
    + 		logs, &bs, &tables, sizes, bufs, 3);
      	struct reftable_iterator it = { 0 };
     -	int err;
      	struct reftable_log_record *out = NULL;
      	size_t len = 0;
      	size_t cap = 0;
      	size_t i;
    ++	int err;
      
    --	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
    + 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
     -	check(!err);
    --	err = reftable_iterator_seek_log(&it, "a");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_log(&it, "a");
     -	check(!err);
     -	check_int(reftable_merged_table_hash_id(mt), ==, REFTABLE_HASH_SHA1);
     -	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
     -	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
    -+	cl_assert(merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG) == 0);
    -+	cl_assert(reftable_iterator_seek_log(&it, "a") == 0);
    ++	cl_assert(!err);
     +	cl_assert_equal_i(reftable_merged_table_hash_id(mt), REFTABLE_HASH_SHA1);
     +	cl_assert_equal_i(reftable_merged_table_min_update_index(mt), 1);
     +	cl_assert_equal_i(reftable_merged_table_max_update_index(mt), 3);
    @@ t/unit-tests/u-reftable-merged.c: static void t_merged_logs(void)
     -		check(reftable_log_record_equal(want[i], &out[i],
     -						 REFTABLE_HASH_SIZE_SHA1));
     +		cl_assert(reftable_log_record_equal(want[i], &out[i],
    -+											REFTABLE_HASH_SIZE_SHA1) != 0);
    ++						    REFTABLE_HASH_SIZE_SHA1) != 0);
      
    --	err = merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG);
    + 	err = merged_table_init_iter(mt, &it, REFTABLE_BLOCK_TYPE_LOG);
     -	check(!err);
    --	err = reftable_iterator_seek_log_at(&it, "a", 2);
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_log_at(&it, "a", 2);
     -	check(!err);
    -+	cl_assert(merged_table_init_iter(mt, &it, BLOCK_TYPE_LOG) == 0);
    -+	cl_assert(reftable_iterator_seek_log_at(&it, "a", 2) == 0);
    ++	cl_assert(!err);
      	reftable_log_record_release(&out[0]);
     -	err = reftable_iterator_next_log(&it, &out[0]);
     -	check(!err);
     -	check(reftable_log_record_equal(&out[0], &r3[0], REFTABLE_HASH_SIZE_SHA1));
     +	cl_assert(reftable_iterator_next_log(&it, &out[0]) == 0);
     +	cl_assert(reftable_log_record_equal(&out[0], &r3[0],
    -+										REFTABLE_HASH_SIZE_SHA1) != 0);
    ++					    REFTABLE_HASH_SIZE_SHA1) != 0);
      	reftable_iterator_destroy(&it);
      
      	for (i = 0; i < len; i++)
    @@ t/unit-tests/u-reftable-merged.c: static void t_default_write_opts(void)
      
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&rd, &source, "filename");
    + 	err = reftable_table_new(&table, &source, "filename");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&rd, &source, "filename") == 0);
    ++	cl_assert(!err);
      
    - 	hash_id = reftable_reader_hash_id(rd);
    + 	hash_id = reftable_table_hash_id(table);
     -	check_int(hash_id, ==, REFTABLE_HASH_SHA1);
     +	cl_assert_equal_i(hash_id, REFTABLE_HASH_SHA1);
      
    - 	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA256);
    + 	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA256);
     -	check_int(err, ==, REFTABLE_FORMAT_ERROR);
    --	err = reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1);
    --	check(!err);
     +	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
    -+	cl_assert(reftable_merged_table_new(&merged, &rd, 1, REFTABLE_HASH_SHA1) == 0);
    + 	err = reftable_merged_table_new(&merged, &table, 1, REFTABLE_HASH_SHA1);
    +-	check(!err);
    ++	cl_assert(!err);
      
    - 	reftable_reader_decref(rd);
    + 	reftable_table_decref(table);
      	reftable_merged_table_free(merged);
      	reftable_buf_release(&buf);
      }
 5:  19b08968a0 !  5:  60cf81862a t/unit-tests: convert reftable pq test to use clar
    @@ Makefile: CLAR_TEST_SUITES += u-prio-queue
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
      CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-pq
    - UNIT_TEST_PROGRAMS += t-reftable-reader
      UNIT_TEST_PROGRAMS += t-reftable-readwrite
      UNIT_TEST_PROGRAMS += t-reftable-record
    + UNIT_TEST_PROGRAMS += t-reftable-stack
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      
      unit_test_programs = [
     -  'unit-tests/t-reftable-pq.c',
    -   'unit-tests/t-reftable-reader.c',
    ++  'unit-tests/t-reftable-reader.c',
        'unit-tests/t-reftable-readwrite.c',
        'unit-tests/t-reftable-record.c',
    +   'unit-tests/t-reftable-stack.c',
     
      ## t/unit-tests/t-reftable-pq.c => t/unit-tests/u-reftable-pq.c ##
     @@ t/unit-tests/u-reftable-pq.c: license that can be found in the LICENSE file or at
    @@ t/unit-tests/u-reftable-pq.c: license that can be found in the LICENSE file or a
      
     -#include "test-lib.h"
     +#include "unit-test.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/constants.h"
      #include "reftable/pq.h"
      #include "strbuf.h"
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_record(void)
      	char *last = NULL;
      
      	for (i = 0; i < N; i++) {
    --		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
    -+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
    +-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
    ++		cl_assert(!reftable_record_init(&recs[i],
    ++						REFTABLE_BLOCK_TYPE_REF));
      		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
      	}
      
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_record(void)
      		merged_iter_pqueue_check(&pq);
      
     -		check(pq_entry_equal(&top, &e));
    --		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
    -+		cl_assert(pq_entry_equal(&top, &e) != 0);
    -+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
    +-		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
    ++		cl_assert(pq_entry_equal(&top, &e));
    ++		cl_assert(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
      		if (last)
     -			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
     +			cl_assert(strcmp(last, e.rec->u.ref.refname) < 0);
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_index(void)
      	size_t N = ARRAY_SIZE(recs), i;
      
      	for (i = 0; i < N; i++) {
    --		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
    -+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
    +-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
    ++		cl_assert(!reftable_record_init(&recs[i],
    ++						REFTABLE_BLOCK_TYPE_REF));
      		recs[i].u.ref.refname = (char *) "refs/heads/master";
      	}
      
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_index(void)
      		merged_iter_pqueue_check(&pq);
      
     -		check(pq_entry_equal(&top, &e));
    --		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
    +-		check(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
     -		check_int(e.index, ==, i);
    -+		cl_assert(pq_entry_equal(&top, &e) != 0);
    -+		cl_assert(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
    ++		cl_assert(pq_entry_equal(&top, &e));
    ++		cl_assert(reftable_record_type(e.rec) == REFTABLE_BLOCK_TYPE_REF);
     +		cl_assert_equal_i(e.index, i);
      		if (last)
     -			check_str(last, e.rec->u.ref.refname);
    @@ t/unit-tests/u-reftable-pq.c: static void t_pq_index(void)
      	size_t N = ARRAY_SIZE(recs), i;
      
      	for (i = 0; i < N; i++) {
    --		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
    -+		cl_assert(reftable_record_init(&recs[i], BLOCK_TYPE_REF) == 0);
    +-		check(!reftable_record_init(&recs[i], REFTABLE_BLOCK_TYPE_REF));
    ++		cl_assert(!reftable_record_init(&recs[i],
    ++						REFTABLE_BLOCK_TYPE_REF));
      		recs[i].u.ref.refname = (char *) "refs/heads/master";
      	}
      
 6:  b34d6714ed <  -:  ---------- t/unit-tests: convert reftable reader test to use clar
 -:  ---------- >  6:  0eec9f7601 t/unit-tests: convert reftable table test to use clar
 7:  05c909ea94 !  7:  36bdd9b003 t/unit-tests: convert reftable readwrite test to use clar
    @@ Commit message
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: CLAR_TEST_SUITES += u-reftable-block
    +@@ Makefile: CLAR_TEST_SUITES += u-reftable-basics
    + CLAR_TEST_SUITES += u-reftable-block
      CLAR_TEST_SUITES += u-reftable-merged
      CLAR_TEST_SUITES += u-reftable-pq
    - CLAR_TEST_SUITES += u-reftable-reader
     +CLAR_TEST_SUITES += u-reftable-readwrite
    + CLAR_TEST_SUITES += u-reftable-table
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
    - CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-readwrite
      UNIT_TEST_PROGRAMS += t-reftable-record
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    +   'unit-tests/u-reftable-block.c',
        'unit-tests/u-reftable-merged.c',
        'unit-tests/u-reftable-pq.c',
    -   'unit-tests/u-reftable-reader.c',
     +  'unit-tests/u-reftable-readwrite.c',
    +   'unit-tests/u-reftable-table.c',
        'unit-tests/u-reftable-tree.c',
        'unit-tests/u-strbuf.c',
    -   'unit-tests/u-strcmp-offset.c',
     @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      test('unit-tests', clar_unit_tests)
      
    @@ t/unit-tests/u-reftable-readwrite.c: license that can be found in the LICENSE fi
      #define DISABLE_SIGN_COMPARE_WARNINGS
      
     -#include "test-lib.h"
    +-#include "lib-reftable.h"
     +#include "unit-test.h"
    - #include "lib-reftable.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/basics.h"
      #include "reftable/blocksource.h"
    + #include "reftable/reftable-error.h"
     @@ t/unit-tests/u-reftable-readwrite.c: license that can be found in the LICENSE file or at
      
      static const int update_index = 5;
    @@ t/unit-tests/u-reftable-readwrite.c: license that can be found in the LICENSE fi
      {
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	struct reftable_block_source source = { 0 };
    - 	struct reftable_block out = { 0 };
    + 	struct reftable_block_data out = { 0 };
      	int n;
      	uint8_t in[] = "hello";
     -	check(!reftable_buf_add(&buf, in, sizeof(in)));
    @@ t/unit-tests/u-reftable-readwrite.c: license that can be found in the LICENSE fi
      	block_source_from_buf(&source, &buf);
     -	check_int(block_source_size(&source), ==, 6);
     +	cl_assert_equal_i(block_source_size(&source), 6);
    - 	n = block_source_read_block(&source, &out, 0, sizeof(in));
    + 	n = block_source_read_data(&source, &out, 0, sizeof(in));
     -	check_int(n, ==, sizeof(in));
     -	check(!memcmp(in, out.data, n));
     +	cl_assert_equal_i(n, sizeof(in));
    -+	cl_assert(memcmp(in, out.data, n) == 0);
    - 	reftable_block_done(&out);
    ++	cl_assert(!memcmp(in, out.data, n));
    + 	block_source_release_data(&out);
      
    --	n = block_source_read_block(&source, &out, 1, 2);
    + 	n = block_source_read_data(&source, &out, 1, 2);
     -	check_int(n, ==, 2);
     -	check(!memcmp(out.data, "el", 2));
    -+	cl_assert_equal_i(block_source_read_block(&source, &out, 1, 2), 2);
    -+	cl_assert(memcmp(out.data, "el", 2) == 0);
    ++	cl_assert_equal_i(n, 2);
    ++	cl_assert(!memcmp(out.data, "el", 2));
      
    - 	reftable_block_done(&out);
    + 	block_source_release_data(&out);
      	block_source_close(&source);
     @@ t/unit-tests/u-reftable-readwrite.c: static void write_table(char ***names, struct reftable_buf *buf, int N,
      	int i;
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_limits(void)
      	struct reftable_write_options opts = {
      		.block_size = 256,
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
    - 	struct reftable_reader *reader;
    + 	struct reftable_table *table;
      	struct reftable_block_source source = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
     -	int N = 2, err, i, n;
     +	int N = 2, i;
      	char **names;
    ++	int err;
      
      	names = reftable_calloc(N + 1, sizeof(*names));
     -	check(names != NULL);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.log");
    + 	err = reftable_table_new(&table, &source, "file.log");
     -	check(!err);
    --
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --
    --	err = reftable_iterator_seek_ref(&it, names[N - 1]);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
     -	check(!err);
    --
    --	err = reftable_iterator_next_ref(&it, &ref);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_iterator_next_ref(&it, &ref);
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.log") == 0);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, names[N - 1]) == 0);
    -+	cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
    ++	cl_assert(!err);
      
      	/* end of iteration. */
     -	err = reftable_iterator_next_ref(&it, &ref);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      	reftable_iterator_destroy(&it);
      	reftable_ref_record_release(&ref);
      
    --	err = reftable_reader_init_log_iterator(reader, &it);
    + 	err = reftable_table_init_log_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_log(&it, "");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_log(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_log(&it, "") == 0);
    ++	cl_assert(!err);
      
      	for (i = 0; ; i++) {
      		int err = reftable_iterator_next_log(&it, &log);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      
      	/* cleanup. */
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
    - 	reftable_reader_decref(reader);
    + 	reftable_table_decref(table);
      }
      
     -static void t_log_zlib_corruption(void)
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_write_read(void)
      	struct reftable_write_options opts = {
      		.block_size = 256,
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
    - 	struct reftable_reader *reader;
    + 	struct reftable_table *table;
      	struct reftable_block_source source = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
      	char message[100] = { 0 };
     -	int err, i, n;
     +	int i;
    ++	int err;
      	struct reftable_log_record log = {
      		.refname = (char *) "refname",
      		.value_type = REFTABLE_LOG_UPDATE,
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
      	w = NULL;
      
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
    - 
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.log");
    + 	err = reftable_table_new(&table, &source, "file.log");
     -	check(!err);
    --
    --	err = reftable_reader_init_log_iterator(reader, &it);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_table_init_log_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_log(&it, "refname");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_log(&it, "refname");
     -	check_int(err, ==, REFTABLE_ZLIB_ERROR);
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.log") == 0);
    -+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
    -+	cl_assert_equal_i(reftable_iterator_seek_log(&it, "refname"), REFTABLE_ZLIB_ERROR);
    ++	cl_assert_equal_i(err, REFTABLE_ZLIB_ERROR);
      
      	reftable_iterator_destroy(&it);
      
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_log_zlib_corruption(void)
      	char **names;
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_sequential(void)
    - 	struct reftable_iterator it = { 0 };
    - 	struct reftable_block_source source = { 0 };
    - 	struct reftable_reader *reader;
    --	int err = 0;
    - 	int j = 0;
    - 
    - 	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
    - 
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.ref");
    + 	err = reftable_table_new(&table, &source, "file.ref");
     -	check(!err);
    --
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_ref(&it, "");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
    ++	cl_assert(!err);
      
      	for (j = 0; ; j++) {
      		struct reftable_ref_record ref = { 0 };
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_sequential(v
     +	cl_assert_equal_i(j, N);
      
      	reftable_iterator_destroy(&it);
    - 	reftable_reader_decref(reader);
    + 	reftable_table_decref(table);
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_sequential(void)
      	free_names(names);
      }
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_sequential(v
      	char **names;
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	int N = 50;
    - 	struct reftable_reader *reader;
    + 	struct reftable_table *table;
      	struct reftable_block_source source = { 0 };
     -	int err;
      	struct reftable_log_record log = { 0 };
      	struct reftable_iterator it = { 0 };
    ++	int err;
      
    -@@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_api(void)
    + 	write_table(&names, &buf, N, 256, REFTABLE_HASH_SHA1);
      
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.ref");
    + 	err = reftable_table_new(&table, &source, "file.ref");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, names[0]) == 0);
    ++	cl_assert(!err);
      
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_ref(&it, names[0]);
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_ref(&it, names[0]);
     -	check(!err);
    --
    --	err = reftable_iterator_next_log(&it, &log);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_iterator_next_log(&it, &log);
     -	check_int(err, ==, REFTABLE_API_ERROR);
    -+	cl_assert_equal_i(reftable_iterator_next_log(&it, &log), REFTABLE_API_ERROR);
    ++	cl_assert_equal_i(err, REFTABLE_API_ERROR);
      
      	reftable_buf_release(&buf);
      	free_names(names);
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
    - 
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.ref");
    + 	err = reftable_table_new(&table, &source, "file.ref");
     -	check(!err);
    --	check_int(hash_id, ==, reftable_reader_hash_id(reader));
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
    -+	cl_assert_equal_i(hash_id, reftable_reader_hash_id(reader));
    +-	check_int(hash_id, ==, reftable_table_hash_id(table));
    ++	cl_assert(!err);
    ++	cl_assert_equal_i(hash_id, reftable_table_hash_id(table));
      
      	if (!index) {
    - 		reader->ref_offsets.index_offset = 0;
    + 		table->ref_offsets.index_offset = 0;
      	} else {
    --		check_int(reader->ref_offsets.index_offset, >, 0);
    -+		cl_assert(reader->ref_offsets.index_offset > 0);
    +-		check_int(table->ref_offsets.index_offset, >, 0);
    ++		cl_assert(table->ref_offsets.index_offset > 0);
      	}
      
      	for (i = 1; i < N; i++) {
    --		err = reftable_reader_init_ref_iterator(reader, &it);
    + 		err = reftable_table_init_ref_iterator(table, &it);
     -		check(!err);
    --		err = reftable_iterator_seek_ref(&it, names[i]);
    ++		cl_assert(!err);
    + 		err = reftable_iterator_seek_ref(&it, names[i]);
     -		check(!err);
    --		err = reftable_iterator_next_ref(&it, &ref);
    ++		cl_assert(!err);
    + 		err = reftable_iterator_next_ref(&it, &ref);
     -		check(!err);
     -		check_str(names[i], ref.refname);
     -		check_int(REFTABLE_REF_VAL1, ==, ref.value_type);
     -		check_int(i, ==, ref.value.val1[0]);
    -+		cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+		cl_assert(reftable_iterator_seek_ref(&it, names[i]) == 0);
    -+		cl_assert(reftable_iterator_next_ref(&it, &ref) == 0);
    ++		cl_assert(!err);
     +		cl_assert_equal_s(names[i], ref.refname);
     +		cl_assert_equal_i(REFTABLE_REF_VAL1, ref.value_type);
     +		cl_assert_equal_i(i, ref.value.val1[0]);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int ind
     +	cl_assert(reftable_buf_addstr(&pastLast, names[N - 1]) == 0);
     +	cl_assert(reftable_buf_addstr(&pastLast, "/") == 0);
      
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    ++	cl_assert(!err);
      	err = reftable_iterator_seek_ref(&it, pastLast.buf);
      	if (err == 0) {
      		struct reftable_ref_record ref = { 0 };
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int ind
      
      	reftable_buf_release(&pastLast);
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int index, enum reftable_hash hash_id)
    - 	reftable_reader_decref(reader);
    + 	reftable_table_decref(table);
      }
      
     -static void t_table_read_write_seek_linear(void)
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_read_write_seek(int ind
      	t_table_read_write_seek(1, REFTABLE_HASH_SHA1);
      }
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
    - 	struct reftable_reader *reader;
    + 	struct reftable_table *table;
      	struct reftable_block_source source = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      	struct reftable_iterator it = { 0 };
     -	int N = 50, n, j, err, i;
     +	int N = 50, j, i;
    ++	int err;
      
      	want_names = reftable_calloc(N + 1, sizeof(*want_names));
     -	check(want_names != NULL);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      
      	reftable_writer_free(w);
      	w = NULL;
    - 
    +@@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&reader, &source, "file.ref");
    + 	err = reftable_table_new(&table, &source, "file.ref");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "file.ref") == 0);
    ++	cl_assert(!err);
      	if (!indexed)
    - 		reader->obj_offsets.is_present = 0;
    + 		table->obj_offsets.is_present = 0;
      
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_ref(&it, "");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
    ++	cl_assert(!err);
      	reftable_iterator_destroy(&it);
      
    --	err = reftable_reader_refs_for(reader, &it, want_hash);
    + 	err = reftable_table_refs_for(table, &it, want_hash);
     -	check(!err);
    -+	cl_assert(reftable_reader_refs_for(reader, &it, want_hash) == 0);
    ++	cl_assert(!err);
      
      	for (j = 0; ; j++) {
      		int err = reftable_iterator_next_ref(&it, &ref);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      	reftable_buf_release(&buf);
      	free_names(want_names);
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
    - 	reftable_reader_decref(reader);
    + 	reftable_table_decref(table);
      }
      
     -static void t_table_refs_for_no_index(void)
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
     -	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
     +	struct reftable_writer *w = cl_reftable_strbuf_writer(&buf, &opts);
      	struct reftable_block_source source = { 0 };
    - 	struct reftable_reader *rd = NULL;
    + 	struct reftable_table *table = NULL;
      	struct reftable_ref_record rec = { 0 };
    - 	struct reftable_iterator it = { 0 };
    --	int err;
    +@@ t/unit-tests/u-reftable-readwrite.c: static void t_write_empty_table(void)
      
      	reftable_writer_set_limits(w, 1, 1);
      
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_table_refs_for(int indexed)
      
      	block_source_from_buf(&source, &buf);
      
    --	err = reftable_reader_new(&rd, &source, "filename");
    + 	err = reftable_table_new(&table, &source, "filename");
     -	check(!err);
    --
    --	err = reftable_reader_init_ref_iterator(rd, &it);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_ref(&it, "");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    --
    --	err = reftable_iterator_next_ref(&it, &rec);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_iterator_next_ref(&it, &rec);
     -	check_int(err, >, 0);
    -+	cl_assert(reftable_reader_new(&rd, &source, "filename") == 0);
    -+	cl_assert(reftable_reader_init_ref_iterator(rd, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
    ++	cl_assert(err > 0);
      
      	reftable_iterator_destroy(&it);
    - 	reftable_reader_decref(rd);
    + 	reftable_table_decref(table);
      	reftable_buf_release(&buf);
      }
      
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_key_order(void)
      		.block_size = 100,
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multiple_indices(void)
      	struct reftable_writer *writer;
    - 	struct reftable_reader *reader;
    + 	struct reftable_table *table;
      	char buf[128];
     -	int err, i;
     +	int i;
    ++	int err;
      
     -	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
     +	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multiple_indices(void)
     +	cl_assert(stats->log_stats.index_offset > 0);
      
      	block_source_from_buf(&source, &writer_buf);
    --	err = reftable_reader_new(&reader, &source, "filename");
    + 	err = reftable_table_new(&table, &source, "filename");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "filename") == 0);
    ++	cl_assert(!err);
      
      	/*
      	 * Seeking the log uses the log index now. In case there is any
      	 * confusion regarding indices we would notice here.
      	 */
    --	err = reftable_reader_init_log_iterator(reader, &it);
    + 	err = reftable_table_init_log_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_log(&it, "");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_log(&it, "");
     -	check(!err);
    -+	cl_assert(reftable_reader_init_log_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_log(&it, "") == 0);
    ++	cl_assert(!err);
      
      	reftable_iterator_destroy(&it);
      	reftable_writer_free(writer);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multiple_indices(void)
      	struct reftable_write_options opts = {
      		.block_size = 100,
     @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multi_level_index(void)
    - 	const struct reftable_stats *stats;
    - 	struct reftable_writer *writer;
    - 	struct reftable_reader *reader;
    --	int err;
    + 	struct reftable_table *table;
    + 	int err;
      
     -	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
     +	writer = cl_reftable_strbuf_writer(&writer_buf, &opts);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multi_level_index(void)
     +	cl_assert_equal_i(stats->ref_stats.max_index_level, 2);
      
      	block_source_from_buf(&source, &writer_buf);
    --	err = reftable_reader_new(&reader, &source, "filename");
    + 	err = reftable_table_new(&table, &source, "filename");
     -	check(!err);
    -+	cl_assert(reftable_reader_new(&reader, &source, "filename") == 0);
    ++	cl_assert(!err);
      
      	/*
      	 * Seeking the last ref should work as expected.
      	 */
    --	err = reftable_reader_init_ref_iterator(reader, &it);
    + 	err = reftable_table_init_ref_iterator(table, &it);
     -	check(!err);
    --	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
    ++	cl_assert(!err);
    + 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
     -	check(!err);
    -+	cl_assert(reftable_reader_init_ref_iterator(reader, &it) == 0);
    -+	cl_assert(reftable_iterator_seek_ref(&it, "refs/heads/199") == 0);
    ++	cl_assert(!err);
      
      	reftable_iterator_destroy(&it);
      	reftable_writer_free(writer);
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multi_level_index(void)
      {
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	struct reftable_block_source source = { 0 };
    - 	struct reftable_reader *reader;
    --	int err;
    +@@ t/unit-tests/u-reftable-readwrite.c: static void t_corrupt_table_empty(void)
      
      	block_source_from_buf(&source, &buf);
    --	err = reftable_reader_new(&reader, &source, "file.log");
    + 	err = reftable_table_new(&table, &source, "file.log");
     -	check_int(err, ==, REFTABLE_FORMAT_ERROR);
    -+	cl_assert_equal_i(reftable_reader_new(&reader, &source,
    -+										  "file.log"),REFTABLE_FORMAT_ERROR);
    ++	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
      }
      
     -static void t_corrupt_table(void)
    @@ t/unit-tests/u-reftable-readwrite.c: static void t_write_multi_level_index(void)
      	uint8_t zeros[1024] = { 0 };
      	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	struct reftable_block_source source = { 0 };
    - 	struct reftable_reader *reader;
    --	int err;
    + 	struct reftable_table *table;
    + 	int err;
     -	check(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
    -+	cl_assert(reftable_buf_add(&buf, zeros, sizeof(zeros)) == 0);
    ++
    ++	cl_assert(!reftable_buf_add(&buf, zeros, sizeof(zeros)));
      
      	block_source_from_buf(&source, &buf);
    --	err = reftable_reader_new(&reader, &source, "file.log");
    + 	err = reftable_table_new(&table, &source, "file.log");
     -	check_int(err, ==, REFTABLE_FORMAT_ERROR);
    -+	cl_assert_equal_i(reftable_reader_new(&reader, &source,
    -+										  "file.log"), REFTABLE_FORMAT_ERROR);
    ++	cl_assert_equal_i(err, REFTABLE_FORMAT_ERROR);
      
      	reftable_buf_release(&buf);
      }
 8:  1515cf15b7 !  8:  df744c1458 t/unit-tests: convert reftable record test to use clar
    @@ Commit message
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: CLAR_TEST_SUITES += u-reftable-merged
    - CLAR_TEST_SUITES += u-reftable-pq
    - CLAR_TEST_SUITES += u-reftable-reader
    - CLAR_TEST_SUITES += u-reftable-readwrite
    -+CLAR_TEST_SUITES += u-reftable-record
    - CLAR_TEST_SUITES += u-reftable-tree
    - CLAR_TEST_SUITES += u-strbuf
    - CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-record
      UNIT_TEST_PROGRAMS += t-reftable-stack
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     
      ## t/meson.build ##
    -@@ t/meson.build: clar_test_suites = [
    -   'unit-tests/u-reftable-pq.c',
    -   'unit-tests/u-reftable-reader.c',
    -   'unit-tests/u-reftable-readwrite.c',
    -+  'unit-tests/u-reftable-record.c',
    -   'unit-tests/u-reftable-tree.c',
    -   'unit-tests/u-strbuf.c',
    -   'unit-tests/u-strcmp-offset.c',
     @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      test('unit-tests', clar_unit_tests)
      
    @@ t/unit-tests/t-reftable-record.c => t/unit-tests/u-reftable-record.c
      
     -#include "test-lib.h"
     +#include "unit-test.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/basics.h"
      #include "reftable/constants.h"
      #include "reftable/record.h"
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_roundtrip(vo
     +	cl_assert(reftable_log_record_is_deletion(&in[2]) == 0);
      
      	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
    - 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
    + 		struct reftable_record rec = { .type = REFTABLE_BLOCK_TYPE_LOG };
     @@ t/unit-tests/u-reftable-record.c: static void t_reftable_log_record_roundtrip(void)
      		reftable_record_key(&rec, &key);
      
    @@ t/unit-tests/u-reftable-record.c: static void t_reftable_index_record_comparison
     +void test_reftable_record__index_record_roundtrip(void)
      {
      	struct reftable_record in = {
    - 		.type = BLOCK_TYPE_INDEX,
    + 		.type = REFTABLE_BLOCK_TYPE_INDEX,
     @@ t/unit-tests/u-reftable-record.c: static void t_reftable_index_record_roundtrip(void)
      	int n, m;
      	uint8_t extra;
 9:  dcbb2b6e56 !  9:  4a247de9e4 t/unit-tests: convert reftable stack test to use clar
    @@ Commit message
         Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
     
      ## Makefile ##
    -@@ Makefile: CLAR_TEST_SUITES += u-reftable-pq
    - CLAR_TEST_SUITES += u-reftable-reader
    +@@ Makefile: CLAR_TEST_SUITES += u-reftable-block
    + CLAR_TEST_SUITES += u-reftable-merged
    + CLAR_TEST_SUITES += u-reftable-pq
      CLAR_TEST_SUITES += u-reftable-readwrite
    - CLAR_TEST_SUITES += u-reftable-record
     +CLAR_TEST_SUITES += u-reftable-stack
    + CLAR_TEST_SUITES += u-reftable-table
      CLAR_TEST_SUITES += u-reftable-tree
      CLAR_TEST_SUITES += u-strbuf
    - CLAR_TEST_SUITES += u-strcmp-offset
    -@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
    - CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
    +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
    + CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      
     -UNIT_TEST_PROGRAMS += t-reftable-stack
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    -   'unit-tests/u-reftable-reader.c',
    +   'unit-tests/u-reftable-merged.c',
    +   'unit-tests/u-reftable-pq.c',
        'unit-tests/u-reftable-readwrite.c',
    -   'unit-tests/u-reftable-record.c',
    ++  'unit-tests/u-reftable-record.c',
     +  'unit-tests/u-reftable-stack.c',
    +   'unit-tests/u-reftable-table.c',
        'unit-tests/u-reftable-tree.c',
        'unit-tests/u-strbuf.c',
    -   'unit-tests/u-strcmp-offset.c',
     @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      test('unit-tests', clar_unit_tests)
      
    @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      ]
      
      foreach unit_test_program : unit_test_programs
    -@@ t/meson.build: integration_tests = [
    +@@ t/meson.build: benchmarks = [
      # sufficient to catch missing test suites in our CI though.
      foreach glob, tests : {
        't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
    +-  'perf/p[0-9][0-9][0-9][0-9]-*.sh': benchmarks,
     -  'unit-tests/t-*.c': unit_test_programs,
        'unit-tests/u-*.c': clar_test_suites,
      }
    @@ t/unit-tests/u-reftable-stack.c: license that can be found in the LICENSE file o
      #define DISABLE_SIGN_COMPARE_WARNINGS
      
     -#include "test-lib.h"
    +-#include "lib-reftable.h"
     +#include "unit-test.h"
    - #include "lib-reftable.h"
      #include "dir.h"
    ++#include "lib-reftable-clar.h"
      #include "reftable/merged.h"
    + #include "reftable/reftable-error.h"
    + #include "reftable/stack.h"
     @@ t/unit-tests/u-reftable-stack.c: static char *get_tmp_template(int linenumber)
      static char *get_tmp_dir(int linenumber)
      {
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_one(void)
      	};
      	struct reftable_ref_record dest = { 0 };
      	struct stat stat_result = { 0 };
    --	err = reftable_new_stack(&st, dir, &opts);
    ++	int err;
    ++
    + 	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    --
    --	err = reftable_stack_add(st, write_test_ref, &ref);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_stack_add(st, write_test_ref, &ref);
     -	check(!err);
    --
    --	err = reftable_stack_read_ref(st, ref.refname, &dest);
    ++	cl_assert(!err);
    + 
    + 	err = reftable_stack_read_ref(st, ref.refname, &dest);
     -	check(!err);
     -	check(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1));
    --	check_int(st->readers_len, >, 0);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    -+	cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    -+	cl_assert(reftable_stack_read_ref(st, ref.refname, &dest) == 0);
    -+	cl_assert(reftable_ref_record_equal(&ref, &dest, REFTABLE_HASH_SIZE_SHA1) != 0);
    -+	cl_assert(st->readers_len > 0);
    +-	check_int(st->tables_len, >, 0);
    ++	cl_assert(!err);
    ++	cl_assert(reftable_ref_record_equal(&ref, &dest,
    ++					    REFTABLE_HASH_SIZE_SHA1));
    ++	cl_assert(st->tables_len > 0);
      
      #ifndef GIT_WINDOWS_NATIVE
     -	check(!reftable_buf_addstr(&scratch, dir));
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_one(void)
     +	cl_assert(reftable_buf_addstr(&scratch, dir) == 0);
     +	cl_assert(reftable_buf_addstr(&scratch, "/") == 0);
      	/* do not try at home; not an external API for reftable. */
    --	check(!reftable_buf_addstr(&scratch, st->readers[0]->name));
    --	err = stat(scratch.buf, &stat_result);
    +-	check(!reftable_buf_addstr(&scratch, st->tables[0]->name));
    ++	cl_assert(!reftable_buf_addstr(&scratch, st->tables[0]->name));
    + 	err = stat(scratch.buf, &stat_result);
     -	check(!err);
     -	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
    -+	cl_assert(reftable_buf_addstr(&scratch, st->readers[0]->name) == 0);
    -+	cl_assert(stat(scratch.buf, &stat_result) == 0);
    -+	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
    ++	cl_assert(!err);
    ++	cl_assert_equal_i((stat_result.st_mode & 0777),
    ++			   opts.default_permissions);
      #else
      	(void) stat_result;
      #endif
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api_pe
      		 * all tables in the stack.
      		 */
      		if (i != n)
    --			check_int(st->merged->readers_len, ==, i + 1);
    -+			cl_assert_equal_i(st->merged->readers_len, i + 1);
    +-			check_int(st->merged->tables_len, ==, i + 1);
    ++			cl_assert_equal_i(st->merged->tables_len, i + 1);
      		else
    --			check_int(st->merged->readers_len, ==, 1);
    -+			cl_assert_equal_i(st->merged->readers_len, 1);
    +-			check_int(st->merged->tables_len, ==, 1);
    ++			cl_assert_equal_i(st->merged->tables_len, 1);
      	}
      
      	reftable_stack_destroy(st);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_transaction_api_pe
      	struct reftable_ref_record ref = {
      		.refname = (char *) "refs/heads/master",
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_fails_gracefully(void)
    - 	struct reftable_stack *st;
    - 	struct reftable_buf table_path = REFTABLE_BUF_INIT;
      	char *dir = get_tmp_dir(__LINE__);
    --	int err;
    + 	int err;
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
     -
     -	err = reftable_stack_add(st, write_test_ref, &ref);
     -	check(!err);
    --	check_int(st->merged->readers_len, ==, 1);
    +-	check_int(st->merged->tables_len, ==, 1);
     -	check_int(st->stats.attempts, ==, 0);
     -	check_int(st->stats.failures, ==, 0);
     +	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
     +	cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    -+	cl_assert_equal_i(st->merged->readers_len, 1);
    ++	cl_assert_equal_i(st->merged->tables_len, 1);
     +	cl_assert_equal_i(st->stats.attempts, 0);
     +	cl_assert_equal_i(st->stats.failures, 0);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_fa
      	 */
     -	check(!reftable_buf_addstr(&table_path, dir));
     -	check(!reftable_buf_addstr(&table_path, "/"));
    --	check(!reftable_buf_addstr(&table_path, st->readers[0]->name));
    +-	check(!reftable_buf_addstr(&table_path, st->tables[0]->name));
     -	check(!reftable_buf_addstr(&table_path, ".lock"));
    -+	cl_assert(reftable_buf_addstr(&table_path, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&table_path, "/") == 0);
    -+	cl_assert(reftable_buf_addstr(&table_path, st->readers[0]->name) == 0);
    -+	cl_assert(reftable_buf_addstr(&table_path, ".lock") == 0);
    ++	cl_assert(!reftable_buf_addstr(&table_path, dir));
    ++	cl_assert(!reftable_buf_addstr(&table_path, "/"));
    ++	cl_assert(!reftable_buf_addstr(&table_path,
    ++				       st->tables[0]->name));
    ++	cl_assert(!reftable_buf_addstr(&table_path, ".lock"));
      	write_file_buf(table_path.buf, "", 0);
      
      	ref.update_index = 2;
    --	err = reftable_stack_add(st, write_test_ref, &ref);
    + 	err = reftable_stack_add(st, write_test_ref, &ref);
     -	check(!err);
    --	check_int(st->merged->readers_len, ==, 2);
    +-	check_int(st->merged->tables_len, ==, 2);
     -	check_int(st->stats.attempts, ==, 1);
     -	check_int(st->stats.failures, ==, 1);
    -+	cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    -+	cl_assert_equal_i(st->merged->readers_len, 2);
    ++	cl_assert(!err);
    ++	cl_assert_equal_i(st->merged->tables_len, 2);
     +	cl_assert_equal_i(st->stats.attempts, 1);
     +	cl_assert_equal_i(st->stats.failures, 1);
      
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_update_index_check
      		.exact_log_message = 1,
      		.default_permissions = 0660,
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
    + 	struct reftable_buf path = REFTABLE_BUF_INIT;
      	struct stat stat_result;
      	size_t i, N = ARRAY_SIZE(refs);
    ++	int err;
      
    --	err = reftable_new_stack(&st, dir, &opts);
    + 	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    -+	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
    ++	cl_assert(!err);
      
      	for (i = 0; i < N; i++) {
      		char buf[256];
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add(void)
     +	cl_assert(reftable_buf_addstr(&path, dir) == 0);
     +	cl_assert(reftable_buf_addstr(&path, "/") == 0);
      	/* do not try at home; not an external API for reftable. */
    --	check(!reftable_buf_addstr(&path, st->readers[0]->name));
    --	err = stat(path.buf, &stat_result);
    +-	check(!reftable_buf_addstr(&path, st->tables[0]->name));
    ++	cl_assert(!reftable_buf_addstr(&path, st->tables[0]->name));
    + 	err = stat(path.buf, &stat_result);
     -	check(!err);
     -	check_int((stat_result.st_mode & 0777), ==, opts.default_permissions);
    -+	cl_assert(reftable_buf_addstr(&path, st->readers[0]->name) == 0);
    -+	cl_assert(stat(path.buf, &stat_result) == 0);
    ++	cl_assert(!err);
     +	cl_assert_equal_i((stat_result.st_mode & 0777), opts.default_permissions);
      #else
      	(void) stat_result;
    @@ t/unit-tests/u-reftable-stack.c: static int fastlogN(uint64_t sz, uint64_t N)
      	char *dir = get_tmp_dir(__LINE__);
     -	int err;
      	size_t i, N = 100;
    ++	int err;
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    @@ t/unit-tests/u-reftable-stack.c: static int fastlogN(uint64_t sz, uint64_t N)
      	for (i = 0; i < N; i++) {
      		char name[100];
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction(void)
    - 		};
      		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
      
    --		err = reftable_stack_add(st, write_test_ref, &ref);
    + 		err = reftable_stack_add(st, write_test_ref, &ref);
     -		check(!err);
    --
    --		err = reftable_stack_auto_compact(st);
    ++		cl_assert(!err);
    + 
    + 		err = reftable_stack_auto_compact(st);
     -		check(!err);
    --		check(i < 2 || st->merged->readers_len < 2 * fastlogN(i, 2));
    -+		cl_assert(reftable_stack_add(st, write_test_ref, &ref) == 0);
    -+		cl_assert(reftable_stack_auto_compact(st) == 0);
    -+		cl_assert(i < 2 || st->merged->readers_len < 2 * fastlogN(i, 2));
    +-		check(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
    ++		cl_assert(!err);
    ++		cl_assert(i < 2 || st->merged->tables_len < 2 * fastlogN(i, 2));
      	}
      
     -	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
      	char *dir = get_tmp_dir(__LINE__);
     -	int err;
      	size_t N = 100;
    ++	int err;
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
      	for (size_t i = 0; i < N; i++) {
      		char name[20];
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_factor(void)
    - 		};
      		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
      
    --		err = reftable_stack_add(st, &write_test_ref, &ref);
    + 		err = reftable_stack_add(st, &write_test_ref, &ref);
     -		check(!err);
    --
    --		check(i < 5 || st->merged->readers_len < 5 * fastlogN(i, 5));
    -+		cl_assert(reftable_stack_add(st, &write_test_ref, &ref) == 0);
    -+		cl_assert(i < 5 || st->merged->readers_len < 5 * fastlogN(i, 5));
    ++		cl_assert(!err);
    + 
    +-		check(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
    ++		cl_assert(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
      	}
      
      	reftable_stack_destroy(st);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_fa
      	struct reftable_write_options opts = {
      		.disable_auto_compact = 1,
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_with_locked_tables(void)
    - 	struct reftable_stack *st = NULL;
    - 	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	char *dir = get_tmp_dir(__LINE__);
    --	int err;
    + 	int err;
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
     +	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
      
      	write_n_ref_tables(st, 5);
    --	check_int(st->merged->readers_len, ==, 5);
    -+	cl_assert_equal_i(st->merged->readers_len, 5);
    +-	check_int(st->merged->tables_len, ==, 5);
    ++	cl_assert_equal_i(st->merged->tables_len, 5);
      
      	/*
      	 * Given that all tables we have written should be roughly the same
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_wi
      	 */
     -	check(!reftable_buf_addstr(&buf, dir));
     -	check(!reftable_buf_addstr(&buf, "/"));
    --	check(!reftable_buf_addstr(&buf, st->readers[2]->name));
    +-	check(!reftable_buf_addstr(&buf, st->tables[2]->name));
     -	check(!reftable_buf_addstr(&buf, ".lock"));
    -+	cl_assert(reftable_buf_addstr(&buf, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, "/") == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, st->readers[2]->name) == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, ".lock") == 0);
    ++	cl_assert(!reftable_buf_addstr(&buf, dir));
    ++	cl_assert(!reftable_buf_addstr(&buf, "/"));
    ++	cl_assert(!reftable_buf_addstr(&buf, st->tables[2]->name));
    ++	cl_assert(!reftable_buf_addstr(&buf, ".lock"));
      	write_file_buf(buf.buf, "", 0);
      
      	/*
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_auto_compaction_with_locked_tables(void)
    - 	 * would in theory compact all tables, due to the preexisting lock we
      	 * only compact the newest two tables.
      	 */
    --	err = reftable_stack_auto_compact(st);
    + 	err = reftable_stack_auto_compact(st);
     -	check(!err);
     -	check_int(st->stats.failures, ==, 0);
    --	check_int(st->merged->readers_len, ==, 4);
    -+	cl_assert(reftable_stack_auto_compact(st) == 0);
    +-	check_int(st->merged->tables_len, ==, 4);
    ++	cl_assert(!err);
     +	cl_assert_equal_i(st->stats.failures, 0);
    -+	cl_assert_equal_i(st->merged->readers_len, 4);
    ++	cl_assert_equal_i(st->merged->tables_len, 4);
      
      	reftable_stack_destroy(st);
      	reftable_buf_release(&buf);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_performs_auto_
      		 * all tables in the stack.
      		 */
      		if (i != n)
    --			check_int(st->merged->readers_len, ==, i + 1);
    -+			cl_assert_equal_i(st->merged->readers_len, i + 1);
    +-			check_int(st->merged->tables_len, ==, i + 1);
    ++			cl_assert_equal_i(st->merged->tables_len, i + 1);
      		else
    --			check_int(st->merged->readers_len, ==, 1);
    -+			cl_assert_equal_i(st->merged->readers_len, 1);
    +-			check_int(st->merged->tables_len, ==, 1);
    ++			cl_assert_equal_i(st->merged->tables_len, 1);
      	}
      
      	reftable_stack_destroy(st);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_add_performs_auto_
      	struct reftable_write_options opts = {
      		.disable_auto_compact = 1,
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_locked_tables(void)
    - 	struct reftable_stack *st = NULL;
    - 	struct reftable_buf buf = REFTABLE_BUF_INIT;
      	char *dir = get_tmp_dir(__LINE__);
    --	int err;
    + 	int err;
      
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
     +	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
      
      	write_n_ref_tables(st, 3);
    --	check_int(st->merged->readers_len, ==, 3);
    -+	cl_assert_equal_i(st->merged->readers_len, 3);
    +-	check_int(st->merged->tables_len, ==, 3);
    ++	cl_assert_equal_i(st->merged->tables_len, 3);
      
      	/* Lock one of the tables that we're about to compact. */
     -	check(!reftable_buf_addstr(&buf, dir));
     -	check(!reftable_buf_addstr(&buf, "/"));
    --	check(!reftable_buf_addstr(&buf, st->readers[1]->name));
    +-	check(!reftable_buf_addstr(&buf, st->tables[1]->name));
     -	check(!reftable_buf_addstr(&buf, ".lock"));
    -+	cl_assert(reftable_buf_addstr(&buf, dir) == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, "/") == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, st->readers[1]->name) == 0);
    -+	cl_assert(reftable_buf_addstr(&buf, ".lock") == 0);
    ++	cl_assert(!reftable_buf_addstr(&buf, dir));
    ++	cl_assert(!reftable_buf_addstr(&buf, "/"));
    ++	cl_assert(!reftable_buf_addstr(&buf, st->tables[1]->name));
    ++	cl_assert(!reftable_buf_addstr(&buf, ".lock"));
      	write_file_buf(buf.buf, "", 0);
      
      	/*
    - 	 * Compaction is expected to fail given that we were not able to
    +@@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_locked_tables(void)
      	 * compact all tables.
      	 */
    --	err = reftable_stack_compact_all(st, NULL);
    + 	err = reftable_stack_compact_all(st, NULL);
     -	check_int(err, ==, REFTABLE_LOCK_ERROR);
     -	check_int(st->stats.failures, ==, 1);
    --	check_int(st->merged->readers_len, ==, 3);
    -+	cl_assert_equal_i(reftable_stack_compact_all(st, NULL), REFTABLE_LOCK_ERROR);
    +-	check_int(st->merged->tables_len, ==, 3);
    ++	cl_assert_equal_i(err, REFTABLE_LOCK_ERROR);
     +	cl_assert_equal_i(st->stats.failures, 1);
    -+	cl_assert_equal_i(st->merged->readers_len, 3);
    ++	cl_assert_equal_i(st->merged->tables_len, 3);
      
      	reftable_stack_destroy(st);
      	reftable_buf_release(&buf);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_with_lo
      }
      
     @@ t/unit-tests/u-reftable-stack.c: static void unclean_stack_close(struct reftable_stack *st)
    - 	REFTABLE_FREE_AND_NULL(st->readers);
    + 	REFTABLE_FREE_AND_NULL(st->tables);
      }
      
     -static void t_reftable_stack_compaction_concurrent_clean(void)
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_compaction_concurr
      {
      	struct reftable_write_options opts = { 0 };
      	struct reftable_stack *st1 = NULL, *st2 = NULL;
    - 	struct reftable_ref_record rec = { 0 };
    - 	struct reftable_iterator it = { 0 };
    - 	char *dir = get_tmp_dir(__LINE__);
    --	int err;
    +@@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_read_across_reload(void)
    + 	int err;
      
      	/* Create a first stack and set up an iterator for it. */
     -	err = reftable_new_stack(&st1, dir, &opts);
     -	check(!err);
     +	cl_assert(reftable_new_stack(&st1, dir, &opts) == 0);
      	write_n_ref_tables(st1, 2);
    --	check_int(st1->merged->readers_len, ==, 2);
    -+	cl_assert_equal_i(st1->merged->readers_len, 2);
    +-	check_int(st1->merged->tables_len, ==, 2);
    ++	cl_assert_equal_i(st1->merged->tables_len, 2);
      	reftable_stack_init_ref_iterator(st1, &it);
     -	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
     +	cl_assert(reftable_iterator_seek_ref(&it, "") == 0);
      
      	/* Set up a second stack for the same directory and compact it. */
    --	err = reftable_new_stack(&st2, dir, &opts);
    + 	err = reftable_new_stack(&st2, dir, &opts);
     -	check(!err);
    --	check_int(st2->merged->readers_len, ==, 2);
    --	err = reftable_stack_compact_all(st2, NULL);
    +-	check_int(st2->merged->tables_len, ==, 2);
    ++	cl_assert(!err);
    ++	cl_assert_equal_i(st2->merged->tables_len, 2);
    + 	err = reftable_stack_compact_all(st2, NULL);
     -	check(!err);
    --	check_int(st2->merged->readers_len, ==, 1);
    -+	cl_assert(reftable_new_stack(&st2, dir, &opts) == 0);
    -+	cl_assert_equal_i(st2->merged->readers_len, 2);
    -+	cl_assert(reftable_stack_compact_all(st2, NULL) == 0);
    -+	cl_assert_equal_i(st2->merged->readers_len, 1);
    +-	check_int(st2->merged->tables_len, ==, 1);
    ++	cl_assert(!err);
    ++	cl_assert_equal_i(st2->merged->tables_len, 1);
      
      	/*
      	 * Verify that we can continue to use the old iterator even after we
      	 * have reloaded its stack.
      	 */
    --	err = reftable_stack_reload(st1);
    + 	err = reftable_stack_reload(st1);
     -	check(!err);
    --	check_int(st1->merged->readers_len, ==, 1);
    --	err = reftable_iterator_next_ref(&it, &rec);
    +-	check_int(st1->merged->tables_len, ==, 1);
    ++	cl_assert(!err);
    ++	cl_assert_equal_i(st1->merged->tables_len, 1);
    + 	err = reftable_iterator_next_ref(&it, &rec);
     -	check(!err);
     -	check_str(rec.refname, "refs/heads/branch-0000");
    --	err = reftable_iterator_next_ref(&it, &rec);
    ++	cl_assert(!err);
    ++	cl_assert_equal_s(rec.refname, "refs/heads/branch-0000");
    + 	err = reftable_iterator_next_ref(&it, &rec);
     -	check(!err);
     -	check_str(rec.refname, "refs/heads/branch-0001");
    --	err = reftable_iterator_next_ref(&it, &rec);
    --	check_int(err, >, 0);
    -+	cl_assert(reftable_stack_reload(st1) == 0);
    -+	cl_assert_equal_i(st1->merged->readers_len, 1);
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
    -+	cl_assert_equal_s(rec.refname, "refs/heads/branch-0000");
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) == 0);
    ++	cl_assert(!err);
     +	cl_assert_equal_s(rec.refname, "refs/heads/branch-0001");
    -+	cl_assert(reftable_iterator_next_ref(&it, &rec) > 0);
    + 	err = reftable_iterator_next_ref(&it, &rec);
    +-	check_int(err, >, 0);
    ++	cl_assert(err > 0);
      
      	reftable_ref_record_release(&rec);
      	reftable_iterator_destroy(&it);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_read_across_reload
      	struct reftable_write_options opts = { 0 };
      	struct reftable_stack *st = NULL;
     @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missing_table(void)
    - 	struct reftable_iterator it = { 0 };
    - 	struct reftable_buf table_path = REFTABLE_BUF_INIT, content = REFTABLE_BUF_INIT;
    - 	char *dir = get_tmp_dir(__LINE__);
    --	int err;
    + 	int err;
      
      	/* Create a first stack and set up an iterator for it. */
     -	err = reftable_new_stack(&st, dir, &opts);
     -	check(!err);
     +	cl_assert(reftable_new_stack(&st, dir, &opts) == 0);
      	write_n_ref_tables(st, 2);
    --	check_int(st->merged->readers_len, ==, 2);
    -+	cl_assert_equal_i(st->merged->readers_len, 2);
    +-	check_int(st->merged->tables_len, ==, 2);
    ++	cl_assert_equal_i(st->merged->tables_len, 2);
      	reftable_stack_init_ref_iterator(st, &it);
     -	err = reftable_iterator_seek_ref(&it, "");
     -	check(!err);
    @@ t/unit-tests/u-reftable-stack.c: static void t_reftable_stack_reload_with_missin
      
      	/*
      	 * Update the tables.list file with some garbage data, while reusing
    - 	 * our old readers. This should trigger a partial reload of the stack,
    - 	 * where we try to reuse our old readers.
    + 	 * our old tables. This should trigger a partial reload of the stack,
    + 	 * where we try to reuse our old tables.
      	*/
    --	check(!reftable_buf_addstr(&content, st->readers[0]->name));
    +-	check(!reftable_buf_addstr(&content, st->tables[0]->name));
     -	check(!reftable_buf_addstr(&content, "\n"));
    --	check(!reftable_buf_addstr(&content, st->readers[1]->name));
    +-	check(!reftable_buf_addstr(&content, st->tables[1]->name));
     -	check(!reftable_buf_addstr(&content, "\n"));
     -	check(!reftable_buf_addstr(&content, "garbage\n"));
     -	check(!reftable_buf_addstr(&table_path, st->list_file));
     -	check(!reftable_buf_addstr(&table_path, ".lock"));
    -+	cl_assert(reftable_buf_addstr(&content, st->readers[0]->name) == 0);
    -+	cl_assert(reftable_buf_addstr(&content, "\n") == 0);
    -+	cl_assert(reftable_buf_addstr(&content, st->readers[1]->name) == 0);
    -+	cl_assert(reftable_buf_addstr(&content, "\n") == 0);
    -+	cl_assert(reftable_buf_addstr(&content, "garbage\n") == 0);
    -+	cl_assert(reftable_buf_addstr(&table_path, st->list_file) == 0);
    -+	cl_assert(reftable_buf_addstr(&table_path, ".lock") == 0);
    ++	cl_assert(!reftable_buf_addstr(&content, st->tables[0]->name));
    ++	cl_assert(!reftable_buf_addstr(&content, "\n"));
    ++	cl_assert(!reftable_buf_addstr(&content, st->tables[1]->name));
    ++	cl_assert(!reftable_buf_addstr(&content, "\n"));
    ++	cl_assert(!reftable_buf_addstr(&content, "garbage\n"));
    ++	cl_assert(!reftable_buf_addstr(&table_path, st->list_file));
    ++	cl_assert(!reftable_buf_addstr(&table_path, ".lock"));
      	write_file_buf(table_path.buf, content.buf, content.len);
     -	err = rename(table_path.buf, st->list_file);
     -	check(!err);
     +	cl_assert(rename(table_path.buf, st->list_file) == 0);
      
    --	err = reftable_stack_reload(st);
    + 	err = reftable_stack_reload(st);
     -	check_int(err, ==, -4);
    --	check_int(st->merged->readers_len, ==, 2);
    -+	cl_assert_equal_i(reftable_stack_reload(st), -4);
    -+	cl_assert_equal_i(st->merged->readers_len, 2);
    +-	check_int(st->merged->tables_len, ==, 2);
    ++	cl_assert_equal_i(err, -4);
    ++	cl_assert_equal_i(st->merged->tables_len, 2);
      
      	/*
      	 * Even though the reload has failed, we should be able to continue
10:  79aa0145aa <  -:  ---------- t/unit-tests: adapt lib-reftable{c,h} helper functions to clar
 -:  ---------- > 10:  7ea45d3600 t/unit-tests: finalize migration of reftable-related tests
-- 
2.43.0

