Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793090335;
	b=NgJV5QEKdIal1rRoaTgcSedFcn0zR3e8MEqWdTTd8psUw5xc8iiubtlS0aMihSAiVyyu
	 NO4ySaOk/ieIWUnqMoKV8dxvAEQU008p1RUoFRJtu+70vt/dffajsQZp5/wRm/U3GP3E6
	 IkbMzs9i3+xcvOgreEyXfChZ0/R9mwcZUL6KDjxrTCyWSHzPfYGPr2m6dEEVpFq2PZvx0
	 K0CDLEuYnRdSBvt6Hg6QUrB0AhfUbx0ovFsj1CYcV3wRzG3jfIoIsRqPl3dkrScEj5TKx
	 4eIICHwjf1QZxPeGz5e67gx5HfyQe+EryYQThC4mi8iYdVJ5e8hYxtyDngJ6wsOhnew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793090335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=c+2aeHagOdVfa0JW/Bmp7ZfCyCP+7MAQYpR9FTEYEVQ=;
	b=IJz6KceAZTwHglAxKNF0rE36U65GHv3+gMSY4IC96WrL4Je5qXD+Omht3RyCniP4JYHZ
	 2JvykUksECxLJflQpwE5VMJDGg7CWLpU8xyWAiDk9/PaaeiZKyQYPgmDkLZ1FgaN7txcn
	 WhKgxo0EEAGJHZdLGBCMImGLWHFxaPcG9D8RktO6ZqNRxvTQVf76yX0JcYz2LowwR96VG
	 /i+K1QxWjUvP5frp5FXWwnvMt6U2rDPK9/tr3fVSVKUMfpDYeB93VcquAdK9Lsj2EYiIB
	 z6/Z9NAjJz7wYL/UeR/dADtYo+IX5jI1dIdPhkP2d76ruE0c5Eq1qjXU+Hk7umCbLiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="cMG/XLo6";
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB4606A326
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FBB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cMG/XLo6
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a451915d8aso2601975b6e.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793090333; x=1793695133; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c+2aeHagOdVfa0JW/Bmp7ZfCyCP+7MAQYpR9FTEYEVQ=;
        b=cMG/XLo6GerzZ76TCBHtVqttRzae31MC+Ktn9z8ATsrt1bN/9TbjRcKxLHPVXRZDTY
         odIpqs93CwR6t0JZJQpf4DOQ3YjTkCCLOgJNWB69vj47TdJ8iclf1b4sRHhwPuKwNzue
         u0VK/ieWZkx0RejgLpVpaJuTNqXfBho2tDzWYija1I7V5dfHJpXwSP/rxpzlbkOSqSO9
         XPDAwbkrclmS12Pq8cPJt6q4kwg3mutTTNbZZ6CFQK1C0N76/ieDMGJQJXs+ngSzl5Qv
         JVEdQs0m422iy1v2PDPuiY8ImLCRhT9Ncf1fy1wY1rkoWTdN+Ke3ncIgjh2kEafKEKz8
         5s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793090333; x=1793695133;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+2aeHagOdVfa0JW/Bmp7ZfCyCP+7MAQYpR9FTEYEVQ=;
        b=r/UHXw0llmdubUK3K5lA4Xh2BQoLiQYwAxYdm1eq52BKf1dTcAOt0YWHcUp6OHbF4p
         sriGEg5NMYKPOAYYisxZ+Lzu1AmJ0CggpWwG0Ze+F7sG74GZg51M1KesLpDdFeKR7Dwe
         frfyTDavJkpQnAhlH/AZ+QHUoBCfw2jaCKxcm7bKZBcwf7p8O3BWjfedrwDu68GVwHGQ
         CgoOQldBUYiQfYKkRdCh9nK/mDGDw79TVK09PAMdJohMCi+OJY0q6hufTOu2IbH4WRkx
         FcvhOgjhtUReBBoHWLWGu4e3AcMOostagRMfIxkPBM3PnOQqK9IK2XouwP8SFO1rPsJC
         N90w==
