Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935BC30B53E
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787368973; cv=none; b=H99zVV9dRCSoS3fvv1C7cJvFhTfi+dgd9pq1NXFbGxQmOisBF9YHlrztYcgK3LzvoV2zIc9dJ3ejAdxb1RT/iK4co2+gsm5B4Oy8AbPS9jsy73a3Hb5uQtfrbjhEh9pfhMTuCkdGGYVdlgFS1Ibu3eXeUeVcC3YJOqBfdDRjZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787368973; c=relaxed/simple;
	bh=aPn09J8XHphtmZ6EoN6j3uY3tPwlQBSbqSRp/D4D7eM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FnvyhUFOdnbxw69q8Sh8uvS/fSe5lRu0AW/dUvubRVr0TlnA7onr+WmVFq2StnrcJ6zYT4j20ZeIagBqqAQiSC7xQ7do4wZXZQ6Vsv4AeHF1RFuYPJB8OnILbNahtI3RfkpVBwPcwUTeEGFfYMHhxp9DpzmD4mBS10I+XIRv8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhs79ptY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhs79ptY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce98cb8165so16974215ad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787368971; x=1787973771; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DSAQJtONuhy4htQLdmcrCEoDotLQEM1Xc+7Kv4D2cew=;
        b=lhs79ptY95g+t6hLaZa3p/EdVvjCxRaZ4sYpvN02sI8ZslzEtflolKzY0284lmadUV
         +ELJpBlebt/bzPZHWJlMoJgC1XHf5coZlRFh3BlrFQP7gYmT1PCaNwK6Ca1uSfua/uwn
         cI1nuwyQ2U5WCjOC9oqg+qKr66vwKgQMg+t92wpYN2B4RcqkZYzTzokygTv/C79HACr8
         XQPs8sFofVLoBePFC0I+WqlH/2ovDAlBdSdHwAUtkpGqJtnvefhmIUxmHPaA0Funm+Om
         KIQ6tzi9DXt3PD7xVQGBaIROz/Vy1jIkDDUyGmxyGOZKPG1C3ZtY1fdXUa25ODm1QX2C
         SuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787368971; x=1787973771;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSAQJtONuhy4htQLdmcrCEoDotLQEM1Xc+7Kv4D2cew=;
        b=HhaV4QTKlJ1Li5gxpFCN9ivLMjZS7kYKxwsllKT4bAFAwNzN6pgUlCn6S+8chD+XNP
         H2u0WNEVRiNLV4W6znhaUgS+60ptFb0nUtlcbL8uJURWsPwNHvnuJvv/XeW0/O7zReEZ
         1MwnF8+Ms77hPleKxKzxt65/ejLlU1SkPdZFyOO5/3W0d83lpdjlH86BGDnboh4Xgijs
         pV5X9tkpjYhZf/FpghG6RYPhrKpr869TLtUzZsmIY7yLas1YIoEtzSGKT7hsKEF5FHr1
         j0EjeUtxi+kN2+yAdhwYdgEqHgmxF+LLw70MO4weBaQbe28hpCDfu0oRLRTV2XvDxRbx
         c9yA==
X-Gm-Message-State: AFuF++n5uz9JHNhhigEnkWJKv5OUJG4YxY4jkIrfQ+SLjoG7HFf/wVo2
	sl99fOeM33Bu35cv41IF5a2tYzyCPskQBgltkoV4ghDI024yBCQG4twcadVESw==
X-Gm-Gg: AR+sD10Klw/p8RFSdprA4181rlNLyyHzEHS4lyci8esUtlV2JG07qbVr52n6fDdYJmt
	5SiYtAnpsAaZzFWzxRdcuugyrrMsXiX7x5ILR8qYOr7CLFNmTDkEfUT/FpU+mujPU2sKB3x3Qgc
	fGHRJo1YHpdyM7TofQpmMM1vT0kZP3TQrIxV8UKFBlNNrbUlIcj1c7IJyDQAJCv8Jh4JhFWhBw+
	4UtBhmirnDwzqWDMDEH+/cUuv4omIPftBw6B1aB5liXUVya0V1nUpdM+1GizKOQ5bZdpKWbD+O8
	HjJzgx/pTDJLNwNZ7yGYJoOcj0i3Huc6Blt0WbAEJgQJOiiGm8911syua7YEJG+RGPPy4RE5XU2
	vxCyC5NR2jK1xx74tR+kftl6tM0HRG8Ze1gJQBr63IFhcD78in4RAIORPLXsfYwrZmJmvRHjfn3
	AShb/ItxPdzwM/hacPE5hjvihTtwOoexLXiHNbGk4BuruCmIvm3Fun0BQyByD6uUe16g==
X-Received: by 2002:a17:902:f688:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2d61a1aabd6mr205097215ad.14.1787368970876;
        Fri, 21 Aug 2026 20:22:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90e22f8sm1426955eec.13.2026.08.21.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 20:22:50 -0700 (PDT)
Message-Id: <095a5796d4c92012825daa07eef67140a7461018.1787368962.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v7.git.1787368962.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 22 Aug 2026 03:22:42 +0000
Subject: [PATCH v7 3/3] worktree add: improve message for ambiguous remote
 branch name
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

When the user runs 'git worktree add ../foo-dir bar-topic' without
specifying a remote, and there is no local branch named bar-topic, we
try to guess which remote branch bar-topic refers to, then create a
new branch named bar-topic that tracks the remote branch.

If multiple remotes have a branch named bar-topic, we silently gave
up, leaving the variable 'branch' intact.  We then entered the
conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered an "invalid
reference" error.  This error message did not provide enough
information to resolve the ambiguity.

When multiple matching branches are found, display a hint and a
descriptive error message and die immediately.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/worktree.c      | 37 ++++++++++++++++++++++++++++++++++---
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 22c8e5e131..320b18873d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -788,6 +788,25 @@ static char *dwim_branch(const char *path, char **new_branch)
 	return NULL;
 }
 
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
 static int add(int ac, const char **av, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -898,17 +917,29 @@ static int add(int ac, const char **av, const char *prefix,
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2) {
-		struct object_id oid;
 		struct commit *commit;
-		char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL, NULL);
+			struct object_id oid;
+			char *remote;
+			int num_matches = 0;
+			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+			remote = unique_tracking_name(branch, &oid, &num_matches,
+						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet &&
+				    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+					advise_disambiguating_remotes(path, branch,
+								      &matched_remote_names);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
+			string_list_clear(&matched_remote_names, 0);
 		}
 
 		if (!strcmp(branch, "HEAD"))
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual
-- 
gitgitgadget
