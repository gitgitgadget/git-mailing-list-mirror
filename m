Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD943921F1
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145607; cv=none; b=iXkrfRY9dPa5g7xAEsQZa7CPPJcxsPmoJI9vn8RiRJ22x4903rDxpudBglEdVVfRSMH6MpXu7nbSS/2VDut75gTUjs4mqIsCUZKGpccfrvs89ZyYyg3GqqMZF68CPMiW4lAdafNapdZH6crzodGVPEqlrI3HcGXXXdmGs4iKFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145607; c=relaxed/simple;
	bh=RsMdMmqtlo7WukQ6M999b3R9beHcmAC7mXpAm3yAWlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRrm2BUKVKAiZmmiZbq4SwgmFzK7RgMVrBPjhCRQ5gxv8SfrtYJzzDYA6tIXFk934IXF2mbH76R86F6Ryl9SCqq/1uZ8eYT0syJPai9NKNpiLA0z013S8JX1ULp5eQ7Z3DMqsTUXhK7zD7c4XnnIOpe8CV5gjCqATywWEDZxqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAAwG7mJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAAwG7mJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso6902125e9.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145603; x=1787750403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjngwiNSmaMrcAbYDBR0zVTsOc/G9S0O1rSyTUZSmYw=;
        b=DAAwG7mJN/2Mg1OPguz0nvXaC9VKAPWapU+Hxlg9eJoVIPpBP43lNZVXfhnpWpbzIT
         o/LKqpdn97V29s5LdJvD9AfbGnhXTSsiHkS/mBELmieUQ7KmiMYIckGzZDskYIug4TXu
         y0b10BlX9GZdn4EsYAYbQRejnG7scWb+s+cpS9AY/a9HagIVoZPj2dhZyrBFR6Pp6Dua
         IDfjX2n0tKTVSwUq+XTTR33zru3mFewYIBxg7G4NukwVzEyNwFTuDNcQl9B2tGhQhm5K
         KUjH6soXkIuRn9Ty6QLHzPJ3wh+WV6N3v/Vjwo234dqutvN8G5NhSE4AcIAtK9JJ/Mw5
         CLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145603; x=1787750403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wjngwiNSmaMrcAbYDBR0zVTsOc/G9S0O1rSyTUZSmYw=;
        b=Blt5XkFY61srQxk0QsYtW7klmIysga7+h0k/Z+K69jyNVbj9/VonJbOCEUlrvgkm+w
         4soW/tIvdnxOy5yY6YPvoeCzuI1UTCvepwX6/+GSRR0iKvpVwmVxY72KjsrGaOnZllwS
         353WuZ+SXvFoktErYk38Af3cWYfWKv+vE8xgrV7zlVVJDbbCfDCpJDjO4O7he3p2ZWoV
         YzgjPAaRiaGIGsEsKPhjJIuBeJ88jSfSkUbVtfvkfUHdvBzB9eshVeywET7aNSe2blM9
         IQuJKVEgOiGWw99s3dYqZMkjtlTuL5EUehKO8dVym7fgLRD8a8CibCf/nsJkDXqGvyJr
         yWxw==
X-Gm-Message-State: AOJu0Yxt32ith2Deyaj+j9RgbN6vXPia7iqdh0eusHRvJ9JpKeAxfM/a
	B5ShM4TwUvLkRW2Y7IRYsH0dXLof+yvozcFGeehtalX7Qa3nXDP+ZY4jlepivuSl
X-Gm-Gg: AR+sD10He9oX//9rkOSFAdh7TB0Z5ocICWfnvJN/Bnra5H43XVYiXqX71A1F2jEmJSt
	qNkaG7gH/sVa6x4LTGoxTR1390iEFkJVJ2lS0YVvjHYpugnUTRyNGx/5NXXcLqvzQevwIEJA7Zb
	YYpcu7LcXPBq7CBBoaVfVqBbKar72K2yXKaVRcuHPh721Ds5Tq2wfI9gP0TdMSrOjcpd3iAZOYj
	bPMzkgcmht5Um6D5fKtdPKIkKWIvQBwdr8a4lhdhYoFKnm8TMIK3sqJoEyRfXYpqjkUsl/jlRG7
	kXqziUckAqWz13oKNbhNLnxOHqUJ+/tgqD252Zl1F2pqfpagNjBFObwnEBwKn8soox+uHQHB9K7
	jFlarRJ8oBjblVrTPnk2FEumTFZnimz1z3ATx6dvF7JXs38vJ04dLp4lsG5/Ol9KK9SH9PyGJ5f
	GRelPOyF+DkSsG2lt/VoQmPDEYuEQwRmxIdMKISu6HztnLqyF7hrYh4aNg6lOYcK128u3puAD+V
	EmAr8s7qx0h2lQVKhHdyU0yHH4=
