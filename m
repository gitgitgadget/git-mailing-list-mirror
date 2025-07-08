Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCA2DA774
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973610; cv=none; b=jz5FVMF5dlNeGhzrSTxXRxGsnTRpxEZ9S3nGl9KJBGAwOX8NyRTj1QoUUh2GQfkYrK9fpO/Mffp3TzbhArOKgZUahn3YCHpMR2S0NxlX2ZEpQ4V+a0XRpYkVJDEDT/T6Pev6BqCwRNszui4kzJ1Kb8Fln/LSKaQGbn1tezEQvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973610; c=relaxed/simple;
	bh=gwWSEcGOcvQ4utj8Z5cG9mDDll0vhWwim2x40NB9pWQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ddc7nDibiRIbKECyBurhxf+I0qn6vt7eTVVym7X71ls7//29eoAusoKG57rlz5xiYF8tjS8IRI5se3bveAZJqT+MNHrFTFmGGn1in29fD2dhkVmvz5mj1DbVHqmrXjVKnlMCC6pHvAmokU4aWyoLds8khrOBGtJ9T2tsxFdPufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5AZh0dz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5AZh0dz"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso32814875e9.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751973606; x=1752578406; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SxojxLAhBbkA1K2r8pEUEghFIkUE4k68TBdTytYsj0=;
        b=K5AZh0dzutDL9YAlE54+AhPlgb/WjlFznu6ya9NNcGjiOwLLXgmAekPyiLutWLi60w
         RT/6HDDwnuo5R+BoN8n5SU5OwWB9K8EqTxgkbVV/nSuqb6h9cM1bbo++bM6YVMFAIFg9
         ONbjCWsFZEJfJETM++938SqL/J06qMVDx6Texi6C1Q2+9rtLf4+TB76y4OA3f1NGSQVm
         NnFyTjAPljSiYXTrP+OAC7/AXURMbOxPrcaWtBTcm9aZMu4gQJnWtfSyKlWEI/5LGIge
         t1FbEmuUPvN3GZhAGnAru655nCmvlAv4Xtvwva8KYgLL15ytj2I8SPb+d2umt9p9JU3L
         MOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973606; x=1752578406;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SxojxLAhBbkA1K2r8pEUEghFIkUE4k68TBdTytYsj0=;
        b=MGY8/QwQjFHIeY9s28JTn/Y9PSQk5+hDGEcGrXckLtL/kEUuY5itrFytIrSVqcVX+m
         v60HFTF9qCs8BK9eZJ9mbxBURSpATNXarXkItsWyqS5+oZbB6g48wh0lKljltO1OH1Py
         6Fof5v++cUuP48SRrt2A9L+sWwvWgZ/RPaHi1B8/47kF4ioBWCjIEwqlWkj8KJMI7FXx
         80FxWomARjMc6Q0Wi/EtpJ009EvStsmHv9BIoii4ghpoOHuIM2rqENxFiZRiRdtPLrVt
         5NTOC9aRlYgwKgTpB/xUc8RppOuGUCeCJIVqWvIKk3FtJ9GlFVZjMA0CSvYKLMU8x8kJ
         nXSw==
X-Gm-Message-State: AOJu0Yy+XYVv7m+v1VB1e3Dt7U3kVpEeqrMYmcHgnWrQyrakniILlkx/
	emZvwZditIHPjbqYText8d1rBC3aPJMjQXHaAC51YOozBdW9Dq9Vs/J3oqfaJA==
X-Gm-Gg: ASbGncvp6hSq7IXpFK5Wu0xvL+HadYtBeB2fz3Nel8vPOvzPYN47/3UM9wAUyCre7D7
	hYmJZAHCKL4n9J3eOHNRVbXaGVm5XbMfr8QtTOCfDPwrRvbYjlNWKYvuNdzxbni+RNvomwfBaFx
	9rLdhT7O3JkWl9GNRmagsO+ca53d3KrPkO0s/WJIWyNrSqKES3aVZxb44d2cPbxb3KBrWPz4IRG
	K2azLrBrKDhEX80OHiU3NcC5f9OVpoP8caMkKK+QA58nktTH8DSMLTuBUZ1jIYGrxJ+oHGE+63E
	AI0BMmr0bM5t4byy8diONsoU6hRzMPo2+K1HZ5TVo6idZ/8F2S7VmEcmxABtGCs=
X-Google-Smtp-Source: AGHT+IE0rA4mi4cJYvEmINco33lcZ26CYeyfwSGHKk57Co01H+2z04e80uGx6Q3cvB+7rz1xSX1DzQ==
X-Received: by 2002:a05:600c:8b84:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-454ccc806f2mr36732045e9.13.1751973605253;
        Tue, 08 Jul 2025 04:20:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd43c5a9sm19268365e9.3.2025.07.08.04.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:20:02 -0700 (PDT)
Message-Id: <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Jul 2025 11:19:52 +0000
Subject: [PATCH 2/3] sparse-checkout: add 'clean' command
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When users change their sparse-checkout definitions to add new
directories and remove old ones, there may be a few reasons why
directories no longer in scope remain (ignored or excluded files still
exist, Windows handles are still open, etc.). When these files still
exist, the sparse index feature notices that a tracked, but sparse,
directory still exists on disk and thus the index expands. This causes a
performance hit _and_ the advice printed isn't very helpful. Using 'git
clean' isn't enough (generally '-dfx' may be needed) but also this may
not be sufficient.

Add a new subcommand to 'git sparse-checkout' that removes these
tracked-but-sparse directories, including any excluded or ignored files
underneath. This is the most extreme method for doing this, but it works
when the sparse-checkout is in cone mode and is expected to rescope
based on directories, not files.

