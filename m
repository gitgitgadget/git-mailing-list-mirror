Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25045D299
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556631; cv=none; b=PumMG9opE9P4NVWvDHjARmtEWS2LRwyrx7eNsChETdbsDtaBxuxllmF/UiBmFPnrXJqMN3h7o3ZcolojFQTLioKPHTn23pVmMTP+0b1q4W/XGKftG/r3QSGjIyPgOIjRcuOn1rJ8+yDxkeWgluvMLam8IsgSM1+GM4fUmd9OUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556631; c=relaxed/simple;
	bh=rMZ7b6yKy4o3zNNPU/wMRKlrXBgDWTSAT5fMRcPKpMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFp0bXZZ5lYodk7OlCUJlSKVUZM0rxnh8H+hq23dexIEMvjKdf02iEJnrLW+cCELOlZGjjEcijuzv3po+3HxwRi9Piy4qFxU4VSJN5irs5sNNlOexL0jJoEJCofUoLtYqYVmqq1CTOIi76ku3Oz+4Vv5hPICLl4PtWEcs+JAhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzdFWIRV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzdFWIRV"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700cc8e447aso140073a34.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556626; x=1720161426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHCb3PYpxfdVu7reAmNeAe6L4tnL5aOMDkJB8vgGCyA=;
        b=HzdFWIRV/IZ5uC1A3sUIxR28U9ehqagEhuICjjMT6mfQMX9DzBNDYnXOYQ5JHVPK6H
         rzIK7DDAUmOFjSKz6D5JLPH8DKe5hNJY3elduatC2Wvoo7Zoi3nnqhiB7ghkP+2wNi9i
         NjvK4BnpaMFM7nGqgQPCh8R6m1bid7EyDig4z+eKOuL6wDn/WHoSDJ8T5Raaj3TLKB5W
         9l1WfObQ8AG8LhXD5zK+MZg44pRPDJB/VXFtsLt947hwQ7QFo0f7lu0q9p+td9KO3vlI
         CGxf8KBDuWlj8cNdylPcTAWkfhSixY37sMgmCZ9EcS08ml0PZjAXn7hw+ZOuK1klB2Ss
         Xb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556626; x=1720161426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHCb3PYpxfdVu7reAmNeAe6L4tnL5aOMDkJB8vgGCyA=;
        b=jjWHvtitoAxlblNiB24DNID6yz0nbDpZqhYBEIRAxWFCbrDqzmHw6uRJszW8j3JPsB
         67qjrs6Vg1QEYwZ8Yy+WLYp/hxD6NIg/A4IQLJkioPS7OJUc+YYVUuZE36C/FRTRRFWV
         8WEwcEibd4cVuufUYLnbAQ12do11gPnL+Z1YBRqC33AOIA7avq1Fe8vYEnCxQHQi3Lod
         sGALb+JYpH0+ngYkPZzKxYwXoqrzLnOQvE4WtjCQHSp5XyY87MOfARiUz3RyGPYQ9Lga
         LUYX2a/l5z3Iv8G2ndDVfbl/IAK6negtDg5rhifFcajzsDzVI8Qed9OgSD6ZcRUO8JvM
         ajKA==
X-Gm-Message-State: AOJu0YzxE4FoEFJw8SwRJiCLMTP4eUQar46qem2K6BR75dVBhTkvzMrM
	fy/B3h3HLOYAYAdYE4BUoW1nUN5Al649E4PZxtxVBHUOaWT3PKDLuh0rdokCkjM=
X-Google-Smtp-Source: AGHT+IFuE6gczQOXnMtCcvnE5Y6HHoNK7i9r4RXgGr8gtU7DdPZ1QrHjIyr46DxMucKOMCV4LuweJw==
X-Received: by 2002:a05:6808:1407:b0:3d4:41b6:6c4e with SMTP id 5614622812f47-3d543b06a3cmr19735065b6e.16.1719556626038;
        Thu, 27 Jun 2024 23:37:06 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH v3 0/11] t: port reftable/record_test.c to the unit testing framework
Date: Fri, 28 Jun 2024 11:49:30 +0530
Message-ID: <20240628063625.4092-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621060018.12795-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
testing framework written entirely in C was introduced to the Git project
aimed at simplifying testing and reducing test run times.
Currently, tests for the reftable refs-backend are performed by a custom
testing framework defined by reftable/test_framework.{c, h}. Port
reftable/record_test.c to the unit testing framework and improve upon
the ported test.

The first patch in the series moves the test to the unit testing framework,
and the rest of the patches improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
Changes in v3:
- Remove reftable_record_print() from tests to reduce clutter in test output.
- Add more explanation to in-code comment in 1st patch.
- Use string literals instead of xstrdup() when possible to prevent the cost
  of mallocing and freeing.
- make reftable_record_is_deletion() test for refs conciser in 6th patch.
- Update commit messages for 7th, 8th and 9th patch to better reflect changes.
- Add tests for '== 0' and '> 0' cases n 10th and 11th patch.

