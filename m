Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C033DE44E
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933648; cv=none; b=aEwa/nwjFXCmSLFC5Uqx9jCdRlr+xGZQXHc7ntZQYZSlkdTk2o+o3hIsBfERIKXsUo1QvAfv+a7yjbNBn6d59REhe1xmH9Rzab6ZDnFeoEBDDXYYbRL0i0SMd8aCQgippx0IAjMYGo0S4ev6Aii12RVcddRILiSHehOiVGkNHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933648; c=relaxed/simple;
	bh=atc6SKxbkOzk3ySsdc/VBrfxE19RdwFCAf1PmHHb1eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHppxW9R/TRS/86lWcXpBTzc5/j+a/NqDbTWycJWENH8jm25USA0ILCblo+jgiaUE1Z2ukWQBQUCm2SjhtZTEHRkrOb4PVmSILaynLM/vMq/QTJ6nAGkE4s4ZwNHGF08aYRpd+vquaORfx1/ChEXi68u8CVgW9BjcCITkgEPyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OseA6Sdw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OseA6Sdw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b150559bso50568945e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933645; x=1777538445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfZMviox4pBT2Fq3U7xUaQq0hyHgTL2TDnIcoFvYF8Y=;
        b=OseA6SdwtY/HS0+hvAH1yEkZlYisM7ZlrUOg0nkhmY2Xtwq9+PuENZMUfrHIWUhkvD
         qo6LC8w70YxGdjgZk6+bb+hcLqexWz89laUHNDQZvJBWmCmBHMBFf1rbF1wIbATmR+Ji
         7ptiR9W+h92yMJ6TotImyQShutO+pz0XBwYN1C8Akp67A2o5ZS0z47oNUFHQZqslUUrq
         sHrZcEHGdn5dOQpdghbsp8jDDNkCz0lImCDG6QMdYFEPYf1+oNPeMeUh/8BMH/34nhCX
         0ExRacvd8RKelqRsIAshi3tyemoB3Re4IJnYhJpwu3ZI7e+VZfqFqw6x1bggAvMi9OBi
         jTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933645; x=1777538445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JfZMviox4pBT2Fq3U7xUaQq0hyHgTL2TDnIcoFvYF8Y=;
        b=ZBYbYAeaq71qVds/ofRAQawgbu0jKzA5F7XN0dZZzMdD8YRIWEVBybOeia9Xr3LpkX
         TZ4j2fIMWXm1EmHXrH4PpSrXE9Ua2idrJ4LUd+xP1EzloOKCwN7DMyQs3nBwwqaQPadk
         /pJF+uA5XYIQpkrxWQMTreUg1/1uqeaBNsQgulPLYWyOxvwKwjXtV904q3vmnqTn4Niv
         F2noRAZoKJO5xBFaNx2YGgH+u8jbGYrnztpVrm14OUxwcPe9Z0RQSDOE62DgsduEtpOe
         HZFcM+xrV7rg3mmG/f5viVkDGrHqsjHCEEHG4GwbGQyG+6mDoq7UVvA1OBcE2E8LZgO5
         eAHA==
X-Gm-Message-State: AOJu0Yx0ZlTuH0AEzB3ZXGB7qO6wLIBkTCv7S2Hq8u0helbU//6LyW9/
	/REKm+7hhlSao81fRHmdnKaECIuK8EylsBYh7wf+bwlvzQN9WiDGsro9qCP7gA==
X-Gm-Gg: AeBDieuZgk/sJF1MxjZxIRNtHJ6iZ+UeNgGp7TSmbeEUs2j2xixpEHImWImIEkM+tdn
	eAItIScISAcFbf2r98TouA0GpkJhymaWjS1dnYEe1gHJ2gYad/9ELwet7e/hlSAium/6APmUYKA
	OplW+uvjogh5Dxdky+pzXk0Fb85xJig41LJOu62QMQEXVOBim2k2BfMoOKdPbDKGfUXSPCIqCft
	B4HeQOfG3PwHUuRLa/UvlX4NXNSYDGxMZQ84RJXf6hyfB3x1ZWG+SJG3WFfglMYpf8+783kXwRN
	ZLSZX0aYmH5lGFdWV2uaGy2DIf5rH3w/3h15U0KwNeB58lPAEhINhDGhwaG22MeBxFsVvBIz1B1
	kL6qGJAepOyRVt/diAt1O5fjdXXyNlo+mrO8S0U7lDaMNIH/tiX1e0bzystIpLGpjNk12+qO8Qf
	sgbmHSqrVfjj+gl74FFjXjUBwihqppVkRG4C1CY2Wj
X-Received: by 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id 5b1f17b1804b1-4890c57760emr164599065e9.31.1776933644947;
        Thu, 23 Apr 2026 01:40:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:35 +0200
