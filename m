Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E13E2772
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916661; cv=none; b=fov3vOccK0d6F0OXZNIBs455s/1QNXyjvQgSjwVGCnylthuybqj0SJoyj5SAROgt0/hQ/2NrQX0cxHVQopNFGWTjjux1VQ/mOu+gQ/9x2vVOafCvJomlYGPPuwdZr2yNrHhGQ74AnqaDuiQOA6jfJaElLV4SaNyNQ1Epbv3o3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916661; c=relaxed/simple;
	bh=FKOdbQeyi2R9rj5+zXeZqEBJG2MjiBsTIsE/TyXDUQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WjjN5dihGP0wSSrmUoMrLf8XFaBKndF88n3d65ECgTrXwit7NmF35DlGcBq8YArqevlttVD74rIjTcw1/OBso/T19tm6bb8UAeXnKgKvaHN6HM7QlUzSGmf/rxCiW5l/Pb6JKTgkqVXNFsxJXaBaW/emgK+EGzfAmTdcw903Yq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmV12irW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmV12irW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so42133025e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916659; x=1778521459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKoVq1oRFXtE6PqIJQ67+Wz4tYWyMANm9Mgw1DhTtMo=;
        b=XmV12irWhri52HbskVm7jpspeP9wCebcDXfwir4kJj7vmfbk+L5hItmJ+FasGsfXMJ
         mhN/sAZ2aG3qc7rq40zC8NnO1ShOYQWMf8uQ0+9x5++YrTRl3QR66iqgdE/0y1by32Sb
         D+Jx5d4jbUWpVS7QPogyB7wuSZwDyBGXzioe4CuZVsJNCbJ1OR1qWK9dO1pKd+8HaAak
         Wi69ygU18On2KEAIptsfWrRiv0nvrblY/hWEl0zkpawEJiUerWVEnAU3ZpnJZzh8WmjI
         cGJ3mZu4ACrvbWL/XBbHYRO5ebJrORfv4Wddq5EYQ19INOTcfiaejcCWDHVNZ7++PL5h
         qp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916659; x=1778521459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QKoVq1oRFXtE6PqIJQ67+Wz4tYWyMANm9Mgw1DhTtMo=;
        b=qSM2JHIUwk+f5S22xwHBTTXBJa0G2Lzwv7BZX9sYHncPkmSB/f+YTrSFrFOZg/FaEi
         T5LDNaveVVQSi1v69ZSwrD0owLe+dZWShlWV8qpyb3gW3v8XP+dSlqL8LNfLBrjgNGpI
         rZTLddZ4ejDFWr+AUproldMSulTWhz9GMlGtciGv6Sr3H0wz3Tb9rLGhblCjR2POaEi9
         fWTSiPW8d84zJByz9ifh6toFyA2JFBIBZVd2SG6uoBIW0m1dj6KMThiFMQtMekNzL+xS
         fPCtGmznzQTRVKhF0OVdo0N3lsjcMU21Xn2tizktmMLccNr4O36hX2OOtqD0eYHhiUsz
         Z8hA==
X-Gm-Message-State: AOJu0YwaItN691Ixr73soXD3QRJasRaFRop94/V2WpZO1bJAMFdxSN9g
	b2b/HQDCvjwwplTqgSLnQQvtQg9tLNssXgg2TvUJTfrrSGplpHWQIE3f
X-Gm-Gg: AeBDievkgWhIu5C8ag6X5Lvo86JLD3uTB1e6wqUcJG1BQSUt9LtO9yiMQpNAUqDuuM2
	uLPTh5bq7gbsxvtIMgYxz80FmGPn7rM22t9KEB/JYo4cCVHfeDdexusca/eJa7vCijo8kEnfTug
	Fue7n0Aqb55yoT/uNmG8qwN5KQ1EgoxeUmlzNImb/QMMwre1t53CRP44kfxC1GXPEVB8yKDezgN
	A0j+c4U4jVdIrHOAeEXgpXsz6lJN0MTOxTsuhfDzsZo6RVnVicYPjT6A2kgTts6CV/lNi6HbhYU
	so7zZZI2TG2IYegUC8xEpAzeUoIyTfNT9/tXbmL/tDqFJ48JX44+OFwslwdGvIHqMBC+RXybHHH
	Gno4pOjOoWMejgYZgyEmk1jslZfc9cnFF+UaQphhwMzxr8QkYEQfoPjf+q8NHvW/m48V93NrwxO
	qQzMIrPnuAEyuPAd5TqDs215ous39mPo31pCVye7zB