CI/PR: https://github.com/gitgitgadget/git/pull/1750

Chandra Pratap (11):
t: move reftable/record_test.c to the unit testing framework
t-reftable-record: add reftable_record_cmp() tests for log records
t-reftable-record: add comparison tests for ref records
t-reftable-record: add comparison tests for index records
t-reftable-record: add comparison tests for obj records
t-reftable-record: add reftable_record_is_deletion() test for ref records
t-reftable-record: add reftable_record_is_deletion() test for log records
t-reftable-record: add reftable_record_is_deletion() test for obj records
t-reftable-record: add reftable_record_is_deletion() test for index records
t-reftable-record: add tests for reftable_ref_record_compare_name()
t-reftable-record: add tests for reftable_log_record_compare_key()

Makefile                         |   2 +-
reftable/record_test.c           | 382 -------------------------
t/helper/test-reftable.c         |   1 -
t/unit-tests/t-reftable-record.c | 554 +++++++++++++++++++++++++++++++++++++++++++++

Range-diff against v2:
 1:  d0646af549 !  1:  c88fb5bcfa t: move reftable/record_test.c to the unit testing framework
    @@ Commit message
         functions are similarly implemented, and
         reftable/test_framework.{c, h} is not #included in the ported test.

    +    Get rid of reftable_record_print() from the tests as well, because
    +    it clutters the test framework's output and we have no way of
    +    verifying the output.
    +
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
    @@ t/unit-tests/t-reftable-record.c: static void test_copy(struct reftable_record *
      	/* do it twice to catch memory leaks */
      	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
     -	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
    -+	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
    -
    +-
     -	puts("testing print coverage:\n");
    -+	test_msg("testing print coverage:");
    - 	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
    +-	reftable_record_print(&copy, GIT_SHA1_RAWSZ);
    ++	check(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));

      	reftable_record_release(&copy);
    + }
     @@ t/unit-tests/t-reftable-record.c: static void test_varint_roundtrip(void)
      			      4096,
      			      ((uint64_t)1 << 63),
 2:  90feb4168c !  2:  45ac972538 t-reftable-record: add reftable_record_cmp() tests for log records
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
     -			.refname = xstrdup("refs/heads/master"),
     -			.update_index = 42,
     +			.type = BLOCK_TYPE_LOG,
    -+			.u.log.refname = xstrdup("refs/heads/master"),
    ++			.u.log.refname = (char *) "refs/heads/master",
     +			.u.log.update_index = 42,
      		},
      		{
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
     -			.update_index = 22,
     -		}
     +			.type = BLOCK_TYPE_LOG,
    -+			.u.log.refname = xstrdup("refs/heads/master"),
    ++			.u.log.refname = (char *) "refs/heads/master",
     +			.u.log.update_index = 22,
     +		},
     +		{
     +			.type = BLOCK_TYPE_LOG,
    -+			.u.log.refname = xstrdup("refs/heads/main"),
    ++			.u.log.refname = (char *) "refs/heads/main",
     +			.u.log.update_index = 22,
     +		},
      	};
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_roundtrip
     +	check(!reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
     +	check(!reftable_record_equal(&in[1], &in[2], GIT_SHA1_RAWSZ));
     +	check_int(reftable_record_cmp(&in[1], &in[2]), >, 0);
    -+	/* comparison should be reversed for equal keys */
    ++	/* comparison should be reversed for equal keys, because
    ++	 * comparison is now performed on the basis of update indices */
     +	check_int(reftable_record_cmp(&in[0], &in[1]), <, 0);
     +
     +	in[1].u.log.update_index = in[0].u.log.update_index;
     +	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
     +	check(!reftable_record_cmp(&in[0], &in[1]));
    -+
    -+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
    -+		reftable_record_release(&in[i]);
      }

      static void test_reftable_log_record_roundtrip(void)
 3:  e435166a78 !  3:  db76851f4b t-reftable-record: add comparison tests for ref records
    @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
     +	struct reftable_record in[3] = {
     +		{
     +			.type = BLOCK_TYPE_REF,
    -+			.u.ref.refname = xstrdup("refs/heads/master"),
    ++			.u.ref.refname = (char *) "refs/heads/master",
     +			.u.ref.value_type = REFTABLE_REF_VAL1,
     +		},
     +		{
     +			.type = BLOCK_TYPE_REF,
    -+			.u.ref.refname = xstrdup("refs/heads/master"),
    ++			.u.ref.refname = (char *) "refs/heads/master",
     +			.u.ref.value_type = REFTABLE_REF_DELETION,
     +		},
     +		{
     +			.type = BLOCK_TYPE_REF,
    -+			.u.ref.refname = xstrdup("HEAD"),
    ++			.u.ref.refname = (char *) "HEAD",
     +			.u.ref.value_type = REFTABLE_REF_SYMREF,
    -+			.u.ref.value.symref = xstrdup("refs/heads/master"),
    ++			.u.ref.value.symref = (char *) "refs/heads/master",
     +		},
     +	};
     +
    @@ t/unit-tests/t-reftable-record.c: static void set_hash(uint8_t *h, int j)
     +	in[1].u.ref.value_type = in[0].u.ref.value_type;
     +	check(reftable_record_equal(&in[0], &in[1], GIT_SHA1_RAWSZ));
     +	check(!reftable_record_cmp(&in[0], &in[1]));
    -+
    -+	for (size_t i = 0; i < ARRAY_SIZE(in); i++)
    -+		reftable_record_release(&in[i]);
     +}
     +
      static void test_reftable_ref_record_roundtrip(void)
 4:  ad014db045 =  4:  78aff923c6 t-reftable-record: add comparison tests for index records
 5:  69c1f3891a =  5:  b0b3c98042 t-reftable-record: add comparison tests for obj records
 6:  dca1a016da <  -:  ---------- t-reftable-record: add ref tests for reftable_record_is_deletion()
 -:  ---------- >  6:  5e6b004216 t-reftable-record: add ref tests for reftable_record_is_deletion()
 7:  c7ffff71b0 !  7:  a68be88ccb t-reftable-record: add log tests for reftable_record_is_deletion()
    @@ Commit message
         reftable_record_is_deletion() is a function defined in
         reftable/record.{c, h} that determines whether a record is of
         type deletion or not. In the current testing setup, this function
    -    is left untested for all the four record types (ref, log, obj, index).
    +    is left untested for three of the four record types (log, obj, index).

         Add tests for this function in the case of log records.

 8:  f3e0c2aaf5 !  8:  02516add15 t-reftable-record: add obj tests for reftable_record_is_deletion()
    @@ Commit message
         reftable_record_is_deletion() is a function defined in
         reftable/record.{c, h} that determines whether a record is of
         type deletion or not. In the current testing setup, this function
    -    is left untested for all the four record types (ref, log, obj, index).
    +    is left untested for two of the four record types (obj, index).

         Add tests for this function in the case of obj records.
         Note that since obj records cannot be of type deletion, this function
 9:  8eeeb63982 !  9:  541f9811d3 t-reftable-record: add index tests for reftable_record_is_deletion()
    @@ Commit message
         reftable_record_is_deletion() is a function defined in
         reftable/record.{c, h} that determines whether a record is of
         type deletion or not. In the current testing setup, this function
    -    is left untested for all the four record types (ref, log, obj, index).
    +    is left untested for index records.

         Add tests for this function in the case of index records.
         Note that since index records cannot be of type deletion, this function
