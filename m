Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276E653
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737524163; cv=none; b=Bpb2INXRpGefULY5hFqD8lZR+oV6ZkAHwzHX/tppsxjlvau2c4gTfyz8IQNtufAqKOZ85/5b3cNXq+v4hMc3i9cVBA3//wNZQ0NPT+Uonbpv7WMux3zV90Z+6B3++ODthz6vU55LC5PGgNPbOx0D6ZV8QsPUZnkhY5G6Jwp7B18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737524163; c=relaxed/simple;
	bh=8uLQBMM/DZCXp9mehH+oIn+yM8M+uhIhwGUoVw8jQVM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=CtxlcxLbiO+80MbssgwJ5OVLsK+ogOsGA7nzrMkmbva6opPAIuBjOtAp4xcmZrCrO1FL8/fGEcrQ5h0dnYy91X7rSbAIqToPa4ff5C/n3SfflivjW3GRvS87w5unJIf4VBiOCGfE5teO2Uazf1aMhLShbG39S/7k1XjR52cHCc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWKl0A7B; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWKl0A7B"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166360285dso124524995ad.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737524161; x=1738128961; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcBqTzsCT+A87JRO6u+CHE0r7XySgVfgKOa59MbeiO0=;
        b=mWKl0A7B9ATG3NRPACgvbn0qtI2RWhZ0y93sWmXK+lQE48+I3hBQoZkiBhMXlRTg5Q
         Ro2ZSj39mr+g2lHQuSH4lZvBZK1lv035KaaekSf68+AEqq0lY8vnuj2LSXsVYVgp4Zci
         o9lxDqOWYtBsplSqhqmOHsaFLCbbHB5NKskq874ewE5OrCqcti+tFUQ/9ma23yVKlju4
         YRHUlatX2MCv56p71iPvhJUjwnRAxbZQll1NTThFvyM2BwXZXCqpRJE4CM0p+xZhYkFn
         mxapLZp3SAoKnGyqAdJY5UUocurkXET8ZvMMBu7C2uUNMp3cFAQIm8nGBWxCaahqftCN
         FrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737524161; x=1738128961;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WcBqTzsCT+A87JRO6u+CHE0r7XySgVfgKOa59MbeiO0=;
        b=u/CLXpRFgC55LHbDStTSNc/7s44dk92tIQgPM24AXGRjpOxXYGNXrigJoEkT3pePzG
         cPH8DhEZOWKE5xtANrU2mX3FKZt9gBRagzIRZ8BcNQs90wIWXtnLy+//aIsdGt/LkxCD
         4H8/4RJLVOx/7B38kB4j3ARLO8R8z0KC2lzoEcIgyh4LxgtrH5yCxEyXSHFU6GEAjoyP
         pEitH8fuDifZGnugylitCrake9fiiJFwN0rB1Asez5hIQVON4Y2388h2rD/YZLmRikmu
         cQYbgZv5eM0qY57ovgEOWGHmbRZIS9ZShvZ1frAgdjDioVHDq2C12AphzP6ryKmFmB6Y
         gisA==
X-Gm-Message-State: AOJu0YwcR2Qlx8MRVMmNPEdhOyI0H/oTUpgsXOrQtQDKtED6ZDHAhHWG
	ZP2YTEa+E6ZW4Jg3V5b3fXoS7YHcOgHBlN9SXm0xkFVqVSmnk/y56nDL01uy
X-Gm-Gg: ASbGncuKK/5/EyEHVOfZHbm4qdUcj/IimsRDMvmwCyWcQalMcY8VRvvBHx+G2gvcu60
	WO/6xKdhbRjm4iedeW0YHybEI+gXbIQBSCxlSR7jUSqDRaUapMRxVOyb4F8HVdK0JJStGdK+F7W
	dcn94JIAbyCrGJhc1HxWaBbzFAax77YtkI3RIz1O7pLtHjTid7JiSci1NKq5u39YwAT4vGx0+41
	pnbqx0kxqa4iRp8B9tAonLK0GY23koQfjNj0/kCWAaLOeer44V37SyCUbmc5cn7dJ9pjNan
X-Google-Smtp-Source: AGHT+IGvQjh99ApU315N//PL4R8GOulxSuA/hbIbjgKwJmGX2I03ymuCcMPhArKA/uvPtkph192JyQ==
X-Received: by 2002:a05:6a00:4fcb:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72daf97b5d3mr30562714b3a.14.1737524160846;
        Tue, 21 Jan 2025 21:36:00 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72db4e718efsm9369207b3a.152.2025.01.21.21.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:36:00 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/3] refs: small followups to the migration corruption
 fix