X-Gm-Message-State: AFq9FYI3wgaU2vIVZHT0hSM2lMlEBJQiDXZiMdUyQvnyDPPg7pGOrYVY
	T5jBKIheTalSf6+EfL5tcMYpke4XJJPfN1cUxNwdMZF/PCNbAewj81A+za0GZ2OrktY=
X-Gm-Gg: AYBFou2kk9eGpPOCjnJLXYuWpLPyt5c3vE7Pm+UyekBz4WDyQMrE0hJPRxHnEP+PYOI
	DZo2LdJdHUelkSO80zT+B3D4V34v9yo2mjB4QKgWg4zfdKPqymXv3KkkYXFPJc9pw77Ef2Ox6Tm
	Joo3qwxTZgPzTBAeIVLbuvbCMM7fYPqi4pIHOMFqurnafe2DPvNNdDwD3Rz7TPiioD4YaOQMw19
	tGpKZKUGPUnjqvLn8vRuN8HyyZZ+iUxRIPr3J7MoTCmWizIOP7P1VgGkXD6Y1/NxS3A+2ZMUaym
	q6piKx+VpQ38cft8LEOvLA4lAynyfNXKH8EyNxco5ySrYPfZPUGewgREM/UGKocvdoxF5dk75Sr
	rimW7x2t8A8QorOxYRcda0EFCR4GJ3Bz4PySfe25Xc/CaLjWMKT12zIXdm+pOPcQkub5xuagydE
	2zHWzTFpTMzdLr6B9oMJ8Ro945gXl01b7tH46hqdcPHsA2wD0roVQcVjjjvpYifGsghgK6H5zTx
	GS1tafC1CGvJws+Y3/kbTQMJBjtJMQZnQBniRD0GWqKNQt2UxiaZDHC
X-Received: by 2002:a05:6808:4f27:b0:4f1:9d5b:3113 with SMTP id 5614622812f47-55c00426a67mr6405452b6e.67.1793090333437;
        Tue, 27 Oct 2026 01:38:53 -0700 (PDT)
Received: from [127.0.0.1] ([4.150.62.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c043115bcsm7202439b6e.15.2026.10.27.01.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:38:51 -0700 (PDT)
Message-Id: <4d779e8da37228567669af19fc0adbcf69adb13f.1793090327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v3.git.git.1793090327.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v3.git.git.1793090327.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:38:46 +0000
Subject: [PATCH v3 1/2] reflog: name the strings that mark switches, renames
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
"returning to " before the branch a rebase goes back to and the
"checkout " before what it checks out, all written by "git rebase".

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c   |  3 ++-
 builtin/checkout.c |  3 ++-
 builtin/rebase.c   | 19 ++++++++++---------
 object-name.c      |  3 ++-
 reflog.h           |  8 ++++++++
 sequencer.c        | 13 +++++++------
 wt-status.c        |  3 ++-
 7 files changed, 33 insertions(+), 19 deletions(-)

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
index 91e0332ec2..1e06586e67 100644
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
@@ -1037,7 +1038,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 
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
index 3bdd1ca8a5..f5586242bf 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,6 +2,14 @@
 #define REFLOG_H
 #include "refs.h"
 
+#define REFLOG_SWITCH_PREFIX "checkout: moving from "
+#define REFLOG_RENAME_PREFIX "Branch: renamed "
+#define REFLOG_STEP_START "start"
+#define REFLOG_STEP_FINISH "finish"
+#define REFLOG_STEP_ABORT "abort"
+#define REFLOG_RETURNING_TO "returning to "
+#define REFLOG_CHECKOUT "checkout "
+
 #define REFLOG_EXPIRE_TOTAL   (1 << 0)
 #define REFLOG_EXPIRE_UNREACH (1 << 1)
 
diff --git a/sequencer.c b/sequencer.c
index 2ac78e15b8..b2c6d8072a 100644
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
+					   REFLOG_CHECKOUT "%s", onto_name),
 		.default_reflog_action = sequencer_reflog_action(opts)
 	};
 	if (reset_working_tree(r, &ropts)) {
@@ -5311,16 +5312,16 @@ cleanup_head_ref:
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

