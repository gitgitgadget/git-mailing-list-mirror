Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676533DC4B7
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259844; cv=none; b=gEKptGYpPBsP5r2A3Nr8ISxPC4yCrBsvrqkFXm8dmpUM31jgY/uvW/VY2AF2wcnA7A/oKWbCPmWi28fAcXdT7FiNja3OiGpO61nqalJRKc6jHNQWSpJKHcYIuc9H2KTRkSivtI3CR7AgFuHfar7uPK1OUf46T5wvRtivH7GRnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259844; c=relaxed/simple;
	bh=DYWQMbJSVvTcWvH9ZYmFdehtdEQF99/QI+qUT07CTDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KVrFRXcpMjMDfeFXAdHJePC+jRkJff442Ys1GfOxJvpn/u44wU1VdDas3XrqcawtLH6VYl0Ke+/Fgacn0npH9eOoxl9HsJ+ZraoCAXf6Se9b2eD7trA0ob81rWjj52OVSKv63JxHf3SpvAONX9aSK+al4eAa0xgppkD9qgciAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPRCdTpp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPRCdTpp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d53197d8b5so3660305ad.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259842; x=1787864642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6jH3RGUHiwGmPwrueH6zfxkqq+NTZyjRAbEZN1YgLJ4=;
        b=GPRCdTppv7FiWgL2DjkEWg1UW/c+Ax9P5NWqEe3srv5pls2Ho0umRuJ1wc6Mw62fPm
         SHfs6lZh3GOgZ4GTYIJemzVdk5msbZJ8YRfysxBqx9miatMnE6KNDR2Rc2p53N07Zgj2
         E9KOIfP9rUrs5bgHdkNn3jIjI6YpEU8DRNfu5PjUdZzwwgGIwb96DCHdFiFx5e+tVcMN
         aeCNL0zHqKmWpLNTtNdhYhF4LHi8p93xJkKTZE4VYz73k/kZGtnVwhl2AVlj48ZlBojW
         5hixBgGYCH1L+1XRgpJj2WfV3eIvGJTKH5l6WXiCwDHNoSmEZnvwbJ81t2HGQioqqJAZ
         ARqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259842; x=1787864642;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6jH3RGUHiwGmPwrueH6zfxkqq+NTZyjRAbEZN1YgLJ4=;
        b=BCdNT8xOtsViU2HkUCQkrKtDLcC6XopmehiF6CWqkTp4uwCxyKRBrij1f6BUqr5HYl
         8dLhbQlQpDi1P1qr4V+GDXCteZOP88woAvRbKlaBqwd2swwdM1gaaZ0hQOVOhr1Tw4u+
         5MtYZHCVIjChNWN3lej7uK1W+N28ILxXl+aYagDdchHa/Dtc8sKOZcrTVDnCDDBJYYqD
         z5Fu/b6Nebqp4btgbehROxcROHM7WRKIELgvWXk7ZAfQp3ZdljLa2bf06tBKyPA+vRH4
         EydTIZf1J7HEGPUXqixicUK9rtJZ/rEJkp8DrP7S1d609jTIfQiJfWv00yrV6nbosToz
         fQtg==
X-Gm-Message-State: AFuF++nQo8XilbeZsuvc9IZ+PiltC0yio/0TaldZvJogmBWAhAUIpgGt
	cqVX3ByNfiFwHukCjVriOlwIoyj3yAvws9FEn3KAV2YhRle46h6yqFN4Bpc32Q+A
X-Gm-Gg: AR+sD11wEPn12WoHv55E0ksatDHKojJE0VsSz4a53+Bvxw7MfLb6DVTix6OtmqQfGhZ
	2ISqHKt5TyvXC9pf93+B4kntO9tCLRuq8PGjP5G/qAlssiVhR8NPnjpHxKz8JaJzh+wfcg9OWEF
	ZrH6spJQGMJC0YJILo035TKqiXiZ51GFSNL9WiwwIxSA31ShcC1ct2hvq75Jz15Ex8BFwkxHdlI
	q6FQ3A4KMoVavqlry4r+Eh7NSKxFo6jh74+oiNkSPCv2O6H3FcyX8oLyBVFJNge2qMUKnJlcZHa
	MZAc16xbTb4oOhevf7rHHPgq0q9K4TObit6scdvr8MxVYW/FiuBb5tDry78E2PqL28K0WfDVsqO
	0CQXyzLI5BX9giUdtuV9dggZ07CfKrJuOfdC0WujqNA8NAoUEEewtzQ6MVYS4cNVVQdft92AdE5
	k+mRp6dCunXi4bhvFrJjHKsA8wPgC4n2yBfUiT3hTauoU1VnVJmSdUVLEulXKx
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d64afa4e37mr28330335ad.6.1787259842418;
        Thu, 20 Aug 2026 14:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327cb5a9831sm12642725eec.21.2026.08.20.14.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:04:01 -0700 (PDT)
Message-Id: <97e99ae31e6f0405e1782c96b311f9760de13e42.1787259838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 21:03:57 +0000
Subject: [PATCH v6 2/3] checkout: improve message for ambiguous remote branch
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

To achieve that, we add an optional feature to the
`unique_tracking_name()` function that allows the matched remote name
to be exposed to the caller.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 28 ++++++++++++++++++++--------
 builtin/worktree.c |  4 ++--
 checkout.c         | 14 ++++++++++++--
 checkout.h         |  5 ++++-
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 650eda735f..35227f7cbd 100644
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
+	advise(_("Branches with the same name appears in multiple remotes:"));
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

