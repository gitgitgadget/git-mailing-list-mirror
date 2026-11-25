Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611187;
	b=zyUnwH1TvJ8T7NcN/Plyp97IFMYd5wqimMKqOQM6vuYC13oLe9owTjLVQhwFuFBF+lb/
	 2gP0XZwO0FnHQQXiK2Cf/K7ZoXQ/UdiUSD7IkZpka2MhIoNtwI1H4d9Ih837K8MnQivB6
	 a8ahM9N+/hSBMjW6Crpt7whbQOp6YXyosy5xDduhMOh55McQ7XPNajkGjYm6g4fRw+F/L
	 w1CBJS1uWSRGCdMUbrzMQRtMzIZasfsdZCKCkwBdi++8IwuKNIjAF5EO91RaI9Do2AZHU
	 DaxsA/FcAaw2ISzBKQeHnRwPy/TybBJxbsGFjRXmiN1FT52ecJZ+YBh5jeZYgSW8dZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=xcI2mpGYoRqOd0r6pWMQuzqmj8a958xwDSqFZrMMFtM=;
	b=u61yK0QZpGWEHW5aWkCs1JM7QGlT8/Dem7e0X7XKNYYVExJ4F8elqd4xUYTkErLeK5nB
	 HhpdE/DECk95MBU98ugftxV950X1WhcGsc9WvBRp/4FEDvJ0g0T2U3po4d4kamtC7fe9+
	 UzewlcFjc5E2rUSDkU2Ru5nD9jOfvPPOpfUetYQ7tKVIgjXn8954ioUeS5lEcZZRj3Z2n
	 z+Puodr8h48YsOHJmSnu4tdSqQNY4RhGzmOcvouqc1EFm+BAzf8ayHSsgF4xixvOAtXZx
	 dZOpjqYZ5GKc0NMS6+Ekt8xm+lieyiCzd+yZE8YsHojVH11ilwQhHmdZaFXx46KsnXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IAPNpI1T;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00395606A33B
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00395606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IAPNpI1T
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-85a5455bd3cso3198656a34.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611186; x=1796215986; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xcI2mpGYoRqOd0r6pWMQuzqmj8a958xwDSqFZrMMFtM=;
        b=IAPNpI1Tb4pEHWqKfwbyTVNPm4lLvZtcUikWAtcU/ke730/HrbZUQKvktTOkwyI3z6
         S0trFZV+teRNlCf7WN5EkR2MygT0G3KOhD8XRORpsQ8h8t+6zBqLZvcTZQd7BvTFf8Hr
         VQgW+kcoXdWbgdYo4Vr7/7ddtN/ctiRtMo8irOFLRNTUQ0Si52bdN0pJYOS3oPlcoCP4
         Iu7cYYKCuyErI59FgIaNAhm5tVvhSfblTkoLvV27Wyb6V2k6CPEn3JggFlFfsSm0esFp
         jKfayRpfPrIGvzJbovm3Pb2vp0InN64oyZjO6pe+BBe7bJLTOjNjySb17HWifZqzZC+N
         H4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611186; x=1796215986;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcI2mpGYoRqOd0r6pWMQuzqmj8a958xwDSqFZrMMFtM=;
        b=VVcW8OigzggSetmNgSIpb9NRv66NiGXraSmVNWPP7HI2pVVdVaJRw6Aot4kn/O8Uwp
         yGw6tAfGNNuRf2Z1d05vvC6+Mp10l5wbS7taPFSziLZQ0Hpi9inGeneqJjdwICW1BAjr
         jZFHyVLdoTXctu2BPUXYefKJdOJW4BvTLQsTE8myMFYfRvfGtRNwVFvAo82Szmu8ozlj
         Yi+x2YN0jLdz5GxfTQ0NrqFa2wa8FNeh0Nt8zxnujL/FeG+P8WBkJ2bZDofu1RuX0qvY
         a/TpiUnTGEFqDzK6UCub3zTdld4MU+Y9Mn/9EPn/HZdwgkiWwVHcEQj1bA5PX8YPTYHY
         FalQ==
X-Gm-Message-State: APuU4Z+uFa1PIKAfPPN+TabUu5XOmT+MGV57NJYfBkr1MnVaW+kqrsae
	J+Y6oaWuFBlCgGZVubWAW9zvgKnVU+ZAz/Y2NQPJ2fXk1bycurUWBk2YvfanMD8A