Date: Wed, 22 Jan 2025 06:35:46 +0100
Message-Id: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALODkGcC/43NTQ6CMBCG4auQrh3TH6DRlfcwLkqZQpNiSQtVQ
 7i7hRU7Xb6TyfMtJGKwGMm1WEjAZKP1zxziVBDdq2eHYNvchFNeUcYklDUD7UOYxwlbCGgm1Tg
 E453zr3kEbCiWpmVKckGyMuYX+94X7o/cvY2TD599MLHt+r+dGFCQFLGmlUJh8NYNyrqz9gPZ7
 MQPHme/PZ49IZHXWip5acqjt67rF0Rkp0oeAQAA
X-Change-ID: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723
In-Reply-To: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7958; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8uLQBMM/DZCXp9mehH+oIn+yM8M+uhIhwGUoVw8jQVM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeQg722zxviiXB0DhoiPw9q7lcsSXJv/q7hE
 NKtSMFpiltTxIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnkIO9AAoJED7VnySO
 Rox/Y6EL/35phWvM57xsJnj94OlF7pQvUHg9MgfczoyWozmByzT2W2lbprpL0Ic4p3WnSLOohQ9
 0nzYV5Y+iJowmFSwiHGUYdADhZMG8cipkA8Vs4Z9C1A1k94epOCiju7O1HhiQcBiAg8WOFNBu77
 5ul+N0Q9X66oaN95AHV7t75xHo3GELvRM8hXuxz/7vSJj3TYFnPq+mucBUSLf1Ymm5oE1QrPCfU
 wdvLMZgKaBJLPpQ98ZJz2J7GEFFaKKQK7MPIVObGA+0OY7iwzGqc7ZAuRlaNNYLz7E5WWNfcSNd
 X+/QUHQHEFq68vIY7aIl/Rxakl7DykXwvlotiqRQCY8BOIHo4KQhC9sQ+i8L4yTz8b0cUExs9tJ
 NAGq1hayE/nOXJRujyqWgt44/5G6zAdAkRUVPoDcg3EbTrIhveGzUVeXyhAbZRYfRTIHNsGoRQf
 a7s4Xm27rE3ogUx2L9NmWTpSNKj3k6e+Zde2lmc1IZnuoWOcImYkesEz6dr8I5GKtY6L7kCxkJ6
 H0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This is a follow up to the bug that was reported [1] around `git refs
migrate --ref-format=reftable` where the migration would fail for
repositories with reflogs with lots of entries. This was caused due to a
mismatch in the reftable's header and footer, specifically WRT the
'max_update_index'.

While there was a fix posted. This series is a small followup to fix
some of the topics discussed there:
1. To mark `ref_transaction_update_reflog()` as static since it is only
used internally within 'refs.c'.
2. To change the type of 'max_index' from 'unsigned int' to 'uint64_t'.
This would be much safer for large repositories with millions of files
and on 32bit systems.
3. To add a safeguard to prevent 'update_index' changes post any record
addition. This is a preventive measure to ensure such bugs don't arise
in the future.

This is based on top of master 757161efcc (Sync with Git 2.48.1,
2025-01-13) with 'kn/reflog-migration-fix' merged in.

[1]: https://lore.kernel.org/r/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v3:
- Commit 3: Modify the commit message to make it clearer that this is a
  preventive measure. Modify the condition to check for both `last_key`
  and `next`. Also add a unit test.
- Link to v2: https://lore.kernel.org/r/20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com

Changes in v2:
- Commit 1: Keep the function comments.
- Commit 3: Modify the requirement to be for any record writes instead
of the first block write. This ensures that the limits need to be set 
before any records being added. Instead of using `BUG()`, return 
`REFTABLE_API_ERROR`. Handle all callers as needed.
- Link to v1: https://lore.kernel.org/r/20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com

---
Karthik Nayak (3):
      refs: mark `ref_transaction_update_reflog()` as static
      refs: use 'uint64_t' for 'ref_update.index'
      reftable: prevent 'update_index' changes after adding records

 refs.c                          | 24 ++++++++++++------
 refs.h                          | 14 -----------
 refs/refs-internal.h            |  4 +--
 refs/reftable-backend.c         | 22 ++++++++++++-----
 reftable/reftable-error.h       |  1 +
 reftable/reftable-writer.h      | 24 ++++++++++--------
 reftable/stack.c                |  6 +++--
 reftable/writer.c               | 15 +++++++++++-
 t/unit-tests/t-reftable-stack.c | 54 ++++++++++++++++++++++++++++++++++++++---
 9 files changed, 118 insertions(+), 46 deletions(-)
---

Range-diff versus v2:

