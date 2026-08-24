Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AD352031
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563883; cv=none; b=CTtYYvyMX3CN3dWMVGkjdyvoblGrFjARw0W1U2+8GybjQyCJVwkAHhkV54tKbRMYYT2wfpS+eM4xMLLPlGgzkLa4v0H5Wb9+NB3Ol7qnbA4HKhwWaCM0zSC59SWl9jVexnCep8EtPQpKeCPOUnTabF7paVZ6kx1+nNThXsG6wXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563883; c=relaxed/simple;
	bh=h33HKDBrlXLNt/PuvwOr+ueDazYSqCiNoJpP6Zf7PVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjWeGCSKViHFiuE3ro0Dc/XSKX79g2uQntC0GriByBqT+2kgjqd37vua+aIzPlOuqub09YMkI1F6Vy5KiMsSlz9vvV8bjRrZOLjFcAvaTwDX3I+1IuC6MRPQurGGYaD+oOR352/0GrqlrLLQIydjcr09wo3c8HEEZ7XEirYyll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Z4mPkB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Z4mPkB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2055573c8cso482858566b.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563878; x=1788168678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqmdXZjNydQ3Z6ou3WWxYqlFDEhRRNXr3eF2G2190Zs=;
        b=O2Z4mPkBkcQzKjwczAkbzXff9xg/oVSYFYIwLHI7JbI9N9ezp06PEqo8sKNuvByzFX
         KL4vq1KO2zPUNPR6yew4w5GGzQsJ4A53rVk8KrvUliGeTzz0mxhpxk8wSP+X06VMhoFR
         D+uMd6MxeAl9TaXix5ucR+3uEIRSLCmL2MagLgqmL1cnUBn8blvj0+IDJ977GPZASCs6
         fGm0FWPIaLrRKc6VfcjD8VQTPKRHTEi//pgndU1c1dsE8ds8w+SqbPIyAetgMBwb2m1A
         jbBwV177nMQN11OW9AsdzZ3l8dETOp765JTUKJT5/n2ztd1xlPYM+vYKEeOIxkjPul2O
         n/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563878; x=1788168678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqmdXZjNydQ3Z6ou3WWxYqlFDEhRRNXr3eF2G2190Zs=;
        b=CyLvmWnsjGFH3KSryfIWR3hcNi6IBG1yEijxBSP3yzBvHq0VrRtHtIMJ4gejCGfZdg
         p4sm2MmYh+8ATf3T/7qUUfW/ylyytVoEmZlp2jVpCRJlpnS3kJQTv4PkY+thb/RbESem
         C4z/cQ3AUUye3r6G5Vc4KEp4yOXzT5pY3oMUYfMHhRQXkKMHtGPxOv9qrWiwunebAFBS
         X/gldYHXFi+bjatlExUBCj1XAqzGLKPrf6OGWAePjcjdxGnCp1LOxF4MBlX6q7eQaOvK
         VTYrvj7PUZvtx8JuQzVwfElIcTMWzTLqoj2JxlNpYkR+bd15VJeDQ/W33dBVMmWP97Eq
         P2aA==
X-Gm-Message-State: AFuF++l4MKOY2klIHaqRA5ScIU++xuet83L9mD7msPXnADJl3Lz+TG/3
	zFf2ESOLdw11TRQr+cY1DY+JABn7lu7YWwhFEmFKrh4sNpNHde3jT/n3
X-Gm-Gg: AR+sD11DVFfn/XApei6Om0WDShrQh3PF6LSMwVg7rKRLHzfi/Oei8lS9fhWjVcF7tch
	268Kp39xypNfjYwZUoMhoAFKz6VsXk4UApnowFVYUtBJTLX+ziENDBnQB6B0btQmLvU9kjby8QI
	MK9z3uRTlUqkth06qhcIG83LT4cqeVecE0MNMRd+dTtVDOH2gWWVV7GttmZ/dO0BRkAq4Vwb5XV
	4eSCEWClR40pBqhbIzMF2k+9cfJjGWQbpW3ajkyWzOxjih4mdhSRRfzPBHck8obNDp8nZBg8vjL
	FwZNBYrcA4lmKHitGv4nSpptvoimOKAVpX8I8B5O0lcvgHouoQ6BBP/BVRAYaH1XXRSBFFP2RWz
	n4vBcBe0pEvzVy1AI0AUtwcSJuQz/na1O1NHZ/EJSHtcdfPoySucQsGDiJSuR8KmBk9a2M+VsJh
	MvkombdFRPFdrS2hxfsP0VrSdzV4HY1jwnMCmhA0e3oEVt/IeeJTA7DntOnh4PH90+wlgbepHSb
	TkL59VrYrGoIr6q57OeMiMvEkc=
