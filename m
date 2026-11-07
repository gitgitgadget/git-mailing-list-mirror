Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052545;
	b=PMWQxnS6kRuhRJClD9Po0oMxcDLgQvr3Wmd43UsRUDjxHi/K4qXAQLwkpIPpFQGjLNum
	 qR9khpWtdyTJt7zihSt4w3cTrsp+02b+eJFSZZ20ib5id6W0tPH9/eRskAAOyYfqQLFVv
	 FE1eMUedRK3oteqkSWGFfkniKhAbwvqCY71kfVaNo5E30nPvlzjhhiYP4Z4v0saUN/xTr
	 JZJRT8xSw/e4rbf33ky3WnNI8tuXSiY8dckZQE1ZDJ+tIStLdSFa5qKVTOuttVOmpSdRs
	 Vdp0cWOVMidRi/JrKtQOT7XI/jKKcM7jzGOvPeXxw7s2E2ELRZN0iF4pIf7bGWXRfqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=M9MzoEbyJx9Jp4O4yD1ya6lVnYPFzPv5gqx8vNELxnQ=;
	b=bzNIDZV6vmAjPI8GMd84L3cXghKAaojtrLEvcjDZAuz4/pav556oeD7BZQ7CCOAhoSaE
	 dSRl+SCAX4LRHH+M0GC7secodVAp99rafWQLZZrh8IQVtH5755/jzgUg56XOdaEVyD2SC
	 wnQVY8Ll+wjNe0WvwppPtmhtaPDZBRkXCUb1CrkT6HaXzHDWwjhJykEnFvvOlWVsA2XWL
	 3r53spwAoQ1WpmDTYzSUao/yKLA2R1NtPWl6Hwd9ZKdiO8w4x5oopmQEVe+6DPM+bpEZH
	 2wdPpCQOLbJsL9iDE9BaMFnQ3JS6ti34FnNn5ubiG6cbApiALdL0MnNUGSAspKvD2pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbUyezjO;
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94345606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 11:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94345606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IbUyezjO
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-563a0462094so734291b6e.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794052543; x=1794657343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M9MzoEbyJx9Jp4O4yD1ya6lVnYPFzPv5gqx8vNELxnQ=;
        b=IbUyezjOD28/nXKxitGzDOgE+2d5d5NveaJgouVRVqD1TNlr1FNDgg9RvOh1UP5sUG
         9OnQSMguf5RwoWE25pTL5R45p/BeU7xN0UoCSQ6xgDR2BOAjdVRR21a9Vr67fcf4xkAj
         d/a94e2xRlVjypUsZSj3M5p0szzHFfM86Kz117U7FoRECe1Ozj9uorzVtPCWgGd7GMmp
         X+5YLjfHhd/bE6td6/JM99JuBlz5Fc4SO01Ee3bInFEu/IgZHQYKl5qxhLykz6DrXTXD
         LNRP6WoC6FdAMwOWMbk0wxQR/AYsyN527p4c39iYJEJ/ZoChqvqnXBzQ4snGKM36jZUg
         irlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794052543; x=1794657343;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9MzoEbyJx9Jp4O4yD1ya6lVnYPFzPv5gqx8vNELxnQ=;
        b=IOg7Cwr2DMnXcWElfzfuJWnYSja0vFvl8xIIQbJzIO6EXFKzrMGorIZvpd2LhbZVVZ
         QFZ3B+2PSEyPukenRG2eWI3bW+cQ5m2OLCRxU2RMDq0jx3bp7FNNGeCKcOKzRDrbSzEH
         9KFeO7K9a5wJwzISv0ybfEc7B3YWtb9e4KW54+jay9As1/HVRNuNeSAghtGDVPv14nuC
         bJW4YGUL1y2cOfErNb8+TbRHTufzvmJ30yL+PvG+XkY/6TazL5RbBe7RnxgRTvzn64qy
         VkEglaZm7+7PAvqQrZYMw7+fwf77WS87nDdy4SgTADUXcf5pJJ/LfydBRm+JjjSoqIO7
         30OA==
X-Gm-Message-State: APuU4Z/BrSDpShAAgG3HsdAuxD6zrjbmMjveVkkTs2wBuoBby+QcO7lT
	H/kw/GCGf0zWuQWEU6hkEM2CbK8lsj515tZCk7dazRp/SmxNgmZfzbjBts4/yw==
