Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8F26138B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475778; cv=none; b=lkqfyohhVCs2POi+iZJGjyOn/uUC7pLdhaHZ/+oAYVk7Ku2hUUGXAy671Xk1uAadSFr7wfW9ETRyxWKfFDhJx0OBpZ1Z3+puHEMM2e3ugoRWm39TEVVNnO5ICnS/OsVaVBI/IQoxszIlZSW3VZ0tckGkx+DfVLfUif1aUweMbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475778; c=relaxed/simple;
	bh=8DbvIz+xlplD0bMqAPtwSi/hN7Ypw5V6eFdyNROASwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EkUAsC9UN91q0nwDNV0rJM5iF4oZPbZuEozwdOsgXk0ozNw26PWV8TcnJpJj2Fg+lZPuk3no1ettu5nLeI/j70L9+JPjqskIURmlf1K8emXhbnCPR46laQXMqJx1if4MF7u5tLjnCPbP17Si5piPs7r4CFahXk/paviUvwfKRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8G1aafR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8G1aafR"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb90f68f8cso1020620866b.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475774; x=1741080574; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgSrTdaz4gftXbxTgwJhGaBvYrJrXe1Id6S7ComH2B4=;
        b=j8G1aafRLD3onrAVtNgSPKBNAiu0E0k4g71HW7SoGOEuhV6bw3mTh3JAD8qRE8VAeq
         TZo1KtBvO6dkEfMyINOzMX3m7MikWBYsNSRyhXWLU5DiKu/emXRLkZWrPY3nazXoPvN/
         seNqcryBbLW2d0sk4IIkSuF1nIXyuRBcMvWxpRICv7IGxgf/pHnYttCmSsqwHTWbH1PD
         boWMGSVcgSk0lpsiOXrAK/TFdU6zJBCJ/d3PdJaDe6p5LD/kFoepwBISqQWJsF+LVZLw
         R0H0pugpykALEJH8APMsXF7bXFPZ3Nnk5j12s2GoEtYy0MfQ/2Lkrjk00a+4+YGmYFqV
         He3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475774; x=1741080574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgSrTdaz4gftXbxTgwJhGaBvYrJrXe1Id6S7ComH2B4=;
        b=pAGPvtYlRQxUrH3AEqVrjcWCgHWD2xa+g/LwOjPkBiMNALyLh8r8zgPHjjfqg4/drz
         LYOeUxqyiaGi2vtTYvVjxLU0fGR7grr6Y1d+4zEGIlJrUkZYdRDdlbUdiEpQPT+NgKaf
         c0Gk2ZOh081M5gayBw9XHCPk8Mn1WkDDIDQjx66J9I46SVWnzD1gEXdVTsRXMAP8Jqvo
         cCy2DrJwxOYEu+FOn9fGZDdmQK6G9piEjs2vc9Dqb/MR0dhu0a6OdEJv/ZuMdVyXQryR
         qyUT2Zt67xN4eQT1I76tSdZJmN2G6l5iinyTpzS0FL1UpHUXBeE4+VbgrLC8rljNHl6g
         Zv4Q==
X-Gm-Message-State: AOJu0YyArcaPQHEOQXAFGFfXOxfdnzCC1moBwikqFITdkVr1i4keLDCk
	cwvC6ZlbTtix1PcMDDCEYDwn3gT3XrqWKZh4vFWvwVD8D8JjpRstrQXNXDVW
X-Gm-Gg: ASbGncsruAuEKefNxJ76OC1HDyMowcgWrDWliLKq0qLB5X4h54JPiq9ul0rnsyQw5fu
	JX9GhE1kmR3lIst11H+lGkT2yoaqRGWCTtBsEiPHKU4VE3auTK6VJ7zb8HiFfpg2Pr2/pvkRnFs
	CNRT4hXPttrTfsSsSH+TKYq8195p03+CwOgi17eHOAz4krbdpisjkFOFcMMzXal4r2xkOUOMMEP
	j6EkA4Fet8K9NBtr+GsM9/0vyEt2jICVXacnZzfi1Uj8ZmiojX3wSIF53tQSYRuJyhffC9oEGAg
	Ppm7J9u+hT7Wa9sm8PcwoHkRvkW4bj6R
X-Google-Smtp-Source: AGHT+IF4JWwlg+0HzyEymubYrW0BrokDFl4MUvKwEo8Jf/w6fJ9P2mUUPwZsJGr7ILGLq6nBybLRjg==
X-Received: by 2002:a17:907:7fa1:b0:abb:9c8a:fbcd with SMTP id a640c23a62f3a-abed107b0e2mr278945966b.53.1740475773997;
        Tue, 25 Feb 2025 01:29:33 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:33 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:10 +0100
