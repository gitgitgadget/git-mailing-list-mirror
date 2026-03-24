Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844373B38AE
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389334; cv=none; b=mtfJG9/UaGLTGtBVYaXSdmFCCgQZ71dRbw+TJLbkhaK6x/2bb1ucYyoxOV75ayf6TZPS5hwkMSPfX8C63p4GAab3+vVvNlI3UxQlkqpi/XNzwdX5kq93zhxWYUVetypIpyQLuW1MJ5gdZQ8r23EFADcLUQ6u/oIMbwrKC/Dt79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389334; c=relaxed/simple;
	bh=uwL9sraSx0lxARtfKtcb52Gs8LwPY/kAftmaJwyW6Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hojqxG12v8AZlrHSHFOjZhgUk2NW1cLdUUFM3HuD4EMm7oyjyXkkaBjyu+r/bwgMux5zSNWGxHtB36CYBZC4ZigHAXRYdSB7VG110Cb7EhquWzTHbTIQWxiIzA+tq7/O4y5mUzNKnZkltjG/3l4ZxSZ50ihuppgN0u7LDZag8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQF5IGK5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQF5IGK5"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d75ed779bfso1395360a34.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774389331; x=1774994131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gIRegRF0cmHSwWrY576V4500fTeeFjdvV8mXwrq2Hk=;
        b=dQF5IGK507VidL2iIc/LNkk57TUzLa1JYYiVrIq6tBY2EEQ313jrxt5mt8+u20Q5jY
         qF3y1WR+vsgR1XbG/D6l74dT2blMmcFO43ghFF09Dn/hp18kMalv8tJlou3SlZHoHPxO
         xuF9VAJDJ0AewEdBeKgPln/5KBc1lDheOeCzEzilNOwZ1wEa+Wm4IU+FiXHwrPe7RW5Y
         lWQ7FoFqTGvaTgtACC9huq/zDgF10a7PkU6kxSqYv2i7f15gBd/GlYRo0LBvLUYxSDqB
         RU/LZRxAkhvywcOkuFHq7Bq0k1LHTZmYMlqHHyDAryhRA7Yot3pLOA5qdL9cHxulKgsf
         8qzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774389331; x=1774994131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gIRegRF0cmHSwWrY576V4500fTeeFjdvV8mXwrq2Hk=;
        b=h0CrDNkxbuYF7xTrGiwHVKrNbHp5MA+AQYvoqe9YF27BwYBsKLKXAb8t9vqa1wzbqT
         2zu9YQh38SSvEvkdgjplcijjYliGVqXdjnSKCGJVQYnq9UYppJafuslouDfewv+YxC/z
         nGqZqbe44Djwh6fW5qm7VjptoovQb+0eE9Eqp1FMkMHhyoKAEytCS3KzOHmKFLoCAdSj
         DxKBxAWp8EvjGuHGRw4BuDYQk89q470bChLK+xdzLiujri9+CF4h5xgZe2y/6/BZLGIl
         hTdmcfLsTdgSspGLv0K7z52KAcZAzvZZWPKFzsv+2AACDgXxRqksWIArNv6bfpCHwbRu
         VxQQ==
X-Gm-Message-State: AOJu0Yy4t9mT167YDZAaZwkNXcR5HDAY0BvX/iUw7DaFCakrFY/+F6iK
	jrAS9ptrWPvKooJ+BD9DgCo6uxE8wJ+XKShgwcFHg8tb5fy0o5a6wIXVJAJqBQ==
X-Gm-Gg: ATEYQzzgxEXEPE9KJDM/8kuWFdh0bN4iDs7uPi6sY9NCz5kQRViH5mnoknG3sipY7c8
	jMof/ngmgbfOgteb74h5kFck2WDxXx4UC4uGKKeZtofz3/zHGvfOsqj99CHDeccqM1RbrtrM9Cu
	jsG1j2FQ0lolqdB4ylDNDR8FxGNhDuVHeC3xmDcMlmY2S1v5yokFzY0fXXA29H6V1IuFt9MANpx
	5xDfBiNuMqPKNtKsGLF0ufx0ApI6pm7v7A4AHG4FxEbwyn8ulufUEKRBAlV09uc5Xn3q5yx31CM
	bo5nh4iNzgoZttfxXme7aFNlqTXFbbbe+Sl53lPfZ+nPYJF1JZjveETdT4/evZA3hPczXbnuhIB
	kpBww5ICDE7kzf9dxy4JxiozxSLixYprX/SEYEMj1wTqSq+FVSlRNVS0RPRecKe8Xvv2ytwLZ4F
	0PqPCLE7nXVBg4uNTRE1KZln1uXPWne0c=
