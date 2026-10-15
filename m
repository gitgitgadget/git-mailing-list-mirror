Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA2529414
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070049; cv=none; b=SaDh99kKFLQrX4kDv2utxiutHdfC3mpTR6oRX9181FN9DbCceZSKxARTBBUNYwBtQKm2ddD7VLYCbowb2hrnirfyGNZn9DFhOsODEpSXfEFFPfqOxjddgNAe0Tu2WJd2FPLPNPtqayGBy7v0Uz+QvM6JjIKH0UVOAQBJjDephkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070049; c=relaxed/simple;
	bh=aAN0Di0uAGIhB8l+f//niKNzISlVdT8OshndT5rWyQQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YuQl0gZ0tUiV0cYbY+wiTD33r5XwjRV4aHp26Zez+JdmSjF6DwqqPoaZrVz7d5+urAW2mkTkMw3J6s7gNyyPej/UA36HdoHw4Vwjf2nI26D3CMNKrFj7KHyA3xTYwP3EeX7eBrwD1NJ0RwQl51vOiCiKA62mly786kgEhqTY1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBz0cToz; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBz0cToz"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so1414003a91.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070045; x=1792674845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qV9AgvACZWsO016AlsyJQWL2Pl9HFSTNIY6E2Eb/bqg=;
        b=JBz0cTozwQaqRRAZ0ZG1U1tLNAGxPNCLpKSNwe3jRBMQpPTkqr5bEcVON3GXCpK5tB
         zxCkVogCwgkKX8BAR4WqkwvmuCRLlqqcxm8eBC9tnSko6dqadHzoCag8VrbWY/2qHxbQ
         2t1n20gVGaQlzgmI2jreLpdiWx+JpcOkAlgCMf7EaldXgPgvxcBa9f2Mj1wKwIwX3V21
         1Dr2Cmpz8rejBuPgzhMEWruxj64qL1YVxq/r340H2CgbtE5ORBaT+wVJ5mW+aoFKXR8h
         9pnSiLhIp85ATtbjKgKsRBXWeqw1u3QHlKV6MLT9M1ETK6QReYcnMPs557rchb77PeUk
         POZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070045; x=1792674845;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qV9AgvACZWsO016AlsyJQWL2Pl9HFSTNIY6E2Eb/bqg=;
        b=MdpvDX93Y6YxDSbMUsj5lB1SUXJgB5NiqX8g0OnV2kBqGUn1oTetf5Qzxbq/uCoaGk
         m9rZC/4pHWXSLmrFubdPHFPgZnjuQeB6q2mHi/XLUEMhP0l2oxD6OU7HHQx5HKbEpvG7
         jjgwaGFLJcdDIK8QUDBvnw2IkSm/AS70cxKF9lqbKgLfJzH+0WjhBNWG9mBeYHMPMzFe
         hx7SZ4y5eKT5lq0zORCbQA6rwwbeMhaZo3R6ksNhCrd7brB44MtCFupriea4BrY6Vrbv
         K4JEytS++5QLPJwtEF1D6UDzzAEP1oSD/w3s0MOs9J2b/8ta/KkW19aqM2PhW1AlPWSq
         96aw==
X-Gm-Message-State: AFq9FYLZBuPiaqrw3JoybDWtIxqemNeoL9nhYpVehm30SQqD3+KiCDZK
	BsgXbI+5lwTLPmeXlOIzBjFa3ZrE6S4J5AHpGPz1eQ1WEb0+VIAhFEryOKB8Gtt94b0=
X-Gm-Gg: AYBFou3VwRgZHM9RfG97dZNBBwo+q6fB4gvM5IKBTqR8Qz8fQMPYHPkYZKnipzDqliK
	rzcDmJSKo4QU2M9Db9H34Mc7YEY84/LygzR7yp8Jerk59VrTDGTUZhh2Ms66CVKj/ugoDIME6Af
	ojBiN2pVRCFUEme4VSkTxkdeSt4GL2QV93FaUeunvQ9D1XP+WyWcRyf3rPUt9UHQZ4ERN7kYaqH
	Y3eUgTaabvW81Ge5HkUYrzzNpNE716E2ppaPJlirPvnlmLGQN5fSB0H0i1teqTYYDQw+3hnpYcb
	0NLIbYCQuWPgOVe8AFMhVYlH7ybZ6WsKmGl+Pbf7fj0ZXbz5spEX86rb+/Vl/Db8zHtiC1bcolz
	RzJd2tm/THBN6p27zllPOjkZhOAlME/xw+u6GcyE9a2NOnBj7NTSXskcxl9soSDRJ6qrBM7Gm1v
	pKOQeqHoAXGIJCV6I6zZCM9ReI2JdDvhBUU9AjJTqWOV/Cj5VuKd3BZJR2sOe+l2Mv0wByY/gee
	w==