X-Received: by 2002:a17:907:60cf:b0:c24:6390:decf with SMTP id a640c23a62f3a-c24926f3e7fmr1890981766b.16.1787563877285;
        Mon, 24 Aug 2026 02:31:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1303013566b.29.2026.08.24.02.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:31:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 11:31:01 +0200
Subject: [PATCH v2 3/4] reftable/stack: move list lock to `struct
 reftable_stack`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-740-optimize-reloading-the-reftable-stack-v2-3-9c9de2eb0af7@gmail.com>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
In-Reply-To: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5995; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=h33HKDBrlXLNt/PuvwOr+ueDazYSqCiNoJpP6Zf7PVw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMD2C8IYwHZAWTx40LfpnT5BlceU8YARLPM
 A3w0Tfi38dzAYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjA9gAAoJED7VnySO
 Rox/q9UL/1Oo40h5z8l2nH38gLnPSRd3zDd0Jjyx6i3X6L4LLk5NM06TvEGjnkHkS5tPAl0bE/a
 jHrIWIu7Gx43Y+M6TVnnn+94VYU8Rjpw/buK3AIX8fWvNZBNo/0B5TuKoqxjxmOt0jblrQQFGwX
 ecTaS7vAnW+QlKBtEH23T885ZD1brIg6Tb+AHln8yInW1+YoKNlw7EMaVUm7wKsjgn450QxXfsS
 pVFVn2ye/OB1f9dV6BVtge2V1RcnwYBrL36gmmMSrFKoe+l8EAWQmAj5mIAlyH41hDtCuw+cVTj
 b//f/JleDkAa7ICTkLSg1N01k9UUpUbmFs5qgpGp3GSez2h1yVi6v3VrqH/R2GKzHiN/6Av1OeJ
 0SAqhq6KitrEQSTgIqx0H6828qXMyTmrgAkGbzRpefXMsZUDLxwQAMVkiS+Nj3GJR/drVk4nWkU
 dsqABlKeWO+jE/6oeiN2J85IJdbZFIER889ujx7qXRqMYumcq8QGv0n/hbFS0xgc3Hw81vOAtg7
 go=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The struct `reftable_addition` is used to modify a given stack, as such,
it also includes a `struct reftable_flock` used to obtain the lock to
the list file. While the scope of the field lies within this struct, it
doesn't allow for optimizations to be made on `struct reftable_stack`
itself.

Move the field to `struct reftable_stack`, allowing us to make a simple
optimization around avoiding a stack reload when we have already
obtained a lock. While this is currently possible in the write path, the
write path also contains multiple branches to reads which only work
on top of `struct reftable_stack`, and we would miss the optimization in
such paths.

Since the lock is now shared across all additions on the same stack, a
second `reftable_addition` that fails to acquire the already held lock
would still call `reftable_addition_close()`, which will release the
`stack->list_lock` which is still held by the first addition. To avoid
this, add a new bit field `locked` to `reftable_addition` that tracks
whether a particular addition is the one holding the lock, and only
release it in that case. Add a unit test to validate this behavior.

While here, remove an unused header file from 'reftable/stack.h'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c                | 26 +++++++++++++++++++-------
 reftable/stack.h                |  7 ++++++-
 t/unit-tests/u-reftable-stack.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 703548417c..c3d4deff29 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -536,6 +536,8 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		goto out;
 	}
 
+	p->list_lock = REFTABLE_FLOCK_INIT;
+
 	err = reftable_stack_reload_maybe_reuse(p, 1);
 	if (err < 0)
 		goto out;