X-Gm-Gg: AZFdTZfKodz4WUVfJexIVf7mNae8clRsLSFoJdXbtTtutoidOok2QXHYx7hhuh+32xj
	Ie6qgmQWWxgSr6FPTWEbw5qJ26MovmyYwf9UwaxZ9cQhb/ZX7YgDPQElNFiNq73DAqBzJ2yOj5u
	2CHh1SJlnf+BedhDmGvqQQ2jmZgklw4JI63eWY8DVRxhRsejgsxSx5FRb6HsD8QPxlGJ9Zbjhjx
	4I6MGKaCXSdZIBXsK6Et7W9gPkI1jZlk0DvzSJiiG12yJ1DbBSpAecfaPwEUtkYdYWfGagkkY7k
	Kinot3n4T6xRw5qCtdaaGkvkgyRK+Bf47qDU6GtJUTpG6esN+j36QpDUTSKal+Z6SnkvSVCkz4T
	3LGqEOuGbNZn3hh8+fK/KNeqvoBBWi05PJM9xxGAH/TvTt4PyBt1zDMZ0/mgMZAD865BDwhuamr
	T4d+FxN27pROqpGig27hHAvA8QTKZI+/Ur/C43QaYcKcRsrZKPXesA5IJP1EZ+ogpSGPsfUAgwJ
	2+mRvuf1G+72M6rn/5bFTasDoUJK4D4cZdCm9l1S3Tv2gRCOwoLoTGUnNvE7MxZo45eWY6zLXMz
	JJaNjrKbb8NgsR/VUrsjf5Fvq5FupQOU
X-Received: by 2002:a05:6808:23c2:b0:4fb:90ae:2b0c with SMTP id 5614622812f47-57a0d704239mr17989193b6e.68.1795611185771;
        Wed, 25 Nov 2026 04:53:05 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a3575f5bfsm13966799b6e.14.2026.11.25.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:04 -0800 (PST)
Message-Id: <339a1d1f2c9fc991753c77293dfe308586876bd7.1795611175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:53 +0000
Subject: [PATCH v11 3/5] branch: let --dry-run preview -d and -D
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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

The other operations, such as creating, renaming or copying a branch,
have no preview. --dry-run with one of them stops with a message that
names the operation:

    $ git branch --dry-run -m foo bar
    fatal: --dry-run is not supported for branch renaming

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 13 +++++----
 builtin/branch.c              | 17 ++++++++---
 t/t3200-branch.sh             | 54 +++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index a803c24858..8efc4faed9 100644
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
 
@@ -236,10 +236,13 @@ silently skipped. Delete it with `git branch -D` if you want to
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
+	like `'origin/*'` before committing to the deletion.  Other
+	operations, such as creating or renaming a branch, do not
+	support it.
 
 `-v`::
 `-vv`::
diff --git a/builtin/branch.c b/builtin/branch.c
index b7c3554b63..82452836d6 100644
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
@@ -1123,8 +1123,15 @@ int cmd_branch(int argc,
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
-	if (dry_run && !delete_merged.nr)
-		die(_("--dry-run requires --delete-merged"));
+	if (dry_run && !delete && !delete_merged.nr) {
+		if (rename)
+			die(_("--dry-run is not supported for branch renaming"));
+		if (copy)
+			die(_("--dry-run is not supported for branch copying"));
+		if (!noncreate_actions)
+			die(_("--dry-run is not supported for branch creation"));
+		die(_("--dry-run is not supported for this operation"));
+	}
 
 	if (recurse_submodules_explicit) {
 		if (!submodule_propagate_branches)
@@ -1162,7 +1169,9 @@ int cmd_branch(int argc,
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
index 44336eef81..55dda3b265 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2211,9 +2211,57 @@ test_expect_success "branch -d still deletes a deleteMerged=false branch" '
 	)
 '
 
-test_expect_success '--dry-run without --delete-merged is rejected' '
-	test_must_fail git -C forked branch --dry-run 2>err &&
-	test_grep "requires --delete-merged" err
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
+test_expect_success '--dry-run is not supported when not deleting branches' '
+	(
+		cd forked &&
+		test_must_fail git branch --dry-run new-branch 2>err &&
+		test_grep "not supported for branch creation" err &&
+		test_must_fail git branch --dry-run -m new-name 2>err &&
+		test_grep "not supported for branch renaming" err &&
+		test_must_fail git branch --dry-run -c new-copy 2>err &&
+		test_grep "not supported for branch copying" err &&
+		test_must_fail git branch --dry-run 2>err &&
+		test_grep "not supported for this operation" err
+	)
 '
 
 test_done
-- 
gitgitgadget