X-Received: by 2002:a05:6820:4df8:b0:67c:3ebf:3e82 with SMTP id 006d021491bc7-67dff37c86amr806436eaf.6.1774389330794;
        Tue, 24 Mar 2026 14:55:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c149103b0sm12391697fac.5.2026.03.24.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 14:55:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/4] fast-import: add 'abort-if-invalid' mode to '--signed-commits=<mode>'
Date: Tue, 24 Mar 2026 16:55:10 -0500
Message-ID: <20260324215513.764739-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260324215513.764739-1-jltobler@gmail.com>
References: <20260324215513.764739-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '--signed-commits=<mode>' option for git-fast-import(1) configures
how signed commits are handled when encountered. In cases where an
invalid commit signature is encountered, a user may wish to abort the
operation entirely. Introduce an 'abort-if-invalid' mode to do so.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-fast-import.adoc |  2 ++
 builtin/fast-export.c              |  6 ++++++
 builtin/fast-import.c              | 10 +++++++++-
 gpg-interface.c                    |  2 ++
 gpg-interface.h                    |  1 +
 t/t9305-fast-import-signatures.sh  | 10 +++++++++-
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
index b3f42d4637..288f2b2a7e 100644
--- a/Documentation/git-fast-import.adoc
+++ b/Documentation/git-fast-import.adoc
@@ -90,6 +90,8 @@ already trusted to run their own code.
   commit signatures and replaces invalid signatures with newly created ones.
   Valid signatures are left unchanged. If `<keyid>` is provided, that key is
   used for signing; otherwise the configured default signing key is used.
+* `abort-if-invalid` will make this program die when encountering a signed
+  commit that is unable to be verified.
 
 Options for Frontends
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 13621b0d6a..dcbc5bc82d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -822,6 +822,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			die(_("encountered signed commit %s; use "
 			      "--signed-commits=<mode> to handle it"),
 			    oid_to_hex(&commit->object.oid));
+		case SIGN_ABORT_IF_INVALID:
+			die(_("'abort-if-invalid' is not a valid mode for "
+			      "git fast-export with --signed-commits=<mode>"));
 		case SIGN_STRIP_IF_INVALID:
 			die(_("'strip-if-invalid' is not a valid mode for "
 			      "git fast-export with --signed-commits=<mode>"));
@@ -970,6 +973,9 @@ static void handle_tag(const char *name, struct tag *tag)
 				die(_("encountered signed tag %s; use "
 				      "--signed-tags=<mode> to handle it"),
 				    oid_to_hex(&tag->object.oid));
