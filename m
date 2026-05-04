Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617631862
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916656; cv=none; b=aW8sK5NAYhL1F5j/yDb7hYbv/vBTiSyMF7zE13TDh94fNl3s7CLaC06QdiCeC5SHzx2MKnth5WcUjauwVMbtQEoiO+7uH378CDnkA9/Gp+J+8qlYiAg8MEmuGHZeZZb8gHQRyxeqiZZ/oV36A5vfWV5hzu072todh8qZ45LPpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916656; c=relaxed/simple;
	bh=skJ/Ko9ClU4cAg8fxwNUYyuKe+vasy5NIUD87QJdg+M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=LmHR68qeD7yl9vCoWq0zpfZWpipZfnFqrlOcgzlMiA6zah3qP5w/E/RAXN5LNKEF/qZZXZGbJcVpuY7pxnfk16uwbNofG+9lacVKfYHUFU03j8EmdmShc8GRDalwNQEjC2dEHXD1fPHavedu4hZ9VcCSU538LWxVECBuS1K9df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwRk+CBG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwRk+CBG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d102471a4so9933135e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916653; x=1778521453; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MNkXMI4HT0v3zvYnvKVUThR2ZIky13aunTrLDAWiSQ=;
        b=rwRk+CBGQEa45bIqiMgtmFjetP9uVFibhcT54hcJP/x7IOWeRkocv92v9uDBZKVQU9
         z3bUIsl4vHTMZwvCCN419AUmtDLeSs1ym5U3yF6E2NJrFYmMQ5ky7xsLY6gY5/tTnEpM
         VQhnCbQc8v5YQoyBH7NdEZtkUOgbzCQot3JoBxMmtgpPNOO6e76+E3W3w/fsRZ5GJV3P
         /ctaocWroAx3tyzxYI+0y1jlzXlmn/8DaYluwenUUrOyK8EohEubeY3YsLm/fJ4OL/W7
         KJMiuuX3Zf1B93oSw8mkbznUhPu4K86P9FL6cMqaFJZhtSXupNQHg9baQ6R+8kcVLHrm
         XxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916653; x=1778521453;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MNkXMI4HT0v3zvYnvKVUThR2ZIky13aunTrLDAWiSQ=;
        b=EJQpOJRsblTR1b4bz0YlBhjLxrMlSlyws5vr2EPkP5HR+rvVej4KmXCT/gzcqWzWnu
         qHB1Y/E3JUQozFPxWb+nbqvJXKDT1tf3zT1UMC8JVpaA4rmIBbsQwcTpbWk/avcFi6Y4
         a+UEqps2JH7dsQ/uJFwET7rn/uLXUSGz5l3HiLJHrNWtadsTxoEZ7Ri5Twjrf7I9tUQr
         R/uVC3T54kwOgAxQq+YOrJ9ib94Y0GzJJZg2N3zl/npvn05zLjf65K36XqGKhm/dkTZG
         eeEiLN+9BVygaUevMDYmhuJv7SPUvxaG2gmV6giR0icGMmo38iMtSuPOyseAMBnBd7+L
         RMCQ==
X-Gm-Message-State: AOJu0Yyv19NtisAXLkkk1N9Svk/xG5PfAYI/AubR4PlFSfEVSm04wHIA
	N5Pl+doynz+T8wo19hNiwLTJF4XPA3HNn6c7rIYfgUhCCUiX+MO2zll/
X-Gm-Gg: AeBDiesnYnOmsAczvrl/1kKcQLKiG5HrY6HQ89h6Qs/DzSqsY3J06/8qjxy37+mAY2j
	F4BfbD/Sa4wkcM35aad2fFejoFvVDhUKmrZAMKHA8tUQsiHmy7bMjpHO2yMbaPeE4dpx/1SG7YQ
	XZLAwidOwxih7LO+X0ue6QS+19Lyvw6z4YbqUgqB2daF3mrBNkMcRnRDdG7n8x4IA3ah/TXL1Ek
	IjOWadbFw5QG6goj7UmmgERnmt2ofQV8/80uDgMUqqIigPUdLInQzB2tfB7Vntu3Qm+vU4fFbMr
	wqOUSKBLlZIzF+LrEQIROMHNCB1q1OObjEfs/xtj1yNjOUu8SMrOU6GkI76vsKvhS5l1Dsjftb7
	mR8rdLcEQD5UmaWd0BizbbTAmrIOps0fArDU8d+Bqwg5WVTVv6tpITrsoG2Cso0rJJd1hZ/eiil
	x1q8bdIy/l8KOTNWAiTm0/KdAT/Y7DlimR0qSEpZod
X-Received: by 2002:a05:600c:528e:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-48a988b8396mr194186055e9.24.1777916652459;
        Mon, 04 May 2026 10:44:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/9] refs: move some of the generic logic out of the
 backends