X-Received: by 2002:a17:90b:2d06:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ab3ad0e976mr9765216a91.43.1792070045083;
        Thu, 15 Oct 2026 06:14:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.112.122.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm4610030a91.0.2026.10.15.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:14:03 -0700 (PDT)
Message-Id: <d95ed5bd679cea41320c39824b969377e8c88e09.1792070038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 13:13:56 +0000
Subject: [PATCH 1/3] reflog: name the strings that mark switches, renames and
 rebase steps
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git checkout" records a move of HEAD in the reflog as "checkout:
moving from <old> to <new>", "git branch -m" records a rename of the
current branch as "Branch: renamed <old> to <new>", and "git rebase"
marks where it starts and ends with steps like "rebase (start)" and
"rebase (finish)". "@{-<n>}" and "git status" read the switch message
back, each with its own copy of the prefix, and a later commit adds a
reader for all of them.

Name these strings in reflog.h and use them where the messages are
written and read, so they cannot drift apart.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c   |  3 ++-
 builtin/checkout.c |  3 ++-
 builtin/rebase.c   | 17 +++++++++--------
 object-name.c      |  3 ++-
 reflog.h           |  6 ++++++
 sequencer.c        | 13 +++++++------
 wt-status.c        |  3 ++-
 7 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..30062ceb7c 100644
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
index c0f0d2c700..9f0f09e50f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -25,6 +25,7 @@
 #include "preload-index.h"
 #include "read-cache.h"
 #include "refs.h"
+#include "reflog.h"
 #include "remote.h"
 #include "repo-settings.h"
 #include "resolve-undo.h"
@@ -999,7 +1000,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
-		strbuf_addf(&msg, "checkout: moving from %s to %s",
+		strbuf_addf(&msg, REFLOG_SWITCH_PREFIX "%s to %s",
 			old_desc ? old_desc : "(invalid)", new_branch_info->name);
 	else
 		strbuf_insertstr(&msg, 0, reflog_msg);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 535db60181..26ef589e89 100644
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
+	strbuf_addf(&head_reflog, "%s (%s): returning to %s",
+		    opts->reflog_action, REFLOG_STEP_FINISH, opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_WORKING_TREE_REFS_ONLY |
 		      RESET_WORKING_TREE_UPDATE_HEAD;
@@ -1413,8 +1414,8 @@ int cmd_rebase(int argc,
 		if (read_basic_state(&options))
 			exit(1);
 
-		strbuf_addf(&head_msg, "%s (abort): returning to %s",
-			    options.reflog_action,
+		strbuf_addf(&head_msg, "%s (%s): returning to %s",
+			    options.reflog_action, REFLOG_STEP_ABORT,
 			    options.head_name ? options.head_name
 					      : oid_to_hex(&options.orig_head->object.oid));
 		ropts.oid = &options.orig_head->object.oid;
@@ -1884,8 +1885,8 @@ int cmd_rebase(int argc,
 		printf(_("First, rewinding head to replay your work on top of "
 			 "it...\n"));
 
-	strbuf_addf(&msg, "%s (start): checkout %s",
-		    options.reflog_action, options.onto_name);
+	strbuf_addf(&msg, "%s (%s): checkout %s", options.reflog_action,
+		    REFLOG_STEP_START, options.onto_name);
 	ropts.oid = &options.onto->object.oid;
 	ropts.orig_head = &options.orig_head->object.oid;
 	ropts.flags = RESET_WORKING_TREE_DETACH |
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..bb349014ee 100644
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
index 3bdd1ca8a5..32c3737db4 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,6 +2,12 @@
 #define REFLOG_H
 #include "refs.h"
 
+#define REFLOG_SWITCH_PREFIX "checkout: moving from "
+#define REFLOG_RENAME_PREFIX "Branch: renamed "
+#define REFLOG_STEP_START "start"
+#define REFLOG_STEP_FINISH "finish"
+#define REFLOG_STEP_ABORT "abort"
+
 #define REFLOG_EXPIRE_TOTAL   (1 << 0)
 #define REFLOG_EXPIRE_UNREACH (1 << 1)
 
diff --git a/sequencer.c b/sequencer.c
index efbfd1315b..c55df2d38f 100644
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
@@ -5011,8 +5012,8 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 RESET_WORKING_TREE_UPDATE_HEAD |
 			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 			 RESET_WORKING_TREE_RUN_POST_CHECKOUT_HOOK,
-		.head_msg = reflog_message(opts, "start", "checkout %s",
-					   onto_name),
+		.head_msg = reflog_message(opts, REFLOG_STEP_START,
+					   "checkout %s", onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_working_tree(r, &ropts)) {
@@ -5310,16 +5311,16 @@ cleanup_head_ref:
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
+				"returning to %s", head_ref.buf);
 			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
 				res = error(_("could not update HEAD to %s"),
 					head_ref.buf);
diff --git a/wt-status.c b/wt-status.c
index 57772c7501..ffd54353a8 100644
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

