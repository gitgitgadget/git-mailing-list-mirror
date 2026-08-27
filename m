Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4E361962
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841725; cv=none; b=T4ikaSjG7C6hy7Scs6xrM2G8a/0GnB6LNAn0d4DE+mtPeilWos/wzno9Jmg1zt5YznY6x+WMfNLL017dW/7O1pdGCOSVTpbJX77ddzNzMvKZiRld7uvpVhPGtwDzlXcyDYs9t9maY31GNniLdXXacSiyhAJxhPvXMHO+cv/G3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841725; c=relaxed/simple;
	bh=+AgU94J3waDpYLX6z6CQZjhybXdynwIrSFlO6eMw214=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZMwunV52boROAPrhbw9mRagQmj9SGGi4z0dXAcAVhaFaMaV6TAibZ3pOHQiVySNcTTDza2IuJ9pYOKEx03ghjBS2+204fxU/1nGpkV0loSqsIJBEJJsvuAaCdVR5vSIKQb3bu9gbXF0qcoy+xcNGUoYHB64RkIKB3MX7fleupe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0cQ5lh6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0cQ5lh6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e6a434cabso108383585a.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841721; x=1788446521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+R8uaSXHp+TbKpY1NxHdUV3XnjElJeKWMuRSoGnnrs8=;
        b=P0cQ5lh6PIPnC3mUIE0glsSmqkXXUpjawmosHb3Bf2PJydp2VxtDEOPyJDNIZvesfQ
         W/IzW8OUGDzIFTp0G+crgio6EclTgeF38hQx6v/ZyqBjPk7uZu/H9yiMarCyXAj7PwOb
         cJdDJV8Xx0eSR1kvGQ9o0FrYoguN6vTwi8XQvf96hVNUFNBbexrlwXh8ClB1p/kGKAiS
         NTNSJlGHAI7Ijvla7qUnBs5gN9JGJLFg8XGYcvO3d9pCuNg2ElHeNfFEG7Q4jENz/78N
         hzPoAG44OmfAmpJiBN5Ql/MQ3ZIoiYMXtFGVtNTDgrPB083v8cJjCa0aZbVHr8j23yHb
         blxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841721; x=1788446521;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+R8uaSXHp+TbKpY1NxHdUV3XnjElJeKWMuRSoGnnrs8=;
        b=slw24q0qCxzfwOKgbjiy1rGlPr+K4r9ynng2HQ+kjX1GhQnZr9j0aiJOHwhmE+8WRm
         1bUECcwglSMpTLLWhCaVBwrVQHPfttTHzReGGZs1qxKmOC3ojEU80loW0bXQwNgIkl/s
         tA+GeN43JfSrN2XPKuCrEYTLYAcvCAV87Hz2cSJrxqSbvJcf1Jjb6UpdoiwwMsqbN4Rk
         e08t12HpLMv1UXeN2mWGAzS7tgzbXB+kcN8D3IYTfWHs0FcVX0BfuPgwFA9CeRVpYsJL
         6sHnIKUHtOQC/fuccSjT3v89kRtWUO0v8Vid8O1ZH/zn9sumOHYHbmrgPL9pAMMYzK+G
         M1Ag==
X-Gm-Message-State: AFuF++lBwrCXGH55iy/FumUIWPvCrW/Vi+A3A6TiEDHUWJtFCV0ORdU+
	N7iUKNx0AOuMkxRvmttywuQ0I+QsQ/cHvkLQYM7A27j+f0EaGN+RpGog0XKkrA==
