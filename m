Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F733C1978
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492705; cv=none; b=jl5WUuK5aCPqsfou0lynbBguiY8fwMf/jg7odoCVLWFyE1jSwplG935Y4cBHxZEDwtXewP5CLG1wdj+OCVKcH4Ysv8ZbJpoLAHB1y/zdWRU2Xj95QLUeHRhtOq5wbX0/EVpCDgEGldAQLLzIa3ElTMjbC4nzIqCrTzLcvBmqSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492705; c=relaxed/simple;
	bh=7+Fzpsx/TDHX55jibxAgGix/ceagAzHav6HVv0jPArQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rf6KhGclgC6rdbGK79XPsgFzQ8FZz/J6TP1AN0EBq8G8QGyx+R7zg5owisUbm3jOaxKItmeuyYWFsHKKZqfPO8KBKRnMlhrERGh0b3HoFGsNwCIfVOjR3zxGN1OtgGFoMfkqUok8d1VA2plxOqWkMPnCFZXBmCuboRQ0qTG9FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxlB0cEe; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxlB0cEe"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12ddbe104ccso3610417c88.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492703; x=1779097503; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ih3WIFmPScFLKqQrLSJsCdsd4q4saZYS4nadQngLeM=;
        b=IxlB0cEen+TkePRSi7T7x5FP0fGpRHB5GFL3FiuTZrRE13d5vGbJ6GcS70df/CKPc5
         FgO9jsM2Qfy93KwITZ287RZvf+2ctGO93Zmqyfl4sDj9eQKuW/sZAr9ZAy49CVA2DFIN
         ySA3+z6h14GruFQ1nw9ajdCgO+j0FaX6BtzEwga7azLM7D73+en7AqjRy/pyH7WHI8K4
         RnuSdJabeF1+z14EJRC1VUq83NtCrPG60+jqtn/QLWK6YzEbYDteVu4ZGpYyIjFABFzk
         /aqGkAPyVKCSX3LowI2JUhPjzxWYgYgTOzasAfZbVhtDraFYbB2H1rDvBZ2peI3yYoiq
         Jchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492703; x=1779097503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ih3WIFmPScFLKqQrLSJsCdsd4q4saZYS4nadQngLeM=;
        b=l8WpeKWCJWtb3331G7OC7SZjBN5w51WUYlmEVbpZEZ1FtZeW7KSLK/ZW6KLMv2QVPi
         Th/2FQ5GCybGl/0eKeEERAinmzDUPQ9InHK2czV21oyoW18F6isiDMkWchocc4qBETVo
         khrCO1M3Fi2hVVnsjuT7FQ4WyMrAhH1zkiACrsXEiPHFowno+nuY8BHpjr/MfGm6XvcY
         HooBpkxvin2kmmP/UP3lskZLuRGPfu/0BadXR9LkDLy5nsLAqcZi9vGpHNLmE3jyxqx7
         bUCdIhcAT277q7qhZgt3/TE+IokZTHt1UuhdaOHm8Zk83ht4Qxcdk1omcdHOPmwpXXGE
         SYOw==
X-Gm-Message-State: AOJu0YzSRZQD1I1zWl+bMXYnUIcNH0EwTTk2S9zW8ajfUkmX4s2fUMFP
	Eo2Pf55Eb6oUw01qrCCmm6piFI55RiNTaT6GpJ+bx3migkg2TA7Rp7KmZ+5OZAWs
X-Gm-Gg: Acq92OGCy2LU6pe6Z9GzwNVQUqHT65JptFFmsQxln0YmrNMDUPolc0tzIabVLGwZMAK
	kREON8YMoq7QLqmSCrcYExfg2P9EZ0wwcDgHZ3arm3kgKu/BpjOR8BeYG8iPfSrf4tgwRyPVUmU
	R+Rws1k8Tiv96uf3FvMlZNU70ke66w8UOo1tKmTTsKV0Kwrd9UKrHPaGu9gES5bXtopxzZ6oFia
	lHkI/6Al0c9u/SfqPnyzCoVaPxJbpddKPhjF0SNYbK48LPC1sYGk5iAvhBCfhYn3U7p7W7xG/DQ
	gOHKsC0TAfW/MfoLVyy51IoHAiO2N8/+m9A2XQEd274gVu+bUzLN4zNyLUEcfm4/ihfDkxT7Dv7
	NrWS2BVDhG4hgYRV2sWvUdwmlKEcrfUF5pHiYEUh8AYEar1GiLD0qTIPBOKTQk1dPM9iHSjH0c+
	aRBgS8Nz7wB46mjwxyUgCtFvgo6VUU2SbKij1s23U=
X-Received: by 2002:a05:7022:625:b0:128:d715:b717 with SMTP id a92af1059eb24-131852d534fmr11353217c88.13.1778492702407;
        Mon, 11 May 2026 02:45:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fc59sm15140535c88.7.2026.05.11.02.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:45:01 -0700 (PDT)
Message-Id: <be255729575abde11208c02ae217640cfe76b095.1778492691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:51 +0000
Subject: [PATCH v6 5/5] branch: add --all-remotes flag
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Combined with --forked or --prune-merged, --all-remotes acts on
every configured remote, in addition to any explicit <remote>
arguments. Used alone, it errors out.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  9 ++++++--
 builtin/branch.c              | 41 +++++++++++++++++++++++++----------
 t/t3200-branch.sh             | 40 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 9807d3c218..e5fe82de39 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,8 +24,8 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
