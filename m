Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293729;
	b=SylcJx56ZVTlPgnrBWiw/L9DoSXL/+uVvRbUOve7Hxia1ba5ZTLvk1TjS949HqZDVyqz
	 /bpiIKbdTM4QLcRbRh7+E269Dl0/aN6hDec0UaKgL6U1gnLISXbR4NgxFnSMk0SsixlbH
	 Gn3QvELddRi82bn8BNsJsR6gq/sXn4Xl8Ct9iiQzQ5WkeeWmNxKagA+wG8KajRXaLWLdR
	 2hmvXKQ0yPn4RsjISlO0/h2vnXFsxRIB+yQL8KNew5EpCoLPW5k7juh8TOwtOdixgevZz
	 fkNR7O6gI60nEgOm6TxW8MF3/iVG2Ym8IWvl1431XTXndNVx2OV6eVOfXb0Ihb/znhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=q1FmCUqtaFG2zF9G6OEJsN8tHd+ha69/7b5TUF+Yt9E=;
	b=Pe0zEKe8Qmgsv54LrumKuOKzi7jW977lmdpBcCDnUIEGIu7+9v363phz+G50EjXKZI0J
	 coi1XIj35Viacb8mK5GgtlU6ADYQQ1EAVtbBLE80WkRv3C4m2EjYkvKKiV3nfKViw2Tm2
	 /O+P8Mok5dsR9aEbS9k258be08kJUmfVimBa/95jkjYk1nRdrZKvMbGAVMAJ6xnHYua+k
	 BjKLDCOI43tWU/C3a4zPzyVgIaOU/l1YXjx8a3K48sq0Vc5F1t7pIqcMabmb/wG4z7KQv
	 nJLqOqrXwYGaKW+2ssvxSP5EZP4cTXwlz5yF17albE7Zxfcf8zeOo0iM8wPr15kiRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TlFEJW5R;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D3606A32C
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8D3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TlFEJW5R
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f2f2edb19so186008585a.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293728; x=1795898528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q1FmCUqtaFG2zF9G6OEJsN8tHd+ha69/7b5TUF+Yt9E=;
        b=TlFEJW5RKbTuUQaNDGaQo5bO6o8+efLGphUEN5/YGsixoQuXPftwrFEWjqBhi8az20
         gZRfUAytBEYZP8NnQZv2ujIK7k/qWOgr73K9H+UP+QXjOgIF0b413LS49DQWo15pCyjS
         H87nJHHx4zuBMMJ1XfogsqGbV6JcJ1UX8GOqayq05TElI/Dqsz7Urw0sMcJVICca73B7
         I/XahfbPEjdkAoBhFjJqfENzLbelDsW68ca8Lu7odcTCSTkvMvaidMwvSUInXiPjfbdT
         5k2nmKobSaLeYrMEUNWaY+bvRh8tI28Enu0qwaw6UoQyyeo+i5hGTYL29bK9ZgjIG5Qs
         di9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293728; x=1795898528;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1FmCUqtaFG2zF9G6OEJsN8tHd+ha69/7b5TUF+Yt9E=;
        b=l1tdNa1ADSReOE1isCH/WLi+oPbsE30JVhFtLverxk1kbUFlLS8NteuC67nmU82/Ni
         IGyYCne0lg8SxLRcJbg+HZ8JEEtZHokXgxCzMBMkX+ilwUn7127fkFzriHEuqGvsWM+K
         wUbCUax5MoX99qjjebfVZ5N7cUhYb6GrM5GeA3huOHe/L6DU9Vikw963kuH53SWEkbjr
         CBDDm4sgCdmsI8owIaodpuFIqcGIHlV8HFUI8jFG/gyDRtWHynDZyTkT7rnfPJAeR+nt
         JopVk/We6IAQ64IY7xA/qliJhsphMRCFU7yrma6jQhNU5gzXFAL9Zh3u7T2OkYLJIV9T
         wZ1g==
X-Gm-Message-State: APuU4Z/2bJRMDLqVdolk8nfyy7l+CScCell9xymIg0DHcWKEgnuybYHu
	QNoXE1qrYN7Q36zhT1vx1c/V182G330tLOVMk1Rin4ioav660ZwOFEKwe1w14Q==
X-Gm-Gg: AZFdTZeifAMoQytXC+1OuvaV/PODRU9XeOKa2367naiQgvbhLdnsDaZtLLenPENFbhU
	KcW2B3KabCf75AWsIv2fgYP/MmHyYXjj71/FT79BmFGV1PfdFo7ah5DG6hiu7NSYM/9GV9x1ijD
	7fboHXPbGKyxfmtva61JEQB3NE4QOOGX9MIAQ9I+37As36UiehcyVbbc63vHu5nch1rCNyOY6Mn
	wG2v0EiJxNlUnWp4RTzCTpYYGgHEEQryuNYL/l0ck9Ugv1AmoRPBApb2MVdugT33rm3Gj6dkJkG
	lQTBv00J0c50yRTRhUAH1bz5plm1MMcNOm0urOhEGqzYeJn0Vhb4XI4sWDP1xy/1MmwSNNcYh8j
	DHqtj0AToHBn+lRSKsj46Uk80g3Ygw+Pw7jiDxCcBryrpqkfb14q/wsNeObg9ov++WyIftCNp8g
	O40L1wnoe+7iy5uQ1ahG+4QH5fcTf14rcvSvD2NPfSu43lFVTBdIFm4c4K+Bsx0O7uPIstJDOT/
	+HDFqwkSyMJQLsE3bhZouIVGTKjDX+D56Zo941VxjKqqRQVKQmIwDZ2W9VzGUgxBC4ZhlRkF1sG
	xAZjMu4jvf8+iHVvP2A/9fc4baudXEDlkg==