10:  979db146a0 ! 10:  c2aff283b1 t-reftable-record: add tests for reftable_ref_record_compare_name()
    @@ Commit message

      ## t/unit-tests/t-reftable-record.c ##
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_comparison(void)
    - 		reftable_record_release(&in[i]);
    + 	check(!reftable_record_cmp(&in[0], &in[1]));
      }

     +static void test_reftable_ref_record_compare_name(void)
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_ref_record_compariso
     +
     +	QSORT(recs, N, reftable_ref_record_compare_name);
     +
    -+	for (i = 1; i < N; i++)
    -+		check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
    ++	for (i = 1; i < N; i++) {
    ++		check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
    ++		check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
    ++	}
    ++
    ++	for (i = 0; i < N - 1; i++)
    ++		check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
     +
     +	for (i = 0; i < N; i++)
     +		reftable_ref_record_release(&recs[i]);
11:  fe044f186b ! 11:  7bdfca3744 t-reftable-record: add tests for reftable_log_record_compare_key()
    @@ Commit message

      ## t/unit-tests/t-reftable-record.c ##
     @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_comparison(void)
    - 		reftable_record_release(&in[i]);
    + 	check(!reftable_record_cmp(&in[0], &in[1]));
      }

     +static void test_reftable_log_record_compare_key(void)
    @@ t/unit-tests/t-reftable-record.c: static void test_reftable_log_record_compariso
     +
     +	QSORT(logs, N, reftable_log_record_compare_key);
     +
    -+	for (i = 1; i < N; i++)
    -+		check(reftable_log_record_compare_key(&logs[i - 1], &logs[i]) < 0);
    ++	for (i = 1; i < N / 2; i++)
    ++		check_int(strcmp(logs[i - 1].refname, logs[i].refname), <, 0);
    ++	for (i = N / 2 + 1; i < N; i++)
    ++		check_int(logs[i - 1].update_index, >, logs[i].update_index);
    ++
    ++	for (i = 0; i < N - 1; i++) {
    ++		check_int(reftable_log_record_compare_key(&logs[i], &logs[i]), ==, 0);
    ++		check_int(reftable_log_record_compare_key(&logs[i + 1], &logs[i]), >, 0);
    ++	}
     +
     +	for (i = 0; i < N; i++)
     +		reftable_log_record_release(&logs[i]);

