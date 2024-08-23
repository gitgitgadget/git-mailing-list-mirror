Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB4184548
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414759; cv=none; b=IP46/HfyQe3aBcbKKMZrwBFtkieBkuE6Yij3/ZOKE1zo1A08xfuHZfMJeYI3C+LY7STiIgb8+DP48PmbgO8KCmEomqusfO5R8ELa47u8fBLge9XWkQ8hwWcIO/epXAclt4mvVmdkNlhyylHf7g2N6NmDPE9X9PG8lTnND42FsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414759; c=relaxed/simple;
	bh=TYAjQAzfBm4MMtWvNVdxbvtzhKzPqdpoowqFRGbDIGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avLSkBsenC+/t9kgwaHBzbksoDD9gFWGeJMQb++rAW0ZN+7ytVQt0HdL6hlzC+Zg9Q8ss5QmTIglpz2B8dwCzYJMa1W/39dWf+Cud6fnYRGcv7pKII4hz+qamrFlM5uramiWi6yMTSpLMnu0tdw4s0VrBFJmU1rKAM2SyEBIKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLpvCdvS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLpvCdvS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2021537a8e6so16908145ad.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414755; x=1725019555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj8kwh3pvNOwZCG3a/a170UM3XcX6UpLzkV2JqMFqOQ=;
        b=cLpvCdvS9g9f6pBJnIcQWSsVurZbjHLRC/QfJUhePuroG/G3wCPrEgrb/w0I0HThQi
         WZ4IEdnADeaXidLIWdpFXOL0D8o/JUGg5FQNT2klH3KBMuOOFLUbUnvDYi8miPS7Ke3W
         W0QoNTYq5M8F1vVq7HSfGKVc56sP9vIXh0I76EOnwHesCw3cuT+PUkCY8LefRlPEEC8y
         Dnw0dN1tyWIAOG/9gIea486odO74gpBIfGXv74OkUv6XwtJxNryr6BiNEu1kpKWUw9lS
         WCrE34SpYRJhBi671dBn9q7IGsZIafDJSyzC1EHxh6dSWN3HUTl0fraGW7sB4r12YD3V
         HDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414755; x=1725019555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj8kwh3pvNOwZCG3a/a170UM3XcX6UpLzkV2JqMFqOQ=;
        b=RIqPTyt4ZvZRAA8Jwp2WBu/hW+TG/zh7LdNknxULgGf0SGSBYrFxZ/B2cXLfhm/K/I
         hEIh7owDkpxy3YMbPeTI7tOcRR96oBO1ofmSZCLehejAv7bp37CduUzD/ZQKZw185dGc
         6L9TgNAcZ1AVmz3p7O9LsPQi+Mvc5l0orXSwUQVe7iwbTIXega2wZagDjnzgrbTnSUmH
         CPGB56miCEily1OrlrGuQniByFiIaj5SbD0XOKCxhQqrrQAjrJvoHMZyUUU9Mf5HhOGH
         O9ONDTkOPEqyRfAO4JuU2ev/4cWeuRClXNlqPtHZl6ie/jqZ1hESZ2Cp2Lh8oabdUDNb
         Fhxw==
X-Gm-Message-State: AOJu0YwANNC9W/wvLV73zifPq+cMkfo2etGyNF80V1QSvLPl0T/SDCfe
	kHosiTIzChNGsz0ZZ1/pn0lqgpPJ41TbRUglr8qzguCTFaZY2bgHYqs02g==
X-Google-Smtp-Source: AGHT+IEntOWpTgPq/2ViOhJWTJZPvDVBITcpWAniyrvoWElPqhJ1ICzD6omo1mq/myUQfWFztp1kPA==
X-Received: by 2002:a17:902:e80f:b0:202:4a15:17fe with SMTP id d9443c01a7336-2039e4ae455mr24020285ad.30.1724414754550;
        Fri, 23 Aug 2024 05:05:54 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:05:53 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v2 0/6] t: port reftable/stack_test.c to the unit testing framework