1:  76e6da564a = 1:  cafede9b10 refs: mark `ref_transaction_update_reflog()` as static
2:  f8e2e81eb4 = 2:  737360d883 refs: use 'uint64_t' for 'ref_update.index'
3:  ca92e29ecc ! 3:  01bf1d765f reftable: prevent 'update_index' changes after adding records
    @@ Commit message
         and footer values. The footer would contain the newer values while the
         header retained the original ones.
     
    -    To fix this bug, prevent callers from updating these values after any
    -    record is written. To do this, modify the function to return an error
    -    whenever the limits are modified after any record adds. Check for record
    -    adds within `reftable_writer_set_limits()` by checking the `last_key`
    -    variable, which is set whenever a new record is added.
    +    To protect against this bug, prevent callers from updating these values
    +    after any record is written. To do this, modify the function to return
    +    an error whenever the limits are modified after any record adds. Check
    +    for record adds within `reftable_writer_set_limits()` by checking the
    +    `last_key` and `next` variable. The former is updated after each record
    +    added, but is reset at certain points. The latter is set after writing
    +    the first block.
     
         Modify all callers of the function to anticipate a return type and
    -    handle it accordingly.
    +    handle it accordingly. Add a unit test to also ensure the function
    +    returns the error as expected.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ reftable/writer.c: int reftable_writer_new(struct reftable_writer **out,
      }
      
     -void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
    --				uint64_t max)
     +int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
    -+			       uint64_t max)
    + 				uint64_t max)
      {
     +	/*
    -+	 * The limits should be set before any records are added to the writer.
    -+	 * Check if any records were added by checking if `last_key` was set.
    ++	  * Set the min/max update index limits for the reftable writer.
    ++	  * This must be called before adding any records, since:
    ++	  * - The 'next' field gets set after writing the first block.
    ++	  * - The 'last_key' field updates with each new record (but resets
    ++	  *   after sections).
    ++	  * Returns REFTABLE_API_ERROR if called after writing has begun.
     +	 */
    -+	if (w->last_key.len)
    ++	if (w->next || w->last_key.len)
     +		return REFTABLE_API_ERROR;
     +
      	w->min_update_index = min;
    @@ t/unit-tests/t-reftable-stack.c: static void t_reflog_expire(void)
      	return 0;
      }
      
    +@@ t/unit-tests/t-reftable-stack.c: static void t_reftable_stack_reload_with_missing_table(void)
    + 	clear_dir(dir);
    + }
    + 
    ++static int write_limits_after_ref(struct reftable_writer *wr, void *arg)
    ++{
    ++	struct reftable_ref_record *ref = arg;
    ++	check(!reftable_writer_set_limits(wr, ref->update_index, ref->update_index));
    ++	check(!reftable_writer_add_ref(wr, ref));
    ++	return reftable_writer_set_limits(wr, ref->update_index, ref->update_index);
    ++}
    ++
    ++static void t_reftable_invalid_limit_updates(void)
    ++{
    ++	struct reftable_ref_record ref = {
    ++		.refname = (char *) "HEAD",
    ++		.update_index = 1,
    ++		.value_type = REFTABLE_REF_SYMREF,
    ++		.value.symref = (char *) "master",
    ++	};
    ++	struct reftable_write_options opts = {
    ++		.default_permissions = 0660,
    ++	};
    ++	struct reftable_addition *add = NULL;
    ++	char *dir = get_tmp_dir(__LINE__);
    ++	struct reftable_stack *st = NULL;
    ++	int err;
    ++
    ++	err = reftable_new_stack(&st, dir, &opts);
    ++	check(!err);
    ++
    ++	reftable_addition_destroy(add);
    ++
    ++	err = reftable_stack_new_addition(&add, st, 0);
    ++	check(!err);
    ++
    ++	/*
    ++	 * write_limits_after_ref also updates the update indexes after adding
    ++	 * the record. This should cause an err to be returned, since the limits
    ++	 * must be set at the start.
    ++	 */
    ++	err = reftable_addition_add(add, write_limits_after_ref, &ref);
    ++	check_int(err, ==, REFTABLE_API_ERROR);
    ++
    ++	reftable_addition_destroy(add);
    ++	reftable_stack_destroy(st);
    ++	clear_dir(dir);
    ++}
    ++
    + int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
    + {
    + 	TEST(t_empty_add(), "empty addition to stack");
    + 	TEST(t_read_file(), "read_lines works");
    + 	TEST(t_reflog_expire(), "expire reflog entries");
    ++	TEST(t_reftable_invalid_limit_updates(), "prevent limit updates after adding records");
    + 	TEST(t_reftable_stack_add(), "add multiple refs and logs to stack");
    + 	TEST(t_reftable_stack_add_one(), "add a single ref record to stack");
    + 	TEST(t_reftable_stack_add_performs_auto_compaction(), "addition to stack triggers auto-compaction");


---

base-commit: a5aa44e7930761cb900813d971b4105f901818fb
change-id: 20250117-461-corrupted-reftable-followup-eb0e4fd1a723

Thanks
- Karthik

