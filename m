Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93744C7D
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721629182; cv=none; b=kW2O93VtKMnGexKkTyWKAj940XS3we3EVUWeoVTikZN0n0CK9JoI0IJNewFH8APtlzdAHsVhPitr7QD8gwDsgYW5eUEUHvT29FVA3u0y8aY+/VlRacs4n4cQtvka5rbCrEaXCdjLOQRJUT5QiN1BBvqjjupg60nXwXcs9CZRylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721629182; c=relaxed/simple;
	bh=JAF3z62Synd+0u8ebQhT8+ChBt8BOSxguDv3i3h0fs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyNV3ZOuEEIMB8qr5olqY8Ci8ItLT11/nAHRbtt0Gngeis+t3lVHGRmhtSHEk9szMdiea9sJKMC4wqs6aMztPn0hmw0zeS0V6sJ6LcFp93D60Ca32VsertQf4Sa1DHQR1ASZ1+ShRhE71ihoIHFpOI7jmbAJU4SYKOY0Ow7UFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCdfNjd/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCdfNjd/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a211a272c2so373508a12.1
        for <git@vger.kernel.org>; Sun, 21 Jul 2024 23:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721629179; x=1722233979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTZ3fK9BFX3GznkQvWJYXLEoCkSZ4nCpI2c8ONhzoIc=;
        b=QCdfNjd/afPrMLpAbxVEZWhea1aFV56spuDBQ8zbPOqqu+d4IY0e08y/ovl77/C+Bq
         k7UI6KTMlYZIJ9DP2B2Jat3vjbw4919gj47JWApRolZRuR577axl7MAHacTApYRzDGCe
         TSKcnQGoYnFMMpZf78FHnfi6BtGBQ8vEjpwRgXT92TRQMUJLBQIyq6LKVJCTlM1nZnEZ
         Hz24L1aGnCFxCSeddEJvVf81+f4GJWwqKTf78k0vtLZ4Rt5mgKP3iIORtdfVY/CvYeLu
         SQAFoE9nPkNINfs9K4FTWTjf+bLSkI5l12G82w4qJqwmlZNwh89tKERq747BJ5QIp0f2
         tjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721629179; x=1722233979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTZ3fK9BFX3GznkQvWJYXLEoCkSZ4nCpI2c8ONhzoIc=;
        b=DaXIHFd4yWOlHsN+f1eZjH/hM5pNRyhYqtagd3h7HDpz2nLU+EcEDUBqaaMNzweZ15
         qWkM573C0hd17oBUrIQxwLULW4d1FaMXnGvVTLEthtWfnBbYBq4I6KrXWrHcMf0Q9q2I
         6FQ17zbsj9j2BJSLH89mgiKq1SsUQ0xVERazqDUZCtrWM9KrzIiaioqOj/zFMr2v4ZhJ
         J4P/smtakFNqlO4BD3ycDxeunbK4KXk6otSSroq6qyNJaL64wsogn90aKjYpduKYyQDT
         +9NZkc/Wggt6sl2uEVictn8wUCzSp9taRlMEmFDC3ssQ9IeO0V0rOBat8li/OpKGvjth
         sV9w==
X-Gm-Message-State: AOJu0Yx5aV5uAE5Ze8JuZtTLFyMb4azq0c1U3l6i9KXQRx/xq9kkPbAD
	UALve1dHVLeFNP1h/e38CDXTzBKWg/fCfMVncLctKWbr3I0cxRY/nEu1wOiYg1E=
X-Google-Smtp-Source: AGHT+IH+e5hk8+GsG5JhK9x0Amc/64jQsB4gHkHDxOcynOjWczeihlD51opPctJtZayqW+8LhOyQEw==
X-Received: by 2002:a17:902:da91:b0:1fb:d07c:64cd with SMTP id d9443c01a7336-1fc5b60a90cmr189432175ad.21.1721629179004;
        Sun, 21 Jul 2024 23:19:39 -0700 (PDT)
Received: from Ubuntu.. ([106.220.63.154])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f31a73csm46362885ad.143.2024.07.21.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:19:38 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	chriscool@tuxfamily.org
Subject: [GSoC][PATCH v5 0/5] t: port reftable/tree_test.c to the unit testing framework
Date: Mon, 22 Jul 2024 11:27:53 +0530
Message-ID: <20240722061836.4176-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240716075641.4264-1-chandrapratap3519@gmail.com>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
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

Hence, port reftable/tree_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series is
preparatory cleanup, the second patch moves the test to the unit
testing framework, and the rest of the patches improve upon the
ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v5:
- Rebase the branch on top of the latest master
- Add more explanation in the commit message of patch 2
- Refer to function pointers as 'func' and not '&func'
- Add comments and refactor the test in patch 2 for easier
  comprehension

CI/PR: https://github.com/gitgitgadget/git/pull/1740

Chandra Pratap(5):
reftable: remove unnecessary curly braces in reftable/tree.c
t: move reftable/tree_test.c to the unit testing framework
t-reftable-tree: split test_tree() into two sub-test
t-reftable-tree: add test for non-existent key
t-reftable-tree: improve the test for infix_walk()

Makefile                       |  2 +-
reftable/reftable-tests.h      |  1 -
reftable/tree.c                | 15 +++-------
reftable/tree_test.c           | 60 ----------------------
t/helper/test-reftable.c       |  1 -
t/unit-tests/t-reftable-tree.c | 83 +++++++++++++++++++++++++++++++++++++
6 files changed, 89 insertions(+), 73 deletions(-)