X-Received: by 2002:a05:600c:530e:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a9865ad96mr187256175e9.17.1777916658446;
        Mon, 04 May 2026 10:44:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:10 +0200
Subject: [PATCH v4 6/9] update-ref: handle rejections while adding updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-6-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12224;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=FKOdbQeyi2R9rj5+zXeZqEBJG2MjiBsTIsE/TyXDUQ8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42urx0Z4eXy3ldhKQSr46tuN/RUU2uo7Tt
 tujjSmcqPtU3YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrqAAoJED7VnySO
 Rox/gEEL/ihqEfPh1bPXkYT9zPyzBZTvnWMgmKZZu2CMkv9cKbFaORniLRmYOOHOTu5R7m7LzDo
 0oilqfaTXT8NftpRTNB6yItJovQxp/A0TFs7/D++9+QqIWa2NZLyUWkqFUoxop/wKRSbigJBamY
 PzWQaip9MiyFXkhkhThBhPareWjRcKO1v/pj28xEDdw4183Hj9YKiOTfxB/9ZtZXVPdjPCwtP7G
 Te86I8g11jzEPLsMbVCsRG8LexZYUOYVektwWopF9zap2y+fAAbT7Mu+o4mshF8idC4CoG/Giyd
 X8S9sL5N/yyY3+Phs9XY7qkflKv+ZMuP5zR4QxSnjysnU/krPc78j/ch7JbjCHDvEuI8gREr8ac
 AOMX7WxMWAKpcfqpc/b8PFrevekRKXTxWArmvtikDzuvGXPbjOPQUGDJOV3qAFHQ5v9Xc5bP+bT
 CnSQc/TGsWlh+UjRphosxmQjADh4mIMfpSqf3dIAXHopEypcn3I/lskKgwN98Gx1uE0AxMqBEf8
 Lw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When using git-update-ref(1) with the '--batch-updates' flag, updates
rejected by the reference backend are displayed to the user while other
updates are applied. This only applies during the commit phase of the
transaction.

In the following commits, we'll also extend `ref_transaction_update()`
to reject updates before a transaction is prepared/committed. In
preparation, modify the code in update-ref to also handle non-generic
rejections from `ref_transaction_update()`. This involves propagating
information to each of the commands on whether updates are allowed to be
rejected, and also checking for rejections and only dying for generic
failures.

Errors encountered during updates will be shown to the user immediately
unlike other errors encountered only when the transaction is
prepared/committed. As the verification of object IDs and peeled tag
objects will move into `ref_transaction_update()` in the following
commit, this means that those errors will be shown to the user before
other errors, this changes the order of errors, but the functionality
remains the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 137 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 98 insertions(+), 39 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5259cc7226..6355c3dd3e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -25,6 +25,15 @@ static unsigned int default_flags;
 static unsigned create_reflog_flag;
 static const char *msg;
 
+struct command_options {
+	/*
+	 * Individual updates are allowed to fail without causing
+	 * update-ref to exit. This is set when using the
+	 * '--batch-updates' flag.
+	 */
+	bool allow_update_failures;
+};
+
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
  * and append the result to arg.  Return a pointer to the terminator.
@@ -257,6 +266,31 @@ static void print_rejected_refs(const char *refname,
 	strbuf_release(&sb);
 }
 