X-Received: by 2002:a05:600c:3f12:b0:499:7a4f:d13d with SMTP id 5b1f17b1804b1-499aa199777mr86888265e9.4.1787145603300;
        Wed, 19 Aug 2026 06:20:03 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:15a6:881d:7fd4:eabb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9ddee1esm37578955e9.2.2026.08.19.06.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:20:02 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 19 Aug 2026 15:19:37 +0200
Subject: [PATCH 1/3] reftable/stack: remove
 `REFTABLE_STACK_NEW_ADDITION_RELOAD`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-740-optimize-reloading-the-reftable-stack-v1-1-6bf5305d4e43@gmail.com>
References: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
In-Reply-To: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19558;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=RsMdMmqtlo7WukQ6M999b3R9beHcmAC7mXpAm3yAWlc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqFrYDD+zDbub7Z/kvlDsXZVTCo+3UbgHS94
 yx48OsCX9PdMIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqha2AAAoJED7VnySO
 Rox/aYwL/izuwTWo3yKGstA4Tjq80WE1FT9Wvft3BBftPODOJwpwGFJeC6s66q1RshI/bCOfxHR
 oWdXyiKfrsnauemwGHLTaocX+reOdu0yZ4iFNLDDgcW428QjWLj5DePDizJNNMDArJEMj7OkddO
 Xv/DRgqcMrDdLNKJm1xQb1zSY71SzF2d99r+Dy0YqMjRZZbzp7JD9kpweuGVd45bq7lg4u8nTmT
 bdD7caTkONuZKnN1dVXJfVPX8MXmqoiAL0fuIzMZf559kbcwnVnz9MJ392elghyyuTbVikjPZ+e
 k4SbxywaPwxZyJJcswGcRIR3MXXgGXcukBKJTXzgDwtLWgr63CXE+eWziarHt92tUToTufl8Anv
 TaTdLPb6d8qVK5SsJd+TBg21fxH+m8Hpv/sT3Dt419JFzVjISVS7DHw6aGnnmLNmZY8925BPRDT
 IplVCedF6MgcWZdTKmhCpOVWcAPqfjdl6QR6UouxwnhBmnQ3dMjRf/aDe694QP0vSwiEi2HtRf7
 Rc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 80e7342ea8 (reftable/stack: allow locking of outdated stacks,
2024-09-24), the `REFTABLE_STACK_NEW_ADDITION_RELOAD` was introduced so
that callers of `reftable_stack_init_addition()` can also reload the
stack if there was a concurrent update made before the lock was
obtained.

Then 16684b6fae (refs/reftable: always reload stacks when creating
lock, 2025-08-12) updated all of the remaining call-sites to propagate
this flag to ensure that we always reload the stack whenever there was a
concurrent update.

As all calls to `reftable_stack_init_addition()` inevitably propagate
the flag, it is safe to remove the flag and its associated code and make
the reloading of the stack the default flow. This makes it easier to
follow the flow and simplifies the logic.

The only exceptions are:

  1. Unit tests, where we explicitly do not propagate the flag. These
     tests are now modified with the new status quo.

  2. `reftable_stack_clean_locked()`, which was propagating 0 to
     `reftable_stack_new_addition()` but was then manually reloading the
     stack after. Here the new flow will achieve the same, while also
     allowing us to remove the manual reload.

This also makes two checks for 'REFTABLE_OUTDATED_ERROR' redundant, so
remove them also.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c         | 18 ++++-------
 reftable/reftable-stack.h       | 17 ++--------
 reftable/stack.c                | 37 ++++++----------------
 t/unit-tests/u-reftable-stack.c | 69 ++++++++++++++++++-----------------------
 4 files changed, 49 insertions(+), 92 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 028f0211af..5c87fd2d68 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1003,8 +1003,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		struct reftable_addition *addition;
 
 		ret = reftable_stack_new_addition(&addition, be->stack,
-						  &reftable_be_write_options(refs)->opts,
-						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
+						  &reftable_be_write_options(refs)->opts);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
 				strbuf_addstr(err, "cannot lock references");