X-Received: by 2002:a05:620a:6503:b0:946:2a0:a0f3 with SMTP id af79cd13be357-949baa0d8f4mr1204783785a.36.1795293726973;
        Sat, 21 Nov 2026 12:42:06 -0800 (PST)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb397b4bsm484099485a.21.2026.11.21.12.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:42:06 -0800 (PST)
Message-Id: <43b6b02f697e3fcc74fcbaf704e23f5f90bcc50c.1795293722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 20:42:00 +0000
Subject: [PATCH v10 3/5] branch: let --dry-run preview -d and -D
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
    Jasper Mayone <me@jaspermayone.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git branch --dry-run" only works together with --delete-merged and is
rejected with every other option. Someone who wants to see what

    git branch -d topic

would do before running it has no way to ask.

Accept --dry-run with -d and -D as well. It reports the branches that
would be deleted and leaves every ref in place:

    $ git branch -d --dry-run topic
    Would delete branch topic (was 1a2b3c4).

A branch that cannot be deleted, for example because it is checked out
or not fully merged, gives the same error as without --dry-run.

--dry-run is still rejected with options that do not delete branches,
where there is nothing to preview.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 11 +++++----
 builtin/branch.c              | 10 ++++----
 t/t3200-branch.sh             | 43 +++++++++++++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index a803c24858..b83ad5efc3 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -23,7 +23,7 @@ git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
 git branch --unset-upstream [<branch-name>]
 git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
-git branch (-d|-D) [-r] <branch-name>...
+git branch (-d|-D) [-r] [--dry-run] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch [--dry-run] (--delete-merged <pattern>)... [<branch-pattern>...]
 
@@ -236,10 +236,11 @@ silently skipped. Delete it with `git branch -D` if you want to
 remove it anyway.
 
 `--dry-run`::
-	With `--delete-merged`, print which branches would be
-	deleted and exit without touching any ref.  Useful for
-	sanity-checking a wide pattern like `'origin/*'` before
-	committing to the deletion.
+	With `-d`, `-D` or `--delete-merged`, print which branches
+	would be deleted and exit without touching any ref.  A branch
+	that cannot be deleted is reported as an error, the same as
+	without `--dry-run`.  Useful for sanity-checking a wide pattern
+	like `'origin/*'` before committing to the deletion.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index b7c3554b63..049d08275a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -1060,7 +1060,7 @@ int cmd_branch(int argc,
 			N_("delete merged branches whose upstream matches <pattern> (repeatable)"),
 			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT_BOOL(0, "dry-run", &dry_run,
-			N_("with --delete-merged, only print which branches would be deleted")),
+			N_("only print which branches would be deleted")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -1123,8 +1123,8 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
-	if (dry_run && !delete_merged.nr)
-		die(_("--dry-run requires --delete-merged"));
+	if (dry_run && !delete && !delete_merged.nr)
+		die(_("--dry-run can only be used when deleting branches"));
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
@@ -1162,7 +1162,9 @@ int cmd_branch(int argc,
 			die(_("branch name required"));
 		ret = delete_branches(argc, argv, filter.kind,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
-				      (quiet ? DELETE_BRANCH_QUIET : 0), NULL);
+				      (quiet ? DELETE_BRANCH_QUIET : 0) |
+				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0),
+				      NULL);
 		goto out;
 	} else if (delete_merged.nr) {
 		ret = delete_merged_branches(&delete_merged, argv,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44336eef81..068d6f7cd6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2211,9 +2211,48 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
-test_expect_success '--dry-run without --delete-merged is rejected' '
+test_expect_success '--dry-run with -d and -D deletes nothing' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch merged &&
+	(
+		cd repo &&
+		git checkout -b unmerged --track origin/next &&
+		git commit --allow-empty -m "unmerged work" &&
+		merged=$(git rev-parse --short merged) &&
+		unmerged=$(git rev-parse --short unmerged) &&
+		next=$(git rev-parse --short origin/next) &&
+
+		test_must_fail git branch -d --dry-run unmerged 2>err &&
+		test_grep "cannot delete branch .unmerged. used by worktree" err &&
+		git checkout --detach &&
+
+		test_must_fail git branch -d --dry-run unmerged 2>err &&
+		test_grep "not fully merged" err &&
+
+		git branch -D --dry-run unmerged >actual &&
+		echo "Would delete branch unmerged (was $unmerged)." >expect &&
+		test_cmp expect actual &&
+
+		git branch -d --dry-run merged >actual &&
+		echo "Would delete branch merged (was $merged)." >expect &&
+		test_cmp expect actual &&
+
+		git branch -d -r --dry-run origin/next >actual &&
+		echo "Would delete remote-tracking branch origin/next (was $next)." >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/remotes/origin/next &&
+
+		check_branches <<-\EOF
+		main
+		merged
+		unmerged
+		EOF
+	)
+'
+
+test_expect_success '--dry-run is rejected when not deleting branches' '
 	test_must_fail git -C forked branch --dry-run 2>err &&
-	test_grep "requires --delete-merged" err
+	test_grep "can only be used when deleting branches" err
 '
 
 test_done
-- 
gitgitgadget