+/*
+ * Handle transaction errors. If we're using batches updates, we want to only
+ * die for generic errors and print the remaining to the user.
+ */
+static void handle_ref_transaction_error(const char *refname,
+					 struct object_id *new_oid,
+					 struct object_id *old_oid,
+					 const char *new_target,
+					 const char *old_target,
+					 enum ref_transaction_error tx_err,
+					 struct strbuf *err,
+					 struct command_options *opts)
+{
+	if (!tx_err)
+		return;
+
+	if (tx_err != REF_TRANSACTION_ERROR_GENERIC && opts->allow_update_failures) {
+		print_rejected_refs(refname, old_oid, new_oid, old_target,
+				    new_target, tx_err, err->buf, NULL);
+		return;
+	}
+
+	die("%s", err->buf);
+}
+
 /*
  * The following five parse_cmd_*() functions parse the corresponding
  * command.  In each case, next points at the character following the
@@ -268,11 +302,13 @@ static void print_rejected_refs(const char *refname,
  */
 
 static void parse_cmd_update(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	struct object_id new_oid, old_oid;
+	enum ref_transaction_error tx_err;
 	int have_old;
 
 	refname = parse_refname(&next);
@@ -289,12 +325,14 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname,
-				   &new_oid, have_old ? &old_oid : NULL,
-				   NULL, NULL,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
-		die("%s", err.buf);
+	tx_err = ref_transaction_update(transaction, refname,
+					&new_oid, have_old ? &old_oid : NULL,
+					NULL, NULL,
+					update_flags | create_reflog_flag,
+					msg, &err);
+	handle_ref_transaction_error(refname, &new_oid, have_old ? &old_oid : NULL,
+				     NULL, NULL, tx_err, &err, opts);
+
 
 	update_flags = default_flags;
 	free(refname);
@@ -302,9 +340,11 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_update(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts)
 {
 	char *refname, *new_target, *old_arg;
+	enum ref_transaction_error tx_err;
 	char *old_target = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -341,13 +381,15 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("symref-update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, NULL,
-				   have_old_oid ? &old_oid : NULL,
-				   new_target,
-				   have_old_oid ? NULL : old_target,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
-		die("%s", err.buf);
+	tx_err = ref_transaction_update(transaction, refname, NULL,
+					have_old_oid ? &old_oid : NULL,
+					new_target,
+					have_old_oid ? NULL : old_target,
+					update_flags | create_reflog_flag,
+					msg, &err);
+	handle_ref_transaction_error(refname, NULL, have_old_oid ? &old_oid : NULL,
+				     new_target, have_old_oid ? NULL : old_target,
+				     tx_err, &err, opts);
 
 	update_flags = default_flags;
 	free(refname);
@@ -358,11 +400,13 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_create(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
 	struct object_id new_oid;
+	enum ref_transaction_error tx_err;
 
 	refname = parse_refname(&next);
 	if (!refname)
@@ -377,22 +421,24 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, &new_oid, NULL,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
-		die("%s", err.buf);
+	tx_err = ref_transaction_create(transaction, refname, &new_oid, NULL,
+					update_flags | create_reflog_flag,
+					msg, &err);
+	handle_ref_transaction_error(refname, &new_oid, NULL, NULL, NULL, tx_err,
+				     &err, opts);
 
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_symref_create(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *new_target;
+	enum ref_transaction_error tx_err;
 
 	refname = parse_refname(&next);
 	if (!refname)
@@ -405,10 +451,11 @@ static void parse_cmd_symref_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("symref-create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, NULL, new_target,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
-		die("%s", err.buf);
+	tx_err = ref_transaction_create(transaction, refname, NULL, new_target,
+					update_flags | create_reflog_flag,
+					msg, &err);
+	handle_ref_transaction_error(refname, NULL, NULL, new_target, NULL,
+				     tx_err, &err, opts);
 
 	update_flags = default_flags;
 	free(refname);
@@ -417,7 +464,8 @@ static void parse_cmd_symref_create(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_delete(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -450,9 +498,9 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_symref_delete(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *old_target;
@@ -479,9 +527,9 @@ static void parse_cmd_symref_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_verify(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -508,7 +556,8 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -550,7 +599,8 @@ static void report_ok(const char *command)
 }
 
 static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
@@ -560,7 +610,8 @@ static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	if (*next != line_termination)
 		die("start: extra input: %s", next);
@@ -568,7 +619,8 @@ static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_prepare(struct ref_transaction *transaction,
-			      const char *next, const char *end UNUSED)
+			      const char *next, const char *end UNUSED,
+			      struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -579,7 +631,8 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_abort(struct ref_transaction *transaction,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -590,7 +643,8 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_commit(struct ref_transaction *transaction,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -618,7 +672,8 @@ enum update_refs_state {
 
 static const struct parse_cmd {
 	const char *prefix;
-	void (*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *,
+		   struct command_options *);
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
@@ -644,6 +699,10 @@ static void update_refs_stdin(unsigned int flags)
 	struct ref_transaction *transaction;
 	int i, j;
 
+	struct command_options opts = {
+		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
+	};
+
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 						  flags, &err);
 	if (!transaction)
@@ -721,7 +780,7 @@ static void update_refs_stdin(unsigned int flags)
 		}
 
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
-			input.buf + input.len);
+			input.buf + input.len, &opts);
 	}
 
 	switch (state) {

-- 
2.53.GIT