+			case SIGN_ABORT_IF_INVALID:
+				die(_("'abort-if-invalid' is not a valid mode for "
+				      "git fast-export with --signed-tags=<mode>"));
 			case SIGN_STRIP_IF_INVALID:
 				die(_("'strip-if-invalid' is not a valid mode for "
 				      "git fast-export with --signed-tags=<mode>"));
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9fc6c35b74..08ea27242d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2892,6 +2892,9 @@ static void handle_signature_if_invalid(struct strbuf *new_data,
 	ret = verify_commit_buffer(tmp_buf.buf, tmp_buf.len, &signature_check);
 
 	if (ret) {
+		if (mode == SIGN_ABORT_IF_INVALID)
+			die(_("aborting due to invalid signature"));
+
 		warn_invalid_signature(&signature_check, msg->buf, mode);
 
 		if (mode == SIGN_SIGN_IF_INVALID) {
@@ -2983,6 +2986,7 @@ static void parse_new_commit(const char *arg)
 		case SIGN_VERBATIM:
 		case SIGN_STRIP_IF_INVALID:
 		case SIGN_SIGN_IF_INVALID:
+		case SIGN_ABORT_IF_INVALID:
 			import_one_signature(&sig_sha1, &sig_sha256, v);
 			break;
 
@@ -3068,7 +3072,8 @@ static void parse_new_commit(const char *arg)
 			encoding);
 
 	if ((signed_commit_mode == SIGN_STRIP_IF_INVALID ||
-	     signed_commit_mode == SIGN_SIGN_IF_INVALID) &&
+	     signed_commit_mode == SIGN_SIGN_IF_INVALID ||
+	     signed_commit_mode == SIGN_ABORT_IF_INVALID) &&
 	    (sig_sha1.hash_algo || sig_sha256.hash_algo))
 		handle_signature_if_invalid(&new_data, &sig_sha1, &sig_sha256,
 					    &msg, signed_commit_mode);
@@ -3115,6 +3120,9 @@ static void handle_tag_signature(struct strbuf *msg, const char *name)
 	case SIGN_ABORT:
 		die(_("encountered signed tag; use "
 		      "--signed-tags=<mode> to handle it"));
+	case SIGN_ABORT_IF_INVALID:
+		die(_("'abort-if-invalid' is not a valid mode for "
+		      "git fast-import with --signed-tags=<mode>"));
 	case SIGN_STRIP_IF_INVALID:
 		die(_("'strip-if-invalid' is not a valid mode for "
 		      "git fast-import with --signed-tags=<mode>"));
diff --git a/gpg-interface.c b/gpg-interface.c
index d517425034..dafd5371fa 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1164,6 +1164,8 @@ int parse_sign_mode(const char *arg, enum sign_mode *mode, const char **keyid)
 		*mode = SIGN_WARN_STRIP;
 	} else if (!strcmp(arg, "strip")) {
 		*mode = SIGN_STRIP;
+	} else if (!strcmp(arg, "abort-if-invalid")) {
+		*mode = SIGN_ABORT_IF_INVALID;
 	} else if (!strcmp(arg, "strip-if-invalid")) {
 		*mode = SIGN_STRIP_IF_INVALID;
 	} else if (!strcmp(arg, "sign-if-invalid")) {
diff --git a/gpg-interface.h b/gpg-interface.h
index a365586ce1..3d95f5ec14 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -115,6 +115,7 @@ void print_signature_buffer(const struct signature_check *sigc,
 /* Modes for --signed-tags=<mode> and --signed-commits=<mode> options. */
 enum sign_mode {
 	SIGN_ABORT,
+	SIGN_ABORT_IF_INVALID,
 	SIGN_WARN_VERBATIM,
 	SIGN_VERBATIM,
 	SIGN_WARN_STRIP,
diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
index 18707b3f6c..5667693afd 100755
--- a/t/t9305-fast-import-signatures.sh
+++ b/t/t9305-fast-import-signatures.sh
@@ -103,7 +103,7 @@ test_expect_success RUST,GPG 'strip both OpenPGP signatures with --signed-commit
 	test_line_count = 2 out
 '
 
-for mode in strip-if-invalid sign-if-invalid
+for mode in strip-if-invalid sign-if-invalid abort-if-invalid
 do
 	test_expect_success GPG "import commit with no signature with --signed-commits=$mode" '
 		git fast-export main >output &&
@@ -135,6 +135,14 @@ do
 		# corresponding `data <length>` command would have to be changed too.
 		sed "s/OpenPGP signed commit/OpenPGP forged commit/" output >modified &&
 
+		if test "$mode" = abort-if-invalid
+		then
+			test_must_fail git -C new fast-import --quiet \
+				--signed-commits=$mode <modified >log 2>&1 &&
+			test_grep "aborting due to invalid signature" log &&
+			return 0
+		fi &&
+
 		git -C new fast-import --quiet --signed-commits=$mode <modified >log 2>&1 &&
 
 		IMPORTED=$(git -C new rev-parse --verify refs/heads/openpgp-signing) &&
-- 
2.53.0.381.g628a66ccf6