Subject: [PATCH v2 7/7] update-ref: add --allow-partial flag for stdin mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-7-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16932;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=8DbvIz+xlplD0bMqAPtwSi/hN7Ypw5V6eFdyNROASwg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXamS5RqTqp7E5GhAIlPsn/QU+kvN2t2G
 2a1FU+JCrgTo4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY12AAoJED7VnySO
 Rox/V1AL/ivuCfrO21Vlcag6r5jpbZkc1r9PRRETO1FuyngQ7b4w7pDiAVhQwxjb7MleMBeXObz
 WDgqyFPYmPlfcb0VET8GPo9cdoaN27UxqbJmONQjd7qGFluupjYyw/v4I9dqPFrZCECJAwa7+tp
 jDurzyEcHczHDlIDsv8RHlR4JTyMaxWy08fbCQuba0NHA+ovVvyTkYrz4ty4Vs370Wp8CnFVcM2
 MzKbY+eve/Y4ryH0xkmmtyTX5UQi4DAFwWJ/bPZ9YlcCJ22QmZ+ww5TO+VeBTcwSLENgQIIBCX7
 b3wvuVcqQg5jl2h6antTzuzZd1Vcmz22vnP99P86fN4cQcufC82rtByr0k531tyjYeLISpAZ6hX
 s2hL0Xcs74o0pmfszOu0NyVbLNme6he+p38l86meWAf0s0w8scFk1AeLLv3JUM2y+A63ZR5voiA
 RYctJ8Ers+i+YRhGKI4IF5RLqQzLAhmwXKBI/u1HVv363qu9xPr60gUF1yCcpjt9JE53SMmIbb7
 fA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When updating multiple references through stdin, Git's update-ref
command normally aborts the entire transaction if any single update
fails. While this atomic behavior prevents partial updates by default,
there are cases where applying successful updates while reporting
failures is desirable.

Add a new `--allow-partial` flag that allows the transaction to continue
even when individual reference updates fail. This flag can only be used
in `--stdin` mode and builds upon the partial transaction support added
to the refs subsystem. When enabled, failed updates are reported in the
following format:

  rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF

or with `-z`:

  rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL

Update the documentation to reflect this change and also tests to cover
different scenarios where an update could be rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.adoc |  21 +++-
 builtin/update-ref.c              |  74 +++++++++++--
 t/t1400-update-ref.sh             | 216 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 302 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9e6935d38d..fc73f1d8aa 100644
--- a/Documentation/git-update-ref.adoc
+++ b/Documentation/git-update-ref.adoc
@@ -7,8 +7,10 @@ git-update-ref - Update the object name stored in a ref safely
 
 SYNOPSIS
 --------
-[verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<old-oid>] | [--create-reflog] <ref> <new-oid> [<old-oid>] | --stdin [-z])
+[synopsis]
+git update-ref [-m <reason>] [--no-deref] -d <ref> [<old-oid>]
+	       [-m <reason>] [--no-deref] [--create-reflog] <ref> <new-oid> [<old-oid>]
+               [-m <reason>] [--no-deref] --stdin [-z] [--allow-partial]
 
 DESCRIPTION
 -----------
@@ -57,6 +59,17 @@ performs all modifications together.  Specify commands of the form:
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
 
+With `--allow-partial`, update-ref continues executing the transaction even if
+some updates fail due to invalid or incorrect user input, applying only the
+successful updates. Errors resulting from user-provided input are treated as
+non-system-related and do not cause the entire transaction to be aborted.
+However, system-related errors—such as I/O failures or memory issues—will still
+result in a full failure. Additionally, errors like F/D conflicts are batched
+for performance optimization and will also cause a full failure. Any failed
+updates will be reported in the following format:
+
+	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
@@ -82,6 +95,10 @@ quoting:
 In this format, use 40 "0" to specify a zero value, and use the empty
 string to specify a missing value.
 
+With `-z`, `--allow-partial` will print rejections in the following form:
+
+	rejected NUL (<old-oid> | <old-target>) NUL (<new-oid> | <new-target>) NUL <rejection-reason> NUL
+
 In either format, values can be specified in any form that Git
 recognizes as an object name.  Commands in any other format or a
 repeated <ref> produce an error.  Command meanings are:
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1d541e13ad..b03b40eacb 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -5,6 +5,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hash.h"
+#include "hex.h"
 #include "refs.h"
 #include "object-name.h"
 #include "parse-options.h"
