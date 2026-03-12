Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE137C919
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343358; cv=none; b=ZbHNcdAmzQqaG261svtGVgpJAxGDedDCm++zLVn1bymhiVmKe3A5t4XIN2QYa1WEXOM8Xw7HyGnw/eJaeYDPrmk+G4+gGMJH8Rws5vq9m1eo8mB97irc+8IkUYqGAY+hFa2zGozlyBgWCvH/OHDGsGSDzuJfXDeYVi7neNaIJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343358; c=relaxed/simple;
	bh=YHzAcPPp3m61tZL6xLOG6XxNfOzcmYrNrXy4D9gMAoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyN+xAq1Jp1YjRVYao8oW+W7KXG8Uqg768LL8cxZqgsJgt/Hqa/oXqKNHHUbtdTeRkZVX88eoWkyx+/V+Yd/iWzov5czn4VtfP5EX0ykfTuiAsVYdX0UhkQuT3ISRnzgsCbMCqet/bYsssxNucBApDVcG+3kS+B2hlD9zkYyNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca0zrc34; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca0zrc34"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4042fe53946so602070fac.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773343356; x=1773948156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqiVRqvdP2IQfdM0qYWQ3TUURE2flV75oct+Pw0Z3zQ=;
        b=Ca0zrc34qhopkYFoH9cNQuFmpwrwbNLGcY3DIoCDUwR97vogII1mKLtQ+tmRNSUiUM
         D3Uix0mtl5VWpDuiy1T/Sk6ktsJXt/Btk6Po02ksaXYKSic5TxkmMlGC2g10Tu1eRigt
         Zv+k/SXdJjCyH/QHvndIzQLHf/zWTeGO9AorHDT4R0LOHSpFUu2G9yeFPHf8L/UXsGzP
         ploKEev4lpPRDb/QJnPnFIRkrtbbOUhYrmWyTIgIK3DxIDpnArYS21uECmcV2ADK2tWa
         FKZpsz2Hbeq8NSZLYwgDK8L6m8kzTT0Wr8GeX+2dGq+gDh+gQGdxnD9QGneLKUQLTHOI
         +A3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773343356; x=1773948156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rqiVRqvdP2IQfdM0qYWQ3TUURE2flV75oct+Pw0Z3zQ=;
        b=MhFYwUCsqOnnVGLlw63k4tBfHr74v9OnyNJuyEXz8NoPdVm6bI4hlX2Xet0I+V242u
         2G0ty1a6dqRG55/DJdGHGxb3WEz4wSodWsIlFWmqPSU6kXUtowWtSllgKti0HzdUdoVL
         w0gdq7W2f26Z84eE0eNsnc1zBGoDan5C31eiIZV4Z677h9GNcfROc0W0jjpXKp3NXbTP
         ujJeMbuItNHAWIqOJifsVupK53BAmPMeyCzs6Oy+r41XeVXatPOCQJbG5U0WqzphQUVu
         PEaEAe3cYz7PMiIinQgbTdpQqrNIRCWPH80Dk7GlD9i9dcfNYBjdUgfQXPh1UVZcBAMj
         57Zg==
X-Gm-Message-State: AOJu0YxGMlg6eTRQvFLRdVqLcysOBsfUmr/qO8EEx6V7aOCBkH6xPPTG
	23mceNgdieEV6LE2Vx9vq8cL7WBaZMtyPudzyVvHAb+IZLnWPCoTkJGy/2tOfQ==
X-Gm-Gg: ATEYQzwcgmJOPkbo/VPPjsFwJlx8PW1Zq4pPtp4HV4wwv/WkIlisRm0jtfywmT5i5rQ
	e8OfzQ4OuLK4GBU6/0ijf/31aFjUdQBdhgtSN+Ir4cuvK3RDbc6RvHip/1stYzE3gR2xkdtR0Ib
	cXyXJOeUCu9IvUsJrrlPk6eToZwv15oqAxRhXAAKu2HSUzQfwFALOuPdX5SPuP7pM5f5wMb4g87
	qAD/JGoiPrW1JGXHKApaoQSLHxF7ymmDhJY+LHlo/acfuLRWFJJ5IUMcHyIk56qLy4Yka3gsIs/
	hgNKtGMiND4n2w7drhI//82PWiZIpANBtyDaWquURVYoCU/MkFimVx9gRtgu0MX0h5M7k/wochn
	u5OERkW7M9ZPmtfuomcANHVDgfB+cPBPJ7IaqrhByarPYSI+IvhkH5CaNop01feEQoRBLq0zVlL
	ZHd862vz+9RmY/zd4R1nXkO99oIwRXvK2G2ZcrUpakYQ==
