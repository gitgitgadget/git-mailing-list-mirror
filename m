Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3131327D
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741125; cv=none; b=gNXV/gqolu9Tcg3YUoOJPKedmOedFMAFOT8aDqlhHbT+/4G5kcfibqufNzHSKnczXm1sboH1nlsn/z0qjm68Sb5UkidE5o1hHdyoVfXwvuAzaeI5UFON3iAQTgdP4wzEt3jg+xFSTAgWFEKYwNiQhWPYLBI88e/Zfb9/tAkiF50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741125; c=relaxed/simple;
	bh=tnsR8TO9Re0KO+GGfZXtM38tJnCw37YuU+sD5RPBjBQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YFT0yXIgBM8Nhg/W2Q4k9EpPH7UrH3S5WRYVsqTWLSjiGLJTbRlgV5lEFIpwFDMkbnULsCg79K/4h0laCmFnVtkh/DKYAg885xdR8cpLeUOts7q/H4dRNjVx2D2Bz3c5Q4Tn8pXX0O+mFnWmKkOaSVK5TPT6/o19sQIzVz3kcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmwimw/P; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmwimw/P"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-462df62f872so2047795fac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741118; x=1788345918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w8ej7dEhQ5qeWwEpo8wPuyOLPf4iNA16IewG6cAl/pg=;
        b=Gmwimw/PvvgdA1XjFfAtmcjzNGn3/SdCcrMtfTmDxNHHQC9JYi1O4I9MnFIzpAVgJj
         DtxLXCreO5zzND0+JgsjAupXID5cQ3O92svZYKbDsuchoTcfkUkfWalgJ0aGjGTSB30H
         9icdl29M866NT7b9SBAhV+0gEGf+lQB6KIr0qnnTPZ2fSwHtN5t+EBJjUv76IuPJVw4u
         L5Dc/YONnK0fXzhaHlyNBqb3F1NOEfAhcF81Gi7b1/gRFQvfM8kLV6zJv54TJB1/C1hn
         CXEEP6W8M/wnc2eC45D5GlP8CIA9fy0mbDVsr8JwnuYB14yBO7x3ONR9JzW5SDYvf7MV
         vD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741118; x=1788345918;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8ej7dEhQ5qeWwEpo8wPuyOLPf4iNA16IewG6cAl/pg=;
        b=M3mzLYO3qhs7GhGxINsyuqli/ItO9O9DffW2WTQhGMv7JwMm+VS7HQBbxyDveyZkRb
         C6Hl/v39X9t5LgH9DG81+jLfCH98sd7rKZ+04Lwx1jgmoj1huBScAC1fJ5XktddRftfU
         TqoedkiDzmENpa/u+Hefxi3NFcj7cxxRk4dwaaNGL9WhjUULwJL+T5skA1yOcG/WyytH
         JSuSVG6xWcFwbVKzckIbtukZl1aTs481ZWtJW45oivHL3Eo9UREw7BjazEsOHEPtI9Qj
         nfjUA5AZbqzhchL5jPcgFu2iK/AJHSP8wTCslQwPLmvAru1Sm/g/t5SCHpOzwioeUz/L
         9UMQ==
X-Gm-Message-State: AFuF++k6hEMDPLsphJwe1wZ/gckjxSXYHGpzIMl3Jf3l2+s8mbZe+mz5
	o96CLgOJXidbbSO/KgB3h0cAHvtO32ztXRwSYB8GOswNcX2yzkD6zCDhjQY+F2jY
X-Gm-Gg: AR+sD11gFGV5eMlITU9iaSQkV+TQf/6+HyZei9ZUXF8zNP4ry2LUuFRCwhAITIttA8g
	9LOom+gW3WGtZyfVlbU91E18hDZHJbuDwsbh1vwdTkdCPy6vjM5UpxvHss9b6ctI8SgYKZ5EAgh
	vzGtlQLvMjC/aW1YPFRamH1DftUEM7lTVI6k0Wx9cCyYaHEKrdH0aooOo2FeM1zvNnFNeGidvTU
	BPFnkeThNhOAYpd3GZ6RZrZdRqqZ4xy+HHhOYlBBfX+G1u4W6ezNMoTt1g+bpYFyZsvMHlmC5F1
	MVDyYMyUmKrigEtSNqY+B714UelXz9ddqiAoc6F4X6gPtv67Y0gU2+gi9C4XNIhh7LCcRvbw91T
	jDRYRjflyRayEM46ry26h4zKzZ3fiqKb4lmMGtiMypZsEnRUCoDqQXzoqKTaPQIeJSRSp9dlEMS
	3PlqmjcMQ+OqTL3veXAcIYatbF9fMG3eMZBuK5EoxwPvjTcRC6MQhwBaoox2Tylb6xcM7So7tOI
	A==
X-Received: by 2002:a05:6820:a293:20b0:6b0:4a36:fb2c with SMTP id 006d021491bc7-6b19fcc2e3cmr3584863eaf.4.1787741118438;
        Wed, 26 Aug 2026 03:45:18 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.19.227])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bdb47sm1508133eaf.1.2026.08.26.03.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:45:17 -0700 (PDT)
Message-Id: <89c0f4d30317ebf7cda884710944e9a6f23d46fe.1787741111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 10:45:08 +0000
Subject: [PATCH v9 2/4] checkout: improve message for ambiguous remote branch
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