-git branch --forked <remote>...
-git branch [-f] --prune-merged <remote>...
+git branch --forked (<remote>... | --all-remotes)
+git branch [-f] --prune-merged (<remote>... | --all-remotes)
 
 DESCRIPTION
 -----------
@@ -226,6 +226,11 @@ delete them regardless. The currently checked-out branch in any
 worktree is always preserved, as is any branch with
 `branch.<name>.pruneMerged` set to `false`.
 
+`--all-remotes`::
+	With `--forked` or `--prune-merged`, act on every
+	configured remote in addition to any explicit _<remote>_
+	arguments.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b356e250e..5f771d2f32 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -703,6 +703,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int collect_remote_name(struct remote *remote, void *cb_data)
+{
+	struct string_list *remote_names = cb_data;
+	string_list_insert(remote_names, remote->name);
+	return 0;
+}
+
 static void parse_forked_args(int argc, const char **argv,
 			      struct string_list *remote_names,
 			      struct string_list *tracking_refs)
@@ -792,7 +799,7 @@ static void collect_default_branch_refs(const struct string_list *remote_names,
 	}
 }
 
-static void collect_forked_set(int argc, const char **argv,
+static void collect_forked_set(int argc, const char **argv, int all_remotes,
 			       struct string_list *protected_default_refs,
 			       struct string_list *out)
 {
@@ -805,6 +812,8 @@ static void collect_forked_set(int argc, const char **argv,
 	};
 
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
+	if (all_remotes)
+		for_each_remote(collect_remote_name, &remote_names);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
@@ -818,15 +827,15 @@ static void collect_forked_set(int argc, const char **argv,
 	string_list_clear(&tracking_refs, 0);
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static int list_forked_branches(int argc, const char **argv, int all_remotes)
 {
 	struct string_list out = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--forked requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, NULL, &out);
+	collect_forked_set(argc, argv, all_remotes, NULL, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
@@ -849,8 +858,8 @@ static struct commit *resolve_remote_head(const char *remote_name)
 	return commit;
 }
 
-static int prune_merged_branches(int argc, const char **argv, int force,
-				 int quiet)
+static int prune_merged_branches(int argc, const char **argv,
+				 int all_remotes, int force, int quiet)
 {
 	struct string_list candidates = STRING_LIST_INIT_DUP;
 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
@@ -861,10 +870,11 @@ static int prune_merged_branches(int argc, const char **argv, int force,
 	int n_not_merged = 0;
 	int ret = 0;
 
-	if (!argc)
-		die(_("--prune-merged requires at least one <remote>"));
+	if (!argc && !all_remotes)
+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
 
-	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
+	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
+			   &candidates);
 
 	for_each_string_list_item(item, &candidates) {
 		const char *short_name = item->string;
@@ -1001,6 +1011,7 @@ int cmd_branch(int argc,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
 	int prune_merged = 0;
+	int all_remotes = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -1058,6 +1069,9 @@ int cmd_branch(int argc,
 			N_("list local branches forked from the given <remote>s")),
 		OPT_BOOL(0, "prune-merged", &prune_merged,
 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
+			N_("with --forked or --prune-merged, act on every configured remote"),
+			PARSE_OPT_NONEG),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1101,6 +1115,9 @@ int cmd_branch(int argc,
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
+	if (all_remotes && !forked && !prune_merged)
+		die(_("--all-remotes requires --forked or --prune-merged"));
+
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && !forked && !prune_merged &&
 	    argc == 0)
@@ -1154,10 +1171,10 @@ int cmd_branch(int argc,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
-		ret = list_forked_branches(argc, argv);
+		ret = list_forked_branches(argc, argv, all_remotes);
 		goto out;
 	} else if (prune_merged) {
-		ret = prune_merged_branches(argc, argv, force, quiet);
+		ret = prune_merged_branches(argc, argv, all_remotes, force, quiet);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fabff84f16..efededd1f0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,6 +1771,27 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--forked --all-remotes covers every configured remote' '
+	git -C forked branch --forked --all-remotes >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked --all-remotes still validates explicit <remote>' '
+	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
+	test_grep "neither a configured remote nor a remote-tracking branch" err
+'
+
+test_expect_success '--all-remotes alone is rejected' '
+	test_must_fail git -C forked branch --all-remotes 2>err &&
+	test_grep "requires --forked or --prune-merged" err
+'
+
 test_expect_success '--prune-merged: setup' '
 	test_create_repo pm-upstream &&
 	test_commit -C pm-upstream base &&
@@ -1955,4 +1976,23 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
 	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
 '
 
+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
+	test_when_finished "rm -rf pm-allremotes" &&
+	git clone pm-upstream pm-allremotes &&
+	test_create_repo pm-other &&
+	test_commit -C pm-other other-base &&
+	git -C pm-other branch foreign other-base &&
+	git -C pm-allremotes remote add other ../pm-other &&
+	git -C pm-allremotes fetch other &&
+	git -C pm-allremotes branch one --track origin/one &&
+	git -C pm-allremotes branch foreign --track other/foreign &&
+
+	git -C pm-allremotes update-ref -d refs/remotes/origin/one &&
+	git -C pm-allremotes update-ref -d refs/remotes/other/foreign &&
+	git -C pm-allremotes branch --force --prune-merged --all-remotes &&
+
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
+'
+
 test_done
-- 
gitgitgadget