Subject: [PATCH v2 6/9] update-ref: handle rejections while adding updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9659; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=atc6SKxbkOzk3ySsdc/VBrfxE19RdwFCAf1PmHHb1eY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wTvCrY5ZVi3ETQT8+YhEO+6/XRs9Qgic
 rSCUoN8CMFmAIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsEAAoJED7VnySO
 Rox/ZGcL/jA5FODKn9RCpwokepV9K5SIVETmAb5IRP10QK5my/2eoCeT5hG9qk9AyOTdnmyYNmU
 Lve+7E4uiqAdFO/yr/Vez8mCAV7QNlJGO2f5MeM6WuBhvC4mvfSjASM2oXxSfqerHQPxCiENC56
 jArooydk2oBUvysA/RJzMmzvmDPAYFDt/NHPWYR9y2HxPvxIoXG/N+1mza3tUE3O9gb0TqLKG1x
 72uPsZ0durnM/gKzD8Aw0yUH0//1EV1Dh5Nj8mU0676xStqL8V7QBEjGcbITG8+Gg8tr4s9NE28
 6thkPdsgaJmjyrZunuks1hTfuT4opCbHCodPVvia9XSHd/bWBrYZacbi95lhaLzL277KATC7eZn
 RHD6UFqhPA75jIUFkFmzeRzpxOMc7D5kSDQNqN7WA3e0yjta2D2Gk72BqT7uS5+nVxZvY1pUlDU
 Rj/4NYYA6xrZye0KqHHE/RZszZLWXTcu5gJpExVxJ11qt8MsPUU+herJqblVpqIibdIwnrmIDz6
 oU=
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 100 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5259cc7226..99deaac6db 100644
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
@@ -268,11 +277,13 @@ static void print_rejected_refs(const char *refname,
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
@@ -289,12 +300,20 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname,
-				   &new_oid, have_old ? &old_oid : NULL,
-				   NULL, NULL,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
+	tx_err = ref_transaction_update(transaction, refname,
+					&new_oid, have_old ? &old_oid : NULL,
+					NULL, NULL,
+					update_flags | create_reflog_flag,
+					msg, &err);
+
+	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
+	    opts->allow_update_failures) {
+		print_rejected_refs(refname, have_old ? &old_oid : NULL,
+				    &new_oid, NULL, NULL, tx_err, err.buf,
+				    NULL);
+	} else if (tx_err) {
 		die("%s", err.buf);
+	}
 
 	update_flags = default_flags;
 	free(refname);
@@ -302,9 +321,11 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
@@ -341,13 +362,21 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("symref-update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, NULL,
-				   have_old_oid ? &old_oid : NULL,
-				   new_target,
-				   have_old_oid ? NULL : old_target,
-				   update_flags | create_reflog_flag,
-				   msg, &err))
+	tx_err = ref_transaction_update(transaction, refname, NULL,
+					have_old_oid ? &old_oid : NULL,
+					new_target,
+					have_old_oid ? NULL : old_target,
+					update_flags | create_reflog_flag,
+					msg, &err);
+
+	if (tx_err && tx_err != REF_TRANSACTION_ERROR_GENERIC &&
+	    opts->allow_update_failures) {
+		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
+				    NULL, have_old_oid ? NULL : old_target,
+				    new_target, tx_err, err.buf, NULL);
+	} else if (tx_err) {
 		die("%s", err.buf);
+	}
 
 	update_flags = default_flags;
 	free(refname);
@@ -358,7 +387,8 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_create(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -387,9 +417,9 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
-
 static void parse_cmd_symref_create(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname, *new_target;
@@ -417,7 +447,8 @@ static void parse_cmd_symref_create(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_delete(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -450,9 +481,9 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
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
@@ -479,9 +510,9 @@ static void parse_cmd_symref_delete(struct ref_transaction *transaction,
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
@@ -508,7 +539,8 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -550,7 +582,8 @@ static void report_ok(const char *command)
 }
 
 static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
@@ -560,7 +593,8 @@ static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	if (*next != line_termination)
 		die("start: extra input: %s", next);
@@ -568,7 +602,8 @@ static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_prepare(struct ref_transaction *transaction,
-			      const char *next, const char *end UNUSED)
+			      const char *next, const char *end UNUSED,
+			      struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -579,7 +614,8 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_abort(struct ref_transaction *transaction,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -590,7 +626,8 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_commit(struct ref_transaction *transaction,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -618,7 +655,8 @@ enum update_refs_state {
 
 static const struct parse_cmd {
 	const char *prefix;
-	void (*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *,
+		   struct command_options *);
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
@@ -644,6 +682,10 @@ static void update_refs_stdin(unsigned int flags)
 	struct ref_transaction *transaction;
 	int i, j;
 
+	struct command_options opts = {
+		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
+	};
+
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 						  flags, &err);
 	if (!transaction)
@@ -721,7 +763,7 @@ static void update_refs_stdin(unsigned int flags)
 		}
 
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
-			input.buf + input.len);
+			input.buf + input.len, &opts);
 	}
 
 	switch (state) {

-- 
2.53.GIT

