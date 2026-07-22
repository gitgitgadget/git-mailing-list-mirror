Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51023C109D
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704252; cv=none; b=ecWT6Cw5nlXS0TcnoQcI0HRKaVLkY7WV4JFRKDP2Dem4Bj1GPpkUlSO9qBfBl+pkaT39TMlReEJ1VgbmYjFQk9MLYRbxcv9v3FY1uK/6WdJO6P8L9TfRPiRsvmZPxtLUgLjyqR9SjUecnJ44hIvd0P7e4PxAkROzqnBqDhenlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704252; c=relaxed/simple;
	bh=aAJMmiu/CnaWPzpJhnVT4pir10nYXELoYej6ZpE0uYs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gLkiN9LeRFEAtahxhO79V0itmVBcOmFC2aeBV9J1+NEttpxNJDP7uEVgSEcrYoaeu283xtgTqY7yTD2HrxM3ZwZ56ewA8YGzo0BwP51aBu99KjhQBp9PU/yCK5CuplNKuKbv1HfB2ZKhryp3PaQSaZO+cyXEP6VIpEulL/TFmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCIHQX/6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCIHQX/6"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c0a81d286so52242081cf.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704246; x=1785309046; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OqbP0YWOVmMkrmt/tx3hZuhpjXbFQ0f4LE/+dszrGx4=;
        b=bCIHQX/6w021ckzQiLiHWq42NNnH4sspMuDqIZGRPUNLrZ59RvEdg8NNGStTMXbZv7
         aAWaxjqDgXfKIEbGLg0DEmYRC5I4N14AVQu79LHAoB0rmNZarQb9vI9GS8xAVkjuOTRz
         UfVCS3ig0XHV7ytR+Mc/ZYAi84gYEGbbAnSoYN4m8T3cpk/M0McuPxd7yZmfA62Scs+s
         8J9UV3qTw2B9Rr0noyRP0XNCCVHvLWebqSOt3vLGbkDosB6iNit67h2nIMITDJpibGSQ
         EeesBjMMxn3vGo7gAEB8XbLNkEkUqJG6xj00fgFZqcMZpusnpAjyexX1jK8nwUTETiUz
         BKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704246; x=1785309046;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqbP0YWOVmMkrmt/tx3hZuhpjXbFQ0f4LE/+dszrGx4=;
        b=sGvc/5iQg5oU739IJWcGDcg28BHVno5khF0EsARPfjzGQdmd3lhkxOMZaBquAG+FAj
         WPZRAAnPmaOp3QN+VafmuMh4/77i7swX1sIbAJ95wenvC+ILYWu3MolkPqT5/0eJAnL8
         bfOLlOvhHBkMsmlF4aknAzBrfMECx8Qnq/iBcbjxFtjKni0Us8T1x7uH8tLQmqCeBgsz
         7e5OpAVeEvg1xbMoQPXJv2irxV41iqYan5T6tAvDvK8XltNECq4bN//36MGupnI3lKCt
         6EgaV/Eo/D8i6tCCYiF9RcsqsdQlPCHZx83Vu0t0yMe6ucsDE+y9AwECwhVPH0cGrXRn
         oQbw==
X-Gm-Message-State: AOJu0YwVO3A/NphyQ5lfHquSMIkpKEXbtYUHYpTON3ErBoFmyJZRzCKR
	3iizqu5W1G6nnD5/IX7pWZWBBfkqBCKJzcWe89GfSw6f2zV488TZo+KoRiRAgQ==
X-Gm-Gg: AR+sD12+KEGh5LQPMJo3yKI73jqCKj9D7VNwtxjrkA+rHnEFuE/3hXDP0RXJqJCWAOD
	sUc+A5c+m/PJr5yQunH/oU0UNzATFF8O5o5hwV5++lrFcaI5WJx4/wr2YasblXqwVOpUT3nOz5X
	o0JfwQqUdrcj/+PplAECGqMu2cyrTef0fsryjbAIJon9adpbbGypgd4s5BQLCsuKowfFRmJ+7Lx
	qTf7XEE2oHUBXhyptqIifDgZCrN/ZtQP40yfO3jEtjbALBKhAlAz65GVoS++yGTKVM1g0DK/i/C
	lgA0LHJp/OrxV/AXPovagrpj1XEMGk2MiIe+/vBy9Qd1+nsemz/jpuvFWAYyIUOzxjL0Yw6tO0t
	At56gs3iYS/yHr0FOIuZ0h+/QEjdZ3NxCgqVO94kWNnGjA8rTwGwjXWY5g6CU953nNcthnAMVaK
	6LFMQ=
X-Received: by 2002:a05:622a:15ce:b0:517:c699:3387 with SMTP id d75a77b69052e-527a961418emr28679801cf.37.1784704246498;
        Wed, 22 Jul 2026 00:10:46 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm10117821cf.27.2026.07.22.00.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:46 -0700 (PDT)
Message-Id: <fa7010861140047be42cb01a0200dfcb24c7d4e2.1784704238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:37 +0000
Subject: [PATCH v20 6/7] branch: add branch.<name>.deleteMerged opt-out
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.deleteMerged=false exempts that branch from
"git branch --delete-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 +++++++++++++
 t/t3200-branch.sh                | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..d8483acb4f 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.deleteMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --delete-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 2a96cd7253..2b206e8689 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,11 +216,12 @@ A branch is not deleted when:
 +
 --
 * its configured upstream ref no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * pushing it by name to the remote configured by
   `branch.<name>.remote` would update its upstream, so it cannot be
   distinguished from a branch that just looks "fully merged" right
-  after a pull.
+  after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index b97315df35..6573ad7027 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -786,6 +786,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	size_t i;
@@ -805,6 +806,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -822,6 +824,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					branch_name, branch_name);
+			continue;
+		}
+
 		strset_add(&deletable_branch_names, branch_name);
 	}
 
@@ -837,6 +850,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
 	strset_clear(&deletable_branch_names);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 268203089b..7111306150 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2076,4 +2076,40 @@ test_expect_success '--delete-merged requires a value' '
 	test_must_fail git -C forked branch --delete-merged 2>err &&
 	test_grep "requires a value" err
 '
+
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch deleted &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch --delete-merged origin/next 2>err &&
+
+		test_grep "Skipping .kept." err &&
+		check_branches <<-\EOF
+		kept
+		main
+		EOF
+	)
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	setup_repo_for_delete_merged &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch -d kept &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_done
-- 
gitgitgadget

