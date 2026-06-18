Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC615337BB8
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810743; cv=none; b=N3oP8dWcrwW+oFB5DaajjQQUfnzuDzRHFwqOfaWCTx+krot+X+WLovJ0jmKoMxvf7nrWx8HTa8d0fSrSbBAxo4apq6JhTh+6j2aqoVzhiRcL8u0Qs3ohsMNi/55EmQAmNIUeNl6Pg2KBM/gT2y9a2m0+dHspSY8k+6eah4H3bLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810743; c=relaxed/simple;
	bh=EmtYLJ8U7R7q9FuxDSWHS/z08x6S7v2rLdTF8driI4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hn+smxX4rnJaeqEorc9SEtQmlyxvnlFRhqv+Os/CKuXCc2PgZQwJjTkX7i2hoXbbBeWOpPRcFgFO5GYePWPxA+yx1rDjCmU0FZv+n3qa5rFk1q+Rg5a61A4jcheVwROa6h76cswyP/Rh89t4QZ7rdqqt4XtUc3cySaXGM9cy7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r0Jds1ta; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0Jds1ta"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51778077b28so13471431cf.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810741; x=1782415541; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vb7Dy+Xx+NGP7kc2VPBW77pEFgVZGsRFgMJpznei9tI=;
        b=r0Jds1tahU6iBPqV3QokG4dgnWdA8RJ07c/TggB+xAm8bFRi59JyJoNTBtKJmwVmjS
         wlt/iIxmUgG6ZiChRZeT6vApwDGdH5eFlw73ybF4Sulq2p+XfZeskFvqRBh1YEN+oKYe
         i1HKmDmukiX6H6WNHL8htcX0fEVlq99GFdt+RekwiNvouY5Saf4ZQKXvN7YNzNCG5BW3
         UYc5Eh2o+Ls8oxyE57R5mRAAXrUJWIyhVh42qNXtbw1ZYS42NiFPrG8P6T7j4goeHCNJ
         qQ+CXKx7x11ecLw8EDpDjS9grz/lbZjf+A3YFQtsychTlGqLqGTpO2qrjir/Tly7O3q6
         Ns9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810741; x=1782415541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vb7Dy+Xx+NGP7kc2VPBW77pEFgVZGsRFgMJpznei9tI=;
        b=pMBVNY/Ldq5P2Nheyhuw4bbaVvw2nYgwXFGdUAO6uUEI3zRO9WOKG9GAQtrTkC4oem
         /Syiy+ozrgDpsvcda+MfFuEVyA/kIgqwj5Hcxaepblc4LV267wthLurW54M5Hq5LBgED
         fqUZypZAHW4rPpQvaaffOesMx1i60ViB9i5yKrwQeCeEVrq+befaQdSc2t/QJ+7wZcwA
         zC/3cfz1j+4rjFJJ7lg12NvPd+92lPPxpvJkUkHsufD2mW5YV+N/eGTTOqmXXXkCuaV/
         ugf6HCo7lSYEJAiLY6nhGnKLYqlG11Ts5c60q0+YLAHnED7V0GdNJJE+LfslVY9SfUvu
         0JqQ==
X-Gm-Message-State: AOJu0Yze+pXlALjRTfrwEmXApSGE8YxL19pN2QUqgv+b5No15BNnKPx/
	fRQyhxVrea/dQ5UpnHGbteXe8A9hAJmP8MrHvwt7sm6BAn/BO2khAxaPmiIzpA==
X-Gm-Gg: AfdE7clsj7zbNIxfkAxA4fTZwreLm1C/+rAcXOxGArQ0Ka7+CLYa63t6dgAgb+EGIWc
	ovzJYILwtFko2eiV4X/qUMo2SihRBvSFScBamWKq6PwO4ar0ZXui2m6KWCdRUqkbPrL3YV/WA2Z
	GQhkznNBBw0nGwpNSj/3PQwbNRTmhr5TNTyDBOUYPCZ5hjotOb0Sr1lj2/LaAkAwryXUfqhIb78
	dzGb+ZMywTKdiETWaPiMgaybeE+6vhCbLlr9iXqCsQ7y1IgFdlcE4gZkTFs9dGB9jwhXqoKLoUW
	/osUfiwidhZl42r2Xq7TqJN3GSUbn67Tzh2mX0SzFkssQ7pmRdc96oE5TcdkNd8v/0maUXmNqmd
	Hi5fc82wZ8uyaTOxixLyKnoFaajVe0a3BCSD1jYdVDGP+ip4r4nW7DzNP7msGffTSCmZ1uulcj1
	JWKxInxFfvh/L7rIiBa7JTB2CXUg==
X-Received: by 2002:a05:622a:191f:b0:517:82a1:351f with SMTP id d75a77b69052e-519e4a5571amr8447281cf.16.1781810740891;
        Thu, 18 Jun 2026 12:25:40 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e61277e7sm2159601cf.26.2026.06.18.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:40 -0700 (PDT)
Message-Id: <a27d2724a2e394e1e985baf08f4b9ba5f27b7947.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:28 +0000
Subject: [PATCH v16 6/7] branch: add branch.<name>.deleteMerged opt-out
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
 builtin/branch.c                 | 15 +++++++++++++++
 t/t3200-branch.sh                | 26 ++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

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
index f82cfa36d0..91700f2e8a 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -215,10 +215,11 @@ A branch is not deleted when:
 +
 --
 * its upstream remote-tracking branch no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * its push destination (`<branch>@{push}`) equals its upstream
   (`<branch>@{upstream}`), so it cannot be distinguished from a
-  branch that just looks "fully merged" right after a pull.
+  branch that just looks "fully merged" right after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index e7e4f1d27f..942e2297c8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -722,6 +722,8 @@ static int delete_merged_branches(int argc, const char **argv,
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_array candidates = { 0 };
 	struct strvec deletable = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	int i, ret = 0;
 
 	if (!argc)
@@ -739,6 +741,7 @@ static int delete_merged_branches(int argc, const char **argv,
 		const char *short_name;
 		struct branch *branch;
 		const char *upstream, *push;
+		int opt_out;
 
 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
 			BUG("filter returned non-branch ref '%s'", full_name);
@@ -753,6 +756,17 @@ static int delete_merged_branches(int argc, const char **argv,
 		if (!push || !strcmp(push, upstream))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", short_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!quiet)
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					short_name, short_name);
+			continue;
+		}
+
 		strvec_push(&deletable, short_name);
 	}
 
@@ -763,6 +777,7 @@ static int delete_merged_branches(int argc, const char **argv,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&deletable);
 	ref_array_clear(&candidates);
 	ref_filter_clear(&filter);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 609a67bb5a..09cecfaff5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1944,4 +1944,30 @@ test_expect_success '--delete-merged requires at least one <branch>' '
 	test_grep "requires at least one <branch>" err
 '
 
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch deleted origin/next &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch --delete-merged origin/next 2>err &&
+
+	test_grep "Skipping .kept." err &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
+	git -C repo rev-parse --verify refs/heads/kept
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch kept origin/next &&
+	git -C repo config branch.kept.deleteMerged false &&
+	git -C repo checkout --detach &&
+
+	git -C repo branch -d kept &&
+	test_must_fail git -C repo rev-parse --verify refs/heads/kept
+'
+
 test_done
-- 
gitgitgadget

