Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F963939BA
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679954; cv=none; b=pl/6fOrcLXYElDKiLIPO0NvnXyanprDfqPkpshXM1dR1fl6VG3kAzhdu5Lg2tnySVAxYF3gEw9UTuRdcjXDBTStHaZXSGtpT9MmrvkpxrFxmHzf4+uCyQy+m8zK8JGqOA+UYBSS9goCD/o/OK7wMZTk9ppWKCriUaSltLea3H2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679954; c=relaxed/simple;
	bh=jQAf3CvAgMuExRIJfnQ9zxsrBYd9f8695H9+OjXvdpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tf67KBcxA3PiEjI8jvPlozuehZS8AAzoVQ/FQp6l8k3BLF0q8ot901xX9iTKySdK+4KXlp6CdOynOjtkIxKQOgYma3Oa7AVBNwlf1reCH5yBMnFsbCpW1GSSmTjRFA2WS/MUezqM73ZK3pVeloWiA1jKCM/GUjC3OcUm+fzYf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+2HpdAe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+2HpdAe"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so1341813f8f.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679950; x=1777284750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qs595hglg0gtBy0ujj7Dw9/awkPQGq9U1xejEQyCC+k=;
        b=l+2HpdAeFOyjsNdHGOJS0nPVON5LV1W26VAYljXIp94xJU+rhWqljry7Sa9JvU7hRs
         4ghkdau10k1HAmH7ScgEO2HuL3Wl0vuiw04GeXXtQ4PJqhh54/rdnyxLWbBpA/60NXc6
         DPzI8tS/nyHM/L4oGZcRtC6k4P3m4UJ5hqIKiW0jTLhFWjvsucOZ/LVjneRzVj6fjykV
         H6KtbM2LZBKeYM7CB/I8posxfGH+XMpY6PJorTHcgLlWrWd3SdvbmfDYrmHza6ru/iJ/
         zoBEHso8rn00Io4aFJCd4TFEu6El1KibHkKLTfWcPTRZ78L6/iYXstNcFsP6r8y9A0sQ
         aoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679950; x=1777284750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qs595hglg0gtBy0ujj7Dw9/awkPQGq9U1xejEQyCC+k=;
        b=Zg/ounVzxhop/x+kZGjWhnxGqiiww0S1FQAqGkgQ2x3PuSiobxAW0Wc5hMk0LvLVoE
         Bv95/CseK1UDQZOE7lzzSFQrvdjY03ZFeqPpr6JpTqGlgGVe00Kx+IuoXDT46irQUf70
         1gMTGcfmT2yP+5CmZjzvbVr50zsrEDJBfFXp4drXNAGXOleq+GYg7wfc3FHD8M6e3RmZ
         hx4cbndY6nk6eoJSSBgFPEOaI/dwpSE/QtlNEUT43Dw9hZ2l4IjW4aHTshJY30VE8n/e
         37ObOmMPHCqiKtR23lRzNf5ImzcEdU9eXI6EP9XeRaZVk5tN4/fjWnGUD/qeI2g1W5E5
         lJbw==
X-Gm-Message-State: AOJu0Yx9sjgQY0fW+mVFc1yT8v2Wrtu+CG3z8+L7RNqKi/l8LbJ5RxzC
	XGrq51BDXiwxyGM7X/Dm++eAyGpS7O6jpXtrXHT/Bt37Vah9ouhNsY/epYCQJQ==
X-Gm-Gg: AeBDiet+uqbtJfbDAI77j17kaEGJ1aUFsXd5ZyyEaqL3L3PXHDU32hB9WlFAGkgFPw+
	s9O3KfekQXZObvoXnKdKvnH1QHsnPE663jyMyLdb6n9i4TvCp5TMfNaMkDZwZQWmDzuUW675lOu
	sOhEsXQIPWPNzFkSYlySRQycRhU0Advj6CyLVZzUYmauHGk76cpp4eoV/ypCOq7uqeaiLqkQGNb
	u9yVbNdcEPIiij78G6Iy0SkMAfCutzStsHXSEU+/CmGLTiwcaqgi42T4EXwklRChBZpgqyLN4uP
	Fb9KhV8rrYhW5WJkxLILVcBFvztHNtf2P9w4JBmjmQxEQZFOSsCrIZbDvaro+svrt7jVZby2scU
	eB/FQG7dvRe5XkoJ4ace40gslO727nXboO3UH5UT8otX9fXeA5glsQLc8W0GCYih/fYU02COTT3
	RjiFIk8hY5YH5t63Fl4wmzBZOphslyGfugI1M+jKm7Pi09CZtNtg==
X-Received: by 2002:a05:6000:4203:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43fe3dc5c80mr19398488f8f.18.1776679950155;
        Mon, 20 Apr 2026 03:12:30 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:03 +0200
