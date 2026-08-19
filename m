Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D930ACF2
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143865; cv=none; b=mo2rLOL64Rl5yF/hjItPCvrE/Qy28HYHul6Lp58P9YZL7dKjD/eKIxK8d9e/CPWNB2ylGq7bdkedPXH04CKvgiCF7zkraGV1su1rB0IQHyFi3L9JQ0RIg+gDIBT/4JFE296TyyJSjfiRVLMn0JKOnXIIN8Y0UXC7HhYbvB78S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143865; c=relaxed/simple;
	bh=2d74Kw4EzY8gsoh9WBuG7k+msUSv/CqME/UOeECZe8c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pVi0e6WPN99HnWhxyzof/4EXGiT2XOTQwRPTeUCoUBFcBPXPf6iB2mupSWqynP3XFSMrbRWvtLfzGJQ/3rncXjLzZxRMSAg1Z8eFWikW0YmeMt8B8HrKZymGObjAiBCsF6Yo6j/2WzEllRXqmTI8zAZRQ/NsVLYvRdfaoRFNGzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNJepFy/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNJepFy/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e7109321dso679660a91.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787143863; x=1787748663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8e+jA7h0nJg2Gz0ccesEfMUrRpOd+3qhxIAos9EE/44=;
        b=MNJepFy/JhHMl4tYiKPr/YmXOhclQfcrb7eVo5PKruIbwhIZdHuvY6okn9L+PvWJoS
         2o7W26Ob6QwpQXRdwh3ML5OCx134DQp8YcRlXhKVMMI1m41fFmsmLsBCo+8TslIZ7Elx
         C0bCzqXQwmPSkjz1uQvl32h46wDwdCWO7r31JWhxj8wAsdHSmCTa26gn8dTSIQTt9x74
         ZUojwXwN9uISL7pwI2ZaNhWMOgFeGI8myx1pudl8Y9KrOo6Y0Bvy/q7nTWMgZTWx6dyj
         sbdZgshcWm5pJ/gots6xF9aPD+pHCsFyp6T0d31mPRyj0FUayOTHGimeyU4e3yoejkxs
         yf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143863; x=1787748663;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8e+jA7h0nJg2Gz0ccesEfMUrRpOd+3qhxIAos9EE/44=;
        b=OqQq68zzfMjLyyYq1S93OvTtX8zxbP8mPJW2NmU89wM4oKyWztozLYFkV0457AtRAv
         xGe+UaFr98X71+7QPNYydG8oY3fLFby3bsEcmVZGkWD5kEr5P8X2PrADJ9mFw+2z6nIf
         IdiF2wugpd/TvUx3e7+YmxlkijsqgazThLDMZQ6EKTfp5xke04X6PpVTFM3utHvoE4WQ
         UE717ShBKCDl1aWrOGNsxXY6erCSxpqkcAB0Kqp27KjxPqSHoiFCUlMy4oxdnyyfU3dQ
         XWVZrRehTxbtSJkChA1H33H8jgCMVwKZMvbm4KsoPjPdmXqgdlu3B4jR/aw3jec0deG2
         I3lA==
X-Gm-Message-State: AFuF++mpr/xOyTuv+KV5ksN+xVXuyD15PNohSb76n9iEMp25I8qDo6Q1
	JJBxixnHUPf7qlDl0ZphBlrK0m+dsJ8YT+/IdnN/Xwkt/pqPqakHsSUXReVjKQ==
X-Gm-Gg: AR+sD11wrKj8a6tmithwPAPYcMM90Jux4zRuR7Nut95DJrocqUBPTCnPt6/W1t4LRFf
	Vd7lq6VmEi4jQ5ngbRF48Bm7tc8CRfExK/buaqHod45Lr/X0aD+w0jsEAytlewi6Y3M2VALQR9e
	D4o0qdq4KVnNfVvIt3bB1C8ApJRdo7GNgstU8bceue31DzQYR4YLwcfpisIyrwv9+k0s4feqnnh
	OijXkpzvKgMZTGSwNcAo4yxdlzXgSe22kHrOHgni1NpeueQ+YpSpb8QD6zjYuIaIVYB/UG5oPih
	hfa8BQabQV7EWz9+7zUp2e68Sq6IJCVqsO0uMpwjnkvIq6YdsWZGvrhKlvQ7y2NOq821k2/DoBU
	4MymClcJzrugjIoxPhvVLrw2xDPtzNMFvhgDc8r2X3Bl+I/pns/MskZQqms3G7HpkUpxwBeEtIA
	jIWb9QjBWPfCHuXo5m+ixkZBZ0dKVllZoPxAOgxIWbYNu3QhzjCEeVTLq6jG9wUV/NhKH3XQ==
X-Received: by 2002:a17:90b:6c6:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-395812a8bd9mr8864805a91.7.1787143862843;
        Wed, 19 Aug 2026 05:51:02 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.76.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm9621426eec.13.2026.08.19.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:51:02 -0700 (PDT)
