Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826943;
	b=aAM9XLnCCoPcNkOsH3uVVWCBHARrAt3JrdltYBmLuKZ+2WGquD4WVmkreb8LNvH5w/1O
	 myBqGlxURgkY4xF84MPEus9UKJfCaJXaZPgu5DDutUg3QmcZVTsR5bcPWx1N0yvNkROXB
	 VvbFQv2ToOAt6eAlOI/baXVKJgIPFH4Z00uo0rb7V8nDhwd+EEdl8PcD3cHLhRYmmgiL5
	 QVbOwyXqVdjXp0e8e7jqhve+aXTtC2920PlTTGsxdOkucU7IEDUwT5KODxjtekCbMMLaQ
	 yx+2N0G7a9cGOM0LtqKH7Owu2KEOaKHiUJvC7HEetQG/9/xbfo4ou/6lScD8gNtLkKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4PEwuxx//qXf0CFFNYcjnvI4XZ5GnpTPFjxYMlRxFt4=;
	b=A8g2a46u7eFRbdozeOFcMQa5ATZnFWBwho05bBbtjetnnKoteh+jmF47cdh4vF0hIZ5P
	 g0uqP/2IgIprZMCyvVGGG4HhRrY/N7iwQFgPv7KaXT7eU6w8X48LKxjwk0KdCFIoWVWCw
	 erdiOhjuqimYekUhwD9RHEAOnEJHbNjHwNHVwggsohGrNDn5N9C3H+tJUMkNEZWGV+LXG
	 XZoNid+S5v+K5klwexWc6R+ZumZQzJOPW6MKM7lxGSmyA3F91oGdDQuUVQDNcHMRcH1xT
	 ci//6hnrOe/igYJKdYZRfiUaP7JdeaLsGV8Cw201WLl4hOFo2svjMc+LGyKCC2qbLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXXyvw8a;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402476073517
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 21:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 402476073517
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UXXyvw8a
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso12393206d6.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 13:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826942; x=1794431742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4PEwuxx//qXf0CFFNYcjnvI4XZ5GnpTPFjxYMlRxFt4=;
        b=UXXyvw8akSEwWDeyv/hZEkJD5N3cqKb/MpnDu954v7LPnR/6Xts5pEiXyqOI6jFCOp
         HyJJwCqZcsy/YVZ3OIFKDhLUpZ38rjStZuKbDBrD24l6VC0yGnCuFuIdmaXEZCrO/Wjj
         M+kPEmiSKgJ3KGf91XQfJQTSbpLnTSh8+ROT8a/4K4e2YW156OfmpHbWApzlPA4Psvoh
         AecS8CfHLPEjSV4dc+bu5Nz+MsVk6l3rrg4s5S/PO4CroYtY49BinHClDvafUZTEqW/H
         4M9Y/LAXmYH6Qmqie/rJ4MKYULr/JTAE0DhlzJzbe8rUcaGSzmsdHF57wD4OVzBJf7Oa
         C+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826942; x=1794431742;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PEwuxx//qXf0CFFNYcjnvI4XZ5GnpTPFjxYMlRxFt4=;
        b=F6R7TK4NKwagdXMid5QoXQ7C2wobNgkSp93LGx7vixFAY6gS9Pr5s1S6da8sTF9H3x
         +xvTPM2dfgIT+zD/riuHpD/0qTYzy5jX27CmbTjNPZKH7sOWrU1bAhfpI7LUOkfzW6l5
         AZP4GAG0+/HIHGxQ+KMYlR3bAOiCkDYa3OTN0BVKLhfB66TOW3RGT7NKozv7fHj/j6Hq
         9crFe+qbZLSuj5jl7pC002nRDc6WTIvqF08mdPzQvtn+9g+349lxDHksjuMMVMJMuKq8
         ZTjp4B4fFGzl8+sWT/HObtpE+R/BMhuFoPZ2iOh4KZzXlj9CRgSpP0482Z0jORu7EvV+
         1gPw==
X-Gm-Message-State: APuU4Z8ygPnqag46NugIx/5SIk2azG5q2mcrHHUk0lGzBwhOifSDvWC8
	PL7zu3ZB6QWUKbLjxqn3auVADNRwUihHeiWU70xYsVTZNivo8HC8r10Xn3O/FtvStXQ=
X-Gm-Gg: AYBFou3qabrUnD0CChbvbMOs6M9f2MF7DP1ykdkPsTgl9T3xSWJL7LM1LkSZl2e1ZOp
	H3Ql564V0kf0CNN3lbKISnDAvQc6TOF/gy1f6l7ETK+utmrsYKQoiYdfqnMDEvc+foS2H1e0kh6
	HNiNyA2PP/tk520cqNr9y6sLL0AY0snXs+8PF7tUGiGg16ZeXuen2LbipiH7e77jISckg9JXgue
	3HdEHUh/6in9mL6KjvpNOIr2/KkOdDdL5RKUEn/0+xbIt8Uq8aNT8XHJrzQRmnWmQTj2qB77x0e
	Vc/Zt9lcBH12b5YGb19+EhcfrRNUn2U0h4RZ2Oc6EM4VfzZzIIY4lwZP/lPAIc3/iXmSr6umUjX
	T2jOvH9HENAkWZP+/dZ/UMT0fNZcJlzD7ypVb6bDL5u87S1F53YcgARcoRaJFkRWsAVvq6Qgf+H
	KtfZ68QrkisekYeTBnlpNZb2tLMSY+ecCDsRIWHpABvHhHdmgdY6KDgrlbvRYFf8T8SFq1mQi+4
	bYhkZbfFCB29DrfETpPGIkuxX2BYzpy1h0//MZwgqMjBpgQvxw0ivZMVzc/mMSokQjKwUFA5v6J
	x5iOlgUl3NPJMoy3SclNT1WVZ93OIx/cDg==
X-Received: by 2002:a05:620a:4483:b0:93e:ee21:70ec with SMTP id af79cd13be357-94421821cd2mr2864467985a.80.1793826940992;
        Wed, 04 Nov 2026 13:15:40 -0800 (PST)
Received: from [127.0.0.1] ([48.217.227.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dacd812sm28890176d6.6.2026.11.04.13.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:15:40 -0800 (PST)
Message-Id: <f960a24b8bcf0ea4e77e20437cd436cc1732683f.1793826938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 21:15:37 +0000
Subject: [PATCH v4 1/2] reflog: name the strings that mark switches, renames
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
index 508ec71792..da6f61a0e6 100644
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