@@ -13,7 +14,7 @@
 static const char * const git_update_ref_usage[] = {
 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
 	N_("git update-ref [<options>]    <refname> <new-oid> [<old-oid>]"),
-	N_("git update-ref [<options>] --stdin [-z]"),
+	N_("git update-ref [<options>] --stdin [-z] [--allow-partial]"),
 	NULL
 };
 
@@ -565,6 +566,54 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum transaction_error err,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char space = ' ';
+	const char *reason = "";
+
+	switch (err) {
+	case TRANSACTION_NAME_CONFLICT:
+		reason = _("refname conflict");
+		break;
+	case TRANSACTION_CREATE_EXISTS:
+		reason = _("reference already exists");
+		break;
+	case TRANSACTION_NONEXISTENT_REF:
+		reason = _("reference does not exist");
+		break;
+	case TRANSACTION_INCORRECT_OLD_VALUE:
+		reason = _("incorrect old value provided");
+		break;
+	case TRANSACTION_INVALID_NEW_VALUE:
+		reason = _("invalid new value provided");
+		break;
+	case TRANSACTION_EXPECTED_SYMREF:
+		reason = _("expected symref but found regular ref");
+		break;
+	default:
+		reason = _("unkown failure");
+	}
+
+	if (!line_termination)
+		space = line_termination;
+
+	strbuf_addf(&sb, "rejected%c%s%c%s%c%c%s%c%s%c", space,
+		    refname, space, new_oid ? oid_to_hex(new_oid) : new_target,
+		    space, space, old_oid ? oid_to_hex(old_oid) : old_target,
+		    space, reason, line_termination);
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+	fflush(stdout);
+}
+
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {
@@ -573,6 +622,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
 		die("commit: extra input: %s", next);
 	if (ref_transaction_commit(transaction, &error))
 		die("commit: %s", error.buf);
+
+	ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
+
 	report_ok("commit");
 	ref_transaction_free(transaction);
 }
@@ -609,7 +662,7 @@ static const struct parse_cmd {
 	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(unsigned int flags)
 {
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
@@ -617,7 +670,7 @@ static void update_refs_stdin(void)
 	int i, j;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  0, &err);
+						  flags, &err);
 	if (!transaction)
 		die("%s", err.buf);
 
@@ -685,7 +738,7 @@ static void update_refs_stdin(void)
 			 */
 			state = cmd->state;
 			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-								  0, &err);
+								  flags, &err);
 			if (!transaction)
 				die("%s", err.buf);
 
@@ -701,6 +754,8 @@ static void update_refs_stdin(void)
 		/* Commit by default if no transaction was requested. */
 		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
+		ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
 		ref_transaction_free(transaction);
 		break;
 	case UPDATE_REFS_STARTED:
@@ -726,7 +781,9 @@ int cmd_update_ref(int argc,
 	const char *refname, *oldval;
 	struct object_id oid, oldoid;
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
-	int create_reflog = 0;
+	int create_reflog = 0, allow_partial = 0;
+	unsigned int flags = 0;
+
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -735,6 +792,8 @@ int cmd_update_ref(int argc,
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BIT('0', "allow-partial", &flags, N_("allow partial transactions"),
+			REF_TRANSACTION_ALLOW_PARTIAL),
 		OPT_END(),
 	};
 
@@ -756,9 +815,10 @@ int cmd_update_ref(int argc,
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(flags);
 		return 0;
-	}
+	} else if (allow_partial)
+		die("--allow-partial can only be used with --stdin");
 
 	if (end_null)
 		usage_with_options(git_update_ref_usage, options);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29045aad43..fb9442982e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2066,6 +2066,222 @@ do
 		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
+	test_expect_success "stdin $type allow-partial" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with invalid new_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "invalid new value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with non-commit new_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			head_tree=$(git rev-parse HEAD^{tree}) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "invalid new value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with non-existent ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with dangling symref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git symbolic-ref refs/heads/ref2 refs/heads/nonexistent &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with regular ref as symref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
+			git update-ref $type --no-deref --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "expected symref but found regular ref" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with invalid old_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference already exists" stdout
+		)
+	'
+
+	test_expect_success "stdin $type allow-partial with incorrect old oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref1 $head &&
+			git update-ref refs/heads/ref2 $head &&
+
+			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual &&
+			test_grep -q "incorrect old value provided" stdout
+		)
+	'
+
+	# F/D conflicts on the files backend are resolved on an individual
+	# update level since refs are stored as files. On the reftable backend
+	# this check is batched to optimize for performance, so failures cannot
+	# be isolated to a single update.
+	test_expect_success REFFILES "stdin $type allow-partial refname conflict" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+			git update-ref refs/heads/ref/foo $head &&
+
+			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
+			git update-ref $type --stdin --allow-partial <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.47.2

