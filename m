Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9081ACA
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928041; cv=none; b=KW3L+euowC4wVAtsJd1kL+PAzVdNSQLjBCVBwEu+syFTY8SlCdO5aCD0wSwsBxbd3ZWDBaMtZNhQyqZPPqn6//9HgXhZU6cdXfLw9XjXEEW314H0DdF/eUu/5F0qne3EYhTT9lIPbTOF9KNsdx3vaa3PGDcel/V2APMnvMcVQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928041; c=relaxed/simple;
	bh=3AKggYiXUliRD5+jNgnLRR7KfeElNNma6DpVDpAMURQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jQeoa58X3niV+2lbneJe4A4tp+mMXlIPIL8bFOB57O36/ld92kvlXQy1dYLcVSNNrNLbY0o9D5kMdbiWh5vxaA+V20c++dbmAMdJmntS1kN9fr09m62XkAPpCgyhPHjEmWNtTiZhG1E9eRJw/I6u9MMeqVTE/Qsy5oR8gbY6ZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSCUcVCF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSCUcVCF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso12050518f8f.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735928037; x=1736532837; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6G9eq33r2R+/Qi+Vg212WkX7WXeGJcjfjosNx48Rw0=;
        b=WSCUcVCFn2F/M6hc8zo8me1fTAUcx8eH8mC2k6pigOCeBhRaJ8q29VvPxJG2dYNb7z
         IdycvC+n75G+UyDGlCIrrurNBTeGTPLuhgE+jBeyAHyJ/V5DVUzk8CQmghKFR9Q30XHe
         oo7MfdamVm28rx0ixDmlv5Vfe/f/GsylvQj7J6uND4zoZx1eOuZvIqZYkTRdtWmCXrSN
         3RE0SqTWwSNkDQK78DHwZiKnal1TSbqewMSkuz/A/8Nk2VuR9cnsUOxvAHraR0Wn5nwH
         uyNxInPWg8nx0R9HP03bBoikBWdEu31pw9NRf7gLCJXAg3Kqk/d9smubQNWkqk/ihI74
         /Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735928037; x=1736532837;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6G9eq33r2R+/Qi+Vg212WkX7WXeGJcjfjosNx48Rw0=;
        b=JBv9afYww1a3tSFoK5HdqHvpK+C3hQ1TKND7PBw0KfvcNEUo8HbOyjOOlUxxIjwVUQ
         6fli1xqgxoLTY0PpDH+iXyv5/Wn9Y+XrfzK4Lxved1XMyUFRCBm4Z97TZr6fIVqIu5JN
         k1IXCUkBdzwZnG1zmoysd7qlqiHMLTAotDhKDrLBegMM6Cdq0LAcsOPDBRJ87ojiesg8
         /ImJzmbcrmVx9iD0jJz71mL/SIXplvX31Tfx80Kw2jNrIhiKuIhmIQmNlOBVsLMCdwLe
         sIcHLo4SOHAnlCk+BOIFgvAFWcpN1VShRRQdQEjUFXes65felTzrPeurZ7pfUnqCtlum
         dNOQ==
X-Gm-Message-State: AOJu0Yw7OMNkBORWDCix5Ufpd7RJAtURo5tvOFURJ6DWrJirG2bPJT/n
	Dj2uGuH/jN9de8FOpPebCb/31EpK+n2rSYRO9B3Le8MyKLomAvbE23drKQ==
X-Gm-Gg: ASbGnct/7dM8Ns7SWAbFf2Ty7T++IqtiWQ5PIUiN/MNKCFh9ZzhY4vV50+jFyZAjErK
	D9QzqRIMBVoofo8Jq9FuUrw6kJKhbG9iFpTC7qRta7BjAIz3ecWGuwVzVwiRS1fRgv140y8iDwD
	TW8qFl0EPmZfzed3/KCIsAS91H5ciU3h2XjfG2pikocAukkKKUEacAB82UHWG6g50suq+MkSU6p
	24vH6WD8kedwlT2wJZ+JcGoT5aiSXC3gDv7FF6RRGMOfh2HwXYK02IYvw==
X-Google-Smtp-Source: AGHT+IH3KGDQcLyg5g8ZAVG1bsbhpcIoBqfeiG8E0DFjN42Cww2z4wA1DFawudLnCw8c4BLEwidKEA==
X-Received: by 2002:adf:ae01:0:b0:38a:615c:825b with SMTP id ffacd0b85a97d-38a615c8353mr7357438f8f.21.1735928036546;
        Fri, 03 Jan 2025 10:13:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b207sm521825155e9.32.2025.01.03.10.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 10:13:56 -0800 (PST)
