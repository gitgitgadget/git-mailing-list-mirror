Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FFA2F39C2
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368971; cv=none; b=ejrLbp+1cC05nACbxPTyQVMvIseG2Oc44dVSNHnEShugR8u9vbhIjPv6rka6Y5EjfpkGWPwkj/6d/5x5EuOTjJ/WUD2xSpjE+7ljM7PIDiZTEyRrdn96AnHRosS1SmXMEFSZ6UVnS/xaBgrtcQFWsK54dThC4rc5Inx2vgxNKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368971; c=relaxed/simple;
	bh=tnsR8TO9Re0KO+GGfZXtM38tJnCw37YuU+sD5RPBjBQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Td5dAJluuJN09PtBwzPQCQ5Q8js15ME8lW/bnjuZ/kTp8ojImgC4WJw71OdDMqUpUDQjei3ZivxqIpXs7LYrBWSMnPrd9A+CuT/NWBORsmBhoQXrajIatHNMI7+d2deq4AuV7/fG8JFER8srhkRtO1q8YcWUFRWyhI4isGR4Gms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSm83A3g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSm83A3g"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce7d2adef4so23892725ad.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 20:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787368969; x=1787973769; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w8ej7dEhQ5qeWwEpo8wPuyOLPf4iNA16IewG6cAl/pg=;
        b=fSm83A3gnDkQnTvRNlbLPIMkqFZl6WO81g0TvMziEN1RziwBLO+YdO9Aq0V5UgGh4w
         FpOpyew9PA0RNzyf0qR/qNt5ESq+oxgNIc58fZx9lVcjwZiVmrbzo57HZdEEUNsffIwp
         rr5Ku4d5f1hbjdwVRRmR/z0B2o1uFHHiZesk8aaoxJwBD0Y1/UXflQEVZGqUs4G7NS9t
         WuoIiRma9y7nvZhz6LURhh94qddwXGUAmYF4ghJCaWCnzzS6WvtWUM5QlrUW81KibjvD
         tIWYCNPBNCG90IUo/noZ832apP4UJS7Ot3QrpldNqxseE9m33DJ00oL9EO5ecKTj1liG
         Pu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787368969; x=1787973769;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8ej7dEhQ5qeWwEpo8wPuyOLPf4iNA16IewG6cAl/pg=;
        b=hDzfGHYX4MQMVO7ZyE+ZZ5Ejh+3iUliYZ6GGXlMsexflrXUS38RlgMU9EEXgvO92qk
         EQ41vgmMav6IDex/BCXXLUs1pfeoWy/UdcciYDy9MmAs7iQoFpFfned1pzPrSybBupMw
         1Y+oMayhUxbJzGQT3kxUb+S27lUQntsx5YoWr8lsqWDikvrI//TRGcpKKVs0Kw2ZJhPz
         HY3LzGucwpW3KeZ5yQCVTZQRWDP/s4YChBHOwRGy3dtHeRZsJs9U7tWBEe8XBHxhVMKI
         SwVaFhEg8TQGcXEgASV4JYKg7vcTsxFJEQW3XkOywkSNqnShx9y605Loa8nS9x9u+fBY
         1JfA==
X-Gm-Message-State: AFuF++nZhu5w2bpiTsBnS4ZAciYCyZ+Z005PMhcw6V2nhecE/JK8YKvx
	6KvBWpgk6zUW44NFZMutYp71cAt9QazXgQ+82H9LbjXHzEGmMQQsJeBxtt8JTw==
X-Gm-Gg: AR+sD12+lxRKj6jREJw6whKAMcDcxOB3vKVxoX/+GiQxf0kmsbKdhGLqnebt9Fk+C0Z
	tWd0/LVuIfkPKFFjKtC/UFeYtOQH9GZCLLAxuusyCsKFT011SnENr5TvHtNO/FUcJw4tZbbRupU
	XRTFyoJD8bKyKuG+lWrqRPdBqxwkV3bPwteXaJ9cC4x3DkB+cCd8xom3GziKVZyYofOMwNCTxU3
	oJpcsdnCgX9jkdOUOTl2PHwn8F6dzwgTqz/9L+20UlR3c+WwrDUPsj/ylIrZs+a+dRjYh0wNMFH
	pNsanvOpmGtLQmRTTnqEDTo7hcopuU3CtokkfP5KQTN0YXfp791uuj5b8McxJ7y0e2GmatKyl17
	Hwdt5MTTFL9HVaEJ1jW5Cer8WghnKmt6PnuCodbz4AYX+f+M/rgJuOqTw+mC5OeKoCOkiNE2GC1
	gvXgusnJ3sgbYF43i5v9Ce/jokoqsdswIpZkldkfvbcIO613WuewkASgf29iHZN+RaGNS6ItE=
X-Received: by 2002:a17:902:ec8a:b0:2d6:3c1a:85e0 with SMTP id d9443c01a7336-2d64b185640mr190105715ad.14.1787368968944;
        Fri, 21 Aug 2026 20:22:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90c0c52sm1681234eec.10.2026.08.21.20.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 20:22:48 -0700 (PDT)
Message-Id: <89c0f4d30317ebf7cda884710944e9a6f23d46fe.1787368962.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Aug 2026 03:22:41 +0000
Subject: [PATCH v7 2/3] checkout: improve message for ambiguous remote branch
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
 checkout.c         | 14 ++++++++++++--
 checkout.h         |  5 ++++-
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 650eda735f..07373615d8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,9 +1343,12 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
-static void advice_disambiguating_remotes(enum checkout_command which_command)
+static void advise_disambiguating_remotes(enum checkout_command which_command,
+					  const char *branch,
+					  const struct string_list *matched_remote_names)
 {
 	const char *cmdname;
+	struct string_list_item *item;
 
 	switch (which_command) {
 	case CHECKOUT_CHECKOUT:
@@ -1360,15 +1363,19 @@ static void advice_disambiguating_remotes(enum checkout_command which_command)
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
-			advice_disambiguating_remotes(which_command);
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