X-Gm-Gg: AR+sD11IqYILo5W5kGX7MEy257f65GSdptGLJvGpJXXyeYsfWv17U4zsZ//zVdhjEwT
	p4ofmfg8mfU81ig6O6jPdeS6vbW8k++79k2EwdQHV/dAXdvzO9eol6R+3YVHuzZav1mwfB80VWH
	OU5+81obIo1UjhdiUB4atL4u304GZEmN9F0B8bITTe/oDsw9ut2fd5jQsN/8b1tA8bBwmH2s5nf
	0ri87WQtXpvtOUA9UEwPUpZaEHBJvelbI0gb6VYWZnZSOALdudm8vda2Q8omC/DDGayENSJhpLm
	Lr1ZBDHR+0NEbyy6J0Vl6HUYcFB2G5i01Zqj90m/QbMKcM4p5Xwrq953XiIavQiTBR4Tshc93Z0
	GD7kXrZbKHGGHLSihjJKkteb6IGlolbpBvqSMO/6OEdUdwyRdT07K/a+F43H2wyAtRD0MJRLUf5
	Bcyw7LqvKrwnY6I7oZzp6jyioecobNvU6FpKX6zDTR5HmgG6csgFl5mHP8VdVtZbnDKg==
X-Received: by 2002:a05:620a:a31b:b0:914:bb06:288 with SMTP id af79cd13be357-937803d18a2mr1279056685a.22.1787841721143;
        Thu, 27 Aug 2026 07:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e616605sm466786185a.29.2026.08.27.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:42:00 -0700 (PDT)
Message-Id: <c37c9c237ab3f0b99e9fc60d650b961667a7d84b.1787841717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 14:41:55 +0000
Subject: [PATCH v10 2/4] checkout: improve message for ambiguous remote branch
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

When the user runs 'git checkout bar-topic' without specifying a
remote, and there is no local branch named bar-topic, we try to guess
which remote branch bar-topic refers to, then create a new branch
named bar-topic that tracks the remote branch.

If multiple remotes have a branch named bar-topic, we cannot determine
a single remote.

To make it easier to resolve the ambiguity, provide the names of the
matching remotes for the specified branch name.

To achieve that, add an optional feature to the
`unique_tracking_name()` function that allows the matching remote
names to be exposed to the caller.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 28 ++++++++++++++++++++--------
 builtin/worktree.c |  4 ++--
 checkout.c         | 13 +++++++++++--
 checkout.h         |  5 ++++-
 4 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3cd5fff709..2bc21aa49b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,9 +1343,12 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
-static void advise_disambiguating_remotes(enum checkout_command which_command)
+static void advise_disambiguating_remotes(enum checkout_command which_command,
+					  const char *branch,
+					  const struct string_list *matched_remote_names)
 {
 	const char *cmdname;
+	struct string_list_item *item;
 
 	switch (which_command) {
 	case CHECKOUT_CHECKOUT:
@@ -1360,15 +1363,19 @@ static void advise_disambiguating_remotes(enum checkout_command which_command)
 		break;
 	}
 
-	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to check out a remote tracking branch on <remote>,\n"
 		 "you can do so by fully qualifying the name with the --track option:\n"
 		 "\n"
-		 "    git %s --track origin/<name>\n"
+		 "    git %s --track <remote>/%s\n"
 		 "\n"
-		 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+		 "If you'd like to always have checkouts of an ambiguous name prefer\n"
 		 "one remote, e.g. the 'origin' remote, consider setting\n"
 		 "checkout.defaultRemote=origin in your config."),
-	       cmdname);
+	       cmdname, branch);
 }
 
 static char *parse_remote_branch(const char *arg,
@@ -1377,7 +1384,10 @@ static char *parse_remote_branch(const char *arg,
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
@@ -1387,12 +1397,14 @@ static char *parse_remote_branch(const char *arg,
 
 	if (!remote && num_matches > 1) {
 		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
-			advise_disambiguating_remotes(which_command);
-
+			advise_disambiguating_remotes(which_command, arg,
+						      &matched_remote_names);
 		die(_("'%s' matched multiple (%d) remote tracking branches"),
 		    arg, num_matches);
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
index 1588b116ee..a0d0229435 100644
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
+	struct string_list *remote_names;
 };
 
 #define TRACKING_NAME_DATA_INIT { 0 }
@@ -39,6 +41,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		oidcpy(dst, cb->dst_oid);
 		cb->default_dst_oid = dst;
 	}
+	if (cb->remote_names)
+		string_list_append(cb->remote_names, remote->name);
 	if (cb->dst_ref) {
 		free(query.dst);
 		return 0;
@@ -48,14 +52,19 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
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
+	cb_data.remote_names = dwim_remote_names;
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