Range-diff against v4:
<rebase commits>
1:  2be2a35b7f = 45:  1d637f7686 reftable: remove unnecessary curly braces in reftable/tree.c
2:  de49698ea7 ! 46:  7401e2409f t: move reftable/tree_test.c to the unit testing framework
   @@ Commit message
        the unit testing framework instead of reftable's test framework and
        renaming the tests to align with unit-tests' standards.

   +    Also add a comment to help understand the test routine.
   +
   +    Note that this commit mostly moves the test from reftable/ to
   +    t/unit-tests/ and most of the refactoring is performed by the
   +    trailing commits.
   +
        Mentored-by: Patrick Steinhardt <ps@pks.im>
        Mentored-by: Christian Couder <chriscool@tuxfamily.org>
        Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

     ## Makefile ##
   -@@ Makefile: UNIT_TEST_PROGRAMS += t-mem-pool
   - UNIT_TEST_PROGRAMS += t-oidtree
   +@@ Makefile: UNIT_TEST_PROGRAMS += t-oidtree
     UNIT_TEST_PROGRAMS += t-prio-queue
     UNIT_TEST_PROGRAMS += t-reftable-basics
   + UNIT_TEST_PROGRAMS += t-reftable-record
    +UNIT_TEST_PROGRAMS += t-reftable-tree
     UNIT_TEST_PROGRAMS += t-strbuf
     UNIT_TEST_PROGRAMS += t-strcmp-offset
     UNIT_TEST_PROGRAMS += t-strvec
   -@@ Makefile: REFTABLE_TEST_OBJS += reftable/record_test.o
   +@@ Makefile: REFTABLE_TEST_OBJS += reftable/pq_test.o
     REFTABLE_TEST_OBJS += reftable/readwrite_test.o
     REFTABLE_TEST_OBJS += reftable/stack_test.o
     REFTABLE_TEST_OBJS += reftable/test_framework.o
    @@ reftable/tree_test.c (deleted)

     ## t/helper/test-reftable.c ##
    @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
   + {
    	/* test from simple to complex. */
   - 	record_test_main(argc, argv);
     	block_test_main(argc, argv);
    -	tree_test_main(argc, argv);
    	pq_test_main(argc, argv);
    @@ t/unit-tests/t-reftable-tree.c (new)
     +	size_t i = 1;
     +	struct curry c = { 0 };
     +
    ++	/* pseudo-randomly insert the pointers for elements between
    ++	 * values[1] and values[10] (included) in the tree.
    ++	 */
     +	do {
    -+		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
    ++		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
     +		i = (i * 7) % 11;
     +	} while (i != 1);
     +
     +	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
    -+		check_pointer_eq(values + i, nodes[i]->key);
    -+		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
    ++		check_pointer_eq(&values[i], nodes[i]->key);
    ++		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
     +	}
     +
     +	infix_walk(root, check_increasing, &c);
 3:  c733776054 ! 47:  59d5c17d5e t-reftable-tree: split test_tree() into two sub-test functions
    @@ Commit message
         'int insert' which when set, inserts the key if it is not found
         in the tree. Otherwise, the function returns NULL for such cases.

    +    While at it, use 'func' to pass function pointers and not '&func'.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ t/unit-tests/t-reftable-tree.c: static void check_increasing(void *arg, void *ke
      	size_t i = 1;
     -	struct curry c = { 0 };

    - 	do {
    - 		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
    + 	/* pseudo-randomly insert the pointers for elements between
    + 	 * values[1] and values[10] (included) in the tree.
     @@ t/unit-tests/t-reftable-tree.c: static void t_tree(void)
    - 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
    + 		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
      	}

     -	infix_walk(root, check_increasing, &c);
    @@ t/unit-tests/t-reftable-tree.c: static void t_tree(void)
     +	size_t i = 1;
     +
     +	do {
    -+		tree_search(values + i, &root, &t_compare, 1);
    ++		tree_search(&values[i], &root, t_compare, 1);
     +		i = (i * 7) % 11;
     +	} while (i != 1);
     +
 4:  f1a9325bb3 <  -:  ---------- t-reftable-tree: add test for non-existent key
 -:  ---------- > 48:  c1ce79916b t-reftable-tree: add test for non-existent key
 5:  c6b7a3d646 ! 49:  d1a5ced526 t-reftable-tree: improve the test for infix_walk()
    @@ t/unit-tests/t-reftable-tree.c: static void t_infix_walk(void)
     +	size_t count = 0;

      	do {
    - 		tree_search(values + i, &root, &t_compare, 1);
    + 		tree_search(&values[i], &root, t_compare, 1);
      		i = (i * 7) % 11;
     +		count++;
      	} while (i != 1);
    @@ t/unit-tests/t-reftable-tree.c: static void t_infix_walk(void)
     -	infix_walk(root, &check_increasing, &c);
     +	infix_walk(root, &store, &c);
     +	for (i = 1; i < ARRAY_SIZE(values); i++)
    -+		check_pointer_eq(values + i, out[i - 1]);
    ++		check_pointer_eq(&values[i], out[i - 1]);
     +	check(!out[i - 1]);
     +	check_int(c.len, ==, count);
      	tree_free(root);
