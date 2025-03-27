Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF674A21
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074022; cv=none; b=MVM5EdGIQd8+vZGaQEOlD+wZyvfP0G8yYmez2GXs2dbjlvYaeI6cNVwNAns51yTJX+09ilYTZKDX6C7HJn7ztC752pTLOJECgDQQnHCxG4Amw0SvWFt25WW8A5k98Er8WRwaqffFcEm1bNEjM4KelrQD8pU6t6tqXHq/53PUtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074022; c=relaxed/simple;
	bh=szjbLqjw32RGvYb7vtUVNNfRFqMWAmuw/WfxG8MyJMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VnDUofopFuv4khjR0el+139j4qIx0kvu7LgBYgmVvqw6TX9Rzuje+PP0k5epSiliq5IyViPgtivVqX5c8UR09yB8K54qp5Jz0r9RvagIPq9ArWHU6KF77IvMj3qflg210XGSIuf3EUFGbeZ9T0+rQOSzwE51hepSE2b+urLpT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcVPjzVE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcVPjzVE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac25d2b2354so150833866b.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074019; x=1743678819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFzTajtQsgLNk7Z5byanF/Gb2nZIjRODNPoFnrUV86Y=;
        b=BcVPjzVEPgEiWQt7TjfBjGJLX45wtAoKZhZ3DPiYMKivsS7D/kCSLoh3RwDEo3lQ3Z
         pGWud9PuDyOSmJyGBTzOCyX45Qrey3m6KhgSrHt5J5h6bcpqcBgzCrBnmnc0mbmp4MvZ
         ebtVCu2VlphW2CFMThsTkEn3f4gFeN1Ok8PJyiW/+Pe293n7Fw5/4FU/KySCj0MGg3gC
         xjPj55BH7WgAL4WS8RhaAHveC3BUDTDZ6yLCOFYRfHp0Rq7mLcY7p6LvdGUIt8Hwf0+E
         ZBJMqZzNejpDRLGBCyVhB30xcKKV+PpQx4gZ6wH9B2Re4aQQG4Ni6zuQpbrIbCJRPiWj
         ZiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074019; x=1743678819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFzTajtQsgLNk7Z5byanF/Gb2nZIjRODNPoFnrUV86Y=;
        b=YkfOW8eKD4AALRRbQjmIkvwczCvN5Z4vVdgzxNrXTYIh0qismt/jsxo4TtZUemUm/E
         v7cHaPeRScZsur44L4xjKF/CmmukZnaINikWbAg6BB+LKTA404gb5diYk4C0Cp3u8Gpp
         gThoXFqCawQcekUeBtIOEK7OeHKbwd4YRCa4LaPOgPH2xRB5rs49SjujCa0mbhH03D/Y
         KxhW8LUY/IotDdkiE0F2yhEhKgAxPxmPKvPNkln/0SZKBF3p2v80Vr0U6LEK+KXg994F
         iIW62b5Z0ZLODoJMZtTeYJMjdMm1npDuNumfZ2nRsTa3v0SlnK9pnqQUueyhu1cNIBKe
         u6Xw==
X-Gm-Message-State: AOJu0Yy/2oGISTWjqJlzxtWAreOGAOWw2EdveVVGqAYEjipACFDs9abb
	zOyPLzu73P8ovQbq2DmNqybk9qV7ekfE3GFOVtC0VBrt7YraqeUl
X-Gm-Gg: ASbGncvrzK0kyy+P+v9nugaMSJZ5SxiSeP/OmhZpbY4d5iEROP1catc8F0F+xa/yDQG
	KK9RwdcaO7skntkHENByc7cR2yYZLLemA4NCyOhWivOOoo2Ciy/cKeUVFbmGuNfPiYpITlsDJyZ
	Ws0RJKaiJFw43o3mqe2io1wy2geFuLNJTsMP/z0fV2hE+2ZFxD3c2LzAIg0slWiajfxBRyJ3kWP
	E9J1px+GdWEPexW24kaYZW4m2bN0t8hdMWx2kfXwz3V28ywACFhyoQ/8dYcCFsPoqemHjMIns0d
	+gT7J2ORCaWSFAEkij3s95aHSfSlZZh9ioj22QGGsAiJm28=