Subject: [PATCH 5/8] update-ref: handle rejections while adding updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-5-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9604; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=jQAf3CvAgMuExRIJfnQ9zxsrBYd9f8695H9+OjXvdpQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl/ABrO2858PmV/qXYV1Q7hNm3dwKOYXNw3
 r0sLL0NkZDkE4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fwAAAoJED7VnySO
 Rox/nTEL/08Ilw+ZJh5/6F2XLUnr9KU3b6gqi8+Te1W7qr76LdmHzcBJPU7ILk+0kn2WpZMkaU5
 oGXmLIyOLfqrX84sSfL5EPc93cE3oWnsgoDX7n4/F0borVrGRJ9Y1m6H7g4ocTWiAuV6uj5Qguj
 LeGHpcLQXs9DBB3JgC89hnBXB1uyP9Cgl3UMIJVUSS0x+2CmsEscCPutYsztlhQ1N1fkQR0E6wn
 SkplqehRkJpRGmoNamGZO70almSiJ04R97eS1JfHZrLjV9Bv2XO9ALWaQZGhBn1YmzkxIprtyVU
 C8paALSRWu1vpEMiwvqjDyNMZWL9c3+f4HLWsVKR1SVChzWMBD+xM67alGQgPBrURFt+m0w6slX
 hyLMOLaNobC9xSPsx3Q6/XbqESKB07bPx701HAzsQ0ceDU9RGfANDQVFpD6L37EjvYE/MybaHt6
 HQ3mA4iwYlPUA8+3rHK8RPkTasVb5ZmhKNk9PzLKLKB1tufyzR/0+kUMUKFpo5eVSmpU7PRTaZ5
 CU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When using git-update-ref(1) with the '--batch-updates' flag, updates
rejected by the reference backend are displayed to the user while other
updates are applied. This only applies during the committing of the
transaction.

In the following commits, we'll also extend `ref_transaction_update()`
to reject updates before even a transaction is prepared/committed. In
preparation, modify the code in update-ref to also handle non-generic
rejections from `ref_transaction_update()`. This involves propagating
information to each of the commands on whether updates are allowed to be
rejected, and also checking for rejections and only dying for generic
failures.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 98 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 29 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5259cc7226..d1980c60c4 100644
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
@@ -289,11 +300,18 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
+	    opts->allow_update_failures)
+		print_rejected_refs(refname, have_old ? &old_oid : NULL,
+				    &new_oid, NULL, NULL, tx_err, err.buf,
+				    NULL);
+	else if (tx_err)
 		die("%s", err.buf);
 
 	update_flags = default_flags;
@@ -302,9 +320,11 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
@@ -341,12 +361,19 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
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
+	    opts->allow_update_failures)
+		print_rejected_refs(refname, have_old_oid ? &old_oid : NULL,
+				    NULL, have_old_oid ? NULL : old_target,
+				    new_target, tx_err, err.buf, NULL);
+	else if (tx_err)
 		die("%s", err.buf);
 
 	update_flags = default_flags;
@@ -358,7 +385,8 @@ static void parse_cmd_symref_update(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_create(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -387,9 +415,9 @@ static void parse_cmd_create(struct ref_transaction *transaction,
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
@@ -417,7 +445,8 @@ static void parse_cmd_symref_create(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_delete(struct ref_transaction *transaction,
-			     const char *next, const char *end)
+			     const char *next, const char *end,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
@@ -450,9 +479,9 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
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
@@ -479,9 +508,9 @@ static void parse_cmd_symref_delete(struct ref_transaction *transaction,
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
@@ -508,7 +537,8 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_symref_verify(struct ref_transaction *transaction,
-				    const char *next, const char *end UNUSED)
+				    const char *next, const char *end UNUSED,
+				    struct command_options *opts UNUSED)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id old_oid;
@@ -550,7 +580,8 @@ static void report_ok(const char *command)
 }
 
 static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	const char *rest;
 	if (skip_prefix(next, "no-deref", &rest) && *rest == line_termination)
@@ -560,7 +591,8 @@ static void parse_cmd_option(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	if (*next != line_termination)
 		die("start: extra input: %s", next);
@@ -568,7 +600,8 @@ static void parse_cmd_start(struct ref_transaction *transaction UNUSED,
 }
 
 static void parse_cmd_prepare(struct ref_transaction *transaction,
-			      const char *next, const char *end UNUSED)
+			      const char *next, const char *end UNUSED,
+			      struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -579,7 +612,8 @@ static void parse_cmd_prepare(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_abort(struct ref_transaction *transaction,
-			    const char *next, const char *end UNUSED)
+			    const char *next, const char *end UNUSED,
+			    struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -590,7 +624,8 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 }
 
 static void parse_cmd_commit(struct ref_transaction *transaction,
-			     const char *next, const char *end UNUSED)
+			     const char *next, const char *end UNUSED,
+			     struct command_options *opts UNUSED)
 {
 	struct strbuf error = STRBUF_INIT;
 	if (*next != line_termination)
@@ -618,7 +653,8 @@ enum update_refs_state {
 
 static const struct parse_cmd {
 	const char *prefix;
-	void (*fn)(struct ref_transaction *, const char *, const char *);
+	void (*fn)(struct ref_transaction *, const char *, const char *,
+		   struct command_options *);
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
@@ -644,6 +680,10 @@ static void update_refs_stdin(unsigned int flags)
 	struct ref_transaction *transaction;
 	int i, j;
 
+	struct command_options opts = {
+		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
+	};
+
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 						  flags, &err);
 	if (!transaction)
@@ -721,7 +761,7 @@ static void update_refs_stdin(unsigned int flags)
 		}
 
 		cmd->fn(transaction, input.buf + strlen(cmd->prefix) + !!cmd->args,
-			input.buf + input.len);
+			input.buf + input.len, &opts);
 	}
 
 	switch (state) {

-- 
2.53.GIT