Message-Id: <b838fdabb7cd0d044294d54fd30cb51f040505ad.1787143859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v5.git.1787143859.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 12:50:57 +0000
Subject: [PATCH v5 1/2] checkout: improve message for ambiguous remote branch
 name
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
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git checkout bar-topic' command that does not
exactly say which remote they want to work with, and there is no local
branch named bar-topic, we try to guess which remote by passing
bar-topic then create a new branch named bar-topic which tracks the
remote branch.

If multiple remotes have a branch named bar-topic, we cannot determine
a single specific remote. Therefore, we provide information that the
user can utilize to resolve the issue.

To make the advice more feasible, we will provide matched remote names
for the specified branch name.

To achive that, we add an optional feature to the
`unique_tracking_name()` function that allows the matched remote name
to be exposed to the caller.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 75 +++++++++++++++++++++++++++-------------------
 builtin/worktree.c |  4 +--
 checkout.c         | 14 +++++++--
 checkout.h         |  5 +++-
 4 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..a2749352e6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,13 +1343,51 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
+static void be_explicit(const char *branch,
+			enum checkout_command which_command,
+			const struct string_list *matched_remote_names)
+{
+	const char *cmdname;
+	struct string_list_item *item;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		cmdname = "checkout";
+		break;
+	case CHECKOUT_SWITCH:
+		cmdname = "switch";
+		break;
+	default:
+		BUG("command <%d> should not reach parse_remote_branch",
+		     which_command);
+		break;
+	}
+
+	advise(_("Branches with the same name appears in multiple remotes:"));
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to check out a remote tracking branch on <remote>,\n"
+		 "you can do so by fully qualifying the name with the --track option:\n"
+		 "\n"
+		 "    git %s --track <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always have checkouts of an ambiguous name prefer\n"
+		 "one remote, e.g. the 'origin' remote, consider setting\n"
+		 "checkout.defaultRemote=origin in your config."),
+	       cmdname, branch);
+}
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
 				 enum checkout_command which_command)
 {
 	int num_matches = 0;
-	char *remote = unique_tracking_name(arg, rev, &num_matches);
+	struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+	char *remote = unique_tracking_name(arg, rev, &num_matches,
+					    &matched_remote_names);
 
 	if (remote && could_be_checkout_paths) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
@@ -1358,37 +1396,14 @@ static char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
-		    const char *cmdname;
-
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
-			    cmdname = "checkout";
-			    break;
-		    case CHECKOUT_SWITCH:
-			    cmdname = "switch";
-			    break;
-		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
-			    break;
-		    }
-
-		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-			     "you can do so by fully qualifying the name with the --track option:\n"
-			     "\n"
-			     "    git %s --track origin/<name>\n"
-			     "\n"
-			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."),
-			   cmdname);
-	    }
-
-	    die(_("'%s' matched multiple (%d) remote tracking branches"),
-		arg, num_matches);
+		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+			be_explicit(arg, which_command, &matched_remote_names);
+		die(_("'%s' matched multiple (%d) remote tracking branches"),
+		    arg, num_matches);
 	}
 
+	string_list_clear(&matched_remote_names, 0);
+
 	return remote;
 }
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..22c8e5e131 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -782,7 +782,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
-		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
+		char *remote = unique_tracking_name(*new_branch, &oid, NULL, NULL);
 		return remote;
 	}
 	return NULL;
@@ -904,7 +904,7 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			remote = unique_tracking_name(branch, &oid, NULL, NULL);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
diff --git a/checkout.c b/checkout.c
index 1588b116ee..2806b783ec 100644
--- a/checkout.c
+++ b/checkout.c
@@ -8,6 +8,7 @@
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -17,6 +18,7 @@ struct tracking_name_data {
 	const char *default_remote;
 	char *default_dst_ref;
 	struct object_id *default_dst_oid;
+	struct string_list **remote_names;
 };
 
 #define TRACKING_NAME_DATA_INIT { 0 }
@@ -39,6 +41,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		oidcpy(dst, cb->dst_oid);
 		cb->default_dst_oid = dst;
 	}
+	if (cb->remote_names)
+		string_list_append(*cb->remote_names, remote->name);
 	if (cb->dst_ref) {
 		free(query.dst);
 		return 0;
@@ -48,14 +52,20 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 }
 
 char *unique_tracking_name(const char *name, struct object_id *oid,
-			   int *dwim_remotes_matched)
+			   int *dwim_remotes_matched,
+			   struct string_list *dwim_remote_names)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
-	if (!repo_config_get_string_tmp(the_repository, "checkout.defaultremote", &default_remote))
+
+	if (!repo_config_get_string_tmp(the_repository,
+					"checkout.defaultremote",
+					&default_remote))
 		cb_data.default_remote = default_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
+	if (dwim_remote_names)
+		cb_data.remote_names = &dwim_remote_names;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
diff --git a/checkout.h b/checkout.h
index 55920e7aeb..0b185a0fc9 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,8 @@
 
 #include "hash.h"
 
+struct string_list;
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
@@ -10,6 +12,7 @@
  */
 char *unique_tracking_name(const char *name,
 			   struct object_id *oid,
-			   int *dwim_remotes_matched);
+			   int *dwim_remotes_matched,
+			   struct string_list *dwim_remote_names);
 
 #endif /* CHECKOUT_H */
-- 
gitgitgadget