X-Google-Smtp-Source: AGHT+IFbVS7y8Lf3xjWBAFOhFbB7mWUKBdMXn0ffE3sFfcnebujaB3DBdhdFBLByRuU5hJpqH/KirQ==
X-Received: by 2002:a17:906:3c0f:b0:ac7:1507:7fa with SMTP id a640c23a62f3a-ac71507082bmr2831066b.35.1743074018539;
        Thu, 27 Mar 2025 04:13:38 -0700 (PDT)
Received: from [127.0.0.2] ([80.242.170.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e56dsm1195866866b.37.2025.03.27.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:13:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 27 Mar 2025 12:13:32 +0100
Subject: [PATCH v5 8/8] update-ref: add --batch-updates flag for stdin mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-245-partially-atomic-ref-updates-v5-8-4db2a3e34404@gmail.com>
References: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
In-Reply-To: <20250327-245-partially-atomic-ref-updates-v5-0-4db2a3e34404@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, phillip.wood123@gmail.com, gitster@pobox.com, 
 ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=16335;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=szjbLqjw32RGvYb7vtUVNNfRFqMWAmuw/WfxG8MyJMc=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGflMtnv/8d7Iu7zWZUva2w1YTSbUiqLrBNb9
 wVqMdthBt41RokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5TLZAAoJED7VnySO
 Rox/7lUL/AnibPkZDmpkcBc/KzkXrFV1wLG2gWZA0g+gy/ewDn4khT0g/M4+eqIcj1XBKdRI4l8
 Cq5yZ/W1DEtTnp7aLjjca4p17+PkFJBzOMiVmhwlzQyxIEESruIXSopToEixqVFNzA7iG5Hti0j
 2vdEaMmVn4bNbc5/+/16nbaTSFtunLnT/yjxgkw0rLLCrfcKRangYxRPct1RHWIO3f72aw303tS
 n8AoGWUC906LyoXympRpyjcyZXbNGoH695N99ex3558mhYiBy1PzrNoJ0oIaGrmAB6wU7COZWcS
 tbSBAfnwoEyA7wScosvV7wVAyvTLKnlP7yH8M9Mqsv8Ep2HOszzM3UYf9GhNjXsE+ZGoHooF3yC
 E4dRwT+D5JtlJqn6enjdIgZsTEBS5vzIZkmjenb8+18pZY0G9m1SQn0sljlZYzddhn0xwpMROkB
 X7H3UvIn0EA3PodhNHiKZ5t9WksVMXdpmHi98acARoLPwwFuOVNYT5gzkUrw82na/RrR6TdazD5
 fM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When updating multiple references through stdin, Git's update-ref
command normally aborts the entire transaction if any single update
fails. This atomic behavior prevents partial updates. Introduce a new
batch update system, where the updates the performed together similar
but individual updates are allowed to fail.

Add a new `--batch-updates` flag that allows the transaction to continue
even when individual reference updates fail. This flag can only be used
in `--stdin` mode and builds upon the batch update support added to the
refs subsystem in the previous commits. When enabled, failed updates are
reported in the following format:

  rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF

Update the documentation to reflect this change and also tests to cover
different scenarios where an update could be rejected.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.adoc |  14 ++-
 builtin/update-ref.c              |  66 ++++++++++-
 t/t1400-update-ref.sh             | 233 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
index 9e6935d38d..5be2c16776 100644
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
+               [-m <reason>] [--no-deref] --stdin [-z] [--batch-updates]
 
 DESCRIPTION
 -----------
@@ -57,6 +59,14 @@ performs all modifications together.  Specify commands of the form:
 With `--create-reflog`, update-ref will create a reflog for each ref
 even if one would not ordinarily be created.
 
+With `--batch-updates`, update-ref executes the updates in a batch but allows
+individual updates to fail due to invalid or incorrect user input, applying only
+the successful updates. However, system-related errors—such as I/O failures or
+memory issues—will result in a full failure of all batched updates. Any failed
+updates will be reported in the following format:
+
+	rejected SP (<old-oid> | <old-target>) SP (<new-oid> | <new-target>) SP <rejection-reason> LF
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1d541e13ad..111d6473ad 100644
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
+	N_("git update-ref [<options>] --stdin [-z] [--batch-updates]"),
 	NULL
 };
 
@@ -565,6 +566,49 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *reason = "";
+
+	switch (err) {
+	case REF_TRANSACTION_ERROR_NAME_CONFLICT:
+		reason = "refname conflict";
+		break;
+	case REF_TRANSACTION_ERROR_CREATE_EXISTS:
+		reason = "reference already exists";
+		break;
+	case REF_TRANSACTION_ERROR_NONEXISTENT_REF:
+		reason = "reference does not exist";
+		break;
+	case REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE:
+		reason = "incorrect old value provided";
+		break;
+	case REF_TRANSACTION_ERROR_INVALID_NEW_VALUE:
+		reason = "invalid new value provided";
+		break;
+	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
+		reason = "expected symref but found regular ref";
+		break;
+	default:
+		reason = "unkown failure";
+	}
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    reason);
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
+
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {
@@ -573,6 +617,10 @@ static void parse_cmd_commit(struct ref_transaction *transaction,
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
@@ -609,7 +657,7 @@ static const struct parse_cmd {
 	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
-static void update_refs_stdin(void)
+static void update_refs_stdin(unsigned int flags)
 {
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
@@ -617,7 +665,7 @@ static void update_refs_stdin(void)
 	int i, j;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  0, &err);
+						  flags, &err);
 	if (!transaction)
 		die("%s", err.buf);
 
@@ -685,7 +733,7 @@ static void update_refs_stdin(void)
 			 */
 			state = cmd->state;
 			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-								  0, &err);
+								  flags, &err);
 			if (!transaction)
 				die("%s", err.buf);
 