X-Gm-Gg: AYBFou3r2RPh+zbXdExEu3A0rFHHf4d/QrGxZQt5CtU1a2dmU0XXixgOO+XLPpzpL03
	ambne/9sYznwXgLBh2iSRAw6NQGg9C8kKrf2z2fadASEr2QH5pYVCgWIQefU+xWEQD6F1umQyMd
	nTAJ37DaUkRsf2gIIXErXpfQrFbFrkg+ahVkJ2ko/3wUqzUgXVWBCNHxZHALlroBo2CKQS+k+2p
	ykHXyXi/6Eq2IKn0wQMaKVGKSGbK9i4zkcyDeo7Jq5Q1a8wizQnmgfkVus26NTm+CpnTwnspswB
	XRRigvh87eHj4frLQOPVZCpeI4JRChv7ROSLZFOBl0O0B5+KXZ8ToIrJVdkgaW3IJbC+S0dVyNk
	Lt4YKNmuFXtb/krBegH259ggPYtkDFA1AzCGy5aJNcc5Ypqj/zcyTihtp6eBFX6vPQ8ZL3t5PEN
	sKzbTVfzHwMudgLx7JCCfGjJ1hwKmyMfaE0XHyZ7cQQqXBMgztD06uAgAdyqaofS3DekZMMVbZH
	H4P1UX+J/UG9XUr/h0JDaUUjrw5EpRqwOD+/KcYANrH/BJw2hI/VS1yEWRVLLmD3PFwu6qzaZmF
	VyT5nY0k6uLqIAPwKXxstyphx9wx9by7
X-Received: by 2002:a05:6808:13c6:b0:567:c773:39ab with SMTP id 5614622812f47-567e1536002mr4842027b6e.39.1794052543401;
        Sat, 07 Nov 2026 03:55:43 -0800 (PST)