Message-Id: <pull.1838.v3.git.1735928035056.gitgitgadget@gmail.com>
In-Reply-To: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
References: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 18:13:54 +0000
Subject: [PATCH v3] maintenance: add prune-remote-refs task
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>,
    Shubham Kanodia <shubham.kanodia10@gmail.com>

From: Shubham Kanodia <shubham.kanodia10@gmail.com>

Remote-tracking refs can accumulate in local repositories even as branches
are deleted on remotes, impacting git performance negatively. Existing
alternatives to keep refs pruned have a few issues:

  1. Running `git fetch` with either `--prune` or `fetch.prune=true`
     set, with the default refspec to copy all their branches into
     our remote-tracking branches, will prune stale refs, but also
     pulls in new branches from remote.  That is undesirable if the
     user wants to only work with a selected few remote branches.

  2. `git remote prune` cleans up refs without adding to the
     existing list but requires periodic user intervention.

Add a new maintenance task 'prune-remote-refs' that runs 'git remote
prune' for each configured remote daily.  Leave the task disabled by
default, as it may be unexpected to see their remote-tracking
branches to disappear while they are not watching for unsuspecting
users.

Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1838%2Fpastelsky%2Fsk%2Fadd-remote-prune-maintenance-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1838/pastelsky/sk/add-remote-prune-maintenance-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1838

