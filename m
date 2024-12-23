Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1C18C924
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734946572; cv=none; b=ZrtJmrrAhiSxK4u+hfGGAxZTgjtvh4c9lvU1Q1i9cmYayK8qqUDe43SSxlGcLw7mUQkct09oA3OT09PP8s69nW7EGn9KyfIkWChNkh22G+EoKP24gkxqIGCjvxITzs/urTE8VzOCuxxl5eYeD/XtXxXZCeUklulwuMiove1CoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734946572; c=relaxed/simple;
	bh=A+gIXfh1DRT4lArryzOh3t/1Qm0snvrOuz9bTMMbE2Y=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=hPIzFbTZ85Wc0ODgjrpcKxMs9osJUHwtFHukESTh69dM4yxFCWNc6nuKmJkyWbb9U7DQmrSqvlOHCngtTJXoUPy1ABhmVVaS3/LRjrYA+wgC5KKiBbhvxfiHfpTstYpQoM5Ecvo4/0txvwuAT7y7sL6ZbTPJtv3DNcd4/mO1KLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc5qoiOo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc5qoiOo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2211613f8f.3
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734946569; x=1735551369; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vA8Us0Kl+xF5zkpjsbBLzD64fBUwykhVjkWE0lLYRFE=;
        b=mc5qoiOo6uphzisrfIligp61gdKIznw5fEJXbYk07mT2XORRqwaYYHJa2DP7EYhKsd
         y3MPC+3/pym6ie9LEAFRlb8WygiIb5o5xG4tZMI9snZFJMhLScJDVwICXCvcSUgJWA7S
         Sjd0DgpMnOcgZl7ubUIBLye+KWs62GOUJqnJCaKxt6gLyO1JzE9ebU4TdfTlkNJqEk1R
         RQq5u0+SpAFk0m8Rt0pbHRy8hdyzrx7WwOuFDXcYlP3tQzo/27410fcwAaanATL0SXnj
         f9hcuRrz0dL9aSK6UJJqA9N9grrUS7/TpAMeMl8RYzG0xetOzSUav0OGViw6jL3+6hPD
         Y9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734946569; x=1735551369;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vA8Us0Kl+xF5zkpjsbBLzD64fBUwykhVjkWE0lLYRFE=;
        b=OgRMtdgqoJDO/LPqbyVtAnz797bSTV32HsltUnJP3++29moyIv7bNhF/c9s2sJKlT8
         IB2Io+Bj9JXYAS0FYnNVr3fYZRqFFJ62z56aJYXq/zx2PJLtb4sjMf19Z3Wb8qBDMEi6
         0AgsJATKF5iEzTaIDHOPhGt/+TGUXsuGTmoN0uOYpAFyGFAu+xn/7RwNZzoE3OGUDmTw
         W3sfKcDlUNItf3heXiEVTAmlsqKQsGen0P+B5Ml2yHc0M2OPjpvMCEsWKMhxcJ6qjzJ/
         uh194s5WpTLhfAsrjPjuypQ9PvV77iM3kgTSURZzoK7SGYZOpmk1oixPGxEB3Y08fP9p
         lOnA==
X-Gm-Message-State: AOJu0YxLElnZl2vsuuktZmO2KVrm7h+d2UefQ4G/YfBVdLhc+1RYNkFC
	TXWR0y5Zj/OVaoa0YSvWqdCGBBVoCQLyf+GuF5cCqbNhqA5HevryhyNpoA==
X-Gm-Gg: ASbGncvEHkefx6ahoSGFLSBNcJFzpreIsEUe6p1RLPatEf9D98J9GLqt6XiTjAPupiI
	zs6KE4tXjPNyysBwrZyM9eA7utE5MRP0t9n8o+bdcCp18INFazZo+CvCgWNNOSF6LIxixi9GfJK
	haVNejcuj8F5xilg17RxcT4l0fJ2gbyqFkBLPI1D3hIDMQ/8JHIkxHSRUQ/r9tTZQoVOhuZHt0r
	7EtTEzkYkyeeKhLxkVGo5C+GIBCOm5iKL4ImFk4CaszNb09z/ILMXZ92g==
X-Google-Smtp-Source: AGHT+IHgnmzKUuqUSre1ZySPtHIFGPeONMn1LHuPN7zRPKu8EXS530RAeY3xP1BRMN2k/rqK+owkQg==
X-Received: by 2002:a05:6000:1866:b0:38a:20d9:32e6 with SMTP id ffacd0b85a97d-38a223ff35bmr9535462f8f.45.1734946568455;
        Mon, 23 Dec 2024 01:36:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1143dsm162880485e9.18.2024.12.23.01.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:36:07 -0800 (PST)
Message-Id: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Dec 2024 09:36:06 +0000
Subject: [PATCH] maintenance: add prune-remote-refs task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: "mailto:gitster@pobox.com" <[gitster@pobox.com]>,
    "mailto:ps@pks.im" <[ps@pks.im]>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Remote-tracking refs can accumulate in local repositories even as branches
are deleted on remotes, impacting git performance negatively. Existing
alternatives to keep refs pruned have a few issues — 

1. The `fetch.prune` config automatically cleans up remote ref on fetch,
but also pulls in new ref from remote which is an undesirable side-effect.

2.`git remote prune` cleans up refs without adding to the existing list
but requires periodic user intervention.

This adds a new maintenance task 'prune-remote-refs' that runs
'git remote prune' for each configured remote daily. This provides an
automated way to clean up stale remote-tracking refs — especially when
users may not do a full fetch.