@@ -701,6 +749,8 @@ static void update_refs_stdin(void)
 		/* Commit by default if no transaction was requested. */
 		if (ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
+		ref_transaction_for_each_rejected_update(transaction,
+						 print_rejected_refs, NULL);
 		ref_transaction_free(transaction);
 		break;
 	case UPDATE_REFS_STARTED:
@@ -727,6 +777,8 @@ int cmd_update_ref(int argc,
 	struct object_id oid, oldoid;
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	int create_reflog = 0;
+	unsigned int flags = 0;
+
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -735,6 +787,8 @@ int cmd_update_ref(int argc,
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
 		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
+		OPT_BIT('0', "batch-updates", &flags, N_("batch reference updates"),
+			REF_TRANSACTION_ALLOW_FAILURE),
 		OPT_END(),
 	};
 
@@ -756,8 +810,10 @@ int cmd_update_ref(int argc,
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
-		update_refs_stdin();
+		update_refs_stdin(flags);
 		return 0;
+	} else if (flags & REF_TRANSACTION_ALLOW_FAILURE) {
+		die("--batch-updates can only be used with --stdin");
 	}
 
 	if (end_null)
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29045aad43..d29d23cb89 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2066,6 +2066,239 @@ do
 		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
 	'
 
+	test_expect_success "stdin $type batch-updates" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "update refs/heads/ref1" "$head" "$Z" >stdin &&
+			format_command $type "update refs/heads/ref2" "$head" "$Z" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin &&
+			echo $head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/ref2 >actual &&
+			test_cmp expect actual
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with invalid new_oid" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
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
+	test_expect_success "stdin $type batch-updates with non-commit new_oid" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
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
+	test_expect_success "stdin $type batch-updates with non-existent ref" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with dangling symref" '
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
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref1 >actual &&
+			test_cmp expect actual &&
+			echo $head >expect &&
+			test_must_fail git rev-parse refs/heads/ref2 &&
+			test_grep -q "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates with regular ref as symref" '
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
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
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
+	test_expect_success "stdin $type batch-updates with invalid old_oid" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
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
+	test_expect_success "stdin $type batch-updates with incorrect old oid" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
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
+	test_expect_success "stdin $type batch-updates refname conflict" '
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
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates refname conflict new ref" '
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
+			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			test_cmp expect actual &&
+			test_grep -q "refname conflict" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.48.1