X-Received: by 2002:a05:6870:3913:b0:404:1c81:596e with SMTP id 586e51a60fabf-417b91adb7fmr256293fac.12.1773343355675;
        Thu, 12 Mar 2026 12:22:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6e82cdsm6159987fac.18.2026.03.12.12.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:22:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 3/3] fast-import: add mode to sign commits with invalid signatures
Date: Thu, 12 Mar 2026 14:22:28 -0500
Message-ID: <20260312192228.481134-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260312192228.481134-1-jltobler@gmail.com>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With git-fast-import(1), handling of signed commits is controlled via
the `--signed-commits=<mode>` option. When an invalid signature is
encountered, a user may want the option to sign the commit again as
opposed to just stripping the signature. To facilitate this, introduce a
"sign-if-invalid" mode for the `--signed-commits` option. Optionally, a
key ID may be explicitly provided in the form
`sign-if-invalid[=<keyid>]` to specify which signing key should be used
when signing invalid commit signatures.

Note that to properly support interoperability mode when signing commit
signatures, the commit buffer must be created in both the repository and
compatability object formats to generate the appropriate signatures
accordingly. As currently implemented, the commit buffer for the
compatability object format is not reconstructed and thus signing
commits in interoperability mode is not yet supported. Support may be
added in the future.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |   4 +
 builtin/fast-export.c              |   8 +-
 builtin/fast-import.c              | 101 ++++++++++++++++-----
 gpg-interface.c                    |  23 +++--
 gpg-interface.h                    |   7 +-
 t/t9305-fast-import-signatures.sh  | 140 ++++++++++++++++++-----------
 6 files changed, 200 insertions(+), 83 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index 479c4081da..b3f42d4637 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -86,6 +86,10 @@ already trusted to run their own code.
 * `strip-if-invalid` will check signatures and, if they are invalid,
   will strip them and display a warning. The validation is performed
   in the same way as linkgit:git-verify-commit[1] does it.