@@ -628,10 +630,16 @@ int reftable_stack_reload(struct reftable_stack *st)
 }
 
 struct reftable_addition {
-	struct reftable_flock tables_list_lock;
 	struct reftable_stack *stack;
 	struct reftable_write_options opts;
 
+	/*
+	 * While the list lock is acquired on the stack, we need to distinguish
+	 * which 'reftable_addition' is responsible for the lock. This avoids
+	 * clearing the lock of another 'reftable_addition'.
+	 */
+	unsigned int locked : 1;
+
 	char **new_tables;
 	size_t new_tables_len, new_tables_cap;
 	uint64_t next_update_index;
@@ -653,7 +661,9 @@ static void reftable_addition_close(struct reftable_addition *add)
 	add->new_tables_len = 0;
 	add->new_tables_cap = 0;
 
-	flock_release(&add->tables_list_lock);
+	if (add->locked)
+		flock_release(&add->stack->list_lock);
+	add->locked = 0;
 	reftable_buf_release(&nm);
 }
 
@@ -669,13 +679,14 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	if (opts)
 		add->opts = *opts;
 
-	err = flock_acquire(&add->tables_list_lock, st->list_file,
+	err = flock_acquire(&add->stack->list_lock, st->list_file,
 			    add->opts.lock_timeout_ms);
 	if (err < 0)
 		goto done;
+	add->locked = 1;
 
 	if (add->opts.default_permissions) {
-		if (chmod(add->tables_list_lock.path,
+		if (chmod(add->stack->list_lock.path,
 			  add->opts.default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
@@ -774,7 +785,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 			goto done;
 	}
 
-	err = reftable_write_data(add->tables_list_lock.fd,
+	err = reftable_write_data(add->stack->list_lock.fd,
 				  table_list.buf, table_list.len);
 	reftable_buf_release(&table_list);
 	if (err < 0) {
@@ -782,17 +793,18 @@ int reftable_addition_commit(struct reftable_addition *add)
 		goto done;
 	}
 
-	err = fsync(add->tables_list_lock.fd);
+	err = fsync(add->stack->list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	err = flock_commit(&add->tables_list_lock);
+	err = flock_commit(&add->stack->list_lock);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+	add->locked = 0;
 
 	/* success, no more state to clean up. */
 	for (i = 0; i < add->new_tables_len; i++)
diff --git a/reftable/stack.h b/reftable/stack.h
index f7901e6c6f..52e07ad551 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -10,7 +10,6 @@
 #define STACK_H
 
 #include "system.h"
-#include "reftable-writer.h"
 #include "reftable-stack.h"
 
 struct reftable_stack {
@@ -18,6 +17,12 @@ struct reftable_stack {
 	char *list_file;
 	int list_fd;
 
+	/*
+	 * Set while an addition holds the stack locked. Used by
+	 * stack_uptodate() to skip reload checks while locked.
+	 */
+	struct reftable_flock list_lock;
+
 	char *reftable_dir;
 
 	struct reftable_stack_options opts;
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index 04927113c2..b6f1c6cc52 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -1310,3 +1310,31 @@ void test_reftable_stack__invalid_limit_updates(void)
 	reftable_stack_destroy(st);
 	clear_dir(dir);
 }
+
+void test_reftable_stack__two_additions(void)
+{
+	struct reftable_stack *st = NULL;
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_addition *add1 = NULL;
+	struct reftable_addition *add2 = NULL;
+
+	struct reftable_ref_record ref = {
+		.refname = (char *) "HEAD",
+		.update_index = 1,
+		.value_type = REFTABLE_REF_SYMREF,
+		.value.symref = (char *) "master",
+	};
+
+	cl_assert_equal_i(reftable_new_stack(&st, dir, NULL), 0);
+
+	cl_assert_equal_i(reftable_stack_addition_new(&add1, st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_addition_new(&add2, st, NULL), REFTABLE_LOCK_ERROR);
+
+	cl_assert_equal_i(reftable_addition_add(add1, write_test_ref, &ref), 0);
+
+	cl_assert_equal_i(reftable_addition_commit(add1), 0);
+
+	reftable_addition_destroy(add1);
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}

-- 
2.55.GIT