Received: from [127.0.0.1] ([13.86.110.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7d8b4besm3777726b6e.6.2026.11.07.03.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:55:41 -0800 (PST)
Message-Id: <115b5a81b7fffb9664a813c21f41d11bee57b98f.1794052536.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v5.git.git.1794052536.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v5.git.git.1794052536.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 11:55:35 +0000
Subject: [PATCH v5 1/2] reflog: name the strings that mark switches, renames
 and rebase steps
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The next commit adds a "%gb" placeholder that shows which branch HEAD
was on for each reflog entry. It finds the branch from the messages
that branch switches, branch renames and rebases leave in the reflog.
The commands that write these messages spell out the strings by hand,
and "@{-<n>}" and "git status" each keep their own copy of the switch
prefix to read it back. Reading them in one more place would add yet
another copy that has to stay in sync.

Name the strings once in reflog.h and use the names wherever the
messages are written or read: the "checkout: moving from " prefix
written by "git checkout", the "Branch: renamed " prefix written by
"git branch -m", and the "start", "finish" and "abort" steps, the
"returning to " before the branch a rebase goes back to, the
"checkout " before what it checks out and the "fast-forward" it
records when a commit can be reused, all written by "git rebase".

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c   |  3 ++-
 builtin/checkout.c |  3 ++-
 builtin/rebase.c   | 19 ++++++++++---------
 object-name.c      |  3 ++-
 reflog.h           |  9 +++++++++
 sequencer.c        | 15 ++++++++-------
 wt-status.c        |  3 ++-
 7 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b536b619bb..f7acb0f349 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -13,6 +13,7 @@
 #include "editor.h"
 #include "environment.h"
 #include "refs.h"
+#include "reflog.h"
 #include "commit.h"
 #include "gettext.h"
 #include "object-name.h"
@@ -669,7 +670,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: copied %s to %s",
 			    oldref.buf, newref.buf);
 	else
-		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+		strbuf_addf(&logmsg, REFLOG_RENAME_PREFIX "%s to %s",
 			    oldref.buf, newref.buf);
 
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f28467f6df..cbdd78dfc8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,6 +26,7 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "reflog.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
@@ -1043,7 +1044,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
-		strbuf_addf(&msg, "checkout: moving from %s to %s",
+		strbuf_addf(&msg, REFLOG_SWITCH_PREFIX "%s to %s",
 			old_desc ? old_desc : "(invalid)", new_branch_info->name);
 	else
 		strbuf_insertstr(&msg, 0, reflog_msg);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 535db60181..47a7b2fd3c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -17,6 +17,7 @@
 #include "strvec.h"
 #include "dir.h"
 #include "refs.h"
+#include "reflog.h"
 #include "config.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
@@ -601,11 +602,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
-		    opts->reflog_action,
+	strbuf_addf(&branch_reflog, "%s (%s): %s onto %s",
+		    opts->reflog_action, REFLOG_STEP_FINISH,
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
-		    opts->reflog_action, opts->head_name);
+	strbuf_addf(&head_reflog, "%s (%s): " REFLOG_RETURNING_TO "%s",
+		    opts->reflog_action, REFLOG_STEP_FINISH, opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
 		      RESET_WORKING_TREE_UPDATE_HEAD;
@@ -867,7 +868,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 	struct reset_working_tree_options ropts = { 0 };
 	int ret = 0;
 
-	strbuf_addf(&buf, "%s: checkout %s",
+	strbuf_addf(&buf, "%s: " REFLOG_CHECKOUT "%s",
 		    options->reflog_action, options->switch_to);
 	ropts.oid = &options->orig_head->object.oid;
 	ropts.branch = options->head_name;
@@ -1413,8 +1414,8 @@ int cmd_rebase(int argc,
 		if (read_basic_state(&options))
 			exit(1);
 
-		strbuf_addf(&head_msg, "%s (abort): returning to %s",
-			    options.reflog_action,
+		strbuf_addf(&head_msg, "%s (%s): " REFLOG_RETURNING_TO "%s",
+			    options.reflog_action, REFLOG_STEP_ABORT,
 			    options.head_name ? options.head_name
 					      : oid_to_hex(&options.orig_head->object.oid));
 		ropts.oid = &options.orig_head->object.oid;
@@ -1884,8 +1885,8 @@ int cmd_rebase(int argc,
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s (start): checkout %s",
-		    options.reflog_action, options.onto_name);
+	strbuf_addf(&msg, "%s (%s): " REFLOG_CHECKOUT "%s",
+		    options.reflog_action, REFLOG_STEP_START, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_WORKING_TREE_DETACH |
diff --git a/object-name.c b/object-name.c
index 6546685760..5b6ce8e0e0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -13,6 +13,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "reflog.h"
 #include "remote.h"
 #include "dir.h"
 #include "odb.h"
@@ -1251,7 +1252,7 @@ static int grab_nth_branch_switch(const char *refname UNUSED,
 	const char *match = NULL, *target = NULL;
 	size_t len;
 
-	if (skip_prefix(message, "checkout: moving from ", &match))
+	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &match))
 		target = strstr(match, " to ");
 
 	if (!match || !target)
diff --git a/reflog.h b/reflog.h
index 3bdd1ca8a5..d396d1df05 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,6 +2,15 @@
 #define REFLOG_H
 #include "refs.h"
 
+#define REFLOG_SWITCH_PREFIX "checkout: moving from "
+#define REFLOG_RENAME_PREFIX "Branch: renamed "
+#define REFLOG_STEP_START "start"
+#define REFLOG_STEP_FINISH "finish"
+#define REFLOG_STEP_ABORT "abort"
+#define REFLOG_RETURNING_TO "returning to "
+#define REFLOG_CHECKOUT "checkout "
+#define REFLOG_FAST_FORWARD "fast-forward"
+
 #define REFLOG_EXPIRE_TOTAL   (1 << 0)
 #define REFLOG_EXPIRE_UNREACH (1 << 1)
 
diff --git a/sequencer.c b/sequencer.c
index 4a1c0e70b8..5aa560315d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -31,6 +31,7 @@
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "refs.h"
+#include "reflog.h"
 #include "sparse-index.h"
 #include "strvec.h"
 #include "quote.h"
@@ -664,7 +665,7 @@ static int fast_forward_to(struct repository *r,
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
+	strbuf_addf(&sb, "%s: " REFLOG_FAST_FORWARD, action_name(opts));
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 						  0, &err);
@@ -5014,8 +5015,8 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 RESET_WORKING_TREE_UPDATE_HEAD |
 			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
-		.head_msg = reflog_message(opts, "start", "checkout %s",
-					   onto_name),
+		.head_msg = reflog_message(opts, REFLOG_STEP_START,
+					   REFLOG_CHECKOUT "%s", onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_working_tree(r, &ropts)) {
@@ -5314,16 +5315,16 @@ cleanup_head_ref:
 				res = error(_("could not read 'onto'"));
 				goto cleanup_head_ref;
 			}
-			msg = reflog_message(opts, "finish", "%s onto %s",
-				head_ref.buf, buf.buf);
+			msg = reflog_message(opts, REFLOG_STEP_FINISH,
+				"%s onto %s", head_ref.buf, buf.buf);
 			if (refs_update_ref(get_main_ref_store(the_repository), msg, head_ref.buf, &head, &orig,
 					    REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;
 			}
-			msg = reflog_message(opts, "finish", "returning to %s",
-				head_ref.buf);
+			msg = reflog_message(opts, REFLOG_STEP_FINISH,
+				REFLOG_RETURNING_TO "%s", head_ref.buf);
 			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
diff --git a/wt-status.c b/wt-status.c
index 238bb48643..3516432338 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,7 @@
 #include "strvec.h"
 #include "remote.h"
 #include "refs.h"
+#include "reflog.h"
 #include "submodule.h"
 #include "column.h"
 #include "read-cache.h"
@@ -1790,7 +1791,7 @@ static int grab_1st_switch(const char *refname UNUSED,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
-	if (!skip_prefix(message, "checkout: moving from ", &message))
+	if (!skip_prefix(message, REFLOG_SWITCH_PREFIX, &message))
 		return 0;
 	target = strstr(message, " to ");
 	if (!target)
-- 
gitgitgadget