@@ -2010,8 +2009,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts,
-				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
+				 &reftable_be_write_options(refs)->opts);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2041,8 +2039,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
-				 &reftable_be_write_options(refs)->opts,
-				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
+				 &reftable_be_write_options(refs)->opts);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2424,8 +2421,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
-				 &reftable_be_write_options(refs)->opts,
-				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
+				 &reftable_be_write_options(refs)->opts);
 
 done:
 	return ret;
@@ -2499,8 +2495,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 	arg.stack = be->stack;
 
 	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
-				 &reftable_be_write_options(refs)->opts,
-				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
+				 &reftable_be_write_options(refs)->opts);
 
 	assert(ret != REFTABLE_API_ERROR);
 	return ret;
@@ -2622,8 +2617,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		goto done;
 
 	ret = reftable_stack_new_addition(&add, be->stack,
-					  &reftable_be_write_options(refs)->opts,
-					  REFTABLE_STACK_NEW_ADDITION_RELOAD);
+					  &reftable_be_write_options(refs)->opts);
 	if (ret < 0)
 		goto done;
 
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 5d22d84e80..5d224f8079 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -58,22 +58,13 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
 /* holds a transaction to add tables at the top of a stack. */
 struct reftable_addition;
 
-enum {
-	/*
-	 * Reload the stack when the stack is out-of-date after locking it.
-	 */
-	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
-};
-
 /*
  * returns a new transaction to add reftables to the given stack. As a side
- * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
- * flags.
+ * effect, the ref database is locked.
  */
 int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
-				const struct reftable_write_options *opts,
-				unsigned int flags);
+				const struct reftable_write_options *opts);
 
 /* Adds a reftable to transaction. */
 int reftable_addition_add(struct reftable_addition *add,
@@ -93,14 +84,12 @@ void reftable_addition_destroy(struct reftable_addition *add);
 /*
  * Add a new table to the stack. The write_table function must call
  * reftable_writer_set_limits, add refs and return an error value.
- * The flags are passed through to `reftable_stack_new_addition()`.
  */
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write_table)(struct reftable_writer *wr,
 					  void *write_arg),
 		       void *write_arg,
-		       const struct reftable_write_options *opts,
-		       unsigned flags);
+		       const struct reftable_write_options *opts);
 
 struct reftable_iterator;
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 308f9578f0..540f5e77ac 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -659,8 +659,7 @@ static void reftable_addition_close(struct reftable_addition *add)
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,
-					const struct reftable_write_options *opts,
-					unsigned int flags)
+					const struct reftable_write_options *opts)
 {
 	struct reftable_buf lock_file_name = REFTABLE_BUF_INIT;
 	int err;
@@ -686,15 +685,11 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	err = stack_uptodate(st);
 	if (err < 0)
 		goto done;
-	if (err > 0 && flags & REFTABLE_STACK_NEW_ADDITION_RELOAD) {
+	if (err > 0) {
 		err = reftable_stack_reload_maybe_reuse(add->stack, 1);
 		if (err)
 			goto done;
 	}
-	if (err > 0) {
-		err = REFTABLE_OUTDATED_ERROR;
-		goto done;
-	}
 
 	add->next_update_index = reftable_stack_next_update_index(st);
 done:
@@ -708,13 +703,12 @@ static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
 					    void *arg),
 			 void *arg,
-			 const struct reftable_write_options *opts,
-			 unsigned flags)
+			 const struct reftable_write_options *opts)
 {
 	struct reftable_addition add;
 	int err;
 
-	err = reftable_stack_init_addition(&add, st, opts, flags);
+	err = reftable_stack_init_addition(&add, st, opts);
 	if (err < 0)
 		goto done;
 
@@ -731,17 +725,10 @@ static int stack_try_add(struct reftable_stack *st,
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write)(struct reftable_writer *wr, void *arg),
 		       void *arg,
-		       const struct reftable_write_options *opts,
-		       unsigned flags)
+		       const struct reftable_write_options *opts)
 {
-	int err = stack_try_add(st, write, arg, opts, flags);
+	int err = stack_try_add(st, write, arg, opts);
 	if (err < 0) {
-		if (err == REFTABLE_OUTDATED_ERROR) {
-			/* Ignore error return, we want to propagate
-			   REFTABLE_OUTDATED_ERROR.
-			*/
-			reftable_stack_reload(st);
-		}
 		return err;
 	}
 
@@ -843,8 +830,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 
 int reftable_stack_new_addition(struct reftable_addition **dest,
 				struct reftable_stack *st,
-				const struct reftable_write_options *opts,
-				unsigned int flags)
+				const struct reftable_write_options *opts)
 {
 	int err;
 
@@ -852,7 +838,7 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 	if (!*dest)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
-	err = reftable_stack_init_addition(*dest, st, opts, flags);
+	err = reftable_stack_init_addition(*dest, st, opts);
 	if (err) {
 		reftable_free(*dest);
 		*dest = NULL;
@@ -1840,12 +1826,7 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 int reftable_stack_clean(struct reftable_stack *st)
 {
 	struct reftable_addition *add = NULL;
-	int err = reftable_stack_new_addition(&add, st, NULL, 0);
-	if (err < 0) {
-		goto done;
-	}
-
-	err = reftable_stack_reload(st);
+	int err = reftable_stack_new_addition(&add, st, NULL);
 	if (err < 0) {
 		goto done;
 	}
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index e6c1635940..c6254190e6 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -127,7 +127,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		cl_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
 
 		cl_assert_equal_i(reftable_stack_add(st,
-						     &write_test_ref, &ref, &opts, 0), 0);
+						     &write_test_ref, &ref, &opts), 0);
 	}
 }
 