Be sure to add a --dry-run option so users can predict what will be
deleted. In general, output the directories that are being removed so
users can know what was removed.

Note that untracked directories remain. Further, directories that
contain staged changes are not deleted. This is a detail that is partly
hidden by the implementation which relies on collapsing the index to a
sparse index in-memory and only deleting directories that are listed as
sparse in the index. If a staged change exists, then that entry is not
stored as a sparse tree entry and thus remains on-disk until committed
or reset.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc | 13 ++++-
 builtin/sparse-checkout.c              | 73 +++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh     | 48 +++++++++++++++++
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 529a8edd9c1e..21ba6f759905 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules) [<options>]
+'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules | clean) [<options>]
 
 
 DESCRIPTION
@@ -111,6 +111,17 @@ flags, with the same meaning as the flags from the `set` command, in order
 to change which sparsity mode you are using without needing to also respecify
 all sparsity paths.
 
+'clean'::
+	Remove all files in tracked directories that are outside of the
+	sparse-checkout definition. This subcommand requires cone-mode
+	sparse-checkout to be sure that we know which directories are
+	both tracked and all contained paths are not in the sparse-checkout.
+	This command can be used to be sure the sparse index works
+	efficiently.
++
+The `clean` command can also take the `--dry-run` (`-n`) option to list
+the directories it would remove without performing any filesystem changes.
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files.
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8b70d0c6a441..6d2843827367 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -23,7 +23,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable | check-rules) [<options>]"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable | check-rules | clean) [<options>]"),
 	NULL
 };
 
@@ -924,6 +924,76 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	return update_working_directory(repo, NULL);
 }
 
+static char const * const builtin_sparse_checkout_clean_usage[] = {
+	"git sparse-checkout clean [-n|--dry-run]",
+	NULL
+};
+
+static struct sparse_checkout_clean_opts {
+	int dry_run;
+} clean_opts;
+
+static int sparse_checkout_clean(int argc, const char **argv,
+				   const char *prefix,
+				   struct repository *repo)
+{
+	struct strbuf full_path = STRBUF_INIT;
+	size_t worktree_len;
+	static struct option builtin_sparse_checkout_clean_options[] = {
+		OPT_BOOL('n', "dry-run", &clean_opts.dry_run,
+			 N_("list the directories that would be removed without making filesystem changes")),
+		OPT_END(),
+	};
+
+	setup_work_tree();
+	if (!core_apply_sparse_checkout)
+		die(_("must be in a sparse-checkout to clean directories"));
+	if (!core_sparse_checkout_cone)
+		die(_("must be in a cone-mode sparse-checkout to clean directories"));
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_clean_options,
+			     builtin_sparse_checkout_clean_usage, 0);
+
+	if (repo_read_index(repo) < 0)
+		die(_("failed to read index"));
+
+	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY))
+		die(_("failed to convert index to a sparse index"));
+
+	strbuf_addstr(&full_path, repo->worktree);
+	strbuf_addch(&full_path, '/');
+	worktree_len = full_path.len;
+
+	for (size_t i = 0; i < repo->index->cache_nr; i++) {
+		DIR* dir;
+		struct cache_entry *ce = repo->index->cache[i];
+		if (!S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+		strbuf_setlen(&full_path, worktree_len);
+		strbuf_add(&full_path, ce->name, ce->ce_namelen);
+
+		dir = opendir(full_path.buf);
+		if (!dir)
+			continue;
+		else if (ENOENT != errno) {
+			warning_errno(_("failed to check for existence of '%s'"), ce->name);
+			continue;
+		}
+
+		closedir(dir);
+
+		printf("%s\n", ce->name);
+		if (!clean_opts.dry_run) {
+			if (remove_dir_recursively(&full_path, 0))
+				warning_errno(_("failed to remove '%s'"), ce->name);
+		}
+	}
+
+	strbuf_release(&full_path);
+	return 0;
+}
+
 static char const * const builtin_sparse_checkout_disable_usage[] = {
 	"git sparse-checkout disable",
 	NULL
@@ -1080,6 +1150,7 @@ int cmd_sparse_checkout(int argc,
 		OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
 		OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
 		OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
+		OPT_SUBCOMMAND("clean", &fn, sparse_checkout_clean),
 		OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
 		OPT_SUBCOMMAND("check-rules", &fn, sparse_checkout_check_rules),
 		OPT_END(),
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ab3a105ffff2..7f8a444541f7 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1050,5 +1050,53 @@ test_expect_success 'check-rules null termination' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clean' '
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	mkdir repo/deep/deeper2 repo/folder1 &&
+	touch repo/deep/deeper2/file &&
+	touch repo/folder1/file &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper2/
+	folder1/
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run >out &&
+	test_cmp expect out &&
+
+	test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1 &&
+
+	git -C repo sparse-checkout clean >out &&
+	test_cmp expect out &&
+
+	! test_path_exists repo/deep/deeper2 &&
+	! test_path_exists repo/folder1
+'
+
+test_expect_success 'clean with staged sparse change' '
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	mkdir repo/deep/deeper2 repo/folder1 &&
+	touch repo/deep/deeper2/file &&
+	touch repo/folder1/file &&
+
+	git -C repo add --sparse folder1/file &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper2/
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run >out &&
+	test_cmp expect out &&
+
+	test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1 &&
+
+	git -C repo sparse-checkout clean >out &&
+	test_cmp expect out &&
+
+	! test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1
+'
 
 test_done
-- 
gitgitgadget