+* `sign-if-invalid[=<keyid>]`, similar to `strip-if-invalid`, verifies
+  commit signatures and replaces invalid signatures with newly created ones.
+  Valid signatures are left unchanged. If `<keyid>` is provided, that key is
+  used for signing; otherwise the configured default signing key is used.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0c5d2386d8..13621b0d6a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -64,7 +64,7 @@ static int parse_opt_sign_mode(const struct option *opt,
 	if (unset)
 		return 0;
 
-	if (parse_sign_mode(arg, val))
+	if (parse_sign_mode(arg, val, NULL))
 		return error(_("unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
@@ -825,6 +825,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		case SIGN_STRIP_IF_INVALID:
 			die(_("'strip-if-invalid' is not a valid mode for "
 			      "git fast-export with --signed-commits=<mode>"));
+		case SIGN_SIGN_IF_INVALID:
+			die(_("'sign-if-invalid' is not a valid mode for "
+			      "git fast-export with --signed-commits=<mode>"));
 		default:
 			BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 		}
@@ -970,6 +973,9 @@ static void handle_tag(const char *name, struct tag *tag)
 			case SIGN_STRIP_IF_INVALID:
 				die(_("'strip-if-invalid' is not a valid mode for "
 				      "git fast-export with --signed-tags=<mode>"));
+			case SIGN_SIGN_IF_INVALID:
+				die(_("'sign-if-invalid' is not a valid mode for "
+				      "git fast-export with --signed-tags=<mode>"));
 			default:
 				BUG("invalid signed_commit_mode value %d", signed_commit_mode);
 			}
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b8a7757cfd..50de88e2ea 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -190,6 +190,7 @@ static const char *global_prefix;
 
 static enum sign_mode signed_tag_mode = SIGN_VERBATIM;
 static enum sign_mode signed_commit_mode = SIGN_VERBATIM;
+static const char *signed_commit_keyid;
 
 /* Memory pools */
 static struct mem_pool fi_mem_pool = {
@@ -2836,26 +2837,15 @@ static void finalize_commit_buffer(struct strbuf *new_data,
 	strbuf_addbuf(new_data, msg);
 }
 
-static void handle_strip_if_invalid(struct strbuf *new_data,
-				    struct signature_data *sig_sha1,
-				    struct signature_data *sig_sha256,
-				    struct strbuf *msg)
+static void warn_invalid_signature(struct signature_check *check,
+				   const char *msg, enum sign_mode mode)
 {
-	struct strbuf tmp_buf = STRBUF_INIT;
-	struct signature_check signature_check = { 0 };
-	int ret;
-
-	/* Check signature in a temporary commit buffer */
-	strbuf_addbuf(&tmp_buf, new_data);
-	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
-	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
-
-	if (ret) {
-		const char *signer = signature_check.signer ?
-			signature_check.signer : _("unknown");
-		const char *subject;
-		int subject_len = find_commit_subject(msg->buf, &subject);
+	const char *signer = check->signer ? check->signer : _("unknown");
+	const char *subject;
+	int subject_len = find_commit_subject(msg, &subject);
 
+	switch (mode) {
+	case SIGN_STRIP_IF_INVALID:
 		if (subject_len > 100)
 			warning(_("stripping invalid signature for commit '%.100s...'\n"
 				  "  allegedly by %s"), subject, signer);
@@ -2865,6 +2855,67 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
 		else
 			warning(_("stripping invalid signature for commit\n"
 				  "  allegedly by %s"), signer);
+		break;
+	case SIGN_SIGN_IF_INVALID:
+		if (subject_len > 100)
+			warning(_("signing commit with invalid signature for '%.100s...'\n"
+				  "  allegedly by %s"), subject, signer);
+		else if (subject_len > 0)
+			warning(_("signing commit with invalid signature for '%.*s'\n"
+				  "  allegedly by %s"), subject_len, subject, signer);
+		else
+			warning(_("signing commit with invalid signature\n"
+				  "  allegedly by %s"), signer);
+		break;
+	default:
+		BUG("unsupported signing mode");
+	}
+}
+
+static void handle_signature_if_invalid(struct strbuf *new_data,
+					struct signature_data *sig_sha1,
+					struct signature_data *sig_sha256,
+					struct strbuf *msg,
+					enum sign_mode mode)
+{
+	struct strbuf tmp_buf = STRBUF_INIT;
+	struct signature_check signature_check = { 0 };
+	int ret;
+
+	/* Check signature in a temporary commit buffer */
+	strbuf_addbuf(&tmp_buf, new_data);
+	finalize_commit_buffer(&tmp_buf, sig_sha1, sig_sha256, msg);
+	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
+
+	if (ret) {
+		warn_invalid_signature(&signature_check, msg->buf, mode);
+
+		if (mode == SIGN_SIGN_IF_INVALID) {
+			struct strbuf signature = STRBUF_INIT;
+			struct strbuf payload = STRBUF_INIT;
+
+			/*
+			 * NEEDSWORK: To properly support interoperability mode
+			 * when signing commit signatures, the commit buffer
+			 * must be provided in both the repository and
+			 * compatibility object formats. As currently
+			 * implemented, only the repository object format is
+			 * considered meaning compatibility signatures cannot be
+			 * generated. Thus, attempting to sign commit signatures
+			 * in interoperability mode is currently unsupported.
+			 */
+			if (the_repository->compat_hash_algo)
+				die(_("signing commits in interoperability mode is unsupported"));
+
+			strbuf_addstr(&payload, signature_check.payload);
+			if (sign_buffer(&payload, &signature, signed_commit_keyid,
+					SIGN_BUFFER_USE_DEFAULT_KEY))
+				die(_("failed to sign commit object"));
+			add_header_signature(new_data, &signature, the_hash_algo);
+
+			strbuf_release(&signature);
+			strbuf_release(&payload);
+		}
 
 		finalize_commit_buffer(new_data, NULL, NULL, msg);
 	} else {
@@ -2927,6 +2978,7 @@ static void parse_new_commit(const char *arg)
 			/* fallthru */
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
+		case SIGN_SIGN_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3011,9 +3063,11 @@ static void parse_new_commit(const char *arg)
 			"encoding %s\n",
 			encoding);
 
-	if (signed_commit_mode == SIGN_STRIP_IF_INVALID &&
+	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
+	     signed_commit_mode == SIGN_SIGN_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
-		handle_strip_if_invalid(&new_data, &sig_sha1, &sig_sha256, &msg);
+		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
+					    &msg, signed_commit_mode);
 	else
 		finalize_commit_buffer(&new_data, &sig_sha1, &sig_sha256, &msg);
 
@@ -3060,6 +3114,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
+	case SIGN_SIGN_IF_INVALID:
+		die(_("'sign-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	default:
 		BUG("invalid signed_tag_mode value %d from tag '%s'",
 		    signed_tag_mode, name);
@@ -3649,10 +3706,10 @@ static int parse_one_option(const char *option)
 	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
 		option_export_pack_edges(option);
 	} else if (skip_prefix(option, "signed-commits=", &option)) {
-		if (parse_sign_mode(option, &signed_commit_mode))
+		if (parse_sign_mode(option, &signed_commit_mode, &signed_commit_keyid))
 			usagef(_("unknown --signed-commits mode '%s'"), option);
 	} else if (skip_prefix(option, "signed-tags=", &option)) {
-		if (parse_sign_mode(option, &signed_tag_mode))
+		if (parse_sign_mode(option, &signed_tag_mode, NULL))
 			usagef(_("unknown --signed-tags mode '%s'"), option);
 	} else if (!strcmp(option, "quiet")) {
 		show_stats = 0;
diff --git a/gpg-interface.c b/gpg-interface.c
index ce935908cc..c26bd32120 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1151,21 +1151,28 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 	return ret;
 }
 
-int parse_sign_mode(const char *arg, enum sign_mode *mode)
+int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid)
 {
-	if (!strcmp(arg, "abort"))
+	if (!strcmp(arg, "abort")) {
 		*mode = SIGN_ABORT;
-	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
+	} else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore")) {
 		*mode = SIGN_VERBATIM;
-	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
+	} else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn")) {
 		*mode = SIGN_WARN_VERBATIM;
-	else if (!strcmp(arg, "warn-strip"))
+	} else if (!strcmp(arg, "warn-strip")) {
 		*mode = SIGN_WARN_STRIP;
-	else if (!strcmp(arg, "strip"))
+	} else if (!strcmp(arg, "strip")) {
 		*mode = SIGN_STRIP;
-	else if (!strcmp(arg, "strip-if-invalid"))
+	} else if (!strcmp(arg, "strip-if-invalid")) {
 		*mode = SIGN_STRIP_IF_INVALID;
-	else
+	} else if (!strcmp(arg, "sign-if-invalid")) {
+		*mode = SIGN_SIGN_IF_INVALID;
+	} else if (skip_prefix(arg, "sign-if-invalid=", &arg)) {
+		*mode = SIGN_SIGN_IF_INVALID;
+		if (keyid)
+			*keyid = arg;
+	} else {
 		return -1;
+	}
 	return 0;
 }
diff --git a/gpg-interface.h b/gpg-interface.h
index 37f3ac42db..a365586ce1 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -120,12 +120,15 @@ enum sign_mode {
 	SIGN_WARN_STRIP,
 	SIGN_STRIP,
 	SIGN_STRIP_IF_INVALID,
+	SIGN_SIGN_IF_INVALID,
 };
 
 /*
  * Return 0 if `arg` can be parsed into an `enum sign_mode`. Return -1
- * otherwise.
+ * otherwise. If the parsed mode is SIGN_SIGN_IF_INVALID and GPG key provided in
+ * the arguments in the form `sign-if-invalid=<keyid>`, the key-ID is parsed
+ * into `char **keyid`.
  */
-int parse_sign_mode(const char *arg, enum sign_mode *mode);
+int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid);
 
 #endif
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index 022dae02e4..38b3e3b537 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -103,26 +103,85 @@ test_expect_success GPG 'strip both OpenPGP signatures with --signed-commits=war
 	test_line_count = 2 out
 '
 
-test_expect_success GPG 'import commit with no signature with --signed-commits=strip-if-invalid' '
-	git fast-export main >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	test_must_be_empty log
-'
-
-test_expect_success GPG 'keep valid OpenPGP signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	git fast-export --signed-commits=verbatim openpgp-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
-	test $OPENPGP_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
-'
-
-test_expect_success GPG 'strip signature invalidated by message change with --signed-commits=strip-if-invalid' '
+for mode in strip-if-invalid sign-if-invalid
+do
+	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
+		git fast-export main >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "keep valid OpenPGP signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim openpgp-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+		test $OPENPGP_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPG "handle signature invalidated by message change with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim openpgp-signing >output &&
+
+		# Change the commit message, which invalidates the signature.
+		# The commit message length should not change though, otherwise the
+		# corresponding `data <length>` command would have to be changed too.
+		sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
+
+		git -C new fast-import --quiet --signed-commits=$mode <modified >log 2>&1 &&
+
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
+		test $OPENPGP_SIGNING != $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+
+		if test "$mode" = strip-if-invalid
+		then
+			test_grep "stripping invalid signature" log &&
+			test_grep ! -E "^gpgsig" actual
+		else
+			test_grep "signing commit with invalid signature" log &&
+			test_grep -E "^gpgsig(-sha256)? " actual &&
+			git -C new verify-commit "$IMPORTED"
+		fi
+	'
+
+	test_expect_success GPGSM "keep valid X.509 signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		git fast-export --signed-commits=verbatim x509-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
+		test $X509_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+
+	test_expect_success GPGSSH "keep valid SSH signature with --signed-commits=$mode" '
+		rm -rf new &&
+		git init new &&
+
+		test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+
+		git fast-export --signed-commits=verbatim ssh-signing >output &&
+		git -C new fast-import --quiet --signed-commits=$mode <output >log 2>&1 &&
+		IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
+		test $SSH_SIGNING = $IMPORTED &&
+		git -C new cat-file commit "$IMPORTED" >actual &&
+		test_grep -E "^gpgsig(-sha256)? " actual &&
+		test_must_be_empty log
+	'
+done
+
+test_expect_success GPGSSH "sign invalid commit with explicit keyid" '
 	rm -rf new &&
 	git init new &&
 
@@ -133,41 +192,22 @@ test_expect_success GPG 'strip signature invalidated by message change with --si
 	# corresponding `data <length>` command would have to be changed too.
 	sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
 
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <modified >log 2>&1 &&
+	# Configure the target repository with an invalid default signing key.
+	test_config -C new user.signingkey "not-a-real-key-id" &&
+	test_config -C new gpg.format ssh &&
+	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	test_must_fail git -C new fast-import --quiet \
+		--signed-commits=sign-if-invalid <modified >/dev/null 2>&1 &&
+
+	# Import using explicitly provided signing key.
+	git -C new fast-import --quiet \
+		--signed-commits=sign-if-invalid="${GPGSSH_KEY_PRIMARY}" <modified &&
 
 	IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
 	test $OPENPGP_SIGNING != $IMPORTED &&
 	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep ! -E "^gpgsig" actual &&
-	test_grep "stripping invalid signature" log
-'
-
-test_expect_success GPGSM 'keep valid X.509 signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	git fast-export --signed-commits=verbatim x509-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/x509-signing) &&
-	test $X509_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
 	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
-'
-
-test_expect_success GPGSSH 'keep valid SSH signature with --signed-commits=strip-if-invalid' '
-	rm -rf new &&
-	git init new &&
-
-	test_config -C new gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
-
-	git fast-export --signed-commits=verbatim ssh-signing >output &&
-	git -C new fast-import --quiet --signed-commits=strip-if-invalid <output >log 2>&1 &&
-	IMPORTED=$(git -C new rev-parse --verify refs/heads/ssh-signing) &&
-	test $SSH_SIGNING = $IMPORTED &&
-	git -C new cat-file commit "$IMPORTED" >actual &&
-	test_grep -E "^gpgsig(-sha256)? " actual &&
-	test_must_be_empty log
+	git -C new verify-commit "$IMPORTED"
 '
 
 test_done
-- 
2.53.0.381.g628a66ccf6