@@ -168,7 +168,7 @@ void test_reftable_stack__add_one(void)
 	err = reftable_new_stack(&st, dir, NULL);
 	cl_assert(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref, &opts, 0);
+	err = reftable_stack_add(st, write_test_ref, &ref, &opts);
 	cl_assert(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
@@ -231,12 +231,9 @@ void test_reftable_stack__uptodate(void)
 	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st1, write_test_ref,
-					     &ref1, NULL, 0), 0);
+					     &ref1, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
-					     &ref2, NULL, 0), REFTABLE_OUTDATED_ERROR);
-	cl_assert_equal_i(reftable_stack_reload(st2), 0);
-	cl_assert_equal_i(reftable_stack_add(st2, write_test_ref,
-					     &ref2, NULL, 0), 0);
+					     &ref2, NULL), 0);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
 	clear_dir(dir);
@@ -260,7 +257,7 @@ void test_reftable_stack__transaction_api(void)
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&ref), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -301,21 +298,17 @@ void test_reftable_stack__transaction_with_reload(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[0]), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
 	reftable_addition_destroy(add);
 
 	/*
-	 * The second stack is now outdated, which we should notice. We do not
-	 * create the addition and lock the stack by default, but allow the
-	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
+	 * The second stack is now outdated, but it should automatically reload it
+	 * with the newer updates.
 	 */
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL, 0),
-						      REFTABLE_OUTDATED_ERROR);
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL,
-						      REFTABLE_STACK_NEW_ADDITION_RELOAD), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[1]), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -363,7 +356,7 @@ void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 		 * better control over when exactly auto compaction runs.
 		 */
 		cl_assert_equal_i(reftable_stack_new_addition(&add,
-							      st, &write_opts, 0), 0);
+							      st, &write_opts), 0);
 		cl_assert_equal_i(reftable_addition_add(add,
 							write_test_ref, &ref), 0);
 		cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -400,7 +393,7 @@ void test_reftable_stack__auto_compaction_fails_gracefully(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref, NULL, 0), 0);
+					     &ref, NULL), 0);
 	cl_assert_equal_i(st->merged->tables_len, 1);
 	cl_assert_equal_i(st->stats.attempts, 0);
 	cl_assert_equal_i(st->stats.failures, 0);
@@ -418,7 +411,7 @@ void test_reftable_stack__auto_compaction_fails_gracefully(void)
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
-	err = reftable_stack_add(st, write_test_ref, &ref, NULL, 0);
+	err = reftable_stack_add(st, write_test_ref, &ref, NULL);
 	cl_assert(!err);
 	cl_assert_equal_i(st->merged->tables_len, 2);
 	cl_assert_equal_i(st->stats.attempts, 1);
@@ -453,9 +446,9 @@ void test_reftable_stack__update_index_check(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref1, NULL, 0), 0);
+					     &ref1, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref2, NULL, 0), REFTABLE_API_ERROR);
+					     &ref2, NULL), REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
@@ -469,7 +462,7 @@ void test_reftable_stack__lock_failure(void)
 	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--)
 		cl_assert_equal_i(reftable_stack_add(st, write_error,
-						     &i, NULL, 0), i);
+						     &i, NULL), i);
 
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -513,7 +506,7 @@ void test_reftable_stack__add(void)
 
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], &opts, 0), 0);
+						     &refs[i], &opts), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -521,7 +514,7 @@ void test_reftable_stack__add(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, &opts, 0), 0);
+						     &arg, &opts), 0);
 	}
 
 	cl_assert_equal_i(reftable_stack_compact_all(st, &opts, NULL), 0);