Range-diff vs v2:

 1:  4d6c143c970 ! 1:  7954df1009a maintenance: add prune-remote-refs task
     @@ Commit message
      
          Remote-tracking refs can accumulate in local repositories even as branches
          are deleted on remotes, impacting git performance negatively. Existing
     -    alternatives to keep refs pruned have a few issues — 
     +    alternatives to keep refs pruned have a few issues:
      
     -    1. Running `git fetch` with either `--prune` or `fetch.prune=true` set will
     -    prune stale refs, but requires a manual operation and also pulls in new
     -    refs from remote which can be an undesirable side-effect.
     +      1. Running `git fetch` with either `--prune` or `fetch.prune=true`
     +         set, with the default refspec to copy all their branches into
     +         our remote-tracking branches, will prune stale refs, but also
     +         pulls in new branches from remote.  That is undesirable if the
     +         user wants to only work with a selected few remote branches.
      
     -    2.`git remote prune` cleans up refs without adding to the existing list
     -    but requires periodic user intervention.
     +      2. `git remote prune` cleans up refs without adding to the
     +         existing list but requires periodic user intervention.
      
     -    This adds a new maintenance task 'prune-remote-refs' that runs
     -    'git remote prune' for each configured remote daily. This provides an
     -    automated way to clean up stale remote-tracking refs — especially when
     -    users may not do a full fetch.
     -
     -    This task is disabled by default.
     +    Add a new maintenance task 'prune-remote-refs' that runs 'git remote
     +    prune' for each configured remote daily.  Leave the task disabled by
     +    default, as it may be unexpected to see their remote-tracking
     +    branches to disappear while they are not watching for unsuspecting
     +    users.
      
          Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-maintenance.txt ##
      @@ Documentation/git-maintenance.txt: pack-refs::
     @@ Documentation/git-maintenance.txt: pack-refs::
      +	information. This task is disabled by default.
      ++
      +NOTE: This task is opt-in to prevent unexpected removal of remote refs
     -+for users of git-maintenance. For most users, configuring `fetch.prune=true`
     -+is a acceptable solution, as it will automatically clean up stale remote-tracking
     ++for users of linkgit:git-maintenance[1]. For most users, configuring `fetch.prune=true`
     ++is an acceptable solution, as it will automatically clean up stale remote-tracking
      +branches during normal fetch operations. However, this task can be useful in
      +specific scenarios:
      ++
     @@ builtin/gc.c: static int maintenance_opt_schedule(const struct option *opt, cons
       	return 0;
       }
       
     -+static int prune_remote(struct remote *remote, void *cb_data UNUSED)
     ++struct remote_cb_data {
     ++	struct maintenance_run_opts *maintenance_opts;
     ++	struct string_list failed_remotes;
     ++};
     ++
     ++static void report_failed_remotes(struct string_list *failed_remotes,
     ++				  const char *action_name)
     ++{
     ++	if (failed_remotes->nr) {
     ++		int i;
     ++		struct strbuf msg = STRBUF_INIT;
     ++		strbuf_addf(&msg, _("failed to %s the following remotes: "),
     ++			    action_name);
     ++		for (i = 0; i < failed_remotes->nr; i++) {
     ++			if (i)
     ++				strbuf_addstr(&msg, ", ");
     ++			strbuf_addstr(&msg, failed_remotes->items[i].string);
     ++		}
     ++		error("%s", msg.buf);
     ++		strbuf_release(&msg);
     ++	}
     ++}
     ++
     ++static int prune_remote(struct remote *remote, void *cb_data)
      +{
      +	struct child_process child = CHILD_PROCESS_INIT;
     ++	struct remote_cb_data *data = cb_data;
      +
      +	if (!remote->url.nr)
      +		return 0;
     @@ builtin/gc.c: static int maintenance_opt_schedule(const struct option *opt, cons
      +	child.git_cmd = 1;
      +	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
      +
     -+	return !!run_command(&child);
     ++	if (run_command(&child))
     ++		string_list_append(&data->failed_remotes, remote->name);
     ++
     ++	return 0;
      +}
      +
      +static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
      +					 struct gc_config *cfg UNUSED)
      +{
     -+	if (for_each_remote(prune_remote, opts)) {
     -+		error(_("failed to prune remotes"));
     -+		return 1;
     -+	}
     ++	struct remote_cb_data cbdata = { .maintenance_opts = opts,
     ++					 .failed_remotes = STRING_LIST_INIT_DUP };
      +
     -+	return 0;
     ++	int result;
     ++	result = for_each_remote(prune_remote, &cbdata);
     ++
     ++	report_failed_remotes(&cbdata.failed_remotes, "prune");
     ++	if (cbdata.failed_remotes.nr)
     ++		result = 1;
     ++
     ++	string_list_clear(&cbdata.failed_remotes, 0);
     ++	return result;
      +}
      +
       /* Remember to update object flag allocation in object.h */
       #define SEEN		(1u<<0)
       
     +@@ builtin/gc.c: static int maintenance_task_commit_graph(struct maintenance_run_opts *opts,
     + 
     + static int fetch_remote(struct remote *remote, void *cbdata)
     + {
     +-	struct maintenance_run_opts *opts = cbdata;
     + 	struct child_process child = CHILD_PROCESS_INIT;
     ++	struct remote_cb_data *data = cbdata;
     + 
     + 	if (remote->skip_default_update)
     + 		return 0;
     +@@ builtin/gc.c: static int fetch_remote(struct remote *remote, void *cbdata)
     + 		     "--no-write-fetch-head", "--recurse-submodules=no",
     + 		     NULL);
     + 
     +-	if (opts->quiet)
     ++	if (data->maintenance_opts->quiet)
     + 		strvec_push(&child.args, "--quiet");
     + 
     +-	return !!run_command(&child);
     ++	if (run_command(&child))
     ++		string_list_append(&data->failed_remotes, remote->name);
     ++
     ++	return 0;
     + }
     + 
     + static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
     + 				     struct gc_config *cfg UNUSED)
     + {
     +-	if (for_each_remote(fetch_remote, opts)) {
     +-		error(_("failed to prefetch remotes"));
     +-		return 1;
     ++	struct remote_cb_data cbdata = { .maintenance_opts = opts,
     ++					 .failed_remotes = STRING_LIST_INIT_DUP };
     ++
     ++	int result = 0;
     ++
     ++	if (for_each_remote(fetch_remote, &cbdata)) {
     ++		error(_("failed to prefetch some remotes"));
     ++		result = 1;
     + 	}
     + 
     +-	return 0;
     ++	report_failed_remotes(&cbdata.failed_remotes, "prefetch");
     ++	if (cbdata.failed_remotes.nr)
     ++		result = 1;
     ++
     ++	string_list_clear(&cbdata.failed_remotes, 0);
     ++	return result;
     + }
     + 
     + static int maintenance_task_gc(struct maintenance_run_opts *opts,
      @@ builtin/gc.c: enum maintenance_task_label {
       	TASK_GC,
       	TASK_COMMIT_GRAPH,
     @@ t/t7900-maintenance.sh: test_expect_success 'pack-refs task' '
      +		test_must_fail git rev-parse refs/remotes/remote2/side2
      +	)
      +'
     ++
     ++test_expect_success 'prune-remote-refs task continues to prune remotes even if some fail' '
     ++	test_commit initial-prune-remote-refs &&
     ++
     ++	git clone . remote-bad1 &&
     ++	git clone . remote-bad2 &&
     ++	git clone . remote-good &&
     ++
     ++	git clone . prune-test-partial &&
     ++	(
     ++		cd prune-test-partial &&
     ++		git config maintenance.prune-remote-refs.enabled true &&
     ++
     ++		# Add remotes in alphabetical order to ensure processing order
     ++		git remote add aaa-bad1 "../remote-bad1" &&
     ++		git remote add bbb-bad2 "../remote-bad2" &&
     ++		git remote add ccc-good "../remote-good" &&
     ++
     ++		# Create and push branches to all remotes
     ++		git branch -f side2 HEAD &&
     ++		git push aaa-bad1 side2 &&
     ++		git push bbb-bad2 side2 &&
     ++		git push ccc-good side2 &&
     ++
     ++		# Rename branch in good remote to simulate a stale branch
     ++		git -C ../remote-good branch -m side2 side3 &&
     ++
     ++		# Break the bad remotes by removing their directories
     ++		rm -rf ../remote-bad1 ../remote-bad2 &&
     ++
     ++		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run --task=prune-remote-refs 2>err || true &&
     ++
     ++		# Verify pruning happened for good remote despite bad remote failures
     ++		test_subcommand git remote prune ccc-good <prune.txt &&
     ++		test_must_fail git rev-parse refs/remotes/ccc-good/side2 &&
     ++		test_grep "error: failed to prune the following remotes: aaa-bad1, bbb-bad2" err
     ++	)
     ++'
      +
       test_expect_success '--auto and --schedule incompatible' '
       	test_must_fail git maintenance run --auto --schedule=daily 2>err &&


 Documentation/git-maintenance.txt | 20 +++++++
 builtin/gc.c                      | 92 ++++++++++++++++++++++++++++---
 t/t7900-maintenance.sh            | 82 +++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 6e6651309d3..df59d43ec88 100644
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
+for users of linkgit:git-maintenance[1]. For most users, configuring `fetch.prune=true`
+is an acceptable solution, as it will automatically clean up stale remote-tracking
+branches during normal fetch operations. However, this task can be useful in
+specific scenarios:
++
+--
+* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
+  where `fetch.prune` would only affect refs that are explicitly fetched.
+* When third-party tools might perform unexpected full fetches, and you want
+  periodic cleanup independently of fetch operations.
+--
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de27..ae2a6762a92 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -23,6 +23,7 @@
 #include "lockfile.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "remote.h"
 #include "sigchain.h"
 #include "strvec.h"
 #include "commit.h"
@@ -916,6 +917,63 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	return 0;
 }
 
+struct remote_cb_data {
+	struct maintenance_run_opts *maintenance_opts;
+	struct string_list failed_remotes;
+};
+
+static void report_failed_remotes(struct string_list *failed_remotes,
+				  const char *action_name)
+{
+	if (failed_remotes->nr) {
+		int i;
+		struct strbuf msg = STRBUF_INIT;
+		strbuf_addf(&msg, _("failed to %s the following remotes: "),
+			    action_name);
+		for (i = 0; i < failed_remotes->nr; i++) {
+			if (i)
+				strbuf_addstr(&msg, ", ");
+			strbuf_addstr(&msg, failed_remotes->items[i].string);
+		}
+		error("%s", msg.buf);
+		strbuf_release(&msg);
+	}
+}
+
+static int prune_remote(struct remote *remote, void *cb_data)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct remote_cb_data *data = cb_data;
+
+	if (!remote->url.nr)
+		return 0;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
+
+	if (run_command(&child))
+		string_list_append(&data->failed_remotes, remote->name);
+
+	return 0;
+}
+
+static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
+					 struct gc_config *cfg UNUSED)
+{
+	struct remote_cb_data cbdata = { .maintenance_opts = opts,
+					 .failed_remotes = STRING_LIST_INIT_DUP };
+
+	int result;
+	result = for_each_remote(prune_remote, &cbdata);
+
+	report_failed_remotes(&cbdata.failed_remotes, "prune");
+	if (cbdata.failed_remotes.nr)
+		result = 1;
+
+	string_list_clear(&cbdata.failed_remotes, 0);
+	return result;
+}
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 
@@ -1036,8 +1094,8 @@ static int maintenance_task_commit_graph(struct maintenance_run_opts *opts,
 
 static int fetch_remote(struct remote *remote, void *cbdata)
 {
-	struct maintenance_run_opts *opts = cbdata;
 	struct child_process child = CHILD_PROCESS_INIT;
+	struct remote_cb_data *data = cbdata;
 
 	if (remote->skip_default_update)
 		return 0;
@@ -1048,21 +1106,34 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 		     "--no-write-fetch-head", "--recurse-submodules=no",
 		     NULL);
 
-	if (opts->quiet)
+	if (data->maintenance_opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	return !!run_command(&child);
+	if (run_command(&child))
+		string_list_append(&data->failed_remotes, remote->name);
+
+	return 0;
 }
 
 static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
 				     struct gc_config *cfg UNUSED)
 {
-	if (for_each_remote(fetch_remote, opts)) {
-		error(_("failed to prefetch remotes"));
-		return 1;
+	struct remote_cb_data cbdata = { .maintenance_opts = opts,
+					 .failed_remotes = STRING_LIST_INIT_DUP };
+
+	int result = 0;
+
+	if (for_each_remote(fetch_remote, &cbdata)) {
+		error(_("failed to prefetch some remotes"));
+		result = 1;
 	}
 
-	return 0;
+	report_failed_remotes(&cbdata.failed_remotes, "prefetch");
+	if (cbdata.failed_remotes.nr)
+		result = 1;
+
+	string_list_clear(&cbdata.failed_remotes, 0);
+	return result;
 }
 
 static int maintenance_task_gc(struct maintenance_run_opts *opts,
@@ -1378,6 +1449,7 @@ enum maintenance_task_label {
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 	TASK_PACK_REFS,
+	TASK_PRUNE_REMOTE_REFS,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1414,6 +1486,10 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_pack_refs,
 		pack_refs_condition,
 	},
+	[TASK_PRUNE_REMOTE_REFS] = {
+		"prune-remote-refs",
+		maintenance_task_prune_remote,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
@@ -1508,6 +1584,8 @@ static void initialize_maintenance_strategy(void)
 		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
 		tasks[TASK_PACK_REFS].enabled = 1;
 		tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
+		tasks[TASK_PRUNE_REMOTE_REFS].enabled = 0;
+		tasks[TASK_PRUNE_REMOTE_REFS].schedule = SCHEDULE_DAILY;
 	}
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1909aed95e0..34e8fa6b5fb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -447,6 +447,88 @@ test_expect_success 'pack-refs task' '
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
+test_expect_success 'prune-remote-refs task continues to prune remotes even if some fail' '
+	test_commit initial-prune-remote-refs &&
+
+	git clone . remote-bad1 &&
+	git clone . remote-bad2 &&
+	git clone . remote-good &&
+
+	git clone . prune-test-partial &&
+	(
+		cd prune-test-partial &&
+		git config maintenance.prune-remote-refs.enabled true &&
+
+		# Add remotes in alphabetical order to ensure processing order
+		git remote add aaa-bad1 "../remote-bad1" &&
+		git remote add bbb-bad2 "../remote-bad2" &&
+		git remote add ccc-good "../remote-good" &&
+
+		# Create and push branches to all remotes
+		git branch -f side2 HEAD &&
+		git push aaa-bad1 side2 &&
+		git push bbb-bad2 side2 &&
+		git push ccc-good side2 &&
+
+		# Rename branch in good remote to simulate a stale branch
+		git -C ../remote-good branch -m side2 side3 &&
+
+		# Break the bad remotes by removing their directories
+		rm -rf ../remote-bad1 ../remote-bad2 &&
+
+		GIT_TRACE2_EVENT="$(pwd)/prune.txt" git maintenance run --task=prune-remote-refs 2>err || true &&
+
+		# Verify pruning happened for good remote despite bad remote failures
+		test_subcommand git remote prune ccc-good <prune.txt &&
+		test_must_fail git rev-parse refs/remotes/ccc-good/side2 &&
+		test_grep "error: failed to prune the following remotes: aaa-bad1, bbb-bad2" err
+	)
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "at most one" err

base-commit: 76cf4f61c87855ebf0784b88aaf737d6b09f504b
-- 
gitgitgadget