Date: Fri, 23 Aug 2024 17:18:45 +0530
Message-ID: <20240823120514.11070-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/stack_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v2:
- Rebase the branch on top of latest 'master', this ensures that
  updates to reftable/stack_test.c are included in the ported test.
- Fix a typo in the commit message patch 2.
- Use ' = { 0 }' to 0-initialize arrays of structs instead
  of ' = { { 0 } }' in patch 2.
- use 'xstrfmt()' instead of a char buffer and 'xstrdup()' in the
  new test in patch 6.

CI/PR: https://github.com/gitgitgadget/git/pull/1762

Chandra Pratap(6):
t: move reftable/stack_test.c to the unit testing framework
t: harmonize t-reftable-stack.c with coding guidelines
t-reftable-stack: use Git's tempfile API instead of mkstemp()
t-reftable-stack: use reftable_ref_record_equal() to compare ref records
t-reftable-stack: add test for non-default compaction factor
t-reftable-stack: add test for stack iterators

Makefile                                                 |   2 +-
reftable/reftable-tests.h                                |   1 -
t/helper/test-reftable.c                                 |   1 -
reftable/stack_test.c => t/unit-tests/t-reftable-stack.c | 611 +++++++++++++++++++--------------
4 files changed, 360 insertions(+), 255 deletions(-)

