Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F23F39D0
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563882; cv=none; b=KrcN/HdFj/fOZLwQheA8AGbJaeInPDXMjA6BHuycyy62+Wwv73vlai4iJqnf6FNCm7v63o1KeI0+AOwBXnbODbsYc+HVVyylaOrIw2ZkUDbHgmuSKeiFSYKtMYXZynN7TEUkwRW+oNOAg5QnQH6nN0e/Im5aNk4YVpO50bVuwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563882; c=relaxed/simple;
	bh=3Qt6cfkVeBWyTEqVZlrsEvwwQl+eAfN0uRN6O9yPQwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATZv5VtCdqCr+e0aMn2F/49no6ipUGV0xpt1LRoc0vK14T6QRgn2p2V0RtG7e3aWUMMF52+5Rg0fkk9SwRKpdBYPAgPX7iIZ4gFfoZVYIDuu51bXnOE8wyCmubT3KDmUyMZxbV65bjQDSvgBgstRMb9xALHbcY6n1yhto/2CW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBR/NpK6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBR/NpK6"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c214321dc32so633434166b.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563877; x=1788168677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VY9YRitrrDOYP4C1L2Y6l9I5iHx0IQ/xzrYXfshNhZc=;
        b=bBR/NpK6HdGDx+28doR8LB8qVE5O9w2qX1SJD+RsxJ3TGqOTW0s/CYx59WGgdSXu9t
         ThLo8obtLqYKHu81ANdk5r/VuXmN5PLBg5Vw4ru9i3Qq1vX1crgiQ+LiRM6i5lA/lMn9
         fkBUbYiAIDr4fXOalrRonsAZ+JTu237gGXRMYgpOXzvTFaAzTO9iNT7aoZ7CUBmLoWLV
         XSznBSp6Fp9ge1esp3cI13jN4aQS3jZcOE3QZg5/R2G9nQfchYiQ5zFttcXl1pNbBxjh
         GKta1lABTZCEPprw73uKNtXV6x4L2DmUwGK2ibs09Le4DhMycW0g371vL5ZW0FP58Byi
         I+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563877; x=1788168677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VY9YRitrrDOYP4C1L2Y6l9I5iHx0IQ/xzrYXfshNhZc=;
        b=UKH+IdnT0HvFw5HbflCP0F2p6c4fxkfNy1CvEL9H5RWX6pEZegeQM/makI70Z52R5P
         dSqWOM259q7cvB7EBENQqplcY1fDq86KfF/DmjoYA54WvUg4TKc/xoUDud98t0PW4Tv2
         waI+7I/jz5eQAA2NKW+W1sfN+AEILMOTyJ9nRrw8t0pUBBNfR84dmCgzEQLwaC9c3jJs
         JlFuNH76VMrXogfdssWG9IEjg7oBiErJYZmdN0sQIsg6y4dgvjyaAozsM5+ro84Yvu1X
         Sb7t7zyT/otuY7SxNdyzpdrJQEXj2zJp4AMsMrnZsk3k8au4JFRBk8LBuQUrpMPdwMr4
         978w==
X-Gm-Message-State: AFuF++n9x4uiI6Q2JM8za/8GfSgBDM89ly0H7sXsR+nGHE1RTiabuTjQ
	YmeMtEgv1Upg2CjIJrHCoiqJGW/Zphj+deSalC3QglPnGNYtt+RTv2S3EsPD6sHQ
X-Gm-Gg: AR+sD11p2JJ3/2vhy9+ZHVmcPWka2EEzQy7J9ua0AFup7nhqqZO8tEU5EnlFW1stkC6
	am6DodY3Sb8+IJgV29kTGOv1fImHznZ1+r0DBDYxZFPJc+DVB0JaJECqWjxMaD8ITS4xn56gjR+
	+QzfavDsdicBLbmlLFcePbvGvaKdpczS1kIjcoFZAtN/mdE06pD6TnXuS+0HumvI0HTJPYTo9o1
	3XVtB23ZLbQ8XsI1zbKVz/QAELjOObClcd2jY1s7RdfwY1DTMGJk1J5amhM8WaGQTfQVsJUFK4k
	4wnb6i6OfssJJY2vlddTHKc+ldwZwTmVlFsmW9SAkndtnP9zAE8pbHfIm0XcbedvM47SD0CdPfY
	S8D6JUlWiNMdRj/ENCM1voMp+70x0kK61lSolqsAlYXjDE8ZRY4mojaxBkNsp97MO1NiehWX2sL
	6UKZnQV1ofhkxYQpYVqImFjBPnOLHbtkiN8HyScV9UE/coSOH4qxmIEIqAwrInexsQi0UW2S49/
	C6yTbOxALE7FDC7R9tgaBnOrRnAl1AY+FSpZT4=
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id a640c23a62f3a-c246a6559aemr2042090566b.13.1787563876335;
        Mon, 24 Aug 2026 02:31:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1303013566b.29.2026.08.24.02.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:31:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 11:31:00 +0200
Subject: [PATCH v2 2/4] reftable/stack: rename
 reftable_stack_new_addition()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-740-optimize-reloading-the-reftable-stack-v2-2-9c9de2eb0af7@gmail.com>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
