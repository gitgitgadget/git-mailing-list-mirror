Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AE383981
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939898; cv=none; b=fsAREy2U1/jQveGYKiLWGLKtE9JD5MFGkNJNLxyiwc8ATjyptXep4lZflNEKP5kGsYTu8g96MHCYUA3RqjUucdeJ4G+R9VeaQdVCtpts08WqEVwE6H130bIaR2DautD6pBURHSUbymlzylRpwc3WCzg3V5D5kPT1zdGvs5g/rCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939898; c=relaxed/simple;
	bh=pbQmdmX0wJyHx52NOT3W1icGOhgFrHMieAwzlpgCT8c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bV6WsUq47DlMnJ4RC/bsDhFOuzN6+H2yTnNFKN5CMsLaHXiF2rjRVQEr4357amyjvJzlWLf7jc7haAle+dPoac07ViVUXtcufixVzIkXKR+TtaAvu5zdhTNhCCTBr8ao13URUlWQJFTvmfIADBw4CA/nydcBciAbBZG6PRvCtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpNyXFNQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpNyXFNQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1031863a91.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939890; x=1786544690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zVa6pOcBe1pCvPmHC5b2GDQ+VmezOeX/GayUtdznwzw=;
        b=EpNyXFNQjik9CQKDachQh8mlr14z76VEsKuDnHDkm4O9+eq0aCa2qvYH7hgZOGPxOU
         9QDwtFc7QnEMVjBPKaOwGEnqh314bCsbN/QTyC16xOwcX1fnzmjbZSfbTgvAd23UP6l8
         fnisU1hmY96w0cCrZzdWhiHQWq+98UAvrLyoYPmK2VTt7kZjxGBPyPj23lqEDKlq24nA
         gPReW+IO1h0EVFbpgQ27XVZEL/YlRUUpOXUtPDUhr6oIwmd6v1poMAD2cxsNTvBWpiEd
         tDIfJ+MiP2uq2Vq23fF4Gt+NAjrlijF8veC++ePTHnYovybN4jl4ufuZus5YEgV2oQ/n
         GG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939890; x=1786544690;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVa6pOcBe1pCvPmHC5b2GDQ+VmezOeX/GayUtdznwzw=;
        b=R0x1ioFqCPUglE0Y9wSo3ncSmR9/+WgHe7KxpldZleJFXEWiGKt2rb4tMsqxkHCzIw
         JrRzVhAk6aeDhwRDlH34u4lOQoMcwYwx2vrU3ZrAQczjfyViiXqcQsAs/jaWFbcq7oKU
         Fw9MXdku0wxsRSef7cisis4iXupyy3qyy2phcfKyl+6aovhNkgEwyIxXy/eTJke6ZeRx
         E4rqfGOStSW8mCQ418T8BtxTjw+mHL2i2qCLe2XXmw3+NW6qsZS9cjMvnKvl7FSi4/n8
         dDAEI3zZdQ5ZsSWLzSMOPXmA2DVOA9Hjcw3vwsNEG77DIxJFU/JpiWrGNycBteLKhn7s
         6V+w==
X-Gm-Message-State: AOJu0YzUjd5oJDObKmVU1tVs7rTKEA7nM3ZvfNHq67rb4VU8fCUn4oQt
	hAgtSdr83EISKRrwhnzG32P0i2K3YcMCsaC4z4QFt1AybVZd3BxkgGcj0IDuWw==
X-Gm-Gg: AR+sD12Vs7274pJIJjAxbibs1/f2CZ8s0ju45PTMdz2d9CrO0UnMh22iTzCOwpHEN48
	2aAncDeiHx+TByZJeydaQF1rED0DUnx7p7SW2Bw/oGoBabhD7ok+U2muytehAczBL2dxXlur5g6
	tZBolS/JldFJhv72zNlIjJuJ/nui+vghO1wZ7SFPPx2zwzv0WWz9IEqxT2g748MxpJQ6I/B1XBk
	cJWEP2dlFDBp8Z4+qpD1pVRRW8Xjs+9zeGXuMnhROPgnUAOEbnFD8TiXgSTuTvrRmVMI9lzkc0U
	c0b3VgnnAA2bDzrsJZWoiy7cgwxFiXFO9JriDbAB3aVwXtHNhWN8vuDB1QKhkSQgpGk8BKmqzr1
	z48zhAz98d6PIyyknqPdw3AVUPAQOQWd6BflRyBX+83KpoK14sXb8G3u8c90nXEQOvYwGac4WD9
	j5dxYPk3+7vq6fS3FPwesSdFZwlwMVe4RYSBQyYtpIFH8LL5rjmj7qLDjA9xAiFOd6lw==
X-Received: by 2002:a17:90a:ec8e:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-3903c56ae7amr8467181a91.9.1785939890480;
        Wed, 05 Aug 2026 07:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca92ada6sm14702186c88.15.2026.08.05.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:49 -0700 (PDT)
Message-Id: <c2d1fdebe81450288f9b86c40f7c9ff70dd8630d.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:36 +0000
Subject: [PATCH v25 6/7] branch: add branch.<name>.deleteMerged opt-out
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
 Documentation/git-branch.adoc    |  3 ++-
 builtin/branch.c                 | 14 +++++++++++++
 t/t3200-branch.sh                | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index 5a85fde8de..c2acd89c99 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -103,3 +103,10 @@ for details).
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
index 4766178204..cfaac4b90f 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -224,7 +224,8 @@ A branch is not deleted when:
   distinguished from a branch that just looks fully merged right
   after a pull; this is determined by the remote's configured push and
   fetch refspecs,
-* it is the local upstream of a branch that is not being deleted.
+* it is the local upstream of a branch that is not being deleted, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 When such a local upstream branch has its own upstream deleted by the
diff --git a/builtin/branch.c b/builtin/branch.c
index f1a73bcea1..2d0c4f51ea 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -818,6 +818,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strset protected_branch_names = STRSET_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	int ret = 0;
@@ -836,6 +837,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -853,6 +855,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
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
 
@@ -873,6 +886,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		clear_deleted_upstreams(&protected_branch_names,
 					&deletable_branch_names);
 
+	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
 	strset_clear(&protected_branch_names);
 	strset_clear(&deletable_branch_names);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 496072a3fe..31ca1719d9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2103,4 +2103,40 @@ test_expect_success '--delete-merged requires a value' '
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