Range-diff against v1:
<rebase commits>
  1:  bd595290dc ! 167:  b401ef765a t: move reftable/stack_test.c to the unit testing framework
    @@ Commit message
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

      ## Makefile ##
    -@@ Makefile: UNIT_TEST_PROGRAMS += t-prio-queue
    - UNIT_TEST_PROGRAMS += t-reftable-basics
    +@@ Makefile: UNIT_TEST_PROGRAMS += t-reftable-basics
      UNIT_TEST_PROGRAMS += t-reftable-merged
    + UNIT_TEST_PROGRAMS += t-reftable-pq
      UNIT_TEST_PROGRAMS += t-reftable-record
     +UNIT_TEST_PROGRAMS += t-reftable-stack
    + UNIT_TEST_PROGRAMS += t-reftable-tree
      UNIT_TEST_PROGRAMS += t-strbuf
      UNIT_TEST_PROGRAMS += t-strcmp-offset
    - UNIT_TEST_PROGRAMS += t-strvec
    -@@ Makefile: REFTABLE_TEST_OBJS += reftable/block_test.o
    +@@ Makefile: REFTABLE_OBJS += reftable/writer.o
    + REFTABLE_TEST_OBJS += reftable/block_test.o
      REFTABLE_TEST_OBJS += reftable/dump.o
    - REFTABLE_TEST_OBJS += reftable/pq_test.o
      REFTABLE_TEST_OBJS += reftable/readwrite_test.o
     -REFTABLE_TEST_OBJS += reftable/stack_test.o
      REFTABLE_TEST_OBJS += reftable/test_framework.o
    - REFTABLE_TEST_OBJS += reftable/tree_test.o

    + TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))

      ## reftable/reftable-tests.h ##
    -@@ reftable/reftable-tests.h: int block_test_main(int argc, const char **argv);
    - int pq_test_main(int argc, const char **argv);
    +@@ reftable/reftable-tests.h: int basics_test_main(int argc, const char **argv);
    + int block_test_main(int argc, const char **argv);
      int record_test_main(int argc, const char **argv);
      int readwrite_test_main(int argc, const char **argv);
     -int stack_test_main(int argc, const char **argv);
    - int tree_test_main(int argc, const char **argv);
      int reftable_dump_main(int argc, char *const *argv);

    + #endif

      ## t/helper/test-reftable.c ##
     @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
    - 	tree_test_main(argc, argv);
    - 	pq_test_main(argc, argv);
    + 	/* test from simple to complex. */
    + 	block_test_main(argc, argv);
      	readwrite_test_main(argc, argv);
     -	stack_test_main(argc, argv);
      	return 0;
    @@ t/unit-tests/t-reftable-stack.c: license that can be found in the LICENSE file o
     +#include "reftable/stack.h"
      #include <dirent.h>

    - static void clear_dir(const char *dirname)
    -@@ t/unit-tests/t-reftable-stack.c: static void clear_dir(const char *dirname)
    - 	strbuf_release(&path);
    - }
    -
     +static void set_test_hash(uint8_t *p, int i)
     +{
     +	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
     +}
     +
    - static int count_dir_entries(const char *dirname)
    + static void clear_dir(const char *dirname)
      {
    - 	DIR *dir = opendir(dirname);
    + 	struct strbuf path = STRBUF_INIT;
     @@ t/unit-tests/t-reftable-stack.c: static char *get_tmp_template(int linenumber)
      static char *get_tmp_dir(int linenumber)
      {
    @@ t/unit-tests/t-reftable-stack.c: static void test_read_file(void)
      	}
      	free_names(names);
      	(void) remove(fn);
    +@@ t/unit-tests/t-reftable-stack.c: static void write_n_ref_tables(struct reftable_stack *st,
    + 		set_test_hash(ref.value.val1, i);
    +
    + 		err = reftable_stack_add(st, &write_test_ref, &ref);
    +-		EXPECT_ERR(err);
    ++		check(!err);
    + 	}
    +
    + 	st->opts.disable_auto_compact = disable_auto_compact;
     @@ t/unit-tests/t-reftable-stack.c: static int write_test_log(struct reftable_writer *wr, void *arg)
      	return reftable_writer_add_log(wr, wla->log);
      }
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction
      	}

     -	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
    --	       (uint64_t)(N * fastlog2(N)));
     +	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
    -+		 (uint64_t)(N * fastlog2(N)));
    + 	       (uint64_t)(N * fastlog2(N)));
    +
    + 	reftable_stack_destroy(st);
    + 	clear_dir(dir);
    + }
    +
    +-static void test_reftable_stack_auto_compaction_with_locked_tables(void)
    ++static void t_reftable_stack_auto_compaction_with_locked_tables(void)
    + {
    + 	struct reftable_write_options opts = {
    + 		.disable_auto_compact = 1,
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction_with_locked_tables(void)
    + 	int err;
    +
    + 	err = reftable_new_stack(&st, dir, &opts);
    +-	EXPECT_ERR(err);
    ++	check(!err);
    +
    + 	write_n_ref_tables(st, 5);
    +-	EXPECT(st->merged->stack_len == 5);
    ++	check_int(st->merged->stack_len, ==, 5);
    +
    + 	/*
    + 	 * Given that all tables we have written should be roughly the same
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_auto_compaction_with_locked_tables(void)
    + 	 * only compact the newest two tables.
    + 	 */
    + 	err = reftable_stack_auto_compact(st);
    +-	EXPECT_ERR(err);
    +-	EXPECT(st->stats.failures == 0);
    +-	EXPECT(st->merged->stack_len == 4);
    ++	check(!err);
    ++	check_int(st->stats.failures, ==, 0);
    ++	check_int(st->merged->stack_len, ==, 4);

      	reftable_stack_destroy(st);
    + 	strbuf_release(&buf);
      	clear_dir(dir);
      }

    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_add_performs_au
      	clear_dir(dir);
      }

    +-static void test_reftable_stack_compaction_with_locked_tables(void)
    ++static void t_reftable_stack_compaction_with_locked_tables(void)
    + {
    + 	struct reftable_write_options opts = {
    + 		.disable_auto_compact = 1,
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_with_locked_tables(void)
    + 	int err;
    +
    + 	err = reftable_new_stack(&st, dir, &opts);
    +-	EXPECT_ERR(err);
    ++	check(!err);
    +
    + 	write_n_ref_tables(st, 3);
    +-	EXPECT(st->merged->stack_len == 3);
    ++	check_int(st->merged->stack_len, ==, 3);
    +
    + 	/* Lock one of the tables that we're about to compact. */
    + 	strbuf_reset(&buf);
    +@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_with_locked_tables(void)
    + 	 * compact all tables.
    + 	 */
    + 	err = reftable_stack_compact_all(st, NULL);
    +-	EXPECT(err == REFTABLE_LOCK_ERROR);
    +-	EXPECT(st->stats.failures == 1);
    +-	EXPECT(st->merged->stack_len == 3);
    ++	check_int(err, ==, REFTABLE_LOCK_ERROR);
    ++	check_int(st->stats.failures, ==, 1);
    ++	check_int(st->merged->stack_len, ==, 3);
    +
    + 	reftable_stack_destroy(st);
    + 	strbuf_release(&buf);
    + 	clear_dir(dir);
    + }
    +
     -static void test_reftable_stack_compaction_concurrent(void)
     +static void t_reftable_stack_compaction_concurrent(void)
      {
      	struct reftable_write_options opts = { 0 };
      	struct reftable_stack *st1 = NULL, *st2 = NULL;
     @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_concurrent(void)
    - 	int N = 3;
    + 	int err;

      	err = reftable_new_stack(&st1, dir, &opts);
     -	EXPECT_ERR(err);
     +	check(!err);
    -
    - 	for (i = 0; i < N; i++) {
    - 		char name[100];
    -@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_concurrent(void)
    - 		snprintf(name, sizeof(name), "branch%04d", i);
    -
    - 		err = reftable_stack_add(st1, &write_test_ref, &ref);
    --		EXPECT_ERR(err);
    -+		check(!err);
    - 	}
    + 	write_n_ref_tables(st1, 3);

      	err = reftable_new_stack(&st2, dir, &opts);
     -	EXPECT_ERR(err);
    @@ t/unit-tests/t-reftable-stack.c: static void unclean_stack_close(struct reftable
      	struct reftable_write_options opts = { 0 };
      	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
     @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_concurrent_clean(void)
    - 	int N = 3;
    + 	int err;

      	err = reftable_new_stack(&st1, dir, &opts);
     -	EXPECT_ERR(err);
     +	check(!err);
    -
    - 	for (i = 0; i < N; i++) {
    - 		char name[100];
    -@@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_concurrent_clean(void)
    - 		snprintf(name, sizeof(name), "branch%04d", i);
    -
    - 		err = reftable_stack_add(st1, &write_test_ref, &ref);
    --		EXPECT_ERR(err);
    -+		check(!err);
    - 	}
    + 	write_n_ref_tables(st1, 3);

      	err = reftable_new_stack(&st2, dir, &opts);
     -	EXPECT_ERR(err);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_conc
     -	RUN_TEST(test_reftable_stack_add);
     -	RUN_TEST(test_reftable_stack_add_one);
     -	RUN_TEST(test_reftable_stack_auto_compaction);
    +-	RUN_TEST(test_reftable_stack_auto_compaction_with_locked_tables);
     -	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
     -	RUN_TEST(test_reftable_stack_compaction_concurrent);
     -	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
    +-	RUN_TEST(test_reftable_stack_compaction_with_locked_tables);
     -	RUN_TEST(test_reftable_stack_hash_id);
     -	RUN_TEST(test_reftable_stack_lock_failure);
     -	RUN_TEST(test_reftable_stack_log_normalize);
    @@ t/unit-tests/t-reftable-stack.c: static void test_reftable_stack_compaction_conc
     +	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");
     +	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
     +	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
    ++	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
     +	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
     +	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
    ++	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
     +	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
     +	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");
     +	TEST(t_reftable_stack_log_normalize(), "log messages should be normalized");
  2:  64d91d89a5 ! 168:  e1704047cb t: harmonize t-reftable-stack.c with coding guidelines
    @@ Commit message
         with the following guidelines:
         - Single line 'for' statements must omit curly braces.
         - Structs must be 0-initialized with '= { 0 }' instead of '= { NULL }'.
    -    - Array sizes and indices should preferably be of type 'size_t'and
    +    - Array sizes and indices should preferably be of type 'size_t' and
           not 'int'.
         - Function pointers should be passed as 'func' and not '&func'.

    @@ t/unit-tests/t-reftable-stack.c: static void t_read_file(void)
      	free_names(names);
      	(void) remove(fn);
      }
    +@@ t/unit-tests/t-reftable-stack.c: static void write_n_ref_tables(struct reftable_stack *st,
    + 			.value_type = REFTABLE_REF_VAL1,
    + 		};
    +
    +-		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
    ++		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
    + 		ref.refname = buf.buf;
    + 		set_test_hash(ref.value.val1, i);
    +
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add_one(void)
      		.value_type = REFTABLE_REF_SYMREF,
      		.value.symref = (char *) "master",
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_transaction_api_pe
      	struct reftable_addition *add = NULL;
      	struct reftable_stack *st = NULL;
     -	int i, n = 20, err;
    -+	size_t i, n = 20;
    ++	size_t n = 20;
     +	int err;

      	err = reftable_new_stack(&st, dir, &opts);
      	check(!err);
    +
    +-	for (i = 0; i <= n; i++) {
    ++	for (size_t i = 0; i <= n; i++) {
    + 		struct reftable_ref_record ref = {
    + 			.update_index = reftable_stack_next_update_index(st),
    + 			.value_type = REFTABLE_REF_SYMREF,
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
      		};
      		char name[100];
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_transaction_api_pe
      		check(!err);

      		err = reftable_addition_commit(add);
    +@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_auto_compaction_fails_gracefully(void)
    + 		.value_type = REFTABLE_REF_VAL1,
    + 		.value.val1 = {0x01},
    + 	};
    +-	struct reftable_write_options opts = {0};
    ++	struct reftable_write_options opts = { 0 };
    + 	struct reftable_stack *st;
    + 	struct strbuf table_path = STRBUF_INIT;
    + 	char *dir = get_tmp_dir(__LINE__);
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_update_index_check(void)
      	err = reftable_new_stack(&st, dir, &opts);
      	check(!err);
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_lock_failure(void)
      static void t_reftable_stack_add(void)
      {
     -	int i = 0;
    --	int err = 0;
    -+	int err;
    + 	int err = 0;
      	struct reftable_write_options opts = {
      		.exact_log_message = 1,
    - 		.default_permissions = 0660,
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
      	};
      	struct reftable_stack *st = NULL;
      	char *dir = get_tmp_dir(__LINE__);
     -	struct reftable_ref_record refs[2] = { { NULL } };
     -	struct reftable_log_record logs[2] = { { NULL } };
    -+	struct reftable_ref_record refs[2] = { { 0 } };
    -+	struct reftable_log_record logs[2] = { { 0 } };
    ++	struct reftable_ref_record refs[2] = { 0 };
    ++	struct reftable_log_record logs[2] = { 0 };
      	struct strbuf path = STRBUF_INIT;
      	struct stat stat_result;
     -	int N = ARRAY_SIZE(refs);
    -+	size_t N = ARRAY_SIZE(refs), i;
    ++	size_t i, N = ARRAY_SIZE(refs);

      	err = reftable_new_stack(&st, dir, &opts);
      	check(!err);
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
      		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
      		check(!err);
      		check(reftable_log_record_equal(&dest, logs + i,
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
    -
    - static void t_reftable_stack_log_normalize(void)
    - {
    --	int err = 0;
    -+	int err;
    - 	struct reftable_write_options opts = {
    - 		0,
    - 	};
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_log_normalize(void)
      	check(!err);

    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_log_normalize(void
     -	int N = ARRAY_SIZE(refs);
     -	struct reftable_ref_record dest = { NULL };
     -	struct reftable_log_record log_dest = { NULL };
    -+	struct reftable_ref_record refs[2] = { { 0 } };
    -+	struct reftable_log_record logs[2] = { { 0 } };
    -+	size_t N = ARRAY_SIZE(refs), i;
    ++	struct reftable_ref_record refs[2] = { 0 };
    ++	struct reftable_log_record logs[2] = { 0 };
    ++	size_t i, N = ARRAY_SIZE(refs);
     +	struct reftable_ref_record dest = { 0 };
     +	struct reftable_log_record log_dest = { 0 };

    @@ t/unit-tests/t-reftable-stack.c: static void t_reflog_expire(void)
     -	struct reftable_log_record logs[20] = { { NULL } };
     -	int N = ARRAY_SIZE(logs) - 1;
     -	int i = 0;
    -+	struct reftable_log_record logs[20] = { { 0 } };
    -+	size_t N = ARRAY_SIZE(logs) - 1, i;
    ++	struct reftable_log_record logs[20] = { 0 };
    ++	size_t i, N = ARRAY_SIZE(logs) - 1;
      	int err;
      	struct reftable_log_expiry_config expiry = {
      		.time = 10,
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
     -	int err, i;
     -	int N = 100;
     +	int err;
    -+	size_t N = 100, i;
    ++	size_t i, N = 100;

      	err = reftable_new_stack(&st, dir, &opts);
      	check(!err);
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add_performs_auto_
      		check(!err);

      		/*
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent(void)
    - 	struct reftable_write_options opts = { 0 };
    - 	struct reftable_stack *st1 = NULL, *st2 = NULL;
    - 	char *dir = get_tmp_dir(__LINE__);
    --	int err, i;
    --	int N = 3;
    -+	int err;
    -+	size_t N = 3, i;
    -
    - 	err = reftable_new_stack(&st1, dir, &opts);
    - 	check(!err);
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent(void)
    - 			.value_type = REFTABLE_REF_SYMREF,
    - 			.value.symref = (char *) "master",
    - 		};
    --		snprintf(name, sizeof(name), "branch%04d", i);
    -+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
    -
    --		err = reftable_stack_add(st1, &write_test_ref, &ref);
    -+		err = reftable_stack_add(st1, write_test_ref, &ref);
    - 		check(!err);
    - 	}
    -
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent(void)
      static void unclean_stack_close(struct reftable_stack *st)
      {
      	/* break abstraction boundary to simulate unclean shutdown. */
     -	int i = 0;
     -	for (; i < st->readers_len; i++) {
    -+	for (size_t i = 0; i < st->readers_len; i++)
    ++	for (int i = 0; i < st->readers_len; i++)
      		reftable_reader_free(st->readers[i]);
     -	}
      	st->readers_len = 0;
      	FREE_AND_NULL(st->readers);
      }
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent_clean(void)
    - 	struct reftable_write_options opts = { 0 };
    - 	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
    - 	char *dir = get_tmp_dir(__LINE__);
    --	int err, i;
    --	int N = 3;
    -+	int err;
    -+	size_t N = 3, i;
    -
    - 	err = reftable_new_stack(&st1, dir, &opts);
    - 	check(!err);
    -@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_compaction_concurrent_clean(void)
    - 			.value_type = REFTABLE_REF_SYMREF,
    - 			.value.symref = (char *) "master",
    - 		};
    --		snprintf(name, sizeof(name), "branch%04d", i);
    -+		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
    -
    --		err = reftable_stack_add(st1, &write_test_ref, &ref);
    -+		err = reftable_stack_add(st1, write_test_ref, &ref);
    - 		check(!err);
    - 	}
    -
  3:  4e769b826f ! 169:  792a7b1e62 t-reftable-stack: use Git's tempfile API instead of mkstemp()
    @@ Metadata
      ## Commit message ##
         t-reftable-stack: use Git's tempfile API instead of mkstemp()

    -    Git's tempfile API defined by $GIT_DIR/tempfile.{c, h} provides
    +    Git's tempfile API defined by $GIT_DIR/tempfile.{c,h} provides
         a unified interface for tempfile operations. Since reftable/stack.c
         uses this API for all its tempfile needs instead of raw functions
         like mkstemp(), make the ported stack test strictly use Git's
  4:  8277e711af ! 170:  d771dc74af t-reftable-stack: use reftable_ref_record_equal() to compare ref records
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add_one(void)

      	printf("testing print functionality:\n");
     @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_transaction_api(void)
    -
      	err = reftable_stack_read_ref(st, ref.refname, &dest);
      	check(!err);
    --	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
    + 	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
     -	check_str("master", dest.value.symref);
     +	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));

  5:  9528f910ce ! 171:  c38a96cd4e t-reftable-stack: add test for non-default compaction factor
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_auto_compaction(vo
      	}

      	check_int(reftable_stack_compaction_stats(st)->entries_written, <,
    --		 (uint64_t)(N * fastlog2(N)));
    -+		 (uint64_t)(N * fastlogN(N, 2)));
    +-	       (uint64_t)(N * fastlog2(N)));
    ++	       (uint64_t)(N * fastlogN(N, 2)));
     +
     +	reftable_stack_destroy(st);
     +	clear_dir(dir);
    @@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc, const char *argv[])
      	TEST(t_reftable_stack_auto_compaction(), "stack must form geometric sequence after compaction");
     +	TEST(t_reftable_stack_auto_compaction_factor(), "auto-compaction with non-default geometric factor");
      	TEST(t_reftable_stack_auto_compaction_fails_gracefully(), "failure on auto-compaction");
    + 	TEST(t_reftable_stack_auto_compaction_with_locked_tables(), "auto compaction with locked tables");
      	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
    - 	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
  6:  bd997a27d7 ! 172:  ea5267ca22 t-reftable-stack: add test for stack iterators
    @@ Commit message
         t-reftable-stack: add test for stack iterators

         reftable_stack_init_ref_iterator and reftable_stack_init_log_iterator
    -    as defined by reftable/stack.{c, h} initialize a stack iterator to
    +    as defined by reftable/stack.{c,h} initialize a stack iterator to
         iterate over the ref and log records in a reftable stack respectively.
         Since these functions are not exercised by any of the existing tests,
         add a test for them.
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +	struct reftable_write_options opts = { 0 };
     +	struct reftable_stack *st = NULL;
     +	char *dir = get_tmp_dir(__LINE__);
    -+	struct reftable_ref_record refs[10] = { { 0 } };
    -+	struct reftable_log_record logs[10] = { { 0 } };
    ++	struct reftable_ref_record refs[10] = { 0 };
    ++	struct reftable_log_record logs[10] = { 0 };
     +	struct reftable_iterator it = { 0 };
     +	size_t N = ARRAY_SIZE(refs), i;
     +	int err;
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +	check(!err);
     +
     +	for (i = 0; i < N; i++) {
    -+		char buf[20];
    -+		xsnprintf(buf, sizeof(buf), "branch%02"PRIuMAX, (uintmax_t)i);
    -+		refs[i].refname = xstrdup(buf);
    ++		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
     +		refs[i].update_index = i + 1;
     +		refs[i].value_type = REFTABLE_REF_VAL1;
     +		set_test_hash(refs[i].value.val1, i);
     +
    -+		logs[i].refname = xstrdup(buf);
    ++		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
     +		logs[i].update_index = i + 1;
     +		logs[i].value_type = REFTABLE_LOG_UPDATE;
     +		logs[i].value.update.email = xstrdup("johndoe@invalid");
    @@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_add(void)
     +
      static void t_reftable_stack_log_normalize(void)
      {
    - 	int err;
    + 	int err = 0;
     @@ t/unit-tests/t-reftable-stack.c: int cmd_main(int argc, const char *argv[])
    - 	TEST(t_reftable_stack_compaction_concurrent(), "compaction with concurrent stack");
      	TEST(t_reftable_stack_compaction_concurrent_clean(), "compaction with unclean stack shutdown");
    + 	TEST(t_reftable_stack_compaction_with_locked_tables(), "compaction with locked tables");
      	TEST(t_reftable_stack_hash_id(), "read stack with wrong hash ID");
     +	TEST(t_reftable_stack_iterator(), "log and ref iterator for reftable stack");
      	TEST(t_reftable_stack_lock_failure(), "stack addition with lockfile failure");