Date: Mon, 04 May 2026 19:44:04 +0200
Message-Id: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTa+GkC/33PPa7CMBAE4Ksg1yyK/wMV90AUjrMOfiIxsoMFQ
 rk7DlBEr0g50uw32hdJGD0mcti8SMTskw9DCWK7IfZihg7BtyUTVjFVCaohokvQh4wwBuhwKOc
 WruaJEZyWTFqJtVaCFOBWuv7xwU/nb0735g/tOItz4+LTGOLzs57p3PsNsWptKFOoQFKOXArHt
 WqOXW/8dWdDT+ahzJYUX6VYoQxKIxwVqtXtf4ovqdX3My8UCsXr1jW63uslNU3TG2mUHn5sAQA
 A
X-Change-ID: 20260417-refs-move-to-generic-layer-f7525c5e8764
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12179;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=skJ/Ko9ClU4cAg8fxwNUYyuKe+vasy5NIUD87QJdg+M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42uipKtPC+e+jEKjaXC3am5jB8274OgZNe
 +askdNhGtiH0IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NroAAoJED7VnySO
 Rox/ADML/0Hz5E8UvS8OXv8OUDL4CGoS5cuPwvKKLmWmFxdSCWp2x1HIUEEOG7Nq2GVbjYONwkg
 b0k7qPw47jmn8zTU+8xCRMVzWzaLWr/EH3alz4y87SxWXUq5gwANKF7uy2z2wVRwGEdSUJ5WoEq
 0ZMoLg6C19T4j2Z1nbp23eXaxrD7j1AJfTF05GQMMhk3HqtHj1DoXgDo/xM/gxIYpSDU3Yru6P0
 b5XMhnxEUYUOfq5hWNr87bg8Evhg+HFhD10CvbprYsgTYOcs6O565utKPWYOYBZcNA05a0V4Aa8
 eKre1uQq5sSb8u2BribPRhU95fUsaK36fNLfbhOfyk4QDMrUcN7AviY/R7l4cJ1aX5bv/wJZCnB
 7L/c+U7vndB+9jxlPawyzeMIffEZq1FSotQqqWsIcKi/1HZt4twG12kzTRBwUt7kaSvXuaxMyeN
 v2PCnsfXhJe1U3TgRlveOrg6l8wIbqgnQsJGu5T90fIzqSRuz5TGaevWtuc3XKhZN101XRgWUx7
 js=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series came together while I was working on other reference related
code and realized that some of the individual logic implemented with the
reference backends can be moved to the generic layer.

Moving code to the generic layer, simplifies the responsibility of
individual backends and avoids deviation in logic between the backends.

The biggest changes are related to moving out usage of `parse_object()`
and `peel_object()` from reference transactions. The former is used to
validate that the OID provided points to a commit object. The latter is
an optimization technique where the packed/reftable backend store the
peeled OID whenever available, so reading such references provides the
peeled OID without having to call the ODB.

Moving object parsing to the generic layout involves moving it out of
the prepare stage of the transaction and into `ref_transaction_update()`
where every added update is checked. As such, this also involves
modifying update-ref(1) and receive-pack(1) to follow this paradigm.

---
Changes in v4:
- Fix a bug in the error handling code, move it to a function and also
  add missing call sites. Add tests to ensure we catch this.
- Link to v3: https://patch.msgid.link/20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com

Changes in v3:
- Remove an unwanted change which creeped up during a rebase.
- Add information in the commit message around how the order of errors
  in git-update-ref(1) will change while maintaining functionality.
- Change up the order of an `if..else` to make it clearer.
- Other small typos and fixes.
- Link to v2: https://patch.msgid.link/20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com

Changes in v2:
- Split the second commit into two: one introducing
  `ref_store_init_options` and the second to use it for reflog config.
- Use opts as the variable name consistently.
- A bunch of grammar fixes.
- Link to v1: https://patch.msgid.link/20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com

---
 builtin/receive-pack.c  |  22 +++---
 builtin/update-ref.c    | 182 +++++++++++++++++++++++++++++++-----------------
 refs.c                  |  60 ++++++++++++----
 refs.h                  |  16 ++---
 refs/files-backend.c    |  58 ++++++---------
 refs/packed-backend.c   |  10 ++-
 refs/packed-backend.h   |   3 +-
 refs/refs-internal.h    |  35 ++++++++--
 refs/reftable-backend.c |  40 +++--------
 t/t1400-update-ref.sh   |  14 ++++
 10 files changed, 266 insertions(+), 174 deletions(-)