This task is disabled by default.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
---
    maintenance: add prune-remote-refs task
    
    As discussed previously on:
    https://lore.kernel.org/git/xmqqwmfr112w.fsf@gitster.g/T/#t
    
    Remote-tracking refs can accumulate in local repositories even as
    branches are deleted on remotes, impacting git performance negatively.
    Existing alternatives to keep refs pruned have a few issues — 
    
     1. The fetch.prune config automatically cleans up remote ref on fetch,
        but also pulls in new ref from remote which is an undesirable
        side-effect.
    
    2.git remote prune cleans up refs without adding to the existing list
    but requires periodic user intervention.
    
    This adds a new maintenance task 'prune-remote-refs' that runs 'git
    remote prune' for each configured remote daily. This provides an
    automated way to clean up stale remote-tracking refs — especially when
    users may not do a full fetch.
    
    This task is disabled by default.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1838%2Fpastelsky%2Fsk%2Fadd-remote-prune-maintenance-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1838/pastelsky/sk/add-remote-prune-maintenance-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1838

 Documentation/git-maintenance.txt | 20 ++++++++++++++
 builtin/gc.c                      | 42 +++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 44 +++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6e6651309d3..0c8f1e01ccd 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -158,6 +158,26 @@ pack-refs::
 	need to iterate across many references. See linkgit:git-pack-refs[1]
 	for more information.
 
+prune-remote-refs::
+	The `prune-remote-refs` task runs `git remote prune` on each remote
+	repository registered in the local repository. This task helps clean
+	up deleted remote branches, improving the performance of operations
+	that iterate through the refs. See linkgit:git-remote[1] for more
+	information. This task is disabled by default.
++
+NOTE: This task is opt-in to prevent unexpected removal of remote refs
+for users of git-maintenance. For most users, configuring `fetch.prune=true`
+is a acceptable solution, as it will automatically clean up stale remote-tracking
+branches during normal fetch operations. However, this task can be useful in
+specific scenarios:
++
+--
+* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
+  where `fetch.prune` would not affect refs outside the fetched hierarchy
+* When third-party tools might perform unexpected full fetches, and you want
+  periodic cleanup independently of fetch operations
+--
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4ae5196aedf..9acf1d29895 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "remote.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "commit.h"
@@ -913,6 +914,40 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int collect_remote(struct remote *remote, void *cb_data)
+{
+	struct string_list *list = cb_data;
+
+	if (!remote->url.nr)
+		return 0;
+
+	string_list_append(list, remote->name);
+	return 0;
+}
+
+static int maintenance_task_prune_remote(struct maintenance_run_opts *opts UNUSED,
+					 struct gc_config *cfg UNUSED)
+{
+	struct string_list_item *item;
+	struct string_list remotes_list = STRING_LIST_INIT_NODUP;
+	struct child_process child = CHILD_PROCESS_INIT;
+	int result = 0;
+
+	for_each_remote(collect_remote, &remotes_list);
+
+	for_each_string_list_item (item, &remotes_list) {
+		const char *remote_name = item->string;
+		child.git_cmd = 1;
+		strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
+
+		if (run_command(&child))
+			result = error(_("failed to prune '%s'"), remote_name);
+	}
+
+	string_list_clear(&remotes_list, 0);
+	return result;
+}
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 
@@ -1375,6 +1410,7 @@ enum maintenance_task_label {
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
+	TASK_PRUNE_REMOTE_REFS,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1411,6 +1447,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_pack_refs,
 		pack_refs_condition,
 	},
+	[TASK_PRUNE_REMOTE_REFS] = {
+		"prune-remote-refs",
+		maintenance_task_prune_remote,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
@@ -1505,6 +1545,8 @@ static void initialize_maintenance_strategy(void)
 		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
 		tasks[TASK_PACK_REFS].enabled = 1;
 		tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
+		tasks[TASK_PRUNE_REMOTE_REFS].enabled = 0;
+		tasks[TASK_PRUNE_REMOTE_REFS].schedule = SCHEDULE_DAILY;
 	}
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0ce4ba1cbef..60a0c3f8353 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -446,6 +446,50 @@ test_expect_success 'pack-refs task' '
 	test_subcommand git pack-refs --all --prune <pack-refs.txt
 '
 
+test_expect_success 'prune-remote-refs task not enabled by default' '
+	git clone . prune-test &&
+	(
+		cd prune-test &&
+		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run 2>err &&
+		test_subcommand ! git remote prune origin <prune.txt
+	)
+'
+
+test_expect_success 'prune-remote-refs task cleans stale remote refs' '
+	test_commit initial &&
+
+	# Create two separate remote repos
+	git clone . remote1 &&
+	git clone . remote2 &&
+
+	git clone . prune-test-clean &&
+	(
+		cd prune-test-clean &&
+		git config maintenance.prune-remote-refs.enabled true &&
+
+		# Add both remotes
+		git remote add remote1 "../remote1" &&
+		git remote add remote2 "../remote2" &&
+
+		# Create and push branches to both remotes
+		git branch -f side2 HEAD &&
+		git push remote1 side2 &&
+		git push remote2 side2 &&
+
+		# Rename branches in each remote to simulate a stale branch
+		git -C ../remote1 branch -m side2 side3 &&
+		git -C ../remote2 branch -m side2 side4 &&
+
+		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run --task=prune-remote-refs &&
+
+		# Verify pruning happened for both remotes
+		test_subcommand git remote prune remote1 <prune.txt &&
+		test_subcommand git remote prune remote2 <prune.txt &&
+		test_must_fail git rev-parse refs/remotes/remote1/side2 &&
+		test_must_fail git rev-parse refs/remotes/remote2/side2
+	)
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