In-Reply-To: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5020; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=3Qt6cfkVeBWyTEqVZlrsEvwwQl+eAfN0uRN6O9yPQwY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMD2DfHV96uaxRLIx1mxOcd7oj4X/GYonQE
 rzsnmmQoNH7nIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjA9gAAoJED7VnySO
 Rox/DOUL/2VV6vKbrdrp4XvC0w25iMMaNiBacntoafx4Z0F6N7luucYTODnUmw8f2f7qKeiw8Qc
 TkPywMVcNMT1l07t8Yoy2LRZYHg0HTzKZyf/btFBicoTmjWzrfLaCQNMbp5NtagiF4su7iJ/a2C
 i3jEtnRAhcH1E/bFGJsZuc+eiuI+PJ5j3TO0V1Q6Z5Fn4f/ocJHHLj8tcSVpKFSEnQVPZz1LWwu
 QAGd7lIDb35J0Q0YgRnwf3V4v536t75Bv3JOkqWgTIjuo/yZJRFnozdT0bd9QVosWDRLnQIHaIk
 myc82aAMDGzp1NJEyMbIT4y9hLOJfEbYasRCCZKgH7puyLzD49Chhy0ATuZ0cQaoSYooV+G/mqv
 vh/BdpWSzmMpmET8rMvOd8zlaed919GiD0D0szDzfUyJOhTEmb1NtSWdURLavKxZVMczWaaspMi
 p5y6dM0U7AvZUX5f7UUPkJFTh4KwmHxtDktiXHjpdj5VSgiEVQUtsERBCO4cOJlRk41D/8kWYk6
 9I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Rename the function `reftable_stack_new_addition()` to
`reftable_stack_addition_new()` to be more inline with our naming
scheme.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c         |  4 ++--
 reftable/reftable-stack.h       |  2 +-
 reftable/stack.c                |  4 ++--
 t/unit-tests/u-reftable-stack.c | 10 +++++-----
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5c87fd2d68..73cd794fc6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1002,7 +1002,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 	if (!arg) {
 		struct reftable_addition *addition;
 
-		ret = reftable_stack_new_addition(&addition, be->stack,
+		ret = reftable_stack_addition_new(&addition, be->stack,
 						  &reftable_be_write_options(refs)->opts);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
@@ -2616,7 +2616,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, be->stack,
+	ret = reftable_stack_addition_new(&add, be->stack,
 					  &reftable_be_write_options(refs)->opts);
 	if (ret < 0)
 		goto done;
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 5d224f8079..875d09d241 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -62,7 +62,7 @@ struct reftable_addition;
  * returns a new transaction to add reftables to the given stack. As a side
  * effect, the ref database is locked.
  */
-int reftable_stack_new_addition(struct reftable_addition **dest,
+int reftable_stack_addition_new(struct reftable_addition **dest,
 				struct reftable_stack *st,
 				const struct reftable_write_options *opts);
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 540f5e77ac..703548417c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -828,7 +828,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	return err;
 }
 
-int reftable_stack_new_addition(struct reftable_addition **dest,
+int reftable_stack_addition_new(struct reftable_addition **dest,
 				struct reftable_stack *st,
 				const struct reftable_write_options *opts)
 {
@@ -1826,7 +1826,7 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 int reftable_stack_clean(struct reftable_stack *st)
 {
 	struct reftable_addition *add = NULL;
-	int err = reftable_stack_new_addition(&add, st, NULL);
+	int err = reftable_stack_addition_new(&add, st, NULL);
 	if (err < 0) {
 		goto done;
 	}
diff --git a/t/unit-tests/u-reftable-stack.c b/t/unit-tests/u-reftable-stack.c
index c6254190e6..04927113c2 100644
--- a/t/unit-tests/u-reftable-stack.c
+++ b/t/unit-tests/u-reftable-stack.c
@@ -257,7 +257,7 @@ void test_reftable_stack__transaction_api(void)
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, NULL), 0);
+	cl_assert_equal_i(reftable_stack_addition_new(&add, st, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&ref), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -298,7 +298,7 @@ void test_reftable_stack__transaction_with_reload(void)
 
 	cl_assert_equal_i(reftable_new_stack(&st1, dir, NULL), 0);
 	cl_assert_equal_i(reftable_new_stack(&st2, dir, NULL), 0);
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st1, NULL), 0);
+	cl_assert_equal_i(reftable_stack_addition_new(&add, st1, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[0]), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -308,7 +308,7 @@ void test_reftable_stack__transaction_with_reload(void)
 	 * The second stack is now outdated, but it should automatically reload it
 	 * with the newer updates.
 	 */
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st2, NULL), 0);
+	cl_assert_equal_i(reftable_stack_addition_new(&add, st2, NULL), 0);
 	cl_assert_equal_i(reftable_addition_add(add, write_test_ref,
 						&refs[1]), 0);
 	cl_assert_equal_i(reftable_addition_commit(add), 0);
@@ -355,7 +355,7 @@ void test_reftable_stack__transaction_api_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		cl_assert_equal_i(reftable_stack_new_addition(&add,
+		cl_assert_equal_i(reftable_stack_addition_new(&add,
 							      st, &write_opts), 0);
 		cl_assert_equal_i(reftable_addition_add(add,
 							write_test_ref, &ref), 0);
@@ -1296,7 +1296,7 @@ void test_reftable_stack__invalid_limit_updates(void)
 
 	reftable_addition_destroy(add);
 
-	cl_assert_equal_i(reftable_stack_new_addition(&add, st, &opts), 0);
+	cl_assert_equal_i(reftable_stack_addition_new(&add, st, &opts), 0);
 
 	/*
 	 * write_limits_after_ref also updates the update indexes after adding

-- 
2.55.GIT