Karthik Nayak (9):
      refs: remove unused typedef 'ref_transaction_commit_fn'
      refs: introduce `ref_store_init_options`
      refs: extract out reflog config to generic layer
      refs: return `ref_transaction_error` from `ref_transaction_update()`
      update-ref: move `print_rejected_refs()` up
      update-ref: handle rejections while adding updates
      refs: move object parsing to the generic layer
      refs: add peeled object ID to the `ref_update` struct
      refs: use peeled tag values in reference backends

Range-diff versus v3:

 1:  b89e273583 =  1:  cf5fa53f34 refs: remove unused typedef 'ref_transaction_commit_fn'
 2:  8f7f8dadc8 =  2:  afd10fd7a3 refs: introduce `ref_store_init_options`
 3:  9cdc35f5b6 =  3:  4eb6950cdc refs: extract out reflog config to generic layer
 4:  36c0c86a31 =  4:  dd8177a243 refs: return `ref_transaction_error` from `ref_transaction_update()`
 5:  1b7eca9353 =  5:  eb86178ae5 update-ref: move `print_rejected_refs()` up
 6:  aef1529054 !  6:  464c6371a4 update-ref: handle rejections while adding updates
    @@ builtin/update-ref.c: static unsigned int default_flags;
      /*
       * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
       * and append the result to arg.  Return a pointer to the terminator.
    +@@ builtin/update-ref.c: static void print_rejected_refs(const char *refname,
    + 	strbuf_release(&sb);
    + }
    + 
    ++/*
    ++ * Handle transaction errors. If we're using batches updates, we want to only
    ++ * die for generic errors and print the remaining to the user.
    ++ */
    ++static void handle_ref_transaction_error(const char *refname,
    ++					 struct object_id *new_oid,
    ++					 struct object_id *old_oid,
    ++					 const char *new_target,
    ++					 const char *old_target,
    ++					 enum ref_transaction_error tx_err,
    ++					 struct strbuf *err,
    ++					 struct command_options *opts)
    ++{
    ++	if (!tx_err)
    ++		return;
    ++
    ++	if (tx_err != REF_TRANSACTION_ERROR_GENERIC && opts->allow_update_failures) {
    ++		print_rejected_refs(refname, old_oid, new_oid, old_target,
    ++				    new_target, tx_err, err->buf, NULL);
    ++		return;
    ++	}
    ++
    ++	die("%s", err->buf);
    ++}
    ++
    + /*
    +  * The following five parse_cmd_*() functions parse the corresponding
    +  * command.  In each case, next points at the character following the
     @@ builtin/update-ref.c: static void print_rejected_refs(const char *refname,
       */
      
    @@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *trans
     -				   NULL, NULL,
     -				   update_flags | create_reflog_flag,
     -				   msg, &err))
    +-		die("%s", err.buf);
     +	tx_err = ref_transaction_update(transaction, refname,
     +					&new_oid, have_old ? &old_oid : NULL,
     +					NULL, NULL,
     +					update_flags | create_reflog_flag,
     +					msg, &err);
    ++	handle_ref_transaction_error(refname, &new_oid, have_old ? &old_oid : NULL,
    ++				     NULL, NULL, tx_err, &err, opts);
     +
    -+	/*
    -+	 * Generic errors are non-recoverable, so we cannot skip the update
    -+	 * or mark it as rejected.
    -+	 */
    -+	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
    - 		die("%s", err.buf);
      
    -+	if (tx_err && opts->allow_update_failures)
    -+		print_rejected_refs(refname, have_old ? &old_oid : NULL,
    -+				    &new_oid, NULL, NULL, tx_err, err.buf,
    -+				    NULL);
    -+
      	update_flags = default_flags;
      	free(refname);
    - 	strbuf_release(&err);
    +@@ builtin/update-ref.c: static void parse_cmd_update(struct ref_transaction *transaction,
      }
      
      static void parse_cmd_symref_update(struct ref_transaction *transaction,
    @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction
     -				   have_old_oid ? NULL : old_target,
     -				   update_flags | create_reflog_flag,
     -				   msg, &err))
    +-		die("%s", err.buf);
     +	tx_err = ref_transaction_update(transaction, refname, NULL,
     +					have_old_oid ? &old_oid : NULL,
     +					new_target,
     +					have_old_oid ? NULL : old_target,
     +					update_flags | create_reflog_flag,
     +					msg, &err);
    -+
    -+	/*
    -+	 * Generic errors are non-recoverable, so we cannot skip the update
    -+	 * or mark it as rejected.
    -+	 */
    -+	if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
    - 		die("%s", err.buf);
    ++	handle_ref_transaction_error(refname, NULL, have_old_oid ? &old_oid : NULL,
    ++				     new_target, have_old_oid ? NULL : old_target,
    ++				     tx_err, &err, opts);
      
    -+	if (tx_err && opts->allow_update_failures)
    -+		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
    -+				    NULL, have_old_oid ? NULL : old_target,
    -+				    new_target, tx_err, err.buf, NULL);
    -+
      	update_flags = default_flags;
      	free(refname);
    - 	free(old_arg);
     @@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction *transaction,
      }
      
      static void parse_cmd_create(struct ref_transaction *transaction,
     -			     const char *next, const char *end)
     +			     const char *next, const char *end,
    -+			     struct command_options *opts UNUSED)
    ++			     struct command_options *opts)
      {
      	struct strbuf err = STRBUF_INIT;
      	char *refname;
    + 	struct object_id new_oid;
    ++	enum ref_transaction_error tx_err;
    + 
    + 	refname = parse_refname(&next);
    + 	if (!refname)
     @@ builtin/update-ref.c: static void parse_cmd_create(struct ref_transaction *transaction,
    + 	if (*next != line_termination)
    + 		die("create %s: extra input: %s", refname, next);
    + 
    +-	if (ref_transaction_create(transaction, refname, &new_oid, NULL,
    +-				   update_flags | create_reflog_flag,
    +-				   msg, &err))
    +-		die("%s", err.buf);
    ++	tx_err = ref_transaction_create(transaction, refname, &new_oid, NULL,
    ++					update_flags | create_reflog_flag,
    ++					msg, &err);
    ++	handle_ref_transaction_error(refname, &new_oid, NULL, NULL, NULL, tx_err,
    ++				     &err, opts);
    + 
    + 	update_flags = default_flags;
    + 	free(refname);
      	strbuf_release(&err);
      }
      
    @@ builtin/update-ref.c: static void parse_cmd_create(struct ref_transaction *trans
      static void parse_cmd_symref_create(struct ref_transaction *transaction,
     -				    const char *next, const char *end UNUSED)
     +				    const char *next, const char *end UNUSED,
    -+				    struct command_options *opts UNUSED)
    ++				    struct command_options *opts)
      {
      	struct strbuf err = STRBUF_INIT;
      	char *refname, *new_target;
    ++	enum ref_transaction_error tx_err;
    + 
    + 	refname = parse_refname(&next);
    + 	if (!refname)
    +@@ builtin/update-ref.c: static void parse_cmd_symref_create(struct ref_transaction *transaction,
    + 	if (*next != line_termination)
    + 		die("symref-create %s: extra input: %s", refname, next);
    + 
    +-	if (ref_transaction_create(transaction, refname, NULL, new_target,
    +-				   update_flags | create_reflog_flag,
    +-				   msg, &err))
    +-		die("%s", err.buf);
    ++	tx_err = ref_transaction_create(transaction, refname, NULL, new_target,
    ++					update_flags | create_reflog_flag,
    ++					msg, &err);
    ++	handle_ref_transaction_error(refname, NULL, NULL, new_target, NULL,
    ++				     tx_err, &err, opts);
    + 
    + 	update_flags = default_flags;
    + 	free(refname);
     @@ builtin/update-ref.c: static void parse_cmd_symref_create(struct ref_transaction *transaction,
      }
      
 7:  4b225f4f4d !  7:  f971226d89 refs: move object parsing to the generic layer
    @@ refs/reftable-backend.c: static enum ref_transaction_error prepare_single_update
      	/*
      	 * When we update the reference that HEAD points to we enqueue
      	 * a second log-only update for HEAD so that its reflog is
    +
    + ## t/t1400-update-ref.sh ##
    +@@ t/t1400-update-ref.sh: test_expect_success 'stdin -z create ref fails with empty new value' '
    + 	test_must_fail git rev-parse --verify -q $c
    + '
    + 
    ++test_expect_success 'stdin -z create ref fails with non commit object' '
    ++	printf $F "create $c" "$(test_oid 001)" >stdin &&
    ++	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    ++	grep "fatal: trying to write ref ${SQ}$c${SQ} with nonexistent object" err &&
    ++	test_must_fail git rev-parse --verify -q $c
    ++'
    ++
    ++test_expect_success 'stdin -z update ref fails with non commit object' '
    ++	printf $F "update $b" "$(test_oid 001)" "" >stdin &&
    ++	test_must_fail git update-ref -z --stdin <stdin 2>err &&
    ++	grep "fatal: trying to write ref ${SQ}$b${SQ} with nonexistent object" err &&
    ++	test_must_fail git rev-parse --verify -q $c
    ++'
    ++
    + test_expect_success 'stdin -z update ref works with right old value' '
    + 	printf $F "update $b" "$m~1" "$m" >stdin &&
    + 	git update-ref -z --stdin <stdin &&
 8:  944af6a454 =  8:  d271167077 refs: add peeled object ID to the `ref_update` struct
 9:  47653fdde9 =  9:  ed88b9e2ce refs: use peeled tag values in reference backends


base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
change-id: 20260417-refs-move-to-generic-layer-f7525c5e8764

Thanks
- Karthik