@@ -604,7 +597,7 @@ void test_reftable_stack__iterator(void)
 
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], NULL, 0), 0);
+						     &refs[i], NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -613,7 +606,7 @@ void test_reftable_stack__iterator(void)
 		};
 
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, NULL, 0), 0);
+						     &arg, NULL), 0);
 	}
 
 	reftable_stack_init_ref_iterator(st, &it);
@@ -685,11 +678,11 @@ void test_reftable_stack__log_normalize(void)
 
 	input.value.update.message = (char *) "one\ntwo";
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, NULL, 0), REFTABLE_API_ERROR);
+					     &arg, NULL), REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, NULL, 0), 0);
+					     &arg, NULL), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
 						  &dest), 0);
 	cl_assert_equal_s(dest.value.update.message, "one\n");
@@ -697,7 +690,7 @@ void test_reftable_stack__log_normalize(void)
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
 	cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-					     &arg, NULL, 0), 0);
+					     &arg, NULL), 0);
 	cl_assert_equal_i(reftable_stack_read_log(st, input.refname,
 						  &dest), 0);
 	cl_assert_equal_s(dest.value.update.message, "two\n");
@@ -747,7 +740,7 @@ void test_reftable_stack__tombstone(void)
 	}
 	for (i = 0; i < N; i++)
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &refs[i], NULL, 0), 0);
+						     &refs[i], NULL), 0);
 
 	for (i = 0; i < N; i++) {
 		struct write_log_arg arg = {
@@ -755,7 +748,7 @@ void test_reftable_stack__tombstone(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, NULL, 0), 0);
+						     &arg, NULL), 0);
 	}
 
 	cl_assert_equal_i(reftable_stack_read_ref(st, "branch",
@@ -801,7 +794,7 @@ void test_reftable_stack__hash_id(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-					     &ref, NULL, 0), 0);
+					     &ref, NULL), 0);
 
 	/* can't read it with the wrong hash ID. */
 	cl_assert_equal_i(reftable_new_stack(&st32, dir,
@@ -869,7 +862,7 @@ void test_reftable_stack__reflog_expire(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 		cl_assert_equal_i(reftable_stack_add(st, write_test_log,
-						     &arg, NULL, 0), 0);
+						     &arg, NULL), 0);
 	}
 
 	cl_assert_equal_i(reftable_stack_compact_all(st, NULL, NULL), 0);
@@ -908,7 +901,7 @@ void test_reftable_stack__empty_add(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
 	cl_assert_equal_i(reftable_stack_add(st, write_nothing,
-					     NULL, NULL, 0), 0);
+					     NULL, NULL), 0);
 	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
 	clear_dir(dir);
 	reftable_stack_destroy(st);
@@ -947,7 +940,7 @@ void test_reftable_stack__auto_compaction(void)
 		};
 		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, write_test_ref, &ref, &opts, 0);
+		err = reftable_stack_add(st, write_test_ref, &ref, &opts);
 		cl_assert(!err);
 
 		err = reftable_stack_auto_compact(st, &opts);
@@ -983,7 +976,7 @@ void test_reftable_stack__auto_compaction_factor(void)
 		};
 		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref, &opts, 0);
+		err = reftable_stack_add(st, &write_test_ref, &ref, &opts);
 		cl_assert(!err);
 
 		cl_assert(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
@@ -1064,7 +1057,7 @@ void test_reftable_stack__add_performs_auto_compaction(void)
 		ref.refname = buf;
 
 		cl_assert_equal_i(reftable_stack_add(st, write_test_ref,
-						     &ref, &write_opts, 0), 0);
+						     &ref, &write_opts), 0);
 
 		/*
 		 * The stack length should grow continuously for all runs where
@@ -1303,7 +1296,7 @@ void test_reftable_stack__invalid_limit_updates(void)
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, &opts, 0), 0);
+	cl_assert_equal_i(reftable_stack_new_addition(&add, st, &opts), 0);
 
 	/*
 	 * write_limits_after_ref also updates the update indexes after adding

-- 
2.55.GIT

